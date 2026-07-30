Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516E24457A2
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433198; cv=pass; b=U6WPzLvCjYzaWsKL7L+yHoZuS9z3a+b5jPp1z2ovgHi8SDeDJqnBfbi99yDvHK3fRRbEgyurcvd+p/vUQrB8kdl1oYUbCEDO4JV3ELB+XGjGjuA2ntfpdduOFAV/B3rv2d+cQkBHyoOw9VLlMepE6tY+ftDTWLmCo+POWQs4hOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433198; c=relaxed/simple;
	bh=SRO3PzomlEz4RrjsomyQ5KEbKepdpTjxVU7bUlqWMN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bH1WiNVqXIcFVgVQiph0IkvmYl5BkDNi6dHOO7O0UEwUhhOyCxI6hzYyLRxp789rGzMfqka/jKvSbwsg3ORtx2z1UgjwKxYWttV6l4QnHVshGmgmo4xFONAUpk8Eh+aYUf2HBZJZKe18MUpCB2NJiJzfQS7GW6SSfn8R8IcTZ/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBUaBhZI; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBUaBhZI"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cacef7d299so10225ad.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:39:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785433195; cv=none;
        d=google.com; s=arc-20260327;
        b=Jdsokw9mK2mj2NSPxaGglWuuutxUC73Emwh7GZ85oslxUNTEnfL3QxF+xW4EN2AfWO
         SZJaP5Ydp7dvuDrqTe5wo7O3Nr5izv2/kTQMw9MCa225dg5PWBqeKEvH0itx3xJKC7KT
         P1eiJY67QjE1xCTBE/N7cLS83rjdrbpYL6Uqjwt9CUQcz3bBeFLuqCMkFpik1+G+rkOL
         HSR/7XQlbfIcNuIGOF81Jt++LjizpEzJLLrS7Olazfs43ppluMWCL7c3loYTJpElb9Rk
         o5PRHXV4CzT9ehM3TWQVUNkoOdgu9ilP2PlXkxIP5uWOrPYAb9ySnbG467D9Px5ZVHnE
         rBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=su7OYTPvLx0XiCkoqBX8Z6gtbnnhWtzOBsMZd6ZqzAY=;
        fh=LXrj0Ykirfyh4hAvYnNzGFZTXI+kZpFGEyNja3xnsR4=;
        b=Jc0S2DoHw+i9Xx5H2gKGaxBEYNW2FlfZRmNwK22UjytvAT+R4FrmdeXc8vIatsTOKP
         k5ocWHngbdXT/kdCRe7+843ZgljdrAwNnqV+U28s87kFbi/okkWNTP7cslp5RxHzby7e
         IiCvMkckOuy767TDITcftSk31CvVtIONZ6cYM+sv28EoZn+0kjc7DRmyYvkZTdWqANHX
         IY8UjCneGxWlaFM0pDExVMk0SfDodtYQeqyA1oYAURqrMRFGDpqC3HCUVRSedZgBFnsD
         O6ee/3psDrD17gW4nRkypNfZqFx0I7q6SNZB6vMlFsOx+WWsAhMnzMrvyFTGhOPt/jQ+
         /i+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785433195; x=1786037995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=su7OYTPvLx0XiCkoqBX8Z6gtbnnhWtzOBsMZd6ZqzAY=;
        b=cBUaBhZIIC1/XAgE5KlKpzkvcywgm/0fkipvTSLS85A08sx2/HwQEHIR0bDmrpm7b3
         Sy4oXMPpADTc57EI5L1VRHuzXeTfj6c0ReH3BcNi7a/vtWAUZdEnl+b6cMBRlL1M8DIo
         lBVmh1MwRGdcRyv35azg8mm/1exog0NieX8zYP/Kzfxh+1otGBKYcEpPBKS8Gfrg8aSm
         Ie2KaYMJLX7hAJYpTr3/3pDcfHNtKywSv2QntHS1x6+gIW3CTLc1hpEs8wl6IkFy40EO
         pe5S6uO7IJpi/rqNHzZrkPc8SYiTjH0iaMyeBRwv82qlHrypxJ/JTWHRyneaOIQpay2Z
         1gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433195; x=1786037995;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=su7OYTPvLx0XiCkoqBX8Z6gtbnnhWtzOBsMZd6ZqzAY=;
        b=aJh5z0N8NWAZ16LiIT8puVSHI1drmFAap37PPn/xXZ+3UyEMsrnU+N3PAgLMIqDMza
         n9TTflnD3Ros+evfz+ZXTO/ANqIau2DSBFI3iTh7YBGlLlCmkltJidUh9RAbFd6Eoof3
         0QDc/YLvlwgGpA1sqBcRSIE14T6A5CkAC1xhjEfxomHlDoJeNFyanWw/BPzwsaeUui6B
         2hYyBKssvXf8VXokFejhLz0PCl3xJ1X9GtTalOpjGPcafgMI64KCxH2vCLTif7T7RWXe
         3zpL2SHsaJEahbDjZVSLdEZ686kALfGaZiwBlqE8TdAj9SftRcH1m/QF3cIo7sjfSD2/
         5ALw==
X-Forwarded-Encrypted: i=1; AHgh+RrC6uKCKCbe8vpwsL0GhpUWE2OPbmtZLqSSvHrlajNqIk3x90JvHTmi9+pnj8KlXRGP/1ZY8CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTGBr5lim6RD6oDxb0x1TZsm7xNUOg63KqJa2q/p3nlqDCLuTs
	DtEpxYrGUGLrSTujeKR3EWCPY8ztgeObDNxcJuL+KslbKNQ795y/7AsqhM+syjtZPPnyqZmqVqH
	3lv3ITi9Z+0RIGwCwyW8xaaNogCRQ1owj1KS0voKj
X-Gm-Gg: AR+sD13SOaq1b+gMh+wFepDID0AJIfvt0ZzJ2GhWLLlzBSkK5fA+0l+BcbxYxhZkdtA
	xKIuhz1pXbm26sQM9f4LVk2LU4cWQvm3QUWtZEDVXwUDboXyneVT0RP0+kHsVVfTkNuP6zUu5Ns
	phhqYe2BynpTrLm0b8KuIDlxGVZBH4rpaPl1RN4rljInBWxv3QlzA/NW8xuuLnuK57BO4LROunU
	FIYi/k5VxDd4CYFfpIfxKrCXz8vDUy1ToLhgtA4PFL42UqcfAHtT1OJCxp0j1FIgPbTXKxasxHG
	w7QP6gB88QOxHlgXQyIWlwFxss9jmV6GWg5YrtDHUCNC46sl0WRLUkD0m4rAsUzQUjed/GLHuPI
	=
X-Received: by 2002:a17:903:114:b0:2ca:e0ff:eaa0 with SMTP id
 d9443c01a7336-2d04113b525mr549905ad.2.1785433194468; Thu, 30 Jul 2026
 10:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729110249.2824835-1-shaojijie@huawei.com>
 <CAHS8izO+kiugW_qN-US+S88ypDnaEePP+-78vnVOfBtb8P0AKg@mail.gmail.com> <0d98a4d1-fad2-4539-b40d-58ea58cacff7@huawei.com>
In-Reply-To: <0d98a4d1-fad2-4539-b40d-58ea58cacff7@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 30 Jul 2026 10:39:41 -0700
X-Gm-Features: AUfX_myujHH29f1OiqpcRaL90oD-1hlUlEVneKFZsXzw225G7d9z1efEkzg0v-8
Message-ID: <CAHS8izMfLhxzT5c+P-m2tV4sb0r7_ePLDYrej00jXk3JaiYxFg@mail.gmail.com>
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

On Thu, Jul 30, 2026 at 2:21=E2=80=AFAM Jijie Shao <shaojijie@huawei.com> w=
rote:
>
>
> on 2026/7/30 6:35, Mina Almasry wrote:
> > On Wed, Jul 29, 2026 at 4:03=E2=80=AFAM Jijie Shao <shaojijie@huawei.co=
m> wrote:
> >> page_pool_scrub() iterates pool->dma_mapped via xa_for_each() with no
> >> page ref held. __page_pool_release_netmem_dma() currently reads and
> >> writes netmem fields (dma_addr, DMA index bits in pp_magic) after
> >> xa_cmpxchg() returns. The unref path calls put_page() unconditionally
> >> regardless of the cmpxchg outcome; when it loses the cmpxchg, it still
> >> frees the page before the scrub winner finishes these netmem accesses,
> >> so scrub touches a freed page -- a Use-After-Free.
> >>
> >> Fix this by:
> >>
> >> 1. Cache dma_addr to a local variable before xa_cmpxchg() in
> >>     __page_pool_release_netmem_dma(), so the scrub winner uses the
> >>     cached address for dma_unmap and never touches netmem fields after
> >>     the cmpxchg.
> >>
> >> 2. Rename page_pool_release_dma_index() to page_pool_remove_dma_mappin=
g()
> >>     and strip it down to a pure cmpxchg wrapper; it no longer clears D=
MA
> >>     index bits.
> >>
> >> 3. Move dma_addr and DMA index cleanup to page_pool_return_netmem(),
> >>     which holds a page ref and can safely write netmem fields regardle=
ss
> >>     of the cmpxchg outcome.
> >>
> >> The scrub path (no ref) only does cmpxchg + dma_unmap on the cached
> >> address; the unref path (holds ref) clears dma_addr and DMA index bits
> >> unconditionally before put_page().
> >>
> >> Suggested-by: Mina Almasry <almasrymina@google.com>
> > Thanks for trying to give credit but I didn't do much but feed your
> > earlier iteration to gemini. I don't mind either way but you can
> > remove.
> >
> >> Fixes: ee62ce7a1d90 ("page_pool: Track DMA-mapped pages and unmap them=
 when destroying the pool")
> >> Assisted-by: OhMyOpenCode:GLM-5.2
> > I fed this to gemini and I got good feedback, but it needs improved
> > human readability.
> >
> >> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> >> ---
> >> Changes in v3:
> >> - Fix unlikely() to likely() for PP_DMA_INDEX_BITS to match
> >>    file convention.
> >> Link to v2: https://lore.kernel.org/r/20260727132612.3277927-1-shaojij=
ie@huawei.com
> >>
> >> Changes in v2:
> >> - Redesign the fix per Mina's review: v1's unconditional
> >>    netmem_set_dma_index() introduced a UAF when the scrub path
> >>    (no page ref) writes to a page freed by the unref path.
> >> - Cache dma_addr before xa_cmpxchg; move dma_addr/DMA index
> >>    cleanup to page_pool_return_netmem() which holds a page ref.
> >> - Rename page_pool_release_dma_index() to
> >>    page_pool_remove_dma_mapping() to reflect its new role as a
> >>    pure cmpxchg wrapper.
> >> - Link to v1: https://lore.kernel.org/r/20260724092135.414699-1-shaoji=
jie@huawei.com
> >> ---
> >>   net/core/page_pool.c | 33 +++++++++++++++++++--------------
> >>   1 file changed, 19 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> >> index 21dc4a9c8714..b7f5cdb6c1c4 100644
> >> --- a/net/core/page_pool.c
> >> +++ b/net/core/page_pool.c
> >> @@ -500,8 +500,8 @@ static int page_pool_register_dma_index(struct pag=
e_pool *pool,
> >>          return err;
> >>   }
> >>
> >> -static int page_pool_release_dma_index(struct page_pool *pool,
> >> -                                      netmem_ref netmem)
> >> +static int page_pool_remove_dma_mapping(struct page_pool *pool,
> >> +                                       netmem_ref netmem)
> > Not a readable name. IDK what 'removing dma mapping' means. It's not
> > doing an unmap in the current iteration. Pick a new human-readable
> > name based on the changes below:
> >
> >>   {
> >>          struct page *old, *page =3D netmem_to_page(netmem);
> >>          unsigned long id;
> >> @@ -517,12 +517,7 @@ static int page_pool_release_dma_index(struct pag=
e_pool *pool,
> >>                  old =3D xa_cmpxchg(&pool->dma_mapped, id, page, NULL,=
 0);
> >>          else
> >>                  old =3D xa_cmpxchg_bh(&pool->dma_mapped, id, page, NU=
LL, 0);
> >> -       if (old !=3D page)
> >> -               return -1;
> >> -
> >> -       netmem_set_dma_index(netmem, 0);
> >> -
> >> -       return 0;
> >> +       return (old =3D=3D page) ? 0 : -1;
> > This function, AFAICT, has only 1 call site where this return value
> > decides whether to dma_unmap_page_attr. That's not easy for a human to
> > follow. Just put the dma_unmap_page_attrs in this function.
> >
> > I asked gemini to apply my feedback and it gave me this (untested)
> > patch. Consider reviewing this one and putting it through your
> > testing/etc. Please review the comments around the code. Some look
> > outdated? It's untested:
> >
> > ```
> > net/core/page_pool.c
> > index 21dc4a9c8714d..628854b56315b 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -500,29 +500,34 @@ static int page_pool_register_dma_index(struct
> > page_pool *pool,
> >          return err;
> >   }
> >
> > -static int page_pool_release_dma_index(struct page_pool *pool,
> > +static void page_pool_release_dma_index(struct page_pool *pool,
> >                                         netmem_ref netmem)
> >   {
> >          struct page *old, *page =3D netmem_to_page(netmem);
> >          unsigned long id;
> > +       dma_addr_t dma;
> > +
> > +       dma =3D page_pool_get_dma_addr_netmem(netmem);
> >
> >          if (unlikely(!PP_DMA_INDEX_BITS))
> > -               return 0;
> > +               goto unmap;
> >
> >          id =3D netmem_get_dma_index(netmem);
> >          if (!id)
> > -               return -1;
> > +               return;
> >
> >          if (in_softirq())
> >                  old =3D xa_cmpxchg(&pool->dma_mapped, id, page, NULL, =
0);
> >          else
> >                  old =3D xa_cmpxchg_bh(&pool->dma_mapped, id, page, NUL=
L, 0);
> > -       if (old !=3D page)
> > -               return -1;
> >
> > -       netmem_set_dma_index(netmem, 0);
> > +       if (old !=3D page)
> > +               return;
> >
> > -       return 0;
> > +unmap:
> > +       dma_unmap_page_attrs(pool->p.dev, dma,
> > +                            PAGE_SIZE << pool->p.order, pool->p.dma_di=
r,
> > +                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORD=
ERING);
> >   }
> >
> >   static bool page_pool_dma_map(struct page_pool *pool, netmem_ref
> > netmem, gfp_t gfp)
> > @@ -728,24 +733,13 @@ void page_pool_clear_pp_info(netmem_ref netmem)
> >   static __always_inline void __page_pool_release_netmem_dma(struct
> > page_pool *pool,
> >                                                             netmem_ref =
netmem)
> >   {
> > -       dma_addr_t dma;
> > -
> >          if (!pool->dma_map)
> >                  /* Always account for inflight pages, even if we didn'=
t
> >                   * map them
> >                   */
> >                  return;
> >
> > -       if (page_pool_release_dma_index(pool, netmem))
> > -               return;
> > -
> > -       dma =3D page_pool_get_dma_addr_netmem(netmem);
> > -
> > -       /* When page is unmapped, it cannot be returned to our pool */
> > -       dma_unmap_page_attrs(pool->p.dev, dma,
> > -                            PAGE_SIZE << pool->p.order, pool->p.dma_di=
r,
> > -                            DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORD=
ERING);
> > -       page_pool_set_dma_addr_netmem(netmem, 0);
> > +       page_pool_release_dma_index(pool, netmem);
> >   }
> >
> >   /* Disconnects a page (from a page_pool).  API users can have a need
> > @@ -759,10 +753,17 @@ static void page_pool_return_netmem(struct
> > page_pool *pool, netmem_ref netmem)
> >          bool put;
> >
> >          put =3D true;
> > -       if (static_branch_unlikely(&page_pool_mem_providers) && pool->m=
p_ops)
> > +       if (static_branch_unlikely(&page_pool_mem_providers) && pool->m=
p_ops) {
> >                  put =3D pool->mp_ops->release_netmem(pool, netmem);
> > -       else
> > +       } else {
> >                  __page_pool_release_netmem_dma(pool, netmem);
> > +               /* clear dma_addr/DMA index; safe because we hold a ref=
 */
> > +               if (pool->dma_map) {
> > +                       page_pool_set_dma_addr_netmem(netmem, 0);
> > +                       if (likely(PP_DMA_INDEX_BITS))
> > +                               netmem_set_dma_index(netmem, 0);
> > +               }
> > +       }
> >
> >          /* This may be the last page returned, releasing the pool, so
> >           * it is not safe to reference pool afterwards.
> > ```
> >
>
> Hi Mina,
>
> Thanks for the review! I restructured the fix as follows =E2=80=94 is thi=
s
> roughly what you had in mind?
>
> Split into two functions. __page_pool_unmap_netmem_dma() does cmpxchg +
> dma_unmap only, with dma_unmap inlined via a goto label. It caches
> dma_addr before the cmpxchg and never touches netmem fields after, so
> it is safe for the scrub path which holds no page ref:
>
> static __always_inline void __page_pool_unmap_netmem_dma(struct page_pool=
 *pool,
>                                                          netmem_ref netme=
m)
> {
>         struct page *old, *page =3D netmem_to_page(netmem);
>         unsigned long id;
>         dma_addr_t dma;
>
>         if (!pool->dma_map)
>                 return;
>
>         dma =3D page_pool_get_dma_addr_netmem(netmem);
>
>         if (unlikely(!PP_DMA_INDEX_BITS))
>                 goto unmap;
>
>         id =3D netmem_get_dma_index(netmem);
>         if (!id)
>                 return;
>
>         if (in_softirq())
>                 old =3D xa_cmpxchg(&pool->dma_mapped, id, page, NULL, 0);
>         else
>                 old =3D xa_cmpxchg_bh(&pool->dma_mapped, id, page, NULL, =
0);
>         if (old !=3D page)
>                 return;
>
> unmap:
>         dma_unmap_page_attrs(pool->p.dev, dma,
>                              PAGE_SIZE << pool->p.order, pool->p.dma_dir,
>                              DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_WEAK_ORDER=
ING);
> }
>
> __page_pool_release_netmem_dma() is now a thin wrapper that calls the
> above and clears dma_addr/DMA index bits =E2=80=94 safe because the calle=
r
> holds a page ref:
>
> static __always_inline void __page_pool_release_netmem_dma(struct page_po=
ol *pool,
>                                                            netmem_ref net=
mem)
> {
>         if (!pool->dma_map)
>                 return;
>
>         __page_pool_unmap_netmem_dma(pool, netmem);
>         page_pool_set_dma_addr_netmem(netmem, 0);
>         if (likely(PP_DMA_INDEX_BITS))
>                 netmem_set_dma_index(netmem, 0);
> }
>
> Scrub path calls __page_pool_unmap_netmem_dma() directly:
>
>         xa_for_each(&pool->dma_mapped, id, ptr)
>                 __page_pool_unmap_netmem_dma(pool, page_to_netmem((struct=
 page *)ptr));
>

Seems roughly about right maybe. Please submit another iteration and
I'll take a detailed look. Thanks for the fix and your patience :-)

--=20
Thanks,
Mina
