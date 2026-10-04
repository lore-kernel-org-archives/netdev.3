Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A013EFFC6
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 04:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791088027; cv=none; b=oUiIFfly6SSnuuaFjI3nKjnNkEo+DDWzqMLIJ5jcXJJJuUI1sci7nNcaWfJjr/pmOwm4F4EpaxqQ37fd9HVP8yRR5gBry2s9nK1WElNAC8gOetcfc2JbmvDAXS5mrFBcMhT1MqfHMW9LPt0xgwF0ZPKm4JJIEH74hhWWIpxAJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791088027; c=relaxed/simple;
	bh=UzB+W8GkiSnjNiEwgE3e6swB1W7HFwpILYFfQew3kLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBHgHhF7SpBSOs+CWgwwCqyZMjTZ4b24aZxGLkKZ0o+bGzywbq8wGyG6li6MwFv+0VF1gJxWOl0QrBzNyx6/3M8vH1J+S0PCwIr+TVV3t1EL/702OiFwQxr0ChcQF++/w8f1q6h7ED+zh5Hfl4ZZFWffYfC7LknVjHQwuWvHlxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hsAwVE70; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsAwVE70"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-534e6545939so5520291cf.3
        for <netdev@vger.kernel.org>; Sat, 03 Oct 2026 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791088025; x=1791692825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=abpir8BYL825hyvaRsoY2mSsbuMYUcaKMePmeAwHmvU=;
        b=hsAwVE7009iZAQmkLB7iYdPqA0PGq+S3uc0dl9IzhiVUfJ/WMSOOA4eXgWR5FqJfbJ
         5oeTxh7xyYWZOQdIRMIrgeVVKoNCO/yfFYCLQAEx1wgnMASID1Jfcsz0N/LWBef49Q/p
         f1xyn1PiRCIUgO6hwY324HPAxYfQ7W2O+YUUSmLbq4Dn0sbgYCfJ4OAZbbh+zkXJatQ7
         LDz3I+1fRdZVHfI4wUNqR4zh9HVFdqZ0HaNyUNwYTD2ogIvkYGB7ee05IB/g4zS1LGUD
         2JJPl55siYmbuaWE+o+NgXfsY5eezlYuwjIXNG6r777df7YFiCqWidNINrq3Ny6V9d+7
         5ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791088025; x=1791692825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abpir8BYL825hyvaRsoY2mSsbuMYUcaKMePmeAwHmvU=;
        b=XoNv9Lh7OfzwXyQNTb0ua7Udc3H4NkhUulqGMQlcFLYX2GjY0Cx8Rnckkejf96OG2W
         SNB8K5X6CskWY2cW5GGEBxLJQ/NjWXz4ts5sAuuLU2qTsBINVjCIn5qoP7jiE9sUGb4B
         z/crEbhEh8cOSNHi4L2iIuRS0bXTi7Bid/LsrLfdr8mWOjKlg2HAxn1TiYdQMF+TH4Ow
         qxPbvY42PieP2tWgNyp2hLX5ovLNR+DACtPXiL7RCoXTZNzn5AaKpMCPGXsnbrhDOJ1n
         PWd/gpJeyRFqZXXcudjP1/h69P68nOBMfQtP1s05WCvTO0MBCFimy34UCmWDKFKzuH4O
         9Ubg==
X-Gm-Message-State: AFuF++kxDw8fZjjfxvpf4kqRzRmacg4tpMLgSACpQEDY3QLwShnQMmAR
	ZzjA8L/8tjK4gvaLt+YjRAVkKcUmXMaLI8vqsLOvCKqlbEdNR4Th7tZOGMUXicM=
X-Gm-Gg: AYBFou2mDAnNruEwG5bTBWrpOw7QPjEwysznd18mJfp/W5wiBCKZAQTeSJlgOWY39sp
	DGzAk/BePOkGsDelPJ8oOhd7IikVUYa0PSBLkyzUme16UWJy5PjzzzMg+gu3aVudWwB7ld5SdhB
	YxXyDx4mIar4kJKkrwuBRRfXniM1fI5qXcFM88LFuZAAmZESgcXxtxYuREUAffAW6aCUN0NEQOX
	ccoMXwXFVSBWGawdOfE4nZY1WdDJ+DkfjBbFanCyA3LpkK15Q1LcjOiBYImE0URuene7cRzotNd
	k5Cr1Ji0uwmdO+FlOqe+aHE7hP6YTYeyPt/gNb1Re6jEveobKIsbaFEhprtYCSUrIGUOcAzK2Bx
	SCRhFPSRzjZEkDzxMOzWT6SNaAI3tMayG58lFBChPJwa6ImfEqUTUl/FxTTw273HclS/ouJ96ot
	P2iGKav2StBrIWJ0k96TV/YSdZFy4glhUlSfgRxdptebcxQ6FxbmLqd+GeQA/ei/8f6ihMeoDHg
	5zB8mSfuC3l/RsrLbS7XSprgQLPgZKDEBVvcCSJIu7iCuQDAlXk4on+egNNWU1nomXtFHW5TooL
	jzJRXvWilHMmOfFuTcNCnaCBBNXeDRowbqG4n7I=
X-Received: by 2002:ac8:5cc1:0:b0:535:1bf:6195 with SMTP id d75a77b69052e-53511d17715mr74684071cf.9.1791088024517;
        Sat, 03 Oct 2026 21:27:04 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533988343b5sm65291551cf.1.2026.10.03.21.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 21:27:03 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	ae878000@gmail.com
Subject: [PATCH net v2] net: nixge: stop IRQ producers before draining DMA error tasklet
Date: Sun,  4 Oct 2026 00:27:02 -0400
Message-ID: <20261004042702.1130389-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX and RX IRQ handlers can reschedule dma_err_tasklet after
tasklet_kill(), allowing it to access rings freed by nixge_stop().

Free both IRQs before killing the tasklet. Since pending recovery can
restart DMA, mask channel interrupts and wait for a DMA reset to finish
before releasing the rings. Clearing RUNSTOP alone does not ensure that
outstanding DMA accesses have completed.

If reset times out, retain the DMA buffers and reject subsequent opens
to prevent those buffers from being freed or their pointers overwritten.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Wait for DMA reset completion; retain buffers and reject reopen on timeout.

Based on net commit 6dc989ea46b96ce170840174b4a38c4a387fb005.
No hardware testing was performed.

 drivers/net/ethernet/ni/nixge.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff..878ca67 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -185,6 +185,7 @@ struct nixge_priv {
 	void __iomem *dma_regs;
 
 	struct tasklet_struct dma_err_tasklet;
+	bool dma_stop_failed;
 
 	int tx_irq;
 	int rx_irq;
@@ -391,7 +392,7 @@ out:
 	return -ENOMEM;
 }
 
-static void __nixge_device_reset(struct nixge_priv *priv, off_t offset)
+static int __nixge_device_reset(struct nixge_priv *priv, off_t offset)
 {
 	u32 status;
 	int err;
@@ -407,6 +408,8 @@ static void __nixge_device_reset(struct nixge_priv *priv, off_t offset)
 				     1000);
 	if (err)
 		netdev_err(priv->ndev, "%s: DMA reset timeout!\n", __func__);
+
+	return err;
 }
 
 static void nixge_device_reset(struct net_device *ndev)
@@ -869,6 +872,10 @@ static int nixge_open(struct net_device *ndev)
 	struct phy_device *phy;
 	int ret;
 
+	/* A failed stop retained buffers which DMA may still be using. */
+	if (priv->dma_stop_failed)
+		return -EIO;
+
 	nixge_device_reset(ndev);
 
 	phy = of_phy_connect(ndev, priv->phy_node,
@@ -911,6 +918,7 @@ static int nixge_stop(struct net_device *ndev)
 {
 	struct nixge_priv *priv = netdev_priv(ndev);
 	u32 cr;
+	int ret;
 
 	netif_stop_queue(ndev);
 	napi_disable(&priv->napi);
@@ -920,6 +928,7 @@ static int nixge_stop(struct net_device *ndev)
 		phy_disconnect(ndev->phydev);
 	}
 
+	/* Stop DMA while the completion IRQ handlers are still installed. */
 	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
 	nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
 			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
@@ -927,11 +936,29 @@ static int nixge_stop(struct net_device *ndev)
 	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
 			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
 
-	tasklet_kill(&priv->dma_err_tasklet);
-
+	/* Remove both producers before draining the error tasklet. */
 	free_irq(priv->tx_irq, ndev);
 	free_irq(priv->rx_irq, ndev);
 
+	tasklet_kill(&priv->dma_err_tasklet);
+
+	/* Error recovery may have restarted DMA and enabled interrupts. */
+	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
+	nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
+			    cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK));
+	cr = nixge_dma_read_reg(priv, XAXIDMA_TX_CR_OFFSET);
+	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
+			    cr & ~(XAXIDMA_CR_RUNSTOP_MASK | XAXIDMA_IRQ_ALL_MASK));
+
+	/* Either channel's reset quiesces the entire AXI DMA engine. */
+	ret = __nixge_device_reset(priv, XAXIDMA_TX_CR_OFFSET);
+	if (ret) {
+		/* Retain DMA buffers and prevent a subsequent open replacing them. */
+		priv->dma_stop_failed = true;
+		netdev_err(ndev, "DMA stop failed; retaining DMA buffers\n");
+		return ret;
+	}
+
 	nixge_hw_dma_bd_release(ndev);
 
 	return 0;
-- 
2.53.0

