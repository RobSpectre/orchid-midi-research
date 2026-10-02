; Offline disassembly. Literal pools may decode as instructions.
; Recognized jump-table data is explicitly identified below.
080347d4: push       {r4, r5, r6, lr}
080347d6: ldr        r5, [pc, #0x74]
080347d8: mov        r4, r0
080347da: mov        r3, r1
080347dc: ldrb.w     r0, [r5, r1, lsl #1]
080347e0: cmp        r2, r0
080347e2: blt        #0x8034804
080347e4: add.w      r5, r5, r1, lsl #1
080347e8: ldrb       r0, [r5, #1]
080347ea: cmp        r2, r0
080347ec: bgt        #0x8034804
080347ee: add.w      r0, r4, r1, lsl #1
080347f2: ldrsh.w    r5, [r0, #0x3e]
080347f6: cmp        r5, r2
080347f8: beq        #0x8034804
080347fa: strh       r2, [r0, #0x3e]
080347fc: cbz        r1, #0x803482e
080347fe: cmp        r1, #1
08034800: beq        #0x803483c
08034802: pop        {r4, r5, r6, pc}
08034804: cmp        r3, #0
08034806: bne        #0x8034802
08034808: ldrsh.w    r3, [r4, #0x2c8]
0803480c: cmp        r3, #0
0803480e: bge        #0x8034822
08034810: ldrb       r3, [r4, #0xd]
08034812: cmp        r3, #2
08034814: bne        #0x8034802
08034816: mov        r0, r4
08034818: movs       r1, #0
0803481a: pop.w      {r4, r5, r6, lr}
0803481e: b.w        #0x8034198
08034822: mov        r0, r4
08034824: movs       r1, #1
08034826: pop.w      {r4, r5, r6, lr}
0803482a: b.w        #0x8033b9c
0803482e: ldrb.w     r3, [r4, #0x3e]
08034832: movs       r2, #0x73
08034834: ldr        r0, [r4, #4]
08034836: bl         #0x8031f68
0803483a: b          #0x8034808
0803483c: ldrb.w     r3, [r4, #0x40]
08034840: movs       r2, #0x74
08034842: ldr        r0, [r4, #4]
08034844: pop.w      {r4, r5, r6, lr}
08034848: b.w        #0x8031f68
0803484c: adds       r1, #0x34
0803484e: lsrs       r7, r0, #0x20
08034850: push       {r4, r5, r6, lr}
08034852: ldr        r3, [pc, #0x34]
08034854: mov        r4, r1
08034856: mov        r5, r0
08034858: sub        sp, #8
0803485a: add.w      r6, r0, r4, lsl #1
0803485e: mov        r1, r2
08034860: add.w      r0, r3, r4, lsl #1
08034864: ldrb.w     r2, [r3, r4, lsl #1]
08034868: ldrb       r3, [r0, #1]
0803486a: movs       r0, #0
0803486c: str        r0, [sp]
0803486e: ldrsh.w    r0, [r6, #0x3e]
08034872: bl         #0x803db28
08034876: mov        r1, r4
08034878: mov        r2, r0
0803487a: mov        r0, r5
0803487c: bl         #0x80347d4
08034880: ldrsh.w    r0, [r6, #0x3e]
08034884: add        sp, #8
08034886: pop        {r4, r5, r6, pc}
08034888: adds       r1, #0x34
0803488a: lsrs       r7, r0, #0x20
0803488c: add.w      r0, r0, r1, lsl #1
08034890: ldrsh.w    r0, [r0, #0x3e]
08034894: bx         lr
08034896: nop        
