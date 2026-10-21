Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792575002;
	b=eGspKwu5rRVPa/Bryhtlh293L08ch4PLblygXwIjabkfiAVFeFgdIptaVc8huXAoewzf
	 1KH0wWSNLX7vxI20CiQRnKb/NDgbOiPP4q/JYSS66e2xIDlKWokF5iFA67WsvyBzrn67b
	 C8BBE+NtYn7jGPBd8nN4lN6Kz4sV7c+dO0wN/4vsL3V1gq5Hyj/u5tbgUUacwOi5cg+gE
	 n1hr/QzaUZbEebRFUZBwX7xVLnc7LM+vmUB1irP10FrcNVzGF+/PJtE5heSyke1g7e7In
	 FQO3BrXKoJv33BzRbEHQCAGSaQDHtLi6VhbbbAQBk4GfcqkpQ5LhnKTQumENrmnMnKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792575002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=talS54amiPg/yZGwEbzg0hMRny1RlU7saCiWAuyBxB4=;
	b=YCO16hVUW9mT0OgHZXzgjY9NigzsRNP6U6CpihMNTih00LRp0d6oV49YhD+FqMqAKZxm
	 6chgAjdufOkCZfuoWgo3zzrbu8BU56+LmOGd7ejwiDBmRzI965+qW8HsNkGEFbrFZttU/
	 wMDhbc8ADVaP/vjcfCktA9jJkX1c/p/pgAXW4ZtmuyLeZvCFfT6vk16ptFSpOBrfNCb55
	 oTYdFDy+5c1iNOKOgrPo5iQXHzokuuSWsLlukhFBhmle1wbkjAbHBIE8QAilEES1OaF9f
	 Eigt/PAUyXuQo3edsjbnvj7/O8Nn/jXVe7TndhDUQr7awD+jyfl0veuwFjV7G8uxnrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZY49XlYv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E8606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 669E8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZY49XlYv
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c33700b6435so3122966b.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792575000; cv=none;
        d=google.com; s=arc-20260327;
        b=G2/DFqGBhXt9zyiKQuJuZfhgSFu5BQoKeqMo1Bc/kD5UWQWf28Rel/qIC+ZMtygTEO
         f4pbBzdSAclG2HlzZHEdVG/cpAGsVUvlayZVR4q4npdCg2ZzMoLsqxsEoqGMe2tLbyvI
         d3edtNzuxCiHQbB3JdQ3qtafGYuvXjzPKzH9YndeIbOwht2bTY1qzTiwEn0k3YL7MBZm
         1LBLUqBWoWE36C27alxWgRWY2hO7dS3Z/r3mC2yidbuIdqibdrf7iwcArblWL+MSE3gU
         JKdFWvRnh/50O1O8EPx3dODbO9RRYZ4oEIRDvkxkM4km6uhaOI1KrEiVigFyXXncCQY0
         IEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=talS54amiPg/yZGwEbzg0hMRny1RlU7saCiWAuyBxB4=;
        fh=VLwhX88fyfn3Mx1wCM4By49l7kISwbFZIcLEUBCyuvg=;
        b=eOmoRxc77t3razBlzHsYtuiGuO8heVU9uBJ5Fl/42gDw383stcZp7aYLSwvsUZt0to
         WuCYv6NYVdP0TV12OBBtkI810FLLHWedhe0vEmSI8YldA8GR6ZuJS2wnk2Vuk9cA7XrU
         q3WZi5vZSKSRmzu1V6sdI3TPrFQSTnp5FYIiG+8665TBKSHFLFTYY3RhCdgfTY/RI5HD
         vSkXJOdvbC02ByPu+S1HfriywVv4wjoNH/2F+92KJxKZhqmHVG0AKWbJauW4b31Bd0gB
         T3Bu7GCgJuo4Ty75lqvvaQNd7osMWMqetEmK7DaDAI7QR2m+RfTA37GbmjU+0cqZeutN
         HS4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792575000; x=1793179800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=talS54amiPg/yZGwEbzg0hMRny1RlU7saCiWAuyBxB4=;
        b=ZY49XlYvkhICPRBe2JG4Q3PM7VqkH7EG6aWGw/ZuNk0oUOs8k3O7wWU8gJrbbBLO1W
         xIUqM8WwjtI6eXZv1Vz2y+zaIjU3c9IaYq5p+fTBB48GvldKdsG+JFqeUdASzQ9vTVgl
         vXAU04XQZcEZrylEHAqa17XOoHzJ9kiYCYcS6Wh4ygI53TrhyVSb1iXAtfAzq5UcPYks
         q5KSDXCbjHUpCLpYPUeaVPEnZf3JG7mQeQGd32h+JmesYw7eGG43aNflptWoZSFJZQD6
         W4HOelzmZUvi8wp7pOkKNa0hjH5cd9SOfqqu8bHMokG3mnui7hwuH6VE5aF7T/LUUfgE
         6G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792575000; x=1793179800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=talS54amiPg/yZGwEbzg0hMRny1RlU7saCiWAuyBxB4=;
        b=GfRpipc9dhNJl+ItnERJlX7/3Qs0NxHfsSmxowTS79vBYzsROgqPlI80pf54sy9Wn3
         4wJaF64PIGN5F5EVRW+T8wb1XncmxkxjfO98A82Yimqy0o19hulKQCsw5RIEZ+Bi5vot
         MOtgfkQjtCYo/SaRs+MkCNm7737Jzy2UJtUdhlJIdmfbzXNEfEyrf/xd15zi9Xm9tHAw
         tsnDbh0R1BsFMk3Gk6BJ3or2EbviBzJ1EHGyI3YjgsyfgjdgCNMB2VI0COLWVvWRtsl/
         nV+SvaJkOpGAW6Dw9F/oGxuV/d+98UrXhdxS5CsQIBkvNWVxXgI8lJwEvtjV+Qex9yo2
         fbyg==
X-Forwarded-Encrypted: i=1; AKwUvByD5tmSdGPzbKeh1k/kKKy4biZWBfbEWAL6TaQMEOoUL/ZlfZe7u2p6U5ggyGhMTLojoVsmfOU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxSndr/S3Gwjc9aQt9UL4RsGl8FLj6SHt4fJW7c8XuSN9OLe8C
	YFYz1aUoi7DqeQPKa9aQWLXeg6pOsi99CxFb/mXwwJwYrKk5x3H5xlX4HRkJn/TToIgVSPkFEIB
	ihrLR4rlF0wFrMPfyF1+qLrY/bfO2o7Q=
X-Gm-Gg: AYBFou1U941o/d2CrTA+ncwqazPBpjb+5HCvmFtes9WGYYrmSIgGKm+l0xXBtgk6JqU
	f6IoLIAm5rId9AJ+/9o6j4sd58aCRZyjctlRKwh7u+2b7WYkBdyN15Vkeks9T8+1UCJjRUtYAEf
	dW+aQQBVIGwolvJGvv82btY/RJ6//iobVT2pOE3dBYLAMwAYFmapj2E+YSf0dqgnnr4cDwrDf59
	bRjsuxqbnyQkherTHV9+LohgNtMZAJIk1CXWZDcRgcs7lMuq1zeZKJr5bJvMQTmnxDX1+p3+PyA
	1iLLSAxfwYES2ETtVliorrFaKTa/B6pTz1TTVTs+LYoSfTM5OFKzaQ/kcl40Y1TMB3XfMohMzc+
	dPp080rlc6QRvAQ9L5E90i4VD1O597e7VIwYEphKW0Cnneu+rw1t9dyaaXZ0TshC5g+YS/DaQi+
	a3VZS8CifEH9g=
X-Received: by 2002:a17:907:3e19:b0:c25:3ec4:9e43 with SMTP id
 a640c23a62f3a-c4678f61921mr142113866b.0.1792574999375; Wed, 21 Oct 2026
 02:29:59 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021065517.198322-1-theodorlarionov@gmail.com>
In-Reply-To: <20261021065517.198322-1-theodorlarionov@gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 21 Oct 2026 17:29:47 +0800
X-Gm-Features: AclHuK_hzep8ZH3TrnvsmRxGfKoygxUVcd_QNcavMfo3m4kxyL8buVoj_sOJOoc
Message-ID: <CAAo+4rURfY514Adv6Qg8SsoRofANzAeY2c-qUYOhmr_r4U_o2Q@mail.gmail.com>
Subject: Re: [PATCH net v2] fou: reserve headroom before pushing the encap header
To: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:55=E2=80=AFPM Theodor Arsenij Larionov Trichkine
<theodorlarionov@gmail.com> wrote:
>
> ip_tunnel_xmit() and ip_md_tunnel_xmit() call ip_tunnel_encap() before
> reserving headroom. A packet redirected into the tunnel (tc mirred, nft
> fwd) has only the headroom of its original device, so fou_build_udp()
> hits skb_under_panic(); with a mirred mirror the push overwrites the
> Ethernet header of the original packet.
>
> Reserve the headroom in fou_build_header() and gue_build_header(). GUE
> sizes and builds the header from one copy of the encap config, which
> can change concurrently. As the skb head may move, ip_tunnel_xmit() and
> ip_md_tunnel_xmit() reload inner_iph after ip_tunnel_encap(), and
> ip_tunnel_xmit() reads tnl_params before it: for GRE with header_ops,
> tnl_params points into the head.
>
> Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp e=
ncapsulation")
> Fixes: ac931d4cdec3 ("ipip,ip_tunnel,sit: Add FOU support for externally =
controlled ipip devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.=
com>
> ---
> v2: move the headroom reservation into {fou,gue}_build_header(), reload
> inner_iph after ip_tunnel_encap() and read tnl_params before it, which
> the Sashiko review of v1 pointed out.
> v1: https://lore.kernel.org/netdev/20261010223601.1193655-1-theodorlarion=
ov@gmail.com/
>
> Chengfeng Ye posted an earlier series for this bug; this takes the
> builder approach Paolo suggested.
> Link: https://lore.kernel.org/netdev/20260904165544.1362052-1-nicoyip.dev=
@gmail.com/

My v1/v2 [1][2] reserved the headroom in gue_build_header(), close to
what this patch does. Ido objected to that [3]: the caller of
ip_tunnel_encap() is expected to reserve encap_hlen() bytes, and an
skb_cow_head() in build_header() forces every caller to refresh
pointers into skb->head. I moved the fix into ip_tunnel_xmit() for
v3/v4 as Ido suggested, and wait for the IPv6 part [4] to be accepted first=
.
That patch is changes-requested, and Paolo said the IPv6 side should become
an RCU conversion targeting net-next [5].

I'm fine with either approach, and will drop my v4 if this patch is taken.

If this version is applied, I'd appreciate a Reported-by, as I first
reported the bug in [1]:

Reported-by: Chengfeng Ye <nicoyip.dev@gmail.com>
Closes: https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.dev=
@gmail.com/

[1] https://lore.kernel.org/netdev/20260801060115.3538849-1-nicoyip.dev@gma=
il.com/
[2] https://lore.kernel.org/netdev/20260821145908.2829132-1-nicoyip.dev@gma=
il.com/
[3] https://lore.kernel.org/netdev/20260824075011.GA858321@shredder/
[4] https://lore.kernel.org/netdev/2ce8f3e4bbed6060afb0aee33dc4e1d9ae021280=
.1788262122.git.petalzu987@gmail.com/
[5] https://lore.kernel.org/netdev/e651fe9e-2d84-4320-99a1-6fddcfc00889@red=
hat.com/

>  net/ipv4/fou_core.c  | 15 +++++++++++----
>  net/ipv4/ip_tunnel.c |  6 ++++--
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
> index 076fdca44f51..896e63adf698 100644
> --- a/net/ipv4/fou_core.c
> +++ b/net/ipv4/fou_core.c
> @@ -1059,6 +1059,9 @@ static int fou_build_header(struct sk_buff *skb, st=
ruct ip_tunnel_encap *e,
>         __be16 sport;
>         int err;
>
> +       if (skb_cow_head(skb, fou_encap_hlen(e)))
> +               return -ENOMEM;
> +
>         err =3D __fou_build_header(skb, e, protocol, &sport, type);
>         if (err)
>                 return err;
> @@ -1071,16 +1074,20 @@ static int fou_build_header(struct sk_buff *skb, =
struct ip_tunnel_encap *e,
>  static int gue_build_header(struct sk_buff *skb, struct ip_tunnel_encap =
*e,
>                             u8 *protocol, struct flowi4 *fl4)
>  {
> -       int type =3D e->flags & TUNNEL_ENCAP_FLAG_CSUM ? SKB_GSO_UDP_TUNN=
EL_CSUM :
> -                                                      SKB_GSO_UDP_TUNNEL=
;
> +       struct ip_tunnel_encap encap =3D READ_ONCE(*e);
> +       int type =3D encap.flags & TUNNEL_ENCAP_FLAG_CSUM ?
> +                  SKB_GSO_UDP_TUNNEL_CSUM : SKB_GSO_UDP_TUNNEL;
>         __be16 sport;
>         int err;
>
> -       err =3D __gue_build_header(skb, e, protocol, &sport, type);
> +       if (skb_cow_head(skb, gue_encap_hlen(&encap)))
> +               return -ENOMEM;
> +
> +       err =3D __gue_build_header(skb, &encap, protocol, &sport, type);
>         if (err)
>                 return err;
>
> -       fou_build_udp(skb, e, fl4, protocol, sport);
> +       fou_build_udp(skb, &encap, fl4, protocol, sport);
>
>         return 0;
>  }
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0..742c2b309608 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -606,6 +606,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct ne=
t_device *dev,
>
>         if (ip_tunnel_encap(skb, &tun_info->encap, &proto, &fl4) < 0)
>                 goto tx_error;
> +       inner_iph =3D (const struct iphdr *)skb_inner_network_header(skb)=
;
>
>         use_cache =3D ip_tunnel_dst_cache_usable(skb, tun_info);
>         if (use_cache)
> @@ -749,6 +750,8 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_d=
evice *dev,
>         }
>
>         tos =3D tnl_params->tos;
> +       df =3D tnl_params->frag_off;
> +       ttl =3D tnl_params->ttl;
>         if (tos & 0x1) {
>                 tos &=3D ~0x1;
>                 if (payload_protocol =3D=3D htons(ETH_P_IP)) {
> @@ -767,6 +770,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_d=
evice *dev,
>
>         if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
>                 goto tx_error;
> +       inner_iph =3D (const struct iphdr *)skb_inner_network_header(skb)=
;
>
>         if (connected && md) {
>                 use_cache =3D ip_tunnel_dst_cache_usable(skb, tun_info);
> @@ -799,7 +803,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_d=
evice *dev,
>                 goto tx_error;
>         }
>
> -       df =3D tnl_params->frag_off;
>         if (payload_protocol =3D=3D htons(ETH_P_IP) && !tunnel->ignore_df=
)
>                 df |=3D (inner_iph->frag_off & htons(IP_DF));
>
> @@ -821,7 +824,6 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_d=
evice *dev,
>         }
>
>         tos =3D ip_tunnel_ecn_encap(tos, inner_iph, skb);
> -       ttl =3D tnl_params->ttl;
>         if (ttl =3D=3D 0) {
>                 if (payload_protocol =3D=3D htons(ETH_P_IP))
>                         ttl =3D inner_iph->ttl;
> --
> 2.34.1
>

Thanks,
Chengfeng
