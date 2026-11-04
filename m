Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820014;
	b=1XjZlvnhANU4WpedBvdED699bzpX0Q996v0j/WXxr0Ird8ZfHS0p9ED5aFZo3aTnAOKW
	 ZyCNxW9F8SvCQzPTT78HAk97q4SS2GVa+zZOcheLHCLe7FA7GMkwmnMohtxGgC1cUPaTj
	 T3RjKIx705kr12dGmYvhLrTe7qHfmBKaA1nVkvRBKobh7lJvOz0k7ywDW10Zl/HTwt7Or
	 2PwWGCVXIBxOYvv8dPa2IDQsvJ4f/2I+0xItDUSqdifIIJBC3wWbLUJDhFO9dcDh97gm8
	 rhlcvnRZZ/cf1ZC2MYWKvrr04G27roiJqRG7G8Z/GWM5iKL1AirqwZa0RO9SWkhW56g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sX2Jzalyt27/oGdLPI23JkAMjlpe7CLlljXwxMG7rPs=;
	b=rAYUCxaSU5CbZ/LdpplBo/yDQWZ6U8zzuIpoBpK36aTVOPryleIfE96vAIfVAXw1SvlP
	 I2algx8TLHKmkUg/5jARc1tXAl7DO8mkwmUcigGmgWFsEP5AKd+tS1rc5S0u99bN1/PpX
	 9z+ZTz6iS40Q4ri1g/ZEwQ+MiufOnb3/ypXwhT2/mChNLdLwH8DTI8EGvpV5tRBkbfQ70
	 4hhLEif0Lqy+pQZjLUS8RmDzHYYHY9N1QZLWUH3JncrkTdSZlO1YulqgMj+3sQiJWcR0K
	 3cQ6fG+BbfXxZ2dBv6cG1W2hRVcTYCCkoCOtx4A3/+PMXWv177OY39ksT3N7fIAEyUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xd0yoprA;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B28D6071A0A
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 19:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B28D6071A0A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xd0yoprA
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-74ab99038afso689459137.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793820013; x=1794424813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sX2Jzalyt27/oGdLPI23JkAMjlpe7CLlljXwxMG7rPs=;
        b=xd0yoprA2U8Te2fS5JeIM4kZvuYDj6nEDDQJy+BNvWyll6bQS4y0Hbs06ou2stMdRx
         Lw/C8cVWxcE7jbPBYs80DZbhI2RbuiyMRX7z/5M1N7Bg3UgsB8ZphuUj2Mjgwuel5RCB
         GVMuO+33YjBUO1qdYA3DURFkAYXGhFLcprLJYRmAl8vpnbZa3mceMDY0UQWbrKNSQfUF
         Iy/oSDTayRtmJEzRVonbL0Iyw+U7t3Ofz/G8U9KzOd1UgHbL5IZUfWn069Twja3GzqkN
         d3W2DtGXDO5P4MFYAAFUhNHnXZjZCa/WVftm/X/BJ5nUEz+RizUXG0E4bBSH0E6pOwv0
         JsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793820013; x=1794424813;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sX2Jzalyt27/oGdLPI23JkAMjlpe7CLlljXwxMG7rPs=;
        b=nJFtV75s0SOZe3TtRjb3S4fn0BYVjhVMP8ndKh0YemDgFuocH4rLeH9FSpPfntQOYJ
         rtKTApMK4EbnJXnylBY8FhKFlqnedrFr2QM7y1BClKd5FTpRMRk0OIHOsOydZnjfSB5h
         yXsMzW47Qi330Fyq199Ny/tlslkN383tyGAMtyxkCkolGYG8wmqXI/z4WPAQteK+vO9j
         plqNX0pesQBHo0K8RUIDo/ITx1Gf/HVSYvo6KJluG1amF1Kj0qiY7QcWBWBNgDxfWnX1
         92HEeWX7kyAhkvo12blIyBumnJOZNg0zfE/XxkufJE8ovWDOjkFmHJojQDO4Z/JiwTtm
         WpxA==
X-Forwarded-Encrypted: i=1; AKwUvBwD07hUMIx8JCi9QKh1v7yrYWHuEVgrKOs910J+JVd0Rewqlj8rdDpHnHXOvExS/MOX1LrRnUY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5psLLcqf00jgSVxoJAn8+letU9IbFfrkSG8kk71hMADDlU5KF
	2lmupBzSlSeRb34Yv0Nw8aRVYCIZ7ew8LSAjkjysfkwXNfq5k2JHS5JQ
X-Gm-Gg: AYBFou3sol9hbCuWAVwaaxfZjAeJzOPUlfkDJy1QoBIgVypAj9HTTEgepVhLIyacXqQ
	Yr9tc4iYWRio3tSDhMbHc4hDQnE1v8NFGHya0mXpn3n2cEqoklH4l0Eh0JSsjQmjzLHgrdZrc/2
	aRvznFC2Vis3Z64Go5CJ+UzPO4IkgXi1hOdv0st6ti/oDnU0dlMKqd4yyhLIdR5qrYmh0JD+HvR
	Q6QYz1ZkmpP10OD/4YXdQiALr9dqCY2Rh2hZmSBrNYa7AfCSB9gT42xVErq6rWSCrr5OKp10nJN
	Abvv01eg0lccGOulAh8BcEumDSLJTsP4ivFfqMWp+cvg9iZH/BNacndBs30ZnycDNW8I1Cys3O9
	+p7QZibwKc3B2QdhJBLUT4MO5DC4KD99MWNfjQb1r93eBiYyEbZ8wuEuHAHc8UR3eHVEuOzl2D3
	RstIXua6OC0akPQaITsHzH7Jpgvb0r6wrmqchVqKoVMVFtx4IRwCb29DlmhR/13aCuokVAbYfsA
	j7ChQq03fSQbfj7Pvqy+XHQ+Kg+lyiUZQ473luQ74/QC/pIkKWcBDPjjiqw06+0EsXdfYPlZ2R2
	ZMIWUOXPwFdBMOAlE5/9+ia7otWyYEuoeapgY1MAKGqxf+5IxPoW4CFJM+Vdek2AIo54+e6RO7B
	Bv3I7J2z52RxEa7LpQ40WsVfPIzBKHLTiUpaMHCrG01Hs3d0RAneDmWUqXmLLBwwATsIvl3c=
X-Received: by 2002:a05:6102:160e:b0:7cb:bbcc:e4e with SMTP id ada2fe7eead31-7d07271116bmr7198149137.23.1793820012989;
        Wed, 04 Nov 2026 11:20:12 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-999f3006224sm782949241.9.2026.11.04.11.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:20:12 -0800 (PST)
Date: Wed, 04 Nov 2026 14:20:12 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kernel-team@meta.com, 
 kuba@kernel.org, 
 tactii@gmail.com
Message-ID: <willemdebruijn.kernel.6cb5330a644f@gmail.com>
In-Reply-To: <CAKgT0Ue6yT1+ON2v_xEQef+eY8tUzEaF=zWaFY1udnLUybPVsQ@mail.gmail.com>
References: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
 <willemdebruijn.kernel.2de9d4f8c5034@gmail.com>
 <ce3e6832-ca9f-4e91-8302-b5bd7cf2f178@redhat.com>
 <willemdebruijn.kernel.1f1cead288fc2@gmail.com>
 <CAKgT0Ue8i8gTiJg91UYjKPvwfZ9ydf6XXDD1dmaJpjVAb7mwPg@mail.gmail.com>
 <CAKgT0Ue6yT1+ON2v_xEQef+eY8tUzEaF=zWaFY1udnLUybPVsQ@mail.gmail.com>
Subject: Re: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other than
 fraglist
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Duyck wrote:
> On Wed, Nov 4, 2026 at 8:34=E2=80=AFAM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >
> > On Wed, Nov 4, 2026 at 8:24=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Paolo Abeni wrote:
> > > > On 11/4/26 03:51, Willem de Bruijn wrote:
> > > > > Alexander Duyck wrote:
> > > > >> From: Alexander Duyck <alexanderduyck@fb.com>
> > > > >>
> > > > >> The netif_needs_gso function lets a GSO skb reach the device u=
nsegmented
> > > > >> when it is CHECKSUM_PARTIAL or CHECKSUM_UNNECESSARY. The secon=
d case was
> > > > >> added for FCoE, whose transmit path marked CRC offload that wa=
y at the
> > > > >> time. Commit 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indi=
cate CRC
> > > > >> offload") moved FCoE back to CHECKSUM_PARTIAL but left the exe=
mption in
> > > > >> place, with nothing left that needed it. Fraglist GSO, added l=
ater, is
> > > > >> its only user today, as its segments already carry valid check=
sums.
> > > > >>
> > > > >> A TCP GSO skb can still arrive as CHECKSUM_UNNECESSARY without=
 being
> > > > >> fraglist. Hardware LRO builds its aggregates that way, for exa=
mple mlx5
> > > > >> sets SKB_GSO_TCPV4 or SKB_GSO_TCPV6 and CHECKSUM_UNNECESSARY, =
without
> > > > >> SKB_GSO_DODGY. IP forwarding and bridging turn LRO off, but a =
tc mirred
> > > > >> redirect does not, so such an skb can be sent out another devi=
ce. It
> > > > >> has no csum_start and its TCP checksum field is whatever the a=
ggregate
> > > > >> left there. Drivers that only set up TSO for CHECKSUM_PARTIAL,=
 such as
> > > > >> fbnic, i40e and ice, then send the whole skb as one oversized =
frame
> > > > >> with a bad checksum.
> > > > >>
> > > > >> Have the validate_xmit_skb function mark any CHECKSUM_UNNECESS=
ARY GSO
> > > > >> skb other than fraglist as CHECKSUM_NONE, which means the same=
 on
> > > > >> transmit. The netif_needs_gso function then segments it in sof=
tware,
> > > > >
> > > > > tcp[46]_gso_segment convert to CHECKSUM_PARTIAL and then
> > > > > tcp_gso_segment will send it on to hardware if skb_gso_ok with
> > > > > NETIF_F_GSO_ROBUST.
> > > > >
> > > > >> and the __skb_gso_segment function unshares the header before =
the
> > > > >> protocol code rewrites the L4 checksum field. The callers of t=
he
> > > > >> netif_needs_gso function that decide on segmentation for thems=
elves,
> > > > >> such as tap, are left as they are.
> > > > >>
> > > > >> Found by code inspection. In QEMU with an emulated fbnic, TCPv=
4 and
> > > > >> TCPv6 GSO skbs built this way each went out as a single 11 KB =
frame
> > > > >> with a bad TCP checksum. With this change they are segmented i=
nto
> > > > >> MSS-sized frames with valid checksums.
> > > > >>
> > > > >> Fixes: 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate C=
RC offload")
> > > > >> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > > > >
> > > > > Reviewed-by: Willem de Bruijn <willemb@google.com>
> > > > >
> > > > > With the above aside. Not important enough to respin imho.
> > > > >
> > > > >> ---
> > > > >>   net/core/dev.c |   11 +++++++++++
> > > > >>   1 file changed, 11 insertions(+)
> > > > >>
> > > > >> diff --git a/net/core/dev.c b/net/core/dev.c
> > > > >> index f32353b0467c..28b4a652d037 100644
> > > > >> --- a/net/core/dev.c
> > > > >> +++ b/net/core/dev.c
> > > > >> @@ -4207,6 +4207,17 @@ static struct sk_buff *validate_xmit_sk=
b(struct sk_buff *skb, struct net_device
> > > > >>    if (unlikely(!skb))
> > > > >>            goto out_null;
> > > > >>
> > > > >> +  /* Only fraglist GSO, whose segments already carry valid ch=
ecksums,
> > > > >> +   * can be handed to a device as CHECKSUM_UNNECESSARY. Any o=
ther GSO
> > > > >> +   * skb has no csum_start for the device to segment from. NO=
NE means
> > > > >> +   * the same on transmit, and has netif_needs_gso() segment =
it in
> > > > >> +   * software.
> > > > >> +   */
> > > > >> +  if (unlikely(skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY &&
> > > > >> +               skb_is_gso(skb) &&
> > > > >> +               !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST=
)))
> > > > >> +          skb->ip_summed =3D CHECKSUM_NONE;
> > > > >> +
> > > > >
> > > > > It's unfortunate that we need to add yet another branch in the =
hot path.
> > > > > But I also do not see a good alternative.
> > > > I understand fraglist GSO has some use-case, but I'm really wonde=
ring if
> > > > it's really worthy the pain?
> > > >
> > > > I'll personally think we should consider removing it entirely.
> > >
> > > If non-fraglist TSO packets with CHECKSUM_UNNECESSARY can be built =
and
> > > drivers are incapable of handling them, this has to be fixed up.
> > >
> > > The GSO stack trick of fixing up csum_start/csum_off and then handi=
ng off
> > > the TSO packet to the driver is a neat solution.
> > >
> > > Though that currently only works for TSO, not yet for USO.
> > >
> > > Apparently with a bit deeper restructuring the check can be added w=
ithout
> > > additional overhead to the common hot path:
> > >
> > > +/* Like netif_needs_gso(), but only fraglist GSO, whose segments a=
lready
> > > + * carry valid checksums, may reach the device as CHECKSUM_UNNECES=
SARY.
> > > + * Any other GSO skb has no csum_start for the device to segment f=
rom.
> > > + *
> > > + * The extra test sits behind skb_is_gso() and ip_summed !=3D CHEC=
KSUM_PARTIAL,
> > > + * which netif_needs_gso() evaluates anyway, so non-GSO and regula=
r
> > > + * CHECKSUM_PARTIAL GSO skbs see no additional branches.
> > > + */
> > > +static bool validate_xmit_needs_gso(const struct sk_buff *skb,
> > > +                                   netdev_features_t features)
> > > +{
> > > +       if (!skb_is_gso(skb))
> > > +               return false;
> > > +       if (!skb_gso_ok(skb, features))
> > > +               return true;
> > > +       if (likely(skb->ip_summed =3D=3D CHECKSUM_PARTIAL))
> > > +               return false;
> > > +       return skb->ip_summed !=3D CHECKSUM_UNNECESSARY ||
> > > +              !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST);
> > > +}
> > > +
> > >
> > > @@ -4222,10 +4243,18 @@ static struct sk_buff *validate_xmit_skb(st=
ruct sk_buff *skb, struct net_device
> > >         if (unlikely(!skb))
> > >                 goto out_null;
> > >
> > > -       if (netif_needs_gso(skb, features)) {
> > > +       if (validate_xmit_needs_gso(skb, features)) {
> > >                 unsigned int max_segs =3D 0;
> > >                 struct sk_buff *segs;
> > >
> > > +               /* NONE means the same as UNNECESSARY on transmit, =
but has
> > > +                * __skb_gso_segment() unshare the header before th=
e protocol
> > > +                * GSO code rewrites the L4 checksum and sets CHECK=
SUM_PARTIAL.
> > > +                */
> > > +               if (skb->ip_summed =3D=3D CHECKSUM_UNNECESSARY &&
> > > +                   !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)=
)
> > > +                       skb->ip_summed =3D CHECKSUM_NONE;
> > > +
> > >                 if (unlikely(!gso_within_dev_limits(skb, dev)))
> > >                         max_segs =3D skb_gso_output_max_segs(skb, d=
ev);
> > >
> >
> > The problem with that is the order of operations. The issue I am
> > attempting to address is that there was an e1000e patch that was
> > trying to make changes to ndo_features_check to address this. That is=

> > when I realized there are numerous drivers that would be encountering=

> > the same issue.
> =

> One alternative we could probably look at would be to modify something
> like gso_features_check to strip all the GSO features except for
> SKB_GSO_FRAGLIST if CHECKSUM_UNECESSARY is set. Thoughts?

That would revert to fully software segmentation right?

It would be preferable to be able to keep TSO, just reset the csum_..
fields.

Though if this is a rare enough path, taking the performance cost there
rather than burdening all other workloads makes sense too.

But I think the current fix is preferable.
