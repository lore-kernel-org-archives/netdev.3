Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35AD436351
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607304; cv=none; b=cB516EQyhbCo4sMaT1FeiHHIXj7Pd0MAvnmmsJyldFoSfBiF7GwxsUExKAs6nQkzbdyLksAGM3ZWZgjVsHLUUzupSb7YYDyE64sFk8B3nSuyPOqgHmvXcSG7XZADDsfGx7/2GA9Z4aUkiVfwEpmyDUZnBuTxeC6UvI+t5cF6jYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607304; c=relaxed/simple;
	bh=jBBNnQC7lq61TLq34Ey49geUnAl0MRFMoFlzzp//5FM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SVnVHOpq49cb9XY6u7FcG1+nbFw7nQco976/fJ9iPuEaZ0R37yxZsKaB7QSRdI92dUxn5TV6UIzqOS5TeOn4Bu2EhSnHCpAEurzRwp+ZxezwKN+wePmSl9OGewWtdjubp6k4lGO4ebyRZ0STARmSdnPYpsAEUc58/b8dDANx1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMdYxRI/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMdYxRI/"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so2180618b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781607303; x=1782212103; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=72nfFGwOqmCepnKWEGZx1I8t5XYaTrVTqrklMpMGSkY=;
        b=nMdYxRI/16ZY3irTKWc1TsRLkfY4Lfwzlayv/KTNxRNjjBZ82h4RI3hGrw1Ut6t8LT
         3RR5LyoUGMhSJ4uYCYLaYwhgSxhUY5UcznT7aYhN8Mx6b2vo++SRFitlBtxhSCrjXev4
         L0pHhSzr6AOIJJNrApLKFrJnvcya9GyTcvqnKMsfnLfbisTNDL0yfpW6124BRvih5NrW
         VJSg9rgemmKGXHhRzbwEaImwYtwBIkYYW6tJ4Pp28Ldla62X0ufbHa/1p0gaWKc3peG9
         x9RwwFIra2DzwwDFEE8mvfGVYBbx3Sc0+GPWdjNAuuK3tvQX5+flxHjTZsmxKsiBZdBT
         PtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607303; x=1782212103;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72nfFGwOqmCepnKWEGZx1I8t5XYaTrVTqrklMpMGSkY=;
        b=JR4IViz/BRXO/UnkqOUstELQNWAFVP0w+NB6ObuAXFSuY3V4JbNiidjbFnAMMwqzYH
         FmYLLLGp2T2EG/1jzfnhSemvHOlN+BvDeI+RpwpKaVfjfFnSPk1gKHHroFBy66lYrDjU
         t4/JXJC+5AP7DjkADaHrrFGsRrk5g1IA5tFam/mzkaKCVXARkfEw0wyreZiGsRdVhhzU
         jfPE1gwBZO2NynVCjFsrbUebjcc1Nmih09lF4Hx82bNJWOt4ca+lIMt3TqBl8iHRKEMo
         lUmStJo4i2/ugAnN/rdxgxWKt9mDeGueUuXUoMiC+qUMCm8AAUJJMRCl0JGN4oI3/6CD
         NO0g==
X-Gm-Message-State: AOJu0Yy/YP8hKilTMILikQTlwS7llISiVGKs4FSSDZkzwhqpDp/03ysG
	s2WlruVgrWFyCChetNzt2x9mnBdmV/rA0a+my/aIX+YApxBGGRIJabdDHDZp063LnP76ng==
X-Gm-Gg: Acq92OGKv3x/KJ9f/AL00CaIE4RgmoCzZHvQyFSFx4Fvu+19i8jyF1UGYhVmAUOt5c5
	IdSBHx00lUNJf2er11BaiRqh+if2sS9b7OOkGPmUKYAVOnGyPe0EXRRpsTk8/XqDt/leJpb2NKC
	SopgWq4cV9pldOJkKtEdOKEhG03GdGxeZzBdRELydIj7DBbd6hLUoi4aNBrIzUDkvwHrkkw3TW4
	5Z04r/PzXNTKBvHEcI8fQJBk3Y3HXFPMByTuBFIt74RUSS2vk+TBWQ/awe5FmT/DBUylERPTQF9
	sUAJnfIkxPRH9cMg+TvyN3mehQf3JAQf2okIxKt1+j7vyTfr5lnjEHZk0oN81CGKwoEwRyknDNI
	brHKW5X65eXIdsWAKzXDkui8QZMXz7kip+76FKZW4HXihK0F93zdrJlSgLfI4X5sUreCecIQtIS
	tZLqqORSDQkRObYJRd
X-Received: by 2002:a05:6a00:1ad3:b0:842:50fd:4c13 with SMTP id d2e1a72fcca58-84513e1750dmr2556028b3a.4.1781607302958;
        Tue, 16 Jun 2026 03:55:02 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b0112edsm11550889b3a.45.2026.06.16.03.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:55:02 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] net: airoha: Stop TX queues on error path in airoha_dev_open
Date: Tue, 16 Jun 2026 18:50:39 +0800
Message-ID: <178160729880.2156257.7978513589649053826@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

In airoha_dev_open(), if airoha_set_vip_for_gdm_port() fails after
netif_tx_start_all_queues() has been called, the TX queues remain
started while the device configuration is incomplete. This leaves
the device in an inconsistent state where packets could be
transmitted before the VIP/IFC port configuration is complete.

Add netif_tx_stop_all_queues() call on the error path to properly
roll back the TX queue state.

Fixes: 20bf7d07c956 ("net: airoha: add QDMA support for Airoha EN7581 Ethernet")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..cf9c366907 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1715,8 +1715,10 @@ static int airoha_dev_open(struct net_device *dev)
 
 	netif_tx_start_all_queues(dev);
 	err = airoha_set_vip_for_gdm_port(port, true);
-	if (err)
+	if (err) {
+		netif_tx_stop_all_queues(dev);
 		return err;
+	}
 
 	if (netdev_uses_dsa(dev))
 		airoha_fe_set(qdma->eth, REG_GDM_INGRESS_CFG(port->id),
-- 
2.51.0


