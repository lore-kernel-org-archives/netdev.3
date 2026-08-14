Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E7622D4C3
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 21:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786742169; cv=none; b=ciLrgRQw9A5H2nv3I55qbPNMztxBTJtzZc+U86zUIPUKs2B+EOjSuGxQI0w5HYq0oTNAk92moBGbZpNSPZHKZyRTS7+Rw27/qNcqn4ZGgbbR2xs/naXqMMIxefbuK7aZsWHCqplIVt7ligFjLzqIIpnHMMDM/4YzBpldovejNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786742169; c=relaxed/simple;
	bh=olW/oaiu18B2Xf7Gdi6WTgFTrvmTZ5V4wg8vNM698Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJkNuqLmM/JeuvShyZGNhCqe3zhSa1dJFQSUzUEmPGwkUuv66F7E9tBEdt2fwJ5tkJIqOOodb7cLgN84qbv74rVYYi7KiRPBRZrHK3B0LEisYoFSKDp95r03Rz4ocIpFp1cJmaexT/ZlpjeeZ9CJwXiPiKWOIB+5aRMD1oaLoB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+/YL2sR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+/YL2sR"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51bfe810293so7647001cf.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786742167; x=1787346967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iUuph7+GUGabAzz9uo8lYg5bSl89amlm6cPhmSveu4Q=;
        b=D+/YL2sRf/UTeI/YrpGvUMDKhJdiVvqMUMpDKe5T7pfpH6g6maZ25JUDxHim095Vbg
         CGPgvboJL0elz5fMHcRlqON6ZOyIbDnMNnJTaCRZbLFdK5pg9/FZQUwOXEAFUrTEVFz+
         ll08XVpUjujb/662c5K9Lejb/U3aUy38hDEynbx4d5WK/JV1cxI870wXFJ0Xnry8jUVk
         0NeFURUuWrtyfg2sJ55llAcqOkovjHS8InJhxtBqex9yVVgx8qa58cClCSLHho8mhNUc
         GviGnyjcWGNwLQeKxB95mCv48GQjjEdAz50yeHVn3eLfN8/7JpEVagZFTjB/+XqlKKgy
         580A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786742167; x=1787346967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iUuph7+GUGabAzz9uo8lYg5bSl89amlm6cPhmSveu4Q=;
        b=k2V74sRtEzAh0KWJNG8VhqVuNY3mGtpZ4kEHLKhz/OdLKWUHcAnAk3v4LzPMUaEIvG
         k/4Z37r0B2fTqjT6SouaRQzAHNfmL7yDWLNJb3bKkm8iybQ2ZCGBmUsv2j0/48ZesScy
         w+3HMfWbHAwjB+Mv+L3fOjFc1/4hiiN8h4q3Bt5wpBZYD09XA06kjRF/RDzWOLbthS5I
         logzud3YIjr/JpgY76U2N1McncD3h9YOGxGdDDFV8k/YxJiVtQwmyL3WKE4nEQxIL2Pl
         Nl9hs33yb7Y1neTPyBJxKikPK/Dy1oc/EUlf0fbpQwlfDSmja7iab88QwMbyeTyi95EQ
         XRXQ==
X-Gm-Message-State: AOJu0YwHqPCIEJ8aZI/tIgWesHv9MlWJV/luEkuySp9L6pIpFM5rW/bV
	GqGlH/bYCwvPh3KS4OX97DPDoQFWAlQbxXU5UhqcKs2NDa9AY9gZOLdsof7rSg==
X-Gm-Gg: AR+sD12m6TJrqAz1u1DxKUiAEwoqQnqmucjFR+TX9EC2RWAcHuGghKHn9yDwdrrnYd6
	ClN3BsjKy9Pldg/d9QxBT4rOy9AzXj4YRC0bPCC+O6l2W0NLPFXLp/mTcBUtJE9aKoARx46Fzpl
	oR1LFmmCOwW8+2F7habE2+dyQOT0rlLpk97ioDcAqMHGnqBAS4N0rj0OIvgrk4E42RfFPIK62IO
	zWAou+xfLclbsnw6+b4Zlnq57jH6hGwcI/ymsrIHvMcBOTzcSNP3qttYGMCNyqfT6Td8JkwOXQF
	XUWSDaudCteLdloqGbfBgoib8X5uFbY6wMrDqksAN0a8Yytu2fq77fpw7+gmkXlmH6akYgrjW2X
	Yaix56QQH05T93uVS6esX0NkxwblS+IBQQjnGdqACrI7g1E7ZjqXGqdgYfBFPg0a1Fty6uAn2OP
	yUiz2htmz5U3wRYtFjr7BcPw7QGh2tJ1Ku2MRd0DZHVV2wCh/VjXuUgriz8hQyWDzbrn0VeeTm0
	uQGwv0/Zaa+92c4Ci0D1V+gua9GLOhAsrc24FyB92v4xhVzfDS6QKqYqaNy3NQUNLR/o+VouI7Y
	UBlImBQJti4JeFDYr1XcM5fKLWeu9Gwfgz1rKjLx61gU1duT
X-Received: by 2002:a05:622a:418d:b0:517:72e0:612 with SMTP id d75a77b69052e-52d855ae71emr113034251cf.42.1786742167082;
        Fri, 14 Aug 2026 14:16:07 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a9359338dsm25695766d6.44.2026.08.14.14.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 14:16:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv4 net-next] net: dsa: b53: srab: propagate errors from init helpers
Date: Fri, 14 Aug 2026 14:16:03 -0700
Message-ID: <20260814211603.53670-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert b53_srab_prepare_irq() and b53_srab_mux_init() from void to
int-returning functions so probe failures are properly propagated.

b53_srab_prepare_irq() now returns -ENOMEM on allocation failure and
-EPROBE_DEFER if any port IRQ is not yet available.

b53_srab_mux_init() now returns PTR_ERR on ioremap failure instead of
silently ignoring it. To keep the same behavior, warn on failure and
continue. Return on -EPROBE_DEFER.

Check and propagate both return values in b53_srab_probe() so the
driver core sees the real error instead of always reaching
b53_switch_register().

Add error handling in probe as a result of b53_srab_prepare_irq().

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v4: ignore b53_srab_mux_init() failure to keep same behavior.
 v3: move mux_config to function.
 v2: address memory leak in b53_srab_prepare_irq().
 drivers/net/dsa/b53/b53_srab.c | 51 +++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index b9939bbd2cd5..d5213e34266a 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -84,7 +84,6 @@ struct b53_srab_port_priv {
 
 struct b53_srab_priv {
 	void __iomem *regs;
-	void __iomem *mux_config;
 	struct b53_srab_port_priv port_intrs[B53_N_PORTS];
 };
 
@@ -531,7 +530,7 @@ static void b53_srab_intr_set(struct b53_srab_priv *priv, bool set)
 	writel(reg, priv->regs + B53_SRAB_CTRLS);
 }
 
-static void b53_srab_prepare_irq(struct platform_device *pdev)
+static int b53_srab_prepare_irq(struct platform_device *pdev)
 {
 	struct b53_device *dev = platform_get_drvdata(pdev);
 	struct b53_srab_priv *priv = dev->priv;
@@ -551,32 +550,37 @@ static void b53_srab_prepare_irq(struct platform_device *pdev)
 
 		name = kasprintf(GFP_KERNEL, "link_state_p%d", i);
 		if (!name)
-			return;
+			return -ENOMEM;
 
 		port->num = i;
 		port->dev = dev;
 		port->irq = platform_get_irq_byname_optional(pdev, name);
 		kfree(name);
+		if (port->irq == -EPROBE_DEFER)
+			return port->irq;
 	}
 
 	b53_srab_intr_set(priv, true);
+
+	return 0;
 }
 
-static void b53_srab_mux_init(struct platform_device *pdev)
+static int b53_srab_mux_init(struct platform_device *pdev)
 {
 	struct b53_device *dev = platform_get_drvdata(pdev);
 	struct b53_srab_priv *priv = dev->priv;
 	struct b53_srab_port_priv *p;
+	void __iomem *mux_config;
 	unsigned int port;
 	u32 reg, off = 0;
 	int ret;
 
-	if (dev->pdata && dev->pdata->chip_id != BCM58XX_DEVICE_ID)
-		return;
+	if (!dev->pdata || dev->pdata->chip_id != BCM58XX_DEVICE_ID)
+		return 0;
 
-	priv->mux_config = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(priv->mux_config))
-		return;
+	mux_config = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(mux_config))
+		return PTR_ERR(mux_config);
 
 	/* Obtain the port mux configuration so we know which lanes
 	 * actually map to SerDes lanes
@@ -584,7 +588,7 @@ static void b53_srab_mux_init(struct platform_device *pdev)
 	for (port = 5; port > 3; port--, off += 4) {
 		p = &priv->port_intrs[port];
 
-		reg = readl(priv->mux_config + B53_MUX_CONFIG_P5 + off);
+		reg = readl(mux_config + B53_MUX_CONFIG_P5 + off);
 		switch (reg & MUX_CONFIG_MASK) {
 		case MUX_CONFIG_SGMII:
 			p->mode = PHY_INTERFACE_MODE_SGMII;
@@ -613,6 +617,8 @@ static void b53_srab_mux_init(struct platform_device *pdev)
 			dev_info(&pdev->dev, "Port %d mode: %s\n",
 				 port, phy_modes(p->mode));
 	}
+
+	return 0;
 }
 
 static int b53_srab_probe(struct platform_device *pdev)
@@ -622,6 +628,7 @@ static int b53_srab_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id = NULL;
 	struct b53_srab_priv *priv;
 	struct b53_device *dev;
+	int err;
 
 	if (dn)
 		of_id = of_match_node(b53_srab_of_match, dn);
@@ -651,10 +658,28 @@ static int b53_srab_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
-	b53_srab_prepare_irq(pdev);
-	b53_srab_mux_init(pdev);
+	err = b53_srab_prepare_irq(pdev);
+	if (err)
+		return err;
+
+	err = b53_srab_mux_init(pdev);
+	if (err == -EPROBE_DEFER)
+		goto err_irq;
+
+	if (err)
+		dev_warn(&pdev->dev,
+			 "failed to read port mux config, ports 4 and 5 may be unavailable: %pe\n",
+			 ERR_PTR(err));
+
+	err = b53_switch_register(dev);
+	if (err)
+		goto err_irq;
+
+	return 0;
 
-	return b53_switch_register(dev);
+err_irq:
+	b53_srab_intr_set(priv, false);
+	return err;
 }
 
 static void b53_srab_remove(struct platform_device *pdev)
-- 
2.55.0

