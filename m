Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F174737C0FB;
	Mon,  3 Aug 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752112; cv=none; b=a4/E3SqoBXv9TWQNslg5vPN553F2j+fd4ah7AGMHaL2KzVaMrMv9y8iFa879sAxzP/kIBXF525g0GUbLAWxCzkM21fOxPywiqjWNeL82oaAniB8bEb2b106Hoo3CO3kh7pz1T0loS/5Qtwfr2qafqqdKePu9Ey+IlxYdUbYxELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752112; c=relaxed/simple;
	bh=JZrZ65rYM8tLXtMMEeRF1Po3l4gxMqcIvdVNOlz/RbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueV/FEZJo15+B952Jjy2oZgCt2BgtZYJS1gmyjohs0dxxgwxIJcinx+n2BLcyTRPCMw2P0CfFgd5Rg1ABAGU5qlCq2k1tJrdbwfKyq8flL8xmPQ+4SQbhoxJ8ZNsf7+tcG5JkHREvZo4QeYcaUgtWkwJK859TY7zhM6wMQ7ZXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=e5hk1uuD; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="e5hk1uuD"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 525631595;
	Mon,  3 Aug 2026 03:15:06 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA30F3F632;
	Mon,  3 Aug 2026 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785752110; bh=JZrZ65rYM8tLXtMMEeRF1Po3l4gxMqcIvdVNOlz/RbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5hk1uuD+1XmiLWjy/1AzfBHfSEAPlO/RIT6Hf5hLgWgIM9whs/nI81iOv07CTtRq
	 q1ERnp9EXCRobQaNNIzrEAnRMJ0tTHJ3uRh2WvStA9dcghYWTyDJ1Ex/XmVN9b4diA
	 YaxNYd9EzdNV7pA5M/GizmaRcHejHYH3EjwJmRNE=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Liu Changjie <liucj1228@outlook.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/6] net: phy: maxio: parse and enable PHY clock from generic DT binding
Date: Mon,  3 Aug 2026 12:14:48 +0200
Message-ID: <20260803101452.2993721-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803101452.2993721-1-andre.przywara@arm.com>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic PHY DT binding features a clocks property, which describes
the clock input to the PHY. Typically this is a crystal oscillator, so
it works without software interaction. But some boards want to save some
pennies on that part, and let a clock fanout pin from the SoC provide this
clock signal. In this case the PHY probe routine needs to enable this
clock explicitly.

Look for a "clocks" property inside the PHY node and enable that clock,
if one is provided.

This allows boards with a SoC-driven PHY clock to use the PHY. Please
note that without the clock enabled, the PHY will not be detected on the
MDIO bus, so the PHY-ID needs to be explicitly named in the PHY
compatible string:
	compatible = "ethernet-phy-id7b74.4411";

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/net/phy/maxio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/maxio.c b/drivers/net/phy/maxio.c
index 95a2169f25df..5fabf99fb90f 100644
--- a/drivers/net/phy/maxio.c
+++ b/drivers/net/phy/maxio.c
@@ -2,6 +2,7 @@
 /* Driver for Maxio Ethernet PHYs. */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/property.h>
@@ -15,6 +16,7 @@
 #define MAXIO_MAE0621A_CLKOUT_ENABLE	BIT(0)
 
 struct maxio_priv {
+	struct clk *clk;
 	bool clk_out_125m;
 };
 
@@ -55,6 +57,11 @@ static int maxio_mae0621a_probe(struct phy_device *phydev)
 		return ret;
 	}
 
+	/* PHY clock from the generic PHY binding */
+	priv->clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
 	return 0;
 }
 
-- 
2.43.0

