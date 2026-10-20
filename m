Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496077;
	b=xpWUuNismoBSrf8m3e34DE0Hna4FsVhvNRin0yPe5K70GGBFMsI9quCAwhulEjnxP/j8
	 yI09TEBkvecdu2chojL/r8GKi0W2/rMJjzHo6q6TTVb7ulkQAVDJZbuGSaIfEkmuqBWbT
	 2cahF2jjfrjCxCZvktwkU9bakh9CSVEtycCuQ4tnTX6KRa53Y2jgtF/6t2yN6D/BgOcKl
	 0O0FCp0eO0+VhpW19latN3vEkTYHArXPdpSMXsIsZSenxcnvsOOErAkBh/m+zK2FSp0CH
	 VXa5ccibRJNFAG1m5mfqfEOkqdhaBfa4YoxN70fjV9RI9v8WTc+5Qrv+SoE+QNNeA+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496077;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YDPaXizwmC/JpiKEr55NlOYCnlfjA2XwAZhmjmD4s7A=;
	b=PyantAfbsgvEJ2tA065GXlSQDrJRUBdFPL51l/WPKWfoZKqIvZlZkub+apyHmDIf95U0
	 hJX0URqkjuaUx/HQ1Gh6XHQfwXFhz4jcBwcYRmUn7pMyi6uUDCf+lJPg61v+GSoUkv+jc
	 hNGRLFdrghJRBocucREhX/sJjOSs80bQ9xbR++LiBWtfYmVrVEWEszxxqnPewGXTsF4Ky
	 qZzp5Ryf+EtlvydiZfczKBz9Bs8VpuCQEj2MUJbG7HoxaIHff3FfaRT1FiEwUsxsEn37O
	 ZgXuB+F8LobqgQeFpaV7f2Wh5UzWKwaylanAt+JznazattN8YnUR9WVpeQ1LkHA/d4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7874460A2607;
	Tue, 20 Oct 2026 11:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7874460A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 Oct
 2026 19:34:14 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 Oct 2026 19:34:14 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 20 Oct 2026 19:34:18 +0800
Subject: [PATCH net-next v4 7/7] net: ftgmac100: Allow building on ARM64
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261020-support_ast2700-v4-7-4d36b40939b3@aspeedtech.com>
References: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
In-Reply-To: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Eric
 Dumazet" <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792496053; l=3621;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=b4nuOAGj7hDll45AfQpS7jJIfXwEMU2no6rHulerEMM=;
 b=qcUc5ezFsLrjUbs+X0UWu2VVELHgsSpbRLyyGCcSxz3XQpOXUvPaXYZr6rUH4JJFcaZQUjalY
 6YXMLqbZ2prB30S/Uw63Uik3Dfg0cGe+o8p+TjZkwSg8vla5sFWnLQY
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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

