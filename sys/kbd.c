#include "types.h"
#include "x86.h"
#include "defs.h"
#include "kbd.h"

int kbdgetc(void)
{
  static uint shift;
  static int extcode = 0;
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  // Handle extended scancode prefix
  if(data == 0xE0) {
    extcode = 1;
    return -1;
  }

  // Process key releases
  if(data & 0x80) {
    data = (data & 0x7F) | (extcode ? 0xE000 : 0);
    extcode = 0;
    // Handle modifier releases
    switch(data) {
    case 0x1D: case 0x9D: shift &= ~CTL; break;
    case 0x38: case 0xB8: shift &= ~ALT; break;
    case 0x2A: case 0x36: shift &= ~SHIFT; break;
    }
    return -1;
  }

  // Handle extended codes
  if(extcode) {
    data |= 0xE000;
    extcode = 0;
  }

  // Handle modifiers
  switch(data) {
  case 0x1D: case 0x9D: shift |= CTL; return -1;
  case 0x38: case 0xB8: shift |= ALT; return -1;
  case 0x2A: case 0x36: shift |= SHIFT; return -1;
  }

  // Map remaining keys
  c = charcode[shift & (CTL | SHIFT)][data & 0xFF];
  
  // Combine with extended prefix
  if(data & 0xE000)
    c |= (data & 0xFF00);

  // Handle case toggling
  if(shift & CAPSLOCK) {
    if('a' <= c && c <= 'z') c += 'A' - 'a';
    else if('A' <= c && c <= 'Z') c += 'a' - 'A';
  }

  return c;
}

void
kbdintr(void)
{
  consoleintr(kbdgetc);
}