# Registers

- AARCH64 has **32** integer registers and **32** floating point registers.

## Types of registers

### Integer registers
- x - 64 bit integer or pointer (addresses)
- w - 32 bit integer

### Floating point registers
- q - quad words        - 16 bytes  - 128 bits
- v - same as q
- d - doubles           - 8 bytes   - 64 bit floats (doubles)
- s - floats            - 4 bytes   - 32 bit floats
- h - half-precision    - 2 bytes   - 16 bit floats
- b - byte              - 1 byte    - 8 bit floats

## Notes
- **The stack pointer in ARM V8 can only be manipulated in multiples of 16.**



# Register functions
x0 - x7     - Parameters, scratch


x30 - Link register - stores return point after called function ends
x31 - N/A