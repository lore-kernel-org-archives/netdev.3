Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089592;
	b=Pj77x1rrskm6d49lkH3zpDypEesrcYaiFVjs6IYnDVUGsx2oW5bCxyjVjR6sZ8v/Pwkx
	 5tfvJsCB4B0Hr9Iay6K9bwcq8SbRsx+BGEcNeXe9gUMmj3l6TnoZmkYh693lvPk+ShNoN
	 4EgD2pQIhEYaijkNDCIWc91XRAcGztK1q73/vU/5Xc36HlC2lKhU5ltKDxHbXDKuiterC
	 6R0GWmyHVtIVT2I9wnSeUyrSyX+5FfnTD7FIIXwo5lomNbOvGC3UOY4Sm0Lbb1fu1PSXE
	 3nx8ZU1hTbBXvUiBJRUdKAcz5pxrdF4QfxZWL9B0ejatNWpToDycMigKUxMA4+GbHUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089592;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OMVqumbOEXKUXJwIxlcOJx0enVxwufUcyFXtU+K8GIo=;
	b=GvFmMWzP6F+yKx5cGTusXVG+/otwMyqAZLBUp7//2EgOSJTpNuHQF84Yd9wAVrnUgpWy
	 a/34D6YhXxsmyF/XzAj9DwC0TLa4GI57TnOm+5TRtmf5+K1F4dIvxxijDKhiStZT1cjdA
	 fHaMR2/PPFlTm4MgOSR8Sd1e0SmG7qjXmJotB4psCJXqk+n8sNpA1/nuj2j1GfCmXV0aB
	 KC4E597dRw07cMoPOnPx1v1ywYnbbc+mU59VXfBQutRm5PHzvcgBwagSetimz3fQw+St2
	 vSA3osu4sJ7mjE0SvdZdTYLDCyFczC3jSxodGQQk7+p2bs7GMcr5RqB3QdAnp6XyDnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQ7layWP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB34606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQ7layWP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636D31F01828;
	Tue, 27 Oct 2026 08:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089591;
	bh=OMVqumbOEXKUXJwIxlcOJx0enVxwufUcyFXtU+K8GIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQ7layWP4FycYZXkt203H9++T4Be9fu589brOGUgA1YjpPyk9v9GmsbVmh6keQJKP
	 jadXbTRbPeL57QRV+iBCaQJIIvq/tnJQtdwiKMciU1sT45M60RdIBSSLP4Fw887XgG
	 DRiM3tZesgcqTcN6FOr9i8MyZerLNjHM4m3w5GcWQvmRoQy0tob0WxKIMra4xFr8HT
	 qzLwns3iOyT9POFLtNzbaa2xduGlX2ZUcaMAjqh7+tJ4Y354MHXaRGI+PNT8xmMRUe
	 K2/UGd0Y9AnNYnRwkxjoNbaMbQrS65mGDM2+alYj89qUVpEZBCQRLpZZ6yVDG8Sevk
	 XnM4lEWJog0wQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	dev@openvswitch.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Ren Wei <weir@nebusec.ai>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net 2/5] loopback: use eth_type_trans_careful()
Date: Tue, 27 Oct 2026 09:26:01 +0100
Message-ID: <20261027082604.1485903-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027082604.1485903-1-edumazet@kernel.org>
References: <20261027082604.1485903-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc egress actions can leave an skb with fewer than ETH_HLEN bytes in
its linear part. loopback_xmit() then crashes in eth_type_trans():

  tc qdisc add dev lo clsact
  tc filter add dev lo egress matchall action vlan pop_eth
  # AF_PACKET SOCK_RAW: eth / eth / 8192 bytes of payload

  kernel BUG at include/linux/skbuff.h:2839!
  RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
  Call Trace:
   loopback_xmit (drivers/net/loopback.c:87)
   dev_hard_start_xmit (include/linux/netdevice.h:5455 include/linux/netdevice.h:5464 net/core/dev.c:4057 net/core/dev.c:4073)
   __dev_queue_xmit (net/core/dev.c:5066)
   packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)

The same happens with "action ife decode" on lo egress.

Use eth_type_trans_careful(), and drop the packet if the Ethernet
header can not be pulled.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@nebusec.ai/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 drivers/net/loopback.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 55ecd5ebac0f21b61b64373c429a6f9ba5d15c8e..8a6cb34e6b5f02c88dfb0c6bf112068c4f51fec1 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -70,6 +70,7 @@ EXPORT_SYMBOL(blackhole_netdev);
 static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 				 struct net_device *dev)
 {
+	enum skb_drop_reason reason;
 	int len;
 
 	skb_tx_timestamp(skb);
@@ -84,7 +85,12 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 	 */
 	skb_dst_force(skb);
 
-	skb->protocol = eth_type_trans(skb, dev);
+	reason = eth_type_trans_careful(skb, dev);
+	if (unlikely(reason)) {
+		dev_core_stats_tx_dropped_inc(dev);
+		kfree_skb_reason(skb, reason);
+		return NETDEV_TX_OK;
+	}
 
 	len = skb->len;
 	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
-- 
2.53.0

