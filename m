Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975125;
	b=X5t4p5+eFl55MKifdYPJExJHM50jKc4dPInq+91jF1kmmGjkvf4kDV2faNdk3e/IVqjc
	 ssxqa5KVWvgp7NBx+PTCfgKm/Yjve3v5B1t26flb8b+A+VxxyUJfqErYSW82vMJQo7m10
	 woYdJcRHD8NPVMD4CkQbSgtTUo0B/eUjtJdi5AvCM4LFrQ5xGBLdqA1avHPuJXPVhaavx
	 xdEJ4PCzYIkIoSxou/lQUSZCo6xshJeLlUsSMDn0wHNb5GOvLUNhl5OpcecqM8I3+EXpk
	 +2uIo+OwQTugwdbnxXBMKwj/dU/maAKymtHVJAZLp2QdR1SBQlca9r415gy9RlTwOzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IVUYgHeIBWVpXUeqXYcWVjDk2UZb78txWIi5FVEjbpo=;
	b=ZGjAauNtXVuiUahHuYDf36274c2BmaguDFp6SjlmYVBPGn1lOVkFRxKXzLOPsWN655KI
	 92t1LTyFWv10mQP5Izj2J7HUzK1Lf8NxU2I26LbsxTYabKBXlPOkSOFHUasTzfRE5b2Xm
	 tmiODufyudzAJuxcPLzNwwzBNKSt40sCiPCoh/RbYlh081R3mViPNj50zktSjYLFqUa6X
	 Y2zMYS+qcvhCx93vUEKIjbEH6+rlPn1FO0Oek2Jkkx1Rcx/wrmN2L+waI8hgUFBQk4AdR
	 nv2Mh+32dlduqGSzZhk9BLkHqxa+zVADhegzM72g5y8i5Pm3iSUFNiqlXCb0tGUMoGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mBJzcGIq;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2D4606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 00:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B2D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mBJzcGIq
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35f1f76ea84so4181375eec.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 17:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792975124; x=1793579924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVUYgHeIBWVpXUeqXYcWVjDk2UZb78txWIi5FVEjbpo=;
        b=mBJzcGIqxIYH7QzlQLHBPKrjskMhg+OhTFX9zvLAM3kBiXLSDw/27dgrphc/drt8au
         cVM4oyjapVYUYaDxvTZ86RB+UsuLKK+u8IOdBXf/5PSC30o500nC1BMGUcH2W406uson
         fNqpu+yQroZejB1JBvd72DyGoVgZmFL6bjwM271RWZfylEC3bcl4OJuyg3KEYh8Hv4dd
         fEnKodbqiaIsHzKtaMHxk+a/44/0mmV5GstfVdaE1dcacIED6eyW4pfM48ryOC1Gobae
         enMW1VwOZceqI4WLpH7jOJRAmN/GecI05/eApep8joQlH3RwpfwhhOTwfS8a9QMr47xt
         TYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792975124; x=1793579924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IVUYgHeIBWVpXUeqXYcWVjDk2UZb78txWIi5FVEjbpo=;
        b=jxh5l+bUa+NiD0uSAKsy1rAKhy9T0Np+xXGqAAvXv+EK0MmnVss4DCvbJzxuG0Ed2O
         60WENTI8xnGrLHIvUwJQHWLprEHcuYkrpMI/rm3qOQuYhQ/FwuGj0qNIlmiUOuYP3ruY
         Gh/1O0IqCPnO9653bf7UaHDmc41wWTS9VWlK4NZDFD3PxTjllzicXnt4nK9CYkdy2bOJ
         NlBfSm7d+zSGXZ+Tn8wrFOFuedObQ3+gqCr9OOkzb351TlWd7pFHW7Ca+x6Nn4AxMJ6S
         1loRdM9ysI2Tu4wzMCVt59VBURtnjUK3a6lvvITBldm4f3y+Wq4zJtzFhIyXPrYBS7Cq
         NFkA==
X-Forwarded-Encrypted: i=1; AKwUvBypguEDiT65+bOhuTqhH3Oj7Uv0egpyRb1fETf1JGGWnXWhtIEeaJWRBw7x5oW6tFX+8W2cLLg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxbR7D5ZIBotwoOiVcbd85PM/GiH8aCJkXckIe+e1j0r7E5NLV
	G845OQzgm/rCk1COpTkauavvNrfVady8WoxIW9gkMCAzxDUbQZJ1zDTp
X-Gm-Gg: AYBFou1atE+ptu8otPgFDtf/Zs9WPOEg7zcJ/NJW0LUUqUfrf0vSxXKwXpC58BlEMA4
	qh1v430My8Z0BUranrFuvdAjlYp0Zg6XJdsiZeZzX6WSQJfl2IUPqHTXYUa7h8xsPEm2HWH1cmA
	cr7CEjvuvt+Q9cM7k+L619j2AVze8Cfo1YFpa3kLavdQicHgHS3b/KcjW2kwYW/SMDhpEcEjIsy
	UJEt07NJR1Ab/oHlksdKkmkiRvvTpbvdAYe8ITs5awiebvCBB3nzVQ3Hj+uVDENcEwA3RZn6Dl4
	IiOZI/JwDexxIFL0P9jq0VoumezZLJddxABVQTnhc8UgxHWb1VnoOHbLAEDPKJJ8PxZzdhJIlFv
	qEqfSt3c1ERa+Mx+/gGx0jbx196R55XTGYeuSKXaWu7rKfv6ZJC/LeiTP2widgaKsNYGpwTC2ge
	4CTYe91ExaClMpI38NzCz9Sv65fGZmwZP7pmhO+NundF2mCYLXtEoWy9QEsun3HDygLf+pSARvD
	4ZgrOOlccsoBN8NWKUkOUOykCv+sRxqn8ONJoAnBQJMLTsipZsOn0LLjQulZPPN+KXavb0mnp1L
	yA==
X-Received: by 2002:a05:693c:8099:b0:360:ca2f:ce6f with SMTP id 5a478bee46e88-369ffdddf39mr2418635eec.1.1792975124383;
        Sun, 25 Oct 2026 17:38:44 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm37925013eec.23.2026.10.25.17.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 17:38:43 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	weiwan@google.com,
	sd@queasysnail.net,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 2/2] inet: restore refcount ordering for lockless ehash walks
Date: Mon, 26 Oct 2026 09:37:45 +0900
Message-ID: <20261026003804.61923-3-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026003804.61923-1-imv4bel@gmail.com>
References: <20261026003804.61923-1-imv4bel@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
of refcount_t"), default builds implemented refcount_inc_not_zero() using
atomic_add_unless(), which provided full memory ordering on success. The
commit removed that ordering on weakly ordered architectures, allowing
validation after a successful reference acquisition in lockless ehash
walks to be reordered before it.

Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
lookups and in inet_twsk_purge(), where the network namespace is validated
again after taking a reference. Use refcount_set_release() when setting
refcounts in the SYN cookie, TCP Fast Open, request migration, and
TIME_WAIT paths. Keep the existing TIME_WAIT smp_wmb(), which separately
orders the refcount store before ehash publication.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 6 +++---
 net/ipv4/inet_hashtables.c      | 2 +-
 net/ipv4/inet_timewait_sock.c   | 4 ++--
 net/ipv4/syncookies.c           | 2 +-
 net/ipv4/tcp_fastopen.c         | 2 +-
 net/ipv6/inet6_hashtables.c     | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index bd0bad96c93c3..837cb91e5b173 100644
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
index 58d54965036a2..7ffa9171d6de1 100644
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
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index d4c781a0667fe..74ff40d42e56b 100644
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
@@ -328,7 +328,7 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo)
 			if (check_net(sock_net(sk)))
 				continue;
 
-			if (unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+			if (unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 				continue;
 
 			if (check_net(sock_net(sk))) {
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 6440305615378..4b2d2713653b7 100644
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
index 471c78be55137..e40477b6b5549 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -364,7 +364,7 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	tcp_reset_xmit_timer(child, ICSK_TIME_RETRANS,
 			     req->timeout, false);
 
-	refcount_set(&req->rsk_refcnt, 2);
+	refcount_set_release(&req->rsk_refcnt, 2);
 
 	sk_mark_napi_id_set(child, skb);
 
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index aa5fa1dd062f7..1eea584d80df8 100644
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
-- 
2.43.0

