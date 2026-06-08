Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3E3546CC;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895366; cv=none; b=AvWxJfbOndxmubkk1TUxSs55JSVQsQiGjRNpBHP3zhONrR6db0+HX8rRDzPHEAvpVTygOa+6toSb11p7S5yr6W1pzb56G5rVRrjl3qW+ZPg/zZAbqww4Y8UIJ096txAA1PP9asbjfS699PesZUEYAHtG+1VeG3sz6CHtyI4Kt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895366; c=relaxed/simple;
	bh=MFdsgV4tCJIb+7JpW4eY9w89wJ4+M0zHKskp8FOGHr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a3WpkOcmdbCxFpxdEzIpv2YXRRKvOeRM6XbOQpxHQ0xEoNJQs+13Zj/wjJDD+lNBP++1HVEmP2inspROiEDxvCGcyY0/HY/4Swk81MCMI3B+DfMR2ni+O43ih55C31zjMAsx1cYBp9S7xvX418kPXTopC+UUyTOUISVqnq0A31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReZLZOo6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReZLZOo6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67182C4AF48;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780895366;
	bh=MFdsgV4tCJIb+7JpW4eY9w89wJ4+M0zHKskp8FOGHr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ReZLZOo6htbNM9XihQOc8QrOHyZmfrqJ+9qiglEGSpWQsbgpM4breRJ6XZCRNIy/8
	 IE+6oSi0+zJH1GAmMY4ZoMIOrohIjx/cfFPWEo5R4S52ovL36Xbw+BApicaWzAPF9Z
	 FoYFQbocEfqrZRkt7mz57UaOo4OV0Y5bO3+QbXnkogoSlQ9TsgWS/j57G/wqS3hnmT
	 abP3C+7LhOYQfUjZfr+KtC2v+ShpbQZJGf/BtmA+yUQ4WS0MryXaaGPKoknqT+eHPv
	 HY4meGT80TkAyHbszhhmFNf4qFN30LF2qEk3Wnb9rXduzJdxgktm31nZl1NTyxelvD
	 k/uCX+3BIr1ow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA01CD8CA7;
	Mon,  8 Jun 2026 05:09:26 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Mon, 08 Jun 2026 09:09:19 +0400
Subject: [PATCH v4 4/4] net: phy: at803x: add RX and TX clock management
 for IPQ5018 PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ipq5018-gephy-clocks-v4-4-fb2ccd56894b@outlook.com>
References: <20260608-ipq5018-gephy-clocks-v4-0-fb2ccd56894b@outlook.com>
In-Reply-To: <20260608-ipq5018-gephy-clocks-v4-0-fb2ccd56894b@outlook.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780895363; l=1756;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=m5xYoQj/G89J7xqhL2YgJahZAGwlkkCV+b0laCqNRBU=;
 b=a9b6VnFuOhU7qXWN2B1DLPAgtbLDyESVPuHBhkQs6Jd27gKLy1uQ+QhPfQyBQnepDm8c+rNSi
 MHqnN6UFaKXAJ/BZidcIBUyQvDrs7SPjT5eUAJRnjP9UwNlGnji3gVd
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Acquire and enable the RX and TX clocks for the IPQ5018 PHY.
These clocks are required for the PHY's datapath to function correctly.

Fixes: d46502279a11 ("net: phy: qcom: at803x: Add Qualcomm IPQ5018 Internal PHY support")
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/net/phy/qcom/at803x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 63726cf98cd4..ba4dc07752b6 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -19,6 +19,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
 #include <linux/phylink.h>
+#include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/phy_port.h>
 #include <dt-bindings/net/qca-ar803x.h>
@@ -1074,6 +1075,7 @@ static void ipq5018_link_change_notify(struct phy_device *phydev)
 static int ipq5018_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
+	struct clk *rx_clk, *tx_clk;
 	struct ipq5018_priv *priv;
 	int ret;
 
@@ -1084,6 +1086,16 @@ static int ipq5018_probe(struct phy_device *phydev)
 	priv->set_short_cable_dac = of_property_read_bool(dev->of_node,
 							  "qcom,dac-preset-short-cable");
 
+	rx_clk = devm_clk_get_enabled(dev, "rx");
+	if (IS_ERR(rx_clk))
+		return dev_err_probe(dev, PTR_ERR(rx_clk),
+				     "failed to get and enable RX clock\n");
+
+	tx_clk = devm_clk_get_enabled(dev, "tx");
+	if (IS_ERR(tx_clk))
+		return dev_err_probe(dev, PTR_ERR(tx_clk),
+				     "failed to get and enable TX clock\n");
+
 	priv->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(priv->rst))
 		return dev_err_probe(dev, PTR_ERR(priv->rst),

-- 
2.53.0


