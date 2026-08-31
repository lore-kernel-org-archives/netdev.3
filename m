Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E73C0611;
	Mon, 31 Aug 2026 07:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160879; cv=none; b=aFAP/Z9gsttLd9PxCQei5fXJW9XFsXjV6BTx2aqGlwmhHx9B2ksfUdtexlOjAjwmi30Zyxk0qN1TrsICvilzuP3TucVaIZc2ms4CxtYXoTKU14G/tnEtutVfj6GO0AdDTVSuinaUQVqx4P4qD+ZhrRg3w4DkmvBRhqbsGwJ09L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160879; c=relaxed/simple;
	bh=XyoHHvsJA41SZYgs8/nta7xlAPK5pWTv6C7xxAqrDtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lN46QJ1fckycWLIIeo+blWv/lz+PVrRCVZ+GCSyWRW+253ZmFrsMCMfRJG5sKiJKfgsbKaHzTtjQnN7/b9iZfp6NTT3e6u5alB9WMZ0/+JexdTZ0+1NUc25f6dKfNPPdc4zNQ+dqsIIZbi9g5r3as0u+pLFacLsIU8pZAr4yT/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YzBuhZDV; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YzBuhZDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=FT
	qzPuH+I54g2gIsoOIEDIxySICos/OCg8sIuuqGMts=; b=YzBuhZDVQsT4fzi4iM
	9hZxJBpU+PXaAYdoXl2fRsbTpCPLp4UyBvRzgMR+rsOGlJC5A388dlo+rAsifvXZ
	N+eqz6liKGgVQqrup57MJzoJZlmcyjn0QU/2G0EYG6uz7WbMh/3QB/PIWOahTwHC
	r9g+IzGYg2jZgdU5+YzT8LLhc=
Received: from sky.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBHxPJCK5VqvJB+Nw--.10420S2;
	Mon, 31 Aug 2026 15:20:35 +0800 (CST)
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
Subject: [PATCH net v2] net/packet: fix network header offset for non-VLAN raw packets
Date: Mon, 31 Aug 2026 15:20:34 +0800
Message-ID: <20260831072034.40044-1-zhangjn_dev@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBHxPJCK5VqvJB+Nw--.10420S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF13Kr4rKrWUCryfXr13Arb_yoW7XF4rp3
	W2kF9xJw4DGr1akr4vqFsxJF4YvFs3G3W2gFWfX3409Fs8uFyrAFyxtF42gFyUKFWrW34U
	Xr1qv3W5Ca1ktrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piW89tUUUUU=
X-CM-SenderInfo: x2kd0wxmqbvvry6rljoofrz/xtbCxQPacGqVK0N8hQAA3C

AF_PACKET SOCK_RAW sets skb network_header to dev->hard_header_len in
packet_snd(). For Ethernet devices whose hard_header_len exceeds the
on-wire L2 header length (min_header_len = ETH_HLEN) -- e.g.
software-offload VLAN subinterfaces, where hard_header_len = ETH_HLEN +
VLAN_HLEN = 18 -- a non-VLAN SOCK_RAW frame still carries a standard
14-byte Ethernet header, so its L3 header sits at min_header_len, not
hard_header_len.

packet_parse_headers() only corrects network_header for VLAN-tagged
frames. For non-VLAN frames it leaves network_header at hard_header_len,
so the IP header is found (hard_header_len - min_header_len) bytes too
late and inet_gso_segment() fails with -EINVAL.

Observed on a virtio_net NIC (KVM guest) that advertises
NETIF_F_HW_VLAN_CTAG_FILTER but not NETIF_F_HW_VLAN_CTAG_TX, so VLAN
subinterfaces use software tag insertion (hard_header_len = 18). An
AF_PACKET SOCK_RAW socket bound to the VLAN subinterface with
PACKET_VNET_HDR enabled sends a large IPv4/TCP frame exceeding the path
MTU, with gso_type set in the virtio-net header. The user frame is a
plain [ethhdr][IP...] layout without a VLAN tag; the VLAN subdevice
inserts the 802.1Q tag in vlan_dev_hard_start_xmit(). With
network_header stuck at 18 while the real IP header is at ETH_HLEN (14),
inet_gso_segment() reads a misaligned ip_hdr(skb) and returns -EINVAL.

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
v2:
- Drop "on VLAN subinterfaces" from the subject and reword the scope to
  Ethernet devices whose hard_header_len exceeds the on-wire L2 header
  length (min_header_len). The min_header_len < hard_header_len test is
  not VLAN-specific; it also covers Ethernet drivers that reserve extra
  hard_header_len space for driver-internal wrapping.
- Restructure packet_parse_headers() to test dev->type once; replace
  has_vlan, which mixed the device and packet tests, with the
  packet-only is_vlan.
- Describe the header offset error generically as (hard_header_len -
  min_header_len) bytes instead of hard-coding the 4-byte VLAN case.
- Document the reproducer: virtio_net advertising
  NETIF_F_HW_VLAN_CTAG_FILTER but not NETIF_F_HW_VLAN_CTAG_TX, with
  PACKET_VNET_HDR and GSO triggering the -EINVAL from
  inet_gso_segment().

v1: https://lore.kernel.org/all/20260821085722.24036-1-zhangjn_dev@163.com/#t
---
 net/packet/af_packet.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 1168bd6b09cd..be5bf9db7ea1 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1935,6 +1935,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
 static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 {
 	int depth;
+	bool is_vlan = false;
 
 	/* On TX skb->data is the L2 header; anchor it for all socket types. */
 	skb_reset_mac_header(skb);
@@ -1943,11 +1944,28 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
 	    sock->type == SOCK_RAW)
 		skb->protocol = dev_parse_header_protocol(skb);
 
+	if (likely(skb->dev->type == ARPHRD_ETHER)) {
+		is_vlan = eth_type_vlan(skb->protocol);
+
+		/* For non-VLAN SOCK_RAW frames on Ethernet devices whose
+		 * hard_header_len exceeds the on-wire L2 header length
+		 * (min_header_len) -- e.g. software-offload VLAN subinterfaces,
+		 * or Ethernet drivers that reserve extra space in
+		 * hard_header_len for driver-internal wrapping -- the SOCK_RAW
+		 * send paths leave network_header at hard_header_len, while the
+		 * user frame's L3 sits at min_header_len. Move network_header
+		 * to the actual L2/L3 boundary so the transport header probe
+		 * below and subsequent GSO see the right L3.
+		 */
+		if (!is_vlan && sock->type == SOCK_RAW &&
+		    skb->dev->min_header_len < skb->dev->hard_header_len)
+			skb_set_network_header(skb, skb->dev->min_header_len);
+	}
+
 	skb_probe_transport_header(skb);
 
 	/* Move network header to the right position for VLAN tagged packets */
-	if (likely(skb->dev->type == ARPHRD_ETHER) &&
-	    eth_type_vlan(skb->protocol) &&
+	if (is_vlan &&
 	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
 		skb_set_network_header(skb, depth);
 }
-- 
2.43.0

