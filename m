Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DD0489894
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730088; cv=none; b=iuM8bMhlIfMrdWNsEw6rL2lI8DtYKiHtj4Tz0ICgTnFxaCK6/VvzHzkp4T5rGEWBzLTdLV5UTZOXHXCKIXKaT5rndVHrK8L6ATlyuQuzUExFndkzp2MfS9E6tgcKlPfKbWnC1EPC1yGKExfRLCyjvnGQyV/v9iGupegJsSGb+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730088; c=relaxed/simple;
	bh=tctOPcRlvU9BNw3/GcokUhL0uuzIoz6qCeUXB4fX8qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpHUX0OYjOsQacONJlQIEYRFTW3cyNOZWh9T9Gt/miAHo30pLakTKEJtbuWfEuVKegdnTmHmnholOm4RDVUe8LJ41VqapIlH2Xvy/kc2XD0cuXPU84zN7G/GDnsy6RdarbRBRm2N4FccUb3cgchxYo6Q7Ddc+BOM9AgLo7juVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LE7ExIDZ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE7ExIDZ"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b026020b92so726725eaf.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786730085; x=1787334885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tnUiJhTni7wF1/vS/NeDygrn2VesXGugWJxtxx6vI6A=;
        b=LE7ExIDZAatd+F91zNvPPEgPgwKtsJ9ijqg7wnWT+ciyMd2i8yMSj0sO8RV8Y9Ncod
         xlCpZ5gIQYJG7Ykx3xYu/yjVKHdV/PA5B/W8zmSt7B6kte/I4pJOeTAAUtUKgoJobxHI
         eSQPivpMiePoWvYdNaaCtqp4DBxH6rcQiCvnNvT5b8usc/k+mSDowyPrEhyb/pm+uHqj
         Rh9YcF27U9O44kyWOqbSumIYiRPJVLRTpeJ/I38c6cMbvLpHQu/pMY549zpLgjiYAeKM
         u/3/5e28MBU36QWraZjfFpb76pBT0gx74bRUjZBoLNOm8FMBLJIC8FI+VWGoJCOICwg/
         IhIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786730085; x=1787334885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tnUiJhTni7wF1/vS/NeDygrn2VesXGugWJxtxx6vI6A=;
        b=ePocspnZUMEckVSQGhJEhSJPUzqAw7IbEUjv+qoCuTgVEbjdy6ir9UCRUBHYx4IAGs
         0wyLYaReGCp6ytJrPkBi5s98/PFJg4aCziqrfSsEdhWAa5PHsxAU49DVyVu21O4cAH2x
         uqOQMCjDJgUpShVBCbescc+hZli2ay0vifWwNCU2oR1lhbt0z0SPeJ1q47FO92ljGdaW
         Gfz+b354fa+EfXG0YvGVFoFWN0cnGIy8SXtPo3w9YGXYmssQZhyJGfbH6r8GJSvCLG2n
         O52ef4c3JZxjOZDu7q5voF4BQRWmcGOCBJz4NaD90XRW/jDBpv/IQ5jCC2dLoMShartQ
         mLvA==
X-Gm-Message-State: AOJu0YwPsN1upe4PWsr5vTcx/8N3dtwjBHnvFGpzqn/247/F3DhBQruu
	9itTsKfy+Q2uiC4iaeK/ptJE17jxEdDiyd27QVjza1OS0YXYSP7kEqM+HweVxw==
X-Gm-Gg: AR+sD13OrF7imF3kcHoFuY1GjKon/vIoBVJkC5tNpinsVT1MKidf05ARq2t2m9r9qJo
	1au9KNJqR2bwcSWIBiYOjPdYgbgdyPPY88C6S+GUr+4jP77UZB2Ug/bCfMQ1oV3qe4BXAWX1A25
	fpZbfhxw9oEzuP0i1cujFB9ZudYjb71dMS+QHnr3pLR3Ii9pp+SRDungvTivx1ZR0y5b4eGR38O
	POcFatyHz+WDgCeALG+TzRcmBPM/QW/So1wKEKYxiFVzNRcbcOEHh2AyPBFG6/o09ROfH0MYXBh
	O6T/IL+X3+NPc1HAKmqurodmKHx1Fg9/FQXRA8S/Exy/tSApBJRZ4U1XMmvHfp0YSIWKJMi0jdN
	eGo7xKDT9Z/gUfyLO1Yh4fNUZ9kYeohyWBqZGnQaPraRcjBYCnuIXRpbpTo62BlG/IJJXmiEEr6
	K4pw9j/lig8f6ZdEw3z7vB1pBbnRHmm4vgLtQ3JHCCKIlDsqITJwWekwyY3PLMy0GCf7AI9D4=
X-Received: by 2002:a05:6820:f02f:b0:6ac:c531:2ef4 with SMTP id 006d021491bc7-6b0d68c0240mr5561219eaf.26.1786730085367;
        Fri, 14 Aug 2026 10:54:45 -0700 (PDT)
Received: from capidev ([2806:264:548c:900d:c985:8bca:7059:269a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0d963f345sm2423729eaf.7.2026.08.14.10.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:54:44 -0700 (PDT)
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	jonas.jensen@gmail.com
Subject: [PATCH] net: moxa: dispose IRQ mappings on probe failure and device removal
Date: Fri, 14 Aug 2026 11:54:03 -0600
Message-ID: <20260814175404.1616-1-diegomancera.dev@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus: Norton (VPS 260814-6, 14/8/2026), Outbound message
X-Antivirus-Status: Clean

moxart_mac_probe() maps the interrupt with irq_of_parse_and_map() but
never disposes of the mapping on the error paths that follow a
successful mapping, and neither does moxart_remove().  Every failed
probe (for example EPROBE_DEFER from platform_get_ethdev_address(),
DMA allocation failures or register_netdev() failure) and every device
removal therefore leaks the interrupt mapping.

Register the disposal as a devres action with devm_add_action_or_reset()
immediately after irq_of_parse_and_map() and before devm_request_irq(),
so on unwind devres disposes of the mapping only after the handler has
been released, and devm_add_action_or_reset() disposes of the mapping
itself if the action cannot be registered.  Since devres_release_all()
runs only after the probe error path frees the netdev, release the
handler with devm_free_irq() before free_netdev() on the error paths
that follow a successful devm_request_irq(), and likewise in
moxart_remove().

Fixes: 6c821bd9edc9 ("net: Add MOXA ART SoCs ethernet driver")
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
---
 drivers/net/ethernet/moxa/moxart_ether.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index 8bd60168624a..7b5720f993ae 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -451,6 +451,13 @@ static const struct net_device_ops moxart_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 };
 
+static void moxart_irq_dispose_mapping(void *data)
+{
+	unsigned int irq = (unsigned int)(uintptr_t)data;
+
+	irq_dispose_mapping(irq);
+}
+
 static int moxart_mac_probe(struct platform_device *pdev)
 {
 	struct device *p_dev = &pdev->dev;
@@ -459,6 +466,7 @@ static int moxart_mac_probe(struct platform_device *pdev)
 	struct moxart_mac_priv_t *priv;
 	struct resource *res;
 	unsigned int irq;
+	bool irq_requested = false;
 	int ret;
 
 	ndev = alloc_etherdev(sizeof(struct moxart_mac_priv_t));
@@ -472,6 +480,16 @@ static int moxart_mac_probe(struct platform_device *pdev)
 		goto irq_map_fail;
 	}
 
+	/* Dispose of the IRQ mapping after the devres-managed handler has
+	 * been released: devres runs actions in reverse registration order,
+	 * so registering this before devm_request_irq() guarantees the
+	 * correct order on probe unwind and device removal.
+	 */
+	ret = devm_add_action_or_reset(p_dev, moxart_irq_dispose_mapping,
+				       (void *)(uintptr_t)irq);
+	if (ret)
+		goto irq_map_fail;
+
 	priv = netdev_priv(ndev);
 	priv->ndev = ndev;
 	priv->pdev = pdev;
@@ -533,6 +551,7 @@ static int moxart_mac_probe(struct platform_device *pdev)
 		netdev_err(ndev, "devm_request_irq failed\n");
 		goto init_fail;
 	}
+	irq_requested = true;
 
 	ndev->netdev_ops = &moxart_netdev_ops;
 	netif_napi_add_weight(ndev, &priv->napi, moxart_rx_poll, RX_DESC_NUM);
@@ -552,6 +571,8 @@ static int moxart_mac_probe(struct platform_device *pdev)
 
 init_fail:
 	netdev_err(ndev, "init failed\n");
+	if (irq_requested)
+		devm_free_irq(p_dev, irq, ndev);
 	moxart_mac_free_memory(ndev);
 irq_map_fail:
 	free_netdev(ndev);
-- 
2.54.0.windows.1

