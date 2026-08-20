Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171CC47D93E
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244819; cv=pass; b=vAdauSijz7R7IveUvc9IzJtLxi8IosEddq0QNpzK5WASvaJpENDWdS6UpsLUvwBnEfZPIg4uyDIXT05pvyZzhYIjxtaLCFmT0rMn93g0FHc7MkUHrNVLihaElI7nSoBIRMJ/6oROjNTzZLqjZ17AxWxwUF1F2llpQjZ7QWWhcd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244819; c=relaxed/simple;
	bh=opv+LcA4ZOcz1hOTwwMwu8TEujjGyrr+wXGQrHmuxS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/jYbd4mrtAZcpzU516Nr6HZL/wmeTmVHD7sQ7PHFfycfGZv9+W7SRVa+2dXtTvpVKusbo+MOYNoev4Ydz56MI9aFCW2J45PsRWpCa+TDrAuxGP4rYdp+lNf8dg+aj7ZZ3UO78igFkXHtegTL7NPtyBDnuJxAyLBg+4LpDNWB+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3VaW6cH; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3VaW6cH"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52d5bfa4bafso24431911cf.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787244816; cv=none;
        d=google.com; s=arc-20260327;
        b=ItKRVH/iokV2BUuIUx1DjMZUPivgYJiax/kTzPScseRbqwMyDoVccd1INadEskpg1B
         v0QpMrjEsVu51uTT3TWglhiXSqgqf7CQn3K+lFWzNyX7Wsqc1m7RilyNMGuzCVoqhbYr
         GGZOo9SOQt1VfBpIaVCzzOEedu0o9LiZUlfgiVzcueO2p9pkjeFlEhQOzHQR0FsbKX2h
         Qb0ToYWVo/ZVMyhvUjc/2ILT8qzxkEghaYYr4tOCs0O2++XBWJ3LJnENvp3Ek5VVTFee
         1Pim4TMHqrtZ5UdsRaWq5VEeBbkv+SU5MH6Zdtx1GjQPgclDMDtad0p+MoXg/BpByJUx
         wMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGH/yJHkK3M0IjwHdyO54yj9vy1LgGP/hn2OsWlWuBY=;
        fh=C/VvdyHOFvcX5OvlLOTOlhimWzC7lIXdi1Ro7XvgWw8=;
        b=PqJPR8H7wioTVoYj+AJCHFy9NjY2vCXqBEZe40093QUEA74SIsiEa1RMTEVjHB1/3q
         K4bLGnC6yvRfwUwnvqYz6JqKUdvpHozlCfayNFjlMwMt+Lh96U22camQvsFtLjm0EbY/
         tCvRrIdh5cyyg96xK5+i4lsg+HBlqzTeyF0xCjMypRnCTE7BY9cbwKz95k9nr3KYIQzK
         lPmtzaIj5kEXgOLavGXRaeCuDoX2K6GYb4+4OAVs26JatWZsaYE4TdaOI0g1/OM56HET
         Au2iWcEmknwTaB1KaA7J8kLWQdgi82tBCraDjGQJLYXsbdpJhEVHBFQHiR6krBNZh5ks
         uYlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787244816; x=1787849616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGH/yJHkK3M0IjwHdyO54yj9vy1LgGP/hn2OsWlWuBY=;
        b=c3VaW6cH/RmcBLe5Q7owLG4Phz5yK5JoA/uuZzRoBbPVsOCV6ixO1lDMjRI0/f5yQQ
         g0KSm69gsaK8kFhSgXFn1II6Tp5+wgnHszxwwC7SVUUw6MMgR60+lglwQm2RUAaL7ZO5
         GrD8QJWMh9KJi0iIec3t+S8hFLxvqDdyNlGiT7msdLi81XtmOV7hXHX/ZFHw6GrnBY7F
         ShTzrRg8Qrmn+STSiPh0Ra0KFmHTx28f0FN3GkhfkC1Hx73xNXssnza+Mq84pRNk/B7W
         +YYWHKjRwaFY6M7HC61LgBWJROVVJNBEt4sl+uP/r8jIF2TwitzFak0l58VIpHJRhMUc
         s5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244816; x=1787849616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGH/yJHkK3M0IjwHdyO54yj9vy1LgGP/hn2OsWlWuBY=;
        b=nDNPrnZlTTZWVXa8iUuElgkU8UXqyHFmEW6kv5yXEtZWN9j2Zb1HX3EoTk/RBAUIUM
         zHSrWV4op0UNnnbFHMiu4uqdcpfwfpQh4JAAdocyo99wyU5YMHNFdiogzaJoKiXwNqu/
         mskq6EFxHtwzyYnyXxGhBc2ddZnN19vM8DQU+DJWTlVXzpOWPObh99b6PW96Sa3koswR
         kapyeuZGeeF/3Ac8/jszhS/d6zOts6FTo0ZOo5gNlutg/qUsdMI4nSmadCHEsR1p+93G
         UkEIZZ0IPvLXdvpCZyqqRPKdxAte49Vosock01tccUb2eH6TZfQrieFyizOGFrkcmom7
         putQ==
X-Gm-Message-State: AOJu0Ywjqc2bFCHqaan7ytX+4dRsa7hI5McJqr+SI8Kl94NGFRd4lveb
	ofBR/zN0v5emg+R5B1TSknK8hpYxD+2P4a0ofKfHGbBBeOFpSU57Gq4dh7CAbhpBXIAjuhOmZyX
	fPFj/iDR036zBA6WVCHFZMlJSUZqh/1zbDGI205O0
X-Gm-Gg: AR+sD11YRT1g8Q+6dD+jCSsOYcT4Su1YNqa3jkaqtn5l/xUL1ceA+hwlshkGmVFwVM0
	Fo1jR4DwPjxjMIhSQiA/l9kWX61viV80F5MgS23BCr39MMe02umsfBhxHBIlEcqcKGrExdqHXt7
	ktd/PtB+4Lnj4US83o9iiotU4zc3WNph4EfdajGslhnyzpuKPVuVPJFg+2DN0P9f/NwhxUx5cC2
	+oW/HRwyD694JtGpwIC2kNKzIm7s7KSPX0ZMclthnNUJ9nH2AI1GEIlqepl1/jVdW9++ai6RPp0
	TzRpmEYNHFQ0pKGQLHc8GGtRPJim6KyxaLhSwmVd39XOOTswoktssVTTNzLDcsRlmSzqttAGAFd
	5oCYIvxxNb9Xsi6NNizujELxkNfQJP4bGd5IdMmCZ1BiLj4Bc7inb7QGeXw==
X-Received: by 2002:ac8:5f0b:0:b0:52d:2ddd:27c with SMTP id
 d75a77b69052e-52dd5cb09c7mr113827831cf.31.1787244815224; Thu, 20 Aug 2026
 09:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817153957.3177627-1-poros@redhat.com>
In-Reply-To: <20260817153957.3177627-1-poros@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Aug 2026 18:53:23 +0200
X-Gm-Features: AcwNN1Xb91DpV9WY_Q-Z2-aLqA5VqqqNBYRmDzZhkVHQO2OraLaV1QOhEcvG8-s
Message-ID: <CANn89iKZe5reKy5uNxF7_G2=zytnPjWCUn+bX7-iGdJuTjBgMw@mail.gmail.com>
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 5:40=E2=80=AFPM Petr Oros <poros@redhat.com> wrote:
>
> __dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does not,
> so a frame taking the qdisc bypass path reaches ndo_start_xmit() with
> the sentinel left by __finalize_skb_around() and skb_mac_header() points
> 65535 bytes past skb->head.
>
> The packet socket reaches it through packet_direct_xmit(), and
> packet_parse_headers() was taught to anchor the header by
> commit c2707480cfbf ("net/packet: reset the MAC header on the
> packet-socket transmit path"). AF_XDP reaches it through
> __xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.
>
> ice reads eth->h_proto through skb_mac_header() on its ordinary Tx path.
> On an E810 every one of 2817224 AF_XDP frames reached the driver with the
> sentinel still in place, so the ethertype never came from the frame. With
> this patch all 5757920 frames of the same test carried the correct 0x88b5=
.
> An AF_PACKET sender on the same port read 0x88b5 in both runs.
>
> On a KFENCE kernel that read lands inside the pool and gets reported as a
> use after free of an unrelated object, 387 times in a 180 s run:
>
>         BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xddb/0x1=
650 [ice]
>          ice_xmit_frame_ring+0xddb/0x1650 [ice]
>          __dev_direct_xmit+0x347/0x4d0
>          __xsk_generic_xmit+0xc13/0x1e70
>          __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
>          xsk_sendmsg+0x6c/0x90
>
> Rerunning the same reproducer on the same E810 with this patch applied
> produced no reports and no bad reads.
>
> Anchor the header in xsk_skb_init_misc(), which runs once per skb for
> both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not a
> real header, but it stays in bounds and no such driver reads it.
>
> Fixes: 35fcde7f8deb ("xsk: support for Tx")
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  net/xdp/xsk.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7855ee09c4b640..885427392cb6b3 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *skb, str=
uct xdp_sock *xs,
>         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
>         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
>         skb->destructor =3D xsk_destruct_skb;
> +       skb_reset_mac_header(skb);

I don't know, I had at some point the goal of removing our dependency
on mac header in ndo_start_xmit(),
as this must be skb->data.

ice could use skb_eth_hdr() instead of eth_hdr() or skb_mac_header()
and save few cycles.

Some drivers call skb_reset_mac_header(skb), this is really a mess.

With AI these days, it should not be too hard to completely remove our
dependency on mac_header.
