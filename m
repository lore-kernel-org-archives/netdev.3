Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80423395AE7;
	Fri,  5 Jun 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663299; cv=none; b=qiEhsVQHey8oeVLDTZVd14USKInDsZmTODWn0BQdgYjjxMBmoFFZwcy2CHNOhgJzpDIlqQdZteGPI9hu5tU+ueHOJSCikcjHLKA/wCdlRWvmtZ9Ly6oGXuJ3NjK8SMyEv7j+Qsd91ONITT/GOLS/7ZTdcJ8yPicY7CXs6tnvn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663299; c=relaxed/simple;
	bh=yBbQQOk+fUvfPZ5vfaumStuzxQ9XjoQe1h8vA618STU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnIoukxtXzROZtNinsYb1yJd4CmtMkgM+uYIP2v6txDZXi+70l9djFiIFtKjRYzdo/UmodDLA50kBJtoo8NmnDxh64sMU6QT1TGC5o76hmDiRvNhaiIr13VK4/rTMEkqpOtyk7uJKt5Zq8WDccSeGzojdzWngGaaU0y1sSQrcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax57QoW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax57QoW5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47F74C4AF0E;
	Fri,  5 Jun 2026 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780663299;
	bh=yBbQQOk+fUvfPZ5vfaumStuzxQ9XjoQe1h8vA618STU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ax57QoW5yFZHXNb/D24ylbzalRRJnCf8LYSjROpp7Sx690lb1i9wFYYNFeJxbM05B
	 VQgYA/MDaRFdE2SPt0aAnZR8Jj3D0O+8xLPztJFxrQYqqYeIsTuGBeG4U1TeXkXRp9
	 vWrUQZQn6DDpLbZq1JrqubkOmtNfEItgtJQd2JjB3P0lMb8+5uhybbb0XBoSWOoUIh
	 Qr3Dasp2ylqWlroFL1p8HlO6dPUV2Wddpn2woVnHGHQT9hUJNXmIy1uVNXK9q0UB22
	 et5qAmKZJyIbTydy/l7Prn8sP/9WSBAYGonSFYKY56pL5UDSnWp4nSePQQEpG1K1wL
	 3tTqmyeYhVnlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D299CD6E7C;
	Fri,  5 Jun 2026 12:41:39 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Fri, 05 Jun 2026 16:41:29 +0400
Subject: [PATCH v3 4/4] net: phy: at803x: add RX and TX clock management
 for IPQ5018 PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-ipq5018-gephy-clocks-v3-4-f232d9ca0966@outlook.com>
References: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
In-Reply-To: <20260605-ipq5018-gephy-clocks-v3-0-f232d9ca0966@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780663297; l=2852;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=MWXgHKXSj4vmywVK+GS467+qaJ57q5XVTsgCD/+MZ10=;
 b=ctVlAF8Yev5vmJGYXp0WvV7idienC027GOek/Zp0sqZdyVf5UNvVa1am8j+IdN8LDAuk7vaEq
 KH84wuc3oiyC8cGk3vNNgoAnVFdVUqu2aFNzMs/H9asSgLIOcCQ0uGK
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Acquire and manage the RX and TX clocks for the IPQ5018 PHY.
These clocks are required for the PHY's datapath to function correctly.
Gate the clocks upon link state changes for improved power management.

Fixes: d46502279a11 ("net: phy: qcom: at803x: Add Qualcomm IPQ5018 Internal PHY support")
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/net/phy/qcom/at803x.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
index 63726cf98cd4..99bc710531a4 100644
--- a/drivers/net/phy/qcom/at803x.c
+++ b/drivers/net/phy/qcom/at803x.c
@@ -19,6 +19,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/of.h>
 #include <linux/phylink.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/reset.h>
 #include <linux/phy_port.h>
 #include <dt-bindings/net/qca-ar803x.h>
@@ -176,6 +178,8 @@ struct at803x_context {
 };
 
 struct ipq5018_priv {
+	struct clk *rx_clk;
+	struct clk *tx_clk;
 	struct reset_control *rst;
 	bool set_short_cable_dac;
 };
@@ -1062,6 +1066,35 @@ static int ipq5018_config_init(struct phy_device *phydev)
 
 static void ipq5018_link_change_notify(struct phy_device *phydev)
 {
+	struct ipq5018_priv *priv = phydev->priv;
+	int ret;
+
+	if (phydev->link) {
+		if (!__clk_is_enabled(priv->rx_clk)) {
+			ret = clk_prepare_enable(priv->rx_clk);
+			if (ret) {
+				dev_err(&phydev->mdio.dev,
+					"failed to enable RX clock\n");
+				goto reset_fifo;
+			}
+		}
+
+		if (!__clk_is_enabled(priv->tx_clk)) {
+			ret = clk_prepare_enable(priv->tx_clk);
+			if (ret) {
+				dev_err(&phydev->mdio.dev,
+					"failed to enable TX clock\n");
+				clk_disable_unprepare(priv->rx_clk);
+			}
+		}
+	} else {
+		if (__clk_is_enabled(priv->rx_clk))
+			clk_disable_unprepare(priv->rx_clk);
+		if (__clk_is_enabled(priv->tx_clk))
+			clk_disable_unprepare(priv->tx_clk);
+	}
+
+reset_fifo:
 	/*
 	 * Reset the FIFO buffer upon link disconnects to clear any residual data
 	 * which may cause issues with the FIFO which it cannot recover from.
@@ -1084,6 +1117,16 @@ static int ipq5018_probe(struct phy_device *phydev)
 	priv->set_short_cable_dac = of_property_read_bool(dev->of_node,
 							  "qcom,dac-preset-short-cable");
 
+	priv->rx_clk = devm_clk_get(dev, "rx");
+	if (IS_ERR(priv->rx_clk))
+		return dev_err_probe(dev, PTR_ERR(priv->rx_clk),
+				     "failed to get RX clock\n");
+
+	priv->tx_clk = devm_clk_get(dev, "tx");
+	if (IS_ERR(priv->tx_clk))
+		return dev_err_probe(dev, PTR_ERR(priv->tx_clk),
+				     "failed to get TX clock\n");
+
 	priv->rst = devm_reset_control_array_get_exclusive(dev);
 	if (IS_ERR(priv->rst))
 		return dev_err_probe(dev, PTR_ERR(priv->rst),

-- 
2.53.0


