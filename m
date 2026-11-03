Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793673199;
	b=vJAPCKHieCEZJROHpDh7/0Oj+wkjoPLVMFa62gSAMm81rf+l93LHhYKWn4L9ppD52buR
	 o+z2h3lddA4yf+yj50E+F5dzVJ/W/SZjMLtMlILjm7xO1GXq2wV3w8980obtQWsTdcKka
	 ogVS9yS2FmTj+0AfD0EAIGqjQYke2pJz6oNF+9+Ga581uiYJ2rUwN75FkwRAPAqDDQhaV
	 zutJPE1trl25u40MyRFx4fmUbswnPYqmlllu79NfaS8gLknBKDHwasEmJUrm65Kkf24yv
	 sC8D+ixOxCuyAPyrKzwWn2iHyK96sEIqEUGVpaz3xHAzRoXnuHztzVbJJxfz2xhvO6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793673199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ej64xMS8kGq5PBAWKWEJuwz7p+48gcc+V/GA+vPZ96I=;
	b=bSvUqeyuLBYZaR5EfWHFu0BDUtj4TjkWZYN7ufVVa0uia+s8CqMxBEZ+znhC7P+YfDs0
	 9xvBgNcmqFbh+eXjYUtidtAe/5O69b3WbPYJ1yrV2i0Q2GkH9soVVDql7cYMwb1cf0O0S
	 qSPKXL9J9Oe2M8aQbrKTf8o8pBEwZMDP08/Dawtr1Yp8zLWeiiGLeR4/ozFF95hk0/TUA
	 41t+EscTW859WWrVj+A3JUNY7+TVMa/XoImRTdYBQWH8cBcCjBzusWpjO/VNzXdjvGOoJ
	 O3FtI6ZJG0TaK7temuyZ1PMvhZ2dvlRiWSdMmYte7dWG5mT8rf2yePsKgep7gyJumTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W+Y8XdQ6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A0606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239A0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W+Y8XdQ6
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so2448a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:33:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793673197; cv=none;
        d=google.com; s=arc-20260327;
        b=EGy0gioobOWF+Nc7/cilMF7QMG0upyvbFoVT57pXVifzHn4BYstDPwDy6V5GYDtL5l
         9BF1xaoGKjUmq13Io17AYqTziy4cHU7YegO+tMd/mESKSNGJK8Opqm/pa+Ru64Y187bz
         fIwaqCoXUq/amZkRCa0QSGXFtsTJ0OekxeKBD3rXjqg5XnPrf1QYPTwJLv5T4eFuMhBq
         s4/QSMpKmNgE35mW4PaTQhSAmkoCCveoWI674sprTSs0slYVeiQTaXZlZna9TSNSB85P
         G+WTHOSQgKZ9xQwgLNagKlMyYytmsQbtSbzqq8HYOXLW5V6qQdxtX7RyRJQSqo9qV0VO
         SANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ej64xMS8kGq5PBAWKWEJuwz7p+48gcc+V/GA+vPZ96I=;
        fh=rHhMJW1n6ei3x1OHTNkC63ikr42QCKERzDHZXYfMy74=;
        b=LMUjfCvU1eYYp6lKu8JcO2P56DIIe1W13MTf9cyT+kAI5F4N0fC5W9/hZbNFKvKWsP
         iXkgBVo5UyrBJwfcIgbQhWeqslxlTHABuBfQyO5D0JCovrd9Fj/0Km784gCVFPNCmuVA
         p2bVxTQYYnzlDOGinv6IQ7XN72lMwIGzMyV6OHfHSHJVwtzkeDG655rShiMrrXEhsAaP
         FtucFTa7Eed5JrlL0j4+qk2TiNCFNrwzL9MgdVbAx8cKrKrzs8kds25KxJrFTgD1VgO6
         f7MMi2Li3/XNM742vKWnLnoV/1QEqcnXaHqFJ98nwJN1b5kW6gIwTjZMJKgZ1RYHwdQ9
         83gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793673197; x=1794277997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ej64xMS8kGq5PBAWKWEJuwz7p+48gcc+V/GA+vPZ96I=;
        b=W+Y8XdQ6mttNbu5uRt0Dl67uj5l4yIeG3+XlCGU8Y19J3q2isuYsf496D9tYXoyuyg
         13BBujovgk6uH/rSYkCLG19C99Sn88E7jLu6cOsZrqsuNvX7rN7cL+yHX7gV1v9fgM54
         4HUZhm3qaJCQGrcQWeCIGW4fHew8JWeDkGQyKL1fShzm85CINcbTxCPTfQHMFFNFYIy3
         YVzxjePngUrxjUDNYVne2nqa1lLRM9s4UMYrEBNdeYs6VKbpR6cU2ON1/hJu+Lf8TZFe
         Aw+IQ1Fy5lfdDe1PEIpvqWeKoZatrCP0JuzQ053+UDCA3FIorYE4ToJ5Hgo3M6j4/4zy
         jF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793673197; x=1794277997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ej64xMS8kGq5PBAWKWEJuwz7p+48gcc+V/GA+vPZ96I=;
        b=UgfIktTbC3EG7spwLqA5tcZA/csSDzlgfwjfITbDNNUDSS31+h60bIx3PyjAlwuy0E
         69/UvGF4ynW21afCXKki+y0wiEroZ9ZURNMfEysC36DbZ81irAekRAuPw0e8tMSs7HOM
         tjqsmYGV/Sdmr9ZP4EBqq2sgtOgnYrfH0IdFOb7P8DOyovDhRrbUQcptvD4n6u10SZsy
         uBHocOV96LyJo4APqgk0wGiYT7LAJXIsN9DRwxGKI60WhjqvxY6RQ8yOdf8LW8xTVO0w
         tdbcGi8u6JqjO6VvpAeAztKouYA7tG6ddB5UgdyfTay2B+7CM3n1dGYN4rooFXm+r76y
         D2Lw==
X-Gm-Message-State: APuU4Z9OTPV2ic00cKgwp6nibgkqaDhsOVmFe5CT+k6NlODkVFzWLd20
	FgjkNSRb2LVT/DWx32uK3xGj7FSMJkSubPEimsydTtpbDHQa++AUKT0pgTJ5HakXMqRRmupjkS3
	p6p1rtZO+qYUFPsoCahvI/B0WFfgG36DnsTyu10Lq
X-Gm-Gg: AYBFou0vLc9wofVVHd3dFdV0dn9m6VW2caVpv5VPtmxYQMV5K8i/MGjxD7uoD5rsY1X
	Tg9caVs2JHYZLCkxrkrTcmPVZwqeawj/GtMrzn2SR+4kocP9XFOqYxA/edjq2f5h4Zy6usfY6f9
	p4kGoKAbW10XH26YFlDL16+a3Ro2uPYBwSa8ok3NFVrVmSHab0U5TXwJNkB69Bx6zoGANdjf8be
	TJdlEq0iSYnTzCCM0EnEik6HeIwFqrvEuKFO95DHArVbQ0Lj0+PyNHu4wm8gMbf43ZpNqvAOQ2M
	PNspQlFXqiyCQWoMRt44XLztFIgoKLYPZwa4bMm3eoXlXg6ZGuz/J/RryyhdJPfNBD1Qv2UAuEB
	1GD0UBOfZZcDGuO+6TZYqMYf/nnzZiEmoS5EM7PE=
X-Received: by 2002:a05:6402:312c:b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b539d10cc7mr27911a12.5.1793673197149; Mon, 02 Nov 2026
 18:33:17 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102191438.1059771-1-sdf@fomichev.me> <20261102191438.1059771-7-sdf@fomichev.me>
 <CAHS8izMRtaL=kZaM29XQBodT8e+srppnK_DjNSTJnxFfNgG9aw@mail.gmail.com> <aukcZBLBir_91hPr@devvm16445.scu0.facebook.com>
In-Reply-To: <aukcZBLBir_91hPr@devvm16445.scu0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 2 Nov 2026 18:33:05 -0800
X-Gm-Features: AclHuK821CTY_RbKAnEbXzfa7MUQLlmGp2kVuevnXDs5zsd5kldlK8Q3AHE6hIM
Message-ID: <CAHS8izMSpG-ng8WFi6K5oAuJP=Jq=vuxshuktObe3AM_iJRgvg@mail.gmail.com>
Subject: Re: [PATCH net-next 6/7] net: devmem: size TX net_iovs from the
 dmabuf sg table
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	edumazet@kernel.org, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, michael.chan@broadcom.com, 
	pavan.chebbi@broadcom.com, sdf@fomichev.me, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, daniel@iogearbox.net, razor@blackwall.org, 
	leitao@debian.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:38=E2=80=AFPM Stanislav Fomichev <sdf.kernel@gmail=
.com> wrote:
>
> On 11/02, Mina Almasry wrote:
> > On Mon, Nov 2, 2026 at 11:14=E2=80=AFAM Stanislav Fomichev <sdf.kernel@=
gmail.com> wrote:
> > >
> > > PAGE_SIZE TX net_iovs cap devmem skbs at MAX_SKB_FRAGS pages (~68KB),
> > > which makes BIG TCP ineffective.
> > >
> > > TX net_iovs only need to be DMA contiguous. Use the largest power of =
2,
> > > up to 2MB, which aligns every DMA segment of the dmabuf:
> > > - 2MB hugepage-backed udmabufs get 2MB net_iovs
> > > - no UAPI change, TX addresses are dmabuf offsets
> > > - skbs are still bounded by TCP's size_goal, only frags get larger
> > >
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > > ---
> > >  net/core/devmem.c      | 28 ++++++++++++++++++++++++++--
> > >  net/core/netdev-genl.c |  2 +-
> > >  2 files changed, 27 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > index 19c039ed2cb2..98c9594dbf99 100644
> > > --- a/net/core/devmem.c
> > > +++ b/net/core/devmem.c
> > > @@ -181,6 +181,20 @@ int net_devmem_bind_dmabuf_to_queue(struct net_d=
evice *dev, u32 rxq_idx,
> > >         return err;
> > >  }
> > >
> > > +static bool net_devmem_sgt_aligned(struct sg_table *sgt, size_t size=
)
> > > +{
> > > +       struct scatterlist *sg;
> > > +       unsigned int i;
> > > +
> > > +       for_each_sgtable_dma_sg(sgt, sg, i) {
> > > +               if (!IS_ALIGNED(sg_dma_address(sg), size) ||
> > > +                   !IS_ALIGNED(sg_dma_len(sg), size))
> > > +                       return false;
> > > +       }
> > > +       return true;
> > > +}
> > > +
> > > +/* niov_shift =3D=3D 0 picks the net_iov size from the dmabuf, TX on=
ly */
> > >  struct net_devmem_dmabuf_binding *
> > >  net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
> > >                        struct device *dma_dev,
> > > @@ -191,11 +205,11 @@ net_devmem_bind_dmabuf(struct net_device *dev, =
void *vdev,
> > >                        struct netlink_ext_ack *extack)
> > >  {
> > >         struct net_devmem_dmabuf_binding *binding;
> > > -       size_t niov_size =3D 1UL << niov_shift;
> > >         static u32 id_alloc_next;
> > >         struct scatterlist *sg;
> > >         struct dma_buf *dmabuf;
> > >         unsigned int sg_idx;
> > > +       size_t niov_size;
> > >         size_t niov_idx;
> > >         size_t i;
> > >         long err;
> > > @@ -221,7 +235,6 @@ net_devmem_bind_dmabuf(struct net_device *dev, vo=
id *vdev,
> > >         binding->tx_max_frag_size =3D dev->netmem_tx_max_frag_size;
> > >         write_pnet(&binding->net, sock_net(nl_sk));
> > >         binding->uid =3D sk_uid(nl_sk);
> > > -       binding->niov_shift =3D niov_shift;
> > >         xa_init_flags(&binding->bound_rxqs, XA_FLAGS_ALLOC);
> > >
> > >         err =3D percpu_ref_init(&binding->ref,
> > > @@ -266,6 +279,17 @@ net_devmem_bind_dmabuf(struct net_device *dev, v=
oid *vdev,
> > >                 goto err_unmap;
> > >         }
> > >
> > > +       if (!niov_shift) {
> > > +               niov_size =3D SZ_2M;
> > > +               while (niov_size > PAGE_SIZE &&
> > > +                      (!IS_ALIGNED(dmabuf->size, niov_size) ||
> > > +                       !net_devmem_sgt_aligned(binding->sgt, niov_si=
ze)))
> > > +                       niov_size /=3D 2;
> > > +               niov_shift =3D ilog2(niov_size);
> > > +       }
> > > +       binding->niov_shift =3D niov_shift;
> > > +       niov_size =3D 1UL << niov_shift;
> > > +
> >
> > How come we're not checknig the largest supported size of the netdev he=
re?
> >
> > Also, maybe should clarify in the cl with the largest supported size,
> > is it actually only powers of 2 up to that power of 2? Or all sizes up
> > to that (not-necassirly) power of 2 size?
>
> I think these are a bit orthogonal, no? We can have niovs larger than
> the HW can tx. If that's the case, we'll just sub-divide when we build
> the skb. If we limit to the same chunk the device can handle here,
> we might use 2 frags to send single chunk worth of data more often (offse=
t
> doesn't have to be aligned to the chunk size).
>
>
> Assuming device can only send 16K, current patch:
>
> [       2MB        ] 2BM niov
>      [ 16K ]         sending 16K from that 2MB will use one chunk
>
>
> Limiting chunks to device's chunk size:
>
> [ 16K ][ 16K ]       16K niov
>     [ 16K ]          sending 16K from offset 8K will have to use 2 frags
>
> (obviously, the same thing can happen with 2MB chunks, but less often)
>
> LMK if it does not sound convincing.

Ah, I see, the skb gets segmented somewhere else of course. Derp

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina
