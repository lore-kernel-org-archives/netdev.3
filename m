Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86223C141F
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194231; cv=pass; b=Zqs/jmeEQbzJ7inbZCSjt9ZTXtRv8p9ihRSXSf52+g601/or/eZ8E9lEaa2R55Jg7VnHcIAYfM+cq0Xfz2upA+20bPYRtm/vmlwLJYAJBYofjT6N/496poc92eHgC+Rsmtky5SQTSuO8JNdGuGj7pmAHOkkYMKBboRBB2UZEFUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194231; c=relaxed/simple;
	bh=QEHatCPgUz5QULPujcSct7LiVVyaQ2UL0dKtrQX2mpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ey+U6StRmpE2TP4tnQZ6Gcl6sTBtHmfBlluwqiq+0Gy+ZekDQpELJnu4+8/ddcqI9gBDjUIYNqxVuzHk/GknE6MZ9usaH62rHn4XNaeQLci//JuUNAsxuGEclueE5bAGe3URdTki+v8ZQOh6iFMUt7TPJxvYHH3CmjipF8388zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rq986dAY; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rq986dAY"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b015b2d792so7610699e87.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 02:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784194228; cv=none;
        d=google.com; s=arc-20260327;
        b=U+rofg04oUTgOVpfsQ9Jnd3mplhqi2Es/mwIxpz3n8YyaLtPDUi++GaPCA7noc/8aF
         19v1S3zKBsyDXiYavlrHNXy5Yjq5jxq95QiZCOx/PAmc5qTw1DvLIOwSLbu2gfyvI8Gw
         HBZ/lwdPrIW1/edn/KRBkCAFq6+cSh1IBZLlNwEuf7vYpkC6tAKbo4lj/9SdaxDiJCQ7
         ukgvUwCLyG5L+2Nvg3gVfuCfEtDxgy/Ej3/Q2YmaldMOShjmaVrvO20NmE8aTtQRAeac
         LZTFUVCrem2Q5hgb8jXFrzgy96L+h14YXQEe7/r3BWg7g/U4JMqRum2A4nDjTDpUqmgL
         QSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WS394X+Kw3Dgf7nUjZ+wZTSIL0JaKnCQXCnKc8IU5iI=;
        fh=JI3h9u+zcTfgqfsrvii+M2LwYW6m91hHHyR7PjAVQZI=;
        b=rW/6JeBh3gqYSSlWNm/kPEIk/Ed5jMa6WZ1pE5DRMIFWufifzZHbCgTducNwKc6WJ/
         KyoIFkOSx0RWPlw67XSrAvK2rtX7qOWUud4J326Zw29HoJsv2SiDVPnol8mnHAZ795zK
         t1WUHYVSfjPBsJLBfkpzp0B76B4aDyHmeGvkP0bBOiUMr1YIDdejMcjyXbX41gJtmLWY
         rcI2VNeekq69ocurjQCSD3UnqR1mOiu1dgBbHf9pprTHhbyyF8qIlOzLGtpwHR0Lcfso
         z1vji/Z77choBCLp2Tsa9xSQ6e8Lj42Cslt3mcortWHuNPT6XRoIgLpbhunzEjUXcTOG
         ShZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784194228; x=1784799028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WS394X+Kw3Dgf7nUjZ+wZTSIL0JaKnCQXCnKc8IU5iI=;
        b=rq986dAYYeG96SEjd7OQ1bTQCvnR+Wnklmfbb1z0bzoRFyNDLoGK3D/PGInZSYidGE
         OdPBLjetUJnpKPUhxptq9ZhUXJmadTCvQE3O2jevHTbixHybzcGJBDFcQTvToNk1hwog
         aqOOzN3mvVw6ebkdTcR0k9tZWEcOdFpwFjGEDGB3dpEGNxU5gZyqR6WijJKFxu7W7+vW
         NW7ABANpx9yoBV+8kgT5c3oBnAAICtdhvJ9qFu8BuYuaKfAYM1KVYCoSYHde+3FAv89m
         JzPSz2/v8qFBL3nbaN0LseJq0J6IpLPl2bgsy2wi7vP8JML7+oG3onle3FHUp4XWiMDw
         zpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194228; x=1784799028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WS394X+Kw3Dgf7nUjZ+wZTSIL0JaKnCQXCnKc8IU5iI=;
        b=esFeG6v0cdeox+n/a73ei70wqOEI/kK/c9h+LEhlB6fBPTZdeF9Ks7Ju3jHD+Ya63h
         QluckF1SVsbD9pMXyTM0QT2cD9H8k7AIeHLR5WqqPXGFfQryRmFl5Nv4taQStewkbssj
         VDcqvpb5Gc8MjTY0Df4P4x6LeLIBdvpCbniIbQS6AGeiRYPsSuTcd7XFNXXqBXr++VVb
         fxTocK13adVdALALN+v9vx+ALWHuMG4/b/WNb7bIER3kHoJxph0FexyczuiDSf5jHebh
         oZpeDMaHm2fWyVOx5vnyk2Yqtwhw7Jvk6Z5bKaGK6aubXwyJk4VF9v0ELAhTjxuKbIcP
         0MPQ==
X-Gm-Message-State: AOJu0YzYQOfOHQUakdaGNc1fMvu8eq+iYm1zT4itEOhcHf+6RY+Lbs6Y
	ZpLBQ9SqwJVHr5y4+YWrCsh6KWbJwDXR5SGa7P72S5i9z3lg2odx01f3MACW9fj5KTAfPCkF2G7
	C93J0Tt0qcFWxZ51i5JW5exKzIjvjhjw=
X-Gm-Gg: AfdE7clTvlJBa2ouGbgjGkOf5nETAHpd/LQR9aofaLjjp5HbQVAWibeIOoNSRJBeawF
	ulhmYfpUgag8/5FPycG+qpPdONQ7lHmUMp8tsSCzi3lrKIZG5ISO3N82oYjwyxS2aGpWZN76fOP
	LpyRt9RrQNwli5NVta6VJLYOwy2s5/96GsPWB5E2ueavddYb2MRMIDVRL/tABrAo5eMEOPncjB4
	v6KVD+lJqiruTyNZG6EcW32fvT+ifWezTwSV+frgxaNXDgf9C1ruIRqD75sAK9yOqJ2a6rfwT5u
	QD8dA+TOjFzCbxwlTOg2TZ+0ucIxoCbHDpBBCKFko95rGR8rIYGA9rTiShxkwxmyYpL/e7SE41w
	q8A==
X-Received: by 2002:ac2:5686:0:b0:5b1:58d6:4542 with SMTP id
 2adb3069b0e04-5b159b6fd09mr2305986e87.14.1784194227328; Thu, 16 Jul 2026
 02:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com> <20260714140722.111645-4-maciej.fijalkowski@intel.com>
In-Reply-To: <20260714140722.111645-4-maciej.fijalkowski@intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 11:29:49 +0200
X-Gm-Features: AUfX_mx3YuK7-PMdW_fqvP-8PVYBxqa6igSapUEDh9lpTolcc79xRdPp5nkh2Jk
Message-ID: <CAL+tcoDc-a=Tx3VGfjnPoLq2hWaGCBjUe+NzHeaz=QPvjWEXjA@mail.gmail.com>
Subject: Re: [PATCH v3 net 3/6] xsk: provide sufficient space in pool->tx_descs
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> The temporary Tx descriptor array in an XSK buffer pool is currently
> sized from the Tx ring of the socket that creates the pool.
>
> This is insufficient for shared-UMEM Tx. A later socket may have a
> larger Tx ring and submit a valid multi-buffer packet containing more
> descriptors than the first socket's ring, while still remaining within
> the device's xdp_zc_max_segs limit.
>
> A packet-framed batch parser bounded by the temporary array cannot reach
> the end-of-packet descriptor in that case. It leaves the packet on the
> Tx ring and encounters the same packet on every subsequent attempt,
> stalling Tx processing for that socket.
>
> Size the temporary descriptor array to the larger of the first Tx ring
> and the device's xdp_zc_max_segs capability. This keeps the array large
> enough to inspect one maximum-sized valid packet. Larger shared Tx rings
> do not require further resizing, as they can be processed over multiple
> batches.
>
> Following commit will actually address the data path side.
>
> Fixes: d5581966040f ("xsk: support ZC Tx multi-buffer in batch API")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

I noticed there is one interesting comment[1] from sashiko, which
actually I think is valid. Probably we don't need to do it in the fix,
but we might need to target -next branch. Now the tx_descs is limited
by the first tx ring.

[1]:
"...since tx_descs is not
reallocated if it already exists, the array size is permanently frozen
to the first socket's size.

Should the array be resized to accommodate the largest shared ring, or
should the batch readers be updated to cap their reads to the array's
actual size?"

Thanks,
Jason

> ---
>  include/net/xsk_buff_pool.h |  6 ++++--
>  net/xdp/xsk.c               | 10 +++++++---
>  net/xdp/xsk_buff_pool.c     | 12 ++++++++----
>  3 files changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> index ccb3b350001f..f5e737a83055 100644
> --- a/include/net/xsk_buff_pool.h
> +++ b/include/net/xsk_buff_pool.h
> @@ -102,12 +102,14 @@ struct xsk_buff_pool {
>
>  /* AF_XDP core. */
>  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> -                                               struct xdp_umem *umem);
> +                                               struct xdp_umem *umem,
> +                                               u32 max_segs);
>  int xp_assign_dev(struct xsk_buff_pool *pool, struct net_device *dev,
>                   u16 queue_id, u16 flags);
>  int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *um=
em_xs,
>                          struct net_device *dev, u16 queue_id);
> -int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs);
> +int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> +                     u32 max_segs);
>  void xp_destroy(struct xsk_buff_pool *pool);
>  void xp_get_pool(struct xsk_buff_pool *pool);
>  bool xp_put_pool(struct xsk_buff_pool *pool);
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 43791647cf18..385a3f4a1b32 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -1525,7 +1525,8 @@ static int xsk_bind(struct socket *sock, struct soc=
kaddr_unsized *addr, int addr
>                          * and/or device.
>                          */
>                         xs->pool =3D xp_create_and_assign_umem(xs,
> -                                                            umem_xs->ume=
m);
> +                                                            umem_xs->ume=
m,
> +                                                            dev->xdp_zc_=
max_segs);
>                         if (!xs->pool) {
>                                 err =3D -ENOMEM;
>                                 sockfd_put(sock);
> @@ -1557,7 +1558,8 @@ static int xsk_bind(struct socket *sock, struct soc=
kaddr_unsized *addr, int addr
>                          * utilizes
>                          */
>                         if (xs->tx && !xs->pool->tx_descs) {
> -                               err =3D xp_alloc_tx_descs(xs->pool, xs);
> +                               err =3D xp_alloc_tx_descs(xs->pool, xs,
> +                                                       dev->xdp_zc_max_s=
egs);
>                                 if (err) {
>                                         xp_put_pool(xs->pool);
>                                         xs->pool =3D NULL;
> @@ -1575,7 +1577,9 @@ static int xsk_bind(struct socket *sock, struct soc=
kaddr_unsized *addr, int addr
>                 goto out_unlock;
>         } else {
>                 /* This xsk has its own umem. */
> -               xs->pool =3D xp_create_and_assign_umem(xs, xs->umem);
> +               xs->pool =3D xp_create_and_assign_umem(xs, xs->umem,
> +                                                    dev->xdp_zc_max_segs=
);
> +
>                 if (!xs->pool) {
>                         err =3D -ENOMEM;
>                         goto out_unlock;
> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 1f28a9641571..12c9fb29af05 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -42,9 +42,12 @@ void xp_destroy(struct xsk_buff_pool *pool)
>         kvfree(pool);
>  }
>
> -int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
> +int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> +                     u32 max_segs)
>  {
> -       pool->tx_descs =3D kvzalloc_objs(*pool->tx_descs, xs->tx->nentrie=
s);
> +       u32 nentries =3D max(xs->tx->nentries, max_segs);
> +
> +       pool->tx_descs =3D kvzalloc_objs(*pool->tx_descs, nentries);
>         if (!pool->tx_descs)
>                 return -ENOMEM;
>
> @@ -52,7 +55,8 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struc=
t xdp_sock *xs)
>  }
>
>  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> -                                               struct xdp_umem *umem)
> +                                               struct xdp_umem *umem,
> +                                               u32 max_segs)
>  {
>         bool unaligned =3D umem->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG;
>         struct xsk_buff_pool *pool;
> @@ -69,7 +73,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct =
xdp_sock *xs,
>                 goto out;
>
>         if (xs->tx)
> -               if (xp_alloc_tx_descs(pool, xs))
> +               if (xp_alloc_tx_descs(pool, xs, max_segs))
>                         goto out;
>
>         pool->chunk_mask =3D ~((u64)umem->chunk_size - 1);
> --
> 2.43.0
>
