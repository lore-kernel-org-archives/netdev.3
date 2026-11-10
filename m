Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354732;
	b=YQpH8mtQZL7uPjvqXUfSePFlQR/A/9Gltv/d/LXS5Ym+sNfUazPuOjUMUs00RFty5oUo
	 37mMxMl/iwMSwuybt0ZG5rnUevhJfy1bGkyaBaHlzI1k6wkt6Qnd4szCfi00DcSAVFyEm
	 O8pirB9JZZUEzqAHsVBgkbWtVFEHK5Ufhx6hEwNS75FOMWFfyVKcogsomRi7kKtBoOUFN
	 s6g+/bLfpfBsPOzrk5UzZdLM7SO3gn4lo8L3foK8UJiwrMJAnnaFxfnmHtOaTAMiU0CyL
	 eux6YV1cMIdUrJX1Cm5B4Ddk6byR+QLHrakOq58dBiOfJNZbiPI/csTgS8h9p5Z1dZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=6MfQtXJm79sw7D3UsF08XYwuRq4pspLW3OExU6w9/Kk=;
	b=0Zd8nPs/ye6x4Ebr2s8i2xlI1GHGn0RKu9+955HMZMbTaFsgZLwn8Yb9XiIa5JjeqPPP
	 LKcBqOY6e73iSDrQgieR9TWFClM+M61ej4/Z1eHVxDiISkJ+fHoyYzVAG3snJyc+r4+Qj
	 dCDRS4QgMBiZeRXXC04vrm8zKbKJ2j4iBfVFnk5hHlZ0Wc07Ebfs3jwAcw9frGDMf5Jjc
	 buqMk3C1fEN1CiKy2nky/YPQinW/WTvIeePHuyfjxmblO6OtWkigqCvLg8UrZCWzkTJph
	 yu8kY84lBK07WomvLsbsMdSDZ1v0u9V0I2zwMtLcWO/3dgPQJYZOOTIpQPh8pIFFEDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qGoGBS9y;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39CC606A33C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A39CC606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qGoGBS9y
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso2419103c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354730; x=1794959530; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6MfQtXJm79sw7D3UsF08XYwuRq4pspLW3OExU6w9/Kk=;
        b=qGoGBS9ydlyzha2HhSniQn6m71/HA+v6j87E38b2n/TfFUJ0pcM9dIDBEQkC32znUU
         YLr5fcmRTVL2hBNuNBtyoLqmdCqXozFPetvH4E6k/UwmOlHlMwGj7hPIED9t+LALovKM
         /rzSA85y57/W6GE0JuHs3b/FKo3quDIalhKb6Dvaf4vBmu9LZO7qRh7dwyivhXEyt1Rf
         a9RBAvixuwepr8fEq/yq7KLrAg7+n/byDLGV7GI4GJ8dEVmmhkPlW+ciy2gzJ674T0I0
         B15ST2nWyGRoBUJwGz6VJOWlbCbiVsZjMcWTk/TX7q6YwxmYIa8JmcyAuZRme64CLP/T
         2vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354730; x=1794959530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6MfQtXJm79sw7D3UsF08XYwuRq4pspLW3OExU6w9/Kk=;
        b=J2HP2mC9g08me9tnZygEkilXo3ylCsAVuHNqAibnCqm17RIIAaYtvDqLtOdKKKTC7x
         i6OV2PVsEZdsvGZeS9TVhB3tbovh5JDZJ4DmjGzAg3PDdftyiFaQPkzuWZwvJc3TV0LN
         KQH7uoqUBR8oDyFDhwDmrDiLrJDsbth5SabisGDuIE9Ia75iOqB0Awmy5sZmqfUlldGq
         JMRyZndXDePj+Sch8HAdlYz1qVzaIzowjIvwIXWYZTA28Iel5aXFm7bwMJpk0aWkl5VD
         0EFkOIUPMj48xwGkNHVvtt7ZBk7l+2bUnuo7GsNXf1dPd5PLImBwrq1dFvugrK/dvGmV
         YKuw==
X-Forwarded-Encrypted: i=1; AL+hErEGqvJCYzYNJUqWG18lMj2v8KScLs1+XhGm2OTbPAWAbKNgAVkJYUH+UBzdOdZUin8aFS2PkSY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dJBD5Wx9R9qN4A2bSYYAsnMKCl/X/jvwbMU0C9fgWX0JUinYg
	8jq9QAKJblGTAY52PImEL8hv1P2C2k31nWd3LTFV3ofLjc/B81hDQFas
X-Gm-Gg: AYBFou1vYFA7E0NuhHTEdRW2VvGPeXI0qLeFbeMUiilSqdgLh/MG+p/WWhfb877QakU
	pWk7iJcNezT40WnhHKAvG6vuxju04mKbZ2OXtIOzwyHU6pTf06Fl0+cXKRgrjGWDNJfW8NR4Hnw
	lhRfbt+qtHX36O3jF/X/dtcRza41McnWsh33Ql8dKfEH8vL2WAJZJK8mpksDLBYggTSXDyuQr1S
	yuExHekyAKQDYycUXKq48lcuykdxTJMDQ6w/a7WIYnfG6UgthG3NW5c5tnFr3O5OhEfhCl5Tf/g
	CoQTlFxlR6uyqGdi4gVklzBhENEl5qkJ6zqKrYfq3hz8lF88xkbRz5YFP321q9xvAjqREfOyWFk
	hVuVRu907JTyxHrcGsiRum8jWLLI3emOsFVmlYTkEXT2hZxSuVj3Z87XZejqfk8oHOb4ZqV8dB7
	Ffm9p8OU2FcpgzVIGUfEWZo0CBv/oiSfw0aKpR6XQc1d4NikwsgYApSBNdwJP89ImhwznSKuayv
	ThQwGCmJUZwm+3BH+6CSq6H8WcJHYkdFRHI4G+DUcqFl1tgshQuRSPXlbG3xXmpz8SX6WoxP0Hl
	EGxsu2RI8HYw71rW/Qow4lE=
X-Received: by 2002:a05:7022:1706:b0:151:d6e5:596b with SMTP id a92af1059eb24-1b3c02ec796mr570661c88.9.1794354729456;
        Tue, 10 Nov 2026 15:52:09 -0800 (PST)
Received: from localhost ([2a03:2880:9ff:40::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm19178865eec.18.2026.11.10.15.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:52:08 -0800 (PST)
Date: Tue, 10 Nov 2026 14:32:13 -0800
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	io-uring@vger.kernel.org, Mina Almasry <almasrymina@google.com>, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stuart Clark <stuclar@meta.com>
Subject: Re: [PATCH net-next v1 03/11] xdp: Copy buffers with restricted
 lifetime
Message-ID: <avOZa6jLnmvYkk2H@devvm16445.scu0.facebook.com>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-4-bjorn@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261110102039.1002605-4-bjorn@kernel.org>

On 11/10, Björn Töpel wrote:
> UMEM stays mapped writable in userspace, and it has a fixed number of
> chunks. The stack must not keep its chunks in an skb or an xdp_frame.
> Mark the providers whose buffers the stack may keep with
> MP_CAP_RETAIN, and copy packets of the others on XDP_PASS, on
> conversion to a frame, and on redirects other than XSKMAP.
> 
> The head chunk is writable by userspace, so it cannot hold
> skb_shared_info, and virt_to_netmem() cannot find a net_iov head.
> Drivers pass kernel memory for both to xdp_init_buff_netmem().
> 
> A static key keeps the check off while no such page pool exists. A
> frame copy is linear, so a multi-buffer packet of such a provider
> cannot go to a device or CPU map.
> 
> Signed-off-by: Björn Töpel <bjorn@kernel.org>
> ---
>  include/linux/skbuff.h                  |  1 +
>  include/net/netmem.h                    | 10 +++
>  include/net/page_pool/memory_provider.h |  3 +
>  include/net/xdp.h                       | 92 +++++++++++++++++++++++--
>  io_uring/zcrx.c                         |  2 +-
>  net/core/dev.h                          |  4 ++
>  net/core/devmem.c                       |  2 +-
>  net/core/filter.c                       | 20 +++++-
>  net/core/page_pool.c                    | 30 ++++++++
>  net/core/xdp.c                          | 78 +++++++++++++++++----
>  10 files changed, 221 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 8b0039d49905..a9cc5dd0211a 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -2691,6 +2691,7 @@ static inline void skb_add_rx_frag_netmem(struct sk_buff *skb, int i,
>  					  int size, unsigned int truesize)
>  {
>  	DEBUG_NET_WARN_ON_ONCE(size > truesize);
> +	DEBUG_NET_WARN_ON_ONCE(!netmem_can_retain(netmem));
>  
>  	skb_fill_netmem_desc(skb, i, netmem, off, size);
>  	skb->len += size;
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index f196b014184c..b986ad616334 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -59,6 +59,7 @@ static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
>  /* net_iov */
>  
>  DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +DECLARE_STATIC_KEY_FALSE(page_pool_restricted);
>  
>  /*  We overload the LSB of the struct page pointer to indicate whether it's
>   *  a page or net_iov.
> @@ -414,6 +415,15 @@ static inline bool net_is_devmem_iov(const struct net_iov *niov)
>  void net_iov_inc_ref(struct net_iov *niov);
>  void net_iov_dec_ref(struct net_iov *niov);
>  
> +#if IS_ENABLED(CONFIG_PAGE_POOL)
> +bool netmem_can_retain(netmem_ref netmem);
> +#else
> +static inline bool netmem_can_retain(netmem_ref netmem)
> +{
> +	return true;
> +}
> +#endif
> +
>  /**
>   * netmem_inc_ref - acquire a non-page_pool reference on a netmem
>   * @netmem: netmem to reference
> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_pool/memory_provider.h
> index 4417e54a0f81..e732b21be9a2 100644
> --- a/include/net/page_pool/memory_provider.h
> +++ b/include/net/page_pool/memory_provider.h
> @@ -25,10 +25,13 @@ struct sk_buff;
>   * @MP_CAP_READABLE: The CPU can access provider memory. It may back header
>   *	page pools, and XDP programs may run on it.
>   * @MP_CAP_FRAG: Page pool fragments may split provider buffers.
> + * @MP_CAP_RETAIN: The stack may keep page pool references to provider
> + *	buffers after the RX poll, for example in an skb or an xdp_frame.
>   */
>  enum mp_caps {
>  	MP_CAP_READABLE		= BIT(0),
>  	MP_CAP_FRAG		= BIT(1),
> +	MP_CAP_RETAIN		= BIT(2),
>  };
>  
>  struct memory_provider_ops {
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 07231adfb5f8..1105bb9e3292 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -81,6 +81,16 @@ enum xdp_buff_flags {
>  	 * XDP program is not attached.
>  	 */
>  	XDP_FLAGS_FRAGS_UNREADABLE	= BIT(2),
> +	/* Internal: the head netmem and the shared info are in &xdp_buff.ext.
> +	 * Not copied to xdp_frames or skbs.
> +	 */
> +	XDP_FLAGS_EXT			= BIT(3),
> +};
> +
> +/* For a head buffer that cannot hold kernel data, see xdp_init_buff_netmem() */
> +struct xdp_buff_ext {
> +	netmem_ref netmem;

nit: netmem -> head ? and the same for xdp_init_buff_netmem netmem arg?

> +	struct skb_shared_info sinfo;
>  };
>  
>  struct xdp_buff {
> @@ -89,7 +99,12 @@ struct xdp_buff {
>  	void *data_meta;
>  	void *data_hard_start;
>  	struct xdp_rxq_info *rxq;
> -	struct xdp_txq_info *txq;
> +	union {
> +		/* DEVMAP egress programs only */
> +		struct xdp_txq_info *txq;
> +		/* RX buffers with XDP_FLAGS_EXT */
> +		struct xdp_buff_ext *ext;
> +	};
>  
>  	union {
>  		struct {
> @@ -138,7 +153,7 @@ static __always_inline void xdp_buff_set_frag_unreadable(struct xdp_buff *xdp)
>  
>  static __always_inline u32 xdp_buff_get_skb_flags(const struct xdp_buff *xdp)
>  {
> -	return xdp->flags;
> +	return xdp->flags & ~XDP_FLAGS_EXT;

The only consumer is xdp_update_skb_frags_info, so probably not worth
filtering out XDP_FLAGS_EXT here? Or is it for
xdp_update_frame_from_buff? Can we explicitly clear it at the caller? 

>  }
>  
>  static __always_inline void xdp_buff_clear_frag_pfmemalloc(struct xdp_buff *xdp)
> @@ -176,6 +191,50 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
>  	xdp->data_meta = meta_valid ? data : data + 1;
>  }
>  
> +/* See MP_CAP_RETAIN */
> +static __always_inline bool xdp_netmem_restricted(netmem_ref netmem)
> +{
> +	return IS_ENABLED(CONFIG_PAGE_POOL) &&
> +	       static_branch_unlikely(&page_pool_restricted) &&
> +	       !netmem_can_retain(netmem);
> +}
> +
> +/**
> + * xdp_init_buff_netmem - initialize an &xdp_buff for a netmem head buffer
> + * @xdp: &xdp_buff to initialize
> + * @frame_sz: frame size
> + * @rxq: RX queue info
> + * @netmem: head buffer
> + * @ext: kernel memory used if @netmem cannot hold the shared info, or the
> + *	stack must not keep it. It must live as long as @xdp.
> + *
> + * A driver that may receive into memory provider buffers uses this instead
> + * of xdp_init_buff().
> + */
> +static __always_inline void
> +xdp_init_buff_netmem(struct xdp_buff *xdp, u32 frame_sz,
> +		     struct xdp_rxq_info *rxq, netmem_ref netmem,
> +		     struct xdp_buff_ext *ext)
> +{
> +	xdp_init_buff(xdp, frame_sz, rxq);
> +	if (likely(!netmem_is_net_iov(netmem) &&
> +		   !xdp_netmem_restricted(netmem)))
> +		return;
> +
> +	ext->netmem = netmem;
> +	xdp->ext = ext;
> +	xdp->flags |= XDP_FLAGS_EXT;
> +}
> +
> +static __always_inline netmem_ref
> +xdp_buff_head_netmem(const struct xdp_buff *xdp)
> +{
> +	if (unlikely(xdp->flags & XDP_FLAGS_EXT))
> +		return xdp->ext->netmem;
> +
> +	return virt_to_netmem(xdp->data);
> +}
> +
>  /* Reserve memory area at end-of data area.
>   *
>   * This macro reserves tailroom in the XDP buffer by limiting the
> @@ -189,9 +248,28 @@ xdp_prepare_buff(struct xdp_buff *xdp, unsigned char *hard_start,
>  static inline struct skb_shared_info *
>  xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
>  {
> +	if (unlikely(xdp->flags & XDP_FLAGS_EXT))
> +		return &xdp->ext->sinfo;
> +
>  	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
>  }
>  
> +bool __xdp_buff_needs_copy(const struct xdp_buff *xdp);
> +
> +/* Must the stack copy a buffer of @xdp before it keeps it? XSK buffers are
> + * copied by their own conversion.
> + */
> +static __always_inline bool xdp_buff_needs_copy(const struct xdp_buff *xdp)
> +{
> +	if (unlikely(xdp->flags & XDP_FLAGS_EXT))
> +		return true;
> +	if (!IS_ENABLED(CONFIG_PAGE_POOL) ||
> +	    !static_branch_unlikely(&page_pool_restricted))
> +		return false;
> +
> +	return __xdp_buff_needs_copy(xdp);
> +}
> +
>  static __always_inline unsigned int
>  xdp_get_buff_len(const struct xdp_buff *xdp)
>  {
> @@ -379,7 +457,7 @@ xdp_update_skb_frags_info(struct sk_buff *skb, u8 nr_frags,
>  void xdp_warn(const char *msg, const char *func, const int line);
>  #define XDP_WARN(msg) xdp_warn(msg, __func__, __LINE__)
>  
> -struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp);
> +struct sk_buff *xdp_build_skb_from_buff(struct xdp_buff *xdp);
>  struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp);
>  struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp);
>  struct sk_buff *__xdp_build_skb_from_frame(struct xdp_frame *xdpf,
> @@ -420,12 +498,15 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
>  		return -ENOSPC;
>  	}
>  
> +	/* The stack may keep the frame, see xdp_buff_needs_copy(). */
> +	DEBUG_NET_WARN_ON_ONCE(xdp_buff_needs_copy(xdp));
> +
>  	xdp_frame->data = xdp->data;
>  	xdp_frame->len  = xdp->data_end - xdp->data;
>  	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
>  	xdp_frame->metasize = metasize;
>  	xdp_frame->frame_sz = xdp->frame_sz;
> -	xdp_frame->flags = xdp->flags;
> +	xdp_frame->flags = xdp_buff_get_skb_flags(xdp);
>  
>  	return 0;
>  }
> @@ -436,7 +517,8 @@ struct xdp_frame *xdp_convert_buff_to_frame(struct xdp_buff *xdp)
>  {
>  	struct xdp_frame *xdp_frame;
>  
> -	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL)
> +	if (xdp->rxq->mem.type == MEM_TYPE_XSK_BUFF_POOL ||
> +	    xdp_buff_needs_copy(xdp))
>  		return xdp_convert_zc_to_xdp_frame(xdp);
>  
>  	/* Store info in top of packet */
> diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
> index 3b5bf97aa203..98d83a8e45e4 100644
> --- a/io_uring/zcrx.c
> +++ b/io_uring/zcrx.c
> @@ -1478,7 +1478,7 @@ static const struct memory_provider_ops io_uring_pp_zc_ops = {
>  	.destroy		= io_pp_zc_destroy,
>  	.nl_fill		= io_pp_nl_fill,
>  	.uninstall		= io_pp_uninstall,
> -	.caps			= MP_CAP_FRAG,
> +	.caps			= MP_CAP_FRAG | MP_CAP_RETAIN,

>  };
>  
>  static unsigned zcrx_parse_rq(netmem_ref *netmem_array, unsigned nr,
> diff --git a/net/core/dev.h b/net/core/dev.h
> index 4e9e8cd15697..e3337013ffc8 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -13,6 +13,10 @@ struct netlink_ext_ack;
>  struct netdev_queue_config;
>  struct cpumask;
>  struct pp_memory_provider_params;
> +struct xdp_buff;
> +struct xdp_frame;
> +
> +struct xdp_frame *xdp_copy_buff_to_frame(const struct xdp_buff *xdp);
>  
>  /* Random bits of netdevice that don't need to be exposed */
>  #define FLOW_LIMIT_HISTORY	(1 << 7)  /* must be ^2 and !overflow buckets */
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 8f190b574beb..dea4a4a17e86 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -698,5 +698,5 @@ static const struct memory_provider_ops dmabuf_devmem_ops = {
>  	.release_netmem		= mp_dmabuf_devmem_release_page,
>  	.nl_fill		= mp_dmabuf_devmem_nl_fill,
>  	.uninstall		= mp_dmabuf_devmem_uninstall,
> -	.caps			= MP_CAP_FRAG,
> +	.caps			= MP_CAP_FRAG | MP_CAP_RETAIN,

Not sure I understand this part, can you explain?
These are MP_CAP_RETAIN because they are unreadable?

>  };
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 80380f89adf9..f93839b493b2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4774,12 +4774,28 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
>  {
>  	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>  	enum bpf_map_type map_type = ri->map_type;
> +	struct xdp_frame *xdpf;
> +	int err;
>  
>  	if (map_type == BPF_MAP_TYPE_XSKMAP)
>  		return __xdp_do_redirect_xsk(ri, dev, xdp, xdp_prog);
>  
> -	return __xdp_do_redirect_frame(ri, dev, xdp_convert_buff_to_frame(xdp),
> -				       xdp_prog);
> +	if (likely(!xdp_buff_needs_copy(xdp)))
> +		return __xdp_do_redirect_frame(ri, dev,
> +					       xdp_convert_buff_to_frame(xdp),
> +					       xdp_prog);
> +
> +	/* Release the source only after the target took the copy. */
> +	xdpf = xdp_copy_buff_to_frame(xdp);
> +	err = __xdp_do_redirect_frame(ri, dev, xdpf, xdp_prog);
> +	if (unlikely(err)) {
> +		if (xdpf)
> +			xdp_return_frame(xdpf);
> +		return err;
> +	}
> +
> +	xdp_return_buff(xdp);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(xdp_do_redirect);
>  
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index d88a3ea528d4..8237fda598ab 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -34,6 +34,10 @@
>  
>  DEFINE_STATIC_KEY_FALSE(page_pool_mem_providers);
>  
> +/* Enabled while a pool of a provider without MP_CAP_RETAIN exists. */
> +DEFINE_STATIC_KEY_FALSE(page_pool_restricted);
> +EXPORT_SYMBOL(page_pool_restricted);
> +
>  #define DEFER_TIME (msecs_to_jiffies(1000))
>  #define DEFER_WARN_INTERVAL (60 * HZ)
>  
> @@ -188,6 +192,28 @@ static void page_pool_struct_check(void)
>  				    PAGE_POOL_FRAG_GROUP_ALIGN);
>  }
>  
> +/**
> + * netmem_can_retain() - may the stack keep @netmem after the RX poll
> + * @netmem: netmem to check
> + *
> + * Context: the caller holds @netmem through its page pool. A plain page
> + * reference does not keep the page in its pool.
> + * Return: false if @netmem belongs to a memory provider without
> + * MP_CAP_RETAIN.
> + */
> +bool netmem_can_retain(netmem_ref netmem)
> +{
> +	const struct memory_provider_ops *ops;
> +
> +	netmem = netmem_compound_head(netmem);
> +	if (!netmem_is_pp(netmem))
> +		return true;
> +
> +	ops = netmem_get_pp(netmem)->mp_ops;
> +	return !ops || ops->caps & MP_CAP_RETAIN;
> +}
> +EXPORT_SYMBOL(netmem_can_retain);
> +
>  static int page_pool_select_mp(struct page_pool *pool,
>  			       const struct pp_memory_provider_params *mpp)
>  {
> @@ -324,6 +350,8 @@ static int page_pool_init(struct page_pool *pool,
>  		}
>  
>  		static_branch_inc(&page_pool_mem_providers);
> +		if (!(pool->mp_ops->caps & MP_CAP_RETAIN))
> +			static_branch_inc(&page_pool_restricted);
>  	} else if (pool->p.order > MAX_PAGE_ORDER) {
>  		err = -EINVAL;
>  		goto free_ptr_ring;
> @@ -352,6 +380,8 @@ static void page_pool_uninit(struct page_pool *pool)
>  #endif
>  
>  	if (pool->mp_ops) {
> +		if (!(pool->mp_ops->caps & MP_CAP_RETAIN))
> +			static_branch_dec(&page_pool_restricted);
>  		pool->mp_ops->destroy(pool);
>  		static_branch_dec(&page_pool_mem_providers);
>  	}
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 1d679e8fd649..0cf46d492d91 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -23,6 +23,8 @@
>  #include <trace/events/xdp.h>
>  #include <net/xdp_sock_drv.h>
>  
> +#include "dev.h"
> +
>  #define REG_STATE_NEW		0x0
>  #define REG_STATE_REGISTERED	0x1
>  #define REG_STATE_UNREGISTERED	0x2
> @@ -559,10 +561,41 @@ void xdp_return_buff(struct xdp_buff *xdp)
>  			     xdp->rxq->mem.type, true, xdp);
>  
>  out:
> -	__xdp_return(virt_to_netmem(xdp->data), xdp->rxq->mem.type, true, xdp);
> +	__xdp_return(xdp_buff_head_netmem(xdp), xdp->rxq->mem.type, true, xdp);
>  }
>  EXPORT_SYMBOL_GPL(xdp_return_buff);
>  
> +bool __xdp_buff_needs_copy(const struct xdp_buff *xdp)
> +{
> +	const struct skb_shared_info *sinfo;
> +	u32 i;
> +
> +	/* Provider buffers come only from page pool queues */
> +	if (xdp->rxq->mem.type != MEM_TYPE_PAGE_POOL)
> +		return false;
> +	if (!netmem_can_retain(xdp_buff_head_netmem(xdp)))
> +		return true;
> +	if (likely(!xdp_buff_has_frags(xdp)))
> +		return false;
> +
> +	sinfo = xdp_get_shared_info_from_buff(xdp);
> +	for (i = 0; i < sinfo->nr_frags; i++) {
> +		if (!netmem_can_retain(skb_frag_netmem(&sinfo->frags[i])))
> +			return true;

Do we want/need to go that deep? Can we have a skb-like assumptions that
mixing retain and non-retain in the same shinfo is not allowed?
