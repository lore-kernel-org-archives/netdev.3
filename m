Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526C4A013F;
	Thu, 15 Oct 2026 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046841; cv=none; b=beSjJpNML0aQQHH2fn8r8TVqxa5nW7lln2Gs6RqvscNZxIshW41xoHP7Z8Kgom44vWckrPGndxc2OFCIuwm9PWbh0Kkdhzch0cuU65IKqvU9VAp8DB7Lijd1Yp2OulrVFkaCA2D7tFnkjgso9SR9Rv+Y1jbJm6rnl6o3zFZwMC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046841; c=relaxed/simple;
	bh=SgYkW/BdBSqtNZ8s+/OpHERQbXZNXhDxkkwWVN95X2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R6q6cpY2OG2b9yXD7s3VNaHAETPs0/2dJScgUdCWeOGGNJ+iIgthQooC9YABpY8BuIA8B19epkDkbm/YQ7EJ+dv58VZ2pzm5zmPIFRVxvC4dZIUie+JgTDEZdWcJXjQZhP10b1+DUBaPwitaByhnAW1klnFG8n15rbn0Hfy0z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 15 Oct
 2026 14:46:59 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 15 Oct 2026 14:46:59 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Thu, 15 Oct 2026 14:46:58 +0800
Subject: [PATCH net-next v3 6/6] net: ftgmac100: Allow building on ARM64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261015-support_ast2700-v3-6-8d7999171ac4@aspeedtech.com>
References: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
In-Reply-To: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Eric
 Dumazet" <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792046819; l=3578;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=SgYkW/BdBSqtNZ8s+/OpHERQbXZNXhDxkkwWVN95X2s=;
 b=j+oK4teDSO+zsMJ/gdSn/k+sRguhq+7KR+qqNgWj/p4vGF+BCugSfuY+iChHVuuAM+tR00G2m
 gaH6g/QkEF4CKexufe7tDDuTLljnnHGfw13GwifxOXvZVQIsjUHfr4A
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Allow the Faraday vendor menu and FTGMAC100 driver to be selected on
ARM64 so AST2700 platforms can enable the MAC. The driver now programs
the upper DMA address fields, so it no longer needs to be marked BROKEN
for 64-bit builds.

AST2700 has no dedicated MACH_ASPEED_G7 symbol; unlike the 32-bit
generations it is only gated by the common ARCH_ASPEED symbol. On
32-bit Aspeed platforms, arch/arm/mach-aspeed/Kconfig nests
MACH_ASPEED_G4/G5/G6 under "if ARCH_ASPEED", so MACH_ASPEED_G6 already
implies ARCH_ASPEED and is redundant once ARCH_ASPEED is part of the
condition. Drop it and select MDIO_ASPEED directly on ARCH_ASPEED.

This does widen the MDIO_ASPEED select beyond AST2600: it is now also
selected for AST2400/AST2500, which keep driving their embedded MDIO
controller from FTGMAC100 itself and have no MDIO node for this driver
to bind to, so it is built but stays unused there. Update the
MDIO_ASPEED help text to describe this.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/Kconfig |  7 +++----
 drivers/net/mdio/Kconfig             | 16 ++++++++++------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index 474073c7f94d..9acc2d260c1f 100644
--- a/drivers/net/ethernet/faraday/Kconfig
+++ b/drivers/net/ethernet/faraday/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_FARADAY
 	bool "Faraday devices"
 	default y
-	depends on ARM || COMPILE_TEST
+	depends on ARM || ARM64 || COMPILE_TEST
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -28,11 +28,10 @@ config FTMAC100
 
 config FTGMAC100
 	tristate "Faraday FTGMAC100 Gigabit Ethernet support"
-	depends on ARM || COMPILE_TEST
-	depends on !64BIT || BROKEN
+	depends on ARM || ARM64 || COMPILE_TEST
 	select PHYLIB
 	select FIXED_PHY
-	select MDIO_ASPEED if MACH_ASPEED_G6
+	select MDIO_ASPEED if ARCH_ASPEED
 	select CRC32
 	help
 	  This driver supports the FTGMAC100 Gigabit Ethernet controller
diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index d44278f26fab..d784782c230f 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -50,12 +50,16 @@ config MDIO_ASPEED
 	depends on OF_MDIO && HAS_IOMEM
 	help
 	  This module provides a driver for the independent MDIO bus
-	  controllers found in the ASPEED AST2600 SoC. This is a driver for the
-	  third revision of the ASPEED MDIO register interface - the first two
-	  revisions are the "old" and "new" interfaces found in the AST2400 and
-	  AST2500, embedded in the MAC. For legacy reasons, FTGMAC100 driver
-	  continues to drive the embedded MDIO controller for the AST2400 and
-	  AST2500 SoCs, so say N if AST2600 support is not required.
+	  controllers found in the ASPEED AST2600 and AST2700 SoCs. This is a
+	  driver for the third revision of the ASPEED MDIO register interface -
+	  the first two revisions are the "old" and "new" interfaces found in
+	  the AST2400 and AST2500, embedded in the MAC. For legacy reasons,
+	  FTGMAC100 driver continues to drive the embedded MDIO controller for
+	  the AST2400 and AST2500 SoCs. AST2700 has no dedicated MACH_ASPEED_G7
+	  symbol and is only gated by ARCH_ASPEED, so FTGMAC100 now
+	  unconditionally selects this driver on every ARCH_ASPEED platform,
+	  including the older AST2400/AST2500 SoCs where it has no MDIO node to
+	  bind to.
 
 config MDIO_BITBANG
 	tristate "Bitbanged MDIO buses"

-- 
2.34.1

