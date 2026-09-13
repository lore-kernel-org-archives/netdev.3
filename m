Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D2397E9A
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 03:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789271415; cv=none; b=q+21HXWFfYjX+iArNbfxOc3jpl4CsBYk742ORDTUPDyCbTKXFnLHP0BHNRL/NzHyoHCCAmo6ERaWXkoI10B679s7c5bJsS1H5pFGh36YgTPFYlcCSaMa2nKbg/fp+OTzoNngaa3ReTyyXNsZ4tDdNkGRbbwcDOK3/vglbiACwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789271415; c=relaxed/simple;
	bh=ZKzuOEDOFX7gx1ZtBwNTWWDeAelY+eS5O399Nzpmhps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ggx/OQJKVCs7Wmk+1FRfJv5CvGjcv6OSrtBK7BaDOZvBDMUXBOCqkrHFckpdgMKcW+fOD7dLo1TWK9XpIRkrkEJ51B21d1BMDVipmi08GTr92SWfuLYtQBSQB8eEXdbv7aQl+ey0l175NVk7xC/lgyLZbGRq6JBQA7ZUAoRvbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuWYKgd9; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuWYKgd9"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff17443dso12695691fa.1
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 20:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789271410; x=1789876210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l3g8q3TyEM0z+Vg+W2FsBr1zsUMst4iQ9kOdl9YDWuA=;
        b=iuWYKgd97zuJtCpOmXh/O6uG2l8fMRv1TXcRMQ6eNDb8arXKRtEvNmzkIAA8O1D+kl
         07A1uu1R25p/l4ABadqbLrEDOq1LEr08fGzM5GJr+OB93xL2+/yeCMYwqC3j+z1lN9/0
         WS1V5jqYMa2bEdicu3wlLhZwZtF1BiGqg2SvpxHQjKr/d3EHaaHckmSjs0PUdSK/HpeV
         aE10iVRdJ2fr6xfEKygrdbmr4LlDLghWTOQcgbCcSn5hBBItxqM1Dqk/cyf77obmLvAz
         GcIbMEWbtrP8x0EUlRN6ailJ04WvcjMBwnnO6PIYZKKwlcPji3RNuQjeCGyGjx0swUG1
         w3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789271410; x=1789876210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=l3g8q3TyEM0z+Vg+W2FsBr1zsUMst4iQ9kOdl9YDWuA=;
        b=FEr0KIgAVhaW9SV8v92NUGxTCJHaQlbhyuhsQhSqdjAKJ3AjDyjHi4KLSCqq5jIaW+
         BS+zPqbyQrpQ7m01xyvwV+IoVrmIw2+JW4KlVR57BeIxHuUv3FFXVh7KOBn5NGVgkelk
         S+BCPQLLkingv4yxe1lL/17+0dyWK3qG58c2bwjhBpHcZa0NvcbCHSJwhiX/M8XaIdj9
         H9ZwobMVV3xQ5o3WYR3GD5iBJPmPw5tiCcQjPzj5Rw12pWiTAu2m6K5FBSp11pUSqP8N
         y6DhdeKifFh08oBablwgjARb7vi7dm8iMx5uxvRSstGN27nmioRhB+D1CtsahCxsroAK
         5x0w==
X-Gm-Message-State: AFuF++n5LqCX8Q4a56Pzsx8on0zW0h34YoXu3+HJ+xwPqJWml0Kveye4
	oezu2thrUd9qHo9WXEG79/5m8I+z0fk+U2Gsc7ms0ieff+bIw1yaKIcdKk8FtgRZ9PE=
X-Gm-Gg: AYBFou3OU9EHNbtGxjHUalvAQsVQsJbjhpxzpfmbMChlo2DcEIf1LOcpg1yGhfsPUyk
	n2RBKaFBGENRx913D2CEc+ajtR04djyD4EAfseTOcQx0eaEFeuZzbNwmTnSeNg6hEJGkm3/2v6Z
	RJbHYvhRbFt96/6GP4ycXb7CQKH3hi3jd9mbNDuu5a5tqolDkBMVNWNHvUzqa9C1hK+MB3oUZ6K
	IycWKFwKxE4UxQPIGdU2IwTmEcP49W9zcn3TQuSckBmTUIRb1Cy1vVlhKxYwWssXDoVZjkyMyfh
	qUyJ3p5ZYAjUSEnK31iUGkZecQvUoI+LVg3dLXPdpjzBjGUHo+ryc1e7MQjacwbsVXMIzhL34Kp
	mv72MiNoBHk86EcWSH8ccVpUH+WQfYwH9d1Cj7nh572I6VJjETLw4jAIO1C6zA/eAJFYAr+bfxG
	soJCK+PB5pFjZXTpUG8wzdLzFMvjImooDLgeiePdXnu+Z4NxFvk2Ch5xbcPQe6pflUmfu1fVEqS
	863YtlFalJvXRAN3po5sEXHKmP000Lr/GoWwMjopipr
X-Received: by 2002:a2e:bc02:0:b0:39c:624d:82b9 with SMTP id 38308e7fff4ca-3a5a4ff7e62mr30202781fa.4.1789271410359;
        Sat, 12 Sep 2026 20:50:10 -0700 (PDT)
Received: from dau-home-pc.. ([95.139.134.117])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a5a332737dsm17277051fa.22.2026.09.12.20.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 20:50:09 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 8/8] ip6_tunnel: add drop reasons to the transmit path
Date: Sun, 13 Sep 2026 06:49:37 +0300
Message-ID: <20260913034937.875068-9-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913034937.875068-1-littlesmilingcloud@gmail.com>
References: <20260913034937.875068-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do for the IPv6 tunnels what the previous patches did for the IPv4 ones.
The situation is the same, with one difference: ip6_tnl_xmit() does not
free the packet itself, it returns an error and the callers do, so the
reason has to travel with it.  Give it an output parameter, and pass it
down through ipxip6_tnl_xmit(), __gre6_xmit() and the three
ip6gre_xmit_*() helpers to the two places that actually drop.

ip6_gre is converted in the same patch because it calls ip6_tnl_xmit()
and would not build otherwise.

The reasons are the ones already used on the IPv4 side:
SKB_DROP_REASON_PKT_TOO_BIG for a packet that exceeds the path MTU,
SKB_DROP_REASON_IP_OUTNOROUTES for the route lookups,
SKB_DROP_REASON_RECURSION_LIMIT for a route pointing back at the tunnel,
SKB_DROP_REASON_NOMEM for the allocations, SKB_DROP_REASON_TUNNEL_TXINFO
for the collect_md metadata checks and SKB_DROP_REASON_NEIGH_CREATEFAIL
for the neighbour lookup.  Two more fit here:
SKB_DROP_REASON_DEV_READY when ip6_tnl_xmit_ctl() refuses the transmit,
and SKB_DROP_REASON_IPV6_BAD_EXTHDR when the tunnel encapsulation limit
option leaves no room for another header.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/ip6_tunnel.h |   3 +-
 net/ipv6/ip6_gre.c       | 121 ++++++++++++++++++++++++++++-----------
 net/ipv6/ip6_tunnel.c    |  73 +++++++++++++++++------
 3 files changed, 142 insertions(+), 55 deletions(-)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index b99805ee2fd1..95f6d12254df 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -143,7 +143,8 @@ int ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 int ip6_tnl_xmit_ctl(struct ip6_tnl *t, const struct in6_addr *laddr,
 		     const struct in6_addr *raddr);
 int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
-		 struct flowi6 *fl6, int encap_limit, __u32 *pmtu, __u8 proto);
+		 struct flowi6 *fl6, int encap_limit, __u32 *pmtu, __u8 proto,
+		 enum skb_drop_reason *reason);
 __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw);
 __u32 ip6_tnl_get_cap(struct ip6_tnl *t, const struct in6_addr *laddr,
 			     const struct in6_addr *raddr);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 047c4f57a828..a510be5ad702 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -734,7 +734,8 @@ static struct ip_tunnel_info *skb_tunnel_info_txcheck(struct sk_buff *skb)
 static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 			       struct net_device *dev, __u8 dsfield,
 			       struct flowi6 *fl6, int encap_limit,
-			       __u32 *pmtu, __be16 proto)
+			       __u32 *pmtu, __be16 proto,
+			       enum skb_drop_reason *reason)
 {
 	struct ip6_tnl *tunnel = netdev_priv(dev);
 	IP_TUNNEL_DECLARE_FLAGS(flags);
@@ -758,8 +759,10 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 
 		tun_info = skb_tunnel_info_txcheck(skb);
 		if (IS_ERR(tun_info) ||
-		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6))
+		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6)) {
+			*reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			return -EINVAL;
+		}
 
 		key = &tun_info->key;
 		memset(fl6, 0, sizeof(*fl6));
@@ -777,8 +780,11 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 		ip_tunnel_flags_and(flags, flags, key->tun_flags);
 		tun_hlen = gre_calc_hlen(flags);
 
-		if (skb_cow_head(skb, dev->needed_headroom ?: tun_hlen + tunnel->encap_hlen))
+		if (skb_cow_head(skb, dev->needed_headroom ?:
+				 tun_hlen + tunnel->encap_hlen)) {
+			*reason = SKB_DROP_REASON_NOMEM;
 			return -ENOMEM;
+		}
 
 		gre_build_header(skb, tun_hlen,
 				 flags, protocol,
@@ -788,8 +794,10 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 				 0);
 
 	} else {
-		if (skb_cow_head(skb, dev->needed_headroom ?: tunnel->hlen))
+		if (skb_cow_head(skb, dev->needed_headroom ?: tunnel->hlen)) {
+			*reason = SKB_DROP_REASON_NOMEM;
 			return -ENOMEM;
+		}
 
 		ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
 
@@ -801,10 +809,11 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 	}
 
 	return ip6_tnl_xmit(skb, dev, dsfield, fl6, encap_limit, pmtu,
-			    NEXTHDR_GRE);
+			    NEXTHDR_GRE, reason);
 }
 
-static inline int ip6gre_xmit_ipv4(struct sk_buff *skb, struct net_device *dev)
+static inline int ip6gre_xmit_ipv4(struct sk_buff *skb, struct net_device *dev,
+				   enum skb_drop_reason *reason)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	int encap_limit = -1;
@@ -821,11 +830,13 @@ static inline int ip6gre_xmit_ipv4(struct sk_buff *skb, struct net_device *dev)
 
 	err = gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
 						t->parms.o_flags));
-	if (err)
+	if (err) {
+		*reason = SKB_DROP_REASON_NOMEM;
 		return -1;
+	}
 
 	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
-			  skb->protocol);
+			  skb->protocol, reason);
 	if (err != 0) {
 		/* XXX: send ICMP error even if DF is not set. */
 		if (err == -EMSGSIZE)
@@ -837,7 +848,8 @@ static inline int ip6gre_xmit_ipv4(struct sk_buff *skb, struct net_device *dev)
 	return 0;
 }
 
-static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev)
+static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev,
+				   enum skb_drop_reason *reason)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
@@ -847,19 +859,25 @@ static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev)
 	__u32 mtu;
 	int err;
 
-	if (ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr))
+	if (ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr)) {
+		*reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		return -1;
+	}
 
 	if (!t->parms.collect_md &&
-	    prepare_ip6gre_xmit_ipv6(skb, dev, &fl6, &dsfield, &encap_limit))
+	    prepare_ip6gre_xmit_ipv6(skb, dev, &fl6, &dsfield, &encap_limit)) {
+		*reason = SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 		return -1;
+	}
 
 	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
-					      t->parms.o_flags)))
+					      t->parms.o_flags))) {
+		*reason = SKB_DROP_REASON_NOMEM;
 		return -1;
+	}
 
 	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit,
-			  &mtu, skb->protocol);
+			  &mtu, skb->protocol, reason);
 	if (err != 0) {
 		if (err == -EMSGSIZE)
 			icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
@@ -869,7 +887,8 @@ static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev)
 	return 0;
 }
 
-static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
+static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev,
+			     enum skb_drop_reason *reason)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	int encap_limit = -1;
@@ -879,14 +898,19 @@ static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
 	int err;
 
 	if (!t->parms.collect_md &&
-	    prepare_ip6gre_xmit_other(skb, dev, &fl6, &dsfield, &encap_limit))
+	    prepare_ip6gre_xmit_other(skb, dev, &fl6, &dsfield, &encap_limit)) {
+		*reason = SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 		return -1;
+	}
 
 	err = gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
 						t->parms.o_flags));
-	if (err)
+	if (err) {
+		*reason = SKB_DROP_REASON_NOMEM;
 		return err;
-	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu, skb->protocol);
+	}
+	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
+			  skb->protocol, reason);
 
 	return err;
 }
@@ -894,16 +918,20 @@ static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
 static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	struct net_device *dev)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
 	__be16 payload_protocol;
 	int ret;
 
-	if (!pskb_inet_may_pull(skb))
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason)
 		goto tx_err;
 
-	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
+	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr)) {
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto tx_err;
+	}
 
 	if (t->parms.collect_md)
 		tun_info = skb_tunnel_info_txcheck(skb);
@@ -911,13 +939,13 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	payload_protocol = skb_protocol(skb, true);
 	switch (payload_protocol) {
 	case htons(ETH_P_IP):
-		ret = ip6gre_xmit_ipv4(skb, dev);
+		ret = ip6gre_xmit_ipv4(skb, dev, &reason);
 		break;
 	case htons(ETH_P_IPV6):
-		ret = ip6gre_xmit_ipv6(skb, dev);
+		ret = ip6gre_xmit_ipv6(skb, dev, &reason);
 		break;
 	default:
-		ret = ip6gre_xmit_other(skb, dev);
+		ret = ip6gre_xmit_other(skb, dev, &reason);
 		break;
 	}
 
@@ -930,13 +958,14 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	if (!IS_ERR(tun_info))
 		DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
 static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					 struct net_device *dev)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct dst_entry *dst = skb_dst(skb);
@@ -950,18 +979,25 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	__u32 mtu;
 	int nhoff;
 
-	if (!pskb_inet_may_pull(skb))
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason)
 		goto tx_err;
 
-	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
+	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr)) {
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto tx_err;
+	}
 
-	if (gre_handle_offloads(skb, false))
+	if (gre_handle_offloads(skb, false)) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_err;
+	}
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
-		if (pskb_trim(skb, dev->mtu + dev->hard_header_len))
+		if (pskb_trim(skb, dev->mtu + dev->hard_header_len)) {
+			reason = SKB_DROP_REASON_NOMEM;
 			goto tx_err;
+		}
 		truncate = true;
 	}
 
@@ -981,8 +1017,10 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			truncate = true;
 	}
 
-	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen))
+	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen)) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_err;
+	}
 
 	IPCB(skb)->flags = 0;
 
@@ -996,8 +1034,10 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 
 		tun_info = skb_tunnel_info_txcheck(skb);
 		if (IS_ERR(tun_info) ||
-		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6))
+		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			goto tx_err;
+		}
 
 		key = &tun_info->key;
 		memset(&fl6, 0, sizeof(fl6));
@@ -1009,10 +1049,14 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 
 		dsfield = key->tos;
 		if (!test_bit(IP_TUNNEL_ERSPAN_OPT_BIT,
-			      tun_info->key.tun_flags))
+			      tun_info->key.tun_flags)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			goto tx_err;
-		if (tun_info->options_len < sizeof(*md))
+		}
+		if (tun_info->options_len < sizeof(*md)) {
+			reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			goto tx_err;
+		}
 		md = ip_tunnel_info_opts(tun_info);
 
 		tun_id = tunnel_id_to_key32(key->tun_id);
@@ -1030,6 +1074,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					       truncate, false);
 			proto = htons(ETH_P_ERSPAN2);
 		} else {
+			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 			goto tx_err;
 		}
 	} else {
@@ -1040,11 +1085,16 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 						 &dsfield, &encap_limit);
 			break;
 		case htons(ETH_P_IPV6):
-			if (ipv6_addr_equal(&t->parms.raddr, &ipv6_hdr(skb)->saddr))
+			if (ipv6_addr_equal(&t->parms.raddr,
+					    &ipv6_hdr(skb)->saddr)) {
+				reason = SKB_DROP_REASON_RECURSION_LIMIT;
 				goto tx_err;
+			}
 			if (prepare_ip6gre_xmit_ipv6(skb, dev, &fl6,
-						     &dsfield, &encap_limit))
+						     &dsfield, &encap_limit)) {
+				reason = SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 				goto tx_err;
+			}
 			break;
 		default:
 			memcpy(&fl6, &t->fl.u.ip6, sizeof(fl6));
@@ -1063,6 +1113,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 					       truncate, false);
 			proto = htons(ETH_P_ERSPAN2);
 		} else {
+			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 			goto tx_err;
 		}
 
@@ -1081,7 +1132,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
-			   NEXTHDR_GRE);
+			   NEXTHDR_GRE, &reason);
 	if (err != 0) {
 		/* XXX: send ICMP error even if DF is not set. */
 		if (err == -EMSGSIZE) {
@@ -1100,7 +1151,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	if (!IS_ERR(tun_info))
 		DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 458ce328311b..d804c67c4be3 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1097,6 +1097,7 @@ EXPORT_SYMBOL_GPL(ip6_tnl_xmit_ctl);
  *   @encap_limit: encapsulation limit
  *   @pmtu: Path MTU is stored if packet is too big
  *   @proto: next header value
+ *   @reason: drop reason, only written when the packet is dropped
  *
  * Description:
  *   Build new header and do some sanity checks on the packet before sending
@@ -1110,7 +1111,7 @@ EXPORT_SYMBOL_GPL(ip6_tnl_xmit_ctl);
 
 int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		 struct flowi6 *fl6, int encap_limit, __u32 *pmtu,
-		 __u8 proto)
+		 __u8 proto, enum skb_drop_reason *reason)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct net *net = t->net;
@@ -1143,13 +1144,17 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 			struct neighbour *neigh;
 			int addr_type;
 
-			if (!skb_dst(skb))
+			if (!skb_dst(skb)) {
+				*reason = SKB_DROP_REASON_NO_TX_TARGET;
 				goto tx_err_link_failure;
+			}
 
 			neigh = dst_neigh_lookup(skb_dst(skb),
 						 &ipv6_hdr(skb)->daddr);
-			if (!neigh)
+			if (!neigh) {
+				*reason = SKB_DROP_REASON_NEIGH_CREATEFAIL;
 				goto tx_err_link_failure;
+			}
 
 			addr6 = (struct in6_addr *)&neigh->primary_key;
 			addr_type = ipv6_addr_type(addr6);
@@ -1162,8 +1167,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		} else if (payload_protocol == htons(ETH_P_IP)) {
 			const struct rtable *rt = skb_rtable(skb);
 
-			if (!rt)
+			if (!rt) {
+				*reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 				goto tx_err_link_failure;
+			}
 
 			if (rt->rt_gw_family == AF_INET6)
 				memcpy(&fl6->daddr, &rt->rt_gw6, sizeof(fl6->daddr));
@@ -1180,8 +1187,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	if (use_cache)
 		dst = dst_cache_get(&t->dst_cache);
 
-	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr))
+	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr)) {
+		*reason = SKB_DROP_REASON_DEV_READY;
 		goto tx_err_link_failure;
+	}
 
 	if (!dst) {
 route_lookup:
@@ -1190,18 +1199,23 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 
 		dst = ip6_route_output(net, NULL, fl6);
 
-		if (dst->error)
+		if (dst->error) {
+			*reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_err_link_failure;
+		}
 		dst = xfrm_lookup(net, dst, flowi6_to_flowi(fl6), NULL, 0);
 		if (IS_ERR(dst)) {
 			err = PTR_ERR(dst);
 			dst = NULL;
+			*reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_err_link_failure;
 		}
 		if (t->parms.collect_md && ipv6_addr_any(&fl6->saddr) &&
 		    ipv6_dev_get_saddr(net, ip6_dst_idev(dst)->dev,
-				       &fl6->daddr, 0, &fl6->saddr))
+				       &fl6->daddr, 0, &fl6->saddr)) {
+			*reason = SKB_DROP_REASON_NO_TX_TARGET;
 			goto tx_err_link_failure;
+		}
 		ndst = dst;
 	}
 
@@ -1211,6 +1225,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		DEV_STATS_INC(dev, collisions);
 		net_warn_ratelimited("%s: Local routing loop detected!\n",
 				     t->parms.name);
+		*reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		goto tx_err_dst_release;
 	}
 	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
@@ -1225,6 +1240,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	if (skb->len - t->tun_hlen - eth_hlen > mtu && !skb_is_gso(skb)) {
 		*pmtu = mtu;
 		err = -EMSGSIZE;
+		*reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		goto tx_err_dst_release;
 	}
 
@@ -1247,12 +1263,16 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 */
 	max_headroom += LL_RESERVED_SPACE(tdev);
 
-	if (skb_cow_head(skb, max_headroom))
+	if (skb_cow_head(skb, max_headroom)) {
+		*reason = SKB_DROP_REASON_NOMEM;
 		goto tx_err_dst_release;
+	}
 
 	if (t->parms.collect_md) {
-		if (t->encap.type != TUNNEL_ENCAP_NONE)
+		if (t->encap.type != TUNNEL_ENCAP_NONE) {
+			*reason = SKB_DROP_REASON_TNL_ENCAP;
 			goto tx_err_dst_release;
+		}
 	} else {
 		if (use_cache && ndst)
 			dst_cache_set_ip6(&t->dst_cache, ndst, &fl6->saddr);
@@ -1276,8 +1296,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
 	err = ip6_tnl_encap(skb, t, &proto, fl6);
-	if (err)
+	if (err) {
+		*reason = SKB_DROP_REASON_TNL_ENCAP;
 		return err;
+	}
 
 	if (encap_limit >= 0) {
 		init_tel_txopt(&opt, encap_limit);
@@ -1306,7 +1328,7 @@ EXPORT_SYMBOL(ip6_tnl_xmit);
 
 static inline int
 ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
-		u8 protocol)
+		u8 protocol, enum skb_drop_reason *reason)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct ipv6hdr *ipv6h;
@@ -1320,8 +1342,10 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 	int err;
 
 	tproto = READ_ONCE(t->parms.proto);
-	if (tproto != protocol && tproto != 0)
+	if (tproto != protocol && tproto != 0) {
+		*reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 		return -1;
+	}
 
 	if (t->parms.collect_md) {
 		struct ip_tunnel_info *tun_info;
@@ -1329,8 +1353,10 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 
 		tun_info = skb_tunnel_info(skb);
 		if (unlikely(!tun_info || !(tun_info->mode & IP_TUNNEL_INFO_TX) ||
-			     ip_tunnel_info_af(tun_info) != AF_INET6))
+			     ip_tunnel_info_af(tun_info) != AF_INET6)) {
+			*reason = SKB_DROP_REASON_TUNNEL_TXINFO;
 			return -1;
+		}
 		key = &tun_info->key;
 		memset(&fl6, 0, sizeof(fl6));
 		fl6.flowi6_proto = protocol;
@@ -1367,6 +1393,7 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 				if (tel->encap_limit == 0) {
 					icmpv6_ndo_send(skb, ICMPV6_PARAMPROB,
 							ICMPV6_HDR_FIELD, offset + 2);
+					*reason = SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 					return -1;
 				}
 				encap_limit = tel->encap_limit - 1;
@@ -1408,13 +1435,15 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 	fl6.flowi6_uid = sock_net_uid(dev_net(dev), NULL);
 	dsfield = INET_ECN_encapsulate(dsfield, orig_dsfield);
 
-	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
+	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6)) {
+		*reason = SKB_DROP_REASON_NOMEM;
 		return -1;
+	}
 
 	skb_set_inner_ipproto(skb, protocol);
 
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
-			   protocol);
+			   protocol, reason);
 	if (err != 0) {
 		/* XXX: send ICMP error even if DF is not set. */
 		if (err == -EMSGSIZE)
@@ -1429,6 +1458,7 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 			default:
 				break;
 			}
+		*reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		return -1;
 	}
 
@@ -1438,11 +1468,13 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 static netdev_tx_t
 ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip6_tnl *t = netdev_priv(dev);
 	u8 ipproto;
 	int ret;
 
-	if (!pskb_inet_may_pull(skb))
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason)
 		goto tx_err;
 
 	switch (skb->protocol) {
@@ -1450,18 +1482,21 @@ ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		ipproto = IPPROTO_IPIP;
 		break;
 	case htons(ETH_P_IPV6):
-		if (ip6_tnl_addr_conflict(t, ipv6_hdr(skb)))
+		if (ip6_tnl_addr_conflict(t, ipv6_hdr(skb))) {
+			reason = SKB_DROP_REASON_RECURSION_LIMIT;
 			goto tx_err;
+		}
 		ipproto = IPPROTO_IPV6;
 		break;
 	case htons(ETH_P_MPLS_UC):
 		ipproto = IPPROTO_MPLS;
 		break;
 	default:
+		reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 		goto tx_err;
 	}
 
-	ret = ipxip6_tnl_xmit(skb, dev, ipproto);
+	ret = ipxip6_tnl_xmit(skb, dev, ipproto, &reason);
 	if (ret < 0)
 		goto tx_err;
 
@@ -1470,7 +1505,7 @@ ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
 tx_err:
 	DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
-- 
2.47.3

