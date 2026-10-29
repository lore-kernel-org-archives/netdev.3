Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310180;
	b=izEkoXdzoIf7dkHVLVvVLIbiwWK5Vy7eOcqBNqfzhgJwPzkbrcJ0cDD14U03jD3Pnh6w
	 0Y2aP/CWEd+LsMCRlb0d1y/tQ9qs/KA/DNJC/kqNyFt5Kx6uKAcf0NuFHfmPqwv4zKvZ2
	 ILdDgwZ2kluRR+lSnseTZY4ilv2EWufcJ8urrJNGbMOBfHeWI+Ur8R5ljOi8IPukcSSCQ
	 kkjNdvYThoMA464fsBjSbqniaA8hkBhaR5i6GGqbbcZCeYR1tC2d1W8NOmjrRTb64uGG7
	 z28uFSZVvDJPEHv1n0IOMu7dllLSGoAJuvA7gPoh4xTa4qEvd1GYy/ZYFd4SkUd9llw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310180;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=E6EtwfrF7WPf7c2zBhkwy9HXJAUGpyAEaJ4Q/kLCoRg=;
	b=NhuB5DUVfaRerqiEuu0IagQk7WusE7NDWWTzUqDgCKJJ0NYCsTBJsO/wX9gF6+RqMy27
	 wkKHte2vGlm1UstZFgJY4ge9yi+OFpXrvy3qKva90InOGXRjNVVztqYPFBrk/eYHo0QxC
	 OKFZm0WoDsSt2DaPXBWzC83bNIGLtCg9pBkS6d6bOkVXCe4QfanIGDsgb9Gax5m2ZKnX1
	 Ak8dk0C9RZT6OMHT/ylOeUx1mNI9aTf8Mokns3YhBzXs5LK7YhYtb/lsOMKGOgs5E4YHR
	 Vb780YvSBeUR6syQbOF4OUVKtjyU0dgK+VuJGZMigIY7NInZ7hCVU7L1t7fcRZGYYWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxbCHa8t;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018DE606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 018DE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oxbCHa8t
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so25036a91.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793310178; x=1793914978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E6EtwfrF7WPf7c2zBhkwy9HXJAUGpyAEaJ4Q/kLCoRg=;
        b=oxbCHa8tm2WpZ3cj3oUo3qMc094q8NzJ2+EYNIppKXLJ8AJiOb6sNGH3vTgIyewLVF
         3T2IHbPGKxMM5NB9jyiIIwS1k7VebgqbZ4TsAIURS/CUCZtzH6wIjRiqoBLqQvp+vEZc
         CklUCY6xafR3kAmrPsOKelKCNCfuh058D0fScon4ewmIgO1LnH+NriFEf7oqbpNWPC9Q
         Lr3uampz68Lw6N8CNjut9suYV6WpVVY/uKJcwvwIDZ/l0mK0ECSasyGpb0vzKpdxLdE6
         5CkaqMwBmdgcy09fKiUvb71e9yfILWSUSoHp6tTjijOCsw1rY36042M4G9gm2fs//tt4
         pGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310178; x=1793914978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=E6EtwfrF7WPf7c2zBhkwy9HXJAUGpyAEaJ4Q/kLCoRg=;
        b=jX3LokL0beQ+H2kRBi9+Dv4VTdV/pIP0mVn8W5qhhe1Qgu+ABBvpvWpX2QhKg/6Tmw
         EMNFOLdWyTzn1FC/UokzasBNtWMn38m7CClfjniLmtaFfXaaRSkUZmcnSZ1QhbuMJiai
         nIXb45b/J3VBiWPrpOfsXBeM586lW9sd/eCRcPawzVtd4NvpX3IlLJwubIZLEbD2K3sR
         BOrhQWn5AP4eerYlPD+u6DHBnb/3keAm61EaeKQv/oBBC/FfD8gnyM5tDfvZ83wcLTKu
         26hEpUsNdV8aI+2MnRqEaTyzok++CFQy9B5Q7uBB7YqyisiwufhKY/zt2PNS5P2MBcWm
         sI4g==
X-Forwarded-Encrypted: i=1; AKwUvBxTzMzckiVjlo8pcJ1zrluKmqcc1etHtE8fP0FuAv30aG61SayHdJTLZlV2zopl9oBg6+ofoT4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzz4ml7xO0AzfdfKtjHvqf/HRPpMveA8WXlpCTwR+IeOjgz8Fk
	tktO4UF0c91uSMEUJb0iL+YLTQ0Ju/yVA638rncvPfZfsFW9dFMqRggo
X-Gm-Gg: AYBFou2RbbZkJrhWhvl/3m5DagAUNSiFSP7M7TrvN0Nhhqo3FY9WUnN+DQp80Adcz7q
	QBBVfEteUxD51Xe9cKGMnck52ojxelP/aKqLck2tUfUMrK8+isHgxsOKZTVnW2ecjqLUiV9bsV5
	yYiFTlToDchU3Rv57LDhpc+Yag9NLQi1BbR9TNyTNOfKYJNvucMfE1WHLkhIF3B7FGM6PgtARo8
	mSjMoyazLMo2DCTpuFDz83okQ75BDVH2eTGyUS+V6HjX6eHBGfD6vZFegRXqKuKDpjer/XGcVw3
	VLptgBvPryC4JUvmr+edc1BZoWwGrxCCaEbtR00zmmd4d8UmMtvt+OoBsCfyuBE53KhRHecpfHm
	+LPDzFSMB63cqOlEkleugSV/bidnKmY372n5QCTMregACGZGs/Axh6gbEYDYvJwJzr3H8EcVX0k
	5Nu+vLQt1FE1KfDp+grOu5bHQQc58ppIojcIEABbjGkGJtOqQCzsNm3h1v2fARmgQugIZbr9q8T
	rNGVbN4tCgkktwRJKDsqhnPtFyRaSmUQYqi8xIKqf+KVelwJA+DS5d19VVr2brQNRaXM8UWvVJF
	3EPMyvSnCxmfsAxhYiKZsauN4m+Lg/NyP+EHU4wEoROe2mMf33JpPPzaQ/xUamfl/aKzKdq5
X-Received: by 2002:a17:90b:570c:b0:3ac:8897:7ba9 with SMTP id 98e67ed59e1d1-3ae8985d52dmr201068a91.56.1793310178224;
        Thu, 29 Oct 2026 14:42:58 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ecaf5sm1122486a91.16.2026.10.29.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:42:56 -0700 (PDT)
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
Subject: [PATCH net v5 2/2] net: restore refcount ordering for lockless socket access
Date: Fri, 30 Oct 2026 06:42:17 +0900
Message-ID: <20261029214219.1035176-3-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029214219.1035176-1-imv4bel@gmail.com>
References: <20261029214219.1035176-1-imv4bel@gmail.com>
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
accesses after a successful reference acquisition to be reordered before
it.

Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
lookups and in inet_twsk_purge(), where the socket is validated again
after taking a reference.

bpf_sk_assign() can receive a socket pointer obtained through BTF
without a reference. Use acquire ordering when it takes its own reference
for a refcounted socket.

Use refcount_set_release() when setting refcounts in the SYN cookie,
TCP Fast Open, request migration, and TIME_WAIT paths. Keep the existing
TIME_WAIT smp_wmb(), which separately orders the refcount store before
ehash publication.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Fixes: 27e5203bd9c5 ("bpf: Change bpf_sk_assign to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/core/filter.c               | 2 +-
 net/ipv4/inet_connection_sock.c | 6 +++---
 net/ipv4/inet_hashtables.c      | 2 +-
 net/ipv4/inet_timewait_sock.c   | 4 ++--
 net/ipv4/syncookies.c           | 2 +-
 net/ipv4/tcp_fastopen.c         | 2 +-
 net/ipv6/inet6_hashtables.c     | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc621672f2e..6d87194c377df 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7989,7 +7989,7 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 	if (sk_unhashed(sk))
 		return -EOPNOTSUPP;
 	if (sk_is_refcounted(sk) &&
-	    unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
+	    unlikely(!refcount_inc_not_zero_acquire(&sk->sk_refcnt)))
 		return -ENOENT;
 
 	skb_orphan(skb);
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

