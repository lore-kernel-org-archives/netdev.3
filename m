Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE93C1D5C
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643013; cv=none; b=mUCASo8PZxb8Fc8aiqg0yg4+OpHO6z7MkQGBbLuyRkoMSYrmb2ChwziZtyGApV7hotRlsycRnaQoAB7DDDe1uisg75o65Wf1KFNvSN78cw+Zma6P52bGbZljF1li3zUeEjHGncfIzQdprZ3ktOOwipVeW2E2YkkSVEjHAmqFhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643013; c=relaxed/simple;
	bh=pms7euRtzURrM/FpFwoQgkMbZg/fnxQ0eDkswwPzdGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6zMkDhpTUvedDeLnXkBNFb3fvq5G54muUOpNkTiJf5aduaFgoTBjoZ2vjX7WJEA/ii3eg1IoA1U583GFFA+Ntj21gVKHAe6AI87aliKECxiOh7n/ncE6QZBbMtq7Yjh1NJe9bMAIw7XHB+P2zKjvT8i7rHsxWlpMCp0/ppLcxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=rdG7hmu6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="rdG7hmu6"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d6af66ca14so19998025ad.1
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 00:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787643011; x=1788247811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BU9EJHssTkGGRD4+ebls8886iYUUrTr8SIYYuo4i+o4=;
        b=rdG7hmu6VLIteJkrsxo+oCCZx7NN1yVIzxnWukFMnRMmQTJybKQMHSIzZjtGUpz6wy
         9NJ7+GUUAPtZ8qIGCnue7d73h/G0U/0L4IsBdhC+UkUsw/sgR0+pYzsG/Zt+YGyyKV3C
         40PteidRD9YhGofKPx58q0SF3xiUh3VF1gDmeB25g8/A+Vcp0EavG4s58WmYDazJLgG3
         CfFJTQQbbreZiXv6Eq2NL16Pwhj7EGfj2Ol0dmP7He6Gs/tNOqYYJHikvfHCWtdJ4or4
         ElIH/MqesWxjaqCWYyPzHH+bkac0JDsyd/HiwzI7cmjOakslOd4dEkHmP26XRfjtw4m1
         mUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787643011; x=1788247811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BU9EJHssTkGGRD4+ebls8886iYUUrTr8SIYYuo4i+o4=;
        b=fQvCR881GCLtzcYvxvtJCNLyhzS/1M6OuCn44cD2sUe783cYEvtNiNwbfPyhYW68lL
         HVtZCM4w3toj4uGyKTQCDY5g4FeSD9XblQ0RDqDC9i1USW1+gstQwU9e1z0OzhRNFi91
         /sZYBHkYBH7GqKYJGeOC3T9F8jsvEpfFrqutwg6avR05ukt/Q0C36teQrAn2ORoZjU8Q
         hUJt044OITBhP2Ovhan0mRK3eJPekI1/vyz60wlMwckgRdVqvHmZpC0oSAn6vT2BwSfa
         5ZlqzOq0V/ahzMdEs4i8Y2owDk9d2t14CbS7W+Rs1jy913ezGPzHSGnOQuZPpGKjq2JO
         7pww==
X-Forwarded-Encrypted: i=1; AHgh+RqeySfNeImxf23XEzPFGG65kAZzylpX9u9lr/XG+SDAr77eRidCWwYroxijx8ySqdy25wC99mc=@vger.kernel.org
X-Gm-Message-State: AFuF++no5CEJF6X+msQXxN8bzHIdtrbK7On8Exn0i/fNrlGZgG0TzO6V
	MZTviXxXL2DMwhOxtDxwA3/u7JeAEVyiz+UUG9XHjxMJXqyTA84R/kiYBBQKLlyTDzco
X-Gm-Gg: AR+sD12DWjix7OXY4zsKjwzgTT//zEARXiKRH9RuRWSKxSy0V93ShnsuJiTY+VFkqbA
	pT4gs/dV2+8hpi8ac3mjXQv1wqloH6QieoRcLUuaARclyY+btRsYtoR/gPIITa+hIhVp3vZc30K
	YFa8VPo8jGMfOM47tdd2C9RbwowRVeCJPCx0jAAbSJm9k5gBKBKpOhbcGa24wy1TQgRsgHDfeq5
	edhBJ1BVvjpzkqqJ3fFtm+pykOcYHfSxTknStxmKM8+i3Jqx+rn3J4idp5+I0sh8dPSejwSJxSK
	EQeYhZiu+Q6KGWoiQaAgbXw1YCeY7sijdbIxGd9P3OMTkCfxByw91tQRFV4fxqyk0xaxrQZjx/w
	MQCFgXzGk3nKUisuIWBXToW0WfoZOYPlc0EOa/RQQbVoDzjhnVYjZeoLtf2VpIh6sLfmLn8cN3l
	ykcEBFSAqLhUbTSW0y7VhE+SA59CmZc0TLqdA/D7stLOORKRaFe8nz/hWT9y7HvGzP3X6KL0M=
X-Received: by 2002:a17:903:3888:b0:2d0:cc92:f7c2 with SMTP id d9443c01a7336-2d670b4cdc9mr451650615ad.1.1787643011180;
        Tue, 25 Aug 2026 00:30:11 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676761c35sm25182575ad.15.2026.08.25.00.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 00:30:10 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: iprintercanon@gmail.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tom@herbertland.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	enjou1224z@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v3 1/1] ip6_tunnel: snapshot encap in xmit
Date: Tue, 25 Aug 2026 15:29:49 +0800
Message-ID: <99ba13458fbcff6d646ee223f0b70847b790777d.1787499036.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787499036.git.petalzu987@gmail.com>
References: <cover.1787499036.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

ip6_tnl_changelink() can update encapsulation parameters while the
netdevice is transmitting packets. ip6_tnl_xmit() can calculate packet
headroom with t->encap_hlen and later build an encapsulation header from
the live t->encap. A concurrent update can change the encapsulation
header between these accesses and make skb_push() underflow the skb head.

Take a local snapshot of t->encap before calculating the encapsulation
header length. Use that same snapshot for headroom accounting, metadata
validation, and build_header(). This keeps all encapsulation decisions
for an skb consistent even if changelink updates the live configuration.

Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 include/net/ip6_tunnel.h | 10 +++++-----
 net/ipv6/ip6_tunnel.c    | 19 +++++++++++++++----
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
index b99805ee2fd1..6e76e50a4406 100644
--- a/include/net/ip6_tunnel.h
+++ b/include/net/ip6_tunnel.h
@@ -106,22 +106,22 @@ static inline int ip6_encap_hlen(struct ip_tunnel_encap *e)
 	return hlen;
 }
 
-static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip6_tnl *t,
+static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip_tunnel_encap *e,
 				u8 *protocol, struct flowi6 *fl6)
 {
 	const struct ip6_tnl_encap_ops *ops;
 	int ret = -EINVAL;
 
-	if (t->encap.type == TUNNEL_ENCAP_NONE)
+	if (e->type == TUNNEL_ENCAP_NONE)
 		return 0;
 
-	if (t->encap.type >= MAX_IPTUN_ENCAP_OPS)
+	if (e->type >= MAX_IPTUN_ENCAP_OPS)
 		return -EINVAL;
 
 	rcu_read_lock();
-	ops = rcu_dereference(ip6tun_encaps[t->encap.type]);
+	ops = rcu_dereference(ip6tun_encaps[e->type]);
 	if (likely(ops && ops->build_header))
-		ret = ops->build_header(skb, &t->encap, protocol, fl6);
+		ret = ops->build_header(skb, e, protocol, fl6);
 	rcu_read_unlock();
 
 	return ret;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01..63c524b080dd 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1102,6 +1102,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		 __u8 proto)
 {
 	struct ip6_tnl *t = netdev_priv(dev);
+	struct ip_tunnel_encap ipencap;
 	struct net *net = t->net;
 	struct ipv6hdr *ipv6h;
 	struct ipv6_tel_txoption opt;
@@ -1109,10 +1110,11 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	struct net_device *tdev;
 	int err_count, mtu;
 	unsigned int eth_hlen = t->dev->type == ARPHRD_ETHER ? ETH_HLEN : 0;
-	unsigned int psh_hlen = sizeof(struct ipv6hdr) + t->encap_hlen;
-	unsigned int max_headroom = psh_hlen;
+	unsigned int max_headroom;
 	__be16 payload_protocol;
 	bool use_cache = false;
+	unsigned int psh_hlen;
+	int encap_hlen;
 	u8 hop_limit;
 	int err = -1;
 
@@ -1202,6 +1204,15 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 				     t->parms.name);
 		goto tx_err_dst_release;
 	}
+
+	/* Can tear, but hlen and build_header() use the same snapshot. */
+	ipencap = data_race(t->encap);
+	encap_hlen = ip6_encap_hlen(&ipencap);
+	if (unlikely(encap_hlen < 0))
+		goto tx_err_dst_release;
+	psh_hlen = sizeof(struct ipv6hdr) + encap_hlen;
+	max_headroom = psh_hlen;
+
 	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
 	if (encap_limit >= 0) {
 		max_headroom += 8;
@@ -1240,7 +1251,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		goto tx_err_dst_release;
 
 	if (t->parms.collect_md) {
-		if (t->encap.type != TUNNEL_ENCAP_NONE)
+		if (ipencap.type != TUNNEL_ENCAP_NONE)
 			goto tx_err_dst_release;
 	} else {
 		if (use_cache && ndst)
@@ -1264,7 +1275,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 			+ dst->header_len + t->hlen;
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
-	err = ip6_tnl_encap(skb, t, &proto, fl6);
+	err = ip6_tnl_encap(skb, &ipencap, &proto, fl6);
 	if (err)
 		return err;
 
-- 
2.34.1

