Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516060;
	b=tJcLKm46Y/heXI9flYUBvFM8MYlX8Ut4EJYvGX4wzLpmF5DmwllHav/NMJlnKadgJox5
	 yr+r2vcPaFg0ANJAvqI0FUTpJKSE6FDGXvJHq8z77eiVQGDOruvq1cDJm7CjuEE4HoFyO
	 fOBlw59FiE4XxklmOt5K4bgZvd+Ktz3x9p7r4shErxlbqSfaMR/5UWMQq24nQY6DKZhWT
	 5PxFn7vT9+rEcFOpWwv0AvkGpF2EBeiqaiA/1gTruoJRYakHc72RjcPIO442TTZJEuDxO
	 oHZHRDZH/ukBnziQG1I31p7s0RypcdZbu/RzR+JSdau/hbUaQgGZuPLHzapOeV/skzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zBfHPQm249Nk34H3ial9k2D14gkrSdWuZNXZZV0acP0=;
	b=O3AmRFXSfOjqLphkXxBamDOCGn8GY8/fjF+3abJqMipOsUkasNjQ/FMKjPwBScvxEtta
	 2jK4j/+q9aMQpIGOrdDmu5F2I/3C3gV/zXrTEnKboPGBIBh3pnclggk3iliGi5/FU9ug9
	 MXbyRqVIEakYA0JWwhQSPwzUGhERk8/vFY0dXCtXeltT9cjYyBYcb/kaU4yT1QnBGdnXf
	 18v7xw5BF9GHMrHjA4VDTlnWDwt1FsdW1guiVW74KvH/Bpg2q48BQ+YYU95RU0MLwKVwQ
	 kGy3P2yTXkr36d0deHLRXWLv61dy43n4O5+IvLFXqCJpSIah/IXGhanFUsyYwz0h7hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=HTDbjPzs;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5A606A887
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74E5A606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=HTDbjPzs
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91c847584b8so3754496d6.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794516059; x=1795120859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBfHPQm249Nk34H3ial9k2D14gkrSdWuZNXZZV0acP0=;
        b=HTDbjPzsR0O+SejXj3jVWZJAnIZg6UHQQTswJ38B6V30qlUr+RYGJQgBm3MqeWMhv7
         tJX0LYXplPWUSPUC65HFJfqomMyVFEFD0gByY5TYfLdUyYvQ3QIBNMBJ2gWwQri80LDZ
         4v8iXYbeC0RRJ/WrRdbK/d8cc75t23J+3dr7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516059; x=1795120859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zBfHPQm249Nk34H3ial9k2D14gkrSdWuZNXZZV0acP0=;
        b=vjjk1QJsubnUIztX7nTNKNg9hcfuMYyT4soXixLVcb8GCj9ggkMOd7/nYtMBUSRFje
         Y2EWQPq+hyacWrLjpad2/ra9hjnGX3yUS2FJq1rXuEX+HbbWrEzHWZ9/xVBSTdRUyrgb
         EhAhz3LmN4FDHDdbo4uUKqV1w6Vlqn8a5pN2Jfr9vJAHIidO8TqeatzJnUj10N6V5HeB
         hA6xmD2NyZiwNmYF+bCTQgKYQ6wgqawll8SHWqGlg2fDAC8bKBJqzJQigGsGKu1fDoNf
         JAHgqELcRoRW3mKj2R8Xp0/koVga6xEbbk98Os3FWBIb/qEudv/7sxwHvjf3eXsujicd
         pdJg==
X-Gm-Message-State: APuU4Z9XE3a58WNwlNoHCJCqowujwVqSwCbO4VMAIa8kNJkb+lrpKg4J
	NhOgJFLpFw3KygCPCxm8TW3Xs5OzYWazRhBZUGYk9Oc6QMLis4a+9l0ekogYqsfefeH3B9x3DJR
	FCsU=
X-Gm-Gg: AYBFou0fVphiggfCpsF1grImuaVrnBcSrgFi/exgiuufi5grEw9u20B1iwUQBvLaLzE
	YNd5fmoW2Dcr4NI4QncH1yy9NftWqKFX/DftouDLhGqjebjW2T8VPnn2pvrk7py0HczJJ1kqmJ5
	eRcU0Rcs4DROcQg3SbWdozmYdIgkfjN7DV6NVWKIPBX6UXZOOWuMdSC2rrKtADypX80sVSJd2Vx
	9IlT9Usz0JX4wZuPvpeTinWUBT7G/C70pG5WUw7yi5P9+7W+pY7RqvkDZjUoYRRBQZKrut4yTZh
	caJQxYv7d6ASvoLZ4mRtrM3ccfoy0jvB9KVuiB7pmg9dfFCBvqO9RjEBf3o1n4Ec5upD3ANHkMq
	9czoMF/gus+mlIfUfp3KT8D/tf60GL0NU4PavezrfI2mbCOrZqfgovsTZ/PovLDizqw8qJBboxp
	G40xqD1PFqr9CoZrUg4wq+K+0nADXEblOqOT/WcBYgyPJFhM+rbB6RkxNKvKMuuj+WR6sEesMMp
	sQvH38GyuAZKT3ga+bj0AL4eYfFV9F6rSiVnOy8anQGIcUQUe0Vd4ibwSP0g5MRJc4hJng/aWKu
	zO8SvAypUgb83hccR6Z7c5JDGg/B514Ab3aIrrk9kZgfA1+elPa7HslKxtG37jo4JwyYBuxedLI
	=
X-Received: by 2002:a05:6214:2f93:b0:91e:b7fd:8ce7 with SMTP id 6a1803df08f44-91f2425d524mr7292946d6.28.1794516059296;
        Thu, 12 Nov 2026 12:40:59 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d61888sm4452116d6.20.2026.11.12.12.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:40:58 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net-next v2 1/4] net: xfrm: interface: restore dst_orig on every xfrm interface
Date: Thu, 12 Nov 2026 15:40:46 -0500
Message-Id: <CORE-9NOG.v2.r0.20261112151659-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
References: <CORE-9NOG.v2.r0.20261112151659@mojatatu.com>
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

Found while testing the dst release for the two producers that steer a
packet to another device, fixed later in this series. One of the consumers
of the metadata such a release installs is an xfrm interface, which
restores the original route before the xfrm lookup; the swap warned on the
metadata dst still installed in the skb, and only the collect_md arm
restored the route at all.

The issue:
An xfrm interface takes the if_id and the underlying device either from its
configuration or, in collect_md mode, from the xfrm metadata on the skb.
When that metadata also carries the route the packet arrived through,
xfrmi_xmit2() puts the route back on the skb, because the xfrm lookup takes
the address family from it. skb_dst_set() expects the dst slot to be empty
for a reference counted dst and warns when it is not, so the route landed
over a metadata dst that was still there; a kernel built with
CONFIG_DEBUG_NET=y panics on the first packet that takes this path when
panic_on_warn is set.

Two more defects sit in the same place. An interface with a configured
if_id never restores the route: it takes the metadata dst as it is, whose
address family is AF_UNSPEC, so the lookup finds no policy and the packet
is dropped as a link failure instead of being transformed. And the restore
moved the route out of the metadata dst, which a clone of the skb shares,
so the clone that reached the interface first left the original packet with
nothing to restore.

The same slot overwrite is in the unstable helper a tc-bpf program uses to
attach that metadata: bpf_skb_set_xfrm_info() records the route as dst_orig
and installs a per-cpu metadata dst over it. The per-cpu dst is shared by
every invocation of the program, so the restore cannot keep anything in it.

The Fix:
Restore dst_orig in both arms of xfrmi_xmit2(), taking a reference with
dst_clone() so the metadata dst keeps its own, and empty the counted slot
with skb_dst_drop() before the route is installed. The helper allocates a
metadata dst per skb instead of a per-cpu one, so the route it records
belongs to that skb and is released with it; the per-cpu allocation is no
longer used and goes away.

Conditions to recreate the bug:
A tc-bpf program that records the route as dst_orig with
bpf_skb_set_xfrm_info() and redirects the packet to an xfrm interface is
the shortest way to hit the overwrite. A netdev egress fwd rule that steers
a packet routed with an xfrm encapsulation into an interface reaches the
same place once the dst release earlier in this series keeps the route:

    ip link add xf0 type xfrm if_id 42
    ip link set xf0 up
    ip neigh replace 10.20.0.1 lladdr 02:aa:00:00:00:ab \
            dev va nud permanent
    ip route add 10.20.0.1/32 dev va encap xfrm if_id 42
    nft add rule netdev t c fwd ip to 10.1.0.2 device xf0

Send one packet to 10.20.0.1. With CONFIG_DEBUG_NET=y and panic_on_warn=1
the kernel panics in xfrmi_xmit() with the metadata dst still installed
while the route is put back. The interface with the configured if_id drops
the packet as a link failure without consulting the outbound policy, and a
clone made after the metadata was attached consumes the route before the
original packet arrives.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/xfrm.h             |  2 --
 net/core/filter.c              |  8 --------
 net/xfrm/xfrm_interface_bpf.c  | 16 +++++-----------
 net/xfrm/xfrm_interface_core.c | 22 ++++++++++++----------
 4 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 445223a8dc6f..1866e5a3b911 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2370,8 +2370,6 @@ static inline bool xfrm6_local_dontfrag(const struct sock *sk)
 #if (IS_BUILTIN(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
     (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
 
-extern struct metadata_dst __percpu *xfrm_bpf_md_dst;
-
 int register_xfrm_interface_bpf(void);
 
 #else
diff --git a/net/core/filter.c b/net/core/filter.c
index 9b8d5191c4ba..2d574ae52c4b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6353,14 +6353,6 @@ static const struct bpf_func_proto bpf_bind_proto = {
 
 #ifdef CONFIG_XFRM
 
-#if (IS_BUILTIN(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
-    (IS_MODULE(CONFIG_XFRM_INTERFACE) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
-
-struct metadata_dst __percpu *xfrm_bpf_md_dst;
-EXPORT_SYMBOL_GPL(xfrm_bpf_md_dst);
-
-#endif
-
 BPF_CALL_5(bpf_skb_get_xfrm_state, struct sk_buff *, skb, u32, index,
 	   struct bpf_xfrm_state *, to, u32, size, u64, flags)
 {
diff --git a/net/xfrm/xfrm_interface_bpf.c b/net/xfrm/xfrm_interface_bpf.c
index 5ea15037ebd1..8e83c624b774 100644
--- a/net/xfrm/xfrm_interface_bpf.c
+++ b/net/xfrm/xfrm_interface_bpf.c
@@ -68,16 +68,9 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
 	if (unlikely(skb_metadata_dst(skb)))
 		return -EINVAL;
 
-	if (!xfrm_bpf_md_dst) {
-		struct metadata_dst __percpu *tmp;
-
-		tmp = metadata_dst_alloc_percpu(0, METADATA_XFRM, GFP_ATOMIC);
-		if (!tmp)
-			return -ENOMEM;
-		if (cmpxchg(&xfrm_bpf_md_dst, NULL, tmp))
-			metadata_dst_free_percpu(tmp);
-	}
-	md_dst = this_cpu_ptr(xfrm_bpf_md_dst);
+	md_dst = metadata_dst_alloc(0, METADATA_XFRM, GFP_ATOMIC);
+	if (unlikely(!md_dst))
+		return -ENOMEM;
 
 	info = &md_dst->u.xfrm_info;
 
@@ -86,7 +79,8 @@ __bpf_kfunc int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx, const struct bp
 	skb_dst_force(skb);
 	info->dst_orig = skb_dst(skb);
 
-	dst_hold((struct dst_entry *)md_dst);
+	/* The allocated dst owns one reference, handed to the skb here. */
+	skb_dstref_steal(skb);
 	skb_dst_set(skb, (struct dst_entry *)md_dst);
 	return 0;
 }
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 9835fbe63ccb..896180f8d171 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -423,6 +423,7 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 static int
 xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 {
+	struct xfrm_md_info *md_info = skb_xfrm_md_info(skb);
 	struct xfrm_if *xi = netdev_priv(dev);
 	struct dst_entry *dst = skb_dst(skb);
 	unsigned int length = skb->len;
@@ -433,25 +434,26 @@ xfrmi_xmit2(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 	int mtu;
 
 	if (xi->p.collect_md) {
-		struct xfrm_md_info *md_info = skb_xfrm_md_info(skb);
-
 		if (unlikely(!md_info))
 			return -EINVAL;
 
 		if_id = md_info->if_id;
 		fl->flowi_oif = md_info->link;
-		if (md_info->dst_orig) {
-			struct dst_entry *tmp_dst = dst;
-
-			dst = md_info->dst_orig;
-			skb_dst_set(skb, dst);
-			md_info->dst_orig = NULL;
-			dst_release(tmp_dst);
-		}
 	} else {
 		if_id = xi->p.if_id;
 	}
 
+	/* The metadata dst carries the route the packet is still to be
+	 * transformed for, and the lookup below takes the address family from
+	 * the dst it is given. Put that route back, taking our own reference:
+	 * the metadata dst keeps its own, as a clone of this skb shares it.
+	 */
+	if (md_info && md_info->dst_orig) {
+		dst = dst_clone(md_info->dst_orig);
+		skb_dst_drop(skb);
+		skb_dst_set(skb, dst);
+	}
+
 	dst_hold(dst);
 	dst = xfrm_lookup_with_ifid(xi->net, dst, fl, NULL, 0, if_id);
 	if (IS_ERR(dst)) {
-- 
2.43.0

