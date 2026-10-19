Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443978;
	b=Nhc3Va78eRuo3zaHHzeVz2004ZyaPKbxsBt+5Jrwd/u/SzH1k4gESm3eQNj2LoyjBT+5
	 37ByGSthU3GIio38fQW1IvQGLOUTEC+X5oBGCFZZRQ1YW89OJm6bqJp7LSm0ZbLmwz/If
	 SOExfJG2fBadhEOCBBFiUk3ROb2Dr4kJWX8jJLJFyQf1xWRKx4cF/HHpRC8HnNvraPtNz
	 g9FFhIdvWz21EOB4rRKFrZaNWg3EmPCB8zp59mH+w9X7Wsi+9ZnF5GvNCOckb6UHdMseh
	 frz78SYEqpER2Bri4ALm88zoN0iPfT/BfakM8P5ZIZWAobfC5v89SjG+CUEBgu3XIow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=XfnY0DQvDrTEPobKWSGpJJKZhuCHUJe4OK2P9eZsJs4=;
	b=Co34ZeESspkjrC1BWfpOzsPbxMlpfF0HB5T2Dul43Pc5w1DYf0aKKo/2KQGE6KiGwapf
	 0G4vMixW5xUc94pM47ohAgzLNS1LfXZki4DtuZuuY6poXxLxC8hIydPzFKfL2/Am7OwM1
	 hQLFGocq5WItQ8rHc4U4/oH75D6bwDoc4mm5zU3ahML5lRSeAGJPqlH2nsCLxoCPDR7eV
	 1Dq58xZJALAAwOvhM1ncOWuejq8nDQ3mBKe0/ANscRcjFkDFoD+mRAkRD+KP+pis7l0+R
	 R0gt7TaGSOcclXVPkWfgK93KOq8jWRe3jNYt78Uk8GykcdyG+V9tNXMFQLSQXn1/HNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UyUvBKL+;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEF4606A339
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 21:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCEF4606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UyUvBKL+
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c41e4057335so261300766b.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792443976; x=1793048776; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfnY0DQvDrTEPobKWSGpJJKZhuCHUJe4OK2P9eZsJs4=;
        b=UyUvBKL+MWBHZkm2e4qbWBwRS4IK+4JYcUiwyVAQtFFoCAQVJ3ODW92aoAnq9zf4mE
         nt4ZOukv+81pVtKG2e3z42YLEHnXkn/MhOMK7h3zu3mL2DO/uKfY19lv7W4Xxr41Q+tm
         2mrj5L8dG/ncdNYIRE+WzzXQvIzNAIMRe4uTPG4P9lKMtrZDz9hHZZxmyXDhdwGDRBsU
         gtw5Lqb0kjS8KsDIaql6YfQWbMrh1h6XOBfZrEeKCnYIvIAPSU9C7JfFBFs4AmtCcDnZ
         inRQTvlo8aHfiBrTDaknK4tl7E5R9VsWB/LFdaW02f5azpu28xPysiQ71ain4X+QqfsC
         zn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792443976; x=1793048776;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XfnY0DQvDrTEPobKWSGpJJKZhuCHUJe4OK2P9eZsJs4=;
        b=hNgHW9N9ZJQJ81VeHE8xz4xzT+Wd4BMGLtigf4NCWtq7fWEV7fGDyZhvHguzttsSXO
         DN7lzCktP6qlKrLkpjry/70u1kJEFjsH/VRb3V6DKwCHTH1IH7MZ8qbToJk/GdZW+1Xd
         8UlcY3MQfS0AhfprFWn4v4iCXQZKDcke27Sd370zIpneR5UrvMg1oTZxwn4vO24RfgAm
         1rxGg5LPRb7mUQ/P7Kp80FPgTZZyh87Lntv8SZyJQVRJpyOEUAjft/6pkvaaiJTJ6ANb
         pl8NsQGA6Y4jL9ED9XbCza5xrE1knNu6c6ATCqncUWOBKTEt1PJHB8H1dzOyhmP7d1fW
         orVg==
X-Gm-Message-State: AFq9FYIq5JkRZFfrLkIJDhCQe2Qns1oFLb19oWd29C1zRJ5bnxvHLnXs
	wEpTA/qDUtxvk1tLRhahNIjhAThrl+m9tmy9QbROPJruQl4g1j+jjgWFUPxc1O3kZpNTcuXiTB9
	sYWPmsA==
X-Received: from ejcfp43.prod.google.com ([2002:a17:906:9e2b:b0:c2e:5a25:5773])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:e1c5:20b0:c41:c718:f5c5
 with SMTP id a640c23a62f3a-c41c71926e4mr380398466b.13.1792443976050; Mon, 19
 Oct 2026 14:06:16 -0700 (PDT)
Date: Mon, 19 Oct 2026 21:06:04 +0000
In-Reply-To: <20261019210604.2433620-1-lrizzo@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261019210604.2433620-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261019210604.2433620-3-lrizzo@google.com>
Subject: [PATCH iwl-next v2 2/2] idpf: use GFP_KERNEL for the initial Rx ring fill
From: Luigi Rizzo <lrizzo@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Luigi Rizzo <rizzo.unipi@gmail.com>, Brian Vazquez <brianvv@google.com>, 
	Joshua Hay <joshua.a.hay@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

When idpf fills its Rx rings at open or on queue reconfiguration, the
allocation runs in process context, right after page_pool_create() and
before the queues' NAPI is enabled. Allocating tens of thousands of
buffers across all queues with GFP_ATOMIC is needlessly restrictive
when the caller may sleep.

In splitq mode, idpf_rx_post_buf_desc() is only used for this initial
fill, so switch its header and payload allocations to
libeth_rx_alloc_gfp(..., GFP_KERNEL).

In singleq mode, add a gfp_t parameter to
idpf_rx_singleq_buf_hw_alloc_all() and pass GFP_KERNEL from
idpf_rx_buf_alloc_singleq() and GFP_ATOMIC from idpf_rx_singleq_clean().

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 7 ++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 9 ++++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h         | 2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index e3ddf18dcbf51..d623e4ab8511f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -885,11 +885,12 @@ static void idpf_rx_buf_hw_update(struct idpf_rx_queue *rxq, u32 val)
  * idpf_rx_singleq_buf_hw_alloc_all - Replace used receive buffers
  * @rx_q: queue for which the hw buffers are allocated
  * @cleaned_count: number of buffers to replace
+ * @gfp: GFP_KERNEL for the initial fill, GFP_ATOMIC from NAPI
  *
  * Returns false if all allocations were successful, true if any fail
  */
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
-				      u16 cleaned_count)
+				      u16 cleaned_count, gfp_t gfp)
 {
 	struct virtchnl2_singleq_rx_buf_desc *desc;
 	const struct libeth_fq_fp fq = {
@@ -908,7 +909,7 @@ bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rx_q,
 	do {
 		dma_addr_t addr;
 
-		addr = libeth_rx_alloc(&fq, nta);
+		addr = libeth_rx_alloc_gfp(&fq, nta, gfp);
 		if (addr == DMA_MAPPING_ERROR)
 			break;
 
@@ -1095,7 +1096,7 @@ static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 
 	page_pool_nid_changed(rx_q->pp, numa_mem_id());
 	if (cleaned_count)
-		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count);
+		idpf_rx_singleq_buf_hw_alloc_all(rx_q, cleaned_count, GFP_ATOMIC);
 
 	u64_stats_update_begin(&rx_q->stats_sync);
 	u64_stats_add(&rx_q->q_stats.packets, rs.packets);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4311ffa30bb18..b1127ab48ef3f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -600,6 +600,9 @@ static void idpf_post_buf_refill(struct idpf_sw_queue *refillq, u16 buf_id)
  * @bufq: buffer queue to post to
  * @buf_id: buffer id to post
  *
+ * Only used for the initial fill, from process context, so it allocates
+ * with GFP_KERNEL.
+ *
  * Return: %false if buffer could not be allocated, %true otherwise.
  */
 static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
@@ -618,7 +621,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 		fq.fqes = bufq->hdr_buf;
 		fq.truesize = bufq->hdr_truesize;
 
-		addr = libeth_rx_alloc(&fq, buf_id);
+		addr = libeth_rx_alloc_gfp(&fq, buf_id, GFP_KERNEL);
 		if (addr == DMA_MAPPING_ERROR)
 			return false;
 
@@ -629,7 +632,7 @@ static bool idpf_rx_post_buf_desc(struct idpf_buf_queue *bufq, u16 buf_id)
 	fq.fqes = bufq->buf;
 	fq.truesize = bufq->truesize;
 
-	addr = libeth_rx_alloc(&fq, buf_id);
+	addr = libeth_rx_alloc_gfp(&fq, buf_id, GFP_KERNEL);
 	if (addr == DMA_MAPPING_ERROR)
 		return false;
 
@@ -675,7 +678,7 @@ static bool idpf_rx_post_init_bufs(struct idpf_buf_queue *bufq,
  */
 static int idpf_rx_buf_alloc_singleq(struct idpf_rx_queue *rxq)
 {
-	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1))
+	if (idpf_rx_singleq_buf_hw_alloc_all(rxq, rxq->desc_count - 1, GFP_KERNEL))
 		goto err;
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 93547597efd2a..e27438c78ec79 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -1123,7 +1123,7 @@ netdev_tx_t idpf_tx_singleq_frame(struct sk_buff *skb,
 				  struct idpf_tx_queue *tx_q);
 netdev_tx_t idpf_tx_start(struct sk_buff *skb, struct net_device *netdev);
 bool idpf_rx_singleq_buf_hw_alloc_all(struct idpf_rx_queue *rxq,
-				      u16 cleaned_count);
+				      u16 cleaned_count, gfp_t gfp);
 bool idpf_rx_process_skb_fields(struct sk_buff *skb,
 				const struct libeth_xdp_buff *xdp,
 				struct libeth_rq_napi_stats *rs);
-- 
2.56.0.212.g129ede20d9-goog

