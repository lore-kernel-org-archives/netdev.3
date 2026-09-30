Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5851E44B
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793586; cv=none; b=MPKKp11dphG3YJUPvhwaNICkxYot3dz6YMWmZfK+rBeoWfLboF9R3iJmHuBZ9IygZ5sBrfHhJJ5A9BuuVq2Fe0fPUuLribmSzutzhvRys6ApESmhUAQx1FZw92VyiLhMwM+9qQZqDfRK/frip/o4NFPQXtDmL0n/icz4C6douHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793586; c=relaxed/simple;
	bh=WNbYTvEyIdUdx7EHvy3JSMVi+TLBLOlM9F+2T36pzt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u36ydzTx+n5wDKbLiLZaWFuW1CmXSaqWa65QLYTXdnFHF+v/tjuPhuODqz2ulVi6ICPhj/V0fIYUbC0eHDYT4bljZIx1Apu5N89vcVBNJUhVDQ03vr9exUmrG9qrL4jZSsZmvDMOrtlgd3Kf9G5iP7e2015tm7uIfEjF2uMnHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgjtpwsQ; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgjtpwsQ"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5ba390408cdso1848653e87.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793582; x=1791398382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NhHApOLR2rUgLss72nYiXwyM3YAsK8SY7Jub2qcLoxs=;
        b=lgjtpwsQst+UQ7YB0tg0DY9m3rSriC9IUIQkwzgfvxO8Y5qxrsWVEXYf+MNB8IIWey
         G6ESemnP+ejhd3IUm7xMYKaN/jNmZLq57wNQ9gjI+nG+bIYtQQqX4WPXBEK+kK1gDV+z
         SvNwX2fmYS4yHTzHjAa/JDfabiit0vDliAt7iPYHk8P8nab7WvRIQY28GpUEJK/hmUnh
         35rCVIeO4QNNqU2uJ5Z0KqDIFVSqACc56f6zryWwKPyhXLUp13q5wjBcmac6uhDwxC9u
         pvsaH8M25bttRjrbGRftYFv+OPqTD314yJ06M8bbq3embxBWBss+jnE/JT/W+bwVRRlK
         /BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793582; x=1791398382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NhHApOLR2rUgLss72nYiXwyM3YAsK8SY7Jub2qcLoxs=;
        b=W+EAWVDFafLCx8w3hQnpUtm4w3YMuiVCcGHEL++upW7hS7uPx9BOjaFBujRb8Ew1cq
         ze3tzWYgO6MgBUBDogXMxhFHY+VbnmjFCa3admvx6g9xd7zW6fWrdorG6A83kh4CU+fc
         D8nyEUuZLUSK7ZpgvvLJhZqjV3g0N1LgZ5ZqW/aEj8W4amBasveMUDp04dqMPALcClTl
         RtFWylbhJUixmFIGzzhdawGTvxUBrekp1Vva8f23mZFs5+B5ChngJf2ULpd0ppy222op
         b8mL5Nuhh24eJqum24jAXn5fOeq7q9G3xq72aQxm8p3MYdVnNLcq5kLXBYT9Vp3vUL72
         4QaQ==
X-Gm-Message-State: AFq9FYLXhLJiuyqLhAObi5cbd9UNcOCZlde52iBRI+wvyK+1e3da2ksM
	KPjEeEu/SUX3WbDIR+QXXs9wGQHBq8/0hZ8E1TJe4ydBom59RDMFoxgYdANIn03v
X-Gm-Gg: AYBFou2UaYHUgFU9CLrEsJyRgmOQn6XKH+6p/jmgX4d0m3D0rUmFK+Ivv3YPrYq8h6/
	PncfHu2g1ZpQ8Z5p13QvRcai3vjHH29ll7mdKaZlEWpHcjXUsuXtHDgUmBJR4iygZrglZ0U27hm
	sc2yH6P2ES4tVd3G0PnnEa61qmZnRfqjjNVALyognkdQeWLDKcttH8K/7kKAaGtb6Yr7XhQRmxn
	nNclfn0v+DhweUU86wJOIgsNJ6PhNpPW/PE/bPkbKLcLfQ+S2+9VTs/QrCt/rkpFbBtCBAGcai2
	3q3e15Z0mqM9wbbvlUO6+e8IRRPjeFfEcJ44aQbt2f2fa9sZDcUp2Yk1dDnFVOd4WpCAfoSTQje
	7Fvs3B82TpCQZIVyGDGKy2WmrUYC2v7GbT1hrFCJGk2sva+MAx0VHE2QqNDfWm4cJa1HJxLwouQ
	JmdPrL0fCH77aL10m1pHEMIM7jM00WqE4ZmTG+WToRF9oMDW1VC+0Fepr2IglmLpkEgG3mtbKq9
	VxKHr6JCY76oaegMCvdkeyuTF9CqmqXMgtRE0TtAVHAM2Z1e0qFOEM=
X-Received: by 2002:a05:6512:481b:b0:5b8:f94a:4d30 with SMTP id 2adb3069b0e04-5ba405feb9emr811482e87.49.1790793581880;
        Wed, 30 Sep 2026 11:39:41 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:41 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 12/14] ip6_tunnel: make ip6_tnl_xmit() return a drop reason
Date: Wed, 30 Sep 2026 21:39:08 +0300
Message-ID: <20260930183910.3151873-13-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Give the IPv6 tunnel transmit path drop reasons, as ip_tunnel_xmit()
and the ip_gre transmit handlers now have. The difference is that
ip6_tnl_xmit() does not free the packet itself: it returns an error and
its callers free it, so the reason has to travel with it.

Make ip6_tnl_xmit() return the drop reason, SKB_NOT_DROPPED_YET on
success, instead of 0, -1 or an errno, and do the same for
ipxip6_tnl_xmit(), __gre6_xmit() and the ip6gre_xmit_*() helpers, so
that the ndo_start_xmit handlers, where the packet is actually freed,
can report it. The callers only told success from failure and looked
for -EMSGSIZE to send an ICMP error back. ip6_tnl_xmit() returns
-EMSGSIZE only for a packet that exceeds the path MTU, which is exactly
when it reports SKB_DROP_REASON_PKT_TOO_BIG, so the ICMP error is now
sent when that reason is returned. A failed xfrm lookup never returns
-EMSGSIZE, so its errno only ever meant failure and goes away.
__gre6_xmit() was declared as returning netdev_tx_t while it returned an
errno, and now returns the reason as well.

The ip6_gre helpers change here because they pass on the return value of
ip6_tnl_xmit(). The ip6_gre handlers take the reason from them but still
free the packet with kfree_skb(); the next patch converts them.
ip6_tnl_start_xmit() frees with the reason and, as in ip_gre, takes the
length reason from pskb_inet_may_pull_reason() instead of
pskb_inet_may_pull(). The other reasons are the ones already used on the
IPv4 side:

 - SKB_DROP_REASON_PKT_TOO_BIG for a packet that exceeds the path MTU,
 - SKB_DROP_REASON_IP_OUTNOROUTES for the route and xfrm lookups,
   including the source address selection that a collect_md tunnel does
   when the flow has no source address,
 - SKB_DROP_REASON_NO_TX_TARGET when an NBMA tunnel gets an skb with no
   destination to derive its endpoint from, or finds no endpoint for it,
   such as an IPv4 packet whose route has no IPv6 gateway or an MPLS
   packet,
 - SKB_DROP_REASON_NEIGH_CREATEFAIL when the NBMA neighbour lookup
   fails,
 - SKB_DROP_REASON_RECURSION_LIMIT for a route pointing back at the
   tunnel, and for the trivial tunnelling loop ip6_tnl_addr_conflict()
   guards against, a packet whose source is the exit point of the
   tunnel,
 - SKB_DROP_REASON_NOMEM for the allocations,
 - SKB_DROP_REASON_TUNNEL_TXINFO for the collect_md metadata checks,
 - SKB_DROP_REASON_TUNNEL_ENCAP when the encapsulation header cannot be
   built, and for a collect_md tunnel that has an encapsulation
   configured, which ip6_tnl_xmit() does not support,
 - SKB_DROP_REASON_UNHANDLED_PROTO for a payload the tunnel does not
   carry, either by its mode or because it is neither IPv4, IPv6 nor
   MPLS.

Two more are IPv6 specific. SKB_DROP_REASON_IPV6_BAD_EXTHDR is used when
the packet's tunnel encapsulation limit option is 0, which forbids
encapsulating it again. SKB_DROP_REASON_DEV_READY is used when
ip6_tnl_xmit_ctl() refuses the transmit. It refuses when the local
address is not configured yet, when the remote address belongs to this
host (the routing loop it warns about), and when the tunnel cannot
transmit with the addresses of the packet. DEV_READY describes the first
case; the other two are reported under it as well, because
ip6_tnl_xmit_ctl() returns only 0 or 1. Telling them apart needs it to
return a reason, which is left for a follow-up, together with
ip6_tnl_rcv_ctl() on the receive side. An NBMA tunnel that found no
endpoint for the packet would be refused there as well; it is caught
before the call, as SKB_DROP_REASON_NO_TX_TARGET.

A collect_md tunnel has no fixed exit point and its raddr is normally
::, as is that of an NBMA ip6tnl device. ip6_tnl_addr_conflict() and,
on a collect_md device, the same check in ip6gre_xmit_ipv6() therefore
also drop the packets such a tunnel sends from ::. They were dropped
before as well; SKB_DROP_REASON_RECURSION_LIMIT names the check that
drops them.
The next patch has the ip6_gre handler drop a packet that carries no
IPv6 tunnel metadata before that check, as
SKB_DROP_REASON_TUNNEL_TXINFO, so that the DAD probes of an ip6gretap
device are reported like its other packets without metadata.
ip6_tnl_start_xmit() still reports such a packet from :: as
SKB_DROP_REASON_RECURSION_LIMIT; an ip6tnl device is IFF_NOARP and does
no DAD, so its own probes do not end up there.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/ip6_tunnel.h |   5 +-
 net/ipv6/ip6_gre.c       |  84 ++++++++++++++++---------------
 net/ipv6/ip6_tunnel.c    | 106 ++++++++++++++++++++++++---------------
 3 files changed, 113 insertions(+), 82 deletions(-)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index d1f0a427e9c8..363eed61b296 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -143,8 +143,9 @@ int ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 		bool log_ecn_error);
 int ip6_tnl_xmit_ctl(struct ip6_tnl *t, const struct in6_addr *laddr,
 		     const struct in6_addr *raddr);
-int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
-		 struct flowi6 *fl6, int encap_limit, __u32 *pmtu, __u8 proto);
+enum skb_drop_reason
+ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
+	     struct flowi6 *fl6, int encap_limit, __u32 *pmtu, __u8 proto);
 __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw);
 __u32 ip6_tnl_get_cap(struct ip6_tnl *t, const struct in6_addr *laddr,
 			     const struct in6_addr *raddr);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index ba080a58ecb2..9e94ea6b6c20 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -717,10 +717,10 @@ static struct ip_tunnel_info *skb_tunnel_info_txcheck(struct sk_buff *skb)
 	return tun_info;
 }
 
-static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
-			       struct net_device *dev, __u8 dsfield,
-			       struct flowi6 *fl6, int encap_limit,
-			       __u32 *pmtu, __be16 proto)
+static enum skb_drop_reason __gre6_xmit(struct sk_buff *skb,
+					struct net_device *dev, __u8 dsfield,
+					struct flowi6 *fl6, int encap_limit,
+					__u32 *pmtu, __be16 proto)
 {
 	struct ip6_tnl *tunnel = netdev_priv(dev);
 	IP_TUNNEL_DECLARE_FLAGS(flags);
@@ -745,7 +745,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 		tun_info = skb_tunnel_info_txcheck(skb);
 		if (IS_ERR(tun_info) ||
 		    unlikely(ip_tunnel_info_af(tun_info) != AF_INET6))
-			return -EINVAL;
+			return SKB_DROP_REASON_TUNNEL_TXINFO;
 
 		key = &tun_info->key;
 		memset(fl6, 0, sizeof(*fl6));
@@ -764,7 +764,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 		tun_hlen = gre_calc_hlen(flags);
 
 		if (skb_cow_head(skb, dev->needed_headroom ?: tun_hlen + tunnel->encap_hlen))
-			return -ENOMEM;
+			return SKB_DROP_REASON_NOMEM;
 
 		gre_build_header(skb, tun_hlen,
 				 flags, protocol,
@@ -775,7 +775,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 
 	} else {
 		if (skb_cow_head(skb, dev->needed_headroom ?: tunnel->hlen))
-			return -ENOMEM;
+			return SKB_DROP_REASON_NOMEM;
 
 		ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
 
@@ -790,9 +790,11 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 			    NEXTHDR_GRE);
 }
 
-static inline int ip6gre_xmit_ipv4(struct sk_buff *skb, struct net_device *dev)
+static inline enum skb_drop_reason ip6gre_xmit_ipv4(struct sk_buff *skb,
+						    struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
+	enum skb_drop_reason reason;
 	int encap_limit = -1;
 	struct flowi6 fl6;
 	__u8 dsfield = 0;
@@ -808,54 +810,56 @@ static inline int ip6gre_xmit_ipv4(struct sk_buff *skb, struct net_device *dev)
 	err = gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
 						t->parms.o_flags));
 	if (err)
-		return -1;
+		return SKB_DROP_REASON_NOMEM;
 
-	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
-			  skb->protocol);
-	if (err != 0) {
+	reason = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
+			     skb->protocol);
+	if (reason) {
 		/* XXX: send ICMP error even if DF is not set. */
-		if (err == -EMSGSIZE)
+		if (reason == SKB_DROP_REASON_PKT_TOO_BIG)
 			icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED,
 				      htonl(mtu));
-		return -1;
+		return reason;
 	}
 
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
-static inline int ip6gre_xmit_ipv6(struct sk_buff *skb, struct net_device *dev)
+static inline enum skb_drop_reason ip6gre_xmit_ipv6(struct sk_buff *skb,
+						    struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct ipv6hdr *ipv6h = ipv6_hdr(skb);
+	enum skb_drop_reason reason;
 	int encap_limit = -1;
 	struct flowi6 fl6;
 	__u8 dsfield = 0;
 	__u32 mtu;
-	int err;
 
 	if (ipv6_addr_equal(&t->parms.raddr, &ipv6h->saddr))
-		return -1;
+		return SKB_DROP_REASON_RECURSION_LIMIT;
 
 	if (!t->parms.collect_md &&
 	    prepare_ip6gre_xmit_ipv6(skb, dev, &fl6, &dsfield, &encap_limit))
-		return -1;
+		return SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 
 	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
 					      t->parms.o_flags)))
-		return -1;
+		return SKB_DROP_REASON_NOMEM;
 
-	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit,
-			  &mtu, skb->protocol);
-	if (err != 0) {
-		if (err == -EMSGSIZE)
+	reason = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit,
+			     &mtu, skb->protocol);
+	if (reason) {
+		if (reason == SKB_DROP_REASON_PKT_TOO_BIG)
 			icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
-		return -1;
+		return reason;
 	}
 
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
-static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
+static enum skb_drop_reason ip6gre_xmit_other(struct sk_buff *skb,
+					      struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	int encap_limit = -1;
@@ -871,10 +875,10 @@ static int ip6gre_xmit_other(struct sk_buff *skb, struct net_device *dev)
 	err = gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
 						t->parms.o_flags));
 	if (err)
-		return err;
-	err = __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu, skb->protocol);
+		return SKB_DROP_REASON_NOMEM;
 
-	return err;
+	return __gre6_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
+			   skb->protocol);
 }
 
 static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
@@ -882,8 +886,8 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 {
 	struct ip_tunnel_info *tun_info = NULL;
 	struct ip6_tnl *t = netdev_priv(dev);
+	enum skb_drop_reason reason;
 	__be16 payload_protocol;
-	int ret;
 
 	if (!pskb_inet_may_pull(skb))
 		goto tx_err;
@@ -897,17 +901,17 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	payload_protocol = skb_protocol(skb, true);
 	switch (payload_protocol) {
 	case htons(ETH_P_IP):
-		ret = ip6gre_xmit_ipv4(skb, dev);
+		reason = ip6gre_xmit_ipv4(skb, dev);
 		break;
 	case htons(ETH_P_IPV6):
-		ret = ip6gre_xmit_ipv6(skb, dev);
+		reason = ip6gre_xmit_ipv6(skb, dev);
 		break;
 	default:
-		ret = ip6gre_xmit_other(skb, dev);
+		reason = ip6gre_xmit_other(skb, dev);
 		break;
 	}
 
-	if (ret < 0)
+	if (reason)
 		goto tx_err;
 
 	return NETDEV_TX_OK;
@@ -927,11 +931,11 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct dst_entry *dst = skb_dst(skb);
 	IP_TUNNEL_DECLARE_FLAGS(flags) = { };
+	enum skb_drop_reason reason;
 	bool truncate = false;
 	int encap_limit = -1;
 	__u8 dsfield = false;
 	struct flowi6 fl6;
-	int err = -EINVAL;
 	__be16 proto;
 	__u32 mtu;
 	int nhoff;
@@ -1066,11 +1070,11 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 		if (dst_mtu(dst) > mtu)
 			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
 	}
-	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
-			   NEXTHDR_GRE);
-	if (err != 0) {
+	reason = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
+			      NEXTHDR_GRE);
+	if (reason) {
 		/* XXX: send ICMP error even if DF is not set. */
-		if (err == -EMSGSIZE) {
+		if (reason == SKB_DROP_REASON_PKT_TOO_BIG) {
 			if (skb->protocol == htons(ETH_P_IP))
 				icmp_ndo_send(skb, ICMP_DEST_UNREACH,
 					      ICMP_FRAG_NEEDED, htonl(mtu));
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 52f6a38657b9..7e444115f431 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1115,14 +1115,14 @@ EXPORT_SYMBOL_GPL(ip6_tnl_xmit_ctl);
  *   it.
  *
  * Return:
- *   0 on success
- *   -1 fail
- *   %-EMSGSIZE message too big. return mtu in this case.
+ *   %SKB_NOT_DROPPED_YET on success, otherwise the drop reason.
+ *   %SKB_DROP_REASON_PKT_TOO_BIG means the message is too big, the path MTU
+ *   is stored in @pmtu in this case.
  **/
 
-int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
-		 struct flowi6 *fl6, int encap_limit, __u32 *pmtu,
-		 __u8 proto)
+enum skb_drop_reason
+ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
+	     struct flowi6 *fl6, int encap_limit, __u32 *pmtu, __u8 proto)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
 	struct net *net = t->net;
@@ -1133,11 +1133,11 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	int err_count, mtu;
 	unsigned int eth_hlen = t->dev->type == ARPHRD_ETHER ? ETH_HLEN : 0;
 	unsigned int psh_hlen = sizeof(struct ipv6hdr) + t->encap_hlen;
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	unsigned int max_headroom = psh_hlen;
 	__be16 payload_protocol;
 	bool use_cache = false;
 	u8 hop_limit;
-	int err = -1;
 
 	payload_protocol = skb_protocol(skb, true);
 
@@ -1155,13 +1155,17 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 			struct neighbour *neigh;
 			int addr_type;
 
-			if (!skb_dst(skb))
+			if (!skb_dst(skb)) {
+				reason = SKB_DROP_REASON_NO_TX_TARGET;
 				goto tx_err_link_failure;
+			}
 
 			neigh = dst_neigh_lookup(skb_dst(skb),
 						 &ipv6_hdr(skb)->daddr);
-			if (!neigh)
+			if (!neigh) {
+				reason = SKB_DROP_REASON_NEIGH_CREATEFAIL;
 				goto tx_err_link_failure;
+			}
 
 			addr6 = (struct in6_addr *)&neigh->primary_key;
 			addr_type = ipv6_addr_type(addr6);
@@ -1174,12 +1178,19 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		} else if (payload_protocol == htons(ETH_P_IP)) {
 			const struct rtable *rt = skb_rtable(skb);
 
-			if (!rt)
+			if (!rt) {
+				reason = SKB_DROP_REASON_NO_TX_TARGET;
 				goto tx_err_link_failure;
+			}
 
 			if (rt->rt_gw_family == AF_INET6)
 				memcpy(&fl6->daddr, &rt->rt_gw6, sizeof(fl6->daddr));
 		}
+
+		if (ipv6_addr_any(&fl6->daddr)) {
+			reason = SKB_DROP_REASON_NO_TX_TARGET;
+			goto tx_err_link_failure;
+		}
 	} else if (t->parms.proto != 0 && !(t->parms.flags &
 					    (IP6_TNL_F_USE_ORIG_TCLASS |
 					     IP6_TNL_F_USE_ORIG_FWMARK))) {
@@ -1192,8 +1203,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	if (use_cache)
 		dst = dst_cache_get(&t->dst_cache);
 
-	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr))
+	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr)) {
+		reason = SKB_DROP_REASON_DEV_READY;
 		goto tx_err_link_failure;
+	}
 
 	if (!dst) {
 route_lookup:
@@ -1202,18 +1215,22 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 
 		dst = ip6_route_output(net, NULL, fl6);
 
-		if (dst->error)
+		if (dst->error) {
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_err_link_failure;
+		}
 		dst = xfrm_lookup(net, dst, flowi6_to_flowi(fl6), NULL, 0);
 		if (IS_ERR(dst)) {
-			err = PTR_ERR(dst);
 			dst = NULL;
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_err_link_failure;
 		}
 		if (t->parms.collect_md && ipv6_addr_any(&fl6->saddr) &&
 		    ipv6_dev_get_saddr(net, ip6_dst_idev(dst)->dev,
-				       &fl6->daddr, 0, &fl6->saddr))
+				       &fl6->daddr, 0, &fl6->saddr)) {
+			reason = SKB_DROP_REASON_IP_OUTNOROUTES;
 			goto tx_err_link_failure;
+		}
 		ndst = dst;
 	}
 
@@ -1223,6 +1240,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		DEV_STATS_INC(dev, collisions);
 		net_warn_ratelimited("%s: Local routing loop detected!\n",
 				     t->parms.name);
+		reason = SKB_DROP_REASON_RECURSION_LIMIT;
 		goto tx_err_dst_release;
 	}
 	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
@@ -1236,7 +1254,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 	if (skb->len - t->tun_hlen - eth_hlen > mtu && !skb_is_gso(skb)) {
 		*pmtu = mtu;
-		err = -EMSGSIZE;
+		reason = SKB_DROP_REASON_PKT_TOO_BIG;
 		goto tx_err_dst_release;
 	}
 
@@ -1259,12 +1277,16 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 */
 	max_headroom += LL_RESERVED_SPACE(tdev);
 
-	if (skb_cow_head(skb, max_headroom))
+	if (skb_cow_head(skb, max_headroom)) {
+		reason = SKB_DROP_REASON_NOMEM;
 		goto tx_err_dst_release;
+	}
 
 	if (t->parms.collect_md) {
-		if (t->encap.type != TUNNEL_ENCAP_NONE)
+		if (t->encap.type != TUNNEL_ENCAP_NONE) {
+			reason = SKB_DROP_REASON_TUNNEL_ENCAP;
 			goto tx_err_dst_release;
+		}
 	} else {
 		if (use_cache && ndst)
 			dst_cache_set_ip6(&t->dst_cache, ndst, &fl6->saddr);
@@ -1287,9 +1309,8 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 			+ dst->header_len + t->hlen;
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
-	err = ip6_tnl_encap(skb, t, &proto, fl6);
-	if (err)
-		return err;
+	if (ip6_tnl_encap(skb, t, &proto, fl6))
+		return SKB_DROP_REASON_TUNNEL_ENCAP;
 
 	if (encap_limit >= 0) {
 		init_tel_txopt(&opt, encap_limit);
@@ -1306,21 +1327,22 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	ipv6h->saddr = fl6->saddr;
 	ipv6h->daddr = fl6->daddr;
 	ip6tunnel_xmit(NULL, skb, dev, 0);
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 tx_err_link_failure:
 	DEV_STATS_INC(dev, tx_carrier_errors);
 	dst_link_failure(skb);
 tx_err_dst_release:
 	dst_release(dst);
-	return err;
+	return reason;
 }
 EXPORT_SYMBOL(ip6_tnl_xmit);
 
-static inline int
+static inline enum skb_drop_reason
 ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 		u8 protocol)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
+	enum skb_drop_reason reason;
 	struct ipv6hdr *ipv6h;
 	const struct iphdr  *iph;
 	int encap_limit = -1;
@@ -1329,11 +1351,10 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 	__u8 dsfield, orig_dsfield;
 	__u32 mtu;
 	u8 tproto;
-	int err;
 
 	tproto = READ_ONCE(t->parms.proto);
 	if (tproto != protocol && tproto != 0)
-		return -1;
+		return SKB_DROP_REASON_UNHANDLED_PROTO;
 
 	if (t->parms.collect_md) {
 		struct ip_tunnel_info *tun_info;
@@ -1342,7 +1363,7 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 		tun_info = skb_tunnel_info(skb);
 		if (unlikely(!tun_info || !(tun_info->mode & IP_TUNNEL_INFO_TX) ||
 			     ip_tunnel_info_af(tun_info) != AF_INET6))
-			return -1;
+			return SKB_DROP_REASON_TUNNEL_TXINFO;
 		key = &tun_info->key;
 		memset(&fl6, 0, sizeof(fl6));
 		fl6.flowi6_proto = protocol;
@@ -1379,7 +1400,7 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 				if (tel->encap_limit == 0) {
 					icmpv6_ndo_send(skb, ICMPV6_PARAMPROB,
 							ICMPV6_HDR_FIELD, offset + 2);
-					return -1;
+					return SKB_DROP_REASON_IPV6_BAD_EXTHDR;
 				}
 				encap_limit = tel->encap_limit - 1;
 			}
@@ -1421,15 +1442,15 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 	dsfield = INET_ECN_encapsulate(dsfield, orig_dsfield);
 
 	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP6))
-		return -1;
+		return SKB_DROP_REASON_NOMEM;
 
 	skb_set_inner_ipproto(skb, protocol);
 
-	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
-			   protocol);
-	if (err != 0) {
+	reason = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
+			      protocol);
+	if (reason) {
 		/* XXX: send ICMP error even if DF is not set. */
-		if (err == -EMSGSIZE)
+		if (reason == SKB_DROP_REASON_PKT_TOO_BIG)
 			switch (protocol) {
 			case IPPROTO_IPIP:
 				icmp_ndo_send(skb, ICMP_DEST_UNREACH,
@@ -1441,20 +1462,21 @@ ipxip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev,
 			default:
 				break;
 			}
-		return -1;
+		return reason;
 	}
 
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 static netdev_tx_t
 ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
+	enum skb_drop_reason reason;
 	u8 ipproto;
-	int ret;
 
-	if (!pskb_inet_may_pull(skb))
+	reason = pskb_inet_may_pull_reason(skb);
+	if (reason)
 		goto tx_err;
 
 	switch (skb->protocol) {
@@ -1462,27 +1484,31 @@ ip6_tnl_start_xmit(struct sk_buff *skb, struct net_device *dev)
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
-	if (ret < 0)
+	reason = ipxip6_tnl_xmit(skb, dev, ipproto);
+	if (reason)
 		goto tx_err;
 
 	return NETDEV_TX_OK;
 
 tx_err:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	DEV_STATS_INC(dev, tx_errors);
 	DEV_STATS_INC(dev, tx_dropped);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return NETDEV_TX_OK;
 }
 
-- 
2.47.3

