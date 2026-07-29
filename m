Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B893E1D08
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785357001; cv=none; b=SssqFD8qmtkcS6wo+LwCNaooJ7U1O3X7X6B1cOR6s05ylpa+a9ydfOqwk0eTMK7EuKJ/4vFd77hEZy1uRX+7zawb4tOPAQw4rhfDg0BScJ/LUkk5tmQj+qOKNRKwRH850JHFaPd0EjW/aCcsEyPtTcrvHw9f4CYriheXWJee/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785357001; c=relaxed/simple;
	bh=H9bDi7hL01TAucB5lO49EUPFSlIgRngaywv1aRrohWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TbYxl0o2eLuWlbdER2Pnid+FggGVm6jQsKpaW/21VGclOKZyvaU2d/Rb0WnsbHt6ieib53juY6FubNVm5YkXC6YfAODFEnnD74DMMShzwzNnu7QocEbhDwH91ln+UV4dRGO88+fuNKxm874fMwZdy2WFuI4QTs1j3n0klhIyMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qlPfEHh+; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlPfEHh+"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8edda5d56a5so12890026d6.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785356997; x=1785961797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vfZQeSMzdITyjFS9OMFudbjyXgRSJSCBaN6S7210wng=;
        b=qlPfEHh+C4shZhekBnxO0cRZ7EhkxX0wWEsqeNv2dyG1UHmU/TZx0bLktsXzdjtbpN
         zu2n/dL/e3piDXNvvkhh5cz+tjs3M7gArK8YTdlEgzwS6b4hprE1Ik5uKlhCcyhJcog2
         /qQWAd6sCBEFdGKyUEGZpYv97BdpK805UjG6UDELg2fo11jZdM1FS6zpypMHXXjb8ZX9
         HvtQIGiTfiEo2+qTaO/DAmmXsao1SA5KOad1UAlesQubLzJpQf2ZzWCsfOKR5ZskNchy
         SrtsAK5LlI23p7m/TbqjtziXWmv/WjwnxZGMBaZ+sNrjIX0mKHpBR2YJW/3XvvS9NaUp
         xTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785356997; x=1785961797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vfZQeSMzdITyjFS9OMFudbjyXgRSJSCBaN6S7210wng=;
        b=mSuhr40L+CBYNPgbx5h1FpfHrpR+WP5B5CNM8qC519dtjKnh4FFXB+k7o4EazWsHvI
         GvSMPxPW2SkyMnoJzJV4wdLCj+Eig0JVck0O0IPdbSVfY6f+DdOgb2BPB12VDt9l5EGq
         iKmV1ma2yNNdXDGQkE03TY+qe//6IzFgP7PbG08tkHV61vBjLhHz1J9jHB3RoufB1tql
         8Vu9KzLa5mWMY3ZpGqzFUFu5V+wgcIQXf7/rBJt3gZ8d9nxrPCxB3/wHxJO/jZzP08rX
         8SXWLmjHI5B9MAgkonTV8C3w4LwURSAqTtAqtNZcxodl4FRQNNQxIJFhKZkdhA089+t/
         yRdw==
X-Gm-Message-State: AOJu0Ywb14JqotJSTXQZmQaCjIOI1UMMAYI/42i6lDS+GRhC8z6Xpose
	skMv8ED5AKSc1rYVBg6QOX7R0orQmPs9P/cv8Oy3Ne0qp/6+l1z27BT5LYiK4D5d
X-Gm-Gg: AR+sD13ES2qc2QIwl6LEvqIhi5p8XwQessUh4XOAUHrPmlp7MTmwJN1p+QGfXnEcyRt
	SFAGs2/KeMIUIgWe89qw6B5pGH27mnXbp6GABUY0mFFf7Nn8OwAezZTyjDcw5H4RInGx2Ezt/4/
	+dpb8TsdSMB4ZkM7AyBD6G2zy6XEHqGPezIGoy9zCu5sP6aYGHobXC6pPhOjwqRs6YGPe4qjWbm
	dxzkf+8WMsNyEn8CwnbuecPJvsF/hMohrxhRGLmU6Hmz7Sl1mqdSEcO4u7vTQmkKPxQTNx24CDZ
	hzFQk1wvuG0hUj0p2/dQySM7lkN6/kweebu+OdVyc6ElMXYoS3Bds99eGq7P2xdL3qNzx9PGidE
	uSIDwxaDU+pwTnNcRYQQY9WHVrWIpHIAwyDra9MbRno96nHCB5aHsaVYFib6VmytIJ/QCwm4jaO
	0415Ek1WWChhb2afdvX8zpEFl/za4MfIdgj/2zcZeT/uXuWT2z/PXDlfCa9Luz/uo43e+xoiVtm
	pcCg3uRzpfaFpEkB9AIsTIk6w0a5tOIEjk3K4fmg+m5N6LVXCOGXFYttgNK2RKEew20v/5fjC0Q
	ul5mbuuMu7I3IXt04kIWrcJ5LS/Co2Pz70DQkQ==
X-Received: by 2002:a05:6214:20ee:b0:908:23fd:8147 with SMTP id 6a1803df08f44-90830180b97mr5068696d6.23.1785356997367;
        Wed, 29 Jul 2026 13:29:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd68d45sm32660646d6.33.2026.07.29.13.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 13:29:56 -0700 (PDT)
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
Subject: [PATCHv3 net-next] net: dsa: b53: srab: propagate errors from init helpers
Date: Wed, 29 Jul 2026 13:29:53 -0700
Message-ID: <20260729202953.704662-1-rosenp@gmail.com>
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
silently ignoring it.

Check and propagate both return values in b53_srab_probe() so the
driver core sees the real error instead of always reaching
b53_switch_register().

Add error handling in probe as a result of b53_srab_prepare_irq().

Move mux_config out of private struct. This was needed when devm was not used.

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v3: move mux_config to function.
 v2: address memory leak in b53_srab_prepare_irq().
 drivers/net/dsa/b53/b53_srab.c | 46 ++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index b9939bbd2cd5..81bfd5cd1022 100644
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
@@ -651,10 +658,23 @@ static int b53_srab_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
-	b53_srab_prepare_irq(pdev);
-	b53_srab_mux_init(pdev);
+	err = b53_srab_prepare_irq(pdev);
+	if (err)
+		return err;
+
+	err = b53_srab_mux_init(pdev);
+	if (err)
+		goto err_irq;
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

