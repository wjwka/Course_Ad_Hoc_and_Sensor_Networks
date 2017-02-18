# Fundamentals
## Introduction
### Wireless Medium Access Control
1. Wireless channels are half-duplex
2. No real collision detection functionality

### Centralized Medium Access
1. Idea: a central station regulates access to the medium
    1. Examples: polling strategies, centralized computation of TDMA schedules
    2. Advantages: easy to avoid collisions, easy guarantee of regular access to nodes
    3. Disadvantages:
        1. Allocation-deallocation protocols are required
        2. Central controller can be complex
        3. Single point of failure
        4. TDMA: time synchronization
2. Rarely used in wireless multi-hop networks
3. But: quite usefule when network is divided into smaller groups
4. In MANETs and WSNs usually distrubuted medium access is considered

### Schedule- vs. contention-based MACs
1. **Schedule-based MACs**:
    1. A schedule regulates who uses channel at which time
    2. Schedule can be created a-priori(offline) or on demand
    3. TDMA must be supported by time synchronization[todo]
2. **Contention-based MACs**:
    1. Risk of colliding packets is deliberately taken
    2. Hope: coordination overhead can be saved, resulting in overall improved efficiency
    3. Mechanisms to handle/reduce probability/impact of collisions required

       Popular approach: CSMA - "listen before you talk"
    4. Usually, **randomization** is used somehow

## Hidden-terminal problem and solutions
1. Senarios
    1. Hidden terminal: A->B, C->B, then collision
    2. Exposed terminal: B->A, C->D, C senses medium busy and defer
    3. [todo]figure
2. Solutions
    1. Busy-Tone solution
        1. use 2 frequency bands:
            1. *data band* is used to transmit data packets
            2. *busy-tone band* is used to transmit busy tone signals
        2. Approach:
            1. While receiving a data packet a station sends an ongoing signal on the busy tone band
            2. The carrier sensing is performed on the busy-tone channel
        3. both problems(hidden and exposed) solved
        3. problems
            1. more spectrum/hardware
            2. if busy tone has smaller transmission range than data signals, collisions still possible
            2. if busy tone has larger transmission range, then theoretically feasible transmissions can be suppressed
            3. The busy tone channel is narrowband => frequency synchronization required
    2. RTS/CTS protocol
        1. uses only a single channel, but requires the exchange of small control packets before data transmission
        2. send RTS(request to send) before sending; send CTS(clear to send) to answer CTS.
        3. [todo]figure
        4. exposed-terminal problem is not solved
        4. Hidden-terminal problem is not completly solved
        5. MANETs: IEEE 802.11 uses RTS/CTS
        6. WSNs: IEEE 802.15.4 uses no RTS/CTS

# MACs for WSNs
## Introduction
### Sources of energy waste
1. Collisions
2. Overhearing
3. Protocol overhead
4. Idle listening

### Deal with Idle Listening
1. In 802.11: TIM and sleeping

   nodes that have data buffered for receivers(e.g. APs) send **traffic indictors**(TI) at pre-arranged points in time, receivers need to wake up at these points, but can sleep otherwise. If TI indicates buffered packets to a receiver, it remains awake and exchanges data with transmitter
2. In WSNs
    1. TDMA-based approaches
    2. Contention approaches
## Asynchronous contention-based schemes
## Synchronized contention-based schemes
## Event-based MACs

# IEEE 802.15.4
## IEEE 802.15.4 Overview and Architecture
## Physical layer
## MAC layer

# LPWAN
