Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8C44C506
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014905; cv=none; b=eFT863mSJb33bBMxm1wzuucI5VQBxLC+UfOOFlSMk5OgQyqMJ29zCh7bzP/pZf8IX4OfMU8QEEq3qANxkTh+q3vzHf5JsWk9szrsLWKe4t/KEh0SbNuu5rvue2yPbYveyfkZ+YDbiIWKY8RdampzxWe+Ozlo8LinIZ1h4HRKf6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014905; c=relaxed/simple;
	bh=amyEg9s1SM6GN6svOrv3HLp1ySuyy+gLUZT+5HjBiDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPoYxX1zwx3YNcsGthDzYGNjzboWeOdizaY79YZFo1MPx4iKlVjeI7M4wqsQFzMIxdMQWxt6gf0iHfbBSAQjZlTsskQwU50sM3KSTN///sC5KAdOnoYtRZmd4PtWW2aJNmjHsqiCBZQeaDZkSDfN1xSLVJifs5uxtxqX3z7UcOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=fz1cIMi3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="fz1cIMi3"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cbb7926836eso1530642a12.3
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 04:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786014903; x=1786619703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5SvYcx4ai7A+LAhsWyrU62LuZiiW2rO6oOfRGjc++k4=;
        b=fz1cIMi30Beqh+m7J9gIcIdHNDD+o9V9XoxhvXRTgY6kjjvTmd9UAuAnv4gJk4JGYS
         yR6oAGI36/IugSlqY8UT32upe1Tra8PDG7SCAgj7ntgf0QEP2OrPFNkGLDmqecpm5XLk
         Vm1wkkWRyPTEj8KbU8HxSSzwgH4bg/N90yxAo2331Nk31t0ejodo185kBd9PjMKniMEM
         ZaNnbSSfAMR0+ekhAMsMzQsh6qxMU6n6mpnIGRLSIjabeAc9W+KW15rJ9ua3FDUsAgJR
         tLFe4EaLk9proNYdmLX6iCgv6jKCufSbrVgfNLcboMd841SmIDYNzqym8XEi4ZUPpjnU
         m5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014903; x=1786619703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5SvYcx4ai7A+LAhsWyrU62LuZiiW2rO6oOfRGjc++k4=;
        b=OaIFLLHFEAlOWvU+w1Kxj2jxJdBxXO2Z+Ki8nEk8pRPecWUGDNvFL2sLYBtRUKB3OJ
         oLbLqOP6x7hhJef7ivsMc1MSnk+79ZS5uPHgiWSTVSG/9lfHy4u4tqaZSaGyWZdW+Ehc
         vW7BJi+MbRxfS2sVpvqEjb65gB0Q+8xP/mlUCGZvtF+Hn65tNYMn0VAdRWySqDFmwL58
         TzHONEqIQj+q59LJcDEV0R+vY2NpIeQVSo9C+dppRP2Priug6jotaGupXbm1sRFViJKC
         FsWMd1bOjx7oJmAnaZGnAM68lyWP/Y3bKU3wiI0QVwWt1dNaEpCZMX8VwSgVZmrBVUq6
         HoPg==
X-Gm-Message-State: AOJu0Yyyxvnt0nkilvJZ0dGPvl7wJACID8LMPApXSPH9nxC7p2nbMcFd
	lUZig8wgyI8+o84aXHpgHcT2tr0J5M+WoeIcxWa3cv3KGSXv5wlrkFlLNL95wKAiH2SoE5oGUUL
	fIy5AitQp/93RwQlb
X-Gm-Gg: AR+sD12H5vbpdhbdB52e1XKXd5yECQB9I+6IXz7JsrcDlDnu/xRvsEQu+a7HikKO3mL
	DERvupbIhDaqnJhG9qqIoVSFWK5BFDp7z03cZSI5OY1glA/2jvT03pay6ljxK/qWe9z/SpNPmRi
	juomNIwTgJM9BwYKOyoq6tehiFR4C8y8ZiBIJh3xrCjKi4XbWWj/UeEQIbfxuI2/xCYEhPJiu9S
	ahJbh+Ka+724IBguFocqUgAwvKJe8r4CHSKPSUz/4C+2Qf/bkz1aJB1k+IxmlSHG53P0gE5+K77
	PHbiyqRHRKjA16LJEUYOSch0K0HL1WijpDy6RPE7GZlZlqlWQVgmjCtSMreHP3QvSvWGFC7JiLf
	QpJJLDU+huVsH9fV+sPgm1ntUJcUenuCUT9nQN2wcaVw3ICn3TlUnEVCJZEVULPhZpWXIZhqnvY
	xjPjMVzqnrrEhbzj+BqXnt/U7dyrvTKgtxuQzuwP/hucSlnPG+0E8Prkl5WU+uJK3F6tuHtAPNL
	4681Q==
X-Received: by 2002:a05:6a00:2d8d:b0:846:bc81:3e29 with SMTP id d2e1a72fcca58-84f2e0228aemr14866416b3a.2.1786014903269;
        Thu, 06 Aug 2026 04:15:03 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f453b07cdsm1214705b3a.17.2026.08.06.04.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 04:15:02 -0700 (PDT)
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
	daniel@iogearbox.net,
	kafai@fb.com,
	kylebot@openai.com,
	david.lee@trailofbits.com,
	vega@nebusec.ai,
	caoruide123@gmail.com,
	weir@nebusec.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net v3 2/2] mptcp: fix MP_CAPABLE token migration when cloning reqsk
Date: Thu,  6 Aug 2026 19:14:31 +0800
Message-ID: <a12d76b7f2305b5a8d64c3d6c3585e39684ff792.1785995291.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785995291.git.caoruide123@gmail.com>
References: <cover.1785995291.git.caoruide123@gmail.com>
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

Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmitting SYN+ACKs.")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/86e2514b533bf4d55d4aa2fdbf1404022e8c9430.1776149210.git.caoruide123%40gmail.com
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/mptcp/protocol.c   | 12 +++++----
 net/mptcp/protocol.h   |  4 ++-
 net/mptcp/subflow.c    |  2 ++
 net/mptcp/token.c      | 61 +++++++++++++++++++++++++++++++++++++-----
 net/mptcp/token_test.c |  4 +--
 5 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ca644ec53eed..07eaa6858d05 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3608,17 +3608,19 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 */
 	mptcp_set_state(nsk, TCP_ESTABLISHED);
 
+	if (!mptcp_token_accept(subflow_req, msk)) {
+		mptcp_release_sched(msk);
+		inet_csk_prepare_forced_close(nsk);
+		tcp_done(nsk);
+		return NULL;
+	}
+
 	/* The msk maintain a ref to each subflow in the connections list */
 	WRITE_ONCE(msk->first, ssk);
 	subflow = mptcp_subflow_ctx(ssk);
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
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4a2d40cd7b13..c58cfb1326b7 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1074,9 +1074,11 @@ static inline void mptcp_token_init_request(struct request_sock *req)
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
index be7260821566..65d876a08233 100644
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
