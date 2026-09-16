Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079DD4DD6E6;
	Wed, 16 Sep 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554087; cv=none; b=S12UgomjoHpVPCKzPwk7Wm9Y3lVOTJ6pv+0Ds5LWTQEOnnZKK72uhi3ucT3PrsOHD6g0bv0Zc2F42mLDbv4druw2H74AiAPSVG+s5lfminnxBFLN5RRJSkYs1hD09bs0yWu61aTAtn1Us5ZBe+Kt4qVOeOWFMo+XloWnwj17Njc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554087; c=relaxed/simple;
	bh=gJnfg39A31FuJpR9qu2Nn5D6Z799oXd02vj22CFcnx8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OTV1y5ZTSYHGtNw2MAtvMUr1EMlZ/1hO6wJzq41XMvauY4j/2H7mz/peaBYBwpaz+OiP7FsJcIhH0WK5yMv8437pMycWb+IuL3/cVamB5PNkGPl60/iRoa47lJLag4F8ObXo7YZz7wqfC0WZuXiRETK2fiCSoqz3/Ocoq9kyeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQGT5TCp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQGT5TCp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDD01F00898;
	Wed, 16 Sep 2026 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554065;
	bh=TtgBDQ4FNslD4tBVwzjA/MF2dJs29rCfgmcA6BCtIP0=;
	h=From:Subject:Date:To:Cc;
	b=XQGT5TCpImNYavut5FCYC/YDZgb0xbSpzgjbHa5lWBWnfIe3TCPnBWwW/63xkxJId
	 rcns/HpYNSlHWAoN6EHIxEUU9fFwXP2rPtk1aNrQT35Q6grtF4NcQYUw5VPkaP6aYy
	 k/vP8j+0ZnUsaTOox+gvVRNQ0UjqNWXzkAjm28/9WiOmQ5m/afWgY5tYFA95nO5AYs
	 uXswoarBzp7F191f8T85Y8IFq6gUC8XQ0WV3zLoSc1sNT5abVt5cIbgsgGldK8kKrz
	 T9CW+8QqyeeqttKA8DeBG2sxqlKGMz97s9r1CKvYUS5Y3LR6dvpKSTo65Tu5wiKlpO
	 oqAAXqahOlz7g==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v15 0/4] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Date: Wed, 16 Sep 2026 12:20:57 +0200
Message-Id: <20260916-ks8995-to-ksz8-v15-0-8825ff5fd4be@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23STW7cMAwF4KsEXtcFKYmS2FXvUWRhSVTipvAUt
 jNIG8zdKzuLUcvu/Pc92vR7HzZZZ9mGLw/vwyrXeZsvSztB+vQw5OdpeZJxLu3CYMB4IODxZYv
 MNO6XdvQ7jkjVVs7RBKxDQz9XqfPbmfhtWGQfF3nbh8ePO9tr+i55P/KOZ5/nbb+sv87hVzzFx
 xj0/4654ghjgAJS3TRRdV9fZF3kx+fL+nSmX03njVHeNE8BTYaSWQIpb3uv59vmM1monpAjV+X
 d3XuwyrvmBQkdSzUoQXnqvVOemueYJkmOxHv9/r73UXnffGFs3ErJWftw9+E/80PzZqogbfuOp
 qh8vPtoUfnYfC1YUjIpeNGe755B75+bjyVGpIkxFe0R+gC9AISjQTawsSzJk/6DiH0C64SjgyD
 gHOJExEUndCVk1EvAs4XZOmMKlGBEJ9g+QdcIjx5aExL6YqF9iE5wfYL+kXg00bbhnk2ymf9u4
 u12+wMrSMj/FAQAAA==
X-Change-ID: 20260509-ks8995-to-ksz8-15f3f9c8271f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0

This series breaks with the dated attempt to polish the old
KS8995 driver, and instead implement support for the KS8995XA
in the KSZ driver, and after that delete the old KS8995 driver.

The hardware clearly has the same ancestry, the KSZ8995XA is
just a rebrand of the much older Micrel KX8995XA switch.

The old driver identified the shared 0x95/0x0 ID as KS8995MA, but
this ID cannot distinguish MA from XA. No KS8995MA users are known,
and KS8995E has no documented SPI management interface. Neither
variant has been verified with the replacement driver.

Add new compatibles, add special code paths for the KSZ8995XA,
including support for its two-level DCB priority model, and add a
new tagger for the special front tag found in the KSZ8995XA.

The patches, including the per-port PHY reset polling, were tested
with the Actiontec MI424WR rev D (which has the KS8995XA) and
OpenWrt as userspace.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v15:
- Require a complete, linear Ethernet header before KS8995 TX tag
  insertion, rejecting truncated frames and pulling fragmented headers.
  Fringe case, but the AI found it so fixed it up.
- Link to v14: https://patch.msgid.link/20260914-ks8995-to-ksz8-v14-0-3d72692b3c97@kernel.org

Changes in v14:
- Add a KS8995 flow dissector using the four-byte in-band RX tag length,
  keeping the eight-byte TX headroom reservation separate.
- Link to v13: https://patch.msgid.link/20260913-ks8995-to-ksz8-v13-0-327b16d309eb@kernel.org

Changes in v13:
- Limit XA apptrust to one selector at a time, since PCP and DSCP results
  are ORed rather than ordered; reject both-enabled readback as well.
- Use the XA fast-age control instead of changing the 802.1p priority
  threshold, and wait for its 800 us cycle before restoring normal ageing.
- Link to v12: https://patch.msgid.link/20260911-ks8995-to-ksz8-v12-0-5c3422d0d72e@kernel.org

Changes in v12:
- Program both KSZ8995XA port tag-control bits together, clearing the
  opposite setting so stale bootloader configuration cannot leave both on.
- Handle KS8995 receive tags in VLAN metadata as well as in-band,
  validating the source-port bits before deciding whether to untag.
- Reserve eight bytes of KS8995 transmit headroom for the switch tag
  and a hardware-accelerated VLAN tag, avoiding an extra head expansion.
- Link to v11: https://patch.msgid.link/20260909-ks8995-to-ksz8-v11-0-0e04411a559d@kernel.org

Changes in v11:
- Drop KSZ8995XA from the three-port binding exception so ports 3 and
  4 receive generic DSA port validation.
- Reject invalid KS8995 receive port masks before ilog2() so plain
  802.1Q frames are dropped safely.
- Propagate KSZ8995XA PHY reset assertion errors instead of treating
  a failed write as a completed reset.
- Do not advertise legacy VLAN behavior for KSZ8995XA, preserving genuine
  ingress VLAN tags through the DSA receive path.
- Link to v10: https://patch.msgid.link/20260908-ks8995-to-ksz8-v10-0-7379239eb65f@kernel.org

Changes in v10:
- Wait for the KSZ8995XA per-port PHY reset bits to clear before
  continuing setup; verified to work on Actiontec MI424WR rev D
  hardware.
- Drop the unreachable KSZ8995XA VLAN filtering check because the
  restricted switch operations do not expose that callback.
- Add KSZ8995XA to the binding's Ethernet-port schema exception list.
- Convert big-endian KS8995 transmit tag fields to host byte order
  before logging them.
- Align the KSZ8995XA SPI ID with its DT compatible to restore module
  autoloading and avoid the SPI registration warning.
- Link to v9: https://patch.msgid.link/20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8@kernel.org

Changes in v9:
- Fold the legacy Micrel compatibles into KSZ8995XA support and use an
  exact tristate dependency to avoid probe races and bisect gaps.
- Always prepend a distinct KS8995 switch tag to preserve existing VLAN
  headers and avoid unsafe MAC-header access on direct transmit paths.
- Rate-limit KS8995 receive untagging errors to avoid log flooding.
- Link to v8: https://patch.msgid.link/20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org

Changes in v8:
- Add DCB support for the KSZ8995XA two-level priority model and set its
  internal priority map count to two.
- Initialize the KSZ8995XA per-port default tags to VID 0 so the tagger can
  distinguish originally untagged packets from VLAN-tagged frames.
- Push non-802.1Q hardware-accelerated VLAN tags into the packet before
  adding the KS8995 tag, so they cannot displace the switch tag from its
  required offset 12.
- Account for the discrepancy between the documented and observed
  KSZ8995XA MTU behavior. Its packet-size control bits use the same
  polarity as the other KSZ8 switches, while using the opposite polarity
  documented in the manual makes the switch hang on big packets.
- Rebased on v7.3-rc1
- Link to v7: https://patch.msgid.link/20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org

Changes in v7:
- Rebased on v7.2-rc1
- Rebased on top of Bastiens cleanups.
- Rebased and reworked on top of my patch changing the SKB ownership
  model in the taggers.
- Drop bogus reset routine, keep per-port reset but use the right
  defines.
- Properly implement the 2way queue split support (low/hi prio)
- Drop bogus surplus ops assignment.
- Link to v6: https://patch.msgid.link/20260608-ks8995-to-ksz8-v6-0-d91eb43edcc5@kernel.org

Changes in v6:
- Provide a prompt along with the transition symbol NET_DSA_KS8995
  so that oldconfig works.
- Clarify in commit message that the platform data probe path is
  unused in the kernel and it is fine to delete this mechanism.
- Link to v5: https://patch.msgid.link/20260604-ks8995-to-ksz8-v5-0-98baeb45e665@kernel.org

Changes in v5:
- Rebase on net-next again to be sure we apply.
- Fix the codepath where DCB was set up per-port, damaging KS8995XA
  port registers.
- Fix up the transitional symbol NET_DSA_KS8995 to depend on
  SPI and select both NET_DSA_MICROCHIP_KSZ_COMMON and
  NET_DSA_MICROCHIP_KSZ_SPI.
- Link to v4: https://patch.msgid.link/20260603-ks8995-to-ksz8-v4-0-e15149ef21e7@kernel.org

Changes in v4:
- Create a stub symbol for NET_DSA_KS8995 to phase over users to
  the new driver.
- Link to v3: https://patch.msgid.link/20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org

Changes in v3:
- Rebase on net-next again, moving target!
- Fix a netdev_info() print in the tagger to be netdev_debug()
- Add net/dsa/tag_ks8995.c to MAINTAINERS
- Link to v2: https://patch.msgid.link/20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org

Changes in v2:
- Avoid trying to configure TOS priority settings (DCB) on the KSZ8995XA.
  It does have some support for this, but let's add that later.
- Pick up Krzysztof's ACK on the new DT bindings.
- Reset the KSZ8995XA by disabling and enabling the switch like the old
  driver does.
- Move mutually exclusive Kconfig over to the patch introducing the
  old Micrel compatibles to the Microchip ksz_spi driver.
  (this complaint from Sashiko.)
- Use __be16 instead of u16 when casting into the SKB in the tagger
  (this complaint from Sashiko.)
- Do not modify the hdr->h_vlan_TCI if no hardware accelerated tag
  is detected, it would get nullified. Use whatever the Linux network stack
  assigned to TCI there.
  (this complaint from Sashiko.)
- Avoid dereference of NULL in debug prints in the tagger.
  (this complaint from Sashiko.)
- Ignored comment: Sashiko complains about ilog2(0) being potentially
  undefined but that is clearly defined as 0 in the Linux kernel.
- Link to v1: https://patch.msgid.link/20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org

---
Linus Walleij (4):
      dt-bindings: net: dsa: microchip: Add KSZ8995XA
      net: dsa: tag_ks8995: Add the KS8995 tag handling
      net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA
      net: dsa: ks8995: Delete surplus driver

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   1 +
 MAINTAINERS                                        |   1 +
 drivers/net/dsa/Kconfig                            |   9 +-
 drivers/net/dsa/Makefile                           |   1 -
 drivers/net/dsa/ks8995.c                           | 857 ---------------------
 drivers/net/dsa/microchip/Kconfig                  |   1 +
 drivers/net/dsa/microchip/ksz8.c                   | 252 +++++-
 drivers/net/dsa/microchip/ksz8.h                   |   2 +
 drivers/net/dsa/microchip/ksz8_reg.h               |   2 +
 drivers/net/dsa/microchip/ksz_common.c             |  53 +-
 drivers/net/dsa/microchip/ksz_common.h             |  11 +-
 drivers/net/dsa/microchip/ksz_dcb.c                |  68 +-
 drivers/net/dsa/microchip/ksz_spi.c                |  33 +-
 include/linux/platform_data/microchip-ksz.h        |   1 +
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_ks8995.c                               | 180 +++++
 18 files changed, 549 insertions(+), 932 deletions(-)
---
base-commit: 17d3afadf539c93def8106bbb83c88274bdc7ab1
change-id: 20260509-ks8995-to-ksz8-15f3f9c8271f

Best regards,
--  
Linus Walleij <linusw@kernel.org>

