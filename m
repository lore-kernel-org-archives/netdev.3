Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778869;
	b=nPrE+TvmEG6ynusiA+aqCY+knTspgfaUvisp+FfttgKX3Qx9OT2Kre6IP5xeedZTcfPi
	 xqomavPtJ0YHt8YAAbMw4pNKjQTe5xlEUmBJUqFBxMvuz5N6rDz5NRjRCD9qr6FJq9b75
	 ygkE5/W/zkZrSYp1DYY8h/TOs54kVfHRA4D9bdtsJ5hvsuwGbX88KLHNrf+iit5sJ0Euv
	 DoHlmuG5gjK0DcdL9xS6PKybtVuUYjTXLRvpXlO4p73zpwk0gFEB5iAyXO/bEPjUVtxLV
	 fqiUJqTNQdMIyZPjTOwKeLTZ+WyawiaCVr5shxYOTRIej0b8+zCGFrkNV+0lL++aocA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=l8yh+J8SSNLKfskLT/Z2Pcy1PDMooIjufZ+RCRIv0iE=;
	b=NxA3Eq7RYIGfZ29aL8HSYhB7Tw5zkKg5L4B3ulo0jq/mcJn0ej2hzb7c75tBJ0a5GBAE
	 Fa8vj34oCOGvmZNYJzZHnbtQUjBzWjz8Od1fgPboLXBrx7Y2/NFtEr3F++y0GhIxkbju7
	 6AZKu4ctE/QDzfB2Jly4meKCF3qWruQpfgzrQcryKkxE8YglToAD1r67ue6DQs/tjoJBr
	 b8OAywLcxhGYMwPCuRFEG57vaeo07KvcKiVM72NyTQz0marirVqwM9buLKPoEoXY9ChcV
	 S2Ve+M63crH40KY1EgbDInK0e0pOMDYQxGGRMrYOplNXs+SL1vqUgEa5XpENaE28WOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lPZbBEpC;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B891606A328
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 18:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B891606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lPZbBEpC
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-18cdcfc05ffso1327559c88.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778868; x=1793383668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l8yh+J8SSNLKfskLT/Z2Pcy1PDMooIjufZ+RCRIv0iE=;
        b=lPZbBEpCXSmjLCMTay3uooK8s96fbEKE6OAo9MCbUAhyVEINNWSYI0RLkJVWmU9nik
         1iMw7TCEUWr4SCYV4G9ChwQ6ZdbldyjTZl4bHsRj6HyvzcATfQP8jjAOwSDDExSxp2SD
         gbZXjVrmvVfgW2IiMs8qO0/J7gr9IghG0ZhGa/7wu7VtEiAHytKBy37Pa7JeuNfZQuT2
         nspyqCmib51TtqozDzKUPqRfnU26iqToUARxHY28kejr6NkAOhAne+t87oeGd2ALsLkx
         HWi+18h3pknGEaKOTDL6GLRCFMGx4qbv0AcbB3TBJXRSutA2jiIlgQCt6YdZCG49ELAO
         BXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778868; x=1793383668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=l8yh+J8SSNLKfskLT/Z2Pcy1PDMooIjufZ+RCRIv0iE=;
        b=cfuMSshDRX3fem6UN1n3BmsP03M9SfGi7v5u0tca6lFY5lrFW+tWSR9/gd1cF6ijak
         wnvAQdZVyqSi5KvjGWipRQPSR5oviT0iUnwRPPGs4U2nsz3lRtV6mb0ZeFxSSDK3Kq5N
         YOOuyiUpmjWNqtOcaYULOSV/KrqmDvVYfhRfS9gY/jMF7tvUa9MzvA888Jxy1ACRB/ia
         G2ZpAm+Pa+HrmB3dvCQDT8FN6ydPdH3PC7+j4i28atcNcYWgRR6o4h895Pfe1HZvRmnl
         BbC7VyQt40cZDZVMb/O2nW3X69M0fKcTmJyYwAQB3TEvy86mZXpgQlP8XvC49IQ3jFz2
         k4lg==
X-Forwarded-Encrypted: i=1; AKwUvBzy0SewEKDczTOnF1oxOwH6maHZa54y/oQxWY146IsQX0V0f76U+tmOZ/2UsFmW1hu44ey5VGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/dObt4C38VLhhNVKubzBvzqaFylwnAS98GgVBb4ZKJcaIRHQK
	6wCO87u/nWwFPNbxASJBYr7S0l+tHA/oTFiRRhmGjflxmxM3IdY2N6yf
X-Gm-Gg: AYBFou1jiLFW5t//BUpzHw9OegEpla5V2cfLtwzOcdtAMEzSa9xLOVCVsHyYh4+XKAs
	lp6BONOv2jDnU2nKX2XnfpveNYMeWWX8TsI5mc/twbzR+E2faN73BtbEImq4z9QhUCYba5mu/84
	6s0V1ITQPNTiwsflLZyLkEm9q20BrBI4+8mIw5D+4vCd2sWp10KtAxOc6oaxKEx5psMi/S8K8Nh
	Icdb3nIjMu9qR8015R+ljbqxZQ91omJIzJN8Y0fIDJHlajJB79rYmGstGWhqERShwYWtLV+5VI1
	HWcYvlTo8YHeqxvkvKF5lo2xbh4/EZE+hIGY7cprbBGzAqkbqomrroageJub3YKgPgqR2QhrFxE
	uU5p9QRQsfhBlHTlkSTcKCl+Exai1j4WObKG7q1oNRIqbjK35qn93YE9srB5qIlyZ5sD11KHLVG
	G2D2kwlIuL5ad7kzqYb80x46RYg5H0pFqfPHlfX8cQPqLXmVy1eEU59iSOb9VDTYa98CjvKTBXC
	IWM5eE7UlK9MvRvv2J1YF+I/Y4jcDwQRagPQoM99Zhj6Ij2mHX/hWZhTXE8NY5D4/XsBWHdPrw=
X-Received: by 2002:a05:7022:3b85:b0:187:efba:9ba2 with SMTP id a92af1059eb24-195c6f00fa6mr4476139c88.44.1792778868167;
        Fri, 23 Oct 2026 11:07:48 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm612623c88.17.2026.10.23.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:07:47 -0700 (PDT)
Date: Sat, 24 Oct 2026 03:07:42 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
	sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2 2/2] inet: restore refcount ordering for
 established lookups
Message-ID: <atuibj7fzdSpOHN9@v4bel>
References: <20261023052542.3505250-1-imv4bel@gmail.com>
 <20261023052542.3505250-3-imv4bel@gmail.com>
 <CAL4WiipDcvmNMeeC1znRmtykFg1uwb5XOZVOoi9y0dVECXtHVw@mail.gmail.com>
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
In-Reply-To: <CAL4WiipDcvmNMeeC1znRmtykFg1uwb5XOZVOoi9y0dVECXtHVw@mail.gmail.com>

On Fri, Oct 23, 2026 at 06:33:53PM +0200, Eric Dumazet wrote:
> Le ven. 23 oct. 2026 à 07:26, Hyunwoo Kim <imv4bel@gmail.com> a écrit :
> >
> > When commit 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use
> > RCU / hlist_nulls") was written, atomic_inc_not_zero() provided full
> > memory ordering. Even after commit 41c6d650f653 ("net: convert
> > sock.sk_refcnt from atomic_t to refcount_t"), default builds used
> > atomic_add_unless() and retained that ordering.
> >
> > Commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > of refcount_t") consolidated the refcount_t implementations in v5.5.
> > On weakly ordered architectures, this removed the ordering required
> > by validation after a successful reference acquisition.
> >
> > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> > lookups. Use refcount_set_release() when setting initial refcounts in
> > sk_clone(), SYN cookie, and request migration paths. In the TCP Fast
> > Open path, move the refcount update after the required initialization
> > and use release ordering.
> >
> > The TIME_WAIT path already has an smp_wmb() between refcount_set() and
> > hash publication, so leave it unchanged.
> 
> This is not accurate. The smp_wmb() in inet_twsk_hashdance_schedule()
> orders the tw_refcnt store against the ehash publication, not the tw
> identity stores done in inet_twsk_alloc() against the tw_refcnt store.
> 
> The latter is what a lookup holding a stale pointer needs. Today we get it
> more or less by accident from the bhash spin_unlock() followed by
> spin_lock() of the ehash lock.
> 
> Please either reword this paragraph, or simply use
> refcount_set_release(&tw->tw_refcnt, 3) there; it is free under the lock
> and makes the pairing explicit.

OK, I'll switch to refcount_set_release().

> 
> 
> >
> > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> 
> refcount_inc_not_zero_acquire() and refcount_set_release() were only
> added in 7f8ceea0c580 ("refcount: provide ops for cases when object's
> memory can be reused"), in v6.15.
> 
> 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/core/sock.c                 | 3 +--
> >  net/ipv4/inet_connection_sock.c | 6 +++---
> >  net/ipv4/inet_hashtables.c      | 2 +-
> >  net/ipv4/syncookies.c           | 2 +-
> >  net/ipv4/tcp_fastopen.c         | 3 +--
> >  net/ipv6/inet6_hashtables.c     | 2 +-
> >  6 files changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 3c25d66ba31a..f3ef9601ab73 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2622,8 +2622,7 @@ struct sock *sk_clone(const struct sock *sk, const gfp_t priority,
> >         /* Before updating sk_refcnt, we must commit prior changes to memory
> >          * (Documentation/RCU/rculist_nulls.rst for details)
> >          */
> > -       smp_wmb();
> > -       refcount_set(&newsk->sk_refcnt, 2);
> > +       refcount_set_release(&newsk->sk_refcnt, 2);
> 
> This part is not a fix: the writer side only needs store->store ordering,
> which smp_wmb() already provides.
> 
> I do not mind the conversion, but then reqsk_queue_hash_req() (which has
> the same smp_wmb() + refcount_set() pattern) should be converted as well
> for consistency. Otherwise please drop this hunk to keep the stable
> backport minimal.
> 
> 
> >
> >         sk_set_socket(newsk, NULL);
> >         sk_tx_queue_clear(newsk);
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index cff02f4c5ac8..2d8e54d3a31b 100644
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
> > @@ -1441,7 +1441,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
> >                                 goto child_put;
> >                         }
> >
> > -                       refcount_set(&nreq->rsk_refcnt, 1);
> > +                       refcount_set_release(&nreq->rsk_refcnt, 1);
> >                         if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
> >                                 __NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
> >                                 reqsk_migrate_reset(req);
> > @@ -1494,7 +1494,7 @@ void inet_csk_listen_stop(struct sock *sk)
> >                 if (nsk) {
> >                         nreq = inet_reqsk_clone(req, nsk);
> >                         if (nreq) {
> > -                               refcount_set(&nreq->rsk_refcnt, 1);
> > +                               refcount_set_release(&nreq->rsk_refcnt, 1);
> >
> >                                 rcu_read_lock();
> >                                 if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 58d54965036a..7ffa9171d6de 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
> >                 if (sk->sk_hash != hash)
> >                         continue;
> >                 if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> > -                       if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +                       if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >                                 goto out;
> >                         if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> >                                      !inet_match(net, sk, acookie, ports, dif,
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 644030561537..4b2d2713653b 100644
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
> > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > index 471c78be5513..2506f415f410 100644
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
> 
> Moving this is harmless, but not needed. The lookup never looks at
> rcv_nxt, and this req is never hashed, so after patch 1/2 a stale lookup
> will reject it anyway. A plain conversion in place would be enough.
> 
> Let's keep code churn minimal, to lower risk of merge conflicts.

I'll submit v3 with all unnecessary changes removed. Thanks for the review.


Best regards,
Hyunwoo Kim
