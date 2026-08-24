Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6F4071E3
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575627; cv=pass; b=E/ajGYgmrAjM3VxSQYN7JcT/SYlpptMZYrei9kVOZpmVsC9SON/UTSUMJu65b2S6GcWFCrqHik+dYhHPoeDukXOMqSXl3Rt+6iTMU9LLmboNlHcSF2dd1j3Uw5gTE5jlmX9+U3ZVqNuDXC/xKTjNY7PxxHBkOA+LZpCPFs06ptQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575627; c=relaxed/simple;
	bh=4COJ/OlUP+SCr/S798Xhf1yZIvDhD+7aGnyhtesl/uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6Qf32HzbKxa2l332YbpHZtoMvgKoETBJU8ycSnF5ss2qo91MR8QIk6U6o1PebTfVsfvXGD15Og+AekG0LtDIP/71Ww/DuB1ZlQCRFy9tfPS89Frcee93uQAUaR1/r4yqLuGybk7xcfUGrK1e1PQYgErjzLGHmnmWhPNQ47DiH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PogaCY+g; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PogaCY+g"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39f1ac13687so23173621fa.0
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 05:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787575624; cv=none;
        d=google.com; s=arc-20260327;
        b=Lbsen9uqnn32TIFqycdqWjeKXdN0Z6EOssu+h8rlHm9GgTGstKM7Vl0YO0CnybslqL
         KpVwxYNqHKy3AkK71Id5huRG6LFEz06IaVKvM8ZiPdWEGzye8H72xEKf3OKSmbyTGlEg
         cKAfgGQDzB+y0zdS5QwU+PP4ubDv6sVMnxSj9I/MS41JatY82BRCQLaxznOVljJdoQ/a
         kTqEgC1sAkFDK6YSCHYEJcvYoHdedd6JJc/NrLIDRe71yk/lcY5THH+GnJTCMhwvyLAk
         fd2DcejpaHMh9aQYnlAFA8RfrVAl1kw2NGy3OfCJRyoFy1agg8K1P7T3AApxRl+aWR5h
         hHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K1p6rRAQErXZWEgR6H+1l88QQvMLOqJ4TgP8gJ7V8kI=;
        fh=GI1kO1eK6eoOHsqPtxHx4EDWMTyMerBWZygPpwMQ9R0=;
        b=JxJ3KRhre5uK4qU4pFH4zcMGGi7lrFD7UujyFVTbGiC9kn5IdohTPIxy7JdAdnXvaD
         XLjjekS/ByCqUkbUScJs3rIj8cqDMfuu9leaoB7dDBLPzIXhRCHLiBjnN1mbD6Fp3wof
         Fym65qtikkcEU48iVTFiVh1vUxWVOLZjAPskwpBoPyu4vKsjEib8e+cKhS1PN+XDRLvE
         LoU/o7EkVdlj9wPqkMhJYq7djm18tcImD6+t3w0m+aGQL5vrUyW1e9J97KFMWWouAUfJ
         UTMHlRgQxWYghY7C4Ibw1bXoh0oXqdQZRx0NlzJPZ9q070c+wsxA58MtcTg1P5qRJ6Q4
         NrHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787575624; x=1788180424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K1p6rRAQErXZWEgR6H+1l88QQvMLOqJ4TgP8gJ7V8kI=;
        b=PogaCY+gf6S6o96HPv+f0AyhvjnYOg+064JSAMa/rrnH4sZTFPCvVF3kIz1jSIv97M
         ri2lPTaz+iSrVLd/W/+KfRQjw4AaVxHW0zPkj0xKcWTtGaSJGR546lsjdnFLkX3ZEF0m
         cA2ugDd4F43DttJ91JKMUpGz8xJfH5Hz1LQYGlKibNNKxxjt38NBn3Ejo87TJ6IU7wdn
         sUdXwCdaczKoppr8FTLHLPbgsvR2z4oCQMhPIbfmK/lt1WVaSsTcEeCy4oiVVv1H8Ao+
         TZN2WY8p1OrYEVofxEO8VXWmD6G/bVO00Hcn+VDaHJq1mgpcbHHRUpd/2fdbVG7e6XjT
         TZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787575624; x=1788180424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K1p6rRAQErXZWEgR6H+1l88QQvMLOqJ4TgP8gJ7V8kI=;
        b=Mb9PqUFbs5GBDPHF9jABa5zCTq87fpb0iyWjpfmol0YRHqy2DWqhKPXqZH3u4pHsli
         Gnll1RUGhpzCT+zq5U0neXwl6m4PGDZNCwCCQnJEvcy5Uz1GZ3VDFE/ntbFyO+35Xiza
         5Eg19WqzlBO2/pzMsXaT50mSZ0N8LLAS8yigMp0jTa7zt9ibS/G1UCX2XpLTWWPCnSGw
         /V3jUVvGKS70H0yDvXnQMAjX0nN+hqlZJCXhXUll4O+UgqiQOnOKw4x035zedDXNaaO1
         m9t77S9vsK0KYTryJm1bvjdTEXwBh10mucty9pFdCal0ej5C/oXe6Uv4W40zSIaXs5VG
         RsDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4cO5V8Px0NiDExG2xfLaBHWpd7z3e+7TwLx6F2lzNAFSdjydrUz/T/yR98quoGlbn+pPq4Dw=@vger.kernel.org
X-Gm-Message-State: AFuF++lcJ82SFJFBfcN8xFuMHLYTPMcnt3f96+6VZCR9StOJXjgmPZcp
	G2VPFPeT106oTQPffZQe+jHFWvgqU+PuDu2u26vUl73NSef0Qap1J3ZYzPJ27aygOEZStQ0mtCU
	2CFqMIkBWY/ThVlBz2nEWUd5ktPMzIjI=
X-Gm-Gg: AR+sD10h1wh5879SsrZQg19jJeD8UEci343AthNXp+iXvVwX+fL/A4ccfyFOQapX9zB
	lBrcZNd7kwccxhMp2hr2uIuDVpeZxZMtp3pf1MEKn4OPedHi00pYFsWFgVcKO17dyGvAs0iYXWZ
	e/H833rXwN57P/XHL+yvS2vA7jEUB0Lq7V7hG7xt5ralGhR6SJt8WDtiZIlwNrj5hmDTLbF0dEv
	hekr4iQKsF30IXqsfEO0qhLkvVHkInAluwzQimYMG/EXazFd/UG3L0EoaWE9rcw4+dpsA2xdvWQ
	IBWe031LxWvTOfWkeDK9AsrK52gY0d+gEVo1BR9OooD7C1EGPK1myNg5IS3K5Os2xNFPXHD+SNj
	r15058bPdJMKxfNyfmbo1lSaQWokzctb1AAr+fciv7ayJ+EeSNv8+GpKpdvQ=
X-Received: by 2002:a05:651c:1541:b0:39d:4014:12cb with SMTP id
 38308e7fff4ca-3a1aeba14f1mr58830741fa.2.1787575623517; Mon, 24 Aug 2026
 05:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817153957.3177627-1-poros@redhat.com> <CANn89iKZe5reKy5uNxF7_G2=zytnPjWCUn+bX7-iGdJuTjBgMw@mail.gmail.com>
In-Reply-To: <CANn89iKZe5reKy5uNxF7_G2=zytnPjWCUn+bX7-iGdJuTjBgMw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 24 Aug 2026 20:46:23 +0800
X-Gm-Features: AcwNN1UNMhg-G3O44wS46NpPtViR0jq5lP4tc_1mJnVvstgEZiQW-oeP94Mc5pw
Message-ID: <CAL+tcoBX+3_oiy5KCtnBkjEdmDgzY6PYAT2oOqDSLXezDCFfHw@mail.gmail.com>
Subject: Re: [PATCH net] xsk: reset the mac header in the generic Tx path
To: Eric Dumazet <edumazet@google.com>
Cc: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Willem de Bruijn <willemb@google.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Doruk Tan Ozturk <doruk@0sec.ai>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 1:07=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Aug 17, 2026 at 5:40=E2=80=AFPM Petr Oros <poros@redhat.com> wrot=
e:
> >
> > __dev_queue_xmit() resets skb->mac_header, __dev_direct_xmit() does not=
,
> > so a frame taking the qdisc bypass path reaches ndo_start_xmit() with
> > the sentinel left by __finalize_skb_around() and skb_mac_header() point=
s
> > 65535 bytes past skb->head.
> >
> > The packet socket reaches it through packet_direct_xmit(), and
> > packet_parse_headers() was taught to anchor the header by
> > commit c2707480cfbf ("net/packet: reset the MAC header on the
> > packet-socket transmit path"). AF_XDP reaches it through
> > __xsk_generic_xmit(), and net/xdp/xsk.c never sets the mac header.
> >
> > ice reads eth->h_proto through skb_mac_header() on its ordinary Tx path=
.
> > On an E810 every one of 2817224 AF_XDP frames reached the driver with t=
he
> > sentinel still in place, so the ethertype never came from the frame. Wi=
th
> > this patch all 5757920 frames of the same test carried the correct 0x88=
b5.
> > An AF_PACKET sender on the same port read 0x88b5 in both runs.
> >
> > On a KFENCE kernel that read lands inside the pool and gets reported as=
 a
> > use after free of an unrelated object, 387 times in a 180 s run:
> >
> >         BUG: KFENCE: use-after-free read in ice_xmit_frame_ring+0xddb/0=
x1650 [ice]
> >          ice_xmit_frame_ring+0xddb/0x1650 [ice]
> >          __dev_direct_xmit+0x347/0x4d0
> >          __xsk_generic_xmit+0xc13/0x1e70
> >          __xsk_sendmsg.constprop.0.isra.0+0x519/0x640
> >          xsk_sendmsg+0x6c/0x90
> >
> > Rerunning the same reproducer on the same E810 with this patch applied
> > produced no reports and no bad reads.
> >
> > Anchor the header in xsk_skb_init_misc(), which runs once per skb for
> > both build paths. With IFF_TX_SKB_NO_LINEAR the offset still is not a
> > real header, but it stays in bounds and no such driver reads it.
> >
> > Fixes: 35fcde7f8deb ("xsk: support for Tx")
> > Signed-off-by: Petr Oros <poros@redhat.com>
> > ---
> >  net/xdp/xsk.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 7855ee09c4b640..885427392cb6b3 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -931,6 +931,7 @@ static int xsk_skb_init_misc(struct sk_buff *skb, s=
truct xdp_sock *xs,
> >         skb->priority =3D READ_ONCE(xs->sk.sk_priority);
> >         skb->mark =3D READ_ONCE(xs->sk.sk_mark);
> >         skb->destructor =3D xsk_destruct_skb;
> > +       skb_reset_mac_header(skb);
>
> I don't know, I had at some point the goal of removing our dependency
> on mac header in ndo_start_xmit(),
> as this must be skb->data.
>
> ice could use skb_eth_hdr() instead of eth_hdr() or skb_mac_header()
> and save few cycles.
>
> Some drivers call skb_reset_mac_header(skb), this is really a mess.
>
> With AI these days, it should not be too hard to completely remove our
> dependency on mac_header.
>

I saw the status has been changed to 'rejected'. Why is that, I
wonder? I think it's just a fix that can be done in xsk like
skb_reset_network_header() that I'm going to add.

Your suggestion should target net-next if someone volunteers to implement i=
t?

Thanks,
Jason
