Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FFA35E1A2;
	Fri, 15 May 2026 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886997; cv=none; b=fr/WnCw1PaFMU4QqOiSPkHyBSzGcFaoKGY6wGobOhonAq05jIok2pZW2csO5NNJSXotDGXJEK8S5xbruEu1SM75N8Qc0grwnw3k7dS2vW4cd+0LdeixfJkuHaSjev0UCYckYzgF8+I5Kc8TM/2GBLn0/EKRIcE10RHbuxrMZ7gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886997; c=relaxed/simple;
	bh=ZMsRxrh8IFDEBxFzQ/V211V80nqkkiWsjoCKrZR1w5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=vD+InHRToHdu9Kr48CJuW5mfepkOq2gNy7xQkgTZ7fGv2M92bpwK5QlKT12YBS9/D8qGIBaTLFb780grpJFoqczhgxuDLd90PBYxoRapAV+zyB5GHbjMhZUwxqVGMlUVA+/Yjj5A8k4pO2SM64MaKjNOIByRYHgyKSCsVZ4V/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb4P3A9o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb4P3A9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE22FC2BCB0;
	Fri, 15 May 2026 23:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778886996;
	bh=ZMsRxrh8IFDEBxFzQ/V211V80nqkkiWsjoCKrZR1w5g=;
	h=From:Subject:Date:To:Cc:From;
	b=Sb4P3A9ofeB4/IMZIUaGSGePnhU57lTe3uh736tE1qTfVM8eozWGJs2OtUeMwOE36
	 /5ilJZDZCStE3xpTQTVxM01wRZSP9y7EuHLDAegfxzgke5Zcttt0xJYBriwN1sXwdS
	 Jy1/UMrTdHwKqWDFEWa0OVFKWZJ6Md62P/vQVDuY+3IPqluBwI4GvagAOmKbLGpPTf
	 LI6Daih7v3y0Taf6LIVvzA/xwfYYhlk2c0Q2dD9VTD8aJsbvkCyX2Rotg7rmhVlRV0
	 Xqg13TfDeTG+6bLvlUHh1SsisRQ3DXqclgcguqEhh4V/8prTLHuz4cazkJ5aV8PUHV
	 t5nvfpLe9urig==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/5] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Date: Sat, 16 May 2026 01:16:12 +0200
Message-Id: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUwNL3exiC0tLU92SfCCrykLX0DTNOM0y2cLI3DBNCaipoCg1LbMCbGB
 0LIRfXJqUlZpcAjJFqbYWAHEG089yAAAA
X-Change-ID: 20260509-ks8995-to-ksz8-15f3f9c8271f
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
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
Linus Walleij (5):
      net: dsa: microchip: Add fallback Micrel compatibles
      dt-bindings: net: dsa: microchip: Add KSZ8995XA
      net: dsa: tag_ks8995: Add the KS8995 tag handling
      net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA
      net: dsa: ks8995: Delete surplus driver

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   1 +
 drivers/net/dsa/Kconfig                            |   8 -
 drivers/net/dsa/Makefile                           |   1 -
 drivers/net/dsa/ks8995.c                           | 857 ---------------------
 drivers/net/dsa/microchip/Kconfig                  |   1 +
 drivers/net/dsa/microchip/ksz8.c                   | 105 ++-
 drivers/net/dsa/microchip/ksz8_reg.h               |   2 +
 drivers/net/dsa/microchip/ksz_common.c             | 115 ++-
 drivers/net/dsa/microchip/ksz_common.h             |  11 +-
 drivers/net/dsa/microchip/ksz_spi.c                |  33 +-
 include/linux/platform_data/microchip-ksz.h        |   1 +
 include/net/dsa.h                                  |   2 +
 net/dsa/Kconfig                                    |   6 +
 net/dsa/Makefile                                   |   1 +
 net/dsa/tag_ks8995.c                               | 134 ++++
 15 files changed, 376 insertions(+), 902 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260509-ks8995-to-ksz8-15f3f9c8271f

Best regards,
--  
Linus Walleij <linusw@kernel.org>

