CONTEXT 0x8030614
080305f8: movs     r0, #0
080305fa: str      r3, [r2]
080305fc: bx       lr
080305fe: orr      r3, r3, #0x100
08030602: movs     r0, #0
08030604: str      r3, [r2]
08030606: bx       lr
08030608: adds     r5, #0xa8
0803060a: subs     r0, #0
0803060c: movs     r0, #0
0803060e: bx       lr
08030610: push     {r4, r5, r6, lr}
08030612: mov      r6, r1
08030614: ldr      r5, [pc, #0x3c]
08030616: mov      r1, r0
08030618: ldrb     r2, [r5]
0803061a: ldr      r3, [r6]
0803061c: uxtb     r2, r2
0803061e: cbz      r3, #0x8030640
08030620: add.w    ip, r0, #-1
08030624: ldr      r0, [pc, #0x30]
08030626: mov      r3, ip
08030628: ldrb     r4, [ip, #1]!
0803062c: add.w    lr, r2, #1
08030630: adds     r3, #2
08030632: strb     r4, [r0, r2]
08030634: ldr      r4, [r6]
08030636: uxtb.w   r2, lr
0803063a: subs     r3, r3, r1
0803063c: cmp      r4, r3
0803063e: bhi      #0x8030626
08030640: ldr      r0, [pc, #0x18]
08030642: strb     r2, [r5]
08030644: bl       #0x803041c
08030648: ldr      r0, [pc, #0x10]
0803064a: bl       #0x803046c
0803064e: movs     r0, #0
08030650: pop      {r4, r5, r6, pc}
08030652: nop      
08030654: adds     r5, #0xac
08030656: subs     r0, #0
08030658: adds     r5, #0xb0
0803065a: subs     r0, #0
0803065c: asrs     r4, r4, #0x1e
0803065e: subs     r0, #0
08030660: push     {r4, lr}
08030662: ldr      r4, [pc, #0x18]
08030664: movs     r2, #0
08030666: ldr      r1, [pc, #0x18]
08030668: mov      r0, r4
0803066a: .byte    0xff, 0xf7
CONTEXT 0x8030624
08030608: adds     r5, #0xa8
0803060a: subs     r0, #0
0803060c: movs     r0, #0
0803060e: bx       lr
08030610: push     {r4, r5, r6, lr}
08030612: mov      r6, r1
08030614: ldr      r5, [pc, #0x3c]
08030616: mov      r1, r0
08030618: ldrb     r2, [r5]
0803061a: ldr      r3, [r6]
0803061c: uxtb     r2, r2
0803061e: cbz      r3, #0x8030640
08030620: add.w    ip, r0, #-1
08030624: ldr      r0, [pc, #0x30]
08030626: mov      r3, ip
08030628: ldrb     r4, [ip, #1]!
0803062c: add.w    lr, r2, #1
08030630: adds     r3, #2
08030632: strb     r4, [r0, r2]
08030634: ldr      r4, [r6]
08030636: uxtb.w   r2, lr
0803063a: subs     r3, r3, r1
0803063c: cmp      r4, r3
0803063e: bhi      #0x8030626
08030640: ldr      r0, [pc, #0x18]
08030642: strb     r2, [r5]
08030644: bl       #0x803041c
08030648: ldr      r0, [pc, #0x10]
0803064a: bl       #0x803046c
0803064e: movs     r0, #0
08030650: pop      {r4, r5, r6, pc}
08030652: nop      
08030654: adds     r5, #0xac
08030656: subs     r0, #0
08030658: adds     r5, #0xb0
0803065a: subs     r0, #0
0803065c: asrs     r4, r4, #0x1e
0803065e: subs     r0, #0
08030660: push     {r4, lr}
08030662: ldr      r4, [pc, #0x18]
08030664: movs     r2, #0
08030666: ldr      r1, [pc, #0x18]
08030668: mov      r0, r4
0803066a: bl       #0x8030400
0803066e: ldr      r1, [pc, #0x14]
08030670: mov      r0, r4
08030672: bl       #0x803041c
08030676: movs     r0, #0
08030678: pop      {r4, pc}
0803067a: nop      
