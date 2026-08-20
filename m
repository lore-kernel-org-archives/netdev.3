Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DE347B438
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787243576; cv=pass; b=icrer+Ehj45jrZKjWEnX3F9DcI81/4afElGrUnTnoAcuKq/cuXBCX6UrgxdJXzwXKzrHoyy0rWr31Wwgw1xrb+3TKl9/i9Kd5oq+PXKqWaP1g1nQj/E/yFwQzZV4BRjn7tYA2A8iPkMYgAGHqy0a+otO3HwKFj6QvOmDk94ETvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787243576; c=relaxed/simple;
	bh=rkzyXPSR/jn/a62GdHaVSAEuVNznsSW+rgf0zyHH41A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGtOqqj8phdY7FZfkxBvZtWONmQvKnO3n4zMPH+460caJNz/4Sa56x3XR7HS3NBTt1kZEyQPPT5kiczYyTN7TfWaOYg18+Lw8TKnUA5hQz/dldfLYe5YCWGFpKAPQrNc5QBOosW19YyBhVok7RvFQFDOWvE1G8zZ+lgJlKBkyqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PC/GqwMc; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PC/GqwMc"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-936cda0e3fbso200724385a.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787243574; cv=none;
        d=google.com; s=arc-20260327;
        b=YlxILfn34k0Alkbd+sXVCoXKTTg6ATqNB0rEttneZYdy2v6zP8PhTaExUj7wgyC5x6
         h7ikuCUjo7XafhFbswxe+0i8UVgTRiqdMgQEYSIgnDImij3r43mULZvaGW/T3ySPVhTC
         xJoLZ33wYvoSvvvNrLzy/P42H7OaSKYZhRwr2ZECZ4tKqNTZaWFzzjG5RgPaax7fb4D9
         Su+rubz7/E87P5xN5zhAoBqXBQtkVHbwfPdXYtpCkJu2ECHeudXX2gKTI/iW0IjDXiCC
         gClRZFGX0BA8UGuPHLrZ6xP5ZntCZYVhxJeLG/uWwQ6m1HmbAyOj/SUUOeOB31f8nzMw
         6BRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUsp03bfJ3WOX3d6yN4GEyHo28ulSrFzk+2hL6X786Q=;
        fh=qzZHubj28t0VFQOgMl/GFpCu8n22KXUUnbnIJWubRNI=;
        b=cKoHkr49SDk0CAEL2yPHSnASQxbDcXNVKIPN0uiMFHrUpeERJ4M372Fh6cA2WEom/x
         AwcqfUBjEdMDvc4EbvCaeoYa48ilR6pa6aBxJAuGxItqVQsnAF3CQnJhQByhRnmv8cbu
         tEfmV1RXdggDaL49wOfF+1aF1JHHs3Dkx7E3xQSizyfOwOzbphYe5dCl8U0gIwXJhBhR
         Ly1Y6tS68G+Mr8eai+dyxjgETMAyMay9tZ3pwSLWTvc1cWKvw+FxJzZEjYJkr0OTdY8i
         vMPY5z+nTKTsGYmXXiypYSugLxQP6ePS16Dqe98rBfv+DYDimMMrpQRjVkAgQAHmcfP0
         JokA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787243574; x=1787848374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CUsp03bfJ3WOX3d6yN4GEyHo28ulSrFzk+2hL6X786Q=;
        b=PC/GqwMcvwqu70/79l/HF7Il7H6JXT5kQYoo0RiGfK5RmsA8QliYeQrHlpMtYd9/r5
         8pF03dGpepeC24eydiyXbP9S1gYp+yPLilvESR8wyVqE1KF9jp8C4OJf9JYS6jsOdy/w
         w0wBa/7QBY/+W4GqeCHabmkCcXBTk72WwH4JFH7AiVZ+lOVYz098y+bYxqstxUl8TaWp
         XR0eL9lLjtplRVyrd1m4hSi29qsc1mEtY5mSQ7jg+KXpUg4KFVsgBucMrrM8qUE2um5Y
         VRRr0l1aXi2mQsepWcKDSDft7vqK5kIGYJA3wtscCoxUdrOZm3AEYpF1A93hnDmWpaBk
         vP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787243574; x=1787848374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUsp03bfJ3WOX3d6yN4GEyHo28ulSrFzk+2hL6X786Q=;
        b=Js+H6ODTI9VtWdL0WagwcVY0+6snGNcGmMLIgAx8/9CFEN6g+X7wX6jl5WvxjpfTb0
         qzXmegAY+wrUkz9+SEctksyLey2KqDumrV2se5Cb2KF+SIWz19w/zRVStD1OnYdINkHV
         IZa1Bcyyq+qvYDJhaj5j992yulK2vwijoIm+x5S+y3zAfpZvGbUA8AQugWWR0agEVaUT
         URHYactwdKpQAcxMGtiY+oh6ZNFDrhBAQMgPxg7gf1RF9+QPH0EFNGFTwP4dfpgoQuVv
         QRNlI2ubAHP84QALd1rMH3cJgh2Pi5f+H2JXal9KqsNZAZsiK1yM5DKteYPjTNbwDl0Y
         mKmw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1cp+pRXhDGb8nbvxWpkwMeGEUGB8BNWKH4gml662TydwGI9kK33wTWa4LBCSMM5MSaA4v+wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwfVmn1aY5I90IeHa0iL4bWh/3YYQVCtlTcsJSXJSMwN8eWWsC
	JW8fIkeK4EACVIUibTUDvf7dYG5b88A0h2PTXBpiPFjsjiQjenYjiPdMK9llOgJLInldC6aLHu+
	rbd6EJZ1/BgrU2DzT4WX5TgLLLlUmKD5NQ0ZnNtpO
X-Gm-Gg: AR+sD10AYS+eG5cATkqJgNiSSpMZiuFK/wo+rFykiZBjydOLdzOlh8I2BVZ13u+4vlA
	IkRO5cW6HmiGQp+ieXCp+3gSclQYfaH7Y9B4B9SFaABM3H7FrTsRnkUzUbce4SpiEYcHTP1nipr
	WMtO3TyKC5/t+qG5Vh84d8NBv42bjN5VnxHwIJEA/VXtwD5SMXKvYAd+mwa9d/29BIgDOSSK5hA
	bQ8YUvyA9ws5vFc3eyHgDxEvDQaRZjeC6C2uF/bYqyw+Z2v8zes2pZCqk86pVvClzktkqfu+1Fg
	IvxBQXGY5YAZNjRhBNXDrwAaQ47VTYzyaje4w3MVl1j7WaRmzlOTgIIZW9Dr1luIpoGgmyvMMEK
	wTfHgZt11fZOyNPvpef1s+iRrdHVU8mEbIdv8Uh5BAA65mM57NZCD0WOqS3vx3qg=
X-Received: by 2002:a05:620a:4556:b0:936:eeab:307e with SMTP id
 af79cd13be357-9371e1f7192mr1321430885a.9.1787243573194; Thu, 20 Aug 2026
 09:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813033855.3372172-1-dongchenchen2@huawei.com>
 <CANn89iLCrzmOfUVwa0yeROpkZxWmVsAkbH7=SBA3XuVxkmTfKA@mail.gmail.com>
 <53e86f6f-43b9-4e06-b185-1344f69cd650@huawei.com> <CANn89iJWTwiQJbjWz5jY6DE_TSA0EEMyJtQFbDSzMJfjV=MHQQ@mail.gmail.com>
 <9a80f88e-c8a6-44fb-a7b2-7cdbaa3bba24@huawei.com>
In-Reply-To: <9a80f88e-c8a6-44fb-a7b2-7cdbaa3bba24@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 20 Aug 2026 18:32:40 +0200
X-Gm-Features: AcwNN1UU9ZZ7sVr18Pu_QFOm8Zo1rQRMjJJjwDbuNLkDJDkAveZeMpa4YGe78fw
Message-ID: <CANn89iKg5XhJQQQWaF0UMxs+Bwjthk=StBKVnKfh+VKBAywkpA@mail.gmail.com>
Subject: Re: [PATCH net] net: iptunnel: fix stale transport header during
 tunnel decapsulation
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, 
	herbert@gondor.apana.org.au, kuniyu@google.com, idosch@nvidia.com, 
	andrew+netdev@lunn.ch, ap420073@gmail.com, steffen.klassert@secunet.com, 
	laforge@gnumonks.org, jiayuan.chen@linux.dev, jhs@mojatatu.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 12:04=E2=80=AFPM dongchenchen (A)
<dongchenchen2@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2026/8/20 17:16, Eric Dumazet =E5=86=99=E9=81=93:
> > On Thu, Aug 20, 2026 at 10:58=E2=80=AFAM dongchenchen (A)
> > <dongchenchen2@huawei.com> wrote:
> >>
> >>
> >>> On Thu, Aug 13, 2026 at 5:30=E2=80=AFAM Dong Chenchen <dongchenchen2@=
huawei.com> wrote:
> >>>>
> >>>> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a sta=
le
> >>>> transport_header offset after tunnel decapsulation.
> >>>>
> >>>> BUG: unable to handle page fault for address: ffffed102091a42e
> >>>> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> >>>> CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-rc4-0=
0061-g248951ddc14d #256 PREEMPT(full)
> >>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debi=
an-1.16.3-2 04/01/2014
> >>>> RIP: 0010:__asan_load2
> >>>> <IRQ>
> >>>> qdisc_pkt_len_segs_init (net/core/dev.c:4145)
> >>>> __dev_queue_xmit (net/core/dev.c:4787)
> >>>> br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
> >>>> br_handle_frame_finish (net/bridge/br_input.c:229)
> >>>> br_handle_frame (net/bridge/br_input.c:315)
> >>>> __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
> >>>> __netif_receive_skb_list_core (net/core/dev.c:6287)
> >>>> netif_receive_skb_list_internal (net/core/dev.c:6445)
> >>>> napi_complete_done (net/core/dev.c:6813)
> >>>> gro_cell_poll (net/core/gro_cells.c:74)
> >>>> __napi_poll (net/core/dev.c:7735)
> >>>> net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
> >>>> handle_softirqs (kernel/softirq.c:622)
> >>>> do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
> >>>> __local_bh_enable_ip (kernel/softirq.c:450)
> >>>> tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
> >>>> tun_chr_write_iter (drivers/net/tun.c:2032)
> >>>>
> >>>> The crash requires four conditions to line up:
> >>>>
> >>>> 1. The incoming packet is encapsulated and carries GSO metadata.  Th=
e outer
> >>>>      transport header offset is stored in skb->transport_header whil=
e the
> >>>>      packet is still in the outer tunnel context.
> >>>> 2. The tunnel receiver strips the outer headers.  skb->data is advan=
ced to
> >>>>      the inner frame, but skb->transport_header is left pointing to =
the
> >>>>      now-removed outer L4 header, so it becomes a negative offset re=
lative to
> >>>>      the new data.
> >>>> 3. The inner frame is not delivered to the local IP stack.  Instead,=
 it
> >>>>      is forwarded at L2 by a bridge or HSR, so ip_rcv_core() never r=
uns and
> >>>>      the transport header is not reset to the inner L4 offset.
> >>>> 4. The forwarding path calls __dev_queue_xmit(), which enters
> >>>>      qdisc_pkt_len_segs_init().  That function computes the GSO head=
er length
> >>>>      from skb_transport_offset(skb).  Because the offset is negative=
, the
> >>>>      unsigned cast overflows and pskb_may_pull(skb, hdr_len +
> >>>>      sizeof(struct tcphdr)) reads past the end of the skb, triggerin=
g a
> >>>>      KASAN fault or page fault.
> >>>>
> >>>> Fix this by clearing skb->transport_header to the ~0U sentinel at th=
e
> >>>> tunnel decapsulation boundary, after each tunnel receive function ha=
s
> >>>> finished all processing that needs the outer L4 header and before th=
e skb
> >>>> is handed to GRO or the stack. The IP/GRO receive paths then set the
> >>>> transport header correctly when they parse the inner packet.
> >>>>
> >>>> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()=
")
> >>>
> >>> This Fixes: tag seems pretty random to me. Issue was present long
> >>> before that commit.
> >>> Next time, please be precise with the `Fixes:` tag; it's not decorati=
on.
> >>>
> >> Thanks for your review. Sorry for the late reply.
> >> The stale transport header has been present since 1da177e4c3f4
> >> ("Linux-2.6.12-rc2"), which is completely latent until
> >> 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()"
> >> was merged.
> >>
> >>   From the perspective of the root cause introduced by the issue,
> >> we can use 1da177e4c3f4 ("Linux-2.6.12-rc2") as fixtag.
> >>
> >>> Also, calling skb_unset_transport_header(skb) directly from
> >>> gro_cells_receive() would make more sense and
> >>> your patch would be less intrusive.
> >>>
> >>
> >> gtp=EF=BC=8Csit use netif_rx to receive pkt. so modifying only gro_cel=
ls_receive
> >> cannot solve all the problems. netif_rx is widely
> >> used and is not only invoked by the tunnel driver, and serval path
> >> (such as genve encap) will reset transport header before netif_rx.
> >> Therefore, should we retain unset in the GTP/SIT tunnel?
> >
> > Hi Dong,
> >
> > 1) Regarding SIT:
> >
> > SIT decapsulates IPv6 over IPv4 (IPPROTO_IPV6). There is no outer L4 tr=
ansport
> > header (no UDP/TCP), so skb->transport_header is not pointing to an
> > outer L4 header.
> >
> > 2) Regarding GTP:
> >
> > GTP is an L3-only point-to-point device (ARPHRD_NONE). It cannot be
> > enslaved by a bridge
> > or forwarded at L2; its packets always go through ip_rcv()/ip6_rcv()
> > where the headers
> > are properly parsed/reset,
> >
> Hi, Eric. Thanks for the review!
>
> I missed the rcv path in the commit message.
> With an ingress qdisc attached to gtp, the stale transport header
> will been consumed in sch_handle_ingress() and its not covered by
> gro_cells_receive() either. So maybe gtp is not safe by
> construction.
>
> gtp_encap_rcv
>    gtp_rx //stale transport header
>      __netif_rx
>        __netif_receive_skb_core
>          sch_handle_ingress
>            qdisc_pkt_len_segs_init
>

Let's step back a bit :)

For non-GSO packets, qdisc_pkt_len_segs_init() returns immediately:

qdisc_skb_cb(skb)->pkt_len =3D skb->len;
if (!shinfo->gso_size) {
    qdisc_skb_cb(skb)->pkt_segs =3D 1;
    return SKB_NOT_DROPPED_YET;
}

It does not inspect skb->transport_header at all. It will be set
eventually later if needed,

GTP does not implement GRO on RX and does not use gro_cells, so incoming
packets in gtp_rx() have gso_size =3D=3D 0.

The issue specifically requires GSO packets (shinfo->gso_size !=3D 0), whic=
h are
processed/aggregated through gro_cells. Fixing this in
gro_cells_receive() covers
all the relevant tunnel drivers in one place.

Thanks.
