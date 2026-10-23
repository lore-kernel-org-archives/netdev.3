Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733195;
	b=HxaUsTD3FfGefbX6h78Yi/J0MtBfkNy5bQ4kklJ+UAkuBh7BY0EKaWGawfDtaAJ73bS+
	 hmoYLvYIvqlLIqe0V9o9mp2btIrPgnUb56VfkWa6fNRmBsQU4TFSVe8ZsjQFgpWmOd+fS
	 OxRcSjXefwkt0ddnf06MCH0Shu6dP8UI/Vu58/0jWgGMLB1KT8dvt4c/QgzjST4HxPY+c
	 50KQle8u2IIu0D92ElV2pk1D7SMX4nbX5fu/HeP9ol7i9J5JUhaX9DTRO0qkTQsE0WWIT
	 7Hc/zHJsERdvbn8ryyOO4BYrnemRhlQFVGnJEkYuHaAm2w/PZpdTdJU/QhX4/xO2igQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KzFYL3klIlj4MNWL8WRGDKXEZF/xciuhk4WNa1f3tW0=;
	b=uF69+bxKSM9aUPYcgNlzogPZd7iQ6a3EMkVHQ6SL3h6C0EN/bfIogII8Decvh6Fl2DHK
	 Z1U5XtAFQ9VBE/NU+VOpNKpNJQvuOsYrbmbS/LC0tUswJ/F4I9txX4EjRh3FSAx5+tcEY
	 uGY957kionlcrLvpdbLbFYRJ97Rchd1jEWRwLc+z0xWk9FmDVIoGcu2z14Slso4Zc5Pml
	 CF2mWCsejZL7/JiNJ18e2fLuOjOf+5+aiAhWFvWYSIj2Om37TO4nwNhrbEHsBkMw5dShW
	 R6cld9ct7bNvtEuiDhilJ+2xT9eLpL10X/zXhK8zqOseF4OybxJkUuAJHi7RGW2XYqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DPjvn2iy;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BB606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A1BB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DPjvn2iy
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so195310a12.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792733195; x=1793337995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KzFYL3klIlj4MNWL8WRGDKXEZF/xciuhk4WNa1f3tW0=;
        b=DPjvn2iyVa3XZ4L1pytqdB2xVt5b8e27SKhYb+A6yhsFkpNE8rzS/cXYr6rMMcO1vm
         hkzdKZkJBdJtZoSNldV1+GGxApQCD5BrTVxDJRnR2TSAVrXOL966UDTqmp+c7aWE0M+a
         P5/fqHxokgCh4Ba8+ckruOb7I1+++BSJKKUPL11orv+lMKXwU3nd50Bu7SfWW9TlBKSa
         GCsr8OEkgYDjPPuukUv9cwtzmUmM7QRv4vLRvH0V/VO1Wxk+3rpci3wixaVjb9Q0IecM
         7zspmjH3hISgRlpGODODXlQ2phCvddlJH9ChxxYGBR6Qa78fqNz3C8ktFy6JMp/aJ24a
         1AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792733195; x=1793337995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KzFYL3klIlj4MNWL8WRGDKXEZF/xciuhk4WNa1f3tW0=;
        b=th42qEc1uJ2ha+lVMtsCweSbuOOA7Ihr47ZpsMzB1qwb6haNaKjCRlOXoOJIircLPU
         u82Drm4keZBzE89rvwHax1DMs2g4LADH34sm+x03TwoeXNdZLN8hBrSdRss/cuaXYVoW
         +NOO4beCxh1ZXMWtT/4zd77eWBjTD8RpMIuj4xYEo5liUd3aCZB7k21giTdSzIf1rdF9
         vvMNV20vHPHkOrkmC6+yHwhmtdoNnDqZtEfvuPJNsBTDX+bNEbvV11K9sKBOAA4QhD1X
         NEO6RUH/wXs3AiucTH95mYF/50Y07VMvVhD8ZpqAsVmW2SjtD+f293zZ2vy0q6eHtkSR
         2wsw==
X-Forwarded-Encrypted: i=1; AKwUvBwzpqt/Bc8xbt1MDnQ7yInr0BrZMnTXEqFR11LI8iKsnlhHXBegGwEBXBDujUiRPTSL4HFtyck=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5taVDxlZlnPkd3QA8UrPwk4H18LZnuzxxzZegR94o4JgvBURk
	7CdnqU1538HPCd0p+SwmjOlj3AROBbG08+TmMwHgSDGpNyjyWmm0Z1im
X-Gm-Gg: AYBFou1yLeOu1rQfafts0yFav9ufXgn3mnFbXUM8LfLXoc/82CKVaL7ibr969S6hFmz
	X1mLDS6ftIQa3l+4Jwgto3wk+lihMyUy+z4q8DX3UgWjeOmsCAgAg1aA6i8fV6cp2o6fSoeUHXo
	PoejiXsyfr1+UkQr1e7ZZbwbQ3I2sJ5Rx81SjB/0WUnpmu3M7OZj7QmyS5s8IFeg45rN1BLUhpF
	uD360DDqCdO7+BbRdfcPgap3B/xrceBZK6QshkxYSYHFlU6b8XUNXXfGvbz9wwpViqnbOoIc1Rd
	4bdEUGdekmzOUF1MQfK+8SMAM5v52tuImxVUXRHiz3q7FhkvraMhh9h0R86T6kbPk2lPVmi2zNB
	2MvsIFiIf4QsY/VVWcw1OSdim2zBa/+XYU+hMTUYXSulu9jdCzU8qLMZtfSSMjm9d2zmyTkRQax
	txcDXSjl1qDy4rp0c/kJcF/QPU7PPl1mg4uF2KML5h36KvXjOnj3fm/lE0O96SSBP02/07XGvJ0
	L8IXzjUHonZ/mHQ2+xoyGZUjp7c+PmsM1mX9I/R6IaxKOSUcdwhIpcL2QU4GigPCw7YdAB8nMan
	Hg==
X-Received: by 2002:a17:90b:1c83:b0:3ab:330d:6e47 with SMTP id 98e67ed59e1d1-3adce600214mr622360a91.10.1792733194643;
        Thu, 22 Oct 2026 22:26:34 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4890c56sm7379785a91.2.2026.10.22.22.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:26:33 -0700 (PDT)
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
Subject: [PATCH net v2 2/2] inet: restore refcount ordering for established lookups
Date: Fri, 23 Oct 2026 14:24:36 +0900
Message-ID: <20261023052542.3505250-3-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023052542.3505250-1-imv4bel@gmail.com>
References: <20261023052542.3505250-1-imv4bel@gmail.com>
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

When commit 3ab5aee7fe84 ("net: Convert TCP & DCCP hash tables to use
RCU / hlist_nulls") was written, atomic_inc_not_zero() provided full
memory ordering. Even after commit 41c6d650f653 ("net: convert
sock.sk_refcnt from atomic_t to refcount_t"), default builds used
atomic_add_unless() and retained that ordering.

Commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations
of refcount_t") consolidated the refcount_t implementations in v5.5.
On weakly ordered architectures, this removed the ordering required
by validation after a successful reference acquisition.

Use refcount_inc_not_zero_acquire() in the IPv4 and IPv6 established
lookups. Use refcount_set_release() when setting initial refcounts in
sk_clone(), SYN cookie, and request migration paths. In the TCP Fast
Open path, move the refcount update after the required initialization
and use release ordering.

The TIME_WAIT path already has an smp_wmb() between refcount_set() and
hash publication, so leave it unchanged.

Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/core/sock.c                 | 3 +--
 net/ipv4/inet_connection_sock.c | 6 +++---
 net/ipv4/inet_hashtables.c      | 2 +-
 net/ipv4/syncookies.c           | 2 +-
 net/ipv4/tcp_fastopen.c         | 3 +--
 net/ipv6/inet6_hashtables.c     | 2 +-
 6 files changed, 8 insertions(+), 10 deletions(-)

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
-- 
2.43.0

