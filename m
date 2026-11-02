Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604124;
	b=SNHoTpEMKheP4LgFEphZ1qPofXQbEutbrEe4CNosGAQEsSvhavXHZW4V0KtKyPHqJeAj
	 SDY/zZFXRx/uCbDAIdO++k8nB0lbrk5m+US3k3kCGTYWFWOA6/ax/Hz6iBMAgNA9jw70C
	 sPzr+SOxYjy6SEzomE2HlgyyRXEGHCKUPPqHUS2iT662DLhNDMgAJY2OwydoPnji1Io2h
	 clhd4xj4Nwrx20mnG56Tfz+6dI4pQqMlj3zAv9fwPPERCc+5m2WqngLYqcpQRw0wi9LJv
	 VHgAbUiSPXRg4qILWZgH+17qD3EYhei7Ez9RqxmyLMHTrF/tlom+i5xdjaGqbAT2jHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D4eYPuLg3xUyB1bWOTJ4iSiQffpGBEZKMs2NiPHXGTk=;
	b=dTNxTQfwpn8vjkGMd/Fuh76ZsmJn8M+JozWSoYc/s8GmX1cpNbyHJ3D+em3CvLC54kp4
	 wE7PuY3iiBP69tyNGM2NZZV0CUXTXLtTq856b0WKL6VcYRrEOuxKLQuk3fdjupTboOAXD
	 S6jkXengrrCx6LYzvvYUazcKRQVWy1equ3BcB5tleS1kfj7B8VMh63A7LPDX4L8cwNo/2
	 TNLIcCoTTUqgcMGB0+NrknCeb76gPWkUoIlhvgB0czRCGN90a+ZArnejyXvaE0cVNjBrW
	 sY4p7QGPoWWOUWlGTCtjsnux7lmGkB05hYHLR+gNbDP5VLk6lF0qRnx1sgcXuK3ru2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPVJmKNs;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1908606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:22:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1908606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HPVJmKNs
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1355342a91.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604123; x=1794208923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4eYPuLg3xUyB1bWOTJ4iSiQffpGBEZKMs2NiPHXGTk=;
        b=HPVJmKNsgv1fBBRAUjASfLuczKhHW4q2StzVaTdk400aqKf/Cm1HkMNrMPHza+CuVD
         ZapWaU06oawTXkx0vD4p/ltyf4YgiLRPAa1C6QWUcFHOroApVDu9cUPbpHLwj8ATb6xA
         q1hXA4PnLmRVUYUOzn14jDZeqD5KcDNEVGE1iKMU9uYOUU2HzuaLz4R3bA/7dLkmNbWr
         FRhz6VbA/oTxyYSQUhoaCs2YPTz7NB/GIIlxKeOoK8AkDdaR10rDeicRZqT9evJUKbO5
         /YnUGDJENkA3FQUlFOr0KtzhM2+Q6ZO314VMFssTs1FuJ17gk6qjI6r9VT+Z/urObLWN
         Qt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604123; x=1794208923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4eYPuLg3xUyB1bWOTJ4iSiQffpGBEZKMs2NiPHXGTk=;
        b=e1680F+avneliB4eQc25N9yUqGfSZqzWLVGg7bFRDonsicuY5jHGh9UfC3+Nh8/1v0
         Nn2RMc1lQGlTrLkw305IJyBBpT64Qt2+lnAe0ibHw8oZ3yARTMAiufSH0No476XrWcqp
         owt1Cq9n6rn2yYYLOg8RbjlozsMu/k2mqOXOuLsSfFDeepauL5m68TMXj5LVv7HO7JJ6
         LvSDdrVAhOkN1ASpw9IvNWBHG0teqOkwOpOQly/Do7hDW1G0AUHfgk3NnUdAG5FEVQgA
         kEn3TwtHYfbh8r7giXSA9vWsTcU7W/fjd0IQmuVYdFa+PFgZIMpfMfyYY3IFmhcfy6Lp
         RmYw==
X-Forwarded-Encrypted: i=1; AKwUvBx/BdAwv0ALatrQObQMm5CP12TXrOJi4hf8HwbTCKVGgIgBcSssek5WchyYMBj/t+uTNnkd+HI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tp596Is7kO4+Y+XhnMe/+t50KeM4vzkbVvWjHJsqc+eMR7CbY
	FRYXoo+M8Rr67K9yC2TW/HvJegnV3hVWq1ZVY/5y114HKlKQPTNjhZwp
X-Gm-Gg: AYBFou0PmWi0VVldv3TpoUL6B7MUua48ligSDroiB0ZsKYDT+cdpGD5WyzgYgf9BoFc
	7loxzG2xVviDTEdFmoKwMjYw7M0GXgBY97lihZQkMpgaZIibkxjWemsm3X3ucn63lobikETDsas
	BM/5kru9PCLL4bU7Cj3GkC9N2/MopCsCAsiTSsTo27tM9KUbTnz/UsjhG5rbWBktGfmkQuosPjU
	bEeu4LjRFqC9ppIPdOUxvIuvQo5Q35LXDGYlKJprshQKbMmPfXXasIQLA0yY2AlN459LCbUAtW5
	vD9lQyAOQxyK6KYdwkY+bfsSHzr6QKZQk7x53zoaRvrXmWc00PahaqNTi9bg3PTLclzKfM3dNwn
	BNhL2YDGRoIQbjqgbHD1HiCu3Uu7/xZLgzbM2jyenZT/yn1m5dBFnRDVa5Mv9CHkZAZ5NLmVzNh
	YqjfyQu+22PZTJD6V9cEY83zexqGG/wgLAaB1WvDjcA1CZPuBSmofzfn+MhIwvrJPmJfmhG8XVG
	IjyQLhysqA46rCQPX9aWoXLwXFvZupyvqiPTvISvplDLJmeAG76lmVWs4xkOkLp5omQhOh93d3Y
	QDEneVjzW4BSxjlRjuep1n4syn5ZST4ffiUCdQ0BKkcipwbQ9RMq40EKn9Cmq6HtX9yzPk15t8x
	yi99eqXXK+in1c25pUejZC1KJeDzhPbTjwHqyive6fvY0sGwC2EBJOrEJZyj9+fhBxmWdGtUC7W
	A=
X-Received: by 2002:a17:90b:4f42:b0:3ac:a521:953 with SMTP id 98e67ed59e1d1-3ae897c777fmr7064360a91.46.1793604122783;
        Sun, 01 Nov 2026 23:22:02 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e944ba9sm17487309a91.8.2026.11.01.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:22:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an egress redirect before each send
Date: Mon,  2 Nov 2026 07:21:04 +0000
Message-ID: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Chris Mason <mason@kernel.org>

tcp_sendmsg_locked() expects a caller that has the socket open. It uses
sk->sk_socket and the wait queue sk->sk_wq. For an egress redirect of an
sk_msg prog the sender calls it on the target without a reference to the
target's file. Both pointers are NULL before accept() and after close().
close() can occur while the sender sleeps. Then the kernel crashes.

Fail the redirect when the target has no struct socket, or when the sender
has to wait for the connection. The error is EINVAL. After close() it is
EPIPE, as today. sk_stream_wait_connect() calls remove_wait_queue() without
a test of SOCK_DEAD. sk_stream_wait_memory() has this test, but it can
still use sk_wq after the sleep. This patch does not change that. The
target can change while the sender sleeps there. Thus do both checks before
each call of tcp_sendmsg_locked(). Clear MSG_FASTOPEN, so that the sender
does not call the connect code of the target, which uses both pointers.

Today the sender can send before accept() and waits in SYN_SENT. send()
with MSG_FASTOPEN sends the data. Today it fails with EISCONN. When the
redirect of a cork fails, send() returns success and the kernel drops the
data, as today.

The Fixes tags are for the two checks and for MSG_FASTOPEN, in this order.

Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
Fixes: b8b8315e39ff ("bpf, sockmap: Remove unhash handler for BPF sockmap usage")
Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index fd443350f9b8..ef2e15de0fe3 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -88,6 +88,24 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
 	return ret;
 }
 
+/*
+ * The target of a redirect belongs to somebody else. A child that nobody has
+ * accepted yet, and an orphan, have no struct socket and no wait queue.
+ * tcp_sendmsg_locked() needs both. See sendmsg_locked() in skbuff.c.
+ * The sender holds no reference to the file of the target, which can be closed
+ * whenever tcp_sendmsg_locked() sleeps. sk_stream_wait_connect() and
+ * inet_wait_for_connect() go back to the wait queue when they wake up, so the
+ * sender must not wait for a connect.
+ */
+static bool tcp_bpf_redir_allowed(const struct sock *sk)
+{
+	if (!sk->sk_socket)
+		return false;
+	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
+		return tcp_passive_fastopen(sk);
+	return true;
+}
+
 static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 			int flags, bool uncharge)
 {
@@ -109,6 +127,10 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		page = sg_page(sge);
 
 retry:
+		/* Only a redirect sends data which is not charged to sk */
+		if (!uncharge && unlikely(!tcp_bpf_redir_allowed(sk)))
+			return sock_flag(sk, SOCK_DEAD) ? -EPIPE : -EINVAL;
+
 		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
 		if (has_tx_ulp)
@@ -555,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int flags;
 
 	/* Don't let internal flags through */
-	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
+	flags = (msg->msg_flags & ~(MSG_SENDPAGE_DECRYPTED | MSG_FASTOPEN));
 	flags |= MSG_NO_SHARED_FRAGS;
 
 	psock = sk_psock_get(sk);
-- 
2.55.0

