Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205672DE6E3
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 01:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787794598; cv=none; b=of5bP6AHF9yNom49/WLPKPIf+79tmzWklyqz0YpuakmB3SaJkMOaRqFTItXr0KOAKRiICh1SBdq4wUtjwxW4GqsTd39ILCKLS5nyKGlAJvO5g3Fb/MoSXLJ7Fe4hLcuicbuFHZF/OBR1GzLaOEVwPdUVRw18kpjpvP85DkUPhxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787794598; c=relaxed/simple;
	bh=8o4QhqDTzyiRPqZdKBYvXh4MWPFiKRWcYZxGTdgZi7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdjCxOIoHc2Mdya+UDatZqZqAh/kYwbxIrXakxBfw8r6BP7UwM5DeuYSe42fyNzC+1kckoWcgsLiSCe4jC4h7XSCrRXym/q4iv3x2KBpEtkGFC7T7xYKwaH28hDRXqmloWXiwyFotfCuqQF3l1UBKWiA6UTraNbtUoU5NOHe22c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaS8bosp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaS8bosp"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39675172593so1384314a91.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 18:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787794596; x=1788399396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8RslJAAyqdhFQpyr/sYYgRXhKwruiBZvG6osvNqKxk=;
        b=PaS8bospJeklCDTCXrREPGzFxpUsdegBhhhnglLtejoTiXIl4pt1yCQNesm3++5lQy
         XFrnFrtDRzBOjgeSo3B8wyUBa2YohkYLYXHSARZUS9Dtf0jVSZR9phnfKjLlvVYghTGT
         GoagHLY4PuqgEG7J0QwEtz7v0lSe3cK0T2az6wtqcGW/EshQLP14Dg+vdszfMBcBRfOl
         dsc/xoTJr30MsAQc5PeySFm3XJI3ph2ZHgCPpNZvQptLo2S55x/bUdQeJdTLrSG3XQmI
         Q0TohLUBFzjKZNq8LP4MKhZFLy1nVqP4pqE+CSmE1Lcv8Qz2bjA9QBustVolr/pDDTyy
         onzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787794596; x=1788399396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8RslJAAyqdhFQpyr/sYYgRXhKwruiBZvG6osvNqKxk=;
        b=giV9eOC/CkJzOfvV1AsMAQ3TDn9v5EfkjnNI7MG7WDTcCyCj/nCynOpxIUMdhpktoB
         y/7jKNP2s0S/LcGbjjMPftQdRs5YNW/piUZQXuJTh4ZR48RaXpOW3qJaveKJ1I/OFVNh
         a25k5WhMOMXkAgolfgQmYjHACGRJnzqauNl6ABUf6jC6ZQOw+oZDihJgg3o+8Vuk3cQn
         OdYB1cgATpI0Ov0lmj/txclwRRu1B3n4M7V6tA8bqUN6CG8GLy91/WiniPuUKNAaQyeQ
         9J2zg9u78Q+u8Q9DlucJ9JJT5698frp5SUmcY4E5BOGL8ktdnAH02f0htpGzshQaDAwg
         Pcfg==
X-Gm-Message-State: AFuF++n4LrnqP7W8TRhlAL8BEP430AYJxH2SzwWbJRWiddVRI8BPEQC2
	girvhZCfDi0L7I63jUES8b1pVtxyndKxBAB3BiCvNN9+qfAcmDylAW6qg0411Q==
X-Gm-Gg: AR+sD131Fxt5t42No2Re4jTX92Lvqjk6opT9cLR0T9YuL2ILVkPd2tloa/hWyFAikXr
	yLaepBclzOClvMdNnWGDRkWpgy/9QBr7XaGLppdHcCcl+E2Tg+uP/QeLQsVfGGvu2EzfxkLg4sU
	I6T7QiUxEJMZYmt2GfrrSOcSHi2d6NzBPYB+iqW+gxn92UFPhqHiSkDcaClBa54rBIrQdIqcjlF
	bj74dbefCuIDZXrLdlPO2+FilFgPZDkUic1/gmPp389qqYrbP084g+ydWDCnoVzcX117f5XYW13
	jOCWRoKmrPCU1cbeRMBE4UdZvEfYBH366yKLpFrKbtmZ4NpKEzuwg5LSxJ4MOPUJTeZWKi7m706
	EU7j5vml8LyMQ7RKS5QO8NnxEbgYxzoWklFFpIwIthbzb3Fus5DRtsqFHmg0lNUt7oxvfIpDyma
	93Ns3ye4oiBipBk+hdh1m+fZ/UOX+l7vTd2X95yuZ+DDJzRGwNknj+J1FWRgOeLynzbMArl7pN9
	PvJic7u41RTiCpDpe4f+QZ/WAGBmF4qxhcvuAiiSXf5Zue/lCmuoMKILF5wRkyvYltpXv0XrK7l
	gob11YBxE6jaY0AYT+LzwC//H/p4Z0YVH674KsM1IllPs9qi
X-Received: by 2002:a17:90b:390a:b0:396:5785:843 with SMTP id 98e67ed59e1d1-3966d203a94mr20643518a91.8.1787794596431;
        Wed, 26 Aug 2026 18:36:36 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea7fa9sm551887a91.4.2026.08.26.18.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 18:36:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Imre Kaloz <kaloz@openwrt.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/INTEL IXP4XX ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: ixp4xx_eth: handle probe deferral from of_get_mac_address()
Date: Wed, 26 Aug 2026 18:36:34 -0700
Message-ID: <20260827013634.167932-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ixp4xx_of_get_platdata() returns NULL on failure, which the probe converts
to -ENODEV, discarding the real cause of the failure. Return ERR_PTR()
with the appropriate error so callers can distinguish cases such as
missing DT properties (-EINVAL) and, importantly, handle -EPROBE_DEFER
from of_get_mac_address().

Fixes: 95aafe911db6 ("net: ethernet: ixp4xx: Support device tree probing")
Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/xscale/ixp4xx_eth.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
index b0faa0f1780d..b8889f87ca03 100644
--- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
+++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
@@ -1444,13 +1444,13 @@ static struct eth_plat_info *ixp4xx_of_get_platdata(struct device *dev)
 
 	plat = devm_kzalloc(dev, sizeof(*plat), GFP_KERNEL);
 	if (!plat)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ret = of_parse_phandle_with_fixed_args(np, "intel,npe-handle", 1, 0,
 					       &npe_spec);
 	if (ret) {
 		dev_err(dev, "no NPE engine specified\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	/* NPE ID 0x00, 0x10, 0x20... */
 	plat->npe = (npe_spec.args[0] << 4);
@@ -1468,7 +1468,7 @@ static struct eth_plat_info *ixp4xx_of_get_platdata(struct device *dev)
 					       &queue_spec);
 	if (ret) {
 		dev_err(dev, "no rx queue phandle\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	plat->rxq = queue_spec.args[0];
 
@@ -1477,11 +1477,13 @@ static struct eth_plat_info *ixp4xx_of_get_platdata(struct device *dev)
 					       &queue_spec);
 	if (ret) {
 		dev_err(dev, "no txready queue phandle\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	plat->txreadyq = queue_spec.args[0];
 
 	ret = of_get_mac_address(np, mac);
+	if (ret == -EPROBE_DEFER)
+		return ERR_PTR(ret);
 	if (!ret) {
 		dev_info(dev, "Setting macaddr from DT %pM\n", mac);
 		memcpy(plat->hwaddr, mac, ETH_ALEN);
@@ -1501,8 +1503,8 @@ static int ixp4xx_eth_probe(struct platform_device *pdev)
 	int err;
 
 	plat = ixp4xx_of_get_platdata(dev);
-	if (!plat)
-		return -ENODEV;
+	if (IS_ERR(plat))
+		return PTR_ERR(plat);
 
 	if (!(ndev = devm_alloc_etherdev(dev, sizeof(struct port))))
 		return -ENOMEM;
-- 
2.55.0

