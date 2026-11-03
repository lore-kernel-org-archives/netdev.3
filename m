Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695942;
	b=ypQ2z3/4hdH9l7NKOp6xR8Y560EVXIbKoqOYHfjR9MWH9hqElhmhRgiy+NqIE8y++qFt
	 CYFDEDXFmUs8g9piWti98iP7GtJyw7pwD8pJwHYlyf4Do3j3hovaJZ47L4D01A3teQu+f
	 B3UbZGiSDidHxi7VxX4sS/dbQ+I2678IQfm1tbwjf95JPwKwBWCYGm0yZv8oexY0dZ4E5
	 EjIhwvWoCR+86AlZBlRaSAQcp7pZQ+ApqAEtcZgs+fRzU4D1MpvAUVVDpa1mBcMjC66Sy
	 zu9sX6kzxwTu8Qy7xvk3aqECZTV4ZB274Hpbghd3GNHQZKCWzXkAR36Ey/r2wp+RI9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695942;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TdSJawfHJlt2CEvQuG6uB67CcZ37ivbLLLF//zSQtxs=;
	b=hDjhs4Z+CztKXAz7n/9v8C5vq6QS1cNVyXcheWfC+uvvBZrzYrHZmZOHnZNezctSi1MA
	 LHY9WaOubGAvdac96jSs0sn9otKy5J1JTndubN/9sxaeUKGraAj+WUs+ALe5yYhxSOEYc
	 tue0AwGiz8kyrqSN3m0fVQGnvFMcPDz5KV1GnFH579HazpmYtlDilaZOBu6JxE9GPN3/V
	 O2xXZU0pCxdq1QlcI+eAgHh0vm/+EX7dK8iJ1loBd4jWn9/359U1UfUk1oIa7bDe5HvAO
	 knpVaSSYPVImrToYucDsoxcl8VYjtdoDazvgbpFhDubiNkBwK+m6SGYmhMcaDPdYzrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mxx7cF4s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F729606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mxx7cF4s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4904F1F00A15
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 08:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695942;
	bh=TdSJawfHJlt2CEvQuG6uB67CcZ37ivbLLLF//zSQtxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mxx7cF4sE3b5qXRX6s3hkMclpAWK0FGdd8M46TDcj8qZtN3XeFNK+xNWs8zyTwGxD
	 biQINWud5AzOz9SYdqinS8cpnbl8V0P7PQmcHeaznOflhzylFM3jn0INcRpHcvuzKS
	 4TjMpMbGKFp45I+xN86MPFHT2VrtEC5PEADCYmtAEDLDt8VEL78q0qJoMaeeRe0jQE
	 2kN/75FdxPEcaSZ1gHH0ZWV1kz309DZjlx/wDb7u8LILkcQxKzb1/Qsqj3h7Le4zDe
	 glbAIMURuHJt39T3yhLG+XJgbarJFeiYGBkyj9X7e0d9DmVi3uJyv4blM9f21H1aSq
	 BTxTK6zvKrLUg==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4932b13c4ccso2539699fac.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 00:52:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByBJVqyDjmHypU4IrZT9GgxqrdVMg+20R6woXKEhbd/ZVt/R3A0ZgnYjLryFi3aFYaOKby5Ews=@vger.kernel.org
X-Gm-Message-State: APuU4Z89GXSPjDbAMqDIY0e3i3tBYNhxMOlr3k3IT1lpv6ycZII9w6Z+
	/q3vKlLMvKeh8HXvg3UL6WK6GrKrPw7N48i/SR9o0npjzYWFoWRbslZciFcelLNfMkDbgavhO3h
	j+GynIlzJsKhYoJX1leyIsyKwKukQX7c=
X-Received: by 2002:a05:6871:4410:b0:494:73e0:eeb9 with SMTP id
 586e51a60fabf-4a907744ae4mr8244206fac.47.1793695941578; Tue, 03 Nov 2026
 00:52:21 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102075441.3771550-1-edumazet@kernel.org> <179369559062.488856.15441115725436277776@kernel.org>
In-Reply-To: <179369559062.488856.15441115725436277776@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 09:52:10 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqU1bT+83m+fkJEftQE9iv+AgcBbFFMsGhw+s3qD-jDEw@mail.gmail.com>
X-Gm-Features: AclHuK_kWzjzr69EGKyEj_0N1KGhlKfklKatO3J29aWnxfwgG_MaiUZSuN-pe-c
Message-ID: <CAL4WiiqU1bT+83m+fkJEftQE9iv+AgcBbFFMsGhw+s3qD-jDEw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	ncardwell@google.com, kuniyu@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, permissiontogallop@gmail.com, x-professor@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 09:46, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 1
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch fixes only half of the migration use-after-free (UAF)
>   it describes.
> - [Low] Leftover from this patch: tcp_v6_init_req()
>   (net/ipv6/tcp_ipv6.c:799-806) still keeps a reference to the SYN skb=E2=
=80=A6
>
> --
>
> tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()
>
> This commit adds a syn_flowlabel field to tcp_request_sock. The field is
> filled from the SYN in tcp_v6_init_req(), and tcp_v6_send_synack() now
> uses it instead of reading ireq->pktopts. The old read could hit a freed
> skb when another cpu completed the 3WHS or migrated the request socket.
>
> Closes: https://lore.kernel.org/netdev/82c31e4d5043f3dbd11b44177cfba779d3=
35aae3.1793599929.git.x-professor@outlook.com/
>
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index e006a30360eae..d406cd3c8ceab 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -578,8 +578,8 @@ static int tcp_v6_send_synack(const struct sock *sk=
, struct dst_entry *dst,
> >                                   &ireq->ir_v6_rmt_addr);
> >
> >               fl6->daddr =3D ireq->ir_v6_rmt_addr;
> > -             if (inet6_test_bit(REPFLOW, sk) && ireq->pktopts)
> > -                     fl6->flowlabel =3D ip6_flowlabel(ipv6_hdr(ireq->p=
ktopts));
> > +             if (inet6_test_bit(REPFLOW, sk))
> > +                     fl6->flowlabel =3D tcp_rsk(req)->syn_flowlabel;
>
> [Severity: High]
> This removes the pktopts read. Does the migration race described in the
> commit message still apply to ireq->ipv6_opt, a few lines further down in
> the same function?
>
> net/ipv6/tcp_ipv6.c:tcp_v6_send_synack() {
>     ...
>                 rcu_read_lock();
>                 opt =3D ireq->ipv6_opt;
>                 if (!opt)
>                         opt =3D rcu_dereference(np->opt);
>                 err =3D ip6_xmit(sk, skb, fl6, skb->mark ? : READ_ONCE(sk=
->sk_mark),
>                                opt, tclass, READ_ONCE(sk->sk_priority));
>     ...
> }
>
> reqsk_migrate_reset() hands ipv6_opt over to the clone along with pktopts=
:
>
> net/ipv4/inet_connection_sock.c:reqsk_migrate_reset() {
>         req->saved_syn =3D NULL;
> #if IS_ENABLED(CONFIG_IPV6)
>         inet_rsk(req)->ipv6_opt =3D NULL;
>         inet_rsk(req)->pktopts =3D NULL;
>     ...
> }
>
> inet_reqsk_clone() memcpy()s the request socket. Until the reset runs, nr=
eq
> and oreq both point at the same ipv6_txoptions. After the reset, nreq own=
s
> it. When nreq is freed, the destructor releases it without waiting for an
> RCU grace period:
>
> net/ipv6/tcp_ipv6.c:tcp_v6_reqsk_destructor() {
>         kfree(inet_rsk(req)->ipv6_opt);
>         consume_skb(inet_rsk(req)->pktopts);
> }
>
> So the rcu_read_lock() in tcp_v6_send_synack() does not protect opt. IPv4
> does this differently: tcp_v4_reqsk_destructor() frees ireq_opt with
> kfree_rcu().
>
> Could this sequence happen?
>
> CPU0 (holds a reference on oreq)
> tcp_v6_rcv()->tcp_check_req()->tcp_rtx_synack()->tcp_v6_send_synack()
>     opt =3D ireq->ipv6_opt;     /* still non-NULL */
>
> CPU1
> inet_csk_complete_hashdance() or reqsk_timer_handler()
>     reqsk_migrate_reset(oreq);
> ...
> nreq is freed, on accept() of the child or after an RST leads to
> inet_csk_reqsk_queue_drop() and the last reqsk_put():
>     tcp_v6_reqsk_destructor()
>         kfree(inet_rsk(req)->ipv6_opt);
>
> CPU0
>     ip6_xmit(..., opt, ...)
>         /* reads opt->opt_nflen/opt_flen, pushes opt->hopopt etc. */
>
> Only calipso_req_setattr() sets ireq->ipv6_opt. It is reached through
> security_inet_conn_request()->netlbl_req_setattr() when a CALIPSO NetLabe=
l
> mapping is configured. The race also needs:
>
> - SO_REUSEPORT listeners with request migration enabled
>   (net.ipv4.tcp_migrate_req or a BPF sk_reuseport migrate program)
> - a listener being closed
>
> The patch carries Fixes: c905dee62232, and the commit message names
> reqsk_migrate_reset() as one of the causes. Should ipv6_opt be handled
> here too?

This is a different issue, which exists independently of this patch.
It is CALIPSO-only (ipv6_opt is only set by calipso_req_setattr()),
and was mentioned in the changelog of e3f33b0a1d89 ("ipv4: free
inet_opt and ireq_opt after an RCU grace period").

Both readers (tcp_v6_send_synack() and tcp_v6_syn_recv_sock()) already
run under RCU,
so freeing ipv6_opt with kfree_rcu() in tcp_v6_reqsk_destructor() is enough=
.

I will send a separate patch.

>
> [ ... ]
>
> > @@ -789,6 +789,7 @@ static void tcp_v6_init_req(struct request_sock *re=
q,
> >       ireq->ir_v6_loc_addr =3D ipv6_hdr(skb)->daddr;
> >       ireq->ir_rmt_addr =3D LOOPBACK4_IPV6;
> >       ireq->ir_loc_addr =3D LOOPBACK4_IPV6;
> > +     tcp_rsk(req)->syn_flowlabel =3D ip6_flowlabel(ipv6_hdr(skb));
> >
> >       /* So that link locals have meaning */
> >       if ((!sk_listener->sk_bound_dev_if || l3_slave) &&
>
> [Severity: Low]
> This isn't a bug, but now that the flowlabel comes from syn_flowlabel, is
> the REPFLOW term still needed in the pktopts condition further down in
> tcp_v6_init_req()?
>
>         if (!tw_isn &&
>             (ipv6_opt_accepted(sk_listener, skb, &TCP_SKB_CB(skb)->header=
.h6) ||
>              np->rxopt.bits.rxinfo ||
>              np->rxopt.bits.rxoinfo || np->rxopt.bits.rxhlim ||
>              np->rxopt.bits.rxohlim || inet6_test_bit(REPFLOW, sk_listene=
r))) {
>                 refcount_inc(&skb->users);
>                 ireq->pktopts =3D skb;
>         }
>
> On a REPFLOW listener with no rxopt bits set, every request socket still
> holds a reference to its SYN skb. cookie_v6_check() uses the same conditi=
on
> without the REPFLOW term, so the two places now differ.
>
> One reader is left: IPV6_2292PKTOPTIONS in do_ipv6_getsockopt(), through
> np->pktoptions on the child. It only produces cmsgs if rxopt bits are set
> on the child after accept(). Dropping the term would change behaviour
> slightly in that case.
>
> Could a follow-up remove the term so that tcp_v6_init_req() matches
> cookie_v6_check()?

Yes, I already mentioned this. I have a net-next patch for this.
