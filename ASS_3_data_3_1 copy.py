# Jobs 1..10
J = list(range(1, 11))

p = {1:4, 2:5, 3:3, 4:5, 5:7, 6:1, 7:0, 8:3, 9:2, 10:10}  # durations
r = {1:3, 2:4, 3:7, 4:11, 5:10, 6:0, 7:0, 8:10, 9:0, 10:15} # release times
d = {1:11, 2:12, 3:20, 4:25, 5:20, 6:10, 7:30, 8:30, 9:10, 10:20} # due dates
c = {j:1 for j in J}  # unit tardiness cost

# Safe big-M (upper bound on any start difference): latest start won’t exceed
# max(r) + sum(p), so this M is safe and not absurdly large.
M = max(r.values()) + sum(p.values())