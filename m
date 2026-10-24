Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820276;
	b=jI6XklacLvRxbv3cQVW2CbOqoqoSCANz7Ha9qUjgvd/vywR7/cov/TlabLjcrfoPjsJS
	 ywFqWaZS9vMmOh1dd896NNzuxC6yjWMQ597CEv6uijivqrgnqQYt+p+h9ki6JGcQYQufQ
	 7KuA5Hs0EnH08/F2+I6IjA0vxvzwZxaYUUewEg88FRs00x3RFrJY6c4VnixLMWr7irROD
	 Aj+Aj3xSC8pYT4D7WBCV644WpLFRFrqI/iJoFUJxLfIvPQc/qJjzsx2AWBoabN8U59cwJ
	 IDIrXSuZYwi72v4ZKs5EMnocehuWdrlgh7a3su4P4auHFN1r/wElKBkyT/OSnZ/ps6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=u1kTAV7kZo1f8uJ6uI/HfVvkXNhvmCW79ofPzPlPbAo=;
	b=zS007WcEuQ3bF13pXUlSt0EBvBCB56fwEk/vy8OkqRsQJQexhpQ8abOXh62Ug93sSICj
	 HZdL+dzpGJ4PkMpYolht78zpLfHmAHWUKV3k/pmBiwkm1TGjEKz/pVps+4TqMYAhiUYe/
	 LHRVUkThkWvv7Ie61b4yNUEu763zwYOhyCWfR4smIy83brJkgbiVWUQB/egMus9fnhB+m
	 fUGnxy33Li0+m/E54k86GuMGOvxjTvzfPLqgemXbzP6FZgcLDaOwcDJuLrej6Pw/PZWvf
	 7oAaU8PHsVEnOieQx5BbmK6rCXGPWjduVPc33i5R7bl494hkXhzqmyC+wllfr+HaJog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h1a+XbhN;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08F606A321
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 05:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C08F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h1a+XbhN
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9995ce866so13037635ad.0
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820275; x=1793425075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u1kTAV7kZo1f8uJ6uI/HfVvkXNhvmCW79ofPzPlPbAo=;
        b=h1a+XbhNiXuyFkU+0t2jFqYMiNtEXXQFk5rvbir0hcCw8wNQwmpDF2fagg8+MO2Ks7
         coevx42zyrC6qgu3d0gUcyhBvhLOCrfk7Uw2gTjcxTDRORo0QTnkggrw9N2ov70fCead
         PUNjDRCC+v0Ehdd3P6adiFOrhqpvWayQWbBhA9phXu/FJCUEfm87bIdFrO4PWFjU9zVS
         2GVF8DKavMhy+/zr+W1V8lk+1vCt21osfUUTmWLAoNG6QcqRDTaVqRjupurhuTt7nrMb
         VQRvFkdxpB8GppY8BO2IQ7VGFKvCrjpimzKGisBKSZt0/kPHAcp8enhgowlo4V+2bs+q
         GM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820275; x=1793425075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u1kTAV7kZo1f8uJ6uI/HfVvkXNhvmCW79ofPzPlPbAo=;
        b=c/pJ1E2GNtbZW/WbDSipYdExEyZ0Gj079xiu7jFm3kxw05AuSWdUAmEqoIthgZIuwO
         F/HDN8k13nJlWnIqydbSXMEwABJGqEgt2yWW9PyL7vQDSTpWnB+wJcvsQOHgYT6dfI6+
         krsHxyYlSC+paWC93pklgEfxyKsizrUM1azrxQrhmM4z41RMRLqOUp0ENOY1+NEQaYgx
         2hOI1wGVfXSUfmAzrOh75GuWQ/az/LT59JgBhNk4aB+tOH9r1utBQz9KnD7p70m6KiRJ
         055L218NPot67hNPPOMoaTMIxpQdKWdJfJ0l4zxcVf8uaKePHvoBMqNeXcaaBFrQKvhS
         grIQ==
X-Forwarded-Encrypted: i=1; AKwUvBylyzeatms1v8qcnFhZcwmwdUI3v9Glp+W2BAXlMCmHS6/LihfJxGdiqxVqohGFUT9TfJycL6g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3Jfnmw0k/sRKtZh900vDMV1+HtFTBPv17/qPkuPUtDnHq+eJH
	Qix2YHZ7Y5HBZeYCe8lK2rRiGpg0WHJUU5qYwPWUVwXuETD3PdUmxiIg
X-Gm-Gg: AYBFou0djoiqJetldKt2DOQSyk0iLUAPyQTxQ2pkYpTEuUAiDrM9/K8qk4UONeFk8Py
	8txYb2OrxBa9n7VchPh3uvyg2XqnQBod3S0/ffIKSnpFPfgtnozHYsBkyMrwpT58ny75/rlphKY
	Wx0jYocPZ7/U67qIrkB7RSlyBZGIvSd6A1jGcQI7K5BmhFOaLBzT5Nd0dkkkcYZLQBiZxFgOcsa
	DkRpJmUNzJiOkEBwIoHRCVnn8A2DeVNH2dUceh6o937MVh4X6qQ3aOrQGMneOQ9wVjSghl5UKeb
	QXS7Ackwy4RFwZhd4a64DNt+PoiJv84GgnyEpLsvTsvcuWWo06oHNHZdW25P8DKHVwWdtLss3Jr
	2hXJSVTdlq92BqYAIXmvEHzscw8+BidyXq+ZkB4Xy/unD7u/Y96Z2VvJEyONEeT2SlWawmRBh9P
	fLvwbNYiccDLWnVVEeHD7OE/gGplYM0A/1IZ/QHN/9zMV5MheSh7cououzQQE/cB5Hv8eBi24VP
	o8C650gQLlHO1ic6WD88XXUYkCWgi+H5HhT6KE4KWTvABlFnPcy4p78pRF2rDW6a+tgoHGjz0Us
	Zg==
X-Received: by 2002:a17:903:1a0d:b0:2e9:4f73:83d1 with SMTP id d9443c01a7336-2ea9c674e67mr10386525ad.22.1792820274840;
        Fri, 23 Oct 2026 22:37:54 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a2676sm2692485ad.50.2026.10.23.22.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:37:53 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] inet: restore refcount ordering for established lookups
Date: Sat, 24 Oct 2026 14:37:13 +0900
Message-ID: <20261024053720.1147022-3-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024053720.1147022-1-imv4bel@gmail.com>
References: <20261024053720.1147022-1-imv4bel@gmail.com>
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
validation in established lookups to be reordered before a successful
reference acquisition.

Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
lookups. Use refcount_set_release() when setting refcounts in the SYN
cookie, TCP Fast Open, request migration, and TIME_WAIT paths. Keep the
existing TIME_WAIT smp_wmb(), which separately orders the refcount store
before ehash publication.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 6 +++---
 net/ipv4/inet_hashtables.c      | 2 +-
 net/ipv4/inet_timewait_sock.c   | 2 +-
 net/ipv4/syncookies.c           | 2 +-
 net/ipv4/tcp_fastopen.c         | 2 +-
 net/ipv6/inet6_hashtables.c     | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

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
index d4c781a0667fe..88ea3a101849a 100644
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

