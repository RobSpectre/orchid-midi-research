CONTEXT 0x802ee1a
0802ee06: pop      {r3, r4, r5, pc}
0802ee08: mov.w    r3, #0x10001
0802ee0c: str      r3, [r0, #0x68]
0802ee0e: b        #0x802edf4
0802ee10: movs     r0, #2
0802ee12: pop      {r3, r4, r5, pc}
0802ee14: push     {r3, lr}
0802ee16: and      r0, r0, #1
0802ee1a: ldr      r3, [pc, #0x60]
0802ee1c: movs     r2, #1
0802ee1e: strb     r0, [r3]
0802ee20: cbnz     r0, #0x802ee54
0802ee22: ldr      r1, [pc, #0x5c]
0802ee24: ldr      r0, [pc, #0x5c]
0802ee26: bl       #0x802f560
0802ee2a: cbz      r0, #0x802ee2e
0802ee2c: bkpt     #0
0802ee2e: ldr      r1, [pc, #0x58]
0802ee30: ldr      r0, [pc, #0x50]
0802ee32: bl       #0x802f588
0802ee36: cbnz     r0, #0x802ee76
0802ee38: movs     r3, #0
0802ee3a: ldr      r1, [pc, #0x50]
0802ee3c: ldr      r2, [pc, #0x50]
0802ee3e: ldr      r0, [pc, #0x44]
0802ee40: strb     r3, [r1]
0802ee42: str      r3, [r2]
0802ee44: bl       #0x802f5c0
0802ee48: cbz      r0, #0x802ee4c
0802ee4a: bkpt     #0
0802ee4c: .byte    0xbd, 0xe8
CONTEXT 0x802ee54
0802ee40: strb     r3, [r1]
0802ee42: str      r3, [r2]
0802ee44: bl       #0x802f5c0
0802ee48: cbz      r0, #0x802ee4c
0802ee4a: bkpt     #0
0802ee4c: pop.w    {r3, lr}
0802ee50: b.w      #0x802d7a8
0802ee54: ldr      r1, [pc, #0x3c]
0802ee56: ldr      r0, [pc, #0x2c]
0802ee58: bl       #0x802f560
0802ee5c: cbz      r0, #0x802ee60
0802ee5e: bkpt     #0
0802ee60: ldr      r1, [pc, #0x34]
0802ee62: ldr      r0, [pc, #0x20]
0802ee64: bl       #0x802f588
0802ee68: cbz      r0, #0x802ee6c
0802ee6a: bkpt     #0
0802ee6c: ldr      r1, [pc, #0x2c]
0802ee6e: ldr      r0, [pc, #0x14]
0802ee70: bl       #0x80303e8
0802ee74: b        #0x802ee38
0802ee76: bkpt     #0
0802ee78: b        #0x802ee38
0802ee7a: nop      
0802ee7c: asrs     r1, r2, #1
0802ee7e: subs     r0, #0
0802ee80: sub      sp, #0
0802ee82: lsrs     r4, r0, #0x20
0802ee84: asrs     r4, r4, #0x1e
0802ee86: subs     r0, #0
CONTEXT 0x802eea0
0802ee8c: asrs     r0, r2, #1
0802ee8e: subs     r0, #0
0802ee90: asrs     r4, r2, #1
0802ee92: subs     r0, #0
0802ee94: lsls     r4, r1, #3
0802ee96: movs     r4, #0
0802ee98: lsls     r4, r1, #1
0802ee9a: movs     r4, #0
0802ee9c: lsls     r4, r5, #3
0802ee9e: movs     r4, #0
0802eea0: ldr      r3, [pc, #0xac]
0802eea2: mov      r2, r1
0802eea4: ldrb     r3, [r3]
0802eea6: cmp      r3, #1
0802eea8: beq      #0x802ef4a
0802eeaa: movs     r3, #4
0802eeac: cmp      r1, #3
0802eeae: mov      ip, r0
0802eeb0: push.w   {r4, r5, r6, r7, r8, sb, lr}
0802eeb4: sub      sp, #0xc
0802eeb6: strb.w   r3, [sp, #4]
0802eeba: bls      #0x802ef3c
0802eebc: ldr.w    sb, [pc, #0x9c]
0802eec0: adds     r3, r0, #3
0802eec2: ldr      r4, [pc, #0x90]
0802eec4: ldr      r5, [pc, #0x90]
0802eec6: ldr.w    r1, [sb]
0802eeca: ldr      r7, [r4]
0802eecc: subs     r2, #3
0802eece: ldrb     lr, [r3, #-0x2]
0802eed2: adds     r0, r7, #1
CONTEXT 0x802ef6e
0802ef5a: subs     r0, #0
0802ef5c: subs     r0, r0, r2
0802ef5e: subs     r0, #0
0802ef60: ldr      r3, [pc, #0x70]
0802ef62: ldrb     r2, [r3]
0802ef64: cbz      r2, #0x802efb0
0802ef66: ldr      r3, [pc, #0x70]
0802ef68: ldr      r3, [r3]
0802ef6a: cmp      r3, #1
0802ef6c: bls      #0x802efd0
0802ef6e: ldr      r3, [pc, #0x6c]
0802ef70: ldrb     r2, [r0]
0802ef72: ldrb     r3, [r3]
0802ef74: lsrs     r1, r2, #4
0802ef76: cmp      r3, #1
0802ef78: beq      #0x802efc4
0802ef7a: movs     r3, #0
0802ef7c: bfi      r3, r1, #0, #8
0802ef80: push     {r4, r5}
0802ef82: bfi      r3, r2, #8, #8
0802ef86: ldr      r5, [pc, #0x58]
0802ef88: ldrb     r2, [r0, #1]
0802ef8a: ldrb     r1, [r0, #2]
0802ef8c: ldr      r4, [r5]
0802ef8e: bfi      r3, r2, #0x10, #8
0802ef92: ldr      r2, [pc, #0x50]
0802ef94: bfi      r3, r1, #0x18, #8
0802ef98: ldr      r0, [pc, #0x4c]
0802ef9a: ldr      r1, [r2]
0802ef9c: adds     r2, r4, #1
0802ef9e: str.w    r3, [r0, r4, lsl #2]
CONTEXT 0x802eff4
0802efe0: subs     r4, r0, r2
0802efe2: subs     r0, #0
0802efe4: subs     r0, r0, r2
0802efe6: subs     r0, #0
0802efe8: subs     r0, r1, r2
0802efea: subs     r0, #0
0802efec: asrs     r4, r4, #0x1e
0802efee: subs     r0, #0
0802eff0: str      r3, [sp, #0x250]
0802eff2: lsrs     r4, r0, #0x20
0802eff4: ldr      r3, [pc, #0xd8]
0802eff6: ldrb     r3, [r3]
0802eff8: cmp      r3, #1
0802effa: beq      #0x802f0c8
0802effc: ldr      r3, [pc, #0xd4]
0802effe: push.w   {r4, r5, r6, r7, r8, lr}
0802f002: ldrb     r4, [r3]
0802f004: ldr      r5, [pc, #0xd0]
0802f006: cbz      r4, #0x802f00e
0802f008: ldrb     r1, [r5]
0802f00a: cmp      r1, #0
0802f00c: beq      #0x802f0bc
0802f00e: ldr      r6, [pc, #0xcc]
0802f010: strb     r4, [r5]
0802f012: bl       #0x803f7b0
0802f016: ldrb     r3, [r6]
0802f018: ldr      r7, [pc, #0xc4]
0802f01a: and      r2, r3, #0xff
0802f01e: cmp      r3, #0
0802f020: bne      #0x802f09c
0802f022: str      r2, [r7]
0802f024: ldr      r4, [pc, #0xbc]
0802f026: ldrb     r3, [r4]
CONTEXT 0x803009a
08030086: movs     r2, #0xa
08030088: ldr      r0, [pc, #4]
0803008a: strh     r2, [r3]
0803008c: bx       lr
0803008e: nop      
08030090: lsls     r4, r0, #2
08030092: movs     r4, #0
08030094: push     {r4, r5, r6, lr}
08030096: movs     r1, #0x82
08030098: mov      r6, r0
0803009a: ldr      r0, [pc, #0x3c]
0803009c: bl       #0x802f8cc
080300a0: movs     r1, #1
080300a2: mov      r5, r0
080300a4: ldr      r0, [pc, #0x30]
080300a6: bl       #0x802f8cc
080300aa: movs     r1, #0x81
080300ac: mov      r4, r0
080300ae: ldr      r0, [pc, #0x28]
080300b0: bl       #0x802f8cc
080300b4: cbz      r5, #0x80300ba
080300b6: movs     r2, #0x10
080300b8: strb     r2, [r5, #6]
080300ba: cbz      r4, #0x80300c4
080300bc: movs     r1, #0
080300be: movs     r2, #0x40
080300c0: strb     r1, [r4, #5]
080300c2: strb     r2, [r4, #4]
080300c4: cbz      r0, #0x80300ce
080300c6: movs     r1, #0
080300c8: movs     r2, #0x40
080300ca: strb     r1, [r0, #5]
080300cc: strb     r2, [r0, #4]
CONTEXT 0x80300a4
08030090: lsls     r4, r0, #2
08030092: movs     r4, #0
08030094: push     {r4, r5, r6, lr}
08030096: movs     r1, #0x82
08030098: mov      r6, r0
0803009a: ldr      r0, [pc, #0x3c]
0803009c: bl       #0x802f8cc
080300a0: movs     r1, #1
080300a2: mov      r5, r0
080300a4: ldr      r0, [pc, #0x30]
080300a6: bl       #0x802f8cc
080300aa: movs     r1, #0x81
080300ac: mov      r4, r0
080300ae: ldr      r0, [pc, #0x28]
080300b0: bl       #0x802f8cc
080300b4: cbz      r5, #0x80300ba
080300b6: movs     r2, #0x10
080300b8: strb     r2, [r5, #6]
080300ba: cbz      r4, #0x80300c4
080300bc: movs     r1, #0
080300be: movs     r2, #0x40
080300c0: strb     r1, [r4, #5]
080300c2: strb     r2, [r4, #4]
080300c4: cbz      r0, #0x80300ce
080300c6: movs     r1, #0
080300c8: movs     r2, #0x40
080300ca: strb     r1, [r0, #5]
080300cc: strb     r2, [r0, #4]
080300ce: movs     r3, #0x43
080300d0: ldr      r0, [pc, #4]
080300d2: strh     r3, [r6]
080300d4: pop      {r4, r5, r6, pc}
080300d6: nop      
CONTEXT 0x80300ae
0803009a: ldr      r0, [pc, #0x3c]
0803009c: bl       #0x802f8cc
080300a0: movs     r1, #1
080300a2: mov      r5, r0
080300a4: ldr      r0, [pc, #0x30]
080300a6: bl       #0x802f8cc
080300aa: movs     r1, #0x81
080300ac: mov      r4, r0
080300ae: ldr      r0, [pc, #0x28]
080300b0: bl       #0x802f8cc
080300b4: cbz      r5, #0x80300ba
080300b6: movs     r2, #0x10
080300b8: strb     r2, [r5, #6]
080300ba: cbz      r4, #0x80300c4
080300bc: movs     r1, #0
080300be: movs     r2, #0x40
080300c0: strb     r1, [r4, #5]
080300c2: strb     r2, [r4, #4]
080300c4: cbz      r0, #0x80300ce
080300c6: movs     r1, #0
080300c8: movs     r2, #0x40
080300ca: strb     r1, [r0, #5]
080300cc: strb     r2, [r0, #4]
080300ce: movs     r3, #0x43
080300d0: ldr      r0, [pc, #4]
080300d2: strh     r3, [r6]
080300d4: pop      {r4, r5, r6, pc}
080300d6: nop      
080300d8: movs     r0, r1
080300da: movs     r4, #0
080300dc: b.w      #0x8030094
080300e0: push     {r4, r5, r6, lr}
CONTEXT 0x80300d0
080300bc: movs     r1, #0
080300be: movs     r2, #0x40
080300c0: strb     r1, [r4, #5]
080300c2: strb     r2, [r4, #4]
080300c4: cbz      r0, #0x80300ce
080300c6: movs     r1, #0
080300c8: movs     r2, #0x40
080300ca: strb     r1, [r0, #5]
080300cc: strb     r2, [r0, #4]
080300ce: movs     r3, #0x43
080300d0: ldr      r0, [pc, #4]
080300d2: strh     r3, [r6]
080300d4: pop      {r4, r5, r6, pc}
080300d6: nop      
080300d8: movs     r0, r1
080300da: movs     r4, #0
080300dc: b.w      #0x8030094
080300e0: push     {r4, r5, r6, lr}
080300e2: movs     r1, #0x82
080300e4: mov      r6, r0
080300e6: ldr      r0, [pc, #0x3c]
080300e8: bl       #0x802f8cc
080300ec: movs     r1, #1
080300ee: mov      r5, r0
080300f0: ldr      r0, [pc, #0x30]
080300f2: bl       #0x802f8cc
080300f6: movs     r1, #0x81
080300f8: mov      r4, r0
080300fa: ldr      r0, [pc, #0x28]
080300fc: bl       #0x802f8cc
08030100: cbz      r5, #0x8030106
08030102: movs     r2, #0x10
CONTEXT 0x80300e6
080300d2: strh     r3, [r6]
080300d4: pop      {r4, r5, r6, pc}
080300d6: nop      
080300d8: movs     r0, r1
080300da: movs     r4, #0
080300dc: b.w      #0x8030094
080300e0: push     {r4, r5, r6, lr}
080300e2: movs     r1, #0x82
080300e4: mov      r6, r0
080300e6: ldr      r0, [pc, #0x3c]
080300e8: bl       #0x802f8cc
080300ec: movs     r1, #1
080300ee: mov      r5, r0
080300f0: ldr      r0, [pc, #0x30]
080300f2: bl       #0x802f8cc
080300f6: movs     r1, #0x81
080300f8: mov      r4, r0
080300fa: ldr      r0, [pc, #0x28]
080300fc: bl       #0x802f8cc
08030100: cbz      r5, #0x8030106
08030102: movs     r2, #0x10
08030104: strb     r2, [r5, #6]
08030106: cbz      r4, #0x8030110
08030108: movs     r1, #0
0803010a: movs     r2, #2
0803010c: strb     r1, [r4, #4]
0803010e: strb     r2, [r4, #5]
08030110: cbz      r0, #0x803011a
08030112: movs     r1, #0
08030114: movs     r2, #2
08030116: strb     r1, [r0, #4]
08030118: strb     r2, [r0, #5]
CONTEXT 0x80300f0
080300dc: b.w      #0x8030094
080300e0: push     {r4, r5, r6, lr}
080300e2: movs     r1, #0x82
080300e4: mov      r6, r0
080300e6: ldr      r0, [pc, #0x3c]
080300e8: bl       #0x802f8cc
080300ec: movs     r1, #1
080300ee: mov      r5, r0
080300f0: ldr      r0, [pc, #0x30]
080300f2: bl       #0x802f8cc
080300f6: movs     r1, #0x81
080300f8: mov      r4, r0
080300fa: ldr      r0, [pc, #0x28]
080300fc: bl       #0x802f8cc
08030100: cbz      r5, #0x8030106
08030102: movs     r2, #0x10
08030104: strb     r2, [r5, #6]
08030106: cbz      r4, #0x8030110
08030108: movs     r1, #0
0803010a: movs     r2, #2
0803010c: strb     r1, [r4, #4]
0803010e: strb     r2, [r4, #5]
08030110: cbz      r0, #0x803011a
08030112: movs     r1, #0
08030114: movs     r2, #2
08030116: strb     r1, [r0, #4]
08030118: strb     r2, [r0, #5]
0803011a: movs     r3, #0x43
0803011c: ldr      r0, [pc, #4]
0803011e: strh     r3, [r6]
08030120: pop      {r4, r5, r6, pc}
08030122: nop      
CONTEXT 0x80300fa
080300e6: ldr      r0, [pc, #0x3c]
080300e8: bl       #0x802f8cc
080300ec: movs     r1, #1
080300ee: mov      r5, r0
080300f0: ldr      r0, [pc, #0x30]
080300f2: bl       #0x802f8cc
080300f6: movs     r1, #0x81
080300f8: mov      r4, r0
080300fa: ldr      r0, [pc, #0x28]
080300fc: bl       #0x802f8cc
08030100: cbz      r5, #0x8030106
08030102: movs     r2, #0x10
08030104: strb     r2, [r5, #6]
08030106: cbz      r4, #0x8030110
08030108: movs     r1, #0
0803010a: movs     r2, #2
0803010c: strb     r1, [r4, #4]
0803010e: strb     r2, [r4, #5]
08030110: cbz      r0, #0x803011a
08030112: movs     r1, #0
08030114: movs     r2, #2
08030116: strb     r1, [r0, #4]
08030118: strb     r2, [r0, #5]
0803011a: movs     r3, #0x43
0803011c: ldr      r0, [pc, #4]
0803011e: strh     r3, [r6]
08030120: pop      {r4, r5, r6, pc}
08030122: nop      
08030124: movs     r0, r1
08030126: movs     r4, #0
08030128: push     {r3, r4, r5, lr}
0803012a: ldr.w    r3, [r0, #0x2d4]
CONTEXT 0x803011c
08030108: movs     r1, #0
0803010a: movs     r2, #2
0803010c: strb     r1, [r4, #4]
0803010e: strb     r2, [r4, #5]
08030110: cbz      r0, #0x803011a
08030112: movs     r1, #0
08030114: movs     r2, #2
08030116: strb     r1, [r0, #4]
08030118: strb     r2, [r0, #5]
0803011a: movs     r3, #0x43
0803011c: ldr      r0, [pc, #4]
0803011e: strh     r3, [r6]
08030120: pop      {r4, r5, r6, pc}
08030122: nop      
08030124: movs     r0, r1
08030126: movs     r4, #0
08030128: push     {r3, r4, r5, lr}
0803012a: ldr.w    r3, [r0, #0x2d4]
0803012e: adds     r3, #0xb0
08030130: ldr.w    r5, [r0, r3, lsl #2]
08030134: cbz      r5, #0x803015e
08030136: mov      r4, r0
08030138: bl       #0x802f484
0803013c: mov      r3, r0
0803013e: add.w    r1, r5, #0x20c
08030142: ldr.w    r0, [r5, #0x204]
08030146: str.w    r3, [r5, #0x20c]
0803014a: ldr.w    r3, [r4, #0x2d4]
0803014e: .byte    0x04, 0xeb
