Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF83C873B;
	Tue,  2 Jun 2026 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441850; cv=none; b=KmfB+sib6eIXURHvMVSvkssPpM1qPt29fLGDVOzwvIQjScVZhy4U5aij+zsm/+tEd+LLz/FFXSIjsTi5o/qS+rBlEYB9XKltoWC8oHC09UDJ4dHjbSKxADimCUzUIWVq/5FPFPwLpfYKJVu6yxLGOyYyk+2+lSiBCNnUjUiWJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441850; c=relaxed/simple;
	bh=3pzpK0BhcukEjX5uUD46kCcyRMN0l4LQ8gzMxHRxFZA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EHIj3xtTkLIu4Kiy04my4lnwn1Cb+XTPQK+Cr5oSn1HoNVoFGcsFLZe19NbOjbxEIJavA95tor/rsHdSjHGP8NMaH0TiNI6znOhV24WUJxepR/PRdiW5vv/B7J5Z8ipIEmBdO07ASNLwII6vq1X0DNsajACeSbZQCYhxAqXPzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcmk8jDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcmk8jDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970DD1F00893;
	Tue,  2 Jun 2026 23:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780441848;
	bh=eZla307qi7URVgkXjVPBSU2R4a5offjxZ+vdElW9STI=;
	h=From:Subject:Date:To:Cc;
	b=jcmk8jDpAAj7xhKa7MENAp7nul88qPILP22AXaPPLiCereqfD1pcaSrBcL5wkd9MI
	 +OPsBcb0/tG3Yd3222Nyyljgwh5cnbKXmlqqWLiFtWo7674q+c+9HmiJ0WZde0DlXB
	 S37mPUtUudjr1NDdGDADcOhneZRRQqaS3t3dEDhuQ7y3IEl9It3mqpPgB7+F7RGS1o
	 HDNSVULR5OFfUemr9qh0OAaVEkLq1rsPhU7AQLutzhpIerDr80MK/9r7PNFSTJOz84
	 iW13Vr05JSBCIQfusScQCzgZPhYXaJG7kNcQWbuAB3E0tgHP7edAVDo9MdTCLiNP/x
	 kTXi+ZxGalPTw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v4 0/5] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Date: Wed, 03 Jun 2026 01:10:39 +0200
Message-Id: <20260603-ks8995-to-ksz8-v4-0-e15149ef21e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XNwRKCIBAG4FdxOEcDKCqdeo+mg+GiZAMNkGM5v
 nuoF8vb7ux+/z8iD06DR6dkRA567bU1cckOCZJtZRrAuo47YoTlhBOBO18KwXGwcfqUmHKVKiF
 LVlCFIno6UHpYAi/IQMAGhoCu68W/bneQYc6bf1vtg3Xvpbuni1hraP5f01NMcEFqAiqrKq6yc
 wfOwONoXbOk92zjGdt5Fj0vKJOklgIKvvPp1u/70+glT4nKORWlUD9+mqYvSQrnp0kBAAA=
X-Change-ID: 20260509-ks8995-to-ksz8-15f3f9c8271f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

This series breaks with the dated attempt to polish the old
KS8995 driver, and instead implement support for the KS8995XA
in the KSZ driver, and after that delete the old KS8995 driver.

The hardware clearly has the same ancestry, the KSZ8995XA is
just a rebrand of the much older Micrel KX8995XA switch.

The old drivers referce to "KS8995" was actually KS8995XA only,
it never supported the sibling devices KS8995E or KS8995MA.
This is reflected in this patch set.

Add new compatibles, add special code paths for the KSZ8995XA
and add a new tagger for the special front tag found in the
KSZ8995XA.

The patches were tested with the Actiontec MI424WR rev D (which
has the KS8995XA) and OpenWrt as userspace.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
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
 drivers/net/dsa/Kconfig                            |  11 +-
 drivers/net/dsa/Makefile                           |   1 -
 drivers/net/dsa/ks8995.c                           | 857 ---------------------
 drivers/net/dsa/microchip/Kconfig                  |   1 +
 drivers/net/dsa/microchip/ksz8.c                   | 170 +++-
 drivers/net/dsa/microchip/ksz8.h                   |   2 +
 drivers/net/dsa/microchip/ksz8_reg.h               |   7 +
 drivers/net/dsa/microchip/ksz_common.c             |  58 +-
 drivers/net/dsa/microchip/ksz_common.h             |  11 +-
 drivers/net/dsa/microchip/ksz_spi.c                |  33 +-
 include/linux/platform_data/microchip-ksz.h        |   1 +
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_ks8995.c                               | 132 ++++
 17 files changed, 394 insertions(+), 901 deletions(-)
---
base-commit: 18b9f739d3f292925ca7f67ad63f3a4c0bbfad3d
change-id: 20260509-ks8995-to-ksz8-15f3f9c8271f

Best regards,
--  
Linus Walleij <linusw@kernel.org>

