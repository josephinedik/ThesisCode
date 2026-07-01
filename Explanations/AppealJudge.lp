parent(a).
parent(b).

props(good_relationship_with_child).
props(bad_relationship_with_child).
props(hit_child_once).
props(child_wants_to_live_with_parent).
props(moved_without_consent).

hasProp(a, good_relationship_with_child).
hasProp(a, child_wants_to_live_with_parent).
hasProp(a, moved_without_consent).

hasProp(b, bad_relationship_with_child).
hasProp(b, hit_child_once).

goodness(good_relationship_with_child).
goodness(child_wants_to_live_with_parent).

badness(bad_relationship_with_child).
badness(hit_child_once).
badness(moved_without_consent).

catProp(good_relationship_with_child, imp).
catProp(bad_relationship_with_child, imp).
catProp(hit_child_once, veryimp).
catProp(child_wants_to_live_with_parent, veryimp).
catProp(moved_without_consent, unimp).

choose(a).

perm(X) :- props(X).
num(1..21).
