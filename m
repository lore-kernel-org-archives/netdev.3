Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F73F8220;
	Wed, 26 Aug 2026 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748544; cv=none; b=KH51ssqMLjgukooOwhjDwjC7PJ7KS5Vnlt+xICOw37EP7oTkkZ8FbZ4FI9jZDtl5utV3fpXwyedk785qwIjzeiI7i4hn0xhSPtXrbB1lai8//EBQ5s/fK/VsrtqB1yP3FohDgFhDJKOumQ7ohZ0Kimpo4N1LkrxcRyNjHXfD4CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748544; c=relaxed/simple;
	bh=4cluWBe9p81nkFKag7OIs81PFmBPD135mnSU3QQzEYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKOGv3jNXm0j0EMoXjCrg/9Mys/5H4wBNp4LHGA9l/jVW0uIy/ZpQvjmT6JCuF5qYhg4p34E/D1soo/eidQmo0R8n/wkZGMv+0FepuwfVFpxrstTJNlDsnQm8E+swfSHRbkJ/5Oupw7rXYI8kYmtseAnRHshzoHI6cpt1GHlR2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9B7522021C9;
	Wed, 26 Aug 2026 14:48:56 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1wzD3o-003RRH-1e;
	Wed, 26 Aug 2026 14:48:56 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 26 Aug 2026 14:48:41 +0200
Subject: [PATCH v2 3/3] net: phy: dp83867: support setting output-impedance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-v7-2-topic-dp83867-v2-3-a97b4cec6e93@pengutronix.de>
References: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
In-Reply-To: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2317;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=4cluWBe9p81nkFKag7OIs81PFmBPD135mnSU3QQzEYc=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ1bfg23FrIuCNYQPOf+0O92wobXQ7aiVSmTnLdUZIlZ1p
 eacxu4dpSwMYlwMsmKKLCoLK/hEPT54Rk4T4YKZw8oEMoSBi1MAJnLrLSPDnu5t7PNuKH2VOi29
 bInZx2WLgr6uiEh9HcV2TGjy1s1+bQz/1KsqAjp797/j7jde7q+30Lcg8tpux/TLh6ccerbF86o
 YKwA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Currently the dp83867 supports setting the io impedance to minimum,
maximum, default or a value from a nvmem cell. In situations where there
is no backend for a nvmem cell, the value can not be set to anything but
minimum, maximum or default.

Add support for the ti,output-impedance-ohms binding, allowing to
specify the impedance via the devicetree. The existing boolean bindings
for minimum and maximum take precedence over this new binding. The nvmem
consumer still takes lowest precedence.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/net/phy/dp83867.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 88255e92b4cdb..973b70f11c45a 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -531,7 +531,8 @@ static int dp83867_of_init_io_impedance(struct phy_device *phydev)
 	struct device *dev = &phydev->mdio.dev;
 	struct device_node *of_node = dev->of_node;
 	struct nvmem_cell *cell;
-	u8 *buf, val;
+	u8 *buf;
+	u32 val;
 	int ret;
 
 	cell = of_nvmem_cell_get(of_node, "io_impedance_ctrl");
@@ -542,12 +543,21 @@ static int dp83867_of_init_io_impedance(struct phy_device *phydev)
 						"failed to get nvmem cell io_impedance_ctrl\n");
 
 		/* If no nvmem cell, check for the boolean properties. */
-		if (of_property_read_bool(of_node, "ti,max-output-impedance"))
+		if (of_property_read_bool(of_node, "ti,max-output-impedance")) {
 			dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX;
-		else if (of_property_read_bool(of_node, "ti,min-output-impedance"))
+		} else if (of_property_read_bool(of_node, "ti,min-output-impedance")) {
 			dp83867->io_impedance = DP83867_IO_MUX_CFG_IO_IMPEDANCE_MIN;
-		else
+		} else if (of_property_read_u32(of_node, "ti,output-impedance-ohms", &val) == 0) {
+			val = val & DP83867_IO_MUX_CFG_IO_IMPEDANCE_MASK;
+			if (val > DP83867_IO_MUX_CFG_IO_IMPEDANCE_MIN ||
+			    val < DP83867_IO_MUX_CFG_IO_IMPEDANCE_MAX) {
+				phydev_err(phydev, "'ti,output-impedance-ohms' contents out of range\n");
+				return -ERANGE;
+			}
+			dp83867->io_impedance = val;
+		} else {
 			dp83867->io_impedance = -1; /* leave at default */
+		}
 
 		return 0;
 	}

-- 
2.54.0

