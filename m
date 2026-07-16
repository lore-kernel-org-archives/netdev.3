Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9F3C10A0
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784199412; cv=pass; b=HfIrOWdfw4OsKXd/cf3ksXoZPRCgMiYNoBU61mbWIhXkbr2RupOgEXx12K7T7DHEab/0arI1D61UAE5ShoAozVryraqCHB0I32BM2pgY+PqZJUZvZfFD0GtZNZ4fD2INAlp9yw2lYmfmIE6WXj66UAscjzhD7AivypElJvYss4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784199412; c=relaxed/simple;
	bh=srL+cMZ1i8YbUEmu2TLX2hhU2kykZPNHq92qtJXugo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJ6sWeFAHx67EUBMTW2bjzg19o7NDxEECW0sJRQeoPOB8pstIg1ptX5gzuHW9BD5jBVNHSMSZwoyUQh8PS/ZH/GIyNyGr5A3uwZRgmxD/LlrJR13+C6YOAZwnn3zm4kDOX0sM9hVaSSPQY+/BuhRDQS9pbdqj45ArEbMesp7NaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRw4Iwtb; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRw4Iwtb"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aec201b582so6344242e87.1
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 03:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784199409; cv=none;
        d=google.com; s=arc-20260327;
        b=lms6Q03etjMmLU/LnfYAa3vU3zHHe17Ms4xWK8Wuy6sirLdeXl/EI5n93h4pGWS894
         YgTOid2MYSzzqYl4wq6Uay+O3l5hzpYiP7gEECm+Gf0R5O8ZF8Ir/vYoYiNWfOxq7X0V
         pXPbiXy3psvCcUGJgw0B80q6Qcm4JDab9KTyZM/jjKPTj7ZZ9bzIq/M9R6CgBg1v8i3B
         yuH+D+K9xseB/esQpLLZQqjYJZpynrm23RvJuK7XIrtGPHNWhv1AWyzJtF0h1tvH10GU
         wi6b5haRz8UDzn7WIz0xPI0EGXTO6X3DQ2MvX77jpf9XFil3I8w4f6I8UTEp/kngLRcM
         jPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tp7+ky3jAc/0xnKfAUPh02vFiCwKWR3+WZ4dapoaCZg=;
        fh=JI3h9u+zcTfgqfsrvii+M2LwYW6m91hHHyR7PjAVQZI=;
        b=bQlvmIvkqFEXdzh27T/aCEuU/9DAX1xTMjqupYnxU6kWzk9iRFVvWZvTsjUf1Xk6u1
         XRQTq/aFSkwxHoKn5mgBFOg1m6I4W+SCPIuxPns2PR5H4riFHsJVHCQLRGsrFnS6BwuW
         SVtDSYADnSywqOYdBPwA82h8DatgemnfVn6YCkrLiJlkzYVwoMPMM0w62Yg+g4G3VyRX
         Rumq3uxs7vhZjfS1eUVBZziFMKb30beFiW/CUoWV7k5KfkSaoSD26XV+r1hHNDBTaXdG
         8qURmnhk70dPjlT/mO1Hfk8Tw7joCPnL3zrB6xmuxpMIGa6fp33q5PPmk04k3kR8dbfn
         FGBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784199409; x=1784804209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tp7+ky3jAc/0xnKfAUPh02vFiCwKWR3+WZ4dapoaCZg=;
        b=XRw4IwtbxnubJvWrrosOYHFARQlvi4jOJsxV8TGTIG/7w1n9yqaDMc9+6B8hsgXCjK
         nO1MgfMCRqnujffypX2byoFi2gIeII/wiAx90RjqTSxGV9Mkh/tlcosIp6DfFPsDgG9t
         0hbU36TgqOZx+CQgfTS63sfpBNJTkFdC7uoF6KfXpoXWlQJHIYkogi22z7HYT00Ya1Od
         dMJ8R14F3zM1mPIihJ9RHj06xf/R3gO4MUkidH+ZFjeujDbW3Jun55UvaGEZpEnSbS8F
         C8rkANu+rU4zF8VCe0bIUNr+dcmH+nINLBljwMygRGeQnLUGUtOkQ9Mv4Wrk3Qsl4TyG
         yftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784199409; x=1784804209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tp7+ky3jAc/0xnKfAUPh02vFiCwKWR3+WZ4dapoaCZg=;
        b=LCA00UZnOWDNftN1ZkCKNib9xATdNUnXRr4PrSjeeSq6sh/LKl2NpwrmW5o25PvMmj
         qPGrHGFiadIjcampcrKCwP83WEon87TK7y/2preD3z8n8ZA0FLlX1hACs021Fp8XDD2N
         fxBQyIzvbewDJmIv54sxkt26ITfGBM4QjDQrJTfJz0KU1zibnHxTqCEvpjHDDzVvQfpY
         6HkD3z68fbORD080f3530nP9QXhdR1vgIHUuNBd0cUwr2SzMHoKw8fqQtiJq+g11GVAC
         KIPt6U6L305bYewWmRkcIh2lQnbM/8wLYNhUnlbcB1AiGa6p9pGumAGuqHGNRbZIvG4+
         1Yag==
X-Gm-Message-State: AOJu0YxCHImd184jHky+6oaN47LvrqWbPeUpmpoou2XjAFs9La41m/Wd
	R4Oq5Jc6857Wpw5eGc7Yux99B8OhEYZIo2Z/fzefoB3FaQy9le1xHMO8cNEBuFgnvdd/5w4F4rE
	bB5k1ie/UH+ba2EPS+knQdHBRXo5qI3k=
X-Gm-Gg: AfdE7cnZB/mBQk3oUJN50QjRNgcP0oWbIuxNirtseMmTa1qtmFd21pWSmjO1vEzvN9F
	yRXi03PJ3KetqYZyc4KCRbLIuAgkjBfYOadr5JBDPj1FPWusIIgCWf0Z9mJnFfGdcW91hJpcyEb
	5UrGPoOCJwplsPX8iVS41T617uLOd+YyPN4D8+A+yj7c7pWhKE5NUBJVVvcFxIKjLp5ZFbAeuaD
	8tE0z8GvcQM43BqTXcR/gP6783PDjHCufsKFPtgKjt825nKNqqEcgRiB23+MbvFkQ0S5UlicDmY
	04XawWANl8LILjP8u0wvILRb6AaWTLYbiETnC6YGkrKHlO9yPC60brZOkg1XQR82xMvodHOijvm
	esg==
X-Received: by 2002:a05:6512:340a:b0:5ae:a9eb:c5c6 with SMTP id
 2adb3069b0e04-5b15d7c3534mr1385587e87.64.1784199408688; Thu, 16 Jul 2026
 03:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-4-maciej.fijalkowski@intel.com> <CAL+tcoDc-a=Tx3VGfjnPoLq2hWaGCBjUe+NzHeaz=QPvjWEXjA@mail.gmail.com>
 <ali2v31fXqzAKrEP@boxer>
In-Reply-To: <ali2v31fXqzAKrEP@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 12:56:09 +0200
X-Gm-Features: AUfX_mz__VkFdg_WzWWar6G58ddWy9DG0HBXZ2xyYCunyozJ5vc0rXUcXfibzfk
Message-ID: <CAL+tcoA=OiOMGc7TvubFTCNA9y7MK4UpqCsGfH19YbA_DUKXSw@mail.gmail.com>
Subject: Re: [PATCH v3 net 3/6] xsk: provide sufficient space in pool->tx_descs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 12:47=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 11:29:49AM +0200, Jason Xing wrote:
> > On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > The temporary Tx descriptor array in an XSK buffer pool is currently
> > > sized from the Tx ring of the socket that creates the pool.
> > >
> > > This is insufficient for shared-UMEM Tx. A later socket may have a
> > > larger Tx ring and submit a valid multi-buffer packet containing more
> > > descriptors than the first socket's ring, while still remaining withi=
n
> > > the device's xdp_zc_max_segs limit.
> > >
> > > A packet-framed batch parser bounded by the temporary array cannot re=
ach
> > > the end-of-packet descriptor in that case. It leaves the packet on th=
e
> > > Tx ring and encounters the same packet on every subsequent attempt,
> > > stalling Tx processing for that socket.
> > >
> > > Size the temporary descriptor array to the larger of the first Tx rin=
g
> > > and the device's xdp_zc_max_segs capability. This keeps the array lar=
ge
> > > enough to inspect one maximum-sized valid packet. Larger shared Tx ri=
ngs
> > > do not require further resizing, as they can be processed over multip=
le
> > > batches.
> > >
> > > Following commit will actually address the data path side.
> > >
> > > Fixes: d5581966040f ("xsk: support ZC Tx multi-buffer in batch API")
> > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > I noticed there is one interesting comment[1] from sashiko, which
> > actually I think is valid. Probably we don't need to do it in the fix,
> > but we might need to target -next branch. Now the tx_descs is limited
> > by the first tx ring.
> >
> > [1]:
> > "...since tx_descs is not
> > reallocated if it already exists, the array size is permanently frozen
> > to the first socket's size.
> >
> > Should the array be resized to accommodate the largest shared ring, or
> > should the batch readers be updated to cap their reads to the array's
> > actual size?"
>
> My take here is that this set will not break the user space by providing
> at least pool->xdp_zc_max_segs at pool->tx_descs. Let us rely at least a
> bit on user's intelligence here - if you would attach one short ring for
> whatever reason among with bigger ring to the very same umem and whine
> your performance suck, then I'd say it's on you :P
>
> Hope this makes sense!

Sure, unless someone else is screaming at me :)

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> > > ---
> > >  include/net/xsk_buff_pool.h |  6 ++++--
> > >  net/xdp/xsk.c               | 10 +++++++---
> > >  net/xdp/xsk_buff_pool.c     | 12 ++++++++----
> > >  3 files changed, 19 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.=
h
> > > index ccb3b350001f..f5e737a83055 100644
> > > --- a/include/net/xsk_buff_pool.h
> > > +++ b/include/net/xsk_buff_pool.h
> > > @@ -102,12 +102,14 @@ struct xsk_buff_pool {
> > >
> > >  /* AF_XDP core. */
> > >  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> > > -                                               struct xdp_umem *umem=
);
> > > +                                               struct xdp_umem *umem=
,
> > > +                                               u32 max_segs);
> > >  int xp_assign_dev(struct xsk_buff_pool *pool, struct net_device *dev=
,
> > >                   u16 queue_id, u16 flags);
> > >  int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock=
 *umem_xs,
> > >                          struct net_device *dev, u16 queue_id);
> > > -int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *x=
s);
> > > +int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *x=
s,
> > > +                     u32 max_segs);
> > >  void xp_destroy(struct xsk_buff_pool *pool);
> > >  void xp_get_pool(struct xsk_buff_pool *pool);
> > >  bool xp_put_pool(struct xsk_buff_pool *pool);
> > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > index 43791647cf18..385a3f4a1b32 100644
> > > --- a/net/xdp/xsk.c
> > > +++ b/net/xdp/xsk.c
> > > @@ -1525,7 +1525,8 @@ static int xsk_bind(struct socket *sock, struct=
 sockaddr_unsized *addr, int addr
> > >                          * and/or device.
> > >                          */
> > >                         xs->pool =3D xp_create_and_assign_umem(xs,
> > > -                                                            umem_xs-=
>umem);
> > > +                                                            umem_xs-=
>umem,
> > > +                                                            dev->xdp=
_zc_max_segs);
> > >                         if (!xs->pool) {
> > >                                 err =3D -ENOMEM;
> > >                                 sockfd_put(sock);
> > > @@ -1557,7 +1558,8 @@ static int xsk_bind(struct socket *sock, struct=
 sockaddr_unsized *addr, int addr
> > >                          * utilizes
> > >                          */
> > >                         if (xs->tx && !xs->pool->tx_descs) {
> > > -                               err =3D xp_alloc_tx_descs(xs->pool, x=
s);
> > > +                               err =3D xp_alloc_tx_descs(xs->pool, x=
s,
> > > +                                                       dev->xdp_zc_m=
ax_segs);
> > >                                 if (err) {
> > >                                         xp_put_pool(xs->pool);
> > >                                         xs->pool =3D NULL;
> > > @@ -1575,7 +1577,9 @@ static int xsk_bind(struct socket *sock, struct=
 sockaddr_unsized *addr, int addr
> > >                 goto out_unlock;
> > >         } else {
> > >                 /* This xsk has its own umem. */
> > > -               xs->pool =3D xp_create_and_assign_umem(xs, xs->umem);
> > > +               xs->pool =3D xp_create_and_assign_umem(xs, xs->umem,
> > > +                                                    dev->xdp_zc_max_=
segs);
> > > +
> > >                 if (!xs->pool) {
> > >                         err =3D -ENOMEM;
> > >                         goto out_unlock;
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > index 1f28a9641571..12c9fb29af05 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -42,9 +42,12 @@ void xp_destroy(struct xsk_buff_pool *pool)
> > >         kvfree(pool);
> > >  }
> > >
> > > -int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *x=
s)
> > > +int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *x=
s,
> > > +                     u32 max_segs)
> > >  {
> > > -       pool->tx_descs =3D kvzalloc_objs(*pool->tx_descs, xs->tx->nen=
tries);
> > > +       u32 nentries =3D max(xs->tx->nentries, max_segs);
> > > +
> > > +       pool->tx_descs =3D kvzalloc_objs(*pool->tx_descs, nentries);
> > >         if (!pool->tx_descs)
> > >                 return -ENOMEM;
> > >
> > > @@ -52,7 +55,8 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, s=
truct xdp_sock *xs)
> > >  }
> > >
> > >  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> > > -                                               struct xdp_umem *umem=
)
> > > +                                               struct xdp_umem *umem=
,
> > > +                                               u32 max_segs)
> > >  {
> > >         bool unaligned =3D umem->flags & XDP_UMEM_UNALIGNED_CHUNK_FLA=
G;
> > >         struct xsk_buff_pool *pool;
> > > @@ -69,7 +73,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(str=
uct xdp_sock *xs,
> > >                 goto out;
> > >
> > >         if (xs->tx)
> > > -               if (xp_alloc_tx_descs(pool, xs))
> > > +               if (xp_alloc_tx_descs(pool, xs, max_segs))
> > >                         goto out;
> > >
> > >         pool->chunk_mask =3D ~((u64)umem->chunk_size - 1);
> > > --
> > > 2.43.0
> > >
