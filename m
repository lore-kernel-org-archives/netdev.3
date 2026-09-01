Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154B41378E;
	Tue,  1 Sep 2026 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248574; cv=none; b=YIc1I5TG3HQSMkPx26OGJy0jQJXUrffWtBmUcOttaWJspfwVniIfo3N6Mr9zBRDuTiD6BfB+w6uqJXWW4EIYYsi1k638bb8NPzIueHiPJAhgVmhOfoQxv8qUbgOniKjJiUOnInUgQz2NtZc9Y1a3WahF8jCQTY2hKJJhIsSZCj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248574; c=relaxed/simple;
	bh=boAq9UlSLVen/OoceZ6i8CG0+ilM9weU6jwKbKABuHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2H4DLr7NaLWPOzxDbdmhlIXl7MqVePte8pCxB7BQNDjTcpf2c642lpb4H2m+vQ2G8QdkgK0GiIsOlhw1jIHcW2CTqbg5XW1oR6olr15G3GLKrUDaBGW2tCJPt2sSSNwQe54Btlh4igpjiXB98W9gSXCtlGdWcyVz1n4R6W4E2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VbKlaiiG; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VbKlaiiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=iJ
	1HACajl7jRHSMfEPRFJKfQbbsmoWUbVzLWRle57Jg=; b=VbKlaiiGFQOToqHGFD
	nCFmoA7vEJV0xnQWrlsr0oT0hBNOOS3bhdNkxEizHd9WrPp7tFa7O2f04ENIyd1P
	hL6raUrby2EDa7SLqTdVC+FW6Z8cmPcK5ciX1WHEJELzg0nJVA0CLIS9hcrkX9SZ
	Mp2sBfbJYXihnlPNx9h1a3u74=
Received: from sky.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA30ITXgZZq7jdkSw--.38828S2;
	Tue, 01 Sep 2026 15:42:15 +0800 (CST)
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
Subject: [PATCH net v3] net/packet: fix network header offset for non-VLAN raw packets on VLAN subinterfaces
Date: Tue,  1 Sep 2026 15:42:14 +0800
Message-ID: <20260901074214.57717-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA30ITXgZZq7jdkSw--.38828S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF1DCw1UuF1kCF4rJrW7XFb_yoW7GF1Dpa
	yjkF9xGw4DGr1Svr4kKFsrJF45ZFs3Ga12g3yfJ340vF4q9FyFvFWxtF129FyUKFWrX34U
	Xr1jvF1Y9a1ktrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pipuWJUUUUU=
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbC7hfVa2qWgdd9vwAA3v

AF_PACKET SOCK_RAW sets skb network_header to dev->hard_header_len in
packet_snd(). On VLAN subinterfaces with software tag insertion,
hard_header_len includes space for the VLAN tag (ETH_HLEN + VLAN_HLEN =
18) while min_header_len is the on-wire Ethernet header length
(ETH_HLEN = 14). A non-VLAN SOCK_RAW frame carries a standard 14-byte
Ethernet header, so its L3 header sits at min_header_len, not
hard_header_len.

packet_parse_headers() only corrects network_header for VLAN-tagged
frames. For non-VLAN frames it leaves network_header at hard_header_len,
so the IP header is found VLAN_HLEN bytes too late and
inet_gso_segment() fails with -EINVAL.

Observed on a virtio_net NIC (KVM guest) that advertises
NETIF_F_HW_VLAN_CTAG_FILTER but not NETIF_F_HW_VLAN_CTAG_TX, so VLAN
subinterfaces use software tag insertion (hard_header_len = 18). An
AF_PACKET SOCK_RAW socket bound to the VLAN subinterface with
PACKET_VNET_HDR enabled sends a large IPv4/TCP frame exceeding the path
MTU, with gso_type set in the virtio-net header. The user frame is a
plain [ethhdr][IP...] layout without a VLAN tag;
vlan_dev_hard_start_xmit() only attaches the tag metadata via
__vlan_hwaccel_put_tag(), and validate_xmit_vlan() on the physical
device later inserts the actual tag bytes via
__vlan_hwaccel_push_inside(). With network_header stuck at 18 while the
real IP header is at ETH_HLEN (14), inet_gso_segment() reads a
misaligned ip_hdr(skb) and returns -EINVAL.

For non-VLAN SOCK_RAW frames on VLAN subinterfaces, set network_header
to min_header_len so that the L3/L4 header positions match the actual
on-the-wire frame.

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
v3:
- Use is_vlan_dev() instead of the min_header_len < hard_header_len
  heuristic to detect the affected device; the heuristic may have false
  positives for other protocols, and the ARPHRD_ETHER check excluded
  the other hard_header_len cases anyway, so scope the fix back to
  VLAN subinterfaces.
- Rename is_vlan to is_vlan_packet to disambiguate from is_vlan_dev().
- Correct where the tag is inserted: vlan_dev_hard_start_xmit() only
  attaches the tag metadata via __vlan_hwaccel_put_tag(); the tag
  bytes are inserted later by validate_xmit_vlan() on the physical
  device.
- Reword the subject and commit message back to the VLAN-subinterface
  scope.

v2: https://lore.kernel.org/all/20260831072034.40044-1-zhangjn_dev@163.com/
v1: https://lore.kernel.org/all/20260821085722.24036-1-zhangjn_dev@163.com/#t
---
 net/packet/af_packet.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 1168bd6b09cd..3bada38b3556 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1935,6 +1935,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 {
 	int depth;
+	bool is_vlan_packet = false;
 
 	/* On TX skb->data is the L2 header; anchor it for all socket types. */
 	skb_reset_mac_header(skb);
@@ -1943,11 +1944,28 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 	    sock->type == SOCK_RAW)
 		skb->protocol = dev_parse_header_protocol(skb);
 
+	if (likely(skb->dev->type == ARPHRD_ETHER)) {
+		is_vlan_packet = eth_type_vlan(skb->protocol);
+
+		/* For non-VLAN SOCK_RAW frames on VLAN subinterfaces with
+		 * software tag insertion, hard_header_len includes space
+		 * for the VLAN tag while min_header_len is the on-wire
+		 * Ethernet header length. The user frame carries a
+		 * standard Ethernet header, so its L3 sits at
+		 * min_header_len, not hard_header_len. Move
+		 * network_header to the actual L2/L3 boundary so the
+		 * transport header probe below and subsequent GSO see
+		 * the right L3.
+		 */
+		if (sock->type == SOCK_RAW && !is_vlan_packet &&
+		    is_vlan_dev(skb->dev))
+			skb_set_network_header(skb, skb->dev->min_header_len);
+	}
+
 	skb_probe_transport_header(skb);
 
 	/* Move network header to the right position for VLAN tagged packets */
-	if (likely(skb->dev->type == ARPHRD_ETHER) &&
-	    eth_type_vlan(skb->protocol) &&
+	if (is_vlan_packet &&
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 }
-- 
2.43.0

