Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218521F2380
	for <netdev@vger.kernel.org>; Sun,  2 Aug 2026 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785664885; cv=none; b=tYTB4HCy9YQXWJYK1xqrO1uEqZidkackMrHuHEMd+FJ0zHMvDgJEMzjWUjpTalLghblrhYTrW/GW9gyI/1YmTJcLV2fvvn+QUn5gyLc2rbEP/YoPeGwYY9XJPHtqfcxiYi0IXjYM09/rMyC1dXcRUkbWY1AlNXkrZjSJVxPPqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785664885; c=relaxed/simple;
	bh=xqfwmHS9GlvfHmx0IVjysWvLOidced27TJ+GdeAaQNo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rf9+pJLvDKMb2aJwPqN+1lfvOAJSdB9YzBqiQae6i4CuIujBNrsMIJL/esg3NeLs6E3J2GXiux/ng6h0P3Ev4gSepOFCpkxXSMjm56+11CUWjkhn1zXqsiFBoH0OUkzmAH5cuLk41dwIXrXRvyHtNB5pXwFwWLmtarfleiFNVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEoILN+5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEoILN+5"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954afac04bso13668845e9.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785664881; x=1786269681; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5BZl8AL8ApB817WM4/dpr2mhu9fwx+hY0cYz5PYsfSE=;
        b=LEoILN+5sG55pZE1O5npcBKByO8JgIDCyd0fhUJrAmFS7qd0Uf3zfNMjUHQ9jhdZKl
         h+f2+ZbMefkdSVjUPQLUACog7v0Qkwj/coAml7AwMTnvB+Xb8rLBF86uTIq+oxIWkLkk
         hE/8aQldvIIwYAy/cJ7ArfSZgTjvh3IJJp1eG/yfueDUBVq+miSMitHOc3d3Lk/MhoU0
         sU2UGLJNB1+w19RJZ7zej/BuwR8b8NyOpjKjnT6ZjPNPX32/om4l8p79rLUwxvylulMb
         v4FpB/JkGeuRdDr8ChrSJRrUVZgx/4QBUSivwREJ3wFEtzVmVuyT0w5OYPfuQxbZmcFm
         SiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785664881; x=1786269681;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5BZl8AL8ApB817WM4/dpr2mhu9fwx+hY0cYz5PYsfSE=;
        b=pSwDw6fl9Ve8AEsEj+6JLHFB5WGdQnlU2UeYlTfJnmkPmVBgimAJq7TzopKvyTWI0Y
         HpGBoeWA3jHw5jpPMuMNPbPzsXOhZQDoUWSJBUbQpbuYCMlNsR1+FRk8nVC7z9hNS4pf
         rToDF1oU/2ZiwjlW/5Q0fANBj+Moj/lcUdRmv3zr1GsK5J7sK/HRWlm2/kbO7HMPAFVw
         wAOS0soA4YjN1qzIVOkk5V2LZAbJEGutsqYb5T1EbHQGJNB2qVEBRdgbk+Sq+BOpoqnp
         eLQaoUz8a6nG8AGmbzB+rRXLMuk9KVEsvhlHykh/RyC4jth7CiD1fZVkEj0iiIK/BSgC
         mWpg==
X-Gm-Message-State: AOJu0YxzfTTO4FQLw0n0nh7uyqhrVxW5LlrLlXCAuGGnsGetU6igDyLn
	EVnIHzEYmmzUH5oP+EPFE0DagDEbNK7LdXOA4MdZItJVZas2vwMENrgC
X-Gm-Gg: AR+sD12amW1kio3P/EhX/i6A6fq+SaUsxUx9DIjxR14wxaWnUSTrFUCwpxdV0ksbZUj
	j0pVezlha8mam73WAXxBkQkBv5rsmHc/Y4t16jv9Wl2i5qXocWIS4hz26MsZjDiisCYXw3v9YP5
	ngt1wEh14VVOrW6hoYE5LqI/PEm030GJgj1xrCaqxvEYuOCbmn0pJAs9HvUFLXKtye2OQDhWKdg
	M/EvYQnUotwtVU1LCSsI3UgJnj4Q+aZOh5kT5VMQqk23MxCs9FD7AyUxgerhFq92TnSejdjwFvS
	LOuhNmDiWFbDLIGgKmX5QPhcp8AwDlv+sViHQEvAIBKqZkQk4UYa07dl3+rlTlnLuxwzVhF9udN
	qLVF9LT69dz4ETUXFLcF0OT8E9DERfaS89gpHtZzFuCGMq5S2S7s8PKsS89fMcFHS0inmQH6wBW
	futoiuSWOO99FacO3kEtaU2Sb+fmWTL6RVP+rBJFzDwm1uY5skywDGTrzJJ+8PFdo=
X-Received: by 2002:a05:600c:3f0d:b0:495:641a:bd3f with SMTP id 5b1f17b1804b1-4980c673891mr125021225e9.13.1785664880936;
        Sun, 02 Aug 2026 03:01:20 -0700 (PDT)
Received: from builder ([2001:9e8:f117:b116:be24:11ff:fe30:5d85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5b4a2sm140991375e9.1.2026.08.02.03.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 03:01:20 -0700 (PDT)
From: Jonas Jelonek <jelonek.jonas@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Sander Vanheule <sander@svanheule.net>,
	Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH net-next v11 0/4] net: pse-pd: add Realtek PSE MCU support
Date: Sun,  2 Aug 2026 10:01:07 +0000
Message-ID: <20260802100114.720594-1-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds a PSE-PD driver for the microcontroller (MCU) that
fronts the PSE silicon on a range of managed switches, together with its
DT binding.

Hardware model
==============

These boards do not expose the PSE chips to the host directly. A small
microcontroller sits on an I2C/SMBus or UART bus and manages one or more
PSE chips behind it; the host CPU only ever talks to that MCU, using a
fixed 12-byte request/response protocol with a trailing checksum. The
PSE silicon never appears on the bus.

Two generations of the protocol exist, both Realtek's: an older one on
boards with Broadcom PSE silicon (BCM59111, BCM59121) and a newer one
used with Realtek's own PSE silicon (RTL8238B, RTL8239, RTL8239C). They
diverge in opcode numbering and a few response layouts; the driver
abstracts that behind a per-dialect opcode table and parser hooks,
selected by the compatible. The specific PSE chip behind the MCU is
detected at runtime and only influences per-chip constants (power scaling
and the per-port cap).

The compatibles
===============

The protocol compatibles name two generations of the Realtek protocol,
with the I2C framing folded in:

  realtek,pse-mcu-gen1        gen1, UART
  realtek,pse-mcu-gen1-smbus  gen1, I2C/SMBus
  realtek,pse-mcu-gen2        gen2, UART
  realtek,pse-mcu-gen2-smbus  gen2, I2C/SMBus
  realtek,pse-mcu-gen2-i2c    gen2, raw I2C

and each board carries a device-specific compatible that falls back to one
of these, e.g.

  compatible = "zyxel,xs1930-12hp-pse", "realtek,pse-mcu-gen2-smbus";

The naming is the part most likely to raise questions, so the reasoning up
front (the binding documents it too):

  - The node describes the MCU together with its Realtek firmware, not a
    PSE chip and not the microcontroller silicon. The PSE chips sit behind
    the MCU, never appear on the bus, and are reported by the MCU and
    detected at runtime; the microcontroller itself is a general-purpose
    part (GigaDevice, Nuvoton, ...) that varies across boards. What is
    fixed and Realtek's is the firmware and its host protocol - hence the
    'realtek' prefix.

  - gen1 and gen2 are two generations of that protocol, both Realtek's:
    gen1 on older boards fronting Broadcom PSE silicon, gen2 the altered
    protocol used once Realtek shipped their own PSE silicon. The
    generation is fixed per board and is all the driver needs at DT-parse
    time, so the compatible encodes it.

  - On I2C the MCU firmware expects one of two framings - SMBus or raw
    I2C - which is a genuine programming-model difference, so it is part
    of the compatible ('-smbus' / '-i2c'). A UART attachment carries no
    framing suffix; the transport is given structurally by the parent
    'serial' node.

  - Each board additionally carries a device-specific compatible that
    falls back to the protocol one. The driver only ever binds on the
    protocol compatible; the device-specific string keeps the binding
    specific and reserves a place for a future per-board quirk without
    having to retrofit device trees already deployed in the field.

Testing
=======

 - Linksys LGS328MPCv2     (RTL8238B, I2C)
 - Zyxel GS1900-10HP A1    (BCM59121, UART)
 - Zyxel GS1900-10HP B1    (RTL8238B, UART)
 - Zyxel GS1920-24HPv2     (BCM59121, SMBus)
 - Zyxel XMG1915-10EP      (RTL8239C, UART)
 - Zyxel XS1930-12HP       (RTL8239, SMBus)

---
v10 -> v11:
 - patch 1: added Reviewed-by from Oleksij
 - patch 2: added Acked-by from Oleksij
 - rebase due to conflict in MAINTAINERS
v10: https://lore.kernel.org/netdev/20260728084307.2129515-1-jelonek.jonas@gmail.com/

v9 -> v10:
 - patch 2: fixed ordering in MAINTAINERS
 - core: dropped unused fields, can be re-added later when actually
   needed (Sashiko)
 - core: harden frame desync for I2C by including seq_num in _is_final
   helper (Sashiko)
 - core: return constant voltage when MCU reports zero, in case the
   port is not delivering. This avoids "Voltage null" errors in case a
   power limit is set while port is not delivering (Sashiko)
 - core: set_pw_limit: round up to avoid setting 0 in case the requested
   limit is below 1 LSB (Sashiko)
 - core: de-assert global port disable after MCU was discovered
   successfully (Sashiko)
 - core: fix and make more precise several comments (Sashiko)
v9: https://lore.kernel.org/all/20260726112223.1286074-1-jelonek.jonas@gmail.com/
Sashiko review: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260726112223.1286074-1-jelonek.jonas%40gmail.com

v8 -> v9:
 - dt-bindings: renamed enable-gpios -> reset-gpios, verified on boards
   that the GPIO which is used with this is connected to the MCU's
   nRESET.
 - dt-bindings: added disable-ports-gpios for GPIO that gates all ports
   (previously incorrectly assumed to be a rail gate, thus being wired
   via 'power-supply')
 - dt-bindings: dropped 'power-supply', not used anymore and confusing,
   easy to confuse with PI's vpwr-supply (Sander)
 - core: adjusted to match bindings, handling reset/disable-ports-gpio
   correctly and dropping 'power-supply' regulator stuff
 - patch 1,2: dropped Reviewed-by/Acked-by tags due to changes.
 - patch 3,4: added Reviewed-by from Kory
v8: https://lore.kernel.org/all/20260715075530.2491534-1-jelonek.jonas@gmail.com/

v7 -> v8:
 - dt-bindings: added Reviewed-by of Oleksij
 - uart: check and warn-on-error for serdev_* operations (Oleksij)
 - core, i2c, uart: added Acked-by of Oleksij
v7: https://lore.kernel.org/netdev/20260712192251.1413279-1-jelonek.jonas@gmail.com/

v6 -> v7:
 - dt-bindings: rename file to 'realtek,pse-mcu-gen1.yml', using
   specific compatible as file name (Conor)
 - dt-bindings: added Conor's Reviewed-by
 - core: replaced some leftover 'BCM/RTK' dialect framing in comments
 - core: use rolling sequence number instead of always hardcoded 0xff,
   adressing the issue that stale data might be accepted for new
   requests (Sashiko)
 - core: reordered MODULE_ calls to keep consistent across all driver
   parts
 - i2c: replaced some leftover 'BCM/RTK' dialect framing in comments
 - slight commit message adjustments
v6: https://lore.kernel.org/netdev/20260709194125.2784507-1-jelonek.jonas@gmail.com/

v5 -> v6:
 - dt-bindings: reworked the compatibles per DT-maintainer feedback
    - name the two protocol generations -gen1 / -gen2 (both Realtek's)
      instead of the -rtk / -brcm dialect suffix (Conor)
    - encode the I2C framing in the compatible (-smbus / raw -i2c) and
      drop the realtek,i2c-protocol property (Rob)
    - add device-specific (switch) compatibles that fall back to the
      protocol compatibles, with the board↔protocol pairing enforced in
      the schema (Conor)
    - rewrite the description accordingly
 - driver: track the binding rework
    - match on realtek,pse-mcu-gen{1,2}[-smbus|-i2c]; the I2C transport
      selects SMBus-vs-raw framing from a native_i2c match-data flag
      instead of reading the property (drops rtpse_mcu_needs_i2c_proto)
    - rename the internal dialect and parser symbols rtk/brcm → gen1/gen2
      (chip identifiers like RTL8238B/BCM59121 kept)
 - i2c: DMA-safe raw-I2C path — bounce each frame through a heap buffer,
   since i2c_master_send()/i2c_master_recv() may DMA and the core's
   frame buffers are on the stack (SMBus and UART paths unaffected)
   (sashiko-nipa)
 - includes: drop unused linux/mod_devicetable.h (core) (Uwe)
 - includes: drop unused linux/delay.h (uart); add
   linux/regulator/consumer.h (core) and linux/slab.h + linux/string.h
   (i2c)
 - commit messages — update the binding, core, and I2C messages to
   match (generations, framing-in-compatible, DMA note)
v5: https://lore.kernel.org/netdev/20260706112425.3149226-1-jelonek.jonas@gmail.com/

v4 -> v5:
 - split the single driver patch into three — core / I2C transport / UART
   transport. Binding stays patch 1, unchanged in shape. (Paolo)
   Please give guidance on how to if I should split more.
 - core: set_pw_limit: guard divide-by-zero on pw_set_lsb_mW; cap the
   programmed value with U8_MAX instead of a bare 0xff; prg_val is now u8.
   (Oleksij, Sashiko)
 - core: discover: also retry transient boot-time frames (-EBADMSG / -EBADE)
   within the bounded window, not just silence/NAK/not-ready (Sashiko).
 - core: pw_status: report Broadcom 0x3 → TEST and 0x5 → OTHERFAULT
   (new STS_TEST/STS_OTHER_FAULT); pw_class comment corrected (0x3/0x5
   aren't "other fault" on RTL; class-0-vs-fault note). (Sashiko)
 - core: dropped unused decoded fields — function_mode, cls_type,
   disconnect_type, pair_type, inrush_mode, limit_type, chip_addr,
   channel. (Oleksij)
 - core: removed forward declarations by moving the response structs above
   the dialect struct. (Oleksij)
 - core: get_pw_limit_ranges: reverse-Christmas-tree local ordering.
   (Oleksij)
 - core: dialect comment clarified (only divergent responses are hooked);
   commit message "parser hooks" tightened to "…for the responses that
   differ." (Sashiko)
 - core: made parse_system_info hook void, both implementations return
   hardcoded 0. (Paolo)
 - core: dropped GFP_KERNEL from kzalloc_obj. (Paolo)
 - core: dropped unneeded u32 cast
 - kept probe dev_info() for now deliberately, due to different opinions
   on whether a probe might print or not
 - NOT included Acked-by from Oleksij, due to several changes
v4: https://lore.kernel.org/netdev/20260630105651.756058-1-jelonek.jonas@gmail.com/

v3 -> v4:
 - move owner setting from core to transport, mitigating possible
   use-after-free (Sashiko)
 - resend because net-next was still closed
v3: https://lore.kernel.org/netdev/20260628222705.4052815-1-jelonek.jonas@gmail.com/

v2 -> v3:
 - dt-bindings: using brcm instead of bcm for Broadcom
 - rename the driver files and Kconfig symbols to realtek-pse-mcu-* /
   PSE_REALTEK_MCU* for consistency with the realtek,pse-mcu-* compatibles
 - rename driver-internal prefix from 'rtpse_' to 'rtpse_mcu' to
   emphasize this targets the MCU-centric setup (and leaves room open
   for eventual directly addressable PSE chips)
 - rework the vendor-prefix rationale (binding + commit message): the
   prefix names the protocol/firmware owner (Realtek documents the protocol
   and supplies the firmware), and -rtk/-brcm select the Realtek or Broadcom
   protocol dialect
 - core: reject zeroed/echo-mismatched responses via the echoed seq_num
   (a BCM PORT_ENABLE on port 0 was otherwise accepted from an all-zero
   frame)
 - core: enable the PoE supply before global-enabling the MCU, and roll
   back the global enable on probe failure or driver removal
 - core: drop inline from helpers (flagged by automated check)
 - uart: update the completion under rx_lock too, so a late frame can no
   longer make the next transaction fail spuriously with -EIO
v2: https://lore.kernel.org/netdev/20260612132944.460646-1-jelonek.jonas@gmail.com/

v1 -> v2:
 - all points flagged by Sashiko addressed:
 - uart: drop frame overflow (return count, not the stored length) so
   serdev retains no leftover bytes that would misalign the next response
 - uart: guard rx_buf/rx_len with a spinlock to close a data race between
   the async receive_buf callback and send/recv
 - i2c: return terminal MCU error opcodes (0xfd/0xfe) to the core
   immediately instead of polling to the 1 s timeout
 - core: cap BCM59121 at 30 W (802.3at) — the basic 8-bit set command
   can't program the advertised 60 W (it silently clamped to 51 W)
v1: https://lore.kernel.org/netdev/20260608205758.1830521-1-jelonek.jonas@gmail.com/

---
Jonas Jelonek (4):
  dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
  net: pse-pd: add Realtek PSE MCU core
  net: pse-pd: realtek-pse-mcu: add I2C transport
  net: pse-pd: realtek-pse-mcu: add UART transport

 .../net/pse-pd/realtek,pse-mcu-gen1.yaml      | 182 ++++
 MAINTAINERS                                   |   7 +
 drivers/net/pse-pd/Kconfig                    |  28 +
 drivers/net/pse-pd/Makefile                   |   3 +
 drivers/net/pse-pd/realtek-pse-mcu-core.c     | 988 ++++++++++++++++++
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c      | 170 +++
 drivers/net/pse-pd/realtek-pse-mcu-uart.c     | 164 +++
 drivers/net/pse-pd/realtek-pse-mcu.h          |  93 ++
 8 files changed, 1635 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-core.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-i2c.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu-uart.c
 create mode 100644 drivers/net/pse-pd/realtek-pse-mcu.h


base-commit: 69963a0678a347d57c4ac8b16939dba216eb95ce
-- 
2.53.0

