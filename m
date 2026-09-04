Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E4A3C9895
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788548595; cv=none; b=eN4ra+byRFT3FobADYnmzDpRT5FEMYEUtFlhGXmTl/3/Zhw8qi2dts2dQrMfUotxOKxY+vMmTForqBVlKfgV4V+UNoIk2w9+PuugcYyMwYtG4x0j/94O62U4v5FyiK09PMZ7V8u1qH4hmh0hMANyOToFyexgnP7vbnhL5/G0+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788548595; c=relaxed/simple;
	bh=gXvwVPKN6ayujaHzp5Wyj6IuDPOSdaTITqxhFxJ5BFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEkoHY4OPAgIamO1LWiLG37knZ8CkNr5M9qbzQGCZcKLQwUeGpnApHZMiGGx+P9jND3W2DFDDVQ9HWVnKmLitit4vQSDP4rRYveb+RRl+v4Mdl9M2+zbcvq9lbjaTW+LBqj7yttdq5BdoneTFu79fI6o8K8gnnntauBcBe+4pM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=H06JGQcX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="H06JGQcX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso11874135e9.1
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788548587; x=1789153387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s92xjaNLbPPzxF6wAx2JWwCYalQPcim70mfvXiP3Qag=;
        b=H06JGQcXXDs3yT1wZP3UH9lrd8RJs1767zfqVnQ73l2Jh1hg3k16yOdhqtv2mmTXhk
         v+mv6O+vPsUXO1z6ZkP/zFLxXJ0NxaicE0N155u0VTzE2RYrnRZ2k7145enIZFVvsYwN
         PdCwk0hxfko3Crn/J5mX/Mt/6D183BfUT7v5Fe1HIzJfoGrlcESgc/CkqB7slXZdFR0z
         yDkmjbSaFQU97PeNoUmklor9C2GcQ1sDqs+TCjq5WN56yozmcerBNLyhr6cGUkPOmL1/
         CSMcQ6TJ+Vi5Lvldt+WEpSQPEp87ms8PfNei/k1ag737WEhhezGCB5iMoIzYV5tZpg8q
         DmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788548587; x=1789153387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s92xjaNLbPPzxF6wAx2JWwCYalQPcim70mfvXiP3Qag=;
        b=Ed3UuIurhE62avaIxD6iCXDAItyf0sL1EiTroA11CDIrgnoJDWFx0o18pA0GNzb6hH
         eBOc6gcnvC7EaV0/1iBi6wpSTDpK20D3UewQiAAaurMunYUXEADHZrKHH60GWNto9UmA
         Egpa/TszeElpamUlEIAte0noiYHXv2jf7XZyLrvvCIigwpPT6NqQmUHYrDvA1vnN7loF
         M8VeIQA8Z35ejwCHmVi10zn8+JM3/yO+LCjPBGehJLq3zZ3vEcDqja+8DxXv40NmlUOX
         G+D8Vf0Ja9RLs6yiESSUvM+7TwB+x81w7kNRTDw73GXCZGv7SCh4xVWY9ZZ6WX9Z8Wce
         BHrQ==
X-Forwarded-Encrypted: i=1; AKwUvByLssFEOjyAztjS8SAVvwi0C+0aU0SvLe6m7uExny5MyOKw2fD9sarg3jp3yNLTMDfHcncm+qY=@vger.kernel.org
X-Gm-Message-State: AFuF++lEt9dGlgXW3q5oNrovdSLlpCvhezmrgJRUgHtpJg9VbVw0u9eg
	kYYzJjySdyACQjopxliaS3N/swYr7uGKq/u3lEUSfQRtvIWMQcT6CWhfaMRv20vP8Zw=
X-Gm-Gg: AYBFou0YRdskRczOUPe2RtnVzeqkI8h75oUC2MJM0n+EXnIuwlRL2hzQKfgks7lchzz
	ZT8aI+7vpnFuGfmOmgC2P/4kXmab7h3+ktrovrhfZLdsXKdhUxUzmbKs3YaeYFzFygw7hHKsYO4
	AlEdClFHH3tcOwrRzH89LDD1xY45VWcxFoXimlaEXtRvG+Jgu7DTGwECr2vma7Peic5FfFciFrl
	uKc+/yyd9q+pIQz3OuYLfblOu+mgVZWT8voip9YEhfvq+YRJeI2/XKs24xIQR97Js4Lt6WdnBbE
	70AhZrDk2G9067wlut4yPBUtn7gnALMrRyevHY/gSZxBq4EGIyhOXPWt+Je08/Jgdzh34RQiy0h
	vTpF109kI/byh3/Q79vzQGLezjF3S+t4V+VcIU58Qqw0a+VBG9mku6rZvp+mpYNIPDVw+0PpT8G
	cH/9UPjh8kHgE454y23rxG7QEFO3M0HkoNnW8v86M=
X-Received: by 2002:a05:600c:138e:b0:49c:d818:8771 with SMTP id 5b1f17b1804b1-49cf8240ba5mr77169535e9.7.1788548586297;
        Fri, 04 Sep 2026 12:03:06 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60d8a6sm172195485e9.10.2026.09.04.12.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:03:05 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next v2 00/10] net: survive a PHY whose firmware arrives after the MAC probes
Date: Fri,  4 Sep 2026 19:02:54 +0000
Message-ID: <cover.1788548229.git.f@lex.la>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha EN8811H answers its PHY ID from power-on, but it is an MD32
microcontroller until the host loads firmware into its volatile RAM,
and on systems that keep the firmware files in a filesystem those
files become readable long after the MDIO bus was scanned. Today the
DSA port that names such a PHY is dropped at switch probe and stays
dead for the whole uptime.

This follows the direction Andrew sketched in [1]: describe the chip
as an MDIO device that owns the download and the reset line, publish
the PHY on a child bus only once the firmware runs, and teach phylink
to wait for a PHY that is expected to probe late.

Patches 1-2 add the bindings. Patch 3 adds mdiodev_lock() and
mdiodev_unlock(), the names Andrew asked for in [2], for code that
holds the bus lock across a burst without a phy_device. Patches 4-6
move the download into a library helper typed on the MDIO device and
teach it to skip a download when the MD32 already runs firmware, which
is what lets the two drivers coexist whichever runs first. Patch 7 adds
the MDIO device driver, patch 8 the pass-through bus, patches 9-10 the
phylink half. Patches 9-10 alone carry this board, whose chip answers
its ID before firmware; the MDIO layer buys the general case - chips
mute before firmware, quad-PHY packages, reset ownership.

Tested on an MT7981B board (MT7531 switch, EN8811H on a 2500base-x
port), warm boots only - I have no remote way to cut power. The board
runs OpenWrt, so what booted is these patches backported onto its 6.18
tree rather than the mailed text byte-for-byte. Two hunks needed
adapting to that tree: one keeps a local in-band guard upstream has
since dropped, and one moves the delayed work's initialisation ahead of
a setup step that can return early there. What the board showed:

 - download and handover, normal boot path, no unbind: U-Boot leaves
   the MD32 in its bootloader on every reboot here, so each boot runs
   the MCU driver's pulse-reset and download; ~144KB lands in about
   half a second, the MCU driver reports the firmware it loaded at
   6.33 s, and the PHY driver finds that firmware already running at
   6.39 s and skips its own download through the shared check
 - phylink attaches the PHY at 7.10 s through the child bus with
   irq=15 from DT rather than PHY_POLL; the port reaches forwarding and
   the link comes up at 20.1 s, and the interrupt line counts link
   events across forced renegotiations
 - the case the series exists for, a PHY arriving while the port is
   already running: attach at 67.44 s, carrier at 71.93 s, so 4.5 s,
   and the PHY's interrupt fires without any port bounce. This needs
   the net fix [4]; without it the same path left the port dead
 - an ifdown/ifup cycle disconnects and reconnects cleanly
 - the stopped-port path, reached deterministically by booting with the
   firmware out of reach and putting the port down while the PHY cannot
   exist: the PHY attaches to the stopped port, sits there attached and
   carrier-less, and the later up starts it, with the link three
   seconds behind
 - the wait itself: one warning at 65 s naming the property and the
   missing PHY, then a 29.19 s gap between the PHY becoming usable and
   the poller noticing it - the ceiling doing its job, where the
   initial one-second interval would have attached within a second

Not exercised here, and I would rather say so. The irq[] copy on the
pass-through bus is a no-op on this board: the PHY sits on the SoC bus
and its interrupt comes from its own DT node. The -EBUSY exit where the
poller gives up was reasoned about, not reached - it needs two nodes
pointing at one PHY, which this board cannot express. The retry after a
failed connect cannot be reached here at all: the EN8811H reports
RATE_MATCH_PAUSE, so phylink_validate_phy() never intersects the port's
line-rate modes with the PHY's copper ones and no MAC-supported
interface makes it return -EINVAL. That is worth knowing beyond this
board - the retry branch fires for PHYs that do not rate-adapt, which is
not the case that motivated the series.

No in-tree device tree sets phy-needs-host-firmware yet. The board I
tested is supported out of tree, in OpenWrt; the in-tree
mt7986a-bananapi-bpi-r3-mini carries the same chip and would be the
first candidate, but I have no such board to test the conversion on.

Andrew asked whether any board with this chip sits on a bus without
direct Clause 45. I found none. The two in-tree device trees that name
it (mt7981b-openwrt-one, mt7986a-bananapi-bpi-r3-mini) put it on
mtk_eth_soc, and in OpenWrt it hangs off one of four controllers:
mtk_eth_soc, the MT7530 DSA bus on EN7581, mdio-airoha on AN7583, or
the SiFlower xgmac. All four set read_c45, and none of those boards
reaches the chip through an mdio-mux or a bitbanged bus.

The status poll keeps the Clause 22 indirection. It went through
phy_read_mmd(), which resolved the mode from phydev->is_c45 - false for
these Clause 22 PHYs - so the constant in the moved helper records what
the code already did rather than choosing it. The chip does answer
Clause 45 before its firmware, though. With the MD32 never programmed,
read on the parent bus while the child bus does not yet exist, the
PMA/PMD identifier comes back as 0x03a2, matching the Clause 22 pair
0x03a2/0xa411 at the same address, and the vendor status reads 0x0000
rather than the 0xffff a silent chip would float to. So the indirection
is a preference, not a necessity.

The flag sits on the MAC/port node because that is where the waiting
happens: phylink keeps the port and polls until the PHY turns up. The
PHY node could carry it instead. phylink resolves phy-handle to a
fwnode before it needs the device, so reading the property from the
referenced node is a one-token change, and a PCS node could carry its
own the same way. Which node do you want it on?

One behaviour change worth naming here: once the MCU driver adopts a
running MD32, the image in RAM wins over the files on disk, so writing
new firmware and rebinding keeps the old image running until a power
cycle. Every in-tree board with this chip keeps reset-gpios on the PHY
node, and phy_detach() asserts that line, so the mitigation is there.

Known and left out: system sleep. A power-cutting suspend wipes the MD32
and nothing re-downloads on resume; the obvious fix, queueing the
download from .resume, cannot run before the PHY child resumes
(freezable workqueues thaw after dpm_resume_end()), so it needs a
synchronous re-download from the firmware cache and S2R testing this
board cannot give. The poller never gives up either, because the errno
out of a failed bringup cannot distinguish "still filling in link modes"
from "genuinely incompatible": a site with the property and no PHY polls
at the 30 s ceiling for the uptime, after one warning in the first
minute. The backoff exists because a failed bringup ends in
phy_detach(), which pulses a PHY-node reset line. Unbinding the MDIO
device at runtime removes the child bus under an attached PHY, and
either the next open or the next close then dereferences the stale
phydev, in phy_start() or phy_stop(); that path predates this series
(any mdio-mux unbind does the same) and wants a phy-core fix rather than
a workaround here. Adoption itself does not depend on it and is
exercised on the ordinary boot path.

The attach lands anywhere in [0, poll interval) after the PHY becomes
ready, ~0.5 s mean at the 1 s interval. The exact edge exists -
BUS_NOTIFY_BOUND_DRIVER fires from driver_bound() after phy_probe() has
set PHY_READY - so an event-driven follow-up is a bus notifier plus a
one-shot work item. Polling first was the plan agreed in [1]; say if
you want the notifier in this series instead.

Why not -EPROBE_DEFER and fw_devlink: the phy-handle supplier link is
satisfied as soon as the PHY device exists, and here it does not exist
at all until the MCU driver has loaded the firmware and registered the
child bus. Nothing in the device core waits for a device that has not
been created. Cost in struct phylink: six fields and a delayed_work.
The flag is a request for a dedicated PHY driver - a PHY meant to run
on the generic driver must not carry it, or the wait never ends.

The base matters for patch 6: it makes the MCU restart on the adoption
path, and 03b4702fc5e3 with 3498acda6b68 moved the LED GPIO enable to
the end of config_init, after that restart. On an older base the
restart would have cleared the buckpbus-mapped GPIO state with nothing
to re-enable it.

This is based on net-next 6ebcf5074cff with patch 1 of the pending pair
[3] applied - the series needs a late bringup failure to leave
pl->phydev clear, or every retry hits -EBUSY; format-patch lists it as a
prerequisite. It also wants [4], a fix now on the list for net: a forced
major configuration can run over an uninitialised link_state, and the
poller in patch 9 reaches it on a port that is already up when the PHY
arrives, because the attach reports the not-yet-started PHY as down and
the resolve then takes the link-failed branch. Patch 5 moves the
firmware write loop that the pending size check [5] guards; whichever
lands first, the other rebases trivially.

[1] https://lore.kernel.org/netdev/a230d199-5d4d-4637-aff3-e725a37e1da1@lunn.ch/
[2] https://lore.kernel.org/netdev/29f973e4-980d-4198-bbec-452f7421d416@lunn.ch/
[3] https://lore.kernel.org/netdev/20260902080511.2211261-1-f@lex.la/
[4] https://lore.kernel.org/netdev/20260904185540.2844261-1-f@lex.la/
[5] https://lore.kernel.org/netdev/20260903123650.23855-1-f@lex.la/

Changes since v1 [6]:
 - Andrew Lunn: the property names the entity instead of describing the
   MAC node it sits in, and states the hardware fact rather than an
   event in the driver model: phy-needs-host-firmware (2)
 - Andrew Lunn: that binding's commit message is rewritten; the open
   question it states is placement now, not naming (2)
 - Andrew Lunn: both binding descriptions are hardware only - no
   driver, no kernel symbols, no filesystems (1, 2)
 - Andrew Lunn: mdiodev_lock()/mdiodev_unlock() beside
   phy_lock_mdio_bus(), so the library stops open-coding the bus
   mutex (3, new)
 - Andrew Lunn: the buckpbus core and the firmware loader are typed on
   struct mdio_device, using the existing __mdiodev_read/write (4, 5,
   6); the MMD status poll stays on the Clause 22 indirection, since
   the data path was already Clause 22 - see above (5)
 - Andrew Lunn: the symbols the MDIO driver consumes moved to
   include/net/phy/air_phy.h instead of reaching into ../phy/ (7)
 - Andrew Lunn asked for dev_warn_once(); kept a per-device flag,
   because dev_warn_once() is per call site and
   mt7986a-bananapi-bpi-r3-mini carries two of these chips (7)
 - Andrew Lunn: the comment claiming the chip enumerates as a C22 PHY
   is gone (7)
 - Andrew Lunn: the parent bus's interrupt is copied onto the
   pass-through bus so a PHY behind it is not forced to poll (8);
   phy_mask stays unset because of_mdiobus_register() overwrites it
 - the readiness test is device_is_bound() rather than phydev->drv,
   which phy_probe() publishes before the driver's probe has filled in
   the supported mask (9)
 - the poller configures the MAC before it starts the PHY, the order
   phylink_start() uses (9)
 - a late attach forces a major reconfiguration, so a port started with
   no phy-mode leaves PHY_INTERFACE_MODE_NA; the not-yet-usable poll
   backs off after the first warning, ceiling 30 s (9)
 - while the PHY is pending, ksettings_get reports SPEED_UNKNOWN and
   DUPLEX_UNKNOWN with no link modes, relying on the ethtool core's
   zeroing for the masks, and ksettings_set and set_pauseparam return
   -EOPNOTSUPP - with the port up, set_pauseparam would program the PCS
   from an advertisement seeded by the MAC mask (10)
 - the download reports adoption distinctly from loading, and adopting
   a running MD32 no longer writes FW_CTRL_1: that write was an
   unpaired FINISH into a chip that had just reported ready, and the
   poll after it asked a question already answered (6)
 - a failed pass-through bus registration is retried, since fwnode_mdio
   returns -EPROBE_DEFER for an interrupt controller that has not
   probed yet; the download is not re-run (7)
 - MODULE_FIRMWARE for the EN8811H files moved off the shared library,
   which AN8801-only systems also load, onto the MDIO driver (7)
 - the netdev AI review of v1 raised four points, all answered: the
   dangling pl->phydev after a late bringup failure goes to the
   prerequisite [3] rather than here (9), the suspend hole is stated
   above as known and left out (7), the naming question is answered by
   the rename (2), and the uninitialised masks rest on the ethtool
   core's zeroing, argued in the patch (10)
 - commit message of the phylink wait patch shortened (9)
 - rebased onto net-next 6ebcf5074cff

[6] https://lore.kernel.org/r/20260829052546.1152446-1-f@lex.la/

Aleksei Sviridkin (10):
  dt-bindings: net: add Airoha EN8811H PHY MCU
  dt-bindings: net: ethernet-controller: add phy-needs-host-firmware
  net: phy: add mdiodev_lock() and mdiodev_unlock()
  net: phy: air: type the buckpbus core on the mdio device
  net: phy: air: move the EN8811H firmware download into the library
  net: phy: air: skip the download when the MD32 is already running
  net: mdio: add Airoha EN8811H MDIO device driver
  net: mdio: en8811h: add the nested pass-through bus
  net: phylink: wait for PHYs that are known to probe late
  net: phylink: report no link modes while a late PHY is missing

 .../bindings/net/airoha,en8811h-mcu.yaml      |  96 +++++
 .../bindings/net/ethernet-controller.yaml     |   7 +
 MAINTAINERS                                   |   7 +
 drivers/net/mdio/Kconfig                      |  11 +
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-airoha-en8811h.c        | 282 ++++++++++++++
 drivers/net/phy/air_en8811h.c                 | 143 +------
 drivers/net/phy/air_phy_lib.c                 | 357 ++++++++++++++++--
 drivers/net/phy/air_phy_lib.h                 |  22 ++
 drivers/net/phy/phylink.c                     | 200 +++++++++-
 include/linux/phy.h                           |  10 +
 include/net/phy/air_phy.h                     |  23 ++
 12 files changed, 977 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h-mcu.yaml
 create mode 100644 drivers/net/mdio/mdio-airoha-en8811h.c
 create mode 100644 include/net/phy/air_phy.h


base-commit: 6ebcf5074cff0402730c6981d2397139fee6322d
prerequisite-patch-id: 293623f600b825505376e5c5bf72df2ac1f58e1e
-- 
2.53.0

