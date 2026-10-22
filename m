Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635213;
	b=V3x5oQw4oFf0CuzoV7EbjGDdwa2aV7yHxmW5KIHtwe2wPLkae9A0SLM3sAU6gNFfleIz
	 1zWuO/r7wbkRsHji5VB+oyqNRGKkMy/ILzUiDXZV/T5mAdfNOmxNaH641PZ/S+c3RRueR
	 cMBUwsoBAXh32pYX+Lccq6QHE94CuhZTBEn2gOejFL8hDBS9scnPSLlKZN0sEGcU5Q+Ma
	 Ua+hFpC34MU9cgxQzPq9nGjBwsdMbis+Zd497EiIZ2IQBKPKEQvVwAjllLw4BT87S8Qf2
	 PaY8F39BdAKcvNp9kg+UUXvwX5jmSSOluecerV/3L64WHt3wlYw4gP4FavO2+XP8PJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=D7FOG2gxlyszvY5NUpCqC8XwkHnHFQqACrHhjpNDFLE=;
	b=leAD3GohqFgPu9EDhhnHOEDFDIl+KUiY6PacOuO2oRWOpITbYqVVJFE0sw8DaYFDcVTv
	 KtxENQs0CW2YwyctjJi8HJ9oBzVoKrL9ORW9tNgqo1vo0GdJcTEw6f1itydOHrZOCbq+u
	 lWnZ1Wz9BeoEZZmwphdxfnPbxjWj7SedNt/aIN70IAQ0I1f4no2Zqj3lZOyrAkoJ1F1ta
	 r8ZcIbYD4lDs5h8y7QrRNaFaDGBPrxlA4UnVc9850jWxTw+VN3kzqFxeF6WwlcktNyky9
	 CgZvv/7lTZudoG3rVFmBLW3Zrtv4lurnuq/05Qv0Qw14+EKX+J9A4J8Luo2VWeVMJ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oIgyKI96;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D948606A31E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 02:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D948606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oIgyKI96
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-15dd124bbe7so2517908c88.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 19:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792635211; x=1793240011; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D7FOG2gxlyszvY5NUpCqC8XwkHnHFQqACrHhjpNDFLE=;
        b=oIgyKI96XHJp556/zOTVyZKHEa6au1sOuXhYRry5zzeFPgqfHj9R/qXuTiazd2/jCB
         FFNJc56L0Z6TnkOXMgzHLy0wZbhfh2JBCfj1LrTS5/JUttzzC+YXZbu2YsDyWtK46SSh
         4ga93EE8jq16k2g6wGDYMaWr4AtxJJkKLnXRNA2T0x/H3/ZSP73E//Alxqq/M+pjNUD5
         f7dBmfszJ7ia0Fd91D/NMAvPjIlPY7v0l5nYGYtSdXOlaVO3ljH63i7fBnAqdaZ8chZ2
         A9/1lskUGMgRsjEk1JuYmbCchfxZtvr0LTjz0e/kZJYQeEHBr7HoJP637VmxounS3la1
         0rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792635211; x=1793240011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D7FOG2gxlyszvY5NUpCqC8XwkHnHFQqACrHhjpNDFLE=;
        b=xExUfXMd7LS5iRYtRt+oD/rTg6fS50Aix0qi5BX7s35cN5ry5hNa18fdCxnp0uQMff
         jv8iUFSShBiGDiC/qn/TVPJz82BxP1mJVJC5puhiOlgWND7zlF0B/DDY3XpmSjCBGUw1
         0wVmd/Iu/ch6gjbk+2VWe9BNbtXoSe377/4kEeBFIhhYBVsWEpvFfg4NpIYz76D+L13i
         jDrP0SCYmIbShMNzhPtIB6vNbWe5v3r9ZCFKeHvcRt1r4bfwHl6rkSA5dfr84Zq+E2By
         vokECwSMggABsN8l/yJJ6nfoS7ce3Dny3kMMbIb75jOwo8YoNISlpCX+x6KD0Ve4WEQc
         RGRg==
X-Forwarded-Encrypted: i=1; AKwUvBz2llboZTLq41W09mp3RzVqtHuFs84vVvfaDR6vVS+m8YeyICHu0jTiH2U6N3x3LUBpkIDBRxk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIuR4FLJ80lv95RAUs8XXwpDksC762jutRUkJW/M72VhUYtRPz8
	gfFJj56hoqkhAgPR2jfkjqmb5ddOCrVNKvSHS9tC3f1mEwQLCEBLRrzx
X-Gm-Gg: AYBFou0+noHZP7SxqFjdI908NCsGx4HG82MmjycEmemWFcS9D/Fc8ZGTYlJEEuxIcns
	QU/WcT0qTmnJ142S9M+TG+ZLMkGd9Lx8eVWgxRX+uARapnMdlqgS7UnqXheSl9mePbIUaAJYEtN
	NslnixC52R1lSbvjuouRa1ku9YTp76kkR2lGuL8mg/Hf9OSnxqV+DIJhSYJfPJr9MAM7mwNWaei
	AgJEYjSc2KYqQ1G1SiSQElKyO1c9u/Nisr0vuPPR0TkAhjTg9C1TLK8gLNL+aRr2MPp7ZXUD8JW
	IVRhsKvxV0zSeQA0YOXf5uriOxPakVeyh+0yr8uj5OxrnvbxzMqzlqhlZQdwvN2Opd8Ri8ZgaF7
	RWAMa99pdCQvx7mqL1gzdzr3nEJVoFgRE+2z6Pq/l3DsIpKWfophs+WlE99473IcQpP8gFHtoTJ
	ijfxBbRQfmv4nX9WzBtBjedSFj1V+0nbSU6lRoBFAsUNkEPIi+1drL+mxu1OIaf15SsF0RyIYLf
	tz/gX+1zXz4968WjBnBmATj3Mofz9z/IilvI1WF1UePrMvFAIIndt7PXGdDu0Kx+Yj3fthDA6A=
X-Received: by 2002:a05:7022:628a:b0:144:c12b:dfc6 with SMTP id a92af1059eb24-190a80ee9a2mr6959988c88.44.1792635211014;
        Wed, 21 Oct 2026 19:13:31 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-190e29381d9sm8595157c88.18.2026.10.21.19.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:13:30 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:13:25 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
	sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net] inet: reject unhashed sockets during established
 lookups
Message-ID: <atlxRcpjHmPWZAax@v4bel>
References: <ath58Egc-oI6p3Jl@v4bel>
 <CAL4Wiipe-=JDzTvr5_SZaZ7b+QEkMyE0Tjh1x=ryJe50yFxKiw@mail.gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4Wiipe-=JDzTvr5_SZaZ7b+QEkMyE0Tjh1x=ryJe50yFxKiw@mail.gmail.com>

On Wed, Oct 21, 2026 at 11:04:58AM +0200, Eric Dumazet wrote:
> Le mer. 21 oct. 2026 à 10:38, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> >
> > TCP established ehash lookups are lockless. The socket caches involved
> > use SLAB_TYPESAFE_BY_RCU, so memory can be reused before an RCU reader
> > that retained its old address has finished.
> >
> > After a tuple match, __inet_lookup_established() and
> > __inet6_lookup_established() acquire a reference and repeat the tuple
> > check. They do not check whether the new object is hashed. If the
> > address is reused for a socket with the same tuple, the lookup can
> > acquire a reference to the new object and return it while its nulls node
> > is unhashed.
> >
> 
> Thanks for the report.
> 
> Rejecting unhashed sockets after taking the reference makes sense:
> syncookie, fastopen and migrated request sockets (and children before
> inet_ehash_nolisten()) can all have a non zero refcount while never
> being in ehash. All allocation paths call sk_node_init(), and all
> removals use the _init_rcu() variants, so the pprev test is reliable,
> and pprev shares a cache line with skc_refcnt.
> 
> Please mention in the changelog that lookups racing with the
> TIME_WAIT hashdance, or with a request being replaced by its child,
> will now restart and find the new socket, instead of returning the
> old one.
> 
> > A PoC that drives reuse with a SYN cookie request socket reproduced the
> > crash. The new request socket is unhashed and has a NULL rsk_listener.
> > A lookup that had loaded the address of the old request socket acquired
> > the reference published by tcp_get_cookie_sock() and returned the new
> > object. tcp_v4_rcv() then read sk_state through the NULL listener.
> >
> > The resulting crash was:
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000012
> >   #PF: supervisor read access in kernel mode
> >   #PF: error_code(0x0000) - not-present page
> >   ...
> >
> >
> > The same stale address pattern also affects full sockets. In an x86
> > KASAN test with enlarged race windows, a stale lookup allowed an RST to
> > change a child socket to TCP_CLOSE while it was being initialized and
> > before ehash insertion.
> 
> I do not see how this can happen. The child is bh-locked from
> sk_clone() until tcp_child_process() (or until the bh_unlock_sock()
> in tcp_conn_request() for fastopen), and inet_ehash_nolisten() is
> called while the lock is held. A stale reader in tcp_v4_rcv() would
> spin in bh_lock_sock_nested() until the child is hashed.

inet_ehash_nolisten() is called with the child lock held. A child created
by sk_clone_lock() briefly inherits TCP_LISTEN from the listener, and its
tuple is set before the transition to TCP_SYN_RECV.

[1] If a stale lookup returns the child during this window, the
TCP_LISTEN test in tcp_v4_rcv() succeeds, so bh_lock_sock_nested() is
skipped. If the child transitions to TCP_SYN_RECV immediately
afterward, the reader can continue into tcp_v4_do_rcv() without taking
the lock.

The child lock therefore does not serialize this path with
inet_ehash_nolisten().

> 
> Please provide the exact interleaving, or remove this paragraph.

The interleaving is a little involved, but the race is as follows.
Should I include this diagram in the changelog, or simply remove the
reference from the changelog?

Personally, I think it would be better to simply remove the paragraph.

           stale RST RX                 server task                 cookie ACK RX


                              listener = socket(AF_INET, SOCK_STREAM, 0)
                              bind(listener, 0.0.0.0:8080)
                              listen(listener, 1)
                              ...
                              A = accept(listener)
                              recv(A)

tcp_v4_rcv(RST) // processes a fragmented RST with the expected sequence number from the peer
  __inet_lookup_established()
    inet_match(A)

                              setsockopt(A, SO_LINGER, {1, 0})
                              close(A)
                                inet_release(A)
                                  tcp_close(A)
                                    __tcp_close(A)
                                      tcp_disconnect(A)
                                        tcp_set_state(A, TCP_CLOSE)
                                          inet_unhash(A)
                                    ...
                                    sock_put(A)
                                      sk_free(A)
                                        kmem_cache_free(TCP, A)

                                                          tcp_v4_rcv(ACK) // processes another SYN cookie ACK for the same tuple from the peer
                                                            tcp_v4_do_rcv(listener)
                                                              tcp_v4_cookie_check()
                                                                cookie_v4_check()
                                                                  tcp_get_cookie_sock()
                                                                    tcp_v4_syn_recv_sock()
                                                                      tcp_create_openreq_child()
                                                                        inet_csk_clone_lock()
                                                                          sk_clone_lock() // creates B locked and in TCP_LISTEN
                                                                          set B tuple // sets B's addresses and ports to match A

    refcount_inc_not_zero(&B->sk_refcnt) // increments B's refcount, not A's
    inet_match(B)
    return B

    ======================== RACE 1 ========================

tcp_v4_rcv(RST) // [1] skips bh_lock_sock_nested(B) when B is observed in TCP_LISTEN

                                                          inet_sk_set_state(B, TCP_SYN_RECV) // changes state after stale RX has skipped the locking path
                                                          WRITE_ONCE(B->rcv_nxt, seq) // sets the value required for the exact sequence check

  tcp_v4_do_rcv(B, RST) // stale RX processes the RST without waiting for B's lock
    tcp_rcv_state_process()
      tcp_validate_incoming()
        tcp_reset()
          tcp_done_with_error()
            tcp_done()
              tcp_set_state(B, TCP_CLOSE)
                inet_unhash(B) // does nothing because B has not been hashed yet

    ======================== RACE 2 ========================

                                                          inet_ehash_nolisten(B) // B remains locked, but stale RX has already bypassed the lock and moved B to TCP_CLOSE
                                                          inet_csk_reqsk_queue_add(listener, req, B)
                                                          tcp_child_process(listener, B, ACK)
                                                            tcp_rcv_state_process(B, ACK)
                                                            bh_unlock_sock(B)
                                                          sock_put(B)

  sock_put(B)

                              B = accept(listener)
                                inet_accept()
                                  inet_csk_accept()
                                    reqsk_queue_remove()
                                  __inet_accept()
                                    sock_graft(B)

                              send(B)

                              close(B)
                                inet_release(B)
                                  tcp_close(B)
                                    __tcp_close(B) // B is already TCP_CLOSE, so inet_unhash() is not called
                                      sock_hold(B)
                                      sock_orphan(B)
                                      inet_csk_destroy_sock(B)
                                        WARN_ON(!sk_unhashed(B))
                                        sock_put(B)
                                    sock_put(B)
                                      sk_free(B)
                                        __sk_free(B)
                                          sk_destruct(B)
                                            __sk_destruct(B)
                                              sk_prot_free(B)
                                                kmem_cache_free(TCP, B) // B is freed while its node remains in the ehash

                                                          net_rx_action() // processes a subsequent ACK for the same tuple from the peer
                                                            ...
                                                            ip_rcv_finish_core()
                                                              tcp_v4_early_demux()
                                                                __inet_lookup_established()
                                                                  if (B->sk_hash != hash) // use-after-fre

> "Enlarged race windows" can easily create schedules that are not
> possible on a real kernel.
> 
> Do not add bugs in the instrumented kernel just to pretend things.

The instrumented kernel did not otherwise change the control flow. I
only added "mdelay()" calls at those points to observe the race
deterministically. The scenario is involved, but I believe the same
interleaving can occur with enough attempts and concurrent processing.

In any case, this "Enlarged race windows" discussion does not belong 
in the changelog. I will remove it.

> 
> 
> 
> > The creation path then inserted the child, and
> > the server accepted it in TCP_CLOSE. The child was later freed while
> > still hashed, and a subsequent lookup reported a use-after-free.
> >
> > Use refcount_inc_not_zero_acquire() when acquiring the reference.
> 
> This is a separate issue, with a different Fixes: tag.
> 
> When 3ab5aee7fe84 was written, sk_refcnt was an atomic_t and
> atomic_inc_not_zero() was fully ordered. Even after the conversion to
> refcount_t (41c6d650f653), default builds used atomic_add_unless().
> The ordering was only lost on weakly ordered arches in v5.5, with
> commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> of refcount_t").
> 
> Please split this into a series:
> 
> 1) Unhashed check in the lookups, and the __reqsk_free() -> reqsk_put()
>    conversions (these are needed because a stale reader can hold a
>    transient reference on a request that was never hashed).
>    Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
> 
> 2) The acquire/release conversions.

Understood.

> 
> If you convert writers to refcount_set_release(), please be
> consistent: sk_clone() still uses refcount_set(&newsk->sk_refcnt, 2),
> and this is precisely the full socket case you mention.
> On the other hand, inet_twsk_hashdance_schedule() already has an
> smp_wmb() right after the refcount_set(), so changing it is not
> needed.
> 
> 
> > After the reference is acquired, restart the lookup if the nulls node is
> > unhashed or the tuple no longer matches. This rejects the SYN cookie
> > request socket and blocks the child socket path observed in the x86
> > test.
> >
> > Use release ordering when setting initial nonzero refcounts in the SYN
> > cookie, TCP Fast Open, request migration, and TIME_WAIT paths. This
> > makes initialization performed before the refcount update visible to a
> > reader that acquires a reference. After a nonzero request refcount has
> > been published, release it with reqsk_put() on failure instead of
> > freeing the request directly.
> >
> > Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 14 ++++++++------
> >  net/ipv4/inet_hashtables.c      |  7 ++++---
> >  net/ipv4/inet_timewait_sock.c   |  2 +-
> >  net/ipv4/syncookies.c           |  4 +++-
> >  net/ipv4/tcp_fastopen.c         |  3 +--
> >  net/ipv4/tcp_input.c            |  3 ++-
> >  net/ipv6/inet6_hashtables.c     |  5 +++--
> >  7 files changed, 22 insertions(+), 16 deletions(-)
> >
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index 6a30f11384547e..25b46beed63541 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
> >                  * hold another count to prevent use-after-free and
> >                  * call reqsk_put() just before return.
> >                  */
> > -               refcount_set(&nreq->rsk_refcnt, 2 + 1);
> >                 timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> > +               refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
> >                 reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
> >
> >                 req = nreq;
> > @@ -1136,10 +1136,12 @@ static void reqsk_timer_handler(struct timer_list *t)
> >          */
> >         if (nreq) {
> >                 __NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQFAILURE);
> > +               reqsk_put(nreq);
> >  no_ownership:
> >                 reqsk_migrate_reset(nreq);
> >                 reqsk_queue_removed(queue, nreq);
> > -               __reqsk_free(nreq);
> > +               reqsk_put(nreq);
> > +               reqsk_put(nreq);
> 
> The accounting looks right on both paths, but three reqsk_put() split
> around a label are hard to follow. Please add a comment explaining
> which references are released on each path.
> 
> >         }
> >
> >  drop:
> > @@ -1437,7 +1439,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
> >                                 goto child_put;
> >                         }
> >
> > -                       refcount_set(&nreq->rsk_refcnt, 1);
> > +                       refcount_set_release(&nreq->rsk_refcnt, 1);
> >                         if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
> >                                 __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
> >                                 reqsk_migrate_reset(req);
> > @@ -1447,7 +1449,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
> >
> >                         __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
> >                         reqsk_migrate_reset(nreq);
> > -                       __reqsk_free(nreq);
> > +                       reqsk_put(nreq);
> >                 } else if (inet_csk_reqsk_queue_add(sk, req, child)) {
> >                         return child;
> >                 }
> > @@ -1490,7 +1492,7 @@ void inet_csk_listen_stop(struct sock *sk)
> >                 if (nsk) {
> >                         nreq = inet_reqsk_clone(req, nsk);
> >                         if (nreq) {
> > -                               refcount_set(&nreq->rsk_refcnt, 1);
> > +                               refcount_set_release(&nreq->rsk_refcnt, 1);
> >
> >                                 rcu_read_lock();
> >                                 if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
> > @@ -1502,7 +1504,7 @@ void inet_csk_listen_stop(struct sock *sk)
> >                                         __NET_INC_STATS(sock_net(nsk),
> >                                                         LINUX_MIB_TCPMIGRATEREQFAILURE);
> >                                         reqsk_migrate_reset(nreq);
> > -                                       __reqsk_free(nreq);
> > +                                       reqsk_put(nreq);
> >                                 }
> >                                 rcu_read_unlock();
> >
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index ba0faa9ae2bb3a..7ffa9171d6de10 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -550,10 +550,11 @@ struct sock *__inet_lookup_established(const struct net *net,
> >                 if (sk->sk_hash != hash)
> >                         continue;
> >                 if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> > -                       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +                       if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >                                 goto out;
> > -                       if (unlikely(!inet_match(net, sk, acookie,
> > -                                                ports, dif, sdif))) {
> > +                       if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> > +                                    !inet_match(net, sk, acookie, ports, dif,
> > +                                                sdif))) {
> >                                 sock_gen_put(sk);
> >                                 goto begin;
> >                         }
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> > index d4c781a0667fe5..88ea3a101849aa 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -141,7 +141,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> >          * Also note that after this point, we lost our implicit reference
> >          * so we are not allowed to use tw anymore.
> >          */
> > -       refcount_set(&tw->tw_refcnt, 3);
> > +       refcount_set_release(&tw->tw_refcnt, 3);
> >
> >         /* Ensure tw_refcnt has been set before tw is published.
> >          * smp_wmb() provides the necessary memory barrier to enforce this
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 73e12976818473..4b2d2713653b75 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
> >         child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
> >                                                  NULL, &own_req, NULL);
> >         if (child) {
> > -               refcount_set(&req->rsk_refcnt, 1);
> > +               refcount_set_release(&req->rsk_refcnt, 1);
> >                 sock_rps_save_rxhash(child, skb);
> >
> >                 if (rsk_drop_req(req)) {
> > @@ -218,6 +218,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
> >
> >                 bh_unlock_sock(child);
> >                 sock_put(child);
> > +               reqsk_put(req);
> > +               return NULL;
> >         }
> >         __reqsk_free(req);
> >
> > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > index 471c78be55137a..2506f415f410bb 100644
> > --- a/net/ipv4/tcp_fastopen.c
> > +++ b/net/ipv4/tcp_fastopen.c
> > @@ -364,8 +364,6 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
> >         tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
> >                              req->timeout, false);
> >
> > -       refcount_set(&req->rsk_refcnt, 2);
> > -
> >         sk_mark_napi_id_set(child, skb);
> >
> >         /* Now finish processing the fastopen child socket. */
> > @@ -378,6 +376,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
> >         tcp_rsk(req)->rcv_nxt = tp->rcv_nxt;
> >         tp->rcv_wup = tp->rcv_nxt;
> >         tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
> > +       refcount_set_release(&req->rsk_refcnt, 2);
> >         /* tcp_conn_request() is sending the SYNACK,
> >          * and queues the child into listener accept queue.
> >          */
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 99baf14afdfd8f..131aa475e35f69 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -7777,7 +7777,8 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
> >                 if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
> >                         bh_unlock_sock(fastopen_sk);
> >                         sock_put(fastopen_sk);
> > -                       goto drop_and_free;
> > +                       reqsk_put(req);
> > +                       goto drop;
> 
> This leaks the request.
> 
> tcp_fastopen_create_child() set rsk_refcnt to 2, and
> inet_child_forget() cleared tp->fastopen_rsk without releasing its
> reference. A single reqsk_put() leaves the refcount at 1, leaking the
> request, its rsk_listener reference, and therefore the netns.
> 
> You need to drop both references here.

I was a little confused by this part, so I checked the path more
carefully.

req->sk is set only on the success path of
inet_csk_reqsk_queue_add(). It remains NULL on the failure path, so
tcp_disconnect() drops one reference through reqsk_fastopen_remove().

tcp_conn_request()
  inet_csk_reqsk_queue_add(sk, req, fastopen_sk) // fails
    inet_child_forget(sk, req, fastopen_sk)
      sk->sk_prot->disconnect(fastopen_sk, O_NONBLOCK)
        tcp_disconnect(fastopen_sk, O_NONBLOCK)
          reqsk_fastopen_remove(fastopen_sk, req, false)
            reqsk_put(req) // 2 -> 1 when no transient lookup reference is held

  reqsk_put(req)           // 1 -> 0 when no transient lookup reference is held

A transient reference held by a lookup is released separately in the
lookup path. The caller therefore needs only one reqsk_put(). Calling it
twice would drop one reference too many and could cause a UAF.

I therefore think the caller should keep a single reqsk_put(), as in v1,
and add a short comment noting that reqsk_fastopen_remove() has already
dropped one reference.

> 
> >                 }
> >                 READ_ONCE(sk->sk_data_ready)(sk);
> >                 bh_unlock_sock(fastopen_sk);
> > diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> > index b111b51d69fc9b..7468aca5c1f1ee 100644
> > --- a/net/ipv6/inet6_hashtables.c
> > +++ b/net/ipv6/inet6_hashtables.c
> > @@ -105,10 +105,11 @@ struct sock *__inet6_lookup_established(const struct net *net,
> >                         continue;
> >                 if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
> >                         continue;
> > -               if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +               if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >                         goto out;
> >
> > -               if (unlikely(!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))) {
> > +               if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> > +                            !inet6_match(net, sk, saddr, daddr, ports, dif, sdif))) {
> >                         sock_gen_put(sk);
> >                         goto begin;
> >                 }
> > --
> > 2.43.0
> >

Before sending v2, I would like to make sure I understood your comments
correctly. I plan to make the following changes. Does this look right?

PATCH 1:

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6a30f1138454..cff02f4c5ac8 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1136,10 +1136,14 @@ static void reqsk_timer_handler(struct timer_list *t)
 	 */
 	if (nreq) {
 		__NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQFAILURE);
+		/* The timer was not armed, drop its reference here. */
+		reqsk_put(nreq);
 no_ownership:
 		reqsk_migrate_reset(nreq);
 		reqsk_queue_removed(queue, nreq);
-		__reqsk_free(nreq);
+		/* Drop the ehash and temporary references. */
+		reqsk_put(nreq);
+		reqsk_put(nreq);
 	}

 drop:
@@ -1447,7 +1451,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,

 			__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
 			reqsk_migrate_reset(nreq);
-			__reqsk_free(nreq);
+			reqsk_put(nreq);
 		} else if (inet_csk_reqsk_queue_add(sk, req, child)) {
 			return child;
 		}
@@ -1502,7 +1506,7 @@ void inet_csk_listen_stop(struct sock *sk)
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
 					reqsk_migrate_reset(nreq);
-					__reqsk_free(nreq);
+					reqsk_put(nreq);
 				}
 				rcu_read_unlock();

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ba0faa9ae2bb..58d54965036a 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -552,8 +552,9 @@ struct sock *__inet_lookup_established(const struct net *net,
 		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
 			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 				goto out;
-			if (unlikely(!inet_match(net, sk, acookie,
-						 ports, dif, sdif))) {
+			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+				     !inet_match(net, sk, acookie, ports, dif,
+						 sdif))) {
 				sock_gen_put(sk);
 				goto begin;
 			}
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 73e129768184..644030561537 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -218,6 +218,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,

 		bh_unlock_sock(child);
 		sock_put(child);
+		reqsk_put(req);
+		return NULL;
 	}
 	__reqsk_free(req);

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 99baf14afdfd..3583867487d7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7777,7 +7777,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
 			bh_unlock_sock(fastopen_sk);
 			sock_put(fastopen_sk);
-			goto drop_and_free;
+			/* tcp_disconnect() already dropped one reqsk ref. */
+			reqsk_put(req);
+			goto drop;
 		}
 		READ_ONCE(sk->sk_data_ready)(sk);
 		bh_unlock_sock(fastopen_sk);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b111b51d69fc..aa5fa1dd062f 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -108,7 +108,9 @@ struct sock *__inet6_lookup_established(const struct net *net,
 		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
 			goto out;

-		if (unlikely(!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))) {
+		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+			     !inet6_match(net, sk, saddr, daddr, ports, dif,
+					  sdif))) {
 			sock_gen_put(sk);
 			goto begin;
 		}

PATCH 2:

diff --git a/net/core/sock.c b/net/core/sock.c
index 3c25d66ba31a..f3ef9601ab73 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2622,8 +2622,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
 	/* Before updating sk_refcnt, we must commit prior changes to memory
 	 * (Documentation/RCU/rculist_nulls.rst for details)
 	 */
-	smp_wmb();
-	refcount_set(&newsk->sk_refcnt, 2);
+	refcount_set_release(&newsk->sk_refcnt, 2);

 	sk_set_socket(newsk, NULL);
 	sk_tx_queue_clear(newsk);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index cff02f4c5ac8..2d8e54d3a31b 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
 		 * hold another count to prevent use-after-free and
 		 * call reqsk_put() just before return.
 		 */
-		refcount_set(&nreq->rsk_refcnt, 2 + 1);
 		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
+		refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
 		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);

 		req = nreq;
@@ -1441,7 +1441,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 				goto child_put;
 			}

-			refcount_set(&nreq->rsk_refcnt, 1);
+			refcount_set_release(&nreq->rsk_refcnt, 1);
 			if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
 				__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
 				reqsk_migrate_reset(req);
@@ -1494,7 +1494,7 @@ void inet_csk_listen_stop(struct sock *sk)
 		if (nsk) {
 			nreq = inet_reqsk_clone(req, nsk);
 			if (nreq) {
-				refcount_set(&nreq->rsk_refcnt, 1);
+				refcount_set_release(&nreq->rsk_refcnt, 1);

 				rcu_read_lock();
 				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 58d54965036a..7ffa9171d6de 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
 		if (sk->sk_hash != hash)
 			continue;
 		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
-			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 				goto out;
 			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
 				     !inet_match(net, sk, acookie, ports, dif,
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 644030561537..4b2d2713653b 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
 						 NULL, &own_req, NULL);
 	if (child) {
-		refcount_set(&req->rsk_refcnt, 1);
+		refcount_set_release(&req->rsk_refcnt, 1);
 		sock_rps_save_rxhash(child, skb);

 		if (rsk_drop_req(req)) {
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 471c78be5513..2506f415f410 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -364,8 +364,6 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
 			     req->timeout, false);

-	refcount_set(&req->rsk_refcnt, 2);
-
 	sk_mark_napi_id_set(child, skb);

 	/* Now finish processing the fastopen child socket. */
@@ -378,6 +376,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	tcp_rsk(req)->rcv_nxt = tp->rcv_nxt;
 	tp->rcv_wup = tp->rcv_nxt;
 	tp->rcv_mwnd_seq = tp->rcv_wup + tp->rcv_wnd;
+	refcount_set_release(&req->rsk_refcnt, 2);
 	/* tcp_conn_request() is sending the SYNACK,
 	 * and queues the child into listener accept queue.
 	 */
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index aa5fa1dd062f..1eea584d80df 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -105,7 +105,7 @@ struct sock *__inet6_lookup_established(const struct net *net,
 			continue;
 		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
 			continue;
-		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+		if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 			goto out;

 		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||


Best regards,
Hyunwoo Kim
