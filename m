Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0833D4F0
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544582; cv=none; b=Km089kTa+NFa2GjSz0+3CI4GABsNRXeUWk6XoQy5Rm814eHIDRZ3Cz5wC57YTxBtdk1ZkLcepHDXn06pHFvRVRFndrRPLKjVC7IvxEG2wLgnvP88diQueovBOzvnNwr+8y/775aiToc9/KgmcJvEH3XAcQq4voEJCCHEZgNBJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544582; c=relaxed/simple;
	bh=FyqUY+AfTGlpkyso58r/SW8InChZGziWWDCRYubsSVs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mxJ7kM/EPEOpTx/JpXBFmebWahUtRAE0Rcw07WCDgp0pb1OU2FLOy5NuXUN8JwibeQS3+OX3qS5vQfaRkkNpgzK543CdCp5HlGtJHM94qCTw+OK0w0GF+gBKWU/H/kEc8Yw/kOaq38fhCnykzHfkw4LaTCErAhaL+6B78pK2BNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfMI8Vnl; arc=none smtp.client-ip=209.85.160.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfMI8Vnl"
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1c7f135bso17549961cf.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786544579; x=1787149379; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oJ48GcoLApm6K65tu+1RPm+pfiT7DLMVSMHPA1LbbHY=;
        b=lfMI8Vnl6Mw2cB8FWe9KdV2FyVyL4eGacIDIRtoJbxM0LnpiVbqz1bVnJBBKXQHFVW
         86+5hoq1VGfR2O75aE4rrKQ2Zvv/iSI3KvzggjkmEr83QKolCys0s4jkddXvipcvNN+O
         PUkW0JNwdY0y0Iuk4cd5qKBzRYjLzQ32jfg+OuGIol907kFiBDtNZudsqVngD4gOg9IN
         ATMkSP3wMvoI47E1fjJuWPzmZTLWmZA5eOx42c4PXt3fmSsm0rqHIQHSQhK5+lxl00nf
         033qpqpXIaiqre7EnqYY8XG1geur9pEj1V0bfkPcbxZS/gtsfT2WMXHuTBPoBL8n8GrP
         6NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544579; x=1787149379;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJ48GcoLApm6K65tu+1RPm+pfiT7DLMVSMHPA1LbbHY=;
        b=h7GROn6zV2T6YML0aUtDBGrNmcTdVH4zdCT54h37/Rv4Tdf/FKhA3RR/fo1cvLj4zd
         SsFiYnlV5Id1h+1V0p5i0XE1enx/HXLIrSP4dUsMHYbq4cJycXTi7zk0+aBg/24z6x4l
         mRchfBWICbsqr/rF7pQ5huiNxlfM4O4ap5TH/wanEU2SWhqe/3h3o9ov/tFOiH7UL/d4
         Pj6Ef/Ik/tQLNwKIB1hAtjMEf8vfLtfbAnB9mSRzocpdRqlFxRSavACZU/Ek6T7wCWii
         4WAoibAvbQFD/LlTLuIOWxbQfSCb6+6p5uEsEv0RvIpwffzpNQm1WrQwsrwZFneKFZ28
         uMpg==
X-Forwarded-Encrypted: i=1; AHgh+Rovsim8VSgrPKLZk9DxcCGssJh9u3Cd6X6ZHupGO6QKy2NP98/LN/ipWKRUh3HEe7LWMlOL7fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbvsoQaGUxmwGBkB6m35s3ja7BPD9tr2CrrS9ZOulkDkmZh9D
	rB5HjqRne+Cn5WdboimWfqnQtkrPVdgLDuPM8BwfOa4SpPmZwiKVpQrptGibLxnyZ23pQCFclqd
	2xHvC4gQUQJWbRA==
X-Received: from qvhh1.prod.google.com ([2002:a05:6214:da1:b0:907:5e8a:6703])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4819:b0:51c:2230:7efb with SMTP id d75a77b69052e-52d647f4609mr45991041cf.23.1786544579011;
 Wed, 12 Aug 2026 07:22:59 -0700 (PDT)
Date: Wed, 12 Aug 2026 14:22:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260812142257.21283-1-edumazet@google.com>
Subject: [PATCH v4 net-next] gre: fix ERSPAN o_flags race/corruption in xmit
 and fill_info
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, 
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
2) Using local stack flags in ipgre_xmit(), gre_tap_xmit(), and erspan_xmit()
   to prevent TOCTOU data races with concurrent configuration updates,
   and passing them to __gre_xmit().
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
v4: addressed sashiko's feedback.
v3: https://lore.kernel.org/netdev/20260811095237.2314234-1-edumazet@google.com/
v2: https://lore.kernel.org/netdev/20260720135132.3957146-1-edumazet@google.com/

 net/ipv4/ip_gre.c  | 42 +++++++++++++++++++++++-------------------
 net/ipv6/ip6_gre.c |  5 ++---
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 6a92607401e8aae5a10bd758820d37f51fd7a25b..82309efd417e0f1f6554e7028be8e05d769e932d 100644
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
@@ -653,6 +650,7 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 			      struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	IP_TUNNEL_DECLARE_FLAGS(flags);
 	const struct iphdr *tnl_params;
 
 	if (!pskb_inet_may_pull(skb))
@@ -688,11 +686,12 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		tnl_params = &tunnel->parms.iph;
 	}
 
-	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
-					      tunnel->parms.o_flags)))
+	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
+
+	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT, flags)))
 		goto free_skb;
 
-	__gre_xmit(skb, dev, tnl_params, skb->protocol);
+	__gre_xmit(skb, dev, tnl_params, skb->protocol, flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -705,6 +704,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 			       struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	IP_TUNNEL_DECLARE_FLAGS(flags);
 	bool truncate = false;
 	__be16 proto;
 
@@ -728,10 +728,12 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
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
@@ -746,8 +748,8 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 		goto free_skb;
 	}
 
-	__clear_bit(IP_TUNNEL_KEY_BIT, tunnel->parms.o_flags);
-	__gre_xmit(skb, dev, &tunnel->parms.iph, proto);
+	__clear_bit(IP_TUNNEL_KEY_BIT, flags);
+	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -760,6 +762,7 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 				struct net_device *dev)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	IP_TUNNEL_DECLARE_FLAGS(flags);
 
 	if (!pskb_inet_may_pull(skb))
 		goto free_skb;
@@ -769,14 +772,15 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
-	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT,
-					      tunnel->parms.o_flags)))
+	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
+
+	if (gre_handle_offloads(skb, test_bit(IP_TUNNEL_CSUM_BIT, flags)))
 		goto free_skb;
 
 	if (skb_cow_head(skb, dev->needed_headroom))
 		goto free_skb;
 
-	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB));
+	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB), flags);
 	return NETDEV_TX_OK;
 
 free_skb:
@@ -1560,12 +1564,15 @@ static size_t ipgre_get_size(const struct net_device *dev)
 
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
@@ -1608,12 +1615,9 @@ static int ipgre_fill_info(struct sk_buff *skb, const struct net_device *dev)
 
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

