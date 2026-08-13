Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A26F2DF6F4
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786591832; cv=none; b=lVd+OgrI31jgSCf/ya0RqOA2aLT6F2AXP8WWFnFaismK2UTlmX2LUz15NVQkjOSy7NRDydZcY/CxoOS2226NNSnQQB0/jArYkSemCL3wpsY+2rdEuEXMRQtxPRpMbbzco9dmF/qgJ5+M+w4xhsumIwvgNXjv8filhJ7NUcBz2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786591832; c=relaxed/simple;
	bh=m+LJwN5Fva5uOOTvKroFKr9SzWeoO5JMoQNzEyNTjLo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBK/JaeO7s6yOWBp7BlE+Em05p7fEztZ/YRyt++hikYRRBDbXe8tZ+joIpbV4m2jTX+DtaTl7jDYDATXhcGAD6TIvrEMJIOElgJ/6xIi+QshvEOZ7MdIMPdjXgOnku3OTlrA2/Ed/XQfuomD/wdEWxYSi/8QGtEg4rhyq7qeHxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0hOHO+Dz; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0hOHO+Dz"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Ddx6m6WyvF4ptfyyfrysd4E1ZX4xUKEa8oeetJNKBBs=;
	b=0hOHO+Dz9ifW5yfuv4GCu85uRMvkf0XCjw1StZEP/CQJu0XMH5e1XDi1LVL/A5WsEEhTAtBwB
	BKFD0tUMCpycLEfGZTQCbk4GI0Egvcf8e832gn3XCyNljdQvY3tTsH3HTwVdXOY00+d+7OMc/5c
	mkdxtXe1N8YlfaSBmZlYYyY=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4hL9Zc6hJLz1K96m;
	Thu, 13 Aug 2026 11:19:36 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 74B914057A;
	Thu, 13 Aug 2026 11:30:14 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Aug 2026 11:30:14 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Aug 2026 11:30:13 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<kuba@kernel.org>, <horms@kernel.org>, <herbert@gondor.apana.org.au>,
	<kuniyu@google.com>
CC: <idosch@nvidia.com>, <andrew+netdev@lunn.ch>, <ap420073@gmail.com>,
	<steffen.klassert@secunet.com>, <laforge@gnumonks.org>,
	<jiayuan.chen@linux.dev>, <jhs@mojatatu.com>, <zhangchangzhong@huawei.com>,
	<netdev@vger.kernel.org>, Dong Chenchen <dongchenchen2@huawei.com>,
	<syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com>
Subject: [PATCH net] net: iptunnel: fix stale transport header during tunnel decapsulation
Date: Thu, 13 Aug 2026 11:38:55 +0800
Message-ID: <20260813033855.3372172-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200002.china.huawei.com (7.202.195.90)

Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a stale
transport_header offset after tunnel decapsulation.

BUG: unable to handle page fault for address: ffffed102091a42e
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-00061-g248951ddc14d #256 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__asan_load2
<IRQ>
qdisc_pkt_len_segs_init (net/core/dev.c:4145)
__dev_queue_xmit (net/core/dev.c:4787)
br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
br_handle_frame_finish (net/bridge/br_input.c:229)
br_handle_frame (net/bridge/br_input.c:315)
__netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
__netif_receive_skb_list_core (net/core/dev.c:6287)
netif_receive_skb_list_internal (net/core/dev.c:6445)
napi_complete_done (net/core/dev.c:6813)
gro_cell_poll (net/core/gro_cells.c:74)
__napi_poll (net/core/dev.c:7735)
net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
handle_softirqs (kernel/softirq.c:622)
do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
__local_bh_enable_ip (kernel/softirq.c:450)
tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
tun_chr_write_iter (drivers/net/tun.c:2032)

The crash requires four conditions to line up:

1. The incoming packet is encapsulated and carries GSO metadata.  The outer
   transport header offset is stored in skb->transport_header while the
   packet is still in the outer tunnel context.
2. The tunnel receiver strips the outer headers.  skb->data is advanced to
   the inner frame, but skb->transport_header is left pointing to the
   now-removed outer L4 header, so it becomes a negative offset relative to
   the new data.
3. The inner frame is not delivered to the local IP stack.  Instead, it
   is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never runs and
   the transport header is not reset to the inner L4 offset.
4. The forwarding path calls __dev_queue_xmit(), which enters
   qdisc_pkt_len_segs_init().  That function computes the GSO header length
   from skb_transport_offset(skb).  Because the offset is negative, the
   unsigned cast overflows and pskb_may_pull(skb, hdr_len +
   sizeof(struct tcphdr)) reads past the end of the skb, triggering a
   KASAN fault or page fault.

Fix this by clearing skb->transport_header to the ~0U sentinel at the
tunnel decapsulation boundary, after each tunnel receive function has
finished all processing that needs the outer L4 header and before the skb
is handed to GRO or the stack. The IP/GRO receive paths then set the
transport header correctly when they parse the inner packet.

Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
Reported-by: syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69de2bee.a00a0220.475f0.0041.GAE@google.com/T/
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 drivers/net/amt.c              | 1 +
 drivers/net/bareudp.c          | 2 ++
 drivers/net/geneve.c           | 6 ++++--
 drivers/net/gtp.c              | 1 +
 drivers/net/pfcp.c             | 1 +
 drivers/net/vxlan/vxlan_core.c | 1 +
 include/linux/skbuff.h         | 5 +++++
 net/ipv4/ip_tunnel.c           | 2 ++
 net/ipv6/ip6_tunnel.c          | 2 ++
 net/ipv6/sit.c                 | 1 +
 net/xfrm/xfrm_input.c          | 1 +
 11 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 182a41d59a75..5968a08fcd5c 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -2355,6 +2355,7 @@ static bool amt_multicast_data_handler(struct amt_dev *amt, struct sk_buff *skb)
 
 	skb->pkt_type = PACKET_MULTICAST;
 	skb->ip_summed = CHECKSUM_NONE;
+	skb_unset_transport_header(skb);
 	len = skb->len;
 	err = gro_cells_receive(&amt->gro_cells, skb);
 	if (likely(err == NET_RX_SUCCESS))
diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 5ef841c85526..b92652ca91ec 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -191,6 +191,8 @@ static int bareudp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 		}
 	}
 
+	skb_unset_transport_header(skb);
+
 	len = skb->len;
 	err = gro_cells_receive(&bareudp->gro_cells, skb);
 	if (likely(err == NET_RX_SUCCESS))
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 72023ebd0e1b..b632239c5e43 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -372,10 +372,12 @@ static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock *gs,
 
 	/* Skip the additional GRO stage when hints are in use. */
 	len = skb->len;
-	if (skb->encapsulation)
+	if (skb->encapsulation) {
 		err = netif_rx(skb);
-	else
+	} else {
+		skb_unset_transport_header(skb);
 		err = gro_cells_receive(&geneve->gro_cells, skb);
+	}
 	if (likely(err == NET_RX_SUCCESS))
 		dev_dstats_rx_add(geneve->dev, len);
 
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9a12cc53da00..1e3013d49713 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -337,6 +337,7 @@ static int gtp_rx(struct pdp_ctx *pctx, struct sk_buff *skb,
 
 	dev_sw_netstats_rx_add(pctx->dev, skb->len);
 
+	skb_unset_transport_header(skb);
 	__netif_rx(skb);
 	return 0;
 
diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
index d8e4d60f5834..4b67906646ff 100644
--- a/drivers/net/pfcp.c
+++ b/drivers/net/pfcp.c
@@ -94,6 +94,7 @@ static int pfcp_encap_recv(struct sock *sk, struct sk_buff *skb)
 	skb_reset_mac_header(skb);
 	skb->dev = pfcp->dev;
 
+	skb_unset_transport_header(skb);
 	gro_cells_receive(&pfcp->gro_cells, skb);
 
 	return 0;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 1ded27768a97..9366895856f6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1799,6 +1799,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	dev_dstats_rx_add(vxlan->dev, skb->len);
 	vxlan_vnifilter_count(vxlan, vni, vninode, VXLAN_VNI_STATS_RX, skb->len);
+	skb_unset_transport_header(skb);
 	gro_cells_receive(&vxlan->gro_cells, skb);
 
 	rcu_read_unlock();
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..626bbb9bae1a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3082,6 +3082,11 @@ static inline bool skb_transport_header_was_set(const struct sk_buff *skb)
 	return skb->transport_header != (typeof(skb->transport_header))~0U;
 }
 
+static inline void skb_unset_transport_header(struct sk_buff *skb)
+{
+	skb->transport_header = (typeof(skb->transport_header))~0U;
+}
+
 static inline unsigned char *skb_transport_header(const struct sk_buff *skb)
 {
 	DEBUG_NET_WARN_ON_ONCE(!skb_transport_header_was_set(skb));
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 9d114bd575f9..5e677c86f0e3 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -445,6 +445,8 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 	if (tun_dst)
 		skb_dst_set(skb, (struct dst_entry *)tun_dst);
 
+	skb_unset_transport_header(skb);
+
 	gro_cells_receive(&tunnel->gro_cells, skb);
 	return 0;
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index ebf83f090376..e7c8283a0e39 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -892,6 +892,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 	if (tun_dst)
 		skb_dst_set(skb, (struct dst_entry *)tun_dst);
 
+	skb_unset_transport_header(skb);
+
 	gro_cells_receive(&tunnel->gro_cells, skb);
 	return 0;
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index a38b24fb8384..ad5adc5abe6e 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -726,6 +726,7 @@ static int ipip6_rcv(struct sk_buff *skb)
 
 		dev_sw_netstats_rx_add(tunnel->dev, skb->len);
 
+		skb_unset_transport_header(skb);
 		netif_rx(skb);
 
 		return 0;
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index eecab337bd0a..2767021c138a 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -744,6 +744,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			skb_dst_drop(skb);
 		if (async)
 			dev_put(dev);
+		skb_unset_transport_header(skb);
 		gro_cells_receive(&gro_cells, skb);
 		rcu_read_unlock();
 		return 0;
-- 
2.25.1

