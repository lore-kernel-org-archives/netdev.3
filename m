Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579B4756C0
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324579; cv=none; b=C5OTRNOY5abTCTY8tdxXmt0Qh5knALg/LNALKkWoWwrOwW5tqrg19hHw/wh79jcHzv4FO+/ZZc+zowbmM3UBgxnckpQnErl6gMvowK7DGIwdMZgsWJpbjUKfwZE2EavscR/i8mTfUk3KATIf+/6OgRrGW9w3+aS+vVr38L/qPYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324579; c=relaxed/simple;
	bh=fONyvsGqe4281Xuw95Mc8exWac5SoFKftqs+5AIR3YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVKmLFjSBKB/H4hoGQ4Pj87Bjj341PnUBhJvWvkRdkZUxuPXq1XBVaYm7GBoYwo5KL0aPJm0FjNsA/UUMkJO6cIymAxs9Nd6alBV+P2SICY/zKnDzqlkeEyioaSb+w+AB9TOTli2foINBBq0mJkVlP4Exjw9Xh8d3+X1jCZeOIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=iod11HA6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="iod11HA6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf50c6f235so9564055ad.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785324577; x=1785929377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0RSh7anhKhi3o3iqmDgvhVKZLB+ONGiikOgDOrEhr8=;
        b=iod11HA6abLYpCUReIxWfRkhWuLFrVR5E9b8lg5lMzTCh9YXRwe8WKh4T+J8QmmloW
         H5xpGtIvTLRpq2dlhudwPsgx4SszVDVcwAQ+A0P7l+im+DIduKXkMOuaXsObVa26Cr9z
         ST54rYGEgpOV1+WD/YDk19SqnHbv40Jx0L3JC/d/buw0FO7mXnAuXHhbTb0qqmA8bpfF
         mOUI6NpbsaEwZ7a0rFgf0eut0jt+V7ORQBBnJKYZaAu1H+goUWYBq3Uzf9xlxxmcb/Su
         1x25wVm6H8GMY1sW8lq7jyuJGXVyW81VXHo44EG1yxB56eC/2GnO0LtVC7FaVCUx4shN
         f48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324577; x=1785929377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0RSh7anhKhi3o3iqmDgvhVKZLB+ONGiikOgDOrEhr8=;
        b=QYzev6eRCjbdNBAn2n6namzly/HHiogg2GBzTe5to+wWGgjenXBuTE7ofvFkhwVtJ6
         EFtHG1IhgLPsN7jLSABfetFRMM806CSTj7H8SXm9RTZXbEzSNeMDDF5jruAO/Y2hgp2T
         6M4pFXu+viSg995SUlQJXyxS4hczmHsRmf5ert/PeO7zZgWAiX/ceP0duyn9WW2AXPfY
         57zzdnqGX0bRCfdfTdyOXp6YHjIOqNy66YGUtzZk6DZiRCdJuCqqzZ10mXZVNoo9gWBE
         n/tlPTQPLItg+69JrLXl8XtoRzdx0KDJMImOw/ShpogNF1wZKaKbP7bwlGBoqoaovndR
         42aQ==
X-Gm-Message-State: AOJu0Yyn2cgvZu7iGOdv0rVenWScwadZXdUc4pDRgFMci4cn4c5VvVaZ
	gQ983kHUqDO8fguTXJjV2HulPfXQwpNzKvOGPy8xMti40YiDZfQJA5uB9n8GLheIvTZuMfQ3YbZ
	cslktOdZl
X-Gm-Gg: AR+sD10e8fXQzFBh/5/s310Aw1wNb+4psjYjvOXnRnW92gitlFBSEIPcTGeHfLyFdjg
	y5+Wa6GOlClnkAbwi8bmcJEhKqqvbVcnsIfbTCyEfxttrPcWFVGPwXxT1axrdyIsk3yvI2Qmi6E
	GYn6YttuAw0ovq/butXT4N6iB2Co6jWjqKjvdVsIqySYDh1iNMblsPv7w9PG4Er6lj4xI3QOdQs
	Tfd+Jw0EBPPlbV6p+uoPALmR8zgTQuBXSgA1FIvqcbjwZGdmGa1UTv2WMoY4aO3KH8PmCx/9i5A
	pSMlhqpAwuCJATCAavw5yciVbaPkvCKnABjh+746STYJrJ1xfj7zrYqAaSLeZpTQHwnDv+HzI1J
	EKLjn1oL6cs1hq1r16sKB7ShynLb3FmS4nxxJO5URUA7NJUGmNRGFB632V74Bwh905MF4jvPFRB
	QHTI7CBrzkF5i9396wo6P7BTW2EDuF9hxj3dtmHgil2u5iL5Y19VCEH6P2BOGjuc3lRm5WhmA=
X-Received: by 2002:a17:902:ce83:b0:2bd:8395:fedd with SMTP id d9443c01a7336-2d015d874d1mr69608405ad.37.1785324576972;
        Wed, 29 Jul 2026 04:29:36 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c55a7dsm9898505ad.84.2026.07.29.04.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:29:36 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	dsahern@kernel.org,
	kees@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	fw@strlen.de,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 1/2] tcp: diag: fix unbounded bucket lock hold in tcp_diag_dump()
Date: Wed, 29 Jul 2026 11:28:39 +0000
Message-ID: <f4df05193cfa73ce02aa4a8a0496f99a5093a17d.1785307984.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1785307984.git.zihanx@nebusec.ai>
References: <cover.1785307984.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_diag dumps execute attacker-controlled bytecode through
inet_diag_bc_sk(). tcp_diag_dump() currently evaluates socket filters and
runs that bytecode while holding the listener, bind and ehash bucket
locks.

A dump request can therefore force unbounded per-bucket lock hold by
arranging for many sockets in the same bucket to fail the pre-bytecode
filters, so the old 16-entry batching limit no longer bounds the locked
walk itself. Under load this can trigger soft lockups and may escalate to
a watchdog panic.

Fix this by making each locked section collect only referenced sockets.
Move all netns/family/port checks, inet_diag_bc_sk(), and fill work out
of the bucket locks so the batch limit bounds raw bucket traversal rather
than only filter hits. For listener, bind and ehash buckets, keep a
referenced dump cursor so restarts resume after the previous socket
instead of rescanning the bucket head under the same lock.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/linux/inet_diag.h |  15 ++
 net/ipv4/inet_diag.c      |  13 ++
 net/ipv4/tcp_diag.c       | 316 +++++++++++++++++++++++++++-----------
 3 files changed, 257 insertions(+), 87 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 704fd415c2b4..4859e77a28c7 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -6,6 +6,7 @@
 #include <uapi/linux/inet_diag.h>
 
 struct inet_hashinfo;
+struct sock;
 
 struct inet_diag_handler {
 	struct module	*owner;
@@ -32,12 +33,24 @@ struct inet_diag_handler {
 };
 
 struct bpf_sk_storage_diag;
+
+enum inet_diag_dump_cursor_type {
+	INET_DIAG_DUMP_CURSOR_NONE,
+	INET_DIAG_DUMP_CURSOR_TCP_LISTEN,
+	INET_DIAG_DUMP_CURSOR_TCP_BIND,
+	INET_DIAG_DUMP_CURSOR_TCP_EHASH,
+	INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN,
+};
+
 struct inet_diag_dump_data {
 	struct nlattr *req_nlas[__INET_DIAG_REQ_MAX];
 #define inet_diag_nla_bc req_nlas[INET_DIAG_REQ_BYTECODE]
 #define inet_diag_nla_bpf_stgs req_nlas[INET_DIAG_REQ_SK_BPF_STORAGES]
 
 	struct bpf_sk_storage_diag *bpf_stg_diag;
+	struct sock *dump_cursor;
+	unsigned int dump_cursor_slot;
+	u8 dump_cursor_type;
 	bool mark_needed;	/* INET_DIAG_BC_MARK_COND present. */
 #ifdef CONFIG_SOCK_CGROUP_DATA
 	bool cgroup_needed;	/* INET_DIAG_BC_CGROUP_COND present. */
@@ -53,6 +66,8 @@ int inet_sk_diag_fill(struct sock *sk, struct inet_connection_sock *icsk,
 
 int inet_diag_bc_sk(const struct inet_diag_dump_data *cb_data, struct sock *sk);
 
+void inet_diag_dump_clear_cursor(struct inet_diag_dump_data *cb_data);
+
 void inet_diag_msg_common_fill(struct inet_diag_msg *r, struct sock *sk);
 
 static inline size_t inet_diag_msg_attrs_size(void)
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 34b77aa87d0a..41148e880054 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -891,10 +891,23 @@ static int inet_diag_dump_start_compat(struct netlink_callback *cb)
 	return __inet_diag_dump_start(cb, sizeof(struct inet_diag_req));
 }
 
+void inet_diag_dump_clear_cursor(struct inet_diag_dump_data *cb_data)
+{
+	if (!cb_data->dump_cursor)
+		return;
+
+	sock_gen_put(cb_data->dump_cursor);
+	cb_data->dump_cursor = NULL;
+	cb_data->dump_cursor_slot = 0;
+	cb_data->dump_cursor_type = INET_DIAG_DUMP_CURSOR_NONE;
+}
+EXPORT_SYMBOL_GPL(inet_diag_dump_clear_cursor);
+
 static int inet_diag_dump_done(struct netlink_callback *cb)
 {
 	struct inet_diag_dump_data *cb_data = cb->data;
 
+	inet_diag_dump_clear_cursor(cb_data);
 	bpf_sk_storage_diag_free(cb_data->bpf_stg_diag);
 	kfree(cb->data);
 
diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index ba1fdbe9807f..be0c22cc445b 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -285,6 +285,65 @@ static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
 				 net_admin);
 }
 
+/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
+ * with bh disabled.
+ */
+#define SKARR_SZ 16
+
+static void tcp_diag_save_cursor(struct inet_diag_dump_data *cb_data, int type,
+				 unsigned int slot, struct sock *sk)
+{
+	sock_hold(sk);
+	inet_diag_dump_clear_cursor(cb_data);
+	cb_data->dump_cursor = sk;
+	cb_data->dump_cursor_slot = slot;
+	cb_data->dump_cursor_type = type;
+}
+
+static bool tcp_diag_bind_collect_sock(struct sock *sk, struct sock **sk_arr,
+				       int *num_arr, int *accum, int num)
+{
+	sock_hold(sk);
+	num_arr[*accum] = num;
+	sk_arr[*accum] = sk;
+
+	return ++*accum == SKARR_SZ;
+}
+
+static bool tcp_diag_bind_collect_owners(struct hlist_head *owners,
+					 struct sock **sk_arr, int *num_arr,
+					 int *accum, int *num, int s_num)
+{
+	struct sock *sk;
+
+	sk_for_each_bound(sk, owners) {
+		if (*num < s_num) {
+			(*num)++;
+			continue;
+		}
+
+		if (tcp_diag_bind_collect_sock(sk, sk_arr, num_arr, accum, *num))
+			return true;
+		(*num)++;
+	}
+
+	return false;
+}
+
+static bool tcp_diag_bind_collect_owners_continue(struct sock *sk,
+						  struct sock **sk_arr,
+						  int *num_arr, int *accum,
+						  int *num)
+{
+	hlist_for_each_entry_continue(sk, sk_bind_node) {
+		if (tcp_diag_bind_collect_sock(sk, sk_arr, num_arr, accum, *num))
+			return true;
+		(*num)++;
+	}
+
+	return false;
+}
+
 static void twsk_build_assert(void)
 {
 	BUILD_BUG_ON(offsetof(struct inet_timewait_sock, tw_family) !=
@@ -335,8 +394,15 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		for (i = s_i; i <= hashinfo->lhash2_mask; i++) {
 			struct inet_listen_hashbucket *ilb;
 			struct hlist_nulls_node *node;
+			struct sock *sk_arr[SKARR_SZ];
+			struct sock *cursor;
+			int num_arr[SKARR_SZ];
+			int idx, accum, res;
+			bool use_cursor;
 
+resume_listen_walk:
 			num = 0;
+			accum = 0;
 			ilb = &hashinfo->lhash2[i];
 
 			if (hlist_nulls_empty(&ilb->nulls_head)) {
@@ -344,52 +410,80 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				continue;
 			}
 			spin_lock(&ilb->lock);
-			sk_nulls_for_each(sk, node, &ilb->nulls_head) {
-				struct inet_sock *inet = inet_sk(sk);
+			cursor = cb_data->dump_cursor;
+			use_cursor = cursor &&
+				     cb_data->dump_cursor_type ==
+				     INET_DIAG_DUMP_CURSOR_TCP_LISTEN &&
+				     cb_data->dump_cursor_slot == i &&
+				     !hlist_nulls_unhashed(&cursor->sk_nulls_node) &&
+				     cursor->sk_nulls_node.pprev != LIST_POISON2;
+			node = use_cursor ? cursor->sk_nulls_node.next :
+					    ilb->nulls_head.first;
+			hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {
+				if (!use_cursor && num < s_num)
+					goto next_listen;
 
-				if (!net_eq(sock_net(sk), net))
-					continue;
+				sock_hold(sk);
+				num_arr[accum] = num;
+				sk_arr[accum] = sk;
+				if (++accum == SKARR_SZ)
+					break;
 
-				if (num < s_num) {
-					num++;
-					continue;
-				}
+next_listen:
+				++num;
+			}
+			spin_unlock(&ilb->lock);
 
+			res = 0;
+			for (idx = 0; idx < accum; idx++) {
+				struct inet_sock *inet;
+
+				sk = sk_arr[idx];
+				if (!net_eq(sock_net(sk), net))
+					goto processed_listen_sk;
+
+				inet = inet_sk(sk);
 				if (r->sdiag_family != AF_UNSPEC &&
 				    sk->sk_family != r->sdiag_family)
-					goto next_listen;
+					goto processed_listen_sk;
 
 				if (r->id.idiag_sport != inet->inet_sport &&
 				    r->id.idiag_sport)
-					goto next_listen;
-
-				if (!inet_diag_bc_sk(cb_data, sk))
-					goto next_listen;
+					goto processed_listen_sk;
 
-				if (inet_sk_diag_fill(sk, inet_csk(sk), skb,
-						      cb, r, NLM_F_MULTI,
-						      net_admin) < 0) {
-					spin_unlock(&ilb->lock);
-					goto done;
+				if (res >= 0 && inet_diag_bc_sk(cb_data, sk)) {
+					res = inet_sk_diag_fill(sk, inet_csk(sk),
+								skb, cb, r, NLM_F_MULTI,
+								net_admin);
+					if (res < 0)
+						num = num_arr[idx];
 				}
+processed_listen_sk:
+				if (res >= 0)
+					tcp_diag_save_cursor(cb_data,
+							     INET_DIAG_DUMP_CURSOR_TCP_LISTEN,
+							     i, sk);
+				sock_put(sk);
+			}
+			if (res < 0)
+				goto done;
 
-next_listen:
-				++num;
+			cond_resched();
+
+			if (accum == SKARR_SZ) {
+				s_num = 0;
+				goto resume_listen_walk;
 			}
-			spin_unlock(&ilb->lock);
 
+			inet_diag_dump_clear_cursor(cb_data);
 			s_num = 0;
 		}
 skip_listen_ht:
+		inet_diag_dump_clear_cursor(cb_data);
 		cb->args[0] = 1;
 		s_i = num = s_num = 0;
 	}
 
-/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
- * with bh disabled.
- */
-#define SKARR_SZ 16
-
 	/* Dump bound but inactive (not listening, connecting, etc.) sockets */
 	if (cb->args[0] == 1) {
 		if (!(idiag_states & TCPF_BOUND_INACTIVE))
@@ -399,8 +493,10 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			struct inet_bind_hashbucket *ibb;
 			struct inet_bind2_bucket *tb2;
 			struct sock *sk_arr[SKARR_SZ];
+			struct sock *cursor;
 			int num_arr[SKARR_SZ];
 			int idx, accum, res;
+			bool use_cursor;
 
 resume_bind_walk:
 			num = 0;
@@ -412,34 +508,38 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 				continue;
 			}
 			spin_lock_bh(&ibb->lock);
-			inet_bind_bucket_for_each(tb2, &ibb->chain) {
-				if (!net_eq(ib2_net(tb2), net))
-					continue;
-
-				sk_for_each_bound(sk, &tb2->owners) {
-					struct inet_sock *inet = inet_sk(sk);
-
-					if (num < s_num)
-						goto next_bind;
-
-					if (sk->sk_state != TCP_CLOSE ||
-					    !inet->inet_num)
-						goto next_bind;
-
-					if (r->sdiag_family != AF_UNSPEC &&
-					    r->sdiag_family != sk->sk_family)
-						goto next_bind;
-
-					if (!inet_diag_bc_sk(cb_data, sk))
-						goto next_bind;
-
-					sock_hold(sk);
-					num_arr[accum] = num;
-					sk_arr[accum] = sk;
-					if (++accum == SKARR_SZ)
+			cursor = cb_data->dump_cursor;
+			use_cursor = cursor &&
+				     cb_data->dump_cursor_type ==
+				     INET_DIAG_DUMP_CURSOR_TCP_BIND &&
+				     cb_data->dump_cursor_slot == i &&
+				     !hlist_unhashed(&cursor->sk_bind_node) &&
+				     cursor->sk_bind_node.pprev != LIST_POISON2 &&
+				     inet_csk(cursor)->icsk_bind2_hash;
+			if (use_cursor) {
+				tb2 = inet_csk(cursor)->icsk_bind2_hash;
+				sk = cursor;
+				if (tcp_diag_bind_collect_owners_continue(sk, sk_arr,
+									  num_arr,
+									  &accum,
+									  &num))
+					goto pause_bind_walk;
+				hlist_for_each_entry_continue(tb2, node) {
+					if (tcp_diag_bind_collect_owners(&tb2->owners,
+									 sk_arr,
+									 num_arr,
+									 &accum,
+									 &num, 0))
+						goto pause_bind_walk;
+				}
+			} else {
+				inet_bind_bucket_for_each(tb2, &ibb->chain) {
+					if (tcp_diag_bind_collect_owners(&tb2->owners,
+									 sk_arr,
+									 num_arr,
+									 &accum,
+									 &num, s_num))
 						goto pause_bind_walk;
-next_bind:
-					num++;
 				}
 			}
 pause_bind_walk:
@@ -447,15 +547,33 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 
 			res = 0;
 			for (idx = 0; idx < accum; idx++) {
-				if (res >= 0) {
-					res = inet_sk_diag_fill(sk_arr[idx],
-								NULL, skb, cb,
+				struct inet_sock *inet;
+
+				sk = sk_arr[idx];
+				if (!net_eq(sock_net(sk), net))
+					goto put_bind_sk;
+
+				inet = inet_sk(sk);
+				if (sk->sk_state != TCP_CLOSE || !inet->inet_num)
+					goto put_bind_sk;
+
+				if (r->sdiag_family != AF_UNSPEC &&
+				    r->sdiag_family != sk->sk_family)
+					goto put_bind_sk;
+
+				if (res >= 0 && inet_diag_bc_sk(cb_data, sk)) {
+					res = inet_sk_diag_fill(sk, NULL, skb, cb,
 								r, NLM_F_MULTI,
 								net_admin);
 					if (res < 0)
 						num = num_arr[idx];
 				}
-				sock_put(sk_arr[idx]);
+				if (res >= 0)
+					tcp_diag_save_cursor(cb_data,
+							     INET_DIAG_DUMP_CURSOR_TCP_BIND,
+							     i, sk);
+put_bind_sk:
+				sock_put(sk);
 			}
 			if (res < 0)
 				goto done;
@@ -463,13 +581,15 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 			cond_resched();
 
 			if (accum == SKARR_SZ) {
-				s_num = num + 1;
+				s_num = 0;
 				goto resume_bind_walk;
 			}
 
+			inet_diag_dump_clear_cursor(cb_data);
 			s_num = 0;
 		}
 skip_bind_ht:
+		inet_diag_dump_clear_cursor(cb_data);
 		cb->args[0] = 2;
 		s_i = num = s_num = 0;
 	}
@@ -482,42 +602,33 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		spinlock_t *lock = inet_ehash_lockp(hashinfo, i);
 		struct hlist_nulls_node *node;
 		struct sock *sk_arr[SKARR_SZ];
+		struct sock *cursor;
 		int num_arr[SKARR_SZ];
 		int idx, accum, res;
+		bool use_cursor;
 
 		if (hlist_nulls_empty(&head->chain))
 			continue;
 
-		if (i > s_i)
+		if (i > s_i) {
+			inet_diag_dump_clear_cursor(cb_data);
 			s_num = 0;
+		}
 
 next_chunk:
 		num = 0;
 		accum = 0;
 		spin_lock_bh(lock);
-		sk_nulls_for_each(sk, node, &head->chain) {
-			int state;
-
-			if (!net_eq(sock_net(sk), net))
-				continue;
-			if (num < s_num)
-				goto next_normal;
-			state = (sk->sk_state == TCP_TIME_WAIT) ?
-				READ_ONCE(inet_twsk(sk)->tw_substate) : sk->sk_state;
-			if (!(idiag_states & (1 << state)))
-				goto next_normal;
-			if (r->sdiag_family != AF_UNSPEC &&
-			    sk->sk_family != r->sdiag_family)
-				goto next_normal;
-			if (r->id.idiag_sport != htons(READ_ONCE(sk->sk_num)) &&
-			    r->id.idiag_sport)
-				goto next_normal;
-			if (r->id.idiag_dport != sk->sk_dport &&
-			    r->id.idiag_dport)
-				goto next_normal;
-			twsk_build_assert();
-
-			if (!inet_diag_bc_sk(cb_data, sk))
+		cursor = cb_data->dump_cursor;
+		use_cursor = cursor &&
+			     cb_data->dump_cursor_type ==
+			     INET_DIAG_DUMP_CURSOR_TCP_EHASH &&
+			     cb_data->dump_cursor_slot == i &&
+			     !hlist_nulls_unhashed(&cursor->sk_nulls_node) &&
+			     cursor->sk_nulls_node.pprev != LIST_POISON2;
+		node = use_cursor ? cursor->sk_nulls_node.next : head->chain.first;
+		hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {
+			if (!use_cursor && num < s_num)
 				goto next_normal;
 
 			if (!refcount_inc_not_zero(&sk->sk_refcnt))
@@ -534,13 +645,42 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 
 		res = 0;
 		for (idx = 0; idx < accum; idx++) {
-			if (res >= 0) {
-				res = sk_diag_fill(sk_arr[idx], skb, cb, r,
-						   NLM_F_MULTI, net_admin);
+			int state;
+
+			sk = sk_arr[idx];
+			if (!net_eq(sock_net(sk), net))
+				goto put_estab_sk;
+
+			state = (sk->sk_state == TCP_TIME_WAIT) ?
+				READ_ONCE(inet_twsk(sk)->tw_substate) : sk->sk_state;
+			if (!(idiag_states & (1 << state)))
+				goto put_estab_sk;
+
+			if (r->sdiag_family != AF_UNSPEC &&
+			    sk->sk_family != r->sdiag_family)
+				goto put_estab_sk;
+
+			if (r->id.idiag_sport != htons(READ_ONCE(sk->sk_num)) &&
+			    r->id.idiag_sport)
+				goto put_estab_sk;
+
+			if (r->id.idiag_dport != sk->sk_dport &&
+			    r->id.idiag_dport)
+				goto put_estab_sk;
+
+			twsk_build_assert();
+			if (res >= 0 && inet_diag_bc_sk(cb_data, sk)) {
+				res = sk_diag_fill(sk, skb, cb, r, NLM_F_MULTI,
+						   net_admin);
 				if (res < 0)
 					num = num_arr[idx];
 			}
-			sock_gen_put(sk_arr[idx]);
+			if (res >= 0)
+				tcp_diag_save_cursor(cb_data,
+						     INET_DIAG_DUMP_CURSOR_TCP_EHASH,
+						     i, sk);
+put_estab_sk:
+			sock_gen_put(sk);
 		}
 		if (res < 0)
 			break;
@@ -548,9 +688,11 @@ static void tcp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		cond_resched();
 
 		if (accum == SKARR_SZ) {
-			s_num = num + 1;
+			s_num = 0;
 			goto next_chunk;
 		}
+
+		inet_diag_dump_clear_cursor(cb_data);
 	}
 
 done:
-- 
2.43.0

