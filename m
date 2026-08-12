Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5917A31E838
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517779; cv=none; b=M+Xn/5q1fRhiBXan9zkefolrfV4G4lkKQ3pt4W2b2RvTNt1l6TMdLBU1jlFAxpSFkUAdXUCl396i0FkX7J4dDHOHBfmq+XVjdgI2WfMU9qsbko10DhLeO8c7KH/pUjraqGA8X/On5w2rR1jkEEsoap5fxcLbRK+pULSztOgdOZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517779; c=relaxed/simple;
	bh=epeMBQ1VCWKYkFcqnC7mbhGl85XSUyqpcxq2gdj6ACc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLdRgwjDRliWZ4Yp8pocsju1cM9+T9YaxdM0yl9SVno0cPnTKnjz7IHrglDTmvkJhiBZ2v1DrlesLgeZy6+UDykiuvB2ZYPfxyEW/9VKndeF47Y5aymZ10AbiWcUPfE7qUwehNoSmZqohE+b7sbqj36vJ8HEZ9EvojXDzszj54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=NJ8gUWiy; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="NJ8gUWiy"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso548659a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 23:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786517778; x=1787122578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2435U7AuiFlclz3ovDhPH4Evn/dXBwX9yd7aszzBj8A=;
        b=NJ8gUWiy5cZhGmoPbWTuppAvTi+fK6Gxd8zimOAoUcnybJeeT05BKCm3dWyxX8d2jd
         F8lTvzhcWfMv4UqN1gW2ygnf8AMRgzXE+IFrI5CZO8apy8IFAVuvJxrTqB1Bw1+Kcqje
         XwRSWP9avw5b99otGNVYcD3w9SUjv+SNdiuIThsnD6injW7dwToAhlq9MGmUWaNUlChC
         y6Url1MzlJhyI6Z3U78jTDihrCn46WqERv8btgLrP8R7BRwTW6iyDZkv+v8aTGlbxIcX
         JiXysrD1xpZYyOPvL6vcaluCUOIbMcqL0zI8IxnNe4trVDHLTWfaH1D+5cfY8RyaaXGp
         XMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517778; x=1787122578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2435U7AuiFlclz3ovDhPH4Evn/dXBwX9yd7aszzBj8A=;
        b=sQIpQLBJ8CXVJgIpw/sd1DoPcvvSuzQWoiUd7+e1i1vtar3lzoswtaRFLi7OphKhI2
         pJG1+5KuW7EkExlyCPXhhA+yGnP7T6AvrQMoZt/xoqItElQ34jj9JGQojmoKRovd49p9
         wLKCho/ZNm1+AJ1FA3c94PntyT8YuvNco4+yy72OfTNUAUzP+hcP6GkEz65NJ5yjdoFB
         Z6OkckCvaqoywftfQ4D0WQWBxcQ3XUHN3ujj4gLnvvYxlcjkybSf0xW1YE129V4tyvVx
         rEv/3jpTp3QDI2RQvbOeji9RHb1lFbIMXGm4oZP1BiVYlJgzOnKTB/5aGijZPfkTwH0x
         6jWA==
X-Gm-Message-State: AOJu0Yya3LSz2O80a2gBD+ooTCFidTne4eHmUIFsc83gNqbsiOJuhuV/
	8BqBazjk9155TSprgjDj/R1+F/V5/jJrRtDBud85nNqVVI946fiml8jztG+MIxI4YNdEwoWhC6H
	JR2ax7PHY
X-Gm-Gg: AR+sD10gH97i05Qkg5CnbkvlDClo2r/ayRQhDvk+MbNkCxC/J8KOlKDIiF0dOukh9fO
	15d88c0CW+s9h9bNhH0uKxWwSANPvP7dQya/FjVXAxqfrtCm2BLWdHueri1FRuINim7eNYLpoXE
	t6i8bwRj05tAERuhWH9b6OaCyjLJc2rGCFm04iHtQk3Z5aR+VUnMOjtPnOZqdUYpU9m2jfLkhwJ
	+B9O9eH+ZLw1ptwTn5vnqvUKDKS+T0XrWCtAQqWxz/avMq/+dU+0w4K8gs4BFk7f/aqAjvaq0Ut
	DYh5sfLHrM1Eobwz/HTktxtyHS3Z7ewgFYZV9+6zvf/5P8lA6G7pVMEfNurCXgj3/u/wQ7KrLJR
	loIjXKbMA2ocusg3oU3Y+FV5mhoqjS/hcIDpcBA7Mbyykgdd3nBgimBXG0PcUzlQJqH996qZzot
	5JKOUGbJPqDM+4EAI1Wf7yfU0PQjVkEylS0UJwmzT881DL1ywozmlvFanoabg9cnB+eLWK1g==
X-Received: by 2002:a17:90b:4cd1:b0:38e:ad9d:1151 with SMTP id 98e67ed59e1d1-393012cee12mr3299614a91.4.1786517777555;
        Tue, 11 Aug 2026 23:56:17 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8d00067sm2546980a91.12.2026.08.11.23.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:56:17 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	kafai@fb.com,
	daniel@iogearbox.net,
	kylebot@openai.com,
	david.lee@trailofbits.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 2/2] mptcp: fix MP_CAPABLE token migration when cloning reqsk
Date: Wed, 12 Aug 2026 14:55:46 +0800
Message-ID: <6abadc83940143e099fa3b54ec6dea2fb95da090.1786497414.git.yuantan098@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1786497414.git.yuantan098@gmail.com>
References: <cover.1786497414.git.yuantan098@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruide Cao <caoruide123@gmail.com>

TCP request migration clones pending request sockets with
inet_reqsk_clone().  For MPTCP MP_CAPABLE requests this byte-copies the
token_node hlist state into the clone even though the token table still
names the original request.

Moving the token only after inet_ehash_insert() succeeds leaves a window
where the cloned request is already globally visible from the ehash but
the token table still points at the original request.  Reordering the
move after clone but before ehash exposure closes that window, but
concurrent RX can still race on the old request and observe that the
token was already moved.

Move MP_CAPABLE token request ownership during MPTCP request cloning
under the token bucket lock.  Make mptcp_token_accept() and
mptcp_token_destroy_request() re-check token_node under the same lock and
treat an already moved or removed request as a normal race instead of
warning.

If the passive MP_CAPABLE socket cannot claim the token, fail
mptcp_sk_clone_init() and let the subflow fall back instead of
installing a socket with mismatched token ownership.

Keep token publication after the cloned msk has its first subflow and
connection list initialized.  If token accept still fails, tear the
cloned MPTCP socket down by open-coding the inet-level forced-close
preparation, avoiding TCP-only helpers such as tcp_done() or
inet_csk_prepare_forced_close() on the MPTCP master socket.

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/mptcp/protocol.c   | 31 +++++++++++++++++----
 net/mptcp/protocol.h   |  4 ++-
 net/mptcp/subflow.c    |  2 ++
 net/mptcp/token.c      | 61 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/token_test.c |  4 +--
 5 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7c8180d8d5ef..b05c8d37a083 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3561,6 +3561,24 @@ static void mptcp_copy_ip_options(struct sock *newsk, const struct sock *sk)
 	rcu_read_unlock();
 }
 
+static void mptcp_sk_clone_destroy(struct sock *nsk)
+{
+	struct mptcp_sock *msk = mptcp_sk(nsk);
+
+	mptcp_release_sched(msk);
+	mptcp_set_state(nsk, TCP_CLOSE);
+	/* inet_csk_prepare_forced_close() clears TCP sock_ops state via
+	 * tcp_sk(), but nsk is an MPTCP master socket; keep the inet-level
+	 * destroy preparation here.
+	 */
+	bh_unlock_sock(nsk);
+	sock_put(nsk);
+	sock_set_flag(nsk, SOCK_DEAD);
+	tcp_orphan_count_inc();
+	inet_sk(nsk)->inet_num = 0;
+	inet_csk_destroy_sock(nsk);
+}
+
 struct sock *mptcp_sk_clone_init(const struct sock *sk,
 				 const struct mptcp_options_received *mp_opt,
 				 struct sock *ssk,
@@ -3620,11 +3638,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	list_add(&subflow->node, &msk->conn_list);
 	sock_hold(ssk);
 
-	/* new mpc subflow takes ownership of the newly
-	 * created mptcp socket
-	 */
-	mptcp_token_accept(subflow_req, msk);
-
 	/* set msk addresses early to ensure mptcp_pm_get_local_id()
 	 * uses the correct data
 	 */
@@ -3633,6 +3646,14 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	mptcp_rcv_space_init(msk, ssk);
 	msk->rcvq_space.time = mptcp_stamp();
 
+	if (!mptcp_token_accept(subflow_req, msk)) {
+		list_del_init(&subflow->node);
+		WRITE_ONCE(msk->first, NULL);
+		sock_put(ssk);
+		mptcp_sk_clone_destroy(nsk);
+		return NULL;
+	}
+
 	if (mp_opt->suboptions & OPTION_MPTCP_MPC_ACK)
 		__mptcp_subflow_fully_established(msk, subflow, mp_opt);
 	bh_unlock_sock(nsk);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 1b80f2d6ec5a..69d531c770c4 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1076,9 +1076,11 @@ static inline void mptcp_token_init_request(struct request_sock *req)
 }
 
 int mptcp_token_new_request(struct request_sock *req);
+void mptcp_token_move_request(struct request_sock *req,
+			      struct request_sock *new_req);
 void mptcp_token_destroy_request(struct request_sock *req);
 int mptcp_token_new_connect(struct sock *ssk);
-void mptcp_token_accept(struct mptcp_subflow_request_sock *r,
+bool mptcp_token_accept(struct mptcp_subflow_request_sock *r,
 			struct mptcp_sock *msk);
 bool mptcp_token_exists(u32 token);
 struct mptcp_sock *mptcp_token_get_sock(struct net *net, u32 token);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 8f8e1229766d..d40ab09ab75b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -56,6 +56,8 @@ void mptcp_subflow_reqsk_clone(struct request_sock *req,
 
 	if (subflow_req->msk)
 		sock_hold((struct sock *)subflow_req->msk);
+
+	mptcp_token_move_request(req, new_req);
 }
 
 static void subflow_generate_hmac(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
diff --git a/net/mptcp/token.c b/net/mptcp/token.c
index f1a50f367add..24877a2c3772 100644
--- a/net/mptcp/token.c
+++ b/net/mptcp/token.c
@@ -180,6 +180,36 @@ int mptcp_token_new_connect(struct sock *ssk)
 	return 0;
 }
 
+void mptcp_token_move_request(struct request_sock *req,
+			      struct request_sock *new_req)
+{
+	struct mptcp_subflow_request_sock *subflow_req = mptcp_subflow_rsk(req);
+	struct mptcp_subflow_request_sock *new_subflow_req;
+	struct mptcp_subflow_request_sock *pos;
+	struct token_bucket *bucket;
+
+	new_subflow_req = mptcp_subflow_rsk(new_req);
+
+	if (hlist_nulls_unhashed_lockless(&subflow_req->token_node)) {
+		mptcp_token_init_request(new_req);
+		return;
+	}
+
+	bucket = token_bucket(subflow_req->token);
+	spin_lock_bh(&bucket->lock);
+	if (hlist_nulls_unhashed(&subflow_req->token_node)) {
+		mptcp_token_init_request(new_req);
+	} else {
+		pos = __token_lookup_req(bucket, subflow_req->token);
+		if (pos == subflow_req)
+			hlist_nulls_replace_init_rcu(&subflow_req->token_node,
+						     &new_subflow_req->token_node);
+		else
+			mptcp_token_init_request(new_req);
+	}
+	spin_unlock_bh(&bucket->lock);
+}
+
 /**
  * mptcp_token_accept - replace a req sk with full sock in token hash
  * @req: the request socket to be removed
@@ -187,24 +217,36 @@ int mptcp_token_new_connect(struct sock *ssk)
  *
  * Called when a SYN packet creates a new logical connection, i.e.
  * is not a join request.
+ *
+ * Return: true on success.
  */
-void mptcp_token_accept(struct mptcp_subflow_request_sock *req,
+bool mptcp_token_accept(struct mptcp_subflow_request_sock *req,
 			struct mptcp_sock *msk)
 {
 	struct mptcp_subflow_request_sock *pos;
 	struct sock *sk = (struct sock *)msk;
 	struct token_bucket *bucket;
+	bool ret = false;
 
-	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
 	bucket = token_bucket(req->token);
 	spin_lock_bh(&bucket->lock);
+	if (hlist_nulls_unhashed(&req->token_node))
+		goto unlock;
 
-	/* pedantic lookup check for the moved token */
 	pos = __token_lookup_req(bucket, req->token);
-	if (!WARN_ON_ONCE(pos != req))
-		hlist_nulls_del_init_rcu(&req->token_node);
+	if (pos != req)
+		goto unlock;
+
+	hlist_nulls_del_init_rcu(&req->token_node);
 	__sk_nulls_add_node_rcu((struct sock *)msk, &bucket->msk_chain);
+	ret = true;
+
+unlock:
 	spin_unlock_bh(&bucket->lock);
+	if (ret)
+		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+
+	return ret;
 }
 
 bool mptcp_token_exists(u32 token)
@@ -355,16 +397,21 @@ void mptcp_token_destroy_request(struct request_sock *req)
 	struct mptcp_subflow_request_sock *pos;
 	struct token_bucket *bucket;
 
-	if (hlist_nulls_unhashed(&subflow_req->token_node))
+	if (hlist_nulls_unhashed_lockless(&subflow_req->token_node))
 		return;
 
 	bucket = token_bucket(subflow_req->token);
 	spin_lock_bh(&bucket->lock);
+	if (hlist_nulls_unhashed(&subflow_req->token_node))
+		goto unlock;
+
 	pos = __token_lookup_req(bucket, subflow_req->token);
-	if (!WARN_ON_ONCE(pos != subflow_req)) {
+	if (pos == subflow_req) {
 		hlist_nulls_del_init_rcu(&pos->token_node);
 		bucket->chain_len--;
 	}
+
+unlock:
 	spin_unlock_bh(&bucket->lock);
 }
 
diff --git a/net/mptcp/token_test.c b/net/mptcp/token_test.c
index 4fc39fa2e262..be9acce8a567 100644
--- a/net/mptcp/token_test.c
+++ b/net/mptcp/token_test.c
@@ -99,7 +99,7 @@ static void mptcp_token_test_accept(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			mptcp_token_new_request((struct request_sock *)req));
 	msk->token = req->token;
-	mptcp_token_accept(req, msk);
+	KUNIT_EXPECT_TRUE(test, mptcp_token_accept(req, msk));
 	KUNIT_EXPECT_PTR_EQ(test, msk, mptcp_token_get_sock(&init_net, msk->token));
 
 	/* this is now a no-op */
@@ -122,7 +122,7 @@ static void mptcp_token_test_destroyed(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, 0,
 			mptcp_token_new_request((struct request_sock *)req));
 	msk->token = req->token;
-	mptcp_token_accept(req, msk);
+	KUNIT_EXPECT_TRUE(test, mptcp_token_accept(req, msk));
 
 	/* simulate race on removal */
 	refcount_set(&sk->sk_refcnt, 0);
-- 
2.43.0
