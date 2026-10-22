Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792685870;
	b=Z70Flqb8hytk9BgpGGfs56K7Lx14lgQQQi/4V6LXGCgCnhinG0dtDm5VV4Oxaowa4ES1
	 IAdEjwm3BGJ5jGBuIVgVAS6Rga+oCf2aNWAvd/Y+ycV922nXBiGj/NMWh4V9Q3ljhWZaW
	 elkZThcAT8KkKKAedDzANPjhxpQ+Vs+5a0/GLWYdV0fVC82TtpHb1IFfjFC9KsGYKd9YV
	 wZUqLmYFYsqcve9vvDMV71Qpg4u+9+7Z8hCrQnQCZPUvqifxMXp2HUCJPlXwhLNAckJlb
	 ENSy+gJ7aErNvIDI3UJVD4zoDIsxHA4RR7MvMYqTvO5gFGjLrlbly0iuwmj+8cRTbZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ms9np8acRDIjcChjTD82wOHEoaKI9XRh/myC0U9P134=;
	b=TnzY9bpLt192aHGo5eSzIXKGIgONyNV4I8GU4FgmUFgqIHX5Qdxlo+TI1LadjfeOoQSJ
	 r9qOv3e/KLSfdD4jKhJNIW7/Q7vR4a9Iysa0/oRY2fGRXWU+SKBE8XrP8PqYQzLlaBsc5
	 wwACMs6O/qUalPID8BjMwCVvQWpsFbdNAcjSOGwvMr2eqDSR5dccyyIK7RgUnR8+nbZhp
	 dVEN4jg+SETwwPS6VXwHj9f9JO8OpZZCCE22Qxkn5S40Xk9AVTOY4QZX/cOfV6ni37God
	 PQcfk1byGZDf1GCvwroCQ8S/Qb0VWScW254gAitC+8YjYqoaqmeiZr80qV/mlpY1LIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=X5JSXNOE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23B606A31A
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 16:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F23B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=X5JSXNOE
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8a264b6a06bso15280b3a.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 09:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792685868; cv=none;
        d=google.com; s=arc-20260327;
        b=o5ho66s5wgikN6lIhOxtDsrGfDurLNaAYXNx7ylW7kwhM5eUhYZOQTpOu7d0FBFSgJ
         1MrLC5jaH9U77p7j3qJiiyGb+XaEVxvhAJz3PEKjH5J4caN+69Chqf5JQjfNskYPIrmi
         DSVnYwFdXqBVJuOIU2Xpf2L5vziOgZNp8vNrN4xA1ceI27iSsljeUPYRK0PwPZBskWME
         2Ycc4/qiJmwNTNboh3ohiT9WKBfrt+1k3voHDq3JAYW7D/B2Rmfm87uABnDJYPoUz3zP
         M1ih6UtboLgCUyyd0jTTw+u7BnqzTmVhmphf5yJpUMd7/06gJfCkZ7xrh/KtHLbXqcIz
         u5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ms9np8acRDIjcChjTD82wOHEoaKI9XRh/myC0U9P134=;
        fh=vNEf1C34bv2YeyCLi5/f9Zeq8qfse05Lm6Ve1n+dlbU=;
        b=qYAu558DiVGQi7YW98pfzzE5+2jSSyxqVNscj9Oc0dpQhD+ujQvO6yj3xQ3KAxULlw
         jpUjbZXdupQZWKisRw3MFGLA6O6h48pfhslJ0NPyPP3rOhSMUVqgPprtipoXFbU8opni
         QYUsqqIk3TW1abNgd71WQaCCe/0+waAmoCm2c+sDKQs7+bgoJfSZ4szpIIZGqRgyhDcg
         lf4HYawGJRJjttdsVu15pv5Oq2QYch2vQOv2TonJvw3jrLK2UCejUh5xn/34Nk3M0Wgx
         OG/W9F+FvR1SQiM+jtPYRPkGydiwTgssO6MEfdLPLRvyy6hDQth+nQerMcW/JEnKxyCe
         o3hA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792685868; x=1793290668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ms9np8acRDIjcChjTD82wOHEoaKI9XRh/myC0U9P134=;
        b=X5JSXNOEc5Vv420YTpmU527PofhO2y8Pp4UOv2V4oENqDjwEhM+iuXwNSe4YPkRsSs
         PxEryo0QZEIXwpJmKBbMEztwjC6FfWGVfessSwPTIywro4GVq5LyIEUgLS3+suNxlWCN
         KT01o71elxhI7F6Ybf18iz96qELABTOErlopU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685868; x=1793290668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ms9np8acRDIjcChjTD82wOHEoaKI9XRh/myC0U9P134=;
        b=hBBI2Jpsbyhu4nR7Hl/fjRsVLyo2tmUnJM8aGUfpka8OJVwaPGpAgLVXgS2sXOU4ON
         QgWZGOrOZLzOU6YkB+VgH8gnSNhQtBG+/3txyW4Cz84lk/hjGnmvCX8vvv+HUXq657fy
         nsaIex9gGlHoeS7oaDtw7U7nV7BjtGd/gnWZYCA8LJHvsVq5qHhZYeaVHnmhJUiIsOjP
         4rSJ/Lo2d5betlfVk4+HzdNQ0xb54CabnYYcRvNokbPusaJUOsqerhl0EZJ1gMW1pSgR
         jOg7nr7ouMZZKZrXLImRwMYp/RQLQDzi4XC4kwblMM9mi5CaQSg5S1YUj8hPakVtI5Gu
         apqA==
X-Gm-Message-State: AFq9FYKVY6Gv1CCQFv0NUGkMrIDKoMXhMnTw/Wu3+AGJgxGktBUQcTdC
	r3PhzhiJlSzTmvnl4MNDp5AmXxD3y1f+F2BM9l3lYtRhGHCGvkpxi48bRYrL5pR85VRietFRGGf
	XdXrkeTYEjAR8TSuYfuLgIRr0BBZrf2BfgKc9lpYL
X-Gm-Gg: AYBFou0jsb20JNBy1QQhmRAxOrnre7gK15WRgj8Iohf5Lg9WxOm0BmjIQ8B3rNrI2X0
	gcvauM18PskAEVjb3C3FjugFbEz3gGpdl2ALrf84i9nXuTAZzfucIPn5GZjrcSWHFNqT/ludj2U
	uELV6iectQHEQ6rEN3QAe1xLLWYflnmYkMEW3oyY65A+s0HWz1YNdxzcyWC7QjrEfROyo+zLhOM
	AN/rBbWq1vwe12CwclVjKFBxpE5sdMuP/Wfo4NZ2TcymmYnIb+Od0ytsPZaPnnRp0smlemVw1it
	GD2mxMnz4EhMX2FKxwBI2GRXZPVfV4Gc8lvGgLX5TJ4q6Vr0Lo8Inq0zmg8/rcXHVX5+cuOgnPY
	oHh56l7AvEtGJ/InJ5eJHmUtnX28U5orErPqlCZ0pVqXTQzjV6g5K+fq2Y0uqXfySvLKFSfw3it
	i7I1xj1mbjJEhhRHg=
X-Received: by 2002:a05:6a00:a24e:b0:886:84c7:72b3 with SMTP id
 d2e1a72fcca58-8a089d340famr4954139b3a.26.1792685868305; Thu, 22 Oct 2026
 09:17:48 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v1.r0.20261022051412@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-1@mojatatu.com>
 <ACT-N6N4.v1.r0.20261022051412-2@mojatatu.com> <ACT-N6N4.v1.r0.20261022051412-3@mojatatu.com>
 <willemdebruijn.kernel.1c05560ef167@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1c05560ef167@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 22 Oct 2026 12:17:36 -0400
X-Gm-Features: AclHuK90a_fLh211CG2JNlvlKpUC5VtT1JKVs_mlSRyBwFYzOdwvch_anYMODbQ
Message-ID: <CAM0EoMmeOCQT8dRYKvfYa0EUtEsLM6EZcNCsQZSF+HfoK61Y2w@mail.gmail.com>
Subject: Re: [PATCH net 3/5] net: tun: keep TUN short linear copy hints safe
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rusty Russell <rusty@rustcorp.com.au>, Max Krasnyansky <maxk@qualcomm.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 11:22=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jamal Hadi Salim wrote:
> > The issue:
> > A TUN skb can be redirected by tc mirred to an Ethernet xmit path, whic=
h
> > calls eth_type_trans() and needs a full Ethernet header in the linear
> > area.  tun_get_user() currently validates len and the GSO header length
> > only for IFF_TAP, so an IFF_TUN | IFF_VNET_HDR packet can set hdr_len t=
o
> > 1..13 and leave fewer than ETH_HLEN linear bytes.  The redirected packe=
t
> > then BUGs in eth_type_trans().
>
> TUN mode does not imply Ethernet. Indeed, TUN implies an L3 packet?

I have a feeling i am missing something: True, TUN is L3  but we are
not adding or parsing eth headers to TUN.

The patch only bounds the linear copy hint and receive headroom so a
TUN skb redirected by tc to an some ethernet xmit path satisfies
eth_type_trans()'s precondition in the patchset. IOW, with current
code does it matter if TUN is l3? The other side will assume the
payload to be ethernet..
If the redirect itself should be rejected for TUN, that is a different
fix; earlier ask from Eric is to fix the producer not for example the
driver (like loopback).
The "reject redirect from TUN" could probably be done but i dont see a
cheap way of doing it.

Thoughts?

cheers,
jamal
> >
> > The Fix:
> > Reject packets shorter than ETH_HLEN in both modes.  For IFF_TUN, where
> > hdr_len is only an allocation/copy hint when GSO and checksum offload a=
re
> > off, raise a short nonzero hdr_len to ETH_HLEN instead of rejecting the
> > write.  Keep the TAP rejection and its NET_IP_ALIGN adjustment unchange=
d.
> > This preserves valid no-offload TUN writes with hints below ETH_HLEN wh=
ile
> > guaranteeing at least ETH_HLEN linear bytes for the redirected consumer=
.
> >
> > The maximum receive headroom advertised through tun_set_headroom() must
> > reserve the same linear minimum.  A large upper-device needed_headroom
> > (for example an L2 netkit port behind a VLAN in an OVS datapath) otherw=
ise
> > caps good_linear below ETH_HLEN and defeats the clamp.  Reserve ETH_HLE=
N
> > for TUN; the TAP branch already reserves ETH_HLEN + NET_IP_ALIGN.
> >
> > Conditions to recreate the bug (repro available):
> > - create a TUN device with IFF_TUN | IFF_VNET_HDR | IFF_NO_PI;
> > - attach ingress mirred egress redirect dev lo;
> > - write a virtio_net_hdr with hdr_len=3D1 and an 8192-byte payload.
> > Unfixed kernel will panic in eth_type_trans via loopback_xmit.
> > In a fixed kernel the write is accepted with hdr_len clamped to ETH_HLE=
N and the
> > packet is forwarded without a BUG.
> > - no-offload acceptance: a separate check writes a 28-byte IPv4/UDP-sha=
ped
> >   packet with hdr_len 0, 1, 13, 14 and 20; all writes are accepted.
> > - high headroom: create an L2 netkit pair with headroom 4096, put a VLA=
N
> >   over it, and add both the VLAN and the TUN to one OVS datapath so the
> >   TUN receive headroom is raised to 4100.  The same hdr_len=3D1 jumbo m=
ust
> >   keep at least ETH_HLEN linear bytes; without the setter reservation i=
t
> >   still BUGs.
> >
> > Fixes: f42157cb568c ("tun: fallback if skb_alloc() fails on big packets=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  drivers/net/tun.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> > index 242899f7fd07..1e235c2f0aee 100644
> > --- a/drivers/net/tun.c
> > +++ b/drivers/net/tun.c
> > @@ -1193,7 +1193,7 @@ static void tun_set_headroom(struct net_device *d=
ev, int new_hr)
> >       if ((tun->flags & TUN_TYPE_MASK) =3D=3D IFF_TAP)
> >               max_headroom -=3D ETH_HLEN + NET_IP_ALIGN;
> >       else
> > -             max_headroom -=3D 1;
> > +             max_headroom -=3D ETH_HLEN;
> >
> >       tun->align =3D clamp_t(int, new_hr, NET_SKB_PAD, max_headroom);
> >  }
> > @@ -1830,6 +1830,11 @@ static ssize_t tun_get_user(struct tun_struct *t=
un, struct tun_file *tfile,
> >               align +=3D NET_IP_ALIGN;
> >               if (unlikely(len < ETH_HLEN || (hdr_len && hdr_len < ETH_=
HLEN)))
> >                       return -EINVAL;
> > +     } else {
> > +             if (unlikely(len < ETH_HLEN))
> > +                     return -EINVAL;
> > +             if (hdr_len)
> > +                     hdr_len =3D max_t(int, hdr_len, ETH_HLEN);
> >       }
> >
> >       good_linear =3D SKB_MAX_HEAD(align);
> > --
> > 2.43.0
> >
>
>
