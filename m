Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCE13932EE;
	Tue, 26 May 2026 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811184; cv=none; b=oA7YLg2xL3XCieQhY8OLdkBfe0YmH0GnMbUyODEMIRj7nmEL4ungzjG2eEId7sYC1rcUwUcwe/qew04hcovUY6cyAaGtEhmch7UblUFdoplM7UUzqBhIIMpxs8y/ctaiMzvH3+0F7sW0L4p1OhiTZDwX6+1gfX3EoMmqRloUAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811184; c=relaxed/simple;
	bh=Fbj+HA7Y4zZAajJ06B7a8ywqKiZGgShMGA/BuE8VdkU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EGydXlAWBQzFJOcIBxEL3I0bNnjVYARwq5uUij5Q0p2rbCOD7WnD3Z5pUMlbH8dYZ4vXyOtJ26UEvi6ryFnDxj+DgHAEmrU0UHPTCl7BJZXqM0u71cFjfnhR/7e/sfyNxb5N2e0skEiKChr6SrFoeTIGSnoIcnBgZrFPKxR58g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8sUKeTp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8sUKeTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894B21F000E9;
	Tue, 26 May 2026 15:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811182;
	bh=JSHZa+SCpPqY8KZl7vp369SU7CDYzcdSW/h3q9lPPos=;
	h=From:Subject:Date:To:Cc;
	b=M8sUKeTpe/rbzRfVOwd5VQx2nXZe1zc6oICttP0ZzoBwFP1X42xDPw5Yh4cg7ITiX
	 2uGhlePJ+JZP4UVOOaFUMDM1Cmfpkb/d/1f6TD5h577uL/TThZg4bApFGPdqgvNehS
	 PD3thrS1ijM5ERm6l/yHCZe93mWqmbSyiHMUqv36vhmLUKte+5xClR62b7yw6j5dX7
	 Zw1LiVdUya+nQKmuTDyOy/6JIiYhNN2Nd7vLAPZwJ9RHEwoil2EVb1EiLZgH9cMHrb
	 JnG3T27pt3bZtiLcv/m4xuOcxBDvLg6iMbzWSetgrIurV16Yy6FmmzKZcmrPAA5JJ1
	 J5/AmdItDso+g==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH net-next v3 0/5] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Date: Tue, 26 May 2026 17:59:30 +0200
Message-Id: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNzRKCIBSFX8VhHQ2gqLTqPZoWhhclG2iAHMvx3
 UPc9LO7Z+75vjMjD06DR4dsRg5G7bU1MeS7DMm+MR1g3caMGGEl4UTgwddCcBxsvF41plzlSsi
 aVVShCN0dKD0l4QkZCNjAFNB5+/jH5QoyrL6122sfrHum7ZEmYpuh5e/MSDHBFWkJqKJpuCqOA
 zgDt711XbKP7INn7I9nkecVZZK0UkDFv/hlWd7aooIFCQEAAA==
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
 drivers/net/dsa/Kconfig                            |   8 -
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
 17 files changed, 388 insertions(+), 904 deletions(-)
---
base-commit: 18b9f739d3f292925ca7f67ad63f3a4c0bbfad3d
change-id: 20260509-ks8995-to-ksz8-15f3f9c8271f

Best regards,
--  
Linus Walleij <linusw@kernel.org>

