Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56437B41B;
	Mon, 31 Aug 2026 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209667; cv=none; b=B7DpIfZulklMOdUYAiOhcDyWwuMyqVevqDgtKVX453HREoxSR99kH6e9+yZgNsAXZPQ5ZZNZ/kF4h6IClAQ20t1gkzh71cPYObjzx3MjtI0hy1uZ/Jz7JdeXav72cOhYmVZScq9+EZ9YalJcz834iAgZ8/wW60Kq4CY8KD0MPKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209667; c=relaxed/simple;
	bh=x/S0721k/SRubbMXvuNkhAnsCDZ7GC0uHnpMIjSF7sU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KLSQnTI3kPY9rhPOgxF05VBAvWVqmEkv5OGb0QFEbJGiLtGTqP5WABpmnmoLxzgFa6gOjqbeLP9AHOk9CfucFuwG5VLM/iutJhNzshe7vN/MykV3ha8h0YL7kppnQ9tdtzn5+/Jm4tzNRMIY1qnKwtX2+PCDBb2oQPPR1zxbqAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keBVVHaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keBVVHaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065BD1F000E9;
	Mon, 31 Aug 2026 20:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788209665;
	bh=NqWOXNguhGEoHxDcYjgEeGnC3OHQ6+lO76rcsC/BXC0=;
	h=From:Subject:Date:To:Cc;
	b=keBVVHaKHaLVU3rLIF7yctzZRXXzmRz6q4vagXzlWfp+PUK7jNBUrIjveGX6Mr5eW
	 JN1jwA8bx0uLau1C6bb4N8AvRgJG0oR60XuwbISp2fJe3Hssc1ku0luszdMcPzzstJ
	 jZ2kWFzXTdles1nCQtTHOnjo34ymWDUPlOpKXnKY4q99IclTzgrxx8IvscxGtQ6B15
	 rS72goRRDN1bA/MD/6Y871qGNpEMwT9L3LBFO7pEpcGcQL+nH97zSB4t7NX6Yik/0A
	 JmK52zkafjOK/Oy+9l8krClGAnRyYgBQsRX4RJJ9nIffqhd/dPtVuXehFtmmWD9S+o
	 qFjzO4jDiCYtw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v8 0/5] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Date: Mon, 31 Aug 2026 22:54:16 +0200
Message-Id: <20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Qy07DMBAF0F+pvMbIr/GDFf+BWDjOuA1FCbJDV
 Kj670zTRQNm55F97h35zCqWASt72p1ZwWWowzTS4B92LB3iuEc+9DQzJZQVIAI/Vh8C8Hmi07f
 nErLOIXnlZGaEPgrm4bQGvrARZz7iaWavt5v62b1hmq9517eHoc5T+Vq7F7mKW420f2sWyQV3o
 heYTYyQzfMRy4jvj1PZr+mL2nilGq/Ig5MqiT4FdNB4vfVtvyafQItsQQYfcuPN3VuhG2/IowR
 pAmYl0TUett40HsgH30XsDKC17f52633jLfk+SOIa+5Ra7+7e/dPvyKuYBdLvG4j+l79cLj/Ba
 OPvSQIAAA==
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

The old drivers referce to "KS8995" was actually KS8995XA only,
it never supported the sibling devices KS8995E or KS8995MA.
This is reflected in this patch set.

Add new compatibles, add special code paths for the KSZ8995XA,
including support for its two-level DCB priority model, and add a
new tagger for the special front tag found in the KSZ8995XA.

The patches were tested with the Actiontec MI424WR rev D (which
has the KS8995XA) and OpenWrt as userspace.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
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
Linus Walleij (5):
      net: dsa: microchip: Add fallback Micrel compatibles
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
 drivers/net/dsa/microchip/ksz8.c                   | 205 ++++-
 drivers/net/dsa/microchip/ksz8.h                   |   2 +
 drivers/net/dsa/microchip/ksz8_reg.h               |   7 +
 drivers/net/dsa/microchip/ksz_common.c             |  53 +-
 drivers/net/dsa/microchip/ksz_common.h             |  11 +-
 drivers/net/dsa/microchip/ksz_dcb.c                |  55 +-
 drivers/net/dsa/microchip/ksz_spi.c                |  33 +-
 include/linux/platform_data/microchip-ksz.h        |   1 +
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_ks8995.c                               | 141 ++++
 18 files changed, 463 insertions(+), 924 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260509-ks8995-to-ksz8-15f3f9c8271f

Best regards,
--  
Linus Walleij <linusw@kernel.org>

