Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573514;
	b=lU8KwPdk8EE6H1WaFoQBAa2TlBUQF6j8OKd94mYgfdBv5RCVi2Id/o9KEySnUhcdBqC4
	 rjoWlBFPNKVz3bxQ9BluzgDqVbI39fjbtDXkpm8G1YpsHu3FsaPxV4m16NOfC6kQNA9Lc
	 +oOoQ+MAl8AwjE8QCpHa4I4Qu0trs0GodI65EiGZtGEbUvumPt7Fo2qfFeKziMyDRmWf3
	 l0aCiyFN5esFiq5SrP79ntI9p39smQ2R50slv3VhpkMq+1YQzjkzzOY47/VageR55/3yU
	 2Dmm7unB6VsuOjr5so6AYmp4q74BqxHc//JDtIVZca/GYZbN364hzyazEI236GfSTTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573514;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kUSrpMFXxWPFRpvXCbMO5u9yaTRX7UqFSSAYtOdk9qk=;
	b=sl9yjEw/FsNm3/zYVCnIGc0pWtNWLRt3pTZq3MsBt4Lo3WyILoyEINsR8dNDuG8YxZ9q
	 n5sYTrgxYJJ7r/MpBgBxlDcGn8UthCNsxDiK7GzETDtVM8IEj1Mf7zuyKVjHHm7pFUanV
	 SIQjmIClsi86UlobP3KQ9LhovpeG1qHqQ2ei5P25sZ5WhLJB94fFKu5bIrab+JssbuQ6J
	 Z7s7qL+oI0yBzBrCxM1P7CGRshuC5zQu69tCiQit6xdaNWvGkouyFR/DmC8cHrAYmC5Ya
	 WcDZ55MwVU4YUZbYMQfcj4xeKT6RktZVjR/C6iwapb73VZtXn4PPdQ7MEzFgJ03zJdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCjibVuT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D9606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bCjibVuT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595501F000D2
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 09:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792573513;
	bh=kUSrpMFXxWPFRpvXCbMO5u9yaTRX7UqFSSAYtOdk9qk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bCjibVuTkC9xjGUb/gC/jqMADmOr8y3tfHg6338J/Zm4YsTxVGvZuh+7iVlOI+pit
	 svwR9FMPP16ITZ10xvxJrTLEfkc18Thvn3lhf7zgZySKrZrimakeT0feDlefS27tFc
	 y8CHqnrQQA8lP9pRhOUxmI+piU4uXspzAJL6U3Ssqd2EUHqzJtFyW03DHL+kOUsBit
	 6Sn8mHviQ57uNSM3z7N9BTFGybhHDAMtMfeULqByiRpAdP/xTN0k9z9o8fWWZH349a
	 pd0RrLZr0OpkOf3OCTnLk1ACjzb4jzuReNMXR9XYrbzR0lJMXSCJXFVcMJgrHTwx+J
	 NGIbqeowxQimg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a9787a156eso5255421fa.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:05:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxwIIGJTyIJtrYu4iIzsLnWRmvcPGVXifbU2cDOWbmNhjv3Bbvofssw8JFAl1EdwxRWJgmzuVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjPeBFSB7XjMHGqdCVZoV4bFrFr0vUWoxaX7X30bj0R4v/bbtu
	Y3mfu6ijMbF2U8EZxk2Rz/7zFKnSpOpcqodxzMpeMbXmgbArRR2zybBWX8EYLqVCdSjZEpP1yxe
	cW6avMASbrWTFmeJBnLApueztGAYk+8w=
X-Received: by 2002:a05:651c:a214:10b0:3ac:418f:332 with SMTP id
 38308e7fff4ca-3ac4419a236mr2942911fa.23.1792573511941; Wed, 21 Oct 2026
 02:05:11 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ath58Egc-oI6p3Jl@v4bel>
In-Reply-To: <ath58Egc-oI6p3Jl@v4bel>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 21 Oct 2026 11:04:58 +0200
X-Gmail-Original-Message-ID: <CAL4Wiipe-=JDzTvr5_SZaZ7b+QEkMyE0Tjh1x=ryJe50yFxKiw@mail.gmail.com>
X-Gm-Features: AclHuK87FBXVWJ6B7uZ7KLENjUJQoQzJpIdnTAXl6MV2LkKfqrgL_IzL4LN1rlM
Message-ID: <CAL4Wiipe-=JDzTvr5_SZaZ7b+QEkMyE0Tjh1x=ryJe50yFxKiw@mail.gmail.com>
Subject: Re: [PATCH net] inet: reject unhashed sockets during established lookups
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@linux.dev, 
	john.fastabend@gmail.com, weiwan@google.com, sd@queasysnail.net, 
	jiayuan.chen@linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 21 oct. 2026 =C3=A0 10:38, Hyunwoo Kim <imv4bel@gmail.com> a =C3=A9=
crit :
>
> TCP established ehash lookups are lockless. The socket caches involved
> use SLAB_TYPESAFE_BY_RCU, so memory can be reused before an RCU reader
> that retained its old address has finished.
>
> After a tuple match, __inet_lookup_established() and
> __inet6_lookup_established() acquire a reference and repeat the tuple
> check. They do not check whether the new object is hashed. If the
> address is reused for a socket with the same tuple, the lookup can
> acquire a reference to the new object and return it while its nulls node
> is unhashed.
>

Thanks for the report.

Rejecting unhashed sockets after taking the reference makes sense:
syncookie, fastopen and migrated request sockets (and children before
inet_ehash_nolisten()) can all have a non zero refcount while never
being in ehash. All allocation paths call sk_node_init(), and all
removals use the _init_rcu() variants, so the pprev test is reliable,
and pprev shares a cache line with skc_refcnt.

Please mention in the changelog that lookups racing with the
TIME_WAIT hashdance, or with a request being replaced by its child,
will now restart and find the new socket, instead of returning the
old one.

> A PoC that drives reuse with a SYN cookie request socket reproduced the
> crash. The new request socket is unhashed and has a NULL rsk_listener.
> A lookup that had loaded the address of the old request socket acquired
> the reference published by tcp_get_cookie_sock() and returned the new
> object. tcp_v4_rcv() then read sk_state through the NULL listener.
>
> The resulting crash was:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000012
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   ...
>
>
> The same stale address pattern also affects full sockets. In an x86
> KASAN test with enlarged race windows, a stale lookup allowed an RST to
> change a child socket to TCP_CLOSE while it was being initialized and
> before ehash insertion.

I do not see how this can happen. The child is bh-locked from
sk_clone() until tcp_child_process() (or until the bh_unlock_sock()
in tcp_conn_request() for fastopen), and inet_ehash_nolisten() is
called while the lock is held. A stale reader in tcp_v4_rcv() would
spin in bh_lock_sock_nested() until the child is hashed.

Please provide the exact interleaving, or remove this paragraph.
"Enlarged race windows" can easily create schedules that are not
possible on a real kernel.

Do not add bugs in the instrumented kernel just to pretend things.



> The creation path then inserted the child, and
> the server accepted it in TCP_CLOSE. The child was later freed while
> still hashed, and a subsequent lookup reported a use-after-free.
>
> Use refcount_inc_not_zero_acquire() when acquiring the reference.

This is a separate issue, with a different Fixes: tag.

When 3ab5aee7fe84 was written, sk_refcnt was an atomic_t and
atomic_inc_not_zero() was fully ordered. Even after the conversion to
refcount_t (41c6d650f653), default builds used atomic_add_unless().
The ordering was only lost on weakly ordered arches in v5.5, with
commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
of refcount_t").

Please split this into a series:

1) Unhashed check in the lookups, and the __reqsk_free() -> reqsk_put()
   conversions (these are needed because a stale reader can hold a
   transient reference on a request that was never hashed).
   Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash tab=
le")

2) The acquire/release conversions.

If you convert writers to refcount_set_release(), please be
consistent: sk_clone() still uses refcount_set(&newsk->sk_refcnt, 2),
and this is precisely the full socket case you mention.
On the other hand, inet_twsk_hashdance_schedule() already has an
smp_wmb() right after the refcount_set(), so changing it is not
needed.


> After the reference is acquired, restart the lookup if the nulls node is
> unhashed or the tuple no longer matches. This rejects the SYN cookie
> request socket and blocks the child socket path observed in the x86
> test.
>
> Use release ordering when setting initial nonzero refcounts in the SYN
> cookie, TCP Fast Open, request migration, and TIME_WAIT paths. This
> makes initialization performed before the refcount update visible to a
> reader that acquires a reference. After a nonzero request refcount has
> been published, release it with reqsk_put() on failure instead of
> freeing the request directly.
>
> Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hl=
ist_nulls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/inet_connection_sock.c | 14 ++++++++------
>  net/ipv4/inet_hashtables.c      |  7 ++++---
>  net/ipv4/inet_timewait_sock.c   |  2 +-
>  net/ipv4/syncookies.c           |  4 +++-
>  net/ipv4/tcp_fastopen.c         |  3 +--
>  net/ipv4/tcp_input.c            |  3 ++-
>  net/ipv6/inet6_hashtables.c     |  5 +++--
>  7 files changed, 22 insertions(+), 16 deletions(-)
>
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 6a30f11384547e..25b46beed63541 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *=
t)
>                  * hold another count to prevent use-after-free and
>                  * call reqsk_put() just before return.
>                  */
> -               refcount_set(&nreq->rsk_refcnt, 2 + 1);
>                 timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_=
PINNED);
> +               refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
>                 reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, r=
eq);
>
>                 req =3D nreq;
> @@ -1136,10 +1136,12 @@ static void reqsk_timer_handler(struct timer_list=
 *t)
>          */
>         if (nreq) {
>                 __NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQFAILURE);
> +               reqsk_put(nreq);
>  no_ownership:
>                 reqsk_migrate_reset(nreq);
>                 reqsk_queue_removed(queue, nreq);
> -               __reqsk_free(nreq);
> +               reqsk_put(nreq);
> +               reqsk_put(nreq);

The accounting looks right on both paths, but three reqsk_put() split
around a label are hard to follow. Please add a comment explaining
which references are released on each path.

>         }
>
>  drop:
> @@ -1437,7 +1439,7 @@ struct sock *inet_csk_complete_hashdance(struct soc=
k *sk, struct sock *child,
>                                 goto child_put;
>                         }
>
> -                       refcount_set(&nreq->rsk_refcnt, 1);
> +                       refcount_set_release(&nreq->rsk_refcnt, 1);
>                         if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
>                                 __NET_INC_STATS(sock_net(sk), LINUX_MIB_T=
CPMIGRATEREQSUCCESS);
>                                 reqsk_migrate_reset(req);
> @@ -1447,7 +1449,7 @@ struct sock *inet_csk_complete_hashdance(struct soc=
k *sk, struct sock *child,
>
>                         __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRAT=
EREQFAILURE);
>                         reqsk_migrate_reset(nreq);
> -                       __reqsk_free(nreq);
> +                       reqsk_put(nreq);
>                 } else if (inet_csk_reqsk_queue_add(sk, req, child)) {
>                         return child;
>                 }
> @@ -1490,7 +1492,7 @@ void inet_csk_listen_stop(struct sock *sk)
>                 if (nsk) {
>                         nreq =3D inet_reqsk_clone(req, nsk);
>                         if (nreq) {
> -                               refcount_set(&nreq->rsk_refcnt, 1);
> +                               refcount_set_release(&nreq->rsk_refcnt, 1=
);
>
>                                 rcu_read_lock();
>                                 if (inet_csk_reqsk_queue_add(nsk, nreq, c=
hild)) {
> @@ -1502,7 +1504,7 @@ void inet_csk_listen_stop(struct sock *sk)
>                                         __NET_INC_STATS(sock_net(nsk),
>                                                         LINUX_MIB_TCPMIGR=
ATEREQFAILURE);
>                                         reqsk_migrate_reset(nreq);
> -                                       __reqsk_free(nreq);
> +                                       reqsk_put(nreq);
>                                 }
>                                 rcu_read_unlock();
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ba0faa9ae2bb3a..7ffa9171d6de10 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -550,10 +550,11 @@ struct sock *__inet_lookup_established(const struct=
 net *net,
>                 if (sk->sk_hash !=3D hash)
>                         continue;
>                 if (likely(inet_match(net, sk, acookie, ports, dif, sdif)=
)) {
> -                       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcn=
t)))
> +                       if (unlikely(!refcount_inc_not_zero_acquire(&sk->=
sk_refcnt)))
>                                 goto out;
> -                       if (unlikely(!inet_match(net, sk, acookie,
> -                                                ports, dif, sdif))) {
> +                       if (unlikely(hlist_nulls_unhashed_lockless(&sk->s=
k_nulls_node) ||
> +                                    !inet_match(net, sk, acookie, ports,=
 dif,
> +                                                sdif))) {
>                                 sock_gen_put(sk);
>                                 goto begin;
>                         }
> diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.=
c
> index d4c781a0667fe5..88ea3a101849aa 100644
> --- a/net/ipv4/inet_timewait_sock.c
> +++ b/net/ipv4/inet_timewait_sock.c
> @@ -141,7 +141,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewai=
t_sock *tw,
>          * Also note that after this point, we lost our implicit referenc=
e
>          * so we are not allowed to use tw anymore.
>          */
> -       refcount_set(&tw->tw_refcnt, 3);
> +       refcount_set_release(&tw->tw_refcnt, 3);
>
>         /* Ensure tw_refcnt has been set before tw is published.
>          * smp_wmb() provides the necessary memory barrier to enforce thi=
s
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 73e12976818473..4b2d2713653b75 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, str=
uct sk_buff *skb,
>         child =3D icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
>                                                  NULL, &own_req, NULL);
>         if (child) {
> -               refcount_set(&req->rsk_refcnt, 1);
> +               refcount_set_release(&req->rsk_refcnt, 1);
>                 sock_rps_save_rxhash(child, skb);
>
>                 if (rsk_drop_req(req)) {
> @@ -218,6 +218,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, str=
uct sk_buff *skb,
>
>                 bh_unlock_sock(child);
>                 sock_put(child);
> +               reqsk_put(req);
> +               return NULL;
>         }
>         __reqsk_free(req);
>
> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> index 471c78be55137a..2506f415f410bb 100644
> --- a/net/ipv4/tcp_fastopen.c
> +++ b/net/ipv4/tcp_fastopen.c
> @@ -364,8 +364,6 @@ static struct sock *tcp_fastopen_create_child(struct =
sock *sk,
>         tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
>                              req->timeout, false);
>
> -       refcount_set(&req->rsk_refcnt, 2);
> -
>         sk_mark_napi_id_set(child, skb);
>
>         /* Now finish processing the fastopen child socket. */
> @@ -378,6 +376,7 @@ static struct sock *tcp_fastopen_create_child(struct =
sock *sk,
>         tcp_rsk(req)->rcv_nxt =3D tp->rcv_nxt;
>         tp->rcv_wup =3D tp->rcv_nxt;
>         tp->rcv_mwnd_seq =3D tp->rcv_wup + tp->rcv_wnd;
> +       refcount_set_release(&req->rsk_refcnt, 2);
>         /* tcp_conn_request() is sending the SYNACK,
>          * and queues the child into listener accept queue.
>          */
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 99baf14afdfd8f..131aa475e35f69 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7777,7 +7777,8 @@ int tcp_conn_request(struct request_sock_ops *rsk_o=
ps,
>                 if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
>                         bh_unlock_sock(fastopen_sk);
>                         sock_put(fastopen_sk);
> -                       goto drop_and_free;
> +                       reqsk_put(req);
> +                       goto drop;

This leaks the request.

tcp_fastopen_create_child() set rsk_refcnt to 2, and
inet_child_forget() cleared tp->fastopen_rsk without releasing its
reference. A single reqsk_put() leaves the refcount at 1, leaking the
request, its rsk_listener reference, and therefore the netns.

You need to drop both references here.

>                 }
>                 READ_ONCE(sk->sk_data_ready)(sk);
>                 bh_unlock_sock(fastopen_sk);
> diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> index b111b51d69fc9b..7468aca5c1f1ee 100644
> --- a/net/ipv6/inet6_hashtables.c
> +++ b/net/ipv6/inet6_hashtables.c
> @@ -105,10 +105,11 @@ struct sock *__inet6_lookup_established(const struc=
t net *net,
>                         continue;
>                 if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif)=
)
>                         continue;
> -               if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> +               if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcn=
t)))
>                         goto out;
>
> -               if (unlikely(!inet6_match(net, sk, saddr, daddr, ports, d=
if, sdif))) {
> +               if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_=
node) ||
> +                            !inet6_match(net, sk, saddr, daddr, ports, d=
if, sdif))) {
>                         sock_gen_put(sk);
>                         goto begin;
>                 }
> --
> 2.43.0
>
