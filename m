Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516062;
	b=l3ogrOPMr878LihvzfIYZvVkT/qQfPN9K6p+2kESeSc2BGj8UECYdmdZCg7uTosre+D+
	 VtUV5eySYFDn2Oz+aODxNvOALg4diPAnp7ZMrIIBzuoRwV/365fqQIRGrcwCLmPPVFfrC
	 LpKeTJWIC27+HN13cocMKhlWxF8qQBT8tXEfIdzzNywO9g5ue+CpMf5rzc1PX6i6BwjNz
	 4C2zAfnLYIZTxpOCmXqOnG7SOj0I461dT4oBI3Rd5zJHOFLX0ImSCXbq0SY7Qbfbhr5Un
	 s6AXietebeW6h5RWdv+IEfGfzOoxERLckGdY+yrdMB+2GURARcuNHaRcjqggi/46sCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Byn2HhOPb19dBjcx3Tbrg9Im7VPacdPGrEuEzofnAl8=;
	b=rHxgFDE6WzUa+XMk6gWj4Fne68DJxo24hm8fLsj8K2GPSvE477KUIt+wfZ+FezUAFDW6
	 kJ7Ms/WIvoNkRW8VwQHohhcZLqAb2gqFCQKEZC593Tp9m2Nq9nO+A05hNXv9A0B6tzcay
	 yvPHvhuIfP+M4TcB03DlTEmCRCafz8X55c+isrgP3cEol5Js+yMYhPLT0eWaJ3KluFvBg
	 XNt1LflXqzxGapJX3WHMlmUxcT2sa3FafKE4Di92iyxS9+CZjsm+L2OFkfnJOrl/AyOsO
	 ONDqhjdL1nW501ftZUNnSCyHu1EDOKl5GGFKHVKwOgIVnV1KeVX54Gr9hhPojdLYZIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=yHrt5zki;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF3E606A899
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CF3E606A899
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=yHrt5zki
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-53512cd2f85so2396061cf.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794516061; x=1795120861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Byn2HhOPb19dBjcx3Tbrg9Im7VPacdPGrEuEzofnAl8=;
        b=yHrt5zkiYxyh/0WxMr6yVueyeQv5MaHKHfPsU+myfUx6yZPMSV8Fu8W4BCVojnXbEc
         BiAwRt8JqQEJNG0dqY+n8VMyQOYvY4hv+YZDpW1H4Sq/Bawe4wtnfUgd5v4krZ+tA5tR
         eqkzOw+dTmpCr55DFj9+ZJHZDI7HgkIyeymR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516061; x=1795120861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Byn2HhOPb19dBjcx3Tbrg9Im7VPacdPGrEuEzofnAl8=;
        b=J0WU3yaKC604jWEAzbGOM03hqyVjeN8cpSHgNekFwfMlikthjhNu6szfdiHN2eJree
         gS1ULxQYefW8m4vVRarwN24WyCZ6BEDWgkn0gdY2uVHwj/kyJ8Ewp6WTzRBTEsA/QriQ
         HH/18vTeI6ElaRETzS1uuXuVGBcv40uvM8jcahYQ+h3kdwKr6BXbZUBaE5wxMMnit4TA
         6tfhxbaSJYSlSUNC1T82XPfZXEPe7nrmZTosgcm6zHGanlS/ymAexEhvra8WDo3V/Syj
         Fo0/3QOFQObFopJf0nLGtXxiVAI72SrCx7ebDurUHACN8JKy93HUgbaOChQQjpRq7o0i
         bjyw==
X-Gm-Message-State: APuU4Z9MtCiAEkIl5SLokCLaZwYyKe8RD1lJiNPbs30DrT0F3rlT7gCm
	SOIXjJXY7TrcD7bkdjgRUjoIjSJX0Jp0+94VdDTW9Ts67sWA774IdcLFIaeibSH7n0Ws/xgvqB1
	70UQ=
X-Gm-Gg: AYBFou0s/AXuPXkcnH74Z3v8lP+jJgoEDQFSm4DscE6j82GM9ZRe6y5VkjRJzm00z+W
	9Gg31tX80HGgo1Oz1DHpde3i1XSki6j16maXDS5xG8wssxKQSTXM85wc4DGJem5wQKEIqns40JM
	1aTWyNuMeYGiYM3Py0uCUX8xtdg9vIUvsUbaW64TRFQodQ+jFFBSd4MDAcIiP2Bk+LczpSjufzE
	r2NAGdi3FP8JHkKWAhQcBSwoKH361q/0FELPLrglzrVcVuamazE67F/GYRcoU1llg6PXBGj8ifb
	F9vXG+ZU+lppfKZm3jZGeifJ188RPChcdehIFWHaFwwnd6Lo73ZivuWSARFkT2nI+vtyAT2R8l4
	Ws5YGKza2wBQbJXLoI9XuijWay0v6MbJW0Xqif+YR9o5giwYc3CI3Yoj26LtaZMDdlvD4gaKWxm
	y6nbQBXDX0AbWzT2xRUC3yRW4ert48mUAxZylj3vS/XzxzTbuXZ8IFDIDbHHvtXI51iXiXdR7Hu
	l7rLmcS8oBwCdjf5hxVaIv62Jwb4o9AJ2+LGmB3/Qh+vv86l364TADUoe2uIqbm2hFpUUqpkPL1
	VPMJ0O4RwaQr/BucIUnh782gH5EadFHrBPjk1D5ORbIzktroVTQIl3yhtGy/TFJ3/e0GKCLHmmk
	=
X-Received: by 2002:a05:622a:1214:b0:535:1b50:48a6 with SMTP id d75a77b69052e-55ac366a4e1mr10884361cf.6.1794516061226;
        Thu, 12 Nov 2026 12:41:01 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d61888sm4452116d6.20.2026.11.12.12.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:41:00 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net-next v2 2/4] net: dst: keep the LWT metadata of a dropped route
Date: Thu, 12 Nov 2026 15:40:47 -0500
Message-Id: <CORE-9NOG.v2.r0.20261112151659-2@mojatatu.com>
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

Found while working on the two producers that steer a packet to another
device's neighbour, fixed later in this series. Both release the route
dst on the way, and a route installed with an encapsulation carries the
parameters a device downstream needs: an ip or ip6 encapsulation holds an
ip_tunnel_info, where skb_tunnel_info() reads it, and an xfrm encapsulation
holds an xfrm_md_info, where skb_xfrm_md_info() reads it. The release
discards them, so a tunnel or an xfrm interface downstream has nothing left
to build the outer header with, or to select its if_id.

The Fix:
Add skb_dst_drop_keep_metadata(), which moves those parameters onto a
metadata dst of its own before the route is released. The ip and ip6
payload is copied field by field; the route's dst cache belongs to its
lwtstate and is shared by every packet that uses the route, so it is not
duplicated: the copy starts with an empty cache, which costs the tunnel one
route lookup. The xfrm payload keeps the route itself, because the xfrm
lookup reads its family; the counted reference the skb already holds moves
into the metadata dst, which releases it once it has been consumed.

The helper owns the whole operation: a dst that is not a route is not
dropped, because a metadata dst is the encapsulation itself. Its callers
must not transmit with the stale route, so a failed copy is reported and
the skb is left untouched for its owner to drop.

Conditions to recreate the bug:
Install a route with an encapsulation (ip route add ... encap ip id <id>
dst <remote>, or encap xfrm if_id <id>), steer a packet to another
device's neighbour with a netdev egress fwd rule or
bpf_redirect_neigh(), and release the route dst before neigh_xmit() hands
the packet on. A tunnel or xfrm device in the path then finds no
parameters in skb_tunnel_info() or skb_xfrm_md_info() and drops the packet
instead of using them.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/dst_metadata.h |  1 +
 net/core/dst.c             | 72 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index f45d1e3163f0..32d74b4f009f 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -136,6 +136,7 @@ struct metadata_dst *metadata_dst_alloc(u8 optslen, enum metadata_type type,
 void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst);
 struct metadata_dst __percpu *
 metadata_dst_alloc_percpu(u8 optslen, enum metadata_type type, gfp_t flags);
+bool skb_dst_drop_keep_metadata(struct sk_buff *skb);
 
 static inline struct metadata_dst *tun_rx_dst(int md_size)
 {
diff --git a/net/core/dst.c b/net/core/dst.c
index 092861133023..daa003979d59 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -353,3 +353,75 @@ void metadata_dst_free_percpu(struct metadata_dst __percpu *md_dst)
 	free_percpu(md_dst);
 }
 EXPORT_SYMBOL_GPL(metadata_dst_free_percpu);
+
+/**
+ * skb_dst_drop_keep_metadata - release a route dst, keeping its LWT metadata
+ * @skb: buffer whose dst is to be released
+ *
+ * A route installed with an encapsulation carries the parameters a downstream
+ * device needs in dst->lwtstate, where skb_tunnel_info() and skb_xfrm_md_info()
+ * find them. Releasing such a route would discard them, so move them onto a
+ * metadata dst of their own first. The route is not duplicated: the copy
+ * starts with an empty cache, and for xfrm the route is kept because the
+ * lookup needs its family.
+ *
+ * A dst that is metadata is left in place. False means no copy could be
+ * allocated and the caller must drop the skb.
+ */
+bool skb_dst_drop_keep_metadata(struct sk_buff *skb)
+{
+	struct dst_entry *old = skb_dst(skb);
+	struct metadata_dst *md_dst = NULL;
+
+	if (!skb_valid_dst(skb))
+		return true;
+
+	if (old->lwtstate && old->lwtstate->type == LWTUNNEL_ENCAP_XFRM) {
+		struct xfrm_md_info *src = lwt_xfrm_info(old->lwtstate);
+
+		md_dst = metadata_dst_alloc(0, METADATA_XFRM, GFP_ATOMIC);
+		if (!md_dst)
+			return false;
+
+		/* Count the route so it outlives the skb, then move the
+		 * reference into the metadata dst.
+		 */
+		if (!skb_dst_force(skb)) {
+			metadata_dst_free(md_dst);
+			return false;
+		}
+
+		md_dst->u.xfrm_info.if_id = src->if_id;
+		md_dst->u.xfrm_info.link = src->link;
+		md_dst->u.xfrm_info.dst_orig = old;
+		skb_dstref_steal(skb);
+		skb_dst_set(skb, &md_dst->dst);
+		return true;
+	}
+
+	if (old->lwtstate &&
+	    (old->lwtstate->type == LWTUNNEL_ENCAP_IP ||
+	     old->lwtstate->type == LWTUNNEL_ENCAP_IP6)) {
+		struct ip_tunnel_info *src = lwt_tun_info(old->lwtstate);
+		struct ip_tunnel_info *dst;
+
+		md_dst = metadata_dst_alloc(src->options_len,
+					    METADATA_IP_TUNNEL, GFP_ATOMIC);
+		if (!md_dst)
+			return false;
+
+		dst = &md_dst->u.tun_info;
+		dst->key = src->key;
+		dst->encap = src->encap;
+		dst->options_len = src->options_len;
+		dst->mode = src->mode;
+		memcpy(ip_tunnel_info_opts(dst), ip_tunnel_info_opts(src),
+		       src->options_len);
+	}
+
+	skb_dst_drop(skb);
+	if (md_dst)
+		skb_dst_set(skb, &md_dst->dst);
+	return true;
+}
+EXPORT_SYMBOL_GPL(skb_dst_drop_keep_metadata);
-- 
2.43.0

