Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56629390999
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923895; cv=none; b=M1cLRAuy7WpQnHzYgo2UINEJnuosbQSeo2TAQjp1WKBwiwOk8tsRKR+5yqmp7MJqOiY5qdh+UAbyymxWWtfVvv31HfONRpV+fjhQ4E7OnPfvy61oaW/J00V71ZUTYS6bJe9gFX3OHUQmdeeXUYziIWPjHjw3U/TF5KaL1SweOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923895; c=relaxed/simple;
	bh=QQ8Iwbigz+MYW4rbdetp5OUMgTuA3Fsc1NNxHb5Tv3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEzQS3RCDnWQL7tHFayIM4ZDwaTIQ9+vNu9mE8D5kbhHTneqOpSCh7izUBntgXagsQnAwpaudjfZkUXDpXOX0Yn2AGDziAzAsm5zEsWna1x15J5vMLKTH8+4ZXh7p4kRMXxohBwqFdzR3yXGx8WfxxOmlnhAMwld4yxGul0Swgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=RTUB9Xkk; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="RTUB9Xkk"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so1054311a12.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789923893; x=1790528693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ooN/l2U+FeOt8DxZ8W5zCyE1PHfXRQVvAAv1VNAL5uc=;
        b=RTUB9Xkkn/AQDckEUwEvxuKlswLnF7bOfvu4eWnWxUpi8Zi1tJ1WjPJ1MjR/Z5mnIC
         Y9C7lnfa7xiafekTQgi7En+EiZ6OezCOV1xA6az+hdDJ+8+mdTqtIn76xdysuTFKH/nM
         8GnxX6VX2OvyX4lme9vnLinN/CElvf2OdJNRjphczHih9uW3nULhYCwOSx00j5L7VN2c
         sKbhQqz4BUr2PrcRIp67/RCv1FvfA+tZS9wW3r/vNiVS6j5WC0Y0TuskkECAsabM7bAI
         Adyozypa9ozjulNm7FMbON4HdsJWWUeMQGegrjOpY3cZWHaMmHtVxYY+CRLUw8CkMMTw
         dIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923893; x=1790528693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ooN/l2U+FeOt8DxZ8W5zCyE1PHfXRQVvAAv1VNAL5uc=;
        b=EikcKxAJREKguhI0FQACSwh9BwVeXn05zxEdwwfKQN4H/3c0BPzcpHKsFDWjLOdR6H
         KENjjYld3K2rL1mLBk5CQRXFLRjtkhRJso1qOmZf/DeirgxPc0Na8Y4hp/Gmf0oPqlR5
         y9eQyiVnxvgzZqsJCKMXlBRFdkpW9fVASvc2TAmDgN07LnPjxqoEtONnkWA7GrjqRT7D
         efVQ0OO7QtgntewBYK/7OMe9pFvJGwBQb2VXDzkgDveoJ6gWNmW9cK1EMIezgX5wJIpk
         JRCT4GFR6EmUa8VyeGjsJNJCQ3dhf6gjFjOSiRmMQm51PUecuLf+laPZMIQ917Ogk4c0
         +ktQ==
X-Forwarded-Encrypted: i=1; AKwUvBxRIU5L09KtsNs60Y/RKUlrsTspljaz3hZQ6ksJzhLIF1LV65bxG+3Q0V5iNIBcRytvdeDFkWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kExo04wFBHUCetjJXhaawFyjxu6vd1kxsDp5cbYoUfWjMfHgsk
	IxDizXY1GEmfMViocOBI4mzmpha2QDs2I1sTFr2bq0xa6I3tTCwMODUdkQ/eI8O5s/Yo
X-Gm-Gg: AYBFou18U4LCQpEJcLvvQ3uwvyAMuxBy0qL0H24Ik7YfDbYYEI8+6JsrRUyvZpSLA1d
	jtLVTL9Jo4dFzHZhFuRRhSToC4pr7Y2ISPCJAFyyouWCW02zXdDUomvWaUCC0Z8YAWIwnm5PLvg
	TH+KBDd/J1Dm/spQEVS1PTaP86+bGaqSveO+TwOop6FOlp3U0sRfaR2rbV7IY+GvG5YzhhbKVsB
	pHxeOp634hLfALGkcZZPQwkxZ9f6lEiLMsZiB3xxzFdBtGfQyfTmM3xsnUrx0zi5gzWdPzm1v+Q
	Y2o97ibwdHfIkBRDNn/LxNdHMxcQdF+8+R4Wx4vdCxf9ddpIwXoC2b80/OkSvzxpgN5ExVNpBNM
	q7llCmpXH5Vsq5K57h9jK7SNtouvh9mApRIkjn4JiTq2eoUvSSLALNT20tHjA7t87WnC5sHp8Kv
	igneGV2KZ0TDG/ES7O5UGz47+2HJ7RgYss3cKQJ45odXDJU+v8pX6/DGyh6Evfib334ayhck8SK
	YO6IG3XZiq7rsQaZzG6
X-Received: by 2002:a17:90b:5281:b0:3a0:3673:dbbf with SMTP id 98e67ed59e1d1-3a03673dd7bmr2791211a91.59.1789923893455;
        Sun, 20 Sep 2026 10:04:53 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a041b87bfesm2639291a91.3.2026.09.20.10.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:04:52 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: cel@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	sashiko-bot@kernel.org,
	rakukuip@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net 1/1] net/handshake: Protect request hash lookups
Date: Mon, 21 Sep 2026 01:04:13 +0800
Message-ID: <01a84794d26de3d9b78ccfb5f34025cd67429290.1789819174.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1789819174.git.rakukuip@gmail.com>
References: <cover.1789819174.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

handshake_req_hash_lookup() uses rhashtable_lookup_fast(), which drops
the RCU read lock internally and returns a naked pointer without
holding a reference count or an active RCU read lock.

When handshake_req_submit() encounters an error during notification
(such as handshake_genl_notify() failure), it removes the request from
the pending list and frees it synchronously via handshake_req_destroy()
and kfree().

If an asynchronous transport teardown or cancel races that unwind,
concurrent callers such as handshake_req_cancel(), tls_handshake_close(),
or handshake_nl_done_doit() can look up the request and dereference
freed memory. Additionally, rhashtable traversal itself can race with
kfree() and panic in memcmp.

Furthermore, handshake_req_next() dequeues a pending request without
taking a reference on the request itself. If FD_PREPARE() or hp_accept()
fails after a concurrent cancellation or socket close has released the
submit file pin, dropping the file pin in handshake_nl_accept_doit()
can trigger socket destruction immediately, freeing the request before
handshake_complete() or trace_handshake_cmd_accept_err() completes.

Fix these races by introducing a kref reference count and rcu_head to
struct handshake_req. handshake_req_hash_lookup() now safely acquires a
reference using kref_get_unless_zero() under rcu_read_lock(). Likewise,
handshake_req_next() acquires a reference under hn_lock, and callers
release their references using handshake_req_put(). Releasing the final
reference in handshake_req_put() frees the request via kfree_rcu().

Fixes: 3b3009ea8abb ("net/handshake: Create a NETLINK service for handling handshake requests")
Reported-by: Vega <vega@nebusec.ai>
Closes: https://sashiko.dev/#/patchset/20260521-handshake-file-pin-v2-0-b9dadc472040@oracle.com
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/handshake/handshake-test.c |  3 +++
 net/handshake/handshake.h      |  5 ++++
 net/handshake/netlink.c        |  3 +++
 net/handshake/request.c        | 43 +++++++++++++++++++++++++++++-----
 net/handshake/tlshd.c          |  8 +++----
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 3dd507470d5f..9fe2e934b9b9 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -236,6 +236,7 @@ static void handshake_req_submit_test4(struct kunit *test)
 	/* Assert */
 	KUNIT_EXPECT_NOT_NULL(test, result);
 	KUNIT_EXPECT_PTR_EQ(test, req, result);
+	handshake_req_put(result);
 
 	handshake_req_cancel(sock->sk);
 	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
@@ -398,6 +399,7 @@ static void handshake_req_cancel_test2(struct kunit *test)
 	 * off by handshake_req_next(); see handshake_nl_accept_doit().
 	 */
 	fput(filp);
+	handshake_req_put(next);
 
 	/* Act */
 	result = handshake_req_cancel(sock->sk);
@@ -452,6 +454,7 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	/* Pretend to complete this request */
 	handshake_complete(next, -ETIMEDOUT, NULL);
 	KUNIT_EXPECT_EQ(test, file_count(filp), fcount_before);
+	handshake_req_put(next);
 
 	/* Act */
 	result = handshake_req_cancel(sock->sk);
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index da61cadd1ad3..f6312061e6cf 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -10,6 +10,8 @@
 #ifndef _INTERNAL_HANDSHAKE_H
 #define _INTERNAL_HANDSHAKE_H
 
+#include <linux/kref.h>
+
 /* Per-net namespace context */
 struct handshake_net {
 	spinlock_t		hn_lock;	/* protects next 3 fields */
@@ -36,6 +38,8 @@ struct handshake_req {
 	struct file			*hr_file;
 	struct sock			*hr_sk;
 	void				(*hr_odestruct)(struct sock *sk);
+	struct kref			hr_kref;
+	struct rcu_head			hr_rcu;
 
 	/* Always the last field */
 	char				hr_priv[];
@@ -85,6 +89,7 @@ int handshake_req_hash_init(void);
 void handshake_req_hash_destroy(void);
 void *handshake_req_private(struct handshake_req *req);
 struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
+void handshake_req_put(struct handshake_req *req);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index 3fd4fef9bab1..da5d41e139a7 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -119,6 +119,7 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 
 		trace_handshake_cmd_accept(net, req, req->hr_sk, fd_prepare_fd(fdf));
 		fd_publish(fdf);
+		handshake_req_put(req);
 		return 0;
 	}
 
@@ -127,6 +128,7 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 		handshake_complete(req, -EIO, NULL);
 out_status:
 	trace_handshake_cmd_accept_err(net, req, NULL, err);
+	handshake_req_put(req);
 	return err;
 }
 
@@ -160,6 +162,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 		status = -(int)nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
 
 	handshake_complete(req, status, info);
+	handshake_req_put(req);
 	sockfd_put(sock);
 	return 0;
 }
diff --git a/net/handshake/request.c b/net/handshake/request.c
index cd30d54d0501..fa61660e386c 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -59,8 +59,16 @@ void handshake_req_hash_destroy(void)
 
 struct handshake_req *handshake_req_hash_lookup(struct sock *sk)
 {
-	return rhashtable_lookup_fast(&handshake_rhashtbl, &sk,
-				      handshake_rhash_params);
+	struct handshake_req *req;
+
+	rcu_read_lock();
+	req = rhashtable_lookup_fast(&handshake_rhashtbl, &sk,
+				     handshake_rhash_params);
+	if (req && !kref_get_unless_zero(&req->hr_kref))
+		req = NULL;
+	rcu_read_unlock();
+
+	return req;
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_req_hash_lookup);
 
@@ -74,13 +82,28 @@ static bool handshake_req_hash_add(struct handshake_req *req)
 	return ret == 0;
 }
 
-static void handshake_req_destroy(struct handshake_req *req)
+static void handshake_req_free(struct kref *kref)
 {
+	struct handshake_req *req =
+		container_of(kref, struct handshake_req, hr_kref);
+
 	if (req->hr_proto->hp_destroy)
 		req->hr_proto->hp_destroy(req);
+	kfree_rcu(req, hr_rcu);
+}
+
+void handshake_req_put(struct handshake_req *req)
+{
+	if (req)
+		kref_put(&req->hr_kref, handshake_req_free);
+}
+EXPORT_SYMBOL_IF_KUNIT(handshake_req_put);
+
+static void handshake_req_destroy(struct handshake_req *req)
+{
 	rhashtable_remove_fast(&handshake_rhashtbl, &req->hr_rhash,
 			       handshake_rhash_params);
-	kfree(req);
+	handshake_req_put(req);
 }
 
 static void handshake_sk_destruct(struct sock *sk)
@@ -95,6 +118,7 @@ static void handshake_sk_destruct(struct sock *sk)
 	trace_handshake_destruct(sock_net(sk), req, sk);
 	sk_destruct = req->hr_odestruct;
 	handshake_req_destroy(req);
+	handshake_req_put(req);
 	if (sk_destruct)
 		sk_destruct(sk);
 }
@@ -124,6 +148,7 @@ struct handshake_req *handshake_req_alloc(const struct handshake_proto *proto,
 	if (!req)
 		return NULL;
 
+	kref_init(&req->hr_kref);
 	INIT_LIST_HEAD(&req->hr_list);
 	req->hr_proto = proto;
 	return req;
@@ -187,8 +212,10 @@ static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
  * @class: handler class to match
  *
  * On a non-NULL return, the caller owns an extra reference
- * on @req->hr_file.  FD_PREPARE() consumes it on success; on
- * the FD_PREPARE() failure path the caller must fput() it.
+ * on @req->hr_file and a reference on @req.  FD_PREPARE() consumes
+ * the file reference on success; on the FD_PREPARE() failure path
+ * the caller must fput() it.  The caller must release the request
+ * reference using handshake_req_put().
  *
  * Return: pointer to a removed handshake_req, or NULL.
  */
@@ -209,6 +236,7 @@ struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 		 * ownership.
 		 */
 		get_file(pos->hr_file);
+		kref_get(&pos->hr_kref);
 		req = pos;
 		break;
 	}
@@ -367,6 +395,7 @@ bool handshake_req_cancel(struct sock *sk)
 		/* Request hadn't been accepted - mark cancelled */
 		if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
 			trace_handshake_cancel_busy(net, req, sk);
+			handshake_req_put(req);
 			return false;
 		}
 		goto out_true;
@@ -374,6 +403,7 @@ bool handshake_req_cancel(struct sock *sk)
 	if (test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
 		/* Request already completed */
 		trace_handshake_cancel_busy(net, req, sk);
+		handshake_req_put(req);
 		return false;
 	}
 
@@ -381,6 +411,7 @@ bool handshake_req_cancel(struct sock *sk)
 	trace_handshake_cancel(net, req, sk);
 
 	fput(req->hr_file);
+	handshake_req_put(req);
 	return true;
 }
 EXPORT_SYMBOL(handshake_req_cancel);
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 7567150c2a4f..164fce83658a 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -449,9 +449,9 @@ void tls_handshake_close(struct socket *sock)
 	req = handshake_req_hash_lookup(sock->sk);
 	if (!req)
 		return;
-	if (!test_and_clear_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags))
-		return;
-	tls_alert_send(sock, TLS_ALERT_LEVEL_WARNING,
-		       TLS_ALERT_DESC_CLOSE_NOTIFY);
+	if (test_and_clear_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags))
+		tls_alert_send(sock, TLS_ALERT_LEVEL_WARNING,
+			       TLS_ALERT_DESC_CLOSE_NOTIFY);
+	handshake_req_put(req);
 }
 EXPORT_SYMBOL(tls_handshake_close);
-- 
2.43.0
