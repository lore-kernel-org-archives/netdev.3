Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDF037A847
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785107969; cv=none; b=uYxxIxg4cMKbRd+2zCPopn1u/GsJFi5ceiR7UPJl3NBU+63torHWJEZNzJJjKntZfFVVWA10U0gf29VBvrKM1xhCgfyDZQRUTOC6pGYpc7EGWdnSHw/wVIWfhU/n1AG9lATxJJqKbHnHs/0Rd97N3fQO28GyGwhixkehgTo4Sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785107969; c=relaxed/simple;
	bh=v2kSmGUdsRV+012QSQjTrDQ+eXHAlOhF2KtRUdmgdkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3D0pmUf6lgqw/vBVgrpuCIpfmkyIDCiywAPrwSJ0dvrkTdmTa6D7iolx04hrQRxKmCpaW231iUq4AOKu+NELVj59fye1vH7tEQGHvanmwdNzzf5MZ3/z4J4s6KAJS+GUqvTfliY/v7ZCyE3GFROGdiW36Q3re9/Pl9NbR0icGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJBxLFAA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJBxLFAA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cee9b74ee1so16445635ad.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 16:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785107967; x=1785712767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FxqUZKAau5p0iE2zHflVSScszcjRBB1eTtSQVoHDjq4=;
        b=cJBxLFAAaCMIeigpoETj9JIypmv4qSRgjhyn2vRmYY7KJgMSAQXdQ0AyX3U2aI7R1b
         lUyWxuer1Efl6/bqldNBVnvq0YOldXplNn0w6wa/2r1t8UWfKgmpNOUW7QrCNr0WK8GI
         V7l4RpgfPdhPTyheTpkLfi1tcgTfcMZnI0lIFdJrTzLyd4gg9cJNz6k+0kngjMT9iRHl
         VzsSdZSej3q1MR+RJTUV//T52UbUpYZQ/CJBtNOE9ZEp9HLSupg7usCy2elnVSxEgdRp
         40QIJO7EdbhyEbZVEll/Gr6dtHxjdLDe4+FCG6UXKjIt+mAeFkl3C6I+XRGgu9xiQvDX
         ADFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785107967; x=1785712767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FxqUZKAau5p0iE2zHflVSScszcjRBB1eTtSQVoHDjq4=;
        b=H5SvqdvQDV3hJrPtJRniUlUxwAxITkuNH4RwG/V6qBW7/kpwdWQFHurlvU1bcgR88p
         kac6VkXiUcE47BF/t/iZRS1NcWCSuZvoHfsbHDHQoBRx/BjKKuU2T6J8dvoIV3KEg+tM
         qt5hhuzbudobd7J6Y51NYL2ppsBn80mgMz14kbKHKOM29VwlSAPftk4WklZ9kpsatXKq
         5ZZlYtNgD69Dkw4AI0wg2QtdVkRcugC/MFupuq/ml6qO0iRPFiY19dAw4moLvOLzgz7J
         7hu4ycorjEC2uzk9jjAK2MlNU6kXHLz/wY4QNZg6O5fyiZt+im9vDjgqiD3x7HFxSfyG
         g0pQ==
X-Gm-Message-State: AOJu0YyuM4ozPzaQTFhtan7CL0m+RUBYmH7bSveDrBAT+IcUMDptqCcC
	xqDgn6c8hIKlzAjenrkHKG4vtlK2bzUyjGcHFNOzUbA4XevBc4yRA0o8ghaSPg==
X-Gm-Gg: AR+sD12bXIXcqR7UiQjdimsohkrVMIxe2NlLbHnI44GIxZ/C3rDblQ5o0qXQY+tSFTG
	jtJp3MBAhyoOW5syxSoH3w+L4EiwUkiYxG2p2suxwX/SV0Ql+jx/FLJ5tkzojbc9SOUXI7hMU0N
	eUxlsgtvLuchd/mzrvt2Op4mRYphFwtqTuUo7aErIlxpAGMuxsArizDvGTWJfJjWyv4BdiOaufG
	OCWsM/zAl+m7K5fbG6O1ffTsgO8s1EHE+xyxNd1ueZe+vFc9+ZkhwRc4aSrt8S9am2dMyQewhAn
	J+TQDFPnabqKSY4641DGmXex1k6xEMh7w0tEQpQZGYYS1NcTZ2b4VMcGFnP2BDWguxQL/LRBwuU
	1UcNpP2UOx9SUX8Mm8UD/RVAMLBM9h7fIeyp8Zvv7RTmzf3V4AHM8GRtybYLdRc9oaUNv41KcwI
	JxwgIbfvFoOzqf/3uf8Ta0pM3RFsH3RGf5Hjsnz+pZI4MkXK623tmzA/ZCJdEuSmLGFTrrUKz1j
	csxpENgnvTgR8f1I6ibEuvFf/SNKdY7OWX7ueuWeWiv6Zu+3JoV02E=
X-Received: by 2002:a17:903:1ae3:b0:2c9:c991:3bf0 with SMTP id d9443c01a7336-2cfde796a13mr59151255ad.8.1785107967076;
        Sun, 26 Jul 2026 16:19:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59b885sm24939315ad.15.2026.07.26.16.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 16:19:26 -0700 (PDT)
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
Subject: [PATCH net-next] net: dsa: b53: srab: propagate errors from init helpers
Date: Sun, 26 Jul 2026 16:19:24 -0700
Message-ID: <20260726231924.88459-1-rosenp@gmail.com>
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

Assisted-by: Opencode:Big-Pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/dsa/b53/b53_srab.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index b9939bbd2cd5..d34e1fa10c9e 100644
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
+		return 0;
 
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
@@ -651,8 +658,13 @@ static int b53_srab_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 
-	b53_srab_prepare_irq(pdev);
-	b53_srab_mux_init(pdev);
+	err = b53_srab_prepare_irq(pdev);
+	if (err)
+		return err;
+
+	err = b53_srab_mux_init(pdev);
+	if (err)
+		return err;
 
 	return b53_switch_register(dev);
 }
-- 
2.55.0

