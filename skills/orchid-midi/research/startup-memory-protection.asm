0803f80c: push     {r4, r5, r6, lr}
0803f80e: ldr      r5, [pc, #0x21c]
0803f810: movs     r4, #0
0803f812: sub      sp, #0x78
0803f814: strb     r4, [r5]
0803f816: bl       #0x802709c
0803f81a: ldr      r1, [pc, #0x214]
0803f81c: mov.w    r3, #0x7000000
0803f820: ldr      r2, [pc, #0x210]
0803f822: str      r1, [r2, #8]
0803f824: vmsr     fpscr, r3
0803f828: movs     r2, #0x4c
0803f82a: mov      r1, r4
0803f82c: add      r0, sp, #0x28
0803f82e: bl       #0x8048f2a
0803f832: movs     r2, #0x20
0803f834: mov      r1, r4
0803f836: add      r0, sp, #8
0803f838: bl       #0x8048f2a
0803f83c: movs     r0, #2
0803f83e: bl       #0x802d760
0803f842: ldr      r2, [pc, #0x1f4]
0803f844: str      r4, [sp, #4]
0803f846: ldr      r3, [r2, #0x18]
0803f848: bic      r3, r3, #0xc000
0803f84c: str      r3, [r2, #0x18]
0803f84e: ldr      r3, [r2, #0x18]
0803f850: and      r3, r3, #0xc000
0803f854: str      r3, [sp, #4]
0803f856: ldr      r3, [sp, #4]
0803f858: ldr      r3, [r2, #0x18]
0803f85a: lsls     r6, r3, #0x12
0803f85c: bpl      #0x803f858
0803f85e: movs     r2, #0x21
0803f860: mov.w    r3, #0x10000
0803f864: movs     r1, #1
0803f866: add      r0, sp, #0x28
0803f868: strd     r2, r3, [sp, #0x28]
0803f86c: movs     r2, #2
0803f86e: movs     r3, #4
0803f870: str      r1, [sp, #0x40]
0803f872: str      r2, [sp, #0x4c]
0803f874: str      r2, [sp, #0x50]
0803f876: str      r2, [sp, #0x64]
0803f878: movs     r2, #0
0803f87a: str      r3, [sp, #0x54]
0803f87c: str      r3, [sp, #0x60]
0803f87e: str      r1, [sp, #0x5c]
0803f880: str      r2, [sp, #0x70]
0803f882: strd     r3, r2, [sp, #0x68]
0803f886: movs     r3, #0x58
0803f888: str      r3, [sp, #0x58]
0803f88a: bl       #0x8027228
0803f88e: cbz      r0, #0x803f892
0803f890: bkpt     #0
0803f892: movs     r3, #0x40
0803f894: movs     r4, #0
0803f896: movs     r1, #3
0803f898: movs     r2, #0x3f
0803f89a: str      r3, [sp, #0x24]
0803f89c: add      r0, sp, #8
0803f89e: strd     r3, r3, [sp, #0x18]
0803f8a2: movs     r3, #8
0803f8a4: strd     r4, r3, [sp, #0x10]
0803f8a8: mov.w    r3, #0x500
0803f8ac: strd     r2, r1, [sp, #8]
0803f8b0: str      r3, [sp, #0x20]
0803f8b2: bl       #0x80277b4
0803f8b6: cbz      r0, #0x803f8ba
0803f8b8: bkpt     #0
0803f8ba: movs     r1, #3
0803f8bc: add      r0, sp, #8
0803f8be: bl       #0x80277b4
0803f8c2: cbz      r0, #0x803f8c6
0803f8c4: bkpt     #0
0803f8c6: ldr      r2, [pc, #0x16c]
0803f8c8: ldr      r1, [pc, #0x170]
0803f8ca: ldr.w    r3, [r2, #0xfc]
0803f8ce: ldr.w    r0, [r1, #0xfb4]
0803f8d2: orr      r3, r3, #0x1000000
0803f8d6: lsls     r0, r0, #0x1f
0803f8d8: str.w    r3, [r2, #0xfc]
0803f8dc: bpl      #0x803f8e4
0803f8de: ldr      r3, [pc, #0x160]
0803f8e0: str.w    r3, [r1, #0xfb0]
0803f8e4: ldr      r2, [pc, #0x154]
0803f8e6: ldr      r3, [r2]
0803f8e8: orr      r3, r3, #1
0803f8ec: str      r3, [r2]
0803f8ee: bl       #0x80435a4
0803f8f2: bl       #0x8043720
0803f8f6: bl       #0x8043710
0803f8fa: clz      r0, r0
0803f8fe: ldr      r3, [pc, #0x144]
0803f900: mov.w    r1, #0x4b0
0803f904: ldr      r2, [pc, #0x140]
0803f906: lsrs     r0, r0, #5
0803f908: str      r1, [r2]
0803f90a: strb     r0, [r3]
0803f90c: bl       #0x804390c
0803f910: bl       #0x803fb4c
0803f914: bl       #0x803f804
0803f918: mov      r4, r0
0803f91a: bl       #0x8045230
0803f91e: bl       #0x80439d0
0803f922: ldr      r0, [pc, #0x128]
0803f924: bl       #0x803083c
0803f928: ldr      r0, [pc, #0x124]
0803f92a: bl       #0x803165c
0803f92e: movs     r1, #0
0803f930: ldr      r0, [pc, #0x120]
0803f932: bl       #0x80386ac
0803f936: ldr      r2, [pc, #0xfc]
0803f938: ldr      r3, [r2, #0x14]
0803f93a: ands     r3, r3, #0x20000
0803f93e: bne      #0x803f964
0803f940: dsb      sy
0803f944: isb      sy
0803f948: str.w    r3, [r2, #0x250]
0803f94c: dsb      sy
0803f950: isb      sy
0803f954: ldr      r3, [r2, #0x14]
0803f956: orr      r3, r3, #0x20000
0803f95a: str      r3, [r2, #0x14]
0803f95c: dsb      sy
0803f960: isb      sy
0803f964: ldr      r0, [pc, #0xcc]
0803f966: ldr      r3, [r0, #0x14]
0803f968: ands     r3, r3, #0x10000
0803f96c: bne      #0x803f9bc
0803f96e: str.w    r3, [r0, #0x84]
0803f972: dsb      sy
0803f976: ldr.w    r3, [r0, #0x80]
0803f97a: movw     lr, #0x3fe0
0803f97e: ubfx     r6, r3, #3, #0xa
0803f982: ubfx     r3, r3, #0xd, #0xf
0803f986: lsl.w    ip, r3, #5
0803f98a: and.w    r1, ip, lr
0803f98e: mov      r3, r6
0803f990: orr.w    r2, r1, r3, lsl #30
0803f994: subs     r3, #1
0803f996: str.w    r2, [r0, #0x260]
0803f99a: adds     r2, r3, #1
0803f99c: bne      #0x803f990
0803f99e: sub.w    ip, ip, #0x20
0803f9a2: cmn.w    ip, #0x20
0803f9a6: bne      #0x803f98a
0803f9a8: dsb      sy
0803f9ac: ldr      r3, [r0, #0x14]
0803f9ae: orr      r3, r3, #0x10000
0803f9b2: str      r3, [r0, #0x14]
0803f9b4: dsb      sy
0803f9b8: isb      sy
0803f9bc: bl       #0x803f7c8
0803f9c0: movs     r0, #0
0803f9c2: bl       #0x802ee14
0803f9c6: bl       #0x8041e80
0803f9ca: bl       #0x8047030
0803f9ce: ldr      r0, [pc, #0x88]
0803f9d0: bl       #0x8041860
0803f9d4: bl       #0x8043c18
0803f9d8: bl       #0x8041bcc
0803f9dc: bl       #0x8043e2c
0803f9e0: movs     r1, #0
0803f9e2: ldr      r0, [pc, #0x70]
0803f9e4: bl       #0x80386ac
0803f9e8: ldr      r0, [pc, #0x70]
0803f9ea: bl       #0x803b240
0803f9ee: movs     r1, #0
0803f9f0: ldr      r0, [pc, #0x6c]
0803f9f2: bl       #0x803182c
0803f9f6: movs     r1, #1
0803f9f8: ldr      r0, [pc, #0x58]
0803f9fa: bl       #0x80386ac
0803f9fe: cmp      r4, #0
