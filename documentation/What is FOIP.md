# Incentergy Fax over IP Solutions explained:

In the modern age of communcations, all Telephone-Lines are now digitalized. This means that the information is being disassembled into packets. Each packet finds a route over the complex Internet and arrives at the destination. At the destination all arriving packages are being re-assembled into the final information. In the modern Internet, it can happen very well, that during transmission one packet gets "lost" and does not make it to the final destination. Normally, there is a redundancy control and the packed would just be requested again, and then received a bit later. The problem with the Fax Simulation over VoIP lines is that this software needs a continuous transmission and can not re-send lost packets in the middle of the transmission.

The problem with FAXes is, that they were meant to work over continuous-current electrical phone-lines and that they did not transmit the data digitally, but only over audio-sounds where every tone had a meaning in the data (Modulation and Demodulation process) (Fax-MoDem)

At Incentergy, we provide 2 software-modem solutions

IAXmodem (Allowed packet-loss: Ideally less than 1%)
T.38modem (Allowed packet-loss: Ideally less than 10%)

While in theory T.38 seems superior, in practice IAX has proven more reliable for different reasons

The connection should ideally be on a "free internet-connection", not over an encrypted VPN

Also, the Network-Latency is a key-indicator of how successful the transmission is going to be

If you have a latency of under 10ms (milliseconds) and are not behind a VPN, the transmission will most likely be successful.

If you have a latency of 10x that, (70ms-100ms) and are behind a VPN, the transmission might not go through