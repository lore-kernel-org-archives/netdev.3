Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748D1449B22
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576652; cv=pass; b=IPVQ8nNSXgyT95dZ088h/KevVO3Y8T0I4S+hpM17nfiBScKdzHu5zZGQTtakk64BwFBnAPOPxc0QOozqwI/8Tjyb3MxsS4J+r9x+21kwJWxksXIEzlBRTk2ppo0wxSm8nsBEvCYZLUcEB2lxr7eHZakgrpKxEWgo6efare3k+gA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576652; c=relaxed/simple;
	bh=ytciUFjlNF6Z1Zi01hjgS/0ArtVMWYYff4GEHsDLYX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0EjpCU2QKJe/Z/kQ9LipiA4/2Y6DY1FP9pQQtPafPPg87L6LNRW3pP2y5TlZ0GNM6YdP0SotFvhrw+A2Q0GTa6JII5FFTqgmnB+WdNDftthG4Nh9Fm75HGVJALHZ3zq2ye0/cZwA+ktaEkD1dDnqfk9cLkMnEMEwJQywY0+Eyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2nfbOGL; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2nfbOGL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-495509b08ebso90155e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 12:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784576649; cv=none;
        d=google.com; s=arc-20260327;
        b=RXEeO79b5g7Hm8C80HS8StflhctgGpbZ3VgyXiZeMKBQBU5gfrY37OLnTpeWImCCcp
         5oEek8CqAk+FQk3xSLpeEiiOMdbhoLTxuA9ji5eTr3Wvy2ERvj8L6dJWWtQGvri9IK12
         5pp02qgDy3Mj0yLiV/ZPL8RIuPUye9obFRs88jFMSEK2Q/JrxKTzPv28ussLVPgv8Z9k
         gdYsIyfcO9qKWqfBJyi5B+WGT7Digur/mr0oVTV1XqyttqgEh4O+Z2HaWXm8kOZat/Z3
         Ead9rSzuzlRJiA2EuWg7ibayQA4OOw0T4bqXe10VCyzVFvLp9y6SowQyoEgGR6/O45dU
         g1QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LfC49QPlyZaqOrOjM8PszDB9lp1q3fneMjUdK0YaQRk=;
        fh=OWGM+hc3FLqqvyJKmuDrPh+ZS1fbr/LIuwXhZxlGmSs=;
        b=B01kPyeNdVdjcTeo3oRXcWjvJv//nSoh3r2Mc+vdsvaq3fdwCnyDb8eNtF5ENtHurm
         dIOZHJ2Jvh7u7iOCc1MVssWMYBAENxJwjeQmFwyqkAZLBqx3c7Pw10fKsNTZaKOyPhro
         f9vmnOMupWYblRMwqwQITJXQlI8XNCaPwQA6frPJ6TdNfjvyNPrnkkXT2G5Ub42bkphU
         rFOrQyo0N4RxyovCGeHpUYZAypYGxWsiDTSTN7ykwdQYupOtTWWBC3vETYTqGLkyNPZ7
         l1TC0KUHtFKJP7ieK7NH2ndUjpKY3m2DvrQyjM/AY5KoS2jiWZbnZnMPnel9OyH27Ghj
         3ysA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784576649; x=1785181449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LfC49QPlyZaqOrOjM8PszDB9lp1q3fneMjUdK0YaQRk=;
        b=e2nfbOGL+mDaBFEEf9H7l013FyU45GNQG0/EKAvbewJQD4TkNdBNPHY8vmAUWzZ+xK
         ghLA253SP5XiMitJQcxbrScyGPj3V6uiXGAeri9XUqGvompOuN4hQFGqD0LNyMKIuBwM
         S28Do4BeKf5wc4uHvgGDzdewOo7oIJRXn/BSNlKlzfq3OF4XJ6SsVSXi2YqBcIv4RMI3
         wu903KgqP7gSNcVO/hiRUwg0ZcOb9Afst5Vj3Ee5nckUhfWwbwOMoFJZQsD7Nwme291m
         I5eSGBTCUIhSqEORouQTQQqByiq7k3K4iATbq73VNz/tD7IXk9nbotHo3YfeaeesXyE2
         I9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576649; x=1785181449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfC49QPlyZaqOrOjM8PszDB9lp1q3fneMjUdK0YaQRk=;
        b=bLFAPj/izIoGZIghAvh8fjZNtPKcZ/TwwOLJzKItLUMeDy4Lieq0dpqLAkS+iWdxVi
         ZzfDbQXVbdnESx/wQph2VckmjWT7CWK7gO12Razaan0cW4otnnHrz0UFw10A6D8SCpR3
         XyCFkNdAJC8o814x6QhqqwLkOw950J5xDve7KP7ujRr39ekKSU8eI9HHB4xf0R9I0Dcp
         1uiAZ0l6fts0v57vq44zyHzAycfbj5uMky9vgov5Bv/VPzxABplXJR/WxAqJDY2FvUj1
         P6RY2CqVi57OhjdSsj4RvdqOj2DwZ5KbbLOG1z1cNATmVlujVMNPdc9+6wpNRiGJ5fE0
         4nJw==
X-Forwarded-Encrypted: i=1; AHgh+RrmZdOKVHlQquHsRz5m+N03v5TWAS1aL8TmalDrCNQtZF+M+lI+JUTcfEnzEmrrxv5eAizoI34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8i8KSzafnZKBobzW5cVFdWSxRphxitxsWNyiR9TqIq5aDvK/
	s8iCH7u9XmxO2U4cUS2of1Zs5e/N2ZBWUEJnMRw2unZc/b1tfcgYCM0OWzGyk6c1b7O5/tv6Imw
	9YdtHbjbSoYC9DBDhLoFisxxykRL60MCwN8lxw5YI
X-Gm-Gg: AfdE7cmeEnsnphafMFqz1xvW1YdO/0CN8bA3Z6cYwdU5YO91HjVtceMDVXCy3ev2/qf
	3P7qilOjy86jQV2bc1dhMxnq/S7mc+XkaAyKRWAYDx2gm4fLi8xZHIgyOD3rSA1EXYbqw4qAyBI
	/d5Zvi8Vy0DFFRdj5vxknq+eydlhOTNw6qSH5x+wYg7QUPemiR6IOYg0i+/ELALU/2FMfg0zXp+
	e6a3ycW2JJ+tb15uL1H1fOJI5gnquCDe2xlyllnNmoc7BvjZIvm58PwnJLnPjKhyAc+A7feIRvs
	1EFzub1ggNSWfHI5d9lyX/8hoY0=
X-Received: by 2002:a05:600c:3412:b0:495:5515:3c00 with SMTP id
 5b1f17b1804b1-495643961d2mr413355e9.9.1784576647864; Mon, 20 Jul 2026
 12:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719175857.4071636-1-ap420073@gmail.com> <20260719175857.4071636-3-ap420073@gmail.com>
In-Reply-To: <20260719175857.4071636-3-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 20 Jul 2026 12:43:52 -0700
X-Gm-Features: AUfX_mzh-HpiMTdTmR9Mwblg1Yg1F2-k1cGWYRzG5BMePvMor3JMM2rdb0_Pak0
Message-ID: <CAHS8izMU4gQCH2v0dcOFkjP6Sxj7RUvC8=Baet=+pFXG24qh7A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 02/13] net: devmem: extend memory provider
 for knod
To: Taehee Yoo <ap420073@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Alexei Starovoitov <ast@kernel.org>, 
	amd-gfx@lists.freedesktop.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Bill Wendling <morbo@google.com>, bpf@vger.kernel.org, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, David Airlie <airlied@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	dri-devel@lists.freedesktop.org, Eduard Zingerman <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Hoyeon Lee <hoyeon.rhee@gmail.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Leon Romanovsky <leon@kernel.org>, 
	linaro-mm-sig@lists.linaro.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rdma@vger.kernel.org, llvm@lists.linux.dev, 
	Mark Bloch <mbloch@nvidia.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Michael Chan <michael.chan@broadcom.com>, Nathan Chancellor <nathan@kernel.org>, netdev@vger.kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Shuah Khan <shuah@kernel.org>, Simona Vetter <simona@ffwll.ch>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 19, 2026 at 11:03=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> Extend the devmem memory-provider path so a knod accelerator can back a
> NIC page_pool with accelerator-exported memory (dma-buf), letting the
> NIC DMA received packets directly into accelerator memory.
>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Changes look fine in general but I do not understand in the design how
the page_pool not bound to rx queue would be used. Maybe elaborate on
the design in the commit message or cover letter in the next
iteration.

> (cherry picked from commit d511a8cb3e229f8f5cf060985880d45bd384db87)

I guess remove unintended cherry-pick tag.

> ---
>  include/net/devmem.h                    |  58 +++++++++++++
>  include/net/netmem.h                    |   9 +++
>  include/net/page_pool/memory_provider.h |   4 +
>  include/net/page_pool/types.h           |  23 +++++-
>  net/core/devmem.c                       | 103 +++++++++++++++++++-----
>  net/core/devmem.h                       |   7 +-
>  net/core/page_pool.c                    |  22 ++++-
>  7 files changed, 198 insertions(+), 28 deletions(-)
>  create mode 100644 include/net/devmem.h
>
> diff --git a/include/net/devmem.h b/include/net/devmem.h
> new file mode 100644
> index 000000000000..f1c3895d7833
> --- /dev/null
> +++ b/include/net/devmem.h

Try to keep only include/net/netmem.h and net/core/devmem.h rather
than add an include/net/devmem.h

> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Device memory TCP support
> + *
> + * Authors:    Mina Almasry <almasrymina@google.com>
> + *             Willem de Bruijn <willemb@google.com>
> + *             Kaiyuan Zhang <kaiyuanz@google.com>
> + *
> + */
> +#ifndef _NET_DEVMEM_H
> +#define _NET_DEVMEM_H
> +
> +#include <linux/dma-direction.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +struct device;
> +struct dma_buf;
> +struct dma_buf_attach_ops;
> +struct net_device;
> +struct net_devmem_dmabuf_binding;
> +struct netlink_ext_ack;
> +
> +#if defined(CONFIG_NET_DEVMEM)
> +struct net_devmem_dmabuf_binding *
> +__net_devmem_binding_create(struct net_device *dev, struct device *dma_d=
ev,
> +                           struct dma_buf *dmabuf,
> +                           enum dma_data_direction direction,
> +                           const struct dma_buf_attach_ops *importer_ops=
,
> +                           struct netlink_ext_ack *extack);
> +int net_devmem_bind_dmabuf_to_queue_direct(struct net_device *dev, u32 r=
xq_idx,
> +                                          struct net_devmem_dmabuf_bindi=
ng *binding);
> +void net_devmem_unbind_dmabuf_direct(struct net_devmem_dmabuf_binding *b=
inding);
> +#else
> +static inline struct net_devmem_dmabuf_binding *
> +__net_devmem_binding_create(struct net_device *dev, struct device *dma_d=
ev,
> +                           struct dma_buf *dmabuf,
> +                           enum dma_data_direction direction,
> +                           const struct dma_buf_attach_ops *importer_ops=
,
> +                           struct netlink_ext_ack *extack)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline int
> +net_devmem_bind_dmabuf_to_queue_direct(struct net_device *dev, u32 rxq_i=
dx,
> +                                      struct net_devmem_dmabuf_binding *=
binding)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +static inline void
> +net_devmem_unbind_dmabuf_direct(struct net_devmem_dmabuf_binding *bindin=
g)
> +{
> +}
> +#endif
> +
> +#endif /* _NET_DEVMEM_H */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index bccacd21b6c3..3ddfbd37500f 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -127,6 +127,15 @@ static inline void net_iov_init(struct net_iov *niov=
,
>         niov->type =3D type;
>  }
>
> +/* Global page index within the dma-buf, accounting for multi-chunk
> + * scatter-gather layouts where each chunk owner's niovs start at 0.
> + */
> +static inline unsigned int net_iov_binding_idx(const struct net_iov *nio=
v)
> +{
> +       return (net_iov_owner(niov)->base_virtual >> PAGE_SHIFT) +
> +              net_iov_idx(niov);
> +}
> +
>  /* netmem */
>
>  /**
> diff --git a/include/net/page_pool/memory_provider.h b/include/net/page_p=
ool/memory_provider.h
> index 255ce4cfd975..4b58a9702fb7 100644
> --- a/include/net/page_pool/memory_provider.h
> +++ b/include/net/page_pool/memory_provider.h
> @@ -23,6 +23,10 @@ bool net_mp_niov_set_dma_addr(struct net_iov *niov, dm=
a_addr_t addr);
>  void net_mp_niov_set_page_pool(struct page_pool *pool, struct net_iov *n=
iov);
>  void net_mp_niov_clear_page_pool(struct net_iov *niov);
>
> +void page_pool_provider_set_netmem(struct page_pool *pool, netmem_ref ne=
tmem,
> +                                  dma_addr_t addr);
> +void page_pool_clear_pp_info(netmem_ref netmem);
> +
>  int netif_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
>                       const struct pp_memory_provider_params *p,
>                       struct netlink_ext_ack *extack);
> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.=
h
> index 03da138722f5..3e866f249768 100644
> --- a/include/net/page_pool/types.h
> +++ b/include/net/page_pool/types.h
> @@ -31,8 +31,16 @@
>   */
>  #define PP_FLAG_ALLOW_UNREADABLE_NETMEM BIT(3)
>
> +/* Driver-managed pool with a directly-supplied memory provider, not bou=
nd to a
> + * netdev rx queue. Setting this flag requires page_pool_params.mp_ops a=
nd
> + * .mp_priv to both be set.
> + */
> +#define PP_FLAG_CUSTOM_MEMORY_PROVIDER BIT(4)
> +
>  #define PP_FLAG_ALL            (PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |=
 \
> -                                PP_FLAG_SYSTEM_POOL | PP_FLAG_ALLOW_UNRE=
ADABLE_NETMEM)
> +                                PP_FLAG_SYSTEM_POOL | \
> +                                PP_FLAG_ALLOW_UNREADABLE_NETMEM | \
> +                                PP_FLAG_CUSTOM_MEMORY_PROVIDER)
>
>  /* Index limit to stay within PP_DMA_INDEX_BITS for DMA indices */
>  #define PP_DMA_INDEX_LIMIT XA_LIMIT(1, BIT(PP_DMA_INDEX_BITS) - 1)
> @@ -54,11 +62,11 @@
>   * would have to take a slower code path.
>   */
>  #if PAGE_SIZE >=3D SZ_64K
> -#define PP_ALLOC_CACHE_REFILL  4
> +#define PP_ALLOC_CACHE_REFILL  256
>  #elif PAGE_SIZE >=3D SZ_16K
> -#define PP_ALLOC_CACHE_REFILL  16
> +#define PP_ALLOC_CACHE_REFILL  1024
>  #else
> -#define PP_ALLOC_CACHE_REFILL  64
> +#define PP_ALLOC_CACHE_REFILL  4096
>  #endif
>

I'm guessing this is just a workaround/optimization. You need a proper
change for this, maybe make it configurable arguments when creating a
pp or something.

>  #define PP_ALLOC_CACHE_SIZE    (PP_ALLOC_CACHE_REFILL * 2)
> @@ -67,6 +75,8 @@ struct pp_alloc_cache {
>         netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>  };
>
> +struct memory_provider_ops;
> +
>  /**
>   * struct page_pool_params - page pool parameters
>   * @fast:      params accessed frequently on hotpath
> @@ -83,6 +93,9 @@ struct pp_alloc_cache {
>   * @queue_idx: queue idx this page_pool is being created for.
>   * @flags:     PP_FLAG_DMA_MAP, PP_FLAG_DMA_SYNC_DEV, PP_FLAG_SYSTEM_POO=
L,
>   *             PP_FLAG_ALLOW_UNREADABLE_NETMEM.
> + * @mp_ops:    driver-supplied memory provider for a pool not bound to a
> + *             netdev rx queue (NULL to use rxq->mp_params instead)
> + * @mp_priv:   context passed to @mp_ops
>   */
>  struct page_pool_params {
>         struct_group_tagged(page_pool_params_fast, fast,
> @@ -99,6 +112,8 @@ struct page_pool_params {
>                 struct net_device *netdev;
>                 unsigned int queue_idx;
>                 unsigned int    flags;
> +               const struct memory_provider_ops *mp_ops;
> +               void *mp_priv;
>  /* private: used by test code only */
>                 void (*init_callback)(netmem_ref netmem, void *arg);
>                 void *init_arg;
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 957d6b96216b..9e21cffc9643 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -121,12 +121,9 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
>  }
>
> -void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +static void
> +net_devmem_binding_unpublish(struct net_devmem_dmabuf_binding *binding)
>  {
> -       struct netdev_rx_queue *rxq;
> -       unsigned long xa_idx;
> -       unsigned int rxq_idx;
> -
>         xa_erase(&net_devmem_dmabuf_bindings, binding->id);
>
>         /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after th=
e
> @@ -136,6 +133,15 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmab=
uf_binding *binding)
>
>         if (binding->list.next)
>                 list_del(&binding->list);
> +}
> +
> +void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +{
> +       struct netdev_rx_queue *rxq;
> +       unsigned long xa_idx;
> +       unsigned int rxq_idx;
> +
> +       net_devmem_binding_unpublish(binding);
>
>         xa_for_each(&binding->bound_rxqs, xa_idx, rxq) {
>                 const struct pp_memory_provider_params mp_params =3D {
> @@ -151,6 +157,47 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmab=
uf_binding *binding)
>         percpu_ref_kill(&binding->ref);
>  }
>
> +/* Bind/unbind variants for in-kernel offload importers that drive the r=
x
> + * queue lifecycle themselves. The mp_params are poked directly, without=
 the
> + * tcp-data-split/XDP guards or the queue reconfigure that the netlink c=
ontrol
> + * plane applies through netif_mp_open_rxq()/netif_mp_close_rxq().
> + */
> +int net_devmem_bind_dmabuf_to_queue_direct(struct net_device *dev, u32 r=
xq_idx,
> +                                          struct net_devmem_dmabuf_bindi=
ng *binding)
> +{

The LLM says in this function you need to check if the queue is
already bound to a devmem tcp memory provider.

--=20
Thanks,
Mina
