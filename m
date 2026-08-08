Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08329B78B
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786178463; cv=none; b=TfJiyRl/yqKCsZzz0m0Zh1Eh+KM6S5tH3mLe2WKhRGkGYyK64OJMJIV7d/r7N1kr5liJlFVgjzWx1jzfeVal+h6rOzJBkWv6iVEEcNNkXEadTcNT50/tYlYrmkAsaOXI4s8zh9djzTTRr5Ts0SrdeX+G4feDNnDv410DIHczmks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786178463; c=relaxed/simple;
	bh=qtMYXq3KlNU386+lSNDIbBTssmOEj46kl3ztH7MS0wE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mv4FRgVbiPMHjgh1fhN+D4lDxl6SYzOfQbeGRq5oMx+AFIkntT0E5SZhVK3mFmC6AsGLVcE7+OyEWjZGhhqni/JxGjfTwXaGl6SWy1MzJJGtF7cZIu8PlDOIaazzHR7CWq2304MiZFo+y4Z0AdMaB3pqLtoRux90gMhrJPfxq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=iqGdym8k; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="iqGdym8k"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso332414a91.3
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786178462; x=1786783262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H3Du2PWv98Z5jwGS6XrYXCLNuGrRsK46H9DGqp4OKpc=;
        b=iqGdym8kj1OwH63kMy5JPOglFrtfPfVKHX6ttGgOn3n+V0VIui6xw0dlxtVImaprAB
         p1wWWpJ1OoS3W+Jb+kFvjXRYRWFQAHTukErANoKDQKdk/TI/+QV6dzczCpoqp/W2SSC/
         1KkqCGBFRQLYPx0edqyEvJKdirDCAStsfCsszwehaiymrJv0VNlBVFM2hOK0xRSeHNWu
         54fwR9PYjgpSu/jAbCvMj4+HTVm+GjE/q8GakdDV1DVvk9hDIWdMdReZeZBxwXiACW8T
         qkF8GK5KO2sV697R896+cQDbaFkYiey21EK5UHCHzG6LhNtOiY7bStavra1rTGE5zWJJ
         7ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786178462; x=1786783262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H3Du2PWv98Z5jwGS6XrYXCLNuGrRsK46H9DGqp4OKpc=;
        b=DVZtXf1s/2oPOssG9EGEtbGaWuX58hDmCYS4K0OJhazgNuQ3qqzvK76Nld5nsDyiTz
         wQiNtKZqk2CmgPb0WN+YjUlN/CwPDfTSapqO+2DuK7FgRrW27kXm4gNtF5GjrfdoRn5I
         HIFknu6RBTnLcaKN5ilwH5fVSpIbmZ2hBK7NDA/6g/uac4cWs12NlgYKy23DUEIGyrAK
         BmXvZhqRDrVqAjE+raeZNYM+Eh21sMtxq/1e2IdNWQN4cs7sNNPJktY/vXGTC0L+GYQ3
         ed5+qIt/+j9EJ4ydiX3QdH977UKNuA4TH8/McMG32brGZ2UdVZ8OMvMqusLTGKsjt94W
         uOsQ==
X-Gm-Message-State: AOJu0YwjXZZAZ/ozkCjKBG3j29L2u0BN0HKBWHrVYacZs/YJptnVNAnB
	oRJeV9eKAwrA/+JlVnIaBM+A2NkYAWyRXqRBsHHFmvQfLN6cvxYtV0O3U+ZjYjz3dzX3PR39EmM
	8FChA+VFo
X-Gm-Gg: AR+sD13fPl3YUcCiCqCQzQxH4Wh0sE3QCNV656CCnPDHWIkfpUyI79iBPazvgh3z+HI
	RISE7dAzwjUIQiloLOx99NHqjpMfcmEApvJpHYt2A5PwxbHdPNuDF++oPsnLm+IvgodKZKxd2qQ
	uYDbS10hV+GXAfk+34qVIM+Ldzq2CUL8KyTAPZPVHI2DhdtdRHYOpxQhy8KeJ8svQj2vXQv3vxX
	XwPrs+MWeLEgzpyDU4eu5qheYFCZ121aFcUAVZ9jz9H92zQ/xaunH28Us26sYFOQMTiHDuRlvwo
	X2ZFDysnzpBelTfzt8ovx2Jwm1vfFPi+TB1kYke11d7x/MCgaoVPy4bdRfIvjXd0mFtT2sjUp/3
	7+n/0laAisc6OQEvWNDEP9CNMJhVWu5SGrLevMuWXAU55VtVzcq1ofdo6JvjZDMsQKOqsTkU2SQ
	Y8eASHITOQ+WHqxS3OKumM1AGXwxxlSB4b0Je3fsL+egIB7IOEBlUnUpvBcpQUdVQ4Zhi4nw1M2
	Z+Zw+b7
X-Received: by 2002:a17:90b:3985:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-392620e6f9dmr9267223a91.12.1786178461717;
        Sat, 08 Aug 2026 01:41:01 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de9c0fsm7956459a91.5.2026.08.08.01.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:41:01 -0700 (PDT)
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
Subject: [PATCH net v2 1/1] ip6_tunnel: snapshot encap in xmit
Date: Sat,  8 Aug 2026 16:40:49 +0800
Message-ID: <b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1786088695.git.petalzu987@gmail.com>
References: <cover.1786088695.git.petalzu987@gmail.com>
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
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/ip6_tunnel.h | 10 +++++-----
 net/ipv6/ip6_tunnel.c    | 21 ++++++++++++++++-----
 2 files changed, 21 insertions(+), 10 deletions(-)

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
index ebf83f090376..d47757e8a388 100644
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
@@ -1251,7 +1262,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	}
 
 	if (t->parms.collect_md) {
-		if (t->encap.type != TUNNEL_ENCAP_NONE)
+		if (ipencap.type != TUNNEL_ENCAP_NONE)
 			goto tx_err_dst_release;
 	} else {
 		if (use_cache && ndst)
@@ -1272,10 +1283,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 * needed_headroom if necessary.
 	 */
 	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct ipv6hdr)
-			+ dst->header_len + t->hlen;
+			+ dst->header_len + t->tun_hlen + encap_hlen;
 	ip_tunnel_adj_headroom(dev, max_headroom);
 
-	err = ip6_tnl_encap(skb, t, &proto, fl6);
+	err = ip6_tnl_encap(skb, &ipencap, &proto, fl6);
 	if (err)
 		return err;
 
-- 
2.34.1
