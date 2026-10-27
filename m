Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089596;
	b=QpGrnAcc3BWPC62WJ0n2pkJUkTOVQgEYS2jkMXWmPzaXtNlNOLKXtwiK6sJmSbxCTE13
	 23y4I9xUxJbCOdzbCDTNnKqHiNs8J3tl0m3hOcdzgIXgvXxzWjBS6PxVxhM/vkqop9H/K
	 M6Pb04i143JUP0hLWV+9KoT0r6rHSAeF8xZ+htXqVjzMEt45H2JqYHQxMUjOlyuJkgAY/
	 efkIsEexSATJohYnCP50EloAz6awce+rXrwBLVFgWa8SKF2X/1V4dHckLLsbH4NGkEooK
	 PqttnCO85kvFYMBJXkijcYe8C2eg47QJN3eNRxRXEu3WsOqmYqVmHC8aOEkSBM5jCUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lMOB8IxsuqTcRshNhaiyOagp9O48aHtw6WZmfYPYk9o=;
	b=nG418Q1cdSv8LmyKDZAH93WrR7OEKI7WuYEuxJj24ClG+Vq/f5Ak2aL6Zhcxe8yZ/qiJ
	 PM3dSJaKWoZDliygfZfHPWSpeDZlZcXmRuFOk0SWr5bccSc4qrtdL3TY3tEqBIqTUtyR9
	 dd+WIVFzL1mMu71As74PCQyOhj8YqzVKcmgr/02eutqCojdBVs9CtdW7lW5Ckh1YzegG2
	 Z5xRKk+nemyumQKgXenSf51iH3gdRmw8wlIz7bMHqpBT14G4Llqv4ele8GGbNEe3Ih7rF
	 23xnPRzX89BBXKHx9fz7iZ+q2SJ5k1H6hBKoIy3qX8es1bVHBz8OsQX3W+VRjFeelfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8venhya;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56993606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i8venhya
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9071F01825;
	Tue, 27 Oct 2026 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793089596;
	bh=lMOB8IxsuqTcRshNhaiyOagp9O48aHtw6WZmfYPYk9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i8venhyaW5voLYHH9796Kc6jqNY2ArqNnbirH3N3QPofVgXFBs3JoqxhWPNzs2pRl
	 12O1FCmOtRTTgUk74pp0O7Jg1AwFyt0oIZnrXzAQuFk2ggM5wqgKHlczkLh+upEEtq
	 2VnGYFLyfEx//Mzcp6J1S6MLDxBalCEqF2xezXTmWhGcknXrQGKP8HFDh5VTgjx8fj
	 ekqeBpl88XcBu3ji9J7V3GvvOTiIZI5BRSlixElv6BVLbJzfVDN+MnTcJjq+2RMx0q
	 iAIn9uYAxWXVBgHbvp34lyvJSBE+pH4OeqsUYWN7iRGYn02AMyoDMohCztiVRp7R3g
	 h6uPu37FIg+WQ==
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
Subject: [PATCH net 3/5] net: use eth_type_trans_careful() in __dev_forward_skb2()
Date: Tue, 27 Oct 2026 09:26:02 +0100
Message-ID: <20261027082604.1485903-4-edumazet@kernel.org>
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

A tc egress BPF program can push a tiny link-layer header with
bpf_skb_change_head() on an skb whose head is almost empty, then
redirect it to an Ethernet device ingress. __bpf_redirect_common()
only checks mac_header < network_header, and __dev_forward_skb2()
crashes in eth_type_trans():

  tc filter add dev lo egress pref 1 matchall action vlan pop_eth continue
  tc filter add dev lo egress pref 2 bpf da obj prog.o
  # prog: bpf_skb_change_head(skb, 1, 0);
  #       return bpf_redirect(veth1_ifindex, BPF_F_INGRESS);
  # AF_PACKET SOCK_RAW on lo: eth / eth / 8192 bytes of payload

  kernel BUG at include/linux/skbuff.h:2839!
  RIP: 0010:eth_type_trans (include/linux/etherdevice.h:635 net/ethernet/eth.c:163)
  Call Trace:
   __dev_forward_skb2 (net/core/dev.c:2507)
   dev_forward_skb_nomtu (net/core/dev.c:2546)
   __dev_queue_xmit (net/core/dev.c:4738 net/core/dev.c:4998)
   packet_sendmsg (net/packet/af_packet.c:3157 net/packet/af_packet.c:3189)

Use eth_type_trans_careful(), and drop the packet if the Ethernet
header can not be pulled. This also covers other dev_forward_skb()
users (veth, macvlan, ipvlan, netdevsim, l2tp_eth).

Fixes: 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel infrastructure")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 net/core/dev.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1a09e7869118059e92b53e00ed873dfc7485ffc3..ac784310a69c1d9ceecf68909334196b555871c5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2501,14 +2501,22 @@ EXPORT_SYMBOL_GPL(is_skb_forwardable);
 static int __dev_forward_skb2(struct net_device *dev, struct sk_buff *skb,
 			      bool check_mtu)
 {
-	int ret = ____dev_forward_skb(dev, skb, check_mtu);
+	enum skb_drop_reason reason;
+	int ret;
+
+	ret = ____dev_forward_skb(dev, skb, check_mtu);
+	if (unlikely(ret))
+		return ret;
 
-	if (likely(!ret)) {
-		skb->protocol = eth_type_trans(skb, dev);
-		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
+	reason = eth_type_trans_careful(skb, dev);
+	if (unlikely(reason)) {
+		dev_core_stats_rx_dropped_inc(dev);
+		kfree_skb_reason(skb, reason);
+		return NET_RX_DROP;
 	}
+	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 
-	return ret;
+	return 0;
 }
 
 int __dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
-- 
2.53.0

