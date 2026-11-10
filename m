Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342029;
	b=I386lt7J6rkUF3lbbb1Tc+6zF/K6uHlN6B2Nwl4/hxvfPZ2ja1MrCupgSnLkG4M+1xoO
	 KNE4qCALBwmxuP4pokvA6fGIN6Wrd7OrRGhJbfzqhD1gdxNhm8I11XDplW1amdfI/Llsk
	 he17jIS5oGadBbGqnpm9UJvU/tWfhheSa4Jpb9vqKLff+m0lQ3crRiyWzQFVLbOB9mzst
	 t3fEPYfIBu+dd4x5q7Y74KUAPGLXWf00Bu9a9KJSf5+boaDIxiN+ZdL937zsBY8U7rbLM
	 igALBEkZUQ6wMAXtn/dtC3DxjJ/5oTjuubTgmgY4d1AMmlSoN1DnFzz99p+R/Zd7uPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OjX+JgGI9jrtFpn+OcL7vKv0wFa1o1cDzJbV4ITeB+w=;
	b=ATy63P9aeyWmv3Zf4J+zYEZr8KqJAglW7+W5AscDKueWXYbyGRIgO0oRpesYr5zQ2TWa
	 EZKqXSOXUn8NJrYp6cRazYRvhNzHumi7RcCDWgONMVLmagEGKAllE3EKp0H/otGx16wd4
	 5hKF3s85xG6MkMBOCnCDGl24ZglNJrIfrudbC4osjAS+WoogHtOvzobdPsitFXv57XN0/
	 dpD99M1j9WAxG8L90cEygIwvIb/9OIzzYlwUYmtGh94lixUaxBMo5JpHmO5dzpE6l8aI7
	 TvQsI5nqveGd21+jEbx9rYY4nhjqRBOqvriKkZnmg6p5nW7uZwj7DZARUURQXIDGtRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wpi55hwY;
	arc=none smtp.remote-ip=209.85.208.180
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C0F60A260C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20C0F60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wpi55hwY
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3ab3dd966e1so20067081fa.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342027; x=1794946827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OjX+JgGI9jrtFpn+OcL7vKv0wFa1o1cDzJbV4ITeB+w=;
        b=Wpi55hwYcu76C7VKSKAeE0QeMC4jJkiemQow4tiGQMVUYuZLV+zV8d3N8/nhHkS/Tx
         zC8CrOTHwh/zSOIMov5PQb30OdJ+/qNfwN2sI39Yafp4+ZLUE+TBc6ugwg91+VA568ea
         GSCEcjdHVRiDoUohkerMnu/pZkkhPGDPgfYFQWpx1k4PSYBHe5xzUbFE82ga/sqLdVSC
         MJIDb8PssEGNpy46/aoO4Fdmj5G+YkiSK/Uo+ngMznEjn8AnlLacubC8P3Q8p2Vm/GGP
         ifnP5i4CIVcBqnRNLalKnSTGVEoRzhpUHLDnZE6nOt/Yn9Loc+p0kGoW+xtfjAU5Wcwq
         1UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342027; x=1794946827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OjX+JgGI9jrtFpn+OcL7vKv0wFa1o1cDzJbV4ITeB+w=;
        b=D7QO2iBpjivL7U90iAp2Tfzwk03NY7mFSTrfH+FPDqKMyuZCtvs1lWsx4vCrM8xdP6
         ti7KMD204OliDZS15hr4b9zifkfMpkA7DG56UktA/EwX32bT2OjkwfP79tSzhoNnEdbt
         gLjvAdqVVoOC9kWFv+sJ9AM8b4OssqHU3hWBJK6XnAe1LIxIbamuK/LDa5glBOzdtz7b
         6wyf1HmlM+ldOgfDUtO6gs+N0NV2cEK0szrwd0x94mkPQYMgJTEDk/WUrRvEJ2DS/ZFS
         uMHsRHPoc9f/yckE4m2R4F2U1LhumGqubOTy1d0oyStImODlYDGJFr6LaWwHgyQWSYVF
         zJFg==
X-Gm-Message-State: APuU4Z+nYnsv5jwrtfj61udByI9KKkWvShwf946O1t3l5ZCVL90Vs0XY
	K6kWoENZ/inEmHKp00YQwnzUdi1WyxbcZPjsWjOZ0ed6g7EORmxUw7BIvu+QNCuW8kuNCg==
X-Gm-Gg: AYBFou1xiRqNrzuOwxE3oa/mCTILoY106S1VdORo2AC5MsPxfn1l7pPTAAq4xmQ8Fr5
	o9/IFphf5XicmjOGE49pWcqAvkisWdIBM9p0Q3OT2NpqmGcZuyVBcIRQshKsB4uEY7/KL4hCnGh
	L1WURuh0QRI7BwEE7vUiWsCBX/8Y2IgHwxdZW2kae6cq5h357+NAFvIaCa8ZOjC34rz31jRmgCg
	7grIUKiEkceDRU1gZfi4qxdc1uF6wFYbh5WUttcUxICLMzqWaj4NWEjiDutFGPhC6IT8DNzkasx
	md+WJLfWgSSEeojbh6+yFKQY9dDkXnM27MFKFfjxfrITK0eVu3+nHR63ej59RDbrIVw+miWxxNe
	VjiziuCQirojg/Rats3Dez34hKqe7POznlh2NhTF4EyvU5fAy+oSkfU/zV3d2hcXl/dWg1jnlbT
	zIQ8qQbon7SSOguC52tHc1t8xqGzSBWqqYzcKvKzrkajPamhWz3OAIW3uByenjfsSd6Z+he+gIU
	SJX63CzeorwLTptp1NQvmniIpEYMU5ADhZ3J6GnSAlgj9fcMBs4BSzauKt4MkOu233gdBuOkD3b
	jk1er1D8CvwcAwtDZ5zA4pHitNiwiZ+LC8H7aDd+aqykCwz7jUOoGxQ6pSS11XiWfqHUQCEnfxT
	sThCGLLCPbl0Ja2m0
X-Received: by 2002:a05:651c:2108:b0:3ac:f2af:7611 with SMTP id 38308e7fff4ca-3ae0964ac16mr7302771fa.19.1794342027198;
        Tue, 10 Nov 2026 12:20:27 -0800 (PST)
Received: from dau-home-pc.megasoftware.org ([95.139.137.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae090ea59esm5945401fa.0.2026.11.10.12.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:20:26 -0800 (PST)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 2/8] ip6_tunnel: add drop reasons to the receive path
Date: Tue, 10 Nov 2026 23:20:15 +0300
Message-ID: <20261110202021.821224-3-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
References: <20261110202021.821224-1-littlesmilingcloud@gmail.com>
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

__ip6_tnl_rcv() mirrors its IPv4 counterpart: all of its failures share
a single plain kfree_skb(). Reuse the drop reasons that ip_tunnel_rcv()
now reports and the ones the length helpers already return.

Note that skb_vlan_inet_prepare() returns an enum skb_drop_reason that
has so far been discarded, and that the ETH_HLEN check gets one by
calling pskb_may_pull_reason() instead of pskb_may_pull().

__ip6_tnl_rcv() is reached two ways: ip6_gre (ip6gre, ip6gretap,
ip6erspan) goes through the exported ip6_tnl_rcv(), while the
ip6_tunnel encapsulations (ip4ip6, ip6ip6, mplsip6) reach it from
ipxip6_rcv(). Only ip6_gre sets the checksum and sequence number bits:
tpi_v4, tpi_v6 and tpi_mpls carry nothing but .proto, and unlike ipip
and sit, ip6_tunnel stores IFLA_IPTUN_FLAGS in parms.flags, not in
parms.i_flags. So the option mismatch and the old sequence reasons are
reachable through ip6_gre alone.

ipxip6_rcv() drops the packets it does not hand to __ip6_tnl_rcv() with
a plain kfree_skb() as well. Give them a reason too:
SKB_DROP_REASON_UNHANDLED_PROTO when the payload is not the one the
tunnel mode carries, SKB_DROP_REASON_XFRM_POLICY when the xfrm policy
check fails, the reason iptunnel_pull_header() returns and
SKB_DROP_REASON_NOMEM when the metadata dst cannot be allocated.

A packet that ip6_tnl_rcv_ctl() refuses stays
SKB_DROP_REASON_NOT_SPECIFIED, now set explicitly. The helper refuses
when the outer destination is not a usable local address, such as a
tentative one, when the outer source belongs to this host, and when the
tunnel cannot receive with the addresses of the packet, and it returns
only 0 or 1. Telling these apart needs ip6_tnl_rcv_ctl() and its
transmit counterpart ip6_tnl_xmit_ctl() to return a reason, which is
left for a follow-up.

ipxip6_rcv() and __ip6_tnl_rcv() follow the rule of ip_tunnel_rcv() for
the reason: it is initialized to SKB_DROP_REASON_NOT_SPECIFIED, and
every jump to the drop label comes with a reason of its own.

Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 45 +++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 64a184bca467..4912b08228a1 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -813,6 +813,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 						struct sk_buff *skb),
 			 bool log_ecn_err)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	const struct ipv6hdr *ipv6h;
 	int nh, err;
 
@@ -820,15 +821,22 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 	    test_bit(IP_TUNNEL_CSUM_BIT, tpi->flags)) {
 		DEV_STATS_INC(tunnel->dev, rx_crc_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
+		reason = SKB_DROP_REASON_TUNNEL_OPT_MISMATCH;
 		goto drop;
 	}
 
 	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.i_flags)) {
-		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags) ||
-		    (tunnel->i_seqno &&
-		     (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0)) {
+		if (!test_bit(IP_TUNNEL_SEQ_BIT, tpi->flags)) {
 			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TUNNEL_OPT_MISMATCH;
+			goto drop;
+		}
+		if (tunnel->i_seqno &&
+		    (s32)(ntohl(tpi->seq) - tunnel->i_seqno) < 0) {
+			DEV_STATS_INC(tunnel->dev, rx_fifo_errors);
+			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_TUNNEL_OLD_SEQ;
 			goto drop;
 		}
 		tunnel->i_seqno = ntohl(tpi->seq) + 1;
@@ -838,7 +846,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 
 	/* Warning: All skb pointers will be invalidated! */
 	if (tunnel->dev->type == ARPHRD_ETHER) {
-		if (!pskb_may_pull(skb, ETH_HLEN)) {
+		reason = pskb_may_pull_reason(skb, ETH_HLEN);
+		if (reason) {
 			DEV_STATS_INC(tunnel->dev, rx_length_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
 			goto drop;
@@ -859,7 +868,8 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 
 	skb_reset_network_header(skb);
 
-	if (skb_vlan_inet_prepare(skb, true)) {
+	reason = skb_vlan_inet_prepare(skb, true);
+	if (reason) {
 		DEV_STATS_INC(tunnel->dev, rx_length_errors);
 		DEV_STATS_INC(tunnel->dev, rx_errors);
 		goto drop;
@@ -881,6 +891,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 		if (err > 1) {
 			DEV_STATS_INC(tunnel->dev, rx_frame_errors);
 			DEV_STATS_INC(tunnel->dev, rx_errors);
+			reason = SKB_DROP_REASON_IP_TUNNEL_ECN;
 			goto drop;
 		}
 	}
@@ -898,7 +909,7 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 drop:
 	if (tun_dst)
 		dst_release((struct dst_entry *)tun_dst);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
@@ -941,6 +952,7 @@ static int ipxip6_rcv(struct sk_buff *skb, u8 ipproto,
 						  const struct ipv6hdr *ipv6h,
 						  struct sk_buff *skb))
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip6_tnl *t;
 	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
@@ -952,21 +964,30 @@ static int ipxip6_rcv(struct sk_buff *skb, u8 ipproto,
 	if (t) {
 		u8 tproto = READ_ONCE(t->parms.proto);
 
-		if (tproto != ipproto && tproto != 0)
+		if (tproto != ipproto && tproto != 0) {
+			reason = SKB_DROP_REASON_UNHANDLED_PROTO;
 			goto drop;
-		if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb))
+		}
+		if (!xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
+			reason = SKB_DROP_REASON_XFRM_POLICY;
 			goto drop;
+		}
 		ipv6h = ipv6_hdr(skb);
-		if (!ip6_tnl_rcv_ctl(t, &ipv6h->daddr, &ipv6h->saddr))
+		if (!ip6_tnl_rcv_ctl(t, &ipv6h->daddr, &ipv6h->saddr)) {
+			reason = SKB_DROP_REASON_NOT_SPECIFIED;
 			goto drop;
-		if (iptunnel_pull_header(skb, 0, tpi->proto, false))
+		}
+		reason = iptunnel_pull_header(skb, 0, tpi->proto, false);
+		if (reason)
 			goto drop;
 		if (t->parms.collect_md) {
 			IP_TUNNEL_DECLARE_FLAGS(flags) = { };
 
 			tun_dst = ipv6_tun_rx_dst(skb, flags, 0, 0);
-			if (!tun_dst)
+			if (!tun_dst) {
+				reason = SKB_DROP_REASON_NOMEM;
 				goto drop;
+			}
 		}
 		ret = __ip6_tnl_rcv(t, skb, tpi, tun_dst, dscp_ecn_decapsulate,
 				    log_ecn_error);
@@ -978,7 +999,7 @@ static int ipxip6_rcv(struct sk_buff *skb, u8 ipproto,
 
 drop:
 	rcu_read_unlock();
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
-- 
2.47.3

