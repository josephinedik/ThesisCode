import clingo
from clingo import Control
from itertools import product
import subprocess
from itertools import combinations

file0 = "CoreCode.lp"
file1 = "FirstJudge.lp"
file2 = "AppealJudge.lp"

usedfile = file1

def get_all_models():
	ctl = Control()
	ctl.configuration.solve.models = 0  # Get all models (no limit)
	ctl.load(usedfile)
	ctl.load(file0)
	ctl.ground([("base", [])])
	model_list=[]
	for model in ctl.solve(yield_=True):
		atoms = model.symbols(shown=True)
		model_list.append(atoms)
	return model_list


def get_props():
	prop_list = []
	for model in get_all_models():
		for atom in model:
			if atom.name == "props":
				prop = str(atom.arguments[0])
				if prop not in prop_list:
					prop_list.append(atom.arguments[0].name)
		break
	return prop_list
	

def get_all_model_weights(models):
	model_list = []
	for model in models:
		weights = {
			str(atom.arguments[0]): atom.arguments[1].number
			for atom in model
			if atom.name == "weight" and atom.arguments[1].type == clingo.SymbolType.Number
			}
		model_list.append(weights)
	return model_list


max_weight = 21 
 

def discover_constraints(models, properties, max_ratio=max_weight):
	"""
	For each pair (x, y), find the minimal set of constraints like:
	weight(x) ≥ k·weight(y), where k ∈ [1, 2, 3, ...]
	"""
	if not models or not properties:
		return []
	constraints = []
			
	for x, y in product(properties, repeat=2):
		if x == y:
			continue
		
		values = [(m[x], m[y]) for m in models]
		for k in reversed(range(1, int(max_ratio) + 1)):
			if all(a > k * b for a, b in values):
				constraints.append(f"{x} ≥ {k}·{y}")
				break  	
		if all(a == b for a, b in values):
			constraints.append(f"{x} = {y}")
	return constraints

def print_constraints(constraints):
	for c in sorted(set(constraints)):
		print(f"{c}")

def fullset_analysis(models):
	if not models:
		return []
	all_models = []
	for model in models:
		atoms = set(model)
		all_models.append(atoms)
	common_atoms = set.intersection(*all_models)
	print("Atoms that are true in all answer sets are the following: ")
	for pred in common_atoms:
		if pred.name == "catProp":
			print("Predicate:", pred)

def discover_diff(models, properties, max_ratio=max_weight-1): 
    if not models or not properties:
        return []
    print(f"\nAnalyzing differences (in all models):")
    constraints0 = []
    for x, y in product(properties, repeat=2):
        if x == y:
            continue
        values = [(m[x], m[y]) for m in models]

		# Calculating the minimum difference
        for k in reversed(range(0, int(max_ratio)+1)):
			# print(f"{k}")
            if all(abs(a - b) >= k for a, b in values):
				# print(f"we are now in the if statement")
                for j in (range(1, int(max_ratio)+1)):
                    if all(j >= abs(a - b) for a, b in values):
                        constraints0.append(f"{j}≥|{x}-{y}|≥{k}")
                        break  
                break
    return constraints0

def diff_analysis(models):
	props=get_props()
	print_constraints(discover_diff(models,props))
	

def print_maxmin_weight(models, x): 
	if not models:
		return 0
	weightList = []
	for m in models: 
		for atom in m:
			if atom == x: 
				weightList.append(m[x])

	print(f"Max weight of {x} is: {max(weightList)}")	
	print(f"Min weight of {x} is: {min(weightList)}")

def subset_analysis(models, x, y):
	subset_x_gt_y = [m for m in models if m[x] > m[y]]
	def get_props(subset):
		props = set()
		for m in subset:
			props.update(m.keys())
		return sorted(props)

	print(f"\nAnalyzing {x} > {y} (in {len(subset_x_gt_y)} models):")
	props_x_gt_y = get_props(subset_x_gt_y)
	print_constraints(discover_constraints(subset_x_gt_y, props_x_gt_y))


def read_file(file_path):
    with open(file_path, 'r') as f:
        return f.readlines()


def is_satisfiable(base_file, temp_constraints_file):
    result = subprocess.run(
    ["clingo", base_file, temp_constraints_file],
    stdout=subprocess.PIPE,
    stderr=subprocess.PIPE,
    universal_newlines=True  # same as text=True
    )
    return "UNSATISFIABLE" not in result.stdout

def write_temp_constraints_general(lines, removed_indices, temp_path):
    with open(temp_path, 'w') as f:
        for i, line in enumerate(lines):
            if i in removed_indices:
                f.write(f"% {line}")
            else:
                f.write(line) 

def find_conflicting_constraint_subsets(base_file, constraints_file, subset_size=1):
    lines = read_file(constraints_file)
    constraint_indices = [i for i, line in enumerate(lines) if line.strip().startswith("catProp")]
    print(f"Found {len(constraint_indices)} constraints.")

    for removed_indices in combinations(constraint_indices, subset_size):
        write_temp_constraints_general(lines, removed_indices, "temp_constraints.lp")
        if is_satisfiable(base_file, "temp_constraints.lp"):
            line_numbers = [i+1 for i in removed_indices]  # 1-based
            print(f"Constraints at lines {line_numbers} in '{constraints_file}' are causing unsatisfiability.")



props = get_props()
model_weights = get_all_model_weights(get_all_models())

print(f"Found {len(model_weights)} models.")

if model_weights:
	print("Here are all the orderings that are globally true")
global_constraints = discover_constraints(model_weights, props)
print_constraints(global_constraints)


fullset_analysis(get_all_models())

for x, y in product(props, repeat=2):
	if x != y:
		subset_analysis(model_weights, x, y)

diff_analysis(model_weights)

for x in props:
	print_maxmin_weight(model_weights, x)

if not model_weights:
	find_conflicting_constraint_subsets("CoreCode.lp", usedfile, subset_size=1)
	find_conflicting_constraint_subsets("CoreCode.lp", usedfile, subset_size=2)
