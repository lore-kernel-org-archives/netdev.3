Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BDD27A47F
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787180487; cv=pass; b=Dq48XC6wHci3sRSb6ww2LTuY1kilMp18sodT9hGt3hmk10W/uwNAaNeo06rE3UvUbNXVnH8x72OK3CbusJaxo1xFF8DH1s/L22jWMIY3A9ET9dXbFJtTvVJiaGnKwqURwpvX7paayvqojZZljBvPelLfomREwOl0/zDWhW/KaDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787180487; c=relaxed/simple;
	bh=S7M+kg1peeStw+bQmUgEq8sBrdm9dt33lLWw9uVfnQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqO6jV9Skdeh9M9BoT0KsGghJ2s/qR6z6jm3kiWHrHQukXYyu/BhfW1SrmVsH7aavrKN1Qg1rH22/G8kl6C8PHSsTjYttkczrJ6/PFyLh0Nq44+g+VRmMijW9mQqtu8QDa+lbWxSsMIqXP3ILe8liB6jrohxAi+13EC8YnF7b8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iug9OSuo; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iug9OSuo"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66c744a00edso1594597d50.2
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 16:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787180484; cv=none;
        d=google.com; s=arc-20260327;
        b=iOQ3bqTk+8tGw1Dth6damhP0AG3PoWW8QPoXa7a9mbHneurUCd/kfSmrqSDAWecElC
         lN+JFKyogA7OgO8QmAgylQLU9c7Vp56n40KfFKvwPKkVlHcDjXT6ZSc8oS6t5WkJOlXc
         Gqf1NqkcDcETtTdY8rwjbj6casQXjPSS9ZpYX5ePetaqJW653njXPzWrZLZuVsStSZSz
         7alxppNwLEJYedmv5y9HxCbkIZFcwEpY+FV4PyGouTHuKaTz9dBA7tUsWHDLgjAhow23
         IpGGEiLrCmGWGdAMnpxfaXZVkNOOc3SY/sTHbX81WKkkeBXv7Fy9HcZlE1O2abi8efnR
         tJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e3qPDFXgplZ5oaO13rh5SXHaEjFeglT/aQYRf2YpTTo=;
        fh=gwjduxvQ8PWNNPkD8VDbVPavujwprcNzi9eY4lgO0tw=;
        b=OpcY95otT0YBdW4/ebb4odivAv5AegHws61+HMNKr5bzkKnKrFv5E+ntudgB1BiG6/
         KoYodGzB4aQdqxhHy7/3nNox152RiiSxa97k6PyBSY1VIkQM4WJPZahUgkZgIym8ebkj
         AHLusF75SIeeyuirjUBpmHpA3PiHjfTa6DZxudrJPY3Mrz8yJl4yrL49xwwb1Jux3LVT
         CK5QfYvpx0E5yslsXq0VBuiP8egTTBUeK9Nzhndng68SjzZHHEpYzzT6ZrWk6kykz/t3
         qzMLdNKqUdEP+038aerr2RBB03zGri8/oZjD/IzQ0r8Z3TREYU5Fg1O9xfmtD+3MmMht
         Q1/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787180484; x=1787785284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e3qPDFXgplZ5oaO13rh5SXHaEjFeglT/aQYRf2YpTTo=;
        b=iug9OSuotzDBNtJWhWCfnnf8ASyPX7N7iCTHEEepKttI//54Z94UlAkdhJts5OqeOb
         +RGkfM35Aw2Nchh7FVxZgkVooq79h2WzdpY/aTYeda4to9qZH1uNxVyL22x4Z0tfeU3d
         lB7ETkSm73BLVLwlVIkMHOyASAXpMedlDBbfxZ15W6UmUYTyR/KqO2yF88kjL3SWv1Hv
         tbHIo9xYhJsEg2a3f5o0E+bYlovAvZbkRNUNUsnd4gUZqwV0yemm7f+8QG+/7x6FiVqI
         3DM4GoxeuPDMWbWFuZj6rV/9cdlQRaOJP/aIMZ++C1Dc8icbnt9vTfmVzu8bej5Av0iG
         UpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787180484; x=1787785284;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e3qPDFXgplZ5oaO13rh5SXHaEjFeglT/aQYRf2YpTTo=;
        b=Ubv2559AKhRZObpvWkGuWlPMyUN031Mqu7fuxxrZWGO2eeijttJWDpgPfnWawVrVn4
         4ehL6jkkLVH567uf/fDowfQkt+oV6gdRHXPTqFU/21nMdRFPtGvYNyiai9f4acgkD4d0
         hi+xrUWNOjO/HrUHrPYjL2vF7P0eOUz+MIwQ6yx8jw2UjmNM86mrA5KH2/axEJfIfOZP
         GpiIlXUH0jjaXATF/ykxG5vrdm/xEMLzeGvYJxvBM+AxTUxUwdhTqXXG3QlA8fGx5PKA
         t+j1xngoDbIDKAA+ux1gM/Ti7GgB5RQpiZEspnEPOzYeLI3cAt3KdxzWupAJ4yt6DGXn
         +4qg==
X-Forwarded-Encrypted: i=1; AHgh+RrDWvvxYo1SlfMLtsMsNHRbRAwW1Y4BDurrsNE02Q5yyEq819j6AAhZY+FhaWfNyTD3VxsCExk=@vger.kernel.org
X-Gm-Message-State: AFuF++krbdb84/HF55hPnvvhu5hKLXv2hMUQ77o8SNHwscZYAAcN8tCk
	fjYPBSRRsP78gsTP2Ey+pT3M1Qc7mLIH6vHj2qqFel7rkJ76VwLnR24ppm7rHKoHKq2eRSmi/4n
	q+XN+sAoMQejGHJoa8E36pg/imvVtelE=
X-Gm-Gg: AR+sD13P8D2bcJscANDTn47QQcB0KentwOAUEnlwwecSr98qKVJSnElvXiDHZQXq+Fp
	Z3ZNwAaiO1hQVYPq/H9hMiefaBUai8vywybyee0kLbeHOPxxdCf8qWZBbQ8JT93gss3AGXFkXmw
	zmX2TCroEzE3tgMoSqwN73xSBQhgp3wMRfZA6cVohhS7x+jth4uo92C8qg1YjNfmloPfIaIMgxJ
	qnqc5tIIiGcjZmp4e69GEav8kWQuTDM9hInCh2p1sAvg/zVnCw0xnoqRb8sUZl+E78/qPtQtoek
	0/wmINRwM/EE2mJrocGPwtw+Z/p07twHP2s3TPPUJrQoVBA5KYVVpB+qAaHGAmLGnQQN/AQfBkF
	W/g==
X-Received: by 2002:a05:690e:dce:b0:667:bae0:e55e with SMTP id
 956f58d0204a3-66ccb55edb6mr2785816d50.4.1787180484224; Wed, 19 Aug 2026
 16:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819093226.193385-1-zhaoping.shu@mediatek.com>
In-Reply-To: <20260819093226.193385-1-zhaoping.shu@mediatek.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 19 Aug 2026 19:00:46 -0400
X-Gm-Features: AcwNN1WEM4e_ulk3k65OjzBP61d1mbrUjNG1Ufz5gSu5el3BQMuGb2PvDL75O80
Message-ID: <CAF=yD-Lx7aHQEr6MN7D8LBp9ctZz3B3dmfsyhLbPxWaiK1UBzw@mail.gmail.com>
Subject: Re: [PATCH net v4] net: gro: Fix nesting of TCP GSO SKBs in skb_gro_receive_list()
To: zhaoping.shu@mediatek.com
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
	dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	haijun.liu@mediatek.com, xiayu.zhang@mediatek.com, lambert.wang@mediatek.com, 
	Iven.Yang@mediatek.com, HW He <hw.he@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 5:37=E2=80=AFAM <zhaoping.shu@mediatek.com> wrote:
>
> From: HW He <hw.he@mediatek.com>
>

Perhaps a brief one sentence summary of the problem, before
a detailed repro. For instance:

Fraglist GRO plus hardware GRO can create an fraglist of
HW-GRO packets. This cannot be segmented back into
the original form.

Avoid constructing such a GSO packet, by flushing an already
built fraglist GRO packet if a hardware GRO packet arrives.

> A device supports GRO_HW, and the device driver enables the
> NETIF_F_GRO_FRAGLIST feature. During a tethering test,
> skb_gro_receive_list() reaggregates the GSO packet. However,
> skb_segment_list() cannot segment this packet back into
> the original packets, which leads to IP fragmentation or packet drop.
>
> Scenario (Tethering/Forwarding):
> 1.Driver submits a single TCP packet, P1. P1 is kept in the
> gro_list as the first packet.
>
> 2. The driver submits a TCP GSO skb, P2. P2 has already aggregated
> multiple TCP packets by HW_GRO, and its non-linear data is stored in
> frags[].
>
> 3. P1 and P2 match the GRO rules, and since there is no local socket,
> they are aggregated by skb_gro_receive_list(). The resulting skb,
> P3, has a frag_list entry that still contains frags[]:
> P3: [ Linear Data ] -> frag_list -> [ Linear Data ]
>                                     [ frag[1] ]
>                                     [ frag[2] ]
>                                     ...
> 4. Later, tcp4_gso_segment() or tcp6_gso_segment() calls
> skb_segment_list() to segment P3. However, skb_segment_list() only
> segments the entries in frag_list. It does not segment the frags[]
> inside P2, so P3 is not restored to the original packets, which leads
> to IP fragmentation or packet drop in the following path.
>
> Check skb_is_gso(skb) and current GRO method, make sure fraglist GRO
> applies to consecutive non-GSO skb, others adopt regular GRO path.
>
> Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
> Signed-off-by: Zhaoping Shu <zhaoping.shu@mediatek.com>
> Signed-off-by: HW He <hw.he@mediatek.com>
>
> ---
> [3]: https://patchwork.kernel.org/patch/14747095
> [2]: https://patchwork.kernel.org/patch/14706032
> [1]: https://patchwork.kernel.org/patch/14702209
> ---
>  net/ipv4/tcp_offload.c   | 22 ++++++++++++++++------
>  net/ipv6/tcpv6_offload.c | 15 +++++++++++++--
>  2 files changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 3b1fdcd3cb29..e74d99ca9fac 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -332,6 +332,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *hea=
d, struct sk_buff *skb,
>                 flush |=3D skb->ip_summed !=3D p->ip_summed;
>                 flush |=3D skb->csum_level !=3D p->csum_level;
>                 flush |=3D NAPI_GRO_CB(p)->count >=3D 64;
> +               flush |=3D NAPI_GRO_CB(p)->is_flist !=3D NAPI_GRO_CB(skb)=
->is_flist;

Technically, is this one-line sufficient?

>                 skb_set_network_header(skb, skb_gro_receive_network_offse=
t(skb));
>
>                 if (flush || skb_gro_receive_list(p, skb))
> @@ -395,12 +396,20 @@ static void tcp4_check_fraglist_gro(struct list_hea=
d *head, struct sk_buff *skb,
>         struct net *net;
>         int iif, sdif;
>
> -       if (likely(!(skb->dev->features & NETIF_F_GRO_FRAGLIST)))
> -               return;
> -
>         p =3D tcp_gro_lookup(head, th);
>         if (p) {
> -               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is_flist;
> +               /* flist GRO applies to consecutive non-GSO skbs */
> +               if (!skb_is_gso(skb) || !NAPI_GRO_CB(p)->is_flist) {
> +                       NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is=
_flist;
> +                       return;
> +               }
> +
> +               /* Fall back to the regular GRO path */
> +               if (NAPI_GRO_CB(p)->count =3D=3D 1)
> +                       NAPI_GRO_CB(p)->is_flist =3D 0;
> +
> +               NAPI_GRO_CB(skb)->is_flist =3D 0;
> +

This reduces the chance to have to flush, by downgrading fraglist GRO
packets if a hardware GRO packet is detected at the stage (count =3D=3D 1)
where fraglist is not enabled in practice.

This is quite a bit of complexity. And if hardware GRO is enabled, what
are the odds in practice that the device does not produce any hardware
GRO packets, yet the software GRO stack is capable of assembling
signficant GSO packets. I suspect low.

The solution is technically correct. But would simply disabling fraglist
GRO when hardware GRO is enabled not be simpler? Or only keeping
the flush and avoiding this micro-optimization.

>                 return;
>         }
>
> @@ -410,7 +419,7 @@ static void tcp4_check_fraglist_gro(struct list_head =
*head, struct sk_buff *skb,
>         sk =3D __inet_lookup_established(net, iph->saddr, th->source,
>                                        iph->daddr, ntohs(th->dest),
>                                        iif, sdif);
> -       NAPI_GRO_CB(skb)->is_flist =3D !sk;
> +       NAPI_GRO_CB(skb)->is_flist =3D !sk && !skb_is_gso(skb);
>         if (sk)
>                 sock_gen_put(sk);
>  }
> @@ -430,7 +439,8 @@ struct sk_buff *tcp4_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>         if (!th)
>                 goto flush;
>
> -       tcp4_check_fraglist_gro(head, skb, th);
> +       if (unlikely(skb->dev->features & NETIF_F_GRO_FRAGLIST))
> +               tcp4_check_fraglist_gro(head, skb, th);
>
>         return tcp_gro_receive(head, skb, th);
>
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index f2a659cd6183..eec3778855eb 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -26,7 +26,18 @@ static void tcp6_check_fraglist_gro(struct list_head *=
head, struct sk_buff *skb,
>
>         p =3D tcp_gro_lookup(head, th);
>         if (p) {
> -               NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is_flist;
> +               /* flist GRO applies to consecutive non-GSO skbs */
> +               if (!skb_is_gso(skb) || !NAPI_GRO_CB(p)->is_flist) {
> +                       NAPI_GRO_CB(skb)->is_flist =3D NAPI_GRO_CB(p)->is=
_flist;
> +                       return;
> +               }
> +
> +               /* Fall back to the regular GRO path */
> +               if (NAPI_GRO_CB(p)->count =3D=3D 1)
> +                       NAPI_GRO_CB(p)->is_flist =3D 0;
> +
> +               NAPI_GRO_CB(skb)->is_flist =3D 0;
> +
>                 return;
>         }
>
> @@ -36,7 +47,7 @@ static void tcp6_check_fraglist_gro(struct list_head *h=
ead, struct sk_buff *skb,
>         sk =3D __inet6_lookup_established(net, &hdr->saddr, th->source,
>                                         &hdr->daddr, ntohs(th->dest),
>                                         iif, sdif);
> -       NAPI_GRO_CB(skb)->is_flist =3D !sk;
> +       NAPI_GRO_CB(skb)->is_flist =3D !sk && !skb_is_gso(skb);
>         if (sk)
>                 sock_gen_put(sk);
>  #endif /* IS_ENABLED(CONFIG_IPV6) */
> --
> 2.17.0
>
>
