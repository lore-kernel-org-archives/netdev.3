Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867B4C33ED
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624730; cv=none; b=p4GvjT0gY8dWmG2QtUytPKdvXAklAuvAnU8z6pXeqNrWFyNTcBhyAaRmYYLco2VS9zsi45qQUgt0saUrB/t/5OcEFlgXteUOc0uqh0TjFHdaYuuEEgAqilWhlSmSVwnRkBJUieVzWqIhEpQdfKvvwrNn9yOtZI80V29XRDiQFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624730; c=relaxed/simple;
	bh=NY4plxob1QgUbaCen+v/0R+ek344biTN0+9oYlQErJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HEWKifFsWZ9dS8IuncAmyLyHi49w5vwTJx5BP+kEDdW+i0p2yzUiKmZmKawgeXVOikrZiY/IcSPEikwW3s2Yg2PgJ2bAjQpUnXMcuDvAybi1GZQ1/CNl93CsIBOX/A+fUXVJxd6P5WawvtK3wLV/ykchP+9Anzd0X8jQqPcgCNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYhvWuaS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYhvWuaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45851F000FF;
	Mon, 28 Sep 2026 19:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790624728;
	bh=jFQadxVCZXEO7GR933a/bxx0A6m5Tew4bcmPNVpV1FA=;
	h=From:To:Cc:Subject:Date;
	b=lYhvWuaSXh38cwdaN6bLrVp1WMeR7jEWIDY8wqXdFQUld25WNPv5WakBLcygDgmZ+
	 a47/iNl4l4gKBH++5dMMMZA5S0n5u4VPH9mYXMSHOPsYCL133xrSPOedCGHZtz/vL+
	 OLYj53QjJo9ViBVt5oyvBuZIOc45YP7v8rhBCAYUbBMlUkUzTuiEvnDZmyMWj7RDIc
	 4ZQN3s25erShN5B9TCEyx61sk3nJdplwDNWDMKRXOw1a0aqqQNDReq/mef/rCgT0N7
	 hZUonvJxqLVxCdPr9Pp6zxWNU24BHLwD0WeA8tW52ri5rb8hbc4w4U+/J3QUhhIGZE
	 XRyQffFGNIKVw==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org,
	edumazet@google.com,
	Eric Dumazet <edumazet@kernel.org>,
	syzbot+9408fbe0e6452a12e9ab@syzkaller.appspotmail.com
Subject: [PATCH net] ipv6: sr: use skb_get_hash_net() in seg6_make_flowlabel()
Date: Mon, 28 Sep 2026 19:45:24 +0000
Message-ID: <20260928194524.3617299-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit d58e468b1112 ("flow_dissector: implements flow dissector
BPF hook") __skb_flow_dissect() needs a net pointer, either from
skb->dev, skb->sk, or since commit 3cbf4ffba5ee ("net: plumb network
namespace into __skb_flow_dissect") a caller provided pointer.

syzbot was able to reach seg6_make_flowlabel() with an skb having
neither skb->dev nor skb->sk set: a TIPC UDP bearer sends a discovery
message through an IPv4 route using seg6 encap, while
net.ipv6.seg6_flowlabel is set to 1.

seg6_make_flowlabel() already has a net pointer, use skb_get_hash_net().

WARNING: net/core/flow_dissector.c:1131 at __skb_flow_dissect+0x910/0x5368 net/core/flow_dissector.c:1126, CPU#0: syz.0.17/4930
Call trace:
  __skb_flow_dissect+0x910/0x5368 net/core/flow_dissector.c:1126 (P)
  __skb_get_hash_net+0xe0/0x29c net/core/flow_dissector.c:1903
  skb_get_hash include/linux/skbuff.h:1663 [inline]
  seg6_make_flowlabel+0xcc/0x1ec net/ipv6/seg6_iptunnel.c:132
  __seg6_do_srh_encap+0x320/0xbf4 net/ipv6/seg6_iptunnel.c:161
  seg6_do_srh+0x4b4/0xa44 net/ipv6/seg6_iptunnel.c:431
  seg6_output_core+0x164/0x688 net/ipv6/seg6_iptunnel.c:681
  seg6_output+0x44/0x1ac net/ipv6/seg6_iptunnel.c:744
  lwtunnel_output+0x3d0/0x664 net/core/lwtunnel.c:356
  dst_output include/net/dst.h:470 [inline]
  ip_local_out+0x110/0x148 net/ipv4/ip_output.c:131
  iptunnel_xmit+0x50c/0xd38 net/ipv4/ip_tunnel_core.c:97
  udp_tunnel_xmit_skb+0x220/0x348 net/ipv4/udp_tunnel_core.c:187
  tipc_udp_xmit+0x75c/0x9c0 net/tipc/udp_media.c:202
  tipc_udp_send_msg+0x214/0x374 net/tipc/udp_media.c:274
  tipc_bearer_xmit_skb+0x260/0x3b0 net/tipc/bearer.c:576
  tipc_enable_bearer net/tipc/bearer.c:366 [inline]
  __tipc_nl_bearer_enable+0xc90/0xfb0 net/tipc/bearer.c:1048
  tipc_nl_bearer_enable+0x2c/0x48 net/tipc/bearer.c:1057
  genl_family_rcv_msg_doit+0x1e4/0x2d4 net/netlink/genetlink.c:1114

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Reported-by: syzbot+9408fbe0e6452a12e9ab@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6abac2eb.3654fce1.1bec97.0000.GAE@google.com/
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/ipv6/seg6_iptunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 61c6a27bf202dd88b401fc33cee7bbfeecc0f531..7cbe0685f8bb9fa34c4611dd9dc3397d112e73b4 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -129,7 +129,7 @@ static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
 	u32 hash;
 
 	if (do_flowlabel > 0) {
-		hash = skb_get_hash(skb);
+		hash = skb_get_hash_net(net, skb);
 		hash = rol32(hash, 16);
 		flowlabel = (__force __be32)hash & IPV6_FLOWLABEL_MASK;
 	} else if (!do_flowlabel && skb->protocol == htons(ETH_P_IPV6)) {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

