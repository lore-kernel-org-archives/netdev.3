Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8692DECA1
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792114967; cv=pass; b=uE97MdfKNzPDYD4lnrXqrYimSzqEuDzeJNiPtcfG83QbQw0hiRxB5Y47VmyqP39JnwYKu9zaNphjepaTcryjYttTZHjsBfgMFnV90qAKlFT6BGsYVl+vV0wCUxU1nA9whGYp3ln+XLJTiHmbwtdlB6Ym9SNMqcVB2+3puUD9j9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792114967; c=relaxed/simple;
	bh=6i0WeLMlEghQpb8uyJNW0pyE1aTfMio3zAYz4uekepw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYAS6B4XHjAr81iS+ya7Q7YHBuRaE+kh3R0mu8XKwjFIhRHfgVJihQhD1FrCZddighg0wurK6eExlw29FafHQl9fZV4VXyLh7REoh7/tjaDwX4GtvUeMJXhnMBrjHDuxZ6ENCYK0B4nm6utjwvEZnS83PvXc/lr6JGBsovDR0+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b=dHwUKkxt; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.b="dHwUKkxt"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7c6e6822b11so725741137.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 18:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792114964; cv=none;
        d=google.com; s=arc-20260327;
        b=Rvw4iBVy3n5cxrMSLvbhOLLFq21bDgRO9WpN55WI5LEv0S2NsmqwD0s0VAx16G17NT
         lYfC/J7421YY8k7ADmwV9Gd3Z3ShcgtEmQfw09/fTaoQOZFSLFQftQpPSgxzZUqToEcn
         +/kLuX3iqZIUng9s1rUkZ5lqoU9VyVrr/SEyhgkPa5TKttZTA0GaCrk1uZIY+ODRBoat
         tMWy6UWzz+HLyuSi574VaEnz8oXqZjKvylSPo4xp+9z7jBb+lDqRPDa/jFktWSci79Ga
         PhkLxty+b4DN0E6ky9gxII+UIL4NWMls3T8E3mKjFf0ZJ7d2VMLkoXmmb2I2FBCicLEp
         FTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vVZmsIf6HaIgsl+foEZt+wGwwAVohSj5QpggFF4Hfm0=;
        fh=xiu7Hc4Gf5e4PiE8i6Rut264GWnNVjdDb4M1FmnrlMc=;
        b=Skm5mGNkyO4f4imHQcpwRe7kWq96xziiL83W+aVfibgyO3jHkcmj40jR4ZtiTnx0Di
         cPqhTJ2nRmsoNJ7DRw5+8H5Fa+wfvq65ww7cI6bE4gOcgQpxv0vBUDjxXPIy6atbw7bw
         jffO1lv7L5u1vduYhSVq9jmPPkdJc3v6WpSY6ZxB4R2a3zlqFAXPeX5MrAvD3Cl0e/NY
         UCo2oi9GVMEYMdfHaMIJPvgLeRiOeamo2mGNBKRxpkh6o7wkzdhF6GirXUCxNxK1mlB9
         Ruf1triViU2hmTOW9xnZ5foWbxXA2lWEn/VJYLeuTDXWv+kT8WGY70z5nazUUqCF3rPK
         ulmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1792114964; x=1792719764; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vVZmsIf6HaIgsl+foEZt+wGwwAVohSj5QpggFF4Hfm0=;
        b=dHwUKkxtT9v4HUYv2Lld2UBpMEcFf3QrincCRGO7nxo0C2NCt+rLHbMsRVi0CTdbXC
         CAOa/ulY+xcyzRp7Lsx1CZV8jwOF9L0fK47LvHAp2V7k/52bZxoi9dXBS+N59qc5RwBi
         LcvRfeO3yfDVTHbW3F/6EdQBtBszkeCvXPAn1/7wu1S/7KdWESV8fJFbXSuXnI8dKOw6
         6fWENLEA5WfJOeikjeARsP1G5yJg98Kl+xgJUCQY4CQ8tcdG5BjJ52R+ZlZCEqSa1rAj
         UV7aPcRqw1thDiWWUtrWSnXuqVNRO+QF/0dJr2YQjEoUxf3tgzQsQwrWmo1g0biXT9bK
         LNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792114964; x=1792719764;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vVZmsIf6HaIgsl+foEZt+wGwwAVohSj5QpggFF4Hfm0=;
        b=ckv0pv22h6jkGI9UoQrv1QJRcNDBRjU/fDYGLv2L8lL7SzJXt5oRESHw5waHO7VLay
         B92WpIzjQ0R/JMidPCilYOu94sBmounEbHAbv96tmCgJ+gq0fQk0z+z4sbZROUHTFUgk
         q9h1Ovrb0pEwIpcVf4FzZdImpQOs0gok2ZqZnLHrevNbyj1rgtTSoJ1+YIkqNjaD/MHx
         aK2DfuwYBBrlODVAJBI+HR0HFeOJz+W4VyLqU9vRO7X/iryhgSyotk5opWPnjzAOnTCj
         TUi4B+xV7YKeYzFQMCwJ58P/fcks/aVKRQ4Lyn76RBFNT8z23nbVdHL5RgT4slvviXlM
         lYzA==
X-Forwarded-Encrypted: i=1; AKwUvBygMk8zU/RkQ1SnhDOdcdYrGuST9akQ2mMdq54s4YzYtBZMRsnhiUmZlHUXslMvnGgKSEXqN9Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/SjAz2bFHv8YkEMDNZnPy73tN8CT7y3CfY0ko1K+Z50ele+3v
	aQUNhDvJAksZnbM/jiYiUfX81+gOAlhW4I6O6G/zCTtElVGlIH4F/wW3cvUkol4bg2iY1D0DDHd
	qe9TejSy1qKGOi/RVxRx7dHZqIgwqH5hUqRabJNcuug==
X-Gm-Gg: AYBFou2JdBJmeyipwHULvXoJAd3DGqFWC6Z0IvygScDrAMYDMDMn/4yQ4p80wxhAgJ2
	Uj4Q4rF+beBw1NIWAuW/aySfa46Z8x0xeXTqL6+9ivJ4Z8KMF90EhiGs1/87o+zB4NGR9yawtvY
	GamO+dZvdXStDTW6C7AEvfKSyyC2bsASPu5I7xFfnoxKLcSHX7BJMK62qy3KBn9M02AW1gEuGNa
	FVIVAryn8hS/NkW3D+/bFaXroSqfdZzx//JXPOd6Dp2vtMGpkGCH+YwP6gP54a2ELEo4Zr+00aP
	hp5Sgi5v745ECfkrgcr56n3UfG6HUymhlBPsq6iRQLM4LYpvf7OzNmF9Pb3JteY8d4uK0WICJ02
	DJMvHSvFR8cx+j+Fj342OSLmJAuZH7EUjY9OTdHC6D/JKM0V4RiYe1dYeiobyMhQcJSIqlS8PvV
	glKdPPB/ltsit/hvTgio8xVtXF+UK79DM2PmaoTaE=
X-Received: by 2002:a05:6102:1624:b0:7b4:740b:9b6 with SMTP id
 ada2fe7eead31-7cb373de30cmr5338155137.26.1792114964042; Thu, 15 Oct 2026
 18:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013033920.2069285-1-rjethwani@purestorage.com> <179195063165.434549.13463545924832836566@kernel.org>
In-Reply-To: <179195063165.434549.13463545924832836566@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Thu, 15 Oct 2026 18:42:32 -0700
X-Gm-Features: AclHuK8N27mGc1KdN4KK4gKo4gYl82sgI4zi_aMkVLpv1hbhFdnlLIxftdE1ahY
Message-ID: <CAKaoeS1Bvpm2OQ_yrfqe6gJRMdY5UZ2P9oNc-d4CEqTMSUmuyg@mail.gmail.com>
Subject: Re: [PATCH net] kcm: defer receive parsing when the lower socket's
 read_sock may sleep
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, leitao@debian.org, zirajs7@gmail.com, 
	runyu.xiao@seu.edu.cn, jiayuan.chen@shopee.com, brauner@kernel.org, 
	sagi@grimberg.me, hare@suse.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:03=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] In net/kcm/kcmsock.c, psock_data_ready() now passes every
>   data_ready event on a non-tcp_read_sock lower socket (for example, a=E2=
=80=A6
>
> --
>
> kcm: defer receive parsing when the lower socket's read_sock may sleep
>
> This commit changes psock_data_ready() so that strp_data_ready() runs
> inline only when the lower socket's read_sock is tcp_read_sock(). Any
> other read_sock, such as kTLS's tls_sw_read_sock(), is now deferred to
> the strparser work via strp_check_rcv(). The goal is to avoid sleeping
> in softirq context.
>
> > diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> > index 71af69d442f21..381a8f0b792e3 100644
> > --- a/net/kcm/kcmsock.c
> > +++ b/net/kcm/kcmsock.c
>
> [ ... ]
>
> > @@ -358,8 +359,19 @@ static void psock_data_ready(struct sock *sk)
> >       read_lock_bh(&sk->sk_callback_lock);
> >
> >       psock =3D (struct kcm_psock *)sk->sk_user_data;
> > -     if (likely(psock))
> > -             strp_data_ready(&psock->strp);
> > +     if (likely(psock)) {
> > +             struct socket *sock =3D sk->sk_socket;
> > +
> > +             /* strp_data_ready() calls sock->ops->read_sock() inline =
from
> > +              * this softirq callback. A ULP's read_sock, such as kTLS=
's
> > +              * tls_sw_read_sock(), may sleep, so hand anything other =
than
> > +              * TCP's own to the parser work, which runs under lock_so=
ck().
> > +              */
> > +             if (likely(sock && sock->ops->read_sock =3D=3D tcp_read_s=
ock))
> > +                     strp_data_ready(&psock->strp);
> > +             else
> > +                     strp_check_rcv(&psock->strp);
>
> [Severity: Medium]
> Will this serialize all KCM-over-kTLS receive processing on a single
> system-wide worker?
>
> strp_check_rcv() only does queue_work(strp_wq, &strp->work). strp_wq is
> created in strp_dev_init() as an ordered workqueue:
>
> net/strparser/strparser.c:strp_dev_init() {
>     ...
>         strp_wq =3D create_singlethread_workqueue("kstrp");
>     ...
> }
>
> So only one strparser work item can run at a time across the whole
> system. KCM psocks, the sockmap strparser in net/core/skmsg.c and
> espintcp in net/xfrm/espintcp.c all share this queue.
>
> With this change, every data_ready event on a kTLS-backed psock ends up
> in this path:
>
> strp_work()
>   do_strp_work()
>     lock_sock()
>     strp_read_sock()
>       tls_sw_read_sock()
>         tls_rx_one_record()   /* sync AEAD decrypt or crypto_wait_req() *=
/
>         tls_read_flush_backlog()
>
> While one psock is decrypting or waiting there, do_strp_work() for every
> other strparser instance waits behind it on kstrp.
>
> Before this patch, the common case ran inline in softirq on the
> receiving CPU, so several sockets could be processed in parallel. kstrp
> was only used for the sock_owned_by_user() and -ENOMEM fallbacks.
>
> Could this add receive latency for unrelated KCM, sockmap and espintcp
> users? Each individual wait is bounded, but a local user who controls
> KCM+kTLS sockets could keep the shared worker busy. Would a per-psock or
> unbound workqueue for this deferred path be a better fit?
>
> > +     }
> >
> >       read_unlock_bh(&sk->sk_callback_lock);
> >  }

Thanks, the point about kstrp being ordered is correct, and it goes further
than this patch.

kstrp has been create_singlethread_workqueue() since strparser was
introduced, and the serialization already bites today. strp_work() takes
cb.lock, which is lock_sock() for every in-tree user (KCM, sockmap,
espintcp, ovpn), so the single kstrp worker already stalls for as long as
any process holds the socket lock of any strparser-attached socket. That
wait has no bound and is a bigger hazard than one AEAD decrypt. KCM
over plain TCP already queues to kstrp on attach and under receive-buffer
backpressure (kcm_rcv_ready() -> strp_check_rcv()), and strparser itself
queues there when the socket is owned or on -ENOMEM. This patch makes the
deferred path more common for KCM-over-kTLS, which currently sleeps in
atomic context. It changes nothing for plain TCP psocks.

Nothing in strparser relies on kstrp being ordered. The workqueue core
never runs one work item on two workers at once; strp_work() and
strp_msg_timeout() both run under cb.lock; strp_done() uses the
cancel_*_sync() variants; and separate strparsers were never ordered
against each other, since the common strp_data_ready() path runs inline in
softirq on whichever CPU received the data.

So rather than a per-psock workqueue, which would need a new strparser
API, v2 adds a follow-up patch that allocates kstrp with
alloc_workqueue("kstrp", WQ_PERCPU | WQ_MEM_RECLAIM, 0), per-CPU and
WQ_MEM_RECLAIM like kTLS's tls-strp. That removes the system-wide
serialization for all strparser users, so a slow or lock-blocked psock only
delays its own work item. v2 also reads sock->ops with READ_ONCE(), since
kTLS can replace it with WRITE_ONCE() after the socket is attached to KCM.

pw-bot: cr
