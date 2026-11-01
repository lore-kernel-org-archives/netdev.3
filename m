Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793551569;
	b=M5gTit7HFfDlfB9kYNdzR8fIBKLh6T36/fmvdhqbh0qrfib/VEF87BKUN/fu6h7fDxtg
	 6K0pw0wtNNzhRqyBHPfFiEmarP368qs3YdDsBdrybZFQjmY+8AecniofA8oisipwu87WA
	 gFYl3IMrHtZFDdZc/Ruk5ZHD6Os6pBWCYkirSpRKfYKB7mbEFlwPj5+W2liRCpGnALppm
	 IaGnByOuLuzf2fXzVe2uPfF7RvVtkDbfPHDfV9bs3qwDplajaMaTt9SZ/OTXSRmsbyDaG
	 2JctfeJCB3fSzy/0zwhCN9Lsmpx8IfahEc0uXtyoGkRvg4uYqUpHHCmYe69kC9vCS8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793551569;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+oQ34f5bfGCIX3EZ4dcfnfajN4eERVEpuI+XV+v7Upw=;
	b=LMNwSi4k7sx+I54KK+g7z+kyD3fPgjdVjpGMgeTUlF8PaPc+UMlpOTLZVOjfIkb5vhCp
	 YstdCOfB3i81PYHK21S/UgkVxbCPwlnrh1HDhevffrUrOAEaoi3gaL79lEXThj1JvPj3b
	 lvUSALG+OQKqvVP8l3Igtq8mZg4FzNU5rA0dPGw9P7C5IDntO6uodazLC6TwpQ3ZZaul+
	 FbzENVMxT1G74LpGDCQ33jAEpJvjmuzjkX28ZrtZwPdj+Dq7uMn9/IH3+JavuiSddrQeG
	 1ExNXY/Pd45pkKwspVXzJ25Eteh2jw5HACiIWVuCw2iZzt6RTrJPsqW7tgEdJabaJkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=d70jUQTe;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB09F606A331
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 16:46:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB09F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=d70jUQTe
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4c9abc1824so345299966b.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 08:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1793551567; x=1794156367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+oQ34f5bfGCIX3EZ4dcfnfajN4eERVEpuI+XV+v7Upw=;
        b=d70jUQTeL7mzMRLLb/xamwAQygtZtojouXyl5mm5fveXBA1pRi+rgZwZ3LjFUH9/JS
         JGOx22rYuo27IEwYkZQYUHck74wzZKN6/qkKVjjFFG0l7+LLgriHHXrcD1TPdou2x2ao
         SVEglZH/Uls5lvBhS+QbJINdvK8+njuRG8of+D2Ogfo2SUbii6rFkdh9Fxe1bCT3w1vT
         27q2QC0ggVIaR/0wNsnxnRd4Vis2F/UXEuXn38ov6jXb7ONc0hY59GqyLT4kyMBWkFws
         5qtt+rXaZ/WldoJ8kgb09GuOYky/GjR5ooEN/vRCxxR1715FKAIAx9Ge9d/BTtjVfv8K
         EZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793551567; x=1794156367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+oQ34f5bfGCIX3EZ4dcfnfajN4eERVEpuI+XV+v7Upw=;
        b=xhbGoPem3p380IwFPWklniE5b+oy8oE5OL/9ahGnWAj0i/xwXZcE+XwQ+TL3zzesCC
         aJWKQPPvcI9gDbIUfAaNZJx3PF2KpcN0gOdxornVBoEHR4yQalUdus/EkkEnSbPXfK47
         w+egzPFaOgOmlKCW7rvxWUK+0COKNa0brqeWTEmKYiZmB1stP1Ey0ejlEQTqRzaZh3jk
         TFjCTMeoJCDHxHKEYdi0TItS3rG/jDaCbES4tXdBttwyhubKELxMo8/6thTc2LfSUdV3
         uNYZaV71VXw/3ryQKE2wHoYSm8ES+oq8vhakQpDflsc0s2Fdp0IZLOMRm7m+h+OLjCvo
         3Nhg==
X-Gm-Message-State: AFq9FYKY8T0pyUf+PUrCyev+AembanVyqEMlwvxk5JsDWuAjsfouC8IA
	arrWlPyRawkk2xP1w5d0rHwJuwF3cwS3C5vQ6YYOMeK+Wpk2HnQxygnYtfJu6hmmCLcMbIUyq2m
	7jeqfAldw
X-Gm-Gg: AYBFou1b3gtMNlsyCnfJoKBITYwM1K7ZMZXm0gO68Gcg/dzYovK/4vMlIRJ8cceOWRk
	WEQwopk+cD/fFCKbZ+XuEPoL6QBoaFxdAse2nF6c+9bLrIP9A+tLKP5qKVTQDg0bkV4oe/oh3us
	IYhGXGwg+LRZ5SvEZgDYGEankr56xTErpENi7nhzEGlwzGU1rwCEZbAAlC5MnXJBf88gjY2L8PN
	TrDVYc66LZrkh2tq1/GZEDS9FLnh1Lr1RK15z9cqShP87SbNy7nx9wdq1gMaAKZE+iLtVfRHo2l
	f9VToBDID06CaNcprUAX1Kz7Z6j7+vwIi5ctlMsp/zzbXybL6sbISJat/MttY4IpkbVwa+bFhOj
	k29cMHzWeoowpYT3oHtfN5VuCNfaRIMbDinoWF8f/DVHlIRo0C2uF6VtQ1s1SloLLDnQ//qdtal
	IZhTM03/r6QxxeyYsRDE+pJpGqZr6yCcHZS5G+GBTIqDwHG/3kikrB1Kh4LndGCJVVN8WJxQKAA
	fiTtSuJOaIlBsN2pDhqBTTPRwb3AlhU1MCkOOFdUG7e+YnY5jApB9pwwfTTwcj1S1fjXsikbEZ/
	qD/sz0lCWwu3/lRPjq41sx8ySwWHw0Ydxc4FRVQYohspFf31Lbm3xXFAzkiGIfr3U72fHIMsFtV
	IhqiQmwnjOUxLMr0PyaQGP+iZ8qyxTd/xoqJTzD7SXzLQVHRgUzOGfTMH+Nj8E0y77VqRBLF5n/
	T7JP7hzXoqxlChueFqwjMkDMDFnec0Opu3bh3OdnN3l/NnBiaUTKuTE2TxRQZExxi118uK9dqpE
	jKjZaax6eh+hgDMT+nACS9NFG4lGip7gJve6lYzFgeYpMZZnkKYDmiTz3sPyt1AeZUt+477EdgV
	0tix8whYq4syh5z1jRg=
X-Received: by 2002:a17:906:dc8a:b0:c3f:d8f2:f08e with SMTP id a640c23a62f3a-c4ca7adb74dmr630927466b.44.1793551567024;
        Sun, 01 Nov 2026 08:46:07 -0800 (PST)
Received: from Desktop (p54aff790.dip0.t-ipconnect.de. [84.175.247.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabcfd254sm296928266b.29.2026.11.01.08.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 08:46:06 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	richardbgobert@gmail.com,
	willemb@google.com,
	ecree.xilinx@gmail.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	shuah@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: keep the TCP fixed-ID flags on the header they describe
Date: Sun,  1 Nov 2026 17:46:03 +0100
Message-ID: <f689def2f03965d7e4c48455c3926d7475044910.1792857378.git.julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1792857378.git.julius@bairaktaris.de>
References: <cover.1792857378.git.julius@bairaktaris.de>
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

GRO sets SKB_GSO_TCP_FIXEDID for the outer IPv4 header of a TCP packet
and SKB_GSO_TCP_FIXEDID_INNER for the inner header of an encapsulated
one, and segmentation reads them the same way. Three paths do not keep
the flags on the header they describe:

- Encapsulation: iptunnel_handle_offloads(), bpf_skb_net_grow() and
  bpf_lwt_push_ip_encap() make the IPv4 header of a GSO packet the
  inner one but leave SKB_GSO_TCP_FIXEDID. A TCP stream that GRO merged
  with fixed IDs and that is forwarded into a tunnel gets one outer ID
  for all segments, also with DF clear, and incrementing inner IDs.
- Decapsulation: iptunnel_pull_offloads(), bpf_skb_net_shrink() and
  the segment routing decapsulation in ipv6_srh_rcv() and
  ipv6_rpl_srh_rcv() leave both flags, so the new outer header is
  segmented with the state of the removed one: inner IDs that
  incremented come out fixed when the outer IDs were fixed, and the
  reverse.
- Segmentation below GRE and UDP tunnels: inet_gso_segment() tells the
  inner header from the outer one by SKB_GSO_CB(skb)->encap_level,
  which gre_gso_segment() and __skb_udp_tunnel_segment() reset before
  they segment the inner packet. The inner IPv4 header of a GRE, VXLAN,
  GENEVE, FOU, GUE or bareudp packet is segmented with the outer flag.

Add skb_gso_fixedid_encap() and skb_gso_fixedid_decap(), which move the
flag to the inner or the outer bit, and call them where a GSO packet
becomes encapsulated or loses its outer header. The segment routing
paths use iptunnel_pull_offloads() for this, which also clears the
tunnel GSO types of the removed header. Keep encap_level below GRE and
UDP tunnels, as ipip_gso_segment() and the IPv6 tunnel handlers do; the
inner pass then also masks the features with hw_enc_features, which the
tunnel handlers have done already, and resets the inner headers of each
segment.

The three changes go together: with any one of them alone, fixed IDs
are lost in a case that works today, such as a packet encapsulated and
decapsulated again without segmentation, or one forwarded into an IPv6
GRE tunnel.

Fixes: 3271f19bf7b9 ("net: gso: restore ids of outer ip headers correctly")
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 include/linux/skbuff.h    | 30 ++++++++++++++++++++++++++++++
 include/net/ip_tunnels.h  |  2 ++
 net/core/filter.c         | 11 ++++++++---
 net/core/lwt_bpf.c        |  1 +
 net/ipv4/gre_offload.c    |  1 -
 net/ipv4/ip_tunnel_core.c |  5 ++++-
 net/ipv4/udp_offload.c    |  1 -
 net/ipv6/exthdrs.c        | 11 +++++++++--
 8 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 6787fcf6ac3e4..00df57cbc05c2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -5337,6 +5337,36 @@ static inline void skb_decrease_gso_size(struct skb_shared_info *shinfo,
 	shinfo->gso_size -= decrement;
 }
 
+/**
+ * skb_gso_fixedid_encap - move the TCP fixed-ID flag to the inner header
+ * @shinfo: shared info of a GSO packet that becomes encapsulated
+ *
+ * The IPv4 header that SKB_GSO_TCP_FIXEDID describes becomes the inner one,
+ * and the new outer header gets an incrementing ID.
+ */
+static inline void skb_gso_fixedid_encap(struct skb_shared_info *shinfo)
+{
+	unsigned int fixedid = shinfo->gso_type & SKB_GSO_TCP_FIXEDID;
+
+	shinfo->gso_type &= ~(SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER);
+	shinfo->gso_type |= fixedid << 1;
+}
+
+/**
+ * skb_gso_fixedid_decap - move the TCP fixed-ID flag to the new outer header
+ * @shinfo: shared info of an encapsulated GSO packet losing its outer header
+ *
+ * The inner IPv4 header, which SKB_GSO_TCP_FIXEDID_INNER describes, becomes
+ * the outer one, and the state of the removed outer header is dropped.
+ */
+static inline void skb_gso_fixedid_decap(struct skb_shared_info *shinfo)
+{
+	unsigned int fixedid = shinfo->gso_type & SKB_GSO_TCP_FIXEDID_INNER;
+
+	shinfo->gso_type &= ~(SKB_GSO_TCP_FIXEDID | SKB_GSO_TCP_FIXEDID_INNER);
+	shinfo->gso_type |= fixedid >> 1;
+}
+
 void __skb_warn_lro_forwarding(const struct sk_buff *skb);
 
 static __always_inline bool skb_warn_if_lro(const struct sk_buff *skb)
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 5cccf4c0e6913..c2ffda6029a06 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -665,6 +665,8 @@ static inline int iptunnel_pull_offloads(struct sk_buff *skb)
 		err = skb_unclone(skb, GFP_ATOMIC);
 		if (unlikely(err))
 			return err;
+		if (skb->encapsulation)
+			skb_gso_fixedid_decap(skb_shinfo(skb));
 		skb_shinfo(skb)->gso_type &= ~(NETIF_F_GSO_ENCAP_ALL >>
 					       NETIF_F_GSO_SHIFT);
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2e..70f41e7597bf3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3691,6 +3691,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
+		if (encap)
+			skb_gso_fixedid_encap(shinfo);
+
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= gso_type;
 		shinfo->gso_segs = 0;
@@ -3782,9 +3785,11 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
 						  SKB_GSO_GRE_CSUM |
 						  SKB_GSO_IPXIP4 |
 						  SKB_GSO_IPXIP6 |
-						  SKB_GSO_ESP)))
-				if (skb->encapsulation)
-					skb->encapsulation = 0;
+						  SKB_GSO_ESP)) &&
+			    skb->encapsulation) {
+				skb_gso_fixedid_decap(shinfo);
+				skb->encapsulation = 0;
+			}
 		}
 
 		/* Header must be checked, and gso_segs recomputed. */
diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
index da49364ec63de..4d9faf2cc5de5 100644
--- a/net/core/lwt_bpf.c
+++ b/net/core/lwt_bpf.c
@@ -539,6 +539,7 @@ static int handle_gso_type(struct sk_buff *skb, unsigned int gso_type,
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 
+	skb_gso_fixedid_encap(shinfo);
 	gso_type |= SKB_GSO_DODGY;
 	shinfo->gso_type |= gso_type;
 	skb_decrease_gso_size(shinfo, encap_len);
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index c8129782d39de..a8f9a0a0b06bd 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -35,7 +35,6 @@ static struct sk_buff *gre_gso_segment(struct sk_buff *skb,
 
 	/* setup inner skb. */
 	skb->encapsulation = 0;
-	SKB_GSO_CB(skb)->encap_level = 0;
 	__skb_pull(skb, tnl_hlen);
 	skb_reset_mac_header(skb);
 	skb_set_network_header(skb, skb_inner_network_offset(skb));
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index 6c2855adff289..59050229e3499 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -182,9 +182,10 @@ EXPORT_SYMBOL_GPL(iptunnel_metadata_reply);
 int iptunnel_handle_offloads(struct sk_buff *skb,
 			     int gso_type_mask)
 {
+	bool encap = !skb->encapsulation;
 	int err;
 
-	if (likely(!skb->encapsulation)) {
+	if (likely(encap)) {
 		skb_reset_inner_headers(skb);
 		skb->encapsulation = 1;
 	}
@@ -193,6 +194,8 @@ int iptunnel_handle_offloads(struct sk_buff *skb,
 		err = skb_header_unclone(skb, GFP_ATOMIC);
 		if (unlikely(err))
 			return err;
+		if (encap)
+			skb_gso_fixedid_encap(skb_shinfo(skb));
 		skb_shinfo(skb)->gso_type |= gso_type_mask;
 		return 0;
 	}
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a2..edcabe1115a60 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -205,7 +205,6 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 
 	/* setup inner skb. */
 	skb->encapsulation = 0;
-	SKB_GSO_CB(skb)->encap_level = 0;
 	__skb_pull(skb, tnl_hlen);
 	skb_reset_mac_header(skb);
 	skb_set_network_header(skb, skb_inner_network_offset(skb));
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 96c8402a27a54..126058772bc5a 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -53,6 +53,7 @@
 #include <linux/ioam6_genl.h>
 #include <net/ioam6.h>
 #include <net/dst_metadata.h>
+#include <net/ip_tunnels.h>
 
 #include <linux/uaccess.h>
 
@@ -406,7 +407,10 @@ static int ipv6_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 
 			skb_reset_network_header(skb);
 			skb_reset_transport_header(skb);
-			skb->encapsulation = 0;
+			if (iptunnel_pull_offloads(skb)) {
+				kfree_skb(skb);
+				return -1;
+			}
 			if (hdr->nexthdr == NEXTHDR_IPV4)
 				skb->protocol = htons(ETH_P_IP);
 			__skb_tunnel_rx(skb, skb->dev, net);
@@ -513,7 +517,10 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb, struct inet6_dev *idev)
 
 			skb_reset_network_header(skb);
 			skb_reset_transport_header(skb);
-			skb->encapsulation = 0;
+			if (iptunnel_pull_offloads(skb)) {
+				kfree_skb(skb);
+				return -1;
+			}
 
 			__skb_tunnel_rx(skb, skb->dev, net);
 
-- 
2.53.0

