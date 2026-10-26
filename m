Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016263;
	b=LP6QOqzzndFWjStggsFbLQo8LDKX6qrsYySh/c2A6A1DV/DSqlzCP/B0r+lN6bXIPJmU
	 enZZsEpu0bZOXZBxJRMkgbopO6Dv3VYFrM6DBcRRUyU0fI5TEZZLTnPNhQN0h7hivlpa4
	 C1CfyP9YaBmdicIfHvmUXrV6dorszugIXjfLgYJ9JoSoTYUIhAOAJQIW9hSoz/8/LPK20
	 S9rTYzTJKRMcw0kJAzPVfVFSru188iEuuZpbf5VdxABzMSQBIZSevV3msBnLrCYFru7ZW
	 b0tmk6FkMaYWxRpN1lBsLwJGRW1HpePqWyGk3YtQ9FaeDnnPJejjauEzzJ3v6TDQNCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/0C4rlxAw/43YJa3IFTDARWYcZPND6mimQSbZdwuy8E=;
	b=vuQPaBXqzQtB/Wj1rqJyssVDCRq1vk3+gnS6Fj9QipgEx3wjFV1rs5mbEHfMUNtag8o+
	 v3NbnOMfpW9+5oVDE1UeBmDzmYCb1CUvF5WvSQRzurPosnyJreWZ3LGf+y+4tFIFArYWG
	 shgCCWxA5NSd2zxx1AWvbNdgDbvympnKsfCycgSIfzgzJH6/+MZsulK1sJwai2PbAb721
	 jQXa+o0qBfHVM522MuGNtZrPI6/VrQfnK5HD9XB0/5j3a3EEMgAkVaaB8ltZbarwx5fAy
	 vKx1+Qd5ml+FWiA+siVk6UWHDVUpv27zCSAyPcUa7uON+3JV1TBMNMlIbDp2utYPG2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cAUQTKhl;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7260A2607
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 12:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBE7260A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cAUQTKhl
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1467566a91.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793016262; x=1793621062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/0C4rlxAw/43YJa3IFTDARWYcZPND6mimQSbZdwuy8E=;
        b=cAUQTKhlcaiKqmBCYidLmRORxiZwt2+OeO/ImaAy6z5ZXPskt5AQeEfSzenI0/NTwC
         wQ56QUgD+2rhaeGm8j4eQUBVlo+fCH5EvWoOfWkvBwpzyAf25J0vct/5UCkL2AECGG3e
         XqYG5KjeJamTInICP2lc1fl/UoaokRtbK8WrTwWpJT5FN+FDzdtOMd21bOrfySsafH4R
         gzMlOPpiUwQ+baNl3U4phIoS75m08/lUGlckjFcU7Gac0RDIIQUPMMHIGeU2JkIYA2Xw
         XBe13Y7NQTEXb5Ax7kSkgXnTuZGJCfMiXVtsZwyDXOdyybl//z/jgAo3HQAokT8zhK5e
         H+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793016262; x=1793621062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/0C4rlxAw/43YJa3IFTDARWYcZPND6mimQSbZdwuy8E=;
        b=Xj6eotmZWZV45TjUuP0eMFOszptg2PksVYAw5a3VFvzHqIvFf8245C85DHk5tmW3IO
         JLHqKh62zFxDS2Znlj3VbM7wMJXtb7uKSk34kfOxGhaRqb4zXyNgFOn+c5hinEPtDeHY
         FF9iRwh6ZvlkDfDIo57EE/mY8Ca5SpMj0JlvBgeLMdYx/acmH8DWaTHDZpkPnh2ugBXh
         ahKvSxsebOzjwHLINhaCr6V73ARa39gwfXCCEC+TxIC4zSNI3vbPulmZNCwrk1WhWiiT
         sLentkhp+yMYVBgyniZcEGU4BVUqAuxA1dp3OHFd2BrQIxX7hRMiYRPbfdNB24zkbSqv
         WT0w==
X-Forwarded-Encrypted: i=1; AKwUvBxLb69dlxZYbXQbhnqwSiXMcNJWMXhpMBpdtmcYv4Y0EfYK/MwFxclDrLnXBZdD5DoLKiX8m1s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBu0I+qgsq2sRoVjSmfV/z+GgDN4q5F223GPVBMk5gJl1ZR77U
	Od/ieynYJaA110sc8f3XG2yxgRbDRZwXzJ/5KBXSPUoBSWvrC/D+29IE
X-Gm-Gg: AYBFou2VmrKEyFrmn+cTjCXXHala8BePLRmDkOjZouti4EGfWejZNQmk92q27S04rlO
	Zm8YRkUvhUrcqpjsXDPv2PGvk7vQmxafCqQF0hNIuAAUyOlRL+n5nBwUDYpfDa5DKKyKil3+hVT
	HTWgLGt3sUIwajUDQnQp0cvWU4JEa6fLlnJtZKrpvWTJJ7QPuHh3scEcCSIVpb9lUva7qIBGBtY
	/shfuYkHI5mf7hI5xLWP8oz1zqbdTfW7VZUtvcjL2zNxr/zdjuFpX+AScKfKW4Ap/O2qrItMLDM
	uWD/ZJzvIFBP/F7lYjupJXQkCYod3VGAVAR4BZCANQkuCXInzoBokD5iQZ8RulYLDt1Pqb5wA7y
	/VxKBijV+bSI22kXG25gCMHbpY3awGyRZLwvMajBf6vpH0dkZ/UNJCZEjVwxi8FvJIq6auGibV4
	xKwzFQkI+MXkDRn6vbcUn/opEyUCmb99ZGERkEVnJE77pGv+wzkA+QJd30G0J56KrGP0XuFrs0Q
	S5izLvC/5E2E3cGiDiyA7u5fV7R7FKzW1kQIQbTWirUuFdDdnjvVKsJYOQlJ/qVez7/ZSfw
X-Received: by 2002:a17:90a:fd89:b0:3ac:b6eb:e0dd with SMTP id 98e67ed59e1d1-3ae3c222aa8mr202856a91.50.1793016261932;
        Mon, 26 Oct 2026 05:04:21 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebb0639bsm8298309a91.12.2026.10.26.05.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:04:21 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: matttbe@kernel.org,
	martineau@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: geliang@kernel.org,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH net 1/2] mptcp: keep delegated subflow contexts alive until socket release
Date: Mon, 26 Oct 2026 20:04:08 +0800
Message-Id: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0@gmail.com>
References: <pm-mptcp-objects-candidate-0010-v3-14c229ea28a7d31f60a0-0@gmail.com>
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

mptcp_subflow_delegate() links the subflow context into a per-CPU list
and pins only the TCP subflow socket with sock_hold(). The context is
freed independently of that reference: subflow_ulp_release() frees a
disposable context with kfree_rcu() when inet_csk_destroy_sock() tears
the ULP down, and __mptcp_close_ssk() does the same for a context whose
ULP release ran earlier. Neither path checks whether delegated_node is
still linked, and TCP protocol destruction runs before the final
sock_put(), so the queued socket reference does not protect the
context.

When mptcp_napi_poll() dequeues the entry on the scheduling CPU only
after that RCU grace period has elapsed, for example because the poll
returned at its budget or runs from ksoftirqd, it unlinks the node from
freed memory, as the KASAN report at the end shows:

  TCP / NAPI                   Close                     RCU
  enqueue ctx, sock_hold(ssk)
  return at budget
                               __mptcp_close_ssk()
                                 ctx->disposable = 1
                                 __tcp_close()
                                   tcp_cleanup_ulp()
                                     kfree_rcu(ctx)
                                                         reclaim ctx
  dequeue ctx->delegated_node

Keep a retired context attached to its socket until the socket itself
is destroyed, which happens only after every pending reference, the
delegated one included, has been dropped. mptcp_subflow_ctx_release()
chains sk_destruct: the replacement clears the ULP data pointer, calls
the original TCP destructor and then queues the context for RCU
freeing. It is only used for an unhashed socket that is already dead.
TCP never clones such a socket, so a child cannot inherit the
overridden destructor.

mptcp_napi_poll() skips a subflow whose ULP has been released or that
fell back to plain TCP: its protocol ops have been restored and nothing
is left to process. The ops pointer is cleared with the socket owned or
under its bh lock, so a racing read lands in the owned branch, which
only dequeues the entry.

The fallback branch of mptcp_subflow_drop_ctx() cannot use the socket
destructor: that socket lives on as a plain TCP socket and must keep
neither a stale ULP pointer nor an overridden destructor. It is reached
with a live socket when an unaccepted MPTCP socket is force-closed at
listener shutdown, and a delegated action may still be queued for its
first subflow. Hand such a context over to mptcp_napi_poll() instead:
the dropping path sets a new RETIRED bit in delegated_status and frees
the context only if no action was scheduled, while the poll frees a
dequeued context that carries that bit. Both sides use atomic
read-modify-write operations on the same word, so exactly one of them
frees the context.

BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x1ed/0x210
Read of size 8 at addr ffff8881271668c8 by task kworker/0:9/1315

Workqueue: events mptcp_worker
Call Trace:
 <IRQ>
 __list_del_entry_valid_or_report+0x1ed/0x210
 mptcp_napi_poll+0x1de/0xa50
 __napi_poll.constprop.0+0xab/0x670
 net_rx_action+0x4df/0xe60
 handle_softirqs+0x201/0x930
 do_softirq+0x47/0xa0
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0xf6/0x120
 __mptcp_close_ssk+0x7a/0x1680
 mptcp_close_ssk+0x11f/0x170
 mptcp_worker+0x7df/0x11c0
 process_one_work+0x908/0x19c0
 worker_thread+0x65c/0xe40
 kthread+0x34f/0x460
 ret_from_fork+0x659/0x940
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 1308:
 __kmalloc_cache_noprof+0x251/0x610
 subflow_create_ctx+0x91/0x290
 subflow_ulp_init+0x66/0x460
 tcp_set_ulp+0x2d0/0x720
 mptcp_subflow_create_socket+0x32b/0x9a0
 __mptcp_subflow_connect+0x30a/0x12b0
 mptcp_pm_create_subflow_or_signal_addr+0xf4a/0x1630
 mptcp_pm_nl_add_addr_doit+0x4cf/0xb80
 genl_family_rcv_msg_doit+0x1f6/0x2e0
 genl_rcv_msg+0x48b/0x700
 netlink_rcv_skb+0x133/0x390
 genl_rcv+0x2d/0x40
 netlink_unicast+0x504/0x840
 netlink_sendmsg+0x7f7/0xcf0
 ____sys_sendmsg+0x88b/0x9d0
 ___sys_sendmsg+0x125/0x1d0
 __sys_sendmsg+0x13e/0x1e0
 do_syscall_64+0x115/0x6a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 29:
 __rcu_free_sheaf_prepare+0x65/0x2a0
 rcu_free_sheaf+0x1f/0xe0
 rcu_core+0x661/0x1d10
 handle_softirqs+0x201/0x930
 run_ksoftirqd+0x33/0x60
 smpboot_thread_fn+0x3bd/0x9a0
 kthread+0x34f/0x460
 ret_from_fork+0x659/0x940
 ret_from_fork_asm+0x1a/0x30

Fixes: b19bc2945b40 ("mptcp: implement delegated actions")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM
---
 net/mptcp/protocol.c | 18 +++++++++++++++++-
 net/mptcp/protocol.h |  8 ++++++--
 net/mptcp/subflow.c  | 44 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e..01b94a280c81 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2705,7 +2705,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	 */
 	if (!inet_csk(ssk)->icsk_ulp_ops) {
 		WARN_ON_ONCE(!sock_flag(ssk, SOCK_DEAD));
-		kfree_rcu(subflow, rcu);
+		mptcp_subflow_ctx_release(ssk);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
 		__tcp_close(ssk, 0);
@@ -4793,6 +4793,21 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 
 		bh_lock_sock_nested(ssk);
+		if (unlikely(!READ_ONCE(inet_csk(ssk)->icsk_ulp_ops))) {
+			/* The subflow was retired, by ULP release or by a
+			 * fallback to plain TCP: nothing is left to process.
+			 * The ops pointer is cleared with the socket owned or
+			 * under its bh lock, so a racing read lands in the
+			 * owned branch below instead.
+			 * mptcp_subflow_drop_ctx() leaves a still queued
+			 * context to us: free it now that it is dequeued.
+			 */
+			if (xchg(&subflow->delegated_status, 0) &
+			    BIT(MPTCP_DELEGATE_RETIRED))
+				kfree_rcu(subflow, rcu);
+			goto unlock;
+		}
+
 		if (!sock_owned_by_user(ssk)) {
 			mptcp_subflow_process_delegated(ssk, xchg(&subflow->delegated_status, 0));
 		} else {
@@ -4804,6 +4819,7 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 			smp_wmb();
 			clear_bit(MPTCP_DELEGATE_SCHEDULED, &subflow->delegated_status);
 		}
+unlock:
 		bh_unlock_sock(ssk);
 		sock_put(ssk);
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 011e73d04ee6..45bae97a4e21 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -553,8 +553,10 @@ DECLARE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 #define MPTCP_DELEGATE_SEND		1
 #define MPTCP_DELEGATE_ACK		2
 #define MPTCP_DELEGATE_SNDBUF		3
+#define MPTCP_DELEGATE_RETIRED		4	/* unreachable ctx, NAPI frees it */
 
-#define MPTCP_DELEGATE_ACTIONS_MASK	(~BIT(MPTCP_DELEGATE_SCHEDULED))
+#define MPTCP_DELEGATE_ACTIONS_MASK	(~(BIT(MPTCP_DELEGATE_SCHEDULED) | \
+					   BIT(MPTCP_DELEGATE_RETIRED)))
 /* MPTCP subflow context */
 struct mptcp_subflow_context {
 	struct	list_head node;/* conn_list of subflows */
@@ -593,7 +595,7 @@ struct mptcp_subflow_context {
 		send_fastclose : 1,
 		send_infinite_map : 1,
 		remote_key_valid : 1,        /* received the peer key from */
-		disposable : 1,	    /* ctx can be free at ulp release time */
+		disposable : 1,	    /* ctx is no longer owned by the msk */
 		closing : 1,	    /* must not pass rx data to msk anymore */
 		valid_csum_seen : 1,        /* at least one csum validated */
 		is_mptfo : 1,	    /* subflow is doing TFO */
@@ -646,6 +648,7 @@ struct mptcp_subflow_context {
 	const	struct inet_connection_sock_af_ops *icsk_af_ops;
 	void	(*tcp_state_change)(struct sock *sk);
 	void	(*tcp_error_report)(struct sock *sk);
+	void	(*tcp_sock_destruct)(struct sock *sk);
 
 	struct	rcu_head rcu;
 };
@@ -761,6 +764,7 @@ mptcp_subflow_get_mapped_dsn(const struct mptcp_subflow_context *subflow)
 }
 
 void mptcp_subflow_process_delegated(struct sock *ssk, long actions);
+void mptcp_subflow_ctx_release(struct sock *ssk);
 
 static inline void mptcp_subflow_delegate(struct mptcp_subflow_context *subflow, int action)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 78e886b20258..8dc0677dc551 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -814,6 +814,33 @@ static void subflow_ulp_fallback(struct sock *sk,
 	mptcp_subflow_ops_undo_override(sk);
 }
 
+static void subflow_ctx_destruct(struct sock *ssk)
+{
+	struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
+
+	rcu_assign_pointer(inet_csk(ssk)->icsk_ulp_data, NULL);
+	ctx->tcp_sock_destruct(ssk);
+	kfree_rcu(ctx, rcu);
+}
+
+/* Retire the context of a subflow socket that is being destroyed: a
+ * delegated action, or any other holder of a socket reference, can still
+ * reach the context, so free it together with the socket.
+ *
+ * Only an unhashed, dead socket may be retired this way. TCP never clones
+ * such a socket, so the overridden destructor can't leak into a child.
+ */
+void mptcp_subflow_ctx_release(struct sock *ssk)
+{
+	struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
+
+	if (WARN_ON_ONCE(ssk->sk_destruct == subflow_ctx_destruct))
+		return;
+
+	ctx->tcp_sock_destruct = ssk->sk_destruct;
+	ssk->sk_destruct = subflow_ctx_destruct;
+}
+
 void mptcp_subflow_drop_ctx(struct sock *ssk)
 {
 	struct mptcp_subflow_context *ctx = mptcp_subflow_ctx(ssk);
@@ -826,9 +853,20 @@ void mptcp_subflow_drop_ctx(struct sock *ssk)
 		subflow_ulp_fallback(ssk, ctx);
 		if (ctx->conn)
 			sock_put(ctx->conn);
-	}
 
-	kfree_rcu(ctx, rcu);
+		/* The socket lives on as a plain TCP socket: it must keep
+		 * neither a stale ULP context nor an overridden destructor,
+		 * so the context can't be retired through sk_destruct here.
+		 * A delegated action may still be queued for it, though:
+		 * hand the context over to mptcp_napi_poll() in that case.
+		 */
+		if (!(set_mask_bits(&ctx->delegated_status, 0,
+				    BIT(MPTCP_DELEGATE_RETIRED)) &
+		      BIT(MPTCP_DELEGATE_SCHEDULED)))
+			kfree_rcu(ctx, rcu);
+	} else {
+		mptcp_subflow_ctx_release(ssk);
+	}
 }
 
 void __mptcp_subflow_fully_established(struct mptcp_sock *msk,
@@ -2087,7 +2125,7 @@ static void subflow_ulp_release(struct sock *ssk)
 
 	mptcp_subflow_ops_undo_override(ssk);
 	if (release)
-		kfree_rcu(ctx, rcu);
+		mptcp_subflow_ctx_release(ssk);
 }
 
 static void subflow_ulp_clone(const struct request_sock *req,

