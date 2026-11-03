Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728316;
	b=qXN8h91I/J42zd0Msc+97Uz4S9ikh+Ai2PKiLP+0DkVO6oiJ6o4/h2AnEJX+dvtGMaG2
	 khGWci/kQYmU72UoEd0hv4l6JdKNDGx102WWnvDzIDwvWd6uMaZkVLdWsXrrVDIxbBBZb
	 qGHLQ/1Q6dcawX2LjhBzZQjAQmEB+aI4rp0E3y+hX7vKv/lV7+yaQUTcQfEShBzWctKFv
	 rCE/3oRzsyGkXjOHAYjO9HODsE4tR0tYnj+xmnx856GGJLK+tF+qqj2rpyKGh0w5SMf8X
	 O+fpo0KDtHiavVBj2DgT/JMyglkXRxUbfeTPE5/KvS5I7kk8/jAprntEmFYyM7lYZmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728316;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=xNexKMTYJicrHV61JDUj9C/J6Qd5Ts2KejKmRFQL9HU=;
	b=LgVmT7c+JlQw6WMMpg2qTzVhIDnXbZ23YoQM8y+sC/ZSlE4xFAYFZdatUbw0XWgjRabG
	 MmPf5KCjXCC0NnyI5QW9MwGaceDyk1R502i/3Uq4GzUCiZiAEzqYkKW7O0MrAlqM8bz8D
	 k3hKyfkO8E68xtsDzN97kw/tYQIRgFML7PHfaVFjMg31fr7kva+4UrZmExnG36XR3JPnt
	 YfZyXUkmk6zc+O8AO7iiQ4tX4BjUmnUMi2hztpyfr8C0Bqke05lEAE5JqDgE4lXcLGuoR
	 w2B93qgb48pB1JkQyjOZOqbr54EPsaGgNcsH86JP9osf1u6SWOZPHbAhL8qGcKxvpGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChyarCys;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221D606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChyarCys
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3D1F00919;
	Tue,  3 Nov 2026 17:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728316;
	bh=xNexKMTYJicrHV61JDUj9C/J6Qd5Ts2KejKmRFQL9HU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ChyarCysNa2+MqzfjXFhXTf2lkRzzbRr/lkSNRnWtI57KIjp71RvgRO9IMgTKalms
	 1LfnKiEU+pfqKRRuuybVPGUTFcPjhe/Pcj4xNvnjucEOYCubkkLdJI3QZOUh/o+KUE
	 xl743iV6hpNGIm9kA/L/5yovHuoyCT8UfNiTJFtcdEpvwWjVhjH8Kk2qh0SooVyB6R
	 ARtuhVeu55O83YCLOpGo3eX0x9SJgO9DApeLkOvCirXnGjvtAaRzzfyqqjAN56MBls
	 ChztX5tG4jOKhWq8AIrhVioGZc5VfbRWwMsiqvk6Lu3SH+Iv62L7FYWCDAvQdGByuO
	 JeGJvLxdT4KFA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:25 +0100
Subject: [PATCH net-next v6 14/15] net: ethernet: cortina: Scope RX
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
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-14-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
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
index 5e89057bb2fb..c32e9574c8c9 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1720,12 +1720,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
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
@@ -1736,6 +1736,7 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 			port->stats.rx_crc_errors++;
 		if (RX_ERROR_FRAME(rx_status))
 			port->stats.rx_frame_errors++;
+		u64_stats_update_end(&port->rx_stats_syncp);
 		return NULL;
 	}
 
@@ -1747,8 +1748,12 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
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
 
@@ -1806,7 +1811,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
+				u64_stats_update_begin(&port->rx_stats_syncp);
 				port->stats.rx_dropped++;
+				u64_stats_update_end(&port->rx_stats_syncp);
 				skb = NULL;
 				frag_nr = 0;
 			}
@@ -1898,7 +1905,9 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			put_page(page);
 
 		if (!dropping) {
+			u64_stats_update_begin(&port->rx_stats_syncp);
 			port->stats.rx_dropped++;
+			u64_stats_update_end(&port->rx_stats_syncp);
 			dropping = true;
 		}
 
@@ -1930,13 +1939,13 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
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
@@ -2863,6 +2872,9 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
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

