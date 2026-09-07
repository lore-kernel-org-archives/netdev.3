Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9CE198A17
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 23:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788825427; cv=pass; b=JzfaTR0ba2GmYPXIXckJ75BFH/HHl0cSIm2nqimA7dlJrx04n8jOLXfHviPNLQDFm2icjWUzrdGFOBLtYMujEWeD8RibMIUY8VNHuHRl9yojcyvXxVTRPosbwk/FYQ3RDGLCC24TPSDRfyvysBJOYr50B+kCDAyjFmEiY0EX/v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788825427; c=relaxed/simple;
	bh=c46rKTMk+T0MRz6l9oagh37NJf3pH9LBMlVldg+ehAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CBQs6w+OwpmLJG5NQNum3SZBxKXBR/TQfQFYXK46yiqP10xo5q5FPR08vsbWkCMdsHidYHG5FSh2t5Zs3xLIciJc+y9+dMlXyiLjjCVVadr/YHgFo7caNTRSPgf/18PWNf7gzFq0Pknl/aC0tOmUt1v0G3B/lemwwEJIsDDQ5Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HKLQvJR5; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HKLQvJR5"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so4204255a12.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 16:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788825426; cv=none;
        d=google.com; s=arc-20260327;
        b=LS4UbjhByNukfITLZFn0cSeXtd9QStgezFXdvAp1SPi+Z02TfOkB+DUnZdUGjaOwoF
         BSDuhkK3XWUnW43s7FOGHBv3Brr5Ph2AEbzIPEWQLO0GG6VWcchbB7rKrS1OnqEdu+5C
         bu8231sxiCXlmVuEp2LXG4JtJ3P94As76XXXHwm/thbyEeIEiMfh4fwO50j5Vf2fnGkd
         jerO/Cjgij+NpWw27NZn+Oy3rOm8LJDv+hESzzqdku54zWxnmW9cf9nLDrB6ibszEBKD
         qV7oyygztdOf/R5jV3c3LcJ+LuYsTQT1u/I1hkw4FYiylkTrDsN/nCliGGnYRl+9LP7D
         gxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D/z7LJACNXlnGot4pgyxsZRjQOLIXZF20cD2esZWxL4=;
        fh=IIHQYwYi4raubTOEtx9IFnIJfu7hqrhsPHbTxfUuvHs=;
        b=aoxkTTCOuAbRYZXJoTNO0naQjB14uwOM+59kqdJwELKazdrx+SFlvbyRctDC7IV4ky
         ufdTRr/nnP+3rCdzd6V7A0k7okZYKV2rPaXb2lY/7LoHm94JRWTWmdg5rODQvi2NQ37Q
         Bj9ab32YLn+LX3Ko+2LNytlX62AoVAGScJZNrWgB0HCsh8HMnkWcx3N8l2C9livqElAA
         v2n4hvHq9O22Ki4IGZHBUsuvWHP+du+9NnROjT4eEXRfNHzg7PfFMrk9F3hJNc4J1ZmW
         qMvwzDErzwBK+/1JaysVsq45V/stqSgOsa8d4506UOVq5bJY+0LaS1AR8+xSM67Miahj
         hA1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788825426; x=1789430226; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D/z7LJACNXlnGot4pgyxsZRjQOLIXZF20cD2esZWxL4=;
        b=HKLQvJR5RsM3uYCvYh9JwI1uCGJxiSKFCHIl7szrkkm57gz8yFHex7c0Sxb03fL0cA
         pe7X1j6HBerKwl5NZTdfEhZAwkKVKyGrLuFO2w7etaDkE9IAe+t2XLSu6e00YyeY0Bjr
         0wq2HpSjcJ+JG5yn1MTpl1po+nKb9zfICO7t7lQ+WkXUERs/ldrw5zqfv7Efy8timYSQ
         TBp3lvjPj7lmlsjeTge8Aj3e+NYRFR/7gdcwQtiXjlNBs3/EoDT1tGepdInUHNEjKZtP
         cBfrMlv29f4Ts0wChMBiV2CBvdezyOIpMmfvRwjxN1caPEgWeYwXrBvzJbSATQnQtRgm
         BZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788825426; x=1789430226;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D/z7LJACNXlnGot4pgyxsZRjQOLIXZF20cD2esZWxL4=;
        b=GRUgM2xKcKFU+ZzVCAb1tv8CsvWyKjrE25A2cHo8+I5kS5DEECK42pK2lBwha3ARWl
         9hrXqKtH1XR3PTdGPsj74c6jPIgVg3dT7jz72y3llb9wyQJsDbKU1OPnOZbWFUzogQ+Z
         Hvdn0f9FVLkTMw3mHmDY1rsGsq17+TOGipM/a1SnZjC66kzmDF5nAir9CJCkUJ7QqDvX
         nRdsATjeZGIjK1J6f2lX12wUgUbYep8ymRPJ/pIJ/L6mIxr7/Xm1M8qIeUba64krJpZN
         qmjf3mukjrPuE7A23IckOy89SU6ZxS59NK2xgo5dsAjKEuGNObadc52Kqd0HlZzB2QMN
         1IBA==
X-Forwarded-Encrypted: i=1; AKwUvBxR+0kq+hWRUkWULNbqW0zfLNqLRZYtASmz8wpv28TlviylrW9sCJ+lM9meyKndbSwA9BsuMik=@vger.kernel.org
X-Gm-Message-State: AFuF++mjzDtk0SMJmiaybrVpN8Ots7DQWRttlmH/dOGfZxLpZu3yGz0W
	Op+OOyvK7Wkwhya1/EiGhjDwOO8FDMKAa5mLJxPPqoEqjpHjdhMtlbOpMUljVvkPe2hl9Ustcag
	FugEQ0gIaVTO6kv3aaNESEGi3x+gub4LtKvAZcFEz
X-Gm-Gg: AYBFou1qwR0hzbw8e6tIuhatEzhyWDu1/76fNew+p2CO4Ajl2SaACvVnp/t0sbQ7pVM
	sy8UCYS50PYQqqEZJD0KsyoIJIEOQHuLxjrj+RAePEcXsmW04TdDLHBpuXsd9Vb1UmEComoJAtJ
	wSTurhckpDWeKf3NqnDAZGoOSuEnf2E9vLIv/U9U93dFjm7cH5Nw546s8Dwyn3MCdgWgOOoP+Uw
	MZMSn87lySeIhbkRIrUF1GFCR80ZFPzvmq8rImVf00yU9eWD3yduYD/nRzA4hi1TzBHP97bIGAo
	3+OAX3d7J2C2YuILtsr74V9pV6j29Oaw9enO+poTGoeEWRrkHPNAfC2i1dszT3jlztx11z3g3mV
	Eo94l86q87DmhYTZQMTXuwRvtFMbdqsD4eXkta74sT0IcPfSiqQbCgdsF
X-Received: by 2002:a05:6300:6ccf:20b0:3da:a65a:84f5 with SMTP id
 adf61e73a8af0-3daa65a8585mr1388467637.22.1788825424973; Mon, 07 Sep 2026
 16:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902202202.892676-2-kuniyu@google.com> <178851031241.4131868.9083667477267963758@kernel.org>
In-Reply-To: <178851031241.4131868.9083667477267963758@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 7 Sep 2026 16:56:53 -0700
X-Gm-Features: AcwNN1WnVdC9bMdt5ndpzqvd8FZNkodwzSQORcM_zHpAy9v5kpjpbHQaXLr8iBA
Message-ID: <CAAVpQUAnN3Nd6bnmV4pV5Nuei2kM9R0PJDOforHDqpFigYvMMA@mail.gmail.com>
Subject: Re: [PATCH v1 net 1/3] af_unix: Update last skb marker in manage_oob().
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, fahad@codepure.com, kuni1840@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 1:25=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (2) =C2=B7 Low: 0
>
> - [Medium] With only this patch applied, a zero-length receive that hits
>   the OOB-skip path turns a busy-wait into an indefinite block.

This is fixed in the next patch.


>
> Pre-existing issues:
> - [Medium] manage_oob() (net/unix/af_unix.c:2815-2869) drops the
>   unconsumed OOB skb without decrementing u->inq_len, so SIOCINQ /=E2=80=
=A6
> - [Medium] The wait marker @last passed to unix_stream_data_wait() is a
>   bare skb address captured under unix_state_lock, but both=E2=80=A6
>
> --
>
> af_unix: Update last skb marker in manage_oob().
>
> manage_oob() can skip OOB skbs and return NULL, after which
> unix_stream_read_generic() may call unix_stream_data_wait() with a stale
> @last, so the wait returns immediately and the reader busy-waits.  This
> patch passes @last into manage_oob() and updates it on the paths that ski=
p
> or unlink an OOB skb.
>
> > diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> > index 13f9926bf205..6861370062df 100644
> > --- a/net/unix/af_unix.c
> > +++ b/net/unix/af_unix.c
> > @@ -2812,8 +2812,8 @@ static int unix_stream_recv_urg(struct unix_strea=
m_read_state *state)
> >       return 1;
> >  }
> >
> > -static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk=
,
> > -                               int flags, int copied)
> > +static struct sk_buff *manage_oob(struct sk_buff *skb, struct sk_buff =
**last,
> > +                               struct sock *sk, int flags, int copied)
> >  {
> >       struct sk_buff *read_skb =3D NULL, *unread_skb =3D NULL;
> >       struct unix_sock *u =3D unix_sk(sk);
> > @@ -2827,11 +2827,13 @@ static struct sk_buff *manage_oob(struct sk_buf=
f *skb, struct sock *sk,
> >               if (copied && (!u->oob_skb || skb =3D=3D u->oob_skb)) {
> >                       skb =3D NULL;
> >               } else if (flags & MSG_PEEK) {
> > +                     *last =3D skb;
> >                       skb =3D skb_peek_next(skb, &sk->sk_receive_queue)=
;
> >               } else {
> >                       read_skb =3D skb;
> >                       skb =3D skb_peek_next(skb, &sk->sk_receive_queue)=
;
> >                       __skb_unlink(read_skb, &sk->sk_receive_queue);
> > +                     *last =3D skb;
> >               }
> >
> >               if (!skb)
> > @@ -2850,8 +2852,10 @@ static struct sk_buff *manage_oob(struct sk_buff=
 *skb, struct sock *sk,
> >                       __skb_unlink(skb, &sk->sk_receive_queue);
> >                       unread_skb =3D skb;
> >                       skb =3D skb_peek(&sk->sk_receive_queue);
> > +                     *last =3D skb;
> >               }
>
> [Severity: Medium]
>
> This is a pre-existing issue and not something this patch introduces, but
> since this branch is being touched: the OOB skb is unlinked here and then
> freed at the end of manage_oob():
>
>         kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
>
> I don't see u->inq_len being adjusted anywhere in manage_oob(), while
> queue_oob() accounts the 1-byte OOB skb:
>
>         WRITE_ONCE(ousk->inq_len, ousk->inq_len + 1);
>
> Other places that remove queued bytes do decrement it, including
> unix_stream_read_skb(), which drops the same skb with the same reason:
>
>         WRITE_ONCE(u->inq_len, u->inq_len - unix_skb_len(skb));
>         if (skb =3D=3D u->oob_skb) {
>                 WRITE_ONCE(u->oob_skb, NULL);
>                 ...
>                 kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
>
> With:
>
>         send(sk0, "ab", 2, MSG_OOB);
>         recv(sk1, buf, 1, 0);   /* reads 'a', inq_len =3D=3D 1 */
>         recv(sk1, buf, 10, 0);  /* manage_oob() unlinks and frees the OOB=
 skb */
>
> the receive queue ends up empty with u->inq_len still 1.  Does SIOCINQ vi=
a
> unix_inq_len(), and msg_inq/SCM_INQ, then report a readable byte that can
> never be read, growing by one for every skipped OOB byte?
>
> >       } else if (!sock_flag(sk, SOCK_URGINLINE)) {
> > +             *last =3D skb;
> >               skb =3D skb_peek_next(skb, &sk->sk_receive_queue);
> >       }
> >
>
> [Severity: Medium]
>
> This is a pre-existing property of the @last marker rather than something
> introduced here, but this path now publishes u->oob_skb as the wait marke=
r,
> and @last is only ever compared as a bare address:
>
> unix_stream_data_wait()
>         tail =3D skb_peek_tail(&sk->sk_receive_queue);
>         if (tail !=3D last || ...)
>                 break;
>
> unix_stream_read_generic() drops both unix_state_lock and u->iolock befor=
e
> that comparison:
>
>         unix_state_unlock(sk);
>         ...
>         mutex_unlock(&u->iolock);
>
>         timeo =3D unix_stream_data_wait(sk, timeo, last, freezable);
>
> so a second reader on the same socket can free that OOB skb in manage_oob=
()
> via kfree_skb_reason(unread_skb, SKB_DROP_REASON_UNIX_SKIP_OOB).
>
> If the sk_buff slab hands the same address back for a newly sent skb that
> becomes the queue tail before the sleeper reaches prepare_to_wait(), the
> accompanying sk_data_ready() finds no waiter and the tail re-check sees
> tail =3D=3D last again.
>
> The pointer is only compared and never dereferenced, so this is not a
> use-after-free, but can the recv() then sleep with readable data queued
> until the next send, a signal, or SO_RCVTIMEO?  Would comparing a tail
> generation counter or qlen be more robust than a raw skb address?
>
> > @@ -2971,7 +2975,7 @@ static int unix_stream_read_generic(struct unix_s=
tream_read_state *state,
> >  again:
> >  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
> >               if (skb) {
> > -                     skb =3D manage_oob(skb, sk, flags, copied);
> > +                     skb =3D manage_oob(skb, &last, sk, flags, copied)=
;
> >                       if (!skb && copied) {
> >                               unix_state_unlock(sk);
> >                               break;
>
> [Severity: Medium]
>
> For cases 1) and 2) in the commit message, recv(sk[1], buf, 0, MSG_PEEK)
> leaves copied =3D=3D 0 because size is 0, so this escape is not taken whe=
n
> manage_oob() returns NULL.
>
> Execution then falls into the skb =3D=3D NULL path, where copied >=3D tar=
get is
> 0 >=3D 1 since sock_rcvlowat() clamps target to at least 1, and
> unix_stream_data_wait() is entered with @last now set to the skipped OOB
> skb, which is also the queue tail.
>
> Since tail =3D=3D last now holds, does the zero-length blocking peek slee=
p
> until unrelated new data arrives, a signal is delivered, or SO_RCVTIMEO
> expires, instead of returning 0?  With MSG_DONTWAIT the same path appears
> to return -EAGAIN rather than 0.
>
> The next patch in the series, "af_unix: Return immediately when
> manage_oob() returns NULL for 0-length buffer.", changes this test to:
>
>         if (!skb && (copied || !state->size)) {
>
> which looks like it covers exactly this case.  Would it make sense to ord=
er
> that change first, or fold the two together, so that a bisection landing =
on
> this commit alone does not convert the busy-wait into a blocking recv()?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260902202202.892676-1-kuniyu%40google.com
