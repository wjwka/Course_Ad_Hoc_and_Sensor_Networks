# Link Layer
## Link Layer Tasks in General
1. **Framing**: Group sequence of bits into packets/frames
2. **Error control**: make sure that transmitted bits arrive and no others
3. **Flow control**: ensure that a faster sender does not overrun a slower receiver
4. **Link management**: discover/manage links to meighbors 

## Error Control
### Overview
1. ensure that the data transfer is:
    1. Error-free:
    2. In-sequence:
    3. Duplication-free:
    4. Loss-free:
    5. Energy-efficiency
2. Reasons for bit errors or packet losses:
    1. interference
    2. fading
    3. loss of synchronization
3. Approaches:
    1. Open-loop: Forward Error Correction(FEC)
    2. Close-loop: ARQ(Automatic Repeat Request) schemes, retransmissions
    3. Hybrid approaches

### ARQ Design Aspects
1. Basic procedure:
    1. Transmitter prepares packet
    2. Transmitter sends packet and sets timer
    3. Receiver provides **feedback** to transmitter
    4. If sender infers that packet has not been received correctly, it will retransmits
2. Standard-ARQ protocols:
    1. alternating-bit (stop-wait)
    2. goback-N
    3. selective repeat
    4. for WSNs alternating bit is often sufficient,[todo]since the bitrates in WSN are always low

### How to Use ACK(Acknowledgments)?
1. Be careful about ACKs from different layers
2. Do not necessarily acknowledge every packet -- use cumulative ACKs
    1. Example scheme: send ACK every *W* packets, after timeout or after duplicate packet -- ACK contains information about packets since lask ACK
    2. Tradeoff against buffer space
3. ACKs: wasteful over excellent links
4. NACKs: additional mechanisms
5. Implicit ACKs: useful with multi-hop forwarding

   "I send you a packet and I hear you forwarding the same packet, so I don't need an extra ACK"

### When to Retransmit?
1. For stationary BSC: any time
2. For fading channel: postpone until deep fade ends( > coherence time )
3. How long to wait: 
    1. probing protocol
        1. two protocol modes, "normal" and "probing"
        2. when error occurs, switch to probing mode
        3. In probing mode, periodically send short packets until sucessful go to normal mode
    2. wait for some fixed time, e.g. the coherence time plus some safety margin

## Framing
### Packet Size
1. Small packets: lower error rate, highter packetzation overhead
2. Large packets: higher error rate, lower packetzation overhead
3. Depends on BER(bit error rate), energy consumption

# Naming & Addressing
## Introduction
1. Traditional(fixed, wireless ad hoc): denote individual noted/interfaces with addresses, e.g. MAC address, IP address, etc.
2. WSN: content-based addresses
3. Name VS Address
    1. Name: refer to things
        1. MANET: nodes
        2. WSN: data
    2. Address: information needed to **find** these things
        1. often hierarchical structure
    3. Binding services: map names to addresses

## Id-centric addressing
### Address Management
1. **Address allocation**: assign an entity an addresss from a given pool of possible addresses

   Distributed schemes preferable, centralized solutions like DHCP do not scale well
2. **Address deallocation**: once an address is no longer used, put it back into the address pool
3. **Duplicate address detection(DAD)**[todo]

### Address Allocation
1. Priori allocation: during manufacturing or before deployment
2. On-demand allocation: either centralized or distributed
    1. Centralized solutions create hot spots
    2. Distributed solutions:
        1. Require execution of an extra protocol
        2. Face the problem of duplicate detection and resolution
            1. Strong DAD: duplicates must be avoided by all means
            2. Weak DAD: duplicates are tolerable when they do not hurt
3. different uniqueness requirements:
    1. Globally unique: requires large representations, but can be done offline without extra protocol
    2. Network-wide unique: requires representations of moderate size, might required extra protocol
    3. Locally unique: requires only small representations, but definitely requires extra protocol
        1. "Local" = two-hop neighborhood

### Uniqueness Requirements
1. On the MAC layer: At least local uniqueness required
2. At the routing layer:
    1. MANET: network-wide- or global uniqueness required, routing must be able to reach individual nodes
    2. WSNs: individual nodes not overly important, non-local

       sensor-to-sensor communication happens rarely, most traffic flows to sinks
       => Sinces and actuators need network-wide or globally unique addresses, for sensors locally unique addresses might be sufficient

### Address Representation
[todo]

### Distributed Assignment of Unique Addresses
1. In MANET, there're several methods:
    1. Node selects randomly a temporary address -> issues an **address request** packet to that address
        1. If routing protocol finds another station, this answers with **address reply**
        2. When no response within finite time, after some further trials the chosen address is accepted
    2. All nodes keep a table of known address allocations -> new node asks neighbor for new address -> neighbor disseminates new address, waits for "objections"
    3. Hierarchical approach for IPv6
        1. Some nodes become **leader nodes**, pick address ranges randomly and check for collisions with other leaders
        2. Other nodes create their addresses from the range adopted by their leader

### Distributed Assignment of Locally Unique Addresses
1. With locally unique address assignments it is possible to re-use addresses within the network, so address representation can be smaller
2. "greedy" use:
    1. When there is a choice, use numerically smallest address
    2. This implies that smallest numbers are the most often used
    3. Therefore, we can shorten address representations by encoding them losslessly
3. Protocol Design Aspects
    1. **Inbound neighbor** of A is a node whose transmissions A can hear but not vice versa
    1. **Outbound neighbor** of A is a node which hears A's transmitions but not vice versa
    1. Nodes communicate only with **bi-directional** neighbors
    1. [todo]Example
    2. Summary: the addresses of receptions must be unique

## Content-based addressing
1. change from id-centric to data-centric networking in WSN
2. Supported by content-based names/addresses

   Do not describe involved nodes, but specify the data one is interested in
3. In sensor networks:
    1. use locally unique addresses
    2. Identify nodes by the data they have
    3. *Use this in protocols**

       Example: let routing be influenced by data, not by addresses

