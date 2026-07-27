Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1542FCD5
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195655; cv=none; b=o1Z+BVOtqdXt5B99a6ebS4BgYilH9JD+j/+cBSPL3jrHxZ86B9ouCSncYobRgW9vtdydIjwwIiL4E+Yqa+qCD4ZQLfx/3Bn4uo6CSSig54AB8c3RL31Rrw2k/dqEBXmWv6X3zYDxBoJAKw1cInvgP2M5vAa1OZ40xvOzDaguBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195655; c=relaxed/simple;
	bh=ZB8YP71TPpwuUGYM6eI6k6ptFWukR4mgl20rfsm3Wfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hcOH3vrtiAXQ4SYjRQb3DfDFTVYXOF1xejPyDimllwEny49XyjznqNfCQJqdZVihsZGWJisF68v7P7ab4VRdmoTckhG2O3SLD4p22OQZ44z+0oTv0fBrTnzsun1F/CGVTiHvGEhUB/AH3CWRBEY6OR/cvJt/CM1NYmR5pXq/EIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAzD4ZQl; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAzD4ZQl"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e55b62640so176861885a.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785195653; x=1785800453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EmN4G3wTK8UDrkQKCZqBFLXktHfX+IRMj8F5YCKN77E=;
        b=MAzD4ZQlh6CaxOyKd9bi+P1L22RfErG34xivcWU04TKJA7VhkR+rXlgV+mIpbS3WjS
         QsTNKxEcSCiIpAJOW4uoA9vOoVp+RuBo419p46Pu6AQZ/7jVPYLHmM8ZKOSn2MNYUv/W
         JpSPesbp81JZc1+6R7WqBP9q3tJ8dy0f+Oov3vqaFD/lTdxx54LDdKwHKleiCU5U2vGG
         NPzYBnalAX4e9ZSv2VvRdY2efZIe6vmirhFA9HYA8jiFDB5HDhwmB3MoQuucOqQokPIy
         GiqKmada/YT6AnuIxf6g2SbKsJrg3HPphUvstiBDoISezaGta6ab7y5BMGjeYOdoJdrE
         lluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785195653; x=1785800453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EmN4G3wTK8UDrkQKCZqBFLXktHfX+IRMj8F5YCKN77E=;
        b=FhucdfD1lT/blefzEg+mOKdNoTzQ9YGVjWE8fzTkMZZ9X3CMYNIjkmBQWjsSzww/0I
         vtiWtE3OliKOAQKRMPk2a77471T8AxKeOB/2GG8E66+KIPqL1kSqjM7MLVpsXzeA+RJF
         nRFQjWe9L+lEVxtHeefUKCe1jDJ6YY59Hz2UlkEamZm0G9jrANlfhUHCMhCNV6IJDt/i
         tfo+P0Qr7z8cx2qCiTJaOkwjvJ6ysxCOFr3GQ5rui1QGyGDxgrsFDsuxQthD1fotwLHc
         LL3RIPlEfhqoTdVDqKJAvkOBW246EBnnql2qfYQBMpc15szYtMtrsOdwzmlIYUnCox27
         kbdg==
X-Gm-Message-State: AOJu0YzEv8xRyfTsZhWSyYDaZ9jYqEPuHZFrr8bKVu0nx6pBginjMuTn
	Q6lhdHYhtqwRoaBnN8lAZrwMLyBHuFlkJGPCh3l7zPPHaI7ydZoGb2tjpDN6WD6m
X-Gm-Gg: AR+sD13b1NTNuFr7zn17r3YUNZrplI200VNxe6FXp52MPwqp+HPP1ssZOP+LJWisGDc
	avC/OBlJgtPA4/J+jSozEQ2bkG38XOrQDTsgSTnkLgrVU2nmVL4mJJiUkAAaOU+7B+nIUT0oM2d
	L1JqkiooJmun4EgO334tAlV8xVpOykU8vfKFvzIVWZJHL/I8Mj5PhXEQftpjYnU5fPFKooZTdEC
	0cAZmK67Q4Sz48liKgL/zbjrB6eyVTpv051F+s1Dy8pDxAlxGex+oBmFOcJSdGZfINFSDLsvxJ8
	a+KUhN/m4gU6rpbLoCXYJxgrUylNIHZbbUDm+66qh00ajVS3jkXXP6mCnPJRXJbfLxgVQui75nK
	fXGyxNIuMWjs2ibucPliUCSg0K/E8rgjNd9TfpNK+qJdHHrV1CRsveBqI9ny/cwc0N1jkln6zYH
	WV6Uj8v7K9qdUj3puBtsvRFOVsQngx+HzzwwFzOP20VCp+/ZIbDGToneamZwiPevFOeLGZL6SiT
	vKjR02Rp+PepKQ3Zy3cb9FuZghJWMlXyuh7b71pZWVWG5mdulzkL28=
X-Received: by 2002:a05:620a:4622:b0:92e:f372:7b5b with SMTP id af79cd13be357-933026bb8d5mr129985a.10.1785195652789;
        Mon, 27 Jul 2026 16:40:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de675571sm715203685a.47.2026.07.27.16.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:40:52 -0700 (PDT)
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
Subject: [PATCHv2 net-next] net: dsa: b53: srab: propagate errors from init helpers
Date: Mon, 27 Jul 2026 16:40:49 -0700
Message-ID: <20260727234049.287278-1-rosenp@gmail.com>
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

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: address memory leak in b53_srab_prepare_irq().
 drivers/net/dsa/b53/b53_srab.c | 36 ++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index b9939bbd2cd5..289504321f3e 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -531,7 +531,7 @@ static void b53_srab_intr_set(struct b53_srab_priv *priv, bool set)
 	writel(reg, priv->regs + B53_SRAB_CTRLS);
 }
 
-static void b53_srab_prepare_irq(struct platform_device *pdev)
+static int b53_srab_prepare_irq(struct platform_device *pdev)
 {
 	struct b53_device *dev = platform_get_drvdata(pdev);
 	struct b53_srab_priv *priv = dev->priv;
@@ -551,18 +551,22 @@ static void b53_srab_prepare_irq(struct platform_device *pdev)
 
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
@@ -572,11 +576,11 @@ static void b53_srab_mux_init(struct platform_device *pdev)
 	int ret;
 
 	if (dev->pdata && dev->pdata->chip_id != BCM58XX_DEVICE_ID)
-		return;
+		return -ENODEV;
 
 	priv->mux_config = devm_platform_ioremap_resource(pdev, 1);
 	if (IS_ERR(priv->mux_config))
-		return;
+		return PTR_ERR(priv->mux_config);
 
 	/* Obtain the port mux configuration so we know which lanes
 	 * actually map to SerDes lanes
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

