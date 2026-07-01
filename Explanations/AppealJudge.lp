parent(a).
parent(b).

props(bad_relationship_with_child).
props(child_wants_to_live_with_parent).
props(moved_without_consent).

hasProp(a, child_wants_to_live_with_parent).
hasProp(a, moved_without_consent).
hasProp(b, bad_relationship_with_child).

goodness(child_wants_to_live_with_parent).
badness(bad_relationship_with_child).
badness(moved_without_consent).

catProp(bad_relationship_with_child, imp).
catProp(child_wants_to_live_with_parent, veryimp).
catProp(moved_without_consent, imp).

choose(a).

perm(X) :- props(X).
num(1..21).
