Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348846;
	b=n8v1AezsgOpohFiW87zNx7w4szWuLOKYeAd/KJKS027nB7kIz8hUlqQ0vWxqYFSHYAF/
	 lkSozyLPr8ULDQhrrtO0F2vWzPwBgE6cx7PhZVooU8NJ9IRZFuugu2qfu/3D4UIWU3Ups
	 ZXaOAOgoRcnlTjN5HpNMXURcvjxp5uDvzgvHt0+hV/BWSywSMxFVVALPdwvhkpGMIZhWo
	 N2fjajXtCRkcNTUUSabdyAgPn4U752Du/9CKuSEaui3q1yZpqe1RshdexUyhBpPqNMjve
	 3lWIyQTBQ5KgtZv2/UuP8Yeso0aSzND3UbUkfovj0eF3PDItdrCY4BOgTNBGeycqy1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348846;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=sH6Pjtl7SHpgp2n6LytnA8GuVQDkLmZnGhVFk6i1krQ=;
	b=2cMTJoosYmncU+D1JTUdbws+aeJ5pFV4zzmGzi3iUcWnCFm1xAHXSgShSCNBLvx/J1gI
	 VUxoqj9OM5+BGSCS5+064+tAKe4VuDfiTbeaU4F1+cXkD06z2Qy+a8eoitrgPRlTPcp46
	 l09Q5nrTMyZnhdyhVOi89+Sk2o8TcaKVqKsW4InFPI+vSQPFtfzizfKsGNcTToWi+G7p3
	 7wBik9F5YZse6sHaUyZek6DD/ziRDBJ4JzaHzOPoC97syoudR+LEZw4XXMnKGv+kvyxGv
	 kvInZ7Xh3dLPGWv0N68Ezn5ucifVRwOfOo10fiPAEgapt2ZWnep5wgOJ0qC7QMdImfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=li3BmiNt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A727606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=li3BmiNt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE4A1F0089F;
	Tue, 10 Nov 2026 22:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348845;
	bh=sH6Pjtl7SHpgp2n6LytnA8GuVQDkLmZnGhVFk6i1krQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=li3BmiNt8RVgmkl+zUajLnAvnTbGrQ5dmf7TOsrlvbSghITRbZ1IEAfSN0G0XXKM3
	 lgHKWsP93jHoP5MFii2Lr9PVKgdM/Bmg2LgpzuKHEcTHDRdtAMe7e78cCBqh6mdINd
	 K1lx1qB79Sf2Q+Xxm9/pDJYo6KqikPiotcqcH816/nx8YKlqpSH20n/XKoAOOXVgH0
	 4TxZRDjcQAHrnOCAr/wwiXquk/vFHBMUTcopB4oaRz+bs7F741mcGyveIQLY5F2dVh
	 oOjCYdblUJCPsMmhyJU61AxTCwoak91mkWMfEOFJhKsfD8dclOG/yLxhujS3qwVxgL
	 i2nAAu+UYtUoA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:30 +0100
Subject: [PATCH net-next v7 15/18] net: ethernet: cortina: Scope RX
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-15-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
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
index 04a125d6d413..59e6aeb07e0b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1727,12 +1727,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
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
@@ -1743,6 +1743,7 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 			port->stats.rx_crc_errors++;
 		if (RX_ERROR_FRAME(rx_status))
 			port->stats.rx_frame_errors++;
+		u64_stats_update_end(&port->rx_stats_syncp);
 		return NULL;
 	}
 
@@ -1754,8 +1755,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
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
 
@@ -1813,7 +1818,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
+				u64_stats_update_begin(&port->rx_stats_syncp);
 				port->stats.rx_dropped++;
+				u64_stats_update_end(&port->rx_stats_syncp);
 				skb = NULL;
 				frag_nr = 0;
 			}
@@ -1905,7 +1912,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			put_page(page);
 
 		if (!dropping) {
+			u64_stats_update_begin(&port->rx_stats_syncp);
 			port->stats.rx_dropped++;
+			u64_stats_update_end(&port->rx_stats_syncp);
 			dropping = true;
 		}
 
@@ -1937,13 +1946,13 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	bool reschedule;
 
 	freeq_threshold = 1 << (geth->freeq_order - 1);
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
@@ -2870,6 +2879,9 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
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

