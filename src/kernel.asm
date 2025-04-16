
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
80100000:	55                   	push   %ebp
80100001:	89 e5                	mov    %esp,%ebp
80100003:	57                   	push   %edi
80100004:	89 d7                	mov    %edx,%edi
80100006:	56                   	push   %esi
80100007:	89 c6                	mov    %eax,%esi
80100009:	53                   	push   %ebx
8010000a:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
8010000d:	68 20 b5 10 80       	push   $0x8010b520
80100012:	e8 b9 4a 00 00       	call   80104ad0 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100017:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
8010001d:	83 c4 10             	add    $0x10,%esp
80100020:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100026:	75 13                	jne    8010003b <bget+0x3b>
80100028:	eb 26                	jmp    80100050 <bget+0x50>
8010002a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100030:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100033:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100039:	74 15                	je     80100050 <bget+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010003b:	39 73 04             	cmp    %esi,0x4(%ebx)
8010003e:	75 f0                	jne    80100030 <bget+0x30>
80100040:	39 7b 08             	cmp    %edi,0x8(%ebx)
80100043:	75 eb                	jne    80100030 <bget+0x30>
      b->refcnt++;
80100045:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100049:	eb 3f                	jmp    8010008a <bget+0x8a>
8010004b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100050:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100056:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010005c:	75 0d                	jne    8010006b <bget+0x6b>
8010005e:	eb 4f                	jmp    801000af <bget+0xaf>
80100060:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100063:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100069:	74 44                	je     801000af <bget+0xaf>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010006b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010006e:	85 c0                	test   %eax,%eax
80100070:	75 ee                	jne    80100060 <bget+0x60>
80100072:	f6 03 04             	testb  $0x4,(%ebx)
80100075:	75 e9                	jne    80100060 <bget+0x60>
      b->dev = dev;
80100077:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010007a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010007d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100083:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010008a:	83 ec 0c             	sub    $0xc,%esp
8010008d:	68 20 b5 10 80       	push   $0x8010b520
80100092:	e8 b9 4b 00 00       	call   80104c50 <release>
      acquiresleep(&b->lock);
80100097:	8d 43 0c             	lea    0xc(%ebx),%eax
8010009a:	89 04 24             	mov    %eax,(%esp)
8010009d:	e8 0e 48 00 00       	call   801048b0 <acquiresleep>
      return b;
801000a2:	83 c4 10             	add    $0x10,%esp
    }
  }
  panic("bget: no buffers");
}
801000a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801000a8:	89 d8                	mov    %ebx,%eax
801000aa:	5b                   	pop    %ebx
801000ab:	5e                   	pop    %esi
801000ac:	5f                   	pop    %edi
801000ad:	5d                   	pop    %ebp
801000ae:	c3                   	ret
  panic("bget: no buffers");
801000af:	83 ec 0c             	sub    $0xc,%esp
801000b2:	68 60 80 10 80       	push   $0x80108060
801000b7:	e8 f4 03 00 00       	call   801004b0 <panic>
801000bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801000c0 <binit>:
{
801000c0:	55                   	push   %ebp
801000c1:	89 e5                	mov    %esp,%ebp
801000c3:	53                   	push   %ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000c4:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
801000c9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
801000cc:	68 71 80 10 80       	push   $0x80108071
801000d1:	68 20 b5 10 80       	push   $0x8010b520
801000d6:	e8 a5 48 00 00       	call   80104980 <initlock>
  bcache.head.next = &bcache.head;
801000db:	83 c4 10             	add    $0x10,%esp
801000de:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
801000e3:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
801000ea:	fc 10 80 
  bcache.head.next = &bcache.head;
801000ed:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
801000f4:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000f7:	eb 09                	jmp    80100102 <binit+0x42>
801000f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100100:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100102:	89 43 54             	mov    %eax,0x54(%ebx)
    initsleeplock(&b->lock, "buffer");
80100105:	83 ec 08             	sub    $0x8,%esp
80100108:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010010b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100112:	68 78 80 10 80       	push   $0x80108078
80100117:	50                   	push   %eax
80100118:	e8 53 47 00 00       	call   80104870 <initsleeplock>
    bcache.head.next->prev = b;
8010011d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100122:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
80100128:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
8010012b:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010012e:	89 d8                	mov    %ebx,%eax
80100130:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100136:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
8010013c:	75 c2                	jne    80100100 <binit+0x40>
}
8010013e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100141:	c9                   	leave
80100142:	c3                   	ret
80100143:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010014a:	00 
8010014b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100150 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
80100150:	55                   	push   %ebp
80100151:	89 e5                	mov    %esp,%ebp
80100153:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
80100156:	8b 55 0c             	mov    0xc(%ebp),%edx
80100159:	8b 45 08             	mov    0x8(%ebp),%eax
8010015c:	e8 9f fe ff ff       	call   80100000 <bget>
  if((b->flags & B_VALID) == 0) {
80100161:	f6 00 02             	testb  $0x2,(%eax)
80100164:	74 0a                	je     80100170 <bread+0x20>
    iderw(b);
  }
  return b;
}
80100166:	c9                   	leave
80100167:	c3                   	ret
80100168:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010016f:	00 
    iderw(b);
80100170:	83 ec 0c             	sub    $0xc,%esp
80100173:	50                   	push   %eax
80100174:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100177:	e8 e4 25 00 00       	call   80102760 <iderw>
8010017c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017f:	83 c4 10             	add    $0x10,%esp
}
80100182:	c9                   	leave
80100183:	c3                   	ret
80100184:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010018b:	00 
8010018c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100190 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100190:	55                   	push   %ebp
80100191:	89 e5                	mov    %esp,%ebp
80100193:	53                   	push   %ebx
80100194:	83 ec 10             	sub    $0x10,%esp
80100197:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
8010019a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010019d:	50                   	push   %eax
8010019e:	e8 ad 47 00 00       	call   80104950 <holdingsleep>
801001a3:	83 c4 10             	add    $0x10,%esp
801001a6:	85 c0                	test   %eax,%eax
801001a8:	74 0f                	je     801001b9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001aa:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001ad:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001b3:	c9                   	leave
  iderw(b);
801001b4:	e9 a7 25 00 00       	jmp    80102760 <iderw>
    panic("bwrite");
801001b9:	83 ec 0c             	sub    $0xc,%esp
801001bc:	68 7f 80 10 80       	push   $0x8010807f
801001c1:	e8 ea 02 00 00       	call   801004b0 <panic>
801001c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001cd:	00 
801001ce:	66 90                	xchg   %ax,%ax

801001d0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001d0:	55                   	push   %ebp
801001d1:	89 e5                	mov    %esp,%ebp
801001d3:	56                   	push   %esi
801001d4:	53                   	push   %ebx
801001d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001d8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001db:	83 ec 0c             	sub    $0xc,%esp
801001de:	56                   	push   %esi
801001df:	e8 6c 47 00 00       	call   80104950 <holdingsleep>
801001e4:	83 c4 10             	add    $0x10,%esp
801001e7:	85 c0                	test   %eax,%eax
801001e9:	74 63                	je     8010024e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
801001eb:	83 ec 0c             	sub    $0xc,%esp
801001ee:	56                   	push   %esi
801001ef:	e8 1c 47 00 00       	call   80104910 <releasesleep>

  acquire(&bcache.lock);
801001f4:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
801001fb:	e8 d0 48 00 00       	call   80104ad0 <acquire>
  b->refcnt--;
80100200:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100203:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100206:	83 e8 01             	sub    $0x1,%eax
80100209:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010020c:	85 c0                	test   %eax,%eax
8010020e:	75 2c                	jne    8010023c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100210:	8b 53 54             	mov    0x54(%ebx),%edx
80100213:	8b 43 50             	mov    0x50(%ebx),%eax
80100216:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100219:	8b 53 54             	mov    0x54(%ebx),%edx
8010021c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010021f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100224:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010022b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010022e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100233:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100236:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }

  release(&bcache.lock);
8010023c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100243:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100246:	5b                   	pop    %ebx
80100247:	5e                   	pop    %esi
80100248:	5d                   	pop    %ebp
  release(&bcache.lock);
80100249:	e9 02 4a 00 00       	jmp    80104c50 <release>
    panic("brelse");
8010024e:	83 ec 0c             	sub    $0xc,%esp
80100251:	68 86 80 10 80       	push   $0x80108086
80100256:	e8 55 02 00 00       	call   801004b0 <panic>
8010025b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100260 <write_page_to_disk>:
{
80100260:	55                   	push   %ebp
80100261:	89 e5                	mov    %esp,%ebp
80100263:	57                   	push   %edi
80100264:	56                   	push   %esi
80100265:	53                   	push   %ebx
80100266:	83 ec 1c             	sub    $0x1c,%esp
80100269:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010026c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010026f:	8d 43 08             	lea    0x8(%ebx),%eax
80100272:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100275:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010027c:	00 
8010027d:	8d 76 00             	lea    0x0(%esi),%esi
    buffer=bget(ROOTDEV,blockno);
80100280:	89 da                	mov    %ebx,%edx
80100282:	b8 01 00 00 00       	mov    $0x1,%eax
80100287:	e8 74 fd ff ff       	call   80100000 <bget>
    memmove(buffer->data,pg+ithPartOfPage,512);   // write 512 bytes to the block
8010028c:	83 ec 04             	sub    $0x4,%esp
    buffer=bget(ROOTDEV,blockno);
8010028f:	89 c7                	mov    %eax,%edi
    memmove(buffer->data,pg+ithPartOfPage,512);   // write 512 bytes to the block
80100291:	8d 40 5c             	lea    0x5c(%eax),%eax
80100294:	68 00 02 00 00       	push   $0x200
80100299:	56                   	push   %esi
8010029a:	50                   	push   %eax
8010029b:	e8 90 4a 00 00       	call   80104d30 <memmove>
  if(!holdingsleep(&b->lock))
801002a0:	8d 47 0c             	lea    0xc(%edi),%eax
801002a3:	89 04 24             	mov    %eax,(%esp)
801002a6:	e8 a5 46 00 00       	call   80104950 <holdingsleep>
801002ab:	83 c4 10             	add    $0x10,%esp
801002ae:	85 c0                	test   %eax,%eax
801002b0:	74 2f                	je     801002e1 <write_page_to_disk+0x81>
  iderw(b);
801002b2:	83 ec 0c             	sub    $0xc,%esp
  b->flags |= B_DIRTY;
801002b5:	83 0f 04             	orl    $0x4,(%edi)
  for(int i=0;i<8;i++){
801002b8:	83 c3 01             	add    $0x1,%ebx
801002bb:	81 c6 00 02 00 00    	add    $0x200,%esi
  iderw(b);
801002c1:	57                   	push   %edi
801002c2:	e8 99 24 00 00       	call   80102760 <iderw>
    brelse(buffer);                               //release lock
801002c7:	89 3c 24             	mov    %edi,(%esp)
801002ca:	e8 01 ff ff ff       	call   801001d0 <brelse>
  for(int i=0;i<8;i++){
801002cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801002d2:	83 c4 10             	add    $0x10,%esp
801002d5:	39 c3                	cmp    %eax,%ebx
801002d7:	75 a7                	jne    80100280 <write_page_to_disk+0x20>
}
801002d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002dc:	5b                   	pop    %ebx
801002dd:	5e                   	pop    %esi
801002de:	5f                   	pop    %edi
801002df:	5d                   	pop    %ebp
801002e0:	c3                   	ret
    panic("bwrite");
801002e1:	83 ec 0c             	sub    $0xc,%esp
801002e4:	68 7f 80 10 80       	push   $0x8010807f
801002e9:	e8 c2 01 00 00       	call   801004b0 <panic>
801002ee:	66 90                	xchg   %ax,%ax

801002f0 <read_page_from_disk>:
{
801002f0:	55                   	push   %ebp
801002f1:	89 e5                	mov    %esp,%ebp
801002f3:	57                   	push   %edi
801002f4:	56                   	push   %esi
801002f5:	53                   	push   %ebx
801002f6:	83 ec 1c             	sub    $0x1c,%esp
801002f9:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002fc:	8b 75 0c             	mov    0xc(%ebp),%esi
801002ff:	8d 43 08             	lea    0x8(%ebx),%eax
80100302:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100305:	eb 36                	jmp    8010033d <read_page_from_disk+0x4d>
80100307:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010030e:	00 
8010030f:	90                   	nop
    memmove(pg+ithPartOfPage, buffer->data,512);  //write to pg from buffer
80100310:	83 ec 04             	sub    $0x4,%esp
80100313:	8d 47 5c             	lea    0x5c(%edi),%eax
  for(int i=0;i<8;i++){
80100316:	83 c3 01             	add    $0x1,%ebx
    memmove(pg+ithPartOfPage, buffer->data,512);  //write to pg from buffer
80100319:	68 00 02 00 00       	push   $0x200
8010031e:	50                   	push   %eax
8010031f:	56                   	push   %esi
  for(int i=0;i<8;i++){
80100320:	81 c6 00 02 00 00    	add    $0x200,%esi
    memmove(pg+ithPartOfPage, buffer->data,512);  //write to pg from buffer
80100326:	e8 05 4a 00 00       	call   80104d30 <memmove>
    brelse(buffer);                   //release lock
8010032b:	89 3c 24             	mov    %edi,(%esp)
8010032e:	e8 9d fe ff ff       	call   801001d0 <brelse>
  for(int i=0;i<8;i++){
80100333:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100336:	83 c4 10             	add    $0x10,%esp
80100339:	39 c3                	cmp    %eax,%ebx
8010033b:	74 23                	je     80100360 <read_page_from_disk+0x70>
  b = bget(dev, blockno);
8010033d:	89 da                	mov    %ebx,%edx
8010033f:	b8 01 00 00 00       	mov    $0x1,%eax
80100344:	e8 b7 fc ff ff       	call   80100000 <bget>
80100349:	89 c7                	mov    %eax,%edi
  if((b->flags & B_VALID) == 0) {
8010034b:	f6 00 02             	testb  $0x2,(%eax)
8010034e:	75 c0                	jne    80100310 <read_page_from_disk+0x20>
    iderw(b);
80100350:	83 ec 0c             	sub    $0xc,%esp
80100353:	50                   	push   %eax
80100354:	e8 07 24 00 00       	call   80102760 <iderw>
80100359:	83 c4 10             	add    $0x10,%esp
8010035c:	eb b2                	jmp    80100310 <read_page_from_disk+0x20>
8010035e:	66 90                	xchg   %ax,%ax
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret
80100368:	66 90                	xchg   %ax,%ax
8010036a:	66 90                	xchg   %ax,%ax
8010036c:	66 90                	xchg   %ax,%ax
8010036e:	66 90                	xchg   %ax,%ax
80100370:	66 90                	xchg   %ax,%ax
80100372:	66 90                	xchg   %ax,%ax
80100374:	66 90                	xchg   %ax,%ax
80100376:	66 90                	xchg   %ax,%ax
80100378:	66 90                	xchg   %ax,%ax
8010037a:	66 90                	xchg   %ax,%ax
8010037c:	66 90                	xchg   %ax,%ax
8010037e:	66 90                	xchg   %ax,%ax

80100380 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	57                   	push   %edi
80100384:	56                   	push   %esi
80100385:	53                   	push   %ebx
80100386:	83 ec 18             	sub    $0x18,%esp
80100389:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010038c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010038f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100392:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100394:	e8 37 19 00 00       	call   80101cd0 <iunlock>
  acquire(&cons.lock);
80100399:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801003a0:	e8 2b 47 00 00       	call   80104ad0 <acquire>
  while(n > 0){
801003a5:	83 c4 10             	add    $0x10,%esp
801003a8:	85 db                	test   %ebx,%ebx
801003aa:	0f 8e 94 00 00 00    	jle    80100444 <consoleread+0xc4>
    while(input.r == input.w){
801003b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801003b5:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
801003bb:	74 25                	je     801003e2 <consoleread+0x62>
801003bd:	eb 59                	jmp    80100418 <consoleread+0x98>
801003bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801003c0:	83 ec 08             	sub    $0x8,%esp
801003c3:	68 20 ff 10 80       	push   $0x8010ff20
801003c8:	68 00 ff 10 80       	push   $0x8010ff00
801003cd:	e8 2e 42 00 00       	call   80104600 <sleep>
    while(input.r == input.w){
801003d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801003d7:	83 c4 10             	add    $0x10,%esp
801003da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801003e0:	75 36                	jne    80100418 <consoleread+0x98>
      if(myproc()->killed){
801003e2:	e8 59 3b 00 00       	call   80103f40 <myproc>
801003e7:	8b 48 24             	mov    0x24(%eax),%ecx
801003ea:	85 c9                	test   %ecx,%ecx
801003ec:	74 d2                	je     801003c0 <consoleread+0x40>
        release(&cons.lock);
801003ee:	83 ec 0c             	sub    $0xc,%esp
801003f1:	68 20 ff 10 80       	push   $0x8010ff20
801003f6:	e8 55 48 00 00       	call   80104c50 <release>
        ilock(ip);
801003fb:	5a                   	pop    %edx
801003fc:	ff 75 08             	push   0x8(%ebp)
801003ff:	e8 ec 17 00 00       	call   80101bf0 <ilock>
        return -1;
80100404:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100407:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010040a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010040f:	5b                   	pop    %ebx
80100410:	5e                   	pop    %esi
80100411:	5f                   	pop    %edi
80100412:	5d                   	pop    %ebp
80100413:	c3                   	ret
80100414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100418:	8d 50 01             	lea    0x1(%eax),%edx
8010041b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100421:	89 c2                	mov    %eax,%edx
80100423:	83 e2 7f             	and    $0x7f,%edx
80100426:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010042d:	80 f9 04             	cmp    $0x4,%cl
80100430:	74 37                	je     80100469 <consoleread+0xe9>
    *dst++ = c;
80100432:	83 c6 01             	add    $0x1,%esi
    --n;
80100435:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100438:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010043b:	83 f9 0a             	cmp    $0xa,%ecx
8010043e:	0f 85 64 ff ff ff    	jne    801003a8 <consoleread+0x28>
  release(&cons.lock);
80100444:	83 ec 0c             	sub    $0xc,%esp
80100447:	68 20 ff 10 80       	push   $0x8010ff20
8010044c:	e8 ff 47 00 00       	call   80104c50 <release>
  ilock(ip);
80100451:	58                   	pop    %eax
80100452:	ff 75 08             	push   0x8(%ebp)
80100455:	e8 96 17 00 00       	call   80101bf0 <ilock>
  return target - n;
8010045a:	89 f8                	mov    %edi,%eax
8010045c:	83 c4 10             	add    $0x10,%esp
}
8010045f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100462:	29 d8                	sub    %ebx,%eax
}
80100464:	5b                   	pop    %ebx
80100465:	5e                   	pop    %esi
80100466:	5f                   	pop    %edi
80100467:	5d                   	pop    %ebp
80100468:	c3                   	ret
      if(n < target){
80100469:	39 fb                	cmp    %edi,%ebx
8010046b:	73 d7                	jae    80100444 <consoleread+0xc4>
        input.r--;
8010046d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100472:	eb d0                	jmp    80100444 <consoleread+0xc4>
80100474:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010047b:	00 
8010047c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100480 <console_echo>:
console_echo(int enable) {
80100480:	55                   	push   %ebp
80100481:	89 e5                	mov    %esp,%ebp
80100483:	53                   	push   %ebx
80100484:	83 ec 10             	sub    $0x10,%esp
80100487:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010048a:	68 20 ff 10 80       	push   $0x8010ff20
8010048f:	e8 3c 46 00 00       	call   80104ad0 <acquire>
  echo = enable;
80100494:	89 1d 00 90 10 80    	mov    %ebx,0x80109000
  release(&cons.lock);
8010049a:	83 c4 10             	add    $0x10,%esp
}
8010049d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&cons.lock);
801004a0:	c7 45 08 20 ff 10 80 	movl   $0x8010ff20,0x8(%ebp)
}
801004a7:	c9                   	leave
  release(&cons.lock);
801004a8:	e9 a3 47 00 00       	jmp    80104c50 <release>
801004ad:	8d 76 00             	lea    0x0(%esi),%esi

801004b0 <panic>:
{
801004b0:	55                   	push   %ebp
801004b1:	89 e5                	mov    %esp,%ebp
801004b3:	53                   	push   %ebx
801004b4:	83 ec 04             	sub    $0x4,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801004b7:	fa                   	cli
  cons.locking = 0;
801004b8:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
801004bf:	00 00 00 
  cprintf("panic: ", lapicid());
801004c2:	e8 19 29 00 00       	call   80102de0 <lapicid>
801004c7:	83 ec 08             	sub    $0x8,%esp
801004ca:	50                   	push   %eax
801004cb:	68 8d 80 10 80       	push   $0x8010808d
801004d0:	e8 1b 03 00 00       	call   801007f0 <cprintf>
  cprintf(s);
801004d5:	58                   	pop    %eax
801004d6:	ff 75 08             	push   0x8(%ebp)
801004d9:	e8 12 03 00 00       	call   801007f0 <cprintf>
  int ticks = sys_uptime();
801004de:	e8 1d 5b 00 00       	call   80106000 <sys_uptime>
  cprintf("uptime: %dm%ds\n", minutes, seconds);
801004e3:	83 c4 0c             	add    $0xc,%esp
  int ticks = sys_uptime();
801004e6:	89 c3                	mov    %eax,%ebx
  int total_seconds = ticks / 100;  // Convert ticks to seconds
801004e8:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
801004ed:	f7 eb                	imul   %ebx
801004ef:	c1 fb 1f             	sar    $0x1f,%ebx
  int seconds = total_seconds % 60;
801004f2:	b8 89 88 88 88       	mov    $0x88888889,%eax
  int total_seconds = ticks / 100;  // Convert ticks to seconds
801004f7:	c1 fa 05             	sar    $0x5,%edx
801004fa:	89 d1                	mov    %edx,%ecx
801004fc:	29 d9                	sub    %ebx,%ecx
  int seconds = total_seconds % 60;
801004fe:	f7 e9                	imul   %ecx
80100500:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80100503:	89 ca                	mov    %ecx,%edx
80100505:	c1 fa 1f             	sar    $0x1f,%edx
80100508:	c1 f8 05             	sar    $0x5,%eax
8010050b:	29 d0                	sub    %edx,%eax
8010050d:	6b d0 3c             	imul   $0x3c,%eax,%edx
80100510:	29 d1                	sub    %edx,%ecx
  cprintf("uptime: %dm%ds\n", minutes, seconds);
80100512:	51                   	push   %ecx
80100513:	50                   	push   %eax
80100514:	68 95 80 10 80       	push   $0x80108095
80100519:	e8 d2 02 00 00       	call   801007f0 <cprintf>
  panicked = 1; // freeze other CPU
8010051e:	83 c4 10             	add    $0x10,%esp
80100521:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
80100528:	00 00 00 
  for(;;);
8010052b:	eb fe                	jmp    8010052b <panic+0x7b>
8010052d:	8d 76 00             	lea    0x0(%esi),%esi

80100530 <consputc.part.0>:
consputc(int c)
80100530:	55                   	push   %ebp
80100531:	89 e5                	mov    %esp,%ebp
80100533:	57                   	push   %edi
80100534:	56                   	push   %esi
80100535:	53                   	push   %ebx
80100536:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
80100539:	3d 00 01 00 00       	cmp    $0x100,%eax
8010053e:	0f 84 cc 00 00 00    	je     80100610 <consputc.part.0+0xe0>
    uartputc(c);
80100544:	83 ec 0c             	sub    $0xc,%esp
80100547:	89 c3                	mov    %eax,%ebx
80100549:	50                   	push   %eax
8010054a:	e8 31 64 00 00       	call   80106980 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010054f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100554:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100559:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010055a:	be d5 03 00 00       	mov    $0x3d5,%esi
8010055f:	89 f2                	mov    %esi,%edx
80100561:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100562:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100565:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010056a:	b8 0f 00 00 00       	mov    $0xf,%eax
8010056f:	c1 e1 08             	shl    $0x8,%ecx
80100572:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100573:	89 f2                	mov    %esi,%edx
80100575:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100576:	0f b6 c0             	movzbl %al,%eax
  if(c == '\n')
80100579:	83 c4 10             	add    $0x10,%esp
  pos |= inb(CRTPORT+1);
8010057c:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010057e:	83 fb 0a             	cmp    $0xa,%ebx
80100581:	75 75                	jne    801005f8 <consputc.part.0+0xc8>
    pos += 80 - pos%80;
80100583:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
80100588:	f7 e2                	mul    %edx
8010058a:	c1 ea 06             	shr    $0x6,%edx
8010058d:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100590:	c1 e0 04             	shl    $0x4,%eax
80100593:	8d 70 50             	lea    0x50(%eax),%esi
  if(pos < 0 || pos > 25*80)
80100596:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
8010059c:	0f 8f 24 01 00 00    	jg     801006c6 <consputc.part.0+0x196>
  if((pos/80) >= 24){  // Scroll up.
801005a2:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
801005a8:	0f 8f c2 00 00 00    	jg     80100670 <consputc.part.0+0x140>
  outb(CRTPORT+1, pos>>8);
801005ae:	89 f0                	mov    %esi,%eax
  outb(CRTPORT+1, pos);
801005b0:	89 f1                	mov    %esi,%ecx
  crt[pos] = ' ' | 0x0700;
801005b2:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos>>8);
801005b9:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801005bc:	b8 0e 00 00 00       	mov    $0xe,%eax
801005c1:	ba d4 03 00 00       	mov    $0x3d4,%edx
801005c6:	ee                   	out    %al,(%dx)
801005c7:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801005cc:	89 f8                	mov    %edi,%eax
801005ce:	89 da                	mov    %ebx,%edx
801005d0:	ee                   	out    %al,(%dx)
801005d1:	b8 0f 00 00 00       	mov    $0xf,%eax
801005d6:	ba d4 03 00 00       	mov    $0x3d4,%edx
801005db:	ee                   	out    %al,(%dx)
801005dc:	89 c8                	mov    %ecx,%eax
801005de:	89 da                	mov    %ebx,%edx
801005e0:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801005e1:	b8 20 07 00 00       	mov    $0x720,%eax
801005e6:	66 89 06             	mov    %ax,(%esi)
}
801005e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005ec:	5b                   	pop    %ebx
801005ed:	5e                   	pop    %esi
801005ee:	5f                   	pop    %edi
801005ef:	5d                   	pop    %ebp
801005f0:	c3                   	ret
801005f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    crt[pos++] = (c&0xff) | colour;
801005f8:	0f b6 db             	movzbl %bl,%ebx
801005fb:	8d 70 01             	lea    0x1(%eax),%esi
801005fe:	80 cf 07             	or     $0x7,%bh
80100601:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100608:	80 
80100609:	eb 8b                	jmp    80100596 <consputc.part.0+0x66>
8010060b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100610:	83 ec 0c             	sub    $0xc,%esp
80100613:	6a 08                	push   $0x8
80100615:	e8 66 63 00 00       	call   80106980 <uartputc>
8010061a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100621:	e8 5a 63 00 00       	call   80106980 <uartputc>
80100626:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010062d:	e8 4e 63 00 00       	call   80106980 <uartputc>
80100632:	b8 0e 00 00 00       	mov    $0xe,%eax
80100637:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010063c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010063d:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100642:	89 da                	mov    %ebx,%edx
80100644:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100645:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100648:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010064d:	b8 0f 00 00 00       	mov    $0xf,%eax
80100652:	c1 e1 08             	shl    $0x8,%ecx
80100655:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100656:	89 da                	mov    %ebx,%edx
80100658:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100659:	0f b6 f0             	movzbl %al,%esi
    if(pos > 0) --pos;
8010065c:	83 c4 10             	add    $0x10,%esp
8010065f:	09 ce                	or     %ecx,%esi
80100661:	74 55                	je     801006b8 <consputc.part.0+0x188>
80100663:	83 ee 01             	sub    $0x1,%esi
80100666:	e9 2b ff ff ff       	jmp    80100596 <consputc.part.0+0x66>
8010066b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100670:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100673:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100676:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010067d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100682:	68 60 0e 00 00       	push   $0xe60
80100687:	68 a0 80 0b 80       	push   $0x800b80a0
8010068c:	68 00 80 0b 80       	push   $0x800b8000
80100691:	e8 9a 46 00 00       	call   80104d30 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100696:	b8 80 07 00 00       	mov    $0x780,%eax
8010069b:	83 c4 0c             	add    $0xc,%esp
8010069e:	29 d8                	sub    %ebx,%eax
801006a0:	01 c0                	add    %eax,%eax
801006a2:	50                   	push   %eax
801006a3:	6a 00                	push   $0x0
801006a5:	56                   	push   %esi
801006a6:	e8 f5 45 00 00       	call   80104ca0 <memset>
  outb(CRTPORT+1, pos);
801006ab:	89 d9                	mov    %ebx,%ecx
801006ad:	83 c4 10             	add    $0x10,%esp
801006b0:	e9 07 ff ff ff       	jmp    801005bc <consputc.part.0+0x8c>
801006b5:	8d 76 00             	lea    0x0(%esi),%esi
801006b8:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801006bd:	31 c9                	xor    %ecx,%ecx
801006bf:	31 ff                	xor    %edi,%edi
801006c1:	e9 f6 fe ff ff       	jmp    801005bc <consputc.part.0+0x8c>
    panic("pos under/overflow");
801006c6:	83 ec 0c             	sub    $0xc,%esp
801006c9:	68 a5 80 10 80       	push   $0x801080a5
801006ce:	e8 dd fd ff ff       	call   801004b0 <panic>
801006d3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801006da:	00 
801006db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801006e0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801006e0:	55                   	push   %ebp
801006e1:	89 e5                	mov    %esp,%ebp
801006e3:	57                   	push   %edi
801006e4:	56                   	push   %esi
801006e5:	53                   	push   %ebx
801006e6:	83 ec 18             	sub    $0x18,%esp
801006e9:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
801006ec:	ff 75 08             	push   0x8(%ebp)
801006ef:	e8 dc 15 00 00       	call   80101cd0 <iunlock>
  acquire(&cons.lock);
801006f4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801006fb:	e8 d0 43 00 00       	call   80104ad0 <acquire>
  for(i = 0; i < n; i++)
80100700:	83 c4 10             	add    $0x10,%esp
80100703:	85 f6                	test   %esi,%esi
80100705:	7e 28                	jle    8010072f <consolewrite+0x4f>
80100707:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010070a:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
8010070d:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100713:	85 d2                	test   %edx,%edx
80100715:	74 09                	je     80100720 <consolewrite+0x40>
  asm volatile("cli");
80100717:	fa                   	cli
    for(;;)
80100718:	eb fe                	jmp    80100718 <consolewrite+0x38>
8010071a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100720:	0f b6 03             	movzbl (%ebx),%eax
  for(i = 0; i < n; i++)
80100723:	83 c3 01             	add    $0x1,%ebx
80100726:	e8 05 fe ff ff       	call   80100530 <consputc.part.0>
8010072b:	39 fb                	cmp    %edi,%ebx
8010072d:	75 de                	jne    8010070d <consolewrite+0x2d>
  release(&cons.lock);
8010072f:	83 ec 0c             	sub    $0xc,%esp
80100732:	68 20 ff 10 80       	push   $0x8010ff20
80100737:	e8 14 45 00 00       	call   80104c50 <release>
  ilock(ip);
8010073c:	58                   	pop    %eax
8010073d:	ff 75 08             	push   0x8(%ebp)
80100740:	e8 ab 14 00 00       	call   80101bf0 <ilock>

  return n;
}
80100745:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100748:	89 f0                	mov    %esi,%eax
8010074a:	5b                   	pop    %ebx
8010074b:	5e                   	pop    %esi
8010074c:	5f                   	pop    %edi
8010074d:	5d                   	pop    %ebp
8010074e:	c3                   	ret
8010074f:	90                   	nop

80100750 <printint>:
{
80100750:	55                   	push   %ebp
80100751:	89 e5                	mov    %esp,%ebp
80100753:	57                   	push   %edi
80100754:	56                   	push   %esi
80100755:	53                   	push   %ebx
80100756:	89 d3                	mov    %edx,%ebx
80100758:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010075b:	85 c0                	test   %eax,%eax
8010075d:	79 05                	jns    80100764 <printint+0x14>
8010075f:	83 e1 01             	and    $0x1,%ecx
80100762:	75 6f                	jne    801007d3 <printint+0x83>
    x = xx;
80100764:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010076b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010076d:	31 f6                	xor    %esi,%esi
8010076f:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100776:	00 
80100777:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010077e:	00 
8010077f:	90                   	nop
    buf[i++] = digits[x % base];
80100780:	89 c8                	mov    %ecx,%eax
80100782:	31 d2                	xor    %edx,%edx
80100784:	89 f7                	mov    %esi,%edi
80100786:	f7 f3                	div    %ebx
80100788:	8d 76 01             	lea    0x1(%esi),%esi
8010078b:	0f b6 92 08 86 10 80 	movzbl -0x7fef79f8(%edx),%edx
80100792:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100796:	89 ca                	mov    %ecx,%edx
80100798:	89 c1                	mov    %eax,%ecx
8010079a:	39 da                	cmp    %ebx,%edx
8010079c:	73 e2                	jae    80100780 <printint+0x30>
  if(sign)
8010079e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801007a1:	85 d2                	test   %edx,%edx
801007a3:	74 07                	je     801007ac <printint+0x5c>
    buf[i++] = '-';
801007a5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
801007aa:	89 f7                	mov    %esi,%edi
  while(--i >= 0)
801007ac:	8d 5d d8             	lea    -0x28(%ebp),%ebx
801007af:	01 df                	add    %ebx,%edi
  if(panicked){
801007b1:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007b6:	85 c0                	test   %eax,%eax
801007b8:	74 06                	je     801007c0 <printint+0x70>
801007ba:	fa                   	cli
    for(;;)
801007bb:	eb fe                	jmp    801007bb <printint+0x6b>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i]);
801007c0:	0f be 07             	movsbl (%edi),%eax
801007c3:	e8 68 fd ff ff       	call   80100530 <consputc.part.0>
  while(--i >= 0)
801007c8:	8d 47 ff             	lea    -0x1(%edi),%eax
801007cb:	39 df                	cmp    %ebx,%edi
801007cd:	74 11                	je     801007e0 <printint+0x90>
801007cf:	89 c7                	mov    %eax,%edi
801007d1:	eb de                	jmp    801007b1 <printint+0x61>
    x = -xx;
801007d3:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
801007d5:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
801007dc:	89 c1                	mov    %eax,%ecx
801007de:	eb 8d                	jmp    8010076d <printint+0x1d>
}
801007e0:	83 c4 2c             	add    $0x2c,%esp
801007e3:	5b                   	pop    %ebx
801007e4:	5e                   	pop    %esi
801007e5:	5f                   	pop    %edi
801007e6:	5d                   	pop    %ebp
801007e7:	c3                   	ret
801007e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801007ef:	00 

801007f0 <cprintf>:
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
801007f6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801007f9:	8b 3d 54 ff 10 80    	mov    0x8010ff54,%edi
  if (fmt == 0)
801007ff:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100802:	85 ff                	test   %edi,%edi
80100804:	0f 85 06 01 00 00    	jne    80100910 <cprintf+0x120>
  if (fmt == 0)
8010080a:	85 f6                	test   %esi,%esi
8010080c:	0f 84 b7 01 00 00    	je     801009c9 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100812:	0f b6 06             	movzbl (%esi),%eax
80100815:	85 c0                	test   %eax,%eax
80100817:	74 5f                	je     80100878 <cprintf+0x88>
  argp = (uint*)(void*)(&fmt + 1);
80100819:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010081c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010081f:	31 db                	xor    %ebx,%ebx
80100821:	89 d7                	mov    %edx,%edi
    if(c != '%'){
80100823:	83 f8 25             	cmp    $0x25,%eax
80100826:	75 58                	jne    80100880 <cprintf+0x90>
    c = fmt[++i] & 0xff;
80100828:	83 c3 01             	add    $0x1,%ebx
8010082b:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
8010082f:	85 c9                	test   %ecx,%ecx
80100831:	74 3a                	je     8010086d <cprintf+0x7d>
    switch(c){
80100833:	83 f9 70             	cmp    $0x70,%ecx
80100836:	0f 84 b4 00 00 00    	je     801008f0 <cprintf+0x100>
8010083c:	7f 72                	jg     801008b0 <cprintf+0xc0>
8010083e:	83 f9 25             	cmp    $0x25,%ecx
80100841:	74 4d                	je     80100890 <cprintf+0xa0>
80100843:	83 f9 64             	cmp    $0x64,%ecx
80100846:	75 76                	jne    801008be <cprintf+0xce>
      printint(*argp++, 10, 1);
80100848:	8d 47 04             	lea    0x4(%edi),%eax
8010084b:	b9 01 00 00 00       	mov    $0x1,%ecx
80100850:	ba 0a 00 00 00       	mov    $0xa,%edx
80100855:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100858:	8b 07                	mov    (%edi),%eax
8010085a:	e8 f1 fe ff ff       	call   80100750 <printint>
8010085f:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100862:	83 c3 01             	add    $0x1,%ebx
80100865:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100869:	85 c0                	test   %eax,%eax
8010086b:	75 b6                	jne    80100823 <cprintf+0x33>
8010086d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
80100870:	85 ff                	test   %edi,%edi
80100872:	0f 85 bb 00 00 00    	jne    80100933 <cprintf+0x143>
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret
  if(panicked){
80100880:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100886:	85 c9                	test   %ecx,%ecx
80100888:	74 19                	je     801008a3 <cprintf+0xb3>
8010088a:	fa                   	cli
    for(;;)
8010088b:	eb fe                	jmp    8010088b <cprintf+0x9b>
8010088d:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
80100890:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
80100896:	85 c9                	test   %ecx,%ecx
80100898:	0f 85 f2 00 00 00    	jne    80100990 <cprintf+0x1a0>
8010089e:	b8 25 00 00 00       	mov    $0x25,%eax
801008a3:	e8 88 fc ff ff       	call   80100530 <consputc.part.0>
      break;
801008a8:	eb b8                	jmp    80100862 <cprintf+0x72>
801008aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
801008b0:	83 f9 73             	cmp    $0x73,%ecx
801008b3:	0f 84 8f 00 00 00    	je     80100948 <cprintf+0x158>
801008b9:	83 f9 78             	cmp    $0x78,%ecx
801008bc:	74 32                	je     801008f0 <cprintf+0x100>
  if(panicked){
801008be:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
801008c4:	85 d2                	test   %edx,%edx
801008c6:	0f 85 b8 00 00 00    	jne    80100984 <cprintf+0x194>
801008cc:	b8 25 00 00 00       	mov    $0x25,%eax
801008d1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801008d4:	e8 57 fc ff ff       	call   80100530 <consputc.part.0>
801008d9:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801008de:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801008e1:	85 c0                	test   %eax,%eax
801008e3:	0f 84 cd 00 00 00    	je     801009b6 <cprintf+0x1c6>
801008e9:	fa                   	cli
    for(;;)
801008ea:	eb fe                	jmp    801008ea <cprintf+0xfa>
801008ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801008f0:	8d 47 04             	lea    0x4(%edi),%eax
801008f3:	31 c9                	xor    %ecx,%ecx
801008f5:	ba 10 00 00 00       	mov    $0x10,%edx
801008fa:	89 45 e0             	mov    %eax,-0x20(%ebp)
801008fd:	8b 07                	mov    (%edi),%eax
801008ff:	e8 4c fe ff ff       	call   80100750 <printint>
80100904:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
80100907:	e9 56 ff ff ff       	jmp    80100862 <cprintf+0x72>
8010090c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
80100910:	83 ec 0c             	sub    $0xc,%esp
80100913:	68 20 ff 10 80       	push   $0x8010ff20
80100918:	e8 b3 41 00 00       	call   80104ad0 <acquire>
  if (fmt == 0)
8010091d:	83 c4 10             	add    $0x10,%esp
80100920:	85 f6                	test   %esi,%esi
80100922:	0f 84 a1 00 00 00    	je     801009c9 <cprintf+0x1d9>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100928:	0f b6 06             	movzbl (%esi),%eax
8010092b:	85 c0                	test   %eax,%eax
8010092d:	0f 85 e6 fe ff ff    	jne    80100819 <cprintf+0x29>
    release(&cons.lock);
80100933:	83 ec 0c             	sub    $0xc,%esp
80100936:	68 20 ff 10 80       	push   $0x8010ff20
8010093b:	e8 10 43 00 00       	call   80104c50 <release>
80100940:	83 c4 10             	add    $0x10,%esp
80100943:	e9 30 ff ff ff       	jmp    80100878 <cprintf+0x88>
      if((s = (char*)*argp++) == 0)
80100948:	8b 17                	mov    (%edi),%edx
8010094a:	8d 47 04             	lea    0x4(%edi),%eax
8010094d:	85 d2                	test   %edx,%edx
8010094f:	74 27                	je     80100978 <cprintf+0x188>
      for(; *s; s++)
80100951:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100954:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100956:	84 c9                	test   %cl,%cl
80100958:	74 68                	je     801009c2 <cprintf+0x1d2>
8010095a:	89 5d e0             	mov    %ebx,-0x20(%ebp)
8010095d:	89 fb                	mov    %edi,%ebx
8010095f:	89 f7                	mov    %esi,%edi
80100961:	89 c6                	mov    %eax,%esi
80100963:	0f be c1             	movsbl %cl,%eax
  if(panicked){
80100966:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
8010096c:	85 d2                	test   %edx,%edx
8010096e:	74 28                	je     80100998 <cprintf+0x1a8>
80100970:	fa                   	cli
    for(;;)
80100971:	eb fe                	jmp    80100971 <cprintf+0x181>
80100973:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100978:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
8010097d:	bf b8 80 10 80       	mov    $0x801080b8,%edi
80100982:	eb d6                	jmp    8010095a <cprintf+0x16a>
80100984:	fa                   	cli
    for(;;)
80100985:	eb fe                	jmp    80100985 <cprintf+0x195>
80100987:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010098e:	00 
8010098f:	90                   	nop
80100990:	fa                   	cli
80100991:	eb fe                	jmp    80100991 <cprintf+0x1a1>
80100993:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100998:	e8 93 fb ff ff       	call   80100530 <consputc.part.0>
      for(; *s; s++)
8010099d:	0f be 43 01          	movsbl 0x1(%ebx),%eax
801009a1:	83 c3 01             	add    $0x1,%ebx
801009a4:	84 c0                	test   %al,%al
801009a6:	75 be                	jne    80100966 <cprintf+0x176>
      if((s = (char*)*argp++) == 0)
801009a8:	89 f0                	mov    %esi,%eax
801009aa:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801009ad:	89 fe                	mov    %edi,%esi
801009af:	89 c7                	mov    %eax,%edi
801009b1:	e9 ac fe ff ff       	jmp    80100862 <cprintf+0x72>
801009b6:	89 c8                	mov    %ecx,%eax
801009b8:	e8 73 fb ff ff       	call   80100530 <consputc.part.0>
      break;
801009bd:	e9 a0 fe ff ff       	jmp    80100862 <cprintf+0x72>
      if((s = (char*)*argp++) == 0)
801009c2:	89 c7                	mov    %eax,%edi
801009c4:	e9 99 fe ff ff       	jmp    80100862 <cprintf+0x72>
    panic("null fmt");
801009c9:	83 ec 0c             	sub    $0xc,%esp
801009cc:	68 bf 80 10 80       	push   $0x801080bf
801009d1:	e8 da fa ff ff       	call   801004b0 <panic>
801009d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801009dd:	00 
801009de:	66 90                	xchg   %ax,%ax

801009e0 <consoleintr>:
{
801009e0:	55                   	push   %ebp
801009e1:	89 e5                	mov    %esp,%ebp
801009e3:	57                   	push   %edi
  int c, doprocdump = 0;
801009e4:	31 ff                	xor    %edi,%edi
{
801009e6:	56                   	push   %esi
801009e7:	53                   	push   %ebx
801009e8:	83 ec 18             	sub    $0x18,%esp
801009eb:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801009ee:	68 20 ff 10 80       	push   $0x8010ff20
801009f3:	e8 d8 40 00 00       	call   80104ad0 <acquire>
  while((c = getc()) >= 0){
801009f8:	83 c4 10             	add    $0x10,%esp
801009fb:	ff d6                	call   *%esi
801009fd:	89 c3                	mov    %eax,%ebx
801009ff:	85 c0                	test   %eax,%eax
80100a01:	78 22                	js     80100a25 <consoleintr+0x45>
    switch(c){
80100a03:	83 fb 15             	cmp    $0x15,%ebx
80100a06:	74 40                	je     80100a48 <consoleintr+0x68>
80100a08:	7f 76                	jg     80100a80 <consoleintr+0xa0>
80100a0a:	83 fb 08             	cmp    $0x8,%ebx
80100a0d:	74 76                	je     80100a85 <consoleintr+0xa5>
80100a0f:	83 fb 10             	cmp    $0x10,%ebx
80100a12:	0f 85 14 01 00 00    	jne    80100b2c <consoleintr+0x14c>
  while((c = getc()) >= 0){
80100a18:	ff d6                	call   *%esi
    switch(c){
80100a1a:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
80100a1f:	89 c3                	mov    %eax,%ebx
80100a21:	85 c0                	test   %eax,%eax
80100a23:	79 de                	jns    80100a03 <consoleintr+0x23>
  release(&cons.lock);
80100a25:	83 ec 0c             	sub    $0xc,%esp
80100a28:	68 20 ff 10 80       	push   $0x8010ff20
80100a2d:	e8 1e 42 00 00       	call   80104c50 <release>
  if(doprocdump) {
80100a32:	83 c4 10             	add    $0x10,%esp
80100a35:	85 ff                	test   %edi,%edi
80100a37:	0f 85 72 01 00 00    	jne    80100baf <consoleintr+0x1cf>
}
80100a3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a40:	5b                   	pop    %ebx
80100a41:	5e                   	pop    %esi
80100a42:	5f                   	pop    %edi
80100a43:	5d                   	pop    %ebp
80100a44:	c3                   	ret
80100a45:	8d 76 00             	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100a48:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a4d:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
80100a53:	74 a6                	je     801009fb <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100a55:	83 e8 01             	sub    $0x1,%eax
80100a58:	89 c2                	mov    %eax,%edx
80100a5a:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100a5d:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100a64:	74 95                	je     801009fb <consoleintr+0x1b>
  if(panicked){
80100a66:	8b 1d 58 ff 10 80    	mov    0x8010ff58,%ebx
        input.e--;
80100a6c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100a71:	85 db                	test   %ebx,%ebx
80100a73:	74 3b                	je     80100ab0 <consoleintr+0xd0>
80100a75:	fa                   	cli
    for(;;)
80100a76:	eb fe                	jmp    80100a76 <consoleintr+0x96>
80100a78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a7f:	00 
    switch(c){
80100a80:	83 fb 7f             	cmp    $0x7f,%ebx
80100a83:	75 4b                	jne    80100ad0 <consoleintr+0xf0>
      if(input.e != input.w){
80100a85:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100a8a:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100a90:	0f 84 65 ff ff ff    	je     801009fb <consoleintr+0x1b>
  if(panicked){
80100a96:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
        input.e--;
80100a9c:	83 e8 01             	sub    $0x1,%eax
80100a9f:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100aa4:	85 c9                	test   %ecx,%ecx
80100aa6:	0f 84 f4 00 00 00    	je     80100ba0 <consoleintr+0x1c0>
80100aac:	fa                   	cli
    for(;;)
80100aad:	eb fe                	jmp    80100aad <consoleintr+0xcd>
80100aaf:	90                   	nop
80100ab0:	b8 00 01 00 00       	mov    $0x100,%eax
80100ab5:	e8 76 fa ff ff       	call   80100530 <consputc.part.0>
      while(input.e != input.w &&
80100aba:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100abf:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100ac5:	75 8e                	jne    80100a55 <consoleintr+0x75>
80100ac7:	e9 2f ff ff ff       	jmp    801009fb <consoleintr+0x1b>
80100acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(c != 0 && input.e-input.r < INPUT_BUF){
80100ad0:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100ad5:	89 c2                	mov    %eax,%edx
80100ad7:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
80100add:	83 fa 7f             	cmp    $0x7f,%edx
80100ae0:	0f 87 15 ff ff ff    	ja     801009fb <consoleintr+0x1b>
    input.buf[input.e++ % INPUT_BUF] = c;
80100ae6:	8d 50 01             	lea    0x1(%eax),%edx
80100ae9:	83 e0 7f             	and    $0x7f,%eax
80100aec:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
    if (echo) {
80100af2:	a1 00 90 10 80       	mov    0x80109000,%eax
    input.buf[input.e++ % INPUT_BUF] = c;
80100af7:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
    if (echo) {
80100afd:	85 c0                	test   %eax,%eax
80100aff:	75 70                	jne    80100b71 <consoleintr+0x191>
    if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b01:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
80100b06:	83 e8 80             	sub    $0xffffff80,%eax
80100b09:	39 d0                	cmp    %edx,%eax
80100b0b:	0f 85 ea fe ff ff    	jne    801009fb <consoleintr+0x1b>
      wakeup(&input.r);
80100b11:	83 ec 0c             	sub    $0xc,%esp
      input.w = input.e;
80100b14:	89 15 04 ff 10 80    	mov    %edx,0x8010ff04
      wakeup(&input.r);
80100b1a:	68 00 ff 10 80       	push   $0x8010ff00
80100b1f:	e8 9c 3b 00 00       	call   801046c0 <wakeup>
80100b24:	83 c4 10             	add    $0x10,%esp
80100b27:	e9 cf fe ff ff       	jmp    801009fb <consoleintr+0x1b>
  if(c != 0 && input.e-input.r < INPUT_BUF){
80100b2c:	85 db                	test   %ebx,%ebx
80100b2e:	0f 84 c7 fe ff ff    	je     801009fb <consoleintr+0x1b>
80100b34:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100b39:	89 c2                	mov    %eax,%edx
80100b3b:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
80100b41:	83 fa 7f             	cmp    $0x7f,%edx
80100b44:	0f 87 b1 fe ff ff    	ja     801009fb <consoleintr+0x1b>
    input.buf[input.e++ % INPUT_BUF] = c;
80100b4a:	8d 50 01             	lea    0x1(%eax),%edx
    if (echo) {
80100b4d:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
    input.buf[input.e++ % INPUT_BUF] = c;
80100b53:	83 e0 7f             	and    $0x7f,%eax
80100b56:	89 15 08 ff 10 80    	mov    %edx,0x8010ff08
    c = (c == '\r') ? '\n' : c;
80100b5c:	83 fb 0d             	cmp    $0xd,%ebx
80100b5f:	75 5d                	jne    80100bbe <consoleintr+0x1de>
    input.buf[input.e++ % INPUT_BUF] = c;
80100b61:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
    if (echo) {
80100b68:	85 c9                	test   %ecx,%ecx
80100b6a:	74 a5                	je     80100b11 <consoleintr+0x131>
    c = (c == '\r') ? '\n' : c;
80100b6c:	bb 0a 00 00 00       	mov    $0xa,%ebx
  if(panicked){
80100b71:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100b77:	85 d2                	test   %edx,%edx
80100b79:	75 40                	jne    80100bbb <consoleintr+0x1db>
80100b7b:	89 d8                	mov    %ebx,%eax
80100b7d:	e8 ae f9 ff ff       	call   80100530 <consputc.part.0>
    if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b82:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
80100b88:	83 fb 0a             	cmp    $0xa,%ebx
80100b8b:	74 84                	je     80100b11 <consoleintr+0x131>
80100b8d:	83 fb 04             	cmp    $0x4,%ebx
80100b90:	0f 85 6b ff ff ff    	jne    80100b01 <consoleintr+0x121>
80100b96:	e9 76 ff ff ff       	jmp    80100b11 <consoleintr+0x131>
80100b9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100ba0:	b8 00 01 00 00       	mov    $0x100,%eax
80100ba5:	e8 86 f9 ff ff       	call   80100530 <consputc.part.0>
80100baa:	e9 4c fe ff ff       	jmp    801009fb <consoleintr+0x1b>
}
80100baf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100bb2:	5b                   	pop    %ebx
80100bb3:	5e                   	pop    %esi
80100bb4:	5f                   	pop    %edi
80100bb5:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100bb6:	e9 e5 3b 00 00       	jmp    801047a0 <procdump>
80100bbb:	fa                   	cli
    for(;;)
80100bbc:	eb fe                	jmp    80100bbc <consoleintr+0x1dc>
    input.buf[input.e++ % INPUT_BUF] = c;
80100bbe:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
    if (echo) {
80100bc4:	85 c9                	test   %ecx,%ecx
80100bc6:	74 c0                	je     80100b88 <consoleintr+0x1a8>
80100bc8:	eb a7                	jmp    80100b71 <consoleintr+0x191>
80100bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100bd0 <consoleinit>:

void
consoleinit(void)
{
80100bd0:	55                   	push   %ebp
80100bd1:	89 e5                	mov    %esp,%ebp
80100bd3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100bd6:	68 c8 80 10 80       	push   $0x801080c8
80100bdb:	68 20 ff 10 80       	push   $0x8010ff20
80100be0:	e8 9b 3d 00 00       	call   80104980 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100be5:	58                   	pop    %eax
80100be6:	5a                   	pop    %edx
80100be7:	6a 00                	push   $0x0
80100be9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100beb:	c7 05 0c 09 11 80 e0 	movl   $0x801006e0,0x8011090c
80100bf2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100bf5:	c7 05 08 09 11 80 80 	movl   $0x80100380,0x80110908
80100bfc:	03 10 80 
  cons.locking = 1;
80100bff:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100c06:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100c09:	e8 32 1d 00 00       	call   80102940 <ioapicenable>
}
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	c9                   	leave
80100c12:	c3                   	ret
80100c13:	66 90                	xchg   %ax,%ax
80100c15:	66 90                	xchg   %ax,%ax
80100c17:	66 90                	xchg   %ax,%ax
80100c19:	66 90                	xchg   %ax,%ax
80100c1b:	66 90                	xchg   %ax,%ax
80100c1d:	66 90                	xchg   %ax,%ax
80100c1f:	90                   	nop

80100c20 <sys_gettime>:
#include "syscall.h"
#include "defs.h"

int
sys_gettime(void)
{
80100c20:	55                   	push   %ebp
80100c21:	89 e5                	mov    %esp,%ebp
80100c23:	83 ec 1c             	sub    $0x1c,%esp
  struct rtcdate *r;

  if(argptr(0, (char**)&r, sizeof(*r)) < 0)
80100c26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80100c29:	6a 18                	push   $0x18
80100c2b:	50                   	push   %eax
80100c2c:	6a 00                	push   $0x0
80100c2e:	e8 8d 43 00 00       	call   80104fc0 <argptr>
80100c33:	83 c4 10             	add    $0x10,%esp
80100c36:	85 c0                	test   %eax,%eax
80100c38:	78 16                	js     80100c50 <sys_gettime+0x30>
    return -1;

  cmostime(r);
80100c3a:	83 ec 0c             	sub    $0xc,%esp
80100c3d:	ff 75 f4             	push   -0xc(%ebp)
80100c40:	e8 7b 22 00 00       	call   80102ec0 <cmostime>
  return 0;
80100c45:	83 c4 10             	add    $0x10,%esp
80100c48:	31 c0                	xor    %eax,%eax
}
80100c4a:	c9                   	leave
80100c4b:	c3                   	ret
80100c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c50:	c9                   	leave
    return -1;
80100c51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100c56:	c3                   	ret
80100c57:	66 90                	xchg   %ax,%ax
80100c59:	66 90                	xchg   %ax,%ax
80100c5b:	66 90                	xchg   %ax,%ax
80100c5d:	66 90                	xchg   %ax,%ax
80100c5f:	90                   	nop

80100c60 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100c60:	55                   	push   %ebp
80100c61:	89 e5                	mov    %esp,%ebp
80100c63:	57                   	push   %edi
80100c64:	56                   	push   %esi
80100c65:	53                   	push   %ebx
80100c66:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100c6c:	e8 cf 32 00 00       	call   80103f40 <myproc>
80100c71:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100c77:	e8 24 26 00 00       	call   801032a0 <begin_op>

  if((ip = namei(path)) == 0){
80100c7c:	83 ec 0c             	sub    $0xc,%esp
80100c7f:	ff 75 08             	push   0x8(%ebp)
80100c82:	e8 89 18 00 00       	call   80102510 <namei>
80100c87:	83 c4 10             	add    $0x10,%esp
80100c8a:	85 c0                	test   %eax,%eax
80100c8c:	0f 84 30 03 00 00    	je     80100fc2 <exec+0x362>
    end_op();
//    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100c92:	83 ec 0c             	sub    $0xc,%esp
80100c95:	89 c7                	mov    %eax,%edi
80100c97:	50                   	push   %eax
80100c98:	e8 53 0f 00 00       	call   80101bf0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100c9d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100ca3:	6a 34                	push   $0x34
80100ca5:	6a 00                	push   $0x0
80100ca7:	50                   	push   %eax
80100ca8:	57                   	push   %edi
80100ca9:	e8 52 12 00 00       	call   80101f00 <readi>
80100cae:	83 c4 20             	add    $0x20,%esp
80100cb1:	83 f8 34             	cmp    $0x34,%eax
80100cb4:	0f 85 01 01 00 00    	jne    80100dbb <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100cba:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100cc1:	45 4c 46 
80100cc4:	0f 85 f1 00 00 00    	jne    80100dbb <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100cca:	e8 51 6e 00 00       	call   80107b20 <setupkvm>
80100ccf:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100cd5:	85 c0                	test   %eax,%eax
80100cd7:	0f 84 de 00 00 00    	je     80100dbb <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cdd:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100ce4:	00 
80100ce5:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100ceb:	0f 84 a1 02 00 00    	je     80100f92 <exec+0x332>
  sz = 0;
80100cf1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100cf8:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cfb:	31 db                	xor    %ebx,%ebx
80100cfd:	e9 8c 00 00 00       	jmp    80100d8e <exec+0x12e>
80100d02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100d08:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100d0f:	75 6c                	jne    80100d7d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100d11:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100d17:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100d1d:	0f 82 87 00 00 00    	jb     80100daa <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100d23:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100d29:	72 7f                	jb     80100daa <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100d2b:	83 ec 04             	sub    $0x4,%esp
80100d2e:	50                   	push   %eax
80100d2f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100d35:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d3b:	e8 40 6c 00 00       	call   80107980 <allocuvm>
80100d40:	83 c4 10             	add    $0x10,%esp
80100d43:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100d49:	85 c0                	test   %eax,%eax
80100d4b:	74 5d                	je     80100daa <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100d4d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100d53:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100d58:	75 50                	jne    80100daa <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100d5a:	83 ec 0c             	sub    $0xc,%esp
80100d5d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100d63:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100d69:	57                   	push   %edi
80100d6a:	50                   	push   %eax
80100d6b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d71:	e8 3a 6b 00 00       	call   801078b0 <loaduvm>
80100d76:	83 c4 20             	add    $0x20,%esp
80100d79:	85 c0                	test   %eax,%eax
80100d7b:	78 2d                	js     80100daa <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d7d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100d84:	83 c3 01             	add    $0x1,%ebx
80100d87:	83 c6 20             	add    $0x20,%esi
80100d8a:	39 d8                	cmp    %ebx,%eax
80100d8c:	7e 52                	jle    80100de0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100d8e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100d94:	6a 20                	push   $0x20
80100d96:	56                   	push   %esi
80100d97:	50                   	push   %eax
80100d98:	57                   	push   %edi
80100d99:	e8 62 11 00 00       	call   80101f00 <readi>
80100d9e:	83 c4 10             	add    $0x10,%esp
80100da1:	83 f8 20             	cmp    $0x20,%eax
80100da4:	0f 84 5e ff ff ff    	je     80100d08 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100daa:	83 ec 0c             	sub    $0xc,%esp
80100dad:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100db3:	e8 e8 6c 00 00       	call   80107aa0 <freevm>
  if(ip){
80100db8:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100dbb:	83 ec 0c             	sub    $0xc,%esp
80100dbe:	57                   	push   %edi
80100dbf:	e8 bc 10 00 00       	call   80101e80 <iunlockput>
    end_op();
80100dc4:	e8 47 25 00 00       	call   80103310 <end_op>
80100dc9:	83 c4 10             	add    $0x10,%esp
    return -1;
80100dcc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100dd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100dd4:	5b                   	pop    %ebx
80100dd5:	5e                   	pop    %esi
80100dd6:	5f                   	pop    %edi
80100dd7:	5d                   	pop    %ebp
80100dd8:	c3                   	ret
80100dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100de0:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100de6:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100dec:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100df2:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100df8:	83 ec 0c             	sub    $0xc,%esp
80100dfb:	57                   	push   %edi
80100dfc:	e8 7f 10 00 00       	call   80101e80 <iunlockput>
  end_op();
80100e01:	e8 0a 25 00 00       	call   80103310 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100e06:	83 c4 0c             	add    $0xc,%esp
80100e09:	53                   	push   %ebx
80100e0a:	56                   	push   %esi
80100e0b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100e11:	56                   	push   %esi
80100e12:	e8 69 6b 00 00       	call   80107980 <allocuvm>
80100e17:	83 c4 10             	add    $0x10,%esp
80100e1a:	89 c7                	mov    %eax,%edi
80100e1c:	85 c0                	test   %eax,%eax
80100e1e:	0f 84 86 00 00 00    	je     80100eaa <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e24:	83 ec 08             	sub    $0x8,%esp
80100e27:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100e2d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e2f:	50                   	push   %eax
80100e30:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100e31:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e33:	e8 88 6e 00 00       	call   80107cc0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100e38:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e3b:	83 c4 10             	add    $0x10,%esp
80100e3e:	8b 10                	mov    (%eax),%edx
80100e40:	85 d2                	test   %edx,%edx
80100e42:	0f 84 56 01 00 00    	je     80100f9e <exec+0x33e>
80100e48:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100e4e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100e51:	eb 23                	jmp    80100e76 <exec+0x216>
80100e53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100e58:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100e5b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100e62:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100e68:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100e6b:	85 d2                	test   %edx,%edx
80100e6d:	74 51                	je     80100ec0 <exec+0x260>
    if(argc >= MAXARG)
80100e6f:	83 f8 20             	cmp    $0x20,%eax
80100e72:	74 36                	je     80100eaa <exec+0x24a>
80100e74:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e76:	83 ec 0c             	sub    $0xc,%esp
80100e79:	52                   	push   %edx
80100e7a:	e8 21 40 00 00       	call   80104ea0 <strlen>
80100e7f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e81:	58                   	pop    %eax
80100e82:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e85:	83 eb 01             	sub    $0x1,%ebx
80100e88:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e8b:	e8 10 40 00 00       	call   80104ea0 <strlen>
80100e90:	83 c0 01             	add    $0x1,%eax
80100e93:	50                   	push   %eax
80100e94:	ff 34 b7             	push   (%edi,%esi,4)
80100e97:	53                   	push   %ebx
80100e98:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100e9e:	e8 dd 70 00 00       	call   80107f80 <copyout>
80100ea3:	83 c4 20             	add    $0x20,%esp
80100ea6:	85 c0                	test   %eax,%eax
80100ea8:	79 ae                	jns    80100e58 <exec+0x1f8>
    freevm(pgdir);
80100eaa:	83 ec 0c             	sub    $0xc,%esp
80100ead:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100eb3:	e8 e8 6b 00 00       	call   80107aa0 <freevm>
80100eb8:	83 c4 10             	add    $0x10,%esp
80100ebb:	e9 0c ff ff ff       	jmp    80100dcc <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ec0:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100ec7:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100ecd:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ed3:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100ed6:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100ed9:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100ee0:	00 00 00 00 
  ustack[1] = argc;
80100ee4:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100eea:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ef1:	ff ff ff 
  ustack[1] = argc;
80100ef4:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100efa:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100efc:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100efe:	29 d0                	sub    %edx,%eax
80100f00:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100f06:	56                   	push   %esi
80100f07:	51                   	push   %ecx
80100f08:	53                   	push   %ebx
80100f09:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100f0f:	e8 6c 70 00 00       	call   80107f80 <copyout>
80100f14:	83 c4 10             	add    $0x10,%esp
80100f17:	85 c0                	test   %eax,%eax
80100f19:	78 8f                	js     80100eaa <exec+0x24a>
  for(last=s=path; *s; s++)
80100f1b:	8b 45 08             	mov    0x8(%ebp),%eax
80100f1e:	8b 55 08             	mov    0x8(%ebp),%edx
80100f21:	0f b6 00             	movzbl (%eax),%eax
80100f24:	84 c0                	test   %al,%al
80100f26:	74 17                	je     80100f3f <exec+0x2df>
80100f28:	89 d1                	mov    %edx,%ecx
80100f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100f30:	83 c1 01             	add    $0x1,%ecx
80100f33:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100f35:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100f38:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100f3b:	84 c0                	test   %al,%al
80100f3d:	75 f1                	jne    80100f30 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100f3f:	83 ec 04             	sub    $0x4,%esp
80100f42:	6a 10                	push   $0x10
80100f44:	52                   	push   %edx
80100f45:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100f4b:	8d 46 6c             	lea    0x6c(%esi),%eax
80100f4e:	50                   	push   %eax
80100f4f:	e8 0c 3f 00 00       	call   80104e60 <safestrcpy>
  curproc->pgdir = pgdir;
80100f54:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100f5a:	89 f0                	mov    %esi,%eax
80100f5c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100f5f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100f61:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100f64:	89 c1                	mov    %eax,%ecx
80100f66:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100f6c:	8b 40 18             	mov    0x18(%eax),%eax
80100f6f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100f72:	8b 41 18             	mov    0x18(%ecx),%eax
80100f75:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100f78:	89 0c 24             	mov    %ecx,(%esp)
80100f7b:	e8 a0 67 00 00       	call   80107720 <switchuvm>
  freevm(oldpgdir);
80100f80:	89 34 24             	mov    %esi,(%esp)
80100f83:	e8 18 6b 00 00       	call   80107aa0 <freevm>
  return 0;
80100f88:	83 c4 10             	add    $0x10,%esp
80100f8b:	31 c0                	xor    %eax,%eax
80100f8d:	e9 3f fe ff ff       	jmp    80100dd1 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f92:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100f97:	31 f6                	xor    %esi,%esi
80100f99:	e9 5a fe ff ff       	jmp    80100df8 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100f9e:	be 10 00 00 00       	mov    $0x10,%esi
80100fa3:	ba 04 00 00 00       	mov    $0x4,%edx
80100fa8:	b8 03 00 00 00       	mov    $0x3,%eax
80100fad:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100fb4:	00 00 00 
80100fb7:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100fbd:	e9 17 ff ff ff       	jmp    80100ed9 <exec+0x279>
    end_op();
80100fc2:	e8 49 23 00 00       	call   80103310 <end_op>
    return -1;
80100fc7:	e9 00 fe ff ff       	jmp    80100dcc <exec+0x16c>
80100fcc:	66 90                	xchg   %ax,%ax
80100fce:	66 90                	xchg   %ax,%ax
80100fd0:	66 90                	xchg   %ax,%ax
80100fd2:	66 90                	xchg   %ax,%ax
80100fd4:	66 90                	xchg   %ax,%ax
80100fd6:	66 90                	xchg   %ax,%ax
80100fd8:	66 90                	xchg   %ax,%ax
80100fda:	66 90                	xchg   %ax,%ax
80100fdc:	66 90                	xchg   %ax,%ax
80100fde:	66 90                	xchg   %ax,%ax

80100fe0 <nullwrite>:
struct {
  struct spinlock lock;
  struct file file[NFILE];
} ftable;

int nullwrite(struct inode *ip, char *buf, int n) { return n; }
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	8b 45 10             	mov    0x10(%ebp),%eax
80100fe6:	5d                   	pop    %ebp
80100fe7:	c3                   	ret
80100fe8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fef:	00 

80100ff0 <nullread>:
int nullread(struct inode *ip, char *buf, int n) { return 0; }
80100ff0:	31 c0                	xor    %eax,%eax
80100ff2:	c3                   	ret
80100ff3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100ffa:	00 
80100ffb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101000 <zeroread>:

// Zero device (returns zeros on read, discards writes)
int zeroread(struct inode *ip, char *dst, int n) {
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	53                   	push   %ebx
80101004:	83 ec 08             	sub    $0x8,%esp
80101007:	8b 5d 10             	mov    0x10(%ebp),%ebx
  memset(dst, 0, n);
8010100a:	53                   	push   %ebx
8010100b:	6a 00                	push   $0x0
8010100d:	ff 75 0c             	push   0xc(%ebp)
80101010:	e8 8b 3c 00 00       	call   80104ca0 <memset>
  return n;
}
80101015:	89 d8                	mov    %ebx,%eax
80101017:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010101a:	c9                   	leave
8010101b:	c3                   	ret
8010101c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101020 <kmemread>:

int zerowrite(struct inode *ip, char *src, int n) {
  return n; // Discard writes
}

int kmemread(struct inode *ip, char *dst, int n) {
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	56                   	push   %esi
80101024:	53                   	push   %ebx
80101025:	8b 75 08             	mov    0x8(%ebp),%esi
80101028:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint addr = ip->off; // Use offset as kernel address
8010102b:	8b 06                	mov    (%esi),%eax
  // Validate address range (KERNBASE to PHYSTOP)
  if (addr < KERNBASE || addr + n > KERNBASE + PHYSTOP || addr + n < addr) 
8010102d:	85 c0                	test   %eax,%eax
8010102f:	79 2f                	jns    80101060 <kmemread+0x40>
80101031:	89 da                	mov    %ebx,%edx
80101033:	01 c2                	add    %eax,%edx
80101035:	72 29                	jb     80101060 <kmemread+0x40>
80101037:	81 fa 00 00 40 80    	cmp    $0x80400000,%edx
8010103d:	77 21                	ja     80101060 <kmemread+0x40>
    return -1;
  memmove(dst, (void*)addr, n);
8010103f:	83 ec 04             	sub    $0x4,%esp
80101042:	53                   	push   %ebx
80101043:	50                   	push   %eax
80101044:	ff 75 0c             	push   0xc(%ebp)
80101047:	e8 e4 3c 00 00       	call   80104d30 <memmove>
  ip->off += n; // Advance offset
8010104c:	01 1e                	add    %ebx,(%esi)
  return n;
8010104e:	83 c4 10             	add    $0x10,%esp
80101051:	89 d8                	mov    %ebx,%eax
}
80101053:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101056:	5b                   	pop    %ebx
80101057:	5e                   	pop    %esi
80101058:	5d                   	pop    %ebp
80101059:	c3                   	ret
8010105a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101060:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101065:	eb ec                	jmp    80101053 <kmemread+0x33>
80101067:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010106e:	00 
8010106f:	90                   	nop

80101070 <kmemwrite>:

int kmemwrite(struct inode *ip, char *src, int n) {
80101070:	55                   	push   %ebp
80101071:	89 e5                	mov    %esp,%ebp
80101073:	56                   	push   %esi
80101074:	53                   	push   %ebx
80101075:	8b 75 08             	mov    0x8(%ebp),%esi
80101078:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint addr = ip->off;
8010107b:	8b 06                	mov    (%esi),%eax
  if (addr < KERNBASE || addr + n > KERNBASE + PHYSTOP || addr + n < addr)
8010107d:	85 c0                	test   %eax,%eax
8010107f:	79 2f                	jns    801010b0 <kmemwrite+0x40>
80101081:	89 da                	mov    %ebx,%edx
80101083:	01 c2                	add    %eax,%edx
80101085:	72 29                	jb     801010b0 <kmemwrite+0x40>
80101087:	81 fa 00 00 40 80    	cmp    $0x80400000,%edx
8010108d:	77 21                	ja     801010b0 <kmemwrite+0x40>
    return -1;
  memmove((void*)addr, src, n);
8010108f:	83 ec 04             	sub    $0x4,%esp
80101092:	53                   	push   %ebx
80101093:	ff 75 0c             	push   0xc(%ebp)
80101096:	50                   	push   %eax
80101097:	e8 94 3c 00 00       	call   80104d30 <memmove>
  ip->off += n;
8010109c:	01 1e                	add    %ebx,(%esi)
  return n;
8010109e:	83 c4 10             	add    $0x10,%esp
801010a1:	89 d8                	mov    %ebx,%eax
}
801010a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801010a6:	5b                   	pop    %ebx
801010a7:	5e                   	pop    %esi
801010a8:	5d                   	pop    %ebp
801010a9:	c3                   	ret
801010aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801010b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010b5:	eb ec                	jmp    801010a3 <kmemwrite+0x33>
801010b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010be:	00 
801010bf:	90                   	nop

801010c0 <zerowrite>:
int zerowrite(struct inode *ip, char *src, int n) {
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	8b 45 10             	mov    0x10(%ebp),%eax
801010c6:	5d                   	pop    %ebp
801010c7:	c3                   	ret
801010c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010cf:	00 

801010d0 <nullinit>:

// Devnodes devices
void nullinit(void) {
  devsw[NULLDEV].read = nullread;
801010d0:	c7 05 10 09 11 80 f0 	movl   $0x80100ff0,0x80110910
801010d7:	0f 10 80 
  devsw[NULLDEV].write = nullwrite;
801010da:	c7 05 14 09 11 80 e0 	movl   $0x80100fe0,0x80110914
801010e1:	0f 10 80 
}
801010e4:	c3                   	ret
801010e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010ec:	00 
801010ed:	8d 76 00             	lea    0x0(%esi),%esi

801010f0 <zeroinit>:

void zeroinit(void) {
  devsw[ZERO].read = zeroread;
801010f0:	c7 05 20 09 11 80 00 	movl   $0x80101000,0x80110920
801010f7:	10 10 80 
  devsw[ZERO].write = zerowrite;
801010fa:	c7 05 24 09 11 80 c0 	movl   $0x801010c0,0x80110924
80101101:	10 10 80 
}
80101104:	c3                   	ret
80101105:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010110c:	00 
8010110d:	8d 76 00             	lea    0x0(%esi),%esi

80101110 <kminit>:

void kminit(void) {
  devsw[KMEM].read = kmemread;
80101110:	c7 05 18 09 11 80 20 	movl   $0x80101020,0x80110918
80101117:	10 10 80 
  devsw[KMEM].write = kmemwrite;
8010111a:	c7 05 1c 09 11 80 70 	movl   $0x80101070,0x8011091c
80101121:	10 10 80 
}
80101124:	c3                   	ret
80101125:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010112c:	00 
8010112d:	8d 76 00             	lea    0x0(%esi),%esi

80101130 <fileinit>:

void
fileinit(void)
{
80101130:	55                   	push   %ebp
80101131:	89 e5                	mov    %esp,%ebp
80101133:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101136:	68 d0 80 10 80       	push   $0x801080d0
8010113b:	68 60 ff 10 80       	push   $0x8010ff60
80101140:	e8 3b 38 00 00       	call   80104980 <initlock>
}
80101145:	83 c4 10             	add    $0x10,%esp
80101148:	c9                   	leave
80101149:	c3                   	ret
8010114a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101150 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101150:	55                   	push   %ebp
80101151:	89 e5                	mov    %esp,%ebp
80101153:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101154:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80101159:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
8010115c:	68 60 ff 10 80       	push   $0x8010ff60
80101161:	e8 6a 39 00 00       	call   80104ad0 <acquire>
80101166:	83 c4 10             	add    $0x10,%esp
80101169:	eb 20                	jmp    8010118b <filealloc+0x3b>
8010116b:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101172:	00 
80101173:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010117a:	00 
8010117b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101180:	83 c3 18             	add    $0x18,%ebx
80101183:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80101189:	74 25                	je     801011b0 <filealloc+0x60>
    if(f->ref == 0){
8010118b:	8b 43 04             	mov    0x4(%ebx),%eax
8010118e:	85 c0                	test   %eax,%eax
80101190:	75 ee                	jne    80101180 <filealloc+0x30>
      f->ref = 1;
      release(&ftable.lock);
80101192:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101195:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010119c:	68 60 ff 10 80       	push   $0x8010ff60
801011a1:	e8 aa 3a 00 00       	call   80104c50 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
801011a6:	89 d8                	mov    %ebx,%eax
      return f;
801011a8:	83 c4 10             	add    $0x10,%esp
}
801011ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801011ae:	c9                   	leave
801011af:	c3                   	ret
  release(&ftable.lock);
801011b0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
801011b3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
801011b5:	68 60 ff 10 80       	push   $0x8010ff60
801011ba:	e8 91 3a 00 00       	call   80104c50 <release>
}
801011bf:	89 d8                	mov    %ebx,%eax
  return 0;
801011c1:	83 c4 10             	add    $0x10,%esp
}
801011c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801011c7:	c9                   	leave
801011c8:	c3                   	ret
801011c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801011d0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
801011d0:	55                   	push   %ebp
801011d1:	89 e5                	mov    %esp,%ebp
801011d3:	53                   	push   %ebx
801011d4:	83 ec 10             	sub    $0x10,%esp
801011d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
801011da:	68 60 ff 10 80       	push   $0x8010ff60
801011df:	e8 ec 38 00 00       	call   80104ad0 <acquire>
  if(f->ref < 1)
801011e4:	8b 43 04             	mov    0x4(%ebx),%eax
801011e7:	83 c4 10             	add    $0x10,%esp
801011ea:	85 c0                	test   %eax,%eax
801011ec:	7e 1a                	jle    80101208 <filedup+0x38>
    panic("filedup");
  f->ref++;
801011ee:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
801011f1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
801011f4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
801011f7:	68 60 ff 10 80       	push   $0x8010ff60
801011fc:	e8 4f 3a 00 00       	call   80104c50 <release>
  return f;
}
80101201:	89 d8                	mov    %ebx,%eax
80101203:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101206:	c9                   	leave
80101207:	c3                   	ret
    panic("filedup");
80101208:	83 ec 0c             	sub    $0xc,%esp
8010120b:	68 d7 80 10 80       	push   $0x801080d7
80101210:	e8 9b f2 ff ff       	call   801004b0 <panic>
80101215:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010121c:	00 
8010121d:	8d 76 00             	lea    0x0(%esi),%esi

80101220 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	57                   	push   %edi
80101224:	56                   	push   %esi
80101225:	53                   	push   %ebx
80101226:	83 ec 28             	sub    $0x28,%esp
80101229:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010122c:	68 60 ff 10 80       	push   $0x8010ff60
80101231:	e8 9a 38 00 00       	call   80104ad0 <acquire>
  if(f->ref < 1)
80101236:	8b 53 04             	mov    0x4(%ebx),%edx
80101239:	83 c4 10             	add    $0x10,%esp
8010123c:	85 d2                	test   %edx,%edx
8010123e:	0f 8e a5 00 00 00    	jle    801012e9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101244:	83 ea 01             	sub    $0x1,%edx
80101247:	89 53 04             	mov    %edx,0x4(%ebx)
8010124a:	75 44                	jne    80101290 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010124c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101250:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101253:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101255:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010125b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010125e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101261:	8b 43 10             	mov    0x10(%ebx),%eax
80101264:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101267:	68 60 ff 10 80       	push   $0x8010ff60
8010126c:	e8 df 39 00 00       	call   80104c50 <release>

  if(ff.type == FD_PIPE)
80101271:	83 c4 10             	add    $0x10,%esp
80101274:	83 ff 01             	cmp    $0x1,%edi
80101277:	74 57                	je     801012d0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101279:	83 ff 02             	cmp    $0x2,%edi
8010127c:	74 2a                	je     801012a8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010127e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101281:	5b                   	pop    %ebx
80101282:	5e                   	pop    %esi
80101283:	5f                   	pop    %edi
80101284:	5d                   	pop    %ebp
80101285:	c3                   	ret
80101286:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010128d:	00 
8010128e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80101290:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80101297:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010129a:	5b                   	pop    %ebx
8010129b:	5e                   	pop    %esi
8010129c:	5f                   	pop    %edi
8010129d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010129e:	e9 ad 39 00 00       	jmp    80104c50 <release>
801012a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
801012a8:	e8 f3 1f 00 00       	call   801032a0 <begin_op>
    iput(ff.ip);
801012ad:	83 ec 0c             	sub    $0xc,%esp
801012b0:	ff 75 e0             	push   -0x20(%ebp)
801012b3:	e8 68 0a 00 00       	call   80101d20 <iput>
    end_op();
801012b8:	83 c4 10             	add    $0x10,%esp
}
801012bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012be:	5b                   	pop    %ebx
801012bf:	5e                   	pop    %esi
801012c0:	5f                   	pop    %edi
801012c1:	5d                   	pop    %ebp
    end_op();
801012c2:	e9 49 20 00 00       	jmp    80103310 <end_op>
801012c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801012ce:	00 
801012cf:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
801012d0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
801012d4:	83 ec 08             	sub    $0x8,%esp
801012d7:	53                   	push   %ebx
801012d8:	56                   	push   %esi
801012d9:	e8 d2 27 00 00       	call   80103ab0 <pipeclose>
801012de:	83 c4 10             	add    $0x10,%esp
}
801012e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012e4:	5b                   	pop    %ebx
801012e5:	5e                   	pop    %esi
801012e6:	5f                   	pop    %edi
801012e7:	5d                   	pop    %ebp
801012e8:	c3                   	ret
    panic("fileclose");
801012e9:	83 ec 0c             	sub    $0xc,%esp
801012ec:	68 df 80 10 80       	push   $0x801080df
801012f1:	e8 ba f1 ff ff       	call   801004b0 <panic>
801012f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801012fd:	00 
801012fe:	66 90                	xchg   %ax,%ax

80101300 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	53                   	push   %ebx
80101304:	83 ec 04             	sub    $0x4,%esp
80101307:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010130a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010130d:	75 31                	jne    80101340 <filestat+0x40>
    ilock(f->ip);
8010130f:	83 ec 0c             	sub    $0xc,%esp
80101312:	ff 73 10             	push   0x10(%ebx)
80101315:	e8 d6 08 00 00       	call   80101bf0 <ilock>
    stati(f->ip, st);
8010131a:	58                   	pop    %eax
8010131b:	5a                   	pop    %edx
8010131c:	ff 75 0c             	push   0xc(%ebp)
8010131f:	ff 73 10             	push   0x10(%ebx)
80101322:	e8 a9 0b 00 00       	call   80101ed0 <stati>
    iunlock(f->ip);
80101327:	59                   	pop    %ecx
80101328:	ff 73 10             	push   0x10(%ebx)
8010132b:	e8 a0 09 00 00       	call   80101cd0 <iunlock>
    return 0;
  }
  return -1;
}
80101330:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101333:	83 c4 10             	add    $0x10,%esp
80101336:	31 c0                	xor    %eax,%eax
}
80101338:	c9                   	leave
80101339:	c3                   	ret
8010133a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101340:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101343:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101348:	c9                   	leave
80101349:	c3                   	ret
8010134a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101350 <fileread>:


// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	56                   	push   %esi
80101355:	53                   	push   %ebx
80101356:	83 ec 0c             	sub    $0xc,%esp
80101359:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010135c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010135f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101362:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101366:	74 60                	je     801013c8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101368:	8b 03                	mov    (%ebx),%eax
8010136a:	83 f8 01             	cmp    $0x1,%eax
8010136d:	74 41                	je     801013b0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010136f:	83 f8 02             	cmp    $0x2,%eax
80101372:	75 5b                	jne    801013cf <fileread+0x7f>
    ilock(f->ip);
80101374:	83 ec 0c             	sub    $0xc,%esp
80101377:	ff 73 10             	push   0x10(%ebx)
8010137a:	e8 71 08 00 00       	call   80101bf0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010137f:	57                   	push   %edi
80101380:	ff 73 14             	push   0x14(%ebx)
80101383:	56                   	push   %esi
80101384:	ff 73 10             	push   0x10(%ebx)
80101387:	e8 74 0b 00 00       	call   80101f00 <readi>
8010138c:	83 c4 20             	add    $0x20,%esp
8010138f:	89 c6                	mov    %eax,%esi
80101391:	85 c0                	test   %eax,%eax
80101393:	7e 03                	jle    80101398 <fileread+0x48>
      f->off += r;
80101395:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101398:	83 ec 0c             	sub    $0xc,%esp
8010139b:	ff 73 10             	push   0x10(%ebx)
8010139e:	e8 2d 09 00 00       	call   80101cd0 <iunlock>
    return r;
801013a3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801013a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013a9:	89 f0                	mov    %esi,%eax
801013ab:	5b                   	pop    %ebx
801013ac:	5e                   	pop    %esi
801013ad:	5f                   	pop    %edi
801013ae:	5d                   	pop    %ebp
801013af:	c3                   	ret
    return piperead(f->pipe, addr, n);
801013b0:	8b 43 0c             	mov    0xc(%ebx),%eax
801013b3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801013b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013b9:	5b                   	pop    %ebx
801013ba:	5e                   	pop    %esi
801013bb:	5f                   	pop    %edi
801013bc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
801013bd:	e9 ae 28 00 00       	jmp    80103c70 <piperead>
801013c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801013c8:	be ff ff ff ff       	mov    $0xffffffff,%esi
801013cd:	eb d7                	jmp    801013a6 <fileread+0x56>
  panic("fileread");
801013cf:	83 ec 0c             	sub    $0xc,%esp
801013d2:	68 e9 80 10 80       	push   $0x801080e9
801013d7:	e8 d4 f0 ff ff       	call   801004b0 <panic>
801013dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013e0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801013e0:	55                   	push   %ebp
801013e1:	89 e5                	mov    %esp,%ebp
801013e3:	57                   	push   %edi
801013e4:	56                   	push   %esi
801013e5:	53                   	push   %ebx
801013e6:	83 ec 1c             	sub    $0x1c,%esp
801013e9:	8b 7d 08             	mov    0x8(%ebp),%edi
801013ec:	8b 45 10             	mov    0x10(%ebp),%eax
801013ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  int r;

  if(f->writable == 0)
801013f2:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
801013f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801013f9:	0f 84 b6 00 00 00    	je     801014b5 <filewrite+0xd5>
    return -1;
  if(f->type == FD_PIPE)
801013ff:	8b 07                	mov    (%edi),%eax
80101401:	83 f8 01             	cmp    $0x1,%eax
80101404:	0f 84 ba 00 00 00    	je     801014c4 <filewrite+0xe4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010140a:	83 f8 02             	cmp    $0x2,%eax
8010140d:	0f 85 c3 00 00 00    	jne    801014d6 <filewrite+0xf6>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101413:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101416:	31 f6                	xor    %esi,%esi
    while(i < n){
80101418:	85 c0                	test   %eax,%eax
8010141a:	0f 8e 90 00 00 00    	jle    801014b0 <filewrite+0xd0>
    int i = 0;
80101420:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101423:	eb 28                	jmp    8010144d <filewrite+0x6d>
80101425:	8d 76 00             	lea    0x0(%esi),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101428:	01 47 14             	add    %eax,0x14(%edi)
      iunlock(f->ip);
8010142b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010142e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101431:	51                   	push   %ecx
80101432:	e8 99 08 00 00       	call   80101cd0 <iunlock>
      end_op();
80101437:	e8 d4 1e 00 00       	call   80103310 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010143c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010143f:	83 c4 10             	add    $0x10,%esp
80101442:	39 d8                	cmp    %ebx,%eax
80101444:	75 5d                	jne    801014a3 <filewrite+0xc3>
        panic("short filewrite");
      i += r;
80101446:	01 c6                	add    %eax,%esi
    while(i < n){
80101448:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010144b:	7e 63                	jle    801014b0 <filewrite+0xd0>
      int n1 = n - i;
8010144d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
      if(n1 > max)
80101450:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101455:	29 f3                	sub    %esi,%ebx
      if(n1 > max)
80101457:	39 c3                	cmp    %eax,%ebx
80101459:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
8010145c:	e8 3f 1e 00 00       	call   801032a0 <begin_op>
      ilock(f->ip);
80101461:	83 ec 0c             	sub    $0xc,%esp
80101464:	ff 77 10             	push   0x10(%edi)
80101467:	e8 84 07 00 00       	call   80101bf0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010146c:	53                   	push   %ebx
8010146d:	ff 77 14             	push   0x14(%edi)
80101470:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101473:	01 f0                	add    %esi,%eax
80101475:	50                   	push   %eax
80101476:	ff 77 10             	push   0x10(%edi)
80101479:	e8 82 0b 00 00       	call   80102000 <writei>
      iunlock(f->ip);
8010147e:	8b 4f 10             	mov    0x10(%edi),%ecx
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101481:	83 c4 20             	add    $0x20,%esp
80101484:	85 c0                	test   %eax,%eax
80101486:	7f a0                	jg     80101428 <filewrite+0x48>
      iunlock(f->ip);
80101488:	83 ec 0c             	sub    $0xc,%esp
8010148b:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010148e:	51                   	push   %ecx
8010148f:	e8 3c 08 00 00       	call   80101cd0 <iunlock>
      end_op();
80101494:	e8 77 1e 00 00       	call   80103310 <end_op>
      if(r < 0)
80101499:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010149c:	83 c4 10             	add    $0x10,%esp
8010149f:	85 c0                	test   %eax,%eax
801014a1:	75 0d                	jne    801014b0 <filewrite+0xd0>
        panic("short filewrite");
801014a3:	83 ec 0c             	sub    $0xc,%esp
801014a6:	68 f2 80 10 80       	push   $0x801080f2
801014ab:	e8 00 f0 ff ff       	call   801004b0 <panic>
    }
    return i == n ? n : -1;
801014b0:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801014b3:	74 05                	je     801014ba <filewrite+0xda>
    return -1;
801014b5:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
801014ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014bd:	89 f0                	mov    %esi,%eax
801014bf:	5b                   	pop    %ebx
801014c0:	5e                   	pop    %esi
801014c1:	5f                   	pop    %edi
801014c2:	5d                   	pop    %ebp
801014c3:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
801014c4:	8b 47 0c             	mov    0xc(%edi),%eax
801014c7:	89 45 08             	mov    %eax,0x8(%ebp)
}
801014ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014cd:	5b                   	pop    %ebx
801014ce:	5e                   	pop    %esi
801014cf:	5f                   	pop    %edi
801014d0:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801014d1:	e9 7a 26 00 00       	jmp    80103b50 <pipewrite>
  panic("filewrite");
801014d6:	83 ec 0c             	sub    $0xc,%esp
801014d9:	68 f8 80 10 80       	push   $0x801080f8
801014de:	e8 cd ef ff ff       	call   801004b0 <panic>
801014e3:	66 90                	xchg   %ax,%ax
801014e5:	66 90                	xchg   %ax,%ax
801014e7:	66 90                	xchg   %ax,%ax
801014e9:	66 90                	xchg   %ax,%ax
801014eb:	66 90                	xchg   %ax,%ax
801014ed:	66 90                	xchg   %ax,%ax
801014ef:	90                   	nop

801014f0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801014f0:	55                   	push   %ebp
801014f1:	89 e5                	mov    %esp,%ebp
801014f3:	57                   	push   %edi
801014f4:	56                   	push   %esi
801014f5:	53                   	push   %ebx
801014f6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;
  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801014f9:	8b 0d 80 26 11 80    	mov    0x80112680,%ecx
{
801014ff:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101502:	85 c9                	test   %ecx,%ecx
80101504:	0f 84 82 00 00 00    	je     8010158c <balloc+0x9c>
8010150a:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101511:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101514:	83 ec 08             	sub    $0x8,%esp
80101517:	89 d8                	mov    %ebx,%eax
80101519:	c1 f8 0c             	sar    $0xc,%eax
8010151c:	03 05 98 26 11 80    	add    0x80112698,%eax
80101522:	50                   	push   %eax
80101523:	ff 75 dc             	push   -0x24(%ebp)
80101526:	e8 25 ec ff ff       	call   80100150 <bread>
8010152b:	83 c4 10             	add    $0x10,%esp
8010152e:	89 c2                	mov    %eax,%edx
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101530:	a1 80 26 11 80       	mov    0x80112680,%eax
80101535:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101538:	31 c0                	xor    %eax,%eax
8010153a:	eb 2b                	jmp    80101567 <balloc+0x77>
8010153c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m = 1 << (bi % 8);
80101540:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101542:	89 c6                	mov    %eax,%esi
      m = 1 << (bi % 8);
80101544:	bf 01 00 00 00       	mov    $0x1,%edi
80101549:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010154c:	c1 fe 03             	sar    $0x3,%esi
      m = 1 << (bi % 8);
8010154f:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101551:	0f b6 4c 32 5c       	movzbl 0x5c(%edx,%esi,1),%ecx
80101556:	85 f9                	test   %edi,%ecx
80101558:	74 46                	je     801015a0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010155a:	83 c0 01             	add    $0x1,%eax
8010155d:	83 c3 01             	add    $0x1,%ebx
80101560:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101565:	74 07                	je     8010156e <balloc+0x7e>
80101567:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010156a:	39 fb                	cmp    %edi,%ebx
8010156c:	72 d2                	jb     80101540 <balloc+0x50>
        bzero(dev, b + bi);
        end_op();
        return b + bi;
      }
    }
    brelse(bp);
8010156e:	83 ec 0c             	sub    $0xc,%esp
80101571:	52                   	push   %edx
80101572:	e8 59 ec ff ff       	call   801001d0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101577:	81 45 e0 00 10 00 00 	addl   $0x1000,-0x20(%ebp)
8010157e:	83 c4 10             	add    $0x10,%esp
80101581:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101584:	3b 05 80 26 11 80    	cmp    0x80112680,%eax
8010158a:	72 85                	jb     80101511 <balloc+0x21>
  }
  panic("balloc: out of blocks");
8010158c:	83 ec 0c             	sub    $0xc,%esp
8010158f:	68 02 81 10 80       	push   $0x80108102
80101594:	e8 17 ef ff ff       	call   801004b0 <panic>
80101599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        begin_op();
801015a0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801015a3:	e8 f8 1c 00 00       	call   801032a0 <begin_op>
        bp->data[bi/8] |= m;  // Mark block in use.
801015a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
        log_write(bp);
801015ab:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801015ae:	89 f8                	mov    %edi,%eax
801015b0:	08 44 32 5c          	or     %al,0x5c(%edx,%esi,1)
        log_write(bp);
801015b4:	52                   	push   %edx
801015b5:	e8 c6 1e 00 00       	call   80103480 <log_write>
        brelse(bp);
801015ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015bd:	89 14 24             	mov    %edx,(%esp)
801015c0:	e8 0b ec ff ff       	call   801001d0 <brelse>
  bp = bread(dev, bno);
801015c5:	58                   	pop    %eax
801015c6:	5a                   	pop    %edx
801015c7:	53                   	push   %ebx
801015c8:	ff 75 dc             	push   -0x24(%ebp)
801015cb:	e8 80 eb ff ff       	call   80100150 <bread>
  memset(bp->data, 0, BSIZE);
801015d0:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801015d3:	89 c6                	mov    %eax,%esi
  memset(bp->data, 0, BSIZE);
801015d5:	8d 40 5c             	lea    0x5c(%eax),%eax
801015d8:	68 00 02 00 00       	push   $0x200
801015dd:	6a 00                	push   $0x0
801015df:	50                   	push   %eax
801015e0:	e8 bb 36 00 00       	call   80104ca0 <memset>
  log_write(bp);
801015e5:	89 34 24             	mov    %esi,(%esp)
801015e8:	e8 93 1e 00 00       	call   80103480 <log_write>
  brelse(bp);
801015ed:	89 34 24             	mov    %esi,(%esp)
801015f0:	e8 db eb ff ff       	call   801001d0 <brelse>
        end_op();
801015f5:	e8 16 1d 00 00       	call   80103310 <end_op>
}
801015fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015fd:	89 d8                	mov    %ebx,%eax
801015ff:	5b                   	pop    %ebx
80101600:	5e                   	pop    %esi
80101601:	5f                   	pop    %edi
80101602:	5d                   	pop    %ebp
80101603:	c3                   	ret
80101604:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010160b:	00 
8010160c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101610 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101614:	31 ff                	xor    %edi,%edi
{
80101616:	56                   	push   %esi
80101617:	89 c6                	mov    %eax,%esi
80101619:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010161a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010161f:	83 ec 28             	sub    $0x28,%esp
80101622:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101625:	68 60 09 11 80       	push   $0x80110960
8010162a:	e8 a1 34 00 00       	call   80104ad0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010162f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101632:	83 c4 10             	add    $0x10,%esp
80101635:	eb 1c                	jmp    80101653 <iget+0x43>
80101637:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010163e:	00 
8010163f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101640:	39 73 04             	cmp    %esi,0x4(%ebx)
80101643:	74 73                	je     801016b8 <iget+0xa8>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101645:	81 c3 94 00 00 00    	add    $0x94,%ebx
8010164b:	81 fb 7c 26 11 80    	cmp    $0x8011267c,%ebx
80101651:	74 2d                	je     80101680 <iget+0x70>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101653:	8b 43 0c             	mov    0xc(%ebx),%eax
80101656:	85 c0                	test   %eax,%eax
80101658:	7f e6                	jg     80101640 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
8010165a:	85 ff                	test   %edi,%edi
8010165c:	75 e7                	jne    80101645 <iget+0x35>
8010165e:	85 c0                	test   %eax,%eax
80101660:	75 7d                	jne    801016df <iget+0xcf>
      empty = ip;
80101662:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101664:	81 c3 94 00 00 00    	add    $0x94,%ebx
8010166a:	81 fb 7c 26 11 80    	cmp    $0x8011267c,%ebx
80101670:	75 e1                	jne    80101653 <iget+0x43>
80101672:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101679:	00 
8010167a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101680:	85 ff                	test   %edi,%edi
80101682:	74 79                	je     801016fd <iget+0xed>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101684:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101687:	89 77 04             	mov    %esi,0x4(%edi)
  ip->inum = inum;
8010168a:	89 57 08             	mov    %edx,0x8(%edi)
  ip->ref = 1;
8010168d:	c7 47 0c 01 00 00 00 	movl   $0x1,0xc(%edi)
  ip->valid = 0;
80101694:	c7 47 50 00 00 00 00 	movl   $0x0,0x50(%edi)
  release(&icache.lock);
8010169b:	68 60 09 11 80       	push   $0x80110960
801016a0:	e8 ab 35 00 00       	call   80104c50 <release>

  return ip;
801016a5:	83 c4 10             	add    $0x10,%esp
}
801016a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016ab:	89 f8                	mov    %edi,%eax
801016ad:	5b                   	pop    %ebx
801016ae:	5e                   	pop    %esi
801016af:	5f                   	pop    %edi
801016b0:	5d                   	pop    %ebp
801016b1:	c3                   	ret
801016b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801016b8:	39 53 08             	cmp    %edx,0x8(%ebx)
801016bb:	75 88                	jne    80101645 <iget+0x35>
      ip->ref++;
801016bd:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
801016c0:	83 ec 0c             	sub    $0xc,%esp
      return ip;
801016c3:	89 df                	mov    %ebx,%edi
      ip->ref++;
801016c5:	89 43 0c             	mov    %eax,0xc(%ebx)
      release(&icache.lock);
801016c8:	68 60 09 11 80       	push   $0x80110960
801016cd:	e8 7e 35 00 00       	call   80104c50 <release>
      return ip;
801016d2:	83 c4 10             	add    $0x10,%esp
}
801016d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016d8:	89 f8                	mov    %edi,%eax
801016da:	5b                   	pop    %ebx
801016db:	5e                   	pop    %esi
801016dc:	5f                   	pop    %edi
801016dd:	5d                   	pop    %ebp
801016de:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801016df:	81 c3 94 00 00 00    	add    $0x94,%ebx
801016e5:	81 fb 7c 26 11 80    	cmp    $0x8011267c,%ebx
801016eb:	74 10                	je     801016fd <iget+0xed>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801016ed:	8b 43 0c             	mov    0xc(%ebx),%eax
801016f0:	85 c0                	test   %eax,%eax
801016f2:	0f 8f 48 ff ff ff    	jg     80101640 <iget+0x30>
801016f8:	e9 61 ff ff ff       	jmp    8010165e <iget+0x4e>
    panic("iget: no inodes");
801016fd:	83 ec 0c             	sub    $0xc,%esp
80101700:	68 18 81 10 80       	push   $0x80108118
80101705:	e8 a6 ed ff ff       	call   801004b0 <panic>
8010170a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101710 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101710:	55                   	push   %ebp
80101711:	89 e5                	mov    %esp,%ebp
80101713:	57                   	push   %edi
80101714:	56                   	push   %esi
80101715:	89 c6                	mov    %eax,%esi
80101717:	53                   	push   %ebx
80101718:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010171b:	83 fa 0b             	cmp    $0xb,%edx
8010171e:	0f 86 8c 00 00 00    	jbe    801017b0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101724:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101727:	83 fb 7f             	cmp    $0x7f,%ebx
8010172a:	0f 87 a1 00 00 00    	ja     801017d1 <bmap+0xc1>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101730:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80101736:	85 c0                	test   %eax,%eax
80101738:	74 5e                	je     80101798 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010173a:	83 ec 08             	sub    $0x8,%esp
8010173d:	50                   	push   %eax
8010173e:	ff 76 04             	push   0x4(%esi)
80101741:	e8 0a ea ff ff       	call   80100150 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101746:	83 c4 10             	add    $0x10,%esp
80101749:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010174d:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010174f:	8b 3b                	mov    (%ebx),%edi
80101751:	85 ff                	test   %edi,%edi
80101753:	74 1b                	je     80101770 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101755:	83 ec 0c             	sub    $0xc,%esp
80101758:	52                   	push   %edx
80101759:	e8 72 ea ff ff       	call   801001d0 <brelse>
8010175e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101761:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101764:	89 f8                	mov    %edi,%eax
80101766:	5b                   	pop    %ebx
80101767:	5e                   	pop    %esi
80101768:	5f                   	pop    %edi
80101769:	5d                   	pop    %ebp
8010176a:	c3                   	ret
8010176b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101770:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101773:	8b 46 04             	mov    0x4(%esi),%eax
80101776:	e8 75 fd ff ff       	call   801014f0 <balloc>
      log_write(bp);
8010177b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010177e:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101781:	89 03                	mov    %eax,(%ebx)
80101783:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101785:	52                   	push   %edx
80101786:	e8 f5 1c 00 00       	call   80103480 <log_write>
8010178b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010178e:	83 c4 10             	add    $0x10,%esp
80101791:	eb c2                	jmp    80101755 <bmap+0x45>
80101793:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101798:	8b 46 04             	mov    0x4(%esi),%eax
8010179b:	e8 50 fd ff ff       	call   801014f0 <balloc>
801017a0:	89 86 90 00 00 00    	mov    %eax,0x90(%esi)
801017a6:	eb 92                	jmp    8010173a <bmap+0x2a>
801017a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801017af:	00 
    if((addr = ip->addrs[bn]) == 0)
801017b0:	8d 5a 18             	lea    0x18(%edx),%ebx
801017b3:	8b 3c 98             	mov    (%eax,%ebx,4),%edi
801017b6:	85 ff                	test   %edi,%edi
801017b8:	75 a7                	jne    80101761 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
801017ba:	8b 40 04             	mov    0x4(%eax),%eax
801017bd:	e8 2e fd ff ff       	call   801014f0 <balloc>
801017c2:	89 04 9e             	mov    %eax,(%esi,%ebx,4)
801017c5:	89 c7                	mov    %eax,%edi
}
801017c7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017ca:	5b                   	pop    %ebx
801017cb:	89 f8                	mov    %edi,%eax
801017cd:	5e                   	pop    %esi
801017ce:	5f                   	pop    %edi
801017cf:	5d                   	pop    %ebp
801017d0:	c3                   	ret
  panic("bmap: out of range");
801017d1:	83 ec 0c             	sub    $0xc,%esp
801017d4:	68 28 81 10 80       	push   $0x80108128
801017d9:	e8 d2 ec ff ff       	call   801004b0 <panic>
801017de:	66 90                	xchg   %ax,%ax

801017e0 <bfree>:
{
801017e0:	55                   	push   %ebp
801017e1:	89 e5                	mov    %esp,%ebp
801017e3:	57                   	push   %edi
801017e4:	56                   	push   %esi
801017e5:	89 c6                	mov    %eax,%esi
801017e7:	53                   	push   %ebx
801017e8:	89 d3                	mov    %edx,%ebx
801017ea:	83 ec 14             	sub    $0x14,%esp
  bp = bread(dev, 1);
801017ed:	6a 01                	push   $0x1
801017ef:	50                   	push   %eax
801017f0:	e8 5b e9 ff ff       	call   80100150 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801017f5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801017f8:	89 c7                	mov    %eax,%edi
  memmove(sb, bp->data, sizeof(*sb));
801017fa:	83 c0 5c             	add    $0x5c,%eax
801017fd:	6a 1c                	push   $0x1c
801017ff:	50                   	push   %eax
80101800:	68 80 26 11 80       	push   $0x80112680
80101805:	e8 26 35 00 00       	call   80104d30 <memmove>
  brelse(bp);
8010180a:	89 3c 24             	mov    %edi,(%esp)
8010180d:	e8 be e9 ff ff       	call   801001d0 <brelse>
  bp = bread(dev, BBLOCK(b, sb));
80101812:	58                   	pop    %eax
80101813:	89 d8                	mov    %ebx,%eax
80101815:	5a                   	pop    %edx
80101816:	c1 e8 0c             	shr    $0xc,%eax
80101819:	03 05 98 26 11 80    	add    0x80112698,%eax
8010181f:	50                   	push   %eax
80101820:	56                   	push   %esi
80101821:	e8 2a e9 ff ff       	call   80100150 <bread>
  m = 1 << (bi % 8);
80101826:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101828:	c1 fb 03             	sar    $0x3,%ebx
8010182b:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
8010182e:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101830:	83 e1 07             	and    $0x7,%ecx
80101833:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101838:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
8010183e:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101840:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101845:	85 c1                	test   %eax,%ecx
80101847:	74 24                	je     8010186d <bfree+0x8d>
  bp->data[bi/8] &= ~m;
80101849:	f7 d0                	not    %eax
  bwrite(bp);
8010184b:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
8010184e:	21 c8                	and    %ecx,%eax
80101850:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  bwrite(bp);
80101854:	56                   	push   %esi
80101855:	e8 36 e9 ff ff       	call   80100190 <bwrite>
  brelse(bp);
8010185a:	89 34 24             	mov    %esi,(%esp)
8010185d:	e8 6e e9 ff ff       	call   801001d0 <brelse>
}
80101862:	83 c4 10             	add    $0x10,%esp
80101865:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101868:	5b                   	pop    %ebx
80101869:	5e                   	pop    %esi
8010186a:	5f                   	pop    %edi
8010186b:	5d                   	pop    %ebp
8010186c:	c3                   	ret
    panic("freeing free block");
8010186d:	83 ec 0c             	sub    $0xc,%esp
80101870:	68 3b 81 10 80       	push   $0x8010813b
80101875:	e8 36 ec ff ff       	call   801004b0 <panic>
8010187a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101880 <readsb>:
{
80101880:	55                   	push   %ebp
80101881:	89 e5                	mov    %esp,%ebp
80101883:	56                   	push   %esi
80101884:	53                   	push   %ebx
80101885:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101888:	83 ec 08             	sub    $0x8,%esp
8010188b:	6a 01                	push   $0x1
8010188d:	ff 75 08             	push   0x8(%ebp)
80101890:	e8 bb e8 ff ff       	call   80100150 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101895:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101898:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010189a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010189d:	6a 1c                	push   $0x1c
8010189f:	50                   	push   %eax
801018a0:	56                   	push   %esi
801018a1:	e8 8a 34 00 00       	call   80104d30 <memmove>
  brelse(bp);
801018a6:	83 c4 10             	add    $0x10,%esp
801018a9:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801018ac:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018af:	5b                   	pop    %ebx
801018b0:	5e                   	pop    %esi
801018b1:	5d                   	pop    %ebp
  brelse(bp);
801018b2:	e9 19 e9 ff ff       	jmp    801001d0 <brelse>
801018b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018be:	00 
801018bf:	90                   	nop

801018c0 <balloc_page>:
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	57                   	push   %edi
801018c4:	56                   	push   %esi
801018c5:	53                   	push   %ebx
801018c6:	8d 84 24 00 f0 f9 ff 	lea    -0x61000(%esp),%eax
801018cd:	81 ec 00 10 00 00    	sub    $0x1000,%esp
801018d3:	83 0c 24 00          	orl    $0x0,(%esp)
801018d7:	39 c4                	cmp    %eax,%esp
801018d9:	75 f2                	jne    801018cd <balloc_page+0xd>
801018db:	81 ec 9c 0a 00 00    	sub    $0xa9c,%esp
      allocatedBlocks[indexNCB] = balloc(dev);
801018e1:	31 ff                	xor    %edi,%edi
801018e3:	8b 45 08             	mov    0x8(%ebp),%eax
801018e6:	e8 05 fc ff ff       	call   801014f0 <balloc>
801018eb:	8d 9d 68 e5 f9 ff    	lea    -0x61a98(%ebp),%ebx
  for(int i=0;i<8;i++){
801018f1:	c7 85 64 e5 f9 ff 01 	movl   $0x1,-0x61a9c(%ebp)
801018f8:	00 00 00 
      allocatedBlocks[indexNCB] = balloc(dev);
801018fb:	89 85 68 e5 f9 ff    	mov    %eax,-0x61a98(%ebp)
80101901:	8b 45 08             	mov    0x8(%ebp),%eax
      indexNCB++;
80101904:	8d 77 01             	lea    0x1(%edi),%esi
      allocatedBlocks[indexNCB] = balloc(dev);
80101907:	e8 e4 fb ff ff       	call   801014f0 <balloc>
8010190c:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
          if((allocatedBlocks[indexNCB]-allocatedBlocks[indexNCB-1])!=1)  //this allocated block in non consecutive
8010190f:	2b 44 b3 fc          	sub    -0x4(%ebx,%esi,4),%eax
80101913:	83 f8 01             	cmp    $0x1,%eax
80101916:	74 28                	je     80101940 <balloc_page+0x80>
      allocatedBlocks[indexNCB] = balloc(dev);
80101918:	8b 45 08             	mov    0x8(%ebp),%eax
      indexNCB++;
8010191b:	83 c6 01             	add    $0x1,%esi
      allocatedBlocks[indexNCB] = balloc(dev);
8010191e:	e8 cd fb ff ff       	call   801014f0 <balloc>
  for(int i=0;i<8;i++){
80101923:	c7 85 64 e5 f9 ff 02 	movl   $0x2,-0x61a9c(%ebp)
8010192a:	00 00 00 
      allocatedBlocks[indexNCB] = balloc(dev);
8010192d:	89 04 b3             	mov    %eax,(%ebx,%esi,4)
          if((allocatedBlocks[indexNCB]-allocatedBlocks[indexNCB-1])!=1)  //this allocated block in non consecutive
80101930:	2b 44 b3 fc          	sub    -0x4(%ebx,%esi,4),%eax
80101934:	83 f8 01             	cmp    $0x1,%eax
80101937:	75 df                	jne    80101918 <balloc_page+0x58>
  for(int i=0;i<8;i++){
80101939:	89 f7                	mov    %esi,%edi
8010193b:	eb c4                	jmp    80101901 <balloc_page+0x41>
8010193d:	8d 76 00             	lea    0x0(%esi),%esi
80101940:	83 85 64 e5 f9 ff 01 	addl   $0x1,-0x61a9c(%ebp)
80101947:	8b 85 64 e5 f9 ff    	mov    -0x61a9c(%ebp),%eax
8010194d:	83 f8 08             	cmp    $0x8,%eax
80101950:	75 e7                	jne    80101939 <balloc_page+0x79>
    for(int i=0;i<=indexNCB-8;i++){
80101952:	8d 77 fa             	lea    -0x6(%edi),%esi
80101955:	85 f6                	test   %esi,%esi
80101957:	7e 1a                	jle    80101973 <balloc_page+0xb3>
80101959:	8d bc bd 50 e5 f9 ff 	lea    -0x61ab0(%ebp,%edi,4),%edi
      bfree(ROOTDEV,allocatedBlocks[i]);    //free unnecesarily allocated blocks
80101960:	8b 13                	mov    (%ebx),%edx
80101962:	b8 01 00 00 00       	mov    $0x1,%eax
    for(int i=0;i<=indexNCB-8;i++){
80101967:	83 c3 04             	add    $0x4,%ebx
      bfree(ROOTDEV,allocatedBlocks[i]);    //free unnecesarily allocated blocks
8010196a:	e8 71 fe ff ff       	call   801017e0 <bfree>
    for(int i=0;i<=indexNCB-8;i++){
8010196f:	39 fb                	cmp    %edi,%ebx
80101971:	75 ed                	jne    80101960 <balloc_page+0xa0>
	  return allocatedBlocks[indexNCB-7];  //return last 8 blocks (address of 1st block among them)
80101973:	8b 84 b5 68 e5 f9 ff 	mov    -0x61a98(%ebp,%esi,4),%eax
    numallocblocks+=1;      //*****************
8010197a:	83 05 7c 26 11 80 01 	addl   $0x1,0x8011267c
}
80101981:	81 c4 9c 1a 06 00    	add    $0x61a9c,%esp
80101987:	5b                   	pop    %ebx
80101988:	5e                   	pop    %esi
80101989:	5f                   	pop    %edi
8010198a:	5d                   	pop    %ebp
8010198b:	c3                   	ret
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101990 <bfree_page>:
{ //*******************xv7*****************
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	56                   	push   %esi
80101994:	53                   	push   %ebx
80101995:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80101998:	8d 73 08             	lea    0x8(%ebx),%esi
8010199b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    bfree(ROOTDEV,b+i);
801019a0:	89 da                	mov    %ebx,%edx
801019a2:	b8 01 00 00 00       	mov    $0x1,%eax
  for(uint i=0;i<8;i++){
801019a7:	83 c3 01             	add    $0x1,%ebx
    bfree(ROOTDEV,b+i);
801019aa:	e8 31 fe ff ff       	call   801017e0 <bfree>
  for(uint i=0;i<8;i++){
801019af:	39 f3                	cmp    %esi,%ebx
801019b1:	75 ed                	jne    801019a0 <bfree_page+0x10>
}
801019b3:	5b                   	pop    %ebx
  numallocblocks-=1;      //*****************
801019b4:	83 2d 7c 26 11 80 01 	subl   $0x1,0x8011267c
}
801019bb:	5e                   	pop    %esi
801019bc:	5d                   	pop    %ebp
801019bd:	c3                   	ret
801019be:	66 90                	xchg   %ax,%ax

801019c0 <iinit>:
{
801019c0:	55                   	push   %ebp
801019c1:	89 e5                	mov    %esp,%ebp
801019c3:	56                   	push   %esi
801019c4:	53                   	push   %ebx
801019c5:	8b 75 08             	mov    0x8(%ebp),%esi
801019c8:	bb a4 09 11 80       	mov    $0x801109a4,%ebx
  initlock(&icache.lock, "icache");
801019cd:	83 ec 08             	sub    $0x8,%esp
801019d0:	68 4e 81 10 80       	push   $0x8010814e
801019d5:	68 60 09 11 80       	push   $0x80110960
801019da:	e8 a1 2f 00 00       	call   80104980 <initlock>
  for(i = 0; i < NINODE; i++) {
801019df:	83 c4 10             	add    $0x10,%esp
801019e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801019e9:	00 
801019ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
801019f0:	83 ec 08             	sub    $0x8,%esp
801019f3:	68 55 81 10 80       	push   $0x80108155
801019f8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801019f9:	81 c3 94 00 00 00    	add    $0x94,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801019ff:	e8 6c 2e 00 00       	call   80104870 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101a04:	83 c4 10             	add    $0x10,%esp
80101a07:	81 fb 8c 26 11 80    	cmp    $0x8011268c,%ebx
80101a0d:	75 e1                	jne    801019f0 <iinit+0x30>
  bp = bread(dev, 1);
80101a0f:	83 ec 08             	sub    $0x8,%esp
80101a12:	6a 01                	push   $0x1
80101a14:	56                   	push   %esi
80101a15:	e8 36 e7 ff ff       	call   80100150 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101a1a:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101a1d:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101a1f:	8d 40 5c             	lea    0x5c(%eax),%eax
80101a22:	6a 1c                	push   $0x1c
80101a24:	50                   	push   %eax
80101a25:	68 80 26 11 80       	push   $0x80112680
80101a2a:	e8 01 33 00 00       	call   80104d30 <memmove>
  brelse(bp);
80101a2f:	89 1c 24             	mov    %ebx,(%esp)
80101a32:	e8 99 e7 ff ff       	call   801001d0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101a37:	ff 35 98 26 11 80    	push   0x80112698
80101a3d:	ff 35 94 26 11 80    	push   0x80112694
80101a43:	ff 35 90 26 11 80    	push   0x80112690
80101a49:	ff 35 8c 26 11 80    	push   0x8011268c
80101a4f:	ff 35 88 26 11 80    	push   0x80112688
80101a55:	ff 35 84 26 11 80    	push   0x80112684
80101a5b:	ff 35 80 26 11 80    	push   0x80112680
80101a61:	68 1c 86 10 80       	push   $0x8010861c
80101a66:	e8 85 ed ff ff       	call   801007f0 <cprintf>
  cprintf("Root mounted! (ide disk 1)\n");
80101a6b:	83 c4 30             	add    $0x30,%esp
80101a6e:	c7 45 08 5b 81 10 80 	movl   $0x8010815b,0x8(%ebp)
}
80101a75:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a78:	5b                   	pop    %ebx
80101a79:	5e                   	pop    %esi
80101a7a:	5d                   	pop    %ebp
  cprintf("Root mounted! (ide disk 1)\n");
80101a7b:	e9 70 ed ff ff       	jmp    801007f0 <cprintf>

80101a80 <ialloc>:
{
80101a80:	55                   	push   %ebp
80101a81:	89 e5                	mov    %esp,%ebp
80101a83:	57                   	push   %edi
80101a84:	56                   	push   %esi
80101a85:	53                   	push   %ebx
80101a86:	83 ec 1c             	sub    $0x1c,%esp
80101a89:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101a8c:	83 3d 88 26 11 80 01 	cmpl   $0x1,0x80112688
{
80101a93:	8b 75 08             	mov    0x8(%ebp),%esi
80101a96:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101a99:	0f 86 91 00 00 00    	jbe    80101b30 <ialloc+0xb0>
80101a9f:	bf 01 00 00 00       	mov    $0x1,%edi
80101aa4:	eb 21                	jmp    80101ac7 <ialloc+0x47>
80101aa6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101aad:	00 
80101aae:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101ab0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101ab3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101ab6:	53                   	push   %ebx
80101ab7:	e8 14 e7 ff ff       	call   801001d0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101abc:	83 c4 10             	add    $0x10,%esp
80101abf:	3b 3d 88 26 11 80    	cmp    0x80112688,%edi
80101ac5:	73 69                	jae    80101b30 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101ac7:	89 f8                	mov    %edi,%eax
80101ac9:	83 ec 08             	sub    $0x8,%esp
80101acc:	c1 e8 03             	shr    $0x3,%eax
80101acf:	03 05 94 26 11 80    	add    0x80112694,%eax
80101ad5:	50                   	push   %eax
80101ad6:	56                   	push   %esi
80101ad7:	e8 74 e6 ff ff       	call   80100150 <bread>
    if(dip->type == 0){  // a free inode
80101adc:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101adf:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101ae1:	89 f8                	mov    %edi,%eax
80101ae3:	83 e0 07             	and    $0x7,%eax
80101ae6:	c1 e0 06             	shl    $0x6,%eax
80101ae9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101aed:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101af1:	75 bd                	jne    80101ab0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101af3:	83 ec 04             	sub    $0x4,%esp
80101af6:	6a 40                	push   $0x40
80101af8:	6a 00                	push   $0x0
80101afa:	51                   	push   %ecx
80101afb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101afe:	e8 9d 31 00 00       	call   80104ca0 <memset>
      dip->type = type;
80101b03:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101b07:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b0a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101b0d:	89 1c 24             	mov    %ebx,(%esp)
80101b10:	e8 6b 19 00 00       	call   80103480 <log_write>
      brelse(bp);
80101b15:	89 1c 24             	mov    %ebx,(%esp)
80101b18:	e8 b3 e6 ff ff       	call   801001d0 <brelse>
      return iget(dev, inum);
80101b1d:	83 c4 10             	add    $0x10,%esp
}
80101b20:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101b23:	89 fa                	mov    %edi,%edx
}
80101b25:	5b                   	pop    %ebx
      return iget(dev, inum);
80101b26:	89 f0                	mov    %esi,%eax
}
80101b28:	5e                   	pop    %esi
80101b29:	5f                   	pop    %edi
80101b2a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101b2b:	e9 e0 fa ff ff       	jmp    80101610 <iget>
  panic("ialloc: no inodes");
80101b30:	83 ec 0c             	sub    $0xc,%esp
80101b33:	68 77 81 10 80       	push   $0x80108177
80101b38:	e8 73 e9 ff ff       	call   801004b0 <panic>
80101b3d:	8d 76 00             	lea    0x0(%esi),%esi

80101b40 <iupdate>:
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	56                   	push   %esi
80101b44:	53                   	push   %ebx
80101b45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b48:	8b 43 08             	mov    0x8(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101b4b:	83 c3 60             	add    $0x60,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b4e:	83 ec 08             	sub    $0x8,%esp
80101b51:	c1 e8 03             	shr    $0x3,%eax
80101b54:	03 05 94 26 11 80    	add    0x80112694,%eax
80101b5a:	50                   	push   %eax
80101b5b:	ff 73 a4             	push   -0x5c(%ebx)
80101b5e:	e8 ed e5 ff ff       	call   80100150 <bread>
  dip->type = ip->type;
80101b63:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101b67:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b6a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101b6c:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101b6f:	83 e0 07             	and    $0x7,%eax
80101b72:	c1 e0 06             	shl    $0x6,%eax
80101b75:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101b79:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101b7c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101b80:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101b83:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101b87:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101b8b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101b8f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101b93:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101b97:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101b9a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101b9d:	6a 34                	push   $0x34
80101b9f:	53                   	push   %ebx
80101ba0:	50                   	push   %eax
80101ba1:	e8 8a 31 00 00       	call   80104d30 <memmove>
  log_write(bp);
80101ba6:	89 34 24             	mov    %esi,(%esp)
80101ba9:	e8 d2 18 00 00       	call   80103480 <log_write>
  brelse(bp);
80101bae:	83 c4 10             	add    $0x10,%esp
80101bb1:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101bb4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101bb7:	5b                   	pop    %ebx
80101bb8:	5e                   	pop    %esi
80101bb9:	5d                   	pop    %ebp
  brelse(bp);
80101bba:	e9 11 e6 ff ff       	jmp    801001d0 <brelse>
80101bbf:	90                   	nop

80101bc0 <idup>:
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	53                   	push   %ebx
80101bc4:	83 ec 10             	sub    $0x10,%esp
80101bc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101bca:	68 60 09 11 80       	push   $0x80110960
80101bcf:	e8 fc 2e 00 00       	call   80104ad0 <acquire>
  ip->ref++;
80101bd4:	83 43 0c 01          	addl   $0x1,0xc(%ebx)
  release(&icache.lock);
80101bd8:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101bdf:	e8 6c 30 00 00       	call   80104c50 <release>
}
80101be4:	89 d8                	mov    %ebx,%eax
80101be6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101be9:	c9                   	leave
80101bea:	c3                   	ret
80101beb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101bf0 <ilock>:
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	56                   	push   %esi
80101bf4:	53                   	push   %ebx
80101bf5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101bf8:	85 db                	test   %ebx,%ebx
80101bfa:	0f 84 b8 00 00 00    	je     80101cb8 <ilock+0xc8>
80101c00:	8b 53 0c             	mov    0xc(%ebx),%edx
80101c03:	85 d2                	test   %edx,%edx
80101c05:	0f 8e ad 00 00 00    	jle    80101cb8 <ilock+0xc8>
  acquiresleep(&ip->lock);
80101c0b:	83 ec 0c             	sub    $0xc,%esp
80101c0e:	8d 43 10             	lea    0x10(%ebx),%eax
80101c11:	50                   	push   %eax
80101c12:	e8 99 2c 00 00       	call   801048b0 <acquiresleep>
  if(ip->valid == 0){
80101c17:	8b 43 50             	mov    0x50(%ebx),%eax
80101c1a:	83 c4 10             	add    $0x10,%esp
80101c1d:	85 c0                	test   %eax,%eax
80101c1f:	74 0f                	je     80101c30 <ilock+0x40>
}
80101c21:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c24:	5b                   	pop    %ebx
80101c25:	5e                   	pop    %esi
80101c26:	5d                   	pop    %ebp
80101c27:	c3                   	ret
80101c28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c2f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c30:	8b 43 08             	mov    0x8(%ebx),%eax
80101c33:	83 ec 08             	sub    $0x8,%esp
80101c36:	c1 e8 03             	shr    $0x3,%eax
80101c39:	03 05 94 26 11 80    	add    0x80112694,%eax
80101c3f:	50                   	push   %eax
80101c40:	ff 73 04             	push   0x4(%ebx)
80101c43:	e8 08 e5 ff ff       	call   80100150 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101c48:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c4b:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101c4d:	8b 43 08             	mov    0x8(%ebx),%eax
80101c50:	83 e0 07             	and    $0x7,%eax
80101c53:	c1 e0 06             	shl    $0x6,%eax
80101c56:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101c5a:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101c5d:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101c60:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->major = dip->major;
80101c64:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101c68:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->minor = dip->minor;
80101c6c:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101c70:	66 89 53 58          	mov    %dx,0x58(%ebx)
    ip->nlink = dip->nlink;
80101c74:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101c78:	66 89 53 5a          	mov    %dx,0x5a(%ebx)
    ip->size = dip->size;
80101c7c:	8b 50 fc             	mov    -0x4(%eax),%edx
80101c7f:	89 53 5c             	mov    %edx,0x5c(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101c82:	6a 34                	push   $0x34
80101c84:	50                   	push   %eax
80101c85:	8d 43 60             	lea    0x60(%ebx),%eax
80101c88:	50                   	push   %eax
80101c89:	e8 a2 30 00 00       	call   80104d30 <memmove>
    brelse(bp);
80101c8e:	89 34 24             	mov    %esi,(%esp)
80101c91:	e8 3a e5 ff ff       	call   801001d0 <brelse>
    if(ip->type == 0)
80101c96:	83 c4 10             	add    $0x10,%esp
80101c99:	66 83 7b 54 00       	cmpw   $0x0,0x54(%ebx)
    ip->valid = 1;
80101c9e:	c7 43 50 01 00 00 00 	movl   $0x1,0x50(%ebx)
    if(ip->type == 0)
80101ca5:	0f 85 76 ff ff ff    	jne    80101c21 <ilock+0x31>
      panic("ilock: no type");
80101cab:	83 ec 0c             	sub    $0xc,%esp
80101cae:	68 8f 81 10 80       	push   $0x8010818f
80101cb3:	e8 f8 e7 ff ff       	call   801004b0 <panic>
    panic("ilock");
80101cb8:	83 ec 0c             	sub    $0xc,%esp
80101cbb:	68 89 81 10 80       	push   $0x80108189
80101cc0:	e8 eb e7 ff ff       	call   801004b0 <panic>
80101cc5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ccc:	00 
80101ccd:	8d 76 00             	lea    0x0(%esi),%esi

80101cd0 <iunlock>:
{
80101cd0:	55                   	push   %ebp
80101cd1:	89 e5                	mov    %esp,%ebp
80101cd3:	56                   	push   %esi
80101cd4:	53                   	push   %ebx
80101cd5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101cd8:	85 db                	test   %ebx,%ebx
80101cda:	74 28                	je     80101d04 <iunlock+0x34>
80101cdc:	83 ec 0c             	sub    $0xc,%esp
80101cdf:	8d 73 10             	lea    0x10(%ebx),%esi
80101ce2:	56                   	push   %esi
80101ce3:	e8 68 2c 00 00       	call   80104950 <holdingsleep>
80101ce8:	83 c4 10             	add    $0x10,%esp
80101ceb:	85 c0                	test   %eax,%eax
80101ced:	74 15                	je     80101d04 <iunlock+0x34>
80101cef:	8b 43 0c             	mov    0xc(%ebx),%eax
80101cf2:	85 c0                	test   %eax,%eax
80101cf4:	7e 0e                	jle    80101d04 <iunlock+0x34>
  releasesleep(&ip->lock);
80101cf6:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101cf9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101cfc:	5b                   	pop    %ebx
80101cfd:	5e                   	pop    %esi
80101cfe:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101cff:	e9 0c 2c 00 00       	jmp    80104910 <releasesleep>
    panic("iunlock");
80101d04:	83 ec 0c             	sub    $0xc,%esp
80101d07:	68 9e 81 10 80       	push   $0x8010819e
80101d0c:	e8 9f e7 ff ff       	call   801004b0 <panic>
80101d11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d18:	00 
80101d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d20 <iput>:
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	57                   	push   %edi
80101d24:	56                   	push   %esi
80101d25:	53                   	push   %ebx
80101d26:	83 ec 28             	sub    $0x28,%esp
80101d29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101d2c:	8d 7b 10             	lea    0x10(%ebx),%edi
80101d2f:	57                   	push   %edi
80101d30:	e8 7b 2b 00 00       	call   801048b0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101d35:	8b 53 50             	mov    0x50(%ebx),%edx
80101d38:	83 c4 10             	add    $0x10,%esp
80101d3b:	85 d2                	test   %edx,%edx
80101d3d:	74 07                	je     80101d46 <iput+0x26>
80101d3f:	66 83 7b 5a 00       	cmpw   $0x0,0x5a(%ebx)
80101d44:	74 32                	je     80101d78 <iput+0x58>
  releasesleep(&ip->lock);
80101d46:	83 ec 0c             	sub    $0xc,%esp
80101d49:	57                   	push   %edi
80101d4a:	e8 c1 2b 00 00       	call   80104910 <releasesleep>
  acquire(&icache.lock);
80101d4f:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101d56:	e8 75 2d 00 00       	call   80104ad0 <acquire>
  ip->ref--;
80101d5b:	83 6b 0c 01          	subl   $0x1,0xc(%ebx)
  release(&icache.lock);
80101d5f:	83 c4 10             	add    $0x10,%esp
80101d62:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
80101d69:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6c:	5b                   	pop    %ebx
80101d6d:	5e                   	pop    %esi
80101d6e:	5f                   	pop    %edi
80101d6f:	5d                   	pop    %ebp
  release(&icache.lock);
80101d70:	e9 db 2e 00 00       	jmp    80104c50 <release>
80101d75:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101d78:	83 ec 0c             	sub    $0xc,%esp
80101d7b:	68 60 09 11 80       	push   $0x80110960
80101d80:	e8 4b 2d 00 00       	call   80104ad0 <acquire>
    int r = ip->ref;
80101d85:	8b 73 0c             	mov    0xc(%ebx),%esi
    release(&icache.lock);
80101d88:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101d8f:	e8 bc 2e 00 00       	call   80104c50 <release>
    if(r == 1){
80101d94:	83 c4 10             	add    $0x10,%esp
80101d97:	83 fe 01             	cmp    $0x1,%esi
80101d9a:	75 aa                	jne    80101d46 <iput+0x26>
80101d9c:	8d 8b 90 00 00 00    	lea    0x90(%ebx),%ecx
80101da2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101da5:	8d 73 60             	lea    0x60(%ebx),%esi
80101da8:	89 df                	mov    %ebx,%edi
80101daa:	89 cb                	mov    %ecx,%ebx
80101dac:	eb 09                	jmp    80101db7 <iput+0x97>
80101dae:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101db0:	83 c6 04             	add    $0x4,%esi
80101db3:	39 de                	cmp    %ebx,%esi
80101db5:	74 19                	je     80101dd0 <iput+0xb0>
    if(ip->addrs[i]){
80101db7:	8b 16                	mov    (%esi),%edx
80101db9:	85 d2                	test   %edx,%edx
80101dbb:	74 f3                	je     80101db0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101dbd:	8b 47 04             	mov    0x4(%edi),%eax
80101dc0:	e8 1b fa ff ff       	call   801017e0 <bfree>
      ip->addrs[i] = 0;
80101dc5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101dcb:	eb e3                	jmp    80101db0 <iput+0x90>
80101dcd:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101dd0:	89 fb                	mov    %edi,%ebx
80101dd2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101dd5:	8b 83 90 00 00 00    	mov    0x90(%ebx),%eax
80101ddb:	85 c0                	test   %eax,%eax
80101ddd:	75 2d                	jne    80101e0c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101ddf:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101de2:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
  iupdate(ip);
80101de9:	53                   	push   %ebx
80101dea:	e8 51 fd ff ff       	call   80101b40 <iupdate>
      ip->type = 0;
80101def:	31 c0                	xor    %eax,%eax
80101df1:	66 89 43 54          	mov    %ax,0x54(%ebx)
      iupdate(ip);
80101df5:	89 1c 24             	mov    %ebx,(%esp)
80101df8:	e8 43 fd ff ff       	call   80101b40 <iupdate>
      ip->valid = 0;
80101dfd:	c7 43 50 00 00 00 00 	movl   $0x0,0x50(%ebx)
80101e04:	83 c4 10             	add    $0x10,%esp
80101e07:	e9 3a ff ff ff       	jmp    80101d46 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101e0c:	83 ec 08             	sub    $0x8,%esp
80101e0f:	50                   	push   %eax
80101e10:	ff 73 04             	push   0x4(%ebx)
80101e13:	e8 38 e3 ff ff       	call   80100150 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101e18:	83 c4 10             	add    $0x10,%esp
80101e1b:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101e1e:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101e24:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101e27:	8d 70 5c             	lea    0x5c(%eax),%esi
80101e2a:	89 cf                	mov    %ecx,%edi
80101e2c:	eb 09                	jmp    80101e37 <iput+0x117>
80101e2e:	66 90                	xchg   %ax,%ax
80101e30:	83 c6 04             	add    $0x4,%esi
80101e33:	39 fe                	cmp    %edi,%esi
80101e35:	74 10                	je     80101e47 <iput+0x127>
      if(a[j])
80101e37:	8b 16                	mov    (%esi),%edx
80101e39:	85 d2                	test   %edx,%edx
80101e3b:	74 f3                	je     80101e30 <iput+0x110>
        bfree(ip->dev, a[j]);
80101e3d:	8b 43 04             	mov    0x4(%ebx),%eax
80101e40:	e8 9b f9 ff ff       	call   801017e0 <bfree>
80101e45:	eb e9                	jmp    80101e30 <iput+0x110>
    brelse(bp);
80101e47:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e4a:	83 ec 0c             	sub    $0xc,%esp
80101e4d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e50:	50                   	push   %eax
80101e51:	e8 7a e3 ff ff       	call   801001d0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e56:	8b 93 90 00 00 00    	mov    0x90(%ebx),%edx
80101e5c:	8b 43 04             	mov    0x4(%ebx),%eax
80101e5f:	e8 7c f9 ff ff       	call   801017e0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101e64:	83 c4 10             	add    $0x10,%esp
80101e67:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80101e6e:	00 00 00 
80101e71:	e9 69 ff ff ff       	jmp    80101ddf <iput+0xbf>
80101e76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e7d:	00 
80101e7e:	66 90                	xchg   %ax,%ax

80101e80 <iunlockput>:
{
80101e80:	55                   	push   %ebp
80101e81:	89 e5                	mov    %esp,%ebp
80101e83:	56                   	push   %esi
80101e84:	53                   	push   %ebx
80101e85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e88:	85 db                	test   %ebx,%ebx
80101e8a:	74 34                	je     80101ec0 <iunlockput+0x40>
80101e8c:	83 ec 0c             	sub    $0xc,%esp
80101e8f:	8d 73 10             	lea    0x10(%ebx),%esi
80101e92:	56                   	push   %esi
80101e93:	e8 b8 2a 00 00       	call   80104950 <holdingsleep>
80101e98:	83 c4 10             	add    $0x10,%esp
80101e9b:	85 c0                	test   %eax,%eax
80101e9d:	74 21                	je     80101ec0 <iunlockput+0x40>
80101e9f:	8b 43 0c             	mov    0xc(%ebx),%eax
80101ea2:	85 c0                	test   %eax,%eax
80101ea4:	7e 1a                	jle    80101ec0 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101ea6:	83 ec 0c             	sub    $0xc,%esp
80101ea9:	56                   	push   %esi
80101eaa:	e8 61 2a 00 00       	call   80104910 <releasesleep>
  iput(ip);
80101eaf:	83 c4 10             	add    $0x10,%esp
80101eb2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101eb5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101eb8:	5b                   	pop    %ebx
80101eb9:	5e                   	pop    %esi
80101eba:	5d                   	pop    %ebp
  iput(ip);
80101ebb:	e9 60 fe ff ff       	jmp    80101d20 <iput>
    panic("iunlock");
80101ec0:	83 ec 0c             	sub    $0xc,%esp
80101ec3:	68 9e 81 10 80       	push   $0x8010819e
80101ec8:	e8 e3 e5 ff ff       	call   801004b0 <panic>
80101ecd:	8d 76 00             	lea    0x0(%esi),%esi

80101ed0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ed0:	55                   	push   %ebp
80101ed1:	89 e5                	mov    %esp,%ebp
80101ed3:	8b 55 08             	mov    0x8(%ebp),%edx
80101ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ed9:	8b 4a 04             	mov    0x4(%edx),%ecx
80101edc:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101edf:	8b 4a 08             	mov    0x8(%edx),%ecx
80101ee2:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101ee5:	0f b7 4a 54          	movzwl 0x54(%edx),%ecx
80101ee9:	66 89 48 02          	mov    %cx,0x2(%eax)
  st->nlink = ip->nlink;
80101eed:	0f b7 4a 5a          	movzwl 0x5a(%edx),%ecx
80101ef1:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101ef5:	8b 52 5c             	mov    0x5c(%edx),%edx
80101ef8:	89 50 10             	mov    %edx,0x10(%eax)
}
80101efb:	5d                   	pop    %ebp
80101efc:	c3                   	ret
80101efd:	8d 76 00             	lea    0x0(%esi),%esi

80101f00 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101f00:	55                   	push   %ebp
80101f01:	89 e5                	mov    %esp,%ebp
80101f03:	57                   	push   %edi
80101f04:	56                   	push   %esi
80101f05:	53                   	push   %ebx
80101f06:	83 ec 1c             	sub    $0x1c,%esp
80101f09:	8b 75 08             	mov    0x8(%ebp),%esi
80101f0c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f0f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f12:	66 83 7e 54 03       	cmpw   $0x3,0x54(%esi)
{
80101f17:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101f1a:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101f1d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101f20:	0f 84 aa 00 00 00    	je     80101fd0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101f26:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101f29:	8b 56 5c             	mov    0x5c(%esi),%edx
80101f2c:	39 fa                	cmp    %edi,%edx
80101f2e:	0f 82 bd 00 00 00    	jb     80101ff1 <readi+0xf1>
80101f34:	89 f9                	mov    %edi,%ecx
80101f36:	31 db                	xor    %ebx,%ebx
80101f38:	01 c1                	add    %eax,%ecx
80101f3a:	0f 92 c3             	setb   %bl
80101f3d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101f40:	0f 82 ab 00 00 00    	jb     80101ff1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101f46:	89 d3                	mov    %edx,%ebx
80101f48:	29 fb                	sub    %edi,%ebx
80101f4a:	39 ca                	cmp    %ecx,%edx
80101f4c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f4f:	85 c0                	test   %eax,%eax
80101f51:	74 74                	je     80101fc7 <readi+0xc7>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101f53:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101f56:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f60:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101f63:	89 fa                	mov    %edi,%edx
80101f65:	c1 ea 09             	shr    $0x9,%edx
80101f68:	89 d8                	mov    %ebx,%eax
80101f6a:	e8 a1 f7 ff ff       	call   80101710 <bmap>
80101f6f:	83 ec 08             	sub    $0x8,%esp
80101f72:	50                   	push   %eax
80101f73:	ff 73 04             	push   0x4(%ebx)
80101f76:	e8 d5 e1 ff ff       	call   80100150 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101f7b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101f7e:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f83:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101f85:	89 f8                	mov    %edi,%eax
80101f87:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f8c:	29 f3                	sub    %esi,%ebx
80101f8e:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101f90:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101f94:	39 d9                	cmp    %ebx,%ecx
80101f96:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101f99:	83 c4 0c             	add    $0xc,%esp
80101f9c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f9d:	01 de                	add    %ebx,%esi
80101f9f:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101fa1:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101fa4:	50                   	push   %eax
80101fa5:	ff 75 e0             	push   -0x20(%ebp)
80101fa8:	e8 83 2d 00 00       	call   80104d30 <memmove>
    brelse(bp);
80101fad:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101fb0:	89 14 24             	mov    %edx,(%esp)
80101fb3:	e8 18 e2 ff ff       	call   801001d0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fb8:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101fbb:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101fbe:	83 c4 10             	add    $0x10,%esp
80101fc1:	39 de                	cmp    %ebx,%esi
80101fc3:	72 9b                	jb     80101f60 <readi+0x60>
80101fc5:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101fc7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fca:	5b                   	pop    %ebx
80101fcb:	5e                   	pop    %esi
80101fcc:	5f                   	pop    %edi
80101fcd:	5d                   	pop    %ebp
80101fce:	c3                   	ret
80101fcf:	90                   	nop
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101fd0:	0f bf 56 56          	movswl 0x56(%esi),%edx
80101fd4:	66 83 fa 09          	cmp    $0x9,%dx
80101fd8:	77 17                	ja     80101ff1 <readi+0xf1>
80101fda:	8b 14 d5 00 09 11 80 	mov    -0x7feef700(,%edx,8),%edx
80101fe1:	85 d2                	test   %edx,%edx
80101fe3:	74 0c                	je     80101ff1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101fe5:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101fe8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101feb:	5b                   	pop    %ebx
80101fec:	5e                   	pop    %esi
80101fed:	5f                   	pop    %edi
80101fee:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101fef:	ff e2                	jmp    *%edx
      return -1;
80101ff1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ff6:	eb cf                	jmp    80101fc7 <readi+0xc7>
80101ff8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101fff:	00 

80102000 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	57                   	push   %edi
80102004:	56                   	push   %esi
80102005:	53                   	push   %ebx
80102006:	83 ec 1c             	sub    $0x1c,%esp
80102009:	8b 45 08             	mov    0x8(%ebp),%eax
8010200c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010200f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102012:	66 83 78 54 03       	cmpw   $0x3,0x54(%eax)
{
80102017:	89 7d dc             	mov    %edi,-0x24(%ebp)
8010201a:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010201d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80102020:	0f 84 c2 00 00 00    	je     801020e8 <writei+0xe8>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102026:	39 78 5c             	cmp    %edi,0x5c(%eax)
80102029:	0f 82 f2 00 00 00    	jb     80102121 <writei+0x121>
    return -1;
  if(off + n > MAXFILE*BSIZE)
8010202f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80102032:	89 f2                	mov    %esi,%edx
80102034:	01 fa                	add    %edi,%edx
80102036:	0f 82 e5 00 00 00    	jb     80102121 <writei+0x121>
8010203c:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80102042:	0f 87 d9 00 00 00    	ja     80102121 <writei+0x121>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102048:	85 f6                	test   %esi,%esi
8010204a:	0f 84 86 00 00 00    	je     801020d6 <writei+0xd6>
80102050:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80102057:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010205a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102060:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102063:	89 fa                	mov    %edi,%edx
80102065:	c1 ea 09             	shr    $0x9,%edx
80102068:	89 f0                	mov    %esi,%eax
8010206a:	e8 a1 f6 ff ff       	call   80101710 <bmap>
8010206f:	83 ec 08             	sub    $0x8,%esp
80102072:	50                   	push   %eax
80102073:	ff 76 04             	push   0x4(%esi)
80102076:	e8 d5 e0 ff ff       	call   80100150 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010207b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010207e:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102081:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102086:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80102088:	89 f8                	mov    %edi,%eax
8010208a:	25 ff 01 00 00       	and    $0x1ff,%eax
8010208f:	29 d3                	sub    %edx,%ebx
80102091:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102093:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102097:	39 d9                	cmp    %ebx,%ecx
80102099:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
8010209c:	83 c4 0c             	add    $0xc,%esp
8010209f:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020a0:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
801020a2:	ff 75 dc             	push   -0x24(%ebp)
801020a5:	50                   	push   %eax
801020a6:	e8 85 2c 00 00       	call   80104d30 <memmove>
    log_write(bp);
801020ab:	89 34 24             	mov    %esi,(%esp)
801020ae:	e8 cd 13 00 00       	call   80103480 <log_write>
    brelse(bp);
801020b3:	89 34 24             	mov    %esi,(%esp)
801020b6:	e8 15 e1 ff ff       	call   801001d0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020bb:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801020be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801020c1:	83 c4 10             	add    $0x10,%esp
801020c4:	01 5d dc             	add    %ebx,-0x24(%ebp)
801020c7:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801020ca:	39 d8                	cmp    %ebx,%eax
801020cc:	72 92                	jb     80102060 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
801020ce:	8b 45 d8             	mov    -0x28(%ebp),%eax
801020d1:	39 78 5c             	cmp    %edi,0x5c(%eax)
801020d4:	72 3a                	jb     80102110 <writei+0x110>
    ip->size = off;
    iupdate(ip);
  }
  return n;
801020d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
801020d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020dc:	5b                   	pop    %ebx
801020dd:	5e                   	pop    %esi
801020de:	5f                   	pop    %edi
801020df:	5d                   	pop    %ebp
801020e0:	c3                   	ret
801020e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
801020e8:	0f bf 40 56          	movswl 0x56(%eax),%eax
801020ec:	66 83 f8 09          	cmp    $0x9,%ax
801020f0:	77 2f                	ja     80102121 <writei+0x121>
801020f2:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
801020f9:	85 c0                	test   %eax,%eax
801020fb:	74 24                	je     80102121 <writei+0x121>
    return devsw[ip->major].write(ip, src, n);
801020fd:	89 75 10             	mov    %esi,0x10(%ebp)
}
80102100:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102103:	5b                   	pop    %ebx
80102104:	5e                   	pop    %esi
80102105:	5f                   	pop    %edi
80102106:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80102107:	ff e0                	jmp    *%eax
80102109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80102110:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80102113:	89 78 5c             	mov    %edi,0x5c(%eax)
    iupdate(ip);
80102116:	50                   	push   %eax
80102117:	e8 24 fa ff ff       	call   80101b40 <iupdate>
8010211c:	83 c4 10             	add    $0x10,%esp
8010211f:	eb b5                	jmp    801020d6 <writei+0xd6>
      return -1;
80102121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102126:	eb b1                	jmp    801020d9 <writei+0xd9>
80102128:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010212f:	00 

80102130 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102136:	6a 0e                	push   $0xe
80102138:	ff 75 0c             	push   0xc(%ebp)
8010213b:	ff 75 08             	push   0x8(%ebp)
8010213e:	e8 5d 2c 00 00       	call   80104da0 <strncmp>
}
80102143:	c9                   	leave
80102144:	c3                   	ret
80102145:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010214c:	00 
8010214d:	8d 76 00             	lea    0x0(%esi),%esi

80102150 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	57                   	push   %edi
80102154:	56                   	push   %esi
80102155:	53                   	push   %ebx
80102156:	83 ec 1c             	sub    $0x1c,%esp
80102159:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010215c:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
80102161:	0f 85 8e 00 00 00    	jne    801021f5 <dirlookup+0xa5>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102167:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010216a:	31 ff                	xor    %edi,%edi
8010216c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010216f:	85 d2                	test   %edx,%edx
80102171:	74 46                	je     801021b9 <dirlookup+0x69>
80102173:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010217a:	00 
8010217b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102180:	6a 10                	push   $0x10
80102182:	57                   	push   %edi
80102183:	56                   	push   %esi
80102184:	53                   	push   %ebx
80102185:	e8 76 fd ff ff       	call   80101f00 <readi>
8010218a:	83 c4 10             	add    $0x10,%esp
8010218d:	83 f8 10             	cmp    $0x10,%eax
80102190:	75 56                	jne    801021e8 <dirlookup+0x98>
      panic("dirlookup read");
    if(de.inum == 0)
80102192:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102197:	74 18                	je     801021b1 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
80102199:	83 ec 04             	sub    $0x4,%esp
8010219c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010219f:	6a 0e                	push   $0xe
801021a1:	50                   	push   %eax
801021a2:	ff 75 0c             	push   0xc(%ebp)
801021a5:	e8 f6 2b 00 00       	call   80104da0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801021aa:	83 c4 10             	add    $0x10,%esp
801021ad:	85 c0                	test   %eax,%eax
801021af:	74 17                	je     801021c8 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
801021b1:	83 c7 10             	add    $0x10,%edi
801021b4:	3b 7b 5c             	cmp    0x5c(%ebx),%edi
801021b7:	72 c7                	jb     80102180 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801021b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801021bc:	31 c0                	xor    %eax,%eax
}
801021be:	5b                   	pop    %ebx
801021bf:	5e                   	pop    %esi
801021c0:	5f                   	pop    %edi
801021c1:	5d                   	pop    %ebp
801021c2:	c3                   	ret
801021c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
801021c8:	8b 45 10             	mov    0x10(%ebp),%eax
801021cb:	85 c0                	test   %eax,%eax
801021cd:	74 05                	je     801021d4 <dirlookup+0x84>
        *poff = off;
801021cf:	8b 45 10             	mov    0x10(%ebp),%eax
801021d2:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
801021d4:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
801021d8:	8b 43 04             	mov    0x4(%ebx),%eax
801021db:	e8 30 f4 ff ff       	call   80101610 <iget>
}
801021e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021e3:	5b                   	pop    %ebx
801021e4:	5e                   	pop    %esi
801021e5:	5f                   	pop    %edi
801021e6:	5d                   	pop    %ebp
801021e7:	c3                   	ret
      panic("dirlookup read");
801021e8:	83 ec 0c             	sub    $0xc,%esp
801021eb:	68 b8 81 10 80       	push   $0x801081b8
801021f0:	e8 bb e2 ff ff       	call   801004b0 <panic>
    panic("dirlookup not DIR");
801021f5:	83 ec 0c             	sub    $0xc,%esp
801021f8:	68 a6 81 10 80       	push   $0x801081a6
801021fd:	e8 ae e2 ff ff       	call   801004b0 <panic>
80102202:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102209:	00 
8010220a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102210 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102210:	55                   	push   %ebp
80102211:	89 e5                	mov    %esp,%ebp
80102213:	57                   	push   %edi
80102214:	56                   	push   %esi
80102215:	53                   	push   %ebx
80102216:	89 c3                	mov    %eax,%ebx
80102218:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010221b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010221e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102221:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102224:	0f 84 be 01 00 00    	je     801023e8 <namex+0x1d8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010222a:	e8 11 1d 00 00       	call   80103f40 <myproc>
  acquire(&icache.lock);
8010222f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102232:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102235:	68 60 09 11 80       	push   $0x80110960
8010223a:	e8 91 28 00 00       	call   80104ad0 <acquire>
  ip->ref++;
8010223f:	83 46 0c 01          	addl   $0x1,0xc(%esi)
  release(&icache.lock);
80102243:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010224a:	e8 01 2a 00 00       	call   80104c50 <release>
8010224f:	83 c4 10             	add    $0x10,%esp
80102252:	eb 0f                	jmp    80102263 <namex+0x53>
80102254:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010225b:	00 
8010225c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102260:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102263:	0f b6 03             	movzbl (%ebx),%eax
80102266:	3c 2f                	cmp    $0x2f,%al
80102268:	74 f6                	je     80102260 <namex+0x50>
  if(*path == 0)
8010226a:	84 c0                	test   %al,%al
8010226c:	0f 84 1e 01 00 00    	je     80102390 <namex+0x180>
  while(*path != '/' && *path != 0)
80102272:	0f b6 03             	movzbl (%ebx),%eax
80102275:	84 c0                	test   %al,%al
80102277:	0f 84 28 01 00 00    	je     801023a5 <namex+0x195>
8010227d:	89 df                	mov    %ebx,%edi
8010227f:	3c 2f                	cmp    $0x2f,%al
80102281:	0f 84 1e 01 00 00    	je     801023a5 <namex+0x195>
80102287:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010228e:	00 
8010228f:	90                   	nop
80102290:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102294:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102297:	3c 2f                	cmp    $0x2f,%al
80102299:	74 04                	je     8010229f <namex+0x8f>
8010229b:	84 c0                	test   %al,%al
8010229d:	75 f1                	jne    80102290 <namex+0x80>
  len = path - s;
8010229f:	89 f8                	mov    %edi,%eax
801022a1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
801022a3:	83 f8 0d             	cmp    $0xd,%eax
801022a6:	0f 8e b4 00 00 00    	jle    80102360 <namex+0x150>
    memmove(name, s, DIRSIZ);
801022ac:	83 ec 04             	sub    $0x4,%esp
801022af:	6a 0e                	push   $0xe
801022b1:	53                   	push   %ebx
801022b2:	89 fb                	mov    %edi,%ebx
801022b4:	ff 75 e4             	push   -0x1c(%ebp)
801022b7:	e8 74 2a 00 00       	call   80104d30 <memmove>
801022bc:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801022bf:	80 3f 2f             	cmpb   $0x2f,(%edi)
801022c2:	75 14                	jne    801022d8 <namex+0xc8>
801022c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022cf:	00 
    path++;
801022d0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801022d3:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801022d6:	74 f8                	je     801022d0 <namex+0xc0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801022d8:	83 ec 0c             	sub    $0xc,%esp
801022db:	56                   	push   %esi
801022dc:	e8 0f f9 ff ff       	call   80101bf0 <ilock>
    if(ip->type != T_DIR){
801022e1:	83 c4 10             	add    $0x10,%esp
801022e4:	66 83 7e 54 01       	cmpw   $0x1,0x54(%esi)
801022e9:	0f 85 bf 00 00 00    	jne    801023ae <namex+0x19e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
801022ef:	8b 45 dc             	mov    -0x24(%ebp),%eax
801022f2:	85 c0                	test   %eax,%eax
801022f4:	74 09                	je     801022ff <namex+0xef>
801022f6:	80 3b 00             	cmpb   $0x0,(%ebx)
801022f9:	0f 84 ff 00 00 00    	je     801023fe <namex+0x1ee>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801022ff:	83 ec 04             	sub    $0x4,%esp
80102302:	6a 00                	push   $0x0
80102304:	ff 75 e4             	push   -0x1c(%ebp)
80102307:	56                   	push   %esi
80102308:	e8 43 fe ff ff       	call   80102150 <dirlookup>
8010230d:	83 c4 10             	add    $0x10,%esp
80102310:	89 c7                	mov    %eax,%edi
80102312:	85 c0                	test   %eax,%eax
80102314:	0f 84 94 00 00 00    	je     801023ae <namex+0x19e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010231a:	83 ec 0c             	sub    $0xc,%esp
8010231d:	8d 4e 10             	lea    0x10(%esi),%ecx
80102320:	51                   	push   %ecx
80102321:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102324:	e8 27 26 00 00       	call   80104950 <holdingsleep>
80102329:	83 c4 10             	add    $0x10,%esp
8010232c:	85 c0                	test   %eax,%eax
8010232e:	0f 84 0a 01 00 00    	je     8010243e <namex+0x22e>
80102334:	8b 56 0c             	mov    0xc(%esi),%edx
80102337:	85 d2                	test   %edx,%edx
80102339:	0f 8e ff 00 00 00    	jle    8010243e <namex+0x22e>
  releasesleep(&ip->lock);
8010233f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102342:	83 ec 0c             	sub    $0xc,%esp
80102345:	51                   	push   %ecx
80102346:	e8 c5 25 00 00       	call   80104910 <releasesleep>
  iput(ip);
8010234b:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
8010234e:	89 fe                	mov    %edi,%esi
  iput(ip);
80102350:	e8 cb f9 ff ff       	call   80101d20 <iput>
80102355:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102358:	e9 06 ff ff ff       	jmp    80102263 <namex+0x53>
8010235d:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102360:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102363:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80102366:	83 ec 04             	sub    $0x4,%esp
80102369:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010236c:	50                   	push   %eax
8010236d:	53                   	push   %ebx
    name[len] = 0;
8010236e:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102370:	ff 75 e4             	push   -0x1c(%ebp)
80102373:	e8 b8 29 00 00       	call   80104d30 <memmove>
    name[len] = 0;
80102378:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010237b:	83 c4 10             	add    $0x10,%esp
8010237e:	c6 01 00             	movb   $0x0,(%ecx)
80102381:	e9 39 ff ff ff       	jmp    801022bf <namex+0xaf>
80102386:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010238d:	00 
8010238e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80102390:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102393:	85 c0                	test   %eax,%eax
80102395:	0f 85 93 00 00 00    	jne    8010242e <namex+0x21e>
    iput(ip);
    return 0;
  }
  return ip;
}
8010239b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010239e:	89 f0                	mov    %esi,%eax
801023a0:	5b                   	pop    %ebx
801023a1:	5e                   	pop    %esi
801023a2:	5f                   	pop    %edi
801023a3:	5d                   	pop    %ebp
801023a4:	c3                   	ret
  while(*path != '/' && *path != 0)
801023a5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801023a8:	89 df                	mov    %ebx,%edi
801023aa:	31 c0                	xor    %eax,%eax
801023ac:	eb b8                	jmp    80102366 <namex+0x156>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801023ae:	83 ec 0c             	sub    $0xc,%esp
801023b1:	8d 5e 10             	lea    0x10(%esi),%ebx
801023b4:	53                   	push   %ebx
801023b5:	e8 96 25 00 00       	call   80104950 <holdingsleep>
801023ba:	83 c4 10             	add    $0x10,%esp
801023bd:	85 c0                	test   %eax,%eax
801023bf:	74 7d                	je     8010243e <namex+0x22e>
801023c1:	8b 4e 0c             	mov    0xc(%esi),%ecx
801023c4:	85 c9                	test   %ecx,%ecx
801023c6:	7e 76                	jle    8010243e <namex+0x22e>
  releasesleep(&ip->lock);
801023c8:	83 ec 0c             	sub    $0xc,%esp
801023cb:	53                   	push   %ebx
801023cc:	e8 3f 25 00 00       	call   80104910 <releasesleep>
  iput(ip);
801023d1:	89 34 24             	mov    %esi,(%esp)
      return 0;
801023d4:	31 f6                	xor    %esi,%esi
  iput(ip);
801023d6:	e8 45 f9 ff ff       	call   80101d20 <iput>
      return 0;
801023db:	83 c4 10             	add    $0x10,%esp
}
801023de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023e1:	89 f0                	mov    %esi,%eax
801023e3:	5b                   	pop    %ebx
801023e4:	5e                   	pop    %esi
801023e5:	5f                   	pop    %edi
801023e6:	5d                   	pop    %ebp
801023e7:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
801023e8:	ba 01 00 00 00       	mov    $0x1,%edx
801023ed:	b8 01 00 00 00       	mov    $0x1,%eax
801023f2:	e8 19 f2 ff ff       	call   80101610 <iget>
801023f7:	89 c6                	mov    %eax,%esi
801023f9:	e9 65 fe ff ff       	jmp    80102263 <namex+0x53>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801023fe:	83 ec 0c             	sub    $0xc,%esp
80102401:	8d 5e 10             	lea    0x10(%esi),%ebx
80102404:	53                   	push   %ebx
80102405:	e8 46 25 00 00       	call   80104950 <holdingsleep>
8010240a:	83 c4 10             	add    $0x10,%esp
8010240d:	85 c0                	test   %eax,%eax
8010240f:	74 2d                	je     8010243e <namex+0x22e>
80102411:	8b 7e 0c             	mov    0xc(%esi),%edi
80102414:	85 ff                	test   %edi,%edi
80102416:	7e 26                	jle    8010243e <namex+0x22e>
  releasesleep(&ip->lock);
80102418:	83 ec 0c             	sub    $0xc,%esp
8010241b:	53                   	push   %ebx
8010241c:	e8 ef 24 00 00       	call   80104910 <releasesleep>
}
80102421:	83 c4 10             	add    $0x10,%esp
}
80102424:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102427:	89 f0                	mov    %esi,%eax
80102429:	5b                   	pop    %ebx
8010242a:	5e                   	pop    %esi
8010242b:	5f                   	pop    %edi
8010242c:	5d                   	pop    %ebp
8010242d:	c3                   	ret
    iput(ip);
8010242e:	83 ec 0c             	sub    $0xc,%esp
80102431:	56                   	push   %esi
      return 0;
80102432:	31 f6                	xor    %esi,%esi
    iput(ip);
80102434:	e8 e7 f8 ff ff       	call   80101d20 <iput>
    return 0;
80102439:	83 c4 10             	add    $0x10,%esp
8010243c:	eb a0                	jmp    801023de <namex+0x1ce>
    panic("iunlock");
8010243e:	83 ec 0c             	sub    $0xc,%esp
80102441:	68 9e 81 10 80       	push   $0x8010819e
80102446:	e8 65 e0 ff ff       	call   801004b0 <panic>
8010244b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102450 <dirlink>:
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	57                   	push   %edi
80102454:	56                   	push   %esi
80102455:	53                   	push   %ebx
80102456:	83 ec 20             	sub    $0x20,%esp
80102459:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010245c:	6a 00                	push   $0x0
8010245e:	ff 75 0c             	push   0xc(%ebp)
80102461:	53                   	push   %ebx
80102462:	e8 e9 fc ff ff       	call   80102150 <dirlookup>
80102467:	83 c4 10             	add    $0x10,%esp
8010246a:	85 c0                	test   %eax,%eax
8010246c:	75 67                	jne    801024d5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010246e:	8b 7b 5c             	mov    0x5c(%ebx),%edi
80102471:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102474:	85 ff                	test   %edi,%edi
80102476:	74 29                	je     801024a1 <dirlink+0x51>
80102478:	31 ff                	xor    %edi,%edi
8010247a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010247d:	eb 09                	jmp    80102488 <dirlink+0x38>
8010247f:	90                   	nop
80102480:	83 c7 10             	add    $0x10,%edi
80102483:	3b 7b 5c             	cmp    0x5c(%ebx),%edi
80102486:	73 19                	jae    801024a1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102488:	6a 10                	push   $0x10
8010248a:	57                   	push   %edi
8010248b:	56                   	push   %esi
8010248c:	53                   	push   %ebx
8010248d:	e8 6e fa ff ff       	call   80101f00 <readi>
80102492:	83 c4 10             	add    $0x10,%esp
80102495:	83 f8 10             	cmp    $0x10,%eax
80102498:	75 4e                	jne    801024e8 <dirlink+0x98>
    if(de.inum == 0)
8010249a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010249f:	75 df                	jne    80102480 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801024a1:	83 ec 04             	sub    $0x4,%esp
801024a4:	8d 45 da             	lea    -0x26(%ebp),%eax
801024a7:	6a 0e                	push   $0xe
801024a9:	ff 75 0c             	push   0xc(%ebp)
801024ac:	50                   	push   %eax
801024ad:	e8 3e 29 00 00       	call   80104df0 <strncpy>
  de.inum = inum;
801024b2:	8b 45 10             	mov    0x10(%ebp),%eax
801024b5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801024b9:	6a 10                	push   $0x10
801024bb:	57                   	push   %edi
801024bc:	56                   	push   %esi
801024bd:	53                   	push   %ebx
801024be:	e8 3d fb ff ff       	call   80102000 <writei>
801024c3:	83 c4 20             	add    $0x20,%esp
801024c6:	83 f8 10             	cmp    $0x10,%eax
801024c9:	75 2a                	jne    801024f5 <dirlink+0xa5>
  return 0;
801024cb:	31 c0                	xor    %eax,%eax
}
801024cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024d0:	5b                   	pop    %ebx
801024d1:	5e                   	pop    %esi
801024d2:	5f                   	pop    %edi
801024d3:	5d                   	pop    %ebp
801024d4:	c3                   	ret
    iput(ip);
801024d5:	83 ec 0c             	sub    $0xc,%esp
801024d8:	50                   	push   %eax
801024d9:	e8 42 f8 ff ff       	call   80101d20 <iput>
    return -1;
801024de:	83 c4 10             	add    $0x10,%esp
801024e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801024e6:	eb e5                	jmp    801024cd <dirlink+0x7d>
      panic("dirlink read");
801024e8:	83 ec 0c             	sub    $0xc,%esp
801024eb:	68 c7 81 10 80       	push   $0x801081c7
801024f0:	e8 bb df ff ff       	call   801004b0 <panic>
    panic("dirlink");
801024f5:	83 ec 0c             	sub    $0xc,%esp
801024f8:	68 43 84 10 80       	push   $0x80108443
801024fd:	e8 ae df ff ff       	call   801004b0 <panic>
80102502:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102509:	00 
8010250a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102510 <namei>:

struct inode*
namei(char *path)
{
80102510:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102511:	31 d2                	xor    %edx,%edx
{
80102513:	89 e5                	mov    %esp,%ebp
80102515:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102518:	8b 45 08             	mov    0x8(%ebp),%eax
8010251b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010251e:	e8 ed fc ff ff       	call   80102210 <namex>
}
80102523:	c9                   	leave
80102524:	c3                   	ret
80102525:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010252c:	00 
8010252d:	8d 76 00             	lea    0x0(%esi),%esi

80102530 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102530:	55                   	push   %ebp
  return namex(path, 1, name);
80102531:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102536:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102538:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010253b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010253e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010253f:	e9 cc fc ff ff       	jmp    80102210 <namex>
80102544:	66 90                	xchg   %ax,%ax
80102546:	66 90                	xchg   %ax,%ax
80102548:	66 90                	xchg   %ax,%ax
8010254a:	66 90                	xchg   %ax,%ax
8010254c:	66 90                	xchg   %ax,%ax
8010254e:	66 90                	xchg   %ax,%ax

80102550 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	56                   	push   %esi
80102554:	53                   	push   %ebx
  if(b == 0)
80102555:	85 c0                	test   %eax,%eax
80102557:	0f 84 b7 00 00 00    	je     80102614 <idestart+0xc4>
    panic("idestart");
  if(b->blockno >= FSSIZE)
8010255d:	8b 70 08             	mov    0x8(%eax),%esi
80102560:	89 c3                	mov    %eax,%ebx
80102562:	81 fe ff f3 01 00    	cmp    $0x1f3ff,%esi
80102568:	0f 87 99 00 00 00    	ja     80102607 <idestart+0xb7>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010256e:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102573:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010257a:	00 
8010257b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102580:	89 ca                	mov    %ecx,%edx
80102582:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102583:	83 e0 c0             	and    $0xffffffc0,%eax
80102586:	3c 40                	cmp    $0x40,%al
80102588:	75 f6                	jne    80102580 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010258a:	31 c0                	xor    %eax,%eax
8010258c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102591:	ee                   	out    %al,(%dx)
80102592:	b8 01 00 00 00       	mov    $0x1,%eax
80102597:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010259c:	ee                   	out    %al,(%dx)
8010259d:	ba f3 01 00 00       	mov    $0x1f3,%edx
801025a2:	89 f0                	mov    %esi,%eax
801025a4:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801025a5:	89 f0                	mov    %esi,%eax
801025a7:	ba f4 01 00 00       	mov    $0x1f4,%edx
801025ac:	c1 f8 08             	sar    $0x8,%eax
801025af:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
801025b0:	89 f0                	mov    %esi,%eax
801025b2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801025b7:	c1 f8 10             	sar    $0x10,%eax
801025ba:	ee                   	out    %al,(%dx)
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801025bb:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801025bf:	ba f6 01 00 00       	mov    $0x1f6,%edx
801025c4:	c1 e0 04             	shl    $0x4,%eax
801025c7:	83 e0 10             	and    $0x10,%eax
801025ca:	83 c8 e0             	or     $0xffffffe0,%eax
801025cd:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801025ce:	f6 03 04             	testb  $0x4,(%ebx)
801025d1:	75 15                	jne    801025e8 <idestart+0x98>
801025d3:	b8 20 00 00 00       	mov    $0x20,%eax
801025d8:	89 ca                	mov    %ecx,%edx
801025da:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801025db:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025de:	5b                   	pop    %ebx
801025df:	5e                   	pop    %esi
801025e0:	5d                   	pop    %ebp
801025e1:	c3                   	ret
801025e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025e8:	b8 30 00 00 00       	mov    $0x30,%eax
801025ed:	89 ca                	mov    %ecx,%edx
801025ef:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801025f0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801025f5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801025f8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801025fd:	fc                   	cld
801025fe:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102600:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102603:	5b                   	pop    %ebx
80102604:	5e                   	pop    %esi
80102605:	5d                   	pop    %ebp
80102606:	c3                   	ret
    panic("incorrect blockno");
80102607:	83 ec 0c             	sub    $0xc,%esp
8010260a:	68 dd 81 10 80       	push   $0x801081dd
8010260f:	e8 9c de ff ff       	call   801004b0 <panic>
    panic("idestart");
80102614:	83 ec 0c             	sub    $0xc,%esp
80102617:	68 d4 81 10 80       	push   $0x801081d4
8010261c:	e8 8f de ff ff       	call   801004b0 <panic>
80102621:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102628:	00 
80102629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102630 <ideinit>:
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102636:	68 ef 81 10 80       	push   $0x801081ef
8010263b:	68 c0 26 11 80       	push   $0x801126c0
80102640:	e8 3b 23 00 00       	call   80104980 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102645:	58                   	pop    %eax
80102646:	a1 44 28 11 80       	mov    0x80112844,%eax
8010264b:	5a                   	pop    %edx
8010264c:	83 e8 01             	sub    $0x1,%eax
8010264f:	50                   	push   %eax
80102650:	6a 0e                	push   $0xe
80102652:	e8 e9 02 00 00       	call   80102940 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102657:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010265a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010265f:	90                   	nop
80102660:	ec                   	in     (%dx),%al
80102661:	83 e0 c0             	and    $0xffffffc0,%eax
80102664:	3c 40                	cmp    $0x40,%al
80102666:	75 f8                	jne    80102660 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102668:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010266d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102672:	ee                   	out    %al,(%dx)
  cprintf("Waiting on root device...\n");
80102673:	83 ec 0c             	sub    $0xc,%esp
80102676:	68 f3 81 10 80       	push   $0x801081f3
8010267b:	e8 70 e1 ff ff       	call   801007f0 <cprintf>
80102680:	83 c4 10             	add    $0x10,%esp
80102683:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102688:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010268d:	eb 06                	jmp    80102695 <ideinit+0x65>
8010268f:	90                   	nop
  for(i=0; i<1000; i++){
80102690:	83 e9 01             	sub    $0x1,%ecx
80102693:	74 0f                	je     801026a4 <ideinit+0x74>
80102695:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102696:	84 c0                	test   %al,%al
80102698:	74 f6                	je     80102690 <ideinit+0x60>
      havedisk1 = 1;
8010269a:	c7 05 a0 26 11 80 01 	movl   $0x1,0x801126a0
801026a1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026a4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801026a9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026ae:	ee                   	out    %al,(%dx)
}
801026af:	c9                   	leave
801026b0:	c3                   	ret
801026b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026b8:	00 
801026b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801026c0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	57                   	push   %edi
801026c4:	56                   	push   %esi
801026c5:	53                   	push   %ebx
801026c6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801026c9:	68 c0 26 11 80       	push   $0x801126c0
801026ce:	e8 fd 23 00 00       	call   80104ad0 <acquire>

  if((b = idequeue) == 0){
801026d3:	8b 1d a4 26 11 80    	mov    0x801126a4,%ebx
801026d9:	83 c4 10             	add    $0x10,%esp
801026dc:	85 db                	test   %ebx,%ebx
801026de:	74 63                	je     80102743 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801026e0:	8b 43 58             	mov    0x58(%ebx),%eax
801026e3:	a3 a4 26 11 80       	mov    %eax,0x801126a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801026e8:	8b 33                	mov    (%ebx),%esi
801026ea:	f7 c6 04 00 00 00    	test   $0x4,%esi
801026f0:	75 2f                	jne    80102721 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026f2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801026f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026fe:	00 
801026ff:	90                   	nop
80102700:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102701:	89 c1                	mov    %eax,%ecx
80102703:	83 e1 c0             	and    $0xffffffc0,%ecx
80102706:	80 f9 40             	cmp    $0x40,%cl
80102709:	75 f5                	jne    80102700 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010270b:	a8 21                	test   $0x21,%al
8010270d:	75 12                	jne    80102721 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010270f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102712:	b9 80 00 00 00       	mov    $0x80,%ecx
80102717:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010271c:	fc                   	cld
8010271d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010271f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102721:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102724:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102727:	83 ce 02             	or     $0x2,%esi
8010272a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010272c:	53                   	push   %ebx
8010272d:	e8 8e 1f 00 00       	call   801046c0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102732:	a1 a4 26 11 80       	mov    0x801126a4,%eax
80102737:	83 c4 10             	add    $0x10,%esp
8010273a:	85 c0                	test   %eax,%eax
8010273c:	74 05                	je     80102743 <ideintr+0x83>
    idestart(idequeue);
8010273e:	e8 0d fe ff ff       	call   80102550 <idestart>
    release(&idelock);
80102743:	83 ec 0c             	sub    $0xc,%esp
80102746:	68 c0 26 11 80       	push   $0x801126c0
8010274b:	e8 00 25 00 00       	call   80104c50 <release>

  release(&idelock);
}
80102750:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102753:	5b                   	pop    %ebx
80102754:	5e                   	pop    %esi
80102755:	5f                   	pop    %edi
80102756:	5d                   	pop    %ebp
80102757:	c3                   	ret
80102758:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010275f:	00 

80102760 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102760:	55                   	push   %ebp
80102761:	89 e5                	mov    %esp,%ebp
80102763:	53                   	push   %ebx
80102764:	83 ec 10             	sub    $0x10,%esp
80102767:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010276a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010276d:	50                   	push   %eax
8010276e:	e8 dd 21 00 00       	call   80104950 <holdingsleep>
80102773:	83 c4 10             	add    $0x10,%esp
80102776:	85 c0                	test   %eax,%eax
80102778:	0f 84 c3 00 00 00    	je     80102841 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010277e:	8b 03                	mov    (%ebx),%eax
80102780:	83 e0 06             	and    $0x6,%eax
80102783:	83 f8 02             	cmp    $0x2,%eax
80102786:	0f 84 a8 00 00 00    	je     80102834 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010278c:	8b 53 04             	mov    0x4(%ebx),%edx
8010278f:	85 d2                	test   %edx,%edx
80102791:	74 0d                	je     801027a0 <iderw+0x40>
80102793:	a1 a0 26 11 80       	mov    0x801126a0,%eax
80102798:	85 c0                	test   %eax,%eax
8010279a:	0f 84 87 00 00 00    	je     80102827 <iderw+0xc7>
    panic("could not mount root!: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801027a0:	83 ec 0c             	sub    $0xc,%esp
801027a3:	68 c0 26 11 80       	push   $0x801126c0
801027a8:	e8 23 23 00 00       	call   80104ad0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027ad:	a1 a4 26 11 80       	mov    0x801126a4,%eax
  b->qnext = 0;
801027b2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027b9:	83 c4 10             	add    $0x10,%esp
801027bc:	85 c0                	test   %eax,%eax
801027be:	74 60                	je     80102820 <iderw+0xc0>
801027c0:	89 c2                	mov    %eax,%edx
801027c2:	8b 40 58             	mov    0x58(%eax),%eax
801027c5:	85 c0                	test   %eax,%eax
801027c7:	75 f7                	jne    801027c0 <iderw+0x60>
801027c9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801027cc:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801027ce:	39 1d a4 26 11 80    	cmp    %ebx,0x801126a4
801027d4:	74 3a                	je     80102810 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801027d6:	8b 03                	mov    (%ebx),%eax
801027d8:	83 e0 06             	and    $0x6,%eax
801027db:	83 f8 02             	cmp    $0x2,%eax
801027de:	74 1b                	je     801027fb <iderw+0x9b>
    sleep(b, &idelock);
801027e0:	83 ec 08             	sub    $0x8,%esp
801027e3:	68 c0 26 11 80       	push   $0x801126c0
801027e8:	53                   	push   %ebx
801027e9:	e8 12 1e 00 00       	call   80104600 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801027ee:	8b 03                	mov    (%ebx),%eax
801027f0:	83 c4 10             	add    $0x10,%esp
801027f3:	83 e0 06             	and    $0x6,%eax
801027f6:	83 f8 02             	cmp    $0x2,%eax
801027f9:	75 e5                	jne    801027e0 <iderw+0x80>
  }
  release(&idelock);
801027fb:	c7 45 08 c0 26 11 80 	movl   $0x801126c0,0x8(%ebp)
}
80102802:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102805:	c9                   	leave
  release(&idelock);
80102806:	e9 45 24 00 00       	jmp    80104c50 <release>
8010280b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102810:	89 d8                	mov    %ebx,%eax
80102812:	e8 39 fd ff ff       	call   80102550 <idestart>
80102817:	eb bd                	jmp    801027d6 <iderw+0x76>
80102819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102820:	ba a4 26 11 80       	mov    $0x801126a4,%edx
80102825:	eb a5                	jmp    801027cc <iderw+0x6c>
    panic("could not mount root!: ide disk 1 not present");
80102827:	83 ec 0c             	sub    $0xc,%esp
8010282a:	68 70 86 10 80       	push   $0x80108670
8010282f:	e8 7c dc ff ff       	call   801004b0 <panic>
    panic("iderw: nothing to do");
80102834:	83 ec 0c             	sub    $0xc,%esp
80102837:	68 24 82 10 80       	push   $0x80108224
8010283c:	e8 6f dc ff ff       	call   801004b0 <panic>
    panic("iderw: buf not locked");
80102841:	83 ec 0c             	sub    $0xc,%esp
80102844:	68 0e 82 10 80       	push   $0x8010820e
80102849:	e8 62 dc ff ff       	call   801004b0 <panic>
8010284e:	66 90                	xchg   %ax,%ax
80102850:	66 90                	xchg   %ax,%ax
80102852:	66 90                	xchg   %ax,%ax
80102854:	66 90                	xchg   %ax,%ax
80102856:	66 90                	xchg   %ax,%ax
80102858:	66 90                	xchg   %ax,%ax
8010285a:	66 90                	xchg   %ax,%ax
8010285c:	66 90                	xchg   %ax,%ax
8010285e:	66 90                	xchg   %ax,%ax
80102860:	66 90                	xchg   %ax,%ax
80102862:	66 90                	xchg   %ax,%ax
80102864:	66 90                	xchg   %ax,%ax
80102866:	66 90                	xchg   %ax,%ax
80102868:	66 90                	xchg   %ax,%ax
8010286a:	66 90                	xchg   %ax,%ax
8010286c:	66 90                	xchg   %ax,%ax
8010286e:	66 90                	xchg   %ax,%ax
80102870:	66 90                	xchg   %ax,%ax
80102872:	66 90                	xchg   %ax,%ax
80102874:	66 90                	xchg   %ax,%ax
80102876:	66 90                	xchg   %ax,%ax
80102878:	66 90                	xchg   %ax,%ax
8010287a:	66 90                	xchg   %ax,%ax
8010287c:	66 90                	xchg   %ax,%ax
8010287e:	66 90                	xchg   %ax,%ax

80102880 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102880:	55                   	push   %ebp
80102881:	89 e5                	mov    %esp,%ebp
80102883:	56                   	push   %esi
80102884:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102885:	c7 05 f4 26 11 80 00 	movl   $0xfec00000,0x801126f4
8010288c:	00 c0 fe 
  ioapic->reg = reg;
8010288f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102896:	00 00 00 
  return ioapic->data;
80102899:	8b 15 f4 26 11 80    	mov    0x801126f4,%edx
8010289f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801028a2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801028a8:	8b 1d f4 26 11 80    	mov    0x801126f4,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801028ae:	0f b6 15 40 28 11 80 	movzbl 0x80112840,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801028b5:	c1 ee 10             	shr    $0x10,%esi
801028b8:	89 f0                	mov    %esi,%eax
801028ba:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801028bd:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
801028c0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801028c3:	39 c2                	cmp    %eax,%edx
801028c5:	74 16                	je     801028dd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801028c7:	83 ec 0c             	sub    $0xc,%esp
801028ca:	68 a0 86 10 80       	push   $0x801086a0
801028cf:	e8 1c df ff ff       	call   801007f0 <cprintf>
  ioapic->reg = reg;
801028d4:	8b 1d f4 26 11 80    	mov    0x801126f4,%ebx
801028da:	83 c4 10             	add    $0x10,%esp
{
801028dd:	ba 10 00 00 00       	mov    $0x10,%edx
801028e2:	31 c0                	xor    %eax,%eax
801028e4:	eb 1a                	jmp    80102900 <ioapicinit+0x80>
801028e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028ed:	00 
801028ee:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028f5:	00 
801028f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028fd:	00 
801028fe:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
80102900:	89 13                	mov    %edx,(%ebx)
80102902:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
80102905:	8b 1d f4 26 11 80    	mov    0x801126f4,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010290b:	83 c0 01             	add    $0x1,%eax
8010290e:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
80102914:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
80102917:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
8010291a:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010291d:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
8010291f:	8b 1d f4 26 11 80    	mov    0x801126f4,%ebx
80102925:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
8010292c:	39 c6                	cmp    %eax,%esi
8010292e:	7d d0                	jge    80102900 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102930:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102933:	5b                   	pop    %ebx
80102934:	5e                   	pop    %esi
80102935:	5d                   	pop    %ebp
80102936:	c3                   	ret
80102937:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010293e:	00 
8010293f:	90                   	nop

80102940 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102940:	55                   	push   %ebp
  ioapic->reg = reg;
80102941:	8b 0d f4 26 11 80    	mov    0x801126f4,%ecx
{
80102947:	89 e5                	mov    %esp,%ebp
80102949:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010294c:	8d 50 20             	lea    0x20(%eax),%edx
8010294f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102953:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102955:	8b 0d f4 26 11 80    	mov    0x801126f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010295b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010295e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102961:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102964:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102966:	a1 f4 26 11 80       	mov    0x801126f4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010296b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010296e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102971:	5d                   	pop    %ebp
80102972:	c3                   	ret
80102973:	66 90                	xchg   %ax,%ax
80102975:	66 90                	xchg   %ax,%ax
80102977:	66 90                	xchg   %ax,%ax
80102979:	66 90                	xchg   %ax,%ax
8010297b:	66 90                	xchg   %ax,%ax
8010297d:	66 90                	xchg   %ax,%ax
8010297f:	90                   	nop

80102980 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102980:	55                   	push   %ebp
80102981:	89 e5                	mov    %esp,%ebp
80102983:	53                   	push   %ebx
80102984:	83 ec 04             	sub    $0x4,%esp
80102987:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  
  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010298a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102990:	75 76                	jne    80102a08 <kfree+0x88>
80102992:	81 fb 90 65 11 80    	cmp    $0x80116590,%ebx
80102998:	72 6e                	jb     80102a08 <kfree+0x88>
8010299a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801029a0:	3d ff ff 3f 00       	cmp    $0x3fffff,%eax
801029a5:	77 61                	ja     80102a08 <kfree+0x88>
    panic("kfree in kalloc.c");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801029a7:	83 ec 04             	sub    $0x4,%esp
801029aa:	68 00 10 00 00       	push   $0x1000
801029af:	6a 01                	push   $0x1
801029b1:	53                   	push   %ebx
801029b2:	e8 e9 22 00 00       	call   80104ca0 <memset>

  if(kmem.use_lock)
801029b7:	8b 15 34 27 11 80    	mov    0x80112734,%edx
801029bd:	83 c4 10             	add    $0x10,%esp
801029c0:	85 d2                	test   %edx,%edx
801029c2:	75 1c                	jne    801029e0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801029c4:	a1 38 27 11 80       	mov    0x80112738,%eax
801029c9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801029cb:	a1 34 27 11 80       	mov    0x80112734,%eax
  kmem.freelist = r;
801029d0:	89 1d 38 27 11 80    	mov    %ebx,0x80112738
  if(kmem.use_lock)
801029d6:	85 c0                	test   %eax,%eax
801029d8:	75 1e                	jne    801029f8 <kfree+0x78>
    release(&kmem.lock);
}
801029da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029dd:	c9                   	leave
801029de:	c3                   	ret
801029df:	90                   	nop
    acquire(&kmem.lock);
801029e0:	83 ec 0c             	sub    $0xc,%esp
801029e3:	68 00 27 11 80       	push   $0x80112700
801029e8:	e8 e3 20 00 00       	call   80104ad0 <acquire>
801029ed:	83 c4 10             	add    $0x10,%esp
801029f0:	eb d2                	jmp    801029c4 <kfree+0x44>
801029f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801029f8:	c7 45 08 00 27 11 80 	movl   $0x80112700,0x8(%ebp)
}
801029ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a02:	c9                   	leave
    release(&kmem.lock);
80102a03:	e9 48 22 00 00       	jmp    80104c50 <release>
    panic("kfree in kalloc.c");
80102a08:	83 ec 0c             	sub    $0xc,%esp
80102a0b:	68 39 82 10 80       	push   $0x80108239
80102a10:	e8 9b da ff ff       	call   801004b0 <panic>
80102a15:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a1c:	00 
80102a1d:	8d 76 00             	lea    0x0(%esi),%esi

80102a20 <freerange>:
{
80102a20:	55                   	push   %ebp
80102a21:	89 e5                	mov    %esp,%ebp
80102a23:	56                   	push   %esi
80102a24:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102a25:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102a28:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102a2b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a31:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a37:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a3d:	39 de                	cmp    %ebx,%esi
80102a3f:	72 2b                	jb     80102a6c <freerange+0x4c>
80102a41:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a48:	00 
80102a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102a50:	83 ec 0c             	sub    $0xc,%esp
80102a53:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a59:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a5f:	50                   	push   %eax
80102a60:	e8 1b ff ff ff       	call   80102980 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a65:	83 c4 10             	add    $0x10,%esp
80102a68:	39 de                	cmp    %ebx,%esi
80102a6a:	73 e4                	jae    80102a50 <freerange+0x30>
}
80102a6c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a6f:	5b                   	pop    %ebx
80102a70:	5e                   	pop    %esi
80102a71:	5d                   	pop    %ebp
80102a72:	c3                   	ret
80102a73:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a7a:	00 
80102a7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102a80 <kinit2>:
{
80102a80:	55                   	push   %ebp
80102a81:	89 e5                	mov    %esp,%ebp
80102a83:	56                   	push   %esi
80102a84:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102a85:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102a88:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
80102a8b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a91:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a97:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a9d:	39 de                	cmp    %ebx,%esi
80102a9f:	72 2b                	jb     80102acc <kinit2+0x4c>
80102aa1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aa8:	00 
80102aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102ab0:	83 ec 0c             	sub    $0xc,%esp
80102ab3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ab9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102abf:	50                   	push   %eax
80102ac0:	e8 bb fe ff ff       	call   80102980 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ac5:	83 c4 10             	add    $0x10,%esp
80102ac8:	39 de                	cmp    %ebx,%esi
80102aca:	73 e4                	jae    80102ab0 <kinit2+0x30>
  kmem.use_lock = 1;
80102acc:	c7 05 34 27 11 80 01 	movl   $0x1,0x80112734
80102ad3:	00 00 00 
}
80102ad6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ad9:	5b                   	pop    %ebx
80102ada:	5e                   	pop    %esi
80102adb:	5d                   	pop    %ebp
80102adc:	c3                   	ret
80102add:	8d 76 00             	lea    0x0(%esi),%esi

80102ae0 <kinit1>:
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	56                   	push   %esi
80102ae4:	53                   	push   %ebx
80102ae5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102ae8:	83 ec 08             	sub    $0x8,%esp
80102aeb:	68 4b 82 10 80       	push   $0x8010824b
80102af0:	68 00 27 11 80       	push   $0x80112700
80102af5:	e8 86 1e 00 00       	call   80104980 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102afa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102afd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102b00:	c7 05 34 27 11 80 00 	movl   $0x0,0x80112734
80102b07:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102b0a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102b10:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b16:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102b1c:	39 de                	cmp    %ebx,%esi
80102b1e:	72 1c                	jb     80102b3c <kinit1+0x5c>
    kfree(p);
80102b20:	83 ec 0c             	sub    $0xc,%esp
80102b23:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b29:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102b2f:	50                   	push   %eax
80102b30:	e8 4b fe ff ff       	call   80102980 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b35:	83 c4 10             	add    $0x10,%esp
80102b38:	39 de                	cmp    %ebx,%esi
80102b3a:	73 e4                	jae    80102b20 <kinit1+0x40>
}
80102b3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b3f:	5b                   	pop    %ebx
80102b40:	5e                   	pop    %esi
80102b41:	5d                   	pop    %ebp
80102b42:	c3                   	ret
80102b43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b4a:	00 
80102b4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102b50 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102b50:	55                   	push   %ebp
80102b51:	89 e5                	mov    %esp,%ebp
80102b53:	53                   	push   %ebx
80102b54:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102b57:	a1 34 27 11 80       	mov    0x80112734,%eax
80102b5c:	85 c0                	test   %eax,%eax
80102b5e:	75 20                	jne    80102b80 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102b60:	8b 1d 38 27 11 80    	mov    0x80112738,%ebx
  if(r)
80102b66:	85 db                	test   %ebx,%ebx
80102b68:	74 07                	je     80102b71 <kalloc+0x21>
    kmem.freelist = r->next;
80102b6a:	8b 03                	mov    (%ebx),%eax
80102b6c:	a3 38 27 11 80       	mov    %eax,0x80112738
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102b71:	89 d8                	mov    %ebx,%eax
80102b73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b76:	c9                   	leave
80102b77:	c3                   	ret
80102b78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b7f:	00 
    acquire(&kmem.lock);
80102b80:	83 ec 0c             	sub    $0xc,%esp
80102b83:	68 00 27 11 80       	push   $0x80112700
80102b88:	e8 43 1f 00 00       	call   80104ad0 <acquire>
  r = kmem.freelist;
80102b8d:	8b 1d 38 27 11 80    	mov    0x80112738,%ebx
  if(kmem.use_lock)
80102b93:	a1 34 27 11 80       	mov    0x80112734,%eax
  if(r)
80102b98:	83 c4 10             	add    $0x10,%esp
80102b9b:	85 db                	test   %ebx,%ebx
80102b9d:	74 08                	je     80102ba7 <kalloc+0x57>
    kmem.freelist = r->next;
80102b9f:	8b 13                	mov    (%ebx),%edx
80102ba1:	89 15 38 27 11 80    	mov    %edx,0x80112738
  if(kmem.use_lock)
80102ba7:	85 c0                	test   %eax,%eax
80102ba9:	74 c6                	je     80102b71 <kalloc+0x21>
    release(&kmem.lock);
80102bab:	83 ec 0c             	sub    $0xc,%esp
80102bae:	68 00 27 11 80       	push   $0x80112700
80102bb3:	e8 98 20 00 00       	call   80104c50 <release>
}
80102bb8:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
80102bba:	83 c4 10             	add    $0x10,%esp
}
80102bbd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bc0:	c9                   	leave
80102bc1:	c3                   	ret
80102bc2:	66 90                	xchg   %ax,%ax
80102bc4:	66 90                	xchg   %ax,%ax
80102bc6:	66 90                	xchg   %ax,%ax
80102bc8:	66 90                	xchg   %ax,%ax
80102bca:	66 90                	xchg   %ax,%ax
80102bcc:	66 90                	xchg   %ax,%ax
80102bce:	66 90                	xchg   %ax,%ax

80102bd0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bd0:	ba 64 00 00 00       	mov    $0x64,%edx
80102bd5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102bd6:	a8 01                	test   $0x1,%al
80102bd8:	0f 84 c2 00 00 00    	je     80102ca0 <kbdgetc+0xd0>
{
80102bde:	55                   	push   %ebp
80102bdf:	ba 60 00 00 00       	mov    $0x60,%edx
80102be4:	89 e5                	mov    %esp,%ebp
80102be6:	53                   	push   %ebx
80102be7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102be8:	8b 1d 3c 27 11 80    	mov    0x8011273c,%ebx
  data = inb(KBDATAP);
80102bee:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102bf1:	3c e0                	cmp    $0xe0,%al
80102bf3:	74 5b                	je     80102c50 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102bf5:	89 da                	mov    %ebx,%edx
80102bf7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
80102bfa:	84 c0                	test   %al,%al
80102bfc:	78 62                	js     80102c60 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102bfe:	85 d2                	test   %edx,%edx
80102c00:	74 09                	je     80102c0b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102c02:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102c05:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102c08:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102c0b:	0f b6 91 80 8a 10 80 	movzbl -0x7fef7580(%ecx),%edx
  shift ^= togglecode[data];
80102c12:	0f b6 81 80 89 10 80 	movzbl -0x7fef7680(%ecx),%eax
  shift |= shiftcode[data];
80102c19:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102c1b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c1d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80102c1f:	89 15 3c 27 11 80    	mov    %edx,0x8011273c
  c = charcode[shift & (CTL | SHIFT)][data];
80102c25:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102c28:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c2b:	8b 04 85 60 89 10 80 	mov    -0x7fef76a0(,%eax,4),%eax
80102c32:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102c36:	74 0b                	je     80102c43 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102c38:	8d 50 9f             	lea    -0x61(%eax),%edx
80102c3b:	83 fa 19             	cmp    $0x19,%edx
80102c3e:	77 48                	ja     80102c88 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102c40:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102c43:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c46:	c9                   	leave
80102c47:	c3                   	ret
80102c48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c4f:	00 
    shift |= E0ESC;
80102c50:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102c53:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102c55:	89 1d 3c 27 11 80    	mov    %ebx,0x8011273c
}
80102c5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c5e:	c9                   	leave
80102c5f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102c60:	83 e0 7f             	and    $0x7f,%eax
80102c63:	85 d2                	test   %edx,%edx
80102c65:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102c68:	0f b6 81 80 8a 10 80 	movzbl -0x7fef7580(%ecx),%eax
80102c6f:	83 c8 40             	or     $0x40,%eax
80102c72:	0f b6 c0             	movzbl %al,%eax
80102c75:	f7 d0                	not    %eax
80102c77:	21 d8                	and    %ebx,%eax
80102c79:	a3 3c 27 11 80       	mov    %eax,0x8011273c
    return 0;
80102c7e:	31 c0                	xor    %eax,%eax
80102c80:	eb d9                	jmp    80102c5b <kbdgetc+0x8b>
80102c82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102c88:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102c8b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102c8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c91:	c9                   	leave
      c += 'a' - 'A';
80102c92:	83 f9 1a             	cmp    $0x1a,%ecx
80102c95:	0f 42 c2             	cmovb  %edx,%eax
}
80102c98:	c3                   	ret
80102c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102ca0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102ca5:	c3                   	ret
80102ca6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102cad:	00 
80102cae:	66 90                	xchg   %ax,%ax

80102cb0 <kbdintr>:

void
kbdintr(void)
{
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102cb6:	68 d0 2b 10 80       	push   $0x80102bd0
80102cbb:	e8 20 dd ff ff       	call   801009e0 <consoleintr>
}
80102cc0:	83 c4 10             	add    $0x10,%esp
80102cc3:	c9                   	leave
80102cc4:	c3                   	ret
80102cc5:	66 90                	xchg   %ax,%ax
80102cc7:	66 90                	xchg   %ax,%ax
80102cc9:	66 90                	xchg   %ax,%ax
80102ccb:	66 90                	xchg   %ax,%ax
80102ccd:	66 90                	xchg   %ax,%ax
80102ccf:	90                   	nop

80102cd0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102cd0:	a1 40 27 11 80       	mov    0x80112740,%eax
80102cd5:	85 c0                	test   %eax,%eax
80102cd7:	0f 84 fb 00 00 00    	je     80102dd8 <lapicinit+0x108>
{
80102cdd:	55                   	push   %ebp
80102cde:	89 e5                	mov    %esp,%ebp
80102ce0:	83 ec 08             	sub    $0x8,%esp
  lapic[index] = value;
80102ce3:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102cea:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ced:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cf0:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102cf7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cfa:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cfd:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102d04:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102d07:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d0a:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102d11:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102d14:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d17:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102d1e:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d21:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d24:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102d2b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d2e:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102d31:	8b 50 30             	mov    0x30(%eax),%edx
80102d34:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102d3a:	0f 85 80 00 00 00    	jne    80102dc0 <lapicinit+0xf0>
  lapic[index] = value;
80102d40:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102d47:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d4a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d4d:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d54:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d57:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d5a:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d61:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d64:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d67:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102d6e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d71:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d74:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102d7b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d7e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d81:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102d88:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102d8b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102d8e:	66 90                	xchg   %ax,%ax
80102d90:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102d96:	80 e6 10             	and    $0x10,%dh
80102d99:	75 f5                	jne    80102d90 <lapicinit+0xc0>
  lapic[index] = value;
80102d9b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102da2:	00 00 00 
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);

  cprintf("lapnic: initialized\n");
80102da5:	83 ec 0c             	sub    $0xc,%esp
  lapic[ID];  // wait for write to finish, by reading
80102da8:	8b 40 20             	mov    0x20(%eax),%eax
  cprintf("lapnic: initialized\n");
80102dab:	68 50 82 10 80       	push   $0x80108250
80102db0:	e8 3b da ff ff       	call   801007f0 <cprintf>
80102db5:	83 c4 10             	add    $0x10,%esp

}
80102db8:	c9                   	leave
80102db9:	c3                   	ret
80102dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102dc0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102dc7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102dca:	8b 50 20             	mov    0x20(%eax),%edx
}
80102dcd:	e9 6e ff ff ff       	jmp    80102d40 <lapicinit+0x70>
80102dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102dd8:	c3                   	ret
80102dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102de0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102de0:	a1 40 27 11 80       	mov    0x80112740,%eax
80102de5:	85 c0                	test   %eax,%eax
80102de7:	74 07                	je     80102df0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102de9:	8b 40 20             	mov    0x20(%eax),%eax
80102dec:	c1 e8 18             	shr    $0x18,%eax
80102def:	c3                   	ret
80102df0:	31 c0                	xor    %eax,%eax
}
80102df2:	c3                   	ret
80102df3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dfa:	00 
80102dfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102e00 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102e00:	a1 40 27 11 80       	mov    0x80112740,%eax
80102e05:	85 c0                	test   %eax,%eax
80102e07:	74 0d                	je     80102e16 <lapiceoi+0x16>
  lapic[index] = value;
80102e09:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102e10:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e13:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102e16:	c3                   	ret
80102e17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e1e:	00 
80102e1f:	90                   	nop

80102e20 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102e20:	c3                   	ret
80102e21:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e28:	00 
80102e29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e30 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102e30:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e31:	b8 0f 00 00 00       	mov    $0xf,%eax
80102e36:	ba 70 00 00 00       	mov    $0x70,%edx
80102e3b:	89 e5                	mov    %esp,%ebp
80102e3d:	53                   	push   %ebx
80102e3e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102e41:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e44:	ee                   	out    %al,(%dx)
80102e45:	b8 0a 00 00 00       	mov    $0xa,%eax
80102e4a:	ba 71 00 00 00       	mov    $0x71,%edx
80102e4f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102e50:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102e52:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102e55:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102e5b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e5d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102e60:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102e62:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e65:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102e68:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102e6e:	a1 40 27 11 80       	mov    0x80112740,%eax
80102e73:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e79:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e7c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102e83:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e86:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e89:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102e90:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e93:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e96:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e9c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e9f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102ea5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102ea8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102eae:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102eb1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102eb7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102eba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ebd:	c9                   	leave
80102ebe:	c3                   	ret
80102ebf:	90                   	nop

80102ec0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
80102ec0:	55                   	push   %ebp
80102ec1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102ec6:	ba 70 00 00 00       	mov    $0x70,%edx
80102ecb:	89 e5                	mov    %esp,%ebp
80102ecd:	57                   	push   %edi
80102ece:	56                   	push   %esi
80102ecf:	53                   	push   %ebx
80102ed0:	83 ec 4c             	sub    $0x4c,%esp
80102ed3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ed4:	ba 71 00 00 00       	mov    $0x71,%edx
80102ed9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102eda:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102edd:	88 45 b4             	mov    %al,-0x4c(%ebp)
80102ee0:	31 c0                	xor    %eax,%eax
80102ee2:	ba 70 00 00 00       	mov    $0x70,%edx
80102ee7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ee8:	b9 71 00 00 00       	mov    $0x71,%ecx
80102eed:	89 ca                	mov    %ecx,%edx
80102eef:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ef0:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ef5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ef8:	b8 02 00 00 00       	mov    $0x2,%eax
80102efd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102efe:	89 ca                	mov    %ecx,%edx
80102f00:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f01:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f06:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f09:	b8 04 00 00 00       	mov    $0x4,%eax
80102f0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f0f:	89 ca                	mov    %ecx,%edx
80102f11:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f12:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f17:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f1a:	b8 07 00 00 00       	mov    $0x7,%eax
80102f1f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f20:	89 ca                	mov    %ecx,%edx
80102f22:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f23:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f28:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f2a:	b8 08 00 00 00       	mov    $0x8,%eax
80102f2f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f30:	89 ca                	mov    %ecx,%edx
80102f32:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f33:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f38:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f3a:	b8 09 00 00 00       	mov    $0x9,%eax
80102f3f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f40:	89 ca                	mov    %ecx,%edx
80102f42:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f43:	ba 70 00 00 00       	mov    $0x70,%edx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f48:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f4b:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f50:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f51:	89 ca                	mov    %ecx,%edx
80102f53:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102f54:	84 c0                	test   %al,%al
80102f56:	78 88                	js     80102ee0 <cmostime+0x20>
  return inb(CMOS_RETURN);
80102f58:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f5c:	89 fa                	mov    %edi,%edx
80102f5e:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102f61:	0f b6 fa             	movzbl %dl,%edi
80102f64:	89 f2                	mov    %esi,%edx
80102f66:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102f69:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102f6d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f70:	ba 70 00 00 00       	mov    $0x70,%edx
80102f75:	89 7d c4             	mov    %edi,-0x3c(%ebp)
80102f78:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102f7b:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102f7f:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102f82:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102f85:	31 c0                	xor    %eax,%eax
80102f87:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f88:	89 ca                	mov    %ecx,%edx
80102f8a:	ec                   	in     (%dx),%al
80102f8b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f8e:	ba 70 00 00 00       	mov    $0x70,%edx
80102f93:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102f96:	b8 02 00 00 00       	mov    $0x2,%eax
80102f9b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f9c:	89 ca                	mov    %ecx,%edx
80102f9e:	ec                   	in     (%dx),%al
80102f9f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fa2:	ba 70 00 00 00       	mov    $0x70,%edx
80102fa7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102faa:	b8 04 00 00 00       	mov    $0x4,%eax
80102faf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fb0:	89 ca                	mov    %ecx,%edx
80102fb2:	ec                   	in     (%dx),%al
80102fb3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fb6:	ba 70 00 00 00       	mov    $0x70,%edx
80102fbb:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102fbe:	b8 07 00 00 00       	mov    $0x7,%eax
80102fc3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fc4:	89 ca                	mov    %ecx,%edx
80102fc6:	ec                   	in     (%dx),%al
80102fc7:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fca:	ba 70 00 00 00       	mov    $0x70,%edx
80102fcf:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102fd2:	b8 08 00 00 00       	mov    $0x8,%eax
80102fd7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fd8:	89 ca                	mov    %ecx,%edx
80102fda:	ec                   	in     (%dx),%al
80102fdb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fde:	ba 70 00 00 00       	mov    $0x70,%edx
80102fe3:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102fe6:	b8 09 00 00 00       	mov    $0x9,%eax
80102feb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fec:	89 ca                	mov    %ecx,%edx
80102fee:	ec                   	in     (%dx),%al
80102fef:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ff2:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102ff5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ff8:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102ffb:	6a 18                	push   $0x18
80102ffd:	50                   	push   %eax
80102ffe:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103001:	50                   	push   %eax
80103002:	e8 d9 1c 00 00       	call   80104ce0 <memcmp>
80103007:	83 c4 10             	add    $0x10,%esp
8010300a:	85 c0                	test   %eax,%eax
8010300c:	0f 85 ce fe ff ff    	jne    80102ee0 <cmostime+0x20>
      break;
  }

  // convert
  if(bcd) {
80103012:	0f b6 75 b4          	movzbl -0x4c(%ebp),%esi
80103016:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103019:	89 f0                	mov    %esi,%eax
8010301b:	84 c0                	test   %al,%al
8010301d:	75 78                	jne    80103097 <cmostime+0x1d7>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010301f:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103022:	89 c2                	mov    %eax,%edx
80103024:	83 e0 0f             	and    $0xf,%eax
80103027:	c1 ea 04             	shr    $0x4,%edx
8010302a:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010302d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103030:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103033:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103036:	89 c2                	mov    %eax,%edx
80103038:	83 e0 0f             	and    $0xf,%eax
8010303b:	c1 ea 04             	shr    $0x4,%edx
8010303e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103041:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103044:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103047:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010304a:	89 c2                	mov    %eax,%edx
8010304c:	83 e0 0f             	and    $0xf,%eax
8010304f:	c1 ea 04             	shr    $0x4,%edx
80103052:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103055:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103058:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
8010305b:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010305e:	89 c2                	mov    %eax,%edx
80103060:	83 e0 0f             	and    $0xf,%eax
80103063:	c1 ea 04             	shr    $0x4,%edx
80103066:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103069:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010306c:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010306f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103072:	89 c2                	mov    %eax,%edx
80103074:	83 e0 0f             	and    $0xf,%eax
80103077:	c1 ea 04             	shr    $0x4,%edx
8010307a:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010307d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103080:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103083:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103086:	89 c2                	mov    %eax,%edx
80103088:	83 e0 0f             	and    $0xf,%eax
8010308b:	c1 ea 04             	shr    $0x4,%edx
8010308e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103091:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103094:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103097:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010309a:	89 03                	mov    %eax,(%ebx)
8010309c:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010309f:	89 43 04             	mov    %eax,0x4(%ebx)
801030a2:	8b 45 c0             	mov    -0x40(%ebp),%eax
801030a5:	89 43 08             	mov    %eax,0x8(%ebx)
801030a8:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801030ab:	89 43 0c             	mov    %eax,0xc(%ebx)
801030ae:	8b 45 c8             	mov    -0x38(%ebp),%eax
801030b1:	89 43 10             	mov    %eax,0x10(%ebx)
801030b4:	8b 45 cc             	mov    -0x34(%ebp),%eax
801030b7:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
801030ba:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
801030c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030c4:	5b                   	pop    %ebx
801030c5:	5e                   	pop    %esi
801030c6:	5f                   	pop    %edi
801030c7:	5d                   	pop    %ebp
801030c8:	c3                   	ret
801030c9:	66 90                	xchg   %ax,%ax
801030cb:	66 90                	xchg   %ax,%ax
801030cd:	66 90                	xchg   %ax,%ax
801030cf:	66 90                	xchg   %ax,%ax
801030d1:	66 90                	xchg   %ax,%ax
801030d3:	66 90                	xchg   %ax,%ax
801030d5:	66 90                	xchg   %ax,%ax
801030d7:	66 90                	xchg   %ax,%ax
801030d9:	66 90                	xchg   %ax,%ax
801030db:	66 90                	xchg   %ax,%ax
801030dd:	66 90                	xchg   %ax,%ax
801030df:	90                   	nop

801030e0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801030e0:	8b 0d a8 27 11 80    	mov    0x801127a8,%ecx
801030e6:	85 c9                	test   %ecx,%ecx
801030e8:	0f 8e 8a 00 00 00    	jle    80103178 <install_trans+0x98>
{
801030ee:	55                   	push   %ebp
801030ef:	89 e5                	mov    %esp,%ebp
801030f1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
801030f2:	31 ff                	xor    %edi,%edi
{
801030f4:	56                   	push   %esi
801030f5:	53                   	push   %ebx
801030f6:	83 ec 0c             	sub    $0xc,%esp
801030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103100:	a1 94 27 11 80       	mov    0x80112794,%eax
80103105:	83 ec 08             	sub    $0x8,%esp
80103108:	01 f8                	add    %edi,%eax
8010310a:	83 c0 01             	add    $0x1,%eax
8010310d:	50                   	push   %eax
8010310e:	ff 35 a4 27 11 80    	push   0x801127a4
80103114:	e8 37 d0 ff ff       	call   80100150 <bread>
80103119:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010311b:	58                   	pop    %eax
8010311c:	5a                   	pop    %edx
8010311d:	ff 34 bd ac 27 11 80 	push   -0x7feed854(,%edi,4)
80103124:	ff 35 a4 27 11 80    	push   0x801127a4
  for (tail = 0; tail < log.lh.n; tail++) {
8010312a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
8010312d:	e8 1e d0 ff ff       	call   80100150 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103132:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103135:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103137:	8d 46 5c             	lea    0x5c(%esi),%eax
8010313a:	68 00 02 00 00       	push   $0x200
8010313f:	50                   	push   %eax
80103140:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103143:	50                   	push   %eax
80103144:	e8 e7 1b 00 00       	call   80104d30 <memmove>
    bwrite(dbuf);  // write dst to disk
80103149:	89 1c 24             	mov    %ebx,(%esp)
8010314c:	e8 3f d0 ff ff       	call   80100190 <bwrite>
    brelse(lbuf);
80103151:	89 34 24             	mov    %esi,(%esp)
80103154:	e8 77 d0 ff ff       	call   801001d0 <brelse>
    brelse(dbuf);
80103159:	89 1c 24             	mov    %ebx,(%esp)
8010315c:	e8 6f d0 ff ff       	call   801001d0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103161:	83 c4 10             	add    $0x10,%esp
80103164:	39 3d a8 27 11 80    	cmp    %edi,0x801127a8
8010316a:	7f 94                	jg     80103100 <install_trans+0x20>
  }
}
8010316c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010316f:	5b                   	pop    %ebx
80103170:	5e                   	pop    %esi
80103171:	5f                   	pop    %edi
80103172:	5d                   	pop    %ebp
80103173:	c3                   	ret
80103174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103178:	c3                   	ret
80103179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103180 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103180:	55                   	push   %ebp
80103181:	89 e5                	mov    %esp,%ebp
80103183:	53                   	push   %ebx
80103184:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103187:	ff 35 94 27 11 80    	push   0x80112794
8010318d:	ff 35 a4 27 11 80    	push   0x801127a4
80103193:	e8 b8 cf ff ff       	call   80100150 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103198:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010319b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010319d:	a1 a8 27 11 80       	mov    0x801127a8,%eax
801031a2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
801031a5:	85 c0                	test   %eax,%eax
801031a7:	7e 29                	jle    801031d2 <write_head+0x52>
801031a9:	31 d2                	xor    %edx,%edx
801031ab:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031b2:	00 
801031b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031ba:	00 
801031bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
801031c0:	8b 0c 95 ac 27 11 80 	mov    -0x7feed854(,%edx,4),%ecx
801031c7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801031cb:	83 c2 01             	add    $0x1,%edx
801031ce:	39 d0                	cmp    %edx,%eax
801031d0:	75 ee                	jne    801031c0 <write_head+0x40>
  }
  bwrite(buf);
801031d2:	83 ec 0c             	sub    $0xc,%esp
801031d5:	53                   	push   %ebx
801031d6:	e8 b5 cf ff ff       	call   80100190 <bwrite>
  brelse(buf);
801031db:	89 1c 24             	mov    %ebx,(%esp)
801031de:	e8 ed cf ff ff       	call   801001d0 <brelse>
}
801031e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801031e6:	83 c4 10             	add    $0x10,%esp
801031e9:	c9                   	leave
801031ea:	c3                   	ret
801031eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801031f0 <initlog>:
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	53                   	push   %ebx
801031f4:	83 ec 2c             	sub    $0x2c,%esp
801031f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
801031fa:	68 65 82 10 80       	push   $0x80108265
801031ff:	68 60 27 11 80       	push   $0x80112760
80103204:	e8 77 17 00 00       	call   80104980 <initlock>
  readsb(dev, &sb);
80103209:	58                   	pop    %eax
8010320a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010320d:	5a                   	pop    %edx
8010320e:	50                   	push   %eax
8010320f:	53                   	push   %ebx
80103210:	e8 6b e6 ff ff       	call   80101880 <readsb>
  log.start = sb.logstart;
80103215:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103218:	59                   	pop    %ecx
  log.dev = dev;
80103219:	89 1d a4 27 11 80    	mov    %ebx,0x801127a4
  log.size = sb.nlog;
8010321f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103222:	a3 94 27 11 80       	mov    %eax,0x80112794
  log.size = sb.nlog;
80103227:	89 15 98 27 11 80    	mov    %edx,0x80112798
  struct buf *buf = bread(log.dev, log.start);
8010322d:	5a                   	pop    %edx
8010322e:	50                   	push   %eax
8010322f:	53                   	push   %ebx
80103230:	e8 1b cf ff ff       	call   80100150 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103235:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103238:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010323b:	89 1d a8 27 11 80    	mov    %ebx,0x801127a8
  for (i = 0; i < log.lh.n; i++) {
80103241:	85 db                	test   %ebx,%ebx
80103243:	7e 2d                	jle    80103272 <initlog+0x82>
80103245:	31 d2                	xor    %edx,%edx
80103247:	eb 17                	jmp    80103260 <initlog+0x70>
80103249:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103250:	00 
80103251:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103258:	00 
80103259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80103260:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103264:	89 0c 95 ac 27 11 80 	mov    %ecx,-0x7feed854(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010326b:	83 c2 01             	add    $0x1,%edx
8010326e:	39 d3                	cmp    %edx,%ebx
80103270:	75 ee                	jne    80103260 <initlog+0x70>
  brelse(buf);
80103272:	83 ec 0c             	sub    $0xc,%esp
80103275:	50                   	push   %eax
80103276:	e8 55 cf ff ff       	call   801001d0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010327b:	e8 60 fe ff ff       	call   801030e0 <install_trans>
  log.lh.n = 0;
80103280:	c7 05 a8 27 11 80 00 	movl   $0x0,0x801127a8
80103287:	00 00 00 
  write_head(); // clear the log
8010328a:	e8 f1 fe ff ff       	call   80103180 <write_head>
}
8010328f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103292:	83 c4 10             	add    $0x10,%esp
80103295:	c9                   	leave
80103296:	c3                   	ret
80103297:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010329e:	00 
8010329f:	90                   	nop

801032a0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
801032a0:	55                   	push   %ebp
801032a1:	89 e5                	mov    %esp,%ebp
801032a3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
801032a6:	68 60 27 11 80       	push   $0x80112760
801032ab:	e8 20 18 00 00       	call   80104ad0 <acquire>
801032b0:	83 c4 10             	add    $0x10,%esp
801032b3:	eb 18                	jmp    801032cd <begin_op+0x2d>
801032b5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
801032b8:	83 ec 08             	sub    $0x8,%esp
801032bb:	68 60 27 11 80       	push   $0x80112760
801032c0:	68 60 27 11 80       	push   $0x80112760
801032c5:	e8 36 13 00 00       	call   80104600 <sleep>
801032ca:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
801032cd:	a1 a0 27 11 80       	mov    0x801127a0,%eax
801032d2:	85 c0                	test   %eax,%eax
801032d4:	75 e2                	jne    801032b8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
801032d6:	a1 9c 27 11 80       	mov    0x8011279c,%eax
801032db:	8b 15 a8 27 11 80    	mov    0x801127a8,%edx
801032e1:	83 c0 01             	add    $0x1,%eax
801032e4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
801032e7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
801032ea:	83 fa 1e             	cmp    $0x1e,%edx
801032ed:	7f c9                	jg     801032b8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
801032ef:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
801032f2:	a3 9c 27 11 80       	mov    %eax,0x8011279c
      release(&log.lock);
801032f7:	68 60 27 11 80       	push   $0x80112760
801032fc:	e8 4f 19 00 00       	call   80104c50 <release>
      break;
    }
  }
}
80103301:	83 c4 10             	add    $0x10,%esp
80103304:	c9                   	leave
80103305:	c3                   	ret
80103306:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010330d:	00 
8010330e:	66 90                	xchg   %ax,%ax

80103310 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103310:	55                   	push   %ebp
80103311:	89 e5                	mov    %esp,%ebp
80103313:	57                   	push   %edi
80103314:	56                   	push   %esi
80103315:	53                   	push   %ebx
80103316:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103319:	68 60 27 11 80       	push   $0x80112760
8010331e:	e8 ad 17 00 00       	call   80104ad0 <acquire>
  log.outstanding -= 1;
80103323:	a1 9c 27 11 80       	mov    0x8011279c,%eax
  if(log.committing)
80103328:	8b 35 a0 27 11 80    	mov    0x801127a0,%esi
8010332e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103331:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103334:	89 1d 9c 27 11 80    	mov    %ebx,0x8011279c
  if(log.committing)
8010333a:	85 f6                	test   %esi,%esi
8010333c:	0f 85 22 01 00 00    	jne    80103464 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103342:	85 db                	test   %ebx,%ebx
80103344:	0f 85 f6 00 00 00    	jne    80103440 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010334a:	c7 05 a0 27 11 80 01 	movl   $0x1,0x801127a0
80103351:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103354:	83 ec 0c             	sub    $0xc,%esp
80103357:	68 60 27 11 80       	push   $0x80112760
8010335c:	e8 ef 18 00 00       	call   80104c50 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103361:	8b 0d a8 27 11 80    	mov    0x801127a8,%ecx
80103367:	83 c4 10             	add    $0x10,%esp
8010336a:	85 c9                	test   %ecx,%ecx
8010336c:	7f 42                	jg     801033b0 <end_op+0xa0>
    acquire(&log.lock);
8010336e:	83 ec 0c             	sub    $0xc,%esp
80103371:	68 60 27 11 80       	push   $0x80112760
80103376:	e8 55 17 00 00       	call   80104ad0 <acquire>
    log.committing = 0;
8010337b:	c7 05 a0 27 11 80 00 	movl   $0x0,0x801127a0
80103382:	00 00 00 
    wakeup(&log);
80103385:	c7 04 24 60 27 11 80 	movl   $0x80112760,(%esp)
8010338c:	e8 2f 13 00 00       	call   801046c0 <wakeup>
    release(&log.lock);
80103391:	c7 04 24 60 27 11 80 	movl   $0x80112760,(%esp)
80103398:	e8 b3 18 00 00       	call   80104c50 <release>
8010339d:	83 c4 10             	add    $0x10,%esp
}
801033a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033a3:	5b                   	pop    %ebx
801033a4:	5e                   	pop    %esi
801033a5:	5f                   	pop    %edi
801033a6:	5d                   	pop    %ebp
801033a7:	c3                   	ret
801033a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033af:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801033b0:	a1 94 27 11 80       	mov    0x80112794,%eax
801033b5:	83 ec 08             	sub    $0x8,%esp
801033b8:	01 d8                	add    %ebx,%eax
801033ba:	83 c0 01             	add    $0x1,%eax
801033bd:	50                   	push   %eax
801033be:	ff 35 a4 27 11 80    	push   0x801127a4
801033c4:	e8 87 cd ff ff       	call   80100150 <bread>
801033c9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801033cb:	58                   	pop    %eax
801033cc:	5a                   	pop    %edx
801033cd:	ff 34 9d ac 27 11 80 	push   -0x7feed854(,%ebx,4)
801033d4:	ff 35 a4 27 11 80    	push   0x801127a4
  for (tail = 0; tail < log.lh.n; tail++) {
801033da:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801033dd:	e8 6e cd ff ff       	call   80100150 <bread>
    memmove(to->data, from->data, BSIZE);
801033e2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801033e5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
801033e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801033ea:	68 00 02 00 00       	push   $0x200
801033ef:	50                   	push   %eax
801033f0:	8d 46 5c             	lea    0x5c(%esi),%eax
801033f3:	50                   	push   %eax
801033f4:	e8 37 19 00 00       	call   80104d30 <memmove>
    bwrite(to);  // write the log
801033f9:	89 34 24             	mov    %esi,(%esp)
801033fc:	e8 8f cd ff ff       	call   80100190 <bwrite>
    brelse(from);
80103401:	89 3c 24             	mov    %edi,(%esp)
80103404:	e8 c7 cd ff ff       	call   801001d0 <brelse>
    brelse(to);
80103409:	89 34 24             	mov    %esi,(%esp)
8010340c:	e8 bf cd ff ff       	call   801001d0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103411:	83 c4 10             	add    $0x10,%esp
80103414:	3b 1d a8 27 11 80    	cmp    0x801127a8,%ebx
8010341a:	7c 94                	jl     801033b0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010341c:	e8 5f fd ff ff       	call   80103180 <write_head>
    install_trans(); // Now install writes to home locations
80103421:	e8 ba fc ff ff       	call   801030e0 <install_trans>
    log.lh.n = 0;
80103426:	c7 05 a8 27 11 80 00 	movl   $0x0,0x801127a8
8010342d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103430:	e8 4b fd ff ff       	call   80103180 <write_head>
80103435:	e9 34 ff ff ff       	jmp    8010336e <end_op+0x5e>
8010343a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103440:	83 ec 0c             	sub    $0xc,%esp
80103443:	68 60 27 11 80       	push   $0x80112760
80103448:	e8 73 12 00 00       	call   801046c0 <wakeup>
  release(&log.lock);
8010344d:	c7 04 24 60 27 11 80 	movl   $0x80112760,(%esp)
80103454:	e8 f7 17 00 00       	call   80104c50 <release>
80103459:	83 c4 10             	add    $0x10,%esp
}
8010345c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010345f:	5b                   	pop    %ebx
80103460:	5e                   	pop    %esi
80103461:	5f                   	pop    %edi
80103462:	5d                   	pop    %ebp
80103463:	c3                   	ret
    panic("log.committing");
80103464:	83 ec 0c             	sub    $0xc,%esp
80103467:	68 69 82 10 80       	push   $0x80108269
8010346c:	e8 3f d0 ff ff       	call   801004b0 <panic>
80103471:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103478:	00 
80103479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103480 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103480:	55                   	push   %ebp
80103481:	89 e5                	mov    %esp,%ebp
80103483:	53                   	push   %ebx
80103484:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103487:	8b 15 a8 27 11 80    	mov    0x801127a8,%edx
{
8010348d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103490:	83 fa 1d             	cmp    $0x1d,%edx
80103493:	7f 7d                	jg     80103512 <log_write+0x92>
80103495:	a1 98 27 11 80       	mov    0x80112798,%eax
8010349a:	83 e8 01             	sub    $0x1,%eax
8010349d:	39 c2                	cmp    %eax,%edx
8010349f:	7d 71                	jge    80103512 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
801034a1:	a1 9c 27 11 80       	mov    0x8011279c,%eax
801034a6:	85 c0                	test   %eax,%eax
801034a8:	7e 75                	jle    8010351f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
801034aa:	83 ec 0c             	sub    $0xc,%esp
801034ad:	68 60 27 11 80       	push   $0x80112760
801034b2:	e8 19 16 00 00       	call   80104ad0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
801034b7:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801034ba:	83 c4 10             	add    $0x10,%esp
801034bd:	31 c0                	xor    %eax,%eax
801034bf:	8b 15 a8 27 11 80    	mov    0x801127a8,%edx
801034c5:	85 d2                	test   %edx,%edx
801034c7:	7f 0e                	jg     801034d7 <log_write+0x57>
801034c9:	eb 15                	jmp    801034e0 <log_write+0x60>
801034cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801034d0:	83 c0 01             	add    $0x1,%eax
801034d3:	39 d0                	cmp    %edx,%eax
801034d5:	74 29                	je     80103500 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801034d7:	39 0c 85 ac 27 11 80 	cmp    %ecx,-0x7feed854(,%eax,4)
801034de:	75 f0                	jne    801034d0 <log_write+0x50>
  log.lh.block[i] = b->blockno;
801034e0:	89 0c 85 ac 27 11 80 	mov    %ecx,-0x7feed854(,%eax,4)
  if (i == log.lh.n)
801034e7:	39 c2                	cmp    %eax,%edx
801034e9:	74 1c                	je     80103507 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
801034eb:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
801034ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
801034f1:	c7 45 08 60 27 11 80 	movl   $0x80112760,0x8(%ebp)
}
801034f8:	c9                   	leave
  release(&log.lock);
801034f9:	e9 52 17 00 00       	jmp    80104c50 <release>
801034fe:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103500:	89 0c 95 ac 27 11 80 	mov    %ecx,-0x7feed854(,%edx,4)
    log.lh.n++;
80103507:	83 c2 01             	add    $0x1,%edx
8010350a:	89 15 a8 27 11 80    	mov    %edx,0x801127a8
80103510:	eb d9                	jmp    801034eb <log_write+0x6b>
    panic("too big a transaction");
80103512:	83 ec 0c             	sub    $0xc,%esp
80103515:	68 78 82 10 80       	push   $0x80108278
8010351a:	e8 91 cf ff ff       	call   801004b0 <panic>
    panic("log_write outside of trans");
8010351f:	83 ec 0c             	sub    $0xc,%esp
80103522:	68 8e 82 10 80       	push   $0x8010828e
80103527:	e8 84 cf ff ff       	call   801004b0 <panic>
8010352c:	66 90                	xchg   %ax,%ax
8010352e:	66 90                	xchg   %ax,%ax

80103530 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	53                   	push   %ebx
80103534:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103537:	e8 e4 09 00 00       	call   80103f20 <cpuid>
8010353c:	89 c3                	mov    %eax,%ebx
8010353e:	e8 dd 09 00 00       	call   80103f20 <cpuid>
80103543:	83 ec 04             	sub    $0x4,%esp
80103546:	53                   	push   %ebx
80103547:	50                   	push   %eax
80103548:	68 a9 82 10 80       	push   $0x801082a9
8010354d:	e8 9e d2 ff ff       	call   801007f0 <cprintf>
  idtinit();       // load idt register
80103552:	e8 d9 2b 00 00       	call   80106130 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103557:	e8 64 09 00 00       	call   80103ec0 <mycpu>
8010355c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010355e:	b8 01 00 00 00       	mov    $0x1,%eax
80103563:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010356a:	e8 61 0c 00 00       	call   801041d0 <scheduler>
8010356f:	90                   	nop

80103570 <mpenter>:
{
80103570:	55                   	push   %ebp
80103571:	89 e5                	mov    %esp,%ebp
80103573:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103576:	e8 95 41 00 00       	call   80107710 <switchkvm>
  seginit();
8010357b:	e8 00 41 00 00       	call   80107680 <seginit>
  lapicinit();
80103580:	e8 4b f7 ff ff       	call   80102cd0 <lapicinit>
  mpmain();
80103585:	e8 a6 ff ff ff       	call   80103530 <mpmain>
8010358a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103590 <enablecur>:
{
80103590:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103591:	b8 0a 00 00 00       	mov    $0xa,%eax
80103596:	ba d4 03 00 00       	mov    $0x3d4,%edx
8010359b:	89 e5                	mov    %esp,%ebp
8010359d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010359e:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801035a3:	89 ca                	mov    %ecx,%edx
801035a5:	ec                   	in     (%dx),%al
	outb(0x3D5, (inb(0x3D5) & 0xC0) | cursor_start);
801035a6:	83 e0 c0             	and    $0xffffffc0,%eax
801035a9:	0a 45 08             	or     0x8(%ebp),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035ac:	ee                   	out    %al,(%dx)
801035ad:	b8 0b 00 00 00       	mov    $0xb,%eax
801035b2:	ba d4 03 00 00       	mov    $0x3d4,%edx
801035b7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035b8:	89 ca                	mov    %ecx,%edx
801035ba:	ec                   	in     (%dx),%al
	outb(0x3D5, (inb(0x3D5) & 0xE0) | cursor_end);
801035bb:	83 e0 e0             	and    $0xffffffe0,%eax
801035be:	0a 45 0c             	or     0xc(%ebp),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801035c1:	ee                   	out    %al,(%dx)
}
801035c2:	5d                   	pop    %ebp
801035c3:	c3                   	ret
801035c4:	66 90                	xchg   %ax,%ax
801035c6:	66 90                	xchg   %ax,%ax
801035c8:	66 90                	xchg   %ax,%ax
801035ca:	66 90                	xchg   %ax,%ax
801035cc:	66 90                	xchg   %ax,%ax
801035ce:	66 90                	xchg   %ax,%ax

801035d0 <main>:
{
801035d0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801035d4:	83 e4 f0             	and    $0xfffffff0,%esp
801035d7:	ff 71 fc             	push   -0x4(%ecx)
801035da:	55                   	push   %ebp
801035db:	89 e5                	mov    %esp,%ebp
801035dd:	53                   	push   %ebx
801035de:	51                   	push   %ecx
  cprintf("%s", bootbanner);
801035df:	83 ec 08             	sub    $0x8,%esp
801035e2:	ff 35 00 b0 10 80    	push   0x8010b000
801035e8:	68 97 83 10 80       	push   $0x80108397
801035ed:	e8 fe d1 ff ff       	call   801007f0 <cprintf>
  enablecur(0, 16);
801035f2:	58                   	pop    %eax
801035f3:	5a                   	pop    %edx
801035f4:	6a 10                	push   $0x10
801035f6:	6a 00                	push   $0x0
801035f8:	e8 93 ff ff ff       	call   80103590 <enablecur>
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801035fd:	59                   	pop    %ecx
801035fe:	5b                   	pop    %ebx
801035ff:	68 00 00 40 80       	push   $0x80400000
80103604:	68 90 65 11 80       	push   $0x80116590
80103609:	e8 d2 f4 ff ff       	call   80102ae0 <kinit1>
  kvmalloc();      // kernel page table
8010360e:	e8 8d 45 00 00       	call   80107ba0 <kvmalloc>
  mpinit();        // detect other processors
80103613:	e8 88 01 00 00       	call   801037a0 <mpinit>
  lapicinit();     // interrupt controller
80103618:	e8 b3 f6 ff ff       	call   80102cd0 <lapicinit>
  seginit();       // segment descriptors
8010361d:	e8 5e 40 00 00       	call   80107680 <seginit>
  picinit();       // disable pic
80103622:	e8 59 03 00 00       	call   80103980 <picinit>
  ioapicinit();    // another interrupt controller
80103627:	e8 54 f2 ff ff       	call   80102880 <ioapicinit>
  consoleinit();   // console hardware
8010362c:	e8 9f d5 ff ff       	call   80100bd0 <consoleinit>
  uartinit();      // serial port
80103631:	e8 6a 32 00 00       	call   801068a0 <uartinit>
  pinit();         // process table
80103636:	e8 65 08 00 00       	call   80103ea0 <pinit>
  tvinit();        // trap vectors
8010363b:	e8 40 2a 00 00       	call   80106080 <tvinit>
  binit();         // buffer cache
80103640:	e8 7b ca ff ff       	call   801000c0 <binit>
  fileinit();      // file table
80103645:	e8 e6 da ff ff       	call   80101130 <fileinit>
  ideinit();       // disk 
8010364a:	e8 e1 ef ff ff       	call   80102630 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
8010364f:	83 c4 0c             	add    $0xc,%esp
80103652:	68 8a 00 00 00       	push   $0x8a
80103657:	68 8c b4 10 80       	push   $0x8010b48c
8010365c:	68 00 70 00 80       	push   $0x80007000
80103661:	e8 ca 16 00 00       	call   80104d30 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103666:	83 c4 10             	add    $0x10,%esp
80103669:	69 05 44 28 11 80 b0 	imul   $0xb0,0x80112844,%eax
80103670:	00 00 00 
80103673:	05 60 28 11 80       	add    $0x80112860,%eax
80103678:	3d 60 28 11 80       	cmp    $0x80112860,%eax
8010367d:	0f 86 7d 00 00 00    	jbe    80103700 <main+0x130>
80103683:	bb 60 28 11 80       	mov    $0x80112860,%ebx
80103688:	eb 1f                	jmp    801036a9 <main+0xd9>
8010368a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103690:	69 05 44 28 11 80 b0 	imul   $0xb0,0x80112844,%eax
80103697:	00 00 00 
8010369a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801036a0:	05 60 28 11 80       	add    $0x80112860,%eax
801036a5:	39 c3                	cmp    %eax,%ebx
801036a7:	73 57                	jae    80103700 <main+0x130>
    if(c == mycpu())  // We've started already.
801036a9:	e8 12 08 00 00       	call   80103ec0 <mycpu>
801036ae:	39 c3                	cmp    %eax,%ebx
801036b0:	74 de                	je     80103690 <main+0xc0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801036b2:	e8 99 f4 ff ff       	call   80102b50 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801036b7:	83 ec 08             	sub    $0x8,%esp
    *(void**)(code-8) = mpenter;
801036ba:	c7 05 f8 6f 00 80 70 	movl   $0x80103570,0x80006ff8
801036c1:	35 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801036c4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801036cb:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801036ce:	05 00 10 00 00       	add    $0x1000,%eax
801036d3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801036d8:	68 00 70 00 00       	push   $0x7000
801036dd:	0f b6 03             	movzbl (%ebx),%eax
801036e0:	50                   	push   %eax
801036e1:	e8 4a f7 ff ff       	call   80102e30 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801036e6:	83 c4 10             	add    $0x10,%esp
801036e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036f0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801036f6:	85 c0                	test   %eax,%eax
801036f8:	74 f6                	je     801036f0 <main+0x120>
801036fa:	eb 94                	jmp    80103690 <main+0xc0>
801036fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103700:	83 ec 08             	sub    $0x8,%esp
80103703:	68 00 00 40 80       	push   $0x80400000
80103708:	68 00 00 40 80       	push   $0x80400000
8010370d:	e8 6e f3 ff ff       	call   80102a80 <kinit2>
  userinit();      // first user process
80103712:	e8 59 08 00 00       	call   80103f70 <userinit>
  mpmain();        // finish this processor's setup
80103717:	e8 14 fe ff ff       	call   80103530 <mpmain>
8010371c:	66 90                	xchg   %ax,%ax
8010371e:	66 90                	xchg   %ax,%ax

80103720 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	57                   	push   %edi
80103724:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103725:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010372b:	53                   	push   %ebx
  e = addr+len;
8010372c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010372f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103732:	39 de                	cmp    %ebx,%esi
80103734:	72 10                	jb     80103746 <mpsearch1+0x26>
80103736:	eb 58                	jmp    80103790 <mpsearch1+0x70>
80103738:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010373f:	00 
80103740:	89 fe                	mov    %edi,%esi
80103742:	39 df                	cmp    %ebx,%edi
80103744:	73 4a                	jae    80103790 <mpsearch1+0x70>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103746:	83 ec 04             	sub    $0x4,%esp
80103749:	8d 7e 10             	lea    0x10(%esi),%edi
8010374c:	6a 04                	push   $0x4
8010374e:	68 bd 82 10 80       	push   $0x801082bd
80103753:	56                   	push   %esi
80103754:	e8 87 15 00 00       	call   80104ce0 <memcmp>
80103759:	83 c4 10             	add    $0x10,%esp
8010375c:	85 c0                	test   %eax,%eax
8010375e:	75 e0                	jne    80103740 <mpsearch1+0x20>
80103760:	89 f2                	mov    %esi,%edx
80103762:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103769:	00 
8010376a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103770:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103773:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103776:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103778:	39 fa                	cmp    %edi,%edx
8010377a:	75 f4                	jne    80103770 <mpsearch1+0x50>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010377c:	84 c0                	test   %al,%al
8010377e:	75 c0                	jne    80103740 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103780:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103783:	89 f0                	mov    %esi,%eax
80103785:	5b                   	pop    %ebx
80103786:	5e                   	pop    %esi
80103787:	5f                   	pop    %edi
80103788:	5d                   	pop    %ebp
80103789:	c3                   	ret
8010378a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103790:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103793:	31 f6                	xor    %esi,%esi
}
80103795:	5b                   	pop    %ebx
80103796:	89 f0                	mov    %esi,%eax
80103798:	5e                   	pop    %esi
80103799:	5f                   	pop    %edi
8010379a:	5d                   	pop    %ebp
8010379b:	c3                   	ret
8010379c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037a0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	57                   	push   %edi
801037a4:	56                   	push   %esi
801037a5:	53                   	push   %ebx
801037a6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801037a9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801037b0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801037b7:	c1 e0 08             	shl    $0x8,%eax
801037ba:	09 d0                	or     %edx,%eax
801037bc:	c1 e0 04             	shl    $0x4,%eax
801037bf:	75 1b                	jne    801037dc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801037c1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801037c8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801037cf:	c1 e0 08             	shl    $0x8,%eax
801037d2:	09 d0                	or     %edx,%eax
801037d4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801037d7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801037dc:	ba 00 04 00 00       	mov    $0x400,%edx
801037e1:	e8 3a ff ff ff       	call   80103720 <mpsearch1>
801037e6:	89 c3                	mov    %eax,%ebx
801037e8:	85 c0                	test   %eax,%eax
801037ea:	0f 84 38 01 00 00    	je     80103928 <mpinit+0x188>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801037f0:	8b 73 04             	mov    0x4(%ebx),%esi
801037f3:	85 f6                	test   %esi,%esi
801037f5:	0f 84 1d 01 00 00    	je     80103918 <mpinit+0x178>
  if(memcmp(conf, "PCMP", 4) != 0)
801037fb:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801037fe:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103804:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103807:	6a 04                	push   $0x4
80103809:	68 c2 82 10 80       	push   $0x801082c2
8010380e:	50                   	push   %eax
8010380f:	e8 cc 14 00 00       	call   80104ce0 <memcmp>
80103814:	83 c4 10             	add    $0x10,%esp
80103817:	89 c2                	mov    %eax,%edx
80103819:	85 c0                	test   %eax,%eax
8010381b:	0f 85 f7 00 00 00    	jne    80103918 <mpinit+0x178>
  if(conf->version != 1 && conf->version != 4)
80103821:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103828:	3c 01                	cmp    $0x1,%al
8010382a:	74 08                	je     80103834 <mpinit+0x94>
8010382c:	3c 04                	cmp    $0x4,%al
8010382e:	0f 85 e4 00 00 00    	jne    80103918 <mpinit+0x178>
  if(sum((uchar*)conf, conf->length) != 0)
80103834:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
  for(i=0; i<len; i++)
8010383b:	66 85 c9             	test   %cx,%cx
8010383e:	74 28                	je     80103868 <mpinit+0xc8>
80103840:	89 f0                	mov    %esi,%eax
80103842:	8d 3c 31             	lea    (%ecx,%esi,1),%edi
80103845:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010384c:	00 
8010384d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103850:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
80103857:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
8010385a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010385c:	39 c7                	cmp    %eax,%edi
8010385e:	75 f0                	jne    80103850 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
80103860:	84 d2                	test   %dl,%dl
80103862:	0f 85 b0 00 00 00    	jne    80103918 <mpinit+0x178>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103868:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010386e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  lapic = (uint*)conf->lapicaddr;
80103871:	a3 40 27 11 80       	mov    %eax,0x80112740
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103876:	0f b7 8e 04 00 00 80 	movzwl -0x7ffffffc(%esi),%ecx
8010387d:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103883:	01 cf                	add    %ecx,%edi
80103885:	89 f9                	mov    %edi,%ecx
80103887:	39 f8                	cmp    %edi,%eax
80103889:	72 10                	jb     8010389b <mpinit+0xfb>
8010388b:	eb 34                	jmp    801038c1 <mpinit+0x121>
8010388d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(*p){
80103890:	84 d2                	test   %dl,%dl
80103892:	74 54                	je     801038e8 <mpinit+0x148>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103894:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103897:	39 c8                	cmp    %ecx,%eax
80103899:	73 26                	jae    801038c1 <mpinit+0x121>
    switch(*p){
8010389b:	0f b6 10             	movzbl (%eax),%edx
8010389e:	80 fa 02             	cmp    $0x2,%dl
801038a1:	74 0d                	je     801038b0 <mpinit+0x110>
801038a3:	76 eb                	jbe    80103890 <mpinit+0xf0>
801038a5:	83 ea 03             	sub    $0x3,%edx
801038a8:	80 fa 01             	cmp    $0x1,%dl
801038ab:	76 e7                	jbe    80103894 <mpinit+0xf4>
801038ad:	eb fe                	jmp    801038ad <mpinit+0x10d>
801038af:	90                   	nop
      ioapicid = ioapic->apicno;
801038b0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801038b4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801038b7:	88 15 40 28 11 80    	mov    %dl,0x80112840
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801038bd:	39 c8                	cmp    %ecx,%eax
801038bf:	72 da                	jb     8010389b <mpinit+0xfb>
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801038c1:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801038c5:	74 15                	je     801038dc <mpinit+0x13c>
801038c7:	b8 70 00 00 00       	mov    $0x70,%eax
801038cc:	ba 22 00 00 00       	mov    $0x22,%edx
801038d1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801038d2:	ba 23 00 00 00       	mov    $0x23,%edx
801038d7:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801038d8:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801038db:	ee                   	out    %al,(%dx)
  }
}
801038dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038df:	5b                   	pop    %ebx
801038e0:	5e                   	pop    %esi
801038e1:	5f                   	pop    %edi
801038e2:	5d                   	pop    %ebp
801038e3:	c3                   	ret
801038e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
801038e8:	8b 35 44 28 11 80    	mov    0x80112844,%esi
801038ee:	83 fe 07             	cmp    $0x7,%esi
801038f1:	7f 19                	jg     8010390c <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801038f3:	69 fe b0 00 00 00    	imul   $0xb0,%esi,%edi
801038f9:	0f b6 50 01          	movzbl 0x1(%eax),%edx
        ncpu++;
801038fd:	83 c6 01             	add    $0x1,%esi
80103900:	89 35 44 28 11 80    	mov    %esi,0x80112844
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103906:	88 97 60 28 11 80    	mov    %dl,-0x7feed7a0(%edi)
      p += sizeof(struct mpproc);
8010390c:	83 c0 14             	add    $0x14,%eax
      continue;
8010390f:	eb 86                	jmp    80103897 <mpinit+0xf7>
80103911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103918:	83 ec 0c             	sub    $0xc,%esp
8010391b:	68 c7 82 10 80       	push   $0x801082c7
80103920:	e8 8b cb ff ff       	call   801004b0 <panic>
80103925:	8d 76 00             	lea    0x0(%esi),%esi
{
80103928:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010392d:	eb 0b                	jmp    8010393a <mpinit+0x19a>
8010392f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103930:	89 f3                	mov    %esi,%ebx
80103932:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103938:	74 de                	je     80103918 <mpinit+0x178>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010393a:	83 ec 04             	sub    $0x4,%esp
8010393d:	8d 73 10             	lea    0x10(%ebx),%esi
80103940:	6a 04                	push   $0x4
80103942:	68 bd 82 10 80       	push   $0x801082bd
80103947:	53                   	push   %ebx
80103948:	e8 93 13 00 00       	call   80104ce0 <memcmp>
8010394d:	83 c4 10             	add    $0x10,%esp
80103950:	85 c0                	test   %eax,%eax
80103952:	75 dc                	jne    80103930 <mpinit+0x190>
80103954:	89 da                	mov    %ebx,%edx
80103956:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010395d:	00 
8010395e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80103960:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103963:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103966:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103968:	39 d6                	cmp    %edx,%esi
8010396a:	75 f4                	jne    80103960 <mpinit+0x1c0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010396c:	84 c0                	test   %al,%al
8010396e:	75 c0                	jne    80103930 <mpinit+0x190>
80103970:	e9 7b fe ff ff       	jmp    801037f0 <mpinit+0x50>
80103975:	66 90                	xchg   %ax,%ax
80103977:	66 90                	xchg   %ax,%ax
80103979:	66 90                	xchg   %ax,%ax
8010397b:	66 90                	xchg   %ax,%ax
8010397d:	66 90                	xchg   %ax,%ax
8010397f:	90                   	nop

80103980 <picinit>:
80103980:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103985:	ba 21 00 00 00       	mov    $0x21,%edx
8010398a:	ee                   	out    %al,(%dx)
8010398b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103990:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103991:	c3                   	ret
80103992:	66 90                	xchg   %ax,%ax
80103994:	66 90                	xchg   %ax,%ax
80103996:	66 90                	xchg   %ax,%ax
80103998:	66 90                	xchg   %ax,%ax
8010399a:	66 90                	xchg   %ax,%ax
8010399c:	66 90                	xchg   %ax,%ax
8010399e:	66 90                	xchg   %ax,%ax
801039a0:	66 90                	xchg   %ax,%ax
801039a2:	66 90                	xchg   %ax,%ax
801039a4:	66 90                	xchg   %ax,%ax
801039a6:	66 90                	xchg   %ax,%ax
801039a8:	66 90                	xchg   %ax,%ax
801039aa:	66 90                	xchg   %ax,%ax
801039ac:	66 90                	xchg   %ax,%ax
801039ae:	66 90                	xchg   %ax,%ax
801039b0:	66 90                	xchg   %ax,%ax
801039b2:	66 90                	xchg   %ax,%ax
801039b4:	66 90                	xchg   %ax,%ax
801039b6:	66 90                	xchg   %ax,%ax
801039b8:	66 90                	xchg   %ax,%ax
801039ba:	66 90                	xchg   %ax,%ax
801039bc:	66 90                	xchg   %ax,%ax
801039be:	66 90                	xchg   %ax,%ax

801039c0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	57                   	push   %edi
801039c4:	56                   	push   %esi
801039c5:	53                   	push   %ebx
801039c6:	83 ec 0c             	sub    $0xc,%esp
801039c9:	8b 75 08             	mov    0x8(%ebp),%esi
801039cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801039cf:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
801039d5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801039db:	e8 70 d7 ff ff       	call   80101150 <filealloc>
801039e0:	89 06                	mov    %eax,(%esi)
801039e2:	85 c0                	test   %eax,%eax
801039e4:	0f 84 a5 00 00 00    	je     80103a8f <pipealloc+0xcf>
801039ea:	e8 61 d7 ff ff       	call   80101150 <filealloc>
801039ef:	89 07                	mov    %eax,(%edi)
801039f1:	85 c0                	test   %eax,%eax
801039f3:	0f 84 84 00 00 00    	je     80103a7d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801039f9:	e8 52 f1 ff ff       	call   80102b50 <kalloc>
801039fe:	89 c3                	mov    %eax,%ebx
80103a00:	85 c0                	test   %eax,%eax
80103a02:	0f 84 a0 00 00 00    	je     80103aa8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103a08:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103a0f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103a12:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103a15:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103a1c:	00 00 00 
  p->nwrite = 0;
80103a1f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103a26:	00 00 00 
  p->nread = 0;
80103a29:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103a30:	00 00 00 
  initlock(&p->lock, "pipe");
80103a33:	68 df 82 10 80       	push   $0x801082df
80103a38:	50                   	push   %eax
80103a39:	e8 42 0f 00 00       	call   80104980 <initlock>
  (*f0)->type = FD_PIPE;
80103a3e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103a40:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103a43:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103a49:	8b 06                	mov    (%esi),%eax
80103a4b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103a4f:	8b 06                	mov    (%esi),%eax
80103a51:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103a55:	8b 06                	mov    (%esi),%eax
80103a57:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103a5a:	8b 07                	mov    (%edi),%eax
80103a5c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103a62:	8b 07                	mov    (%edi),%eax
80103a64:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103a68:	8b 07                	mov    (%edi),%eax
80103a6a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103a6e:	8b 07                	mov    (%edi),%eax
80103a70:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103a73:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103a75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a78:	5b                   	pop    %ebx
80103a79:	5e                   	pop    %esi
80103a7a:	5f                   	pop    %edi
80103a7b:	5d                   	pop    %ebp
80103a7c:	c3                   	ret
  if(*f0)
80103a7d:	8b 06                	mov    (%esi),%eax
80103a7f:	85 c0                	test   %eax,%eax
80103a81:	74 1e                	je     80103aa1 <pipealloc+0xe1>
    fileclose(*f0);
80103a83:	83 ec 0c             	sub    $0xc,%esp
80103a86:	50                   	push   %eax
80103a87:	e8 94 d7 ff ff       	call   80101220 <fileclose>
80103a8c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103a8f:	8b 07                	mov    (%edi),%eax
80103a91:	85 c0                	test   %eax,%eax
80103a93:	74 0c                	je     80103aa1 <pipealloc+0xe1>
    fileclose(*f1);
80103a95:	83 ec 0c             	sub    $0xc,%esp
80103a98:	50                   	push   %eax
80103a99:	e8 82 d7 ff ff       	call   80101220 <fileclose>
80103a9e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103aa1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103aa6:	eb cd                	jmp    80103a75 <pipealloc+0xb5>
  if(*f0)
80103aa8:	8b 06                	mov    (%esi),%eax
80103aaa:	85 c0                	test   %eax,%eax
80103aac:	75 d5                	jne    80103a83 <pipealloc+0xc3>
80103aae:	eb df                	jmp    80103a8f <pipealloc+0xcf>

80103ab0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	56                   	push   %esi
80103ab4:	53                   	push   %ebx
80103ab5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103ab8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103abb:	83 ec 0c             	sub    $0xc,%esp
80103abe:	53                   	push   %ebx
80103abf:	e8 0c 10 00 00       	call   80104ad0 <acquire>
  if(writable){
80103ac4:	83 c4 10             	add    $0x10,%esp
80103ac7:	85 f6                	test   %esi,%esi
80103ac9:	74 45                	je     80103b10 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
80103acb:	83 ec 0c             	sub    $0xc,%esp
80103ace:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103ad4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103adb:	00 00 00 
    wakeup(&p->nread);
80103ade:	50                   	push   %eax
80103adf:	e8 dc 0b 00 00       	call   801046c0 <wakeup>
80103ae4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103ae7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103aed:	85 d2                	test   %edx,%edx
80103aef:	75 0a                	jne    80103afb <pipeclose+0x4b>
80103af1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103af7:	85 c0                	test   %eax,%eax
80103af9:	74 35                	je     80103b30 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103afb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103afe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b01:	5b                   	pop    %ebx
80103b02:	5e                   	pop    %esi
80103b03:	5d                   	pop    %ebp
    release(&p->lock);
80103b04:	e9 47 11 00 00       	jmp    80104c50 <release>
80103b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
80103b10:	83 ec 0c             	sub    $0xc,%esp
80103b13:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103b19:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103b20:	00 00 00 
    wakeup(&p->nwrite);
80103b23:	50                   	push   %eax
80103b24:	e8 97 0b 00 00       	call   801046c0 <wakeup>
80103b29:	83 c4 10             	add    $0x10,%esp
80103b2c:	eb b9                	jmp    80103ae7 <pipeclose+0x37>
80103b2e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103b30:	83 ec 0c             	sub    $0xc,%esp
80103b33:	53                   	push   %ebx
80103b34:	e8 17 11 00 00       	call   80104c50 <release>
    kfree((char*)p);
80103b39:	83 c4 10             	add    $0x10,%esp
80103b3c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103b3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b42:	5b                   	pop    %ebx
80103b43:	5e                   	pop    %esi
80103b44:	5d                   	pop    %ebp
    kfree((char*)p);
80103b45:	e9 36 ee ff ff       	jmp    80102980 <kfree>
80103b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b50 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103b50:	55                   	push   %ebp
80103b51:	89 e5                	mov    %esp,%ebp
80103b53:	57                   	push   %edi
80103b54:	56                   	push   %esi
80103b55:	53                   	push   %ebx
80103b56:	83 ec 28             	sub    $0x28,%esp
80103b59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103b5c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
80103b5f:	53                   	push   %ebx
80103b60:	e8 6b 0f 00 00       	call   80104ad0 <acquire>
  for(i = 0; i < n; i++){
80103b65:	83 c4 10             	add    $0x10,%esp
80103b68:	85 ff                	test   %edi,%edi
80103b6a:	0f 8e ce 00 00 00    	jle    80103c3e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b70:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103b76:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103b79:	89 7d 10             	mov    %edi,0x10(%ebp)
80103b7c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b7f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103b82:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103b85:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b8b:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b91:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b97:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
80103b9d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103ba0:	0f 85 b6 00 00 00    	jne    80103c5c <pipewrite+0x10c>
80103ba6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103ba9:	eb 3b                	jmp    80103be6 <pipewrite+0x96>
80103bab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103bb0:	e8 8b 03 00 00       	call   80103f40 <myproc>
80103bb5:	8b 48 24             	mov    0x24(%eax),%ecx
80103bb8:	85 c9                	test   %ecx,%ecx
80103bba:	75 34                	jne    80103bf0 <pipewrite+0xa0>
      wakeup(&p->nread);
80103bbc:	83 ec 0c             	sub    $0xc,%esp
80103bbf:	56                   	push   %esi
80103bc0:	e8 fb 0a 00 00       	call   801046c0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103bc5:	58                   	pop    %eax
80103bc6:	5a                   	pop    %edx
80103bc7:	53                   	push   %ebx
80103bc8:	57                   	push   %edi
80103bc9:	e8 32 0a 00 00       	call   80104600 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103bce:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103bd4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103bda:	83 c4 10             	add    $0x10,%esp
80103bdd:	05 00 02 00 00       	add    $0x200,%eax
80103be2:	39 c2                	cmp    %eax,%edx
80103be4:	75 2a                	jne    80103c10 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103be6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103bec:	85 c0                	test   %eax,%eax
80103bee:	75 c0                	jne    80103bb0 <pipewrite+0x60>
        release(&p->lock);
80103bf0:	83 ec 0c             	sub    $0xc,%esp
80103bf3:	53                   	push   %ebx
80103bf4:	e8 57 10 00 00       	call   80104c50 <release>
        return -1;
80103bf9:	83 c4 10             	add    $0x10,%esp
80103bfc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103c01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c04:	5b                   	pop    %ebx
80103c05:	5e                   	pop    %esi
80103c06:	5f                   	pop    %edi
80103c07:	5d                   	pop    %ebp
80103c08:	c3                   	ret
80103c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c10:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103c13:	8d 42 01             	lea    0x1(%edx),%eax
80103c16:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
80103c1c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103c1f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103c25:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c28:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
80103c2c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103c30:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103c33:	39 c1                	cmp    %eax,%ecx
80103c35:	0f 85 50 ff ff ff    	jne    80103b8b <pipewrite+0x3b>
80103c3b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103c3e:	83 ec 0c             	sub    $0xc,%esp
80103c41:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103c47:	50                   	push   %eax
80103c48:	e8 73 0a 00 00       	call   801046c0 <wakeup>
  release(&p->lock);
80103c4d:	89 1c 24             	mov    %ebx,(%esp)
80103c50:	e8 fb 0f 00 00       	call   80104c50 <release>
  return n;
80103c55:	83 c4 10             	add    $0x10,%esp
80103c58:	89 f8                	mov    %edi,%eax
80103c5a:	eb a5                	jmp    80103c01 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103c5c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c5f:	eb b2                	jmp    80103c13 <pipewrite+0xc3>
80103c61:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c68:	00 
80103c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c70 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103c70:	55                   	push   %ebp
80103c71:	89 e5                	mov    %esp,%ebp
80103c73:	57                   	push   %edi
80103c74:	56                   	push   %esi
80103c75:	53                   	push   %ebx
80103c76:	83 ec 18             	sub    $0x18,%esp
80103c79:	8b 75 08             	mov    0x8(%ebp),%esi
80103c7c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103c7f:	56                   	push   %esi
80103c80:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103c86:	e8 45 0e 00 00       	call   80104ad0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103c8b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103c91:	83 c4 10             	add    $0x10,%esp
80103c94:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103c9a:	74 2f                	je     80103ccb <piperead+0x5b>
80103c9c:	eb 37                	jmp    80103cd5 <piperead+0x65>
80103c9e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103ca0:	e8 9b 02 00 00       	call   80103f40 <myproc>
80103ca5:	8b 40 24             	mov    0x24(%eax),%eax
80103ca8:	85 c0                	test   %eax,%eax
80103caa:	0f 85 a0 00 00 00    	jne    80103d50 <piperead+0xe0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103cb0:	83 ec 08             	sub    $0x8,%esp
80103cb3:	56                   	push   %esi
80103cb4:	53                   	push   %ebx
80103cb5:	e8 46 09 00 00       	call   80104600 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103cba:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103cc0:	83 c4 10             	add    $0x10,%esp
80103cc3:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103cc9:	75 0a                	jne    80103cd5 <piperead+0x65>
80103ccb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103cd1:	85 d2                	test   %edx,%edx
80103cd3:	75 cb                	jne    80103ca0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103cd5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103cd8:	31 db                	xor    %ebx,%ebx
80103cda:	85 c9                	test   %ecx,%ecx
80103cdc:	7f 46                	jg     80103d24 <piperead+0xb4>
80103cde:	eb 4c                	jmp    80103d2c <piperead+0xbc>
80103ce0:	eb 1e                	jmp    80103d00 <piperead+0x90>
80103ce2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ce9:	00 
80103cea:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103cf1:	00 
80103cf2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103cf9:	00 
80103cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103d00:	8d 48 01             	lea    0x1(%eax),%ecx
80103d03:	25 ff 01 00 00       	and    $0x1ff,%eax
80103d08:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103d0e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103d13:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103d16:	83 c3 01             	add    $0x1,%ebx
80103d19:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103d1c:	74 0e                	je     80103d2c <piperead+0xbc>
80103d1e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103d24:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103d2a:	75 d4                	jne    80103d00 <piperead+0x90>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103d2c:	83 ec 0c             	sub    $0xc,%esp
80103d2f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103d35:	50                   	push   %eax
80103d36:	e8 85 09 00 00       	call   801046c0 <wakeup>
  release(&p->lock);
80103d3b:	89 34 24             	mov    %esi,(%esp)
80103d3e:	e8 0d 0f 00 00       	call   80104c50 <release>
  return i;
80103d43:	83 c4 10             	add    $0x10,%esp
}
80103d46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d49:	89 d8                	mov    %ebx,%eax
80103d4b:	5b                   	pop    %ebx
80103d4c:	5e                   	pop    %esi
80103d4d:	5f                   	pop    %edi
80103d4e:	5d                   	pop    %ebp
80103d4f:	c3                   	ret
      release(&p->lock);
80103d50:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103d53:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103d58:	56                   	push   %esi
80103d59:	e8 f2 0e 00 00       	call   80104c50 <release>
      return -1;
80103d5e:	83 c4 10             	add    $0x10,%esp
}
80103d61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d64:	89 d8                	mov    %ebx,%eax
80103d66:	5b                   	pop    %ebx
80103d67:	5e                   	pop    %esi
80103d68:	5f                   	pop    %edi
80103d69:	5d                   	pop    %ebp
80103d6a:	c3                   	ret
80103d6b:	66 90                	xchg   %ax,%ax
80103d6d:	66 90                	xchg   %ax,%ax
80103d6f:	66 90                	xchg   %ax,%ax
80103d71:	66 90                	xchg   %ax,%ax
80103d73:	66 90                	xchg   %ax,%ax
80103d75:	66 90                	xchg   %ax,%ax
80103d77:	66 90                	xchg   %ax,%ax
80103d79:	66 90                	xchg   %ax,%ax
80103d7b:	66 90                	xchg   %ax,%ax
80103d7d:	66 90                	xchg   %ax,%ax
80103d7f:	90                   	nop

80103d80 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d84:	bb 14 2e 11 80       	mov    $0x80112e14,%ebx
{
80103d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103d8c:	68 e0 2d 11 80       	push   $0x80112de0
80103d91:	e8 3a 0d 00 00       	call   80104ad0 <acquire>
80103d96:	83 c4 10             	add    $0x10,%esp
80103d99:	eb 10                	jmp    80103dab <allocproc+0x2b>
80103d9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103da0:	83 c3 7c             	add    $0x7c,%ebx
80103da3:	81 fb 14 4d 11 80    	cmp    $0x80114d14,%ebx
80103da9:	74 75                	je     80103e20 <allocproc+0xa0>
    if(p->state == UNUSED)
80103dab:	8b 43 0c             	mov    0xc(%ebx),%eax
80103dae:	85 c0                	test   %eax,%eax
80103db0:	75 ee                	jne    80103da0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103db2:	a1 08 b0 10 80       	mov    0x8010b008,%eax

  release(&ptable.lock);
80103db7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103dba:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103dc1:	89 43 10             	mov    %eax,0x10(%ebx)
80103dc4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103dc7:	68 e0 2d 11 80       	push   $0x80112de0
  p->pid = nextpid++;
80103dcc:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  release(&ptable.lock);
80103dd2:	e8 79 0e 00 00       	call   80104c50 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103dd7:	e8 74 ed ff ff       	call   80102b50 <kalloc>
80103ddc:	83 c4 10             	add    $0x10,%esp
80103ddf:	89 43 08             	mov    %eax,0x8(%ebx)
80103de2:	85 c0                	test   %eax,%eax
80103de4:	74 53                	je     80103e39 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103de6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103dec:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103def:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103df4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103df7:	c7 40 14 42 60 10 80 	movl   $0x80106042,0x14(%eax)
  p->context = (struct context*)sp;
80103dfe:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103e01:	6a 14                	push   $0x14
80103e03:	6a 00                	push   $0x0
80103e05:	50                   	push   %eax
80103e06:	e8 95 0e 00 00       	call   80104ca0 <memset>
  p->context->eip = (uint)forkret;
80103e0b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103e0e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103e11:	c7 40 10 50 3e 10 80 	movl   $0x80103e50,0x10(%eax)
}
80103e18:	89 d8                	mov    %ebx,%eax
80103e1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e1d:	c9                   	leave
80103e1e:	c3                   	ret
80103e1f:	90                   	nop
  release(&ptable.lock);
80103e20:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103e23:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103e25:	68 e0 2d 11 80       	push   $0x80112de0
80103e2a:	e8 21 0e 00 00       	call   80104c50 <release>
  return 0;
80103e2f:	83 c4 10             	add    $0x10,%esp
}
80103e32:	89 d8                	mov    %ebx,%eax
80103e34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e37:	c9                   	leave
80103e38:	c3                   	ret
    p->state = UNUSED;
80103e39:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103e40:	31 db                	xor    %ebx,%ebx
80103e42:	eb ee                	jmp    80103e32 <allocproc+0xb2>
80103e44:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e4b:	00 
80103e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e50 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103e56:	68 e0 2d 11 80       	push   $0x80112de0
80103e5b:	e8 f0 0d 00 00       	call   80104c50 <release>

  if (first) {
80103e60:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80103e65:	83 c4 10             	add    $0x10,%esp
80103e68:	85 c0                	test   %eax,%eax
80103e6a:	75 04                	jne    80103e70 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103e6c:	c9                   	leave
80103e6d:	c3                   	ret
80103e6e:	66 90                	xchg   %ax,%ax
    first = 0;
80103e70:	c7 05 04 b0 10 80 00 	movl   $0x0,0x8010b004
80103e77:	00 00 00 
    iinit(ROOTDEV);
80103e7a:	83 ec 0c             	sub    $0xc,%esp
80103e7d:	6a 01                	push   $0x1
80103e7f:	e8 3c db ff ff       	call   801019c0 <iinit>
    initlog(ROOTDEV);
80103e84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103e8b:	e8 60 f3 ff ff       	call   801031f0 <initlog>
}
80103e90:	83 c4 10             	add    $0x10,%esp
80103e93:	c9                   	leave
80103e94:	c3                   	ret
80103e95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e9c:	00 
80103e9d:	8d 76 00             	lea    0x0(%esi),%esi

80103ea0 <pinit>:
{
80103ea0:	55                   	push   %ebp
80103ea1:	89 e5                	mov    %esp,%ebp
80103ea3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103ea6:	68 e4 82 10 80       	push   $0x801082e4
80103eab:	68 e0 2d 11 80       	push   $0x80112de0
80103eb0:	e8 cb 0a 00 00       	call   80104980 <initlock>
}
80103eb5:	83 c4 10             	add    $0x10,%esp
80103eb8:	c9                   	leave
80103eb9:	c3                   	ret
80103eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ec0 <mycpu>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	56                   	push   %esi
80103ec4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ec5:	9c                   	pushf
80103ec6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ec7:	f6 c4 02             	test   $0x2,%ah
80103eca:	75 46                	jne    80103f12 <mycpu+0x52>
  apicid = lapicid();
80103ecc:	e8 0f ef ff ff       	call   80102de0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103ed1:	8b 35 44 28 11 80    	mov    0x80112844,%esi
80103ed7:	85 f6                	test   %esi,%esi
80103ed9:	7e 2a                	jle    80103f05 <mycpu+0x45>
80103edb:	31 d2                	xor    %edx,%edx
80103edd:	eb 08                	jmp    80103ee7 <mycpu+0x27>
80103edf:	90                   	nop
80103ee0:	83 c2 01             	add    $0x1,%edx
80103ee3:	39 f2                	cmp    %esi,%edx
80103ee5:	74 1e                	je     80103f05 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103ee7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103eed:	0f b6 99 60 28 11 80 	movzbl -0x7feed7a0(%ecx),%ebx
80103ef4:	39 c3                	cmp    %eax,%ebx
80103ef6:	75 e8                	jne    80103ee0 <mycpu+0x20>
}
80103ef8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103efb:	8d 81 60 28 11 80    	lea    -0x7feed7a0(%ecx),%eax
}
80103f01:	5b                   	pop    %ebx
80103f02:	5e                   	pop    %esi
80103f03:	5d                   	pop    %ebp
80103f04:	c3                   	ret
  panic("unknown apicid\n");
80103f05:	83 ec 0c             	sub    $0xc,%esp
80103f08:	68 eb 82 10 80       	push   $0x801082eb
80103f0d:	e8 9e c5 ff ff       	call   801004b0 <panic>
    panic("mycpu called with interrupts enabled\n");
80103f12:	83 ec 0c             	sub    $0xc,%esp
80103f15:	68 40 87 10 80       	push   $0x80108740
80103f1a:	e8 91 c5 ff ff       	call   801004b0 <panic>
80103f1f:	90                   	nop

80103f20 <cpuid>:
cpuid() {
80103f20:	55                   	push   %ebp
80103f21:	89 e5                	mov    %esp,%ebp
80103f23:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103f26:	e8 95 ff ff ff       	call   80103ec0 <mycpu>
}
80103f2b:	c9                   	leave
  return mycpu()-cpus;
80103f2c:	2d 60 28 11 80       	sub    $0x80112860,%eax
80103f31:	c1 f8 04             	sar    $0x4,%eax
80103f34:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103f3a:	c3                   	ret
80103f3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103f40 <myproc>:
myproc(void) {
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	53                   	push   %ebx
80103f44:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103f47:	e8 34 0b 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80103f4c:	e8 6f ff ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
80103f51:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f57:	e8 94 0c 00 00       	call   80104bf0 <popcli>
}
80103f5c:	89 d8                	mov    %ebx,%eax
80103f5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f61:	c9                   	leave
80103f62:	c3                   	ret
80103f63:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f6a:	00 
80103f6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103f70 <userinit>:
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	53                   	push   %ebx
80103f74:	83 ec 04             	sub    $0x4,%esp
  nullinit();
80103f77:	e8 54 d1 ff ff       	call   801010d0 <nullinit>
  kminit();
80103f7c:	e8 8f d1 ff ff       	call   80101110 <kminit>
  zeroinit();
80103f81:	e8 6a d1 ff ff       	call   801010f0 <zeroinit>
  p = allocproc();
80103f86:	e8 f5 fd ff ff       	call   80103d80 <allocproc>
80103f8b:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103f8d:	a3 14 4d 11 80       	mov    %eax,0x80114d14
  if((p->pgdir = setupkvm()) == 0)
80103f92:	e8 89 3b 00 00       	call   80107b20 <setupkvm>
80103f97:	89 43 04             	mov    %eax,0x4(%ebx)
80103f9a:	85 c0                	test   %eax,%eax
80103f9c:	0f 84 bd 00 00 00    	je     8010405f <userinit+0xef>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103fa2:	83 ec 04             	sub    $0x4,%esp
80103fa5:	68 2c 00 00 00       	push   $0x2c
80103faa:	68 60 b4 10 80       	push   $0x8010b460
80103faf:	50                   	push   %eax
80103fb0:	e8 7b 38 00 00       	call   80107830 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103fb5:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103fb8:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103fbe:	6a 4c                	push   $0x4c
80103fc0:	6a 00                	push   $0x0
80103fc2:	ff 73 18             	push   0x18(%ebx)
80103fc5:	e8 d6 0c 00 00       	call   80104ca0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103fca:	8b 43 18             	mov    0x18(%ebx),%eax
80103fcd:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103fd2:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103fd5:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103fda:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103fde:	8b 43 18             	mov    0x18(%ebx),%eax
80103fe1:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103fe5:	8b 43 18             	mov    0x18(%ebx),%eax
80103fe8:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103fec:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103ff0:	8b 43 18             	mov    0x18(%ebx),%eax
80103ff3:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ff7:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103ffb:	8b 43 18             	mov    0x18(%ebx),%eax
80103ffe:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104005:	8b 43 18             	mov    0x18(%ebx),%eax
80104008:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010400f:	8b 43 18             	mov    0x18(%ebx),%eax
80104012:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104019:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010401c:	6a 10                	push   $0x10
8010401e:	68 14 83 10 80       	push   $0x80108314
80104023:	50                   	push   %eax
80104024:	e8 37 0e 00 00       	call   80104e60 <safestrcpy>
  p->cwd = namei("/");
80104029:	c7 04 24 1d 83 10 80 	movl   $0x8010831d,(%esp)
80104030:	e8 db e4 ff ff       	call   80102510 <namei>
80104035:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104038:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
8010403f:	e8 8c 0a 00 00       	call   80104ad0 <acquire>
  p->state = RUNNABLE;
80104044:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010404b:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
80104052:	e8 f9 0b 00 00       	call   80104c50 <release>
}
80104057:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010405a:	83 c4 10             	add    $0x10,%esp
8010405d:	c9                   	leave
8010405e:	c3                   	ret
    panic("userinit: out of memory?");
8010405f:	83 ec 0c             	sub    $0xc,%esp
80104062:	68 fb 82 10 80       	push   $0x801082fb
80104067:	e8 44 c4 ff ff       	call   801004b0 <panic>
8010406c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104070 <growproc>:
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	56                   	push   %esi
80104074:	53                   	push   %ebx
80104075:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104078:	e8 03 0a 00 00       	call   80104a80 <pushcli>
  c = mycpu();
8010407d:	e8 3e fe ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
80104082:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104088:	e8 63 0b 00 00       	call   80104bf0 <popcli>
  if (n < 0 || n > KERNBASE || curproc->sz + n > KERNBASE)
8010408d:	85 db                	test   %ebx,%ebx
8010408f:	78 1f                	js     801040b0 <growproc+0x40>
80104091:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80104097:	77 17                	ja     801040b0 <growproc+0x40>
80104099:	03 1e                	add    (%esi),%ebx
8010409b:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801040a1:	77 0d                	ja     801040b0 <growproc+0x40>
  curproc->sz += n;
801040a3:	89 1e                	mov    %ebx,(%esi)
  return 0;
801040a5:	31 c0                	xor    %eax,%eax
}
801040a7:	5b                   	pop    %ebx
801040a8:	5e                   	pop    %esi
801040a9:	5d                   	pop    %ebp
801040aa:	c3                   	ret
801040ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
	  return -1;
801040b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801040b5:	eb f0                	jmp    801040a7 <growproc+0x37>
801040b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040be:	00 
801040bf:	90                   	nop

801040c0 <fork>:
{
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	57                   	push   %edi
801040c4:	56                   	push   %esi
801040c5:	53                   	push   %ebx
801040c6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
801040c9:	e8 b2 09 00 00       	call   80104a80 <pushcli>
  c = mycpu();
801040ce:	e8 ed fd ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
801040d3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040d9:	e8 12 0b 00 00       	call   80104bf0 <popcli>
  if((np = allocproc()) == 0){
801040de:	e8 9d fc ff ff       	call   80103d80 <allocproc>
801040e3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801040e6:	85 c0                	test   %eax,%eax
801040e8:	0f 84 d6 00 00 00    	je     801041c4 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801040ee:	83 ec 08             	sub    $0x8,%esp
801040f1:	ff 33                	push   (%ebx)
801040f3:	89 c7                	mov    %eax,%edi
801040f5:	ff 73 04             	push   0x4(%ebx)
801040f8:	e8 13 3c 00 00       	call   80107d10 <copyuvm>
801040fd:	83 c4 10             	add    $0x10,%esp
80104100:	89 47 04             	mov    %eax,0x4(%edi)
80104103:	85 c0                	test   %eax,%eax
80104105:	0f 84 9a 00 00 00    	je     801041a5 <fork+0xe5>
  np->sz = curproc->sz;
8010410b:	8b 03                	mov    (%ebx),%eax
8010410d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104110:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104112:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104115:	89 c8                	mov    %ecx,%eax
80104117:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010411a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010411f:	8b 73 18             	mov    0x18(%ebx),%esi
80104122:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104124:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104126:	8b 40 18             	mov    0x18(%eax),%eax
80104129:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104130:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104134:	85 c0                	test   %eax,%eax
80104136:	74 13                	je     8010414b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104138:	83 ec 0c             	sub    $0xc,%esp
8010413b:	50                   	push   %eax
8010413c:	e8 8f d0 ff ff       	call   801011d0 <filedup>
80104141:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104144:	83 c4 10             	add    $0x10,%esp
80104147:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
8010414b:	83 c6 01             	add    $0x1,%esi
8010414e:	83 fe 10             	cmp    $0x10,%esi
80104151:	75 dd                	jne    80104130 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80104153:	83 ec 0c             	sub    $0xc,%esp
80104156:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104159:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
8010415c:	e8 5f da ff ff       	call   80101bc0 <idup>
80104161:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104164:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104167:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010416a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010416d:	6a 10                	push   $0x10
8010416f:	53                   	push   %ebx
80104170:	50                   	push   %eax
80104171:	e8 ea 0c 00 00       	call   80104e60 <safestrcpy>
  pid = np->pid;
80104176:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104179:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
80104180:	e8 4b 09 00 00       	call   80104ad0 <acquire>
  np->state = RUNNABLE;
80104185:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010418c:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
80104193:	e8 b8 0a 00 00       	call   80104c50 <release>
  return pid;
80104198:	83 c4 10             	add    $0x10,%esp
}
8010419b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010419e:	89 d8                	mov    %ebx,%eax
801041a0:	5b                   	pop    %ebx
801041a1:	5e                   	pop    %esi
801041a2:	5f                   	pop    %edi
801041a3:	5d                   	pop    %ebp
801041a4:	c3                   	ret
    kfree(np->kstack);
801041a5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801041a8:	83 ec 0c             	sub    $0xc,%esp
801041ab:	ff 73 08             	push   0x8(%ebx)
801041ae:	e8 cd e7 ff ff       	call   80102980 <kfree>
    np->kstack = 0;
801041b3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
801041ba:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
801041bd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801041c4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801041c9:	eb d0                	jmp    8010419b <fork+0xdb>
801041cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801041d0 <scheduler>:
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	57                   	push   %edi
801041d4:	56                   	push   %esi
801041d5:	53                   	push   %ebx
801041d6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801041d9:	e8 e2 fc ff ff       	call   80103ec0 <mycpu>
  c->proc = 0;
801041de:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801041e5:	00 00 00 
  struct cpu *c = mycpu();
801041e8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801041ea:	8d 78 04             	lea    0x4(%eax),%edi
801041ed:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
801041f0:	fb                   	sti
    acquire(&ptable.lock);
801041f1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041f4:	bb 14 2e 11 80       	mov    $0x80112e14,%ebx
    acquire(&ptable.lock);
801041f9:	68 e0 2d 11 80       	push   $0x80112de0
801041fe:	e8 cd 08 00 00       	call   80104ad0 <acquire>
80104203:	83 c4 10             	add    $0x10,%esp
80104206:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010420d:	00 
8010420e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80104210:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104214:	75 33                	jne    80104249 <scheduler+0x79>
      switchuvm(p);
80104216:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104219:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
8010421f:	53                   	push   %ebx
80104220:	e8 fb 34 00 00       	call   80107720 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104225:	58                   	pop    %eax
80104226:	5a                   	pop    %edx
80104227:	ff 73 1c             	push   0x1c(%ebx)
8010422a:	57                   	push   %edi
      p->state = RUNNING;
8010422b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104232:	e8 84 0c 00 00       	call   80104ebb <swtch>
      switchkvm();
80104237:	e8 d4 34 00 00       	call   80107710 <switchkvm>
      c->proc = 0;
8010423c:	83 c4 10             	add    $0x10,%esp
8010423f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104246:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104249:	83 c3 7c             	add    $0x7c,%ebx
8010424c:	81 fb 14 4d 11 80    	cmp    $0x80114d14,%ebx
80104252:	75 bc                	jne    80104210 <scheduler+0x40>
    release(&ptable.lock);
80104254:	83 ec 0c             	sub    $0xc,%esp
80104257:	68 e0 2d 11 80       	push   $0x80112de0
8010425c:	e8 ef 09 00 00       	call   80104c50 <release>
    sti();
80104261:	83 c4 10             	add    $0x10,%esp
80104264:	eb 8a                	jmp    801041f0 <scheduler+0x20>
80104266:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010426d:	00 
8010426e:	66 90                	xchg   %ax,%ax

80104270 <sched>:
{
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	56                   	push   %esi
80104274:	53                   	push   %ebx
  pushcli();
80104275:	e8 06 08 00 00       	call   80104a80 <pushcli>
  c = mycpu();
8010427a:	e8 41 fc ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
8010427f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104285:	e8 66 09 00 00       	call   80104bf0 <popcli>
  if(!holding(&ptable.lock))
8010428a:	83 ec 0c             	sub    $0xc,%esp
8010428d:	68 e0 2d 11 80       	push   $0x80112de0
80104292:	e8 a9 07 00 00       	call   80104a40 <holding>
80104297:	83 c4 10             	add    $0x10,%esp
8010429a:	85 c0                	test   %eax,%eax
8010429c:	74 4f                	je     801042ed <sched+0x7d>
  if(mycpu()->ncli != 1)
8010429e:	e8 1d fc ff ff       	call   80103ec0 <mycpu>
801042a3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801042aa:	75 68                	jne    80104314 <sched+0xa4>
  if(p->state == RUNNING)
801042ac:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801042b0:	74 55                	je     80104307 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801042b2:	9c                   	pushf
801042b3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801042b4:	f6 c4 02             	test   $0x2,%ah
801042b7:	75 41                	jne    801042fa <sched+0x8a>
  intena = mycpu()->intena;
801042b9:	e8 02 fc ff ff       	call   80103ec0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801042be:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801042c1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801042c7:	e8 f4 fb ff ff       	call   80103ec0 <mycpu>
801042cc:	83 ec 08             	sub    $0x8,%esp
801042cf:	ff 70 04             	push   0x4(%eax)
801042d2:	53                   	push   %ebx
801042d3:	e8 e3 0b 00 00       	call   80104ebb <swtch>
  mycpu()->intena = intena;
801042d8:	e8 e3 fb ff ff       	call   80103ec0 <mycpu>
}
801042dd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801042e0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801042e6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042e9:	5b                   	pop    %ebx
801042ea:	5e                   	pop    %esi
801042eb:	5d                   	pop    %ebp
801042ec:	c3                   	ret
    panic("sched ptable.lock");
801042ed:	83 ec 0c             	sub    $0xc,%esp
801042f0:	68 1f 83 10 80       	push   $0x8010831f
801042f5:	e8 b6 c1 ff ff       	call   801004b0 <panic>
    panic("sched interruptible");
801042fa:	83 ec 0c             	sub    $0xc,%esp
801042fd:	68 4b 83 10 80       	push   $0x8010834b
80104302:	e8 a9 c1 ff ff       	call   801004b0 <panic>
    panic("sched running");
80104307:	83 ec 0c             	sub    $0xc,%esp
8010430a:	68 3d 83 10 80       	push   $0x8010833d
8010430f:	e8 9c c1 ff ff       	call   801004b0 <panic>
    panic("sched locks");
80104314:	83 ec 0c             	sub    $0xc,%esp
80104317:	68 31 83 10 80       	push   $0x80108331
8010431c:	e8 8f c1 ff ff       	call   801004b0 <panic>
80104321:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104328:	00 
80104329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104330 <exit>:
{
80104330:	55                   	push   %ebp
80104331:	89 e5                	mov    %esp,%ebp
80104333:	57                   	push   %edi
80104334:	56                   	push   %esi
80104335:	53                   	push   %ebx
80104336:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104339:	e8 02 fc ff ff       	call   80103f40 <myproc>
  if(curproc == initproc)
8010433e:	39 05 14 4d 11 80    	cmp    %eax,0x80114d14
80104344:	0f 84 0d 01 00 00    	je     80104457 <exit+0x127>
8010434a:	89 c3                	mov    %eax,%ebx
8010434c:	8d 70 28             	lea    0x28(%eax),%esi
8010434f:	8d 78 68             	lea    0x68(%eax),%edi
80104352:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104359:	00 
8010435a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104360:	8b 06                	mov    (%esi),%eax
80104362:	85 c0                	test   %eax,%eax
80104364:	74 12                	je     80104378 <exit+0x48>
      fileclose(curproc->ofile[fd]);
80104366:	83 ec 0c             	sub    $0xc,%esp
80104369:	50                   	push   %eax
8010436a:	e8 b1 ce ff ff       	call   80101220 <fileclose>
      curproc->ofile[fd] = 0;
8010436f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104375:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104378:	83 c6 04             	add    $0x4,%esi
8010437b:	39 f7                	cmp    %esi,%edi
8010437d:	75 e1                	jne    80104360 <exit+0x30>
  begin_op();
8010437f:	e8 1c ef ff ff       	call   801032a0 <begin_op>
  iput(curproc->cwd);
80104384:	83 ec 0c             	sub    $0xc,%esp
80104387:	ff 73 68             	push   0x68(%ebx)
8010438a:	e8 91 d9 ff ff       	call   80101d20 <iput>
  end_op();
8010438f:	e8 7c ef ff ff       	call   80103310 <end_op>
  curproc->cwd = 0;
80104394:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
8010439b:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
801043a2:	e8 29 07 00 00       	call   80104ad0 <acquire>
  wakeup1(curproc->parent);
801043a7:	8b 53 14             	mov    0x14(%ebx),%edx
801043aa:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043ad:	b8 14 2e 11 80       	mov    $0x80112e14,%eax
801043b2:	eb 16                	jmp    801043ca <exit+0x9a>
801043b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043bb:	00 
801043bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043c0:	83 c0 7c             	add    $0x7c,%eax
801043c3:	3d 14 4d 11 80       	cmp    $0x80114d14,%eax
801043c8:	74 1c                	je     801043e6 <exit+0xb6>
    if(p->state == SLEEPING && p->chan == chan)
801043ca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801043ce:	75 f0                	jne    801043c0 <exit+0x90>
801043d0:	3b 50 20             	cmp    0x20(%eax),%edx
801043d3:	75 eb                	jne    801043c0 <exit+0x90>
      p->state = RUNNABLE;
801043d5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043dc:	83 c0 7c             	add    $0x7c,%eax
801043df:	3d 14 4d 11 80       	cmp    $0x80114d14,%eax
801043e4:	75 e4                	jne    801043ca <exit+0x9a>
      p->parent = initproc;
801043e6:	8b 0d 14 4d 11 80    	mov    0x80114d14,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043ec:	ba 14 2e 11 80       	mov    $0x80112e14,%edx
801043f1:	eb 18                	jmp    8010440b <exit+0xdb>
801043f3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043fa:	00 
801043fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104400:	83 c2 7c             	add    $0x7c,%edx
80104403:	81 fa 14 4d 11 80    	cmp    $0x80114d14,%edx
80104409:	74 33                	je     8010443e <exit+0x10e>
    if(p->parent == curproc){
8010440b:	39 5a 14             	cmp    %ebx,0x14(%edx)
8010440e:	75 f0                	jne    80104400 <exit+0xd0>
      if(p->state == ZOMBIE)
80104410:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104414:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104417:	75 e7                	jne    80104400 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104419:	b8 14 2e 11 80       	mov    $0x80112e14,%eax
8010441e:	eb 0a                	jmp    8010442a <exit+0xfa>
80104420:	83 c0 7c             	add    $0x7c,%eax
80104423:	3d 14 4d 11 80       	cmp    $0x80114d14,%eax
80104428:	74 d6                	je     80104400 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
8010442a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010442e:	75 f0                	jne    80104420 <exit+0xf0>
80104430:	3b 48 20             	cmp    0x20(%eax),%ecx
80104433:	75 eb                	jne    80104420 <exit+0xf0>
      p->state = RUNNABLE;
80104435:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010443c:	eb e2                	jmp    80104420 <exit+0xf0>
  curproc->state = ZOMBIE;
8010443e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104445:	e8 26 fe ff ff       	call   80104270 <sched>
  panic("zombie exit");
8010444a:	83 ec 0c             	sub    $0xc,%esp
8010444d:	68 6a 83 10 80       	push   $0x8010836a
80104452:	e8 59 c0 ff ff       	call   801004b0 <panic>
    panic("init died\n");
80104457:	83 ec 0c             	sub    $0xc,%esp
8010445a:	68 5f 83 10 80       	push   $0x8010835f
8010445f:	e8 4c c0 ff ff       	call   801004b0 <panic>
80104464:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010446b:	00 
8010446c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104470 <wait>:
{
80104470:	55                   	push   %ebp
80104471:	89 e5                	mov    %esp,%ebp
80104473:	57                   	push   %edi
80104474:	56                   	push   %esi
80104475:	53                   	push   %ebx
80104476:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80104479:	e8 02 06 00 00       	call   80104a80 <pushcli>
  c = mycpu();
8010447e:	e8 3d fa ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
80104483:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104489:	e8 62 07 00 00       	call   80104bf0 <popcli>
  acquire(&ptable.lock);
8010448e:	83 ec 0c             	sub    $0xc,%esp
80104491:	68 e0 2d 11 80       	push   $0x80112de0
80104496:	e8 35 06 00 00       	call   80104ad0 <acquire>
8010449b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010449e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044a0:	bb 14 2e 11 80       	mov    $0x80112e14,%ebx
801044a5:	eb 14                	jmp    801044bb <wait+0x4b>
801044a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044ae:	00 
801044af:	90                   	nop
801044b0:	83 c3 7c             	add    $0x7c,%ebx
801044b3:	81 fb 14 4d 11 80    	cmp    $0x80114d14,%ebx
801044b9:	74 1b                	je     801044d6 <wait+0x66>
      if(p->parent != curproc)
801044bb:	39 73 14             	cmp    %esi,0x14(%ebx)
801044be:	75 f0                	jne    801044b0 <wait+0x40>
      if(p->state == ZOMBIE){
801044c0:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801044c4:	74 5a                	je     80104520 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044c6:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
801044c9:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044ce:	81 fb 14 4d 11 80    	cmp    $0x80114d14,%ebx
801044d4:	75 e5                	jne    801044bb <wait+0x4b>
    if(!havekids || curproc->killed){
801044d6:	85 c0                	test   %eax,%eax
801044d8:	0f 84 a2 00 00 00    	je     80104580 <wait+0x110>
801044de:	8b 46 24             	mov    0x24(%esi),%eax
801044e1:	85 c0                	test   %eax,%eax
801044e3:	0f 85 97 00 00 00    	jne    80104580 <wait+0x110>
  pushcli();
801044e9:	e8 92 05 00 00       	call   80104a80 <pushcli>
  c = mycpu();
801044ee:	e8 cd f9 ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
801044f3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801044f9:	e8 f2 06 00 00       	call   80104bf0 <popcli>
  if(p == 0)
801044fe:	85 db                	test   %ebx,%ebx
80104500:	0f 84 91 00 00 00    	je     80104597 <wait+0x127>
  p->chan = chan;
80104506:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104509:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104510:	e8 5b fd ff ff       	call   80104270 <sched>
  p->chan = 0;
80104515:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010451c:	eb 80                	jmp    8010449e <wait+0x2e>
8010451e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104520:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104523:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104526:	ff 73 08             	push   0x8(%ebx)
80104529:	e8 52 e4 ff ff       	call   80102980 <kfree>
        pgdir = p->pgdir;
8010452e:	8b 7b 04             	mov    0x4(%ebx),%edi
        p->name[0] = 0;
80104531:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->kstack = 0;
80104535:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        p->pgdir = 0;
8010453c:	c7 43 04 00 00 00 00 	movl   $0x0,0x4(%ebx)
        p->pid = 0;
80104543:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010454a:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->killed = 0;
80104551:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104558:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010455f:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
80104566:	e8 e5 06 00 00       	call   80104c50 <release>
        freevm(pgdir);
8010456b:	89 3c 24             	mov    %edi,(%esp)
8010456e:	e8 2d 35 00 00       	call   80107aa0 <freevm>
        return pid;
80104573:	83 c4 10             	add    $0x10,%esp
}
80104576:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104579:	89 f0                	mov    %esi,%eax
8010457b:	5b                   	pop    %ebx
8010457c:	5e                   	pop    %esi
8010457d:	5f                   	pop    %edi
8010457e:	5d                   	pop    %ebp
8010457f:	c3                   	ret
      release(&ptable.lock);
80104580:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104583:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104588:	68 e0 2d 11 80       	push   $0x80112de0
8010458d:	e8 be 06 00 00       	call   80104c50 <release>
      return -1;
80104592:	83 c4 10             	add    $0x10,%esp
80104595:	eb df                	jmp    80104576 <wait+0x106>
    panic("sleep");
80104597:	83 ec 0c             	sub    $0xc,%esp
8010459a:	68 76 83 10 80       	push   $0x80108376
8010459f:	e8 0c bf ff ff       	call   801004b0 <panic>
801045a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045ab:	00 
801045ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045b0 <yield>:
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	53                   	push   %ebx
801045b4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801045b7:	68 e0 2d 11 80       	push   $0x80112de0
801045bc:	e8 0f 05 00 00       	call   80104ad0 <acquire>
  pushcli();
801045c1:	e8 ba 04 00 00       	call   80104a80 <pushcli>
  c = mycpu();
801045c6:	e8 f5 f8 ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
801045cb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045d1:	e8 1a 06 00 00       	call   80104bf0 <popcli>
  myproc()->state = RUNNABLE;
801045d6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801045dd:	e8 8e fc ff ff       	call   80104270 <sched>
  release(&ptable.lock);
801045e2:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
801045e9:	e8 62 06 00 00       	call   80104c50 <release>
}
801045ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045f1:	83 c4 10             	add    $0x10,%esp
801045f4:	c9                   	leave
801045f5:	c3                   	ret
801045f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045fd:	00 
801045fe:	66 90                	xchg   %ax,%ax

80104600 <sleep>:
{
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	57                   	push   %edi
80104604:	56                   	push   %esi
80104605:	53                   	push   %ebx
80104606:	83 ec 0c             	sub    $0xc,%esp
80104609:	8b 7d 08             	mov    0x8(%ebp),%edi
8010460c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010460f:	e8 6c 04 00 00       	call   80104a80 <pushcli>
  c = mycpu();
80104614:	e8 a7 f8 ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
80104619:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010461f:	e8 cc 05 00 00       	call   80104bf0 <popcli>
  if(p == 0)
80104624:	85 db                	test   %ebx,%ebx
80104626:	0f 84 87 00 00 00    	je     801046b3 <sleep+0xb3>
  if(lk == 0)
8010462c:	85 f6                	test   %esi,%esi
8010462e:	74 76                	je     801046a6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104630:	81 fe e0 2d 11 80    	cmp    $0x80112de0,%esi
80104636:	74 50                	je     80104688 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104638:	83 ec 0c             	sub    $0xc,%esp
8010463b:	68 e0 2d 11 80       	push   $0x80112de0
80104640:	e8 8b 04 00 00       	call   80104ad0 <acquire>
    release(lk);
80104645:	89 34 24             	mov    %esi,(%esp)
80104648:	e8 03 06 00 00       	call   80104c50 <release>
  p->chan = chan;
8010464d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104650:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104657:	e8 14 fc ff ff       	call   80104270 <sched>
  p->chan = 0;
8010465c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104663:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
8010466a:	e8 e1 05 00 00       	call   80104c50 <release>
    acquire(lk);
8010466f:	83 c4 10             	add    $0x10,%esp
80104672:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104675:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104678:	5b                   	pop    %ebx
80104679:	5e                   	pop    %esi
8010467a:	5f                   	pop    %edi
8010467b:	5d                   	pop    %ebp
    acquire(lk);
8010467c:	e9 4f 04 00 00       	jmp    80104ad0 <acquire>
80104681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104688:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010468b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104692:	e8 d9 fb ff ff       	call   80104270 <sched>
  p->chan = 0;
80104697:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010469e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046a1:	5b                   	pop    %ebx
801046a2:	5e                   	pop    %esi
801046a3:	5f                   	pop    %edi
801046a4:	5d                   	pop    %ebp
801046a5:	c3                   	ret
    panic("sleep without lk");
801046a6:	83 ec 0c             	sub    $0xc,%esp
801046a9:	68 7c 83 10 80       	push   $0x8010837c
801046ae:	e8 fd bd ff ff       	call   801004b0 <panic>
    panic("sleep");
801046b3:	83 ec 0c             	sub    $0xc,%esp
801046b6:	68 76 83 10 80       	push   $0x80108376
801046bb:	e8 f0 bd ff ff       	call   801004b0 <panic>

801046c0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	53                   	push   %ebx
801046c4:	83 ec 10             	sub    $0x10,%esp
801046c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801046ca:	68 e0 2d 11 80       	push   $0x80112de0
801046cf:	e8 fc 03 00 00       	call   80104ad0 <acquire>
801046d4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046d7:	b8 14 2e 11 80       	mov    $0x80112e14,%eax
801046dc:	eb 0c                	jmp    801046ea <wakeup+0x2a>
801046de:	66 90                	xchg   %ax,%ax
801046e0:	83 c0 7c             	add    $0x7c,%eax
801046e3:	3d 14 4d 11 80       	cmp    $0x80114d14,%eax
801046e8:	74 1c                	je     80104706 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801046ea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801046ee:	75 f0                	jne    801046e0 <wakeup+0x20>
801046f0:	3b 58 20             	cmp    0x20(%eax),%ebx
801046f3:	75 eb                	jne    801046e0 <wakeup+0x20>
      p->state = RUNNABLE;
801046f5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046fc:	83 c0 7c             	add    $0x7c,%eax
801046ff:	3d 14 4d 11 80       	cmp    $0x80114d14,%eax
80104704:	75 e4                	jne    801046ea <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104706:	c7 45 08 e0 2d 11 80 	movl   $0x80112de0,0x8(%ebp)
}
8010470d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104710:	c9                   	leave
  release(&ptable.lock);
80104711:	e9 3a 05 00 00       	jmp    80104c50 <release>
80104716:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010471d:	00 
8010471e:	66 90                	xchg   %ax,%ax

80104720 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	53                   	push   %ebx
80104724:	83 ec 10             	sub    $0x10,%esp
80104727:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010472a:	68 e0 2d 11 80       	push   $0x80112de0
8010472f:	e8 9c 03 00 00       	call   80104ad0 <acquire>
80104734:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104737:	b8 14 2e 11 80       	mov    $0x80112e14,%eax
8010473c:	eb 0c                	jmp    8010474a <kill+0x2a>
8010473e:	66 90                	xchg   %ax,%ax
80104740:	83 c0 7c             	add    $0x7c,%eax
80104743:	3d 14 4d 11 80       	cmp    $0x80114d14,%eax
80104748:	74 36                	je     80104780 <kill+0x60>
    if(p->pid == pid){
8010474a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010474d:	75 f1                	jne    80104740 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010474f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104753:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010475a:	75 07                	jne    80104763 <kill+0x43>
        p->state = RUNNABLE;
8010475c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104763:	83 ec 0c             	sub    $0xc,%esp
80104766:	68 e0 2d 11 80       	push   $0x80112de0
8010476b:	e8 e0 04 00 00       	call   80104c50 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104770:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104773:	83 c4 10             	add    $0x10,%esp
80104776:	31 c0                	xor    %eax,%eax
}
80104778:	c9                   	leave
80104779:	c3                   	ret
8010477a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104780:	83 ec 0c             	sub    $0xc,%esp
80104783:	68 e0 2d 11 80       	push   $0x80112de0
80104788:	e8 c3 04 00 00       	call   80104c50 <release>
}
8010478d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104790:	83 c4 10             	add    $0x10,%esp
80104793:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104798:	c9                   	leave
80104799:	c3                   	ret
8010479a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047a0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	57                   	push   %edi
801047a4:	56                   	push   %esi
      state = states[p->state];
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
801047a5:	8d 75 c0             	lea    -0x40(%ebp),%esi
{
801047a8:	53                   	push   %ebx
801047a9:	bb 80 2e 11 80       	mov    $0x80112e80,%ebx
801047ae:	83 ec 3c             	sub    $0x3c,%esp
801047b1:	eb 24                	jmp    801047d7 <procdump+0x37>
801047b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801047b8:	83 ec 0c             	sub    $0xc,%esp
801047bb:	68 75 81 10 80       	push   $0x80108175
801047c0:	e8 2b c0 ff ff       	call   801007f0 <cprintf>
801047c5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047c8:	83 c3 7c             	add    $0x7c,%ebx
801047cb:	81 fb 80 4d 11 80    	cmp    $0x80114d80,%ebx
801047d1:	0f 84 89 00 00 00    	je     80104860 <procdump+0xc0>
    if(p->state == UNUSED)
801047d7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801047da:	85 c0                	test   %eax,%eax
801047dc:	74 ea                	je     801047c8 <procdump+0x28>
      state = "???";
801047de:	ba 8d 83 10 80       	mov    $0x8010838d,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801047e3:	83 f8 05             	cmp    $0x5,%eax
801047e6:	77 11                	ja     801047f9 <procdump+0x59>
801047e8:	8b 14 85 80 8b 10 80 	mov    -0x7fef7480(,%eax,4),%edx
      state = "???";
801047ef:	b8 8d 83 10 80       	mov    $0x8010838d,%eax
801047f4:	85 d2                	test   %edx,%edx
801047f6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801047f9:	53                   	push   %ebx
801047fa:	52                   	push   %edx
801047fb:	ff 73 a4             	push   -0x5c(%ebx)
801047fe:	68 91 83 10 80       	push   $0x80108391
80104803:	e8 e8 bf ff ff       	call   801007f0 <cprintf>
    if(p->state == SLEEPING){
80104808:	83 c4 10             	add    $0x10,%esp
8010480b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010480f:	75 a7                	jne    801047b8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104811:	83 ec 08             	sub    $0x8,%esp
80104814:	89 f7                	mov    %esi,%edi
80104816:	56                   	push   %esi
80104817:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010481a:	8b 40 0c             	mov    0xc(%eax),%eax
8010481d:	83 c0 08             	add    $0x8,%eax
80104820:	50                   	push   %eax
80104821:	e8 7a 01 00 00       	call   801049a0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104826:	83 c4 10             	add    $0x10,%esp
80104829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104830:	8b 07                	mov    (%edi),%eax
80104832:	85 c0                	test   %eax,%eax
80104834:	74 82                	je     801047b8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104836:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104839:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010483c:	50                   	push   %eax
8010483d:	68 9a 83 10 80       	push   $0x8010839a
80104842:	e8 a9 bf ff ff       	call   801007f0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104847:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010484a:	83 c4 10             	add    $0x10,%esp
8010484d:	39 c7                	cmp    %eax,%edi
8010484f:	75 df                	jne    80104830 <procdump+0x90>
80104851:	e9 62 ff ff ff       	jmp    801047b8 <procdump+0x18>
80104856:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010485d:	00 
8010485e:	66 90                	xchg   %ax,%ax
  }
}
80104860:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104863:	5b                   	pop    %ebx
80104864:	5e                   	pop    %esi
80104865:	5f                   	pop    %edi
80104866:	5d                   	pop    %ebp
80104867:	c3                   	ret
80104868:	66 90                	xchg   %ax,%ax
8010486a:	66 90                	xchg   %ax,%ax
8010486c:	66 90                	xchg   %ax,%ax
8010486e:	66 90                	xchg   %ax,%ax

80104870 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	53                   	push   %ebx
80104874:	83 ec 0c             	sub    $0xc,%esp
80104877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010487a:	68 c8 83 10 80       	push   $0x801083c8
8010487f:	8d 43 04             	lea    0x4(%ebx),%eax
80104882:	50                   	push   %eax
80104883:	e8 f8 00 00 00       	call   80104980 <initlock>
  lk->name = name;
80104888:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010488b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104891:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104894:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010489b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010489e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048a1:	c9                   	leave
801048a2:	c3                   	ret
801048a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048aa:	00 
801048ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801048b0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	56                   	push   %esi
801048b4:	53                   	push   %ebx
801048b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801048b8:	8d 73 04             	lea    0x4(%ebx),%esi
801048bb:	83 ec 0c             	sub    $0xc,%esp
801048be:	56                   	push   %esi
801048bf:	e8 0c 02 00 00       	call   80104ad0 <acquire>
  while (lk->locked) {
801048c4:	8b 13                	mov    (%ebx),%edx
801048c6:	83 c4 10             	add    $0x10,%esp
801048c9:	85 d2                	test   %edx,%edx
801048cb:	74 16                	je     801048e3 <acquiresleep+0x33>
801048cd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801048d0:	83 ec 08             	sub    $0x8,%esp
801048d3:	56                   	push   %esi
801048d4:	53                   	push   %ebx
801048d5:	e8 26 fd ff ff       	call   80104600 <sleep>
  while (lk->locked) {
801048da:	8b 03                	mov    (%ebx),%eax
801048dc:	83 c4 10             	add    $0x10,%esp
801048df:	85 c0                	test   %eax,%eax
801048e1:	75 ed                	jne    801048d0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801048e3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801048e9:	e8 52 f6 ff ff       	call   80103f40 <myproc>
801048ee:	8b 40 10             	mov    0x10(%eax),%eax
801048f1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801048f4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801048f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048fa:	5b                   	pop    %ebx
801048fb:	5e                   	pop    %esi
801048fc:	5d                   	pop    %ebp
  release(&lk->lk);
801048fd:	e9 4e 03 00 00       	jmp    80104c50 <release>
80104902:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104909:	00 
8010490a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104910 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	56                   	push   %esi
80104914:	53                   	push   %ebx
80104915:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104918:	8d 73 04             	lea    0x4(%ebx),%esi
8010491b:	83 ec 0c             	sub    $0xc,%esp
8010491e:	56                   	push   %esi
8010491f:	e8 ac 01 00 00       	call   80104ad0 <acquire>
  lk->locked = 0;
80104924:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010492a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104931:	89 1c 24             	mov    %ebx,(%esp)
80104934:	e8 87 fd ff ff       	call   801046c0 <wakeup>
  release(&lk->lk);
80104939:	83 c4 10             	add    $0x10,%esp
8010493c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010493f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104942:	5b                   	pop    %ebx
80104943:	5e                   	pop    %esi
80104944:	5d                   	pop    %ebp
  release(&lk->lk);
80104945:	e9 06 03 00 00       	jmp    80104c50 <release>
8010494a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104950 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	56                   	push   %esi
80104954:	53                   	push   %ebx
80104955:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104958:	8d 5e 04             	lea    0x4(%esi),%ebx
8010495b:	83 ec 0c             	sub    $0xc,%esp
8010495e:	53                   	push   %ebx
8010495f:	e8 6c 01 00 00       	call   80104ad0 <acquire>
  r = lk->locked;
80104964:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104966:	89 1c 24             	mov    %ebx,(%esp)
80104969:	e8 e2 02 00 00       	call   80104c50 <release>
  return r;
}
8010496e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104971:	89 f0                	mov    %esi,%eax
80104973:	5b                   	pop    %ebx
80104974:	5e                   	pop    %esi
80104975:	5d                   	pop    %ebp
80104976:	c3                   	ret
80104977:	66 90                	xchg   %ax,%ax
80104979:	66 90                	xchg   %ax,%ax
8010497b:	66 90                	xchg   %ax,%ax
8010497d:	66 90                	xchg   %ax,%ax
8010497f:	90                   	nop

80104980 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104986:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104989:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010498f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104992:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104999:	5d                   	pop    %ebp
8010499a:	c3                   	ret
8010499b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801049a0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801049a0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801049a1:	31 d2                	xor    %edx,%edx
{
801049a3:	89 e5                	mov    %esp,%ebp
801049a5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801049a6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801049a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801049ac:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
801049af:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049b6:	00 
801049b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049be:	00 
801049bf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801049c0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801049c6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801049cc:	77 1a                	ja     801049e8 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
801049ce:	8b 58 04             	mov    0x4(%eax),%ebx
801049d1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801049d4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801049d7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801049d9:	83 fa 0a             	cmp    $0xa,%edx
801049dc:	75 e2                	jne    801049c0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801049de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049e1:	c9                   	leave
801049e2:	c3                   	ret
801049e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
801049e8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801049eb:	83 c1 28             	add    $0x28,%ecx
801049ee:	89 ca                	mov    %ecx,%edx
801049f0:	29 c2                	sub    %eax,%edx
801049f2:	83 e2 04             	and    $0x4,%edx
801049f5:	74 29                	je     80104a20 <getcallerpcs+0x80>
    pcs[i] = 0;
801049f7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801049fd:	83 c0 04             	add    $0x4,%eax
80104a00:	39 c8                	cmp    %ecx,%eax
80104a02:	74 da                	je     801049de <getcallerpcs+0x3e>
80104a04:	eb 1a                	jmp    80104a20 <getcallerpcs+0x80>
80104a06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a0d:	00 
80104a0e:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a15:	00 
80104a16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a1d:	00 
80104a1e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104a20:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104a26:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104a29:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104a30:	39 c8                	cmp    %ecx,%eax
80104a32:	75 ec                	jne    80104a20 <getcallerpcs+0x80>
80104a34:	eb a8                	jmp    801049de <getcallerpcs+0x3e>
80104a36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a3d:	00 
80104a3e:	66 90                	xchg   %ax,%ax

80104a40 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	53                   	push   %ebx
80104a44:	83 ec 04             	sub    $0x4,%esp
80104a47:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
80104a4a:	8b 02                	mov    (%edx),%eax
80104a4c:	85 c0                	test   %eax,%eax
80104a4e:	75 10                	jne    80104a60 <holding+0x20>
}
80104a50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a53:	31 c0                	xor    %eax,%eax
80104a55:	c9                   	leave
80104a56:	c3                   	ret
80104a57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a5e:	00 
80104a5f:	90                   	nop
  return lock->locked && lock->cpu == mycpu();
80104a60:	8b 5a 08             	mov    0x8(%edx),%ebx
80104a63:	e8 58 f4 ff ff       	call   80103ec0 <mycpu>
80104a68:	39 c3                	cmp    %eax,%ebx
}
80104a6a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a6d:	c9                   	leave
  return lock->locked && lock->cpu == mycpu();
80104a6e:	0f 94 c0             	sete   %al
80104a71:	0f b6 c0             	movzbl %al,%eax
}
80104a74:	c3                   	ret
80104a75:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a7c:	00 
80104a7d:	8d 76 00             	lea    0x0(%esi),%esi

80104a80 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	53                   	push   %ebx
80104a84:	83 ec 04             	sub    $0x4,%esp
80104a87:	9c                   	pushf
80104a88:	5b                   	pop    %ebx
  asm volatile("cli");
80104a89:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104a8a:	e8 31 f4 ff ff       	call   80103ec0 <mycpu>
80104a8f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104a95:	85 c0                	test   %eax,%eax
80104a97:	74 17                	je     80104ab0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104a99:	e8 22 f4 ff ff       	call   80103ec0 <mycpu>
80104a9e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104aa5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104aa8:	c9                   	leave
80104aa9:	c3                   	ret
80104aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104ab0:	e8 0b f4 ff ff       	call   80103ec0 <mycpu>
80104ab5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104abb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104ac1:	eb d6                	jmp    80104a99 <pushcli+0x19>
80104ac3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104aca:	00 
80104acb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104ad0 <acquire>:
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	53                   	push   %ebx
80104ad4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104ad7:	e8 a4 ff ff ff       	call   80104a80 <pushcli>
  if(holding(lk))
80104adc:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == mycpu();
80104adf:	8b 02                	mov    (%edx),%eax
80104ae1:	85 c0                	test   %eax,%eax
80104ae3:	0f 85 d7 00 00 00    	jne    80104bc0 <acquire+0xf0>
  asm volatile("lock; xchgl %0, %1" :
80104ae9:	b8 01 00 00 00       	mov    $0x1,%eax
80104aee:	f0 87 02             	lock xchg %eax,(%edx)
80104af1:	b9 01 00 00 00       	mov    $0x1,%ecx
  while(xchg(&lk->locked, 1) != 0)
80104af6:	85 c0                	test   %eax,%eax
80104af8:	74 12                	je     80104b0c <acquire+0x3c>
80104afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b00:	8b 55 08             	mov    0x8(%ebp),%edx
80104b03:	89 c8                	mov    %ecx,%eax
80104b05:	f0 87 02             	lock xchg %eax,(%edx)
80104b08:	85 c0                	test   %eax,%eax
80104b0a:	75 f4                	jne    80104b00 <acquire+0x30>
  __sync_synchronize();
80104b0c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104b11:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104b14:	e8 a7 f3 ff ff       	call   80103ec0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104b19:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80104b1c:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104b1e:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104b21:	31 c0                	xor    %eax,%eax
80104b23:	eb 1b                	jmp    80104b40 <acquire+0x70>
80104b25:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b2c:	00 
80104b2d:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b34:	00 
80104b35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b3c:	00 
80104b3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104b40:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104b46:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104b4c:	77 1a                	ja     80104b68 <acquire+0x98>
    pcs[i] = ebp[1];     // saved %eip
80104b4e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104b51:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104b55:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104b58:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104b5a:	83 f8 0a             	cmp    $0xa,%eax
80104b5d:	75 e1                	jne    80104b40 <acquire+0x70>
}
80104b5f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b62:	c9                   	leave
80104b63:	c3                   	ret
80104b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104b68:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80104b6c:	83 c1 34             	add    $0x34,%ecx
80104b6f:	89 ca                	mov    %ecx,%edx
80104b71:	29 c2                	sub    %eax,%edx
80104b73:	83 e2 04             	and    $0x4,%edx
80104b76:	74 28                	je     80104ba0 <acquire+0xd0>
    pcs[i] = 0;
80104b78:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104b7e:	83 c0 04             	add    $0x4,%eax
80104b81:	39 c8                	cmp    %ecx,%eax
80104b83:	74 da                	je     80104b5f <acquire+0x8f>
80104b85:	eb 19                	jmp    80104ba0 <acquire+0xd0>
80104b87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b8e:	00 
80104b8f:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b96:	00 
80104b97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b9e:	00 
80104b9f:	90                   	nop
    pcs[i] = 0;
80104ba0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ba6:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104ba9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104bb0:	39 c8                	cmp    %ecx,%eax
80104bb2:	75 ec                	jne    80104ba0 <acquire+0xd0>
80104bb4:	eb a9                	jmp    80104b5f <acquire+0x8f>
80104bb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bbd:	00 
80104bbe:	66 90                	xchg   %ax,%ax
  return lock->locked && lock->cpu == mycpu();
80104bc0:	8b 5a 08             	mov    0x8(%edx),%ebx
80104bc3:	e8 f8 f2 ff ff       	call   80103ec0 <mycpu>
80104bc8:	39 c3                	cmp    %eax,%ebx
80104bca:	74 0c                	je     80104bd8 <acquire+0x108>
  while(xchg(&lk->locked, 1) != 0)
80104bcc:	8b 55 08             	mov    0x8(%ebp),%edx
80104bcf:	e9 15 ff ff ff       	jmp    80104ae9 <acquire+0x19>
80104bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("acquire");
80104bd8:	83 ec 0c             	sub    $0xc,%esp
80104bdb:	68 d3 83 10 80       	push   $0x801083d3
80104be0:	e8 cb b8 ff ff       	call   801004b0 <panic>
80104be5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bec:	00 
80104bed:	8d 76 00             	lea    0x0(%esi),%esi

80104bf0 <popcli>:

void
popcli(void)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104bf6:	9c                   	pushf
80104bf7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104bf8:	f6 c4 02             	test   $0x2,%ah
80104bfb:	75 35                	jne    80104c32 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104bfd:	e8 be f2 ff ff       	call   80103ec0 <mycpu>
80104c02:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104c09:	78 34                	js     80104c3f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c0b:	e8 b0 f2 ff ff       	call   80103ec0 <mycpu>
80104c10:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104c16:	85 d2                	test   %edx,%edx
80104c18:	74 06                	je     80104c20 <popcli+0x30>
    sti();
}
80104c1a:	c9                   	leave
80104c1b:	c3                   	ret
80104c1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104c20:	e8 9b f2 ff ff       	call   80103ec0 <mycpu>
80104c25:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104c2b:	85 c0                	test   %eax,%eax
80104c2d:	74 eb                	je     80104c1a <popcli+0x2a>
  asm volatile("sti");
80104c2f:	fb                   	sti
}
80104c30:	c9                   	leave
80104c31:	c3                   	ret
    panic("popcli - interruptible");
80104c32:	83 ec 0c             	sub    $0xc,%esp
80104c35:	68 db 83 10 80       	push   $0x801083db
80104c3a:	e8 71 b8 ff ff       	call   801004b0 <panic>
    panic("popcli");
80104c3f:	83 ec 0c             	sub    $0xc,%esp
80104c42:	68 f2 83 10 80       	push   $0x801083f2
80104c47:	e8 64 b8 ff ff       	call   801004b0 <panic>
80104c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c50 <release>:
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	56                   	push   %esi
80104c54:	53                   	push   %ebx
80104c55:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return lock->locked && lock->cpu == mycpu();
80104c58:	8b 03                	mov    (%ebx),%eax
80104c5a:	85 c0                	test   %eax,%eax
80104c5c:	75 12                	jne    80104c70 <release+0x20>
    panic("release");
80104c5e:	83 ec 0c             	sub    $0xc,%esp
80104c61:	68 f9 83 10 80       	push   $0x801083f9
80104c66:	e8 45 b8 ff ff       	call   801004b0 <panic>
80104c6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return lock->locked && lock->cpu == mycpu();
80104c70:	8b 73 08             	mov    0x8(%ebx),%esi
80104c73:	e8 48 f2 ff ff       	call   80103ec0 <mycpu>
80104c78:	39 c6                	cmp    %eax,%esi
80104c7a:	75 e2                	jne    80104c5e <release+0xe>
  lk->pcs[0] = 0;
80104c7c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104c83:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104c8a:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104c8f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104c95:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c98:	5b                   	pop    %ebx
80104c99:	5e                   	pop    %esi
80104c9a:	5d                   	pop    %ebp
  popcli();
80104c9b:	e9 50 ff ff ff       	jmp    80104bf0 <popcli>

80104ca0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	57                   	push   %edi
80104ca4:	8b 55 08             	mov    0x8(%ebp),%edx
80104ca7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104caa:	89 d0                	mov    %edx,%eax
80104cac:	09 c8                	or     %ecx,%eax
80104cae:	a8 03                	test   $0x3,%al
80104cb0:	75 1e                	jne    80104cd0 <memset+0x30>
    c &= 0xFF;
80104cb2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104cb6:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104cb9:	89 d7                	mov    %edx,%edi
80104cbb:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104cc1:	fc                   	cld
80104cc2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104cc4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104cc7:	89 d0                	mov    %edx,%eax
80104cc9:	c9                   	leave
80104cca:	c3                   	ret
80104ccb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104cd0:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cd3:	89 d7                	mov    %edx,%edi
80104cd5:	fc                   	cld
80104cd6:	f3 aa                	rep stos %al,%es:(%edi)
80104cd8:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104cdb:	89 d0                	mov    %edx,%eax
80104cdd:	c9                   	leave
80104cde:	c3                   	ret
80104cdf:	90                   	nop

80104ce0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	56                   	push   %esi
80104ce4:	8b 75 10             	mov    0x10(%ebp),%esi
80104ce7:	8b 45 08             	mov    0x8(%ebp),%eax
80104cea:	53                   	push   %ebx
80104ceb:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104cee:	85 f6                	test   %esi,%esi
80104cf0:	74 2e                	je     80104d20 <memcmp+0x40>
80104cf2:	01 c6                	add    %eax,%esi
80104cf4:	eb 14                	jmp    80104d0a <memcmp+0x2a>
80104cf6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cfd:	00 
80104cfe:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104d00:	83 c0 01             	add    $0x1,%eax
80104d03:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104d06:	39 f0                	cmp    %esi,%eax
80104d08:	74 16                	je     80104d20 <memcmp+0x40>
    if(*s1 != *s2)
80104d0a:	0f b6 08             	movzbl (%eax),%ecx
80104d0d:	0f b6 1a             	movzbl (%edx),%ebx
80104d10:	38 d9                	cmp    %bl,%cl
80104d12:	74 ec                	je     80104d00 <memcmp+0x20>
      return *s1 - *s2;
80104d14:	0f b6 c1             	movzbl %cl,%eax
80104d17:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104d19:	5b                   	pop    %ebx
80104d1a:	5e                   	pop    %esi
80104d1b:	5d                   	pop    %ebp
80104d1c:	c3                   	ret
80104d1d:	8d 76 00             	lea    0x0(%esi),%esi
80104d20:	5b                   	pop    %ebx
  return 0;
80104d21:	31 c0                	xor    %eax,%eax
}
80104d23:	5e                   	pop    %esi
80104d24:	5d                   	pop    %ebp
80104d25:	c3                   	ret
80104d26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d2d:	00 
80104d2e:	66 90                	xchg   %ax,%ax

80104d30 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	57                   	push   %edi
80104d34:	8b 55 08             	mov    0x8(%ebp),%edx
80104d37:	8b 45 10             	mov    0x10(%ebp),%eax
80104d3a:	56                   	push   %esi
80104d3b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104d3e:	39 d6                	cmp    %edx,%esi
80104d40:	73 26                	jae    80104d68 <memmove+0x38>
80104d42:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104d45:	39 ca                	cmp    %ecx,%edx
80104d47:	73 1f                	jae    80104d68 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104d49:	85 c0                	test   %eax,%eax
80104d4b:	74 0f                	je     80104d5c <memmove+0x2c>
80104d4d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104d50:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104d54:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104d57:	83 e8 01             	sub    $0x1,%eax
80104d5a:	73 f4                	jae    80104d50 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104d5c:	5e                   	pop    %esi
80104d5d:	89 d0                	mov    %edx,%eax
80104d5f:	5f                   	pop    %edi
80104d60:	5d                   	pop    %ebp
80104d61:	c3                   	ret
80104d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104d68:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104d6b:	89 d7                	mov    %edx,%edi
80104d6d:	85 c0                	test   %eax,%eax
80104d6f:	74 eb                	je     80104d5c <memmove+0x2c>
80104d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d7f:	00 
      *d++ = *s++;
80104d80:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104d81:	39 f1                	cmp    %esi,%ecx
80104d83:	75 fb                	jne    80104d80 <memmove+0x50>
}
80104d85:	5e                   	pop    %esi
80104d86:	89 d0                	mov    %edx,%eax
80104d88:	5f                   	pop    %edi
80104d89:	5d                   	pop    %ebp
80104d8a:	c3                   	ret
80104d8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104d90 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104d90:	eb 9e                	jmp    80104d30 <memmove>
80104d92:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d99:	00 
80104d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104da0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	53                   	push   %ebx
80104da4:	8b 55 10             	mov    0x10(%ebp),%edx
80104da7:	8b 45 08             	mov    0x8(%ebp),%eax
80104daa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104dad:	85 d2                	test   %edx,%edx
80104daf:	75 16                	jne    80104dc7 <strncmp+0x27>
80104db1:	eb 2d                	jmp    80104de0 <strncmp+0x40>
80104db3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104db8:	3a 19                	cmp    (%ecx),%bl
80104dba:	75 12                	jne    80104dce <strncmp+0x2e>
    n--, p++, q++;
80104dbc:	83 c0 01             	add    $0x1,%eax
80104dbf:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104dc2:	83 ea 01             	sub    $0x1,%edx
80104dc5:	74 19                	je     80104de0 <strncmp+0x40>
80104dc7:	0f b6 18             	movzbl (%eax),%ebx
80104dca:	84 db                	test   %bl,%bl
80104dcc:	75 ea                	jne    80104db8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104dce:	0f b6 00             	movzbl (%eax),%eax
80104dd1:	0f b6 11             	movzbl (%ecx),%edx
}
80104dd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104dd7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104dd8:	29 d0                	sub    %edx,%eax
}
80104dda:	c3                   	ret
80104ddb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104de0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104de3:	31 c0                	xor    %eax,%eax
}
80104de5:	c9                   	leave
80104de6:	c3                   	ret
80104de7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104dee:	00 
80104def:	90                   	nop

80104df0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	57                   	push   %edi
80104df4:	56                   	push   %esi
80104df5:	8b 75 08             	mov    0x8(%ebp),%esi
80104df8:	53                   	push   %ebx
80104df9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104dfc:	89 f0                	mov    %esi,%eax
80104dfe:	eb 15                	jmp    80104e15 <strncpy+0x25>
80104e00:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104e04:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104e07:	83 c0 01             	add    $0x1,%eax
80104e0a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
80104e0e:	88 48 ff             	mov    %cl,-0x1(%eax)
80104e11:	84 c9                	test   %cl,%cl
80104e13:	74 13                	je     80104e28 <strncpy+0x38>
80104e15:	89 d3                	mov    %edx,%ebx
80104e17:	83 ea 01             	sub    $0x1,%edx
80104e1a:	85 db                	test   %ebx,%ebx
80104e1c:	7f e2                	jg     80104e00 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104e1e:	5b                   	pop    %ebx
80104e1f:	89 f0                	mov    %esi,%eax
80104e21:	5e                   	pop    %esi
80104e22:	5f                   	pop    %edi
80104e23:	5d                   	pop    %ebp
80104e24:	c3                   	ret
80104e25:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104e28:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104e2b:	83 e9 01             	sub    $0x1,%ecx
80104e2e:	85 d2                	test   %edx,%edx
80104e30:	74 ec                	je     80104e1e <strncpy+0x2e>
80104e32:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e39:	00 
80104e3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104e40:	83 c0 01             	add    $0x1,%eax
80104e43:	89 ca                	mov    %ecx,%edx
80104e45:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104e49:	29 c2                	sub    %eax,%edx
80104e4b:	85 d2                	test   %edx,%edx
80104e4d:	7f f1                	jg     80104e40 <strncpy+0x50>
}
80104e4f:	5b                   	pop    %ebx
80104e50:	89 f0                	mov    %esi,%eax
80104e52:	5e                   	pop    %esi
80104e53:	5f                   	pop    %edi
80104e54:	5d                   	pop    %ebp
80104e55:	c3                   	ret
80104e56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e5d:	00 
80104e5e:	66 90                	xchg   %ax,%ax

80104e60 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	56                   	push   %esi
80104e64:	8b 55 10             	mov    0x10(%ebp),%edx
80104e67:	8b 75 08             	mov    0x8(%ebp),%esi
80104e6a:	53                   	push   %ebx
80104e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104e6e:	85 d2                	test   %edx,%edx
80104e70:	7e 25                	jle    80104e97 <safestrcpy+0x37>
80104e72:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104e76:	89 f2                	mov    %esi,%edx
80104e78:	eb 16                	jmp    80104e90 <safestrcpy+0x30>
80104e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104e80:	0f b6 08             	movzbl (%eax),%ecx
80104e83:	83 c0 01             	add    $0x1,%eax
80104e86:	83 c2 01             	add    $0x1,%edx
80104e89:	88 4a ff             	mov    %cl,-0x1(%edx)
80104e8c:	84 c9                	test   %cl,%cl
80104e8e:	74 04                	je     80104e94 <safestrcpy+0x34>
80104e90:	39 d8                	cmp    %ebx,%eax
80104e92:	75 ec                	jne    80104e80 <safestrcpy+0x20>
    ;
  *s = 0;
80104e94:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104e97:	89 f0                	mov    %esi,%eax
80104e99:	5b                   	pop    %ebx
80104e9a:	5e                   	pop    %esi
80104e9b:	5d                   	pop    %ebp
80104e9c:	c3                   	ret
80104e9d:	8d 76 00             	lea    0x0(%esi),%esi

80104ea0 <strlen>:

int
strlen(const char *s)
{
80104ea0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104ea1:	31 c0                	xor    %eax,%eax
{
80104ea3:	89 e5                	mov    %esp,%ebp
80104ea5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104ea8:	80 3a 00             	cmpb   $0x0,(%edx)
80104eab:	74 0c                	je     80104eb9 <strlen+0x19>
80104ead:	8d 76 00             	lea    0x0(%esi),%esi
80104eb0:	83 c0 01             	add    $0x1,%eax
80104eb3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104eb7:	75 f7                	jne    80104eb0 <strlen+0x10>
    ;
  return n;
}
80104eb9:	5d                   	pop    %ebp
80104eba:	c3                   	ret

80104ebb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104ebb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104ebf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104ec3:	55                   	push   %ebp
  pushl %ebx
80104ec4:	53                   	push   %ebx
  pushl %esi
80104ec5:	56                   	push   %esi
  pushl %edi
80104ec6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104ec7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104ec9:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80104ecb:	5f                   	pop    %edi
  popl %esi
80104ecc:	5e                   	pop    %esi
  popl %ebx
80104ecd:	5b                   	pop    %ebx
  popl %ebp
80104ece:	5d                   	pop    %ebp
  ret
80104ecf:	c3                   	ret

80104ed0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	53                   	push   %ebx
80104ed4:	83 ec 04             	sub    $0x4,%esp
80104ed7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104eda:	e8 61 f0 ff ff       	call   80103f40 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104edf:	8b 00                	mov    (%eax),%eax
80104ee1:	39 c3                	cmp    %eax,%ebx
80104ee3:	73 1b                	jae    80104f00 <fetchint+0x30>
80104ee5:	8d 53 04             	lea    0x4(%ebx),%edx
80104ee8:	39 d0                	cmp    %edx,%eax
80104eea:	72 14                	jb     80104f00 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104eec:	8b 45 0c             	mov    0xc(%ebp),%eax
80104eef:	8b 13                	mov    (%ebx),%edx
80104ef1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ef3:	31 c0                	xor    %eax,%eax
}
80104ef5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ef8:	c9                   	leave
80104ef9:	c3                   	ret
80104efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f05:	eb ee                	jmp    80104ef5 <fetchint+0x25>
80104f07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f0e:	00 
80104f0f:	90                   	nop

80104f10 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	53                   	push   %ebx
80104f14:	83 ec 04             	sub    $0x4,%esp
80104f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104f1a:	e8 21 f0 ff ff       	call   80103f40 <myproc>

  if(addr >= curproc->sz)
80104f1f:	3b 18                	cmp    (%eax),%ebx
80104f21:	73 35                	jae    80104f58 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80104f23:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f26:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104f28:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104f2a:	39 d3                	cmp    %edx,%ebx
80104f2c:	73 2a                	jae    80104f58 <fetchstr+0x48>
80104f2e:	89 d8                	mov    %ebx,%eax
80104f30:	eb 15                	jmp    80104f47 <fetchstr+0x37>
80104f32:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f39:	00 
80104f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f40:	83 c0 01             	add    $0x1,%eax
80104f43:	39 d0                	cmp    %edx,%eax
80104f45:	73 11                	jae    80104f58 <fetchstr+0x48>
    if(*s == 0)
80104f47:	80 38 00             	cmpb   $0x0,(%eax)
80104f4a:	75 f4                	jne    80104f40 <fetchstr+0x30>
      return s - *pp;
80104f4c:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104f4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f51:	c9                   	leave
80104f52:	c3                   	ret
80104f53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f58:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104f5b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f60:	c9                   	leave
80104f61:	c3                   	ret
80104f62:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f69:	00 
80104f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f70 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	56                   	push   %esi
80104f74:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f75:	e8 c6 ef ff ff       	call   80103f40 <myproc>
80104f7a:	8b 55 08             	mov    0x8(%ebp),%edx
80104f7d:	8b 40 18             	mov    0x18(%eax),%eax
80104f80:	8b 40 44             	mov    0x44(%eax),%eax
80104f83:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104f86:	e8 b5 ef ff ff       	call   80103f40 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f8b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f8e:	8b 00                	mov    (%eax),%eax
80104f90:	39 c6                	cmp    %eax,%esi
80104f92:	73 1c                	jae    80104fb0 <argint+0x40>
80104f94:	8d 53 08             	lea    0x8(%ebx),%edx
80104f97:	39 d0                	cmp    %edx,%eax
80104f99:	72 15                	jb     80104fb0 <argint+0x40>
  *ip = *(int*)(addr);
80104f9b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f9e:	8b 53 04             	mov    0x4(%ebx),%edx
80104fa1:	89 10                	mov    %edx,(%eax)
  return 0;
80104fa3:	31 c0                	xor    %eax,%eax
}
80104fa5:	5b                   	pop    %ebx
80104fa6:	5e                   	pop    %esi
80104fa7:	5d                   	pop    %ebp
80104fa8:	c3                   	ret
80104fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104fb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fb5:	eb ee                	jmp    80104fa5 <argint+0x35>
80104fb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fbe:	00 
80104fbf:	90                   	nop

80104fc0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	57                   	push   %edi
80104fc4:	56                   	push   %esi
80104fc5:	53                   	push   %ebx
80104fc6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104fc9:	e8 72 ef ff ff       	call   80103f40 <myproc>
80104fce:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fd0:	e8 6b ef ff ff       	call   80103f40 <myproc>
80104fd5:	8b 55 08             	mov    0x8(%ebp),%edx
80104fd8:	8b 40 18             	mov    0x18(%eax),%eax
80104fdb:	8b 40 44             	mov    0x44(%eax),%eax
80104fde:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104fe1:	e8 5a ef ff ff       	call   80103f40 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fe6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104fe9:	8b 00                	mov    (%eax),%eax
80104feb:	39 c7                	cmp    %eax,%edi
80104fed:	73 31                	jae    80105020 <argptr+0x60>
80104fef:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104ff2:	39 c8                	cmp    %ecx,%eax
80104ff4:	72 2a                	jb     80105020 <argptr+0x60>

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104ff6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104ff9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104ffc:	85 d2                	test   %edx,%edx
80104ffe:	78 20                	js     80105020 <argptr+0x60>
80105000:	8b 16                	mov    (%esi),%edx
80105002:	39 d0                	cmp    %edx,%eax
80105004:	73 1a                	jae    80105020 <argptr+0x60>
80105006:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105009:	01 c3                	add    %eax,%ebx
8010500b:	39 da                	cmp    %ebx,%edx
8010500d:	72 11                	jb     80105020 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010500f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105012:	89 02                	mov    %eax,(%edx)
  return 0;
80105014:	31 c0                	xor    %eax,%eax
}
80105016:	83 c4 0c             	add    $0xc,%esp
80105019:	5b                   	pop    %ebx
8010501a:	5e                   	pop    %esi
8010501b:	5f                   	pop    %edi
8010501c:	5d                   	pop    %ebp
8010501d:	c3                   	ret
8010501e:	66 90                	xchg   %ax,%ax
    return -1;
80105020:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105025:	eb ef                	jmp    80105016 <argptr+0x56>
80105027:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010502e:	00 
8010502f:	90                   	nop

80105030 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	56                   	push   %esi
80105034:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105035:	e8 06 ef ff ff       	call   80103f40 <myproc>
8010503a:	8b 55 08             	mov    0x8(%ebp),%edx
8010503d:	8b 40 18             	mov    0x18(%eax),%eax
80105040:	8b 40 44             	mov    0x44(%eax),%eax
80105043:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105046:	e8 f5 ee ff ff       	call   80103f40 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010504b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010504e:	8b 00                	mov    (%eax),%eax
80105050:	39 c6                	cmp    %eax,%esi
80105052:	73 44                	jae    80105098 <argstr+0x68>
80105054:	8d 53 08             	lea    0x8(%ebx),%edx
80105057:	39 d0                	cmp    %edx,%eax
80105059:	72 3d                	jb     80105098 <argstr+0x68>
  *ip = *(int*)(addr);
8010505b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010505e:	e8 dd ee ff ff       	call   80103f40 <myproc>
  if(addr >= curproc->sz)
80105063:	3b 18                	cmp    (%eax),%ebx
80105065:	73 31                	jae    80105098 <argstr+0x68>
  *pp = (char*)addr;
80105067:	8b 55 0c             	mov    0xc(%ebp),%edx
8010506a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010506c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010506e:	39 d3                	cmp    %edx,%ebx
80105070:	73 26                	jae    80105098 <argstr+0x68>
80105072:	89 d8                	mov    %ebx,%eax
80105074:	eb 11                	jmp    80105087 <argstr+0x57>
80105076:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010507d:	00 
8010507e:	66 90                	xchg   %ax,%ax
80105080:	83 c0 01             	add    $0x1,%eax
80105083:	39 d0                	cmp    %edx,%eax
80105085:	73 11                	jae    80105098 <argstr+0x68>
    if(*s == 0)
80105087:	80 38 00             	cmpb   $0x0,(%eax)
8010508a:	75 f4                	jne    80105080 <argstr+0x50>
      return s - *pp;
8010508c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010508e:	5b                   	pop    %ebx
8010508f:	5e                   	pop    %esi
80105090:	5d                   	pop    %ebp
80105091:	c3                   	ret
80105092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105098:	5b                   	pop    %ebx
    return -1;
80105099:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010509e:	5e                   	pop    %esi
8010509f:	5d                   	pop    %ebp
801050a0:	c3                   	ret
801050a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801050a8:	00 
801050a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801050b0 <syscall>:
[SYS_echo]    sys_echo,
};

void
syscall(void)
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	53                   	push   %ebx
801050b4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801050b7:	e8 84 ee ff ff       	call   80103f40 <myproc>
801050bc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801050be:	8b 40 18             	mov    0x18(%eax),%eax
801050c1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801050c4:	8d 50 ff             	lea    -0x1(%eax),%edx
801050c7:	83 fa 1a             	cmp    $0x1a,%edx
801050ca:	77 24                	ja     801050f0 <syscall+0x40>
801050cc:	8b 14 85 a0 8b 10 80 	mov    -0x7fef7460(,%eax,4),%edx
801050d3:	85 d2                	test   %edx,%edx
801050d5:	74 19                	je     801050f0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801050d7:	ff d2                	call   *%edx
801050d9:	89 c2                	mov    %eax,%edx
801050db:	8b 43 18             	mov    0x18(%ebx),%eax
801050de:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801050e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050e4:	c9                   	leave
801050e5:	c3                   	ret
801050e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801050ed:	00 
801050ee:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
801050f0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801050f1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801050f4:	50                   	push   %eax
801050f5:	ff 73 10             	push   0x10(%ebx)
801050f8:	68 01 84 10 80       	push   $0x80108401
801050fd:	e8 ee b6 ff ff       	call   801007f0 <cprintf>
    curproc->tf->eax = -1;
80105102:	8b 43 18             	mov    0x18(%ebx),%eax
80105105:	83 c4 10             	add    $0x10,%esp
80105108:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010510f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105112:	c9                   	leave
80105113:	c3                   	ret
80105114:	66 90                	xchg   %ax,%ax
80105116:	66 90                	xchg   %ax,%ax
80105118:	66 90                	xchg   %ax,%ax
8010511a:	66 90                	xchg   %ax,%ax
8010511c:	66 90                	xchg   %ax,%ax
8010511e:	66 90                	xchg   %ax,%ax

80105120 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	57                   	push   %edi
80105124:	56                   	push   %esi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105125:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105128:	53                   	push   %ebx
80105129:	83 ec 44             	sub    $0x44,%esp
8010512c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
8010512f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105132:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80105135:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105138:	57                   	push   %edi
80105139:	50                   	push   %eax
8010513a:	e8 f1 d3 ff ff       	call   80102530 <nameiparent>
8010513f:	83 c4 10             	add    $0x10,%esp
80105142:	85 c0                	test   %eax,%eax
80105144:	74 5e                	je     801051a4 <create+0x84>
    return 0;
  ilock(dp);
80105146:	83 ec 0c             	sub    $0xc,%esp
80105149:	89 c3                	mov    %eax,%ebx
8010514b:	50                   	push   %eax
8010514c:	e8 9f ca ff ff       	call   80101bf0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105151:	83 c4 0c             	add    $0xc,%esp
80105154:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105157:	50                   	push   %eax
80105158:	57                   	push   %edi
80105159:	53                   	push   %ebx
8010515a:	e8 f1 cf ff ff       	call   80102150 <dirlookup>
8010515f:	83 c4 10             	add    $0x10,%esp
80105162:	89 c6                	mov    %eax,%esi
80105164:	85 c0                	test   %eax,%eax
80105166:	74 48                	je     801051b0 <create+0x90>
    iunlockput(dp);
80105168:	83 ec 0c             	sub    $0xc,%esp
8010516b:	53                   	push   %ebx
8010516c:	e8 0f cd ff ff       	call   80101e80 <iunlockput>
    ilock(ip);
80105171:	89 34 24             	mov    %esi,(%esp)
80105174:	e8 77 ca ff ff       	call   80101bf0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105179:	83 c4 10             	add    $0x10,%esp
8010517c:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80105181:	75 15                	jne    80105198 <create+0x78>
80105183:	66 83 7e 54 02       	cmpw   $0x2,0x54(%esi)
80105188:	75 0e                	jne    80105198 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010518a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010518d:	89 f0                	mov    %esi,%eax
8010518f:	5b                   	pop    %ebx
80105190:	5e                   	pop    %esi
80105191:	5f                   	pop    %edi
80105192:	5d                   	pop    %ebp
80105193:	c3                   	ret
80105194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105198:	83 ec 0c             	sub    $0xc,%esp
8010519b:	56                   	push   %esi
8010519c:	e8 df cc ff ff       	call   80101e80 <iunlockput>
    return 0;
801051a1:	83 c4 10             	add    $0x10,%esp
}
801051a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801051a7:	31 f6                	xor    %esi,%esi
}
801051a9:	5b                   	pop    %ebx
801051aa:	89 f0                	mov    %esi,%eax
801051ac:	5e                   	pop    %esi
801051ad:	5f                   	pop    %edi
801051ae:	5d                   	pop    %ebp
801051af:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
801051b0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
801051b4:	83 ec 08             	sub    $0x8,%esp
801051b7:	50                   	push   %eax
801051b8:	ff 73 04             	push   0x4(%ebx)
801051bb:	e8 c0 c8 ff ff       	call   80101a80 <ialloc>
801051c0:	83 c4 10             	add    $0x10,%esp
801051c3:	89 c6                	mov    %eax,%esi
801051c5:	85 c0                	test   %eax,%eax
801051c7:	0f 84 ae 00 00 00    	je     8010527b <create+0x15b>
  ilock(ip);
801051cd:	83 ec 0c             	sub    $0xc,%esp
801051d0:	50                   	push   %eax
801051d1:	e8 1a ca ff ff       	call   80101bf0 <ilock>
  ip->major = major;
801051d6:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
801051da:	66 89 46 56          	mov    %ax,0x56(%esi)
  ip->minor = minor;
801051de:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
801051e2:	66 89 46 58          	mov    %ax,0x58(%esi)
  ip->nlink = 1;
801051e6:	b8 01 00 00 00       	mov    $0x1,%eax
801051eb:	66 89 46 5a          	mov    %ax,0x5a(%esi)
  iupdate(ip);
801051ef:	89 34 24             	mov    %esi,(%esp)
801051f2:	e8 49 c9 ff ff       	call   80101b40 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801051f7:	83 c4 10             	add    $0x10,%esp
801051fa:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
801051ff:	74 2f                	je     80105230 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80105201:	83 ec 04             	sub    $0x4,%esp
80105204:	ff 76 08             	push   0x8(%esi)
80105207:	57                   	push   %edi
80105208:	53                   	push   %ebx
80105209:	e8 42 d2 ff ff       	call   80102450 <dirlink>
8010520e:	83 c4 10             	add    $0x10,%esp
80105211:	85 c0                	test   %eax,%eax
80105213:	78 73                	js     80105288 <create+0x168>
  iunlockput(dp);
80105215:	83 ec 0c             	sub    $0xc,%esp
80105218:	53                   	push   %ebx
80105219:	e8 62 cc ff ff       	call   80101e80 <iunlockput>
  return ip;
8010521e:	83 c4 10             	add    $0x10,%esp
}
80105221:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105224:	89 f0                	mov    %esi,%eax
80105226:	5b                   	pop    %ebx
80105227:	5e                   	pop    %esi
80105228:	5f                   	pop    %edi
80105229:	5d                   	pop    %ebp
8010522a:	c3                   	ret
8010522b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    iupdate(dp);
80105230:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105233:	66 83 43 5a 01       	addw   $0x1,0x5a(%ebx)
    iupdate(dp);
80105238:	53                   	push   %ebx
80105239:	e8 02 c9 ff ff       	call   80101b40 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010523e:	83 c4 0c             	add    $0xc,%esp
80105241:	ff 76 08             	push   0x8(%esi)
80105244:	68 39 84 10 80       	push   $0x80108439
80105249:	56                   	push   %esi
8010524a:	e8 01 d2 ff ff       	call   80102450 <dirlink>
8010524f:	83 c4 10             	add    $0x10,%esp
80105252:	85 c0                	test   %eax,%eax
80105254:	78 18                	js     8010526e <create+0x14e>
80105256:	83 ec 04             	sub    $0x4,%esp
80105259:	ff 73 08             	push   0x8(%ebx)
8010525c:	68 38 84 10 80       	push   $0x80108438
80105261:	56                   	push   %esi
80105262:	e8 e9 d1 ff ff       	call   80102450 <dirlink>
80105267:	83 c4 10             	add    $0x10,%esp
8010526a:	85 c0                	test   %eax,%eax
8010526c:	79 93                	jns    80105201 <create+0xe1>
      panic("create dots");
8010526e:	83 ec 0c             	sub    $0xc,%esp
80105271:	68 2c 84 10 80       	push   $0x8010842c
80105276:	e8 35 b2 ff ff       	call   801004b0 <panic>
    panic("create: ialloc");
8010527b:	83 ec 0c             	sub    $0xc,%esp
8010527e:	68 1d 84 10 80       	push   $0x8010841d
80105283:	e8 28 b2 ff ff       	call   801004b0 <panic>
    panic("create: dirlink");
80105288:	83 ec 0c             	sub    $0xc,%esp
8010528b:	68 3b 84 10 80       	push   $0x8010843b
80105290:	e8 1b b2 ff ff       	call   801004b0 <panic>
80105295:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010529c:	00 
8010529d:	8d 76 00             	lea    0x0(%esi),%esi

801052a0 <sys_dup>:
{
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	56                   	push   %esi
801052a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801052a5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801052a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801052ab:	50                   	push   %eax
801052ac:	6a 00                	push   $0x0
801052ae:	e8 bd fc ff ff       	call   80104f70 <argint>
801052b3:	83 c4 10             	add    $0x10,%esp
801052b6:	85 c0                	test   %eax,%eax
801052b8:	78 36                	js     801052f0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801052ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801052be:	77 30                	ja     801052f0 <sys_dup+0x50>
801052c0:	e8 7b ec ff ff       	call   80103f40 <myproc>
801052c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801052c8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801052cc:	85 f6                	test   %esi,%esi
801052ce:	74 20                	je     801052f0 <sys_dup+0x50>
  struct proc *curproc = myproc();
801052d0:	e8 6b ec ff ff       	call   80103f40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801052d5:	31 db                	xor    %ebx,%ebx
801052d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052de:	00 
801052df:	90                   	nop
    if(curproc->ofile[fd] == 0){
801052e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052e4:	85 d2                	test   %edx,%edx
801052e6:	74 18                	je     80105300 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
801052e8:	83 c3 01             	add    $0x1,%ebx
801052eb:	83 fb 10             	cmp    $0x10,%ebx
801052ee:	75 f0                	jne    801052e0 <sys_dup+0x40>
    return -1;
801052f0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801052f5:	eb 19                	jmp    80105310 <sys_dup+0x70>
801052f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052fe:	00 
801052ff:	90                   	nop
  filedup(f);
80105300:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105303:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105307:	56                   	push   %esi
80105308:	e8 c3 be ff ff       	call   801011d0 <filedup>
  return fd;
8010530d:	83 c4 10             	add    $0x10,%esp
}
80105310:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105313:	89 d8                	mov    %ebx,%eax
80105315:	5b                   	pop    %ebx
80105316:	5e                   	pop    %esi
80105317:	5d                   	pop    %ebp
80105318:	c3                   	ret
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105320 <sys_read>:
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105325:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105328:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010532b:	53                   	push   %ebx
8010532c:	6a 00                	push   $0x0
8010532e:	e8 3d fc ff ff       	call   80104f70 <argint>
80105333:	83 c4 10             	add    $0x10,%esp
80105336:	85 c0                	test   %eax,%eax
80105338:	78 5e                	js     80105398 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010533a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010533e:	77 58                	ja     80105398 <sys_read+0x78>
80105340:	e8 fb eb ff ff       	call   80103f40 <myproc>
80105345:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105348:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010534c:	85 f6                	test   %esi,%esi
8010534e:	74 48                	je     80105398 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105350:	83 ec 08             	sub    $0x8,%esp
80105353:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105356:	50                   	push   %eax
80105357:	6a 02                	push   $0x2
80105359:	e8 12 fc ff ff       	call   80104f70 <argint>
8010535e:	83 c4 10             	add    $0x10,%esp
80105361:	85 c0                	test   %eax,%eax
80105363:	78 33                	js     80105398 <sys_read+0x78>
80105365:	83 ec 04             	sub    $0x4,%esp
80105368:	ff 75 f0             	push   -0x10(%ebp)
8010536b:	53                   	push   %ebx
8010536c:	6a 01                	push   $0x1
8010536e:	e8 4d fc ff ff       	call   80104fc0 <argptr>
80105373:	83 c4 10             	add    $0x10,%esp
80105376:	85 c0                	test   %eax,%eax
80105378:	78 1e                	js     80105398 <sys_read+0x78>
  return fileread(f, p, n);
8010537a:	83 ec 04             	sub    $0x4,%esp
8010537d:	ff 75 f0             	push   -0x10(%ebp)
80105380:	ff 75 f4             	push   -0xc(%ebp)
80105383:	56                   	push   %esi
80105384:	e8 c7 bf ff ff       	call   80101350 <fileread>
80105389:	83 c4 10             	add    $0x10,%esp
}
8010538c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010538f:	5b                   	pop    %ebx
80105390:	5e                   	pop    %esi
80105391:	5d                   	pop    %ebp
80105392:	c3                   	ret
80105393:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105398:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010539d:	eb ed                	jmp    8010538c <sys_read+0x6c>
8010539f:	90                   	nop

801053a0 <sys_write>:
{
801053a0:	55                   	push   %ebp
801053a1:	89 e5                	mov    %esp,%ebp
801053a3:	56                   	push   %esi
801053a4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801053a5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801053a8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801053ab:	53                   	push   %ebx
801053ac:	6a 00                	push   $0x0
801053ae:	e8 bd fb ff ff       	call   80104f70 <argint>
801053b3:	83 c4 10             	add    $0x10,%esp
801053b6:	85 c0                	test   %eax,%eax
801053b8:	78 5e                	js     80105418 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801053ba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801053be:	77 58                	ja     80105418 <sys_write+0x78>
801053c0:	e8 7b eb ff ff       	call   80103f40 <myproc>
801053c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053c8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801053cc:	85 f6                	test   %esi,%esi
801053ce:	74 48                	je     80105418 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053d0:	83 ec 08             	sub    $0x8,%esp
801053d3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053d6:	50                   	push   %eax
801053d7:	6a 02                	push   $0x2
801053d9:	e8 92 fb ff ff       	call   80104f70 <argint>
801053de:	83 c4 10             	add    $0x10,%esp
801053e1:	85 c0                	test   %eax,%eax
801053e3:	78 33                	js     80105418 <sys_write+0x78>
801053e5:	83 ec 04             	sub    $0x4,%esp
801053e8:	ff 75 f0             	push   -0x10(%ebp)
801053eb:	53                   	push   %ebx
801053ec:	6a 01                	push   $0x1
801053ee:	e8 cd fb ff ff       	call   80104fc0 <argptr>
801053f3:	83 c4 10             	add    $0x10,%esp
801053f6:	85 c0                	test   %eax,%eax
801053f8:	78 1e                	js     80105418 <sys_write+0x78>
  return filewrite(f, p, n);
801053fa:	83 ec 04             	sub    $0x4,%esp
801053fd:	ff 75 f0             	push   -0x10(%ebp)
80105400:	ff 75 f4             	push   -0xc(%ebp)
80105403:	56                   	push   %esi
80105404:	e8 d7 bf ff ff       	call   801013e0 <filewrite>
80105409:	83 c4 10             	add    $0x10,%esp
}
8010540c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010540f:	5b                   	pop    %ebx
80105410:	5e                   	pop    %esi
80105411:	5d                   	pop    %ebp
80105412:	c3                   	ret
80105413:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105418:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010541d:	eb ed                	jmp    8010540c <sys_write+0x6c>
8010541f:	90                   	nop

80105420 <sys_close>:
{
80105420:	55                   	push   %ebp
80105421:	89 e5                	mov    %esp,%ebp
80105423:	56                   	push   %esi
80105424:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105425:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105428:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010542b:	50                   	push   %eax
8010542c:	6a 00                	push   $0x0
8010542e:	e8 3d fb ff ff       	call   80104f70 <argint>
80105433:	83 c4 10             	add    $0x10,%esp
80105436:	85 c0                	test   %eax,%eax
80105438:	78 3e                	js     80105478 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010543a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010543e:	77 38                	ja     80105478 <sys_close+0x58>
80105440:	e8 fb ea ff ff       	call   80103f40 <myproc>
80105445:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105448:	8d 5a 08             	lea    0x8(%edx),%ebx
8010544b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010544f:	85 f6                	test   %esi,%esi
80105451:	74 25                	je     80105478 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105453:	e8 e8 ea ff ff       	call   80103f40 <myproc>
  fileclose(f);
80105458:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010545b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105462:	00 
  fileclose(f);
80105463:	56                   	push   %esi
80105464:	e8 b7 bd ff ff       	call   80101220 <fileclose>
  return 0;
80105469:	83 c4 10             	add    $0x10,%esp
8010546c:	31 c0                	xor    %eax,%eax
}
8010546e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105471:	5b                   	pop    %ebx
80105472:	5e                   	pop    %esi
80105473:	5d                   	pop    %ebp
80105474:	c3                   	ret
80105475:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105478:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010547d:	eb ef                	jmp    8010546e <sys_close+0x4e>
8010547f:	90                   	nop

80105480 <sys_fstat>:
{
80105480:	55                   	push   %ebp
80105481:	89 e5                	mov    %esp,%ebp
80105483:	56                   	push   %esi
80105484:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105485:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105488:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010548b:	53                   	push   %ebx
8010548c:	6a 00                	push   $0x0
8010548e:	e8 dd fa ff ff       	call   80104f70 <argint>
80105493:	83 c4 10             	add    $0x10,%esp
80105496:	85 c0                	test   %eax,%eax
80105498:	78 46                	js     801054e0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010549a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010549e:	77 40                	ja     801054e0 <sys_fstat+0x60>
801054a0:	e8 9b ea ff ff       	call   80103f40 <myproc>
801054a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054a8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801054ac:	85 f6                	test   %esi,%esi
801054ae:	74 30                	je     801054e0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801054b0:	83 ec 04             	sub    $0x4,%esp
801054b3:	6a 64                	push   $0x64
801054b5:	53                   	push   %ebx
801054b6:	6a 01                	push   $0x1
801054b8:	e8 03 fb ff ff       	call   80104fc0 <argptr>
801054bd:	83 c4 10             	add    $0x10,%esp
801054c0:	85 c0                	test   %eax,%eax
801054c2:	78 1c                	js     801054e0 <sys_fstat+0x60>
  return filestat(f, st);
801054c4:	83 ec 08             	sub    $0x8,%esp
801054c7:	ff 75 f4             	push   -0xc(%ebp)
801054ca:	56                   	push   %esi
801054cb:	e8 30 be ff ff       	call   80101300 <filestat>
801054d0:	83 c4 10             	add    $0x10,%esp
}
801054d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054d6:	5b                   	pop    %ebx
801054d7:	5e                   	pop    %esi
801054d8:	5d                   	pop    %ebp
801054d9:	c3                   	ret
801054da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801054e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054e5:	eb ec                	jmp    801054d3 <sys_fstat+0x53>
801054e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054ee:	00 
801054ef:	90                   	nop

801054f0 <sys_link>:
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	57                   	push   %edi
801054f4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801054f5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801054f8:	53                   	push   %ebx
801054f9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801054fc:	50                   	push   %eax
801054fd:	6a 00                	push   $0x0
801054ff:	e8 2c fb ff ff       	call   80105030 <argstr>
80105504:	83 c4 10             	add    $0x10,%esp
80105507:	85 c0                	test   %eax,%eax
80105509:	0f 88 fb 00 00 00    	js     8010560a <sys_link+0x11a>
8010550f:	83 ec 08             	sub    $0x8,%esp
80105512:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105515:	50                   	push   %eax
80105516:	6a 01                	push   $0x1
80105518:	e8 13 fb ff ff       	call   80105030 <argstr>
8010551d:	83 c4 10             	add    $0x10,%esp
80105520:	85 c0                	test   %eax,%eax
80105522:	0f 88 e2 00 00 00    	js     8010560a <sys_link+0x11a>
  begin_op();
80105528:	e8 73 dd ff ff       	call   801032a0 <begin_op>
  if((ip = namei(old)) == 0){
8010552d:	83 ec 0c             	sub    $0xc,%esp
80105530:	ff 75 d4             	push   -0x2c(%ebp)
80105533:	e8 d8 cf ff ff       	call   80102510 <namei>
80105538:	83 c4 10             	add    $0x10,%esp
8010553b:	89 c3                	mov    %eax,%ebx
8010553d:	85 c0                	test   %eax,%eax
8010553f:	0f 84 df 00 00 00    	je     80105624 <sys_link+0x134>
  ilock(ip);
80105545:	83 ec 0c             	sub    $0xc,%esp
80105548:	50                   	push   %eax
80105549:	e8 a2 c6 ff ff       	call   80101bf0 <ilock>
  if(ip->type == T_DIR){
8010554e:	83 c4 10             	add    $0x10,%esp
80105551:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
80105556:	0f 84 b5 00 00 00    	je     80105611 <sys_link+0x121>
  iupdate(ip);
8010555c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010555f:	66 83 43 5a 01       	addw   $0x1,0x5a(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105564:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105567:	53                   	push   %ebx
80105568:	e8 d3 c5 ff ff       	call   80101b40 <iupdate>
  iunlock(ip);
8010556d:	89 1c 24             	mov    %ebx,(%esp)
80105570:	e8 5b c7 ff ff       	call   80101cd0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105575:	58                   	pop    %eax
80105576:	5a                   	pop    %edx
80105577:	57                   	push   %edi
80105578:	ff 75 d0             	push   -0x30(%ebp)
8010557b:	e8 b0 cf ff ff       	call   80102530 <nameiparent>
80105580:	83 c4 10             	add    $0x10,%esp
80105583:	89 c6                	mov    %eax,%esi
80105585:	85 c0                	test   %eax,%eax
80105587:	74 5b                	je     801055e4 <sys_link+0xf4>
  ilock(dp);
80105589:	83 ec 0c             	sub    $0xc,%esp
8010558c:	50                   	push   %eax
8010558d:	e8 5e c6 ff ff       	call   80101bf0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105592:	8b 43 04             	mov    0x4(%ebx),%eax
80105595:	83 c4 10             	add    $0x10,%esp
80105598:	39 46 04             	cmp    %eax,0x4(%esi)
8010559b:	75 3b                	jne    801055d8 <sys_link+0xe8>
8010559d:	83 ec 04             	sub    $0x4,%esp
801055a0:	ff 73 08             	push   0x8(%ebx)
801055a3:	57                   	push   %edi
801055a4:	56                   	push   %esi
801055a5:	e8 a6 ce ff ff       	call   80102450 <dirlink>
801055aa:	83 c4 10             	add    $0x10,%esp
801055ad:	85 c0                	test   %eax,%eax
801055af:	78 27                	js     801055d8 <sys_link+0xe8>
  iunlockput(dp);
801055b1:	83 ec 0c             	sub    $0xc,%esp
801055b4:	56                   	push   %esi
801055b5:	e8 c6 c8 ff ff       	call   80101e80 <iunlockput>
  iput(ip);
801055ba:	89 1c 24             	mov    %ebx,(%esp)
801055bd:	e8 5e c7 ff ff       	call   80101d20 <iput>
  end_op();
801055c2:	e8 49 dd ff ff       	call   80103310 <end_op>
  return 0;
801055c7:	83 c4 10             	add    $0x10,%esp
801055ca:	31 c0                	xor    %eax,%eax
}
801055cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055cf:	5b                   	pop    %ebx
801055d0:	5e                   	pop    %esi
801055d1:	5f                   	pop    %edi
801055d2:	5d                   	pop    %ebp
801055d3:	c3                   	ret
801055d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(dp);
801055d8:	83 ec 0c             	sub    $0xc,%esp
801055db:	56                   	push   %esi
801055dc:	e8 9f c8 ff ff       	call   80101e80 <iunlockput>
    goto bad;
801055e1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801055e4:	83 ec 0c             	sub    $0xc,%esp
801055e7:	53                   	push   %ebx
801055e8:	e8 03 c6 ff ff       	call   80101bf0 <ilock>
  ip->nlink--;
801055ed:	66 83 6b 5a 01       	subw   $0x1,0x5a(%ebx)
  iupdate(ip);
801055f2:	89 1c 24             	mov    %ebx,(%esp)
801055f5:	e8 46 c5 ff ff       	call   80101b40 <iupdate>
  iunlockput(ip);
801055fa:	89 1c 24             	mov    %ebx,(%esp)
801055fd:	e8 7e c8 ff ff       	call   80101e80 <iunlockput>
  end_op();
80105602:	e8 09 dd ff ff       	call   80103310 <end_op>
  return -1;
80105607:	83 c4 10             	add    $0x10,%esp
    return -1;
8010560a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010560f:	eb bb                	jmp    801055cc <sys_link+0xdc>
    iunlockput(ip);
80105611:	83 ec 0c             	sub    $0xc,%esp
80105614:	53                   	push   %ebx
80105615:	e8 66 c8 ff ff       	call   80101e80 <iunlockput>
    end_op();
8010561a:	e8 f1 dc ff ff       	call   80103310 <end_op>
    return -1;
8010561f:	83 c4 10             	add    $0x10,%esp
80105622:	eb e6                	jmp    8010560a <sys_link+0x11a>
    end_op();
80105624:	e8 e7 dc ff ff       	call   80103310 <end_op>
    return -1;
80105629:	eb df                	jmp    8010560a <sys_link+0x11a>
8010562b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105630 <sys_unlink>:
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	57                   	push   %edi
80105634:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105635:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105638:	53                   	push   %ebx
80105639:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010563c:	50                   	push   %eax
8010563d:	6a 00                	push   $0x0
8010563f:	e8 ec f9 ff ff       	call   80105030 <argstr>
80105644:	83 c4 10             	add    $0x10,%esp
80105647:	85 c0                	test   %eax,%eax
80105649:	0f 88 54 01 00 00    	js     801057a3 <sys_unlink+0x173>
  begin_op();
8010564f:	e8 4c dc ff ff       	call   801032a0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105654:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105657:	83 ec 08             	sub    $0x8,%esp
8010565a:	53                   	push   %ebx
8010565b:	ff 75 c0             	push   -0x40(%ebp)
8010565e:	e8 cd ce ff ff       	call   80102530 <nameiparent>
80105663:	83 c4 10             	add    $0x10,%esp
80105666:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105669:	85 c0                	test   %eax,%eax
8010566b:	0f 84 58 01 00 00    	je     801057c9 <sys_unlink+0x199>
  ilock(dp);
80105671:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105674:	83 ec 0c             	sub    $0xc,%esp
80105677:	57                   	push   %edi
80105678:	e8 73 c5 ff ff       	call   80101bf0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010567d:	58                   	pop    %eax
8010567e:	5a                   	pop    %edx
8010567f:	68 39 84 10 80       	push   $0x80108439
80105684:	53                   	push   %ebx
80105685:	e8 a6 ca ff ff       	call   80102130 <namecmp>
8010568a:	83 c4 10             	add    $0x10,%esp
8010568d:	85 c0                	test   %eax,%eax
8010568f:	0f 84 fb 00 00 00    	je     80105790 <sys_unlink+0x160>
80105695:	83 ec 08             	sub    $0x8,%esp
80105698:	68 38 84 10 80       	push   $0x80108438
8010569d:	53                   	push   %ebx
8010569e:	e8 8d ca ff ff       	call   80102130 <namecmp>
801056a3:	83 c4 10             	add    $0x10,%esp
801056a6:	85 c0                	test   %eax,%eax
801056a8:	0f 84 e2 00 00 00    	je     80105790 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
801056ae:	83 ec 04             	sub    $0x4,%esp
801056b1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801056b4:	50                   	push   %eax
801056b5:	53                   	push   %ebx
801056b6:	57                   	push   %edi
801056b7:	e8 94 ca ff ff       	call   80102150 <dirlookup>
801056bc:	83 c4 10             	add    $0x10,%esp
801056bf:	89 c3                	mov    %eax,%ebx
801056c1:	85 c0                	test   %eax,%eax
801056c3:	0f 84 c7 00 00 00    	je     80105790 <sys_unlink+0x160>
  ilock(ip);
801056c9:	83 ec 0c             	sub    $0xc,%esp
801056cc:	50                   	push   %eax
801056cd:	e8 1e c5 ff ff       	call   80101bf0 <ilock>
  if(ip->nlink < 1)
801056d2:	83 c4 10             	add    $0x10,%esp
801056d5:	66 83 7b 5a 00       	cmpw   $0x0,0x5a(%ebx)
801056da:	0f 8e fd 00 00 00    	jle    801057dd <sys_unlink+0x1ad>
  if(ip->type == T_DIR && !isdirempty(ip)){
801056e0:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
801056e5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801056e8:	74 66                	je     80105750 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801056ea:	83 ec 04             	sub    $0x4,%esp
801056ed:	6a 10                	push   $0x10
801056ef:	6a 00                	push   $0x0
801056f1:	57                   	push   %edi
801056f2:	e8 a9 f5 ff ff       	call   80104ca0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801056f7:	6a 10                	push   $0x10
801056f9:	ff 75 c4             	push   -0x3c(%ebp)
801056fc:	57                   	push   %edi
801056fd:	ff 75 b4             	push   -0x4c(%ebp)
80105700:	e8 fb c8 ff ff       	call   80102000 <writei>
80105705:	83 c4 20             	add    $0x20,%esp
80105708:	83 f8 10             	cmp    $0x10,%eax
8010570b:	0f 85 d9 00 00 00    	jne    801057ea <sys_unlink+0x1ba>
  if(ip->type == T_DIR){
80105711:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
80105716:	0f 84 94 00 00 00    	je     801057b0 <sys_unlink+0x180>
  iunlockput(dp);
8010571c:	83 ec 0c             	sub    $0xc,%esp
8010571f:	ff 75 b4             	push   -0x4c(%ebp)
80105722:	e8 59 c7 ff ff       	call   80101e80 <iunlockput>
  ip->nlink--;
80105727:	66 83 6b 5a 01       	subw   $0x1,0x5a(%ebx)
  iupdate(ip);
8010572c:	89 1c 24             	mov    %ebx,(%esp)
8010572f:	e8 0c c4 ff ff       	call   80101b40 <iupdate>
  iunlockput(ip);
80105734:	89 1c 24             	mov    %ebx,(%esp)
80105737:	e8 44 c7 ff ff       	call   80101e80 <iunlockput>
  end_op();
8010573c:	e8 cf db ff ff       	call   80103310 <end_op>
  return 0;
80105741:	83 c4 10             	add    $0x10,%esp
80105744:	31 c0                	xor    %eax,%eax
}
80105746:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105749:	5b                   	pop    %ebx
8010574a:	5e                   	pop    %esi
8010574b:	5f                   	pop    %edi
8010574c:	5d                   	pop    %ebp
8010574d:	c3                   	ret
8010574e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105750:	83 7b 5c 20          	cmpl   $0x20,0x5c(%ebx)
80105754:	76 94                	jbe    801056ea <sys_unlink+0xba>
80105756:	be 20 00 00 00       	mov    $0x20,%esi
8010575b:	eb 0b                	jmp    80105768 <sys_unlink+0x138>
8010575d:	8d 76 00             	lea    0x0(%esi),%esi
80105760:	83 c6 10             	add    $0x10,%esi
80105763:	3b 73 5c             	cmp    0x5c(%ebx),%esi
80105766:	73 82                	jae    801056ea <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105768:	6a 10                	push   $0x10
8010576a:	56                   	push   %esi
8010576b:	57                   	push   %edi
8010576c:	53                   	push   %ebx
8010576d:	e8 8e c7 ff ff       	call   80101f00 <readi>
80105772:	83 c4 10             	add    $0x10,%esp
80105775:	83 f8 10             	cmp    $0x10,%eax
80105778:	75 56                	jne    801057d0 <sys_unlink+0x1a0>
    if(de.inum != 0)
8010577a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010577f:	74 df                	je     80105760 <sys_unlink+0x130>
    iunlockput(ip);
80105781:	83 ec 0c             	sub    $0xc,%esp
80105784:	53                   	push   %ebx
80105785:	e8 f6 c6 ff ff       	call   80101e80 <iunlockput>
    goto bad;
8010578a:	83 c4 10             	add    $0x10,%esp
8010578d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105790:	83 ec 0c             	sub    $0xc,%esp
80105793:	ff 75 b4             	push   -0x4c(%ebp)
80105796:	e8 e5 c6 ff ff       	call   80101e80 <iunlockput>
  end_op();
8010579b:	e8 70 db ff ff       	call   80103310 <end_op>
  return -1;
801057a0:	83 c4 10             	add    $0x10,%esp
    return -1;
801057a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057a8:	eb 9c                	jmp    80105746 <sys_unlink+0x116>
801057aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
801057b0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801057b3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801057b6:	66 83 68 5a 01       	subw   $0x1,0x5a(%eax)
    iupdate(dp);
801057bb:	50                   	push   %eax
801057bc:	e8 7f c3 ff ff       	call   80101b40 <iupdate>
801057c1:	83 c4 10             	add    $0x10,%esp
801057c4:	e9 53 ff ff ff       	jmp    8010571c <sys_unlink+0xec>
    end_op();
801057c9:	e8 42 db ff ff       	call   80103310 <end_op>
    return -1;
801057ce:	eb d3                	jmp    801057a3 <sys_unlink+0x173>
      panic("isdirempty: readi");
801057d0:	83 ec 0c             	sub    $0xc,%esp
801057d3:	68 5d 84 10 80       	push   $0x8010845d
801057d8:	e8 d3 ac ff ff       	call   801004b0 <panic>
    panic("unlink: nlink < 1");
801057dd:	83 ec 0c             	sub    $0xc,%esp
801057e0:	68 4b 84 10 80       	push   $0x8010844b
801057e5:	e8 c6 ac ff ff       	call   801004b0 <panic>
    panic("unlink: writei");
801057ea:	83 ec 0c             	sub    $0xc,%esp
801057ed:	68 6f 84 10 80       	push   $0x8010846f
801057f2:	e8 b9 ac ff ff       	call   801004b0 <panic>
801057f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057fe:	00 
801057ff:	90                   	nop

80105800 <sys_open>:

int
sys_open(void)
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	57                   	push   %edi
80105804:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105805:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105808:	53                   	push   %ebx
80105809:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010580c:	50                   	push   %eax
8010580d:	6a 00                	push   $0x0
8010580f:	e8 1c f8 ff ff       	call   80105030 <argstr>
80105814:	83 c4 10             	add    $0x10,%esp
80105817:	85 c0                	test   %eax,%eax
80105819:	0f 88 8e 00 00 00    	js     801058ad <sys_open+0xad>
8010581f:	83 ec 08             	sub    $0x8,%esp
80105822:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105825:	50                   	push   %eax
80105826:	6a 01                	push   $0x1
80105828:	e8 43 f7 ff ff       	call   80104f70 <argint>
8010582d:	83 c4 10             	add    $0x10,%esp
80105830:	85 c0                	test   %eax,%eax
80105832:	78 79                	js     801058ad <sys_open+0xad>
    return -1;

  begin_op();
80105834:	e8 67 da ff ff       	call   801032a0 <begin_op>

  if(omode & O_CREATE){
    ip = create(path, T_FILE, 0, 0);
80105839:	8b 45 e0             	mov    -0x20(%ebp),%eax
  if(omode & O_CREATE){
8010583c:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105840:	75 76                	jne    801058b8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105842:	83 ec 0c             	sub    $0xc,%esp
80105845:	50                   	push   %eax
80105846:	e8 c5 cc ff ff       	call   80102510 <namei>
8010584b:	83 c4 10             	add    $0x10,%esp
8010584e:	89 c6                	mov    %eax,%esi
80105850:	85 c0                	test   %eax,%eax
80105852:	74 7e                	je     801058d2 <sys_open+0xd2>
      end_op();
      return -1;
    }
    ilock(ip);
80105854:	83 ec 0c             	sub    $0xc,%esp
80105857:	50                   	push   %eax
80105858:	e8 93 c3 ff ff       	call   80101bf0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010585d:	83 c4 10             	add    $0x10,%esp
80105860:	66 83 7e 54 01       	cmpw   $0x1,0x54(%esi)
80105865:	0f 84 bd 00 00 00    	je     80105928 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010586b:	e8 e0 b8 ff ff       	call   80101150 <filealloc>
80105870:	89 c7                	mov    %eax,%edi
80105872:	85 c0                	test   %eax,%eax
80105874:	74 26                	je     8010589c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105876:	e8 c5 e6 ff ff       	call   80103f40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010587b:	31 db                	xor    %ebx,%ebx
8010587d:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80105880:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105884:	85 d2                	test   %edx,%edx
80105886:	74 58                	je     801058e0 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105888:	83 c3 01             	add    $0x1,%ebx
8010588b:	83 fb 10             	cmp    $0x10,%ebx
8010588e:	75 f0                	jne    80105880 <sys_open+0x80>
    if(f)
      fileclose(f);
80105890:	83 ec 0c             	sub    $0xc,%esp
80105893:	57                   	push   %edi
80105894:	e8 87 b9 ff ff       	call   80101220 <fileclose>
80105899:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010589c:	83 ec 0c             	sub    $0xc,%esp
8010589f:	56                   	push   %esi
801058a0:	e8 db c5 ff ff       	call   80101e80 <iunlockput>
    end_op();
801058a5:	e8 66 da ff ff       	call   80103310 <end_op>
    return -1;
801058aa:	83 c4 10             	add    $0x10,%esp
    return -1;
801058ad:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801058b2:	eb 65                	jmp    80105919 <sys_open+0x119>
801058b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801058b8:	83 ec 0c             	sub    $0xc,%esp
801058bb:	31 c9                	xor    %ecx,%ecx
801058bd:	ba 02 00 00 00       	mov    $0x2,%edx
801058c2:	6a 00                	push   $0x0
801058c4:	e8 57 f8 ff ff       	call   80105120 <create>
    if(ip == 0){
801058c9:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801058cc:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801058ce:	85 c0                	test   %eax,%eax
801058d0:	75 99                	jne    8010586b <sys_open+0x6b>
      end_op();
801058d2:	e8 39 da ff ff       	call   80103310 <end_op>
      return -1;
801058d7:	eb d4                	jmp    801058ad <sys_open+0xad>
801058d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801058e0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801058e3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801058e7:	56                   	push   %esi
801058e8:	e8 e3 c3 ff ff       	call   80101cd0 <iunlock>
  end_op();
801058ed:	e8 1e da ff ff       	call   80103310 <end_op>

  f->type = FD_INODE;
801058f2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801058f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801058fb:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801058fe:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105901:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105903:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010590a:	f7 d0                	not    %eax
8010590c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010590f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105912:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105915:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105919:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010591c:	89 d8                	mov    %ebx,%eax
8010591e:	5b                   	pop    %ebx
8010591f:	5e                   	pop    %esi
80105920:	5f                   	pop    %edi
80105921:	5d                   	pop    %ebp
80105922:	c3                   	ret
80105923:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105928:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010592b:	85 c9                	test   %ecx,%ecx
8010592d:	0f 84 38 ff ff ff    	je     8010586b <sys_open+0x6b>
80105933:	e9 64 ff ff ff       	jmp    8010589c <sys_open+0x9c>
80105938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010593f:	00 

80105940 <sys_mkdir>:

int
sys_mkdir(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105946:	e8 55 d9 ff ff       	call   801032a0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010594b:	83 ec 08             	sub    $0x8,%esp
8010594e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105951:	50                   	push   %eax
80105952:	6a 00                	push   $0x0
80105954:	e8 d7 f6 ff ff       	call   80105030 <argstr>
80105959:	83 c4 10             	add    $0x10,%esp
8010595c:	85 c0                	test   %eax,%eax
8010595e:	78 30                	js     80105990 <sys_mkdir+0x50>
80105960:	83 ec 0c             	sub    $0xc,%esp
80105963:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105966:	31 c9                	xor    %ecx,%ecx
80105968:	ba 01 00 00 00       	mov    $0x1,%edx
8010596d:	6a 00                	push   $0x0
8010596f:	e8 ac f7 ff ff       	call   80105120 <create>
80105974:	83 c4 10             	add    $0x10,%esp
80105977:	85 c0                	test   %eax,%eax
80105979:	74 15                	je     80105990 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010597b:	83 ec 0c             	sub    $0xc,%esp
8010597e:	50                   	push   %eax
8010597f:	e8 fc c4 ff ff       	call   80101e80 <iunlockput>
  end_op();
80105984:	e8 87 d9 ff ff       	call   80103310 <end_op>
  return 0;
80105989:	83 c4 10             	add    $0x10,%esp
8010598c:	31 c0                	xor    %eax,%eax
}
8010598e:	c9                   	leave
8010598f:	c3                   	ret
    end_op();
80105990:	e8 7b d9 ff ff       	call   80103310 <end_op>
    return -1;
80105995:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010599a:	c9                   	leave
8010599b:	c3                   	ret
8010599c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059a0 <sys_mknod>:

int
sys_mknod(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801059a6:	e8 f5 d8 ff ff       	call   801032a0 <begin_op>
  if((argstr(0, &path)) < 0 ||
801059ab:	83 ec 08             	sub    $0x8,%esp
801059ae:	8d 45 ec             	lea    -0x14(%ebp),%eax
801059b1:	50                   	push   %eax
801059b2:	6a 00                	push   $0x0
801059b4:	e8 77 f6 ff ff       	call   80105030 <argstr>
801059b9:	83 c4 10             	add    $0x10,%esp
801059bc:	85 c0                	test   %eax,%eax
801059be:	78 60                	js     80105a20 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801059c0:	83 ec 08             	sub    $0x8,%esp
801059c3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059c6:	50                   	push   %eax
801059c7:	6a 01                	push   $0x1
801059c9:	e8 a2 f5 ff ff       	call   80104f70 <argint>
  if((argstr(0, &path)) < 0 ||
801059ce:	83 c4 10             	add    $0x10,%esp
801059d1:	85 c0                	test   %eax,%eax
801059d3:	78 4b                	js     80105a20 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801059d5:	83 ec 08             	sub    $0x8,%esp
801059d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059db:	50                   	push   %eax
801059dc:	6a 02                	push   $0x2
801059de:	e8 8d f5 ff ff       	call   80104f70 <argint>
     argint(1, &major) < 0 ||
801059e3:	83 c4 10             	add    $0x10,%esp
801059e6:	85 c0                	test   %eax,%eax
801059e8:	78 36                	js     80105a20 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801059ea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801059ee:	83 ec 0c             	sub    $0xc,%esp
801059f1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801059f5:	ba 03 00 00 00       	mov    $0x3,%edx
801059fa:	50                   	push   %eax
801059fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801059fe:	e8 1d f7 ff ff       	call   80105120 <create>
     argint(2, &minor) < 0 ||
80105a03:	83 c4 10             	add    $0x10,%esp
80105a06:	85 c0                	test   %eax,%eax
80105a08:	74 16                	je     80105a20 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a0a:	83 ec 0c             	sub    $0xc,%esp
80105a0d:	50                   	push   %eax
80105a0e:	e8 6d c4 ff ff       	call   80101e80 <iunlockput>
  end_op();
80105a13:	e8 f8 d8 ff ff       	call   80103310 <end_op>
  return 0;
80105a18:	83 c4 10             	add    $0x10,%esp
80105a1b:	31 c0                	xor    %eax,%eax
}
80105a1d:	c9                   	leave
80105a1e:	c3                   	ret
80105a1f:	90                   	nop
    end_op();
80105a20:	e8 eb d8 ff ff       	call   80103310 <end_op>
    return -1;
80105a25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a2a:	c9                   	leave
80105a2b:	c3                   	ret
80105a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a30 <sys_chdir>:

int
sys_chdir(void)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	56                   	push   %esi
80105a34:	53                   	push   %ebx
80105a35:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105a38:	e8 03 e5 ff ff       	call   80103f40 <myproc>
80105a3d:	89 c6                	mov    %eax,%esi

  begin_op();
80105a3f:	e8 5c d8 ff ff       	call   801032a0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105a44:	83 ec 08             	sub    $0x8,%esp
80105a47:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a4a:	50                   	push   %eax
80105a4b:	6a 00                	push   $0x0
80105a4d:	e8 de f5 ff ff       	call   80105030 <argstr>
80105a52:	83 c4 10             	add    $0x10,%esp
80105a55:	85 c0                	test   %eax,%eax
80105a57:	78 77                	js     80105ad0 <sys_chdir+0xa0>
80105a59:	83 ec 0c             	sub    $0xc,%esp
80105a5c:	ff 75 f4             	push   -0xc(%ebp)
80105a5f:	e8 ac ca ff ff       	call   80102510 <namei>
80105a64:	83 c4 10             	add    $0x10,%esp
80105a67:	89 c3                	mov    %eax,%ebx
80105a69:	85 c0                	test   %eax,%eax
80105a6b:	74 63                	je     80105ad0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105a6d:	83 ec 0c             	sub    $0xc,%esp
80105a70:	50                   	push   %eax
80105a71:	e8 7a c1 ff ff       	call   80101bf0 <ilock>
  if(ip->type != T_DIR){
80105a76:	83 c4 10             	add    $0x10,%esp
80105a79:	66 83 7b 54 01       	cmpw   $0x1,0x54(%ebx)
80105a7e:	75 30                	jne    80105ab0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105a80:	83 ec 0c             	sub    $0xc,%esp
80105a83:	53                   	push   %ebx
80105a84:	e8 47 c2 ff ff       	call   80101cd0 <iunlock>
  iput(curproc->cwd);
80105a89:	58                   	pop    %eax
80105a8a:	ff 76 68             	push   0x68(%esi)
80105a8d:	e8 8e c2 ff ff       	call   80101d20 <iput>
  end_op();
80105a92:	e8 79 d8 ff ff       	call   80103310 <end_op>
  curproc->cwd = ip;
80105a97:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105a9a:	83 c4 10             	add    $0x10,%esp
80105a9d:	31 c0                	xor    %eax,%eax
}
80105a9f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105aa2:	5b                   	pop    %ebx
80105aa3:	5e                   	pop    %esi
80105aa4:	5d                   	pop    %ebp
80105aa5:	c3                   	ret
80105aa6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105aad:	00 
80105aae:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105ab0:	83 ec 0c             	sub    $0xc,%esp
80105ab3:	53                   	push   %ebx
80105ab4:	e8 c7 c3 ff ff       	call   80101e80 <iunlockput>
    end_op();
80105ab9:	e8 52 d8 ff ff       	call   80103310 <end_op>
    return -1;
80105abe:	83 c4 10             	add    $0x10,%esp
    return -1;
80105ac1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ac6:	eb d7                	jmp    80105a9f <sys_chdir+0x6f>
80105ac8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105acf:	00 
    end_op();
80105ad0:	e8 3b d8 ff ff       	call   80103310 <end_op>
    return -1;
80105ad5:	eb ea                	jmp    80105ac1 <sys_chdir+0x91>
80105ad7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ade:	00 
80105adf:	90                   	nop

80105ae0 <sys_exec>:

int
sys_exec(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	57                   	push   %edi
80105ae4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105ae5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105aeb:	53                   	push   %ebx
80105aec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105af2:	50                   	push   %eax
80105af3:	6a 00                	push   $0x0
80105af5:	e8 36 f5 ff ff       	call   80105030 <argstr>
80105afa:	83 c4 10             	add    $0x10,%esp
80105afd:	85 c0                	test   %eax,%eax
80105aff:	0f 88 87 00 00 00    	js     80105b8c <sys_exec+0xac>
80105b05:	83 ec 08             	sub    $0x8,%esp
80105b08:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105b0e:	50                   	push   %eax
80105b0f:	6a 01                	push   $0x1
80105b11:	e8 5a f4 ff ff       	call   80104f70 <argint>
80105b16:	83 c4 10             	add    $0x10,%esp
80105b19:	85 c0                	test   %eax,%eax
80105b1b:	78 6f                	js     80105b8c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105b1d:	83 ec 04             	sub    $0x4,%esp
80105b20:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105b26:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105b28:	68 80 00 00 00       	push   $0x80
80105b2d:	6a 00                	push   $0x0
80105b2f:	56                   	push   %esi
80105b30:	e8 6b f1 ff ff       	call   80104ca0 <memset>
80105b35:	83 c4 10             	add    $0x10,%esp
80105b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b3f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105b40:	83 ec 08             	sub    $0x8,%esp
80105b43:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105b49:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105b50:	50                   	push   %eax
80105b51:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105b57:	01 f8                	add    %edi,%eax
80105b59:	50                   	push   %eax
80105b5a:	e8 71 f3 ff ff       	call   80104ed0 <fetchint>
80105b5f:	83 c4 10             	add    $0x10,%esp
80105b62:	85 c0                	test   %eax,%eax
80105b64:	78 26                	js     80105b8c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105b66:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105b6c:	85 c0                	test   %eax,%eax
80105b6e:	74 30                	je     80105ba0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105b70:	83 ec 08             	sub    $0x8,%esp
80105b73:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105b76:	52                   	push   %edx
80105b77:	50                   	push   %eax
80105b78:	e8 93 f3 ff ff       	call   80104f10 <fetchstr>
80105b7d:	83 c4 10             	add    $0x10,%esp
80105b80:	85 c0                	test   %eax,%eax
80105b82:	78 08                	js     80105b8c <sys_exec+0xac>
  for(i=0;; i++){
80105b84:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105b87:	83 fb 20             	cmp    $0x20,%ebx
80105b8a:	75 b4                	jne    80105b40 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105b8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105b8f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105b94:	5b                   	pop    %ebx
80105b95:	5e                   	pop    %esi
80105b96:	5f                   	pop    %edi
80105b97:	5d                   	pop    %ebp
80105b98:	c3                   	ret
80105b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105ba0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105ba7:	00 00 00 00 
  return exec(path, argv);
80105bab:	83 ec 08             	sub    $0x8,%esp
80105bae:	56                   	push   %esi
80105baf:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105bb5:	e8 a6 b0 ff ff       	call   80100c60 <exec>
80105bba:	83 c4 10             	add    $0x10,%esp
}
80105bbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bc0:	5b                   	pop    %ebx
80105bc1:	5e                   	pop    %esi
80105bc2:	5f                   	pop    %edi
80105bc3:	5d                   	pop    %ebp
80105bc4:	c3                   	ret
80105bc5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105bcc:	00 
80105bcd:	8d 76 00             	lea    0x0(%esi),%esi

80105bd0 <sys_pipe>:

int
sys_pipe(void)
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	57                   	push   %edi
80105bd4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105bd5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105bd8:	53                   	push   %ebx
80105bd9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105bdc:	6a 08                	push   $0x8
80105bde:	50                   	push   %eax
80105bdf:	6a 00                	push   $0x0
80105be1:	e8 da f3 ff ff       	call   80104fc0 <argptr>
80105be6:	83 c4 10             	add    $0x10,%esp
80105be9:	85 c0                	test   %eax,%eax
80105beb:	0f 88 93 00 00 00    	js     80105c84 <sys_pipe+0xb4>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105bf1:	83 ec 08             	sub    $0x8,%esp
80105bf4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105bf7:	50                   	push   %eax
80105bf8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105bfb:	50                   	push   %eax
80105bfc:	e8 bf dd ff ff       	call   801039c0 <pipealloc>
80105c01:	83 c4 10             	add    $0x10,%esp
80105c04:	85 c0                	test   %eax,%eax
80105c06:	78 7c                	js     80105c84 <sys_pipe+0xb4>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c08:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105c0b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105c0d:	e8 2e e3 ff ff       	call   80103f40 <myproc>
    if(curproc->ofile[fd] == 0){
80105c12:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105c16:	85 f6                	test   %esi,%esi
80105c18:	74 16                	je     80105c30 <sys_pipe+0x60>
80105c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105c20:	83 c3 01             	add    $0x1,%ebx
80105c23:	83 fb 10             	cmp    $0x10,%ebx
80105c26:	74 45                	je     80105c6d <sys_pipe+0x9d>
    if(curproc->ofile[fd] == 0){
80105c28:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105c2c:	85 f6                	test   %esi,%esi
80105c2e:	75 f0                	jne    80105c20 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105c30:	8d 73 08             	lea    0x8(%ebx),%esi
80105c33:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c37:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105c3a:	e8 01 e3 ff ff       	call   80103f40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105c3f:	31 d2                	xor    %edx,%edx
80105c41:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c48:	00 
80105c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105c50:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105c54:	85 c9                	test   %ecx,%ecx
80105c56:	74 38                	je     80105c90 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80105c58:	83 c2 01             	add    $0x1,%edx
80105c5b:	83 fa 10             	cmp    $0x10,%edx
80105c5e:	75 f0                	jne    80105c50 <sys_pipe+0x80>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105c60:	e8 db e2 ff ff       	call   80103f40 <myproc>
80105c65:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105c6c:	00 
    fileclose(rf);
80105c6d:	83 ec 0c             	sub    $0xc,%esp
80105c70:	ff 75 e0             	push   -0x20(%ebp)
80105c73:	e8 a8 b5 ff ff       	call   80101220 <fileclose>
    fileclose(wf);
80105c78:	58                   	pop    %eax
80105c79:	ff 75 e4             	push   -0x1c(%ebp)
80105c7c:	e8 9f b5 ff ff       	call   80101220 <fileclose>
    return -1;
80105c81:	83 c4 10             	add    $0x10,%esp
    return -1;
80105c84:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c89:	eb 16                	jmp    80105ca1 <sys_pipe+0xd1>
80105c8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105c90:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105c94:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105c97:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105c99:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105c9c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105c9f:	31 c0                	xor    %eax,%eax
}
80105ca1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ca4:	5b                   	pop    %ebx
80105ca5:	5e                   	pop    %esi
80105ca6:	5f                   	pop    %edi
80105ca7:	5d                   	pop    %ebp
80105ca8:	c3                   	ret
80105ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cb0 <sys_bstat>:
int
sys_bstat(void)
{
  //************xv7************
	return numallocblocks;
}
80105cb0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80105cb5:	c3                   	ret
80105cb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cbd:	00 
80105cbe:	66 90                	xchg   %ax,%ax

80105cc0 <sys_swap>:
 */

 //*************xv7************
int
sys_swap(void)
{
80105cc0:	55                   	push   %ebp
80105cc1:	89 e5                	mov    %esp,%ebp
80105cc3:	57                   	push   %edi
80105cc4:	56                   	push   %esi
  uint addr;

  if(argint(0, (int*)&addr) < 0)
80105cc5:	8d 45 e4             	lea    -0x1c(%ebp),%eax
{
80105cc8:	53                   	push   %ebx
80105cc9:	83 ec 24             	sub    $0x24,%esp
  if(argint(0, (int*)&addr) < 0)
80105ccc:	50                   	push   %eax
80105ccd:	6a 00                	push   $0x0
80105ccf:	e8 9c f2 ff ff       	call   80104f70 <argint>
80105cd4:	83 c4 10             	add    $0x10,%esp
80105cd7:	85 c0                	test   %eax,%eax
80105cd9:	0f 88 91 00 00 00    	js     80105d70 <sys_swap+0xb0>
    return -1;
  // swap addr
  struct proc *currentProcess=myproc();
80105cdf:	e8 5c e2 ff ff       	call   80103f40 <myproc>
  pde_t *pgdir=currentProcess->pgdir;
  pte_t *pte=walkpgdir(pgdir,(char*)addr,1);
80105ce4:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  pde = &pgdir[PDX(va)];
80105ce7:	8b 40 04             	mov    0x4(%eax),%eax
80105cea:	89 f2                	mov    %esi,%edx
80105cec:	c1 ea 16             	shr    $0x16,%edx
80105cef:	8d 3c 90             	lea    (%eax,%edx,4),%edi
  if(*pde & PTE_P){
80105cf2:	8b 1f                	mov    (%edi),%ebx
80105cf4:	f6 c3 01             	test   $0x1,%bl
80105cf7:	75 4f                	jne    80105d48 <sys_swap+0x88>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80105cf9:	e8 52 ce ff ff       	call   80102b50 <kalloc>
80105cfe:	89 c3                	mov    %eax,%ebx
80105d00:	85 c0                	test   %eax,%eax
80105d02:	0f 84 6f 00 00 00    	je     80105d77 <sys_swap.cold>
    memset(pgtab, 0, PGSIZE);
80105d08:	83 ec 04             	sub    $0x4,%esp
80105d0b:	68 00 10 00 00       	push   $0x1000
80105d10:	6a 00                	push   $0x0
80105d12:	50                   	push   %eax
80105d13:	e8 88 ef ff ff       	call   80104ca0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80105d18:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80105d1e:	83 c4 10             	add    $0x10,%esp
80105d21:	83 c8 07             	or     $0x7,%eax
80105d24:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80105d26:	89 f0                	mov    %esi,%eax
80105d28:	c1 e8 0a             	shr    $0xa,%eax
80105d2b:	25 fc 0f 00 00       	and    $0xffc,%eax
80105d30:	01 c3                	add    %eax,%ebx
  if(*pte & PTE_P){
80105d32:	f6 03 01             	testb  $0x1,(%ebx)
80105d35:	75 29                	jne    80105d60 <sys_swap+0xa0>
    swap_page_from_pte(pte);
  }

  return 0;
80105d37:	31 c0                	xor    %eax,%eax
}
80105d39:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d3c:	5b                   	pop    %ebx
80105d3d:	5e                   	pop    %esi
80105d3e:	5f                   	pop    %edi
80105d3f:	5d                   	pop    %ebp
80105d40:	c3                   	ret
80105d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80105d48:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80105d4e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80105d54:	eb d0                	jmp    80105d26 <sys_swap+0x66>
80105d56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d5d:	00 
80105d5e:	66 90                	xchg   %ax,%ax
    swap_page_from_pte(pte);
80105d60:	83 ec 0c             	sub    $0xc,%esp
80105d63:	53                   	push   %ebx
80105d64:	e8 e7 06 00 00       	call   80106450 <swap_page_from_pte>
80105d69:	83 c4 10             	add    $0x10,%esp
80105d6c:	eb c9                	jmp    80105d37 <sys_swap+0x77>
80105d6e:	66 90                	xchg   %ax,%ax
    return -1;
80105d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d75:	eb c2                	jmp    80105d39 <sys_swap+0x79>

80105d77 <sys_swap.cold>:
  if(*pte & PTE_P){
80105d77:	a1 00 00 00 00       	mov    0x0,%eax
80105d7c:	0f 0b                	ud2
80105d7e:	66 90                	xchg   %ax,%ax

80105d80 <sys_echo>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_echo(void) {
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	83 ec 20             	sub    $0x20,%esp
  int enable;
  if (argint(0, &enable) < 0) return -1;
80105d86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d89:	50                   	push   %eax
80105d8a:	6a 00                	push   $0x0
80105d8c:	e8 df f1 ff ff       	call   80104f70 <argint>
80105d91:	83 c4 10             	add    $0x10,%esp
80105d94:	85 c0                	test   %eax,%eax
80105d96:	78 18                	js     80105db0 <sys_echo+0x30>
  console_echo(enable); // Defined in console.c
80105d98:	83 ec 0c             	sub    $0xc,%esp
80105d9b:	ff 75 f4             	push   -0xc(%ebp)
80105d9e:	e8 dd a6 ff ff       	call   80100480 <console_echo>
  return 0;
80105da3:	83 c4 10             	add    $0x10,%esp
80105da6:	31 c0                	xor    %eax,%eax
}
80105da8:	c9                   	leave
80105da9:	c3                   	ret
80105daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105db0:	c9                   	leave
  if (argint(0, &enable) < 0) return -1;
80105db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105db6:	c3                   	ret
80105db7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105dbe:	00 
80105dbf:	90                   	nop

80105dc0 <sys_uname>:

int sys_uname(void) {
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	53                   	push   %ebx
  struct utsname *u;
  char *addr;

  // Get the user-space pointer argument
  if(argptr(0, &addr, sizeof(*u)) < 0)
80105dc4:	8d 45 f4             	lea    -0xc(%ebp),%eax
int sys_uname(void) {
80105dc7:	83 ec 18             	sub    $0x18,%esp
  if(argptr(0, &addr, sizeof(*u)) < 0)
80105dca:	68 45 01 00 00       	push   $0x145
80105dcf:	50                   	push   %eax
80105dd0:	6a 00                	push   $0x0
80105dd2:	e8 e9 f1 ff ff       	call   80104fc0 <argptr>
80105dd7:	83 c4 10             	add    $0x10,%esp
80105dda:	85 c0                	test   %eax,%eax
80105ddc:	78 72                	js     80105e50 <sys_uname+0x90>
    return -1;
  u = (struct utsname *)addr;
80105dde:	8b 5d f4             	mov    -0xc(%ebp),%ebx

  // Copy strings to user space
  safestrcpy(u->sysname, "Sugar/Unix", sizeof(u->sysname));
80105de1:	83 ec 04             	sub    $0x4,%esp
80105de4:	6a 41                	push   $0x41
80105de6:	68 7e 84 10 80       	push   $0x8010847e
80105deb:	53                   	push   %ebx
80105dec:	e8 6f f0 ff ff       	call   80104e60 <safestrcpy>
  safestrcpy(u->nodename, "localhost", sizeof(u->nodename)); // TODO: Make this use hostname.
80105df1:	83 c4 0c             	add    $0xc,%esp
80105df4:	8d 43 41             	lea    0x41(%ebx),%eax
80105df7:	6a 41                	push   $0x41
80105df9:	68 89 84 10 80       	push   $0x80108489
80105dfe:	50                   	push   %eax
80105dff:	e8 5c f0 ff ff       	call   80104e60 <safestrcpy>
  safestrcpy(u->release, "0.11-RELEASE", sizeof(u->release));
80105e04:	83 c4 0c             	add    $0xc,%esp
80105e07:	8d 83 82 00 00 00    	lea    0x82(%ebx),%eax
80105e0d:	6a 41                	push   $0x41
80105e0f:	68 93 84 10 80       	push   $0x80108493
80105e14:	50                   	push   %eax
80105e15:	e8 46 f0 ff ff       	call   80104e60 <safestrcpy>
  safestrcpy(u->version, "Sugar/Unix (Codename ALFA)", sizeof(u->version));
80105e1a:	83 c4 0c             	add    $0xc,%esp
80105e1d:	8d 83 c3 00 00 00    	lea    0xc3(%ebx),%eax
  safestrcpy(u->machine, "i386", sizeof(u->machine));
80105e23:	81 c3 04 01 00 00    	add    $0x104,%ebx
  safestrcpy(u->version, "Sugar/Unix (Codename ALFA)", sizeof(u->version));
80105e29:	6a 41                	push   $0x41
80105e2b:	68 a0 84 10 80       	push   $0x801084a0
80105e30:	50                   	push   %eax
80105e31:	e8 2a f0 ff ff       	call   80104e60 <safestrcpy>
  safestrcpy(u->machine, "i386", sizeof(u->machine));
80105e36:	83 c4 0c             	add    $0xc,%esp
80105e39:	6a 41                	push   $0x41
80105e3b:	68 bb 84 10 80       	push   $0x801084bb
80105e40:	53                   	push   %ebx
80105e41:	e8 1a f0 ff ff       	call   80104e60 <safestrcpy>

  return 0;
80105e46:	83 c4 10             	add    $0x10,%esp
80105e49:	31 c0                	xor    %eax,%eax
}
80105e4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e4e:	c9                   	leave
80105e4f:	c3                   	ret
    return -1;
80105e50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e55:	eb f4                	jmp    80105e4b <sys_uname+0x8b>
80105e57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e5e:	00 
80105e5f:	90                   	nop

80105e60 <sys_setcursor>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e60:	b8 0f 00 00 00       	mov    $0xf,%eax
80105e65:	ba d4 03 00 00       	mov    $0x3d4,%edx
80105e6a:	ee                   	out    %al,(%dx)
80105e6b:	31 c9                	xor    %ecx,%ecx
80105e6d:	ba d5 03 00 00       	mov    $0x3d5,%edx
80105e72:	89 c8                	mov    %ecx,%eax
80105e74:	ee                   	out    %al,(%dx)
80105e75:	b8 0e 00 00 00       	mov    $0xe,%eax
80105e7a:	ba d4 03 00 00       	mov    $0x3d4,%edx
80105e7f:	ee                   	out    %al,(%dx)
80105e80:	ba d5 03 00 00       	mov    $0x3d5,%edx
80105e85:	89 c8                	mov    %ecx,%eax
80105e87:	ee                   	out    %al,(%dx)
  // Set cursor to (0,0) via VGA ports
  outb(0x3D4, 0x0F);
  outb(0x3D5, 0x00);
  outb(0x3D4, 0x0E);
  outb(0x3D5, 0x00);
}
80105e88:	c3                   	ret
80105e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e90 <sys_fork>:

int
sys_fork(void)
{
  return fork();
80105e90:	e9 2b e2 ff ff       	jmp    801040c0 <fork>
80105e95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e9c:	00 
80105e9d:	8d 76 00             	lea    0x0(%esi),%esi

80105ea0 <sys_exit>:
}

int
sys_exit(void)
{
80105ea0:	55                   	push   %ebp
80105ea1:	89 e5                	mov    %esp,%ebp
80105ea3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105ea6:	e8 85 e4 ff ff       	call   80104330 <exit>
  return 0;  // not reached
}
80105eab:	31 c0                	xor    %eax,%eax
80105ead:	c9                   	leave
80105eae:	c3                   	ret
80105eaf:	90                   	nop

80105eb0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105eb0:	e9 bb e5 ff ff       	jmp    80104470 <wait>
80105eb5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ebc:	00 
80105ebd:	8d 76 00             	lea    0x0(%esi),%esi

80105ec0 <sys_kill>:
}

int
sys_kill(void)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105ec6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ec9:	50                   	push   %eax
80105eca:	6a 00                	push   $0x0
80105ecc:	e8 9f f0 ff ff       	call   80104f70 <argint>
80105ed1:	83 c4 10             	add    $0x10,%esp
80105ed4:	85 c0                	test   %eax,%eax
80105ed6:	78 18                	js     80105ef0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105ed8:	83 ec 0c             	sub    $0xc,%esp
80105edb:	ff 75 f4             	push   -0xc(%ebp)
80105ede:	e8 3d e8 ff ff       	call   80104720 <kill>
80105ee3:	83 c4 10             	add    $0x10,%esp
}
80105ee6:	c9                   	leave
80105ee7:	c3                   	ret
80105ee8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105eef:	00 
80105ef0:	c9                   	leave
    return -1;
80105ef1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ef6:	c3                   	ret
80105ef7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105efe:	00 
80105eff:	90                   	nop

80105f00 <sys_getpid>:

int
sys_getpid(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105f06:	e8 35 e0 ff ff       	call   80103f40 <myproc>
80105f0b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105f0e:	c9                   	leave
80105f0f:	c3                   	ret

80105f10 <sys_sbrk>:

int
sys_sbrk(void)
{
80105f10:	55                   	push   %ebp
80105f11:	89 e5                	mov    %esp,%ebp
80105f13:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105f14:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f17:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105f1a:	50                   	push   %eax
80105f1b:	6a 00                	push   $0x0
80105f1d:	e8 4e f0 ff ff       	call   80104f70 <argint>
80105f22:	83 c4 10             	add    $0x10,%esp
80105f25:	85 c0                	test   %eax,%eax
80105f27:	78 27                	js     80105f50 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105f29:	e8 12 e0 ff ff       	call   80103f40 <myproc>
  if(growproc(n) < 0)
80105f2e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105f31:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105f33:	ff 75 f4             	push   -0xc(%ebp)
80105f36:	e8 35 e1 ff ff       	call   80104070 <growproc>
80105f3b:	83 c4 10             	add    $0x10,%esp
80105f3e:	85 c0                	test   %eax,%eax
80105f40:	78 0e                	js     80105f50 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105f42:	89 d8                	mov    %ebx,%eax
80105f44:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f47:	c9                   	leave
80105f48:	c3                   	ret
80105f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f50:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105f55:	eb eb                	jmp    80105f42 <sys_sbrk+0x32>
80105f57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f5e:	00 
80105f5f:	90                   	nop

80105f60 <sys_sleep>:

int
sys_sleep(void)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105f64:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f67:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105f6a:	50                   	push   %eax
80105f6b:	6a 00                	push   $0x0
80105f6d:	e8 fe ef ff ff       	call   80104f70 <argint>
80105f72:	83 c4 10             	add    $0x10,%esp
80105f75:	85 c0                	test   %eax,%eax
80105f77:	78 64                	js     80105fdd <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105f79:	83 ec 0c             	sub    $0xc,%esp
80105f7c:	68 40 4d 11 80       	push   $0x80114d40
80105f81:	e8 4a eb ff ff       	call   80104ad0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105f86:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105f89:	8b 1d 20 4d 11 80    	mov    0x80114d20,%ebx
  while(ticks - ticks0 < n){
80105f8f:	83 c4 10             	add    $0x10,%esp
80105f92:	85 d2                	test   %edx,%edx
80105f94:	75 2b                	jne    80105fc1 <sys_sleep+0x61>
80105f96:	eb 50                	jmp    80105fe8 <sys_sleep+0x88>
80105f98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f9f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105fa0:	83 ec 08             	sub    $0x8,%esp
80105fa3:	68 40 4d 11 80       	push   $0x80114d40
80105fa8:	68 20 4d 11 80       	push   $0x80114d20
80105fad:	e8 4e e6 ff ff       	call   80104600 <sleep>
  while(ticks - ticks0 < n){
80105fb2:	a1 20 4d 11 80       	mov    0x80114d20,%eax
80105fb7:	83 c4 10             	add    $0x10,%esp
80105fba:	29 d8                	sub    %ebx,%eax
80105fbc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105fbf:	73 27                	jae    80105fe8 <sys_sleep+0x88>
    if(myproc()->killed){
80105fc1:	e8 7a df ff ff       	call   80103f40 <myproc>
80105fc6:	8b 40 24             	mov    0x24(%eax),%eax
80105fc9:	85 c0                	test   %eax,%eax
80105fcb:	74 d3                	je     80105fa0 <sys_sleep+0x40>
      release(&tickslock);
80105fcd:	83 ec 0c             	sub    $0xc,%esp
80105fd0:	68 40 4d 11 80       	push   $0x80114d40
80105fd5:	e8 76 ec ff ff       	call   80104c50 <release>
      return -1;
80105fda:	83 c4 10             	add    $0x10,%esp
    return -1;
80105fdd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fe2:	eb 16                	jmp    80105ffa <sys_sleep+0x9a>
80105fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  release(&tickslock);
80105fe8:	83 ec 0c             	sub    $0xc,%esp
80105feb:	68 40 4d 11 80       	push   $0x80114d40
80105ff0:	e8 5b ec ff ff       	call   80104c50 <release>
  return 0;
80105ff5:	83 c4 10             	add    $0x10,%esp
80105ff8:	31 c0                	xor    %eax,%eax
}
80105ffa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ffd:	c9                   	leave
80105ffe:	c3                   	ret
80105fff:	90                   	nop

80106000 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106000:	55                   	push   %ebp
80106001:	89 e5                	mov    %esp,%ebp
80106003:	53                   	push   %ebx
80106004:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106007:	68 40 4d 11 80       	push   $0x80114d40
8010600c:	e8 bf ea ff ff       	call   80104ad0 <acquire>
  xticks = ticks;
80106011:	8b 1d 20 4d 11 80    	mov    0x80114d20,%ebx
  release(&tickslock);
80106017:	c7 04 24 40 4d 11 80 	movl   $0x80114d40,(%esp)
8010601e:	e8 2d ec ff ff       	call   80104c50 <release>
  return xticks;
}
80106023:	89 d8                	mov    %ebx,%eax
80106025:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106028:	c9                   	leave
80106029:	c3                   	ret

8010602a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010602a:	1e                   	push   %ds
  pushl %es
8010602b:	06                   	push   %es
  pushl %fs
8010602c:	0f a0                	push   %fs
  pushl %gs
8010602e:	0f a8                	push   %gs
  pushal
80106030:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106031:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106035:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106037:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106039:	54                   	push   %esp
  call trap
8010603a:	e8 21 01 00 00       	call   80106160 <trap>
  addl $4, %esp
8010603f:	83 c4 04             	add    $0x4,%esp

80106042 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106042:	61                   	popa
  popl %gs
80106043:	0f a9                	pop    %gs
  popl %fs
80106045:	0f a1                	pop    %fs
  popl %es
80106047:	07                   	pop    %es
  popl %ds
80106048:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106049:	83 c4 08             	add    $0x8,%esp
  iret
8010604c:	cf                   	iret
8010604d:	66 90                	xchg   %ax,%ax
8010604f:	66 90                	xchg   %ax,%ax
80106051:	66 90                	xchg   %ax,%ax
80106053:	66 90                	xchg   %ax,%ax
80106055:	66 90                	xchg   %ax,%ax
80106057:	66 90                	xchg   %ax,%ax
80106059:	66 90                	xchg   %ax,%ax
8010605b:	66 90                	xchg   %ax,%ax
8010605d:	66 90                	xchg   %ax,%ax
8010605f:	66 90                	xchg   %ax,%ax
80106061:	66 90                	xchg   %ax,%ax
80106063:	66 90                	xchg   %ax,%ax
80106065:	66 90                	xchg   %ax,%ax
80106067:	66 90                	xchg   %ax,%ax
80106069:	66 90                	xchg   %ax,%ax
8010606b:	66 90                	xchg   %ax,%ax
8010606d:	66 90                	xchg   %ax,%ax
8010606f:	66 90                	xchg   %ax,%ax
80106071:	66 90                	xchg   %ax,%ax
80106073:	66 90                	xchg   %ax,%ax
80106075:	66 90                	xchg   %ax,%ax
80106077:	66 90                	xchg   %ax,%ax
80106079:	66 90                	xchg   %ax,%ax
8010607b:	66 90                	xchg   %ax,%ax
8010607d:	66 90                	xchg   %ax,%ax
8010607f:	90                   	nop

80106080 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106080:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106081:	31 c0                	xor    %eax,%eax
{
80106083:	89 e5                	mov    %esp,%ebp
80106085:	83 ec 08             	sub    $0x8,%esp
80106088:	eb 36                	jmp    801060c0 <tvinit+0x40>
8010608a:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106091:	00 
80106092:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106099:	00 
8010609a:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060a1:	00 
801060a2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060a9:	00 
801060aa:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060b1:	00 
801060b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060b9:	00 
801060ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801060c0:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
801060c7:	c7 04 c5 82 4d 11 80 	movl   $0x8e000008,-0x7feeb27e(,%eax,8)
801060ce:	08 00 00 8e 
801060d2:	66 89 14 c5 80 4d 11 	mov    %dx,-0x7feeb280(,%eax,8)
801060d9:	80 
801060da:	c1 ea 10             	shr    $0x10,%edx
801060dd:	66 89 14 c5 86 4d 11 	mov    %dx,-0x7feeb27a(,%eax,8)
801060e4:	80 
  for(i = 0; i < 256; i++)
801060e5:	83 c0 01             	add    $0x1,%eax
801060e8:	3d 00 01 00 00       	cmp    $0x100,%eax
801060ed:	75 d1                	jne    801060c0 <tvinit+0x40>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801060ef:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801060f2:	a1 0c b1 10 80       	mov    0x8010b10c,%eax
801060f7:	c7 05 82 4f 11 80 08 	movl   $0xef000008,0x80114f82
801060fe:	00 00 ef 
  initlock(&tickslock, "time");
80106101:	68 c0 84 10 80       	push   $0x801084c0
80106106:	68 40 4d 11 80       	push   $0x80114d40
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010610b:	66 a3 80 4f 11 80    	mov    %ax,0x80114f80
80106111:	c1 e8 10             	shr    $0x10,%eax
80106114:	66 a3 86 4f 11 80    	mov    %ax,0x80114f86
  initlock(&tickslock, "time");
8010611a:	e8 61 e8 ff ff       	call   80104980 <initlock>
}
8010611f:	83 c4 10             	add    $0x10,%esp
80106122:	c9                   	leave
80106123:	c3                   	ret
80106124:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010612b:	00 
8010612c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106130 <idtinit>:

void
idtinit(void)
{
80106130:	55                   	push   %ebp
  pd[0] = size-1;
80106131:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106136:	89 e5                	mov    %esp,%ebp
80106138:	83 ec 10             	sub    $0x10,%esp
8010613b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010613f:	b8 80 4d 11 80       	mov    $0x80114d80,%eax
80106144:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106148:	c1 e8 10             	shr    $0x10,%eax
8010614b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010614f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106152:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106155:	c9                   	leave
80106156:	c3                   	ret
80106157:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010615e:	00 
8010615f:	90                   	nop

80106160 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106160:	55                   	push   %ebp
80106161:	89 e5                	mov    %esp,%ebp
80106163:	57                   	push   %edi
80106164:	56                   	push   %esi
80106165:	53                   	push   %ebx
80106166:	83 ec 1c             	sub    $0x1c,%esp
80106169:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010616c:	8b 43 30             	mov    0x30(%ebx),%eax
8010616f:	83 f8 40             	cmp    $0x40,%eax
80106172:	0f 84 30 01 00 00    	je     801062a8 <trap+0x148>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106178:	83 e8 0e             	sub    $0xe,%eax
8010617b:	83 f8 31             	cmp    $0x31,%eax
8010617e:	0f 87 8c 00 00 00    	ja     80106210 <trap+0xb0>
80106184:	ff 24 85 10 8c 10 80 	jmp    *-0x7fef73f0(,%eax,4)
8010618b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  case T_PGFLT:
  	handle_pgfault();
  	break;
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80106190:	e8 8b dd ff ff       	call   80103f20 <cpuid>
80106195:	85 c0                	test   %eax,%eax
80106197:	0f 84 13 02 00 00    	je     801063b0 <trap+0x250>
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
8010619d:	e8 5e cc ff ff       	call   80102e00 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061a2:	e8 99 dd ff ff       	call   80103f40 <myproc>
801061a7:	85 c0                	test   %eax,%eax
801061a9:	74 1a                	je     801061c5 <trap+0x65>
801061ab:	e8 90 dd ff ff       	call   80103f40 <myproc>
801061b0:	8b 50 24             	mov    0x24(%eax),%edx
801061b3:	85 d2                	test   %edx,%edx
801061b5:	74 0e                	je     801061c5 <trap+0x65>
801061b7:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801061bb:	f7 d0                	not    %eax
801061bd:	a8 03                	test   $0x3,%al
801061bf:	0f 84 cb 01 00 00    	je     80106390 <trap+0x230>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801061c5:	e8 76 dd ff ff       	call   80103f40 <myproc>
801061ca:	85 c0                	test   %eax,%eax
801061cc:	74 0f                	je     801061dd <trap+0x7d>
801061ce:	e8 6d dd ff ff       	call   80103f40 <myproc>
801061d3:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801061d7:	0f 84 b3 00 00 00    	je     80106290 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061dd:	e8 5e dd ff ff       	call   80103f40 <myproc>
801061e2:	85 c0                	test   %eax,%eax
801061e4:	74 1a                	je     80106200 <trap+0xa0>
801061e6:	e8 55 dd ff ff       	call   80103f40 <myproc>
801061eb:	8b 40 24             	mov    0x24(%eax),%eax
801061ee:	85 c0                	test   %eax,%eax
801061f0:	74 0e                	je     80106200 <trap+0xa0>
801061f2:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801061f6:	f7 d0                	not    %eax
801061f8:	a8 03                	test   $0x3,%al
801061fa:	0f 84 d5 00 00 00    	je     801062d5 <trap+0x175>
    exit();
}
80106200:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106203:	5b                   	pop    %ebx
80106204:	5e                   	pop    %esi
80106205:	5f                   	pop    %edi
80106206:	5d                   	pop    %ebp
80106207:	c3                   	ret
80106208:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010620f:	00 
    if(myproc() == 0 || (tf->cs&3) == 0){
80106210:	e8 2b dd ff ff       	call   80103f40 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106215:	8b 7b 38             	mov    0x38(%ebx),%edi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106218:	85 c0                	test   %eax,%eax
8010621a:	0f 84 c4 01 00 00    	je     801063e4 <trap+0x284>
80106220:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106224:	0f 84 ba 01 00 00    	je     801063e4 <trap+0x284>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010622a:	0f 20 d1             	mov    %cr2,%ecx
8010622d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106230:	e8 eb dc ff ff       	call   80103f20 <cpuid>
80106235:	8b 73 30             	mov    0x30(%ebx),%esi
80106238:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010623b:	8b 43 34             	mov    0x34(%ebx),%eax
8010623e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106241:	e8 fa dc ff ff       	call   80103f40 <myproc>
80106246:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106249:	e8 f2 dc ff ff       	call   80103f40 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010624e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106251:	51                   	push   %ecx
80106252:	57                   	push   %edi
80106253:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106256:	52                   	push   %edx
80106257:	ff 75 e4             	push   -0x1c(%ebp)
8010625a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010625b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010625e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106261:	56                   	push   %esi
80106262:	ff 70 10             	push   0x10(%eax)
80106265:	68 c0 87 10 80       	push   $0x801087c0
8010626a:	e8 81 a5 ff ff       	call   801007f0 <cprintf>
    myproc()->killed = 1;
8010626f:	83 c4 20             	add    $0x20,%esp
80106272:	e8 c9 dc ff ff       	call   80103f40 <myproc>
80106277:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010627e:	e8 bd dc ff ff       	call   80103f40 <myproc>
80106283:	85 c0                	test   %eax,%eax
80106285:	0f 85 20 ff ff ff    	jne    801061ab <trap+0x4b>
8010628b:	e9 35 ff ff ff       	jmp    801061c5 <trap+0x65>
  if(myproc() && myproc()->state == RUNNING &&
80106290:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106294:	0f 85 43 ff ff ff    	jne    801061dd <trap+0x7d>
    yield();
8010629a:	e8 11 e3 ff ff       	call   801045b0 <yield>
8010629f:	e9 39 ff ff ff       	jmp    801061dd <trap+0x7d>
801062a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801062a8:	e8 93 dc ff ff       	call   80103f40 <myproc>
801062ad:	8b 70 24             	mov    0x24(%eax),%esi
801062b0:	85 f6                	test   %esi,%esi
801062b2:	0f 85 e8 00 00 00    	jne    801063a0 <trap+0x240>
    myproc()->tf = tf;
801062b8:	e8 83 dc ff ff       	call   80103f40 <myproc>
801062bd:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801062c0:	e8 eb ed ff ff       	call   801050b0 <syscall>
    if(myproc()->killed)
801062c5:	e8 76 dc ff ff       	call   80103f40 <myproc>
801062ca:	8b 48 24             	mov    0x24(%eax),%ecx
801062cd:	85 c9                	test   %ecx,%ecx
801062cf:	0f 84 2b ff ff ff    	je     80106200 <trap+0xa0>
}
801062d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062d8:	5b                   	pop    %ebx
801062d9:	5e                   	pop    %esi
801062da:	5f                   	pop    %edi
801062db:	5d                   	pop    %ebp
      exit();
801062dc:	e9 4f e0 ff ff       	jmp    80104330 <exit>
801062e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801062e8:	8b 7b 38             	mov    0x38(%ebx),%edi
801062eb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801062ef:	e8 2c dc ff ff       	call   80103f20 <cpuid>
801062f4:	57                   	push   %edi
801062f5:	56                   	push   %esi
801062f6:	50                   	push   %eax
801062f7:	68 68 87 10 80       	push   $0x80108768
801062fc:	e8 ef a4 ff ff       	call   801007f0 <cprintf>
    lapiceoi();
80106301:	e8 fa ca ff ff       	call   80102e00 <lapiceoi>
    break;
80106306:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106309:	e8 32 dc ff ff       	call   80103f40 <myproc>
8010630e:	85 c0                	test   %eax,%eax
80106310:	0f 85 95 fe ff ff    	jne    801061ab <trap+0x4b>
80106316:	e9 aa fe ff ff       	jmp    801061c5 <trap+0x65>
8010631b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    kbdintr();
80106320:	e8 8b c9 ff ff       	call   80102cb0 <kbdintr>
    lapiceoi();
80106325:	e8 d6 ca ff ff       	call   80102e00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010632a:	e8 11 dc ff ff       	call   80103f40 <myproc>
8010632f:	85 c0                	test   %eax,%eax
80106331:	0f 85 74 fe ff ff    	jne    801061ab <trap+0x4b>
80106337:	e9 89 fe ff ff       	jmp    801061c5 <trap+0x65>
8010633c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106340:	e8 9b 06 00 00       	call   801069e0 <uartintr>
    lapiceoi();
80106345:	e8 b6 ca ff ff       	call   80102e00 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010634a:	e8 f1 db ff ff       	call   80103f40 <myproc>
8010634f:	85 c0                	test   %eax,%eax
80106351:	0f 85 54 fe ff ff    	jne    801061ab <trap+0x4b>
80106357:	e9 69 fe ff ff       	jmp    801061c5 <trap+0x65>
8010635c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106360:	e8 5b c3 ff ff       	call   801026c0 <ideintr>
80106365:	e9 33 fe ff ff       	jmp    8010619d <trap+0x3d>
8010636a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  	handle_pgfault();
80106370:	e8 fb 03 00 00       	call   80106770 <handle_pgfault>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106375:	e8 c6 db ff ff       	call   80103f40 <myproc>
8010637a:	85 c0                	test   %eax,%eax
8010637c:	0f 85 29 fe ff ff    	jne    801061ab <trap+0x4b>
80106382:	e9 3e fe ff ff       	jmp    801061c5 <trap+0x65>
80106387:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010638e:	00 
8010638f:	90                   	nop
    exit();
80106390:	e8 9b df ff ff       	call   80104330 <exit>
80106395:	e9 2b fe ff ff       	jmp    801061c5 <trap+0x65>
8010639a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801063a0:	e8 8b df ff ff       	call   80104330 <exit>
801063a5:	e9 0e ff ff ff       	jmp    801062b8 <trap+0x158>
801063aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801063b0:	83 ec 0c             	sub    $0xc,%esp
801063b3:	68 40 4d 11 80       	push   $0x80114d40
801063b8:	e8 13 e7 ff ff       	call   80104ad0 <acquire>
      ticks++;
801063bd:	83 05 20 4d 11 80 01 	addl   $0x1,0x80114d20
      wakeup(&ticks);
801063c4:	c7 04 24 20 4d 11 80 	movl   $0x80114d20,(%esp)
801063cb:	e8 f0 e2 ff ff       	call   801046c0 <wakeup>
      release(&tickslock);
801063d0:	c7 04 24 40 4d 11 80 	movl   $0x80114d40,(%esp)
801063d7:	e8 74 e8 ff ff       	call   80104c50 <release>
801063dc:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801063df:	e9 b9 fd ff ff       	jmp    8010619d <trap+0x3d>
801063e4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801063e7:	e8 34 db ff ff       	call   80103f20 <cpuid>
801063ec:	83 ec 0c             	sub    $0xc,%esp
801063ef:	56                   	push   %esi
801063f0:	57                   	push   %edi
801063f1:	50                   	push   %eax
801063f2:	ff 73 30             	push   0x30(%ebx)
801063f5:	68 8c 87 10 80       	push   $0x8010878c
801063fa:	e8 f1 a3 ff ff       	call   801007f0 <cprintf>
      panic("trap");
801063ff:	83 c4 14             	add    $0x14,%esp
80106402:	68 c5 84 10 80       	push   $0x801084c5
80106407:	e8 a4 a0 ff ff       	call   801004b0 <panic>
8010640c:	66 90                	xchg   %ax,%ax
8010640e:	66 90                	xchg   %ax,%ax
80106410:	66 90                	xchg   %ax,%ax
80106412:	66 90                	xchg   %ax,%ax
80106414:	66 90                	xchg   %ax,%ax
80106416:	66 90                	xchg   %ax,%ax
80106418:	66 90                	xchg   %ax,%ax
8010641a:	66 90                	xchg   %ax,%ax
8010641c:	66 90                	xchg   %ax,%ax
8010641e:	66 90                	xchg   %ax,%ax

80106420 <myprocXV7>:
static pte_t * walkpgdir(pde_t *pgdir, const void *va, int alloc);
int deallocuvmXV7(pde_t *pgdir, uint oldsz, uint newsz);
static int mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm);

struct proc*
myprocXV7(void) {
80106420:	55                   	push   %ebp
80106421:	89 e5                	mov    %esp,%ebp
80106423:	53                   	push   %ebx
80106424:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
80106427:	e8 54 e6 ff ff       	call   80104a80 <pushcli>
  c = mycpu();
8010642c:	e8 8f da ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
80106431:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80106437:	e8 b4 e7 ff ff       	call   80104bf0 <popcli>
  return p;
}
8010643c:	89 d8                	mov    %ebx,%eax
8010643e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106441:	c9                   	leave
80106442:	c3                   	ret
80106443:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010644a:	00 
8010644b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106450 <swap_page_from_pte>:
 * to the disk blocks and save the block-id into the
 * pte.
 */
void
swap_page_from_pte(pte_t *pte)
{
80106450:	55                   	push   %ebp
80106451:	89 e5                	mov    %esp,%ebp
80106453:	57                   	push   %edi
80106454:	56                   	push   %esi
80106455:	53                   	push   %ebx
80106456:	83 ec 0c             	sub    $0xc,%esp
80106459:	8b 7d 08             	mov    0x8(%ebp),%edi
	//************xv7*************

  uint physicalAddress=PTE_ADDR(*pte);          //PTE_ADDR returns address in pte
  if(physicalAddress==0)
8010645c:	8b 37                	mov    (%edi),%esi
8010645e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80106464:	74 4a                	je     801064b0 <swap_page_from_pte+0x60>
    cprintf("physicalAddress address is zero\n");
  uint diskPage=balloc_page(ROOTDEV);
80106466:	83 ec 0c             	sub    $0xc,%esp
//  char *vaSwapPage=kalloc();                 //virtual address of physical page which needs to be swapped to disk
  // char vaSwapPage[4096]="";

  // memmove(vaSwapPage,(char*)P2V(physicalAddress),PGSIZE); //copy va to vaSwapPage : copied from 2071: copyuvm()

  write_page_to_disk(ROOTDEV,(char*)P2V(physicalAddress),diskPage);    //write this page to disk
80106469:	81 c6 00 00 00 80    	add    $0x80000000,%esi
  uint diskPage=balloc_page(ROOTDEV);
8010646f:	6a 01                	push   $0x1
80106471:	e8 4a b4 ff ff       	call   801018c0 <balloc_page>
  write_page_to_disk(ROOTDEV,(char*)P2V(physicalAddress),diskPage);    //write this page to disk
80106476:	83 c4 0c             	add    $0xc,%esp
80106479:	50                   	push   %eax
  uint diskPage=balloc_page(ROOTDEV);
8010647a:	89 c3                	mov    %eax,%ebx
  write_page_to_disk(ROOTDEV,(char*)P2V(physicalAddress),diskPage);    //write this page to disk
8010647c:	56                   	push   %esi
    Store block id and swapped flag in the pte entry whose page was swapped to the disk
    So, when next time this pte is dereferenced, we know that the page has been swapped to
    the disk and we can bring this page again to memory
  */
  *pte = (*pte & 0x000000);     //make pte = null;
  *pte = (diskPage << 12)| PTE_SWAPPED;
8010647d:	c1 e3 0c             	shl    $0xc,%ebx
  write_page_to_disk(ROOTDEV,(char*)P2V(physicalAddress),diskPage);    //write this page to disk
80106480:	6a 01                	push   $0x1
  *pte = (diskPage << 12)| PTE_SWAPPED;
80106482:	80 cf 02             	or     $0x2,%bh
  write_page_to_disk(ROOTDEV,(char*)P2V(physicalAddress),diskPage);    //write this page to disk
80106485:	e8 d6 9d ff ff       	call   80100260 <write_page_to_disk>
  *pte = (diskPage << 12)| PTE_SWAPPED;
8010648a:	89 1f                	mov    %ebx,(%edi)
  /*WHEN PAGE TABLE ENTRIES ARE MODIFIED, THE HARDWARE STILL USES CACHED ENTRIES IN TLB,
    SO WE NEED TO INVALIDATE TLB ENTRY USING EITHER invlpg INSTRUCTION OR
    lcr3
  */

  kfree(P2V(physicalAddress));
8010648c:	89 34 24             	mov    %esi,(%esp)
8010648f:	e8 ec c4 ff ff       	call   80102980 <kfree>
  cprintf("\nReturning from swap page from pte\n");
80106494:	83 c4 10             	add    $0x10,%esp
80106497:	c7 45 08 28 88 10 80 	movl   $0x80108828,0x8(%ebp)

}
8010649e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064a1:	5b                   	pop    %ebx
801064a2:	5e                   	pop    %esi
801064a3:	5f                   	pop    %edi
801064a4:	5d                   	pop    %ebp
  cprintf("\nReturning from swap page from pte\n");
801064a5:	e9 46 a3 ff ff       	jmp    801007f0 <cprintf>
801064aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("physicalAddress address is zero\n");
801064b0:	83 ec 0c             	sub    $0xc,%esp
801064b3:	68 04 88 10 80       	push   $0x80108804
801064b8:	e8 33 a3 ff ff       	call   801007f0 <cprintf>
801064bd:	83 c4 10             	add    $0x10,%esp
801064c0:	eb a4                	jmp    80106466 <swap_page_from_pte+0x16>
801064c2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064c9:	00 
801064ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801064d0 <swap_page>:

/* Select a victim and swap the contents to the disk.
 */
int
swap_page(pde_t *pgdir)
{
801064d0:	55                   	push   %ebp
801064d1:	89 e5                	mov    %esp,%ebp
801064d3:	56                   	push   %esi
801064d4:	53                   	push   %ebx
801064d5:	8b 75 08             	mov    0x8(%ebp),%esi
  pte_t* pte=select_a_victim(pgdir);         //returns *pte
801064d8:	83 ec 0c             	sub    $0xc,%esp
801064db:	56                   	push   %esi
801064dc:	e8 df 16 00 00       	call   80107bc0 <select_a_victim>
  if(pte==0){                                     //If this is true, victim is not found in 1st attempt. Inside this function
801064e1:	83 c4 10             	add    $0x10,%esp
801064e4:	85 c0                	test   %eax,%eax
801064e6:	74 38                	je     80106520 <swap_page+0x50>

    if(pte!=0) cprintf("victim found");
    else cprintf("Not found even in second attempt." );
  }
  else{                                           //This else is true, then victim is found in first attempt.
    cprintf("Victim found in 1st attempt.");
801064e8:	83 ec 0c             	sub    $0xc,%esp
801064eb:	89 c3                	mov    %eax,%ebx
801064ed:	68 d7 84 10 80       	push   $0x801084d7
801064f2:	e8 f9 a2 ff ff       	call   801007f0 <cprintf>
801064f7:	83 c4 10             	add    $0x10,%esp
  }

  swap_page_from_pte(pte);  //swap victim page to disk
801064fa:	83 ec 0c             	sub    $0xc,%esp
  lcr3(V2P(pgdir));         //This operation ensures that the older TLB entries are flushed
801064fd:	81 c6 00 00 00 80    	add    $0x80000000,%esi
  swap_page_from_pte(pte);  //swap victim page to disk
80106503:	53                   	push   %ebx
80106504:	e8 47 ff ff ff       	call   80106450 <swap_page_from_pte>
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106509:	0f 22 de             	mov    %esi,%cr3
	//panic("swap_page is not implemented");
	return 1;
}
8010650c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010650f:	b8 01 00 00 00       	mov    $0x1,%eax
80106514:	5b                   	pop    %ebx
80106515:	5e                   	pop    %esi
80106516:	5d                   	pop    %ebp
80106517:	c3                   	ret
80106518:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010651f:	00 
    cprintf("No victim found in 1st attempt. Clearing access bits.");
80106520:	83 ec 0c             	sub    $0xc,%esp
80106523:	68 4c 88 10 80       	push   $0x8010884c
80106528:	e8 c3 a2 ff ff       	call   801007f0 <cprintf>
    clearaccessbit(pgdir);                        //Accessbits are cleared,
8010652d:	89 34 24             	mov    %esi,(%esp)
80106530:	e8 eb 16 00 00       	call   80107c20 <clearaccessbit>
    cprintf("Finding victim again, after clearing access bits of 10%% pages.");
80106535:	c7 04 24 84 88 10 80 	movl   $0x80108884,(%esp)
8010653c:	e8 af a2 ff ff       	call   801007f0 <cprintf>
    pte=select_a_victim(pgdir);                   //then victim is selected again. Victim is found this time.
80106541:	89 34 24             	mov    %esi,(%esp)
80106544:	e8 77 16 00 00       	call   80107bc0 <select_a_victim>
    if(pte!=0) cprintf("victim found");
80106549:	83 c4 10             	add    $0x10,%esp
    pte=select_a_victim(pgdir);                   //then victim is selected again. Victim is found this time.
8010654c:	89 c3                	mov    %eax,%ebx
    if(pte!=0) cprintf("victim found");
8010654e:	85 c0                	test   %eax,%eax
80106550:	74 16                	je     80106568 <swap_page+0x98>
80106552:	83 ec 0c             	sub    $0xc,%esp
80106555:	68 ca 84 10 80       	push   $0x801084ca
8010655a:	e8 91 a2 ff ff       	call   801007f0 <cprintf>
8010655f:	83 c4 10             	add    $0x10,%esp
80106562:	eb 96                	jmp    801064fa <swap_page+0x2a>
80106564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else cprintf("Not found even in second attempt." );
80106568:	83 ec 0c             	sub    $0xc,%esp
8010656b:	68 c4 88 10 80       	push   $0x801088c4
80106570:	e8 7b a2 ff ff       	call   801007f0 <cprintf>
80106575:	83 c4 10             	add    $0x10,%esp
80106578:	eb 80                	jmp    801064fa <swap_page+0x2a>
8010657a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106580 <map_address>:
iii) Set the access bit of the page (last 12 bits are same in physical and virtual page),
			so they share the access bit
*/
void
map_address(pde_t *pgdir, uint addr)
{
80106580:	55                   	push   %ebp
80106581:	89 e5                	mov    %esp,%ebp
80106583:	57                   	push   %edi
80106584:	56                   	push   %esi
80106585:	53                   	push   %ebx
80106586:	83 ec 1c             	sub    $0x1c,%esp
80106589:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
8010658c:	e8 ef e4 ff ff       	call   80104a80 <pushcli>
  c = mycpu();
80106591:	e8 2a d9 ff ff       	call   80103ec0 <mycpu>
  popcli();
80106596:	e8 55 e6 ff ff       	call   80104bf0 <popcli>
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010659b:	0f 20 d0             	mov    %cr2,%eax
	struct proc *curproc = myprocXV7();
	// cprintf(curproc->name);
	uint cursz= curproc->sz;
	uint a= PGROUNDDOWN(rcr2());			//rounds the address to a multiple of page size (PGSIZE)
8010659e:	89 c3                	mov    %eax,%ebx
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801065a0:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801065a3:	8b 04 87             	mov    (%edi,%eax,4),%eax
	uint a= PGROUNDDOWN(rcr2());			//rounds the address to a multiple of page size (PGSIZE)
801065a6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  if(*pde & PTE_P){
801065ac:	a8 01                	test   $0x1,%al
801065ae:	75 18                	jne    801065c8 <map_address+0x48>
	char *mem=kalloc();    //allocate a physical page
801065b0:	e8 9b c5 ff ff       	call   80102b50 <kalloc>
  if(mem==0){
801065b5:	85 c0                	test   %eax,%eax
801065b7:	0f 84 5b 01 00 00    	je     80106718 <map_address+0x198>
}
801065bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801065c0:	5b                   	pop    %ebx
801065c1:	5e                   	pop    %esi
801065c2:	5f                   	pop    %edi
801065c3:	5d                   	pop    %ebp
801065c4:	c3                   	ret
801065c5:	8d 76 00             	lea    0x0(%esi),%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801065c8:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801065ca:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801065cf:	c1 ea 0a             	shr    $0xa,%edx
801065d2:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801065d8:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
801065df:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	char *mem=kalloc();    //allocate a physical page
801065e2:	e8 69 c5 ff ff       	call   80102b50 <kalloc>
  if(mem==0){
801065e7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801065ea:	85 c0                	test   %eax,%eax
	char *mem=kalloc();    //allocate a physical page
801065ec:	89 c6                	mov    %eax,%esi
  if(mem==0){
801065ee:	0f 84 4c 01 00 00    	je     80106740 <map_address+0x1c0>
  if(pte!=0){
801065f4:	85 d2                	test   %edx,%edx
801065f6:	74 c5                	je     801065bd <map_address+0x3d>
    if(*pte & PTE_SWAPPED){
801065f8:	f6 42 01 02          	testb  $0x2,0x1(%edx)
801065fc:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801065ff:	74 4f                	je     80106650 <map_address+0xd0>
      blockid=getswappedblk(pgdir,a);      //disk id where the page was swapped
80106601:	83 ec 08             	sub    $0x8,%esp
80106604:	53                   	push   %ebx
80106605:	57                   	push   %edi
      lcr3(V2P(pgdir));
80106606:	81 c7 00 00 00 80    	add    $0x80000000,%edi
      blockid=getswappedblk(pgdir,a);      //disk id where the page was swapped
8010660c:	e8 6f 16 00 00       	call   80107c80 <getswappedblk>
      read_page_from_disk(ROOTDEV, mem, blockid);
80106611:	83 c4 0c             	add    $0xc,%esp
80106614:	50                   	push   %eax
      blockid=getswappedblk(pgdir,a);      //disk id where the page was swapped
80106615:	89 c3                	mov    %eax,%ebx
      read_page_from_disk(ROOTDEV, mem, blockid);
80106617:	56                   	push   %esi
      *pte=V2P(mem) | PTE_W | PTE_U | PTE_P;
80106618:	81 c6 00 00 00 80    	add    $0x80000000,%esi
      read_page_from_disk(ROOTDEV, mem, blockid);
8010661e:	6a 01                	push   $0x1
      *pte &= ~PTE_SWAPPED;
80106620:	81 e6 ff fd ff ff    	and    $0xfffffdff,%esi
80106626:	83 ce 07             	or     $0x7,%esi
      read_page_from_disk(ROOTDEV, mem, blockid);
80106629:	e8 c2 9c ff ff       	call   801002f0 <read_page_from_disk>
      *pte &= ~PTE_SWAPPED;
8010662e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106631:	89 32                	mov    %esi,(%edx)
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106633:	0f 22 df             	mov    %edi,%cr3
      bfree_page(ROOTDEV,blockid);
80106636:	83 c4 10             	add    $0x10,%esp
80106639:	89 5d 0c             	mov    %ebx,0xc(%ebp)
8010663c:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
80106643:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106646:	5b                   	pop    %ebx
80106647:	5e                   	pop    %esi
80106648:	5f                   	pop    %edi
80106649:	5d                   	pop    %ebp
      bfree_page(ROOTDEV,blockid);
8010664a:	e9 41 b3 ff ff       	jmp    80101990 <bfree_page>
8010664f:	90                   	nop
      memset(mem,0,PGSIZE);
80106650:	83 ec 04             	sub    $0x4,%esp
80106653:	68 00 10 00 00       	push   $0x1000
80106658:	6a 00                	push   $0x0
8010665a:	56                   	push   %esi
8010665b:	29 de                	sub    %ebx,%esi
8010665d:	e8 3e e6 ff ff       	call   80104ca0 <memset>
{
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106662:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106668:	83 c4 10             	add    $0x10,%esp
8010666b:	89 5d dc             	mov    %ebx,-0x24(%ebp)
8010666e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106671:	89 7d e0             	mov    %edi,-0x20(%ebp)
80106674:	eb 39                	jmp    801066af <map_address+0x12f>
80106676:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010667d:	00 
8010667e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80106680:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106682:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106687:	c1 ea 0a             	shr    $0xa,%edx
8010668a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106690:	8d 94 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%edx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106697:	85 d2                	test   %edx,%edx
80106699:	74 6d                	je     80106708 <map_address+0x188>
      return -1;
    // if(*pte & PTE_P)
    //   panic("remap in mappages in paging.c");
    *pte = pa | perm | PTE_P;
8010669b:	83 ce 07             	or     $0x7,%esi
8010669e:	89 32                	mov    %esi,(%edx)
    if(a == last)
801066a0:	39 5d dc             	cmp    %ebx,-0x24(%ebp)
801066a3:	0f 84 14 ff ff ff    	je     801065bd <map_address+0x3d>
      break;
    a += PGSIZE;
801066a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801066af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
801066b2:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801066b5:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801066b8:	89 d8                	mov    %ebx,%eax
801066ba:	c1 e8 16             	shr    $0x16,%eax
801066bd:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801066c0:	8b 07                	mov    (%edi),%eax
801066c2:	a8 01                	test   $0x1,%al
801066c4:	75 ba                	jne    80106680 <map_address+0x100>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801066c6:	e8 85 c4 ff ff       	call   80102b50 <kalloc>
801066cb:	85 c0                	test   %eax,%eax
801066cd:	74 39                	je     80106708 <map_address+0x188>
    memset(pgtab, 0, PGSIZE);
801066cf:	83 ec 04             	sub    $0x4,%esp
801066d2:	68 00 10 00 00       	push   $0x1000
801066d7:	6a 00                	push   $0x0
801066d9:	50                   	push   %eax
801066da:	89 45 d8             	mov    %eax,-0x28(%ebp)
801066dd:	e8 be e5 ff ff       	call   80104ca0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801066e2:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
801066e5:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801066e8:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801066ee:	83 c8 07             	or     $0x7,%eax
801066f1:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801066f3:	89 d8                	mov    %ebx,%eax
801066f5:	c1 e8 0a             	shr    $0xa,%eax
801066f8:	25 fc 0f 00 00       	and    $0xffc,%eax
801066fd:	01 c2                	add    %eax,%edx
801066ff:	eb 9a                	jmp    8010669b <map_address+0x11b>
80106701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    		panic("allocuvm out of memory xv7 in mappages/n");
80106708:	83 ec 0c             	sub    $0xc,%esp
8010670b:	68 e8 88 10 80       	push   $0x801088e8
80106710:	e8 9b 9d ff ff       	call   801004b0 <panic>
80106715:	8d 76 00             	lea    0x0(%esi),%esi
    swap_page(pgdir);
80106718:	83 ec 0c             	sub    $0xc,%esp
8010671b:	57                   	push   %edi
8010671c:	e8 af fd ff ff       	call   801064d0 <swap_page>
    mem=kalloc();             //now a physical page has been swapped to disk and free, so this time we will get physical page for sure.
80106721:	e8 2a c4 ff ff       	call   80102b50 <kalloc>
    cprintf("kalloc success\n");
80106726:	83 c4 10             	add    $0x10,%esp
80106729:	c7 45 08 f4 84 10 80 	movl   $0x801084f4,0x8(%ebp)
}
80106730:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106733:	5b                   	pop    %ebx
80106734:	5e                   	pop    %esi
80106735:	5f                   	pop    %edi
80106736:	5d                   	pop    %ebp
    cprintf("kalloc success\n");
80106737:	e9 b4 a0 ff ff       	jmp    801007f0 <cprintf>
8010673c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    swap_page(pgdir);
80106740:	83 ec 0c             	sub    $0xc,%esp
80106743:	57                   	push   %edi
80106744:	e8 87 fd ff ff       	call   801064d0 <swap_page>
    mem=kalloc();             //now a physical page has been swapped to disk and free, so this time we will get physical page for sure.
80106749:	e8 02 c4 ff ff       	call   80102b50 <kalloc>
    cprintf("kalloc success\n");
8010674e:	c7 04 24 f4 84 10 80 	movl   $0x801084f4,(%esp)
    mem=kalloc();             //now a physical page has been swapped to disk and free, so this time we will get physical page for sure.
80106755:	89 c6                	mov    %eax,%esi
    cprintf("kalloc success\n");
80106757:	e8 94 a0 ff ff       	call   801007f0 <cprintf>
8010675c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010675f:	83 c4 10             	add    $0x10,%esp
80106762:	e9 8d fe ff ff       	jmp    801065f4 <map_address+0x74>
80106767:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010676e:	00 
8010676f:	90                   	nop

80106770 <handle_pgfault>:
{
80106770:	55                   	push   %ebp
80106771:	89 e5                	mov    %esp,%ebp
80106773:	53                   	push   %ebx
80106774:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80106777:	e8 04 e3 ff ff       	call   80104a80 <pushcli>
  c = mycpu();
8010677c:	e8 3f d7 ff ff       	call   80103ec0 <mycpu>
  p = c->proc;
80106781:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80106787:	e8 64 e4 ff ff       	call   80104bf0 <popcli>
	asm volatile ("movl %%cr2, %0 \n\t" : "=r" (addr));
8010678c:	0f 20 d0             	mov    %cr2,%eax
	map_address(curproc->pgdir, addr);
8010678f:	83 ec 08             	sub    $0x8,%esp
	addr &= ~0xfff;
80106792:	25 00 f0 ff ff       	and    $0xfffff000,%eax
	map_address(curproc->pgdir, addr);
80106797:	50                   	push   %eax
80106798:	ff 73 04             	push   0x4(%ebx)
8010679b:	e8 e0 fd ff ff       	call   80106580 <map_address>
}
801067a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801067a3:	83 c4 10             	add    $0x10,%esp
801067a6:	c9                   	leave
801067a7:	c3                   	ret
801067a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801067af:	00 

801067b0 <deallocuvmXV7>:
{
801067b0:	55                   	push   %ebp
801067b1:	89 e5                	mov    %esp,%ebp
801067b3:	57                   	push   %edi
801067b4:	56                   	push   %esi
801067b5:	53                   	push   %ebx
801067b6:	83 ec 0c             	sub    $0xc,%esp
801067b9:	8b 75 0c             	mov    0xc(%ebp),%esi
801067bc:	8b 7d 08             	mov    0x8(%ebp),%edi
    return oldsz;
801067bf:	89 f0                	mov    %esi,%eax
  if(newsz >= oldsz)
801067c1:	39 75 10             	cmp    %esi,0x10(%ebp)
801067c4:	73 62                	jae    80106828 <deallocuvmXV7+0x78>
  a = PGROUNDUP(newsz);
801067c6:	8b 45 10             	mov    0x10(%ebp),%eax
801067c9:	89 f2                	mov    %esi,%edx
801067cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801067d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801067d7:	39 f3                	cmp    %esi,%ebx
801067d9:	72 11                	jb     801067ec <deallocuvmXV7+0x3c>
801067db:	eb 48                	jmp    80106825 <deallocuvmXV7+0x75>
801067dd:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801067e0:	83 c0 01             	add    $0x1,%eax
801067e3:	c1 e0 16             	shl    $0x16,%eax
801067e6:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
801067e8:	39 d3                	cmp    %edx,%ebx
801067ea:	73 39                	jae    80106825 <deallocuvmXV7+0x75>
  pde = &pgdir[PDX(va)];
801067ec:	89 d8                	mov    %ebx,%eax
801067ee:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801067f1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
801067f4:	f6 c1 01             	test   $0x1,%cl
801067f7:	74 e7                	je     801067e0 <deallocuvmXV7+0x30>
  return &pgtab[PTX(va)];
801067f9:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801067fb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106801:	c1 ee 0a             	shr    $0xa,%esi
80106804:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010680a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80106811:	85 f6                	test   %esi,%esi
80106813:	74 cb                	je     801067e0 <deallocuvmXV7+0x30>
    else if((*pte & PTE_P) != 0){
80106815:	8b 06                	mov    (%esi),%eax
80106817:	a8 01                	test   $0x1,%al
80106819:	75 15                	jne    80106830 <deallocuvmXV7+0x80>
  for(; a  < oldsz; a += PGSIZE){
8010681b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106821:	39 d3                	cmp    %edx,%ebx
80106823:	72 c7                	jb     801067ec <deallocuvmXV7+0x3c>
  return newsz;
80106825:	8b 45 10             	mov    0x10(%ebp),%eax
}
80106828:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010682b:	5b                   	pop    %ebx
8010682c:	5e                   	pop    %esi
8010682d:	5f                   	pop    %edi
8010682e:	5d                   	pop    %ebp
8010682f:	c3                   	ret
      if(pa == 0)
80106830:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106835:	74 25                	je     8010685c <deallocuvmXV7+0xac>
      kfree(v);
80106837:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010683a:	05 00 00 00 80       	add    $0x80000000,%eax
8010683f:	89 55 0c             	mov    %edx,0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106842:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106848:	50                   	push   %eax
80106849:	e8 32 c1 ff ff       	call   80102980 <kfree>
      *pte = 0;
8010684e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80106854:	8b 55 0c             	mov    0xc(%ebp),%edx
80106857:	83 c4 10             	add    $0x10,%esp
8010685a:	eb 8c                	jmp    801067e8 <deallocuvmXV7+0x38>
        panic("kfree");
8010685c:	83 ec 0c             	sub    $0xc,%esp
8010685f:	68 04 85 10 80       	push   $0x80108504
80106864:	e8 47 9c ff ff       	call   801004b0 <panic>
80106869:	66 90                	xchg   %ax,%ax
8010686b:	66 90                	xchg   %ax,%ax
8010686d:	66 90                	xchg   %ax,%ax
8010686f:	90                   	nop

80106870 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106870:	a1 80 55 11 80       	mov    0x80115580,%eax
80106875:	85 c0                	test   %eax,%eax
80106877:	74 17                	je     80106890 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106879:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010687e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010687f:	a8 01                	test   $0x1,%al
80106881:	74 0d                	je     80106890 <uartgetc+0x20>
80106883:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106888:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106889:	0f b6 c0             	movzbl %al,%eax
8010688c:	c3                   	ret
8010688d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106890:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106895:	c3                   	ret
80106896:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010689d:	00 
8010689e:	66 90                	xchg   %ax,%ax

801068a0 <uartinit>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801068a0:	31 c9                	xor    %ecx,%ecx
801068a2:	ba fa 03 00 00       	mov    $0x3fa,%edx
801068a7:	89 c8                	mov    %ecx,%eax
801068a9:	ee                   	out    %al,(%dx)
801068aa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801068af:	ba fb 03 00 00       	mov    $0x3fb,%edx
801068b4:	ee                   	out    %al,(%dx)
801068b5:	b8 0c 00 00 00       	mov    $0xc,%eax
801068ba:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068bf:	ee                   	out    %al,(%dx)
801068c0:	ba f9 03 00 00       	mov    $0x3f9,%edx
801068c5:	89 c8                	mov    %ecx,%eax
801068c7:	ee                   	out    %al,(%dx)
801068c8:	b8 03 00 00 00       	mov    $0x3,%eax
801068cd:	ba fb 03 00 00       	mov    $0x3fb,%edx
801068d2:	ee                   	out    %al,(%dx)
801068d3:	ba fc 03 00 00       	mov    $0x3fc,%edx
801068d8:	89 c8                	mov    %ecx,%eax
801068da:	ee                   	out    %al,(%dx)
801068db:	b8 01 00 00 00       	mov    $0x1,%eax
801068e0:	ba f9 03 00 00       	mov    $0x3f9,%edx
801068e5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068e6:	ba fd 03 00 00       	mov    $0x3fd,%edx
801068eb:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801068ec:	3c ff                	cmp    $0xff,%al
801068ee:	0f 84 85 00 00 00    	je     80106979 <uartinit+0xd9>
{
801068f4:	55                   	push   %ebp
801068f5:	ba fa 03 00 00       	mov    $0x3fa,%edx
801068fa:	89 e5                	mov    %esp,%ebp
801068fc:	57                   	push   %edi
801068fd:	56                   	push   %esi
801068fe:	53                   	push   %ebx
801068ff:	83 ec 24             	sub    $0x24,%esp
  uart = 1;
80106902:	c7 05 80 55 11 80 01 	movl   $0x1,0x80115580
80106909:	00 00 00 
8010690c:	ec                   	in     (%dx),%al
8010690d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106912:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106913:	6a 00                	push   $0x0
  for(p="xv6...\n"; *p; p++)
80106915:	bf 0a 85 10 80       	mov    $0x8010850a,%edi
8010691a:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
8010691f:	6a 04                	push   $0x4
80106921:	e8 1a c0 ff ff       	call   80102940 <ioapicenable>
80106926:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106929:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
8010692d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80106930:	a1 80 55 11 80       	mov    0x80115580,%eax
80106935:	bb 80 00 00 00       	mov    $0x80,%ebx
8010693a:	85 c0                	test   %eax,%eax
8010693c:	75 14                	jne    80106952 <uartinit+0xb2>
8010693e:	eb 23                	jmp    80106963 <uartinit+0xc3>
    microdelay(10);
80106940:	83 ec 0c             	sub    $0xc,%esp
80106943:	6a 0a                	push   $0xa
80106945:	e8 d6 c4 ff ff       	call   80102e20 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010694a:	83 c4 10             	add    $0x10,%esp
8010694d:	83 eb 01             	sub    $0x1,%ebx
80106950:	74 07                	je     80106959 <uartinit+0xb9>
80106952:	89 f2                	mov    %esi,%edx
80106954:	ec                   	in     (%dx),%al
80106955:	a8 20                	test   $0x20,%al
80106957:	74 e7                	je     80106940 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106959:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010695d:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106962:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80106963:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80106967:	83 c7 01             	add    $0x1,%edi
8010696a:	88 45 e7             	mov    %al,-0x19(%ebp)
8010696d:	84 c0                	test   %al,%al
8010696f:	75 bf                	jne    80106930 <uartinit+0x90>
}
80106971:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106974:	5b                   	pop    %ebx
80106975:	5e                   	pop    %esi
80106976:	5f                   	pop    %edi
80106977:	5d                   	pop    %ebp
80106978:	c3                   	ret
80106979:	c3                   	ret
8010697a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106980 <uartputc>:
  if(!uart)
80106980:	a1 80 55 11 80       	mov    0x80115580,%eax
80106985:	85 c0                	test   %eax,%eax
80106987:	74 47                	je     801069d0 <uartputc+0x50>
{
80106989:	55                   	push   %ebp
8010698a:	89 e5                	mov    %esp,%ebp
8010698c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010698d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106992:	53                   	push   %ebx
80106993:	bb 80 00 00 00       	mov    $0x80,%ebx
80106998:	eb 18                	jmp    801069b2 <uartputc+0x32>
8010699a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801069a0:	83 ec 0c             	sub    $0xc,%esp
801069a3:	6a 0a                	push   $0xa
801069a5:	e8 76 c4 ff ff       	call   80102e20 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801069aa:	83 c4 10             	add    $0x10,%esp
801069ad:	83 eb 01             	sub    $0x1,%ebx
801069b0:	74 07                	je     801069b9 <uartputc+0x39>
801069b2:	89 f2                	mov    %esi,%edx
801069b4:	ec                   	in     (%dx),%al
801069b5:	a8 20                	test   $0x20,%al
801069b7:	74 e7                	je     801069a0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801069b9:	8b 45 08             	mov    0x8(%ebp),%eax
801069bc:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069c1:	ee                   	out    %al,(%dx)
}
801069c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801069c5:	5b                   	pop    %ebx
801069c6:	5e                   	pop    %esi
801069c7:	5d                   	pop    %ebp
801069c8:	c3                   	ret
801069c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069d0:	c3                   	ret
801069d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801069d8:	00 
801069d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801069e0 <uartintr>:

void
uartintr(void)
{
801069e0:	55                   	push   %ebp
801069e1:	89 e5                	mov    %esp,%ebp
801069e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801069e6:	68 70 68 10 80       	push   $0x80106870
801069eb:	e8 f0 9f ff ff       	call   801009e0 <consoleintr>
}
801069f0:	83 c4 10             	add    $0x10,%esp
801069f3:	c9                   	leave
801069f4:	c3                   	ret

801069f5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801069f5:	6a 00                	push   $0x0
  pushl $0
801069f7:	6a 00                	push   $0x0
  jmp alltraps
801069f9:	e9 2c f6 ff ff       	jmp    8010602a <alltraps>

801069fe <vector1>:
.globl vector1
vector1:
  pushl $0
801069fe:	6a 00                	push   $0x0
  pushl $1
80106a00:	6a 01                	push   $0x1
  jmp alltraps
80106a02:	e9 23 f6 ff ff       	jmp    8010602a <alltraps>

80106a07 <vector2>:
.globl vector2
vector2:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $2
80106a09:	6a 02                	push   $0x2
  jmp alltraps
80106a0b:	e9 1a f6 ff ff       	jmp    8010602a <alltraps>

80106a10 <vector3>:
.globl vector3
vector3:
  pushl $0
80106a10:	6a 00                	push   $0x0
  pushl $3
80106a12:	6a 03                	push   $0x3
  jmp alltraps
80106a14:	e9 11 f6 ff ff       	jmp    8010602a <alltraps>

80106a19 <vector4>:
.globl vector4
vector4:
  pushl $0
80106a19:	6a 00                	push   $0x0
  pushl $4
80106a1b:	6a 04                	push   $0x4
  jmp alltraps
80106a1d:	e9 08 f6 ff ff       	jmp    8010602a <alltraps>

80106a22 <vector5>:
.globl vector5
vector5:
  pushl $0
80106a22:	6a 00                	push   $0x0
  pushl $5
80106a24:	6a 05                	push   $0x5
  jmp alltraps
80106a26:	e9 ff f5 ff ff       	jmp    8010602a <alltraps>

80106a2b <vector6>:
.globl vector6
vector6:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $6
80106a2d:	6a 06                	push   $0x6
  jmp alltraps
80106a2f:	e9 f6 f5 ff ff       	jmp    8010602a <alltraps>

80106a34 <vector7>:
.globl vector7
vector7:
  pushl $0
80106a34:	6a 00                	push   $0x0
  pushl $7
80106a36:	6a 07                	push   $0x7
  jmp alltraps
80106a38:	e9 ed f5 ff ff       	jmp    8010602a <alltraps>

80106a3d <vector8>:
.globl vector8
vector8:
  pushl $8
80106a3d:	6a 08                	push   $0x8
  jmp alltraps
80106a3f:	e9 e6 f5 ff ff       	jmp    8010602a <alltraps>

80106a44 <vector9>:
.globl vector9
vector9:
  pushl $0
80106a44:	6a 00                	push   $0x0
  pushl $9
80106a46:	6a 09                	push   $0x9
  jmp alltraps
80106a48:	e9 dd f5 ff ff       	jmp    8010602a <alltraps>

80106a4d <vector10>:
.globl vector10
vector10:
  pushl $10
80106a4d:	6a 0a                	push   $0xa
  jmp alltraps
80106a4f:	e9 d6 f5 ff ff       	jmp    8010602a <alltraps>

80106a54 <vector11>:
.globl vector11
vector11:
  pushl $11
80106a54:	6a 0b                	push   $0xb
  jmp alltraps
80106a56:	e9 cf f5 ff ff       	jmp    8010602a <alltraps>

80106a5b <vector12>:
.globl vector12
vector12:
  pushl $12
80106a5b:	6a 0c                	push   $0xc
  jmp alltraps
80106a5d:	e9 c8 f5 ff ff       	jmp    8010602a <alltraps>

80106a62 <vector13>:
.globl vector13
vector13:
  pushl $13
80106a62:	6a 0d                	push   $0xd
  jmp alltraps
80106a64:	e9 c1 f5 ff ff       	jmp    8010602a <alltraps>

80106a69 <vector14>:
.globl vector14
vector14:
  pushl $14
80106a69:	6a 0e                	push   $0xe
  jmp alltraps
80106a6b:	e9 ba f5 ff ff       	jmp    8010602a <alltraps>

80106a70 <vector15>:
.globl vector15
vector15:
  pushl $0
80106a70:	6a 00                	push   $0x0
  pushl $15
80106a72:	6a 0f                	push   $0xf
  jmp alltraps
80106a74:	e9 b1 f5 ff ff       	jmp    8010602a <alltraps>

80106a79 <vector16>:
.globl vector16
vector16:
  pushl $0
80106a79:	6a 00                	push   $0x0
  pushl $16
80106a7b:	6a 10                	push   $0x10
  jmp alltraps
80106a7d:	e9 a8 f5 ff ff       	jmp    8010602a <alltraps>

80106a82 <vector17>:
.globl vector17
vector17:
  pushl $17
80106a82:	6a 11                	push   $0x11
  jmp alltraps
80106a84:	e9 a1 f5 ff ff       	jmp    8010602a <alltraps>

80106a89 <vector18>:
.globl vector18
vector18:
  pushl $0
80106a89:	6a 00                	push   $0x0
  pushl $18
80106a8b:	6a 12                	push   $0x12
  jmp alltraps
80106a8d:	e9 98 f5 ff ff       	jmp    8010602a <alltraps>

80106a92 <vector19>:
.globl vector19
vector19:
  pushl $0
80106a92:	6a 00                	push   $0x0
  pushl $19
80106a94:	6a 13                	push   $0x13
  jmp alltraps
80106a96:	e9 8f f5 ff ff       	jmp    8010602a <alltraps>

80106a9b <vector20>:
.globl vector20
vector20:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $20
80106a9d:	6a 14                	push   $0x14
  jmp alltraps
80106a9f:	e9 86 f5 ff ff       	jmp    8010602a <alltraps>

80106aa4 <vector21>:
.globl vector21
vector21:
  pushl $0
80106aa4:	6a 00                	push   $0x0
  pushl $21
80106aa6:	6a 15                	push   $0x15
  jmp alltraps
80106aa8:	e9 7d f5 ff ff       	jmp    8010602a <alltraps>

80106aad <vector22>:
.globl vector22
vector22:
  pushl $0
80106aad:	6a 00                	push   $0x0
  pushl $22
80106aaf:	6a 16                	push   $0x16
  jmp alltraps
80106ab1:	e9 74 f5 ff ff       	jmp    8010602a <alltraps>

80106ab6 <vector23>:
.globl vector23
vector23:
  pushl $0
80106ab6:	6a 00                	push   $0x0
  pushl $23
80106ab8:	6a 17                	push   $0x17
  jmp alltraps
80106aba:	e9 6b f5 ff ff       	jmp    8010602a <alltraps>

80106abf <vector24>:
.globl vector24
vector24:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $24
80106ac1:	6a 18                	push   $0x18
  jmp alltraps
80106ac3:	e9 62 f5 ff ff       	jmp    8010602a <alltraps>

80106ac8 <vector25>:
.globl vector25
vector25:
  pushl $0
80106ac8:	6a 00                	push   $0x0
  pushl $25
80106aca:	6a 19                	push   $0x19
  jmp alltraps
80106acc:	e9 59 f5 ff ff       	jmp    8010602a <alltraps>

80106ad1 <vector26>:
.globl vector26
vector26:
  pushl $0
80106ad1:	6a 00                	push   $0x0
  pushl $26
80106ad3:	6a 1a                	push   $0x1a
  jmp alltraps
80106ad5:	e9 50 f5 ff ff       	jmp    8010602a <alltraps>

80106ada <vector27>:
.globl vector27
vector27:
  pushl $0
80106ada:	6a 00                	push   $0x0
  pushl $27
80106adc:	6a 1b                	push   $0x1b
  jmp alltraps
80106ade:	e9 47 f5 ff ff       	jmp    8010602a <alltraps>

80106ae3 <vector28>:
.globl vector28
vector28:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $28
80106ae5:	6a 1c                	push   $0x1c
  jmp alltraps
80106ae7:	e9 3e f5 ff ff       	jmp    8010602a <alltraps>

80106aec <vector29>:
.globl vector29
vector29:
  pushl $0
80106aec:	6a 00                	push   $0x0
  pushl $29
80106aee:	6a 1d                	push   $0x1d
  jmp alltraps
80106af0:	e9 35 f5 ff ff       	jmp    8010602a <alltraps>

80106af5 <vector30>:
.globl vector30
vector30:
  pushl $0
80106af5:	6a 00                	push   $0x0
  pushl $30
80106af7:	6a 1e                	push   $0x1e
  jmp alltraps
80106af9:	e9 2c f5 ff ff       	jmp    8010602a <alltraps>

80106afe <vector31>:
.globl vector31
vector31:
  pushl $0
80106afe:	6a 00                	push   $0x0
  pushl $31
80106b00:	6a 1f                	push   $0x1f
  jmp alltraps
80106b02:	e9 23 f5 ff ff       	jmp    8010602a <alltraps>

80106b07 <vector32>:
.globl vector32
vector32:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $32
80106b09:	6a 20                	push   $0x20
  jmp alltraps
80106b0b:	e9 1a f5 ff ff       	jmp    8010602a <alltraps>

80106b10 <vector33>:
.globl vector33
vector33:
  pushl $0
80106b10:	6a 00                	push   $0x0
  pushl $33
80106b12:	6a 21                	push   $0x21
  jmp alltraps
80106b14:	e9 11 f5 ff ff       	jmp    8010602a <alltraps>

80106b19 <vector34>:
.globl vector34
vector34:
  pushl $0
80106b19:	6a 00                	push   $0x0
  pushl $34
80106b1b:	6a 22                	push   $0x22
  jmp alltraps
80106b1d:	e9 08 f5 ff ff       	jmp    8010602a <alltraps>

80106b22 <vector35>:
.globl vector35
vector35:
  pushl $0
80106b22:	6a 00                	push   $0x0
  pushl $35
80106b24:	6a 23                	push   $0x23
  jmp alltraps
80106b26:	e9 ff f4 ff ff       	jmp    8010602a <alltraps>

80106b2b <vector36>:
.globl vector36
vector36:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $36
80106b2d:	6a 24                	push   $0x24
  jmp alltraps
80106b2f:	e9 f6 f4 ff ff       	jmp    8010602a <alltraps>

80106b34 <vector37>:
.globl vector37
vector37:
  pushl $0
80106b34:	6a 00                	push   $0x0
  pushl $37
80106b36:	6a 25                	push   $0x25
  jmp alltraps
80106b38:	e9 ed f4 ff ff       	jmp    8010602a <alltraps>

80106b3d <vector38>:
.globl vector38
vector38:
  pushl $0
80106b3d:	6a 00                	push   $0x0
  pushl $38
80106b3f:	6a 26                	push   $0x26
  jmp alltraps
80106b41:	e9 e4 f4 ff ff       	jmp    8010602a <alltraps>

80106b46 <vector39>:
.globl vector39
vector39:
  pushl $0
80106b46:	6a 00                	push   $0x0
  pushl $39
80106b48:	6a 27                	push   $0x27
  jmp alltraps
80106b4a:	e9 db f4 ff ff       	jmp    8010602a <alltraps>

80106b4f <vector40>:
.globl vector40
vector40:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $40
80106b51:	6a 28                	push   $0x28
  jmp alltraps
80106b53:	e9 d2 f4 ff ff       	jmp    8010602a <alltraps>

80106b58 <vector41>:
.globl vector41
vector41:
  pushl $0
80106b58:	6a 00                	push   $0x0
  pushl $41
80106b5a:	6a 29                	push   $0x29
  jmp alltraps
80106b5c:	e9 c9 f4 ff ff       	jmp    8010602a <alltraps>

80106b61 <vector42>:
.globl vector42
vector42:
  pushl $0
80106b61:	6a 00                	push   $0x0
  pushl $42
80106b63:	6a 2a                	push   $0x2a
  jmp alltraps
80106b65:	e9 c0 f4 ff ff       	jmp    8010602a <alltraps>

80106b6a <vector43>:
.globl vector43
vector43:
  pushl $0
80106b6a:	6a 00                	push   $0x0
  pushl $43
80106b6c:	6a 2b                	push   $0x2b
  jmp alltraps
80106b6e:	e9 b7 f4 ff ff       	jmp    8010602a <alltraps>

80106b73 <vector44>:
.globl vector44
vector44:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $44
80106b75:	6a 2c                	push   $0x2c
  jmp alltraps
80106b77:	e9 ae f4 ff ff       	jmp    8010602a <alltraps>

80106b7c <vector45>:
.globl vector45
vector45:
  pushl $0
80106b7c:	6a 00                	push   $0x0
  pushl $45
80106b7e:	6a 2d                	push   $0x2d
  jmp alltraps
80106b80:	e9 a5 f4 ff ff       	jmp    8010602a <alltraps>

80106b85 <vector46>:
.globl vector46
vector46:
  pushl $0
80106b85:	6a 00                	push   $0x0
  pushl $46
80106b87:	6a 2e                	push   $0x2e
  jmp alltraps
80106b89:	e9 9c f4 ff ff       	jmp    8010602a <alltraps>

80106b8e <vector47>:
.globl vector47
vector47:
  pushl $0
80106b8e:	6a 00                	push   $0x0
  pushl $47
80106b90:	6a 2f                	push   $0x2f
  jmp alltraps
80106b92:	e9 93 f4 ff ff       	jmp    8010602a <alltraps>

80106b97 <vector48>:
.globl vector48
vector48:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $48
80106b99:	6a 30                	push   $0x30
  jmp alltraps
80106b9b:	e9 8a f4 ff ff       	jmp    8010602a <alltraps>

80106ba0 <vector49>:
.globl vector49
vector49:
  pushl $0
80106ba0:	6a 00                	push   $0x0
  pushl $49
80106ba2:	6a 31                	push   $0x31
  jmp alltraps
80106ba4:	e9 81 f4 ff ff       	jmp    8010602a <alltraps>

80106ba9 <vector50>:
.globl vector50
vector50:
  pushl $0
80106ba9:	6a 00                	push   $0x0
  pushl $50
80106bab:	6a 32                	push   $0x32
  jmp alltraps
80106bad:	e9 78 f4 ff ff       	jmp    8010602a <alltraps>

80106bb2 <vector51>:
.globl vector51
vector51:
  pushl $0
80106bb2:	6a 00                	push   $0x0
  pushl $51
80106bb4:	6a 33                	push   $0x33
  jmp alltraps
80106bb6:	e9 6f f4 ff ff       	jmp    8010602a <alltraps>

80106bbb <vector52>:
.globl vector52
vector52:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $52
80106bbd:	6a 34                	push   $0x34
  jmp alltraps
80106bbf:	e9 66 f4 ff ff       	jmp    8010602a <alltraps>

80106bc4 <vector53>:
.globl vector53
vector53:
  pushl $0
80106bc4:	6a 00                	push   $0x0
  pushl $53
80106bc6:	6a 35                	push   $0x35
  jmp alltraps
80106bc8:	e9 5d f4 ff ff       	jmp    8010602a <alltraps>

80106bcd <vector54>:
.globl vector54
vector54:
  pushl $0
80106bcd:	6a 00                	push   $0x0
  pushl $54
80106bcf:	6a 36                	push   $0x36
  jmp alltraps
80106bd1:	e9 54 f4 ff ff       	jmp    8010602a <alltraps>

80106bd6 <vector55>:
.globl vector55
vector55:
  pushl $0
80106bd6:	6a 00                	push   $0x0
  pushl $55
80106bd8:	6a 37                	push   $0x37
  jmp alltraps
80106bda:	e9 4b f4 ff ff       	jmp    8010602a <alltraps>

80106bdf <vector56>:
.globl vector56
vector56:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $56
80106be1:	6a 38                	push   $0x38
  jmp alltraps
80106be3:	e9 42 f4 ff ff       	jmp    8010602a <alltraps>

80106be8 <vector57>:
.globl vector57
vector57:
  pushl $0
80106be8:	6a 00                	push   $0x0
  pushl $57
80106bea:	6a 39                	push   $0x39
  jmp alltraps
80106bec:	e9 39 f4 ff ff       	jmp    8010602a <alltraps>

80106bf1 <vector58>:
.globl vector58
vector58:
  pushl $0
80106bf1:	6a 00                	push   $0x0
  pushl $58
80106bf3:	6a 3a                	push   $0x3a
  jmp alltraps
80106bf5:	e9 30 f4 ff ff       	jmp    8010602a <alltraps>

80106bfa <vector59>:
.globl vector59
vector59:
  pushl $0
80106bfa:	6a 00                	push   $0x0
  pushl $59
80106bfc:	6a 3b                	push   $0x3b
  jmp alltraps
80106bfe:	e9 27 f4 ff ff       	jmp    8010602a <alltraps>

80106c03 <vector60>:
.globl vector60
vector60:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $60
80106c05:	6a 3c                	push   $0x3c
  jmp alltraps
80106c07:	e9 1e f4 ff ff       	jmp    8010602a <alltraps>

80106c0c <vector61>:
.globl vector61
vector61:
  pushl $0
80106c0c:	6a 00                	push   $0x0
  pushl $61
80106c0e:	6a 3d                	push   $0x3d
  jmp alltraps
80106c10:	e9 15 f4 ff ff       	jmp    8010602a <alltraps>

80106c15 <vector62>:
.globl vector62
vector62:
  pushl $0
80106c15:	6a 00                	push   $0x0
  pushl $62
80106c17:	6a 3e                	push   $0x3e
  jmp alltraps
80106c19:	e9 0c f4 ff ff       	jmp    8010602a <alltraps>

80106c1e <vector63>:
.globl vector63
vector63:
  pushl $0
80106c1e:	6a 00                	push   $0x0
  pushl $63
80106c20:	6a 3f                	push   $0x3f
  jmp alltraps
80106c22:	e9 03 f4 ff ff       	jmp    8010602a <alltraps>

80106c27 <vector64>:
.globl vector64
vector64:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $64
80106c29:	6a 40                	push   $0x40
  jmp alltraps
80106c2b:	e9 fa f3 ff ff       	jmp    8010602a <alltraps>

80106c30 <vector65>:
.globl vector65
vector65:
  pushl $0
80106c30:	6a 00                	push   $0x0
  pushl $65
80106c32:	6a 41                	push   $0x41
  jmp alltraps
80106c34:	e9 f1 f3 ff ff       	jmp    8010602a <alltraps>

80106c39 <vector66>:
.globl vector66
vector66:
  pushl $0
80106c39:	6a 00                	push   $0x0
  pushl $66
80106c3b:	6a 42                	push   $0x42
  jmp alltraps
80106c3d:	e9 e8 f3 ff ff       	jmp    8010602a <alltraps>

80106c42 <vector67>:
.globl vector67
vector67:
  pushl $0
80106c42:	6a 00                	push   $0x0
  pushl $67
80106c44:	6a 43                	push   $0x43
  jmp alltraps
80106c46:	e9 df f3 ff ff       	jmp    8010602a <alltraps>

80106c4b <vector68>:
.globl vector68
vector68:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $68
80106c4d:	6a 44                	push   $0x44
  jmp alltraps
80106c4f:	e9 d6 f3 ff ff       	jmp    8010602a <alltraps>

80106c54 <vector69>:
.globl vector69
vector69:
  pushl $0
80106c54:	6a 00                	push   $0x0
  pushl $69
80106c56:	6a 45                	push   $0x45
  jmp alltraps
80106c58:	e9 cd f3 ff ff       	jmp    8010602a <alltraps>

80106c5d <vector70>:
.globl vector70
vector70:
  pushl $0
80106c5d:	6a 00                	push   $0x0
  pushl $70
80106c5f:	6a 46                	push   $0x46
  jmp alltraps
80106c61:	e9 c4 f3 ff ff       	jmp    8010602a <alltraps>

80106c66 <vector71>:
.globl vector71
vector71:
  pushl $0
80106c66:	6a 00                	push   $0x0
  pushl $71
80106c68:	6a 47                	push   $0x47
  jmp alltraps
80106c6a:	e9 bb f3 ff ff       	jmp    8010602a <alltraps>

80106c6f <vector72>:
.globl vector72
vector72:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $72
80106c71:	6a 48                	push   $0x48
  jmp alltraps
80106c73:	e9 b2 f3 ff ff       	jmp    8010602a <alltraps>

80106c78 <vector73>:
.globl vector73
vector73:
  pushl $0
80106c78:	6a 00                	push   $0x0
  pushl $73
80106c7a:	6a 49                	push   $0x49
  jmp alltraps
80106c7c:	e9 a9 f3 ff ff       	jmp    8010602a <alltraps>

80106c81 <vector74>:
.globl vector74
vector74:
  pushl $0
80106c81:	6a 00                	push   $0x0
  pushl $74
80106c83:	6a 4a                	push   $0x4a
  jmp alltraps
80106c85:	e9 a0 f3 ff ff       	jmp    8010602a <alltraps>

80106c8a <vector75>:
.globl vector75
vector75:
  pushl $0
80106c8a:	6a 00                	push   $0x0
  pushl $75
80106c8c:	6a 4b                	push   $0x4b
  jmp alltraps
80106c8e:	e9 97 f3 ff ff       	jmp    8010602a <alltraps>

80106c93 <vector76>:
.globl vector76
vector76:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $76
80106c95:	6a 4c                	push   $0x4c
  jmp alltraps
80106c97:	e9 8e f3 ff ff       	jmp    8010602a <alltraps>

80106c9c <vector77>:
.globl vector77
vector77:
  pushl $0
80106c9c:	6a 00                	push   $0x0
  pushl $77
80106c9e:	6a 4d                	push   $0x4d
  jmp alltraps
80106ca0:	e9 85 f3 ff ff       	jmp    8010602a <alltraps>

80106ca5 <vector78>:
.globl vector78
vector78:
  pushl $0
80106ca5:	6a 00                	push   $0x0
  pushl $78
80106ca7:	6a 4e                	push   $0x4e
  jmp alltraps
80106ca9:	e9 7c f3 ff ff       	jmp    8010602a <alltraps>

80106cae <vector79>:
.globl vector79
vector79:
  pushl $0
80106cae:	6a 00                	push   $0x0
  pushl $79
80106cb0:	6a 4f                	push   $0x4f
  jmp alltraps
80106cb2:	e9 73 f3 ff ff       	jmp    8010602a <alltraps>

80106cb7 <vector80>:
.globl vector80
vector80:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $80
80106cb9:	6a 50                	push   $0x50
  jmp alltraps
80106cbb:	e9 6a f3 ff ff       	jmp    8010602a <alltraps>

80106cc0 <vector81>:
.globl vector81
vector81:
  pushl $0
80106cc0:	6a 00                	push   $0x0
  pushl $81
80106cc2:	6a 51                	push   $0x51
  jmp alltraps
80106cc4:	e9 61 f3 ff ff       	jmp    8010602a <alltraps>

80106cc9 <vector82>:
.globl vector82
vector82:
  pushl $0
80106cc9:	6a 00                	push   $0x0
  pushl $82
80106ccb:	6a 52                	push   $0x52
  jmp alltraps
80106ccd:	e9 58 f3 ff ff       	jmp    8010602a <alltraps>

80106cd2 <vector83>:
.globl vector83
vector83:
  pushl $0
80106cd2:	6a 00                	push   $0x0
  pushl $83
80106cd4:	6a 53                	push   $0x53
  jmp alltraps
80106cd6:	e9 4f f3 ff ff       	jmp    8010602a <alltraps>

80106cdb <vector84>:
.globl vector84
vector84:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $84
80106cdd:	6a 54                	push   $0x54
  jmp alltraps
80106cdf:	e9 46 f3 ff ff       	jmp    8010602a <alltraps>

80106ce4 <vector85>:
.globl vector85
vector85:
  pushl $0
80106ce4:	6a 00                	push   $0x0
  pushl $85
80106ce6:	6a 55                	push   $0x55
  jmp alltraps
80106ce8:	e9 3d f3 ff ff       	jmp    8010602a <alltraps>

80106ced <vector86>:
.globl vector86
vector86:
  pushl $0
80106ced:	6a 00                	push   $0x0
  pushl $86
80106cef:	6a 56                	push   $0x56
  jmp alltraps
80106cf1:	e9 34 f3 ff ff       	jmp    8010602a <alltraps>

80106cf6 <vector87>:
.globl vector87
vector87:
  pushl $0
80106cf6:	6a 00                	push   $0x0
  pushl $87
80106cf8:	6a 57                	push   $0x57
  jmp alltraps
80106cfa:	e9 2b f3 ff ff       	jmp    8010602a <alltraps>

80106cff <vector88>:
.globl vector88
vector88:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $88
80106d01:	6a 58                	push   $0x58
  jmp alltraps
80106d03:	e9 22 f3 ff ff       	jmp    8010602a <alltraps>

80106d08 <vector89>:
.globl vector89
vector89:
  pushl $0
80106d08:	6a 00                	push   $0x0
  pushl $89
80106d0a:	6a 59                	push   $0x59
  jmp alltraps
80106d0c:	e9 19 f3 ff ff       	jmp    8010602a <alltraps>

80106d11 <vector90>:
.globl vector90
vector90:
  pushl $0
80106d11:	6a 00                	push   $0x0
  pushl $90
80106d13:	6a 5a                	push   $0x5a
  jmp alltraps
80106d15:	e9 10 f3 ff ff       	jmp    8010602a <alltraps>

80106d1a <vector91>:
.globl vector91
vector91:
  pushl $0
80106d1a:	6a 00                	push   $0x0
  pushl $91
80106d1c:	6a 5b                	push   $0x5b
  jmp alltraps
80106d1e:	e9 07 f3 ff ff       	jmp    8010602a <alltraps>

80106d23 <vector92>:
.globl vector92
vector92:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $92
80106d25:	6a 5c                	push   $0x5c
  jmp alltraps
80106d27:	e9 fe f2 ff ff       	jmp    8010602a <alltraps>

80106d2c <vector93>:
.globl vector93
vector93:
  pushl $0
80106d2c:	6a 00                	push   $0x0
  pushl $93
80106d2e:	6a 5d                	push   $0x5d
  jmp alltraps
80106d30:	e9 f5 f2 ff ff       	jmp    8010602a <alltraps>

80106d35 <vector94>:
.globl vector94
vector94:
  pushl $0
80106d35:	6a 00                	push   $0x0
  pushl $94
80106d37:	6a 5e                	push   $0x5e
  jmp alltraps
80106d39:	e9 ec f2 ff ff       	jmp    8010602a <alltraps>

80106d3e <vector95>:
.globl vector95
vector95:
  pushl $0
80106d3e:	6a 00                	push   $0x0
  pushl $95
80106d40:	6a 5f                	push   $0x5f
  jmp alltraps
80106d42:	e9 e3 f2 ff ff       	jmp    8010602a <alltraps>

80106d47 <vector96>:
.globl vector96
vector96:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $96
80106d49:	6a 60                	push   $0x60
  jmp alltraps
80106d4b:	e9 da f2 ff ff       	jmp    8010602a <alltraps>

80106d50 <vector97>:
.globl vector97
vector97:
  pushl $0
80106d50:	6a 00                	push   $0x0
  pushl $97
80106d52:	6a 61                	push   $0x61
  jmp alltraps
80106d54:	e9 d1 f2 ff ff       	jmp    8010602a <alltraps>

80106d59 <vector98>:
.globl vector98
vector98:
  pushl $0
80106d59:	6a 00                	push   $0x0
  pushl $98
80106d5b:	6a 62                	push   $0x62
  jmp alltraps
80106d5d:	e9 c8 f2 ff ff       	jmp    8010602a <alltraps>

80106d62 <vector99>:
.globl vector99
vector99:
  pushl $0
80106d62:	6a 00                	push   $0x0
  pushl $99
80106d64:	6a 63                	push   $0x63
  jmp alltraps
80106d66:	e9 bf f2 ff ff       	jmp    8010602a <alltraps>

80106d6b <vector100>:
.globl vector100
vector100:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $100
80106d6d:	6a 64                	push   $0x64
  jmp alltraps
80106d6f:	e9 b6 f2 ff ff       	jmp    8010602a <alltraps>

80106d74 <vector101>:
.globl vector101
vector101:
  pushl $0
80106d74:	6a 00                	push   $0x0
  pushl $101
80106d76:	6a 65                	push   $0x65
  jmp alltraps
80106d78:	e9 ad f2 ff ff       	jmp    8010602a <alltraps>

80106d7d <vector102>:
.globl vector102
vector102:
  pushl $0
80106d7d:	6a 00                	push   $0x0
  pushl $102
80106d7f:	6a 66                	push   $0x66
  jmp alltraps
80106d81:	e9 a4 f2 ff ff       	jmp    8010602a <alltraps>

80106d86 <vector103>:
.globl vector103
vector103:
  pushl $0
80106d86:	6a 00                	push   $0x0
  pushl $103
80106d88:	6a 67                	push   $0x67
  jmp alltraps
80106d8a:	e9 9b f2 ff ff       	jmp    8010602a <alltraps>

80106d8f <vector104>:
.globl vector104
vector104:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $104
80106d91:	6a 68                	push   $0x68
  jmp alltraps
80106d93:	e9 92 f2 ff ff       	jmp    8010602a <alltraps>

80106d98 <vector105>:
.globl vector105
vector105:
  pushl $0
80106d98:	6a 00                	push   $0x0
  pushl $105
80106d9a:	6a 69                	push   $0x69
  jmp alltraps
80106d9c:	e9 89 f2 ff ff       	jmp    8010602a <alltraps>

80106da1 <vector106>:
.globl vector106
vector106:
  pushl $0
80106da1:	6a 00                	push   $0x0
  pushl $106
80106da3:	6a 6a                	push   $0x6a
  jmp alltraps
80106da5:	e9 80 f2 ff ff       	jmp    8010602a <alltraps>

80106daa <vector107>:
.globl vector107
vector107:
  pushl $0
80106daa:	6a 00                	push   $0x0
  pushl $107
80106dac:	6a 6b                	push   $0x6b
  jmp alltraps
80106dae:	e9 77 f2 ff ff       	jmp    8010602a <alltraps>

80106db3 <vector108>:
.globl vector108
vector108:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $108
80106db5:	6a 6c                	push   $0x6c
  jmp alltraps
80106db7:	e9 6e f2 ff ff       	jmp    8010602a <alltraps>

80106dbc <vector109>:
.globl vector109
vector109:
  pushl $0
80106dbc:	6a 00                	push   $0x0
  pushl $109
80106dbe:	6a 6d                	push   $0x6d
  jmp alltraps
80106dc0:	e9 65 f2 ff ff       	jmp    8010602a <alltraps>

80106dc5 <vector110>:
.globl vector110
vector110:
  pushl $0
80106dc5:	6a 00                	push   $0x0
  pushl $110
80106dc7:	6a 6e                	push   $0x6e
  jmp alltraps
80106dc9:	e9 5c f2 ff ff       	jmp    8010602a <alltraps>

80106dce <vector111>:
.globl vector111
vector111:
  pushl $0
80106dce:	6a 00                	push   $0x0
  pushl $111
80106dd0:	6a 6f                	push   $0x6f
  jmp alltraps
80106dd2:	e9 53 f2 ff ff       	jmp    8010602a <alltraps>

80106dd7 <vector112>:
.globl vector112
vector112:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $112
80106dd9:	6a 70                	push   $0x70
  jmp alltraps
80106ddb:	e9 4a f2 ff ff       	jmp    8010602a <alltraps>

80106de0 <vector113>:
.globl vector113
vector113:
  pushl $0
80106de0:	6a 00                	push   $0x0
  pushl $113
80106de2:	6a 71                	push   $0x71
  jmp alltraps
80106de4:	e9 41 f2 ff ff       	jmp    8010602a <alltraps>

80106de9 <vector114>:
.globl vector114
vector114:
  pushl $0
80106de9:	6a 00                	push   $0x0
  pushl $114
80106deb:	6a 72                	push   $0x72
  jmp alltraps
80106ded:	e9 38 f2 ff ff       	jmp    8010602a <alltraps>

80106df2 <vector115>:
.globl vector115
vector115:
  pushl $0
80106df2:	6a 00                	push   $0x0
  pushl $115
80106df4:	6a 73                	push   $0x73
  jmp alltraps
80106df6:	e9 2f f2 ff ff       	jmp    8010602a <alltraps>

80106dfb <vector116>:
.globl vector116
vector116:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $116
80106dfd:	6a 74                	push   $0x74
  jmp alltraps
80106dff:	e9 26 f2 ff ff       	jmp    8010602a <alltraps>

80106e04 <vector117>:
.globl vector117
vector117:
  pushl $0
80106e04:	6a 00                	push   $0x0
  pushl $117
80106e06:	6a 75                	push   $0x75
  jmp alltraps
80106e08:	e9 1d f2 ff ff       	jmp    8010602a <alltraps>

80106e0d <vector118>:
.globl vector118
vector118:
  pushl $0
80106e0d:	6a 00                	push   $0x0
  pushl $118
80106e0f:	6a 76                	push   $0x76
  jmp alltraps
80106e11:	e9 14 f2 ff ff       	jmp    8010602a <alltraps>

80106e16 <vector119>:
.globl vector119
vector119:
  pushl $0
80106e16:	6a 00                	push   $0x0
  pushl $119
80106e18:	6a 77                	push   $0x77
  jmp alltraps
80106e1a:	e9 0b f2 ff ff       	jmp    8010602a <alltraps>

80106e1f <vector120>:
.globl vector120
vector120:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $120
80106e21:	6a 78                	push   $0x78
  jmp alltraps
80106e23:	e9 02 f2 ff ff       	jmp    8010602a <alltraps>

80106e28 <vector121>:
.globl vector121
vector121:
  pushl $0
80106e28:	6a 00                	push   $0x0
  pushl $121
80106e2a:	6a 79                	push   $0x79
  jmp alltraps
80106e2c:	e9 f9 f1 ff ff       	jmp    8010602a <alltraps>

80106e31 <vector122>:
.globl vector122
vector122:
  pushl $0
80106e31:	6a 00                	push   $0x0
  pushl $122
80106e33:	6a 7a                	push   $0x7a
  jmp alltraps
80106e35:	e9 f0 f1 ff ff       	jmp    8010602a <alltraps>

80106e3a <vector123>:
.globl vector123
vector123:
  pushl $0
80106e3a:	6a 00                	push   $0x0
  pushl $123
80106e3c:	6a 7b                	push   $0x7b
  jmp alltraps
80106e3e:	e9 e7 f1 ff ff       	jmp    8010602a <alltraps>

80106e43 <vector124>:
.globl vector124
vector124:
  pushl $0
80106e43:	6a 00                	push   $0x0
  pushl $124
80106e45:	6a 7c                	push   $0x7c
  jmp alltraps
80106e47:	e9 de f1 ff ff       	jmp    8010602a <alltraps>

80106e4c <vector125>:
.globl vector125
vector125:
  pushl $0
80106e4c:	6a 00                	push   $0x0
  pushl $125
80106e4e:	6a 7d                	push   $0x7d
  jmp alltraps
80106e50:	e9 d5 f1 ff ff       	jmp    8010602a <alltraps>

80106e55 <vector126>:
.globl vector126
vector126:
  pushl $0
80106e55:	6a 00                	push   $0x0
  pushl $126
80106e57:	6a 7e                	push   $0x7e
  jmp alltraps
80106e59:	e9 cc f1 ff ff       	jmp    8010602a <alltraps>

80106e5e <vector127>:
.globl vector127
vector127:
  pushl $0
80106e5e:	6a 00                	push   $0x0
  pushl $127
80106e60:	6a 7f                	push   $0x7f
  jmp alltraps
80106e62:	e9 c3 f1 ff ff       	jmp    8010602a <alltraps>

80106e67 <vector128>:
.globl vector128
vector128:
  pushl $0
80106e67:	6a 00                	push   $0x0
  pushl $128
80106e69:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106e6e:	e9 b7 f1 ff ff       	jmp    8010602a <alltraps>

80106e73 <vector129>:
.globl vector129
vector129:
  pushl $0
80106e73:	6a 00                	push   $0x0
  pushl $129
80106e75:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106e7a:	e9 ab f1 ff ff       	jmp    8010602a <alltraps>

80106e7f <vector130>:
.globl vector130
vector130:
  pushl $0
80106e7f:	6a 00                	push   $0x0
  pushl $130
80106e81:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106e86:	e9 9f f1 ff ff       	jmp    8010602a <alltraps>

80106e8b <vector131>:
.globl vector131
vector131:
  pushl $0
80106e8b:	6a 00                	push   $0x0
  pushl $131
80106e8d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106e92:	e9 93 f1 ff ff       	jmp    8010602a <alltraps>

80106e97 <vector132>:
.globl vector132
vector132:
  pushl $0
80106e97:	6a 00                	push   $0x0
  pushl $132
80106e99:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106e9e:	e9 87 f1 ff ff       	jmp    8010602a <alltraps>

80106ea3 <vector133>:
.globl vector133
vector133:
  pushl $0
80106ea3:	6a 00                	push   $0x0
  pushl $133
80106ea5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106eaa:	e9 7b f1 ff ff       	jmp    8010602a <alltraps>

80106eaf <vector134>:
.globl vector134
vector134:
  pushl $0
80106eaf:	6a 00                	push   $0x0
  pushl $134
80106eb1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106eb6:	e9 6f f1 ff ff       	jmp    8010602a <alltraps>

80106ebb <vector135>:
.globl vector135
vector135:
  pushl $0
80106ebb:	6a 00                	push   $0x0
  pushl $135
80106ebd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106ec2:	e9 63 f1 ff ff       	jmp    8010602a <alltraps>

80106ec7 <vector136>:
.globl vector136
vector136:
  pushl $0
80106ec7:	6a 00                	push   $0x0
  pushl $136
80106ec9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106ece:	e9 57 f1 ff ff       	jmp    8010602a <alltraps>

80106ed3 <vector137>:
.globl vector137
vector137:
  pushl $0
80106ed3:	6a 00                	push   $0x0
  pushl $137
80106ed5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106eda:	e9 4b f1 ff ff       	jmp    8010602a <alltraps>

80106edf <vector138>:
.globl vector138
vector138:
  pushl $0
80106edf:	6a 00                	push   $0x0
  pushl $138
80106ee1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106ee6:	e9 3f f1 ff ff       	jmp    8010602a <alltraps>

80106eeb <vector139>:
.globl vector139
vector139:
  pushl $0
80106eeb:	6a 00                	push   $0x0
  pushl $139
80106eed:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106ef2:	e9 33 f1 ff ff       	jmp    8010602a <alltraps>

80106ef7 <vector140>:
.globl vector140
vector140:
  pushl $0
80106ef7:	6a 00                	push   $0x0
  pushl $140
80106ef9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106efe:	e9 27 f1 ff ff       	jmp    8010602a <alltraps>

80106f03 <vector141>:
.globl vector141
vector141:
  pushl $0
80106f03:	6a 00                	push   $0x0
  pushl $141
80106f05:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106f0a:	e9 1b f1 ff ff       	jmp    8010602a <alltraps>

80106f0f <vector142>:
.globl vector142
vector142:
  pushl $0
80106f0f:	6a 00                	push   $0x0
  pushl $142
80106f11:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106f16:	e9 0f f1 ff ff       	jmp    8010602a <alltraps>

80106f1b <vector143>:
.globl vector143
vector143:
  pushl $0
80106f1b:	6a 00                	push   $0x0
  pushl $143
80106f1d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106f22:	e9 03 f1 ff ff       	jmp    8010602a <alltraps>

80106f27 <vector144>:
.globl vector144
vector144:
  pushl $0
80106f27:	6a 00                	push   $0x0
  pushl $144
80106f29:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106f2e:	e9 f7 f0 ff ff       	jmp    8010602a <alltraps>

80106f33 <vector145>:
.globl vector145
vector145:
  pushl $0
80106f33:	6a 00                	push   $0x0
  pushl $145
80106f35:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106f3a:	e9 eb f0 ff ff       	jmp    8010602a <alltraps>

80106f3f <vector146>:
.globl vector146
vector146:
  pushl $0
80106f3f:	6a 00                	push   $0x0
  pushl $146
80106f41:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106f46:	e9 df f0 ff ff       	jmp    8010602a <alltraps>

80106f4b <vector147>:
.globl vector147
vector147:
  pushl $0
80106f4b:	6a 00                	push   $0x0
  pushl $147
80106f4d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106f52:	e9 d3 f0 ff ff       	jmp    8010602a <alltraps>

80106f57 <vector148>:
.globl vector148
vector148:
  pushl $0
80106f57:	6a 00                	push   $0x0
  pushl $148
80106f59:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106f5e:	e9 c7 f0 ff ff       	jmp    8010602a <alltraps>

80106f63 <vector149>:
.globl vector149
vector149:
  pushl $0
80106f63:	6a 00                	push   $0x0
  pushl $149
80106f65:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106f6a:	e9 bb f0 ff ff       	jmp    8010602a <alltraps>

80106f6f <vector150>:
.globl vector150
vector150:
  pushl $0
80106f6f:	6a 00                	push   $0x0
  pushl $150
80106f71:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106f76:	e9 af f0 ff ff       	jmp    8010602a <alltraps>

80106f7b <vector151>:
.globl vector151
vector151:
  pushl $0
80106f7b:	6a 00                	push   $0x0
  pushl $151
80106f7d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106f82:	e9 a3 f0 ff ff       	jmp    8010602a <alltraps>

80106f87 <vector152>:
.globl vector152
vector152:
  pushl $0
80106f87:	6a 00                	push   $0x0
  pushl $152
80106f89:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106f8e:	e9 97 f0 ff ff       	jmp    8010602a <alltraps>

80106f93 <vector153>:
.globl vector153
vector153:
  pushl $0
80106f93:	6a 00                	push   $0x0
  pushl $153
80106f95:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106f9a:	e9 8b f0 ff ff       	jmp    8010602a <alltraps>

80106f9f <vector154>:
.globl vector154
vector154:
  pushl $0
80106f9f:	6a 00                	push   $0x0
  pushl $154
80106fa1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106fa6:	e9 7f f0 ff ff       	jmp    8010602a <alltraps>

80106fab <vector155>:
.globl vector155
vector155:
  pushl $0
80106fab:	6a 00                	push   $0x0
  pushl $155
80106fad:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106fb2:	e9 73 f0 ff ff       	jmp    8010602a <alltraps>

80106fb7 <vector156>:
.globl vector156
vector156:
  pushl $0
80106fb7:	6a 00                	push   $0x0
  pushl $156
80106fb9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106fbe:	e9 67 f0 ff ff       	jmp    8010602a <alltraps>

80106fc3 <vector157>:
.globl vector157
vector157:
  pushl $0
80106fc3:	6a 00                	push   $0x0
  pushl $157
80106fc5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106fca:	e9 5b f0 ff ff       	jmp    8010602a <alltraps>

80106fcf <vector158>:
.globl vector158
vector158:
  pushl $0
80106fcf:	6a 00                	push   $0x0
  pushl $158
80106fd1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106fd6:	e9 4f f0 ff ff       	jmp    8010602a <alltraps>

80106fdb <vector159>:
.globl vector159
vector159:
  pushl $0
80106fdb:	6a 00                	push   $0x0
  pushl $159
80106fdd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106fe2:	e9 43 f0 ff ff       	jmp    8010602a <alltraps>

80106fe7 <vector160>:
.globl vector160
vector160:
  pushl $0
80106fe7:	6a 00                	push   $0x0
  pushl $160
80106fe9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106fee:	e9 37 f0 ff ff       	jmp    8010602a <alltraps>

80106ff3 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ff3:	6a 00                	push   $0x0
  pushl $161
80106ff5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106ffa:	e9 2b f0 ff ff       	jmp    8010602a <alltraps>

80106fff <vector162>:
.globl vector162
vector162:
  pushl $0
80106fff:	6a 00                	push   $0x0
  pushl $162
80107001:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107006:	e9 1f f0 ff ff       	jmp    8010602a <alltraps>

8010700b <vector163>:
.globl vector163
vector163:
  pushl $0
8010700b:	6a 00                	push   $0x0
  pushl $163
8010700d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107012:	e9 13 f0 ff ff       	jmp    8010602a <alltraps>

80107017 <vector164>:
.globl vector164
vector164:
  pushl $0
80107017:	6a 00                	push   $0x0
  pushl $164
80107019:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010701e:	e9 07 f0 ff ff       	jmp    8010602a <alltraps>

80107023 <vector165>:
.globl vector165
vector165:
  pushl $0
80107023:	6a 00                	push   $0x0
  pushl $165
80107025:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010702a:	e9 fb ef ff ff       	jmp    8010602a <alltraps>

8010702f <vector166>:
.globl vector166
vector166:
  pushl $0
8010702f:	6a 00                	push   $0x0
  pushl $166
80107031:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107036:	e9 ef ef ff ff       	jmp    8010602a <alltraps>

8010703b <vector167>:
.globl vector167
vector167:
  pushl $0
8010703b:	6a 00                	push   $0x0
  pushl $167
8010703d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107042:	e9 e3 ef ff ff       	jmp    8010602a <alltraps>

80107047 <vector168>:
.globl vector168
vector168:
  pushl $0
80107047:	6a 00                	push   $0x0
  pushl $168
80107049:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010704e:	e9 d7 ef ff ff       	jmp    8010602a <alltraps>

80107053 <vector169>:
.globl vector169
vector169:
  pushl $0
80107053:	6a 00                	push   $0x0
  pushl $169
80107055:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010705a:	e9 cb ef ff ff       	jmp    8010602a <alltraps>

8010705f <vector170>:
.globl vector170
vector170:
  pushl $0
8010705f:	6a 00                	push   $0x0
  pushl $170
80107061:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107066:	e9 bf ef ff ff       	jmp    8010602a <alltraps>

8010706b <vector171>:
.globl vector171
vector171:
  pushl $0
8010706b:	6a 00                	push   $0x0
  pushl $171
8010706d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107072:	e9 b3 ef ff ff       	jmp    8010602a <alltraps>

80107077 <vector172>:
.globl vector172
vector172:
  pushl $0
80107077:	6a 00                	push   $0x0
  pushl $172
80107079:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010707e:	e9 a7 ef ff ff       	jmp    8010602a <alltraps>

80107083 <vector173>:
.globl vector173
vector173:
  pushl $0
80107083:	6a 00                	push   $0x0
  pushl $173
80107085:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010708a:	e9 9b ef ff ff       	jmp    8010602a <alltraps>

8010708f <vector174>:
.globl vector174
vector174:
  pushl $0
8010708f:	6a 00                	push   $0x0
  pushl $174
80107091:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107096:	e9 8f ef ff ff       	jmp    8010602a <alltraps>

8010709b <vector175>:
.globl vector175
vector175:
  pushl $0
8010709b:	6a 00                	push   $0x0
  pushl $175
8010709d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801070a2:	e9 83 ef ff ff       	jmp    8010602a <alltraps>

801070a7 <vector176>:
.globl vector176
vector176:
  pushl $0
801070a7:	6a 00                	push   $0x0
  pushl $176
801070a9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801070ae:	e9 77 ef ff ff       	jmp    8010602a <alltraps>

801070b3 <vector177>:
.globl vector177
vector177:
  pushl $0
801070b3:	6a 00                	push   $0x0
  pushl $177
801070b5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801070ba:	e9 6b ef ff ff       	jmp    8010602a <alltraps>

801070bf <vector178>:
.globl vector178
vector178:
  pushl $0
801070bf:	6a 00                	push   $0x0
  pushl $178
801070c1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801070c6:	e9 5f ef ff ff       	jmp    8010602a <alltraps>

801070cb <vector179>:
.globl vector179
vector179:
  pushl $0
801070cb:	6a 00                	push   $0x0
  pushl $179
801070cd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801070d2:	e9 53 ef ff ff       	jmp    8010602a <alltraps>

801070d7 <vector180>:
.globl vector180
vector180:
  pushl $0
801070d7:	6a 00                	push   $0x0
  pushl $180
801070d9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801070de:	e9 47 ef ff ff       	jmp    8010602a <alltraps>

801070e3 <vector181>:
.globl vector181
vector181:
  pushl $0
801070e3:	6a 00                	push   $0x0
  pushl $181
801070e5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801070ea:	e9 3b ef ff ff       	jmp    8010602a <alltraps>

801070ef <vector182>:
.globl vector182
vector182:
  pushl $0
801070ef:	6a 00                	push   $0x0
  pushl $182
801070f1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801070f6:	e9 2f ef ff ff       	jmp    8010602a <alltraps>

801070fb <vector183>:
.globl vector183
vector183:
  pushl $0
801070fb:	6a 00                	push   $0x0
  pushl $183
801070fd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107102:	e9 23 ef ff ff       	jmp    8010602a <alltraps>

80107107 <vector184>:
.globl vector184
vector184:
  pushl $0
80107107:	6a 00                	push   $0x0
  pushl $184
80107109:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010710e:	e9 17 ef ff ff       	jmp    8010602a <alltraps>

80107113 <vector185>:
.globl vector185
vector185:
  pushl $0
80107113:	6a 00                	push   $0x0
  pushl $185
80107115:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010711a:	e9 0b ef ff ff       	jmp    8010602a <alltraps>

8010711f <vector186>:
.globl vector186
vector186:
  pushl $0
8010711f:	6a 00                	push   $0x0
  pushl $186
80107121:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107126:	e9 ff ee ff ff       	jmp    8010602a <alltraps>

8010712b <vector187>:
.globl vector187
vector187:
  pushl $0
8010712b:	6a 00                	push   $0x0
  pushl $187
8010712d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107132:	e9 f3 ee ff ff       	jmp    8010602a <alltraps>

80107137 <vector188>:
.globl vector188
vector188:
  pushl $0
80107137:	6a 00                	push   $0x0
  pushl $188
80107139:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010713e:	e9 e7 ee ff ff       	jmp    8010602a <alltraps>

80107143 <vector189>:
.globl vector189
vector189:
  pushl $0
80107143:	6a 00                	push   $0x0
  pushl $189
80107145:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010714a:	e9 db ee ff ff       	jmp    8010602a <alltraps>

8010714f <vector190>:
.globl vector190
vector190:
  pushl $0
8010714f:	6a 00                	push   $0x0
  pushl $190
80107151:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107156:	e9 cf ee ff ff       	jmp    8010602a <alltraps>

8010715b <vector191>:
.globl vector191
vector191:
  pushl $0
8010715b:	6a 00                	push   $0x0
  pushl $191
8010715d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107162:	e9 c3 ee ff ff       	jmp    8010602a <alltraps>

80107167 <vector192>:
.globl vector192
vector192:
  pushl $0
80107167:	6a 00                	push   $0x0
  pushl $192
80107169:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010716e:	e9 b7 ee ff ff       	jmp    8010602a <alltraps>

80107173 <vector193>:
.globl vector193
vector193:
  pushl $0
80107173:	6a 00                	push   $0x0
  pushl $193
80107175:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010717a:	e9 ab ee ff ff       	jmp    8010602a <alltraps>

8010717f <vector194>:
.globl vector194
vector194:
  pushl $0
8010717f:	6a 00                	push   $0x0
  pushl $194
80107181:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107186:	e9 9f ee ff ff       	jmp    8010602a <alltraps>

8010718b <vector195>:
.globl vector195
vector195:
  pushl $0
8010718b:	6a 00                	push   $0x0
  pushl $195
8010718d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107192:	e9 93 ee ff ff       	jmp    8010602a <alltraps>

80107197 <vector196>:
.globl vector196
vector196:
  pushl $0
80107197:	6a 00                	push   $0x0
  pushl $196
80107199:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010719e:	e9 87 ee ff ff       	jmp    8010602a <alltraps>

801071a3 <vector197>:
.globl vector197
vector197:
  pushl $0
801071a3:	6a 00                	push   $0x0
  pushl $197
801071a5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801071aa:	e9 7b ee ff ff       	jmp    8010602a <alltraps>

801071af <vector198>:
.globl vector198
vector198:
  pushl $0
801071af:	6a 00                	push   $0x0
  pushl $198
801071b1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801071b6:	e9 6f ee ff ff       	jmp    8010602a <alltraps>

801071bb <vector199>:
.globl vector199
vector199:
  pushl $0
801071bb:	6a 00                	push   $0x0
  pushl $199
801071bd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801071c2:	e9 63 ee ff ff       	jmp    8010602a <alltraps>

801071c7 <vector200>:
.globl vector200
vector200:
  pushl $0
801071c7:	6a 00                	push   $0x0
  pushl $200
801071c9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801071ce:	e9 57 ee ff ff       	jmp    8010602a <alltraps>

801071d3 <vector201>:
.globl vector201
vector201:
  pushl $0
801071d3:	6a 00                	push   $0x0
  pushl $201
801071d5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801071da:	e9 4b ee ff ff       	jmp    8010602a <alltraps>

801071df <vector202>:
.globl vector202
vector202:
  pushl $0
801071df:	6a 00                	push   $0x0
  pushl $202
801071e1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801071e6:	e9 3f ee ff ff       	jmp    8010602a <alltraps>

801071eb <vector203>:
.globl vector203
vector203:
  pushl $0
801071eb:	6a 00                	push   $0x0
  pushl $203
801071ed:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801071f2:	e9 33 ee ff ff       	jmp    8010602a <alltraps>

801071f7 <vector204>:
.globl vector204
vector204:
  pushl $0
801071f7:	6a 00                	push   $0x0
  pushl $204
801071f9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801071fe:	e9 27 ee ff ff       	jmp    8010602a <alltraps>

80107203 <vector205>:
.globl vector205
vector205:
  pushl $0
80107203:	6a 00                	push   $0x0
  pushl $205
80107205:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010720a:	e9 1b ee ff ff       	jmp    8010602a <alltraps>

8010720f <vector206>:
.globl vector206
vector206:
  pushl $0
8010720f:	6a 00                	push   $0x0
  pushl $206
80107211:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107216:	e9 0f ee ff ff       	jmp    8010602a <alltraps>

8010721b <vector207>:
.globl vector207
vector207:
  pushl $0
8010721b:	6a 00                	push   $0x0
  pushl $207
8010721d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107222:	e9 03 ee ff ff       	jmp    8010602a <alltraps>

80107227 <vector208>:
.globl vector208
vector208:
  pushl $0
80107227:	6a 00                	push   $0x0
  pushl $208
80107229:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010722e:	e9 f7 ed ff ff       	jmp    8010602a <alltraps>

80107233 <vector209>:
.globl vector209
vector209:
  pushl $0
80107233:	6a 00                	push   $0x0
  pushl $209
80107235:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010723a:	e9 eb ed ff ff       	jmp    8010602a <alltraps>

8010723f <vector210>:
.globl vector210
vector210:
  pushl $0
8010723f:	6a 00                	push   $0x0
  pushl $210
80107241:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107246:	e9 df ed ff ff       	jmp    8010602a <alltraps>

8010724b <vector211>:
.globl vector211
vector211:
  pushl $0
8010724b:	6a 00                	push   $0x0
  pushl $211
8010724d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107252:	e9 d3 ed ff ff       	jmp    8010602a <alltraps>

80107257 <vector212>:
.globl vector212
vector212:
  pushl $0
80107257:	6a 00                	push   $0x0
  pushl $212
80107259:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010725e:	e9 c7 ed ff ff       	jmp    8010602a <alltraps>

80107263 <vector213>:
.globl vector213
vector213:
  pushl $0
80107263:	6a 00                	push   $0x0
  pushl $213
80107265:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010726a:	e9 bb ed ff ff       	jmp    8010602a <alltraps>

8010726f <vector214>:
.globl vector214
vector214:
  pushl $0
8010726f:	6a 00                	push   $0x0
  pushl $214
80107271:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107276:	e9 af ed ff ff       	jmp    8010602a <alltraps>

8010727b <vector215>:
.globl vector215
vector215:
  pushl $0
8010727b:	6a 00                	push   $0x0
  pushl $215
8010727d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107282:	e9 a3 ed ff ff       	jmp    8010602a <alltraps>

80107287 <vector216>:
.globl vector216
vector216:
  pushl $0
80107287:	6a 00                	push   $0x0
  pushl $216
80107289:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010728e:	e9 97 ed ff ff       	jmp    8010602a <alltraps>

80107293 <vector217>:
.globl vector217
vector217:
  pushl $0
80107293:	6a 00                	push   $0x0
  pushl $217
80107295:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010729a:	e9 8b ed ff ff       	jmp    8010602a <alltraps>

8010729f <vector218>:
.globl vector218
vector218:
  pushl $0
8010729f:	6a 00                	push   $0x0
  pushl $218
801072a1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801072a6:	e9 7f ed ff ff       	jmp    8010602a <alltraps>

801072ab <vector219>:
.globl vector219
vector219:
  pushl $0
801072ab:	6a 00                	push   $0x0
  pushl $219
801072ad:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801072b2:	e9 73 ed ff ff       	jmp    8010602a <alltraps>

801072b7 <vector220>:
.globl vector220
vector220:
  pushl $0
801072b7:	6a 00                	push   $0x0
  pushl $220
801072b9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801072be:	e9 67 ed ff ff       	jmp    8010602a <alltraps>

801072c3 <vector221>:
.globl vector221
vector221:
  pushl $0
801072c3:	6a 00                	push   $0x0
  pushl $221
801072c5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801072ca:	e9 5b ed ff ff       	jmp    8010602a <alltraps>

801072cf <vector222>:
.globl vector222
vector222:
  pushl $0
801072cf:	6a 00                	push   $0x0
  pushl $222
801072d1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801072d6:	e9 4f ed ff ff       	jmp    8010602a <alltraps>

801072db <vector223>:
.globl vector223
vector223:
  pushl $0
801072db:	6a 00                	push   $0x0
  pushl $223
801072dd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801072e2:	e9 43 ed ff ff       	jmp    8010602a <alltraps>

801072e7 <vector224>:
.globl vector224
vector224:
  pushl $0
801072e7:	6a 00                	push   $0x0
  pushl $224
801072e9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801072ee:	e9 37 ed ff ff       	jmp    8010602a <alltraps>

801072f3 <vector225>:
.globl vector225
vector225:
  pushl $0
801072f3:	6a 00                	push   $0x0
  pushl $225
801072f5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801072fa:	e9 2b ed ff ff       	jmp    8010602a <alltraps>

801072ff <vector226>:
.globl vector226
vector226:
  pushl $0
801072ff:	6a 00                	push   $0x0
  pushl $226
80107301:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107306:	e9 1f ed ff ff       	jmp    8010602a <alltraps>

8010730b <vector227>:
.globl vector227
vector227:
  pushl $0
8010730b:	6a 00                	push   $0x0
  pushl $227
8010730d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107312:	e9 13 ed ff ff       	jmp    8010602a <alltraps>

80107317 <vector228>:
.globl vector228
vector228:
  pushl $0
80107317:	6a 00                	push   $0x0
  pushl $228
80107319:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010731e:	e9 07 ed ff ff       	jmp    8010602a <alltraps>

80107323 <vector229>:
.globl vector229
vector229:
  pushl $0
80107323:	6a 00                	push   $0x0
  pushl $229
80107325:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010732a:	e9 fb ec ff ff       	jmp    8010602a <alltraps>

8010732f <vector230>:
.globl vector230
vector230:
  pushl $0
8010732f:	6a 00                	push   $0x0
  pushl $230
80107331:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107336:	e9 ef ec ff ff       	jmp    8010602a <alltraps>

8010733b <vector231>:
.globl vector231
vector231:
  pushl $0
8010733b:	6a 00                	push   $0x0
  pushl $231
8010733d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107342:	e9 e3 ec ff ff       	jmp    8010602a <alltraps>

80107347 <vector232>:
.globl vector232
vector232:
  pushl $0
80107347:	6a 00                	push   $0x0
  pushl $232
80107349:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010734e:	e9 d7 ec ff ff       	jmp    8010602a <alltraps>

80107353 <vector233>:
.globl vector233
vector233:
  pushl $0
80107353:	6a 00                	push   $0x0
  pushl $233
80107355:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010735a:	e9 cb ec ff ff       	jmp    8010602a <alltraps>

8010735f <vector234>:
.globl vector234
vector234:
  pushl $0
8010735f:	6a 00                	push   $0x0
  pushl $234
80107361:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107366:	e9 bf ec ff ff       	jmp    8010602a <alltraps>

8010736b <vector235>:
.globl vector235
vector235:
  pushl $0
8010736b:	6a 00                	push   $0x0
  pushl $235
8010736d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107372:	e9 b3 ec ff ff       	jmp    8010602a <alltraps>

80107377 <vector236>:
.globl vector236
vector236:
  pushl $0
80107377:	6a 00                	push   $0x0
  pushl $236
80107379:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010737e:	e9 a7 ec ff ff       	jmp    8010602a <alltraps>

80107383 <vector237>:
.globl vector237
vector237:
  pushl $0
80107383:	6a 00                	push   $0x0
  pushl $237
80107385:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010738a:	e9 9b ec ff ff       	jmp    8010602a <alltraps>

8010738f <vector238>:
.globl vector238
vector238:
  pushl $0
8010738f:	6a 00                	push   $0x0
  pushl $238
80107391:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107396:	e9 8f ec ff ff       	jmp    8010602a <alltraps>

8010739b <vector239>:
.globl vector239
vector239:
  pushl $0
8010739b:	6a 00                	push   $0x0
  pushl $239
8010739d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801073a2:	e9 83 ec ff ff       	jmp    8010602a <alltraps>

801073a7 <vector240>:
.globl vector240
vector240:
  pushl $0
801073a7:	6a 00                	push   $0x0
  pushl $240
801073a9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801073ae:	e9 77 ec ff ff       	jmp    8010602a <alltraps>

801073b3 <vector241>:
.globl vector241
vector241:
  pushl $0
801073b3:	6a 00                	push   $0x0
  pushl $241
801073b5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801073ba:	e9 6b ec ff ff       	jmp    8010602a <alltraps>

801073bf <vector242>:
.globl vector242
vector242:
  pushl $0
801073bf:	6a 00                	push   $0x0
  pushl $242
801073c1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801073c6:	e9 5f ec ff ff       	jmp    8010602a <alltraps>

801073cb <vector243>:
.globl vector243
vector243:
  pushl $0
801073cb:	6a 00                	push   $0x0
  pushl $243
801073cd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801073d2:	e9 53 ec ff ff       	jmp    8010602a <alltraps>

801073d7 <vector244>:
.globl vector244
vector244:
  pushl $0
801073d7:	6a 00                	push   $0x0
  pushl $244
801073d9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801073de:	e9 47 ec ff ff       	jmp    8010602a <alltraps>

801073e3 <vector245>:
.globl vector245
vector245:
  pushl $0
801073e3:	6a 00                	push   $0x0
  pushl $245
801073e5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801073ea:	e9 3b ec ff ff       	jmp    8010602a <alltraps>

801073ef <vector246>:
.globl vector246
vector246:
  pushl $0
801073ef:	6a 00                	push   $0x0
  pushl $246
801073f1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801073f6:	e9 2f ec ff ff       	jmp    8010602a <alltraps>

801073fb <vector247>:
.globl vector247
vector247:
  pushl $0
801073fb:	6a 00                	push   $0x0
  pushl $247
801073fd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107402:	e9 23 ec ff ff       	jmp    8010602a <alltraps>

80107407 <vector248>:
.globl vector248
vector248:
  pushl $0
80107407:	6a 00                	push   $0x0
  pushl $248
80107409:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010740e:	e9 17 ec ff ff       	jmp    8010602a <alltraps>

80107413 <vector249>:
.globl vector249
vector249:
  pushl $0
80107413:	6a 00                	push   $0x0
  pushl $249
80107415:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010741a:	e9 0b ec ff ff       	jmp    8010602a <alltraps>

8010741f <vector250>:
.globl vector250
vector250:
  pushl $0
8010741f:	6a 00                	push   $0x0
  pushl $250
80107421:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107426:	e9 ff eb ff ff       	jmp    8010602a <alltraps>

8010742b <vector251>:
.globl vector251
vector251:
  pushl $0
8010742b:	6a 00                	push   $0x0
  pushl $251
8010742d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107432:	e9 f3 eb ff ff       	jmp    8010602a <alltraps>

80107437 <vector252>:
.globl vector252
vector252:
  pushl $0
80107437:	6a 00                	push   $0x0
  pushl $252
80107439:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010743e:	e9 e7 eb ff ff       	jmp    8010602a <alltraps>

80107443 <vector253>:
.globl vector253
vector253:
  pushl $0
80107443:	6a 00                	push   $0x0
  pushl $253
80107445:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010744a:	e9 db eb ff ff       	jmp    8010602a <alltraps>

8010744f <vector254>:
.globl vector254
vector254:
  pushl $0
8010744f:	6a 00                	push   $0x0
  pushl $254
80107451:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107456:	e9 cf eb ff ff       	jmp    8010602a <alltraps>

8010745b <vector255>:
.globl vector255
vector255:
  pushl $0
8010745b:	6a 00                	push   $0x0
  pushl $255
8010745d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107462:	e9 c3 eb ff ff       	jmp    8010602a <alltraps>
80107467:	66 90                	xchg   %ax,%ax
80107469:	66 90                	xchg   %ax,%ax
8010746b:	66 90                	xchg   %ax,%ax
8010746d:	66 90                	xchg   %ax,%ax
8010746f:	66 90                	xchg   %ax,%ax
80107471:	66 90                	xchg   %ax,%ax
80107473:	66 90                	xchg   %ax,%ax
80107475:	66 90                	xchg   %ax,%ax
80107477:	66 90                	xchg   %ax,%ax
80107479:	66 90                	xchg   %ax,%ax
8010747b:	66 90                	xchg   %ax,%ax
8010747d:	66 90                	xchg   %ax,%ax
8010747f:	90                   	nop

80107480 <deallocuvm.part.0>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
// If the page was swapped free the corresponding disk block.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107480:	55                   	push   %ebp
80107481:	89 e5                	mov    %esp,%ebp
80107483:	57                   	push   %edi
80107484:	56                   	push   %esi
80107485:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107486:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010748c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107492:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80107495:	39 d3                	cmp    %edx,%ebx
80107497:	73 73                	jae    8010750c <deallocuvm.part.0+0x8c>
80107499:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010749c:	89 c6                	mov    %eax,%esi
8010749e:	89 d7                	mov    %edx,%edi
801074a0:	eb 2a                	jmp    801074cc <deallocuvm.part.0+0x4c>
801074a2:	eb 1c                	jmp    801074c0 <deallocuvm.part.0+0x40>
801074a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074ab:	00 
801074ac:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074b3:	00 
801074b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074bb:	00 
801074bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);

    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801074c0:	83 c2 01             	add    $0x1,%edx
801074c3:	89 d3                	mov    %edx,%ebx
801074c5:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
801074c8:	39 fb                	cmp    %edi,%ebx
801074ca:	73 3d                	jae    80107509 <deallocuvm.part.0+0x89>
  pde = &pgdir[PDX(va)];
801074cc:	89 da                	mov    %ebx,%edx
801074ce:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801074d1:	8b 04 96             	mov    (%esi,%edx,4),%eax
801074d4:	a8 01                	test   $0x1,%al
801074d6:	74 e8                	je     801074c0 <deallocuvm.part.0+0x40>
  return &pgtab[PTX(va)];
801074d8:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801074da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801074df:	c1 e9 0a             	shr    $0xa,%ecx
801074e2:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
801074e8:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
801074ef:	85 c0                	test   %eax,%eax
801074f1:	74 cd                	je     801074c0 <deallocuvm.part.0+0x40>

    else if(*pte & PTE_SWAPPED){
801074f3:	8b 10                	mov    (%eax),%edx
801074f5:	f6 c6 02             	test   $0x2,%dh
801074f8:	75 5e                	jne    80107558 <deallocuvm.part.0+0xd8>
        uint block_id= (*pte)>>12;
        bfree_page(ROOTDEV,block_id);
      }

    else if((*pte & PTE_P) != 0){
801074fa:	f6 c2 01             	test   $0x1,%dl
801074fd:	75 21                	jne    80107520 <deallocuvm.part.0+0xa0>
  for(; a  < oldsz; a += PGSIZE){
801074ff:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107505:	39 fb                	cmp    %edi,%ebx
80107507:	72 c3                	jb     801074cc <deallocuvm.part.0+0x4c>
80107509:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      *pte = 0;
    }

  }
  return newsz;
}
8010750c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010750f:	89 c8                	mov    %ecx,%eax
80107511:	5b                   	pop    %ebx
80107512:	5e                   	pop    %esi
80107513:	5f                   	pop    %edi
80107514:	5d                   	pop    %ebp
80107515:	c3                   	ret
80107516:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010751d:	00 
8010751e:	66 90                	xchg   %ax,%ax
      if(pa == 0)
80107520:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107526:	74 4c                	je     80107574 <deallocuvm.part.0+0xf4>
      kfree(v);
80107528:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010752b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107531:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107534:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
8010753a:	52                   	push   %edx
8010753b:	e8 40 b4 ff ff       	call   80102980 <kfree>
      *pte = 0;
80107540:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80107543:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80107546:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010754c:	e9 77 ff ff ff       	jmp    801074c8 <deallocuvm.part.0+0x48>
80107551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        bfree_page(ROOTDEV,block_id);
80107558:	83 ec 08             	sub    $0x8,%esp
        uint block_id= (*pte)>>12;
8010755b:	c1 ea 0c             	shr    $0xc,%edx
  for(; a  < oldsz; a += PGSIZE){
8010755e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
        bfree_page(ROOTDEV,block_id);
80107564:	52                   	push   %edx
80107565:	6a 01                	push   $0x1
80107567:	e8 24 a4 ff ff       	call   80101990 <bfree_page>
8010756c:	83 c4 10             	add    $0x10,%esp
8010756f:	e9 54 ff ff ff       	jmp    801074c8 <deallocuvm.part.0+0x48>
        panic("kfree");
80107574:	83 ec 0c             	sub    $0xc,%esp
80107577:	68 04 85 10 80       	push   $0x80108504
8010757c:	e8 2f 8f ff ff       	call   801004b0 <panic>
80107581:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107588:	00 
80107589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107590 <mappages>:
{
80107590:	55                   	push   %ebp
80107591:	89 e5                	mov    %esp,%ebp
80107593:	57                   	push   %edi
80107594:	56                   	push   %esi
80107595:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107596:	89 d3                	mov    %edx,%ebx
80107598:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010759e:	83 ec 1c             	sub    $0x1c,%esp
801075a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801075a4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801075a8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801075ad:	89 45 dc             	mov    %eax,-0x24(%ebp)
801075b0:	8b 45 08             	mov    0x8(%ebp),%eax
801075b3:	29 d8                	sub    %ebx,%eax
801075b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801075b8:	eb 3f                	jmp    801075f9 <mappages+0x69>
801075ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801075c0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801075c7:	c1 ea 0a             	shr    $0xa,%edx
801075ca:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801075d0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801075d7:	85 c0                	test   %eax,%eax
801075d9:	74 75                	je     80107650 <mappages+0xc0>
    if(*pte & PTE_P)
801075db:	f6 00 01             	testb  $0x1,(%eax)
801075de:	0f 85 86 00 00 00    	jne    8010766a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801075e4:	0b 75 0c             	or     0xc(%ebp),%esi
801075e7:	83 ce 01             	or     $0x1,%esi
801075ea:	89 30                	mov    %esi,(%eax)
    if(a == last)
801075ec:	8b 45 dc             	mov    -0x24(%ebp),%eax
801075ef:	39 c3                	cmp    %eax,%ebx
801075f1:	74 6d                	je     80107660 <mappages+0xd0>
    a += PGSIZE;
801075f3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801075f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
801075fc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801075ff:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80107602:	89 d8                	mov    %ebx,%eax
80107604:	c1 e8 16             	shr    $0x16,%eax
80107607:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
8010760a:	8b 07                	mov    (%edi),%eax
8010760c:	a8 01                	test   $0x1,%al
8010760e:	75 b0                	jne    801075c0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107610:	e8 3b b5 ff ff       	call   80102b50 <kalloc>
80107615:	85 c0                	test   %eax,%eax
80107617:	74 37                	je     80107650 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107619:	83 ec 04             	sub    $0x4,%esp
8010761c:	68 00 10 00 00       	push   $0x1000
80107621:	6a 00                	push   $0x0
80107623:	50                   	push   %eax
80107624:	89 45 d8             	mov    %eax,-0x28(%ebp)
80107627:	e8 74 d6 ff ff       	call   80104ca0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010762c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010762f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107632:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107638:	83 c8 07             	or     $0x7,%eax
8010763b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
8010763d:	89 d8                	mov    %ebx,%eax
8010763f:	c1 e8 0a             	shr    $0xa,%eax
80107642:	25 fc 0f 00 00       	and    $0xffc,%eax
80107647:	01 d0                	add    %edx,%eax
80107649:	eb 90                	jmp    801075db <mappages+0x4b>
8010764b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80107650:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107653:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107658:	5b                   	pop    %ebx
80107659:	5e                   	pop    %esi
8010765a:	5f                   	pop    %edi
8010765b:	5d                   	pop    %ebp
8010765c:	c3                   	ret
8010765d:	8d 76 00             	lea    0x0(%esi),%esi
80107660:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107663:	31 c0                	xor    %eax,%eax
}
80107665:	5b                   	pop    %ebx
80107666:	5e                   	pop    %esi
80107667:	5f                   	pop    %edi
80107668:	5d                   	pop    %ebp
80107669:	c3                   	ret
      panic("remap in mappages in vm.c");
8010766a:	83 ec 0c             	sub    $0xc,%esp
8010766d:	68 12 85 10 80       	push   $0x80108512
80107672:	e8 39 8e ff ff       	call   801004b0 <panic>
80107677:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010767e:	00 
8010767f:	90                   	nop

80107680 <seginit>:
{
80107680:	55                   	push   %ebp
80107681:	89 e5                	mov    %esp,%ebp
80107683:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107686:	e8 95 c8 ff ff       	call   80103f20 <cpuid>
  pd[0] = size-1;
8010768b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107690:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107696:	c7 80 d8 28 11 80 ff 	movl   $0xffff,-0x7feed728(%eax)
8010769d:	ff 00 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801076a0:	c7 80 e0 28 11 80 ff 	movl   $0xffff,-0x7feed720(%eax)
801076a7:	ff 00 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801076aa:	c7 80 e8 28 11 80 ff 	movl   $0xffff,-0x7feed718(%eax)
801076b1:	ff 00 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801076b4:	c7 80 f0 28 11 80 ff 	movl   $0xffff,-0x7feed710(%eax)
801076bb:	ff 00 00 
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801076be:	c7 80 dc 28 11 80 00 	movl   $0xcf9a00,-0x7feed724(%eax)
801076c5:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801076c8:	c7 80 e4 28 11 80 00 	movl   $0xcf9200,-0x7feed71c(%eax)
801076cf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801076d2:	c7 80 ec 28 11 80 00 	movl   $0xcffa00,-0x7feed714(%eax)
801076d9:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801076dc:	c7 80 f4 28 11 80 00 	movl   $0xcff200,-0x7feed70c(%eax)
801076e3:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801076e6:	05 d0 28 11 80       	add    $0x801128d0,%eax
801076eb:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
801076ef:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801076f3:	c1 e8 10             	shr    $0x10,%eax
801076f6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801076fa:	8d 45 f2             	lea    -0xe(%ebp),%eax
801076fd:	0f 01 10             	lgdtl  (%eax)
}
80107700:	c9                   	leave
80107701:	c3                   	ret
80107702:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107709:	00 
8010770a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107710 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107710:	a1 84 55 11 80       	mov    0x80115584,%eax
80107715:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010771a:	0f 22 d8             	mov    %eax,%cr3
}
8010771d:	c3                   	ret
8010771e:	66 90                	xchg   %ax,%ax

80107720 <switchuvm>:
{
80107720:	55                   	push   %ebp
80107721:	89 e5                	mov    %esp,%ebp
80107723:	57                   	push   %edi
80107724:	56                   	push   %esi
80107725:	53                   	push   %ebx
80107726:	83 ec 1c             	sub    $0x1c,%esp
80107729:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010772c:	85 f6                	test   %esi,%esi
8010772e:	0f 84 cb 00 00 00    	je     801077ff <switchuvm+0xdf>
  if(p->kstack == 0)
80107734:	8b 46 08             	mov    0x8(%esi),%eax
80107737:	85 c0                	test   %eax,%eax
80107739:	0f 84 da 00 00 00    	je     80107819 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010773f:	8b 46 04             	mov    0x4(%esi),%eax
80107742:	85 c0                	test   %eax,%eax
80107744:	0f 84 c2 00 00 00    	je     8010780c <switchuvm+0xec>
  pushcli();
8010774a:	e8 31 d3 ff ff       	call   80104a80 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010774f:	e8 6c c7 ff ff       	call   80103ec0 <mycpu>
80107754:	89 c3                	mov    %eax,%ebx
80107756:	e8 65 c7 ff ff       	call   80103ec0 <mycpu>
8010775b:	89 c7                	mov    %eax,%edi
8010775d:	e8 5e c7 ff ff       	call   80103ec0 <mycpu>
80107762:	83 c7 08             	add    $0x8,%edi
80107765:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107768:	e8 53 c7 ff ff       	call   80103ec0 <mycpu>
8010776d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107770:	ba 67 00 00 00       	mov    $0x67,%edx
80107775:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010777c:	83 c0 08             	add    $0x8,%eax
8010777f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107786:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010778b:	83 c1 08             	add    $0x8,%ecx
8010778e:	c1 e8 18             	shr    $0x18,%eax
80107791:	c1 e9 10             	shr    $0x10,%ecx
80107794:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010779a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801077a0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801077a5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801077ac:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801077b1:	e8 0a c7 ff ff       	call   80103ec0 <mycpu>
801077b6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801077bd:	e8 fe c6 ff ff       	call   80103ec0 <mycpu>
801077c2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801077c6:	8b 5e 08             	mov    0x8(%esi),%ebx
801077c9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801077cf:	e8 ec c6 ff ff       	call   80103ec0 <mycpu>
801077d4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801077d7:	e8 e4 c6 ff ff       	call   80103ec0 <mycpu>
801077dc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801077e0:	b8 28 00 00 00       	mov    $0x28,%eax
801077e5:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801077e8:	8b 46 04             	mov    0x4(%esi),%eax
801077eb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801077f0:	0f 22 d8             	mov    %eax,%cr3
}
801077f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077f6:	5b                   	pop    %ebx
801077f7:	5e                   	pop    %esi
801077f8:	5f                   	pop    %edi
801077f9:	5d                   	pop    %ebp
  popcli();
801077fa:	e9 f1 d3 ff ff       	jmp    80104bf0 <popcli>
    panic("switchuvm: no process");
801077ff:	83 ec 0c             	sub    $0xc,%esp
80107802:	68 2c 85 10 80       	push   $0x8010852c
80107807:	e8 a4 8c ff ff       	call   801004b0 <panic>
    panic("switchuvm: no pgdir");
8010780c:	83 ec 0c             	sub    $0xc,%esp
8010780f:	68 57 85 10 80       	push   $0x80108557
80107814:	e8 97 8c ff ff       	call   801004b0 <panic>
    panic("switchuvm: no kstack");
80107819:	83 ec 0c             	sub    $0xc,%esp
8010781c:	68 42 85 10 80       	push   $0x80108542
80107821:	e8 8a 8c ff ff       	call   801004b0 <panic>
80107826:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010782d:	00 
8010782e:	66 90                	xchg   %ax,%ax

80107830 <inituvm>:
{
80107830:	55                   	push   %ebp
80107831:	89 e5                	mov    %esp,%ebp
80107833:	57                   	push   %edi
80107834:	56                   	push   %esi
80107835:	53                   	push   %ebx
80107836:	83 ec 1c             	sub    $0x1c,%esp
80107839:	8b 45 08             	mov    0x8(%ebp),%eax
8010783c:	8b 75 10             	mov    0x10(%ebp),%esi
8010783f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107842:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107845:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010784b:	77 49                	ja     80107896 <inituvm+0x66>
  mem = kalloc();
8010784d:	e8 fe b2 ff ff       	call   80102b50 <kalloc>
  memset(mem, 0, PGSIZE);
80107852:	83 ec 04             	sub    $0x4,%esp
80107855:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010785a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010785c:	6a 00                	push   $0x0
8010785e:	50                   	push   %eax
8010785f:	e8 3c d4 ff ff       	call   80104ca0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107864:	58                   	pop    %eax
80107865:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010786b:	5a                   	pop    %edx
8010786c:	6a 06                	push   $0x6
8010786e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107873:	31 d2                	xor    %edx,%edx
80107875:	50                   	push   %eax
80107876:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107879:	e8 12 fd ff ff       	call   80107590 <mappages>
  memmove(mem, init, sz);
8010787e:	83 c4 10             	add    $0x10,%esp
80107881:	89 75 10             	mov    %esi,0x10(%ebp)
80107884:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107887:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010788a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010788d:	5b                   	pop    %ebx
8010788e:	5e                   	pop    %esi
8010788f:	5f                   	pop    %edi
80107890:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107891:	e9 9a d4 ff ff       	jmp    80104d30 <memmove>
    panic("inituvm: more than a page");
80107896:	83 ec 0c             	sub    $0xc,%esp
80107899:	68 6b 85 10 80       	push   $0x8010856b
8010789e:	e8 0d 8c ff ff       	call   801004b0 <panic>
801078a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801078aa:	00 
801078ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801078b0 <loaduvm>:
{
801078b0:	55                   	push   %ebp
801078b1:	89 e5                	mov    %esp,%ebp
801078b3:	57                   	push   %edi
801078b4:	56                   	push   %esi
801078b5:	53                   	push   %ebx
801078b6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
801078b9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
801078bc:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
801078bf:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
801078c5:	0f 85 a2 00 00 00    	jne    8010796d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
801078cb:	85 ff                	test   %edi,%edi
801078cd:	74 7d                	je     8010794c <loaduvm+0x9c>
801078cf:	90                   	nop
  pde = &pgdir[PDX(va)];
801078d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801078d3:	8b 55 08             	mov    0x8(%ebp),%edx
801078d6:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
801078d8:	89 c1                	mov    %eax,%ecx
801078da:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801078dd:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
801078e0:	f6 c1 01             	test   $0x1,%cl
801078e3:	75 13                	jne    801078f8 <loaduvm+0x48>
      panic("loaduvm: address should exist");
801078e5:	83 ec 0c             	sub    $0xc,%esp
801078e8:	68 85 85 10 80       	push   $0x80108585
801078ed:	e8 be 8b ff ff       	call   801004b0 <panic>
801078f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801078f8:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801078fb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107901:	25 fc 0f 00 00       	and    $0xffc,%eax
80107906:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010790d:	85 c9                	test   %ecx,%ecx
8010790f:	74 d4                	je     801078e5 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80107911:	89 fb                	mov    %edi,%ebx
80107913:	b8 00 10 00 00       	mov    $0x1000,%eax
80107918:	29 f3                	sub    %esi,%ebx
8010791a:	39 c3                	cmp    %eax,%ebx
8010791c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010791f:	53                   	push   %ebx
80107920:	8b 45 14             	mov    0x14(%ebp),%eax
80107923:	01 f0                	add    %esi,%eax
80107925:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80107926:	8b 01                	mov    (%ecx),%eax
80107928:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010792d:	05 00 00 00 80       	add    $0x80000000,%eax
80107932:	50                   	push   %eax
80107933:	ff 75 10             	push   0x10(%ebp)
80107936:	e8 c5 a5 ff ff       	call   80101f00 <readi>
8010793b:	83 c4 10             	add    $0x10,%esp
8010793e:	39 d8                	cmp    %ebx,%eax
80107940:	75 1e                	jne    80107960 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80107942:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107948:	39 fe                	cmp    %edi,%esi
8010794a:	72 84                	jb     801078d0 <loaduvm+0x20>
}
8010794c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010794f:	31 c0                	xor    %eax,%eax
}
80107951:	5b                   	pop    %ebx
80107952:	5e                   	pop    %esi
80107953:	5f                   	pop    %edi
80107954:	5d                   	pop    %ebp
80107955:	c3                   	ret
80107956:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010795d:	00 
8010795e:	66 90                	xchg   %ax,%ax
80107960:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107963:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107968:	5b                   	pop    %ebx
80107969:	5e                   	pop    %esi
8010796a:	5f                   	pop    %edi
8010796b:	5d                   	pop    %ebp
8010796c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
8010796d:	83 ec 0c             	sub    $0xc,%esp
80107970:	68 14 89 10 80       	push   $0x80108914
80107975:	e8 36 8b ff ff       	call   801004b0 <panic>
8010797a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107980 <allocuvm>:
{
80107980:	55                   	push   %ebp
80107981:	89 e5                	mov    %esp,%ebp
80107983:	57                   	push   %edi
80107984:	56                   	push   %esi
80107985:	53                   	push   %ebx
80107986:	83 ec 1c             	sub    $0x1c,%esp
80107989:	8b 7d 10             	mov    0x10(%ebp),%edi
8010798c:	8b 55 0c             	mov    0xc(%ebp),%edx
  if(newsz >= KERNBASE)
8010798f:	85 ff                	test   %edi,%edi
80107991:	78 7f                	js     80107a12 <allocuvm+0x92>
80107993:	89 f9                	mov    %edi,%ecx
  if(newsz < oldsz)
80107995:	39 d7                	cmp    %edx,%edi
80107997:	0f 82 83 00 00 00    	jb     80107a20 <allocuvm+0xa0>
  a = PGROUNDUP(oldsz);
8010799d:	8d b2 ff 0f 00 00    	lea    0xfff(%edx),%esi
801079a3:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801079a9:	39 fe                	cmp    %edi,%esi
801079ab:	73 75                	jae    80107a22 <allocuvm+0xa2>
801079ad:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801079b0:	89 55 0c             	mov    %edx,0xc(%ebp)
801079b3:	eb 3f                	jmp    801079f4 <allocuvm+0x74>
801079b5:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801079b8:	83 ec 04             	sub    $0x4,%esp
801079bb:	68 00 10 00 00       	push   $0x1000
801079c0:	6a 00                	push   $0x0
801079c2:	50                   	push   %eax
801079c3:	e8 d8 d2 ff ff       	call   80104ca0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801079c8:	58                   	pop    %eax
801079c9:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801079cf:	5a                   	pop    %edx
801079d0:	6a 06                	push   $0x6
801079d2:	b9 00 10 00 00       	mov    $0x1000,%ecx
801079d7:	89 f2                	mov    %esi,%edx
801079d9:	50                   	push   %eax
801079da:	8b 45 08             	mov    0x8(%ebp),%eax
801079dd:	e8 ae fb ff ff       	call   80107590 <mappages>
801079e2:	83 c4 10             	add    $0x10,%esp
801079e5:	83 f8 ff             	cmp    $0xffffffff,%eax
801079e8:	74 46                	je     80107a30 <allocuvm+0xb0>
  for(; a < newsz; a += PGSIZE){
801079ea:	81 c6 00 10 00 00    	add    $0x1000,%esi
801079f0:	39 fe                	cmp    %edi,%esi
801079f2:	73 64                	jae    80107a58 <allocuvm+0xd8>
    mem = kalloc();
801079f4:	e8 57 b1 ff ff       	call   80102b50 <kalloc>
801079f9:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801079fb:	85 c0                	test   %eax,%eax
801079fd:	75 b9                	jne    801079b8 <allocuvm+0x38>
  if(newsz >= oldsz)
801079ff:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a02:	39 d7                	cmp    %edx,%edi
80107a04:	74 0c                	je     80107a12 <allocuvm+0x92>
80107a06:	8b 45 08             	mov    0x8(%ebp),%eax
80107a09:	89 d1                	mov    %edx,%ecx
80107a0b:	89 fa                	mov    %edi,%edx
80107a0d:	e8 6e fa ff ff       	call   80107480 <deallocuvm.part.0>
    return 0;
80107a12:	31 c9                	xor    %ecx,%ecx
}
80107a14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a17:	89 c8                	mov    %ecx,%eax
80107a19:	5b                   	pop    %ebx
80107a1a:	5e                   	pop    %esi
80107a1b:	5f                   	pop    %edi
80107a1c:	5d                   	pop    %ebp
80107a1d:	c3                   	ret
80107a1e:	66 90                	xchg   %ax,%ax
    return oldsz;
80107a20:	89 d1                	mov    %edx,%ecx
}
80107a22:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a25:	89 c8                	mov    %ecx,%eax
80107a27:	5b                   	pop    %ebx
80107a28:	5e                   	pop    %esi
80107a29:	5f                   	pop    %edi
80107a2a:	5d                   	pop    %ebp
80107a2b:	c3                   	ret
80107a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(newsz >= oldsz)
80107a30:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a33:	39 d7                	cmp    %edx,%edi
80107a35:	74 0c                	je     80107a43 <allocuvm+0xc3>
80107a37:	8b 45 08             	mov    0x8(%ebp),%eax
80107a3a:	89 d1                	mov    %edx,%ecx
80107a3c:	89 fa                	mov    %edi,%edx
80107a3e:	e8 3d fa ff ff       	call   80107480 <deallocuvm.part.0>
      kfree(mem);
80107a43:	83 ec 0c             	sub    $0xc,%esp
80107a46:	53                   	push   %ebx
80107a47:	e8 34 af ff ff       	call   80102980 <kfree>
      return 0;
80107a4c:	83 c4 10             	add    $0x10,%esp
    return 0;
80107a4f:	31 c9                	xor    %ecx,%ecx
80107a51:	eb c1                	jmp    80107a14 <allocuvm+0x94>
80107a53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a58:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
}
80107a5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a5e:	5b                   	pop    %ebx
80107a5f:	5e                   	pop    %esi
80107a60:	89 c8                	mov    %ecx,%eax
80107a62:	5f                   	pop    %edi
80107a63:	5d                   	pop    %ebp
80107a64:	c3                   	ret
80107a65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a6c:	00 
80107a6d:	8d 76 00             	lea    0x0(%esi),%esi

80107a70 <deallocuvm>:
{
80107a70:	55                   	push   %ebp
80107a71:	89 e5                	mov    %esp,%ebp
80107a73:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a76:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107a79:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107a7c:	39 d1                	cmp    %edx,%ecx
80107a7e:	73 10                	jae    80107a90 <deallocuvm+0x20>
}
80107a80:	5d                   	pop    %ebp
80107a81:	e9 fa f9 ff ff       	jmp    80107480 <deallocuvm.part.0>
80107a86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a8d:	00 
80107a8e:	66 90                	xchg   %ax,%ax
80107a90:	89 d0                	mov    %edx,%eax
80107a92:	5d                   	pop    %ebp
80107a93:	c3                   	ret
80107a94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107a9b:	00 
80107a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107aa0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107aa0:	55                   	push   %ebp
80107aa1:	89 e5                	mov    %esp,%ebp
80107aa3:	57                   	push   %edi
80107aa4:	56                   	push   %esi
80107aa5:	53                   	push   %ebx
80107aa6:	83 ec 0c             	sub    $0xc,%esp
80107aa9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107aac:	85 f6                	test   %esi,%esi
80107aae:	74 59                	je     80107b09 <freevm+0x69>
  if(newsz >= oldsz)
80107ab0:	31 c9                	xor    %ecx,%ecx
80107ab2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107ab7:	89 f0                	mov    %esi,%eax
80107ab9:	89 f3                	mov    %esi,%ebx
80107abb:	e8 c0 f9 ff ff       	call   80107480 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107ac0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107ac6:	eb 0f                	jmp    80107ad7 <freevm+0x37>
80107ac8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107acf:	00 
80107ad0:	83 c3 04             	add    $0x4,%ebx
80107ad3:	39 fb                	cmp    %edi,%ebx
80107ad5:	74 23                	je     80107afa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107ad7:	8b 03                	mov    (%ebx),%eax
80107ad9:	a8 01                	test   $0x1,%al
80107adb:	74 f3                	je     80107ad0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107add:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107ae2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107ae5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107ae8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107aed:	50                   	push   %eax
80107aee:	e8 8d ae ff ff       	call   80102980 <kfree>
80107af3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107af6:	39 fb                	cmp    %edi,%ebx
80107af8:	75 dd                	jne    80107ad7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107afa:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107afd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b00:	5b                   	pop    %ebx
80107b01:	5e                   	pop    %esi
80107b02:	5f                   	pop    %edi
80107b03:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107b04:	e9 77 ae ff ff       	jmp    80102980 <kfree>
    panic("freevm: no pgdir");
80107b09:	83 ec 0c             	sub    $0xc,%esp
80107b0c:	68 a3 85 10 80       	push   $0x801085a3
80107b11:	e8 9a 89 ff ff       	call   801004b0 <panic>
80107b16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107b1d:	00 
80107b1e:	66 90                	xchg   %ax,%ax

80107b20 <setupkvm>:
{
80107b20:	55                   	push   %ebp
80107b21:	89 e5                	mov    %esp,%ebp
80107b23:	56                   	push   %esi
80107b24:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107b25:	e8 26 b0 ff ff       	call   80102b50 <kalloc>
80107b2a:	85 c0                	test   %eax,%eax
80107b2c:	74 5e                	je     80107b8c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
80107b2e:	83 ec 04             	sub    $0x4,%esp
80107b31:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b33:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107b38:	68 00 10 00 00       	push   $0x1000
80107b3d:	6a 00                	push   $0x0
80107b3f:	50                   	push   %eax
80107b40:	e8 5b d1 ff ff       	call   80104ca0 <memset>
80107b45:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107b48:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107b4b:	83 ec 08             	sub    $0x8,%esp
80107b4e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107b51:	8b 13                	mov    (%ebx),%edx
80107b53:	ff 73 0c             	push   0xc(%ebx)
80107b56:	50                   	push   %eax
80107b57:	29 c1                	sub    %eax,%ecx
80107b59:	89 f0                	mov    %esi,%eax
80107b5b:	e8 30 fa ff ff       	call   80107590 <mappages>
80107b60:	83 c4 10             	add    $0x10,%esp
80107b63:	83 f8 ff             	cmp    $0xffffffff,%eax
80107b66:	74 18                	je     80107b80 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b68:	83 c3 10             	add    $0x10,%ebx
80107b6b:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107b71:	75 d5                	jne    80107b48 <setupkvm+0x28>
}
80107b73:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b76:	89 f0                	mov    %esi,%eax
80107b78:	5b                   	pop    %ebx
80107b79:	5e                   	pop    %esi
80107b7a:	5d                   	pop    %ebp
80107b7b:	c3                   	ret
80107b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107b80:	83 ec 0c             	sub    $0xc,%esp
80107b83:	56                   	push   %esi
80107b84:	e8 17 ff ff ff       	call   80107aa0 <freevm>
      return 0;
80107b89:	83 c4 10             	add    $0x10,%esp
}
80107b8c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80107b8f:	31 f6                	xor    %esi,%esi
}
80107b91:	89 f0                	mov    %esi,%eax
80107b93:	5b                   	pop    %ebx
80107b94:	5e                   	pop    %esi
80107b95:	5d                   	pop    %ebp
80107b96:	c3                   	ret
80107b97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107b9e:	00 
80107b9f:	90                   	nop

80107ba0 <kvmalloc>:
{
80107ba0:	55                   	push   %ebp
80107ba1:	89 e5                	mov    %esp,%ebp
80107ba3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107ba6:	e8 75 ff ff ff       	call   80107b20 <setupkvm>
80107bab:	a3 84 55 11 80       	mov    %eax,0x80115584
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107bb0:	05 00 00 00 80       	add    $0x80000000,%eax
80107bb5:	0f 22 d8             	mov    %eax,%cr3
}
80107bb8:	c9                   	leave
80107bb9:	c3                   	ret
80107bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107bc0 <select_a_victim>:
    of 10% of the allocated pages and call select_a_victim() again
*/

pte_t*
select_a_victim(pde_t *pgdir)
{
80107bc0:	55                   	push   %ebp
80107bc1:	89 e5                	mov    %esp,%ebp
80107bc3:	56                   	push   %esi
80107bc4:	53                   	push   %ebx
  pte_t *pte;
  for(long i=4096; i<KERNBASE;i+=PGSIZE){    //for all pages in the user virtual space
80107bc5:	bb 00 10 00 00       	mov    $0x1000,%ebx
{
80107bca:	8b 75 08             	mov    0x8(%ebp),%esi
  for(long i=4096; i<KERNBASE;i+=PGSIZE){    //for all pages in the user virtual space
80107bcd:	eb 17                	jmp    80107be6 <select_a_victim+0x26>
80107bcf:	90                   	nop
               }
           }
      }
      else{

        cprintf("walkpgdir failed \n ");
80107bd0:	83 ec 0c             	sub    $0xc,%esp
80107bd3:	68 b4 85 10 80       	push   $0x801085b4
80107bd8:	e8 13 8c ff ff       	call   801007f0 <cprintf>
80107bdd:	83 c4 10             	add    $0x10,%esp
  for(long i=4096; i<KERNBASE;i+=PGSIZE){    //for all pages in the user virtual space
80107be0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pde = &pgdir[PDX(va)];
80107be6:	89 d8                	mov    %ebx,%eax
80107be8:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107beb:	8b 04 86             	mov    (%esi,%eax,4),%eax
80107bee:	a8 01                	test   $0x1,%al
80107bf0:	74 de                	je     80107bd0 <select_a_victim+0x10>
  return &pgtab[PTX(va)];
80107bf2:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107bf4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107bf9:	c1 ea 0a             	shr    $0xa,%edx
80107bfc:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107c02:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte=walkpgdir(pgdir,(char*)i,0))!= 0) //if mapping exists (0 as 3rd argument as we dont want to create mapping if does not exists)
80107c09:	85 c0                	test   %eax,%eax
80107c0b:	74 c3                	je     80107bd0 <select_a_victim+0x10>
           if(*pte & PTE_P) //if not dirty, or (present and access bit not set)  --- conditions needs to be checked
80107c0d:	f6 00 01             	testb  $0x1,(%eax)
80107c10:	74 ce                	je     80107be0 <select_a_victim+0x20>
      }
	}

  cprintf("bahar aa gaya  ");
  return 0;
}
80107c12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107c15:	5b                   	pop    %ebx
80107c16:	5e                   	pop    %esi
80107c17:	5d                   	pop    %ebp
80107c18:	c3                   	ret
80107c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107c20 <clearaccessbit>:

// Clear access bit of a random pte.
void
clearaccessbit(pde_t *pgdir)
{ pte_t *pte;
80107c20:	55                   	push   %ebp
80107c21:	89 e5                	mov    %esp,%ebp
80107c23:	56                   	push   %esi
80107c24:	8b 75 08             	mov    0x8(%ebp),%esi
80107c27:	53                   	push   %ebx
  int count=0;
  for(long i=4096;i<KERNBASE;i+=PGSIZE){
80107c28:	bb 00 10 00 00       	mov    $0x1000,%ebx
80107c2d:	8d 76 00             	lea    0x0(%esi),%esi
  pde = &pgdir[PDX(va)];
80107c30:	89 d8                	mov    %ebx,%eax
80107c32:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107c35:	8b 04 86             	mov    (%esi,%eax,4),%eax
80107c38:	a8 01                	test   $0x1,%al
80107c3a:	74 2b                	je     80107c67 <clearaccessbit+0x47>
  return &pgtab[PTX(va)];
80107c3c:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c3e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107c43:	c1 ea 0a             	shr    $0xa,%edx
80107c46:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107c4c:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
      if((pte=walkpgdir(pgdir,(char*)i,0))!= 0){
80107c53:	85 c0                	test   %eax,%eax
80107c55:	74 10                	je     80107c67 <clearaccessbit+0x47>
        cprintf("walkpkgdir mei");
80107c57:	83 ec 0c             	sub    $0xc,%esp
80107c5a:	68 c8 85 10 80       	push   $0x801085c8
80107c5f:	e8 8c 8b ff ff       	call   801007f0 <cprintf>
        if((*pte & PTE_P) & (*pte & PTE_A)){
80107c64:	83 c4 10             	add    $0x10,%esp
            else{
              cprintf("103 se zyaada ho gya");
            }
        }
    }
    cprintf("chalo vappis");
80107c67:	83 ec 0c             	sub    $0xc,%esp
  for(long i=4096;i<KERNBASE;i+=PGSIZE){
80107c6a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    cprintf("chalo vappis");
80107c70:	68 d7 85 10 80       	push   $0x801085d7
80107c75:	e8 76 8b ff ff       	call   801007f0 <cprintf>
  for(long i=4096;i<KERNBASE;i+=PGSIZE){
80107c7a:	83 c4 10             	add    $0x10,%esp
80107c7d:	eb b1                	jmp    80107c30 <clearaccessbit+0x10>
80107c7f:	90                   	nop

80107c80 <getswappedblk>:

// return the disk block-id, if the virtual address
// was swapped, -1 otherwise.
int
getswappedblk(pde_t *pgdir, uint va)
{
80107c80:	55                   	push   %ebp
80107c81:	89 e5                	mov    %esp,%ebp
80107c83:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107c86:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107c89:	89 c1                	mov    %eax,%ecx
80107c8b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107c8e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107c91:	f6 c2 01             	test   $0x1,%dl
80107c94:	0f 84 a0 03 00 00    	je     8010803a <getswappedblk.cold>
  return &pgtab[PTX(va)];
80107c9a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c9d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  //***************xv7**************
  pte_t *pte= walkpgdir(pgdir,(char*)va,0);
  //first 20 bits contain block-id, extract them from *pte
  int block_id= (*pte)>>12;
  return block_id;
}
80107ca3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107ca4:	25 ff 03 00 00       	and    $0x3ff,%eax
  int block_id= (*pte)>>12;
80107ca9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
80107cb0:	c1 e8 0c             	shr    $0xc,%eax
}
80107cb3:	c3                   	ret
80107cb4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107cbb:	00 
80107cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107cc0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107cc0:	55                   	push   %ebp
80107cc1:	89 e5                	mov    %esp,%ebp
80107cc3:	83 ec 08             	sub    $0x8,%esp
80107cc6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107cc9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107ccc:	89 c1                	mov    %eax,%ecx
80107cce:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107cd1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107cd4:	f6 c2 01             	test   $0x1,%dl
80107cd7:	75 17                	jne    80107cf0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107cd9:	83 ec 0c             	sub    $0xc,%esp
80107cdc:	68 e4 85 10 80       	push   $0x801085e4
80107ce1:	e8 ca 87 ff ff       	call   801004b0 <panic>
80107ce6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107ced:	00 
80107cee:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107cf0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107cf3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107cf9:	25 fc 0f 00 00       	and    $0xffc,%eax
80107cfe:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107d05:	85 c0                	test   %eax,%eax
80107d07:	74 d0                	je     80107cd9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107d09:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107d0c:	c9                   	leave
80107d0d:	c3                   	ret
80107d0e:	66 90                	xchg   %ax,%ax

80107d10 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107d10:	55                   	push   %ebp
80107d11:	89 e5                	mov    %esp,%ebp
80107d13:	57                   	push   %edi
80107d14:	56                   	push   %esi
80107d15:	53                   	push   %ebx
80107d16:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;
  if((d = setupkvm()) == 0)
80107d19:	e8 02 fe ff ff       	call   80107b20 <setupkvm>
80107d1e:	85 c0                	test   %eax,%eax
80107d20:	0f 84 c1 01 00 00    	je     80107ee7 <copyuvm+0x1d7>
80107d26:	89 c1                	mov    %eax,%ecx
    return 0;
  // cprintf("process size is: %d",sz);
  for(i = 0; i < sz; i += PGSIZE){
80107d28:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d2b:	85 c0                	test   %eax,%eax
80107d2d:	0f 84 cc 00 00 00    	je     80107dff <copyuvm+0xef>
      int blockid=getswappedblk(pgdir,i);      //disk id where the page was swapped
      read_page_from_disk(ROOTDEV,mem,blockid);

      *pte=V2P(mem) | PTE_W | PTE_U | PTE_P;
      *pte &= ~PTE_SWAPPED;
      lcr3(V2P(pgdir));
80107d33:	8b 45 08             	mov    0x8(%ebp),%eax
80107d36:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
80107d39:	31 db                	xor    %ebx,%ebx
      lcr3(V2P(pgdir));
80107d3b:	05 00 00 00 80       	add    $0x80000000,%eax
80107d40:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107d43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107d4a:	00 
80107d4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
80107d50:	8b 4d 08             	mov    0x8(%ebp),%ecx
80107d53:	89 d8                	mov    %ebx,%eax
80107d55:	c1 e8 16             	shr    $0x16,%eax
80107d58:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107d5b:	8b 07                	mov    (%edi),%eax
80107d5d:	a8 01                	test   $0x1,%al
80107d5f:	75 0f                	jne    80107d70 <copyuvm+0x60>
      panic("copyuvm: pte should exist");
80107d61:	83 ec 0c             	sub    $0xc,%esp
80107d64:	68 ee 85 10 80       	push   $0x801085ee
80107d69:	e8 42 87 ff ff       	call   801004b0 <panic>
80107d6e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107d70:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107d72:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107d77:	c1 ea 0a             	shr    $0xa,%edx
80107d7a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107d80:	8d b4 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%esi
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107d87:	85 f6                	test   %esi,%esi
80107d89:	74 d6                	je     80107d61 <copyuvm+0x51>
    if(*pte & PTE_SWAPPED){
80107d8b:	8b 06                	mov    (%esi),%eax
80107d8d:	f6 c4 02             	test   $0x2,%ah
80107d90:	75 7e                	jne    80107e10 <copyuvm+0x100>
      bfree_page(ROOTDEV,blockid);

      //panic("copyuvm: page not present");
    }
    //  cprintf("page was not swapped\n");
    pa = PTE_ADDR(*pte);
80107d92:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107d94:	25 ff 0f 00 00       	and    $0xfff,%eax
80107d99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107d9c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107da2:	e8 a9 ad ff ff       	call   80102b50 <kalloc>
80107da7:	89 c6                	mov    %eax,%esi
80107da9:	85 c0                	test   %eax,%eax
80107dab:	0f 84 cf 00 00 00    	je     80107e80 <copyuvm+0x170>
      mem=kalloc();
      if(mem==0)
        cprintf("unable to get memory in copyuvm");
    }

    memmove(mem, (char*)P2V(pa), PGSIZE);
80107db1:	83 ec 04             	sub    $0x4,%esp
80107db4:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107dba:	68 00 10 00 00       	push   $0x1000
80107dbf:	57                   	push   %edi
80107dc0:	56                   	push   %esi
80107dc1:	e8 6a cf ff ff       	call   80104d30 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107dc6:	58                   	pop    %eax
80107dc7:	5a                   	pop    %edx
80107dc8:	8d 96 00 00 00 80    	lea    -0x80000000(%esi),%edx
80107dce:	ff 75 e4             	push   -0x1c(%ebp)
80107dd1:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107dd6:	52                   	push   %edx
80107dd7:	89 da                	mov    %ebx,%edx
80107dd9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107ddc:	e8 af f7 ff ff       	call   80107590 <mappages>
80107de1:	83 c4 10             	add    $0x10,%esp
80107de4:	83 f8 ff             	cmp    $0xffffffff,%eax
80107de7:	0f 84 eb 00 00 00    	je     80107ed8 <copyuvm+0x1c8>
  for(i = 0; i < sz; i += PGSIZE){
80107ded:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107df3:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
80107df6:	0f 82 54 ff ff ff    	jb     80107d50 <copyuvm+0x40>
80107dfc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  return d;

bad:
  freevm(d);
  return 0;
}
80107dff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e02:	89 c8                	mov    %ecx,%eax
80107e04:	5b                   	pop    %ebx
80107e05:	5e                   	pop    %esi
80107e06:	5f                   	pop    %edi
80107e07:	5d                   	pop    %ebp
80107e08:	c3                   	ret
80107e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e10:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      if((mem = kalloc()) == 0)
80107e13:	e8 38 ad ff ff       	call   80102b50 <kalloc>
80107e18:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107e1b:	85 c0                	test   %eax,%eax
80107e1d:	0f 84 95 00 00 00    	je     80107eb8 <copyuvm+0x1a8>
  if(*pde & PTE_P){
80107e23:	8b 0f                	mov    (%edi),%ecx
80107e25:	f6 c1 01             	test   $0x1,%cl
80107e28:	0f 84 13 02 00 00    	je     80108041 <copyuvm.cold>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e2e:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
      read_page_from_disk(ROOTDEV,mem,blockid);
80107e34:	83 ec 04             	sub    $0x4,%esp
  int block_id= (*pte)>>12;
80107e37:	8b bc 0a 00 00 00 80 	mov    -0x80000000(%edx,%ecx,1),%edi
80107e3e:	c1 ef 0c             	shr    $0xc,%edi
      read_page_from_disk(ROOTDEV,mem,blockid);
80107e41:	57                   	push   %edi
80107e42:	50                   	push   %eax
80107e43:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107e46:	6a 01                	push   $0x1
80107e48:	e8 a3 84 ff ff       	call   801002f0 <read_page_from_disk>
      *pte=V2P(mem) | PTE_W | PTE_U | PTE_P;
80107e4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107e50:	05 00 00 00 80       	add    $0x80000000,%eax
      *pte &= ~PTE_SWAPPED;
80107e55:	80 e4 fd             	and    $0xfd,%ah
80107e58:	83 c8 07             	or     $0x7,%eax
80107e5b:	89 06                	mov    %eax,(%esi)
80107e5d:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107e60:	0f 22 d8             	mov    %eax,%cr3
      bfree_page(ROOTDEV,blockid);
80107e63:	59                   	pop    %ecx
80107e64:	58                   	pop    %eax
80107e65:	57                   	push   %edi
80107e66:	6a 01                	push   $0x1
80107e68:	e8 23 9b ff ff       	call   80101990 <bfree_page>
    pa = PTE_ADDR(*pte);
80107e6d:	8b 06                	mov    (%esi),%eax
80107e6f:	83 c4 10             	add    $0x10,%esp
80107e72:	e9 1b ff ff ff       	jmp    80107d92 <copyuvm+0x82>
80107e77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107e7e:	00 
80107e7f:	90                   	nop
      swap_page(pgdir);
80107e80:	83 ec 0c             	sub    $0xc,%esp
80107e83:	ff 75 08             	push   0x8(%ebp)
80107e86:	e8 45 e6 ff ff       	call   801064d0 <swap_page>
      mem=kalloc();
80107e8b:	e8 c0 ac ff ff       	call   80102b50 <kalloc>
      if(mem==0)
80107e90:	83 c4 10             	add    $0x10,%esp
      mem=kalloc();
80107e93:	89 c6                	mov    %eax,%esi
      if(mem==0)
80107e95:	85 c0                	test   %eax,%eax
80107e97:	0f 85 14 ff ff ff    	jne    80107db1 <copyuvm+0xa1>
        cprintf("unable to get memory in copyuvm");
80107e9d:	83 ec 0c             	sub    $0xc,%esp
80107ea0:	68 38 89 10 80       	push   $0x80108938
80107ea5:	e8 46 89 ff ff       	call   801007f0 <cprintf>
80107eaa:	83 c4 10             	add    $0x10,%esp
80107ead:	e9 ff fe ff ff       	jmp    80107db1 <copyuvm+0xa1>
80107eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        swap_page(pgdir);
80107eb8:	83 ec 0c             	sub    $0xc,%esp
80107ebb:	ff 75 08             	push   0x8(%ebp)
80107ebe:	e8 0d e6 ff ff       	call   801064d0 <swap_page>
        mem=kalloc();
80107ec3:	e8 88 ac ff ff       	call   80102b50 <kalloc>
80107ec8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107ecb:	83 c4 10             	add    $0x10,%esp
80107ece:	e9 50 ff ff ff       	jmp    80107e23 <copyuvm+0x113>
80107ed3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  freevm(d);
80107ed8:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80107edb:	83 ec 0c             	sub    $0xc,%esp
80107ede:	51                   	push   %ecx
80107edf:	e8 bc fb ff ff       	call   80107aa0 <freevm>
  return 0;
80107ee4:	83 c4 10             	add    $0x10,%esp
    return 0;
80107ee7:	31 c9                	xor    %ecx,%ecx
80107ee9:	e9 11 ff ff ff       	jmp    80107dff <copyuvm+0xef>
80107eee:	66 90                	xchg   %ax,%ax

80107ef0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107ef0:	55                   	push   %ebp
80107ef1:	89 e5                	mov    %esp,%ebp
80107ef3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107ef6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107ef9:	89 c1                	mov    %eax,%ecx
80107efb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107efe:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107f01:	f6 c2 01             	test   $0x1,%dl
80107f04:	0f 84 3e 01 00 00    	je     80108048 <uva2ka.cold>
  return &pgtab[PTX(va)];
80107f0a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107f0d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107f13:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107f14:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107f19:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107f20:	89 d0                	mov    %edx,%eax
80107f22:	f7 d2                	not    %edx
80107f24:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f29:	05 00 00 00 80       	add    $0x80000000,%eax
80107f2e:	83 e2 05             	and    $0x5,%edx
80107f31:	ba 00 00 00 00       	mov    $0x0,%edx
80107f36:	0f 45 c2             	cmovne %edx,%eax
}
80107f39:	c3                   	ret
80107f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107f40 <uva2pte>:

// returns the page table entry corresponding
// to a virtual address.
pte_t*
uva2pte(pde_t *pgdir, uint uva)
{
80107f40:	55                   	push   %ebp
80107f41:	31 c0                	xor    %eax,%eax
80107f43:	89 e5                	mov    %esp,%ebp
80107f45:	53                   	push   %ebx
80107f46:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(*pde & PTE_P){
80107f49:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107f4c:	89 d9                	mov    %ebx,%ecx
80107f4e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107f51:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107f54:	f6 c2 01             	test   $0x1,%dl
80107f57:	74 17                	je     80107f70 <uva2pte+0x30>
  return &pgtab[PTX(va)];
80107f59:	89 d8                	mov    %ebx,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107f5b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107f61:	c1 e8 0a             	shr    $0xa,%eax
80107f64:	25 fc 0f 00 00       	and    $0xffc,%eax
80107f69:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  return walkpgdir(pgdir, (void*)uva, 0);
}
80107f70:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107f73:	c9                   	leave
80107f74:	c3                   	ret
80107f75:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107f7c:	00 
80107f7d:	8d 76 00             	lea    0x0(%esi),%esi

80107f80 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107f80:	55                   	push   %ebp
80107f81:	89 e5                	mov    %esp,%ebp
80107f83:	57                   	push   %edi
80107f84:	56                   	push   %esi
80107f85:	53                   	push   %ebx
80107f86:	83 ec 0c             	sub    $0xc,%esp
80107f89:	8b 75 14             	mov    0x14(%ebp),%esi
80107f8c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107f8f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107f92:	85 f6                	test   %esi,%esi
80107f94:	75 49                	jne    80107fdf <copyout+0x5f>
80107f96:	e9 95 00 00 00       	jmp    80108030 <copyout+0xb0>
80107f9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107fa0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107fa5:	05 00 00 00 80       	add    $0x80000000,%eax
80107faa:	74 6e                	je     8010801a <copyout+0x9a>
      return -1;
    n = PGSIZE - (va - va0);
80107fac:	89 fb                	mov    %edi,%ebx
80107fae:	29 cb                	sub    %ecx,%ebx
80107fb0:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107fb6:	39 f3                	cmp    %esi,%ebx
80107fb8:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107fbb:	29 f9                	sub    %edi,%ecx
80107fbd:	83 ec 04             	sub    $0x4,%esp
80107fc0:	01 c8                	add    %ecx,%eax
80107fc2:	53                   	push   %ebx
80107fc3:	52                   	push   %edx
80107fc4:	89 55 10             	mov    %edx,0x10(%ebp)
80107fc7:	50                   	push   %eax
80107fc8:	e8 63 cd ff ff       	call   80104d30 <memmove>
    len -= n;
    buf += n;
80107fcd:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107fd0:	8d 8f 00 10 00 00    	lea    0x1000(%edi),%ecx
  while(len > 0){
80107fd6:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107fd9:	01 da                	add    %ebx,%edx
  while(len > 0){
80107fdb:	29 de                	sub    %ebx,%esi
80107fdd:	74 51                	je     80108030 <copyout+0xb0>
  if(*pde & PTE_P){
80107fdf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107fe2:	89 c8                	mov    %ecx,%eax
    va0 = (uint)PGROUNDDOWN(va);
80107fe4:	89 cf                	mov    %ecx,%edi
  pde = &pgdir[PDX(va)];
80107fe6:	c1 e8 16             	shr    $0x16,%eax
    va0 = (uint)PGROUNDDOWN(va);
80107fe9:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107fef:	8b 04 83             	mov    (%ebx,%eax,4),%eax
80107ff2:	a8 01                	test   $0x1,%al
80107ff4:	0f 84 55 00 00 00    	je     8010804f <copyout.cold>
  return &pgtab[PTX(va)];
80107ffa:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ffc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80108001:	c1 eb 0c             	shr    $0xc,%ebx
80108004:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
8010800a:	8b 84 98 00 00 00 80 	mov    -0x80000000(%eax,%ebx,4),%eax
  if((*pte & PTE_U) == 0)
80108011:	89 c3                	mov    %eax,%ebx
80108013:	f7 d3                	not    %ebx
80108015:	83 e3 05             	and    $0x5,%ebx
80108018:	74 86                	je     80107fa0 <copyout+0x20>
  }
  return 0;
}
8010801a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010801d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80108022:	5b                   	pop    %ebx
80108023:	5e                   	pop    %esi
80108024:	5f                   	pop    %edi
80108025:	5d                   	pop    %ebp
80108026:	c3                   	ret
80108027:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010802e:	00 
8010802f:	90                   	nop
80108030:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80108033:	31 c0                	xor    %eax,%eax
}
80108035:	5b                   	pop    %ebx
80108036:	5e                   	pop    %esi
80108037:	5f                   	pop    %edi
80108038:	5d                   	pop    %ebp
80108039:	c3                   	ret

8010803a <getswappedblk.cold>:
  int block_id= (*pte)>>12;
8010803a:	a1 00 00 00 00       	mov    0x0,%eax
8010803f:	0f 0b                	ud2

80108041 <copyuvm.cold>:
80108041:	a1 00 00 00 00       	mov    0x0,%eax
80108046:	0f 0b                	ud2

80108048 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80108048:	a1 00 00 00 00       	mov    0x0,%eax
8010804d:	0f 0b                	ud2

8010804f <copyout.cold>:
8010804f:	a1 00 00 00 00       	mov    0x0,%eax
80108054:	0f 0b                	ud2
