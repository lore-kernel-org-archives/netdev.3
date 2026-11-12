Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482415;
	b=ZVgIbdbfSzHpdTRg4Y7b8kyZ16ZDVpZRR0NnPlNtniEBC7VuSeVwJiGAZJNQxMnw/YMj
	 MaMQ9qTnMhS1gvmSV8I7AzMbe2bE0mxEIwF6iC44q8GOv36fCwCdWrHmquf06MyqCnoRe
	 o4kXo4cM/P8N7ME/bLnR1vLNGCxeYnjIfkzBWdu1CeeJIK4m0TPcc8zhLXvgoLIm+HqnM
	 jkxuhn9cS75iu7zkMEoxA2bBSLbJH2BU+ESoXMa3CNgy72s/k9lZ/J7GlPFpEO+5lHH9X
	 C9VXNz4/iSMxZ9aUd+6OQ/uxZDiwzVi+11B60SWdjUr4UGJ9xpDYkXZScyJQP9+Pd2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=n6P1sRjIxGRsOlYiUP9NL4FyqP6Z5X1r0A8C9mbRGC4=;
	b=T8Ae8wPduJTgwYLgOFaeiaqEqOMOxFpUFK0LU3c9JlsEuM0kpJhgF5BGXDQZT10YSzTu
	 zZy03EmOEuLXxZ8E9YBDn/Wo6MvSw3PafHTUlgCCmnMVTzgJAwZMBlYIWahtYMSaaBD3c
	 j8UHis7TyJ88g2vlA1GR2DJTMeHQub0F35cFt5QStVof1AC3AKS0vLN8b6uRtafe4lQBX
	 cqbbt9p6eiB/cf95GRNVN61/T+EPnRvSJte0g9iTpuUuzJd6WQN5JnUixN3IS4XzETeFZ
	 gY483jI96hPHkEGtt2TN+BqjQc2Z0eljng0mzRUYs7aXEUj1Fxd2I82BINkpznPuRIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDpvB1Qw;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554CC606A8AC
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 11:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 554CC606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MDpvB1Qw
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b18717a193so812976a91.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 03:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794482413; x=1795087213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6P1sRjIxGRsOlYiUP9NL4FyqP6Z5X1r0A8C9mbRGC4=;
        b=MDpvB1QwemOWm3CTeo03llC9nDTT85pdKF7CQHVJ4QTcGuG9oo4tA8eA3MBNT4FF6V
         5DJaFqD2tAOko3Rl61+Cz0ViPM5+rdLnJWECkp7pWQkUgg8qftEEfT7iw/09S/In03vs
         F+uzBBNpzloxd0Jzzhdne4MeV8wSngpMlmiz0lxYPpNUhl+KibVkJK10H9K1ew9ejxet
         LHuSEOV2SFyPkZEHOTrfGjSAnE+8GKkOqymt4VuJq0mLLIw3R25l2EVcpURmish8Mu6V
         34FcuG7yVE2XUO+dFq5anKUiGNaFBK6jYppFWvnwbi/2JioVnPxSTpLd/AFGJ1RPS0QD
         OWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482413; x=1795087213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6P1sRjIxGRsOlYiUP9NL4FyqP6Z5X1r0A8C9mbRGC4=;
        b=nW9goNx/5c9xc33WWjrmVd7B4MBVsKD6o7ki0mMcP+ZXPfbHH145wFK2YbfT+lm0is
         FUvsmbaFpnrk1PYA9ULtrZ5OcAy0WzFggTNXywTKy7UxDRpZeqUEAJZE+3D6STy2v2C6
         XxxlorcVAcd6LU/oF2ndQpyZARQW6D1y0DeE+31wsfuQfPtEYiu/YpfG+IJSGQ3BJZnO
         qU1EGkIvL6n7axzbBHjhCiHNaoa0VsZH13jteSIrD8NoLze3NpWPa1HOdQJ+J2vIPcF2
         RZ/cAnGDHstnX6Wcjsv+r+Zh4cecWMiFLv7gBZuhpno3B43YQfaLS3lf2RsxIitnnTrT
         YLVw==
X-Gm-Message-State: APuU4Z/8Z1wAA9uFUsy5KvtSJb5V+RI6E19SYRsVyoYIn2pwmyEkflCp
	CBkL9Fmw1rfm0xdzGHjnvvbW2iga7ZXoeHvFuLBd0KsAuvV3RuVtrTFPkh0HRfNo
X-Gm-Gg: AYBFou1ToayxMSIcnrGBkhCfAmk3XDX1z47ZIDKOo/DQgTQ17gYhols2ZDQFSnR+0n9
	PcdQsFYargzmXkXVigpRKYeDTWr8Sm8VMVf4FF4w5N+mlTniUVI7QOJK0lrNyabvtC80doQP+ch
	j2k+GHL7r8zOgClsq+rxhrX8rIgRS4947wmqvwp6cMzaXaT9eupv0ctMUz4V0UGmbBKdYnpUo3S
	97joVPPKka7tEekP+r2zmWHkaPDZdt/ViaKQzqRwlVhOt+RZ3Mo4DDGeXpmXdT6gOpwczsHrusx
	VndssNX227h5OcCg6/DuRTRzRLBP3INWUKMCWhIg7x7TKSucWv0JGkdJHsxEpsC1DGuNqlUaFfY
	BUECWYBiHP/zvA2i7WiR2J10qkzrY2fnsvenN/seDzN9XG8hhL3omCpq4EQSoNDqGAVwvHc7jEK
	2NgiPufk/vmhkq/bmqMTBVfY6VJQQIWzVSnr6r5kV0+yzyyNLEp32fExkCdqIwaEVDdoMPiuWCQ
	XbhT1W5QWpgFXjQRsW9GhHwW6xIj523vc5Zm956LdIpNQdg6fZVZbaYtoJkX9EN9ntxKAu4mrNL
	hiXDaq8m0uwQEKM1TyDRS+tp3QH7dwtQf8j044zh5w==
X-Received: by 2002:a17:90b:1f90:b0:3a7:e11c:4e6e with SMTP id 98e67ed59e1d1-3b182f5a142mr5144729a91.59.1794482413349;
        Thu, 12 Nov 2026 03:20:13 -0800 (PST)
Received: from buddy.mshome.net ([104.192.108.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b182dff97fsm3541562a91.3.2026.11.12.03.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:20:12 -0800 (PST)
From: Jun Yao <yaojun8558363@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dsahern@kernel.org,
	idosch@nvidia.com,
	lkp@intel.com,
	victor@mojatatu.com,
	Jun Yao <yaojun8558363@gmail.com>
Subject: [PATCH v2] xfrm: avoid stale tunnel pointers in deferred input callbacks
Date: Thu, 12 Nov 2026 19:19:46 +0800
Message-ID: <20261112111946.375692-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.43.0
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

IP-TFS input can be deferred while its reordering queue waits for a missing
sequence number. The VTI receive callback stores a pointer to the tunnel in
skb->cb, and the device can be removed and freed before the callback runs.

The issue was discovered by Qihoo 360's Tulongfeng multi-agent system.

This IPv4 VTI use-after-free was reproduced on Linux 7.4-rc2 in an x86-64
QEMU guest. When the IP-TFS reorder timer resumes input after VTI deletion,
KASAN reports an 8-byte read from freed memory in vti_rcv_cb(). Relevant
parts of the report are:

  BUG: KASAN: slab-use-after-free in vti_rcv_cb+0x696/0x770
  Read of size 8 at addr ffff88810eae4b58 by task swapper/3/0
  Call Trace:
   [...]
   vti_rcv_cb+0x696/0x770
   xfrm4_rcv_cb+0xa6/0x110
   xfrm_rcv_cb+0xca/0x140
   xfrm_input+0x11eb/0x6660
   __input_process_payload+0xb87/0x24c0
   iptfs_input_ordered+0x560/0x8e0
   iptfs_drop_timer+0x464/0x8e0
   __hrtimer_run_queues+0x270/0x600
   hrtimer_run_softirq+0x14b/0x270
   [...]

  Freed by task 394:
   [...]
   kfree+0x23c/0x490
   kvfree+0x31/0x40
   netdev_release+0x6d/0x90
   device_release+0xce/0x250
   kobject_put+0x18d/0x4f0
   netdev_run_todo+0x724/0x1360
   rtnl_dellink+0x401/0x1020
   [...]

Keep only scalar tunnel metadata in an skb extension. The VTI callbacks
look up the device by ifindex under RCU and check its link configuration
before using its private data. If the VTI no longer exists, drop the
deferred packet. Use the same metadata to preserve tunnel mark handling
and IPv6 tunnel detection, and clear it when a new XFRM receive path starts
and after the callback completes.

Guard the skb extension accesses with CONFIG_XFRM and provide no-op or
NULL-returning helpers when it is disabled, since xfrm.h is also included
by code built without XFRM support.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>

---
v1: https://lore.kernel.org/lkml/20261111094629.230568-1-yaojun8558363@gmail.com/T/#u

Changes in v2:
- Group the tunnel info helpers under CONFIG_XFRM and provide NULL-returning
  or no-op stubs when it is disabled, fixing the !CONFIG_XFRM build errors.
- Document the runtime reproduction and include a trimmed KASAN report.

Build failure reported by the kernel test robot:
https://lore.kernel.org/oe-kbuild-all/202611120519.EG3LbKfu-lkp@intel.com/

Build-tested bzImage and modules using x86_64_defconfig-based configurations
with CONFIG_WERROR=y and GCC 13.3.0:
- CONFIG_XFRM=y, including IPv4/IPv6 VTI and ESP offload, XFRM interface,
  and IP-TFS.
- CONFIG_XFRM=n and CONFIG_SKB_EXTENSIONS=n.
Both builds completed without errors or warnings.

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6787fcf6a..f97412b95 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5044,6 +5044,7 @@ enum skb_ext_id {
 #endif
 #ifdef CONFIG_XFRM
 	SKB_EXT_SEC_PATH,
+	SKB_EXT_XFRM_TUNNEL,
 #endif
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 	TC_SKB_EXT,
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 445223a8d..38815faca 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -382,6 +382,7 @@ struct xfrm_dst_lookup_params {
 };
 
 struct net_device;
+struct ip6_tnl;
 struct xfrm_type;
 struct xfrm_dst;
 struct xfrm_policy_afinfo {
@@ -740,14 +741,70 @@ struct xfrm_tunnel_skb_cb {
 		struct inet_skb_parm h4;
 		struct inet6_skb_parm h6;
 	} header;
+	/* Keep the layout of the other XFRM skb control blocks stable. */
+	unsigned long reserved;
+};
+
+enum xfrm_tunnel_info_type {
+	XFRM_TUNNEL_INFO_VTI4,
+	XFRM_TUNNEL_INFO_VTI6,
+	XFRM_TUNNEL_INFO_IP6,
+};
 
+/* Stored in an skb extension so it survives asynchronous XFRM input. */
+struct xfrm_tunnel_info {
+	int ifindex;
+	__be32 i_key;
+	u8 type;
 	union {
-		struct ip_tunnel *ip4;
-		struct ip6_tnl *ip6;
-	} tunnel;
+		struct {
+			int link;
+			__be32 saddr;
+			__be32 daddr;
+		} ip4;
+		struct {
+			int link;
+			u8 proto;
+			struct in6_addr laddr;
+			struct in6_addr raddr;
+		} ip6;
+	};
 };
 
-#define XFRM_TUNNEL_SKB_CB(__skb) ((struct xfrm_tunnel_skb_cb *)&((__skb)->cb[0]))
+#ifdef CONFIG_XFRM
+static inline struct xfrm_tunnel_info *
+xfrm_tunnel_info_add(struct sk_buff *skb)
+{
+	return skb_ext_add(skb, SKB_EXT_XFRM_TUNNEL);
+}
+
+static inline const struct xfrm_tunnel_info *
+xfrm_tunnel_info(const struct sk_buff *skb)
+{
+	return skb_ext_find(skb, SKB_EXT_XFRM_TUNNEL);
+}
+
+static inline void xfrm_tunnel_info_clear(struct sk_buff *skb)
+{
+	skb_ext_del(skb, SKB_EXT_XFRM_TUNNEL);
+}
+#else
+static inline struct xfrm_tunnel_info *
+xfrm_tunnel_info_add(struct sk_buff *skb)
+{
+	return NULL;
+}
+
+static inline const struct xfrm_tunnel_info *
+xfrm_tunnel_info(const struct sk_buff *skb)
+{
+	return NULL;
+}
+
+static inline void xfrm_tunnel_info_clear(struct sk_buff *skb)
+{
+}
+#endif /* CONFIG_XFRM */
 
 /*
  * This structure is used for the duration where packets are being
@@ -1851,7 +1908,7 @@ int xfrm4_rcv(struct sk_buff *skb);
 
 static inline int xfrm4_rcv_spi(struct sk_buff *skb, int nexthdr, __be32 spi)
 {
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+	xfrm_tunnel_info_clear(skb);
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
 	return xfrm_input(skb, nexthdr, spi, 0);
@@ -2300,15 +2357,17 @@ static inline int xfrm_if_id_put(struct sk_buff *skb, __u32 if_id)
 static inline int xfrm_tunnel_check(struct sk_buff *skb, struct xfrm_state *x,
 				    unsigned int family)
 {
+	const struct xfrm_tunnel_info *info = xfrm_tunnel_info(skb);
 	bool tunnel = false;
 
 	switch(family) {
 	case AF_INET:
-		if (XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4)
+		if (info && info->type == XFRM_TUNNEL_INFO_VTI4)
 			tunnel = true;
 		break;
 	case AF_INET6:
-		if (XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6)
+		if (info && (info->type == XFRM_TUNNEL_INFO_VTI6 ||
+			     info->type == XFRM_TUNNEL_INFO_IP6))
 			tunnel = true;
 		break;
 	}
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8da53d5b7..32f41370d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5241,6 +5241,7 @@ static const u8 skb_ext_type_len[] = {
 #endif
 #ifdef CONFIG_XFRM
 	[SKB_EXT_SEC_PATH] = SKB_EXT_CHUNKSIZEOF(struct sec_path),
+	[SKB_EXT_XFRM_TUNNEL] = SKB_EXT_CHUNKSIZEOF(struct xfrm_tunnel_info),
 #endif
 #if IS_ENABLED(CONFIG_NET_TC_SKB_EXT)
 	[TC_SKB_EXT] = SKB_EXT_CHUNKSIZEOF(struct tc_skb_ext),
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f..fa0a2a73b 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -81,7 +81,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 	if (NAPI_GRO_CB(skb)->proto == IPPROTO_UDP)
 		encap_type = UDP_ENCAP_ESPINUDP;
 
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+	xfrm_tunnel_info_clear(skb);
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
 	XFRM_SPI_SKB_CB(skb)->seq = seq;
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index c4f14d42d..3594254df 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -58,10 +58,25 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 	tunnel = ip_tunnel_lookup(itn, skb->dev->ifindex, flags,
 				  iph->saddr, iph->daddr, 0);
 	if (tunnel) {
+		struct xfrm_tunnel_info *info;
+
 		if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
 			goto drop;
 
-		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
+		info = xfrm_tunnel_info_add(skb);
+		if (!info)
+			goto drop;
+
+		*info = (struct xfrm_tunnel_info) {
+			.ifindex = tunnel->dev->ifindex,
+			.i_key = tunnel->parms.i_key,
+			.type = XFRM_TUNNEL_INFO_VTI4,
+			.ip4 = {
+				.link = tunnel->parms.link,
+				.saddr = tunnel->parms.iph.saddr,
+				.daddr = tunnel->parms.iph.daddr,
+			},
+		};
 
 		if (update_skb_dev)
 			skb->dev = tunnel->dev;
@@ -96,18 +111,28 @@ static int vti_rcv_proto(struct sk_buff *skb)
 
 static int vti_rcv_cb(struct sk_buff *skb, int err)
 {
+	const struct xfrm_tunnel_info *info = xfrm_tunnel_info(skb);
 	unsigned short family;
 	struct net_device *dev;
 	struct xfrm_state *x;
 	const struct xfrm_mode *inner_mode;
-	struct ip_tunnel *tunnel = XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4;
+	struct ip_tunnel *tunnel;
 	u32 orig_mark = skb->mark;
 	int ret;
 
-	if (!tunnel)
+	if (!info || info->type != XFRM_TUNNEL_INFO_VTI4)
 		return 1;
 
-	dev = tunnel->dev;
+	dev = dev_get_by_index_rcu(dev_net(skb->dev), info->ifindex);
+	if (!dev || dev->rtnl_link_ops != &vti_link_ops)
+		return err ? 1 : -ENODEV;
+
+	tunnel = netdev_priv(dev);
+	if (tunnel->parms.i_key != info->i_key ||
+	    tunnel->parms.link != info->ip4.link ||
+	    tunnel->parms.iph.saddr != info->ip4.saddr ||
+	    tunnel->parms.iph.daddr != info->ip4.daddr)
+		return err ? 1 : -ENODEV;
 
 	if (err) {
 		DEV_STATS_INC(dev, rx_errors);
@@ -131,7 +156,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 
 	family = inner_mode->family;
 
-	skb->mark = be32_to_cpu(tunnel->parms.i_key);
+	skb->mark = be32_to_cpu(info->i_key);
 	ret = xfrm_policy_check(NULL, XFRM_POLICY_IN, skb, family);
 	skb->mark = orig_mark;
 
diff --git a/net/ipv4/xfrm4_protocol.c b/net/ipv4/xfrm4_protocol.c
index 4ee624d8e..c31426ea8 100644
--- a/net/ipv4/xfrm4_protocol.c
+++ b/net/ipv4/xfrm4_protocol.c
@@ -65,7 +65,7 @@ int xfrm4_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
 	struct xfrm4_protocol *handler;
 	struct xfrm4_protocol __rcu **head = proto_handlers(nexthdr);
 
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+	xfrm_tunnel_info_clear(skb);
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
 
@@ -98,7 +98,7 @@ static int xfrm4_esp_rcv(struct sk_buff *skb)
 	int ret;
 	struct xfrm4_protocol *handler;
 
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+	xfrm_tunnel_info_clear(skb);
 
 	for_each_protocol_rcu(esp4_handlers, handler)
 		if ((ret = handler->handler(skb)) != -EINVAL)
@@ -126,7 +126,7 @@ static int xfrm4_ah_rcv(struct sk_buff *skb)
 	int ret;
 	struct xfrm4_protocol *handler;
 
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+	xfrm_tunnel_info_clear(skb);
 
 	for_each_protocol_rcu(ah4_handlers, handler)
 		if ((ret = handler->handler(skb)) != -EINVAL)
@@ -154,7 +154,7 @@ static int xfrm4_ipcomp_rcv(struct sk_buff *skb)
 	int ret;
 	struct xfrm4_protocol *handler;
 
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+	xfrm_tunnel_info_clear(skb);
 
 	for_each_protocol_rcu(ipcomp4_handlers, handler)
 		if ((ret = handler->handler(skb)) != -EINVAL)
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22895521a..00cdae2c7 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -110,7 +110,7 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 		goto out;
 
 	IP6CB(skb)->nhoff = nhoff;
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = NULL;
+	xfrm_tunnel_info_clear(skb);
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET6;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
 	XFRM_SPI_SKB_CB(skb)->seq = seq;
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index c79027839..6cf40b000 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -302,6 +302,8 @@ static int vti6_input_proto(struct sk_buff *skb, int nexthdr, __be32 spi,
 	rcu_read_lock();
 	t = vti6_tnl_lookup(dev_net(skb->dev), &ipv6h->saddr, &ipv6h->daddr);
 	if (t) {
+		struct xfrm_tunnel_info *info;
+
 		if (t->parms.proto != IPPROTO_IPV6 && t->parms.proto != 0) {
 			rcu_read_unlock();
 			goto discard;
@@ -319,9 +321,26 @@ static int vti6_input_proto(struct sk_buff *skb, int nexthdr, __be32 spi,
 			goto discard;
 		}
 
+		info = xfrm_tunnel_info_add(skb);
+		if (!info) {
+			rcu_read_unlock();
+			goto discard;
+		}
+
+		*info = (struct xfrm_tunnel_info) {
+			.ifindex = t->dev->ifindex,
+			.i_key = t->parms.i_key,
+			.type = XFRM_TUNNEL_INFO_VTI6,
+			.ip6 = {
+				.link = t->parms.link,
+				.proto = t->parms.proto,
+				.laddr = t->parms.laddr,
+				.raddr = t->parms.raddr,
+			},
+		};
+
 		rcu_read_unlock();
 
-		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
 		XFRM_SPI_SKB_CB(skb)->family = AF_INET6;
 		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
 		return xfrm_input(skb, nexthdr, spi, encap_type);
@@ -342,18 +361,29 @@ static int vti6_rcv(struct sk_buff *skb)
 
 static int vti6_rcv_cb(struct sk_buff *skb, int err)
 {
+	const struct xfrm_tunnel_info *info = xfrm_tunnel_info(skb);
 	unsigned short family;
 	struct net_device *dev;
 	struct xfrm_state *x;
 	const struct xfrm_mode *inner_mode;
-	struct ip6_tnl *t = XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6;
+	struct ip6_tnl *t;
 	u32 orig_mark = skb->mark;
 	int ret;
 
-	if (!t)
+	if (!info || info->type != XFRM_TUNNEL_INFO_VTI6)
 		return 1;
 
-	dev = t->dev;
+	dev = dev_get_by_index_rcu(dev_net(skb->dev), info->ifindex);
+	if (!dev || dev->rtnl_link_ops != &vti6_link_ops)
+		return err ? 1 : -ENODEV;
+
+	t = netdev_priv(dev);
+	if (t->parms.i_key != info->i_key ||
+	    t->parms.link != info->ip6.link ||
+	    t->parms.proto != info->ip6.proto ||
+	    !ipv6_addr_equal(&t->parms.laddr, &info->ip6.laddr) ||
+	    !ipv6_addr_equal(&t->parms.raddr, &info->ip6.raddr))
+		return err ? 1 : -ENODEV;
 
 	if (err) {
 		DEV_STATS_INC(dev, rx_errors);
@@ -377,7 +407,7 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
 
 	family = inner_mode->family;
 
-	skb->mark = be32_to_cpu(t->parms.i_key);
+	skb->mark = be32_to_cpu(info->i_key);
 	ret = xfrm_policy_check(NULL, XFRM_POLICY_IN, skb, family);
 	skb->mark = orig_mark;
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 07edef258..9aed0b21d 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -15,6 +15,7 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter_ipv6.h>
 #include <net/ipv6.h>
+#include <net/ip6_tunnel.h>
 #include <net/xfrm.h>
 #include <net/protocol.h>
 #include <net/gro.h>
@@ -22,7 +23,28 @@
 int xfrm6_rcv_spi(struct sk_buff *skb, int nexthdr, __be32 spi,
 		  struct ip6_tnl *t)
 {
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
+	struct xfrm_tunnel_info *info;
+
+	xfrm_tunnel_info_clear(skb);
+	if (t) {
+		info = xfrm_tunnel_info_add(skb);
+		if (!info) {
+			kfree_skb(skb);
+			return 0;
+		}
+
+		*info = (struct xfrm_tunnel_info) {
+			.ifindex = t->dev->ifindex,
+			.i_key = t->parms.i_key,
+			.type = XFRM_TUNNEL_INFO_IP6,
+			.ip6 = {
+				.link = t->parms.link,
+				.proto = t->parms.proto,
+				.laddr = t->parms.laddr,
+				.raddr = t->parms.raddr,
+			},
+		};
+	}
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET6;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
 	return xfrm_input(skb, nexthdr, spi, 0);
diff --git a/net/ipv6/xfrm6_protocol.c b/net/ipv6/xfrm6_protocol.c
index 9b586fcec..2e93029a3 100644
--- a/net/ipv6/xfrm6_protocol.c
+++ b/net/ipv6/xfrm6_protocol.c
@@ -66,7 +66,7 @@ int xfrm6_rcv_encap(struct sk_buff *skb, int nexthdr, __be32 spi,
 	struct xfrm6_protocol *handler;
 	struct xfrm6_protocol __rcu **head = proto_handlers(nexthdr);
 
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = NULL;
+	xfrm_tunnel_info_clear(skb);
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET6;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
 
@@ -113,7 +113,7 @@ static int xfrm6_esp_rcv(struct sk_buff *skb)
 	int ret;
 	struct xfrm6_protocol *handler;
 
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = NULL;
+	xfrm_tunnel_info_clear(skb);
 
 	for_each_protocol_rcu(esp6_handlers, handler)
 		if ((ret = handler->handler(skb)) != -EINVAL)
@@ -142,7 +142,7 @@ static int xfrm6_ah_rcv(struct sk_buff *skb)
 	int ret;
 	struct xfrm6_protocol *handler;
 
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = NULL;
+	xfrm_tunnel_info_clear(skb);
 
 	for_each_protocol_rcu(ah6_handlers, handler)
 		if ((ret = handler->handler(skb)) != -EINVAL)
@@ -171,7 +171,7 @@ static int xfrm6_ipcomp_rcv(struct sk_buff *skb)
 	int ret;
 	struct xfrm6_protocol *handler;
 
-	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = NULL;
+	xfrm_tunnel_info_clear(skb);
 
 	for_each_protocol_rcu(ipcomp6_handlers, handler)
 		if ((ret = handler->handler(skb)) != -EINVAL)
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 5ed87d513..a5d67d506 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -466,6 +466,7 @@ static int xfrm_inner_mode_input(struct xfrm_state *x,
 int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 {
 	const struct xfrm_state_afinfo *afinfo;
+	const struct xfrm_tunnel_info *tunnel_info;
 	struct net *net = dev_net(skb->dev);
 	struct net_device *dev = skb->dev;
 	int err;
@@ -555,16 +556,20 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	}
 
 	family = XFRM_SPI_SKB_CB(skb)->family;
+	tunnel_info = xfrm_tunnel_info(skb);
 
 	/* if tunnel is present override skb->mark value with tunnel i_key */
 	switch (family) {
 	case AF_INET:
-		if (XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4)
-			mark = be32_to_cpu(XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4->parms.i_key);
+		if (tunnel_info &&
+		    tunnel_info->type == XFRM_TUNNEL_INFO_VTI4)
+			mark = be32_to_cpu(tunnel_info->i_key);
 		break;
 	case AF_INET6:
-		if (XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6)
-			mark = be32_to_cpu(XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6->parms.i_key);
+		if (tunnel_info &&
+		    (tunnel_info->type == XFRM_TUNNEL_INFO_VTI6 ||
+		     tunnel_info->type == XFRM_TUNNEL_INFO_IP6))
+			mark = be32_to_cpu(tunnel_info->i_key);
 		break;
 	}
 
@@ -739,6 +744,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		goto drop;
 	}
 
+	xfrm_tunnel_info_clear(skb);
 	nf_reset_ct(skb);
 
 	if (decaps) {
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 9835fbe63..d91b5f22d 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -322,10 +322,10 @@ static int xfrmi_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 	XFRM_SPI_SKB_CB(skb)->family = family;
 	if (family == AF_INET) {
 		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
-		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+		xfrm_tunnel_info_clear(skb);
 	} else {
 		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
-		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = NULL;
+		xfrm_tunnel_info_clear(skb);
 	}
 
 	return xfrm_input(skb, nexthdr, spi, encap_type);

