#!/usr/bin/env python3

import sys
from pixel_ring import pixel_ring

if sys.argv[1] == "off":
    pixel_ring.off()
elif sys.argv[1] == "spin":
    pixel_ring.spin()
elif sys.argv[1] == "listen":
    pixel_ring.listen()
elif sys.argv[1] == "think":
    pixel_ring.think()
elif sys.argv[1] == "speak":
    pixel_ring.speak()          
else:
    pixel_ring.off()

