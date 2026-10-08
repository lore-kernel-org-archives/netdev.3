Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA3381EA7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791429380; cv=none; b=SAbPtD2qfcAM6J3ozMwPvwQQm5dMeFV+Wo85oD+2hx7un3fyf8muo4mE7kxtHSMpXIug4Kzeh1g+KEQ4cSx2nmB94QhkGMKUgoFJrD2k2zV3NTn2L1a7aA27+rC7am98P62gnj2vo3ZGTp+uByxPwCb+57CZnk1QPGcrv+RDNf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791429380; c=relaxed/simple;
	bh=YrUW6Gz9HDb0fb4ytIL2HYIdj/R8a7zCocOQr4l4l5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iY4CnmKPhUhAAbg3/IgEk6VJ/KyZd3Y9/97f93ivO4zIF+wu5kmC2Gg1zVGLAG2BtRVUFn07k87JB1yW9NAQJlvho8j4biitnnZN5H62cLkYKe2ba0aWJzYz9/Ze0a59ar0Rq9HA/jg3YGLqA7eKv6B9sji/7G39MG470mYH6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=geUzG7H5; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geUzG7H5"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cca35cf9f77so3076865a12.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791429371; x=1792034171; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATxs/uFnhVurrsu+Fu5hr+7fyIusGS2GK8sSQhK6jpA=;
        b=geUzG7H5cp/ghHMhAXDzaihJdUl/zMfkY7pfthVAZ+VnaZOmTGAvCswSJG79LSGr4L
         lrZNL6MitaM8ORQ65x+csOWPagojM88u7/dJnpJjn+OuH5jE6zQrHq9KStoNyxa4uZCr
         am/o4QDZX6juTVcDQ1jga6G6Ev55CMC9GvDl3ldxRVEE67PSTFu9+vbhpDFFR5nk1F3n
         YUvHEV5LWYFG2d6RfVnYyh/ESMgj6AsvnkIuhWTtRmVG8XJhzLqJAPRy4mGtLAdKMzTt
         hCV4ML88PfKHHC/CIjF6JuZBrtpwIm/JPIbE+gxIizxR8BSBav4B+HJg9uHcoTw40OZ5
         uvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791429371; x=1792034171;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATxs/uFnhVurrsu+Fu5hr+7fyIusGS2GK8sSQhK6jpA=;
        b=uvnTehG8ffLIKjuO8WPF53sRgszIEWKq+N9n1wlE5evD8Up5sqo1xDqsfLKKzC+dLB
         Oi+paMRZeAJgc8tgyiTBgl1wiGVNqYvCiMmwXIcBudlQ+k347pkFVQVuaupSRY0digDI
         1lrVxWUDOg1J7Lwt6Hyc+MJYga9vdIfmMQZAgtgjIes6ZbJIttT4SAmMgE5uAoo61xqV
         9ljxpKWjql9glfNjhZbHErhijhPuJ4nFnIaFLmCONoxf0lMFKOIIizNbkBUUlzepOF12
         Kn+IcH0OnRu+Y7GkfmjWjoeKduOjPDYh4FNT+H/rtZCos94RX6qwMQqqyg6jI5rJVm6Z
         RrTw==
X-Forwarded-Encrypted: i=1; AKwUvBybFSB2Ll71RtskgoOzy6WiZgWFHBJSDjOJ92azSeXryNOl3yrW8IZUt4kgQxcqqMwvb3KPz60=@vger.kernel.org
X-Gm-Message-State: AFuF++nKrK52CWkQRPBe9DAx+++9zEFtJKJQHmOqVWPM0ONsqFeyxjEx
	6QbdIycPyGgO9CPGLEfGOYKMjpTNaQ6dtq5HiB73fWamKCsn/agP/3Qo8TPdELW0+5MS9IJ7RXH
	Utjqk7Q==
X-Received: from pgbj19-n1.prod.google.com ([2002:a05:6a02:61d3:10b0:ccf:5b57:433b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9183:b0:3de:94b:7e68
 with SMTP id adf61e73a8af0-3e133da852fmr3455069637.8.1791429370980; Wed, 07
 Oct 2026 20:16:10 -0700 (PDT)
Date: Thu,  8 Oct 2026 03:15:25 +0000
In-Reply-To: <20261008031604.256498-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261008031604.256498-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008031604.256498-6-kuniyu@google.com>
Subject: [PATCH v5 bpf-next 05/10] bpf: tcp: Check BPF_SOCK_OPS_TEST_FLAG()
 after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
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

BPF_CGROUP_RUN_PROG_XXX() macros guard __cgroup_bpf_run_filter_XXX()
with cgroup_bpf_enabled().

However, even when no SOCK_OPS prog is attached, callers still
initialise struct bpf_sock_ops_kern (memset(), etc.) or evaluate
BPF_SOCK_OPS_TEST_FLAG(), which loads tp->bpf_sock_ops_cb_flags
from a cold cacheline near the end of struct tcp_sock.

Similar to bpf_tcp_ops, let's check cgroup_bpf_enabled() before
BPF_SOCK_OPS_TEST_FLAG() and struct bpf_sock_ops_kern setup, and
rename BPF_CGROUP_RUN_PROG_SOCK_OPS{,_SK}() with __ prefix.

Since all direct callers of tcp_call_bpf() pass 0 and NULL for
nargs and args, they can be folded into the new tcp_call_bpf()
macro.

All callers of tcp_call_bpf_{2,3}arg() check BPF_SOCK_OPS_TEST_FLAG()
and do not need the return value.  These are replaced with the new
tcp_call_bpf_flag() macro.

Now, bpf_skops_hdr_opt_len() and bpf_tcp_ops_hdr_opt_len() are
just NOPs without bpf prog attached.

  $ llvm-objdump -S -D --disassemble=tcp_established_options vmlinux
  ...
  ; 	asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
>>ffffffff825127e6: 66 90                	nop
>>ffffffff825127e8: 66 90                	nop
  ; 	size = MAX_TCP_OPTION_SPACE - remaining;
  ffffffff825127ea: b9 28 00 00 00       	movl	$0x28, %ecx
  ffffffff825127ef: 29 c1                	subl	%eax, %ecx
  ; 	return size;
  ffffffff825127f1: 89 c8                	movl	%ecx, %eax
  ...
  ffffffff825127fb: 2e e9 6f 02 43 00    	jmp	0xffffffff82942a70 <__x86_return_thunk>

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v5: Always inline static key to tcp_established_options()
---
 include/linux/bpf-cgroup.h | 36 ++++++++++--------------
 include/net/tcp.h          | 56 ++++++++++++++++----------------------
 net/ipv4/af_inet.c         |  2 +-
 net/ipv4/tcp.c             |  3 +-
 net/ipv4/tcp_input.c       | 21 ++++++++------
 net/ipv4/tcp_nv.c          |  2 +-
 net/ipv4/tcp_output.c      | 36 ++++++++++--------------
 net/ipv4/tcp_timer.c       |  6 ++--
 8 files changed, 70 insertions(+), 92 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 8a75a6cd7309..02ef7f899b3d 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -345,27 +345,19 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
  * calling bpf_setsockopt on listener-sk will not make sense anyway,
  * so passing 'sock_ops->sk == req_sk' to the bpf prog is appropriate here.
  */
-#define BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(sock_ops, sk)			\
-({									\
-	int __ret = 0;							\
-	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS))			\
-		__ret = __cgroup_bpf_run_filter_sock_ops(sk,		\
-							 sock_ops,	\
-							 CGROUP_SOCK_OPS); \
-	__ret;								\
-})
-
-#define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops)				       \
-({									       \
-	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) && (sock_ops)->sk) {       \
-		typeof(sk) __sk = sk_to_full_sk((sock_ops)->sk);	       \
-		if (__sk && sk_fullsock(__sk))				       \
-			__ret = __cgroup_bpf_run_filter_sock_ops(__sk,	       \
-								 sock_ops,     \
-							 CGROUP_SOCK_OPS); \
-	}								       \
-	__ret;								       \
+#define __BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(sock_ops, sk)				\
+	__cgroup_bpf_run_filter_sock_ops(sk, sock_ops,				\
+					 CGROUP_SOCK_OPS)
+
+#define __BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops)				\
+({										\
+	int __ret = 0;								\
+	typeof(sk) __sk = sk_to_full_sk((sock_ops)->sk);			\
+	if (__sk && sk_fullsock(__sk))						\
+		__ret = __cgroup_bpf_run_filter_sock_ops(__sk,			\
+							 sock_ops,		\
+							 CGROUP_SOCK_OPS);	\
+	__ret;									\
 })
 
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access)	      \
@@ -529,7 +521,7 @@ static inline int cgroup_bpf_struct_ops_attach(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_UDP4_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UDP6_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk, uaddr, uaddrlen) ({ 0; })
-#define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
+#define __BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(atype, major, minor, access) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SYSCTL(head,table,write,buf,count,pos) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_GETSOCKOPT(sock, level, optname, optval, \
diff --git a/include/net/tcp.h b/include/net/tcp.h
index b7c0f1a8797a..85b4bfe963d3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2891,7 +2891,7 @@ static inline void bpf_skops_init_skb(struct bpf_sock_ops_kern *skops,
  * program loaded).
  */
 #ifdef CONFIG_BPF
-static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
+static inline int __tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
 	struct bpf_sock_ops_kern sock_ops;
 	int ret;
@@ -2908,7 +2908,7 @@ static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 	if (nargs > 0)
 		memcpy(sock_ops.args, args, nargs * sizeof(*args));
 
-	ret = BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
+	ret = __BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 	if (ret == 0)
 		ret = sock_ops.reply;
 	else
@@ -2916,20 +2916,23 @@ static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 	return ret;
 }
 
-static inline int tcp_call_bpf_2arg(struct sock *sk, int op, u32 arg1, u32 arg2)
-{
-	u32 args[2] = {arg1, arg2};
-
-	return tcp_call_bpf(sk, op, 2, args);
-}
-
-static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
-				    u32 arg3)
-{
-	u32 args[3] = {arg1, arg2, arg3};
+#define tcp_call_bpf(sk, op)						\
+({									\
+	int __ret = 0;							\
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS)) {			\
+		__ret = __tcp_call_bpf(sk, op, 0, NULL);		\
+	}								\
+	__ret;								\
+})
 
-	return tcp_call_bpf(sk, op, 3, args);
-}
+#define tcp_call_bpf_flag(sk, op, ...)					\
+do {									\
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&			\
+	    BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), op ## _FLAG)) {		\
+		u32 __args[] = { __VA_ARGS__ };				\
+		__tcp_call_bpf(sk, op, ARRAY_SIZE(__args), __args);	\
+	}								\
+} while (0)
 
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
@@ -2938,21 +2941,12 @@ static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 }
 
 #else
-static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
-{
-	return -EPERM;
-}
-
-static inline int tcp_call_bpf_2arg(struct sock *sk, int op, u32 arg1, u32 arg2)
+static inline int tcp_call_bpf(struct sock *sk, int op)
 {
 	return -EPERM;
 }
 
-static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
-				    u32 arg3)
-{
-	return -EPERM;
-}
+#define tcp_call_bpf_flag(sk, op, ...) do { } while (0)
 
 static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
 {
@@ -3136,7 +3130,7 @@ static inline u32 tcp_timeout_init(struct sock *sk)
 {
 	int timeout;
 
-	timeout = tcp_call_bpf(sk, BPF_SOCK_OPS_TIMEOUT_INIT, 0, NULL);
+	timeout = tcp_call_bpf(sk, BPF_SOCK_OPS_TIMEOUT_INIT);
 	timeout = bpf_tcp_ops_call_int(timeout_init, timeout, sk);
 	if (timeout <= 0)
 		timeout = TCP_TIMEOUT_INIT;
@@ -3147,7 +3141,7 @@ static inline u32 tcp_rwnd_init_bpf(struct sock *sk)
 {
 	int rwnd;
 
-	rwnd = tcp_call_bpf(sk, BPF_SOCK_OPS_RWND_INIT, 0, NULL);
+	rwnd = tcp_call_bpf(sk, BPF_SOCK_OPS_RWND_INIT);
 	rwnd = bpf_tcp_ops_call_int(rwnd_init, rwnd, sk);
 	if (rwnd < 0)
 		rwnd = 0;
@@ -3156,14 +3150,12 @@ static inline u32 tcp_rwnd_init_bpf(struct sock *sk)
 
 static inline bool tcp_bpf_ca_needs_ecn(struct sock *sk)
 {
-	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN, 0, NULL) == 1);
+	return (tcp_call_bpf(sk, BPF_SOCK_OPS_NEEDS_ECN) == 1);
 }
 
 static inline void tcp_bpf_rtt(struct sock *sk, long mrtt, u32 srtt)
 {
-	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
-		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
-
+	tcp_call_bpf_flag(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
 	bpf_tcp_ops_call_flag(rtt, RTT, sk, mrtt, srtt);
 }
 
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index cdcfc7d3c6d2..035c83338e0f 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -226,7 +226,7 @@ int __inet_listen_sk(struct sock *sk, int backlog)
 		if (err)
 			return err;
 
-		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB, 0, NULL);
+		tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_LISTEN_CB);
 		bpf_tcp_ops_call(listen, sk);
 	}
 	return 0;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index fa69961c47d3..5d9d3bcde8f7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2994,8 +2994,7 @@ void tcp_set_state(struct sock *sk, int state)
 	 */
 	BTF_TYPE_EMIT_ENUM(BPF_TCP_ESTABLISHED);
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_STATE_CB_FLAG))
-		tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_STATE_CB, oldstate, state);
+	tcp_call_bpf_flag(sk, BPF_SOCK_OPS_STATE_CB, oldstate, state);
 	bpf_tcp_ops_call(set_state, sk, state);
 
 	switch (state) {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4478d3f3d4b0..f374257013b1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -146,14 +146,16 @@ EXPORT_SYMBOL_GPL(clean_acked_data_flush);
 #ifdef CONFIG_CGROUP_BPF
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 {
-	bool unknown_opt = tcp_sk(sk)->rx_opt.saw_unknown &&
-		BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
-				       BPF_SOCK_OPS_PARSE_UNKNOWN_HDR_OPT_CB_FLAG);
-	bool parse_all_opt = BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
-						    BPF_SOCK_OPS_PARSE_ALL_HDR_OPT_CB_FLAG);
 	struct bpf_sock_ops_kern sock_ops;
+	const struct tcp_sock *tp;
+
+	if (!cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+		return;
 
-	if (likely(!unknown_opt && !parse_all_opt))
+	tp = tcp_sk(sk);
+	if (!(tp->rx_opt.saw_unknown &&
+	      BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_PARSE_UNKNOWN_HDR_OPT_CB_FLAG)) &&
+	    !BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_PARSE_ALL_HDR_OPT_CB_FLAG))
 		return;
 
 	/* The skb will be handled in the
@@ -176,7 +178,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
 	sock_ops.sk = sk;
 	bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
-	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
+	__BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
 
 static void bpf_skops_established(struct sock *sk, int bpf_op,
@@ -184,6 +186,9 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 {
 	struct bpf_sock_ops_kern sock_ops;
 
+	if (!cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+		return;
+
 	sock_owned_by_me(sk);
 
 	memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
@@ -195,7 +200,7 @@ static void bpf_skops_established(struct sock *sk, int bpf_op,
 	if (skb)
 		bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
 
-	BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
+	__BPF_CGROUP_RUN_PROG_SOCK_OPS(&sock_ops);
 }
 #else
 static void bpf_skops_parse_hdr(struct sock *sk, struct sk_buff *skb)
diff --git a/net/ipv4/tcp_nv.c b/net/ipv4/tcp_nv.c
index f345897a68df..7b0dae23d9aa 100644
--- a/net/ipv4/tcp_nv.c
+++ b/net/ipv4/tcp_nv.c
@@ -146,7 +146,7 @@ static void tcpnv_init(struct sock *sk)
 	 * within a datacenter, where we have reasonable estimates of
 	 * RTTs
 	 */
-	base_rtt = tcp_call_bpf(sk, BPF_SOCK_OPS_BASE_RTT, 0, NULL);
+	base_rtt = tcp_call_bpf(sk, BPF_SOCK_OPS_BASE_RTT);
 	if (base_rtt > 0) {
 		ca->nv_base_rtt = base_rtt;
 		ca->nv_lower_bound_rtt = (base_rtt * 205) >> 8; /* 80% */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 313dfe70a386..d4ee359d36d0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -476,8 +476,8 @@ static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 	struct bpf_sock_ops_kern sock_ops;
 	int err;
 
-	if (likely(!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
-					   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) ||
+	if (!BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
+				    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG) ||
 	    !remaining)
 		return remaining;
 
@@ -518,7 +518,7 @@ static u32 bpf_skops_hdr_opt_len(struct sock *sk, struct sk_buff *skb,
 	if (skb)
 		bpf_skops_init_skb(&sock_ops, skb, 0);
 
-	err = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
+	err = __BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
 
 	if (err || sock_ops.remaining_opt_len == remaining)
 		return remaining;
@@ -543,7 +543,8 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 
 	first_opt_off = tcp_hdrlen(skb) - max_opt_len;
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
+	    BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk),
 				   BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG)) {
 		struct bpf_sock_ops_kern sock_ops;
 		int err;
@@ -567,7 +568,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk, struct sk_buff *skb,
 		sock_ops.remaining_opt_len = max_opt_len;
 		bpf_skops_init_skb(&sock_ops, skb, first_opt_off);
 
-		err = BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
+		err = __BPF_CGROUP_RUN_PROG_SOCK_OPS_SK(&sock_ops, sk);
 		if (!err)
 			nr_written = max_opt_len - sock_ops.remaining_opt_len;
 	}
@@ -638,6 +639,11 @@ static __always_inline u32 tcp_bpf_hdr_opt_len(struct sock *sk, struct sk_buff *
 					       struct tcp_out_options *opts,
 					       u32 remaining)
 {
+	if (cgroup_bpf_enabled(CGROUP_SOCK_OPS))
+		remaining = bpf_skops_hdr_opt_len(sk, skb, req, syn_skb,
+						  synack_type, opts,
+						  remaining);
+
 	if (cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS))
 		remaining = bpf_tcp_ops_hdr_opt_len(sk, skb, req, syn_skb,
 						    synack_type, opts,
@@ -1103,8 +1109,6 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
 
-	remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
-					  remaining);
 	remaining = tcp_bpf_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
 					remaining);
 
@@ -1193,8 +1197,6 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
 
-	remaining = bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
-					  synack_type, opts, remaining);
 	remaining = tcp_bpf_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
 					synack_type, opts, remaining);
 
@@ -1293,15 +1295,6 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		}
 	}
 
-	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
-					    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
-		remaining = MAX_TCP_OPTION_SPACE - size;
-		remaining = bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
-						  remaining);
-
-		size = MAX_TCP_OPTION_SPACE - remaining;
-	}
-
 	remaining = tcp_bpf_hdr_opt_len(sk, skb, NULL, NULL, 0, opts,
 					MAX_TCP_OPTION_SPACE - size);
 
@@ -3738,9 +3731,8 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 		err = tcp_transmit_skb(sk, skb, 1, GFP_ATOMIC);
 	}
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RETRANS_CB_FLAG))
-		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RETRANS_CB,
-				  TCP_SKB_CB(skb)->seq, segs, err);
+	tcp_call_bpf_flag(sk, BPF_SOCK_OPS_RETRANS_CB,
+			  TCP_SKB_CB(skb)->seq, segs, err);
 	bpf_tcp_ops_call(retrans, sk, skb, err);
 
 	if (unlikely(err) && err != -EBUSY)
@@ -4368,7 +4360,7 @@ int tcp_connect(struct sock *sk)
 	struct sk_buff *buff;
 	int err;
 
-	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB, 0, NULL);
+	tcp_call_bpf(sk, BPF_SOCK_OPS_TCP_CONNECT_CB);
 	bpf_tcp_ops_call(connect, sk);
 
 #if defined(CONFIG_TCP_MD5SIG) && defined(CONFIG_TCP_AO)
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 3d49adc51766..00debcba122b 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -286,10 +286,8 @@ static int tcp_write_timeout(struct sock *sk)
 	tcp_fastopen_active_detect_blackhole(sk, expired);
 	mptcp_active_detect_blackhole(sk, expired);
 
-	if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_RTO_CB_FLAG))
-		tcp_call_bpf_3arg(sk, BPF_SOCK_OPS_RTO_CB,
-				  icsk->icsk_retransmits,
-				  icsk->icsk_rto, (int)expired);
+	tcp_call_bpf_flag(sk, BPF_SOCK_OPS_RTO_CB,
+			  icsk->icsk_retransmits, icsk->icsk_rto, (int)expired);
 	bpf_tcp_ops_call(rto, sk);
 
 	if (expired) {
-- 
2.56.0.360.g66cac248cb-goog

