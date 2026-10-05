Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37034CC620
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215147; cv=none; b=P8DzC9Kjq5JBWI8+MavWRGHQaVZvLaqL2Yb1bHr+7RdhAS2pRVhj5slw7g52O/jX1mNHbpSHgJMH6yMGYeKztdn2BkKe6PB3+DemYpqd/jJ6NY7g7Wdr2RjW3X/SYhjIxyDw9uEI9mek6YcTh1yswHrEUT/qbh3JCam5HXDrTvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215147; c=relaxed/simple;
	bh=I7sWKJIsvE5af1nh1DdX2zrNzOy+rlqnrSmIKP87qJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m/7i4cgnp6QtxayQUpg/smzwEgZdyfDpzX30NkkvSf588++msyVmdwPgn6DP36Dm7uO5jkumlN7sQRJt16CY1MYZbTgcnP/zSN3DugM0toP8PgC20N2bD1QGCTpvYSTBHo3/EJh2YBWqE+vr44OUaULlhFcoTmyQYlMTtwEqOQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mmPYv2O6; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mmPYv2O6"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-88629a452e0so1546073b3a.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215140; x=1791819940; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7fm9CPHW8EY+EUw4xj8qUNdwwWG49bRQwlN7lQQa9ro=;
        b=mmPYv2O6gDxWaaOJaK6iEDaAjiMX651ndz/bQE1z4yMw2KH7Zm5AL5ojZSBzxEs0g3
         2VdO1KMmwQjTnlgvW0SpIuewIZR1OZhwmiyGHGDEaw+eFXsdSTq+UXJ7jtK9czAp9zNC
         vfZHuwBx301U+P2Epc9sEuU22bBZar45d0b9CzZGgJ1X1y04YW7nT4eiRN41dtolxBZE
         wmWuTv7z+QEsa+45OB5M+m5eZQ5GylfBgwYf/DuWy+2gPDGTAzdJ6nOe/LCseo+jCYf6
         ObZcJSwC5I96PXQZNeItbRbyTZJaD9SBEHrQ/vP0p0sjWCZ2Rj17VyxW1c4cxrK9LISU
         vNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215140; x=1791819940;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7fm9CPHW8EY+EUw4xj8qUNdwwWG49bRQwlN7lQQa9ro=;
        b=SUyCnM2YPD+/WGh7gOFqINFG48RFaLt2ZXvudJ2d0TDke4QInp7yM1ItCKlyyUzsJZ
         j7K3ChNFGPpeASKzAuYyyFJbNBltpgEKDpJBf79O+kuJBsVmEC6MZ2CjUEfDFfa3MjEU
         tJ0WAwAMYt3bI0S1qMJ9wBce2qmuqY7Iy/6lxP4THgi3vxCjieqQFNxvLNgCp3KVNLbA
         n3r5ofJ7vPBTQf6Kop83qUEeGljwhBopsaLNP5aXqFupwgM98g8vPGtoItPliuXXOzQF
         eIwrrK2Jothj1vxZzYa5d03sV4fz+fg5YthA7AHA+AV6JG1rr5PNH3WKL91jxmfpU4SG
         ywyA==
X-Forwarded-Encrypted: i=1; AKwUvBxlyI95wd8sSEnn/uPHgY5FQpl9iy3fp/ieMMPgsGwpLD7Uo8hYPQ1yurZBDGGKCMUWNkdm2+o=@vger.kernel.org
X-Gm-Message-State: AFuF++l3ir8XYX48DFJ9fOjowE7sLLtJDfXmnxpncbQgKSOPgapvJFug
	yVlZk2dZngKBUG0rYsgmT9vCpIAycnsuP0y4EozI9d/LFWuukkVnNcUN325DI7oKi58joBhahHz
	ouAQQsg==
X-Received: from pgby27-n2.prod.google.com ([2002:a05:6a02:651b:20b0:cc7:d8ea:a7b5])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3284:b0:3dd:a006:ed9b
 with SMTP id adf61e73a8af0-3e0bd195e32mr10791156637.49.1791215139883; Mon, 05
 Oct 2026 08:45:39 -0700 (PDT)
Date: Mon,  5 Oct 2026 15:40:44 +0000
In-Reply-To: <20261005154533.4147685-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261005154533.4147685-3-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 2/9] bpf: tcp: Add a new per-socket flag and kfunc
 for bpf_tcp_ops.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The legacy SOCK_OPS guards some hooks with a per-socket flag,
tp->bpf_sock_ops_cb_flags.

In contrast, bpf_tcp_ops was initially designed without per-socket
flags so that users can simply define only the callbacks they need.

However, it turned out that even attaching a bpf_tcp_ops with a NULL
callback incurs measurable overhead in the fast path. [0]

We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
1 bit left for a new opt-in callback, while not all of the 7 existing
opt-in hooks are in the fast path and really need a flag guard.

Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
update it, both of which require sock_owned_by_me(sk):

  * bpf_sock_ops_cb_flags_set()
  * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)

Both helpers only overwrite the field, which leads to reading and
modifying the flags in the BPF prog and then writing them back
via the helper.  This prevents future use from tc or cgroup_skb
hooks where bh_lock_sock() alone cannot prevent races with process
context.

Let's add a new u32 field, tp->bpf_tcp_ops_flags, at the end of the
tcp_sock_read_txrx cacheline group, along with a new kfunc,
bpf_tcp_ops_set_flags().

bpf_tcp_ops_set_flags() takes bitmasks of flags to enable and
disable and updates tp->bpf_tcp_ops_flags atomically via
try_cmpxchg() without relying on lock_sock().

The kfunc is exposed to bpf_tcp_ops and BPF_PROG_TYPE_CGROUP_SOCKOPT.
The first argument is struct tcp_sock * so that bpf_tcp_sock() is
required for BPF_PROG_TYPE_CGROUP_SOCKOPT, but not for bpf_tcp_ops
where struct sock * is promoted to struct tcp_sock * automatically.

The fast-path callbacks will be guarded by the new flags in a later
patch after updating the existing selftest to avoid breaking bisection.

Link: https://lore.kernel.org/netdev/CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX832wUFOQ44fOwDnQ@mail.gmail.com/ #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/tcp.h            |  7 +++++
 include/net/tcp.h              |  1 +
 include/uapi/linux/bpf.h       |  8 +++++
 net/ipv4/bpf_tcp_ops.c         | 56 +++++++++++++++++++++++++++++++++-
 net/ipv4/tcp.c                 |  3 ++
 tools/include/uapi/linux/bpf.h |  8 +++++
 6 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a8c77719322..24bb751cc65a 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -233,6 +233,13 @@ struct tcp_sock {
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
 		is_cwnd_limited:1,/* forward progress limited by snd_cwnd? */
 		recvmsg_inq : 1;/* Indicate # of bytes in queue upon recvmsg */
+#ifdef CONFIG_BPF
+	u32	bpf_tcp_ops_flags;
+#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) \
+	(READ_ONCE((TP)->bpf_tcp_ops_flags) & BPF_TCP_OPS_FLAG_ ## ARG)
+#else
+#define BPF_TCP_OPS_TEST_FLAG(TP, ARG) (0)
+#endif
 	__cacheline_group_end(tcp_sock_read_txrx);
 
 	/* RX read-mostly hotpath cache lines */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index d61ee00052e3..f69091f5e01f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2934,6 +2934,7 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
 	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
+	WRITE_ONCE(tcp_sk(sk)->bpf_tcp_ops_flags, 0);
 }
 
 #else
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 4687c3310996..6ff90b73dd38 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7334,6 +7334,14 @@ enum {
 					 */
 };
 
+enum {
+	BPF_TCP_OPS_FLAG_RTT			= (1 << 0),
+	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL	= (1 << 1),
+	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN	= (1 << 2),
+	BPF_TCP_OPS_FLAG_WRITE_HDR_OPT		= (1 << 3),
+	BPF_TCP_OPS_FLAG_ALL			= (1 << 4) - 1,
+};
+
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
  * changes between the TCP and BPF versions. Ideally this should never happen.
  * If it does, we need to add code to convert them before calling
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index 1ada3b781bf1..5693857e764e 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -328,8 +328,62 @@ static struct bpf_struct_ops bpf_tcp_ops = {
 	.owner = THIS_MODULE,
 };
 
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_tcp_ops_set_flags(struct tcp_sock *tp, u32 enable, u32 disable)
+{
+	u32 old, new;
+
+	if ((enable & disable) || (enable | disable) & ~BPF_TCP_OPS_FLAG_ALL)
+		return -EINVAL;
+
+	old = READ_ONCE(tp->bpf_tcp_ops_flags);
+
+	do {
+		new = (old | enable) & ~disable;
+		if (new == old)
+			break;
+	} while (!try_cmpxchg(&tp->bpf_tcp_ops_flags, &old, new));
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(bpf_tcp_ops_set_flags_kfunc_set)
+BTF_ID_FLAGS(func, bpf_tcp_ops_set_flags)
+BTF_KFUNCS_END(bpf_tcp_ops_set_flags_kfunc_set)
+
+static int bpf_tcp_ops_set_flags_kfunc_filter(const struct bpf_prog *prog,
+					      u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&bpf_tcp_ops_set_flags_kfunc_set, kfunc_id))
+		return 0;
+
+	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
+	    prog->aux->st_ops != &bpf_tcp_ops)
+		return -EACCES;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_tcp_ops_set_flags_kfunc_id_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_tcp_ops_set_flags_kfunc_set,
+	.filter = bpf_tcp_ops_set_flags_kfunc_filter,
+};
+
 static int __init __bpf_tcp_ops_init(void)
 {
-	return register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&bpf_tcp_ops_set_flags_kfunc_id_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT,
+					       &bpf_tcp_ops_set_flags_kfunc_id_set);
+	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_ops, bpf_tcp_ops);
+
+	return ret;
 }
+
 late_initcall(__bpf_tcp_ops_init);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 650a2e89950a..fa69961c47d3 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -5217,6 +5217,9 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, lost_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, sacked_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, scaling_ratio);
+#ifdef CONFIG_BPF
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, bpf_tcp_ops_flags);
+#endif
 
 	/* RX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, copied_seq);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4687c3310996..6ff90b73dd38 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7334,6 +7334,14 @@ enum {
 					 */
 };
 
+enum {
+	BPF_TCP_OPS_FLAG_RTT			= (1 << 0),
+	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_ALL	= (1 << 1),
+	BPF_TCP_OPS_FLAG_PARSE_HDR_OPT_UNKNOWN	= (1 << 2),
+	BPF_TCP_OPS_FLAG_WRITE_HDR_OPT		= (1 << 3),
+	BPF_TCP_OPS_FLAG_ALL			= (1 << 4) - 1,
+};
+
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
  * changes between the TCP and BPF versions. Ideally this should never happen.
  * If it does, we need to add code to convert them before calling
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

