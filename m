Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E31314B95
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602525; cv=none; b=oyF4V4klwpuZSOpt0c3sEHs+bLDjtH/E+PrKrSSa6bk/Vz6GnmChbiD7SAf5rVLoEgYMK4XL2U24IcOcA7h7bllIm7P11hh/+PBWfr7kRg3Td9BIlU5YftVQ/mB3n9tRloBK2b0B2yAouINEr/Ox34wkZ6bE+nYmfaEXPSWQJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602525; c=relaxed/simple;
	bh=d1kEFi2dgI7yPst5RrNJLJ4jaqLAqlgLOETc5aB6/ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvQLrWIydnPbhQOP6gqA5XZ7leO/Tbf+zzn5NYCesx7qAHbRgCRaLQdYk00W39DAzXcCFiEUV2ABTVoJYmGAbVkpjAD2zgn3i1pZxFFfv982etSwWdN3v1v6YnrVTW2MOfZTtaz317di/DPa0PmQ6u1ZxA4wPymX9ElHv2jY7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=kmxgr7D2; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="kmxgr7D2"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso1258244a34.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788602522; x=1789207322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1WlAzd/i+j4kX9CBtUrIIq7HtD/s6Y84Xw2IMehcF3g=;
        b=kmxgr7D2U/B00CWdIO/nJJn9CRHy3n1ZrrHsLWSQpdfcUt3RgK3O2vYq2vpFmkh1uO
         adsRc3O3vJ6HUASiovReuc+tqXCbUgD5+nIkqcEvNyFpqdrCOxkL1Iloln2nTB27ZlkY
         joMnW8B1uqFXuoAVT4B4gL1lCQl/lFakiyUTyIsFRQLd+CHv/k58YNNLmtb0E92t4uyw
         v1TFnY2V/hTjSu4wSkRYUt7SxGZzhu8DWxqC1lVMLwIEwuv1Idom829TvfkWevho0uMA
         Lk9Mk5SlcImR9vjBiDvWm1HorJwetcxI7vtsn1j7nv35334umYnPMFZxsPw+9yevl6KO
         2uVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788602522; x=1789207322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1WlAzd/i+j4kX9CBtUrIIq7HtD/s6Y84Xw2IMehcF3g=;
        b=bxrAOvyDJDANeCYf4IlzBfOf+LbyYo09OLtNFd4rBtLRnJF2Bsxgt/2NBzZdLfUcZ3
         HLLEb+PWHWWGSywPB81AvWbXljddHODynUpYnuWWFIEYpksxTnuERxmrBdpHB/v1JVWW
         X6h8n/+RHeesbpISQXaDSdJa4bu1QDjmTgTUlrNZBaTZT01qKohScRMggV9w0VgOMLQe
         mPCm299cXAczMCfN8ayzeRS9+kpHthvwmFxN43FDRtKi1lsOe4JqMV9D74gx+v5qYA/v
         /gd0BKlMMwUK4QSfjjpbjPV+nJkSJPbjZYqRMOqDB/7CgwnXzevjKzKdVZK0q5ULcvy9
         KS2g==
X-Forwarded-Encrypted: i=1; AKwUvBw2ydL4wUNRlbxNs71KkuW0Y9Wi/8lTu+MA1f8pmrk+oOdx6nOkDv84Oyqt3h+kYdpfQ7vQZxI=@vger.kernel.org
X-Gm-Message-State: AFuF++kKOrb+rnZJxY7sjNHpcqw6AYr/fk2NPZzVV+LutEJn3uaZ3x9e
	Yi/f1ojuHlUxKCBdevZ5nsPqT5RFl7SXbkukV2OGkuKURnJTXggAOunPSeFVZXyGWL8V
X-Gm-Gg: AYBFou0ejHyI8DfGh4xmvaNkqKvsgOXAEpY+QTrHfZT6PilK0n6NyQ/S/7XmwBB9A32
	PvkEh+afVSjYjm84+kjfZX/sM+ttlllVncG0J6MHfdoCXwxKuav3wU8Qq0EJMVmEcvq5rkvFLw5
	DT3l/rtPA9o8r01ornAXbc0kzj8GTwNfXuQsRKkcOWWayhOptOC4ZK08lsuApI6yrkjOlCf/F+Y
	WlekYloEw5hrAmWZSykmORSroJrkvBDyqOO99d6xCFn2Tyvd/Pyzjp4btou0Rw1qpvKKpQrNqyn
	nKruSCBss25PxrwMw1LOjqV4w1nOPW+jM3A4OFREBKvrdu+3ouqYXnuOLIeSfS20WLJ+tso1fOj
	6DtuJRxStRwWgYTuLGL4zj0XHys1ViAGe5MGyTkpqbb9Ug/ivo2Hqeb+fKR/4CkpjNxnO2mcNil
	D5FDxw6bDN1Cf9SYGuzAXVJ//I2HKg/Qa1FCxGD+ILK88+8UnWUvjUjqk28nQ395MRY3OUrQ==
X-Received: by 2002:a05:6820:1c87:b0:6a1:8192:4d89 with SMTP id 006d021491bc7-6b6fe2b1023mr7764962eaf.29.1788602522226;
        Sat, 05 Sep 2026 03:02:02 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243908a9sm11676920c88.9.2026.09.05.03.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 03:02:01 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: idosch@nvidia.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	iprintercanon@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tom@herbertland.com,
	vega@nebusec.ai,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v4 1/1] ip6_tunnel: snapshot encap in xmit
Date: Sat,  5 Sep 2026 18:01:36 +0800
Message-ID: <2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280.1788262122.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788262122.git.petalzu987@gmail.com>
References: <cover.1788262122.git.petalzu987@gmail.com>
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
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/ip6_tunnel.h | 10 +++++-----
 include/net/ip_tunnels.h | 10 ++++++++++
 net/ipv6/ip6_tunnel.c    | 18 ++++++++++++++----
 3 files changed, 29 insertions(+), 9 deletions(-)

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
index d5ff50a2ac01..6ca373d6205a 100644
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
 
-- 
2.34.1
