Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793453540;
	b=MpAo9XPyeoGpwsiI+NBQYgn3ft9myb0iH0jtfZlol4RcrubXWFYAgp6ZYq/1SSA4x3pv
	 YaGIkGMURDgntAXxWGmNKcqGmeH0k3RU8wnRoMYNv4ahI/MywO2iT10Kgxk9rpUrfmtmy
	 WGhf42l3IcW4yarRATXQpj62G+tk02fk6h4eEvsX1ua6kGjGu9Rrbm3TBCfDiG9uRuCZl
	 jCrjnGVk8u48BsXrCvrhhpZ9owaCbRhkDROhXGeBJGqLl6q6yM9b3BUUDAWp3Nvj2rspD
	 3i5QYscwHqm0qv/3vTZC7vUjDgBEsFoP1SxsiTKHzoBYes4ZBxWa5wukd+wDLdYU64A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
	b=pA+Fo0N7BxFD/TEhPfpEs2YiU3beAZFPmMCZF4Of2tE6MoXDkNv+i3ENUDJT2rc/gVXp
	 DL2NGQS2vAWE5UGBLeTY911oi3/li4Q+l0HQysHvtQk2efGPj7BL5XwvW+MFXavQ1Uf2f
	 g/rWULTLFckCzA2my0uFEFZun8oeQOpvkk+lEQiOKzbBJlZwEMx9jJzzRNRAf6zRgpTL9
	 QmoxXgxoaEbzNEYCAzVFW/kteoBWCi/HcS7A6WaL0RzBumaG2sDzUu0f8tn0uwruQNleb
	 yqwZDLOxcQQxH6HImcFWhHw7xFlrgl3vx8McwqL3GLjr+Hfmj0OA+leOYspH78489Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XKnOjMRP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F1606A31A
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 13:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E9F1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=XKnOjMRP
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a07078200fso668432b3a.2
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 06:32:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793453538; cv=none;
        d=google.com; s=arc-20260327;
        b=FhPV+9RsTZqMbd/7JDQ90nl58vBSPV3HFZERWOJYTy02Jyx8/jPIT527eInKjSPxcx
         ksx7y0vdYEdVhQI7aQ6lne1/UD8kwrmhjF+FmupMdNSVmnJOJdDqboXhDGLhIQ3ztV82
         Qu/QfMFMCQwNcvG2RP5x2Caflp74aIUNoOOH0v9oV9TaiZpYpTqphoNs69nEqQkxiprt
         0fewXU55puMAEu5V2E6ZQdjn2xAn7oxmMk09ObiBsVcZdsqNRN71TThLRq7SwA9DhF1p
         sx1dL4gzqmWbeC5vI+bFbkLoB0fS2kq8BYMnAB0ic/ZmKndyP7D9B8sknAs7CZbUy3DK
         iGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
        fh=7QJ9Eis0yvJCrNSsu/t2OUGiYu1/fN7HYuUaSoTARCk=;
        b=JmK+Nt4oVzFKxT7iBteNbHSxmb2p2hfBimj9+FFAbTHeAi7Feuwu+pxrusf7BUlFrw
         R3yQGj+3hlG4zVvtiTVl8xbNKBRygpqNaKAO90jTw0l8eteaRQN6w5FitYTNa1GxAVJT
         Hq3ffFxBjIVxtSVnTyhrQzTRtm8T0816Y9AtI9n/9i29Zm8U5zCaHFBcyzrFfwNOsvfW
         V4wtcnEiaG+dOvnM1jYT9E9hGE2xUoEkTzbp8/fgjZ/cFAjykKJOtzHqscwMmpU9RwKW
         w6gJ0U98DmF/8OXMMNTeVVtAvpQXfQPyV5PKcCofr1WlHFJZO+fLph1ahixPO0dOF6dB
         YppA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793453538; x=1794058338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
        b=XKnOjMRPi1xowFEnisIR1z4LU2wkmPn460uIbnYFo262VHWeQFoTh/HoQdkw60dc1a
         1zdDrd+OqzuW41lm62mCj7dcoHFjgW2MOlHyj83i9lgrOZCcxL6XKUo55Ov0N0HUDQ5d
         EdoSbP9yfU2qWOluiS20Xn3hWPcx7/ZppJ26A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793453538; x=1794058338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QrhJINBYjJTT5louKFAwSUTUsf/5n1vYlK1qTtlzMCY=;
        b=Nv+Sb3P50/vcKHyQ7i071gLPoJD5dqTnDPHeC/1NJUJALCqNaIUHTMLQMDIeRa4lDf
         N1RRrSiRGDAbbpF1O+5YD1yvdArdGZbmZNTvDUjPrMDMmxG00mshMvjvxL6U4HtTiKqM
         1Hv3+JNLgV0r8nHARR48mk8tGl2qA+ybcqVHtkn0GJIszH8yERLMEkifsFVOuXl/YY8y
         NAJpGmU1rVhfVoBa7+8oqFwkGVGD2Q3ObIYcdics8nSv/Sn0bCDMlI48tyRW3Ml4vQD4
         YtyDZ7Opu54X7zLJMsmCR6r1w/y4+/2mVhdqTTw7o20Zo2dpbPm6VH+C3XUAiQXkLLOd
         tu0g==
X-Gm-Message-State: AFq9FYK0eGy7gWfJS+Hqr8rkgzbdi5cCvBJDz89ZnIkw1Y8TDHApSRuZ
	Ye/afEugW0puJE7ZbtSsUOo5vNmLw3bDy1xHZtBb2IzBJjrEWD0Dd5UFaMPygaLrhsYA2kaFGdr
	wHYhr4klJhtbXmmrjcFrFwkWoT+Iv+4L6st3cJ3/p
X-Gm-Gg: AYBFou1JLoChvDCDKEVg9qQUUmAO5ON7GRn9SNGQ0iKK5r0wv4y6WjmOxrIlXhShnr1
	0bOloKmMZWSN3uICYU5VTQW4kQ1YAYNFJs4LTUMheJnek85F2gEA7/YiTjWIbKVXDbx0x698Bwn
	ttst6BihYusT58fDbesEfm2bOITamiK+m2HZfc3VmPYFEvtZtOTjIRe5Yesx+h4gFigdICjqn8k
	b5STVP2ZUudn+WFpoDG31kQGO3gZw7Ukes4HYGSdht8eWuOBWiVyd40YeNz5veOrPeD9qz6XuUn
	/5LInWkhoCjeiicoKBu6l1sVBEWqEPdy+rzVTZbTxeFvVWwHnezz4oL8khBAbQ/C3MNLDWH7cGA
	uuY0moOU3QIUL/YrBWS/i19mpkbPohKtcAn/KyP0zszo2XZbUv51W+beCkdJFYZGw3eZ9u/3tw2
	3+2NXPPC5reWahL2g=
X-Received: by 2002:a05:6a00:4b12:b0:89e:fc56:a25e with SMTP id
 d2e1a72fcca58-8a9bfa02bd4mr4056675b3a.41.1793453538349; Sat, 31 Oct 2026
 06:32:18 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <bpf_redirect_neigh_short_linear.v2.r0.20261028080316-1@mojatatu.com>
 <DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com>
In-Reply-To: <DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Oct 2026 09:32:06 -0400
X-Gm-Features: AclHuK-ddqUaxwQGu_QsdsX_5VreQz3XrjlPaOLjbuJHGuyWX_YBYrjskp5eDDg
Message-ID: <CAM0EoMn7kvsfZbsOdU3jHiT1Ypc6OHHu_+empy=Fmu33Etfhug@mail.gmail.com>
Subject: Re: [PATCH net v2] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, bpf@vger.kernel.org, 
	bot+bpf-ci@kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	David Ahern <dsahern@gmail.com>, Martin KaFai Lau <kafai@fb.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, linux-kselftest@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:47=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Oct 29, 2026 at 02:36 AM Jamal Hadi Salim <jhs@mojatatu.com> wrot=
e:
> > Add egress coverage to tc_redirect_neigh: the existing test only attach=
es
> > redirect_neigh at ingress, where mac_len is populated.
>
> This test cannot hit the BUG.

It was reachable _before_ the fix, normally useful to include such tests.
I will drop it, but if you think it is still useful and you catch me
before i send v3 i can include it (or can be sent afterwards).


> Just drop it and respin as [PATCH bpf v3].
>

Will do a v3 sometimes today for below...

cheers,
jamal
> >  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device=
 *dev,
> >                               struct bpf_nh_params *nh)
> >  {
> > -     struct ethhdr *ethh =3D eth_hdr(skb);
> > +     struct ethhdr *ethh;
> >
> >       if (unlikely(skb->mac_header >=3D skb->network_header))
> >               goto out;
> > +     if (unlikely(skb_mac_header_len(skb) < ETH_HLEN ||
> > +                  !pskb_may_pull(skb, ETH_HLEN)))
> > +             goto out;
> > +     ethh =3D eth_hdr(skb);
>
> ETH_HLEN is not enough.
> __bpf_redirect_neigh_v4() and __bpf_redirect_neigh_v6() read ip_hdr()
> and ipv6_hdr() right after the pull. Nothing makes these headers linear.
> Take the AF_PACKET frame from the commit log without pop_eth and
> bpf_skb_change_head():
>
>   packet_snd()                     headlen =3D=3D 14, IP header in frags
>   skb_pull(skb, ETH_HLEN)          headlen =3D=3D 0
>   skb_reset_network_header(skb)    network header =3D=3D skb->tail
>   ip4h->daddr, ip4h->saddr         read past skb->tail
>
> The route lookup runs on garbage.
>
> Eric's skb_network_offset() check also covers
> mac_header >=3D network_header. No need for two checks.
>
> Something like this:
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2290,10 +2290,14 @@ static int bpf_out_neigh_v6(struct net *net, stru=
ct sk_buff *skb,
>  static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_devic=
e *dev,
>                                    struct bpf_nh_params *nh)
>  {
> -       const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
>         struct net *net =3D dev_net(dev);
>         int err, ret =3D NET_XMIT_DROP;
> +       const struct ipv6hdr *ip6h;
> +
> +       if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h))))
> +               goto out_drop;
> +       ip6h =3D ipv6_hdr(skb);
>
>         if (!nh) {
>                 struct dst_entry *dst;
>                 struct flowi6 fl6 =3D {
> @@ -2399,10 +2403,14 @@ static int bpf_out_neigh_v4(struct net *net, stru=
ct sk_buff *skb,
>  static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_devic=
e *dev,
>                                    struct bpf_nh_params *nh)
>  {
> -       const struct iphdr *ip4h =3D ip_hdr(skb);
>         struct net *net =3D dev_net(dev);
>         int err, ret =3D NET_XMIT_DROP;
> +       const struct iphdr *ip4h;
> +
> +       if (unlikely(!pskb_may_pull(skb, sizeof(*ip4h))))
> +               goto out_drop;
> +       ip4h =3D ip_hdr(skb);
>
>         if (!nh) {
>                 struct flowi4 fl4 =3D {
>                         .flowi4_flags =3D FLOWI_FLAG_ANYSRC,
> @@ -2451,15 +2459,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff=
 *skb, struct net_device *dev,
>  static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *=
dev,
>                                 struct bpf_nh_params *nh)
>  {
> -       struct ethhdr *ethh =3D eth_hdr(skb);
> -
> -       if (unlikely(skb->mac_header >=3D skb->network_header))
> +       if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
> +                    !pskb_may_pull(skb, ETH_HLEN)))
>                 goto out;
>         bpf_push_mac_rcsum(skb);
> -       if (is_multicast_ether_addr(ethh->h_dest))
> +       if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
>                 goto out;
>
> -       skb_pull(skb, sizeof(*ethh));
> +       skb_pull(skb, ETH_HLEN);
>         skb_unset_mac_header(skb);
>         skb_reset_network_header(skb);
>
>
> pw-bot: cr
