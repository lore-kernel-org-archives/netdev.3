Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47332D97BA
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 04:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787112579; cv=none; b=sdGFTIqGtQqImC+KCAWfqx2j3nlZxQB5Uc4YVxOGA3++XdcYrkagBQ+Lsxs3cIdnBgKyp9YNyzy9jlqcWfSPzlxybd83gNo0DdW6BNA6u1q9OsJ2+CHlW3mQCUozoZ/UaMZjRhwbxxZpZHKRhby6nqDudcDytPTFvysVt2mHtM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787112579; c=relaxed/simple;
	bh=6Y9pvYAMVdWjnvCDxgEQOFKJ3MefUW7wF3C+fjgqrao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RAGZl8gjtxGPamXsyqe7Au/RsXoeS6IeAzmafuhvZBbRMhOa5G3yaUPB8d0CE/xWmxLAN7hEFPOZf9vGicoZwJ1DTHkqRYhkdkmv/XyBasqvlRX9KLczg5pwzolPN6HBoMxR7Tv9t5btCh4mO8ewY00Ce+7Ab3/gzHDgWqpV+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bN/L5yY+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bN/L5yY+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso1021857a91.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 21:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787112577; x=1787717377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RW6fl6IuFJo9pUwsC4YyObT1+Lda4WOCod4aNBdqDik=;
        b=bN/L5yY+Nw2DV3IX/xhMYbYfRYZDEcU7v1OHkiq+CAxJnL6gqZ6rLZAjhBxD3dJEag
         ysKrxpmw7rBksttcxVFMs3QA/VsXNOps4EKhKDgWgg6rUR2n7BC5nY9ovWVxDPLkILlu
         13AVbA0KKDakkK1ulSCTChSRyAkyRJVj1tC3cQaELTXy+mdEjIfSPZKK1rVQfXn/Q/E9
         H3MVoE9COEQGgv+q8oUswi7e7QJBdqNTqrbuU8hMzZG1JvD9olthPl+58FaYhS7rEeF1
         4WsPsEoyONZ8qagV4/Ji6FgsPTsz+b9tim4TDl6mGfMf7KDJC3kgbBfAYCZRtvOCoB6B
         meOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787112577; x=1787717377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RW6fl6IuFJo9pUwsC4YyObT1+Lda4WOCod4aNBdqDik=;
        b=cuTewdxxjcdNUSWwNNYtEi5GvwCmWBpBTMAQbLsDlu7gnqWjMg4lyKEgSk7ZTDn5Rf
         1LF+P69xHWNS01+c3LGUPeGrtXSIHUF98TF5xKNIHFxCw05fgkqjBKMI7FiQ1ECNfhhI
         ulxC5BNXsIXa/B01HYeiGLir+oMciixMl+k8zckFG4/eqNvnaKpw+102Tyl2h7qgryCU
         GtBZB/Q9QTRsBDcUCTZ62rCoWsBe5ttOD5Pk4eaYzb0tiftoDLIgbvm5rtPbjsxa3OJ9
         etoiFKMArjG/pSaUQD5GA2fb5OWGOOFUip1vqxxtLJGkECpQZCwYx+MIIYMNBbFCJ4+P
         xIhA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1sMdMsRCooI3dM5NxevZrHtaOxH+3g1FbT9XKCy+rLJekZsVIgbKqJrr07WGWVj3pLfCbK5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv2HLq9+JUiBJqkL6B7LBG+WFZW/fkg1NV1VVDVZ9OFfwW8CXn
	83zWdX3obw3vYV64OE+Af0zi00U3QOEuLCZexLK5A6+WsV+SmNV8t4Wb
X-Gm-Gg: AR+sD13OtByPs/Pqhs6rhKeK8JlONBPmgW1IQ21pR4juMAUTtjBmpuL8s/Dif1rnlxJ
	rVhWUBzgiA7rBm3Iymf10ZTJLhWjcCGq5wsO5tX4VqE6zXFFTOzlDwtAgagL38y3aHcoKTj9/8t
	cE3FCFjkvY8oFtweiuVOEGZjnNx2wiY8bfesSb/T5LFgA6BM42p/IOW3c7SHcpS/NsGyoWxyWAG
	WwA7/TxWWAM5ABVlPPtCavUBSeRvCeKGt6+1HdnHYfKxDYYuJjBOg9ukaTiNXiK7OjcZe4cTGzt
	F07jN+r61GSQXBXHbJdcNZVH7NYxC0/Bwk1Cpgrgugdi9FR3aLdLR6gWxU52GMy/2VZ5VsLXkvG
	yZ87fcr3QnvpaNTNEoeFKoVXiGOm7Fq5MLMTzQzm8TYrPo4cnGrsAQa5t6XoeiaUVWknMBSt2gB
	BvYS3GrFOcVnTlGswVVnPHhKwvowbfThm1w5TV+wC1kzz5E0CPaqPtu4m5u6M5hX7RNd27CQ==
X-Received: by 2002:a17:90b:4fd0:b0:390:b41a:b92b with SMTP id 98e67ed59e1d1-39580a53469mr3502694a91.4.1787112576971;
        Tue, 18 Aug 2026 21:09:36 -0700 (PDT)
Received: from c79home.localdomain ([14.154.28.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fc00b22sm351907a91.3.2026.08.18.21.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 21:09:36 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH net-next] net: macb: fix CONFIG_OF=n build
Date: Wed, 19 Aug 2026 12:09:13 +0800
Message-Id: <20260819040913.109367-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macb_alloc_tieoff() and macb_free_tieoff() are called from macb_probe()
and macb_remove(), which are built regardless of CONFIG_OF.

The helpers were added inside the CONFIG_OF block, although the tieoff
descriptor handling does not depend on OF. This breaks CONFIG_OF=n builds
with implicit function declaration errors.

Move the helpers outside the CONFIG_OF block.

Fixes: 5262eab9462a ("net: macb: allocate tieoff descriptor once across device lifetime")
Signed-off-by: Zhixing Chen <running910@gmail.com>
---

I hit this while building the latest net-next tree with my local config,
where CONFIG_MACB is enabled and CONFIG_OF is disabled.

Since CONFIG_MACB does not depend on CONFIG_OF, macb_main.c still needs
to build in this configuration. However, macb_probe() and macb_remove()
are built while macb_alloc_tieoff() and macb_free_tieoff() are hidden
behind CONFIG_OF.

Build error:

drivers/net/ethernet/cadence/macb_main.c: In function 'macb_probe':
drivers/net/ethernet/cadence/macb_main.c:5951:15: error: implicit declaration of function 'macb_alloc_tieoff' [-Werror=implicit-function-declaration]
 5951 |         err = macb_alloc_tieoff(bp);
drivers/net/ethernet/cadence/macb_main.c:5973:9: error: implicit declaration of function 'macb_free_tieoff' [-Werror=implicit-function-declaration]
 5973 |         macb_free_tieoff(bp);
  CC [M]  drivers/gpu/drm/i915/display/intel_qp_tables.o

---
 drivers/net/ethernet/cadence/macb_main.c | 64 ++++++++++++------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1476bce77f34..c7e3b630b49e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5507,38 +5507,6 @@ static int eyeq5_init(struct platform_device *pdev)
 	return ret;
 }
 
-static int macb_alloc_tieoff(struct macb *bp)
-{
-	/* Tieoff is a workaround in case HW cannot disable queues, for PM. */
-	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
-		return 0;
-
-	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
-						macb_dma_desc_get_size(bp),
-						&bp->rx_ring_tieoff_dma,
-						GFP_KERNEL);
-	if (!bp->rx_ring_tieoff)
-		return -ENOMEM;
-
-	macb_set_addr(bp, bp->rx_ring_tieoff,
-		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
-
-	bp->rx_ring_tieoff->ctrl = 0;
-
-	return 0;
-}
-
-static void macb_free_tieoff(struct macb *bp)
-{
-	if (!bp->rx_ring_tieoff)
-		return;
-
-	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
-			  bp->rx_ring_tieoff,
-			  bp->rx_ring_tieoff_dma);
-	bp->rx_ring_tieoff = NULL;
-}
-
 static const struct macb_usrio_config mpfs_usrio = {
 	.tsu_source = 0,
 };
@@ -5756,6 +5724,38 @@ static const struct of_device_id macb_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, macb_dt_ids);
 #endif /* CONFIG_OF */
 
+static int macb_alloc_tieoff(struct macb *bp)
+{
+	/* Tieoff is a workaround in case HW cannot disable queues, for PM. */
+	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
+		return 0;
+
+	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
+						macb_dma_desc_get_size(bp),
+						&bp->rx_ring_tieoff_dma,
+						GFP_KERNEL);
+	if (!bp->rx_ring_tieoff)
+		return -ENOMEM;
+
+	macb_set_addr(bp, bp->rx_ring_tieoff,
+		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
+
+	bp->rx_ring_tieoff->ctrl = 0;
+
+	return 0;
+}
+
+static void macb_free_tieoff(struct macb *bp)
+{
+	if (!bp->rx_ring_tieoff)
+		return;
+
+	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+			  bp->rx_ring_tieoff,
+			  bp->rx_ring_tieoff_dma);
+	bp->rx_ring_tieoff = NULL;
+}
+
 static const struct macb_config default_gem_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
 		MACB_CAPS_JUMBO |

base-commit: 61eb236c41c2a4717015dff18016a75a5eb90052
-- 
2.34.1

