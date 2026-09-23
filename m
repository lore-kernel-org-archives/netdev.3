Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E70E483829;
	Wed, 23 Sep 2026 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160001; cv=none; b=LNNGS7trpkgxdZP1FiA4Z9o3+T1SWRzm1IctfTVJXeph6VSCI2VuwZOq7KU2lVpjT4MTtGIbG+OCS39k5txBhtTE5oexozmDlsFkmdma9ZFji35l1qQTxjZfE21J9Lq7393fhHMV9q5DeEuVUadNu+INKxliMwJqBMryn15mv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160001; c=relaxed/simple;
	bh=+Cu7ELct7CYfKS56sCulkTJS1lam6OhwEzqTSoJ8Zg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ewmAiLklVg4ujW1kEZnNys5dEq+C16D4PlT8utnq9q3zblmmzpTy9UlO3bmlb/FfsfC/eK5Y08Okvo6+4tLeuhwVaDVESWKTuiwmaOdP4SJh0d6bv3sCXSJrDM1+LpDVNXi5IObEX03YGNJUYWMnbF1LuRemJjf8uL4Av9R1i4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sgOVOKml; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kYutQOp7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sgOVOKml";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kYutQOp7"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIJqn7gYsblS+oZECmBr3OHJ+dooqIeQBXuGu2zSZ3k=;
	b=sgOVOKmlAvrnnPqH+QYn0uJZclTkHJeO2AfKNulUlBRhNH3sYI6qVc+FD25o0zsuPjuAT0
	hVVWgk8yxHaiIm7+vzH2rYkPlsHasUOL2qsmN9ARFjUgOcUyzV2RUMLFXA+0I15mGd1Fp4
	w1yR179/wQm2W3dnMBX/Ra0KaP2xHJPNfrTqYN9aZCN78ANx84igH1bkmLEQO055WDYFcd
	oKQF63oB45jPP8XXISC6gCuIqh1EXhjPqOo9Kz3dbB+D2f7QZBjdEGw84fSeu00XzfPPdu
	4EJfsW27WKPhz43seS5iT2h1nwKxcJOQZsiM3YQo4bGDO9iKJ3Zh9H50yNctcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIJqn7gYsblS+oZECmBr3OHJ+dooqIeQBXuGu2zSZ3k=;
	b=kYutQOp7o02Xk+OmrUMorfr18dtgpD4LAMHxVXfGxVlHEmoZqGGFvDiqYExKZ3To/t1y/E
	ewKBRf2XHEKqs3Cw==
Date: Wed, 23 Sep 2026 12:39:35 +0200
Subject: [PATCH net-next v3 8/8] net: dsa: soce: Disable unsupported
 hardware STP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-devel-vstrassheim-soce-dsa-ml-v3-8-ddebafcb9ba7@linutronix.de>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

The driver does not implement hardware STP offloading yet. Switch cores
synthesized with the STP feature enabled may therefore retain their
reset configuration and block frame forwarding.

Detect the synthesized STP feature and disable it during switch setup,
leaving STP state handling to the Linux bridge.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 drivers/net/dsa/soce/soce_dsa.h      |  1 +
 drivers/net/dsa/soce/soce_dsa_core.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/dsa/soce/soce_dsa.h b/drivers/net/dsa/soce/soce_dsa.h
index 41533a89d680..bb9e65567ec6 100644
--- a/drivers/net/dsa/soce/soce_dsa.h
+++ b/drivers/net/dsa/soce/soce_dsa.h
@@ -22,6 +22,7 @@ struct soce_dsa_local {
 struct soce_features {
 	u32 num_ports;
 	bool port_vlan;
+	bool stp;
 };
 
 struct soce_priv {
diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soce/soce_dsa_core.c
index f93ce9da8400..3b9fde7a547e 100644
--- a/drivers/net/dsa/soce/soce_dsa_core.c
+++ b/drivers/net/dsa/soce/soce_dsa_core.c
@@ -36,6 +36,7 @@
 #define SOCE_IMPL_FEATURES0_OFFSET		0x000c
 #define SOCE_IMPL_FEATURES0_NUM_PORTS_MASK	GENMASK(31, 27)
 #define SOCE_IMPL_FEATURES0_PORT_VLAN		BIT(9)
+#define SOCE_IMPL_FEATURES0_STP			BIT(20)
 #define SOCE_IMPL_FEATURES0_DSA			BIT(23)
 
 #define SOCE_DSA_REGS_BASE			0x1200
@@ -51,6 +52,10 @@
 #define SOCE_PORTS_CTRL_INGR_EN			BIT(0)
 #define SOCE_PORTS_CTRL_EGR_EN			BIT(1)
 
+#define SOCE_STP_REGS_BASE			0x0f00
+#define SOCE_STP_CTRL_OFFSET			SOCE_STP_REGS_BASE
+#define SOCE_STP_CTRL_ENABLE			BIT(0)
+
 #define SOCE_VLAN_REGS_BASE			0x0d00
 #define SOCE_VLAN_CTRL_OFFSET			SOCE_VLAN_REGS_BASE
 #define SOCE_VLAN_CTRL_ENABLE			BIT(0)
@@ -160,6 +165,7 @@ static int soce_sw_detect_features(struct soce_dsa_local *local,
 		return -ENODEV;
 
 	features->port_vlan = regval & SOCE_IMPL_FEATURES0_PORT_VLAN;
+	features->stp = regval & SOCE_IMPL_FEATURES0_STP;
 
 	implemented_numports =
 		FIELD_GET(SOCE_IMPL_FEATURES0_NUM_PORTS_MASK, regval);
@@ -200,6 +206,16 @@ static void soce_sw_disable_tagging(struct soce_dsa_local *local)
 	writel(regval, base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
 }
 
+static void soce_stp_disable(struct soce_dsa_local *local)
+{
+	void __iomem *base = local->base_addr;
+	u32 regval;
+
+	regval = readl(base + SOCE_STP_CTRL_OFFSET);
+	regval &= ~SOCE_STP_CTRL_ENABLE;
+	writel(regval, base + SOCE_STP_CTRL_OFFSET);
+}
+
 static void soce_vlan_set_enabled(struct soce_dsa_local *local, bool enabled)
 {
 	void __iomem *base = local->base_addr;
@@ -420,6 +436,10 @@ static int soce_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	/* Unconfigured hardware STP blocks frame forwarding. */
+	if (priv->features.stp)
+		soce_stp_disable(&priv->local);
+
 	soce_sw_enable_tagging(&priv->local);
 
 	return 0;

-- 
2.39.5

