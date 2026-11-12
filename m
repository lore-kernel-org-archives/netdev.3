Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490264;
	b=t0857dF1p2FNsNk9AZ+qD80lEV40FAaYev/Hu3e7MGM84/WohlC5ISrLHWcT72xbkVTk
	 Ql1bZMTbwC2esqPokUu0aNJFQqnr6Wj6M0lIOwCzs6A7+BI/nDiGy/77t/m+BTmaNfva+
	 FHKzFFY0JLO9eKRbVzh14rnVqWR3ihLkrLONtny0mtCB4FHxn+UzwR5jeOVYZFSF9Z503
	 VH0kHkEHF8Agr4SycD8jyyla7Nf1UufI1DvVvSGpp01YjOsfdMJ3G6UjQr/dCqJXf/gxr
	 hXfM3kkEXN2UpfFvNxU/Nfdw4cXLTZaIU/Gjv836zN63Rx7zcU2Ol/NxSBAEP14RLMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490264;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=8jov7QB5Uud17cmyrN/GNlRG0vxcIpB38alZ97lpqKU=;
	b=Pq64vVhu1gG+WpTP36rvDj1sMxw05Pmd23rIofW8PxVz8WoHcKjklKERndtx0CyCDwx5
	 Urf9pNL8QHyk0qHv4/MUHJi3ybJgMs1/V4tWwpXJIOyy1sSkMZfX083otVL+0rcYQgNi9
	 U0Cri/5Iq1ZpeYIUGJNKoC2iWetA8TpSRK/os23mPG/l7w2f0pZOLUs7CsXIkAlAVTsae
	 1iXVrN3BbRUVuujaZcCPTzr+eGQibk4VfZLyn72M3/d5Y4opmP7Pl9LLA78xyjWj/2TfJ
	 jZjMcA3djoWqn+P1iOUzN8bOm0xXPdszoly6sf3vo3f8aUAqJzFKdOqUzB51ZPySIwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtWkj64L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C90606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jtWkj64L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3605A1F00A0E;
	Thu, 12 Nov 2026 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490264;
	bh=8jov7QB5Uud17cmyrN/GNlRG0vxcIpB38alZ97lpqKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jtWkj64Lo5RRgMKFBLyArazQM9MOqvxjvHN82yQ6O2EEd5BEKgUiVHWS+9LFjp3oN
	 TB92/Ud8R6oBmUCJohrAMK4BhyGpzh3bFDFTtZhZ9M6cHhb+XNFttE1SAibIGgt/WM
	 1hljwjA2dwCAZ8yTejZTTo8ed9Ua2t7lBu9vuEwIQeG2CeOZzd313+7H5+u5HbcGtP
	 C2yShTxfBCtmbz/UZo8lQ2CegUS/fmhCkeeP80pz5sunR0JDTyBAewxf84QOidNgCO
	 SdW223X/6YQxEY3K+wm6l/EZsvY+ijI5XkW+DsfIvd7EsTjpCRtxgZRP5YBBXCP1LE
	 e/JwZ6CHf39Zw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:31 +0100
Subject: [PATCH net-next v8 16/19] net: ethernet: cortina: Scope RX
 statistics updates
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-16-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

On 32-bit PREEMPT_RT systems u64_stats_update_begin() disables
preemption. The RX poll currently holds that writer section across
gmac_rx(), which takes spinlock_t locks and calls into GRO and fragment
handling. spinlock_t can sleep on PREEMPT_RT and must not be acquired
with preemption disabled.

Keep the writer sections around the counter updates only. NAPI ownership
continues to serialize normal RX writers, while the stop path updates its
counter after napi_disable(). This preserves the existing accounting
without covering potentially sleeping operations.

Initialize the dynamically allocated statistics synchronization objects
so their seqcount lockdep keys are valid on 32-bit debug kernels.

The issue was found by inspecting the u64_stats_sync writer scope. The
series was tested on a D-Link DIR-685 with media playback and ksmbd
transfers under ping load. PREEMPT_RT was not runtime-tested.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index cc26ff16a0a3..d0d161654f49 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1769,12 +1769,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 	unsigned int rx_status = word0.bits.status;
 	struct sk_buff *skb = NULL;
 
-	port->rx_stats[rx_status]++;
-	port->rx_csum_stats[rx_csum]++;
-
 	if (word0.bits.derr || word0.bits.perr ||
 	    rx_status || frame_len < ETH_ZLEN ||
 	    rx_csum >= RX_CHKSUM_IP_ERR_UNKNOWN) {
+		u64_stats_update_begin(&port->rx_stats_syncp);
+		port->rx_stats[rx_status]++;
+		port->rx_csum_stats[rx_csum]++;
 		port->stats.rx_errors++;
 
 		if (frame_len < ETH_ZLEN || RX_ERROR_LENGTH(rx_status))
@@ -1785,6 +1785,7 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 			port->stats.rx_crc_errors++;
 		if (RX_ERROR_FRAME(rx_status))
 			port->stats.rx_frame_errors++;
+		u64_stats_update_end(&port->rx_stats_syncp);
 		return NULL;
 	}
 
@@ -1796,8 +1797,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 
 update_exit:
+	u64_stats_update_begin(&port->rx_stats_syncp);
+	port->rx_stats[rx_status]++;
+	port->rx_csum_stats[rx_csum]++;
 	port->stats.rx_bytes += frame_len;
 	port->stats.rx_packets++;
+	u64_stats_update_end(&port->rx_stats_syncp);
 	return skb;
 }
 
@@ -1855,7 +1860,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
+				u64_stats_update_begin(&port->rx_stats_syncp);
 				port->stats.rx_dropped++;
+				u64_stats_update_end(&port->rx_stats_syncp);
 				skb = NULL;
 				frag_nr = 0;
 			}
@@ -1947,7 +1954,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			put_page(page);
 
 		if (!dropping) {
+			u64_stats_update_begin(&port->rx_stats_syncp);
 			port->stats.rx_dropped++;
+			u64_stats_update_end(&port->rx_stats_syncp);
 			dropping = true;
 		}
 
@@ -1979,13 +1988,13 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	bool reschedule;
 
 	freeq_threshold = 1 << (geth->freeq_buf_order - 1);
-	u64_stats_update_begin(&port->rx_stats_syncp);
 
 	received = gmac_rx(napi->dev, budget, &freeq_consumed, &reschedule);
-	if (!reschedule && received < budget)
+	if (!reschedule && received < budget) {
+		u64_stats_update_begin(&port->rx_stats_syncp);
 		++port->rx_napi_exits;
-
-	u64_stats_update_end(&port->rx_stats_syncp);
+		u64_stats_update_end(&port->rx_stats_syncp);
+	}
 
 	port->freeq_refill += freeq_consumed;
 	if (port->freeq_refill > freeq_threshold) {
@@ -2912,6 +2921,9 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	}
 
 	port = netdev_priv(netdev);
+	u64_stats_init(&port->tx_stats_syncp);
+	u64_stats_init(&port->rx_stats_syncp);
+	u64_stats_init(&port->ir_stats_syncp);
 	SET_NETDEV_DEV(netdev, dev);
 	port->netdev = netdev;
 	port->id = id;

-- 
2.56.0

