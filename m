Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A9D4D597B
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548687; cv=none; b=pRved1j1vHuZSSw5eO9GZx2g6T68aZu/89Y6A+sL9Gme8Y4Ri5YwcIx6G1KcqjzAqibxBb7eIQStJ05Zpjioo0+ctaMkXXBLy+1RunY2qyOdr7hrYhcwfTYaZSv1Wq9NXFcXuDSNmfFEmZkekp8BdD9j9cT5g2hMHH3nuPIZ0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548687; c=relaxed/simple;
	bh=Y8+upvczJjAAb/zgtPff2fwSD5erdQnt6V4Ei+DmjG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiJ0EKXSrFQD95hknUBsEqu75PbZkXxD1rfXDH4gprbr1eH9bZ8WrWfVZMte6anfrp5vS77ILYp7b6YkaW38hzV4Agsavjsgkj8MSq7k7QtVACYOEJ/yKPWNdMe1jv1zzCbRuOFsOEzYOmBS/Q1GScj5ic16XGNMyjM9uxd0SvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=TPj1RHDD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="TPj1RHDD"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab450c0873so469703a91.3
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 05:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791548676; x=1792153476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/Y0GlSH1Dp4D9Kp+/LktRy4ycb9+VJkFnZVQ09sD3Y=;
        b=TPj1RHDDh9xWQ+4M7J2m2kVrpm/+AUkRclDXYoF5mqDXRbNOfv/2kdvaPVOUnXUfiH
         4HX1fpAR4RSuiNUL/xqWW+O9vgeqRVjFqhEyNPcWGCpQVkcBzXXuc96lP9QB/Lh3OPWq
         yJEJc8OaybF3phEbby7KCgUTCGxsrYoKXvrRCsp2VGGiP+kGIs4R5RAvE+8SgJLeg7iQ
         ye8fL7yjrMgKOY3oZZ2LhPL2Xfm4MMnc2Yk/7xaPfmoYxV9g4PYUrJJ9UNMcpKSdaxYM
         2MNsdztJj/vx7qx6IYhJ3lfFxtoOR5L5RzaId3VavanqB0q5pfMSU2+7j7wU1EWt6Gwm
         7JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791548676; x=1792153476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s/Y0GlSH1Dp4D9Kp+/LktRy4ycb9+VJkFnZVQ09sD3Y=;
        b=Ao4C7dGd3lhrrJW8Fxm7AeVUJE1JzSX39M1qTJ1jvzjuE1MhnDyJC1qZckRQMH55gQ
         VGla/SZVI9VX2yditkEvwWS2JhUNYXO9Q5G59SAmyCrEp9Hv87SBmBTSIJgNDXV0CgxV
         pYA9FjTkiscmR1RW7abjLgbcuWj7zDG0pI4vclTT/WVIdkgxtg0c9P81syNYQXmVcL+4
         98M1W/0lTYGR7Y2Sbpqwv0IgDsTPj7RhwYs84unFEmLGCK1XKkZICGCVhr5r17N5Zjym
         JZUTGYRBUUxfpn73aptN15nFzfOLBjYZFldZeYrAp7LG75lNAYQpJUIwj43xhN/9bbGF
         S0fA==
X-Forwarded-Encrypted: i=1; AKwUvByfARmDdMcFlJBBOrRBMwf/k3jUiUGrpQ30KX5SaAigYYhLgjBhETRwtBIPS5FhW45xMy0oY3c=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/StL65m/C+FTlZ5/txxIPKYQ/LsDNYIAdLUkszCfS915WmmMi
	xhhGTjosGcY5f+6W9Za0HUdooepSSryXEYTQMsB+WLRl59i8wavRuuKs2EigvtD1SG9bdXc0Bsh
	0y9Wwcjo=
X-Gm-Gg: AYBFou3WzGy0x/PACWkEMghBTHX1PMAaq8sTr/p8m/6P28cfDjD5kW3Z5JJH1aLVXsJ
	fi1iIhZWqTfFsSGk9dKKVK/c3rbgjKED2v1/cv1Qid+ua0vi+t/ug9i/bKcWbgHGTseM1q2Ubze
	YttY0KyYRk4mG6o2HkAIst8ltrsytvxycr4Vhj8Nk9pvS9/L3fmv11HJD8JAmPwOfyDQgmzBvjn
	Fu/OmD2lrkC2GKq7/wOw1dTXWMk8yS4VHCi74feyj9kKK3KmiSEsV1DCXsN7n+NLdTv5YAsg930
	sGO9SqjKHh37R6bvtLeRP6UWxldkNLUVEARVgIZOLDogsZa2ajoemyvzt85elc1S7kiPwPMCwSw
	fQ2VZ2yK6HNuGfE1NDb+bxarnrptDeaTXXyi9dlQ2ZDk7k4raYiMdJ6tC2rRtrVq7NvHM9ElbA7
	lLIxlHeCAFT/ew0E4ESMyhqyZPRZNMuB2SK0zggy3/itZyQbaazqEVUIX+vZ2olgXmvzosc3h5g
	dG1QR836JqIFfgvkUhzc4xY4d1QvMuSGDcfPwkE
X-Received: by 2002:a17:90b:4a8f:b0:3a8:bbc1:75dc with SMTP id 98e67ed59e1d1-3ab3a8d0eb9mr1673636a91.38.1791548675893;
        Fri, 09 Oct 2026 05:24:35 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab55e41eefsm1660502a91.10.2026.10.09.05.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:24:35 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 03/13] amt: key relay tunnels on a union amt_addr endpoint
Date: Fri,  9 Oct 2026 12:24:16 +0000
Message-ID: <20261009122426.551178-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009122426.551178-1-omar@blockcast.net>
References: <20261009122426.551178-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A relay keeps one struct amt_tunnel_list per gateway and finds it by
the gateway's IPv4 address, stored as __be32 ip4 and compared with
ip_hdr(skb)->saddr. On an IPv6 outer transport that reads bytes 4-7 of
the IPv6 source address as an IPv4 address, and the field cannot hold
the gateway's address anyway.

Store the endpoint as a union amt_addr, which group and source nodes
already use, and move the union above struct amt_tunnel_list so the
tunnel can embed it. Its ip6 member is no longer under CONFIG_IPV6, so
code that only copies, compares or prints an endpoint compiles without
an #if and relies on amt_v6() being false. The tunnel's endpoint grows
from 4 to 16 bytes on every kernel; a kernel without IPv6 also pays 12
more bytes per source node and 24 per group node, which it already
zeroes. The tunnel needs no family of its own: the relay's socket is
bound to one family, so every tunnel has the device's family, which
amt_v6() reports.

amt_outer_saddr() copies the outer source address of a received message
by value into a zeroed union amt_addr. amt_request_handler() takes that
snapshot once and matches and records tunnels with it, comparing with
the existing amt_addr_equal(); the union is zero-padded for IPv4, so
one memcmp() serves both families. As before, a tunnel is matched on
the address alone. When the tunnel limit is reached, an IPv6 device
answers with an ICMPv6 destination unreachable instead of an ICMP one.
It is sent with skb->dev set to the underlying link: amt_rcv() has made
it the amt device, and icmp6_send() routes an error to a link-local
source through skb->dev, where amt_dev_xmit() would drop it.

The response MAC becomes one siphash() over the packed {address, port,
nonce} tuple instead of siphash_3u32() over the IPv4 address. Only the
relay computes and checks the MAC; the gateway echoes it verbatim, so it
cannot tell that the value for an IPv4 endpoint changed.

The IPv4 senders and the relay status debug message are converted to
tunnel->addr.ip4, and the debug message prints an IPv6 endpoint with
%pI6c. No functional change: amt_v6() is still false for every device.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 73 ++++++++++++++++++++++++++++++++++++-----------
 include/net/amt.h | 18 ++++++------
 2 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index a550f84..eaa5637 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -88,6 +88,19 @@ static bool amt_v6(const struct amt_dev *amt)
 	return IS_ENABLED(CONFIG_IPV6) && !ipv6_addr_any(&amt->local_ipv6);
 }
 
+/* Copy the outer source address of a received message by value, so that
+ * the caller may pull the skb afterwards.
+ */
+static void amt_outer_saddr(const struct amt_dev *amt,
+			    const struct sk_buff *skb, union amt_addr *addr)
+{
+	memset(addr, 0, sizeof(*addr));
+	if (amt_v6(amt))
+		addr->ip6 = ipv6_hdr(skb)->saddr;
+	else
+		addr->ip4 = ip_hdr(skb)->saddr;
+}
+
 static void __amt_source_gc_work(void)
 {
 	struct amt_source_node *snode;
@@ -594,10 +607,16 @@ static void __amt_update_relay_status(struct amt_tunnel_list *tunnel,
 {
 	if (validate && tunnel->status >= status)
 		return;
-	netdev_dbg(tunnel->amt->dev,
-		   "Update Tunnel(IP = %pI4, PORT = %u) status %s -> %s",
-		   &tunnel->ip4, ntohs(tunnel->source_port),
-		   status_str[tunnel->status], status_str[status]);
+	if (amt_v6(tunnel->amt))
+		netdev_dbg(tunnel->amt->dev,
+			   "Update Tunnel(IP = %pI6c, PORT = %u) status %s -> %s",
+			   &tunnel->addr.ip6, ntohs(tunnel->source_port),
+			   status_str[tunnel->status], status_str[status]);
+	else
+		netdev_dbg(tunnel->amt->dev,
+			   "Update Tunnel(IP = %pI4, PORT = %u) status %s -> %s",
+			   &tunnel->addr.ip4, ntohs(tunnel->source_port),
+			   status_str[tunnel->status], status_str[status]);
 	tunnel->status = status;
 }
 
@@ -1173,12 +1192,12 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 
 	memset(&fl4, 0, sizeof(struct flowi4));
 	fl4.flowi4_oif         = amt->stream_dev->ifindex;
-	fl4.daddr              = tunnel->ip4;
+	fl4.daddr              = tunnel->addr.ip4;
 	fl4.saddr              = amt->local_ip;
 	fl4.flowi4_proto       = IPPROTO_UDP;
 	rt = ip_route_output_key(amt->net, &fl4);
 	if (IS_ERR(rt)) {
-		netdev_dbg(amt->dev, "no route to %pI4\n", &tunnel->ip4);
+		netdev_dbg(amt->dev, "no route to %pI4\n", &tunnel->addr.ip4);
 		kfree_skb(skb);
 		return;
 	}
@@ -1228,13 +1247,13 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	skb_reset_inner_headers(skb);
 	memset(&fl4, 0, sizeof(struct flowi4));
 	fl4.flowi4_oif         = amt->stream_dev->ifindex;
-	fl4.daddr              = tunnel->ip4;
+	fl4.daddr              = tunnel->addr.ip4;
 	fl4.saddr              = amt->local_ip;
 	fl4.flowi4_dscp        = inet_dsfield_to_dscp(AMT_TOS);
 	fl4.flowi4_proto       = IPPROTO_UDP;
 	rt = ip_route_output_key(amt->net, &fl4);
 	if (IS_ERR(rt)) {
-		netdev_dbg(amt->dev, "no route to %pI4\n", &tunnel->ip4);
+		netdev_dbg(amt->dev, "no route to %pI4\n", &tunnel->addr.ip4);
 		return true;
 	}
 
@@ -2585,7 +2604,7 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb_reset_network_header(skb);
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == saddr) {
+		if (tunnel->addr.ip4 == saddr) {
 			if ((nonce == tunnel->nonce &&
 			     response_mac == tunnel->mac)) {
 				mod_delayed_work(amt_wq, &tunnel->gc_wq,
@@ -2818,18 +2837,23 @@ static bool amt_discovery_handler(struct amt_dev *amt, struct sk_buff *skb)
 
 static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
+	struct {
+		union amt_addr	addr;
+		__be16		port;
+		__be32		nonce;
+	} __packed mac_in;
 	struct amt_header_request *amtrh;
 	struct amt_tunnel_list *tunnel;
 	unsigned long long key;
+	union amt_addr saddr;
 	struct udphdr *udph;
-	struct iphdr *iph;
 	u64 mac;
 	int i;
 
 	if (!pskb_may_pull(skb, sizeof(*udph) + sizeof(*amtrh)))
 		return true;
 
-	iph = ip_hdr(skb);
+	amt_outer_saddr(amt, skb, &saddr);
 	udph = udp_hdr(skb);
 	amtrh = (struct amt_header_request *)(udp_hdr(skb) + 1);
 
@@ -2837,12 +2861,24 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 		return true;
 
 	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
-		if (tunnel->ip4 == iph->saddr)
+		if (amt_addr_equal(&tunnel->addr, &saddr))
 			goto send;
 
 	spin_lock_bh(&amt->lock);
 	if (amt->nr_tunnels >= amt->max_tunnels) {
 		spin_unlock_bh(&amt->lock);
+		if (amt_v6(amt)) {
+			/* amt_rcv() made skb->dev the amt device, but
+			 * icmp6_send() routes an error to a link-local
+			 * source through skb->dev, and the amt device
+			 * drops it. Send it through the underlying link.
+			 */
+			skb->dev = amt->stream_dev;
+			icmpv6_ndo_send(skb, ICMPV6_DEST_UNREACH,
+					ICMPV6_ADDR_UNREACH, 0);
+			skb->dev = amt->dev;
+			return true;
+		}
 		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
 		return true;
 	}
@@ -2856,7 +2892,7 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 	}
 
 	tunnel->source_port = udph->source;
-	tunnel->ip4 = iph->saddr;
+	tunnel->addr = saddr;
 
 	memcpy(&key, &tunnel->key, sizeof(unsigned long long));
 	tunnel->amt = amt;
@@ -2876,10 +2912,13 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 
 send:
 	tunnel->nonce = amtrh->nonce;
-	mac = siphash_3u32((__force u32)tunnel->ip4,
-			   (__force u32)tunnel->source_port,
-			   (__force u32)tunnel->nonce,
-			   &tunnel->key);
+	/* The MAC is opaque to the gateway, which only echoes it, so one
+	 * siphash over the zero-padded endpoint serves both families.
+	 */
+	mac_in.addr = tunnel->addr;
+	mac_in.port = tunnel->source_port;
+	mac_in.nonce = tunnel->nonce;
+	mac = siphash(&mac_in, sizeof(mac_in), &tunnel->key);
 	tunnel->mac = mac >> 16;
 
 	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
diff --git a/include/net/amt.h b/include/net/amt.h
index 921944b..77d17fc 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -241,6 +241,14 @@ struct amt_relay_headers {
 	};
 } __packed;
 
+/* ip6 is present without CONFIG_IPV6 too, so that code which only copies
+ * or compares addresses needs no #if; amt_v6() is then false.
+ */
+union amt_addr {
+	__be32			ip4;
+	struct in6_addr		ip6;
+};
+
 struct amt_tunnel_list {
 	struct list_head	list;
 	/* Protect All resources under an amt_tunne_list */
@@ -251,7 +259,8 @@ struct amt_tunnel_list {
 	enum amt_status		status;
 	struct delayed_work	gc_wq;
 	__be16			source_port;
-	__be32			ip4;
+	/* Gateway endpoint, in the device's outer family */
+	union amt_addr		addr;
 	__be32			nonce;
 	siphash_key_t		key;
 	u64			mac:48,
@@ -260,13 +269,6 @@ struct amt_tunnel_list {
 	struct hlist_head	groups[];
 };
 
-union amt_addr {
-	__be32			ip4;
-#if IS_ENABLED(CONFIG_IPV6)
-	struct in6_addr		ip6;
-#endif
-};
-
 /* RFC 3810
  *
  * When the router is in EXCLUDE mode, the router state is represented
-- 
2.43.0

