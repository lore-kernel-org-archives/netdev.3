Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9E364055
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771001936; cv=none; b=Tv14/mslEkzLQ//zvs8CPM7mwPcYTSv9+QcFTlbQCoDr6Nfo60qrhW3OOH1eAq0pfx9JDG545LZeZ75lbRY3VxjM76MPL5wHA+lL/umJ7DUoqB+bAGa7D3YSN/m3FPfQnxH2UComttqEU0lfh2nO87YTE8xA/zXrYSNjFwHvA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771001936; c=relaxed/simple;
	bh=HW9OjYS3TDwmbSTFjz+CpXYzkTbusYrZ6ob/Eyrw4KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCk55kJ/EO9QW5F9ahR6P0HLr4980aV0J5PEph6RUGMTFcMGL3O8EROkpYfrJOq6ZTFK5ckCxoy8MUaWkfmOLyn89HOgsfBFwG/BS1Dgr+j1ZPPsVr3gghjbgwI+y1koozqPUS4tvv+lIl+QsegluzkbTvG2KqyXjj3VqenFxD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wWAXz2/0; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wWAXz2/0"
Received: from smtpout-01.galae.net (unknown [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6C4D4C1E4A2;
	Fri, 13 Feb 2026 16:58:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AEEF6606BE;
	Fri, 13 Feb 2026 16:58:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D303310368EB1;
	Fri, 13 Feb 2026 17:58:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771001916; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JVjUTf4NRhSxI/gJMo3Ok54wjpnF9Jou6i2VhBSwvcc=;
	b=wWAXz2/0Qx2DhZv+YzLaCb2nMY+ftoQ/T+tD2dtcFCX0O348Bn6Rhh+ZS03Rsg2Fez6fsx
	N97WKxhbe1N7yaOSgR0LkdF0GwM8dHQ0Seb6X6m8Mp0iAvwnIasKrb63E69d9A73XuGAQl
	6g3E5wpm8HKGsmRVH77JS+mPSpt7iRuBbiWcT3P1FwQyYVbH9jtZlwztj9RUKJy6yJ/RkC
	K0GShdsFlIbLSzofjdAvUyCHcnsaRRyaPaHtpO0zRZ2x6kbHGtTIyQZ7WnVaVXtJW130dr
	aCbR+iNFfWVzO1uOrSHrkkz5dqZN49V6ithGON/LUI0JfKsFljwxHr5L9S3DKw==
From: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
To: theo.lebrun@bootlin.com
Cc: andrew+netdev@lunn.ch,
	claudiu.beznea@tuxon.dev,
	davem@davemloft.net,
	edumazet@google.com,
	gregory.clement@bootlin.com,
	kuba@kernel.org,
	lorenzo@kernel.org,
	netdev@vger.kernel.org,
	nicolas.ferre@microchip.com,
	pabeni@redhat.com,
	pvalerio@redhat.com,
	thomas.petazzoni@bootlin.com
Subject: [PATCH 3/6] net: macb: always use DMA_BIDIRECTIONAL on page pool buffers
Date: Fri, 13 Feb 2026 17:57:56 +0100
Message-ID: <20260213165759.225449-3-theo.lebrun@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213165759.225449-1-theo.lebrun@bootlin.com>
References: <DG4MBFXG7GGG.3GFLWBUKH087T@bootlin.com>
 <20260213165759.225449-1-theo.lebrun@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Creating a page pool on open requires knowing the DMA direction. We want
BIDI if an XDP program is loaded (because it might modify and XDP_TX the
buffer) and only need FROM_DEVICE otherwise.

However, we do not reopen on .ndo_bpf() to load an XDP program. This
means the DMA direction might be wrong. Options:
 - Reopen on XDP program load if no program was loaded before.
 - Always use BIDI.

Option 2 shows no reproducible performance costs on my target. It
implies an additional dma_sync_single_for_device() when page pool
buffers are recycled; see __page_pool_put_page().

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 918eee5c8a5b..05bbbaf260ce 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -1582,7 +1582,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		dma_sync_single_for_cpu(&bp->pdev->dev,
 					addr, bp->rx_buffer_size,
-					page_pool_get_dma_dir(queue->page_pool));
+					DMA_BIDIRECTIONAL);
 		/* Ensure ctrl is at least as up-to-date as rxused */
 		dma_rmb();
 
@@ -2867,9 +2867,7 @@ static int gem_create_page_pool(struct macb_queue *queue, int qid)
 		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
 		.pool_size = queue->bp->rx_ring_size,
 		.nid = NUMA_NO_NODE,
-		.dma_dir = rcu_access_pointer(queue->bp->prog)
-				? DMA_BIDIRECTIONAL
-				: DMA_FROM_DEVICE,
+		.dma_dir = DMA_BIDIRECTIONAL,
 		.dev = &queue->bp->pdev->dev,
 		.napi = &queue->napi_rx,
 		.max_len = PAGE_SIZE,
-- 
2.53.0

