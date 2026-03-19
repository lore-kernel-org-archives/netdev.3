Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270171FF5E3
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773940623; cv=none; b=Woh0dgaxufD5pCtgk/5Z1UvGkQ+ZZ+6dF8oQ/DaW/1F0YJlcnShUb3I8nc/HJ847L0IORoOqEHJPe/RGbbYLf9aNPlzGvcoZi8nZbssOmF1wtuWT7SsdMPT2PpmxWE1Fm8O/y8ws+mvOr/FS4eEQma6APqMOFQ/vwVGYBlxvdfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773940623; c=relaxed/simple;
	bh=9ljBffsxw2q8RqJ9bVYqPxIRaFxIoLEm+OV8ME5ln1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULHMK8nRSYUAt5AVKx5NmlmWR6zcQUSyMbH6iO3V79T11S8eHzCbpdmCtSIQszpKkB0k8obPHXa4RGMdrIpbhZEH+bAV1aK5WSkAsFPZ8r+tEcoLoxqo8tilWoOj8IuXImhyV/k6HzSuULJSRb3UTcTP65oKqaxRUeygS6pPPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Ohl5b+6H; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Ohl5b+6H"
Received: from ms-a2 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62JHGx9v076770
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Mar 2026 02:16:59 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=WGbzCKIs05fkhZHCHfv1/0M5dGRY957hmlR1wbvNhaE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773940619; v=1;
        b=Ohl5b+6HxbDnpIFWoGbaipMRS2j8uqfjhVN3LqyWWnzgiD3QGoPINdAA7m2ufRb9
         QFv97UeR20iSSgrw+fbQUM2wcLf/ybHLRNODHPDuwT7xXCFHOo346mw24AHCgN1F
         BxB2Ie1rPVtRCA921BdhkEfrGwa3dnUK/+6srsC0cUH7q/OUVLO7QHeHnjIHIX9+
         PAJO+vw8U0Ubo3EzTPvXFoPccO6+THnTHMRUnxn6578s4gHI72B0dxdotFCalyh7
         2rV2kyB+d+/6OnVWfLTIuFATXha5veNMPJLUVvQ8rhAAI4qYktFNFmNlzKcxHAkC
         fcy6kiRtbY81VUtzQbXW5Q==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-next v1 1/3] i40e: prepare for XDP metadata ops support
Date: Thu, 19 Mar 2026 17:16:42 +0000
Message-ID: <20260319171650.5815-2-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319171650.5815-1-kohei@enjuk.jp>
References: <20260319171650.5815-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare 'struct i40e_xdp_buff' that contains an xdp_buff and a pointer
to i40e_rx_desc in order to pass the RX descriptor to the XDP kfuncs.
Also in ZC path, use XSK_CHECK_PRIV_TYPE() to ensure i40e_xdp_buff
doesn't exceed the offset of cb in xdp_buff_xsk.

No functional changes.

Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  5 ++++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h |  7 ++++++-
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 12 ++++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 31a42ee18aa0..7966d9cb8009 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3619,7 +3619,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
 	}
 
 skip:
-	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);
+	xdp_init_buff(&ring->xdp_ctx.xdp, xdp_frame_sz, &ring->xdp_rxq);
 
 	rx_ctx.dbuff = DIV_ROUND_UP(ring->rx_buf_len,
 				    BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 4ffdb007c41a..cfaf724ee7ff 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2438,10 +2438,11 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 			     unsigned int *rx_cleaned)
 {
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	struct i40e_xdp_buff *xdp_ctx = &rx_ring->xdp_ctx;
 	u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
 	u16 clean_threshold = rx_ring->count / 2;
 	unsigned int offset = rx_ring->rx_offset;
-	struct xdp_buff *xdp = &rx_ring->xdp;
+	struct xdp_buff *xdp = &xdp_ctx->xdp;
 	unsigned int xdp_xmit = 0;
 	struct bpf_prog *xdp_prog;
 	bool failure = false;
@@ -2530,6 +2531,8 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget,
 		if (neop)
 			continue;
 
+		xdp_ctx->desc = rx_desc;
+
 		xdp_res = i40e_run_xdp(rx_ring, xdp, xdp_prog);
 
 		if (xdp_res) {
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index e630493e9139..6c6ba42ee00c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -283,6 +283,11 @@ struct i40e_rx_buffer {
 	__u32 page_count;
 };
 
+struct i40e_xdp_buff {
+	struct xdp_buff xdp;
+	const union i40e_rx_desc *desc;
+};
+
 struct i40e_queue_stats {
 	u64 packets;
 	u64 bytes;
@@ -345,7 +350,7 @@ struct i40e_ring {
 	 * and to resume packet building for this ring in the next call to
 	 * i40e_clean_rx_ring_irq().
 	 */
-	struct xdp_buff xdp;
+	struct i40e_xdp_buff xdp_ctx;
 
 	/* Next descriptor to be processed; next_to_clean is updated only on
 	 * processing EOP descriptor
diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..51a05ce4c7ce 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -246,6 +246,8 @@ bool i40e_alloc_rx_buffers_zc(struct i40e_ring *rx_ring, u16 count)
 	u32 nb_buffs, i;
 	dma_addr_t dma;
 
+	XSK_CHECK_PRIV_TYPE(struct i40e_xdp_buff);
+
 	rx_desc = I40E_RX_DESC(rx_ring, ntu);
 	xdp = i40e_rx_bi(rx_ring, ntu);
 
@@ -396,6 +398,14 @@ static void i40e_handle_xdp_result_zc(struct i40e_ring *rx_ring,
 	WARN_ON_ONCE(1);
 }
 
+static struct i40e_xdp_buff *xsk_buff_to_i40e_ctx(struct xdp_buff *xdp)
+{
+	/* xdp_buff pointer used by ZC code path is allocated as xdp_buff_xsk.
+	 * i40e_xdp_buff private fields overlap with xdp_buff_xsk->cb.
+	 */
+	return (struct i40e_xdp_buff *)xdp;
+}
+
 /**
  * i40e_clean_rx_irq_zc - Consumes Rx packets from the hardware ring
  * @rx_ring: Rx ring
@@ -472,6 +482,8 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		if (i40e_is_non_eop(rx_ring, rx_desc))
 			continue;
 
+		xsk_buff_to_i40e_ctx(first)->desc = rx_desc;
+
 		xdp_res = i40e_run_xdp_zc(rx_ring, first, xdp_prog);
 		i40e_handle_xdp_result_zc(rx_ring, first, rx_desc, &rx_packets,
 					  &rx_bytes, xdp_res, &failure);
-- 
2.51.0

