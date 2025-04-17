.global entryother_start, entryother_end
.global _binary_initcode_start, _binary_initcode_end

.section .rodata
.align 4

entryother_start:
    .incbin "out/entryother"
entryother_end:

_binary_initcode_start:
    .incbin "out/initcode"
_binary_initcode_end: