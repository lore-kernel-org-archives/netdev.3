Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794597250;
	b=mWc2b8NC/FXAqGqq5am93iE9AEd6RRVyv/92OoAT1/wOqRVOT3ciUSFzGb+JgNE/A/AR
	 msJZECF1GWR6PL77W7qdlsKQLQbbJbmWyDu1+FtDsM7gwUHsCM1Qq7seSwKPuglnfPh8n
	 erAR3SqtO2nOTjWBXXo7C8KikXUZtWcQP4pEMlWL3HGp+0toWri125GEZJobcAz8ZUG4O
	 tXu+x1cztFEtTFRDtfb9TWhMU9IOpYSoSS9XYpcsGu4z1UR6h6WDEu7XRYepyx52Mpxuo
	 9Vwan3wTjwtnJlYjRT26awpk+pCbmGWBRa5xQjluaaEjogTPL7oKTKXOluE0tlI354g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nukmCzxnurdF+WzHZEUDqY2HEYOtndn6l7EHzMPKKf4=;
	b=nx4Fro2ws5RxtN9u/sFTgIPHvriO0Kjm5YH4nIYma5x3eLoJlqhiHupUmvZfe3+zYx55
	 4B0iybSPJm2MV0FmxpdJNlzklp1ooKLVx2ZIeARf7jDJUCIYTurlCtcfFt5Q4jdlm4oa9
	 WbFJcCx+dUNLqVA5h1Jq47pPt9QK6+EO5GBt1i2mZohw+ixBxaIe7ZE/H+uX0nQKj9bDn
	 eYuf2xWm+2bdP1nuTJcwru5QSpFqpIpElGIdlkXjV2vz0XxEOCl4R1YS6UmbiKe+CpjnU
	 s7vFOs2YbYdsTDOogwW8bjySBoF3NmYpBn8l3aNLwTzBvreLCXMMzPeMxYGlvjMQA9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A4wnrPTB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17A606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 19:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A17A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=A4wnrPTB
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso1209a12.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794597248; cv=none;
        d=google.com; s=arc-20260327;
        b=Do9is8/JNb9dNeuMhZt6lk6OPMt+cIFo9Cp6hqL2+NIUVTIngt9fwk1kAeQTZyRvub
         fNxQENM25QIEnadPssonPtdPNktyDuAGHfMeDeGyb+N4MrXodJIQoWuz5L1+zlAgPkMC
         VmAxSUGfkbICQyV83xeBUvXPdNzjkLW+4BQJPNP6wAFObYV5oZar86ZH2wWxBT3VerOX
         39uyupGwiSg8evHJhBL8+MkhF8cTyde1ZgEKARet0HEWXtr5ik3XqITr4uPzDxV2x8rv
         TdHt5Wd9XR4ikmsgcIUb/g6i7jY4CN3UGpe91Pp3delkve9DrqoXew2cC0Yn3+bcV7j/
         7Rlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nukmCzxnurdF+WzHZEUDqY2HEYOtndn6l7EHzMPKKf4=;
        fh=PQNYmB0frpQqMn3z8dE468pl6CD7IT7AFQcD/V4I1qw=;
        b=eRekO+7WRQIiuTipmidXH5Wuf6TrVuJBwnpKl9hSx7BqNQteQrX9T9zxtKMLQx/kve
         S6ky1WyYuyoexlnXY6boHtNVcSBGQYQ2a5TPuoCddU9dmehDx0BnooMgYPFwnTwgtteP
         0Y1V1NgSLaMKPqbCOyHq5FqSnm1kF5oLshZi7btkfi2mGFIMsCRS/2NeThl1V4xFWdnK
         /2mlVrAz64/asuXeGoMoIRegCGQW9OP+5EQO8t5obx7r3Xahwug7ApVraWPA+agkQsau
         UjU5ku+NqB+qEPmVNJOg8NYibWHF9dR2syQouuF2MTDj50HF8lKq4SxZCV3Y43cv0dTl
         g02Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794597248; x=1795202048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nukmCzxnurdF+WzHZEUDqY2HEYOtndn6l7EHzMPKKf4=;
        b=A4wnrPTBLDl3/9LGe/bpdPMp40hRVx9RVyf3BR65I4DSPTHHHmgNlW8YezYPuRZ0fs
         sXKyZ7uvek02wy+UkmJzUDRexI2zLWy1N2yi9dzxjq+Ypfjx3cEqzyUq3pGGd0X3tPrn
         BhIu6/xdDbLibCMPT/oeI7l1X7rx8orcZlvWpJfAvCc8VAhzOy3Gnnr7l10MoZMBol4W
         a3YfXVXY0n9zNRkm7nogVFWitgiQEL6uQEAZFmWWlMdavMGn99Z+Dx1h6I19dqdSbvus
         udJYhz0shvHXpso3COUcC/gkNIZTgHyNE46tnbCMuhF16w8SuQVBIAj+wfGiKsL9WNtK
         GWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794597248; x=1795202048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nukmCzxnurdF+WzHZEUDqY2HEYOtndn6l7EHzMPKKf4=;
        b=zoe3+CY4bZcrP0TetLHYWV2dVK2Dt9eZQaul7tEateUG/NN+T0huOmzwGTujMyQFxL
         5IpW7dPK/yWLUptmwbhnB5ZOiVKnun0jAhyaaKd3f3VOV4XcriTo744d26xtNx8Mb62n
         aOCC/N4t4SkuGLidi5y2VOjehPuwDRMOxmwzfl2bONhFIHO5gBYI8o4GTMVo2r8MzA5G
         3uld33PS0/ybJkiQdD6Ru5Cp36MgWH5mrNFSbdiEabtrkQ/LwkC3ibqVEm5HVmy6ggCG
         GUPUYniSc9a3qC97QVRSuwvBjvlTVCK22ZtCz7Ee6OCRr+qUSdH4CW5DpT5VWnd34tUL
         F5ZA==
X-Forwarded-Encrypted: i=1; AL+hErFTGze55dSz5lDSnNxaOm7kmP24fKBnO1TYnv2JbWwWiPwUjgBTU3peGnaWCG2g+xGQ03VPVJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8adZ1wlqGHgi8qlBupv5kw5nNxcpg3oF4luB04j6GqAO2WUGYK
	UFHm8CkKTKnJv1pk2RhdK46MeRSUVATQgf7+PjGb5HvYnW/YwCSqRxdUZEhNj+8Mg7FWJSX9/0C
	WO1y41MaQVE56rV/EU467KS85I3pBujoqudDaWTGZ
X-Gm-Gg: AYBFou1VkKc4xp0KQw4KAiQLSXY0Bec043feAOXWNoyKO7ePwcWBozOX2fLfivn3oZb
	NrHspeDwQz8BIdBADEsBRqAmvWj1FEcBjiTC1IcZ08RkLCdjovFcka7TNRnsSX1A+l51Hskg5Qf
	CzZKvkL70IHg9FVtlAVv2v6WPD6Rp7qe4dN5Uiy2o5clxmKzc6Yhhuz2Qgk5JSgaW9Jdo0qPPnX
	lBCk6EXXtK5VQ0VnP/a5bIcqXEXDn5Tf4t3pTuDo9dgAhjg4svXUK4TkhtNYracuh6Eis4D2g3v
	yTT2QIA6hb7zNagh1tZTStldd0fv+WMUXARMWoBk6wt/8M7HsInKLR7w2jLX6mWqmU8hEPOEndH
	YODHLFShdsf1dNZZ/L7mVFbCb678Zs+KZdC/B4bytb+I//6n/lVLVJieLr7AvlXzqVmY=
X-Received: by 2002:a05:6402:a218:20b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b7e0736587mr6700a12.13.1794597247918; Fri, 13 Nov 2026
 11:14:07 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110102039.1002605-1-bjorn@kernel.org> <20261110102039.1002605-5-bjorn@kernel.org>
In-Reply-To: <20261110102039.1002605-5-bjorn@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 13 Nov 2026 11:13:56 -0800
X-Gm-Features: AclHuK9SrzHlBa2KO-MSm5yvV0US3tsLyYCQnWM4XmzFNyUvpNqc1N9oPCjRgfU
Message-ID: <CAHS8izNC9APadHg9yPtROkii1H7TPMAB7Xhxo+y9Cx-XCw9C1Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1 04/11] xsk: Allocate UMEM chunks through page_pool
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
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
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, io-uring@vger.kernel.org, 
	"Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi <bestswngs@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stuart Clark <stuclar@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 2:21=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> AF_XDP zero copy needs a second RX allocator in every driver. A
> page_pool driver can take UMEM chunks from a memory provider instead,
> and keep its refill, recycling and DMA sync code.
>
> Each aligned chunk becomes a net_iov, whose address netmem_address()
> finds without calling the provider. Userspace may post a chunk that
> the kernel still owns, so the provider tracks the owner of each chunk
> and drops such FILL entries. Chunks that a page pool releases stay in
> the kernel for reuse. Nothing installs the provider yet.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> ---
>  include/net/netmem.h |  25 ++++-
>  include/net/xdp.h    |   2 +-
>  net/xdp/Kconfig      |   1 +
>  net/xdp/Makefile     |   2 +-
>  net/xdp/xsk.h        |   6 ++
>  net/xdp/xsk_pp.c     | 246 +++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 279 insertions(+), 3 deletions(-)
>  create mode 100644 net/xdp/xsk_pp.c
>
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index b986ad616334..a3b67ef32b21 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -69,6 +69,7 @@ DECLARE_STATIC_KEY_FALSE(page_pool_restricted);
>  enum net_iov_type {
>         NET_IOV_DMABUF,
>         NET_IOV_IOURING,
> +       NET_IOV_XSK,
>  };
>
>  /* A memory descriptor representing abstract networking I/O vectors.
> @@ -107,6 +108,10 @@ struct net_iov_area {
>         size_t num_niovs;
>         /* Each net_iov covers 1 << niov_shift bytes. */
>         unsigned int niov_shift;
> +       /* CPU address of the first net_iov, or NULL if the CPU cannot re=
ad
> +        * the area.
> +        */
> +       void *vaddr;
>  };
>
>  static inline struct net_iov_area *net_iov_owner(const struct net_iov *n=
iov)
> @@ -119,6 +124,18 @@ static inline unsigned int net_iov_idx(const struct =
net_iov *niov)
>         return niov - net_iov_owner(niov)->niovs;
>  }
>
> +static inline void *net_iov_address(const struct net_iov *niov)
> +{
> +       const struct net_iov_area *area =3D net_iov_owner(niov);
> +       unsigned long off;
> +
> +       if (!area->vaddr)
> +               return NULL;
> +
> +       off =3D (unsigned long)net_iov_idx(niov) << area->niov_shift;
> +       return area->vaddr + off;
> +}
> +
>  /* Initialize a niov: stamp the owning area, the memory provider type.
>   */
>  static inline void net_iov_init(struct net_iov *niov,
> @@ -345,10 +362,16 @@ static inline void *__netmem_address(netmem_ref net=
mem)
>         return page_address(__netmem_to_page(netmem));
>  }
>
> +/**
> + * netmem_address - get the CPU address of the memory behind @netmem
> + * @netmem: netmem to get the address of
> + *
> + * Return: the address, or NULL if the CPU cannot read @netmem.
> + */
>  static inline void *netmem_address(netmem_ref netmem)
>  {
>         if (netmem_is_net_iov(netmem))
> -               return NULL;
> +               return net_iov_address(netmem_to_net_iov(netmem));
>
>         return __netmem_address(netmem);
>  }
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 1105bb9e3292..5ab7802ac4e1 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -368,7 +368,7 @@ static inline bool xdp_buff_add_frag(struct xdp_buff =
*xdp, netmem_ref netmem,
>
>         if (unlikely(netmem_is_pfmemalloc(netmem)))
>                 xdp_buff_set_frag_pfmemalloc(xdp);
> -       if (unlikely(netmem_is_net_iov(netmem)))
> +       if (unlikely(netmem_is_net_iov(netmem) && !netmem_address(netmem)=
))
>                 xdp_buff_set_frag_unreadable(xdp);
>


netmem_is_net_iov() check became redundant.

>         return true;
> diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> index 71af2febe72a..c9c68d3b3712 100644
> --- a/net/xdp/Kconfig
> +++ b/net/xdp/Kconfig
> @@ -2,6 +2,7 @@
>  config XDP_SOCKETS
>         bool "XDP sockets"
>         depends on BPF_SYSCALL
> +       select PAGE_POOL
>         default n
>         help
>           XDP sockets allows a channel between XDP programs and
> diff --git a/net/xdp/Makefile b/net/xdp/Makefile
> index 30cdc4315f42..6e9d60f9f7f1 100644
> --- a/net/xdp/Makefile
> +++ b/net/xdp/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_XDP_SOCKETS) +=3D xsk.o xdp_umem.o xsk_queue.o xskmap.o
> -obj-$(CONFIG_XDP_SOCKETS) +=3D xsk_buff_pool.o
> +obj-$(CONFIG_XDP_SOCKETS) +=3D xsk_buff_pool.o xsk_pp.o
>  obj-$(CONFIG_XDP_SOCKETS_DIAG) +=3D xsk_diag.o
> diff --git a/net/xdp/xsk.h b/net/xdp/xsk.h
> index 7c811b5cce76..4dab7b9a1487 100644
> --- a/net/xdp/xsk.h
> +++ b/net/xdp/xsk.h
> @@ -34,6 +34,12 @@ static inline struct xdp_sock *xdp_sk(struct sock *sk)
>
>  void xsk_map_try_sock_delete(struct xsk_map *map, struct xdp_sock *xs,
>                              struct xdp_sock __rcu **map_entry);
> +struct xsk_pp;
> +
> +extern const struct memory_provider_ops xsk_pp_ops;
> +
> +struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool);
> +void xsk_pp_put(struct xsk_pp *pp);
>  void xsk_clear_pool_at_qid(struct net_device *dev, u16 queue_id);
>  int xsk_reg_pool_at_qid(struct net_device *dev, struct xsk_buff_pool *po=
ol,
>                         u16 queue_id);
> diff --git a/net/xdp/xsk_pp.c b/net/xdp/xsk_pp.c
> new file mode 100644
> index 000000000000..fdd55265a6cd
> --- /dev/null
> +++ b/net/xdp/xsk_pp.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* AF_XDP UMEM as a page pool memory provider
> + *
> + * Each aligned UMEM chunk is a readable net_iov with one owner at a tim=
e:
> + *
> + *   userspace --FILL--> page pool --release--> reuse --alloc--> page po=
ol
> + *       ^                   |
> + *       +-----RX ring-------+
> + */
> +
> +#include <net/page_pool/helpers.h>
> +#include <net/page_pool/memory_provider.h>
> +#include <net/xdp_sock_drv.h>
> +
> +#include "xsk.h"
> +#include "xsk_queue.h"
> +
> +enum xsk_pp_chunk {
> +       XSK_PP_USER,    /* owned by userspace */
> +       XSK_PP_POOL,    /* owned by a page pool */
> +       XSK_PP_REUSE,   /* on the reuse stack */
> +};

maybe should be xsk_mp_chunk.

But also, why is this 3? Usually the mp's track allocated and free. I
assume PP_REUSE is actually free, but I'm curious why it matters to
your mp whether the pool or the userspace holds the memory (or whether
the net stack holds it. Can't it hold it?)

> +
> +struct xsk_pp {

maybe xsk_mp? this is a memory provider right?


> +       struct net_iov_area area;
> +       struct xsk_buff_pool *pool;
> +       /* Protects fq, state and reuse */
> +       spinlock_t lock;
> +       struct xsk_queue *fq;
> +       refcount_t refs;
> +       u32 nr_pools;
> +       bool dma_need_sync;
> +       u8 *state;
> +       u32 reuse_cnt;
> +       u32 reuse[];
> +};
> +
> +static void xsk_pp_free(struct xsk_pp *pp)
> +{
> +       kvfree(pp->state);
> +       kvfree(pp->area.niovs);
> +       kvfree(pp);
> +}
> +
> +void xsk_pp_put(struct xsk_pp *pp)
> +{
> +       if (refcount_dec_and_test(&pp->refs))
> +               xsk_pp_free(pp);
> +}
> +
> +/* @pool must be DMA mapped and have aligned chunks. The provider must b=
e
> + * the only consumer of its FILL ring.
> + */
> +struct xsk_pp *xsk_pp_create(struct xsk_buff_pool *pool)
> +{
> +       struct net_iov *niov;
> +       struct xsk_pp *pp;
> +       dma_addr_t dma;
> +       u32 i;
> +
> +       pp =3D kvzalloc_flex(*pp, reuse, pool->heads_cnt, GFP_KERNEL_ACCO=
UNT);
> +       if (!pp)
> +               return ERR_PTR(-ENOMEM);
> +
> +       pp->area.niovs =3D kvzalloc_objs(*pp->area.niovs, pool->heads_cnt=
,
> +                                      GFP_KERNEL_ACCOUNT);
> +       pp->state =3D kvzalloc(pool->heads_cnt, GFP_KERNEL_ACCOUNT);
> +       if (!pp->area.niovs || !pp->state) {
> +               xsk_pp_free(pp);
> +               return ERR_PTR(-ENOMEM);
> +       }
> +
> +       pp->area.num_niovs =3D pool->heads_cnt;
> +       pp->area.niov_shift =3D pool->chunk_shift;
> +       pp->area.vaddr =3D pool->addrs;
> +       pp->pool =3D pool;
> +       pp->fq =3D pool->fq;
> +       pp->dma_need_sync =3D dma_dev_need_sync(pool->dev);
> +       spin_lock_init(&pp->lock);
> +       refcount_set(&pp->refs, 1);
> +
> +       for (i =3D 0; i < pp->area.num_niovs; i++) {
> +               niov =3D &pp->area.niovs[i];
> +               dma =3D xp_raw_get_dma(pool, (u64)i << pool->chunk_shift)=
;
> +               net_iov_init(niov, &pp->area, NET_IOV_XSK);
> +               if (net_mp_niov_set_dma_addr(niov, dma)) {
> +                       xsk_pp_free(pp);
> +                       return ERR_PTR(-ERANGE);
> +               }
> +       }
> +
> +       return pp;
> +}
> +
> +static int xsk_pp_init(struct page_pool *pool)
> +{
> +       struct xsk_pp *pp =3D pool->mp_priv;
> +
> +       if (pool->p.order || pool->p.dma_dir !=3D DMA_BIDIRECTIONAL ||
> +           pool->p.dev !=3D pp->pool->dev)
> +               return -EINVAL;
> +       if (pool->p.max_len > pp->pool->chunk_size ||
> +           pool->p.offset > pp->pool->chunk_size - pool->p.max_len)
> +               return -EINVAL;
> +
> +       refcount_inc(&pp->refs);
> +       spin_lock_bh(&pp->lock);
> +       pp->nr_pools++;
> +       spin_unlock_bh(&pp->lock);
> +       return 0;
> +}
> +
> +static void xsk_pp_destroy(struct page_pool *pool)
> +{
> +       struct xsk_pp *pp =3D pool->mp_priv;
> +
> +       spin_lock_bh(&pp->lock);
> +       pp->nr_pools--;
> +       spin_unlock_bh(&pp->lock);
> +       xsk_pp_put(pp);
> +}
> +
> +static bool xsk_pp_claim(struct xsk_pp *pp, u32 idx, enum xsk_pp_chunk f=
rom)
> +{
> +       lockdep_assert_held(&pp->lock);
> +
> +       if (pp->state[idx] !=3D from)
> +               return false;
> +
> +       pp->state[idx] =3D XSK_PP_POOL;
> +       return true;
> +}
> +
> +static u32 xsk_pp_alloc_reuse(struct xsk_pp *pp, netmem_ref *netmems, u3=
2 max)
> +{
> +       u32 idx, n =3D 0;
> +
> +       while (n < max && pp->reuse_cnt) {
> +               idx =3D pp->reuse[--pp->reuse_cnt];
> +               if (WARN_ON_ONCE(!xsk_pp_claim(pp, idx, XSK_PP_REUSE)))
> +                       continue;
> +               netmems[n++] =3D net_iov_to_netmem(&pp->area.niovs[idx]);
> +       }
> +
> +       return n;
> +}
> +
> +static u32 xsk_pp_alloc_fill(struct xsk_pp *pp, netmem_ref *netmems, u32=
 max)
> +{
> +       struct xsk_buff_pool *pool =3D pp->pool;
> +       struct xsk_queue *fq =3D pp->fq;
> +       u32 i, entries, cons, idx, n =3D 0;
> +       u64 addr;
> +
> +       if (!fq || !max)
> +               return 0;
> +
> +       entries =3D xskq_cons_nb_entries(fq, max);
> +       if (!entries) {
> +               fq->queue_empty_descs++;
> +               return 0;
> +       }
> +
> +       cons =3D fq->cached_cons;
> +       for (i =3D 0; i < entries; i++) {
> +               __xskq_cons_read_addr_unchecked(fq, cons++, &addr);
> +               addr &=3D pool->chunk_mask;
> +               idx =3D addr >> pp->area.niov_shift;
> +               if (unlikely(addr >=3D pool->addrs_cnt ||
> +                            !xsk_pp_claim(pp, idx, XSK_PP_USER))) {
> +                       fq->invalid_descs++;
> +                       continue;
> +               }
> +               netmems[n++] =3D net_iov_to_netmem(&pp->area.niovs[idx]);
> +       }
> +
> +       xskq_cons_release_n(fq, entries);
> +       __xskq_cons_release(fq);
> +       return n;
> +}
> +
> +static netmem_ref xsk_pp_alloc_netmems(struct page_pool *pool, gfp_t gfp=
)
> +{
> +       netmem_ref *netmems =3D pool->alloc.cache;
> +       struct xsk_pp *pp =3D pool->mp_priv;
> +       struct net_iov *niov;
> +       dma_addr_t dma;
> +       u32 i, n;
> +
> +       if (WARN_ON_ONCE(pool->alloc.count))
> +               return 0;
> +
> +       spin_lock_bh(&pp->lock);
> +       n =3D xsk_pp_alloc_reuse(pp, netmems, PP_ALLOC_CACHE_REFILL);
> +       n +=3D xsk_pp_alloc_fill(pp, netmems + n, PP_ALLOC_CACHE_REFILL -=
 n);
> +       spin_unlock_bh(&pp->lock);
> +       if (!n)
> +               return 0;
> +
> +       for (i =3D 0; i < n; i++) {
> +               niov =3D netmem_to_net_iov(netmems[i]);
> +               dma =3D page_pool_get_dma_addr_netmem(netmems[i]);
> +               if (pp->dma_need_sync)
> +                       dma_sync_single_range_for_device(pool->p.dev, dma=
,
> +                                                        pool->p.offset,
> +                                                        pool->p.max_len,
> +                                                        pool->p.dma_dir)=
;
> +               net_mp_niov_set_page_pool(pool, niov);
> +       }
> +
> +       pool->alloc.count =3D n - 1;
> +       return netmems[n - 1];
> +}
> +
> +static bool xsk_pp_release_netmem(struct page_pool *pool, netmem_ref net=
mem)
> +{
> +       struct net_iov *niov =3D netmem_to_net_iov(netmem);
> +       struct xsk_pp *pp =3D pool->mp_priv;
> +       u32 idx =3D net_iov_idx(niov);
> +
> +       spin_lock_bh(&pp->lock);
> +       net_mp_niov_clear_page_pool(niov);
> +       if (!WARN_ON_ONCE(pp->state[idx] !=3D XSK_PP_POOL ||
> +                         pp->reuse_cnt =3D=3D pp->area.num_niovs)) {
> +               pp->state[idx] =3D XSK_PP_REUSE;
> +               pp->reuse[pp->reuse_cnt++] =3D idx;
> +       }
> +       spin_unlock_bh(&pp->lock);
> +
> +       return false;
> +}
> +
> +static int xsk_pp_nl_fill(void *mp_priv, struct sk_buff *rsp,
> +                         struct netdev_rx_queue *rxq)
> +{
> +       return 0;
> +}
> +
> +const struct memory_provider_ops xsk_pp_ops =3D {
> +       .init           =3D xsk_pp_init,
> +       .destroy        =3D xsk_pp_destroy,
> +       .alloc_netmems  =3D xsk_pp_alloc_netmems,
> +       .release_netmem =3D xsk_pp_release_netmem,
> +       .nl_fill        =3D xsk_pp_nl_fill,
> +       .caps           =3D MP_CAP_READABLE,
> +};
> --
> 2.56.0
>


--
Thanks,
Mina
