Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021439;
	b=lP6pgPfVfXm7w8EWay+Ax4TC1+u4RD0hFPjT+ts8UC5y+IoXdAljBQonsRnKciU4EM2P
	 FuilKUGusPa20CfterZWEHCg6FNylHRDKQUcyQRpci2Flu/WVOI7xy/DrqGx7FbYC/Erv
	 hdFOqexQxYqz+OZ8VbMonxI5CsKd2NAhgcKX7KscRt06Z1MyxDOSA5ZWbFHj/iLwblEgt
	 Ad34KbhEqN+NsKd2RlmxtCccbBGbcyUEqmT1JTrTgP140tbyMqFkcEE00QFeJLwVbLpQM
	 5glz9R/m/tAUtMpKCR8MzYFDCVkG3h7K0h7UJBYaunlHlnlvzLkd4XzNQgmbr6XBDbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:
	 In-Reply-To:References:From:Date:Subject;
	bh=5V973eV5z9bFCFEhgPYSvRAKHWeecR/OoECRUm/vrjI=;
	b=g5wReHToXid2QZH+UaNWs3oOK4P70Hu3Mc1v5dFHjiwqU2s5kqGqbm/KHmG4kDS1jCfY
	 TRj6CqHX6qgVS6LdCe+dynBZ2lN21I1DEFycF5niySNa4AufFXbDJSCsGBHp8WvwHfTVW
	 kXRgXb3pUjsTrN7KwoN2WvlmjOA1fE7t18qihTn4l/dQpzwjtoW0osGBMc1VY37FzEMHo
	 7oyWYgo+LehjsWfL+NOzryTpbYegwo//cUe6gudLviM/b8iIZVmKYmfi0A4GoG8odiDyl
	 40s/Ej8PZrHbOf5IMZlA6G0lhE61MQhbOkANCGj9gdyrmJq6GKWQYx8aYsnUw8Zs6uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mtf0B2Lr;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4C606A32D
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0D4C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mtf0B2Lr
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a6ee9c59aso172660eec.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794021438; x=1794626238; darn=vger.kernel.org;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5V973eV5z9bFCFEhgPYSvRAKHWeecR/OoECRUm/vrjI=;
        b=mtf0B2Lr5l7FsjDOdaERaAxmGRyqLte1g4IWhLbZHM+ub48pKGPjjqUGdZd+IRHrMD
         meJZuBiTQeW55zIf8ZeLOzfb05/Np7cAH55b+PnuXKk4EtVoyjXKdBTVi3wYCBJY4XE5
         81Qo8qPVVsSdfUXFBoTn2rnLwIhrdXYaHbYBIuN3GnsHkPoWVSJXz/+L3uqWHBbwHnAU
         czIgLwzP9Anr4267FbtfN5OLlT5Hcu5dAXgXZddin+r5ivbJ3wgyHtcjBkrG8t0jz45W
         RxG5zQYjomPh/tmMwtlxVGEPlJDFPT+M2slOybjXuKi/LcK0FIj23U0i89TaifaUmrjO
         gizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794021438; x=1794626238;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5V973eV5z9bFCFEhgPYSvRAKHWeecR/OoECRUm/vrjI=;
        b=IB5M/Mk7uuAoSHhXae0beAjaeNSdr8dWau6cgvCLDOXh7gJ8ad3QikYjmn+p1I2sVm
         lRAh3DEA9Hpg2sLg3ZIcpd6nZNec6bDEPWpZonGhoRR4pwviyG3X7bmxJTdQmOWkzpjG
         bp8yePq464gbXQI0+1cWKi9WVVFDO4tJUK85wgTCjmyn/LK3iXf5PWU0NJKz4eZi9xqS
         jgaKxm1RMg4nBJzu4SUj0rJUuu5k8ag3xBWS7cMA6kjsslZq8RaTcBm1cR37xiLdC+Jo
         Lzdf2EWms4s96SJBcXHqXfTxQCYV99A8ovv9r7/ImrhzyZyEPvMHb7AoRzVxpzWTQkzG
         w/0g==
X-Gm-Message-State: APuU4Z+Ksuf63ViyL2P75JcjYXeJB2ZH9a2dfvAofnZbRonj6bFwmwab
	/UtN/9C4eWa40GM/Enm7DYpjDbIssiaoEcKgPbAbs5z8zlpm4/L4dapJ
X-Gm-Gg: AYBFou1b0zslgyOM/zDOQNu3I/sVwP+0M+dsGh8Otj0XtOfCijf0WgHQLCEecVrgDgb
	wttRKAN4KgIZ1lP/aQX0iN47s5lXaI+ypnrNiWJkmOUMZBJNieoeLa19zNCpNRtzDkL1VGP7hAX
	cKrEM7SPHLO1/6LvmLgwp70PlAr/mlb/qEQOM/0LAy3U+JAnf2Xszf8ASz80W5Tp0/5fNJAcXf5
	HdY4oFOpAX1bg/uUmWw4J5Dh1XId2HECaCf0Fu6rf/MuQdvgVj10qhEdRji/+WqkhvGbo1BkxyV
	t0Upbw89ZA0t87iNWTEI2sRrbUfvUkAjMxus/rqQaBwbcOjrq3+dByuVOappIiseKgFxI3VYdC4
	vphS5YjsUVHCpOKkdvT3NUub7RvXc7BzBDQ6H2Ud8BIDdZh0HqHj9aKwif220772umnMGX3fe+d
	XmQxFnSZh1IH5P1jzq/41XNnFZHR/y8iIITvsFC76YVPbAKgS02Pm7Gt3nMp5YtPCuM3yrP2jIA
	IjOSka4X9WsNGi8oUVbz5+aCMBJ1CiMxoQi/xlsjznrrCgAYXiP45EXCnZ9CpyLaaDKV+PTh79U
	cZId7oANEIlvPJ+rcmeL8fn5r1msyNO7Kgk8Lf9E8PYPik0vfXTKTNlLCLPxYYKMEdYVC6o=
X-Received: by 2002:a05:693c:8858:b0:35f:ea17:d171 with SMTP id 5a478bee46e88-36f7524bf37mr9088545eec.2.1794021437662;
        Fri, 06 Nov 2026 19:17:17 -0800 (PST)
Received: from msg ([188.253.120.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa922b205sm10973889eec.11.2026.11.06.19.17.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:17:17 -0800 (PST)
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Message-ID: <20261107111617.21347-4-q.h.hack.winter@gmail.com>
In-Reply-To: <20261107111617.21347-1-q.h.hack.winter@gmail.com>
References: <20261107111617.21347-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Sat, 31 Oct 2026 10:09:48 +0800
Subject: [PATCH net v8 3/3] xfrm: hold the tunnel device reference across the
 input path
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

vti_input() and vti6_input_proto() cache the tunnel pointer in the skb
control buffer without taking a reference.  With async crypto the
receive callback runs from the crypto completion, after a possible
device teardown, and dereferences the freed tunnel device:

    BUG: KASAN: slab-use-after-free in vti_rcv_cb

Take a reference on the tunnel device when the pointer is cached.  The
tunnel is the device's private area, so the reference keeps the tunnel
structure alive as well.  xfrm6_rcv_spi() takes the same reference for
the tunnel it is given; it is a separate entry point, so vti6 does not
hold the reference twice.

A successful vti/vti6 callback leaves the cached tunnel in place for
xfrm_input() to release after delivery.  A callback that fails only
updates the error counters; the common drop path releases the reference
after the skb has been freed.  The helper takes the device out of the
skb before gro_cells_receive() and transport_finish(), which may already
consume the skb, so the device reference is always dropped after the skb
is gone.  The early drop for a state that is no longer valid releases
the reference too, and needs the address family for that, so set the
family before the validity check.

The reference is released right after gro_cells_receive().  The NAPI
that processes the queued skb later still reads skb->dev without a
reference.  That window is pre-existing on the synchronous path as well
and is not changed here.

IPTFS consumes the outer skb itself and frees it directly, so it must
release the reference as well.  The IPTFS state carries the address
family the tunnel was resolved for, and the caller passes it in.  Add
xfrm_input_drop() and xfrm_input_consume() for the outer-skb free paths
in __input_process_payload(), iptfs_input_ordered(), iptfs_input(),
iptfs_drop_timer() and iptfs_destroy_state().  Only the outer skb
carries the cached tunnel; the inner skbs built by iptfs_alloc_skb()
have a zeroed control buffer, so they do not release it.  The drop paths
keep their skb drop reason and the consumed skb keeps consume_skb()
semantics.

Fixes: df3893c176e9 ("vti: Update the ipv4 side to use it's own receive hook.")
Fixes: fa9ad96d4905 ("vti6: Update the ipv6 side to use its own receive hook.")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/ipv4/ip_vti.c      |  3 ++
 net/ipv6/ip6_vti.c     |  2 ++
 net/ipv6/xfrm6_input.c |  3 ++
 net/xfrm/xfrm_inout.h  |  4 +++
 net/xfrm/xfrm_input.c  | 64 ++++++++++++++++++++++++++++++++++++++++--
 net/xfrm/xfrm_iptfs.c  | 31 +++++++++++---------
 6 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index c4f14d42d..e7b836aba 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -63,6 +63,9 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 
 		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
 
+		/* Keep the tunnel alive until xfrm_input() is done with the skb. */
+		dev_hold(tunnel->dev);
+
 		if (update_skb_dev)
 			skb->dev = tunnel->dev;
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index c79027839..c3666dc53 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -319,6 +319,8 @@ static int vti6_input_proto(struct sk_buff *skb, int nexthdr, __be32 spi,
 			goto discard;
 		}
 
+		/* Keep the tunnel alive until xfrm_input() is done with the skb. */
+		dev_hold(t->dev);
 		rcu_read_unlock();
 
 		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 07edef258..d27bc24f1 100644
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
@@ -23,6 +24,8 @@ int xfrm6_rcv_spi(struct sk_buff *skb, int nexthdr, __be32 spi,
 		  struct ip6_tnl *t)
 {
 	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
+	if (t)
+		dev_hold(t->dev);
 	XFRM_SPI_SKB_CB(skb)->family = AF_INET6;
 	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
 	return xfrm_input(skb, nexthdr, spi, 0);
diff --git a/net/xfrm/xfrm_inout.h b/net/xfrm/xfrm_inout.h
index efc5e6b2e..8bd05f62a 100644
--- a/net/xfrm/xfrm_inout.h
+++ b/net/xfrm/xfrm_inout.h
@@ -6,6 +6,10 @@
 #ifndef XFRM_INOUT_H
 #define XFRM_INOUT_H 1
 
+void xfrm_input_drop(struct sk_buff *skb, unsigned int family,
+		     enum skb_drop_reason reason);
+void xfrm_input_consume(struct sk_buff *skb, unsigned int family);
+
 static inline void xfrm4_extract_header(struct sk_buff *skb)
 {
 	const struct iphdr *iph = ip_hdr(skb);
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index cfd5cea03..e3b6c486f 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -120,6 +120,56 @@ static int xfrm_rcv_cb(struct sk_buff *skb, unsigned int family, u8 protocol,
 	return ret;
 }
 
+/*
+ * The cached tunnel holds one reference on its net_device.
+ * The address family determines the tunnel type.
+ */
+static struct net_device *xfrm_input_take_tunnel_dev(struct sk_buff *skb,
+						     unsigned int family)
+{
+	void *slot = (void *)XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4;
+	struct net_device *dev;
+
+	if (!slot)
+		return NULL;
+
+	switch (family) {
+	case AF_INET:
+		dev = ((struct ip_tunnel *)slot)->dev;
+		break;
+	case AF_INET6:
+		dev = ((struct ip6_tnl *)slot)->dev;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+
+	XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+	return dev;
+}
+
+void xfrm_input_drop(struct sk_buff *skb, unsigned int family,
+		     enum skb_drop_reason reason)
+{
+	struct net_device *dev = xfrm_input_take_tunnel_dev(skb, family);
+
+	kfree_skb_reason(skb, reason);
+	if (dev)
+		dev_put(dev);
+}
+EXPORT_SYMBOL(xfrm_input_drop);
+
+void xfrm_input_consume(struct sk_buff *skb, unsigned int family)
+{
+	struct net_device *dev = xfrm_input_take_tunnel_dev(skb, family);
+
+	consume_skb(skb);
+	if (dev)
+		dev_put(dev);
+}
+EXPORT_SYMBOL(xfrm_input_consume);
+
 struct sec_path *secpath_set(struct sk_buff *skb)
 {
 	struct sec_path *sp, *tmp = skb_ext_find(skb, SKB_EXT_SEC_PATH);
@@ -468,6 +518,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	const struct xfrm_state_afinfo *afinfo;
 	struct net *net = dev_net(skb->dev);
 	struct net_device *dev = skb->dev;
+	struct net_device *tdev;
 	int err;
 	__be32 seq;
 	__be32 seq_hi;
@@ -747,8 +798,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			sp->olen = 0;
 		if (skb_valid_dst(skb))
 			skb_dst_drop(skb);
-		/* gro_cells_receive() reads skb->dev. */
+		/* gro_cells_receive() may free the skb. */
+		tdev = xfrm_input_take_tunnel_dev(skb, family);
 		gro_cells_receive(&gro_cells, skb);
+		if (tdev)
+			dev_put(tdev);
 		if (async)
 			dev_put(dev);
 		rcu_read_unlock();
@@ -758,6 +812,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		if (xo)
 			xfrm_gro = xo->flags & XFRM_GRO;
 
+		tdev = xfrm_input_take_tunnel_dev(skb, family);
 		err = -EAFNOSUPPORT;
 		afinfo = xfrm_state_afinfo_get_rcu(family);
 		if (likely(afinfo))
@@ -771,6 +826,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			gro_cells_receive(&gro_cells, skb);
 		}
 
+		if (tdev)
+			dev_put(tdev);
 		if (async)
 			dev_put(dev);
 		rcu_read_unlock();
@@ -781,9 +838,12 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	spin_unlock(&x->lock);
 drop:
 	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
+	tdev = xfrm_input_take_tunnel_dev(skb, family);
+	kfree_skb(skb);
+	if (tdev)
+		dev_put(tdev);
 	if (async)
 		dev_put(dev);
-	kfree_skb(skb);
 	return 0;
 }
 EXPORT_SYMBOL(xfrm_input);
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 5ea3e77dd..363962308 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -717,8 +717,9 @@ static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
 			      IPTFS_HRTIMER_MODE);
 	}
 
-	if (free)
-		kfree_skb(xtfs->ra_newskb);
+	if (free && xtfs->ra_newskb)
+		xfrm_input_drop(xtfs->ra_newskb, xtfs->x->props.family,
+				SKB_DROP_REASON_NOT_SPECIFIED);
 	xtfs->ra_newskb = NULL;
 }
 
@@ -1213,14 +1214,11 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 	skb_abort_seq_read(skbseq);
 
 	if (defer) {
-		consume_skb(defer);
+		xfrm_input_consume(defer, x->props.family);
 	} else if (!first_skb) {
-		/* skb is the original passed in skb, but we didn't get far
-		 * enough to process it as the first_skb, if we had it would
-		 * either be save in ra_newskb, trimmed and sent on as an skb or
-		 * placed in defer to be freed.
-		 */
-		kfree_skb(skb);
+		/* The original skb was not consumed as the first inner packet. */
+		xfrm_input_drop(skb, x->props.family,
+				SKB_DROP_REASON_NOT_SPECIFIED);
 	}
 	return true;
 }
@@ -1307,7 +1305,8 @@ static void iptfs_input_ordered(struct xfrm_state *x, struct sk_buff *skb)
 	if (!consumed) {
 		skb = skbseq.root_skb;
 		skb_abort_seq_read(&skbseq);
-		kfree_skb(skb);
+		xfrm_input_drop(skb, x->props.family,
+				SKB_DROP_REASON_NOT_SPECIFIED);
 	}
 }
 
@@ -1709,7 +1708,8 @@ static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
 	spin_unlock(&xtfs->drop_lock);
 
 	if (skb)
-		kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
+		xfrm_input_drop(skb, x->props.family,
+				SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
 
 	if (count) {
 		list_for_each_entry_safe(skb, next, &list, list) {
@@ -1760,7 +1760,8 @@ static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
 
 	list_for_each_entry_safe(skb, next, &freelist, list) {
 		skb_list_del_init(skb);
-		kfree_skb(skb);
+		xfrm_input_drop(skb, x->props.family,
+				SKB_DROP_REASON_NOT_SPECIFIED);
 	}
 done:
 	/* We always have dealt with the input SKB, either we are re-using it,
@@ -2761,11 +2762,13 @@ static void iptfs_destroy_state(struct xfrm_state *x)
 	hrtimer_cancel(&xtfs->drop_timer);
 
 	if (xtfs->ra_newskb)
-		kfree_skb(xtfs->ra_newskb);
+		xfrm_input_drop(xtfs->ra_newskb, xtfs->x->props.family,
+				SKB_DROP_REASON_NOT_SPECIFIED);
 
 	for (s = xtfs->w_saved, se = s + xtfs->w_savedlen; s < se; s++) {
 		if (s->skb)
-			kfree_skb(s->skb);
+			xfrm_input_drop(s->skb, x->props.family,
+					SKB_DROP_REASON_NOT_SPECIFIED);
 	}
 
 	kfree_sensitive(xtfs->w_saved);
-- 
2.54.0 (Apple Git-157)


