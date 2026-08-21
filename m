Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CC443AAB;
	Fri, 21 Aug 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302687; cv=none; b=nNE6AGL8ykyY8qoQ8HoqzBjvq9WfbH08Ey/UJjYR5Zeq25q/O0DnXdhBgXKRlwaywcZWNMQ2F/fuEgg4l/l4NC/cXKkKW1mMXRMTDXP/2BqGSxLsKfqO9daOrwtfkvDFr4LiztHiHj8vz52SlbHVScce2BhW8NPTJIsqf2A7flQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302687; c=relaxed/simple;
	bh=SUGE2//ZKrRF+ANloTD4zPsh8isqBGU3BqOD9vjE+oE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oI4uNk4neXfXXcHAb/FRDhMnRZdY73LvwVOisTTeQAi22OpfSjL6DYSkcP1cZkZS4IhjR/waO6C4ueFAVWFE38wLBvmNpTnUKzeVxYhg6GO8c+WhhxAmIKZfEycC/RLXQXdJp1xjlewh2TNp0UiByyRCm7GORWFYGm9sCeaHMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DN3VEYt+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DN3VEYt+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Nh
	viHOrrfe/WNa5/IisHg2NHp8G7zQYFfYPdpCZlib8=; b=DN3VEYt+2JjhK14zeo
	Bth+alIQUBUSnivFVcatmZvcAmfTZeev+eqhVCTQClY1UO53VvQ105gjOjM78M08
	nfxnvvGgIkDSXNs9ltuzjQi3Nd0JBCqdyqtGzqRDIcW+kCpYfHS18u9cyCm/kw58
	q5TocJOttAhVa51F6G7AHTV+c=
Received: from sky.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3X8j1Eohqb8I7Cw--.56773S2;
	Fri, 21 Aug 2026 16:57:26 +0800 (CST)
From: Junnan Zhang <zhangjn_dev@163.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangjn_dev@163.com,
	Junnan Zhang <zhangjn11@chinatelecom.cn>,
	Shouxin Sun <sunshx@chinatelecom.cn>
Subject: [PATCH] net/packet: fix network header offset for non-VLAN raw packets on VLAN subinterfaces
Date: Fri, 21 Aug 2026 16:57:22 +0800
Message-ID: <20260821085722.24036-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X8j1Eohqb8I7Cw--.56773S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZryDtrWUCr43ZryxCFy8Zrb_yoW5Zr15pa
	4UCF98Jw4DGrsI9w4kWFsrXF45ZFs7G3W7XayfX34Yvrs0gFyFyFWxtF429Fy8tFWrW34U
	Xr1qqF1rC3WktrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piH7K3UUUUU=
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbC7RZ+FGqIEvbIswAA3s

From: Junnan Zhang <zhangjn11@chinatelecom.cn>

AF_PACKET SOCK_RAW reserves dev->hard_header_len bytes of headroom. For
VLAN subinterfaces, hard_header_len includes VLAN tag space (18 bytes)
while min_header_len is the real Ethernet header length (14 bytes). When
userspace sends a standard untagged Ethernet frame through a VLAN
subinterface, packet_parse_headers() only corrects network_header for
VLAN-tagged frames. For non-VLAN frames it leaves network_header at
hard_header_len, so the IP header is found 4 bytes too late and
inet_gso_segment() fails with -EINVAL.

Set network_header to min_header_len for non-VLAN SOCK_RAW frames on
Ethernet devices whose hard_header_len exceeds min_header_len, so the
L3/L4 header positions match the actual on-the-wire frame.

This fix is placed before skb_probe_transport_header() so that both the
transport header probe (which uses skb_network_offset() as nhoff) and
subsequent GSO see the right L3/L4 offsets. It complements
commit 01fdecc0480d ("net: packet: fix wrong transport_header when sending VLAN-tagged frame")
which only covers VLAN-tagged frames.

Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
Signed-off-by: Junnan Zhang <zhangjn_dev@163.com>
---
 net/packet/af_packet.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 1168bd6b09cd..4669320f551b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1935,6 +1935,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 {
 	int depth;
+	bool has_vlan;
 
 	/* On TX skb->data is the L2 header; anchor it for all socket types. */
 	skb_reset_mac_header(skb);
@@ -1943,11 +1944,23 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 	    sock->type == SOCK_RAW)
 		skb->protocol = dev_parse_header_protocol(skb);
 
+	has_vlan = likely(skb->dev->type == ARPHRD_ETHER) &&
+		   eth_type_vlan(skb->protocol);
+
+	/* For non-VLAN raw frames on devices whose hard_header_len includes
+	 * VLAN tag space (e.g. VLAN subinterfaces), the network header must be
+	 * at the actual L2/L3 boundary, not hard_header_len, so that both the
+	 * transport header probe below and subsequent GSO see the right L3.
+	 */
+	if (!has_vlan && sock->type == SOCK_RAW &&
+	    likely(skb->dev->type == ARPHRD_ETHER) &&
+	    skb->dev->min_header_len < skb->dev->hard_header_len)
+		skb_set_network_header(skb, skb->dev->min_header_len);
+
 	skb_probe_transport_header(skb);
 
 	/* Move network header to the right position for VLAN tagged packets */
-	if (likely(skb->dev->type == ARPHRD_ETHER) &&
-	    eth_type_vlan(skb->protocol) &&
+	if (has_vlan &&
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 }
-- 
2.43.0

