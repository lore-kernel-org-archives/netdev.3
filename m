Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3D52121D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793573; cv=none; b=Z9iNPPQn7UZnVM4OfzcHri7JsgMH4gBWIhOAMYKHrwcZByqSMSLekkZBmVWmQ5vkV6baZiDx3V54B6DSBhZ2a21+y0zUz4ma6F7XJ2PMttV7rokVKBNvIEoembqjs3wgFsbLXkD10lIWBBBqm9SJwNU6SYnlAC8qp71IPv9gd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793573; c=relaxed/simple;
	bh=n9IjnA/8qHmLwM0p1e9oJt9uoJIysNkHxO9y7gTKgy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b79s4IravnzZv/enLKDJgSA/hdlOsgtu7frvItHyctW32zROSz/3caoujhowIry7EsuHTJz3ZS7kagDqq/r8JdLAr8BkQxjBRd2hDZzulyoC3U7deQ5euiqBZ1rYj44JpRn6EPQZVZNk5HZcTnvmwo99h9ekT8b//Ez1PWxmW/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec94lHXL; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec94lHXL"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba330dbd67so1833196e87.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793569; x=1791398369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gwhEGb1DslxOKa87yBxBo5FUVL93cgEfxsi6MmdhJMI=;
        b=Ec94lHXLdvl29nOrhP6lYkKJhI7iolZZusr/EEXV1+J91pAopzOtLrSPJVS4T059qX
         0iI1feYf9GKzCMASuppyClNtfWasZBkTv1d/kmYavxoR5bT6JYk8WOIhDz7ezrCWCQ2A
         Liw7gUlpHaOOzTfamSWVGSAAxKCdxDrTLnCybsFUCROi87J3Grz6bZEc3ZvfrWwndsDD
         FvvaXGD6NrDIUi5miFOx8j2Gbi0YM7EWiBacpmuQT1hgkI3S/tJR9z342keULycaGzi3
         iJzwvslpMuQE0aXljMcDrM/yyNovADevR5iqfcBgVwxRXUvSxcNu7QmlOGXR5eTyN/lc
         0A7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793569; x=1791398369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gwhEGb1DslxOKa87yBxBo5FUVL93cgEfxsi6MmdhJMI=;
        b=EAU7VDksIes1FGPyuu21GDUFuI9HFlGVWhGxYj25n6xP5WWpRsosZwXNuTK+Vda7Jv
         PPU9Mzx4S3FqYhQIPIXur9GGtzAtSWMtKPfUJphHYSyQrT7x6uUemQJemh8/7OoSMS+C
         KuGH3Ul1VHPrXU9ekeFATVOz1I9IeQehvhDbno/cpwluLNBLrPif1SgB5pLMdoIH+g+D
         IEgGo2rEWdV8hgNEgz+jHmCEqcBY93beoywLJaXpllyRmaweiEjuP8eVUt1v5bnagckN
         EOepkeLn5UT4+yT7JZtIXWW9g58gohjiF7QhjSF1mazYhWFzYY7l6hKy7G3GFzHxphIc
         tsEA==
X-Gm-Message-State: AFq9FYJR2nq++rjtKpXfb6ZmGsivSHnM7TgrhJV4c/ApvCPFXID6L3pH
	1g+H7DBVtn8aNs7p/oY4/gbSdZfj4fw8QR8jenesta2+ogVja/cNlzqzBGswWXKS
X-Gm-Gg: AYBFou0wMlyZLDX6Ci29ooeAneVvdzxRUYEcTPfBitIjwaaDfo3NK73bZ5txc3P08YT
	AO+BU950qSYcJ8Yiie3vJbxRd5e95WuA6jsRWjQpNlToeUt8reRBl3QyBBbzu6CaqzTFRed/Ypr
	CTQb5CHqSSFJVM/jlMzlFBwIkNQoSchV3Lu6TOFRKqXYgghevrWd2b1lnNYqH0TMUmdAIgP2dWO
	GF7wIokchYpXYuPNtHuqkomWURT6Q7rz4IaTRyETgnPdz3YPiChRSw2Q/KPN0mFOKP4H1DBnrLF
	wpNF3W0iCG0fHFmDN4rG3x+A689tT93UZ9z9LmNeB78apV4XzivSN3GKwWNTwx1VzCzbWbsVUbe
	eUDE4S8Emc7yyZE/QMwR9noBMykqPvvWl1OmoSTjTKGrLsJ00lZnAm6cgz50OC2Dtj/594xBV05
	QA4SzROouyB04Zk6FbQFmeSpFlsXfgwQ0owNdQPI4lRz/of6HQu0AYvT2u369iR62o4qBzePSd3
	e5301h24CDLDGM5y4+5hEPtLE+ofHKPy96bsCjM0jLWdPlkjpdu4EM=
X-Received: by 2002:ac2:4288:0:b0:5b6:1a7c:aa0d with SMTP id 2adb3069b0e04-5ba40607925mr725838e87.37.1790793569241;
        Wed, 30 Sep 2026 11:39:29 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:28 -0700 (PDT)
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
Subject: [PATCH net-next v5 05/14] ip6_tunnel: add drop reasons to the receive path
Date: Wed, 30 Sep 2026 21:39:01 +0300
Message-ID: <20260930183910.3151873-6-littlesmilingcloud@gmail.com>
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
tunnel mode carries, the reason the transmit side uses later in the
series, SKB_DROP_REASON_XFRM_POLICY when the xfrm policy check fails,
SKB_DROP_REASON_DEV_READY when ip6_tnl_rcv_ctl() refuses the packet,
the reason iptunnel_pull_header() returns and SKB_DROP_REASON_NOMEM
when the metadata dst cannot be allocated.
ip6_tnl_rcv_ctl() refuses when the outer destination is not a usable
local address, such as a tentative one, when the outer source belongs
to this host, and when the tunnel cannot receive with the addresses of
the packet. It returns only 0 or 1, so DEV_READY stands for all three,
as it does for ip6_tnl_xmit_ctl() on the transmit side later in the
series, although it describes only the first. Telling them apart needs
both helpers to return a reason, which is left for a follow-up.

ipxip6_rcv() and __ip6_tnl_rcv() follow the rule of ip_tunnel_rcv() for
the reason: it is initialized to SKB_DROP_REASON_NOT_SPECIFIED, and the
drop label falls back to it, as a helper stores its result in the
reason.

Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 47 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01..52f6a38657b9 100644
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
@@ -896,9 +907,10 @@ static int __ip6_tnl_rcv(struct ip6_tnl *tunnel, struct sk_buff *skb,
 	return 0;
 
 drop:
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
 	if (tun_dst)
 		dst_release((struct dst_entry *)tun_dst);
-	kfree_skb(skb);
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
@@ -941,6 +953,7 @@ static int ipxip6_rcv(struct sk_buff *skb, u8 ipproto,
 						  const struct ipv6hdr *ipv6h,
 						  struct sk_buff *skb))
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	struct ip6_tnl *t;
 	const struct ipv6hdr *ipv6h = ipv6_hdr(skb);
 	struct metadata_dst *tun_dst = NULL;
@@ -952,21 +965,30 @@ static int ipxip6_rcv(struct sk_buff *skb, u8 ipproto,
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
+			reason = SKB_DROP_REASON_DEV_READY;
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
@@ -978,7 +1000,8 @@ static int ipxip6_rcv(struct sk_buff *skb, u8 ipproto,
 
 drop:
 	rcu_read_unlock();
-	kfree_skb(skb);
+	reason = reason ?: SKB_DROP_REASON_NOT_SPECIFIED;
+	kfree_skb_reason(skb, reason);
 	return 0;
 }
 
-- 
2.47.3

