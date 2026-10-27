Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089600;
	b=dcufFH5EF3uhO/OKMKaWevvK9deCU+0ZMmJHWjK1DuHyXK7szocMKMaQfpN2Z7cOXAbB
	 +ICBZmW9hOTqhaOv5/AzLs8BFfn1Ip3MJnR6VPmN8bzNSIY+SL8+jxKc+tNXOjKlk+PDo
	 I3Thsg3atRMudS9f77bzOQfPwPibMo4SB6XVcjV1t9Em6EjoNqw0BGGZVaxCQj+rzlenf
	 4G4PRyCCWVA6XafKrZPR5nFws8eOA3tUv9FfvGp5Wpe4jiESZZsFyIU4n8cRA4WW8xO3B
	 nnyhhOrc+xA92eVignBd28M3xYWMylpiHOnvASrEojAvjepgdFO/2Hju9dGBxRjiPuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089600;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wxlEUOPDWrWSjb+U69g4A3AvQlYOq0xjZK0iGo8qV7w=;
	b=R6N+iAbqxpaEUJvPpvcdGTKkqblplJ23nbntWYrnP7nO2+HfKJTbCIK6XzDD5MAynze4
	 6dYIekgaivyNOpgQ+aF1dMhUJZgnjzaCyVhCkGzCEbZNU/8X67vcfHN1WyoHreXMr/ucF
	 EgrSxGWoD+GbSuG3HhTA1TzD5jevqfInjYo9Nt5hhLus9ZmQ6GwUEzt/jYQrfNJt58qP2
	 kgdxV+fRbz0K88tIqV596VN4vH29ssuVF9vyImWQpmxDMbLbqjFcMjlaYaG6MaEn4SSVt
	 +le6kkV5R34gx2tbHZwFQ4biSemv7bRLjVfv7kRuTpqdLEKFmosDmv7Rt0Q9tm2mRWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJL9glBL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C4606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJL9glBL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD61C1F01825;
	Tue, 27 Oct 2026 08:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089600;
	bh=wxlEUOPDWrWSjb+U69g4A3AvQlYOq0xjZK0iGo8qV7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bJL9glBL9FnvSW80kttAQlhFmMmILzNHALQEc2jliN6yffayQ51iNaLhRNm53fRrq
	 BwplPAYeOAjg6LUOxZHtN73OfwthRtUQoqh69TuhUlWKG6mQzTWenmCaT2/DnI9UYA
	 6YFsu5W45Xz2p7NRjTaAUeTq5d1zdy0YjP75hTCxBPjuBKH509KVimJjnjtOV86hZK
	 qt2B4qnAEBxmgO24H8MNAKxdBxkHiujFOynAiXd7l10twHv2nGFPJD1bfu3mZyvXP2
	 HEe9vppsRaFhrXn1S/Cqq/S4+ZRCONLD5iiJcypoY7KwCyrFUp4OrAtY5Y6eFybsNF
	 gcPiZm5oQiCmQ==
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
	Ren Wei <weir@nebusec.ai>
Subject: [PATCH net 4/5] openvswitch: use eth_type_trans_careful() in internal_dev_recv()
Date: Tue, 27 Oct 2026 09:26:03 +0100
Message-ID: <20261027082604.1485903-5-edumazet@kernel.org>
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

OVS actions like pop_eth followed by pop_mpls(ETH_P_TEB) or pop_nsh
can expose an inner Ethernet header which is not in the linear part
of the skb. Output to an internal port then crashes in eth_type_trans():

  flow: in_port(0),eth(),eth_type(0x8847),mpls(lse=0x00010140)
  actions: pop_eth,pop_mpls(0x6558),0
  # AF_PACKET SOCK_RAW on dp0: eth / mpls / eth / 4096 bytes of payload

  kernel BUG at include/linux/skbuff.h:2839!
  RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
  Call Trace:
   internal_dev_recv (net/openvswitch/vport-internal_dev.c:202) openvswitch
   do_execute_actions (net/openvswitch/actions.c:1296) openvswitch
   ovs_execute_actions (net/openvswitch/actions.c:1606) openvswitch
   ovs_dp_process_packet (net/openvswitch/datapath.c:310) openvswitch
   ovs_vport_receive (net/openvswitch/vport.c:448) openvswitch
   internal_dev_xmit (net/openvswitch/vport-internal_dev.c:42) openvswitch
   dev_hard_start_xmit (include/linux/netdevice.h:5455 include/linux/netdevice.h:5464 net/core/dev.c:4057 net/core/dev.c:4073)
   __dev_queue_xmit (net/core/dev.c:5066)
   packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)

Use eth_type_trans_careful(), and drop the packet if the Ethernet
header can not be pulled. This covers all OVS actions at the consumer,
instead of fixing each producer.

Fixes: b2d0f5d5dc53 ("openvswitch: enable NSH support")
Fixes: f66b53fdbb22 ("openvswitch: New MPLS actions for layer 2 tunnelling")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/openvswitch/vport-internal_dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-internal_dev.c b/net/openvswitch/vport-internal_dev.c
index 77a16d5ebd54343c80a2def261aadcb8ff0d1274..8f035087f0eec80eddf6b493cf5ba7915a3e01c6 100644
--- a/net/openvswitch/vport-internal_dev.c
+++ b/net/openvswitch/vport-internal_dev.c
@@ -188,6 +188,7 @@ static void internal_dev_destroy(struct vport *vport)
 static int internal_dev_recv(struct sk_buff *skb)
 {
 	struct net_device *netdev = skb->dev;
+	enum skb_drop_reason reason;
 
 	if (unlikely(!(netdev->flags & IFF_UP))) {
 		kfree_skb(skb);
@@ -199,7 +200,12 @@ static int internal_dev_recv(struct sk_buff *skb)
 	nf_reset_ct(skb);
 
 	skb->pkt_type = PACKET_HOST;
-	skb->protocol = eth_type_trans(skb, netdev);
+	reason = eth_type_trans_careful(skb, netdev);
+	if (unlikely(reason)) {
+		dev_core_stats_rx_dropped_inc(netdev);
+		kfree_skb_reason(skb, reason);
+		return NETDEV_TX_OK;
+	}
 	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 	dev_sw_netstats_rx_add(netdev, skb->len);
 
-- 
2.53.0

