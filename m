Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AC281503;
	Sun,  7 Jun 2026 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780872100; cv=none; b=Y9wewppvufMKkYeETAG8wXsuX8L3KrfMd2qn9RUpdEZ6W+4R6Oyj4lsfqdxcmQVzzEsUMN0bejHfRFXcL4tmhzTmL576RYOFfHkm5aXmc9DRfZHca+aN5vChHrp7jK0cA3HZyjgLn4nZ9fNQrLPC5DqwjP3P1AQaiv58q7WvooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780872100; c=relaxed/simple;
	bh=lmGFcrexkEvQEW+cMW4RWPUg0K5/Vkp28qLscUgMcOg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YLwYuTNfP9BoLq1ZGpHuCbUH6WPQ2EXCOdOj7vZvbtBw4V6LrVNN3xqcpjXbiHwII4A/fAdoISf5glQQceyLOdUJHpXOKF/dFRPnhB98Y88cVMtucagvZLCGLOCPBUgbElAGIfWCwyh/O0Jl8ycbJvZM2LGTz9w87LrlaFugZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjemT3CV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjemT3CV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B161F00893;
	Sun,  7 Jun 2026 22:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780872099;
	bh=S0SFdJIbFGxEfERXn/7dSvNyCSRCV2YmfDFR7pNS5cU=;
	h=From:Subject:Date:To:Cc;
	b=UjemT3CVdrce/BNF24oLixBrIPGs8E3s+rCeFMMJ/XAiGbgo5z8AXdjMphRvapUAm
	 PZ1y0eRnZqz/l5waIkyDv5zE/VV5M4N7tNAtJgvPe1fsbcZW3gN1wkCKRyjjpKvfyh
	 H6uPDW++dU0N5J8Bd7DMTXv1+Akshj2630h617QbAY10SwLe+aCsKa/umUeNWY/EMT
	 yIxneWQQFabkrYEDJUbsc059mdPvr+w1zhpjPtrsPXkLZ0XIXk7wsN3H8f4nNwjqdL
	 fw5gIdUtSYqYV5g6A53y62GTO6GgPCLupi9B8KEIC/4Rc1lEaGAJy2wfi4J2RRWW+N
	 Sj783CV9XriWg==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v6 0/5] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Date: Mon, 08 Jun 2026 00:41:28 +0200
Message-Id: <20260608-ks8995-to-ksz8-v6-0-d91eb43edcc5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XOy07DMBAF0F+pvMbIr/GDFf+BWCTOuDVFDrJNV
 Kjy77jpgoB3Mxqfe30lBXPEQp4OV5JxiSXOqS364UD8aUhHpHFqOxFMaAbM0XOxzgGtc5u+LeU
 QZHDeCsMDaegjY4iXLfCFJKw04aWS1/ulfI5v6Ost7/b2FEud89fWvfBN3Gu4/l+zcMqoYRPDo
 IYBgno+Y074/jjn45a+iJ0XovOieTBceDZ5hwY6L/e+75fNe5AsaODOutB59es1k51XzSMHrhw
 GwdF0HvZedR6ad3YccFSAWv/9/7quP7HD+g7JAQAA
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
 drivers/net/dsa/microchip/ksz8.c                   | 177 ++++-
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
 17 files changed, 400 insertions(+), 900 deletions(-)
---
base-commit: c1c3d01e3a9038d3e8f497e773e1f7b5d6b8212a
change-id: 20260509-ks8995-to-ksz8-15f3f9c8271f

Best regards,
--  
Linus Walleij <linusw@kernel.org>

