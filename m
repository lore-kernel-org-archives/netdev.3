Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571894;
	b=4Bsg3xoHGp2x7c5DtR1yafEkHcYfZ+a1f3L55/3lHbtN4R/3ltxQnjy0KkOYorJ+QPvV
	 NAOVqbD/54TueDF03gaIxLhZZ/7lxwcl8v+RqVTw5nRaWQG633lTChm6lp4i88YWqLnda
	 VHocFSbsCoq3xFJ4CNwt1vd4LQMmCAR8H/g87SyznRtAZ3ZAbzJkt+yrhLRL1NiLPOaMP
	 t4ntO59cp7jQl9ERRGgniuQDPNaIj+Y4TdNDnbwMOgUeBuFhnVP8hd7PaVJWx6EDrIPVO
	 aGQ1WnFzQwZRi1oFN8FccrY5nDym2a+IWBBGdFHXWOqnj6bZCxyRqoAXrbEQKC9Dx5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=0DM2se4MDa1QRd53dwq77PpEITS9LrTnNaMogG6Tv3c=;
	b=arXUUhfAMycd+Kt6u3bLo7+QXcZeu+ga0lrGt0snLD869u5ECv7aavSxB8jf3H3/1uMD
	 HbGImbd5g8RNwPg+cwsyzbEC9DHyVnw3JKxa8ZRrgmcc1Cp+eviRZ8nb3+48PwZvDxCJr
	 p2cEbVCKT0teTNFrLK7UwI3aShs9ccFm7W/YM7Bgj9YlV5KnBqbfTVqh9GwqzvTJHfGJq
	 EcyolAjuqWHsrUDNz8ekHAttOWnZ1OtVedph6Ni4JeQg/561rsBRL8N7OTRxie+w7Zie2
	 71zsFFPN9cofHZ4PPA7vRBI10R6SjTELBNiwFtj85khdzrbOfS5Er7UfdOL6bR/+bow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fupdEtSX;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FAC606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71FAC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fupdEtSX
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-89f85edd210so172473b3a.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 01:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792571893; x=1793176693; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0DM2se4MDa1QRd53dwq77PpEITS9LrTnNaMogG6Tv3c=;
        b=fupdEtSXazoMlbflM+ZiNuDhamPkCZIR93hweGaa2gktGvpxdqdIQc1ninPWXWna8S
         a25vD5WNOBWbBBdhhqrwzlYBkMktyIK7CVxy4lKmEg0e2esAFgiM9h/3W6cA4sfeHZG4
         6hhbhHudZVqv4JSkGMaCW7c+KRAig4b2Ca2Bq0nlzhamDtZLVIw6dyRCIIJVny4cxcwI
         uz7Fe+gR6WlLQexXYPdNTQtPBvecrO6u6mJBuPro+ZGFQg232ge2QbDehugEpCa83kTM
         PNsO3eVxKP61OWf1OOkfIpTtS5i6t9bGN2DnS/2CQbnXQVzds16bjw4h2CZaIRl49tCV
         Z81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571893; x=1793176693;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0DM2se4MDa1QRd53dwq77PpEITS9LrTnNaMogG6Tv3c=;
        b=uvMKoBYithbJB4/eg59Wyli2IRyJD+c0ikBkhtt1FZIKoTDDcDh0dkzmYMAxXJFj57
         eNwitbwGj7qj8fXax+MS2K6SqkpNvzrWli2VrmD2Uh55Q/RwH2VSmA6FoSfq8W0jTecd
         EITuDDZdAwE5JsEzlG+P11ftXG/HSiVnWuOK2Yn8g2kNBimEyKH520a1a+YGnOOWVHVw
         BJY5bEzK/9x+iebZJ4cGq2rPn0R/zqwtQOMydUmfbmccw6VvY8gp1+eHeetuWp/Gft2s
         XIVEqQFnZSYRbyvyQ9iqbwr5ylGWxCYessbMeO8lMuGfaIlQQOraDfUkXFZP7p8qDNfG
         Lg5g==
X-Forwarded-Encrypted: i=1; AKwUvByhl1SuizA156qP3HqAHDjiHdsO0XuN6yz6CBTnmvG3lh4sHuhyqqDYIrparRC1kR/humidD2Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlo9Ttu6gEtxyZj7MtLW662MMqouCexE/eC/9bpNTCzhDVBPty
	bWR5IHMiNKO44aRLZqHm6R7a0A3cNK9DfsMtieyuk4T7nl1dGI5wAxdo
X-Gm-Gg: AYBFou0LRjihieNyes+2ZaYzEcLjE7GAiRvgmZZRgCOsf+klG7+7gBLHH1VmMTB//RY
	ZOwT6QAzM8R8wIiuudPgSQEzKXi2XGFT4ziUiaT9+5w9cR+h9Wd0vRPbk1/K91Z7lJEehAYv33h
	aWbMXg3VeKOZS8Jb4xJKVjQ6bqyLU/6AlsLs6Q+oJSEgBpySrHJ1QX9gGqNOtEDCyM25RZiz6ae
	sFGjSSwvjF6gXY+qDvKjtUliWaWYRn4eCEkdzQTmP1rQVdqVX4ixlvar57Qbgl8L9QPTrfSwnik
	1L0y8N02jIBVfP5fYPbS0qmCou6K0zQNkd0KbM5ShaJqtnQJqGSHgerOMApchdsHnbRU/K2Q/14
	Troj9pXx4Ff8b7U3oaJ0QpCYbDNIQEblJleOU1JA/hvxQylY8aPnfTjB3dQEOvA/ol3Qqx2Y09o
	nas+AK25svx7RrUlOBYX3mAmtx0ef+ghMojFTvmsSldeUaRz/lqYrv4glMgnaYh63MI+c3Ti8cM
	RWksalN9wluzKhWNdrVVZnsRHcQn+/EvCiH0nOHBcB6IKKLiZwEPfTymfbdQKkf4NTy1lq9VTg=
X-Received: by 2002:a05:6a00:348e:b0:89e:2cbb:f1bb with SMTP id d2e1a72fcca58-8a089d420ffmr989116b3a.44.1792571893395;
        Wed, 21 Oct 2026 01:38:13 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0895dbb91sm608179b3a.38.2026.10.21.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:38:12 -0700 (PDT)
Date: Wed, 21 Oct 2026 17:38:08 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: martin.lau@linux.dev, john.fastabend@gmail.com, weiwan@google.com,
	sd@queasysnail.net, jiayuan.chen@linux.dev, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH net] inet: reject unhashed sockets during established lookups
Message-ID: <ath58Egc-oI6p3Jl@v4bel>
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

TCP established ehash lookups are lockless. The socket caches involved
use SLAB_TYPESAFE_BY_RCU, so memory can be reused before an RCU reader
that retained its old address has finished.

After a tuple match, __inet_lookup_established() and
__inet6_lookup_established() acquire a reference and repeat the tuple
check. They do not check whether the new object is hashed. If the
address is reused for a socket with the same tuple, the lookup can
acquire a reference to the new object and return it while its nulls node
is unhashed.

A PoC that drives reuse with a SYN cookie request socket reproduced the
crash. The new request socket is unhashed and has a NULL rsk_listener.
A lookup that had loaded the address of the old request socket acquired
the reference published by tcp_get_cookie_sock() and returned the new
object. tcp_v4_rcv() then read sk_state through the NULL listener.

The resulting crash was:

  BUG: kernel NULL pointer dereference, address: 0000000000000012
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  ...
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 7.3.0-00591-g0e135910deec #1 PREEMPT(lazy)
  ...
  RIP: 0010:tcp_v4_rcv+0x44e/0x1280
  ...
  R10: 0000000000000001 R11: 00000000024ca8c0 R12: 0000000000000000
  ...
  CR2: 0000000000000012 CR3: 0000000103d50004 CR4: 0000000000770ef0
  ...
  Call Trace:
   <IRQ>
   ? raw_local_deliver+0xae/0x240
   ip_protocol_deliver_rcu+0x2d/0x180
   ip_local_deliver_finish+0x84/0x100
   ip_sublist_rcv_finish+0x5f/0x70
   ip_sublist_rcv+0x12a/0x1d0
   ip_list_rcv+0xfd/0x130
   __netif_receive_skb_list_core+0x223/0x250
   netif_receive_skb_list_internal+0x1d2/0x2c0
   ? try_fill_recv+0x39/0x7b0
   napi_complete_done+0x74/0x170
   virtnet_poll+0x445/0x600
   __napi_poll+0x27/0x1e0
   net_rx_action+0x2fe/0x3b0
   handle_softirqs+0xc2/0x2c0
   __irq_exit_rcu+0x74/0xd0
   common_interrupt+0x7f/0x90
   </IRQ>
  ...
  Kernel panic - not syncing: Fatal exception in interrupt

The same stale address pattern also affects full sockets. In an x86
KASAN test with enlarged race windows, a stale lookup allowed an RST to
change a child socket to TCP_CLOSE while it was being initialized and
before ehash insertion. The creation path then inserted the child, and
the server accepted it in TCP_CLOSE. The child was later freed while
still hashed, and a subsequent lookup reported a use-after-free.

Use refcount_inc_not_zero_acquire() when acquiring the reference. After
the reference is acquired, restart the lookup if the nulls node is
unhashed or the tuple no longer matches. This rejects the SYN cookie
request socket and blocks the child socket path observed in the x86
test.

Use release ordering when setting initial nonzero refcounts in the SYN
cookie, TCP Fast Open, request migration, and TIME_WAIT paths. This
makes initialization performed before the refcount update visible to a
reader that acquires a reference. After a nonzero request refcount has
been published, release it with reqsk_put() on failure instead of
freeing the request directly.

Fixes: 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use RCU / hlist_nulls")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 14 ++++++++------
 net/ipv4/inet_hashtables.c      |  7 ++++---
 net/ipv4/inet_timewait_sock.c   |  2 +-
 net/ipv4/syncookies.c           |  4 +++-
 net/ipv4/tcp_fastopen.c         |  3 +--
 net/ipv4/tcp_input.c            |  3 ++-
 net/ipv6/inet6_hashtables.c     |  5 +++--
 7 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 6a30f11384547e..25b46beed63541 100644
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
@@ -1136,10 +1136,12 @@ static void reqsk_timer_handler(struct timer_list *t)
 	 */
 	if (nreq) {
 		__NET_INC_STATS(net, LINUX_MIB_TCPMIGRATEREQFAILURE);
+		reqsk_put(nreq);
 no_ownership:
 		reqsk_migrate_reset(nreq);
 		reqsk_queue_removed(queue, nreq);
-		__reqsk_free(nreq);
+		reqsk_put(nreq);
+		reqsk_put(nreq);
 	}
 
 drop:
@@ -1437,7 +1439,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 				goto child_put;
 			}
 
-			refcount_set(&nreq->rsk_refcnt, 1);
+			refcount_set_release(&nreq->rsk_refcnt, 1);
 			if (inet_csk_reqsk_queue_add(sk, nreq, child)) {
 				__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQSUCCESS);
 				reqsk_migrate_reset(req);
@@ -1447,7 +1449,7 @@ struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock *child,
 
 			__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPMIGRATEREQFAILURE);
 			reqsk_migrate_reset(nreq);
-			__reqsk_free(nreq);
+			reqsk_put(nreq);
 		} else if (inet_csk_reqsk_queue_add(sk, req, child)) {
 			return child;
 		}
@@ -1490,7 +1492,7 @@ void inet_csk_listen_stop(struct sock *sk)
 		if (nsk) {
 			nreq = inet_reqsk_clone(req, nsk);
 			if (nreq) {
-				refcount_set(&nreq->rsk_refcnt, 1);
+				refcount_set_release(&nreq->rsk_refcnt, 1);
 
 				rcu_read_lock();
 				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
@@ -1502,7 +1504,7 @@ void inet_csk_listen_stop(struct sock *sk)
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
 					reqsk_migrate_reset(nreq);
-					__reqsk_free(nreq);
+					reqsk_put(nreq);
 				}
 				rcu_read_unlock();
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index ba0faa9ae2bb3a..7ffa9171d6de10 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -550,10 +550,11 @@ struct sock *__inet_lookup_established(const struct net *net,
 		if (sk->sk_hash != hash)
 			continue;
 		if (likely(inet_match(net, sk, acookie, ports, dif, sdif))) {
-			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 				goto out;
-			if (unlikely(!inet_match(net, sk, acookie,
-						 ports, dif, sdif))) {
+			if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+				     !inet_match(net, sk, acookie, ports, dif,
+						 sdif))) {
 				sock_gen_put(sk);
 				goto begin;
 			}
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index d4c781a0667fe5..88ea3a101849aa 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -141,7 +141,7 @@ void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
 	 * Also note that after this point, we lost our implicit reference
 	 * so we are not allowed to use tw anymore.
 	 */
-	refcount_set(&tw->tw_refcnt, 3);
+	refcount_set_release(&tw->tw_refcnt, 3);
 
 	/* Ensure tw_refcnt has been set before tw is published.
 	 * smp_wmb() provides the necessary memory barrier to enforce this
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 73e12976818473..4b2d2713653b75 100644
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
@@ -218,6 +218,8 @@ struct sock *tcp_get_cookie_sock(struct sock *sk, struct sk_buff *skb,
 
 		bh_unlock_sock(child);
 		sock_put(child);
+		reqsk_put(req);
+		return NULL;
 	}
 	__reqsk_free(req);
 
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 471c78be55137a..2506f415f410bb 100644
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
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 99baf14afdfd8f..131aa475e35f69 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7777,7 +7777,8 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		if (!inet_csk_reqsk_queue_add(sk, req, fastopen_sk)) {
 			bh_unlock_sock(fastopen_sk);
 			sock_put(fastopen_sk);
-			goto drop_and_free;
+			reqsk_put(req);
+			goto drop;
 		}
 		READ_ONCE(sk->sk_data_ready)(sk);
 		bh_unlock_sock(fastopen_sk);
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b111b51d69fc9b..7468aca5c1f1ee 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -105,10 +105,11 @@ struct sock *__inet6_lookup_established(const struct net *net,
 			continue;
 		if (!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))
 			continue;
-		if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+		if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 			goto out;
 
-		if (unlikely(!inet6_match(net, sk, saddr, daddr, ports, dif, sdif))) {
+		if (unlikely(hlist_nulls_unhashed_lockless(&sk->sk_nulls_node) ||
+			     !inet6_match(net, sk, saddr, daddr, ports, dif, sdif))) {
 			sock_gen_put(sk);
 			goto begin;
 		}
-- 
2.43.0

