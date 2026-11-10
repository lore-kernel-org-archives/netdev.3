Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342035;
	b=Jc/tAKS5YXkLosNFB4KsQ9LXlt7Gtx5baYQV6886BcY8/Z0sa7XIQSkvQrs27BGGEjHD
	 Hwh25yepS/0PZU4XoYnLQaFTjSMzFpJawvuRzNTuejI/FJh9YzJWVJ5moDuD54mrzAFTj
	 T7+LjA72VEOHz5KPo7hH5ojHyfyGpOmRi3OIeGPmVytgKOjQ86awGWCX/jgiL9IBjsHhp
	 3nWKnHyN1upt/wm17PGmI/W8XnB+A6jMZLpK3amNGNOKjioezjTM2KcPcpVUByk6UeZhy
	 Xny+LC8LK19UrzI257m3nBZFJWqWT5TLv0VK4UQPEZENfvEtsJDUmcacht0SY3QpeqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342035;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZjZKFJ2EmsBkFUt4w4LMIu51Vj/2Mg/+ePZ3/ZrD/O4=;
	b=pErrtyeCYALFfBXHmkpIXuDi56N4Yf63C9vrm12H6ySCSWDIHajiW6zRP+STrMz0Ucwe
	 ZlecKlnXEHn6nnNGMdRPsrEvomW90TLlTKJawXDGQOMLP0QfjzidPKe40cCo4pSlyQwbI
	 S9Z8amdxx1bCIMKeh6HPhFFMvXVJwt20ntwEwe8tgslJ7EfdD9Xv/1en9pY6gUOB87SvB
	 KKVou/IFqdQaUIt+Zr7mePJ0qngIAPDWb+PPgtU9j/J2evQ2LD+0VghCMeXJQTkLoPuii
	 +hybZ5IePUXoP7CggCUmwNbWcFJ8HkbHAyUp6eczKUidgKQb3ST8xoOUoD/bHfew25g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csB3MXzL;
	arc=none smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6786060A3820
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 20:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6786060A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csB3MXzL
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ae0eb56ba1so7668841fa.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 12:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794342034; x=1794946834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZjZKFJ2EmsBkFUt4w4LMIu51Vj/2Mg/+ePZ3/ZrD/O4=;
        b=csB3MXzLfkEhDOZE/zrOJAhMVNKXDIBuctnSWFtDebYg1mqtZWnu0KowZaQQNPPxqi
         zrdOqZx7Xm1wHBwBakrJxr71CJmSeEy3oXAw68RTqv+Kl9h8T9ajZFuyf48etwDgdVPh
         RL8FO/ZqYfbRHradTVBqTaJa37iXE1TQFZwUHA5e8Fo3GAB2sTFx6LjmAWifnleIwocn
         JPLK8quK2EQcQQPfarlMLPM/ZmaB93bj9q/TwxhpKaHPQQ6bFgFPwxSDH8J7ukUoY75/
         8y/1wVYtVraIyVe/lH1udJa5KdBWiPRzukzF9/sCFaVxYKZW9RA1hdL5Ten4CrZkKzPf
         sRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342034; x=1794946834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZjZKFJ2EmsBkFUt4w4LMIu51Vj/2Mg/+ePZ3/ZrD/O4=;
        b=1kwgACDsSyv0axsTfFvMGgoIv8V5ipyw+ri5GYQ+laJvYT/z3IKU0xXmkUywtzY1A8
         SUdiqWnmaLRxr+nkH+ffWXQsiazT8trnwylNHIocIaE97Wbn7Hc4zXwNHl/rfEBao4+S
         KGeH68zRY7r+JB7gXrOHSmZ921BCheMSki9Oez+T52uxdaAHJP/KzwyaZbcQ/o1DBmyf
         O91dpGpMhrNTlTX60xoPkXqTSjGVZjjpN5Q7/Nv3BSpSnGqrAnzcLDRDQ8wPVfLffSCJ
         EiTVXmi9c1NuL/W8DR730yHePkDJdlSugaf1mK4wUTzyNgtfw/LsEimI3KdyfSrY/HUA
         4ZWg==
X-Gm-Message-State: APuU4Z+420CcDjEypecrtuc6DnUSB87yNJ9h3b5pfekYlnZvVyGITmUy
	iktVoZGnNjLQ//K4CHpcO2GPh9/3Ime69rjObOTAETJFW+NFZTtUemS8qSOxOYNqmYEwIg==
X-Gm-Gg: AYBFou0+2wvezPfVMDjsVOmZGIWgr0N1eipVBhq43W8evVM2mFstp63hAOm/LZp3QT/
	Pk4vnxn/LmqNQyphHdA0RMEl0kZyLpeKHNbi7X4T2IDnNIHbaBn/vpKn+2HH79Qoq3KVciqJg+W
	fW0Bo9U8BHe4JBOvU9qxmqCFlWQbIxl09cUizdBSvmUU9ZSWlfyivjwPhzQB7tsd7hpyUWMp2Xb
	mM8EqLPTyf0gy3dq+cGHRR0kMy8EbaM3zv3npiESYdH7wtDN6V9hpWRExFIhF81x7h72+0dKObT
	wXw7ZpX2tDCZpgT8od1w6NYcAkUEeOk3CxDoCIWtZFRTqFx6x7XJKP9nAshyK5ISc0T+kYQy0DE
	TjIsSPOInipgBWvCfl34kpzxs0yxIyG/yE+eIZSijj4tIEyrhaGBvw5O4y0Po5iLzvprNq4c42T
	zFYn01r2epd361h/6N6WgxvjdRp5mJmwriRSeLvTMqyEhFVe/OJV1dSTNkU72Bji7QKJbLH6os3
	KVFJhaRVbkkklyGSTeMHpKjwdRpud1VPLJPeV8oedCkKfZcSqdJk4xdXR5ZtGHV5o8bYCrFzelr
	9dtGwOvmv043YO90CXgfuXD2+O+pAeuCqigCWEeZKgZvpRJsiCDmm0LeC6c7fdWz7o1AsET3gb3
	i2j+V/pneIgex2f8midBdACBNQt2mamG+ZoFxWQ==
X-Received: by 2002:a2e:bc93:0:b0:3a9:decc:71d8 with SMTP id 38308e7fff4ca-3ae09644263mr8350061fa.20.1794342033577;
        Tue, 10 Nov 2026 12:20:33 -0800 (PST)
Received: from dau-home-pc.megasoftware.org ([95.139.137.59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae090ea59esm5945401fa.0.2026.11.10.12.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:20:32 -0800 (PST)
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
Subject: [PATCH net-next v6 6/8] ip_tunnel: make ip_tunnel_encap() return a drop reason
Date: Tue, 10 Nov 2026 23:20:19 +0300
Message-ID: <20261110202021.821224-7-littlesmilingcloud@gmail.com>
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

ip_tunnel_encap() builds the FOU or GUE header of an IPv4 tunnel and
returns 0 or a negative error, so its callers can tell that the packet
has to be dropped, but not why.

Make it return the drop reason instead, like __iptunnel_pull_header()
and gre_parse_header() do:

 - SKB_NOT_DROPPED_YET when no encapsulation is configured or the
   header is built,
 - SKB_DROP_REASON_NOMEM when the build_header() callback fails with
   -ENOMEM, which the FOU and GUE callbacks do when the header of a GSO
   packet cannot be uncloned,
 - SKB_DROP_REASON_TUNNEL_ENCAP, a new reason, for any other failure,
   such as an encapsulation type without a registered callback.

The three callers, two in ip_tunnel.c and one in sit.c, tested the
result with "< 0". With the enum, that test would always be false and
no compiler warns about it, so they test for a non-zero value now. The
next patch reports the reason in the transmit path of ip_tunnel; sit
still frees the packet with a plain kfree_skb().

ip6_tnl_encap() keeps returning an int for now: its only caller,
ip6_tnl_xmit(), returns an int as well, and both belong to the IPv6
transmit path, which is left for a later series.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 include/net/dropreason-core.h |  7 +++++++
 include/net/ip_tunnels.h      | 16 ++++++++++------
 net/ipv4/ip_tunnel.c          |  4 ++--
 net/ipv6/sit.c                |  2 +-
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 2df44745cf3b..fb6f3d8da960 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -131,6 +131,7 @@
 	FN(TUNNEL_OPT_MISMATCH)		\
 	FN(TUNNEL_OLD_SEQ)		\
 	FN(GRE_CSUM)			\
+	FN(TUNNEL_ENCAP)		\
 	FNe(MAX)
 
 /**
@@ -634,6 +635,12 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_TUNNEL_OLD_SEQ,
 	/** @SKB_DROP_REASON_GRE_CSUM: GRE checksum error */
 	SKB_DROP_REASON_GRE_CSUM,
+	/**
+	 * @SKB_DROP_REASON_TUNNEL_ENCAP: failed to build the encapsulation
+	 * header of a tunnel, e.g. an unknown or unregistered encapsulation
+	 * type.
+	 */
+	SKB_DROP_REASON_TUNNEL_ENCAP,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 792690ae4f26..87046ba50d45 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -541,18 +541,18 @@ static inline int ip_encap_hlen(struct ip_tunnel_encap *e)
 	return hlen;
 }
 
-static inline int ip_tunnel_encap(struct sk_buff *skb,
-				  struct ip_tunnel_encap *e,
-				  u8 *protocol, struct flowi4 *fl4)
+static inline enum skb_drop_reason
+ip_tunnel_encap(struct sk_buff *skb, struct ip_tunnel_encap *e,
+		u8 *protocol, struct flowi4 *fl4)
 {
 	const struct ip_tunnel_encap_ops *ops;
 	int ret = -EINVAL;
 
 	if (e->type == TUNNEL_ENCAP_NONE)
-		return 0;
+		return SKB_NOT_DROPPED_YET;
 
 	if (e->type >= MAX_IPTUN_ENCAP_OPS)
-		return -EINVAL;
+		return SKB_DROP_REASON_TUNNEL_ENCAP;
 
 	rcu_read_lock();
 	ops = rcu_dereference(iptun_encaps[e->type]);
@@ -560,7 +560,11 @@ static inline int ip_tunnel_encap(struct sk_buff *skb,
 		ret = ops->build_header(skb, e, protocol, fl4);
 	rcu_read_unlock();
 
-	return ret;
+	if (!ret)
+		return SKB_NOT_DROPPED_YET;
+	if (ret == -ENOMEM)
+		return SKB_DROP_REASON_NOMEM;
+	return SKB_DROP_REASON_TUNNEL_ENCAP;
 }
 
 /* Extract dsfield from inner protocol */
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 7d8744ed1664..f3c5d8424925 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -619,7 +619,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	if (!tunnel_hlen)
 		tunnel_hlen = ip_encap_hlen(&tun_info->encap);
 
-	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
+	if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4))
 		goto tx_error;
 
 	use_cache = ip_tunnel_dst_cache_usable(skb, tun_info);
@@ -780,7 +780,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
+	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4))
 		goto tx_error;
 
 	if (connected && md) {
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index a7ec800216ad..9576d146c961 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1096,7 +1096,7 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
 		ttl = iph6->hop_limit;
 	tos = INET_ECN_encapsulate(tos, ipv6_get_dsfield(iph6));
 
-	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
+	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4)) {
 		ip_rt_put(rt);
 		goto tx_error;
 	}
-- 
2.47.3

