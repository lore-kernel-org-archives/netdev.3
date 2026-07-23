Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F947D45A
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784831739; cv=pass; b=FwLkpr5jtYlgDYn1MXNhTqEtm5yH4EuK4/DptUNVB2OxLqRsqav4+5rgTcXoKi5adCQ53HImdbxGqppNAnIevxD2bvn4N/n/fBzLRVHSpaIC4zlWCg9z+/bsCoZk3Aq+UY3Jc/MtmG3vpiJm/FkRaTnVlHFIcwUzqraDfxdJ2aY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784831739; c=relaxed/simple;
	bh=QeA1F2U8vgeQEZoTtIN1yGUiWvodHYxSInxl+yr5gOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9zKs8HR5mIDeaBLmo/xrasFuC/0Ky652IlwdzNqwaYJOfP3UNwR5WMpXjtv71ip7xhONgkdVlW8R6Ip9U9rNuTIc7Xw4rw0sKZnlBlMwXjGEs/SAqKyScV0kVQjyK4Rn4ZzWdldCwl/egHJ69sEBZ46t0HrCFuCGkHSfhNcrdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaX0Rrt+; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaX0Rrt+"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccdf36f63dso17765ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 11:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784831729; cv=none;
        d=google.com; s=arc-20260327;
        b=UHr+OxwgoiTx3wzvzBItcAToHEsl8YGN4+eNqEyAnlRArZKgRSzLRmx3/xxixPbGQo
         mFofJZmi8a/ahMjGPLOATtlZyYkvsmv1jYXKWGVAMNwksXaD8VY884nbIltmaX8Cx+M6
         MnpkSnLB8T+O2UD/rB5xX8RwoJyTSm0RzOmJwhRBDWnds9iJ+XWyqvM9O/yyBC/AfOWq
         oX7wmD6bto5+VEaKeh2ltbIzpu656qV4LLxFZkGn/qVR59kgm9oESFG9CCVUXIlpxkaT
         RnKLM4kt0nhsgLbai119WuUGDqo87mA0rM9Jcz3ntSYHnRoP4XGOoZUF8iR0coG/5NqG
         ADCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cnhhsa3ZzOxh8ybdz+brBlfnDG71eh3LHYllQIgs3gg=;
        fh=ZQEEQDjrFKyftUf6NKiRxgZZalKga+lXlpI7Fq0ICUs=;
        b=MbhvBh/x09e/605V8M/FNrLgYxouZmz8rfrYRY837YmIns3wbiAmsK6n3sk7GfnCX+
         jjZ7Db1VmemT6lPmmwnr7dPENZKHl5b4aJf0XYLw8TtLGDvmhDJAYDVeXskfeJi9U2m4
         MKpDxXXWLC8heEx3XLU3k5XwXoNmxqap84ojVobWwPZFfyO3qCZAqvJfnL0QgaFw8kuz
         p5lMyFepFJb4YTnLs1nIiWhGqq0V3+hMvUonXHr9rn9AeJtVabEwGY/HkurlqtnnvtAb
         q8vLZcX/O4DRUd+4M/Hq0XmuySpyMyqN/m5HqxrYZxsvI8UtjZqTqe4x5ryziud4wpID
         LUzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784831729; x=1785436529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cnhhsa3ZzOxh8ybdz+brBlfnDG71eh3LHYllQIgs3gg=;
        b=UaX0Rrt+gXo26C8MBqjaL7MzHOxg62wewSHQqvUNjG8kWe7bALjI2rsLvx1h7vyx8u
         duuTg5bqq3LyMAXIVul1N8jcjHIqsteSe9xyjU74J0WMmQdnxXV6NqEI/8VQ2JssemrD
         d4IuQUBlV9fpy6ap5RP76kiksBcfII/4KIGdGedufxXZJNGIDLr0QpR8tyqbLqYGJkov
         AW6rsm2Ma8uR4mXldU8ZG4uz+z6bX+b6AFw17jWZkNo3vOViGtnHpFg99et8d05K7xOj
         /mB/lZspE6s3luzjvJjaJvaVO6YH4bULBEVL99aeQPApAmCjgPbwC6O2SXka4kk0Eh+5
         f5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784831729; x=1785436529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnhhsa3ZzOxh8ybdz+brBlfnDG71eh3LHYllQIgs3gg=;
        b=n9CYk5f/7jSSceSWK/kEPVFCtxUWbnDBWOV5yBRuJyEFKXcOo+pPQOOdoBbjN0tytM
         ywJSA9PYB57prj3tAUjzuBdo//Yl81n1YGLDxLBlOxo9T75uTEIPJqledVNS/UL/XHaw
         9L1O7iQhMPAC3p0zFc6D6ZzW0bnVLnvuo5/GlJCogcCWnzAeZ/89Phe8JJq/jEC1VrkH
         iX5PGDGsjP3zzl/2GiJ52ApPHbSXY98LrDWibQkm4VvU8yIWTQKUw5VNRupA4abbZoQb
         U18Ez2DCRyNru0jp+1hSBi9CwFxL3KZ17qOD59Xe2SI0lTPJaiUkx8ehXwAKz76ymolc
         gEFQ==
X-Forwarded-Encrypted: i=1; AHgh+RrW8g1H05XC6S3ndi0FFLUcZ5QogyLhV52aSWHSC7odHuiXyZYQtbpm3RdsZFpnkuXor+hM9oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDTGSRIuQqtnnzaZmdAat/pYI3fNEovo27yZefv7XiWMAYhec+
	HE23994Cg+QISyNGcxIGRrSWMrD9VidkVDupaqXLwSDBZcCG1izFM3zuvgbVkZqTMCs9KK6oi09
	d/51xJEa5NUXOTCfRAxw/8UPTOld5HvuzJX54CW5o
X-Gm-Gg: AR+sD10xtmVBk6cI0GuMwtBW7iJs2RXAOpIUKCu0w2cHqZgGWPYVXShTzPLCrll2vb9
	A2UlFlMRjpzyzDtdFEO0ECpwDnpm5yrwBtaszDyOzI7voWk0E1ZBIpVObpvwcCyfKFdyweJ+URC
	St/ruA/AAU1lmegVJMH4z55JCh1apyKNPplf9rY91WR9Nq4Fm6tT4w8obBhyxvdaX9fG0cAimbR
	arnlrfNn3KGLKvX1IoBgrN7shACQs7IAWHeBDJkeJX3JdgKcllXdyjapHQ6Tje4bja0r2MDlVnX
	IvcfU56FxkDsCoFi
X-Received: by 2002:a17:902:d98f:b0:2ca:e134:acc4 with SMTP id
 d9443c01a7336-2cfc049d30amr581355ad.16.1784831728621; Thu, 23 Jul 2026
 11:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06f0d5ce07dd8593a69239cfa56745cb9c7d957c.1784717791.git.asml.silence@gmail.com>
 <CAHS8izPiZ_1aysWG-up6eW285+MzJN17L9QREfVWgRLkdqL5sQ@mail.gmail.com> <amJOXKql1nbskGZJ@devvm29614.prn0.facebook.com>
In-Reply-To: <amJOXKql1nbskGZJ@devvm29614.prn0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 23 Jul 2026 11:35:15 -0700
X-Gm-Features: AUfX_myxeMtYxrzToPItiMNYDlIup30Qogfm9xOvL0cltkrxIlNSQYtkwgsDwGA
Message-ID: <CAHS8izOAgMX4wSbyUpSLGD_uo7G01cSqnMvrXP9KDdhrYrjNCw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: devmem: prevent net-iov / page mixing
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 10:24=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmai=
l.com> wrote:
>
> On Wed, Jul 22, 2026 at 12:49:07PM -0700, Mina Almasry wrote:
> > On Wed, Jul 22, 2026 at 3:59=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> > >
> > > We should either have net_iov or page backed frags in a single skb,
> > > otherwise it blows up down the stack. Don't allow mixing in
> > > zerocopy_fill_skb_from_devmem().
> > >
> > > Fixes: bd61848900bff ("net: devmem: Implement TX path")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> >
> > It's true that we don't support mixing niov types and doing so would
> > blow up, but this is an unnecessary defensive check imo. The calling
> > code should not (and does not, I hope) have an edge case where it
> > tries to mix and match niov types.
> >
> > Maybe a DEBUG_NET_WARN_ON check to help catch bugs in the calling code
> > may be fine?
> >
> > Also we don't really support mixing different niov sub-types in an skb
> > (like IO_URING + DMABUF) afaict, so might as well go the extra mile
> > and check that it's all devmem niovs specifically.
> >
> > And might as well put the check in skb_add_rx_frag_netmem. It's the
> > same situation on RX, we don't support mixing there (and I hope no
> > code path leads to mixing today).
>
> Hey Mina and Pavel,
>
> I was able to confirm this mixing case does exist.
>
> It looks like in tcp_sendmsg_locked() when new message is non-devmem (zc
> =3D=3D 0) and tcp_write_queue_tail is devmem, the skb collapsing is allow=
ed
> (though same-frag merge is disallowed).
>
> Adding a mode to ncdevmem that sends mixed devmem and non-devmem
> messages, it can be caught hacking this in:
>
> /* DEBUG (DROP ME): detect a TX skb that mixes devmem (net_iov, unreadabl=
e)
>  * and non-devmem (page, readable) fragments. Such an skb must never exis=
t.
>  */
> static bool tcp_dbg_skb_frags_mixed(const struct sk_buff *skb)
> {
>         bool readable =3D false, unreadable =3D false;
>         int i;
>
>         for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
>                 if (skb_frag_is_net_iov(&skb_shinfo(skb)->frags[i]))
>                         unreadable =3D true;
>                 else
>                         readable =3D true;
>         }
>         return readable && unreadable;
> }
>
> static int __tcp_transmit_skb(struct sock *sk, struct sk_buff *skb, ...)
> {
>         ...
>         BUG_ON(!skb || !tcp_skb_pcount(skb));
>
>         WARN_ONCE(tcp_dbg_skb_frags_mixed(skb),
>                   "DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=
=3D%u len=3D%u)\n",
>                   skb_shinfo(skb)->nr_frags, skb->len);
>         ...
> }
>
>
> Resulting in:
>
> [   85.908005] DEBUG: TX skb mixes devmem+non-devmem frags (nr_frags=3D2 =
len=3D24)
> [   85.908342] WARNING: net/ipv4/tcp_output.c:1570 at __tcp_transmit_skb+=
0x9bb/0x1030, CPU#2: ncdevmem/278
> [   85.910646] RIP: 0010:__tcp_transmit_skb+0x9c2/0x1030
>    ...
> [   85.915617]  tcp_write_xmit+0x47b/0x17d0
> [   85.915802]  __tcp_push_pending_frames+0x38/0x100
> [   85.916025]  tcp_sendmsg_locked+0xe51/0x1280
> [   85.916244]  tcp_sendmsg+0x2c/0x50
> [   85.916903]  do_syscall_64+0x11c/0x610
>
>
> My feeling is that we should guard against this when
> tcp_sendmsg_locked() is doing its "new segment or not" calculus.  In the
> zc =3D=3D 0 case, I think we need to check if the queue tail is unreadabl=
e
> and 'goto new_segment' if it is?
>
> This is a different case than Pavel's patch addresses though, where the
> new sendmsg is devmem and write queue tail is readable.
>

:( Yep looks like we have a couple of bugs in the TX mixing. Sorry
about that. We do indeed need to fix this ASAP.

I don't think it's enough to check readable vs unreadable, no? Because
I think appending io_uring niovs to a devmem skb will still blow up
and vise versa, even though both are unreadable, right? Or is io_uring
saved from this somehow in both cases?

If io_uring is vulnerable to this as well, then fixing this becomes a
bit more hairy because this is a TCP fast path. We don't have bits in
the skb header telling us exactly what the skb memtype is (only
readable vs not), so we'll have to check skb_frag_is_net_iov(frags[0])
and netmem_to_net_iov(frags[0]->netmem)->niov_type to check the exact
type of the skb memtype, and that may be a lot of cachelines to fetch
in the fast path. :(


--=20
Thanks,
Mina
