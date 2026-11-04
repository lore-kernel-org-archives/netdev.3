Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802597;
	b=b9R5fgcW1aXWtCqdNefgK6PSasmtW2/7TEKQAMlX3rKWEXPtYYGh2JiLpXntqqDEV+T5
	 RvwP8oDNXHyETAoDdibo8rrn2+DLakvA7bjNBQmknGNbimggyFMXZglmxKwlWNokubhys
	 AMHuYfzk0iqQsonW81MbqrBh64gapdtyVjYfzJR6PmpaI/z4YfBIf7vxA/sJVLNemtU2R
	 hyYrV0lDXX9pRZ7Xc6L17hodExD4btHlIcPp14/DPUxg3qgJguJBRdN2zmpgyp2qGEZ6Q
	 x6ljzao8qULkuQkpKi51yXi1sU53PlOz49fYwwaiERcHMw7wHQHlpvFuf74B9zJJ0DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802597;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=votNOs2PnLk67YnR2kwPOlpCLz0pukFATeePLOHUXmk=;
	b=uXGUryiMKXwzljTKGe2Op1kW1pIiAwSTkrwUbduLZBrFv+eBgnIp0ZAzzX4HVYNnYjII
	 OLFk1qoR5Njph/3HjTtPdnDFEXBbCvzLzWptTlJQAf3ZJ5JKWSpJEY9tR/MNp4X9M3WfZ
	 oBcCNub7wL+RjbvT0P6CbGK2LQ2sm98QS4goIzmu/ioj526A+PFfY8lqIeQBZugZuLrsv
	 UQ4i3HQz+d8q5XBLjSGbbupU7QpQ8tJXQK92JB542qy+OZzDRs+S2Dm44eDa0KkyyYEKg
	 NZ7aZvGscUNAgA8+2kq4gPosQSnoEZdxRR3NeWWzB4bq/mqM3JWMlzG43yzKwc0b7Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igerpp0o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E869606A328
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=igerpp0o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC411F00A16
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802597;
	bh=votNOs2PnLk67YnR2kwPOlpCLz0pukFATeePLOHUXmk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=igerpp0ocvoQBINgzZdy9hjZm0efRH1RzGKGShvJZXlcCGZAxc635e7HAS7wVlKMR
	 2pdq6DH0XOK6cT81JYGOwvkdNGdJrlZXp/OW4KRscKePpwf7dU9mogz8/0CphYm1R3
	 TdMhVMgyiYbkfBh4tXu5BeJTo3LLwKTVeWSnkpaQP3LXgAOuccKnAEHjn++R8Qx1ns
	 356pLdihmforyXyHxj61y/9IDEdwt01+ZWeKOzS9UFLN8gmYHfqrOis1mi9vxgELds
	 ldxlaH5iH4oeMmtl4Pwg/M1FvxfyxAEJY1UWZdbZsjxUPw0bvx9MczSqYPtPbZbtUx
	 3YBBJ2tbXDRmg==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4877837890fso413286fac.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 06:29:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBx1WrtYlUPSCsjjQ1d7Vs+tJ+tW7GtwD/g9cs6b0SfBXah7pvxb6pryQem0uokPfd7kgVWzB4Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xtt6aUULP5BmNmDwbhnpqflswQCovE0RlTc/aFZ2tsHTnxJw2
	L4fdJ2o9GiD8sh9Rujrf1dnPswuh/yU91wzGIRqoAb+yah9XXUAB2CEg7mF/D6Azf1W5hxRWfSr
	yAUpqN7uO9ZG2SEfRMyLjKeP7XunjeLc=
X-Received: by 2002:a05:687c:2f0d:b0:4ac:195:2342 with SMTP id
 586e51a60fabf-4ac01954cd5mr1412784fac.25.1793802596668; Wed, 04 Nov 2026
 06:29:56 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103090011.4128420-1-edumazet@kernel.org> <179378292255.488856.6917577451813010963@kernel.org>
In-Reply-To: <179378292255.488856.6917577451813010963@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 15:29:45 +0100
X-Gmail-Original-Message-ID: <CAL4WiipSMhFpvgVSHLqeSDjwEb5aMjRfY-uKzCe_aX6peiJjHg@mail.gmail.com>
X-Gm-Features: AclHuK-5lUreCL0lcAN-VxtqBxKiCJsztz4Z0CG6U5b8iyJRkUfSxuy6Ivwapyg
Message-ID: <CAL4WiipSMhFpvgVSHLqeSDjwEb5aMjRfY-uKzCe_aX6peiJjHg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ipv6: free ireq->ipv6_opt after an RCU grace period
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	ncardwell@google.com, kuniyu@google.com, horms@kernel.org, 
	netdev@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 10:02, <netdev-bot+sashiko@kernel.org> a =C3=A9c=
rit :
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 0 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The fix is incomplete.
>
> Pre-existing issues:
> - [High] The ipv6_opt attached to a request socket is charged to the
>   listener's sk_omem_alloc and never uncharged.
> - [Low] After this patch, ireq->ipv6_opt is freed after an RCU grace
>   period, and the commit message says its readers 'already run under=E2=
=80=A6
>
> --
>
> tcp: ipv6: free ireq->ipv6_opt after an RCU grace period
>
> When a request socket is migrated, the old request socket and its clone
> share ireq->ipv6_opt. If the clone is freed while another CPU is still
> using the options through the old request socket, that is a
> use-after-free. The patch frees ipv6_opt with kfree_rcu() in
> tcp_v6_reqsk_destructor(), as was already done for the IPv4 ireq_opt.
>
> Closes: https://lore.kernel.org/netdev/179369559062.488856.15441115725436=
277776@kernel.org/
>
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index e006a30360eae..517f34166cda6 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -607,7 +607,7 @@ static int tcp_v6_send_synack(const struct sock *sk=
, struct dst_entry *dst,
> >
> >  static void tcp_v6_reqsk_destructor(struct request_sock *req)
> >  {
> > -     kfree(inet_rsk(req)->ipv6_opt);
> > +     kfree_rcu(inet_rsk(req)->ipv6_opt, rcu);
>
> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch, but it
> is on the line being changed. Is the listener's sk_omem_alloc charge for
> ipv6_opt ever released?


Right, this is a separate CALIPSO issue: the listener's sk_omem_alloc
is never uncharged when the request socket is freed.

Uncharging in tcp_v6_reqsk_destructor() would not be correct after a
migration, because req->rsk_listener is no longer the socket that was
charged. calipso_req_setattr() and calipso_req_delattr() should
not keep a charge on the listener at all, like cipso_v4_req_setattr()
which uses kzalloc().

I will send a separate patch.
But only after the pending patches are merged, see below.

>
> calipso_req_setattr() charges the listener, sk_to_full_sk(req), through
> ipv6_renew_options()->sock_kmalloc(). It only uncharges the options that
> it replaces:
>
> net/ipv6/calipso.c:calipso_req_setattr() {
>     ...
>         txopts =3D ipv6_renew_options(sk, req_inet->ipv6_opt, IPV6_HOPOPT=
S, new);
>     ...
>         txopts =3D xchg(&req_inet->ipv6_opt, txopts);
>         if (txopts) {
>                 atomic_sub(txopts->tot_len, &sk->sk_omem_alloc);
>                 txopt_put(txopts);
>         }
>     ...
> }
>
> calipso_req_delattr() uncharges in the same way. tcp_v6_reqsk_destructor(=
)
> does the final free of ipv6_opt with no atomic_sub(), both with kfree()
> before this patch and with kfree_rcu() after it.
>
> tcp_v6_syn_recv_sock() charges the child separately through
> ipv6_dup_options(newsk, ...), so the listener's charge stays in place.
>
> On a listener with a CALIPSO label, does sk_omem_alloc grow by roughly
> 80-110 bytes for each connection request? With the default optmem_max of
> 128KB, sock_kmalloc() would start failing after about 1300 requests. Then
> ipv6_renew_options() returns -ENOBUFS, and every later SYN is dropped by
> the LSM hook in tcp_v6_route_req():
>
>         if (security_inet_conn_request(sk, skb, req))
>                 return NULL;
>
> When the listener is destroyed, __sk_destruct() would also report optmem
> leakage.
>
> [Severity: Low]
> This isn't a bug introduced by this patch, but the commit message says
> that both readers "already run under RCU, like their IPv4 counterparts".
> Now that ipv6_opt is freed after a grace period, should it get the
> matching RCU annotations?

This is net-next material.

>
> In struct inet_request_sock, ipv6_opt is a plain pointer, while the IPv4
> member of the same union is __rcu:
>
>         union {
>                 struct ip_options_rcu __rcu     *ireq_opt;
> #if IS_ENABLED(CONFIG_IPV6)
>                 struct {
>                         struct ipv6_txoptions   *ipv6_opt;
>
> Both IPv6 readers load it with a plain read. For example, in
> tcp_v6_syn_recv_sock():
>
>         opt =3D ireq->ipv6_opt;
>         if (!opt)
>                 opt =3D rcu_dereference(np->opt);
>         if (opt) {
>                 opt =3D ipv6_dup_options(newsk, opt);
>
> The IPv4 readers use rcu_dereference(ireq->ireq_opt). Meanwhile,
> reqsk_migrate_reset() writes NULL to the same field with a plain store,
> on a request that other CPUs may still be reading.
>
> KCSAN would report this as a data race, and sparse cannot check the RCU
> usage. In theory the compiler could reload ireq->ipv6_opt after the NULL
> test and pass NULL to ipv6_dup_options().
>
> Would it make sense to add __rcu, rcu_dereference() and RCU_INIT_POINTER(=
)
> on top of the kfree_rcu() change?
>
> >       consume_skb(inet_rsk(req)->pktopts);
>
> [Severity: High]
> Does this fully close the window described in the commit message?
>
> After inet_reqsk_clone(), the old request and its clone also share the
> same inet_rsk(req)->pktopts skb. reqsk_migrate_reset() clears it together
> with ipv6_opt:
>
> net/ipv4/inet_connection_sock.c:reqsk_migrate_reset() {
>     ...
>         inet_rsk(req)->ipv6_opt =3D NULL;
>         inet_rsk(req)->pktopts =3D NULL;
>     ...
> }
>
> pktopts is still freed right away, both here and in tcp_v6_syn_recv_sock(=
)
> when that request wins own_req:
>
> net/ipv6/tcp_ipv6.c:tcp_v6_syn_recv_sock() {
>     ...
>         if (*own_req) {
>                 ...
>                 if (ireq->pktopts) {
>                         newnp->pktoptions =3D skb_clone_and_charge_r(ireq=
->pktopts, newsk);
>                         consume_skb(ireq->pktopts);
>                         ireq->pktopts =3D NULL;
>     ...
> }
>
> At the same time, tcp_v6_send_synack() on the sibling request can read it
> without any RCU protection:
>
> net/ipv6/tcp_ipv6.c:tcp_v6_send_synack() {
>     ...
>                 if (inet6_test_bit(REPFLOW, sk) && ireq->pktopts)
>                         fl6->flowlabel =3D ip6_flowlabel(ipv6_hdr(ireq->p=
ktopts));
>     ...
> }
>
> tcp_v6_init_req() keeps pktopts whenever REPFLOW (or the common rxopt
> bits) is set on the listener, so this does not need CALIPSO.
>
> With REPFLOW set, tcp_migrate_req=3D1 (or a BPF migrate program), and a
> listener that is closing, one possible sequence is:
>
> CPU A                                CPU C
> reqsk_timer_handler(oreq)
>   nreq =3D inet_reqsk_clone(oreq, nsk)
>   tcp_rtx_synack(nsk, nreq)
>     tcp_v6_send_synack()             tcp_check_req(oreq) (final ACK)
>                                        tcp_v6_syn_recv_sock(oreq)
>                                          own_req =3D true
>                                          consume_skb(oreq->pktopts)
>       ipv6_hdr(ireq->pktopts)  <- skb already freed
>
> The timer's reference on oreq protects ipv6_opt in this case, but it does
> not protect pktopts.
>
> The reverse order also looks possible. CPU C handles a retransmitted SYN
> on oreq and calls tcp_check_req()->tcp_rtx_synack()->tcp_v6_send_synack()=
.
> At the same time, CPU A has done inet_ehash_insert(nreq, oreq) but not ye=
t
> reqsk_migrate_reset(oreq). CPU B then processes the final ACK on nreq and
> frees the shared skb in tcp_v6_syn_recv_sock().
>
> In both cases ipv6_hdr() reads from a freed sk_buff. That can oops, or it
> can put stale bits into the flow label of the SYNACK.
>
> tcp_v6_syn_recv_sock() frees the skb directly, so switching to an RCU
> deferred free would not help here. Does pktopts need its own handling,
> for example an skb_get() for the clone, so that each request drops only
> its own reference?

pktopts is handled by the other pending patch, "tcp: ipv6: do not
read ireq->pktopts from tcp_v6_send_synack()" [1]

With it, tcp_v6_send_synack() no longer reads ireq->pktopts.

The only remaining user is tcp_v6_syn_recv_sock(), and only when it
wins the ehash insertion (*own_req =3D=3D true). Only one of the old
request and its clone can win. When the migration fails,
reqsk_migrate_reset(nreq) clears the clone's pointer, so the skb is
never freed twice.

The two patches fix two different fields, and can be applied
independently, in any order.

[1] https://lore.kernel.org/netdev/20261102075441.3771550-1-edumazet@kernel=
.org/

Let's merge these fixes, so that I can proceed with more urgent bugs.
