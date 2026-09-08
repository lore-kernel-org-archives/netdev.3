Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA41581255
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883035; cv=none; b=mtZGfrAt1bE1pLFZWZsDcVU39nPBH6b3v1Vse3P/WYOC5aoZeHz3NyB1zKCz8Vww6wZmNuDqrEKCqSGv2U5M6MfSaJlQ3Z4bKxz2Q+5pZkNIB+XJi5pMJ/Nnb9oBzy1FwRVxHIBQaCxVmquLnBc96dyxmLfiNDE2ta5w41MnbiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883035; c=relaxed/simple;
	bh=zi96+EZd2CP475BTpx81u2hso2C9fSpqeLLxMFMqhoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRVcwsL0LNawqu0TqXq9A9p/XZSV6L4S5AJ6gpaXcaG1uyHlB9Hj2n868Fs6ms+TutfbSvWXwOECrSFZ5es2ylD71atNctK6upN941VYJo2FjhSeqr730KnyGl1t5PJwOcYHUi+J/IU232GVeMy4e7jl7CIl4NV9p+YdZBjTOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=JzE8gBt3; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="JzE8gBt3"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so16566f8f.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788883030; x=1789487830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IQZoZUPW7XsnZUyDNP1zXoPIybWlOKVOw77p6n3MbfQ=;
        b=JzE8gBt3Xd2jajalSjWAeJqlMnEPEttBPbkDsZaKhXNkfeHwerAllsA8nvDCJ6P5+F
         2e8UQOlyO+iywF/H/gx1T/dJlmUsdpIOKWjUwk4a69Y+QsFNC0qOkBiPuhePU4U5ILKG
         Kj+kqyFwlQEZTdfy6oMtzIP39SUfwnmWBDpekAZsIwIoZ8zsIyOhO1yQyY+OUHTF1LjC
         xWI+c/VUzFEIxF99zCaUwUaDYQ70hJNQxh/zbSoSVoMmECBs3aXfYTUff9zhIRmWN6y4
         UnK0Ukw0eInBEuP8qqymgZPyi7Pk4fHjIvBVqjkpChERaSWeeVIpWRx3XLdjXBulOScx
         dLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788883030; x=1789487830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IQZoZUPW7XsnZUyDNP1zXoPIybWlOKVOw77p6n3MbfQ=;
        b=bFqZ/DMb2uh5f8jLI2zfOjd8nNuASAQ2ol2n/8D/oM4/UUCXsgMULtsbj8zu6mj7w5
         x60v3BD0QdGh7fMY5Wa6BJnrSyVxrowUekM8dBPbADX4grIqcQN9TR7XBwBpVJ/vjoKq
         hJdUIsTmXG8WmApTTZ4ZguWVeg14iu6Q3eZ3DR76S7ysmEuDddLxxqy8c53bJUo0lu4V
         I8P5JQJV3+pQjokfdruQlGls4Lnxw4Yc3TipqqueHymtGSMYFaRrx/DoyOtbC/Jb4Pj+
         BKqm7ZE+TsUNkA9/to5fT8WcmXBHrLcaOYOjez3cX2z+cdEaSjvgJ8hvIsoDfTvXnR+S
         hsFA==
X-Forwarded-Encrypted: i=1; AKwUvByFjbpKCmAfS1xlDlfD/jMeoEspF8GPA8jHw8TARjidxPEFqId8KK1KD6fhDNmlh09+SVGBiaA=@vger.kernel.org
X-Gm-Message-State: AFuF++nUGV/ORHtpURJhyq7A27XWRBxNE5WS++gX7eKyyBEjg24t1a6y
	xSZkyW3PcGDOMxI9516Qz1O6tRPxBa1k28iK2iybW/9QxVaLPQee6rmzwaIzdV1lLBY=
X-Gm-Gg: AYBFou2zXr/azbaYtsOb41JsrCX1dFszHD/v2bX4ZDbZDDUP3578V+pyFioSavKsffJ
	Criyu16G82pHTS1938VgCZ3rEBkCHfVBnxVwY+WIKYD5Su2RcwTB7beyNpdTfTw2hPYOufJehLs
	BqbjFEehV0g1nC8dooqvXUPemGpBFPbCwXIyuZ9HnaI4n4QnwJtVcjrc1eksdRISuwJuSAusX3W
	S2tmdqKxIcVNTobLc36e2c5Mg+9WB+Q7Ti9Ulex+S3ON9S9QbrBCsQVz1vsdcmVTEOGVzEi+0tO
	bfX03TeTnwrA3Y2k58PW1wExpXd0DL6x7EcDQQkMrPMWZxH+GvZyPWZiwTGsgYQL5w95whxYYJy
	dncNNs0yDJZxpG3PCLa+wDThDRsM5rH+N1ClszGPoTmt3KLjQGQ8iVL9XrgclqQpBrHlzo6K96w
	K+m38YszySuAYW5pazGQAkWvCqD8JhoNNTdIFjE/eKPQ/ahzTiaQ==
X-Received: by 2002:a05:6000:2489:b0:485:8e72:93ad with SMTP id ffacd0b85a97d-485aac58437mr501655f8f.0.1788883029989;
        Tue, 08 Sep 2026 08:57:09 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883be709sm37345704f8f.21.2026.09.08.08.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:57:09 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: ericwouds@gmail.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [RFC PATCH net-next v2 0/7] net: mdio: an MDIO device driver for the Airoha EN8811H
Date: Tue,  8 Sep 2026 15:57:00 +0000
Message-ID: <20260908155707.4164559-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha EN8811H answers its PHY ID from power-on, but it is an MD32
microcontroller until the host loads firmware into its volatile RAM.
Today one driver owns both roles: the PHY driver downloads the firmware
from .probe(), which works only when the files are readable by then and
leaves the reset line in the hands of a PHY node whose detach wipes what
was loaded.

Describe the chip instead as an MDIO device that owns the download and
the reset, and publish the PHY on a child pass-through bus once the
firmware runs. Patch 1 adds the binding. Patch 2 adds mdiodev_lock(),
mdiodev_lock_nested() and mdiodev_unlock(), the names Andrew asked for
in [1], for code that holds the bus lock across a burst without a
phy_device. Patches 3-5 move the download into the shared library,
typed on the MDIO device, and teach it to skip a download when the MD32
already runs firmware - which is what lets the two drivers coexist
whichever runs first. Patches 6-7 add the driver and its bus.

This is one half of an RFC last posted whole as v2 [2]. The other half
teaches phylink to keep a port whose PHY is expected to probe late,
under a new needs-host-firmware property; it is posted alongside this
one, and its v1 thread is at
https://lore.kernel.org/r/cover.1788711837.git.f@lex.la/
. The halves touch no common file and go to different reviewers, so they
are apart. They are not alternatives: the phylink half alone carries a
board whose chip answers its ID before firmware and whose PHY driver is
a module, and this half buys the cases that are not that - chips mute
before firmware, a built-in PHY driver whose probe fails once on missing
files and is never retried, and reset ownership. The shape also admits a
quad package, one MCU serving four PHYs; this driver passes one address
through and does not try.

There is a smaller way to do the EN8811H alone, and I did not take it:
keep the PHY driver, have it poll for its firmware from a workqueue,
and hold the link down until the download is done. It fails on the
cases above. A chip that is mute before firmware gets no phy_device at
scan, so no PHY driver ever probes it. A PHY node that owns reset-gpios
has that line asserted by phy_detach(), which erases the firmware, and
the driver cannot refuse that from inside phylib. And once the firmware
is up, nothing in phylib re-runs the initialisation the driver skipped
at probe; the driver would be doing that itself, from a workqueue,
under locks phylib expects to own.

Publishing the PHY on a child bus splits the two agents that drive this
chip onto two mutexes, so the driver holds the child bus lock around
its own access and the library beneath takes the parent one level down.
Patch 7 has the mechanism. Two choices in it are worth your opinion:
the level is a bool and not an enum mdio_mutex_lock_class, because the
helpers it picks between are the names Andrew asked for in [1], and the
parameter arrives with the patch that creates the second level so it
never sits unused. I can go the other way on either.

One shape the series does not support, though nothing rejects it: the
pass-through bus reads its parent at MDIO_MUTEX_NESTED, the same
subclass a DSA user bus takes for the switch's own parent. An MCU
sitting on such a bus gives lockdep three nesting levels of one class
across two subclasses, and a recursive-locking report. The mutexes are
distinct, so that is a complaint and not a demonstrated deadlock,
and the driver neither detects nor refuses the topology. The enum's
remaining value, MDIO_MUTEX_MUX, belongs to mdio-mux, so a third level
wants a new one - not a decision this series should make on its own.

Andrew asked whether any board with this chip sits on a bus without
direct Clause 45. I found none. The two in-tree device trees that carry
it - mt7981b-openwrt-one by compatible, mt7986a-bananapi-bpi-r3-mini by
bare PHY nodes at the chip's addresses - put it on mtk_eth_soc, and out
of tree it hangs off one of four controllers: mtk_eth_soc, the MT7530
DSA bus on EN7581, mdio-airoha on AN7583, or the SiFlower xgmac. All
four set read_c45, and none of those boards reaches the chip through an
mdio-mux or a bitbanged bus.

The status poll keeps the Clause 22 indirection, which patch 4
explains. It is a preference and not a necessity: the chip does answer
Clause 45 before its firmware, and the board readings below say what it
answered.

System sleep is handled but untested, since this board gives no way to
cut power to the PHY. A power-cutting suspend wipes the MD32, so
.resume repeats the reset decision and the download in line, because
the child PHY's own resume calls phy_init_hw() immediately after and
needs the firmware by then. request_firmware_direct() already caches what
it loaded, so the explicit registration exists for the adopt path, where
loaded, so the explicit registration exists for the adopt path, where
no file was ever read and the cache would otherwise hold nothing. A
resume that cannot reload restores the chip and not the port; question
3 says why.

Tearing the MDIO device down while its child PHY is attached crashes:
mdiobus_unregister() removes the PHY's driver without freeing the
interrupt its consumer requested, so the next interrupt dereferences
phydev->drv after phy_remove() cleared it. No open or close is needed.
Module unload cannot reach it, because attaching a PHY takes a
reference on the bus owner, and sysfs unbind cannot, because the
attributes are suppressed. Removing the parent MDIO controller still
can; question 3 again.

Tested on an MT7981B board (MT7531 switch, EN8811H on a 2500base-x
port), warm boots only - I have no remote way to cut power. The board
runs OpenWrt, so what booted is these patches backported onto its 6.18
tree, not the mailed text byte-for-byte. What the board showed:

 - download and handover on the normal boot path: U-Boot leaves the
   MD32 in its bootloader on every reboot here, so each boot runs the
   driver's pulse-reset and download; ~144KB lands in about two
   seconds, which is what 73728 Clause 22 frames cost at the 2.5 MHz
   MDC these boards default to; the driver reports the firmware it
   loaded at 6.33 s, and the PHY driver finds that firmware already
   running at 6.39 s and skips its own download through the shared
   check
 - the PHY is attached at 7.10 s through the child bus with irq=15 from
   DT and not PHY_POLL; the port reaches forwarding and the link
   comes up at 20.1 s, and the interrupt line counts link events across
   forced renegotiations
 - Clause 45 before firmware: with the MD32 never programmed, read on
   the parent bus while the child bus does not exist, the PMA/PMD
   identifier is 0x03a2, matching the Clause 22 pair 0x03a2/0xa411 at
   the same address, and the vendor status reads 0x0000 where a silent
   chip would float to 0xffff

Two of the v1 review points [3] went a different way than asked, and
each gets a sentence rather than silence. The shared header went to
include/linux/mdio/ beside the other MDIO driver headers: include/net/phy/
does not exist, and include/linux/phy/ is the generic PHY framework. And
the copy of parent->irq[addr] onto the child bus was in v2 and is gone
from v3. A bus's irq[] starts as PHY_POLL from mdiobus_register(), and
the DT path fills an entry only when it registers a PHY at that address,
from the PHY node's own interrupts property. The MCU node is not a PHY,
so the parent's entry at its address stays PHY_POLL, while the child bus
gets its own entry filled from the child PHY node when that bus is
registered. The copy carried PHY_POLL over a value the child fills
correctly on its own, and the board's irq=15 comes from the child node
either way.

The base matters for patch 5: it makes the MCU restart on the adoption
path, and commit 03b4702fc5e3 ("net: phy: air_en8811h: move LED GPIO
configuration to config_init") with commit 3498acda6b68 ("net: phy:
air_en8811h: restore AN8811HB LED GPIO after MCU restart") moved the
LED GPIO enable to the end of config_init, after that restart. On an
older base the restart would have cleared the buckpbus-mapped GPIO
state with nothing to re-enable it. The firmware size check landed as
commit daf0972d38e9 ("net: phy: air_en8811h: refuse a firmware blob
that is not a multiple of 4"), and patch 4 carries it into the library
with the write loop it guards.

What I am asking:

 1. The binding lets software timing pick the topology: the same chip
    on the same board is a plain PHY node when its firmware is in the
    bootloader, and an MCU with a child bus when the firmware arrives
    with the rootfs. Move the files into an initramfs and the
    recommended description changes without a wire moving. The hardware
    argument that does hold is narrower - the reset line belongs to the
    MD32 core rather than to the PHY the firmware creates, and a PHY
    node that owns it wipes the firmware on detach - and it argues for
    the MCU node, not for the child bus. If the child bus has to be
    justified by hardware too, I do not have that argument, and the
    honest options are to describe the chip one way always, or to say
    plainly in the binding that this is a driver model choice. Which
    would you rather see?

 2. A third nesting level has no subclass, as above. Should this series
    add one?

 3. Removing the parent MDIO controller reaches this driver's remove
    with the child PHY attached, and nothing pins the parent's owner.
    Closing it wants a way for a bus to tell its PHYs' consumers to let
    go, which is a phy-core change. The failed-resume path above wants
    the same channel for "re-initialise" rather than "let go", so that
    is two uses for one mechanism. Is it worth doing here?

 4. MDIO_AIROHA_EN8811H sits in the "MDIO controller drivers" menu,
    though it drives a device on a bus and not a controller. The
    mdio-mux entries set the precedent, but say if you want it
    elsewhere.

 5. The child bus accepts exactly one address, the one this node
    occupies on the parent, and I do not think the schema can say so.
    What it does say now is that a child named ethernet-phy@N is
    validated as one, and that it must not carry reset-gpios or its
    timings - the whole reason this node exists is that a PHY-node
    reset is what phy_detach() asserts, and it erases the firmware.
    What it cannot say is that a differently named child is refused:
    mdio.yaml's own patternProperties evaluates any node@hex and its
    additionalProperties: true admits the rest, so unevaluatedProperties
    has nothing left to reject. Is prose enough for the address, and is
    there an idiom I am missing for the rest?

 6. include/linux/mdio/mdio-airoha-en8811h.h is named for the driver
    that consumes it, while its four neighbours in that directory name
    the driver that implements them - here the implementation is
    drivers/net/phy/air_phy_lib.c. Where should this header live, and
    should the MAINTAINERS entry that now claims it also claim the
    library files it declares?

Changes since v1:

 - the child PHY node references airoha,en8811h.yaml instead of the
   generic ethernet-phy schema. On the generic one the polarity
   properties that PHY defines are unevaluated, so a device tree using
   airoha,pnswap-rx on the child was rejected; the example check says
   so, and says it passes now.
 - resets and reset-names are closed on that node beside reset-gpios.
   Only the GPIO spelling was refused before, while mdio_device_reset()
   pulses reset_ctrl the same way, so a reset controller on the child
   node validated and would have erased the firmware.
 - both were found by the Sashiko AI review. Its third point, that
   pm_ptr() should replace pm_sleep_ptr() on the driver's dev_pm_ops,
   is not taken: DEFINE_SIMPLE_DEV_PM_OPS builds the ops out of
   SYSTEM_SLEEP_PM_OPS, which CONFIG_PM_SLEEP guards, and of the 34
   files in drivers/net that define ops that way, 26 use pm_sleep_ptr()
   and none use pm_ptr().
 - question 5 below still stands, and the answer to the part about a
   differently named child has not changed.
 - v1: https://lore.kernel.org/r/cover.1788711797.git.f@lex.la/

[1] https://lore.kernel.org/netdev/29f973e4-980d-4198-bbec-452f7421d416@lunn.ch/
[2] https://lore.kernel.org/r/cover.1788548229.git.f@lex.la/
[3] https://lore.kernel.org/netdev/20260829052546.1152446-1-f@lex.la/

Aleksei Sviridkin (7):
  dt-bindings: net: add Airoha EN8811H PHY MCU
  net: phy: add mdiodev_lock(), mdiodev_lock_nested() and
    mdiodev_unlock()
  net: phy: air: type the buckpbus core on the mdio device
  net: phy: air: move the EN8811H firmware download into the library
  net: phy: air: skip the download when the MD32 is already running
  net: mdio: add Airoha EN8811H MDIO device driver
  net: mdio: en8811h: add the nested bus

 .../bindings/net/airoha,en8811h-mcu.yaml      | 119 +++++
 MAINTAINERS                                   |   8 +
 drivers/net/mdio/Kconfig                      |  13 +
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-airoha-en8811h.c        | 382 ++++++++++++++++
 drivers/net/phy/air_en8811h.c                 | 151 +------
 drivers/net/phy/air_phy_lib.c                 | 421 ++++++++++++++++--
 drivers/net/phy/air_phy_lib.h                 |  27 ++
 include/linux/mdio/mdio-airoha-en8811h.h      |  25 ++
 include/linux/phy.h                           |  16 +
 10 files changed, 984 insertions(+), 179 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
 create mode 100644 drivers/net/mdio/mdio-airoha-en8811h.c
 create mode 100644 include/linux/mdio/mdio-airoha-en8811h.h


base-commit: ab217fbb9b2169ce677b09a66558d5c3adcfbb76
-- 
2.53.0

