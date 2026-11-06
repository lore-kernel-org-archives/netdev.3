Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954959;
	b=EWNgbH+OmTyv+O5nQCc9xXFcYflgHWWXAzFVTQn4iG6TYOSBBMomPsduv/MdquZwNzGE
	 MVZTWvLn+M5pE12NX86rUsCH4PBtFXxgQFbZa4h4yRO7doeehuL7GXEu4wqg2//iil8TB
	 gGC+3Uqw4Ylv6GB6Zgz5YYNPYZH7OETI8vLu72Co9KtuAnrQMH6Lon7pk30kLdTx5uIWa
	 f64v7Bgk0kcEWKOg6zX4LEL596T3fzQOS68LbMlST7DJah/Cf4Nb4O/YzxbvPledIA/Zh
	 uqNcAVe8u4t7OLaYugHJS41Nl4wNTjl9EuuD4wUNYbnYb17UDWuX7gBnXFJx/oiY68Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954959;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=DgXP7zZI1FlaPaSSGpM+hJxyXMjUNEAftizK0rzrvB8=;
	b=H6LNgue8t/3R7or8GgkJCMi1GfdOdglX3LJek5tUPEroBhicEpak/1VUddv0fKEEvU9l
	 KWDkdulmDVlKkjfiThVUS/tk3LkoxsxIJZ6uLclp5RL1feJt6vun6zkPxPCoTjXNoY7eZ
	 4nRWAHzRHkTU3VFgG3U6BvILQ9TDmjVEDgrXNi4yIvKtGu0PtBaUibJzgvfUx35rGlN1P
	 W2j9vpyXXhuA8QW7U9Ypb9jGhVOJX1h+7+I5jh7gC0fdjXShWbjnrKWRkaItiISjwhX/Y
	 MOPI8/jysM+aE9IefgD7SJ0Szd7ddWIk9vUJtrKqe8jB+9T1mR1KNbWyo35OzMGx0Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZPHm5ui;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB82606A329
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZPHm5ui
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9DE51F0089F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793954958;
	bh=DgXP7zZI1FlaPaSSGpM+hJxyXMjUNEAftizK0rzrvB8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DZPHm5uiZBwE4Dfn527zSL0DaEhuyn+7lYoex9PMjTVa/E9heISQGnqAO53JbYTSu
	 5IIoAb66VFlweRXSpAOgGkQNhEII9pDPwB8xbqaLTILlrIPqBKIMCUX9VbKtcpLwd1
	 XwH6DXpupBu+qRJRa9YpSzlBUyCZVtk6HQilDURNwrrAYWNjS9el15DhxbLxZobTsp
	 BbvY6yqKGsHPp8H33bZTlZvdc4t7jglDugg8OCdwwFnA4eT7oY/zCN4XcU3/nh92Lh
	 i3LWjpinjkskuD3oryRLFnxNUXe+ggNjQNLxu6+HbGYYO+Lr6/MmIcat3IJ/BjVl17
	 rGa+RWj8Sf0Uw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4932b13c4ccso193962fac.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 00:49:18 -0800 (PST)
X-Gm-Message-State: APuU4Z+ekmyxIBmC9EWKgaOX8FbCYtN50XDLSEnjxlSfBe2c3K7DhbHq
	AITvM62Jn9zW7aiW0CVtgvFBSXffIk/+Cc5Lsc6pxjzwMKpPerb7GCsKeeNBNXHd0GHmpXH8I6z
	VyFlSkGvc9JQKroHvc/PLMmOFVLtielQ=
X-Received: by 2002:a05:6870:b3c3:b0:4a8:6aa4:5ac7 with SMTP id
 586e51a60fabf-4ad98e47a9emr1170796fac.45.1793954958065; Fri, 06 Nov 2026
 00:49:18 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105115715.1466924-1-edumazet@kernel.org> <20261105115715.1466924-4-edumazet@kernel.org>
 <willemdebruijn.kernel.1afc96da83d57@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1afc96da83d57@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 6 Nov 2026 09:49:06 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqrXe6XehCt+SiR-PzpXzYK71U+rP_vBhJ09ub3TZnjcQ@mail.gmail.com>
X-Gm-Features: AclHuK-7ZZim4zJUAqt1vFqkkEBh1Sez_DrWsXKs9fMK90nqYIlPwYCa_geKNP4
Message-ID: <CAL4WiiqrXe6XehCt+SiR-PzpXzYK71U+rP_vBhJ09ub3TZnjcQ@mail.gmail.com>
Subject: Re: [PATCH net v3 3/8] tun: clear stale skb->protocol of NAPI frags skbs
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Hassan Sultan <hassansultan@google.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 6 nov. 2026 =C3=A0 05:21, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> a =C3=A9crit :
>
> Eric Dumazet wrote:
> > With IFF_NAPI_FRAGS, tun_napi_alloc_frags() gets its skb from
> > napi_get_frags(). If GRO merged the previous frame with
> > GRO_MERGED_FREE, that skb was recycled by napi_reuse_skb(), which does
> > not reset skb->protocol set by napi_frags_skb() for the previous frame.
> >
> > On the IFF_TAP path, tun_get_user() calls tun_vnet_hdr_tnl_to_skb()
> > before eth_type_trans(), so the virtio header checks see the protocol
> > of the previous frame: the outer protocol check of UDP tunnel GSO
> > packets rejects a valid frame when the two ethertypes differ, and
> > GSO packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are dissected with
> > the wrong protocol.
> >
> > This needs GRO to hold packets across writes, for example with
> > napi_defer_hard_irqs and gro_flush_timeout set on the device.
> >
> > Clear skb->protocol for IFF_TAP frames, as for skbs allocated by
> > tun_alloc_skb(). eth_type_trans() sets it right after.
> >
> > Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/netdev/179386753589.488856.114551817210=
04759454@kernel.org/
> > Signed-off-by: Eric Dumazet <edumazet@kernel.org>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> > ---
> >  drivers/net/tun.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 3920b3dff1e8..6b648f21018c 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1941,6 +1941,11 @@ static ssize_t tun_get_user(struct tun_struct *t=
un, struct tun_file *tfile,
> >                       goto drop;
> >               }
> >               skb_set_network_header(skb, ETH_HLEN);
> > +             /* A NAPI frags skb recycled by napi_reuse_skb() keeps th=
e
> > +              * protocol of a previous frame. eth_type_trans() sets it
> > +              * below, the virtio header checks must not see a stale o=
ne.
> > +              */
> > +             skb->protocol =3D 0;
>
> This resets it for all IFF_TAP.
>
> Would it make sense to do this in tun_napi_alloc_frags if it is only
> needed for IFF_NAPI_FRAGS?

Yes, other skbs come from tun_alloc_skb() or build_skb() with a zero
protocol. Done in v4, where I kept your Reviewed-by.
