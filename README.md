Analysis of Role-based Models
=============================

This repository contains two models for illustrating the role-based modeling
approach and a subsequent (quantitative) analysis. The first example is a
peer-to-peer file transfer protocol (`p2p-transfer`) and the second example
concerns an automated self-adaptive production cell (`production-cell`).


## Prerequisites

Running the experiments requires the following tools to be installed.

* Translation of the role-based models into PRISM models requires the
  [rbsc tool](https://github.com/pchrszon/rbsc).
* The verification and analysis of the resulting models is carried out using
  [PRISM](http://www.prismmodelchecker.org) (see also
  [PRISM on Github](https://github.com/prismmodelchecker/prism)).
* *(optional)* For running the analysis on models with multi-actions, an
  [extended version of PRISM](https://wwwtcs.inf.tu-dresden.de/ALGI/PUB/FA18/)
  is required (the archive contains further installation instructions).

The scripts for running the experiments provided in this repository assume that
both `rbsc` and `prism` are on the `PATH`. In case you opted for installing the
extended version of PRISM as well, it should be made available as `prism-ma` on
the `PATH`. However, you may also explicitly specify the paths to the `rbsc` and
`prism` binaries by setting the `RBSC` and `PRISM` variables in the first few
lines of each script.


## Running the Experiments

In the following, the scripts for running the experiments are explained in
detail.

### Peer-to-peer File Transfer

The role-based version of this family of models is contained in the
`p2p-transfer` directory.

**Functional analysis of a single network.** The functional correctness of a
single network can be checked using the `check-single.sh` script. It requires
three arguments: the topology (either `star` or `ring`), the number of stations,
and the number of distinct files. In a star topology, the first station is
placed at the center and all other stations are directly connected to this
central station, with no additional connections between the outer stations. In
a ring topology, each station is directly connected to its two neighbors in the
ring (via bidirectional connections). For instance, checking the functional
correctness of a network with ring topology, 3 stations, and 2 files can be
achieved using:

    ./check-single.sh ring 3 2

The script first instantiates the role-based model, translates it into a PRISM
model, and finally invokes PRISM for checking the functional properties.
*Expected output*: PRISM prints `Result: true` for each property.

**Functional analysis of interacting networks.** The functional correctness of a
system comprising two interacting networks can be checked using the
`check-multi.sh` script. The first network consists of two stations, 1 and 2,
which are directly connected to each other. The second network comprises the
stations 2, 3, and 4, arranged in a ring topology. Note that the station 2 is
shared between the two networks. Since the scenario is fixed, the script takes
no further arguments:

    ./check-multi.sh

*Expected output*: The two last properties, i.e., that some station is able to
get file 1, and the each request is eventually answered, are violated (PRISM
prints `Result: false`). To view the traces of the violated properties, the GUI
of PRISM may be started using:

    xprism build/out.prism sanity.props

In the properties pane, select the third or fourth property, right click and
select "Verify". After checking the property, PRISM will offer showing a
counterexample trace in the simulator.


**Scalability.** For benchmark purposes, the file-transfer model can be
automatically instantiated for an increasing number of stations and files. The
maximal number of stations and the maximal number of files are passed as
arguments to the `build.sh` script, e.g.:

    ./build.sh 3 2

This will instantiate three models in the `build/bench` directory:

- 2 stations, 1 file
- 3 stations, 1 files
- 3 stations, 2 files

Subsequently, the generated PRISM models can be checked using the `bench.sh`
script, which should be invoked with the same arguments that have been used
previously for executing the `build.sh` script.

    ./bench.sh 3 2

The benchmark script will run each analysis three times, with a warm-up run
beforehand. The output logs will be written to the `logs` directory.

Finally, various model and analysis statistics can be collected into a single
CSV file using the `results.sh` script. Again, pass the same arguments as
previously:

    ./results.sh 3 2

The statistics will be written to the `results.csv` file.

The benchmarks as described above can also be conducted using the extended
version of PRISM that is able to directly handle multi-actions. This extended
version is furthermore capable of reducing the size of the internal symbolic
model representation by means of reordering. To run the benchmarks using the
extended version of PRISM, use the `build-ma.sh` and `bench-ma.sh` scripts
instead of the `build.sh` and `bench.sh` scripts, respectively.

**Comparison with standard PRISM model.** To quantify the impact of the
role-based modeling and analysis approach on the model sizes and analysis times,
a reference model using no role-specific constructs is provided in the
`p2p-transfer-ref` directory. The `build.sh`, `bench.sh`, and `results.sh`
scripts are invoked in the same way as for the role-based model.


### Self-adaptive Production Cell

The model for the self-adaptive production cell is contained in the
`production-cell` directory.

**Quantitative Analysis: Impact of Adaptivity on Resilience.** The first
experiment compares the resiliency, i.e., the probability that the system
successfully produces *n* workpieces, for varying degrees of adaptability. Here,
we consider a production cell comprising three robots. The *fixed* variant
possesses no adaptivity. In the *adaptive-chain* variant, the direction in which
the workpieces move through the cell can be flipped. The *adaptive-ring*
variants allows for all possible adaptations, i.e., each robot can potentially
carry out each of the processing steps.

The probabilities of completing *n* workpieces for an increasing *n* can be
computed using the `completion_probs.sh` script. The first argument is the model
variant, which is either `main-fixed.rbl`, `main-adaptive-chain.rbl`, or
`main-adaptive-ring.rbl`. The following three arguments provide the initial
value of *n*, the stride (how much *n* is increased in each step), and the
maximal value of *n*. For instance, computing the probabilities for processing
*n* workpieces for *n* = 10, *n* = 20, and *n* = 30 in the *fixed* variant can
be computed with:

    ./completion_probs.sh main-fixed.rbl 10 10 30

The results are written to the file `<variant>.dat`, where the second column
states the probability of successfully processing the number of workpieces in
the first column.

**Quantitative Analysis: Throughput.** The second experiment compares the
throughput of different cell configurations and adaptation strategies. In
particular, the following variants are analyzed:

* single cell with 3 robots
* two cells with one shared robots and two other robots each, cells are adapted
  separately
* same as the previous variant, but adaptation considers both cells
* two separate cells with 3 robots each

The analysis for all 4 variants is started using the `throughput.sh` script (no
arguments). The results as produced by PRISM are written to the `logs`
directory.
