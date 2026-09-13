Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97AC3E3D8F
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 23:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789343396; cv=pass; b=GhYCDsFyg0rzHNagWmF2qTrojw/gB9w5urhdSB8RfN4SX3qVgAw5jEboqqnI9JPKvLlciXisp7XvRX8OW9kRFq37cUvMtGAc55Kdz0/S5yK7Qrs8bB33YZmjrNBg1H4dIFfX9gSQj1/H5jfTFNsr7HeuHyKHQFPe2Ot3gcWtu4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789343396; c=relaxed/simple;
	bh=nqjN80FjEjrlkTYMgptyycliSQKyF0sQn4cL1l1/qQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1YoLN4rcgWgKN+agKvy383Cj0uICSkOtXl6awvdC8osaX8ji4MePudCpMKAEW06YkhPinJ11xMdWbDtaabeKIQWTxVomkjaMdrS1oPTLUqhfT1CHR+25OtKHzHUUL5z4F2DaYO1aWlOPJYRGicX22WxTGoIsmHQnNoLR6wDwUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcRAer1S; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcRAer1S"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52fa9c055b5so43652231cf.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 16:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789343391; cv=none;
        d=google.com; s=arc-20260327;
        b=ZcfAfggTR5uvezQPPfbjyKtH4sfoIXywCCB7eN4yKNAIawq7XUJ0twAzUQUOnqcpee
         hu9GewyAPtPqCDb7vgDjALE0dI9d2S/C+UwmYylU2JVE1a0LK1LgsYsEtu5rEB032J8m
         Q0CkYpoFc//7cpp5AafDVnrPZBXUm0/7M87W0cdgDKdqg0sXA6YCA509ef0RpZtZyHfE
         iEYm2phe6u1stI2GNnsgIljJvAQ98zUuANwISsloGVJnvK/pNOq8mYgGtEy5udbiPsdR
         eIYMJruaeZdYWB4xPkVKfnequsAqrkbQyhWjtUl5W3llVrP8A6OIifjerStdIGj8Do5T
         i1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+X3bSblbUC62598m6PGy4H4uB3nFwVKze0HCK3UE6bc=;
        fh=vauqkY5KTYAYYivM2/cAkm9abNNgGSttTYb9KcWH5ac=;
        b=QdZtQm0KxQbtefuxwkgd409qEvhboClo/pq0O4Ac4X81OZyj6lVvCJLbnLWEgzey4c
         uVEkeLgEg2Wh7v4EGwb6QNfO5AvzepqGXkjk3HRTrXFx4b6plzmGmhzfnYxoJVwM0dkS
         e870S/kf7v/RmNlO5DZyIEEQwkiNXEe92+BE13uBqU6Jf+ORE3u36BP1H0pBwRKXG4TO
         rp4yCb4DNk1wPKeZ/d//b27m9VHkE38glT7syjdtdvV57BwTSZTypIU6Hwb22NEKixf4
         XVl5qc9i7wGv1ZY7LVzEKYwHl0/ZVEsOHKA36zk0bT1fEsijwZX0nSnEEnzcGu7ERwLD
         D9yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789343391; x=1789948191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+X3bSblbUC62598m6PGy4H4uB3nFwVKze0HCK3UE6bc=;
        b=mcRAer1SISOOwKP0pdSDttT/RPJYnGigzvDFOfxx1TdbwT95zEC7h7fp7+Xbr6kq+6
         ktXJViWhKc2I9Fb3uLSlPvvmKyF6brG80TMvOuGyNE9ykd60KaN/88zZOLu0VSa/nZM7
         gA34zGeXadcQy48FC/a+mAUI06KicadhNuAKMM8pLnYi2PGGsevYj/gpkI1D5AduHn88
         GUJhpXEnltP9MUcIKnPB44QGjud8loAUkUFLhAqxKdsicEYZwEyG+5rEbQPXoIahTc6m
         P2uGhlegoYFGhpqxCFc2FqH3NPqI6ohOd9eTaPoF/hT++lC06lKkUg9BpO6vwa/sFLBR
         zH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789343391; x=1789948191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+X3bSblbUC62598m6PGy4H4uB3nFwVKze0HCK3UE6bc=;
        b=mQDs7m88psag51wesmY5yDHNZPutZz/V6Y71/6gUYUBTlgaUR/TvojKAgDUOFGldSG
         rb1aZRbhBXyq7WGOx2mWPCMvtoHgBdLULMZxBkz3kBaCHup+jQ3EoBsJ2uUJHRQV3B4E
         Fs588V9g+CM9foZ7wpPOPXIAd6jgiZBj0Q5IcmEDhidD0PKQmJ/97S1fPRhuNeTlK0lQ
         MHsFMv22Gvu3T9QboKdOZnee6MgoJMCISBneeNV1MAa8e9JfYyQJvu5k/RgS5ICe8U8A
         IQSJDCsHPScBV6tuoBf/ljZ+2+OsfoHp9KhszB+o/w72w3yE4t9SEUBBoLD7AvcO8gUL
         hR8g==
X-Forwarded-Encrypted: i=1; AKwUvBz2v0CMaq2ckteKkYPEsya62GO0gA7gdq6Cjp8pvetcWzP0dH/X1CrPA2vN9A8VIIIVtKSjkZs=@vger.kernel.org
X-Gm-Message-State: AFuF++kZWWjyB5N8qiFgvT4BAqiL4otv+gzB1SlU09wS7FHxJCik8IMB
	nxYJGHl3RI9dirle05ro7UIBQBPdVk6Wu8D7fFkxwhU0LyaHXH3SZ04wV5bRjHeFQ/VcOf2PSEN
	eJ4p8JH9Cli/LSQl/cFpCfkvwTuoSwmN//4Cn2zFX
X-Gm-Gg: AYBFou2NJrtkY8rrZkmrzKWaVI3CjN8M65+CAaQ2nzKiqSZbU3XSo7PRllQ3Dwv3fP/
	xsPBsQSjGfgS6VhltKFqwjumIgCzyHH1suCP6p0gLmILRDGgmaLAu/jLFuLkWQwKKBgqXj6e3Ul
	Du9Zmcs9Y04P7g1Q8xP8SgsG8TUfPSyB3ZmI5I80N1XbdDn58+fC2rMQJNYXSk372GU3ZNT/Y5n
	uLmgec4twW3uTwjRXDxBecTsM7+oVpE9ACtTYupy/Jjn2Wosb+tUNgs8ATK0HP04/ubmj5aWehh
	ocyjpIPLypjr+j3esHvSzeicYt/IukdtkutHqb1qmQtqsng86R7ngwCBftJkj2tGKM48uKwjvNA
	BVy1c7UkvpQu+zXsSE/imEdCCPuRiJJS5F1Zq9epK6LR7P9EVXDk+fH2Rc9mwaaNYEjw=
X-Received: by 2002:ac8:5a94:0:b0:530:fa1b:1281 with SMTP id
 d75a77b69052e-530fb6aac99mr46284331cf.38.1789343390390; Sun, 13 Sep 2026
 16:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912233048.3977192-1-edumazet@google.com> <178934237420.22033.12474248772012953233@kernel.org>
In-Reply-To: <178934237420.22033.12474248772012953233@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 13 Sep 2026 16:49:38 -0700
X-Gm-Features: AcwNN1XD3kcoEqOhhLa3T2-HcYX1WsPGNmTxGa1qG44NImu6xdI8sbDbGXnXxaI
Message-ID: <CANn89iJGzZY3HYpUjZxJFPgWOUs7RJDJnACTBwcGhjcb7AvyAQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] pppoatm: ensure a writable skb header and linear data
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, mitch@sfgoth.com, 
	3chas3@gmail.com, qingfang.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 4:32=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>
> - [High] pppoatm_send() does not make the frame linear, although the
>   commit subject claims to "ensure a writable skb header and linear=E2=80=
=A6
>
> Pre-existing issues:
> - [Low] net/atm/pppoatm.c never initialises pvcc->chan.hdrlen although
>   the channel requires LLC_LEN (4) bytes of headroom for e_llc=E2=80=A6
>
> --
>
> pppoatm: ensure a writable skb header and linear data
>
> pppoatm_send() now uses skb_cow_head() to get a writable header with room
> for the LLC header, adds a pskb_may_pull(skb, 1) before looking at
> skb->data[0], and defers the SC_COMP_PROT pull plus the LLC push until
> after pppoatm_may_send() has succeeded, dropping the old "undo" heuristic=
.
>
> A couple of questions about the linearity claim and about the channel
> headroom hint.
>
> > diff --git a/net/atm/pppoatm.c b/net/atm/pppoatm.c
> > index 6da52d12df68e..5214786e61d11 100644
> > --- a/net/atm/pppoatm.c
> > +++ b/net/atm/pppoatm.c
> > @@ -292,10 +292,13 @@ static int pppoatm_send(struct ppp_channel *chan,=
 struct sk_buff *skb)
> >       struct atm_vcc *vcc;
> >       int ret;
> >
> > +     if (!pskb_may_pull(skb, 1)) {
> > +             kfree_skb(skb);
> > +             return DROP_PACKET;
> > +     }
> > +
>
> [Severity: High]
> The subject says "linear data" and the changelog says this pull is there
> "to prevent out-of-bounds reads on zero-length or non-linear frames
> (e.g. from bridging)", but does this pull actually make the frame linear?
> pskb_may_pull(skb, 1) only guarantees the single byte read as
> skb->data[0]; skb_cow_head() -> __skb_cow() -> pskb_expand_head()
> unshares and grows the head but leaves the paged fragments in place.
>


Linear' as in : make sure the first byte is in skb->head, before
reading skb->data[0]

> So a frame with skb->len > skb_headlen(skb) still reaches the device
> send op further down this function:
>
>         ret =3D ATM_SKB(skb)->vcc->send(ATM_SKB(skb)->vcc, skb)
>             ? DROP_PACKET : 1;
>
> vcc->send is the device op (net/atm/raw.c does
> vcc->send =3D vcc->dev->ops->send), and nothing under drivers/atm/
> references nr_frags, skb_headlen or skb_linearize. For example
> solos-pci psend() takes pktlen =3D skb->len and fpga_tx() then does:

I would argue this is a different bug.

>
>         memcpy_toio(TX_BUF(card, port), skb->data, skb->len);
>
> or, in the DMA case:
>
>         dma_map_single(..., data, skb->len, DMA_TO_DEVICE);
>
> For a paged skb, can this read past the end of the linear head buffer
> and put unrelated heap bytes on the wire (and map a length larger than
> the mapped object)?
>
> The bridging path the changelog cites is the one that can deliver such a
> frame: ppp_input() calls ppp_channel_bridge_input() before any
> normalization, and the bridge hands the received skb to the peer channel
> verbatim:
>
> drivers/net/ppp/ppp_generic.c:ppp_channel_bridge_input() {
>         ...
>         skb_scrub_packet(skb, !net_eq(pch->chan_net, pchb->chan_net));
>         if (!pchb->chan->ops->start_xmit(pchb->chan, skb))
>         ...
> }
>
> The source channels do not linearize either (pppoe_rcv() only does
> pskb_may_pull(skb, sizeof(struct pppoe_hdr)) before ppp_input(), and
> l2tp_ppp.c is similar), while the normal ppp_start_xmit() path is linear
> because the ppp netdev has no SG offload. Would skb_linearize() (or
> pskb_may_pull(skb, skb->len)) here be the intended fix, or should the
> subject and changelog be reworded so that backporters do not conclude
> non-linear bridged frames are now handled?
>
> > @@ -317,23 +320,13 @@ static int pppoatm_send(struct ppp_channel *chan,=
 struct sk_buff *skb)
> >
> >       switch (pvcc->encaps) {         /* LLC encapsulation needed */
> >       case e_llc:
> > -             if (skb_headroom(skb) < LLC_LEN) {
> > -                     struct sk_buff *n;
> > -                     n =3D skb_realloc_headroom(skb, LLC_LEN);
> > -                     if (n !=3D NULL &&
> > -                         !pppoatm_may_send(pvcc, n->truesize)) {
> > -                             kfree_skb(n);
> > -                             goto nospace;
> > -                     }
> > -                     consume_skb(skb);
> > -                     skb =3D n;
> > -                     if (skb =3D=3D NULL) {
> > -                             bh_unlock_sock(sk_atm(vcc));
> > -                             return DROP_PACKET;
> > -                     }
> > -             } else if (!pppoatm_may_send(pvcc, skb->truesize))
> > +             if (skb_cow_head(skb, LLC_LEN)) {
> > +                     bh_unlock_sock(sk_atm(vcc));
> > +                     kfree_skb(skb);
> > +                     return DROP_PACKET;
> > +             }
> > +             if (!pppoatm_may_send(pvcc, skb->truesize))
> >                       goto nospace;
> > -             memcpy(skb_push(skb, LLC_LEN), pppllc, LLC_LEN);
> >               break;
>
> [Severity: Low]
> This isn't a bug introduced by this patch, since the previous code did th=
e
> same reallocation via skb_realloc_headroom() and dropped on failure, but
> would it be worth setting pvcc->chan.hdrlen while touching this?
>
> pppoatm_assign_vcc() sets chan.private, chan.ops and chan.mtu, and even
> subtracts LLC_LEN from the MTU, but leaves chan.hdrlen at 0 (pvcc is
> kzalloc'ed):
>
>         pvcc->chan.private =3D pvcc;
>         pvcc->chan.ops =3D &pppoatm_ops;
>         pvcc->chan.mtu =3D atmvcc->qos.txtp.max_sdu - PPP_HDRLEN -
>             (be.encaps =3D=3D e_vc ? 0 : LLC_LEN);
>
> include/linux/ppp_channel.h documents the field as:
>
>         int             hdrlen;         /* amount of headroom channel nee=
ds */
>
> and ppp_generic honours it, e.g. in ppp_write():
>
>         skb =3D alloc_skb(count + pf->hdrlen, GFP_KERNEL);
>         if (!skb)
>                 goto out;
>         skb_reserve(skb, pf->hdrlen);
>
> With hdrlen left at 0, frames written directly to the channel fd and
> multilink fragments arrive with no headroom, so the new
> skb_cow_head(skb, LLC_LEN) has to run a full pskb_expand_head() with
> GFP_ATOMIC inside the bh_lock_sock() section for every such frame, and
> drops the packet if that allocation fails. Setting
> pvcc->chan.hdrlen =3D LLC_LEN for the non-e_vc encapsulations would make
> the common case a no-op.
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260912233048.3977192-1-edumazet%40google.com
