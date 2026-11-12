Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443698;
	b=nSy1s5w/4nxIeK2PdTIpXsnbGlvOcsZiDj/cfaBfTcJk0BpIEhwmkyrijyh6WkIq/+2j
	 NjPCaD5HBMAawbIiUVRLJV5hEgVJbfh+LnVOdNTZpIdadn+GPiYCUlTi+7elB/Xo2bBY7
	 nKZECMLc3em7EFGzrs7grDxYg1zkQQETo7n3x6NqlCIfo6moZEtcbpqaUVdl4245Pxmqk
	 cNF7ylc2dm/GgP0Zjfya4WUMIwZdvI7j4j3DmQ4so0U9qwCDPpanWHvIoRT80Y1EKXZUj
	 aUImFZDSXWPjmD+EXdcqXbIMviu1/Fwf1g69X7xvCROhKh8wB+8LmWUiUwPg0aJCiVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443698;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=0TpPReWodjm7eLrKXuRP3FItXhIb0Yxnna4BA9L21XQ=;
	b=pnntMxRzakD8hGfeo37nIT6sK5dyyQhc0M8q55HBNznVyAcp3J5kkeaORZ0GvhE/rp/d
	 KLZo7G5YWZOjZi28twg6VdDxdDX69jsytkxh2eOzzJjBzP446y7ZtSHI2eXalBi+wWmgN
	 UBs3291fjVzmQDFWFvKXRiWZrROJ3IhUbwpBTV5dX8o/Gm6eGWF04bp5ZDuyMp/f8lwVj
	 jvLkKJDChRxojb8NoyQzKpK2KbMELs6hW9yNMx1gj1eVylUv8pjtg54D6jkQlv5PXBoE0
	 lJ7BsETpqUmSda36t7JSWYiDsm8gnRfAJY/xffFhGRegO1ZsfSRKcVRQi0+YOeLleAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXbHONMv;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BD9606A326
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 00:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49BD9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXbHONMv
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so2014553b3a.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443696; x=1795048496; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0TpPReWodjm7eLrKXuRP3FItXhIb0Yxnna4BA9L21XQ=;
        b=zXbHONMvA9iS5oKI/8P7GqCMXrhjREZZx14wcGA8rf9Mch/7lSFkxaEjO3GxZeyZIw
         24WvAn6kXZVb1NcSClO/IDfosMcKzdYFAc3hLUoQR1powz5DKMf3QiUafcatBitB2zJw
         Bc+CYtebd9zUVcvxUXQDD/YkjF238Eo3QrcEc02PZ1Ma2Z5J2stbJqh56src8e+Gl7xw
         buIUH1ujUUUdO2K9f8LBA52vdsE/momSK7Q8aVO8wPlrgOTNAdGxmI4g0U4cU6MNWh+y
         PJ2WybWEc0jMmP88kCXQx9GZresqFEYO3YLnrw2meHBGRJs6sH5CiIuIchAlGHIb7ewP
         jhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443697; x=1795048497;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0TpPReWodjm7eLrKXuRP3FItXhIb0Yxnna4BA9L21XQ=;
        b=G5ln/5IdOrflUZ1NLK0TewR9FPCYP0g74kz59ICRy6SGddtimxCB+iCPZ/R9axy1q7
         JqCtSk96PI0YBzSNkguQ0xo19jlIH1kYwcILt0TSUC87Z4XjUR8cCJw9e5C1HzMi3wNa
         c11Yb+Zzguwv8WRDdsvNd+u5FYdkvlpXaqjyXR5KWJfzgq9gHSAk3BPS+BhOeZBt5Br3
         km7h2wjdR89VYQAETmTJe/L/HEZuJhkwBs3wR+dtxcN3H2J5EbbqlhvQuNtntbEs13e+
         dLDUO1fA6MGBoSU873LJqN5s7eNQCesGoP5VBeY5CSsnY+J2XgkO3ttCAj6qGr7a59mw
         E4Bg==
X-Forwarded-Encrypted: i=1; AL+hErE9OysWZd8DEfK/gHff0izguJcWz3udTryzk2mlDgi/mlfM6ZnXgTPwEnISRYF1JfgFCPPTFaA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bI1yPUiqt1QxYU6Nu98jtGxLx92tk7tWM0WQ2+K/xkM64u9r9
	V1pNrWz17V4SB1ty0VBgDYWEsNW/v2r54Px5soE4xQpf7Iw0rm30+b8C
X-Gm-Gg: AYBFou0o5DVXtHOxfxhwRXY4y09d5DORnr67NqQ5fyoyLx5PYr8yh8KLF9DrvVd5GW4
	F7BiiGIUhQl9JCqu1jlPonSuXdU0Q4Epaqg/dc4wDvj1wd/WBvsVnNaQ16PhHFxvuiJVqzg8VFV
	oT+cByTS82E0muF96X268FNFnuUVx0yVxAjpgxsjzgUrdqduApBZSQWeocKfUcJj6y9QOqfPlo7
	Z0bFVFRxLQVZO8DWMjPxN5IdkCcL7sZd9A43e6vH0eKM05iHi8QhrKSAHT/B07LWRZN9WOySUdE
	kYZopmGMPNTvzVa2GiNdVhJalPNlOETyKs1e4WVE001vTlgl3Y1huBXq6GNOGECAwMUnVhuLjFT
	uB3JvdHENt9MGXLl//+P1UeFfjGGSsv70dkix4ckP3CfEVG4iM30kEiCllmMS7C93A+ArhIWSxZ
	zYJDd22OU80w+dxcgftl9ZO80R+0APGEK5SzoQeXEFOwTv+ohnvmGpC+y7/e8ugH1BemySi7H/d
	gFQ0Bp+rPTb9GVT+JiMkY1aQdckXmiyIKnzACQwUEV7OL+DdXDQh8BXKfzkFrcSE8WkK7QRv2I/
	AVVyFt3No9o3XebTETctVi+O8VJg789VIXTwAhLTTWZ9Co/I1df2jBFGl5A3ueckKHROf3vrWKK
	uMMkWkXQbxr+7LGBsG8wD3FrRtnCyHI7Vjg==
X-Received: by 2002:a05:6a20:2451:b0:3e2:1a24:fb7e with SMTP id adf61e73a8af0-3f2fda8c6b2mr4281249637.40.1794443696335;
        Wed, 11 Nov 2026 16:34:56 -0800 (PST)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e52esm2026298a12.10.2026.11.11.16.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 16:34:55 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 00:34:54 +0000
Message-Id: <DMST78XBB2RK.2BKP3O07GEWZQ@gmail.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "Lorenzo Bianconi" <lorenzo@kernel.org>, "Vladimir
 Vdovin" <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Donald Hunter" <donald.hunter@gmail.com>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Tony Nguyen"
 <anthony.l.nguyen@intel.com>, "Przemek Kitszel"
 <przemyslaw.kitszel@intel.com>, "Maciej Fijalkowski"
 <maciej.fijalkowski@intel.com>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Magnus Karlsson"
 <magnus.karlsson@intel.com>, "Tushar Vyavahare"
 <tushar.vyavahare@intel.com>, "Jason Xing" <kerneljasonxing@gmail.com>,
 "Nikolay Aleksandrov" <razor@blackwall.org>, "Madalin Bucur"
 <madalin.bucur@nxp.com>, "Ioana Ciornei" <ioana.ciornei@nxp.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Shuah
 Khan" <shuah@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Nick Desaulniers"
 <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>, "Justin
 Stitt" <justinstitt@google.com>, "Chris J Arges" <carges@cloudflare.com>,
 "Jakub Sitnicki" <jakub@cloudflare.com>, <linux-doc@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
 <llvm@lists.linux.dev>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Tianyi Gao" <tianyi@cloudflare.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>
In-Reply-To: <cover.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, Nov 09, 2026 at 07:56 PM Tianyi Gao <tianyi@cloudflare.com> wrote:
> The layout of the area follows skb extensions (struct skb_ext). A small
> header gives the offset of each entry. An entry takes headroom only when
> the program stores it, so the area does not grow with each new type of
> RX metadata, unlike [4]. Unlike skb_ext, the area needs no allocation.

I'm with Stan on this. It looks heavy.

How about the following idea:

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231ad..7f30d24 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -81,8 +81,15 @@ enum xdp_buff_flags {
 	 * XDP program is not attached.
 	 */
 	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
+	/* The prog stored these members of struct xdp_rx_meta */
+	XDP_FLAGS_RX_HASH		= BIT(3),
+	XDP_FLAGS_RX_VLAN		= BIT(4),
+	XDP_FLAGS_RX_CSUM		= BIT(5),
 };

+#define XDP_FLAGS_RX_META \
+	(XDP_FLAGS_RX_HASH | XDP_FLAGS_RX_VLAN | XDP_FLAGS_RX_CSUM)
+
 struct xdp_buff {
 	void *data;
 	void *data_end;
@@ -174,6 +181,7 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
 	xdp->data = data;
 	xdp->data_end = data + data_len;
 	xdp->data_meta = meta_valid ? data : data + 1;
+	xdp->flags &= ~XDP_FLAGS_RX_META;
 }

 /* Reserve memory area at end-of data area.
@@ -310,6 +318,48 @@ struct xdp_frame {
 	u32 flags; /* supported values defined in xdp_buff_flags */
 };

+/*
+ * RX metadata that an XDP prog stores for the skb that is built later.
+ * It follows the xdp_frame in the headroom. The headroom is taken only
+ * when one of XDP_FLAGS_RX_META is set.
+ */
+struct xdp_rx_meta {
+	u32 hash;
+	__be16 vlan_proto;
+	u16 vlan_tci;
+	u8 hash_type;	/* enum pkt_hash_types */
+	u8 ip_summed;
+	u8 csum_level;
+};
+
+static __always_inline struct xdp_rx_meta *xdp_rx_meta(void *data_hard_start)
+{
+	return data_hard_start + sizeof(struct xdp_frame);
+}
+
+/* The lowest address that the packet and data_meta can use */
+static __always_inline void *xdp_buff_headroom_start(const struct xdp_buff *xdp)
+{
+	struct xdp_rx_meta *meta = xdp_rx_meta(xdp->data_hard_start);
+
+	return xdp->flags & XDP_FLAGS_RX_META ? meta + 1 : meta;
+}
+
+void __xdp_rx_meta_to_skb(struct sk_buff *skb, const struct xdp_rx_meta *meta,
+			  u32 flags);
+
+/*
+ * A driver calls it on XDP_PASS after it sets the skb fields from
+ * the RX descriptor.
+ */
+static inline void xdp_buff_rx_meta_to_skb(const struct xdp_buff *xdp,
+					   struct sk_buff *skb)
+{
+	if (unlikely(xdp->flags & XDP_FLAGS_RX_META))
+		__xdp_rx_meta_to_skb(skb, xdp_rx_meta(xdp->data_hard_start),
+				     xdp->flags);
+}
+
 static __always_inline bool xdp_frame_has_frags(const struct xdp_frame *frame)
 {
 	return !!(frame->flags & XDP_FLAGS_HAS_FRAGS);
@@ -648,6 +698,12 @@ enum xdp_rss_hash_type {
 	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
 };

+enum xdp_checksum {
+	XDP_CHECKSUM_NONE		= BIT(CHECKSUM_NONE),
+	XDP_CHECKSUM_UNNECESSARY	= BIT(CHECKSUM_UNNECESSARY),
+	XDP_CHECKSUM_COMPLETE		= BIT(CHECKSUM_COMPLETE),
+};
+
 struct xdp_metadata_ops {
 	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
 	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index d6c9dc6..f255818 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -223,7 +223,8 @@ static bool ctx_was_changed(struct xdp_page_head *head)
 {
 	return head->orig_ctx.data != head->ctx.data ||
 		head->orig_ctx.data_meta != head->ctx.data_meta ||
-		head->orig_ctx.data_end != head->ctx.data_end;
+		head->orig_ctx.data_end != head->ctx.data_end ||
+		head->orig_ctx.flags != head->ctx.flags;
 }

 static void reset_ctx(struct xdp_page_head *head)
@@ -234,6 +235,7 @@ static void reset_ctx(struct xdp_page_head *head)
 	head->ctx.data = head->orig_ctx.data;
 	head->ctx.data_meta = head->orig_ctx.data_meta;
 	head->ctx.data_end = head->orig_ctx.data_end;
+	head->ctx.flags = head->orig_ctx.flags;
 	xdp_update_frame_from_buff(&head->ctx, head->frame);
 	head->frame->mem_type = head->orig_ctx.rxq->mem.type;
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009..efbe293 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4243,9 +4243,8 @@ static unsigned long xdp_get_metalen(const struct xdp_buff *xdp)

 BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, xdp, int, offset)
 {
-	void *xdp_frame_end = xdp->data_hard_start + sizeof(struct xdp_frame);
 	unsigned long metalen = xdp_get_metalen(xdp);
-	void *data_start = xdp_frame_end + metalen;
+	void *data_start = xdp_buff_headroom_start(xdp) + metalen;
 	void *data = xdp->data + offset;

 	if (unlikely(data < data_start ||
@@ -4547,13 +4546,12 @@ static const struct bpf_func_proto bpf_xdp_adjust_tail_proto = {

 BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, xdp, int, offset)
 {
-	void *xdp_frame_end = xdp->data_hard_start + sizeof(struct xdp_frame);
 	void *meta = xdp->data_meta + offset;
 	unsigned long metalen = xdp->data - meta;

 	if (xdp_data_meta_unsupported(xdp))
 		return -ENOTSUPP;
-	if (unlikely(meta < xdp_frame_end ||
+	if (unlikely(meta < xdp_buff_headroom_start(xdp) ||
 		     meta > xdp->data))
 		return -EINVAL;
 	if (unlikely(xdp_metalen_invalid(metalen)))
@@ -12794,7 +12792,7 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)

 	start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;

-	headroom = start - xdp->data_hard_start - sizeof(struct xdp_frame);
+	headroom = start - xdp_buff_headroom_start(xdp);
 	tailroom = data_hard_end - xdp->data_end;

 	delta = len - data_len;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 1d679e8..ca17609 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -829,10 +829,10 @@ struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,

 	/* Essential SKB info: protocol and skb->dev */
 	skb->protocol = eth_type_trans(skb, dev);
+	if (xdpf->flags & XDP_FLAGS_RX_META)
+		__xdp_rx_meta_to_skb(skb, xdp_rx_meta(xdpf), xdpf->flags);

 	/* Optional SKB info, currently missing:
-	 * - HW checksum info		(skb->ip_summed)
-	 * - HW RX hash			(skb_set_hash)
 	 * - RX ring dev queue index	(skb_record_rx_queue)
 	 */

@@ -857,6 +857,9 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,

 	memset(skb, 0, offsetof(struct sk_buff, tail));

+	/* The callers set the RX fields themselves or transmit the skb */
+	xdpf->flags &= ~XDP_FLAGS_RX_META;
+
 	return __xdp_build_skb_from_frame(xdpf, skb, dev);
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_frame);
@@ -990,9 +993,154 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)
 	return btf_id_set8_contains(&xdp_metadata_kfunc_ids, btf_id);
 }

+void __xdp_rx_meta_to_skb(struct sk_buff *skb, const struct xdp_rx_meta *meta,
+			  u32 flags)
+{
+	if (flags & XDP_FLAGS_RX_HASH)
+		skb_set_hash(skb, meta->hash, meta->hash_type);
+	if (flags & XDP_FLAGS_RX_VLAN)
+		__vlan_hwaccel_put_tag(skb, meta->vlan_proto, meta->vlan_tci);
+	if (flags & XDP_FLAGS_RX_CSUM) {
+		skb->ip_summed = meta->ip_summed;
+		skb->csum_level = meta->csum_level;
+	}
+}
+EXPORT_SYMBOL_GPL(__xdp_rx_meta_to_skb);
+
+static struct xdp_rx_meta *xdp_rx_meta_reserve(const struct xdp_buff *xdp)
+{
+	struct xdp_rx_meta *meta = xdp_rx_meta(xdp->data_hard_start);
+	void *start = xdp_data_meta_unsupported(xdp) ? xdp->data : xdp->data_meta;
+
+	/* User space can write the headroom of AF_XDP zero-copy buffers */
+	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
+		return ERR_PTR(-EOPNOTSUPP);
+	if ((void *)(meta + 1) > start)
+		return ERR_PTR(-ENOSPC);
+	return meta;
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * bpf_xdp_store_rx_hash - Store the RX hash for the skb of this packet.
+ * @ctx: XDP context pointer.
+ * @hash: RX hash value.
+ * @rss_type: RSS hash type, see &enum xdp_rss_hash_type.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-ENOSPC`` : not enough headroom
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_store_rx_hash(struct xdp_md *ctx, u32 hash,
+				      enum xdp_rss_hash_type rss_type)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_rx_meta *meta = xdp_rx_meta_reserve(xdp);
+
+	if (IS_ERR(meta))
+		return PTR_ERR(meta);
+
+	meta->hash = hash;
+	if (rss_type & XDP_RSS_L4)
+		meta->hash_type = PKT_HASH_TYPE_L4;
+	else if (rss_type & (XDP_RSS_L3_IPV4 | XDP_RSS_L3_IPV6))
+		meta->hash_type = PKT_HASH_TYPE_L3;
+	else
+		meta->hash_type = PKT_HASH_TYPE_NONE;
+	xdp->flags |= XDP_FLAGS_RX_HASH;
+
+	return 0;
+}
+
+/**
+ * bpf_xdp_store_rx_vlan_tag - Store the VLAN tag for the skb of this packet.
+ * @ctx: XDP context pointer.
+ * @vlan_proto: VLAN tag protocol identifier (TPID), in network byte order.
+ * @vlan_tci: VLAN TCI, in host byte order.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EINVAL`` : @vlan_proto is not 802.1Q or 802.1AD
+ * * ``-ENOSPC`` : not enough headroom
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_store_rx_vlan_tag(struct xdp_md *ctx, __be16 vlan_proto,
+					  u16 vlan_tci)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_rx_meta *meta = xdp_rx_meta_reserve(xdp);
+
+	if (IS_ERR(meta))
+		return PTR_ERR(meta);
+	if (vlan_proto != htons(ETH_P_8021Q) &&
+	    vlan_proto != htons(ETH_P_8021AD))
+		return -EINVAL;
+
+	meta->vlan_proto = vlan_proto;
+	meta->vlan_tci = vlan_tci;
+	xdp->flags |= XDP_FLAGS_RX_VLAN;
+
+	return 0;
+}
+
+/**
+ * bpf_xdp_store_rx_csum - Store the checksum status for the skb of this packet.
+ * @ctx: XDP context pointer.
+ * @ip_summed: ``XDP_CHECKSUM_NONE`` or ``XDP_CHECKSUM_UNNECESSARY``.
+ * @csum_level: Number of consecutive verified checksums minus one, up to
+ *              ``SKB_MAX_CSUM_LEVEL``. Must be 0 with ``XDP_CHECKSUM_NONE``.
+ *
+ * Return:
+ * * Returns 0 on success or ``-errno`` on error.
+ * * ``-EINVAL`` : @ip_summed is not supported, or @csum_level is not valid
+ *   for it
+ * * ``-ENOSPC`` : not enough headroom
+ * * ``-EOPNOTSUPP`` : AF_XDP zero-copy buffer
+ */
+__bpf_kfunc int bpf_xdp_store_rx_csum(struct xdp_md *ctx,
+				      enum xdp_checksum ip_summed,
+				      u8 csum_level)
+{
+	struct xdp_buff *xdp = (struct xdp_buff *)ctx;
+	struct xdp_rx_meta *meta = xdp_rx_meta_reserve(xdp);
+
+	if (IS_ERR(meta))
+		return PTR_ERR(meta);
+	if (ip_summed == XDP_CHECKSUM_NONE && !csum_level)
+		meta->ip_summed = CHECKSUM_NONE;
+	else if (ip_summed == XDP_CHECKSUM_UNNECESSARY &&
+		 csum_level <= SKB_MAX_CSUM_LEVEL)
+		meta->ip_summed = CHECKSUM_UNNECESSARY;
+	else
+		return -EINVAL;
+
+	meta->csum_level = csum_level;
+	xdp->flags |= XDP_FLAGS_RX_CSUM;
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(xdp_rx_meta_kfunc_ids)
+BTF_ID_FLAGS(func, bpf_xdp_store_rx_hash)
+BTF_ID_FLAGS(func, bpf_xdp_store_rx_vlan_tag)
+BTF_ID_FLAGS(func, bpf_xdp_store_rx_csum)
+BTF_KFUNCS_END(xdp_rx_meta_kfunc_ids)
+
+static const struct btf_kfunc_id_set xdp_rx_meta_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &xdp_rx_meta_kfunc_ids,
+};
+
 static int __init xdp_metadata_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_rx_meta_kfunc_set);
+	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &xdp_metadata_kfunc_set);
 }
 late_initcall(xdp_metadata_init);

