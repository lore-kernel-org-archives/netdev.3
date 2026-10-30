Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793362251;
	b=rrp/7a1iqIyxFFlI502PGMpgwdqSPWkpp48Gcc48ToV1lmjcAzYDiKpw4xt8vvhmNsMG
	 YORn+WJEHhztc+dkYSULNyLx1y0oH4s9zQq+sLF2oJlnuFPKCJBLlndTBzAns/YhZV2Y8
	 RPlsuDs0L3kLA3+KYaO4FIdgZY5nhtbH4/+DyidXuh9YRVVtHATBAvjPo9jfpGnQm7wKM
	 5lNGYQtj5T4sVCKtUrZ/ebbWKHSxv4FrWaoWYv5UiKuFu39HE4/rOd/o7w9TstpdS/f3x
	 tNWbAcRZ61w5WhuVe98PVPncOzxP1YIJrttsBJ+SLkJmvG5C8loKnfhFzcTJa4XFE7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QA50g16aHudGDcSXsItQdqb/ZNETm3wfRubXwKNAx98=;
	b=gLDj4WNubGTyH77m6ABSK70+7oGwGpozAGFR7F7WweReWhCuT9rTWxP3mro4NS1JQlMA
	 IOdt018ap7Cczf3U0jadvtm7W2qzXNRyvbd6Pe2nZpyMYDHUN6U4DZY8vFO4ExHyYM1Mc
	 HQV9jotpUj8kKpmMsA5UGOafYJG5AP39W3I22SUzJVTyi5BghmagOZO67RfkpoieTBD9l
	 I4EvGNJM/3rmgG2QaJj1LHKdCVUR0EjTnQNmWJOmBmFz8VrsYCl9Mw/UCxX8Y+6Kyjp34
	 P2F/4YFOsQO5h+zZ8/kWQWiG2//awICPUGDbSc3ijXEFaHW7mTd5aq92fdQQEssNAQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E3MVxeMT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC53606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADC53606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E3MVxeMT
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4f48d91ba7dso368638b6e.2
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:10:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793362249; cv=none;
        d=google.com; s=arc-20260327;
        b=GYuXg8d9bWGpRhTSxNV3aK59IKAYqILHejkSVl1SyZ98xK5b+C55l1MtSTydspMlaf
         3JvzEwO5SDCkh+RZNQm5vNnEhV/oCMbQDSYYD41pBDoQEdT2HfBbshKwaPBUhAVuJUKa
         8y4NbXFBGJa0MYQwyDFcQy9f/P/ecZM84S6a8zmlt4SQzvybLI5ycOlKkcrmut3Ns1Gn
         rYy9pEzNZ6UgVmiYb7OVKP6Fcn6HI9cHypKBjGVgnPyCG5w8ds0crKg3fh2UBVGl5UKm
         BxTyxW01QbEDMTzzh+8335gja/aeXmS5w6+jRrxeKfZfaNbrRkJRbQWkZljSQ0sDdpye
         tz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QA50g16aHudGDcSXsItQdqb/ZNETm3wfRubXwKNAx98=;
        fh=d0LydO8IW8sd2WLB87qVWssoI5/1YfKIWNX6PL3YcrY=;
        b=F/CRmJgQBT2aZQHPU2k1nKCwQeUrfOpyhlGxPki8HRKOcGD4dzR5K5bFGDqGdlmxX6
         gCNImXzjUnSntW6WFQ8QnIT3QtSZvvXFDJLXTzIy0oY4hnhFyU3i0Hax+SmBJ7W6SSP7
         6pipfZKmm6rfJd76CPeoKsCBcTmXPnxJVnbpM/Hc7TrQKOt282967s0uxrYU0FTOVWTL
         9z/ghBd6JoGPmjaKmgm6qmFHIIV/qCCPfdFoyFcBG7vhofO1ZcZNJu/3jZKiZJFxhG3r
         Ooc3jx6T9i4DKi9WY/sty+bIKfz+Kze07b+cOrkuzHxt6yfplTnvc1PG+WHxzEyk3jv7
         6KQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793362249; x=1793967049; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QA50g16aHudGDcSXsItQdqb/ZNETm3wfRubXwKNAx98=;
        b=E3MVxeMT8vw/bg1QUyjHbM1ISQlhs/B0OjX5kTo0urxT0gAbzc58k9InBnhmf0Ewq6
         9uQP1EjXZp5Ph/2dBCyX5aryfZuIBJnI4TdnO6iboEASvYrnFeCYMdxOYHS/ZMaTgp73
         66OF6RhEb4JN4nS5RUBjFIQX7yQLn6JSZQjjVw6yNjLHcbcu+DcwMSLDuQm4cMNZ3u4S
         U4iFYjlHgMAf0CI/BXBgKLRuZdFHaZndU8wBpzhviYsdkr/MMywz48GuqWsuP6fy9emD
         H4ZatYNBP8gqNAniHitbn2O8gz0knFr4+WJZ19C2pJJl+nTEfBdy35IlkfowWXVWJpGk
         XNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793362249; x=1793967049;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QA50g16aHudGDcSXsItQdqb/ZNETm3wfRubXwKNAx98=;
        b=qq7YqGXBWl28mWvK1McPaa7kmOABFwF/3AceAZrN6MQN1LZFhqrCW8aU5aLlmHDUhd
         fcs0P38reGoMOa4Fi8o24fMfKnYl1CmhPxhKH6/D2uVazxY4mgMCN8SbdokN6nOyaCDZ
         OS+zfRyZN5Prd9WvXM/ZbSNhu8r/nLlNbmAsSAsOBOb1LBdbF2H6bU+yvnM3CsFJt6Gs
         KaeTMFv8B+HzJI7IIto9f2K90fAzhxLduw4ZDYohAA2BT2ljbelx9NU3397V8+CJFMAj
         jjknvQINrc1xzNdzWLRy5t+PjNti1V1zogmDAUen33R1wdLiOx+XMG+tdQLkLVk+zisL
         86pA==
X-Forwarded-Encrypted: i=1; AKwUvBzbyWeH6WeaHDpnq6stQLw1AKMwAhHAAKuOPbVdOc4k509sArHOJFueoXr+fCYowsjjCZjW/hA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLc1OkdZoQtn19Dx+j/0BJOhMxjADRJWT3f+61yhur5ra8bfMY3
	glpYwdkcSKobD6pOXlehI0P2BQT5A0M0gWwgiy14HbJ6wRm35YcB7PONrHVhu0rixoPzBEc0xRG
	njLTpr4EeShvcFVJCz/U8No9StHQLnC0=
X-Gm-Gg: AYBFou2/lNXaWisQ4iJ/ZQx4FqFQQpwzh5ho8Wpoa5v8gtr3MFGMOYTrg9eMxzJtf07
	R6H73F2Kuk8ZFfD/LtB6K2sKkom42/NmBIgBlOGVWWlXkIOXvWzYvtz44gYARWdIt2Ztj0isKkX
	PTI330DMQUkhzEGxyKeWjOTqspDV0JQ0aN6A1vAmHqHjLpkXM5RZUnkYL0St3376Zi8zVMgowbG
	eT1axw/rx7nOjD2Q6miBdvAQSJj9DpElrJR7D/C2fN2R69pCUb+v5A3GSvP8C5izmqZQJwMwWMQ
	bSt3fDbfIliLZVbiWlr+mywHebQDhLpBBEY2L66y9q7UTYCyFJ79iWrn48h0SOzZod0g1CP7f22
	lOrpFBlClDtUPwtj2X89U0LbHKrwCMjWhbEn1IERuSdvTWaNZUf/zMuAPQiTtGLPQa1xHwymu/I
	CWMhAoaotUwf1qRnF83BxCRpw=
X-Received: by 2002:a05:6808:11c7:b0:4ea:686e:fe86 with SMTP id
 5614622812f47-5640df62ac0mr1416797b6e.63.1793362249561; Fri, 30 Oct 2026
 05:10:49 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027-netlink-dump-livelock-v2-1-c4bb05352a33@gmail.com> <179332592143.3134.3446883215083774550@kernel.org>
In-Reply-To: <179332592143.3134.3446883215083774550@kernel.org>
From: Jhonata Poma-Hansen <jhonata.poma@gmail.com>
Date: Fri, 30 Oct 2026 13:10:37 +0100
X-Gm-Features: AclHuK_RWzDPl0fMVJWfqiGX-48WGTJYsqVpLqwIl0KpdhbtkY637vTEbdwkYGs
Message-ID: <CACgZWq6SQjQDvCz6L_4yo=JG-tB8sdM=1yGWGZA+uaD8CjT=pA@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] netlink: check sk_rcvbuf before charging the
 dump skb
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kuniyu@google.com, m.szyprowski@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Oct 2026, Sashiko wrote:
> [High] In netlink_dump() (net/netlink/af_netlink.c:2327), a dump can
> still fail to start because of memory charged by skbs that have...

This is real, but it is not new: both the previous check and the one
before ae8f160e7eb2 refuse the skb when the stale charge alone is at or
above sk_rcvbuf. It needs a single notification with a truesize of at
least sk_rcvbuf, so only very small receive buffers. The patch fixes
the common case where the stale charge is below sk_rcvbuf; the commit
message could have been narrower about that.

Never failing the first skb on rcvbuf would let a reader that does not
read queue one skb per dump request without bound, which is what
ae8f160e7eb2 closed.

> [Medium] This problem wasn't introduced by this patch, but it has the
> same trigger the commit describes.

Right, the gate in netlink_recvmsg() is unchanged by this patch.

Thanks,
Jhonata

Best regards,
Jhonata Poma-Hansen

=F0=9F=87=A9=F0=9F=87=B0 +45 7143 7020 =F0=9F=87=AE=F0=9F=87=B9 +39 3205740=
789




Il giorno ven 30 ott 2026 alle ore 03:05
<netdev-bot+sashiko@kernel.org> ha scritto:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 (1) =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] In netlink_dump() (net/netlink/af_netlink.c:2327), a dump can
>   still fail to start because of memory charged by skbs that have=E2=80=
=A6
> - [Low] The new comment in netlink_dump() ("netlink_recvmsg() continues
>   the dump at or below half of sk_rcvbuf, and the skb must be queued=E2=
=80=A6
> - [Low] The dump_extack selftest (tools/testing/selftests/net/netlink-
>   dumps.c, comment at lines 158-161, branch at 162-163) still describes=
=E2=80=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but it has the
>   same trigger the commit describes.
>
> --
>
> netlink: check sk_rcvbuf before charging the dump skb
>
> This patch changes netlink_dump() so that sk_rmem_alloc is compared
> against sk_rcvbuf before the new dump skb is charged instead of after.
> A dump can then start while something else is still charged to the
> socket. It also refuses an skb that would push sk_rmem_alloc past
> INT_MAX, so the wraparound fix from ae8f160e7eb2 still holds.
>
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index a904dc3bcad6b..4129e93a9ff0c 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -2318,9 +2318,13 @@ static int netlink_dump(struct sock *sk, bool lo=
ck_taken)
> >       if (!skb)
> >               goto errout_skb;
> >
> > +     /* Check the limit before charging the skb: netlink_recvmsg() con=
tinues
> > +      * the dump at or below half of sk_rcvbuf, and the skb must be qu=
eued
> > +      * then. Keep sk_rmem_alloc at or below INT_MAX.
> > +      */
>
> [Severity: Low]
> Is "the skb must be queued then" guaranteed? netlink_recvmsg() checks its
> gate without any lock that keeps senders out:
>
> netlink_recvmsg() {
>     ...
>         if (READ_ONCE(nlk->cb_running) &&
>             atomic_read(&sk->sk_rmem_alloc) <=3D sk->sk_rcvbuf / 2) {
>                 ret =3D netlink_dump(sk, false);
>     ...
> }
>
> netlink_dump() then takes nl_cb_mutex and calls alloc_skb(GFP_KERNEL).
> Both can sleep before the skb is charged. Several things can happen in
> that window:
>
>   - netlink_broadcast_deliver() fills the socket up to rcvbuf, or puts
>     an skb of any truesize into an empty socket.
>   - A rejected broadcast briefly over-charges before its atomic_sub().
>   - setsockopt(SO_RCVBUF) shrinks rcvbuf.
>   - A second reader's dump skb gets queued first.
>
> Any of these can make rmem - skb->truesize >=3D rcvbuf true after the gat=
e
> passed. netlink_recvmsg() then sets sk_err while the dump keeps running.
> A later read seems to resume the dump, so this looks transient. The same
> races also existed before this patch.
>
> Could the comment and the commit message ("so the skb is then always
> queued") be softened to say this only holds when nothing else charges
> the socket concurrently?
>
> Separately, the plain read of sk->sk_rcvbuf in that gate races with the
> WRITE_ONCE() in sock_setsockopt(). That part is pre-existing.
>
> >       rcvbuf =3D READ_ONCE(sk->sk_rcvbuf);
> >       rmem =3D atomic_add_return(skb->truesize, &sk->sk_rmem_alloc);
> > -     if (rmem !=3D skb->truesize && rmem >=3D rcvbuf) {
> > +     if (rmem - skb->truesize >=3D rcvbuf || rmem > INT_MAX) {
>
> [Severity: High]
> Can the dump still get stuck when the stale charge alone is at least
> sk_rcvbuf?
>
> The commit message says this fixes "A dump that starts while something
> else is still charged to a socket with a small receive buffer fails with
> ENOBUFS and stays running". This check only covers a stale charge that is
> below sk_rcvbuf.
>
> netlink_broadcast_deliver() accepts a notification of any truesize into
> a socket with nothing charged, through rmem =3D=3D skb->truesize. The
> selftest in the next patch uses SO_RCVBUF 2048, which gives sk_rcvbuf
> 4096. With a buffer that small, one rtnetlink or genetlink notification
> can have truesize >=3D sk_rcvbuf.
>
> do_one_broadcast() gives the first listener the original skb through
> p->skb2 =3D skb_get(p->skb). After the reader dequeues it, the charge sta=
ys
> on the socket until netlink_broadcast_filtered() calls consume_skb(skb).
> This is the preempted-sender state from the commit message. The
> broadcaster can also sleep in skb_clone() for later listeners.
>
> The reader then sends a dump request:
>
> __netlink_dump_start()
>     WRITE_ONCE(nlk->cb_running, true);
>     netlink_dump()
>         rmem - skb->truesize >=3D rcvbuf -> -ENOBUFS
>     return ret;   /* cb_running is still true */
>
> The ack goes through netlink_rcv_skb()->netlink_ack()->netlink_unicast()
> ->netlink_attachskb(). There rmem =3D stale + ack truesize, which is abov=
e
> rcvbuf and not equal to the ack truesize, so the ack is dropped.
> netlink_overrun() then sets sk_err, or does nothing if NETLINK_NO_ENOBUFS
> is set.
>
> When the broadcaster later drops its reference, sock_rfree() only
> uncharges. It does not wake the reader or call netlink_dump().
>
> netlink_recvmsg() resumes a dump only after skb_recv_datagram() returns
> an skb, and the queue is empty. So:
>
>   - the next recvmsg() returns sk_err;
>   - the one after that blocks;
>   - every later dump request gets -EBUSY from __netlink_dump_start(),
>     until some unrelated message arrives.
>
> Would it be more robust to never fail the first netlink_dump() call from
> __netlink_dump_start() because of rcvbuf? Another option is to clear
> cb_running, or arrange a resume, when that call fails.
>
> [Severity: Low]
> This isn't a bug, but the dump_extack test in
> tools/testing/selftests/net/netlink-dumps.c still describes the old
> behaviour:
>
> dump_extack() {
>     ...
>                 /* Once we fill the buffer we'll see one ENOBUFS followed
>                  * by a number of EBUSYs. Then the last recv() will final=
ly
>                  * trigger and complete the dump.
>                  */
>                 if (ret =3D=3D FOUND_ERR && (ea.err =3D=3D ENOBUFS || ea.=
err =3D=3D EBUSY))
>                         continue;
>     ...
> }
>
> With this check, the bad RTM_GETNEIGH dumps keep queueing DONE+extack
> skbs as long as the charge before each one is below sk_rcvbuf. So
> sk_rmem_alloc ends up in [rcvbuf, rcvbuf + truesize).
>
> The ENOBUFS ack for the next dump is then refused in netlink_attachskb(),
> and netlink_overrun() sets NETLINK_S_CONGESTED. Because of that bit, the
> later EBUSY acks are dropped as well. The ENOBUFS/EBUSY branch above can
> no longer be reached.
>
> Should the comment and the branch be updated, perhaps to check the new
> behaviour instead? The next patch in the series only adds a new test and
> leaves dump_extack unchanged.
>
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the same trigger can also
> stall a dump after it has started. netlink_recvmsg() is the only place
> that continues a running dump:
>
> netlink_recvmsg() {
>     ...
>         skb_free_datagram(sk, skb);
>
>         if (READ_ONCE(nlk->cb_running) &&
>             atomic_read(&sk->sk_rmem_alloc) <=3D sk->sk_rcvbuf / 2) {
>                 ret =3D netlink_dump(sk, false);
>     ...
> }
>
> The sk_rmem_alloc value read there still includes the charge of a
> notification that was dequeued but is held through skb_get() in
> do_one_broadcast(). That charge stays until consume_skb(skb) in
> netlink_broadcast_filtered().
>
> Suppose that notification's truesize is between rcvbuf/2 and rcvbuf:
>
>   1. The dump starts normally under the new check.
>   2. The reader consumes the first dump skb.
>   3. The gate sees the stale charge above rcvbuf/2 and does not
>      continue the dump.
>   4. The next recvmsg() blocks on an empty queue.
>   5. netlink_skb_destructor()->sock_rfree() later uncharges, but neither
>      wakes the reader nor calls netlink_dump().
>
> A dump that needs several skbs, such as a scan dump, then stalls until
> some unrelated message arrives. Could this be handled together with the
> start-of-dump case? The gate and the destructor are not changed here, and
> they behaved the same way before ae8f160e7eb2.
>
> >               atomic_sub(skb->truesize, &sk->sk_rmem_alloc);
> >               goto errout_skb;
> >       }
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261027-netlink-dump-livelock-v2-0-c4bb05352a33%40gmail.com
