Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39F4211A09
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367948; cv=none; b=HW3Gk+hS1eUjtlqbSrL/ZF8b84im6blVLSrGLK0TnKkko+QGb7b0TUfyK1gSQG9lF13Td9kl05LhzhdylBa06VmjNXvJaljTYZmoRgsWBymbBmZW5cn1n2I9SW1QhQLzpMLGuMWuSu7S4xXnKt+TqkUBG1jI+KyBI5Rq9q30Rf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367948; c=relaxed/simple;
	bh=uYXXrV7oSscJ5Nd+4n9xWTL4xDguLt2hrWucJg9Rh7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hd737bgsoavNId3aqSCA+LFUYSw3Tto6nRWJNbLm8TJkILJLpP6yXjnYSOLjTQeV9EjKwmSoxTD5JZT/wNF7hpoG3MDDoASllADu8YLhQXUVITvHIuAbDapRBxc2vmDq3nedpordl4oDJQAQfptzssG/kTJ6npcHER1+k2sqybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GH9D6vRA; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH9D6vRA"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1682135a91.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786367944; x=1786972744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+VW3i74IAPjVY0OS6V/IwE4IE06dAM439Do4xlSGaIc=;
        b=GH9D6vRAcuJkbrDvQh2rZSKtwaE8pMkavaDpIWbE4NzONZA69OxTXZ+mKvIppY/fFM
         TApLZvpOKQtLh9/jYB2ks8mxe6PmLIpblJxmCEFCeIOAO33L8gMwvrxFSHCgDl/U6Rj0
         4TjQ+CodsNqkMGd0Rl6DAQ7AZygOK55nYfg83gFzZHwnXUUdxaq+PxxRsTm2GbUJvUJK
         WB1C9cqJF4Q40VDUg4LkNSRodS6lwkzT9p+xufynpzG/z9SGac8vFkoiUYuEDGM6g6NM
         m92yHIFhz1DqW6/TQE8ey1qxJgPgXlAAAr/R3eNJgu6bYyX9IexEvzENG4bmWDdO0gzi
         3daQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786367944; x=1786972744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+VW3i74IAPjVY0OS6V/IwE4IE06dAM439Do4xlSGaIc=;
        b=jlpKPUqelubkuXHXYGZIvKKEBNFNC/4JHMof8rd4/Dj6OLW1dny0UdDxvvBmLFpiT5
         JyE4sk9Q3AXQUTveui3DTnR1NNSUN/2eaRnojhid9+Yhr+FXMgGisbiCqCBJTn7NoZt4
         OnUS8bemang4cOZAiBT/Cas3qgY5F5DXM0EcLKnwnd3nVJFe3gWEW02zDiW1whKauqVZ
         VsEg4tPJXgKi+z0QISkB4FIFVxkN0TC0s1MckpOZ6EVvrtoeXDgcItgALaxhxBkeq2mK
         NVp7NCBKXEjNmM6djGauePKlll8pi2JWQQFRmGX6aUUi8Nmn/XC9hjvrN+9Dc3/ATN8Q
         E3PQ==
X-Forwarded-Encrypted: i=1; AHgh+RohD2qOCNsOcR1M6HlpjZ6cy50b+0ypMSTMS5izwHwjs2wm1ri9/GyPyQhzWlQiMQ9DYEZzac8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypWgJonrRZsn41a08V4L4DedXJuRsQExZE77ao82oLU8XCDA9Q
	rOiuwlJTW+hxRUa+SBGiIxQ0fsYPhtTk7UU/0HXIkLUePnu2QyVJ26l0
X-Gm-Gg: AR+sD135BB/i/7+6utQFceObJinJk9UR7opvjqs9N9P4DbnApoX0jh34rao5nCx0GG6
	KUKy2zMcCCOidp0ohUyo8eD3TUWue3GUHkqqf6mw0qJ0O3uUJ9kE03HKsetmsBK/yEDCxk+H44u
	brfQU/bHE1hO+sI4R+VCK77WIawB/QhkSE5osh/XNdNl0O3U/BZrfPO1EOPcubis9OTvJnlc6Ge
	81WutFnemNXxR0GHnUkqPH9sNYufpCgYUnwNZalWSGm3oj4ymrY9bxpo7AkOPBmU+7mxA8BHcnN
	9wcXD8yj57KJSfm4fw/VbmvyOIrsAZMxHtHrajpkWXxcD02DDweut+0gNpAjj4tnIq7wQsXSnhm
	MhShpeUWEm4eIbGLFAMgL6rmpqT67QQQ68xJsyNj2u/JLHI6GypPeV7KX+4AC11Ci25mnFck8AP
	g8b4+ayBnd2PX2mrx2Fhwu7vkrFR8T09jLbeO4UCUKAFBZ8nO71kZbsuDdof1oTTpVrVOIA3avn
	MRGbg==
X-Received: by 2002:a17:90b:5251:b0:38e:4cb:51f with SMTP id 98e67ed59e1d1-3903c59212bmr44426513a91.11.1786367943952;
        Mon, 10 Aug 2026 06:19:03 -0700 (PDT)
Received: from localhost ([2402:e280:3e0d:544:91b3:77c4:f31d:d706])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm73961999eec.18.2026.08.10.06.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 06:19:03 -0700 (PDT)
From: Vaibhav Nagare <nagarevaibhav@gmail.com>
X-Google-Original-From: Vaibhav Nagare <vnagare@redhat.com>
To: horms@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: andrew+netdev@lunn.ch,
	matvey.kovalev@ispras.ru,
	Pavel.Zhigulin@kaspersky.com,
	aelior@marvell.com,
	manishc@marvell.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vaibhav Nagare <vnagare@redhat.com>
Subject: [PATCH net v4] qede: Fix NULL pointer dereference in TPA fragment processing
Date: Mon, 10 Aug 2026 18:48:59 +0530
Message-ID: <20260810131859.1870628-1-vnagare@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under memory pressure, the qede driver encounters NULL pointer
dereferences when processing TPA continuation fragments.

As identified by Jakub Kicinski, commit 8a8633978b84
("qede: Add build_skb() support.") accidentally dropped
the assignment of tpa_info->buffer.data in qede_tpa_start().

When memory pressure causes an SKB allocation failure in qede_tpa_start(),
the driver sets tpa_start_fail = true and attempts to recycle the physical
page later in qede_tpa_end(). However, because buffer.data was left
uninitialized (NULL), qede_reuse_page() pushes a "ghost"
page (valid mapping but NULL data pointer) back into the
active Rx ring. The next time the hardware uses this descriptor,
it passes a NULL page to qede_fill_frag_skb(), causing a kernel
panic.

Example crash from production system:
 BUG: unable to handle kernel NULL pointer dereference at 0x8
 RIP: qede_fill_frag_skb+0x96/0x430 [qede]
 Call Trace:
   qede_rx_int+0xb06/0x1de0
   qede_poll+0x2f4/0x6c0
   __napi_poll+0x2d/0x130

Observed on HPE Synergy 480 Gen11 running RHEL 8.10
(4.18.0-553.134.1.el8_10.x86_64), but the vulnerable code path
exists in mainline.

Fix the root cause by:
1. Restoring the tpa_info->buffer.data assignment in qede_tpa_start().
2. Reverting the error recovery block in qede_tpa_end() to rely on
   tpa_start_fail, which safely recycles the page without causing
   double DMA unmaps.

Additionally, harden the surrounding TPA flow:
3. Add NULL page validation in qede_fill_frag_skb() before dereferencing.
4. Correct bounds checking logic in TPA error loops (evaluating bounds
   before reading the array elements to prevent out-of-bounds reads).
5. Check error state early in qede_tpa_end() and qede_tpa_cont() before
   processing fragments.
6. Ensure NULL buffer descriptors are consumed rather than recycled, and
   correct buffer capacity tracking (rxq->filled_buffers--) to avoid
   Rx ring starvation.

Fixes: 8a8633978b84 ("qede: Add build_skb() support.")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
---
  v4: Fix err: label handling as identified by Jakub Kicinski:
    - Restored tpa_info->buffer.data assignment in qede_tpa_start(),
      which was dropped by commit 8a8633978b84
    - Reverted err: label in qede_tpa_end() to use tpa_start_fail flag
      instead of buffer.data check (ownership semantics)
    - Updated Fixes: tag to 8a8633978b84
    - Added Suggested-by: Jakub Kicinski
  v3: Addressed additional AI review feedback:
    - Fixed NULL pointer recycling in qede_tpa_cont() and qede_tpa_end()
    - Fixed array bounds check order in TPA error loops
    - Moved version notes after --- per Markus Elfring feedback
    - Resent as independent thread per netdev-bot feedback
  v2: Addressed AI review feedback from Simon Horman:
    - Added net_ratelimit() to prevent printk storm in NAPI fast path
    - Fixed NULL buffer recycling in qede_fill_frag_skb()
    - Added proper cleanup in qede_tpa_end() early exit path
  v1: https://lore.kernel.org/netdev/20260709044704.141507-1-vnagare@redhat.com/

 drivers/net/ethernet/qlogic/qede/qede_fp.c | 56 ++++++++++++++++++++--
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 33e18bb69774..bf0448b035b4 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -670,13 +670,23 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 							 NUM_RX_BDS_MAX];
 	struct qede_agg_info *tpa_info = &rxq->tpa_info[tpa_agg_index];
 	struct sk_buff *skb = tpa_info->skb;
+	struct page *page = current_bd->data;
 
 	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START))
 		goto out;
 
+	/* Avoid NULL pointer dereference when under severe memory pressure */
+	if (unlikely(!page)) {
+		if (net_ratelimit())
+			DP_NOTICE(edev,
+				  "Failed to allocate RX buffer for TPA agg %u\n",
+				  tpa_agg_index);
+		goto out;
+	}
+
 	/* Add one frag and update the appropriate fields in the skb */
 	skb_fill_page_desc(skb, tpa_info->frag_id++,
-			   current_bd->data,
+			   page,
 			   current_bd->page_offset + rxq->rx_headroom,
 			   len_on_bd);
 
@@ -684,7 +694,7 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 		/* Incr page ref count to reuse on allocation failure
 		 * so that it doesn't get freed while freeing SKB.
 		 */
-		page_ref_inc(current_bd->data);
+		page_ref_inc(page);
 		goto out;
 	}
 
@@ -698,8 +708,12 @@ static int qede_fill_frag_skb(struct qede_dev *edev,
 
 out:
 	tpa_info->state = QEDE_AGG_STATE_ERROR;
-	qede_recycle_rx_bd_ring(rxq, 1);
-
+	if (current_bd->data) {
+		qede_recycle_rx_bd_ring(rxq, 1);
+	} else {
+		qede_rx_bd_ring_consume(rxq);
+		rxq->filled_buffers--;
+	}
 	return -ENOMEM;
 }
 
@@ -845,7 +859,7 @@ static void qede_tpa_start(struct qede_dev *edev,
 					      pad, false);
 	tpa_info->buffer.page_offset = sw_rx_data_cons->page_offset;
 	tpa_info->buffer.mapping = sw_rx_data_cons->mapping;
-
+	tpa_info->buffer.data = sw_rx_data_cons->data;
 	if (unlikely(!tpa_info->skb)) {
 		DP_NOTICE(edev, "Failed to allocate SKB for gro\n");
 
@@ -959,8 +973,24 @@ static inline void qede_tpa_cont(struct qede_dev *edev,
 				 struct qede_rx_queue *rxq,
 				 struct eth_fast_path_rx_tpa_cont_cqe *cqe)
 {
+	struct qede_agg_info *tpa_info = &rxq->tpa_info[cqe->tpa_agg_index];
 	int i;
 
+	/* Don't process fragments if TPA start failed */
+	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START)) {
+		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++) {
+			struct sw_rx_data *rx_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
+								NUM_RX_BDS_MAX];
+				if (likely(rx_bd->data)) {
+					qede_recycle_rx_bd_ring(rxq, 1);
+				} else {
+					qede_rx_bd_ring_consume(rxq);
+					rxq->filled_buffers--;
+				}
+		}
+		return;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
 		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
 				   le16_to_cpu(cqe->len_list[i]));
@@ -986,6 +1016,22 @@ static int qede_tpa_end(struct qede_dev *edev,
 		dma_unmap_page(rxq->dev, tpa_info->buffer.mapping,
 			       PAGE_SIZE, rxq->data_direction);
 
+	/* Drop the packet if TPA start failed */
+	if (unlikely(tpa_info->state != QEDE_AGG_STATE_START || !skb)) {
+		/* Recycle BDs from cqe->len_list to keep ring synchronized */
+		for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++) {
+			struct sw_rx_data *rx_bd = &rxq->sw_rx_ring[rxq->sw_rx_cons &
+								NUM_RX_BDS_MAX];
+			if (likely(rx_bd->data)) {
+				qede_recycle_rx_bd_ring(rxq, 1);
+			} else {
+				qede_rx_bd_ring_consume(rxq);
+				rxq->filled_buffers--;
+			}
+		}
+		goto err;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(cqe->len_list) && cqe->len_list[i]; i++)
 		qede_fill_frag_skb(edev, rxq, cqe->tpa_agg_index,
 				   le16_to_cpu(cqe->len_list[i]));
-- 
2.54.0

