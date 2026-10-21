Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588452;
	b=wjW4LU+M8tZAFCQzEIPqdJU9tlDEt2xWFKdMc7eCrUaYHt4XXX7Yi+bmSJmbYy8yt+W/
	 AGdP3o3Yl6QBj5v4UWdY+CpTVfVdNrF3iagO5G3EsL1lMCqnXvezyrDvr/BLi/5AS89rN
	 /f5lQGfSuFZcnBC44rY8mRFBf7jqpIQIEXYUNjUob0ocSPnWMhT/l27kzUHBEYQ5W186h
	 KsgeHY9nTwFV4V3Cyhc0jz0hRgF2jsCwaf1H+24TGqUqJgIq/CmFZdFlKZUnkvbnrQyE+
	 +NLfhzJismeiRsR2U6RQrL1DaNzXMxO8VFPNv8RoNrzVUetDt349hI2b0tgzbm+Hcsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588452;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KMUlS4kVV/hcwaTj9DNkFEqBacqnZ7xr4+Vq80uk9j8=;
	b=w9g/cDgqJ+Tv0L8eK4PgMlqVkfhBz/ExQp4FEU/1Z28GGv1D8UHpOB/7kGfn+dL2vE/L
	 ksZ0W4IxGttdT7tBHvkQGT5nzOlP/rwR2suzkA9JyroHoyKGowjzlGd/iBrHzlweP4+gK
	 Q9Wb5DiTdqmoIeXAH4ci4zF8c9V0XvDd1Bio0rbLGFddlGD92X48M6ZJNIlhN7QxhxK7o
	 bsAWm6xtJZPiYK5mBR2v+lp8qkrvQfo5mLzeCqUH4MTN1Ialt0c10F2liHXQpYwrkCohT
	 WqS2v7tksEYpkes21VMmqd01Xs1IdpqXZElQspQlIldPBF49UcDnfe3S3nbT6imrYaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZQGCFnH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696E606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CZQGCFnH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E991F000CC
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588451;
	bh=KMUlS4kVV/hcwaTj9DNkFEqBacqnZ7xr4+Vq80uk9j8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CZQGCFnHTJb+DdW/zc33BOVgDn6skv2WxjULScgbIFEJgVp8eL4hprvTaB44QIoK8
	 F5XzK4n4sG46WKUPp/ZKpmodefwDhjoKJxIoC/XgGO3Ggr2vi9LcuLCRnUAWp1MYaa
	 Y0ER/Q4rmnobYM5KRcMq8QJ/xxAokpBzbXjR2pV8u84VydAOP9M6mFipZN35TieGrq
	 lHdHkCaqoK1Uw3Njmoo5qJyjTYNaZlFZQpe01Pnt41MqixeXY7szyiQfSJ5xnAbiXD
	 q+NiZEGijA27+3sxRpq0P0rInWZ7SvJmOneTp2BRLJ77Fkx4Pbb+2BfGHhTF5GhVqS
	 VyXzlsiaGB7LA==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ab3b29a298so6020881fa.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:14:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzQv/L/4NrPK0aJS2FV32jAgv9mE0ywomHRAuFT1p3GJMr8+Vy26wZLD9WGRnCj7dt7WfCeLuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIf69QXqkfTfUDrVaPpN46tCN67LIVePMoDf7c6fN/+d50d35Gr
	sLHGVdjGTvz2Keh3KD+ajXVcE61bbXLlYaNpRk9jchZLQ65TPkxCAKLJQolNZeVXbkdt6bXKnyv
	R5yYMGh48X0rLpJKCY5rdPoPUGrfz6Es=
X-Received: by 2002:a05:651c:a10f:20b0:3ab:3a7c:a4ca with SMTP id
 38308e7fff4ca-3ac441b323fmr4436701fa.24.1792588450220; Wed, 21 Oct 2026
 06:14:10 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021101839.3797779-1-fouriezhang@tencent.com>
In-Reply-To: <20261021101839.3797779-1-fouriezhang@tencent.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 15:13:56 +0200
X-Gmail-Original-Message-ID: <CAL4WiirY7rHc8J52-Dg3Umb8CPf7Eiwew3wovecT2YaQA__N7w@mail.gmail.com>
X-Gm-Features: AclHuK8jAF91MmHmH8wRpKg7z_X2t8VoBJFAOh8N_tZ0l011RSI6D4CzvAQSNpQ
Message-ID: <CAL4WiirY7rHc8J52-Dg3Umb8CPf7Eiwew3wovecT2YaQA__N7w@mail.gmail.com>
Subject: Re: [PATCH ipsec] xfrm4: use a full socket for local errors
To: Fourie Zhang <littleddfu@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Zhiling Zou <zhilinz@nebusec.ai>, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 12:18, Fourie Zhang <littleddfu@gmail.com> a =
=C3=A9crit :
>
> xfrm4_local_error() passes skb->sk to inet_sk() and ip_local_error()
> without ensuring it points to a full socket. TCP SYN-ACK skbs can be owne=
d
> by TCP_NEW_SYN_RECV request sockets.
>
> When IP-TFS rejects such an skb because it exceeds its payload MTU, the
> local error path treats the request socket as a struct inet_sock. KASAN
> reports a slab-out-of-bounds read in ip_local_error() beyond the
> request_sock_TCP allocation.
>
> Resolve the skb owner with skb_to_full_sk() before accessing inet_sock
> state or reporting the error. This maps a request socket to its listener
> and rejects sockets that cannot be used as full sockets, matching what
> commit 6973a21ee73c ("ipv6: xfrm: use full sockets in local error paths")
> did for xfrm6_local_error().
>

Note that xfrm4_tunnel_check_size() already checks sk_fullsock() since
commit 1620c88887b1 ("xfrm: Fix the usage of skb->sk"), so
iptfs_is_too_big() is the only remaining IPv4 caller passing a request
socket here: the sk it tests is the listener, while skb->sk is the
request socket.

> Fixes: b00897b881f7 ("xfrm4: Don't call icmp_send on local error")

This does not look right. In 2013 SYNACK packets were attached to the
listener. I would use instead:

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handlin=
g")

> Cc: stable@vger.kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Link: https://lore.kernel.org/netdev/20260908224856.1591189-1-kuba@kernel=
.org/
> Assisted-by: tencentos-corvus-ai:hy4-preview
> Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
> ---
> A KASAN reproducer for this issue is available if requested.
>
>  net/ipv4/xfrm4_output.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
> index 0ae67d537499..cf6be50485d1 100644
> --- a/net/ipv4/xfrm4_output.c
> +++ b/net/ipv4/xfrm4_output.c
> @@ -39,8 +39,11 @@ int xfrm4_output(struct net *net, struct sock *sk, str=
uct sk_buff *skb)
>  void xfrm4_local_error(struct sk_buff *skb, u32 mtu)
>  {
>         struct iphdr *hdr;
> +       struct sock *sk =3D skb_to_full_sk(skb);

Nit: reverse xmas tree order please.

Otherwise the fix looks good to me, thanks.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

> +
> +       if (!sk)
> +               return;
>
>         hdr =3D skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
> -       ip_local_error(skb->sk, EMSGSIZE, hdr->daddr,
> -                      inet_sk(skb->sk)->inet_dport, mtu);
> +       ip_local_error(sk, EMSGSIZE, hdr->daddr, inet_sk(sk)->inet_dport,=
 mtu);
>  }
> --
> 2.43.7
>
