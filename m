Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7238552F;
	Thu, 29 Jan 2026 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684567; cv=none; b=VG3Zf6feK/zUGx2qsqOFHMNa7F5QwkZLcTm4iFELStYaIcKAasFwt0FpNYgdrQSdbNcgQKzgO0ush+4PVxVOMTxxK36lYYUImw1vqpgeA5F/o2FC2JYfgQIpN1hnWwFzXLkFvomEgrLWufpjLhoCZF08p9WTBrXsLCPuCTVFBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684567; c=relaxed/simple;
	bh=Ly9xvhNWP+BElw1tvbuTB2q+sscQXyQnfqIcmzbVFc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mR00OeaMg94spUgDC4zz0w2oSW+1k3jELH57d5EjIa8yqJpzDdn6rR6sfbL9KX/yC+88CxRo4Dms7D/DGdd+ESzjVOOfMkSR5xMGqGxcaNLIj5RDD8rE/atd2yZldr2oGk3l5uKs31EMmomA7FisBxhp01BXsz9gCDfOw3K5udI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=yYWvFd+L; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=DHUnDg78; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yYWvFd+L";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DHUnDg78"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f1x7S33J3z9srX;
	Thu, 29 Jan 2026 12:02:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769684564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Updstyxzh8PPxICNMPd/pdSh8qmMSzexL8/c9NNXGkQ=;
	b=yYWvFd+LS9if5YLYwWH8dax568/z/RWrMJBzU6GHZcGjfNZslPXwFM0it+gx5OxBZhhnSP
	KZa/IGlXOV2pK7MeSmY4CiWd4lsFQwm+AS/LRdTTmKeM354i2q0Q5vcujs69UbR6McJyGT
	JCktgpKtC+U3mMCodZ7Hi9Os23IU1E2Hcw07MfenCv061/OkTdGroXG0TJtQY042emJVv4
	yDKOJjhRFs71f1jA6raPSfRhsIr7kR4kNSF5ppPCBoh144m4HArUtRp2MaeUCTRp4zAynn
	325zllpH9CE+9UMp/FlRFqVYuUZ5KiEIEf8GypGOp0o4QI76crMhX0H6/MzABw==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769684562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Updstyxzh8PPxICNMPd/pdSh8qmMSzexL8/c9NNXGkQ=;
	b=DHUnDg78rfdpoGXUXHD0NiTyY6Z7F/2VIRMNBR9pjikVhSUj2PyHn0W/yv67pCQqU0AlWH
	GiNPafz/vN7jLRFOBvFddx3JMFFP+hgkmFiMyrfZM8ESwh4vsyxwT/+bBrcXddLs2A/UTx
	oXf8eCX20jBQbvv6Dkjrll2oibqiXNLzBDMslClC+jyOROdNSRMwzERntI7fmuGfhO3rCp
	jOw2k+fnMoao80z2Rj2Ny8/vRPKaiOhjc2rclKOIABtexbG1Sse0haV2ZfJEC2zpglbxzT
	skePcBLU+nLig3o4jDgjJVmgDLO9f9BQTr8W1Zmyy9EBEKV1SXsUEAxq/2KXPg==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v21 3/7] net: mtip: Add buffers management functions to the L2 switch driver
Date: Thu, 29 Jan 2026 12:01:50 +0100
Message-Id: <20260129110154.1699976-4-lukasz.majewski@mailbox.org>
In-Reply-To: <20260129110154.1699976-1-lukasz.majewski@mailbox.org>
References: <20260129110154.1699976-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a73103908f63cfdfca7
X-MBO-RS-META: 1wtzgnrmrc11qhhxdt56g9mostoku19c

This patch provides buffers management funcions' content for MTIP
L2 switch.

Signed-off-by: Lukasz Majewski <lukasz.majewski@mailbox.org>
---
Changes for v14:
- New patch - created by excluding some code from large (i.e. v13
  and earlier) MTIP driver

Changes for v15 - v20:
- None

Changes for v21:
- Add check if fep->page[i] is not NULL before returning it to page pool
---
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 88 +++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
index 7b61ba9642e3..e242f6b90068 100644
--- a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
+++ b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
@@ -888,11 +888,99 @@ static void mtip_get_drvinfo(struct net_device *dev,
 
 static void mtip_free_buffers(struct net_device *dev)
 {
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	int i;
+
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		if (!fep->page[i])
+			continue;
+
+		page_pool_put_full_page(fep->page_pool,
+					fep->page[i], false);
+		fep->page[i] = NULL;
+	}
+
+	page_pool_destroy(fep->page_pool);
+	fep->page_pool = NULL;
+
+	for (i = 0; i < TX_RING_SIZE; i++)
+		kfree(fep->tx_bounce[i]);
+}
+
+static int mtip_create_page_pool(struct switch_enet_private *fep, int size)
+{
+	struct page_pool_params pp_params = {
+		.order = 0,
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = size,
+		.nid = dev_to_node(&fep->pdev->dev),
+		.dev = &fep->pdev->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = 0,
+		.max_len = MTIP_SWITCH_RX_FRSIZE,
+	};
+	int ret = 0;
+
+	fep->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(fep->page_pool)) {
+		ret = PTR_ERR(fep->page_pool);
+		fep->page_pool = NULL;
+	}
+
+	return ret;
 }
 
 static int mtip_alloc_buffers(struct net_device *dev)
 {
+	struct mtip_ndev_priv *priv = netdev_priv(dev);
+	struct switch_enet_private *fep = priv->fep;
+	struct cbd_t *bdp;
+	struct page *page;
+	int i, ret;
+
+	ret = mtip_create_page_pool(fep, RX_RING_SIZE);
+	if (ret < 0) {
+		dev_err(&fep->pdev->dev, "Failed to create page pool\n");
+		return ret;
+	}
+
+	bdp = fep->rx_bd_base;
+	for (i = 0; i < RX_RING_SIZE; i++) {
+		page = page_pool_dev_alloc_pages(fep->page_pool);
+		if (!page) {
+			dev_err(&fep->pdev->dev,
+				"Failed to allocate page for rx buffer\n");
+			goto err;
+		}
+
+		bdp->cbd_bufaddr = page_pool_get_dma_addr(page);
+		fep->page[i] = page;
+
+		bdp->cbd_sc = BD_ENET_RX_EMPTY;
+		bdp++;
+	}
+
+	mtip_set_last_buf_to_wrap(bdp);
+
+	bdp = fep->tx_bd_base;
+	for (i = 0; i < TX_RING_SIZE; i++) {
+		fep->tx_bounce[i] = kmalloc(MTIP_SWITCH_TX_FRSIZE, GFP_KERNEL);
+		if (!fep->tx_bounce[i])
+			goto err;
+
+		bdp->cbd_sc = 0;
+		bdp->cbd_bufaddr = 0;
+		bdp++;
+	}
+
+	mtip_set_last_buf_to_wrap(bdp);
+
 	return 0;
+
+ err:
+	mtip_free_buffers(dev);
+	return -ENOMEM;
 }
 
 static int mtip_rx_napi(struct napi_struct *napi, int budget)
-- 
2.39.5

