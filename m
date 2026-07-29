Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088C33F12E2
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364541; cv=pass; b=eLwPgdfI01Tahd/ii7TM8ET28D57oeZvYxS1N+QdgLYWgMQ58DgU+Fr5sR3Rmjg3+VvNORxAlYS0sa4EZ0RiTfkaGkuM8/hu0sjZM2zIISbt+0sbwzildzh4hvkvn9B55igRWBVrnJ/FodTjr9fV2v6sNLfS+KuZ9ZYwNHLsxbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364541; c=relaxed/simple;
	bh=/px7XPzxM80fwnJlMNzLMSv1QSD5qCUbxnVvSmNHIXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrHkWgkNXJhyd5XyR84WUQWK/TpTRvds0gluibAzUEhd/yhvJHrSmOS8FIq4iEkuSvmDogh+jEd6qbfkGprRoQn3oIRB7qnCG96hh4r/VsGAum1kstXisaSvPqAqSTQbT95G3s/lhUyaTXYOEPRvmFjppLFyqnQm3bkP5XU5L/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+4Po+c3; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+4Po+c3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cacef7d299so24835ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785364536; cv=none;
        d=google.com; s=arc-20260327;
        b=TuyrzrZgGqSTODdGwtHZ7mJ1D9upzYVYWb6JsqJ+tP43jF1qDNPfL/3Sry2S16czhy
         VQiXbZ9EylfnRvR97SJXlmFqLlOBvhnLxO9YVO1OYjA57THuqOM3UlvNnD0Aszr2CyA/
         zDogDyNeAWC9l4ZkqvYZ1+dzaGjUG8nenrVBpjJc25QxZfdnyvfp6yCR0IyhnePSClYd
         nGRqPf0TGetdFtiLCe7AIil78Q94gyuNaa8dMvESBmXpvCDugQ+cFfdSnmkINjZoPwNk
         UsIMiTHo/kn59sjRAmig3i84QX4Hcq3rBxH7RnLlLaYLDaw04kP68EpcBRucVXmEw69E
         7HBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sAFbqSnTjVvDd7N/ufRBA5YIGxJ6su1eptQYO4lk4FE=;
        fh=9y1NxAgXdJkYK2hlJg9i6zB1zKBLcR3xnQdz2BZaNwY=;
        b=jiWpBa1U64DkRIwgo7yNB0he+VJkLvUVLNobnKYTwGSbNKwKxieC1iFoJHut6a3890
         VBMAdBHs6aTuYVibtY9D1INtn6mt9xTXFqGsRpWEjaNf7tPHLuLkjbg0GNQ1TjyxmcEb
         C0OYZZCl3wAKqt/mJAivEfZOSY0OdCg7PZgFTkHlubHbbozWJDOqHODTq+UM9OEGsFpb
         +UzCWXLP6qK85SgtLik8HYWIeuwGLewz/mrdnMwbUlWHKlvNvmrWeQ8XMGB0wWq5bOXE
         rlzL7NbGMx/HyJhzRitNwECh10487FAThUTUyI+BNDZUD7989flN3H6E1Oq1GVbfykrL
         GIhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785364536; x=1785969336; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAFbqSnTjVvDd7N/ufRBA5YIGxJ6su1eptQYO4lk4FE=;
        b=N+4Po+c3TRrDB0DpReGH+upFs71lYD0L9IGfnNrES/rbUb3f9SurSActxhfPRHwyEy
         bc7o8MIE26t0m8+TkuEQWmTtKjuASu8HT/fFS3zXg3vMY0vbf5uwNs9KOYvmKZCX9uKG
         eYhC+Qr57xsxpuykLC5Jew5N4C7M0cDNuaZZdzpyHwt4YWel2kRjoKcL3F9Cqus5X7NN
         mhD4AIHNt5XVyP5EfL0nEtjuMv1Qge54Evt059PbdUlKyEndVbuIXi+ArafI1/ggcG56
         E6RYS61MPMPSDC4sVt0eViIG+Ta9bIgEu1oSCtYPMZw/+kgbDxowxU4VWmtXs/SOSvFu
         nHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364536; x=1785969336;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAFbqSnTjVvDd7N/ufRBA5YIGxJ6su1eptQYO4lk4FE=;
        b=pcif2hEqUbFyLgTdKfsfDlacPyZu93plZraBHsP2683VIe7tZos7GM/BpfhC/LYEMe
         u8Bw+3XKBWAIfBUdsTDt2aiBtCnWPOVC6pf66auqOMgV3fcI5yYogbINygP7d61v+HMS
         M5IVi1Tg62ZhLD0+fH++C2LOVCkmu5wKrcxUWnWVFb3IrCO5Ux3A5eugBE22q1KXaxGv
         TaxIpaQZBTMRH7KvT9FmKIJTOdl+KGJOk22obEIkiSirMo3onzd2/RGR00cu9t4m+bdz
         ULazmjkdGYGN6a8wiEbIsF72hHNWepBFvAmEsxRKeh6Cuhf80RFZe23drCBPMFt3jYDP
         4bHQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvRMTmIU4qijRjx6X57wPxKwFwb0+RIBIJO490a4XYFshExXI2K/+KHLAdl0E/OYs1xtL2FGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7y7zWfOBGSKF1xou7BqrB+6d9vOTopgLCMpdfQXPB64SXzlIi
	IzZBvLNnqt0CYRRqi7m3M18Ebn8XRGQGhuFEdOh39ej1KF6LVXgEaHWAQ1vWw6w5EPLC3MKrLcw
	0teZhRyBH5PpkCUGVrsVnv2JTgNhGVmcc9iOx5AGT
X-Gm-Gg: AR+sD12ZyJG3C9p3miIYvi8Q/AQtgwtL/WaMVmHU1r8X2qim9UkCHFH3nD6b+Ufjwyp
	psbw47+g+m73RMrRYtKmBp89oTfwOYc8yUuQt0kj7PS+16s/6ngWw+NMje6gRrPBLTBn+bOeugz
	Po5q7U6cX36CmHYZcdqbCcMdxxWAhsZrrnWVTEp/k4FCMn8pe38oxd00dvHqtU5J5xlyEDx7C74
	Nn7qwgPV05GGJcibPFXARaYL/BFLTciSg3PagTxORqiHfoklITaYs2cckLVr/CGrQkde09vDfVQ
	QDCCzyF6nsCNYFBC3BetlyRw4v2oOlUvk02vmJFpuhoG9gzLbGvSLWbesaHrcFVAMSjsf2Sd8A/
	XTktMKoVucQ==
X-Received: by 2002:a17:903:903:b0:2c7:9e6a:1a8d with SMTP id
 d9443c01a7336-2d035e66bb7mr853815ad.12.1785364535618; Wed, 29 Jul 2026
 15:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729110249.2824835-1-shaojijie@huawei.com>
In-Reply-To: <20260729110249.2824835-1-shaojijie@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 29 Jul 2026 15:35:22 -0700
X-Gm-Features: AUfX_myAyvLvTtKrC4G2AGeQA9myyGoioUK2CwKoGB7ho5rUUkk4YKFRtaphEnQ
Message-ID: <CAHS8izO+kiugW_qN-US+S88ypDnaEePP+-78vnVOfBtb8P0AKg@mail.gmail.com>
Subject: Re: [PATCH v3 net] net: page_pool: fix UAF in __page_pool_release_netmem_dma
 on xa_cmpxchg race
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, toke@redhat.com, shenjian15@huawei.com, 
	liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 4:03=E2=80=AFAM Jijie Shao <shaojijie@huawei.com> w=
rote:
>
> page_pool_scrub() iterates pool->dma_mapped via xa_for_each() with no
> page ref held. __page_pool_release_netmem_dma() currently reads and
> writes netmem fields (dma_addr, DMA index bits in pp_magic) after
> xa_cmpxchg() returns. The unref path calls put_page() unconditionally
> regardless of the cmpxchg outcome; when it loses the cmpxchg, it still
> frees the page before the scrub winner finishes these netmem accesses,
> so scrub touches a freed page -- a Use-After-Free.
>
> Fix this by:
>
> 1. Cache dma_addr to a local variable before xa_cmpxchg() in
>    __page_pool_release_netmem_dma(), so the scrub winner uses the
>    cached address for dma_unmap and never touches netmem fields after
>    the cmpxchg.
>
> 2. Rename page_pool_release_dma_index() to page_pool_remove_dma_mapping()
>    and strip it down to a pure cmpxchg wrapper; it no longer clears DMA
>    index bits.
>
> 3. Move dma_addr and DMA index cleanup to page_pool_return_netmem(),
>    which holds a page ref and can safely write netmem fields regardless
>    of the cmpxchg outcome.
>
> The scrub path (no ref) only does cmpxchg + dma_unmap on the cached
> address; the unref path (holds ref) clears dma_addr and DMA index bits
> unconditionally before put_page().
>
> Suggested-by: Mina Almasry <almasrymina@google.com>

Thanks for trying to give credit but I didn't do much but feed your
earlier iteration to gemini. I don't mind either way but you can
remove.

> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them wh=
en destroying the pool")
> Assisted-by: OhMyOpenCode:GLM-5.2

I fed this to gemini and I got good feedback, but it needs improved
human readability.

> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> Changes in v3:
> - Fix unlikely() to likely() for PP_DMA_INDEX_BITS to match
>   file convention.
> Link to v2: https://lore.kernel.org/r/20260727132612.3277927-1-shaojijie@=
huawei.com
>
> Changes in v2:
> - Redesign the fix per Mina's review: v1's unconditional
>   netmem_set_dma_index() introduced a UAF when the scrub path
>   (no page ref) writes to a page freed by the unref path.
> - Cache dma_addr before xa_cmpxchg; move dma_addr/DMA index
>   cleanup to page_pool_return_netmem() which holds a page ref.
> - Rename page_pool_release_dma_index() to
>   page_pool_remove_dma_mapping() to reflect its new role as a
>   pure cmpxchg wrapper.
> - Link to v1: https://lore.kernel.org/r/20260724092135.414699-1-shaojijie=
@huawei.com
> ---
>  net/core/page_pool.c | 33 +++++++++++++++++++--------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 21dc4a9c8714..b7f5cdb6c1c4 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -500,8 +500,8 @@ static int page_pool_register_dma_index(struct page_p=
ool *pool,
>         return err;
>  }
>
> -static int page_pool_release_dma_index(struct page_pool *pool,
> -                                      netmem_ref netmem)
> +static int page_pool_remove_dma_mapping(struct page_pool *pool,
> +                                       netmem_ref netmem)

Not a readable name. IDK what 'removing dma mapping' means. It's not
doing an unmap in the current iteration. Pick a new human-readable
name based on the changes below:

>  {
>         struct page *old, *page =3D netmem_to_page(netmem);
>         unsigned long id;
> @@ -517,12 +517,7 @@ static int page_pool_release_dma_index(struct page_p=
ool *pool,
>                 old =3D xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
>         else
>                 old =3D xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, =
0);
> -       if (old !=3D page)
> -               return -1;
> -
> -       netmem_set_dma_index(netmem, 0);
> -
> -       return 0;
> +       return (old =3D=3D page) ? 0 : -1;

This function, AFAICT, has only 1 call site where this return value
decides whether to dma_unmap_page_attr. That's not easy for a human to
follow. Just put the dma_unmap_page_attrs in this function.

I asked gemini to apply my feedback and it gave me this (untested)
patch. Consider reviewing this one and putting it through your
testing/etc. Please review the comments around the code. Some look
outdated? It's untested:

```
net/core/page_pool.c
index 21dc4a9c8714d..628854b56315b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -500,29 +500,34 @@ static int page_pool_register_dma_index(struct
page_pool *pool,
        return err;
 }

-static int page_pool_release_dma_index(struct page_pool *pool,
+static void page_pool_release_dma_index(struct page_pool *pool,
                                       netmem_ref netmem)
 {
        struct page *old, *page =3D netmem_to_page(netmem);
        unsigned long id;
+       dma_addr_t dma;
+
+       dma =3D page_pool_get_dma_addr_netmem(netmem);

        if (unlikely(!PP_DMA_INDEX_BITS))
-               return 0;
+               goto unmap;

        id =3D netmem_get_dma_index(netmem);
        if (!id)
-               return -1;
+               return;

        if (in_softirq())
                old =3D xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
        else
                old =3D xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, 0)=
;
-       if (old !=3D page)
-               return -1;

-       netmem_set_dma_index(netmem, 0);
+       if (old !=3D page)
+               return;

-       return 0;
+unmap:
+       dma_unmap_page_attrs(pool->p.dev, dma,
+                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
+                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERIN=
G);
 }

 static bool page_pool_dma_map(struct page_pool *pool, netmem_ref
netmem, gfp_t gfp)
@@ -728,24 +733,13 @@ void page_pool_clear_pp_info(netmem_ref netmem)
 static __always_inline void __page_pool_release_netmem_dma(struct
page_pool *pool,
                                                           netmem_ref netme=
m)
 {
-       dma_addr_t dma;
-
        if (!pool->dma_map)
                /* Always account for inflight pages, even if we didn't
                 * map them
                 */
                return;

-       if (page_pool_release_dma_index(pool, netmem))
-               return;
-
-       dma =3D page_pool_get_dma_addr_netmem(netmem);
-
-       /* When page is unmapped, it cannot be returned to our pool */
-       dma_unmap_page_attrs(pool->p.dev, dma,
-                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
-                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDERIN=
G);
-       page_pool_set_dma_addr_netmem(netmem, 0);
+       page_pool_release_dma_index(pool, netmem);
 }

 /* Disconnects a page (from a page_pool).  API users can have a need
@@ -759,10 +753,17 @@ static void page_pool_return_netmem(struct
page_pool *pool, netmem_ref netmem)
        bool put;

        put =3D true;
-       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_op=
s)
+       if (static_branch_unlikely(&page_pool_mem_providers) && pool->mp_op=
s) {
                put =3D pool->mp_ops->release_netmem(pool, netmem);
-       else
+       } else {
                __page_pool_release_netmem_dma(pool, netmem);
+               /* clear dma_addr/DMA index; safe because we hold a ref */
+               if (pool->dma_map) {
+                       page_pool_set_dma_addr_netmem(netmem, 0);
+                       if (likely(PP_DMA_INDEX_BITS))
+                               netmem_set_dma_index(netmem, 0);
+               }
+       }

        /* This may be the last page returned, releasing the pool, so
         * it is not safe to reference pool afterwards.
```



--=20
Thanks,
Mina
