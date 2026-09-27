Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED233BADAA;
	Sun, 27 Sep 2026 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790493458; cv=none; b=ixgmGcXLD+dZPmlqqhX/UuIpkB4YvVQR0VjvB6kpUEmdKKWaGHBLWQAZVB8xdULUJ9kRKZFj4JX9pN51U4GiVqsYDTMAxZs6s+jM32WBX2byd40o+8TDuNamPzq4pA3kGj1gJCVpUmrNKjs03ZCiNCGnkINnIpDroGCvxxTCYwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790493458; c=relaxed/simple;
	bh=Z4FCpnXXY91618+XsBXY31i8s5uXcA1p0nOQ4b3OZXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=u2gi9okwqm0Jz6rZzdZUTj2aZfaabFrIsKSIEdloqs9cw2zxFbqlt6/B2c4iHBFbh4SXE6rcM2u7e9mixWvZLQVFBQvWdSXeRR7HzyxBkB+ElsDPMtr1jbA2P+TP3qN0Bx+nfPAEgfow1eRL63MqVzAXWrHMKAqtoZCzhj+ns08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 27 Sep
 2026 15:16:21 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 27 Sep 2026 15:16:21 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Sun, 27 Sep 2026 15:16:24 +0800
Subject: [PATCH 5/5] net: ftgmac100: Allow building on ARM64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260927-support_ast2700-v1-5-9f03f29d2c82@aspeedtech.com>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
In-Reply-To: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790493380; l=1545;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=Z4FCpnXXY91618+XsBXY31i8s5uXcA1p0nOQ4b3OZXk=;
 b=U5C3DQbNrbxfYrMnpn/p13qd7sEiecuyuq0E3YQW5V4l/khKojZ44Mnio8ZQ+JvDCoYyJ2UvB
 0teT1XTb0QuBNIqPOBpOr8E7WlNeMCIosIwGNgG3SqM+GgZt2RZlRkU
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Allow the Faraday vendor menu and FTGMAC100 driver to be selected on
ARM64 so AST2700 platforms can enable the MAC. The driver now programs
the upper DMA address fields, so it no longer needs to be marked BROKEN
for 64-bit builds.

Keep selecting the Aspeed MDIO controller for MACH_ASPEED_G6 and also
select it for ARCH_ASPEED. This preserves the existing AST2600
dependency while covering newer Aspeed SoCs that use the common ARCH
symbol.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/Kconfig b/drivers/net/ethernet/faraday/Kconfig
index 474073c7f94d..dea6dcfc9ab5 100644
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
+	select MDIO_ASPEED if MACH_ASPEED_G6 || ARCH_ASPEED
 	select CRC32
 	help
 	  This driver supports the FTGMAC100 Gigabit Ethernet controller

-- 
2.34.1

