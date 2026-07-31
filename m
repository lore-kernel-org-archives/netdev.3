Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80032442FAA
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 17:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519494; cv=pass; b=fXIOFQI+nAtGkbfax82RPrGi17Fsgx92RcY/yzsb0CLyB9N+sZ0FgzptIgKWkQNJBRnR1w3VhKIXB2aS40B/7YyDz0JgQha2KK4fFB1Zp3Tl0lcjUB3oZ0zEU19uS/kTdTsB408bpdQpwtRalvGIgi4d+n/Xn2AWaXPTzgjjim0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519494; c=relaxed/simple;
	bh=8z1uncO2iPJRaVkYgA4xzh0g/jehiPBKOcONt5AmRjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsAVPHY98R7dB82SVcGY+q990FkwE9VbUvPVKhbAOQK2pZkEKC70ZDxQCuSBPwaOcHhOmsnoBn9k0yTL90S4tsfi0XNdKy3iVg7ugjYvfjriwLXc+jufr+t8G9dltAyxMe0mFX1hMgyTzOEzvAkexSllSW0qNapGOeOd0dMzsO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kIuxrt6j; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kIuxrt6j"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab97c86bdso5545ad.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 10:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785519492; cv=none;
        d=google.com; s=arc-20260327;
        b=muPvD6aQfQZ3ge76h8joNe80QulBw1hYpa2Ecv50LOZaRpwHx7WnBKP87E1rgugVGo
         rGb3vs2cx37dAR23WW76rZrDj/XViHT0M6Oku3TJegDxcPKBvC56iXrtomSKy1tvd+fE
         Lg45VE2tiCxPtSjx4PhoVaM8xD1P1WhQarTNPbMg0XCcXfO+ltYnXlISoS/xjqt1WDxC
         0HRk2Y6NtKScMzNt7inaPVhGiiaOleDlmDPjApjfUjlP5nsRtsdUv0SYQJG/2dSff1LB
         cjjPEMlf7NBkwk0Gc3QsP7cPlnZE86UpBFGr5pndkcoNgmE1YGdJNVHcr5MrCGG8DztI
         hAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oKPVUf7EVDMbHf/8PQ7nMv6+CDZsaC7bYwhGdSGtE/o=;
        fh=LxrS9yZb/n5DLENjcFyDsxBo587qdelHwNg0eyqXHtg=;
        b=Ttf9ouqxFPirVY3aYctNqIerZ3ghlqxWqVLEkBRxOxS8PDl2WmMtcs6X+NqNQQUoo/
         B+EpthsujRMX6401EhAmgiRYN+7p0ebNEfg5vhKXLcoS7quTIBx5jBoYdm5GOlyJLwet
         7BtUyhmNhXUg3YiQf8R+F2jE+rEnUOELKIT/OTpPNo7qJqw6BusCHFxGZti6UQmBylIv
         vjZnvP7uYNBE82HC+qXzpWmAq2Y/hFAi6necqxyG5xqVN+lQ95d/mBuIEtauZD6WWqm3
         yBtlu5Dg1BSProBAeBJAuYtJ3tXF/iRjqcbG0xSAojavtGR+i4YbtZFWxg2wAh7lqWxv
         AhdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785519492; x=1786124292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oKPVUf7EVDMbHf/8PQ7nMv6+CDZsaC7bYwhGdSGtE/o=;
        b=kIuxrt6jTHZLkrLsLeM5MGs8ai3JU8XQlmT4lbfgzziet8VdV3XOI4MEG9hRbQpCjV
         fHnil+/iq0Rqree9SuG0OlNqjKgXnfP6K0I/tccqyKbf02mWwbd9lDlMMTlyBDUmHOLG
         I0Q4JIGr+n0h5j5I2tyZu4ojQoI9iG+8V1twRYR6+m3TYJs0y3wD8PsLXxxhxW2BkRqU
         hjQR9MvlGFRG5rUSoRL/HUiYuEqf5Y/8G/90kEhSI1aSJArsjKgMnywSdman3U01EQS0
         TheuEILHFqAYQBkmBYi69fw2WGQegK70JmbkQKWMfZCYuPPT0tYxzNXN0+7JolVXdSr8
         XMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785519492; x=1786124292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKPVUf7EVDMbHf/8PQ7nMv6+CDZsaC7bYwhGdSGtE/o=;
        b=qQTuEfgJlDMDdBBoFDx7djOi8j/kKLZvqBZ4Ymovl3Mhj/qjz9lt5rxffKyuIfOqLF
         4bd36OchmMI/7t0wBd4aUr+3vKfZDAYRElS7M8XhZVhCTlN6AmfVF4aq1kPK33frgBsv
         Qbffq0M2B37M9dximEUFZN71+h2h3g/6fotxcHYZ9M7t28D9EjoUtEagqEkXuxbIyUt+
         1v4yp24lBmqpEL/vy1sLG/lXU1uhUhcIHq+3qGhg3VASMbU9ZDx9g9DWvRAOg4HF4t3v
         noLJap4MV3hKh3Ngdd4HRd+JXllvqu+L/eM03w9yNxDKFrvBPEagU55J4Re7NzwOClMA
         Pzmw==
X-Forwarded-Encrypted: i=1; AHgh+RpvPz7lr3ACwEbnSrlVJI4ZFfQ0jySMUoYjKiQlkNTtCw6TGLaPkBLy5NFec4POg3+Hp60Jz1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTUfHgN8CT1UyfoS8NxbnM22ms0yzJA6wrsPFawp/EVUUksF49
	oT3LT/LWspKBCRh+e7gFp5zpH7Tqdpb6O5NxE4V+j3oRVAzyiCuRZSF23IOF//6oI3yD2sY2d+K
	bSVJEB0kMcdqB/2Y2Ca5lE6DBD24SMPqI3DyCb6e9
X-Gm-Gg: AR+sD12nC/CedTlzytOBJ/PjPLBbWm+3EJsh8D5wvo1AzAlAMmi42DnFw6hildHQL+Y
	+uGUSjTlm4I4px8vpG6L7PDoGbtrmdRiveZ9j6bvKnmT0ndgJEmAJLS/9ip/qISs+/F6h53u+RD
	UYdKTePLvcTFXzQLWzrKPfVMNMa25SoOPl/T4clTtUZdFjGZql4xl4pu8mmkpxdXBPoA31VJtFa
	6Yrg8eAYEn9SiOW17p5yp14iOrcgay87BOsJPXCpf7fskTJzQK3VhOHnxOGAEFQ6uRnDGEFR7hH
	3W03an2vBnfYClcwmRb0tKqCxMbRltAP+l3O99lXnZFjvBXsTpG1UN8+asCxJ+ptcJLSUMTkh7k
	=
X-Received: by 2002:a17:903:2685:b0:2ce:b436:272a with SMTP id
 d9443c01a7336-2d05494ad4fmr249025ad.3.1785519490949; Fri, 31 Jul 2026
 10:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731111507.2355601-1-shaojijie@huawei.com>
In-Reply-To: <20260731111507.2355601-1-shaojijie@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 31 Jul 2026 10:37:58 -0700
X-Gm-Features: AUfX_mxgw25NfYWaFBOLznJYyWoUvQPTy5BDheVxee4aMCT7LUAm_Rrvjy1z3ps
Message-ID: <CAHS8izPpwz=swSXJZhnVFvTeu43WBhtRv7PmC_OQ0XzG8no8bQ@mail.gmail.com>
Subject: Re: [PATCH v4 net] net: page_pool: fix UAF in __page_pool_release_netmem_dma
 on xa_cmpxchg race
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, toke@redhat.com, shenjian15@huawei.com, 
	liuyonglong@huawei.com, chenhao418@huawei.com, yangshuaisong@h-partners.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 4:15=E2=80=AFAM Jijie Shao <shaojijie@huawei.com> w=
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
> Fix this by splitting the DMA release into two functions:
>
> 1. __page_pool_unmap_netmem_dma() caches dma_addr before xa_cmpxchg(),
>    does the cmpxchg to remove the DMA mapping, and calls dma_unmap on
>    the cached address. It never touches netmem fields after the cmpxchg,
>    making it safe for the scrub path which holds no page ref.
>
> 2. __page_pool_release_netmem_dma() wraps the above and additionally
>    clears dma_addr and DMA index bits in netmem fields. This is safe
>    only when the caller holds a page ref, so it is used by the return
>    path (page_pool_return_netmem).
>
> The scrub path calls __page_pool_unmap_netmem_dma() directly; the return
> path calls __page_pool_release_netmem_dma().
>
> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them wh=
en destroying the pool")
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Assisted-by: OhMyOpenCode:GLM-5.2
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Gemini provided no feedback and to my eye the code looks great too.

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
> Changes in v4:
> - Restructure per Mina's review: merge page_pool_remove_dma_mapping()
>   into __page_pool_unmap_netmem_dma() with dma_unmap inlined via goto
>   label; simplify __page_pool_release_netmem_dma() to a thin wrapper.
> - Link to v3: https://lore.kernel.org/r/20260729110249.2824835-1-shaojiji=
e@huawei.com
>
> Changes in v3:
> - Fix unlikely() to likely() for PP_DMA_INDEX_BITS to match
>   file convention.
> - Link to v2: https://lore.kernel.org/r/20260727132612.3277927-1-shaojiji=
e@huawei.com
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
>  net/core/page_pool.c | 46 ++++++++++++++++++++++----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 21dc4a9c8714..497bb1906fc3 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -500,29 +500,40 @@ static int page_pool_register_dma_index(struct page=
_pool *pool,
>         return err;
>  }
>
> -static int page_pool_release_dma_index(struct page_pool *pool,
> -                                      netmem_ref netmem)
> +static void __page_pool_unmap_netmem_dma(struct page_pool *pool,
> +                                        netmem_ref netmem)
>  {
>         struct page *old, *page =3D netmem_to_page(netmem);
>         unsigned long id;
> +       dma_addr_t dma;
> +
> +       if (!pool->dma_map)
> +               return;
> +
> +       /* Cache dma_addr before xa_cmpxchg. The scrub path holds no page=
 ref;
> +        * the unref path calls put_page() regardless of cmpxchg outcome,=
 so
> +        * after the cmpxchg we cannot safely touch netmem fields.
> +        */
> +       dma =3D page_pool_get_dma_addr_netmem(netmem);
>
>         if (unlikely(!PP_DMA_INDEX_BITS))
> -               return 0;
> +               goto unmap;
>
>         id =3D netmem_get_dma_index(netmem);
>         if (!id)
> -               return -1;
> +               return;
>
>         if (in_softirq())
>                 old =3D xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
>         else
>                 old =3D xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, =
0);
>         if (old !=3D page)
> -               return -1;
> -
> -       netmem_set_dma_index(netmem, 0);
> +               return;
>
> -       return 0;
> +unmap:
> +       dma_unmap_page_attrs(pool->p.dev, dma,
> +                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> +                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDER=
ING);
>  }
>
>  static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem,=
 gfp_t gfp)
> @@ -728,24 +739,13 @@ void page_pool_clear_pp_info(netmem_ref netmem)
>  static __always_inline void __page_pool_release_netmem_dma(struct page_p=
ool *pool,
>                                                            netmem_ref net=
mem)
>  {
> -       dma_addr_t dma;
> -
>         if (!pool->dma_map)
> -               /* Always account for inflight pages, even if we didn't
> -                * map them
> -                */
>                 return;
>
> -       if (page_pool_release_dma_index(pool, netmem))
> -               return;
> -
> -       dma =3D page_pool_get_dma_addr_netmem(netmem);
> -
> -       /* When page is unmapped, it cannot be returned to our pool */
> -       dma_unmap_page_attrs(pool->p.dev, dma,
> -                            PAGE_SIZE << pool->p.order, pool->p.dma_dir,
> -                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDER=
ING);
> +       __page_pool_unmap_netmem_dma(pool, netmem);
>         page_pool_set_dma_addr_netmem(netmem, 0);
> +       if (likely(PP_DMA_INDEX_BITS))
> +               netmem_set_dma_index(netmem, 0);

I now notice that maybe another cleanup we could have done is open
code __page_pool_unmap_netmem_dma() in this function to cut down 1
helper, and just have the scrub function call
__page_pool_release_netmem_dma() to reduce some code. But this is more
than fine too I think, especially since this is a fix the stable trees
are going to want I guess.

--=20
Thanks,
Mina
