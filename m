Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6231A35F60D
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728539; cv=none; b=rMICpeRBGnSr30nAh0t9ZC1/YKK4R+7Hy1nrUyK6H4N2wyVofJ4xD+UkIDWi+TVp1sZorJxdx+sfjzvbSmw2/N6EXWqxKSy+MkVSmiEpKzNvbFTa2UjLKvKUfFcX4rLv4NCst4fO4iUecUgZPOE+EjD1/T9P2D3MvRV026Nzpa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728539; c=relaxed/simple;
	bh=hbdD2EgQb82Qd6vkM0HUzWNzWTweqQ0fZEiwbjNTlzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgB63UPPyqJ+OcVItzMioN+Md+uzhZ5QOa6ncdkpm8xGdVjxRRP53AAZtaS0XdGD9Y70IXV4YujvMxXH7F5PG479mxDfKYDQwTKsGMpflVoh5OdOmtxgKk2sICFkhSNwgMwHS0wHKNanJ0tsnqy/m8oud1lyexctu1Xl7nXNTmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=TJTOZ7+V; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="TJTOZ7+V"
Received: from ms-a2 (16.4.31.150.dy.iij4u.or.jp [150.31.4.16])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62H6MFGB069015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 17 Mar 2026 15:22:15 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=U0c0no8qOQMhS+4Ff84jEoupUlPveySfmNiJKU+YoOs=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773728536; v=1;
        b=TJTOZ7+V/mCxUCGS7AljPoa45TxfGqhV/+/mADeZuHUN8prPHkhvj8GtK/oST9Nr
         sLavL70/izk6R8YpKdEEtkdZTCH6isRAMaxYc465Pny7DOyWbSSWo1iHMd5ZJPy/
         ZND8Knn15TV1BtThtOnkdQybVzOLf2Or6hfIFqsyp18T4t6FySh8XvNnqXuWgAK0
         A9/njzdVf6GGlfHZvCwQ8ss0NLCxtMhHG5fyY+4VPNi1K2QnjyV3DUNbCOU7/DBR
         T+J4STSBkhvC69fJCNIrVuXWOnUlTMLLlkfLOSVVtSLaMuJcQhHo7U3+yH/q+vtp
         Z95a+9WQTUSY6HeLhae1sQ==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
        kohei.enju@gmail.com, Kohei Enju <kohei@enjuk.jp>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v2 2/2] igc: enable build_skb on the non-XDP small-frame RX path
Date: Tue, 17 Mar 2026 06:21:46 +0000
Message-ID: <20260317062205.39406-3-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317062205.39406-1-kohei@enjuk.jp>
References: <20260317062205.39406-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

igc implements igc_build_skb(), but it is currently unused because the
IGC_RING_FLAG_RX_BUILD_SKB_ENABLED bit is never set. Enable the
build_skb path when XDP is not active and the configured maximum frame
size fits within IGC_MAX_FRAME_BUILD_SKB.

In a single-queue small-packet (64-byte) RX microbenchmark on my setup,
enabling build_skb improved the receive rate from about 3.11 Mpps to
about 3.30 Mpps, while reducing missed packets from about 484 kpps to
about 300 kpps.

Keep the XDP path unchanged for now, since it uses a different RX buffer
layout based on XDP_PACKET_HEADROOM, and enabling it there would need
separate validation and buffer layout adjustments.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
---
 drivers/net/ethernet/intel/igc/igc.h      | 4 ++++
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
index e66799507f81..acbd2c237667 100644
--- a/drivers/net/ethernet/intel/igc/igc.h
+++ b/drivers/net/ethernet/intel/igc/igc.h
@@ -734,6 +734,10 @@ enum igc_ring_flags_t {
 
 #define ring_uses_build_skb(ring) \
 	test_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+#define set_ring_uses_build_skb(ring) \
+	set_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
+#define clear_ring_uses_build_skb(ring) \
+	clear_bit(IGC_RING_FLAG_RX_BUILD_SKB_ENABLED, &(ring)->flags)
 
 static inline unsigned int igc_rx_bufsz(struct igc_ring *ring)
 {
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 79192b02e6be..b44f89311a4e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -474,6 +474,7 @@ static void igc_clean_rx_ring(struct igc_ring *ring)
 		igc_clean_rx_ring_page_shared(ring);
 
 	clear_ring_uses_large_buffer(ring);
+	clear_ring_uses_build_skb(ring);
 
 	ring->next_to_alloc = 0;
 	ring->next_to_clean = 0;
@@ -654,6 +655,9 @@ static void igc_configure_rx_ring(struct igc_adapter *adapter,
 
 	if (igc_xdp_is_enabled(adapter))
 		set_ring_uses_large_buffer(ring);
+	else if (!(adapter->flags & IGC_FLAG_RX_LEGACY) &&
+		 adapter->max_frame_size <= IGC_MAX_FRAME_BUILD_SKB)
+		set_ring_uses_build_skb(ring);
 
 	/* disable the queue */
 	wr32(IGC_RXDCTL(reg_idx), 0);
-- 
2.51.0

