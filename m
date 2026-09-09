Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881C492E2D
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980538; cv=none; b=N7kDjWFX13tTI3PdeOHrflwH+F4hfDM8TYOr6xP4W5AIt9VNbgIHM8NjqSE+PvKT/NhYJuVfgRiAiS0uhi8MztawvyUsbGjMlbn3zNegGA/frnmSmQXxSz61C6Ui7Rvsws3LxM20M2iCn768ftZ2Khny0VJeFmehsE+7oQWehfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980538; c=relaxed/simple;
	bh=ulxjNuiDc1v4p6vkr+ativIZP9YoQWnvRoVnUEHpw6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAN6ffLzXmjWDzUNXg3MTGGSIk0Zctp7D9ete2xalgyLp8e4Y0/iduuACkgNNq4mS+nM31z10d1i3OIJ1us+RzFuBWKiArjhyrKakeou5y5mUY/U8P17dLsqzxWtjTal1uBs25cfsgODyuudUhwhvsIwbe7VZxrbsMr5BIc/dgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=m4P4bjY5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="m4P4bjY5"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2db858d60e0so21774995ad.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788980536; x=1789585336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UyKxHk5Nrdwl00WqKr1Z4ye7umgcWAGSca5dNYYCDQo=;
        b=m4P4bjY5rLzyoi2rVVd4nqm2GlKdU2q3V9cNflXCKtu9A8iuZl0g7JbiHH/yNxa8mK
         1ONoqwOWqcVb87ZXMc2hXdNixYf3bePINyJfls0Vm6rz5hqZkCOFotyrStEy6V/PCBdz
         RVz4KedGuTGKfy3awgzYbN8eYcAvD4XDV+6q9A+dB7SBBDDbtb6egYenl+29Bb7upIpP
         6wWiM/LJ5VBv73TDqD0Gp/zSoTOcpE3gTN760wITWQwFQPaqFwBe1zAR1KKvf8wv1Zuh
         tonGGIVXAI0UpfWQA1UdSTlHLy2NSVLe+hB/ocQWCEpwkDeA+IOOqyhqKnOevjbsIUQ1
         nuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980536; x=1789585336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UyKxHk5Nrdwl00WqKr1Z4ye7umgcWAGSca5dNYYCDQo=;
        b=rSNDZvMvsvEtKQTo9zZr3uYTIfBCtOZIUVMTBDEBzlArgpty8qBIs6gv9lSc/JH88/
         eXl2FUNP+EF7b6f1JpWugPxS1JLw2HSiLq7IYq/zadL7A+BD4dat1fJE7WEcGOJD5GxI
         EKJiroLJ6bZlZCXx4Q56LxLkwOl+XRbAEG1Nbqz4X4TytkPxTRJdZRaYVnTwX9VXYvxD
         bwRNM/BypqQiOZfAxUcL9FwPLrn1v/QDxjVRYSV497ifE1iGlrGNRkaAEeYV2MKi57DN
         PsZTG4cUkYn1vXny31ohWMrYSRnlJuq9G3dbQeQBDfWR9UX9B2D9kHvGu5HMWi84Rqg4
         /uHQ==
X-Gm-Message-State: AFuF++l9CSBkGxCCHzdXQsPfpbQkXnbU+CUe33ldjMtxQhikEYOOu0JN
	7PRCqx64Ch/bGlyJcaSjm6rawMWdh0F+H4B1LquOwv9KzlbSxGmqZRt0//gNeTCeOwx29NNZj1N
	Kek2vTtIIUW8=
X-Gm-Gg: AYBFou3oZEgtrVkhvibii7MgRFif4f5Ltclp0AM23jUDQyZny2tdb8hqPTAcWRVsb+e
	8gU+Wy7nrpbWEBsBldmgTS+GCbH9iHE1rQ3gnbLDCj69xaC9EttVbR3vMnLEj8OhIrme0zTfOiG
	k9eeLvgZdyEt3lW58D+8oTM+nJZ/NLQ3TNHiHtNBVUwTuOIvJhUC4plo7GICaiM96szzGusAFEq
	azy7+ydN6DsYSd8yvLFtsjze1sVRumnap3P2juTnKmn11f8zCtrmd9xj34+iBocq6uTrCKNHoBc
	J/+l3FJI3B/GSz/b/M1s59Q4c3/ukw7T7b3EcATkcaOGmbqKVuw3xZEwH+05o2Ec51syyl37Wjf
	WNeooyInmA8lsruF8QLzZmSwppsGsUdr5QcwTuqeVHTUjJGeOwoB76M3HjApWBWfEyYMYi0iqy4
	RHabP7lgsZ68/8+AaK4ih1J35BcUx4AsG3mOuMsLjp7e4tDeBGE8NKu6pu3uYibifgWwbtu98Nd
	wPpjiGg
X-Received: by 2002:a17:902:ce89:b0:2da:e967:7953 with SMTP id d9443c01a7336-2db125f1626mr467025135ad.12.1788980536061;
        Wed, 09 Sep 2026 12:02:16 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1497d9ddsm77771745ad.31.2026.09.09.12.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:02:08 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
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
	weir@nebusec.ai
Subject: [PATCH net v5 1/1] ip6_tunnel: snapshot encap in xmit
Date: Thu, 10 Sep 2026 03:01:15 +0800
Message-ID: <ca20d8addc2d6b01cac83ed9661e465c47e9b94c.1788778433.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788778433.git.petalzu987@gmail.com>
References: <cover.1788778433.git.petalzu987@gmail.com>
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

Take a field-wise local copy of t->encap before calculating the
encapsulation header length. Use the local object for headroom
accounting, metadata validation, and header construction. This keeps
those operations for one skb from re-reading the live configuration
after the headroom check.

The four fields are read independently with READ_ONCE(), so the local
copy is not an atomic snapshot of a changelink update. It only makes
the length calculation, headroom reservation, validation, and header
construction use the same local result.

Update ip6_tnl_encap_setup() to validate the new encapsulation length
before publishing the fields, remove the clearing memset(), and use
WRITE_ONCE() for each field. Failed updates therefore leave the
previous valid encapsulation configuration in place.

Keep the snapshot helper in the shared tunnel header because the
encapsulation structure is shared and the helper may be reused by
IPv4 tunnel transmit paths. The existing t->hlen needed_headroom
adjustment remains unchanged because it is separate from the
packet-local headroom calculation.

Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/ip6_tunnel.h | 10 +++++-----
 include/net/ip_tunnels.h | 10 ++++++++++
 net/ipv6/ip6_tunnel.c    | 28 ++++++++++++++++++----------
 3 files changed, 33 insertions(+), 15 deletions(-)

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
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 7c9aadfe8fe3..ab217ddbeb20 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -522,6 +522,16 @@ skb_vlan_inet_prepare(struct sk_buff *skb, bool inner_proto_inherit)
 	return SKB_NOT_DROPPED_YET;
 }
 
+static inline void
+ip_tunnel_encap_snapshot(struct ip_tunnel_encap *dst,
+			 const struct ip_tunnel_encap *src)
+{
+	dst->type = READ_ONCE(src->type);
+	dst->flags = READ_ONCE(src->flags);
+	dst->sport = READ_ONCE(src->sport);
+	dst->dport = READ_ONCE(src->dport);
+}
+
 static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
 {
 	const struct ip_tunnel_encap_ops *ops;
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index d5ff50a2ac01..0ddee4771ada 100644
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
 
@@ -1202,6 +1204,14 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 				     t->parms.name);
 		goto tx_err_dst_release;
 	}
+
+	ip_tunnel_encap_snapshot(&ipencap, &t->encap);
+	encap_hlen = ip6_encap_hlen(&ipencap);
+	if (unlikely(encap_hlen < 0))
+		goto tx_err_dst_release;
+	psh_hlen = sizeof(struct ipv6hdr) + encap_hlen;
+	max_headroom = psh_hlen;
+
 	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
 	if (encap_limit >= 0) {
 		max_headroom += 8;
@@ -1240,7 +1250,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		goto tx_err_dst_release;
 
 	if (t->parms.collect_md) {
-		if (t->encap.type != TUNNEL_ENCAP_NONE)
+		if (ipencap.type != TUNNEL_ENCAP_NONE)
 			goto tx_err_dst_release;
 	} else {
 		if (use_cache && ndst)
@@ -1264,7 +1274,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 			+ dst->header_len + t->hlen;
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
-	err = ip6_tnl_encap(skb, t, &proto, fl6);
+	err = ip6_tnl_encap(skb, &ipencap, &proto, fl6);
 	if (err)
 		return err;
 
@@ -1818,16 +1828,14 @@ int ip6_tnl_encap_setup(struct ip6_tnl *t,
 {
 	int hlen;
 
-	memset(&t->encap, 0, sizeof(t->encap));
-
 	hlen = ip6_encap_hlen(ipencap);
 	if (hlen < 0)
 		return hlen;
 
-	t->encap.type = ipencap->type;
-	t->encap.sport = ipencap->sport;
-	t->encap.dport = ipencap->dport;
-	t->encap.flags = ipencap->flags;
+	WRITE_ONCE(t->encap.type, ipencap->type);
+	WRITE_ONCE(t->encap.sport, ipencap->sport);
+	WRITE_ONCE(t->encap.dport, ipencap->dport);
+	WRITE_ONCE(t->encap.flags, ipencap->flags);
 
 	t->encap_hlen = hlen;
 	t->hlen = t->encap_hlen + t->tun_hlen;
-- 
2.34.1
