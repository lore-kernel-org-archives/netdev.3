Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D09369D45;
	Sat, 26 Sep 2026 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790463696; cv=none; b=VjKioX913jLouWiZHEom/jAluOCn4PTkWbyiGNnfMKG+OLvXAgmyGw8GQfERT+rqBxps7H1biZpa9tko4H5/TMpPhU6Zd+G2TEb5JmJD8fyZKKYpTF/z3GAukEyAObjgdNPM9JzcRC3kmtk7uQjnYRH1/gr3r2BlqSQAEh/6M6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790463696; c=relaxed/simple;
	bh=G3tlOPyS5ynDKJeJRN1gzV0pfwHKfooB8lUK0UETCEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxtP3fTgO2GZReY+l9niM5natkfqkAHQtN95pDBClgbxY4xSgN7d+YpxzL6m7sQxYZ81jGrZJut2Kib0bz9dpraBsV2wEKq6D1DvnMvE+TuOMA9X/Wt3ecKEZV04fR3IbTaNWKxBL1IXq5e7c/dF5fAAUDAlOwBpHGJPb3G0YoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XLTSwWiF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XLTSwWiF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E565175A;
	Sat, 26 Sep 2026 16:01:27 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BDD13F632;
	Sat, 26 Sep 2026 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790463691; bh=G3tlOPyS5ynDKJeJRN1gzV0pfwHKfooB8lUK0UETCEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLTSwWiFlKWL1T9YW9lqXWJy+f75s1bB4J1e27KWeBAc4ItnQGe4tDUQAVUxaJe4c
	 YLHwXTrly22I+JtyZsDSzasoqBF4kzQm0IKKLabgBxnUi6zUypsqOX+BOo6p3H+X6L
	 DzW9VrgAbDLE/pK3qy0PeSoYuBnWJmGIuwmSkqpo=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
	Liu Changjie <liucj1228@outlook.com>,
	Per Larsson <per@palvencia.se>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/5] net: phy: maxio: parse and enable PHY clock from generic DT binding
Date: Sun, 27 Sep 2026 00:56:24 +0200
Message-ID: <20260926225625.25969-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260926225625.25969-1-andre.przywara@arm.com>
References: <20260926225625.25969-1-andre.przywara@arm.com>
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
index 9ba82c1cd8b13..266be95b949a8 100644
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
 
@@ -57,6 +59,11 @@ static int maxio_mae0621a_probe(struct phy_device *phydev)
 		priv->clk_out_125m = true;
 	}
 
+	/* PHY clock from the generic PHY binding */
+	priv->clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
 	return 0;
 }
 
-- 
2.46.4

