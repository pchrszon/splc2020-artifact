### Questions

- Choice for assigning a workpiece to a production cell: nondeterministic, deterministic or random?

### Interactions

Interactions found during modeling

- If workpiece is ready to be processed by a robot, the robot could be
  reconfigured by another cell, leaving the workpiece "hanging" on the robot.
  Solution: workpieces may leave a robot if is is no longer able to process it.

### Properties

Throughput:
- counter for elapsed time (reconfiguration also takes time)
- reward for finished workpieces until end of time
- throughput: workpieces / time

- time counter does not take into account that processing of independent robots
  can be done in parallel
- simplification: if there are only as many workpieces as there are cells and
  cell assignment is fixed: only processing of robots in different cells can be
  done in parallel
- idea: add parallelization-id to processing action, with id for each possible
  combination of processing actions

### Results

- P fail = 0.1

- global vs. local-only reconfiguration:
    * 2-3 topology, tmax = 10, global:     2.967 .. 3.998 (0.2967 .. 0.3998)
    * 2-3 topology, tmax = 10, local-only: 2.591 .. 3.962 (0.2591 .. 0.3962)
    * 2-5 topology, tmax = 10, global:     1.531 .. 2.781 (0.1531 .. 0.2781)
    * 2-5 topology, tmax = 10, local-only: 1.531 .. 2.781 (0.1531 .. 0.2781)
    * 2-5 topology, tmax = 20, global:     4.595 .. 5.933 (0.2298 .. 0.2967)
    * 2-5 topology, tmax = 20, local-only: 3.654 .. 5.798

- different time-frames (global reconfiguration, 2-3 topology):
    * tmax = 10 :  2.967 ..  3.998 (0.2967 .. 0.3998)
    * tmax = 20 :  7.330 ..  8.573 (0.3665 .. 0.4286)
    * tmax = 40 : 12.569 .. 14.089 (0.3142 .. 0.3522)

- single cell vs. multiple cells (global reconfiguration):
    * 1-2 topology, tmax = 10: 2.845 .. 3.897 (0.2845 .. 0.3897)
    * 1-2 topology, tmax = 20: 6.236 .. 7.455 (0.3118 .. 0.3728)
    * 2-3 topology, tmax = 10: 2.967 .. 3.998 (0.2967 .. 0.3998)
    * 2-3 topology, tmax = 20: 7.330 .. 8.573 (0.3665 .. 0.4286)
    * 1-3 topology, tmax = 10: 1.503 .. 2.531 (0.1503 .. 0.2531)
    * 1-3 topology, tmax = 20: 4.106 .. 5.172 (0.2053 .. 0.2586)
    * 2-5 topology, tmax = 10: 1.531 .. 2.781 (0.1531 .. 0.2781)
    * 2-5 topology, tmax = 20: 4.595 .. 5.933 (0.2298 .. 0.2967)

- time taken by reconfiguration (2-3 topology, tmax = 20):
    * 1 tu, global:     7.330 .. 8.573 (0.3665 .. 0.4286) 0.0538
    * 1 tu, local-only: 6.253 .. 8.348 (0.3127 .. 0.4174)
    * 2 tu, global:     6.730 .. 8.090 (0.3365 .. 0.4045) 0.0578
    * 2 tu, local-only: 5.574 .. 7.898 (0.2787 .. 0.3949)

### Results (with phases)

- P fail = 0.1

- single cell vs. multiple cells (global reconfiguration):
    * 1-2 topology, tmax = 10, 1 workpiece:  3.891 ..  3.891 (0.3891 .. 0.3891)
    * 1-2 topology, tmax = 10, 2 workpieces: 5.560 ..  6.427 (0.5560 .. 0.6427)
    * 2-3 topology, tmax = 10, 2 workpieces: 5.944 ..  7.052 (0.5944 .. 0.7052)
    * 2-3 topology, tmax = 10, 4 workpieces: 6.126 ..  8.390 (0.6126 .. 0.8390)
    * 2-4 topology, tmax = 10, 2 workpieces: 6.152 ..  7.618 (0.6152 .. 0.7618)
    * 2-4 topology, tmax = 10, 4 workpieces: 8.579 .. 11.965 (0.8597 .. 1.1965)

    * 1-3 topology, tmax = 10, 1 workpiece:  2.531 ..  2.827 (0.2531 .. 0.2827)
    * 1-3 topology, tmax = 10, 2 workpieces: 3.599 ..  4.776 (0.3599 .. 0.4776)
    * 1-3 topology, tmax = 20, 2 workpieces: 8.199 ..  9.973 (0.4100 .. 0.4987)
    * 2-5 topology, tmax = 10, 2 workpieces: 3.748 ..  4.928 (0.3748 .. 0.4928)
    * 2-5 topology, tmax = 20, 2 workpieces: 8.038 .. 10.858 (0.4019 .. 0.5429)

- global vs. local-only reconfiguration:
    * 2-3 topology, tmax = 10, global:     5.944 ..  7.052 (0.5944 .. 0.7052)
    * 2-3 topology, tmax = 10, local-only: 4.887 ..  6.770 (0.4887 .. 0.6670)
    * 2-5 topology, tmax = 10, global:     3.748 ..  4.928 (0.3748 .. 0.4928)
    * 2-5 topology, tmax = 10, local-only: 3.223 ..  4.547 (0.3223 .. 0.4547)
    * 2-5 topology, tmax = 20, global:     8.038 .. 10.858 (0.4019 .. 0.5429)
    * 2-5 topology, tmax = 20, local-only:

- single cell vs. multiple cells (global reconfiguration, P fail = 0.0):
    * 1-2 topology, tmax = 10, 2 workpieces:  8.0 ..  8.0
    * 2-3 topology, tmax = 10, 4 workpieces:  8.0 ..  8.0
    * 2-4 topology, tmax = 10, 4 workpieces: 16.0 .. 16.0

### Results (with phases, fast shared)

- single cell vs. multiple cells (global reconfiguration):
    * 1-2 topology, tmax = 10, 1 workpiece:  3.891 .. 3.891
    * 2-3 topology, tmax = 10, 2 workpieces: 6.187 .. 7.355
    * 2-4 topology, tmax = 10, 2 workpieces: 6.152 .. 7.618

    * 1-3 topology, tmax = 10, 1 workpiece:  2.531 .. 2.827 (X)
    * 2-5 topology, tmax = 10, 2 workpieces: 4.035 .. 5.474
    * 2-6 topology, tmax = 10, 2 workpieces: 6.870 .. 7.964 (X)

    * 1-3 topology, tmax = 10, 2 workpieces: 3.599 .. 4.776
    * 2-5 topology, tmax = 10, 4 workpieces:

    * 1-3 topology, tmax = 10, 3 workpieces: 4.051 .. 6.097
    * 2-5 topology, tmax = 10, 6 workpieces:

- global vs. local-only reconfiguration:
    * 2-3 topology, tmax = 10, 2 workpieces, global:     6.187 .. 7.355
    * 2-3 topology, tmax = 10, 2 workpieces, local-only: 5.173 .. 7.130

    * 2-5 topology, tmax = 10, 2 workpieces, global:     4.035 .. 5.474 (X)
    * 2-5 topology, tmax = 10, 2 workpieces, local-only: 3.493 .. 5.096 (X)
