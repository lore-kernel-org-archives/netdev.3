Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793158156;
	b=0sqs1ZV9zym+u0j36CvsWF3O3fSpV0iS6f5+7m3O2xns8snyMqO2rt8DOHR4rMGoWwdj
	 V44wVL0p2cYxCdK/sM/kUhlfgWML88QsdZ74W+U+gy10lHUpZN0nDvTpOsCQPcPjw26on
	 DzSlRtTYNR0+37fHSUMQoSjE7tfqI53mKScBKavt6HxiZ/ZnwzSC6stb0Rvu2EuorfI0J
	 sVh/Ji2jJv8+Z8kxPeGVEJt4/Y3N9s0F8w8tQiP9adUrikrCDUUV4QgLsu8YCrCKGH3Le
	 xqZUOrNjFnPtSy+hSN1lrUIDQ9UwU5mxpAkJ0iNXco5Qed+QActJE5Zf+s5XQo/Cfxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Kk+1t0b0DKZaul87Zv25lHrAh2UEd2PmUOMEfr4aozc=;
	b=v6m86IQEOqowZ+cN0WpbDGcru+j9NjWtWB44Cy45vJAb1odZUhERF3Rz+Gc9elNke2Fr
	 KcfFsiBky5b7koglpjkO9GeH3qVl2OkhmDlvAqBbPsBohYxrQoKQzhgCCikoeHqalE99l
	 n+ayliPpJY1QhcMiFVf0I81jT5zPLm/4d+IdsRED7Wmnxl5QIwf8bhXnqax6LxkaUsW+5
	 lAQRB+iAtwwgs5QC8y2aFJ4IySwFGFNZuClH4E1HFzgYIu6CrP33CVRrPh8QTYg3fa0tc
	 sQHk9SOJmcAHyRAMHzc+4MzY9/gnLhv3XtpxAWB2ocxA+B2CVNzp0BOtyZFYnLniDrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmiW5xRr;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78441606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78441606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MmiW5xRr
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e95bd1c14cso3781745ad.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 20:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793158156; x=1793762956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kk+1t0b0DKZaul87Zv25lHrAh2UEd2PmUOMEfr4aozc=;
        b=MmiW5xRrJU9cQwWwzg4G+OihR8WEy/IgFwb12nmHXnySG+vB6UOOZtbjtAhzeFYhpx
         dKAyeLcY7ucK1JBCorSfRpjbZjjnSgbTX/DZs/wmvhh7wrEfa/fk6YVqfcPlM/rgzEAI
         X5dB2NsSENnufyMdoCDTVkKdVF4PsHdz4WA06lNVTM2pBBRXJiWk8+LXhCRHYPHwsQDF
         QxDdvLRQlXzb5KLwz6ZIOFQUkoLPju9usIxDdpWWrdQegQUdJqqU4+8YL+UajXf4U577
         2B409dXk63yiaTkLPa9oc3Nb+sab5zyudZRJrOLmd0+jmJkpoCz30rH+mmpEBG+LAwBL
         44/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793158156; x=1793762956;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kk+1t0b0DKZaul87Zv25lHrAh2UEd2PmUOMEfr4aozc=;
        b=Cni845zpkYWBx9S2rJmpHqwxOzfa4b6vQGGK29JEHbkp0VNE7SYOr1VjUIDIae/Udm
         idWAfrIu/scsoLRIU79gI448q/fzMnIX68KFanncE+5wDu19pvSuJS6maFYMHbxBoxP7
         QLJKd8LDUZ8eVK6uXW1d26sUwQfnU8v7CBMkq4PyvvxlnvTfCAgNYoEdOoitGQ6Bzvds
         H8ypU7VHAbhR4NBWutyaVjC35HG60ZeFhu8802pRu5pdNVGaAu+81kPZRmlZwXLMCmP+
         qqZHjYJTGa/EGXyQYBx0x7NWA2QCCA/qUvUfeMwnRx2qakSh2yjecHzui53odbVqAZVJ
         Q8NQ==
X-Forwarded-Encrypted: i=1; AKwUvBzV6GG/7QeuUHUBW687nQLrfxxC1BvxW4gAet1/KNamMb7yDGGDN3mh3+82g4pNu8vwXzSpAjo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvRzKAj7eycxTVd2gt53lHdyuqiA2/5EukLbcLlBIrmren4njC
	D8em48qzzgU0D1mNXMfV1w/FMTTbvNi9iEjblMaWdt/yplxVrV9dMrEoTf0+/w==
X-Gm-Gg: AYBFou1Q/zxCMb7R8vz9X07FF0IE48AR0ptiuZ95X1OQE3XRlfZ3pCuJD/mazJexcIA
	ad7vR8HDM4sa+HXf87b+piF7L8EBV7q8y2l1PfX5NWmeWsMMCASbN867wy9s1KJpalQ+XQdg6tD
	mtEWiTH2oeWdsjgrzIwefn8HC0tJ3KVVAFs3bh3msPJk33k+6n6dntVhPgX3TuaVl8AE87FpfaX
	I2LtbXMrjr9+j7PxXTQ8WMlQeI0NyZ6ueeEGgdE0Jo6qzl3ydZVkjW6pS1QUgislF63qfKoE9sh
	3Zd0BPznC3e/oNVefxHqFcVM/ZV+3Qk9JKn/PpeFcVwbJev6TNOj5OZJh75WDJZk+ZrBT5xDfqa
	hlELNk5zCUx08MgJ890OYTOXsC0i+9lUI8cm6PKVf0EqrjWgWe/mghV3OYKWAPkJkmr23vxEkcd
	QiH0OizznpvtI9kKNJJ9yRCVICm5PacQhsYVb6mHF1bXUpo2NrzWZBoaavRh7TueubObgnUY0eZ
	Tz7Xp8L4gf+0imtZu69P47zKhR6t2X328CLTCMRFA/Zhgl0mjH7hOVLS8GcK4m0t6fs4DUUq02M
	jNa8xz6sF3WTNIaofEWRXwUoiVxYcf7el6QvhKqtbiaSma3o
X-Received: by 2002:a17:90b:510f:b0:3ad:eb34:4c6c with SMTP id 98e67ed59e1d1-3ae57f629camr769035a91.13.1793158155725;
        Tue, 27 Oct 2026 20:29:15 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a48d7basm869780a91.3.2026.10.27.20.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 20:29:15 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:29:10 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
	sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4 2/2] inet: restore refcount ordering for lockless
 ehash walks
Message-ID: <auFsBkQInOabvUEd@v4bel>
References: <20261026003804.61923-1-imv4bel@gmail.com>
 <20261026003804.61923-3-imv4bel@gmail.com>
 <auFUvRnF2uDgZix8@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auFUvRnF2uDgZix8@google.com>

On Wed, Oct 28, 2026 at 02:13:15AM +0000, Kuniyuki Iwashima wrote:
> On Mon, 26 Oct 2026 09:37:45 +0900, Hyunwoo Kim wrote:
> > Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
> > of refcount_t"), default builds implemented refcount_inc_not_zero() using
> > atomic_add_unless(), which provided full memory ordering on success. The
> > commit removed that ordering on weakly ordered architectures, allowing
> > validation after a successful reference acquisition in lockless ehash
> > walks to be reordered before it.
> > 
> > Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
> 
> Does bpf_sk_assign() need it too ?
> 
> If the socket is taken from lookup helper, it's safe, but what
> happens if the pointer is taken from BTF (27e5203bd9c5), e.g.
> tp->inet_conn.icsk_accept_queue.rskq_accept_head ?

Yeah the same ordering issue remains when the pointer is obtained from 
BTF without a reference. Fixes: 27e5203bd9c5.

However, I think this is better handled in a separate follow-up patch. 
What do you think?

> 
> 
> > lookups and in inet_twsk_purge(), where the network namespace is validated
> > again after taking a reference. Use refcount_set_release() when setting
> > refcounts in the SYN cookie, TCP Fast Open, request migration, and
> > TIME_WAIT paths. Keep the existing TIME_WAIT smp_wmb(), which separately
> > orders the refcount store before ehash publication.
> > 
> > Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/ipv4/inet_connection_sock.c | 6 +++---
> >  net/ipv4/inet_hashtables.c      | 2 +-
> >  net/ipv4/inet_timewait_sock.c   | 4 ++--
> >  net/ipv4/syncookies.c           | 2 +-
> >  net/ipv4/tcp_fastopen.c         | 2 +-
> >  net/ipv6/inet6_hashtables.c     | 2 +-
> >  6 files changed, 9 insertions(+), 9 deletions(-)
> > 
> > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> > index bd0bad96c93c3..837cb91e5b173 100644
> > --- a/net/ipv4/inet_connection_sock.c
> > +++ b/net/ipv4/inet_connection_sock.c
> > @@ -1056,8 +1056,8 @@ static void reqsk_timer_handler(struct timer_list *t)
> >  		 * hold another count to prevent use-after-free and
> >  		 * call reqsk_put() just before return.
> >  		 */
> > -		refcount_set(&nreq->rsk_refcnt, 2 + 1);
> >  		timer_setup(&nreq->rsk_timer, reqsk_timer_handler, TIMER_PINNED);
> > +		refcount_set_release(&nreq->rsk_refcnt, 2 + 1);
> >  		reqsk_queue_migrated(&inet_csk(nsk)->icsk_accept_queue, req);
> >  
> >  		req = nreq;
> > @@ -1441,7 +1441,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
> >  				goto child_put;
> >  			}
> >  
> > -			refcount_set(&nreq->rsk_refcnt, 1);
> > +			refcount_set_release(&nreq->rsk_refcnt, 1);
> >  			if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
> >  				__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
> >  				reqsk_migrate_reset(req);
> > @@ -1494,7 +1494,7 @@ void inet_csk_listen_stop(struct sock *sk)
> >  		if (nsk) {
> >  			nreq = inet_reqsk_clone(req, nsk);
> >  			if (nreq) {
> > -				refcount_set(&nreq->rsk_refcnt, 1);
> > +				refcount_set_release(&nreq->rsk_refcnt, 1);
> >  
> >  				rcu_read_lock();
> >  				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
> > diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> > index 58d54965036a2..7ffa9171d6de1 100644
> > --- a/net/ipv4/inet_hashtables.c
> > +++ b/net/ipv4/inet_hashtables.c
> > @@ -550,7 +550,7 @@ struct sock *__inet_lookup_established(const struct net *net,
> >  		if (sk->sk_hash != hash)
> >  			continue;
> >  		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
> > -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >  				goto out;
> >  			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> >  				     !inet_match(net, sk, acookie, ports, dif,
> > diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
> > index d4c781a0667fe..74ff40d42e56b 100644
> > --- a/net/ipv4/inet_timewait_sock.c
> > +++ b/net/ipv4/inet_timewait_sock.c
> > @@ -141,7 +141,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
> >  	 * Also note that after this point, we lost our implicit reference
> >  	 * so we are not allowed to use tw anymore.
> >  	 */
> > -	refcount_set(&tw->tw_refcnt, 3);
> > +	refcount_set_release(&tw->tw_refcnt, 3);
> >  
> >  	/* Ensure tw_refcnt has been set before tw is published.
> >  	 * smp_wmb() provides the necessary memory barrier to enforce this
> > @@ -328,7 +328,7 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
> >  			if (check_net(sock_net(sk)))
> >  				continue;
> >  
> > -			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >  				continue;
> >  
> >  			if (check_net(sock_net(sk))) {
> > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > index 6440305615378..4b2d2713653b7 100644
> > --- a/net/ipv4/syncookies.c
> > +++ b/net/ipv4/syncookies.c
> > @@ -205,7 +205,7 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
> >  	child = icsk->icsk_af_ops->syn_recv_sock(sk, skb, req, dst,
> >  						 NULL, &own_req, NULL);
> >  	if (child) {
> > -		refcount_set(&req->rsk_refcnt, 1);
> > +		refcount_set_release(&req->rsk_refcnt, 1);
> >  		sock_rps_save_rxhash(child, skb);
> >  
> >  		if (rsk_drop_req(req)) {
> > diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
> > index 471c78be55137..e40477b6b5549 100644
> > --- a/net/ipv4/tcp_fastopen.c
> > +++ b/net/ipv4/tcp_fastopen.c
> > @@ -364,7 +364,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
> >  	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
> >  			     req->timeout, false);
> >  
> > -	refcount_set(&req->rsk_refcnt, 2);
> > +	refcount_set_release(&req->rsk_refcnt, 2);
> >  
> >  	sk_mark_napi_id_set(child, skb);
> >  
> > diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
> > index aa5fa1dd062f7..1eea584d80df8 100644
> > --- a/net/ipv6/inet6_hashtables.c
> > +++ b/net/ipv6/inet6_hashtables.c
> > @@ -105,7 +105,7 @@ struct sock *__inet6_lookup_established(const struct net *net,
> >  			continue;
> >  		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
> >  			continue;
> > -		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +		if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
> >  			goto out;
> >  
> >  		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
> > -- 
> > 2.43.0
> > 
