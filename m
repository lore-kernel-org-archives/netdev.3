Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45A239F18A
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 11:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785324584; cv=none; b=K+tYwhzfL/60pFekvhVY6cXpJ1IKSzbmIxMmBPsKvpIzIPvTWFsXMzozmvcARDCE5Px2idUNLi2d5bqvYF2xydbcrhHbefpvhRgGggl4Na8eMnJ0Z7yPsomV4Wf8GA9xRnxgXOPjd1DuyxyA1E085TeENH2P7Ppff32K/mE88rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785324584; c=relaxed/simple;
	bh=9MhVi3tBuUVUiWdwEgz/IihUj3etazN9M4/4mSNlqdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TP4N06DtM/az8Kya9BaygX4gEfXD7pSzcnLTyu3BHXDfHosDp4MJjIH/YOMcay+OVYIdhJERkcnfl+f/1wWwkgFSyqZKqpHuSUwttu3ZogRzKlz0bH81HzAvxuYj8h5Auli68CoQft5TG6DcaxbnRNTIZZuBTl1Q0rdrypW+PMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=TtXf2YZO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="TtXf2YZO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d004f135b1so12214735ad.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 04:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785324582; x=1785929382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VYe2iubu6ASdkv/skq7uS2fIda+uHnh2Q+ijL0hRfXc=;
        b=TtXf2YZOTmfDWDn5cLd3h7aPmaJLsn6oOAsjtyEL36QlIIJEOXBjtF8KSpaURYDE+U
         PmsXPCtD/MCmYo45rZD28j+Q3HgZGfZHyoT9MGlVzeYbT139iXzGqRVTa6RmTsiYFu5B
         SKWEyI6CocEEYpZNwcstG87AfuU7Nu5bUmcWKRn1lDtdDoq+y93hyqtYM1Ak4kg/ZtCh
         GCEfdm1Ga5k1g6rfDe118eFQgf8ETrjz/x1z8cIJ0DlX0PzYy/jppzmkOcG6EJ1dKJqw
         oB1YVN0xQxvypkcT6uT+9ZQvoKqqkkNivM0iayS9jWCH1MLQP66fxbUvFn7pTykhJWEQ
         e1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324582; x=1785929382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VYe2iubu6ASdkv/skq7uS2fIda+uHnh2Q+ijL0hRfXc=;
        b=ARx1HceeEBcDfyIs+uWhuHjITrqIPJby7liqmMu/YPm0W4VJq3DvnhhR/1ff50hPI2
         mVEH4CqeiHijSif9N2jAyfbqfJGtz7ry/QjdaUron2Yb9J2x6JXSdw1xuisd7P8Vfr/s
         pUDNKx3rKtRu7VvWIcu665/imE9t+vYje2SNTibvtmfVWwaGJ6MKwmmP/ipq48HZxN84
         WgLqq7BMDyMBbnt/+L1MWrMo/yrzmyE07gzsFm5H9PbNwYP9QSNsb9ByF1EB6VfOOlK0
         WIKHT0B8yv8aa2zCEf3vyjOHG6Q1NTbntPa9S477WdoEZoY9TkQeuUxSqHjcMq/7moJi
         ZE/Q==
X-Gm-Message-State: AOJu0YzdJPwdp6RwJTZlVWVC38SdELP9jCeZC0M2ztMLG/aKcBaUcMcP
	RTx6pn5IhYP3cDVR/3iIXsYdOjqA15Q3VR78qqr5cMzhxNfTf8vqlpDyTAXAPv4OCcwRXYvd6KO
	Vt3LD8SuG
X-Gm-Gg: AR+sD10PhBrhsfdqPkTf4Ef7xS+2j+PhTuFpsbfPL7htEt3PswKNT09Kw1NaKr995mR
	Z1q0QSGVK9O20K5AM/ZmEk49eB8iqLVyUStBUT93gD8vRfA/orSIW0rqSrdtT3e0v95R02S/Yr5
	7teyXRjzh1MY5xg+GblIZXbPMYQkqo0cRsHlNrO4EVGS5jeMde1fFIyD3F5UCYVBxG2ekcWBYZ2
	PVf5s7u/T48cS+GHyZBtaPE5kjkYvEbsD/lujAP8SI9LxBzlegKeEQGp7MXO3eLoFwtVgmGBYGZ
	JOgBVTi60JJHyRnXnlemA6eNFrM6Wu0V0Pe6TETreUcGbcJ6tYtHeAQ86djhlxt1vgqH4jy3xAo
	uOsObtyn3458+3Y1oOs5nihoTVrOqjQn4Itbt1DfEWp6ZJ0Yvr2QSjax3toGgID8Y7JRuGUX4G2
	/EI1lqHT7dRz6YOFYFsuqB4/xk0qtuxKhFFps7OT3rJkvXp7gyb/ZP02OLNXMEWkuClpVv8517B
	NvOI9zEYw==
X-Received: by 2002:a17:903:1a2d:b0:2ca:d7a3:3723 with SMTP id d9443c01a7336-2d015d238bdmr70760425ad.29.1785324581971;
        Wed, 29 Jul 2026 04:29:41 -0700 (PDT)
Received: from localhost.localdomain ([115.192.250.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c55a7dsm9898505ad.84.2026.07.29.04.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 04:29:41 -0700 (PDT)
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
Subject: [PATCH net 2/2] mptcp: diag: fix unbounded listener bucket lock hold
Date: Wed, 29 Jul 2026 11:28:40 +0000
Message-ID: <4632ca2134dbd3947529180ba8b8ba4b467c2098.1785307984.git.zihanx@nebusec.ai>
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

MPTCP listener diag dumping reuses sk_diag_dump(), which executes
inet_diag_bc_sk() before filling the netlink reply. The listener walk in
mptcp_diag_dump_listeners() currently performs MPTCP listener selection
and bytecode-triggering dump work while holding the listener bucket lock.

A dump request can therefore force unbounded per-bucket lock hold by
arranging for many listeners in the same bucket to miss the MPTCP or
socket-attribute prefilters, so the old 16-entry batching limit no longer
bounds the locked scan itself.

Fix this by collecting only referenced listener sockets under the bucket
lock. Re-check the MPTCP listener properties, obtain the parent MPTCP
socket reference, and run sk_diag_dump() only after dropping the lock.
Keep a referenced dump cursor so the next batch resumes after the previous
listener instead of rescanning the bucket head under the listener lock.

Fixes: 4fa39b701ce9 ("mptcp: listen diag dump support")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/mptcp/mptcp_diag.c | 124 +++++++++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 37 deletions(-)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 136c2d05c0ee..981e64343039 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -6,12 +6,25 @@
  * Author: Paolo Abeni <pabeni@redhat.com>
  */
 
+/* Process a bounded number of listeners per bucket lock hold. */
+#define MPTCP_DIAG_BULK_SZ 16
+
 #include <linux/kernel.h>
 #include <linux/net.h>
 #include <linux/inet_diag.h>
 #include <net/netlink.h>
 #include "protocol.h"
 
+static void mptcp_diag_save_cursor(struct inet_diag_dump_data *cb_data,
+				   unsigned int slot, struct sock *sk)
+{
+	sock_hold(sk);
+	inet_diag_dump_clear_cursor(cb_data);
+	cb_data->dump_cursor = sk;
+	cb_data->dump_cursor_slot = slot;
+	cb_data->dump_cursor_type = INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN;
+}
+
 static int sk_diag_dump(struct sock *sk, struct sk_buff *skb,
 			struct netlink_callback *cb,
 			const struct inet_diag_req_v2 *req,
@@ -77,6 +90,7 @@ static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callba
 				      bool net_admin)
 {
 	struct mptcp_diag_ctx *diag_ctx = (void *)cb->ctx;
+	struct inet_diag_dump_data *cb_data = cb->data;
 	struct net *net = sock_net(skb->sk);
 	struct inet_hashinfo *hinfo;
 	int i;
@@ -86,62 +100,98 @@ static void mptcp_diag_dump_listeners(struct sk_buff *skb, struct netlink_callba
 	for (i = diag_ctx->l_slot; i <= hinfo->lhash2_mask; i++) {
 		struct inet_listen_hashbucket *ilb;
 		struct hlist_nulls_node *node;
-		struct sock *sk;
-		int num = 0;
-
+		struct sock *tmp, *sk, *sk_arr[MPTCP_DIAG_BULK_SZ];
+		struct sock *cursor;
+		int accum, idx, num, ret;
+		int num_arr[MPTCP_DIAG_BULK_SZ];
+		bool use_cursor;
+
+resume_listen_walk:
+		num = 0;
+		accum = 0;
 		ilb = &hinfo->lhash2[i];
+		ret = 0;
 
 		rcu_read_lock();
 		spin_lock(&ilb->lock);
-		sk_nulls_for_each(sk, node, &ilb->nulls_head) {
-			const struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(sk);
-			struct inet_sock *inet = inet_sk(sk);
-			int ret;
-
-			if (num < diag_ctx->l_num)
-				goto next_listen;
-
-			if (!ctx || strcmp(inet_csk(sk)->icsk_ulp_ops->name, "mptcp"))
-				goto next_listen;
-
-			sk = ctx->conn;
-			if (!sk || !net_eq(sock_net(sk), net))
-				goto next_listen;
-
-			if (r->sdiag_family != AF_UNSPEC &&
-			    sk->sk_family != r->sdiag_family)
-				goto next_listen;
-
-			if (r->id.idiag_sport != inet->inet_sport &&
-			    r->id.idiag_sport)
+		cursor = cb_data->dump_cursor;
+		use_cursor = cursor &&
+			     cb_data->dump_cursor_type ==
+			     INET_DIAG_DUMP_CURSOR_MPTCP_LISTEN &&
+			     cb_data->dump_cursor_slot == i &&
+			     !hlist_nulls_unhashed(&cursor->sk_nulls_node) &&
+			     cursor->sk_nulls_node.pprev != LIST_POISON2;
+		node = use_cursor ? cursor->sk_nulls_node.next :
+				    ilb->nulls_head.first;
+		hlist_nulls_for_each_entry_from(sk, node, sk_nulls_node) {
+			if (!use_cursor && num < diag_ctx->l_num)
 				goto next_listen;
 
 			if (!refcount_inc_not_zero(&sk->sk_refcnt))
 				goto next_listen;
 
-			ret = sk_diag_dump(sk, skb, cb, r, net_admin);
-
-			sock_put(sk);
-
-			if (ret < 0) {
-				spin_unlock(&ilb->lock);
-				rcu_read_unlock();
-				diag_ctx->l_slot = i;
-				diag_ctx->l_num = num;
-				return;
-			}
-			diag_ctx->l_num = num + 1;
-			num = 0;
+			num_arr[accum] = num;
+			sk_arr[accum] = sk;
+			if (++accum == MPTCP_DIAG_BULK_SZ)
+				break;
 next_listen:
 			++num;
 		}
 		spin_unlock(&ilb->lock);
 		rcu_read_unlock();
 
+		for (idx = 0; idx < accum; idx++) {
+			const struct tcp_ulp_ops *ulp_ops;
+			const struct mptcp_subflow_context *ctx;
+			struct inet_sock *inet;
+
+			sk = sk_arr[idx];
+			rcu_read_lock();
+			ctx = mptcp_subflow_ctx(sk);
+			ulp_ops = READ_ONCE(inet_csk(sk)->icsk_ulp_ops);
+			inet = inet_sk(sk);
+			tmp = ctx ? ctx->conn : NULL;
+			if (!ctx || !ulp_ops || strcmp(ulp_ops->name, "mptcp") ||
+			    !tmp || !net_eq(sock_net(tmp), net) ||
+			    (r->sdiag_family != AF_UNSPEC &&
+			     tmp->sk_family != r->sdiag_family) ||
+			    (r->id.idiag_sport != inet->inet_sport &&
+			     r->id.idiag_sport) ||
+			    !refcount_inc_not_zero(&tmp->sk_refcnt)) {
+				rcu_read_unlock();
+				goto processed_listener_sk;
+			}
+			rcu_read_unlock();
+			if (ret >= 0) {
+				ret = sk_diag_dump(tmp, skb, cb, r, net_admin);
+				if (ret < 0)
+					num = num_arr[idx];
+			}
+			sock_put(tmp);
+processed_listener_sk:
+			if (ret >= 0)
+				mptcp_diag_save_cursor(cb_data, i, sk);
+			sock_put(sk);
+		}
+
+		if (ret < 0) {
+			diag_ctx->l_slot = i;
+			diag_ctx->l_num = num;
+			return;
+		}
+
 		cond_resched();
+
+		if (accum == MPTCP_DIAG_BULK_SZ) {
+			diag_ctx->l_num = 0;
+			goto resume_listen_walk;
+		}
+
+		inet_diag_dump_clear_cursor(cb_data);
 		diag_ctx->l_num = 0;
 	}
 
+	inet_diag_dump_clear_cursor(cb_data);
 	diag_ctx->l_num = 0;
 	diag_ctx->l_slot = i;
 }
-- 
2.43.0

