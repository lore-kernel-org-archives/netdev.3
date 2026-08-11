Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2A5421F0F
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441962; cv=none; b=kANF1mpCEj0HyNuTyIDVFDxHM9bz5THkbkMhofpJzgVSu8GDuSdmftgjVVCBG2/ULDsZ/fPh48iB7KN1nLMuHpJgMf9T8XZqY6ze159l6UAZRGocjhIZaM1MP7qiDJUvYbA+a1rbuZEFjnEWQr2OX4Kh/hTSH6eSaOmAv+yeLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441962; c=relaxed/simple;
	bh=q6ZdKMpaII4Z/SiliMf11wzeE7qAK/XaezlT4GQcjqY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DMtlMkUgYAPntzKJunZp7ZMKyDvjDixPtY3raIqioa832GIjlrXyvW+9YIxBu4B4iziA0Zdkl4E0WaScjfb+TVrJtE7Cij4zrzXbWinC0eWCKAPBIrv6cf3trJu02EGhYbwvLuIYj6oOlMNFOvKWNlHEj+qVBKx+70GX7a+BHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v2/Q1Rzz; arc=none smtp.client-ip=209.85.219.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2/Q1Rzz"
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9083b049f73so34935486d6.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786441959; x=1787046759; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Vcu6xpeicZFSZrgcpIozjyhmYaIf1Dg1ruA4HYytmI=;
        b=v2/Q1RzzHPSDpJdZY7nWbsiSmB65x/0FCKkFJE/9Hyf10zXXfLKyoSkFbNISeERKxZ
         /fO4+m/q8XJaF3klQdoaG7QVPvI1IJ7jQkmvfI0fOVJ5+h8J6UTfTV8jsmp3eRSkO88c
         BUtHjm+1MmiC6fmS2y0mdMtTgfhmlqj5hSIYtyoHvwwXDvj86x2RYDw1vAT39ghysfmu
         luPYd7HYaFV03lP8ehaa7L+CjfdxIrRCd5Tx/4zL2THHQjARayzbNUPyx8TX0SpFlLWy
         Hon7L920KbKslh/0OKRiLFtHsnESKnGYayWAPN3pw6FvETEGFqH5ywoQbdYsql2wRXRf
         bs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786441959; x=1787046759;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Vcu6xpeicZFSZrgcpIozjyhmYaIf1Dg1ruA4HYytmI=;
        b=GwtgDF3Xl6m150nW9DbAeROAwP0LC8U2s/fcJI+CmWxObT5lpzYxFwlbkbmFsf4xtE
         QuHMMVfg1K99qBD+UOGrJR+I737GpLvCRiu4y62RMa9K/97SAxKTNzqaqx+Y8+sVTV1e
         kAdMkuL4DIjpwbla8eFDb+sEOymT1wnvefIIxSoWRmPTTuO/KNlUgXxB5vuQnFtcJai/
         xByok2liCFy1aSowW+5lpBO1521d50FO65qK5HMek2u95qG1MEGzJkY9VbonWnbtElYK
         Cg196GKHjD48uk6VkbDEZmVQPGaHqytGDPukScW+ecNsLFEnOa2Y7GEhgblG91DYCRgl
         602w==
X-Forwarded-Encrypted: i=1; AHgh+Rq3maP1/aV5j9INGBtuERRU4VKKTdC9icc+AYxJiUchnSKqa2xLqAEHxiLM/UdTWA8f0dyydEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPDB0EpVl4i5n9a523UKb7VX4EMlf3r5zW5DGSKeCG4TEletpt
	2ygwfsSrnl5IuIoP8ht+8VIc278moR89EEKOWGs23z61xZ4Txu6UTdZ6og/SY0YJMQYdCRcAme+
	BQFMUJM3FJ1Yw/w==
X-Received: from qvbdi14.prod.google.com ([2002:ad4:58ee:0:b0:8dd:df44:692])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:588f:b0:905:6e01:b9a3 with SMTP id 6a1803df08f44-90a66b6ea11mr14332156d6.31.1786441959231;
 Tue, 11 Aug 2026 02:52:39 -0700 (PDT)
Date: Tue, 11 Aug 2026 09:52:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811095237.2314234-1-edumazet@google.com>
Subject: [PATCH v3 net-next] gre: fix ERSPAN o_flags race/corruption in xmit
 and fill_info
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

For IPv4 ERSPAN:
In erspan_xmit(), the driver clears IP_TUNNEL_SEQ_BIT (for version 0)
and IP_TUNNEL_KEY_BIT directly in the shared tunnel->parms.o_flags
structure. Since transmit paths can run locklessly and concurrently,
this leads to a data race.

Furthermore, modifying tunnel->parms.o_flags permanently alters the
tunnel configuration. To work around this, erspan_fill_info() (which
reports config to userspace) was setting IP_TUNNEL_KEY_BIT back. If
erspan_fill_info (running under RTNL) and erspan_xmit (running locklessly)
race, erspan_xmit might see IP_TUNNEL_KEY_BIT set when it shouldn't,
leading to GRE header corruption (injecting a key field into the ERSPAN
GRE header).

Fix this by:
1) Passing flags as an argument to __gre_xmit().
2) Using local flags in erspan_xmit() and passing them to __gre_xmit().
3) Removing the racy modification of t->parms.o_flags in erspan_fill_info().
4) Forcing IP_TUNNEL_KEY_BIT in the reported flags for ERSPAN locally
   in ipgre_fill_info().

For IPv6 ERSPAN:
ip6erspan_tunnel_xmit() was locklessly clearing IP_TUNNEL_KEY_BIT in
t->parms.o_flags even though it does not use these flags for building
the GRE header (it uses local flags). This permanently corrupts the
configuration and races with ip6gre_fill_info() which reads it.

Remove the redundant and racy modification.
This should remove false sharing in a fast path.

Add const qualifiers in ipgre_fill_info(), erspan_fill_info()
and ip6gre_fill_info() to clarify that these methods are not
supposed to write any live parameters.

Fixes: 84e54fe0a5ea ("gre: introduce native tunnel support for ERSPAN")
Fixes: ee496694b9ee ("ip_gre: do not report erspan version on GRE interface")
Fixes: 5a963eb61b7c ("ip6_gre: Add ERSPAN native tunnel support")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: https://lore.kernel.org/netdev/20260720135132.3957146-1-edumazet@google.com/

 net/ipv4/ip_gre.c  | 30 +++++++++++++++---------------
 net/ipv6/ip6_gre.c |  5 ++---
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 6a92607401e8aae5a10bd758820d37f51fd7a25b..b8c1df4a871942bc0929c685d389cf889dc0c882 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -475,12 +475,9 @@ static int gre_rcv(struct sk_buff *skb)
 
 static void __gre_xmit(struct sk_buff *skb, struct net_device *dev,
 		       const struct iphdr *tnl_params,
-		       __be16 proto)
+		       __be16 proto, const unsigned long *flags)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
-	IP_TUNNEL_DECLARE_FLAGS(flags);
-
-	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
 
 	/* Push GRE header. */
 	gre_build_header(skb, tunnel->tun_hlen,
@@ -692,7 +689,7 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 					      tunnel->parms.o_flags)))
 		goto free_skb;
 
-	__gre_xmit(skb, dev, tnl_params, skb->protocol);
+	__gre_xmit(skb, dev, tnl_params, skb->protocol, tunnel->parms.o_flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -705,6 +702,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 			       struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	IP_TUNNEL_DECLARE_FLAGS(flags);
 	bool truncate = false;
 	__be16 proto;
 
@@ -728,10 +726,12 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		truncate = true;
 	}
 
+	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
+
 	/* Push ERSPAN header */
 	if (tunnel->erspan_ver == 0) {
 		proto = htons(ETH_P_ERSPAN);
-		__clear_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags);
+		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
 	} else if (tunnel->erspan_ver == 1) {
 		erspan_build_header(skb, ntohl(tunnel->parms.o_key),
 				    tunnel->index,
@@ -746,8 +746,8 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		goto free_skb;
 	}
 
-	__clear_bit(IP_TUNNEL_KEY_BIT, tunnel->parms.o_flags);
-	__gre_xmit(skb, dev, &tunnel->parms.iph, proto);
+	__clear_bit(IP_TUNNEL_KEY_BIT, flags);
+	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -776,7 +776,7 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 	if (skb_cow_head(skb, dev->needed_headroom))
 		goto free_skb;
 
-	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB));
+	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB), tunnel->parms.o_flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -1560,12 +1560,15 @@ static size_t ipgre_get_size(const struct net_device *dev)
 
 static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip_tunnel *t = netdev_priv(dev);
-	struct ip_tunnel_parm_kern *p = &t->parms;
+	const struct ip_tunnel *t = netdev_priv(dev);
+	const struct ip_tunnel_parm_kern *p = &t->parms;
 	IP_TUNNEL_DECLARE_FLAGS(o_flags);
 
 	ip_tunnel_flags_copy(o_flags, p->o_flags);
 
+	if (t->erspan_ver != 0 && !t->collect_md)
+		__set_bit(IP_TUNNEL_KEY_BIT, o_flags);
+
 	if (nla_put_u32(skb, IFLA_GRE_LINK, p->link) ||
 	    nla_put_be16(skb, IFLA_GRE_IFLAGS,
 			 gre_tnl_flags_to_gre_flags(p->i_flags)) ||
@@ -1608,12 +1611,9 @@ static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
 static int erspan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip_tunnel *t = netdev_priv(dev);
+	const struct ip_tunnel *t = netdev_priv(dev);
 
 	if (t->erspan_ver <= 2) {
-		if (t->erspan_ver != 0 && !t->collect_md)
-			__set_bit(IP_TUNNEL_KEY_BIT, t->parms.o_flags);
-
 		if (nla_put_u8(skb, IFLA_GRE_ERSPAN_VER, t->erspan_ver))
 			goto nla_put_failure;
 
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index b843116e9b703c701a1a28a85569501d83ede21d..0b3f386b51a2d8c97e67472bcccc15285f7fc15a 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -964,7 +964,6 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen))
 		goto tx_err;
 
-	__clear_bit(IP_TUNNEL_KEY_BIT, t->parms.o_flags);
 	IPCB(skb)->flags = 0;
 
 	/* For collect_md mode, derive fl6 from the tunnel key,
@@ -2115,8 +2114,8 @@ static size_t ip6gre_get_size(const struct net_device *dev)
 
 static int ip6gre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
-	struct ip6_tnl *t = netdev_priv(dev);
-	struct __ip6_tnl_parm *p = &t->parms;
+	const struct ip6_tnl *t = netdev_priv(dev);
+	const struct __ip6_tnl_parm *p = &t->parms;
 	IP_TUNNEL_DECLARE_FLAGS(o_flags);
 
 	ip_tunnel_flags_copy(o_flags, p->o_flags);
-- 
2.55.0.679.g6767b8d81c-goog

