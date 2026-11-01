Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560904;
	b=4rhuKA7lQGJyVAmIqiRxjBm/a6QWlf82cXrgiMo43y1pftHYWIIbkrW/JuejxA8wlaWG
	 hjNzQVny44MTgjm1D8zHags7m1O06fla86AV5x9fhZMPtJRu5NXtyqK1S9kAxzWGrEgPs
	 zpZspZ7akbK85IftjjhMmQGH2SArg0bk50qZyaQwjPK5BiFuFjolglvpLXmvKxuUG/F1i
	 fRe6+0edcighaEAbBdr4HfG3WYdUH8vrcFys5eDeOK/BV5KUW+XoZ3y/FMbKRDihzUXmn
	 cGVN+577EZzkkLx6qDqO//ZGpToRl2Ia96pl9heLwySGI+xhwBmg2WkVbZbiWEsRx8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SzMjUS+/JylIFqehNQ/NUtqKceY36ervniTve9Rd0yE=;
	b=yDs0NeBQqZSLVRBl7rQ1KTAE6IE0ngQYcGGELDwhepnb80IKwJVZzk8/fst3eopUy8xu
	 zHe0Cj8lRZCUdGNDKK0xHRrgTrmSF0bd7WmS1lGt6/PnSjlxYRRcIHs63GwhG+uvvmVbl
	 HcA5Y9T2EXllwaxj/uc13UY+99pqf6n+Rn4fXbUyioB864hZQj/g5VJtIeGQYw+0hCHlx
	 NOPn55xPpLSW2JOzfhYm/bVjb2q91fUkINOwiRObDdwInXQ5MuEf+XvquHWQU654NN+pP
	 nRMdPDxB+GAWQwZEm+GjPRtxw6p2U29nDmycgqlbt3qqSrgV4wbwFr8qoyOCLsDs0wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSgROHw9;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FABE606A329
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 19:21:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FABE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSgROHw9
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso1384219a91.1
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 11:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793560904; x=1794165704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzMjUS+/JylIFqehNQ/NUtqKceY36ervniTve9Rd0yE=;
        b=ZSgROHw9aXybdC9AvxaM0B5aDD1dANvb1oT0epfbMui/6C+0gkwf//63wGzwnDab7F
         cnH/oaD4HSpsUAmFXGzF0xvbCdFh0TyEGNO1kS+8HVeJH/jsf5+0zzRavr47VHewdj6D
         Mcw29PmsOY2mxnei/XpHPWXDhWsiqm3H0DFXzLHL1v5r2Oorg/lstYVEFCJBH5lHcLM3
         yjmGSkAnjcViM2cqwn1/bh6lnJOdXcxqGQyRbq+xgkcoK4QvrvXVnl1VUKj03CWBDX1o
         KJMk+XcDCHhRih4s+B4hIynETrtoDD19cY/zr1Pr0BWL8I2YvUwAfEUHj5mD6pwTEvLu
         B18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560904; x=1794165704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzMjUS+/JylIFqehNQ/NUtqKceY36ervniTve9Rd0yE=;
        b=TDiIlytiXCf7e0NMoptlR8gxK1/b0hn7TRi4FXVcgl2MxbmbqY3dtgNuvx7DpoRJG9
         ouBPPNio5xeovUf1D4bG1hOnB7hMiL7utluys+QKJjzNRCUVx9H3Sd9Oc8yPgMxOQ+/R
         zS6h8qwi+PNoRvdwoG6+zKFYur+elATouSKJloOHuaPagdaCsVM3gRJhYBLLbruAQQUH
         Wr3ESIDjoNXYBNl9j7WfHPRbXbGFlj8Xq994QUSL1aoJVBgOp9T9W/kwiawLOQEa9slf
         wFtckbe0VdnXVaXL8N06TYkx06MHIjzAoCtEYxSkFDquveghDHpqUAs3X/Wmgi7PMirN
         GCmw==
X-Forwarded-Encrypted: i=1; AKwUvBx2rJ8o7mYTnTVcMcYzluFwYIDYQTV02BIElA6t86cdAMkD5DVC5g15yup+zwJ8KYCnhQeAN8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ALzimZM+C+YY+w7E7QoBv+FqvBEHUVcG6txeEnU4xDzSj+pdq
	4zf1RNpArM7w1fygTNK47Xce1gzt6bhfnbTp50RrMncnIwfg4d6avQcz
X-Gm-Gg: AYBFou2QYaahs4haK4z/S7CoaTTbtOvVc/W6GmmIKgaz8hJpHz9wYmIG9jlmluhO87B
	B64nc08QSCB0f7jv3q/vnoKoAP+AVucjTxR/FzG/8lvekoD8K/VuMYN/Xu/oYuqXfcy5CzqbHNa
	1jZi/XaydTocq/4CS2JQR0D93ZqxX3BLIBL81D88tJnExRuO8qBNUEyzI7/DYRPUE8NSB4UM2EE
	mLnyt6BLl6exFcFBAdUIPAmE3SpjJQ3YLemRB+RegCuGVymBkA7noRLnrwdz+bMghu4fFQsfxha
	jmosKf/ok0b2CYC9ZitsQU3WrCMcHoLPGUh/OpcD9FaKt5yR5Hxew1LQMPEe7zYUyPsDwVUo6Vs
	GYye56QCk3QPo+y2TMR2rEY3faZueSns1InF1g7miA3O7da5YRjbhcuHydwm7ZWeiL47TVIO+hm
	dMatc/jYKxNR9XXJVh7mcElYWyykvtVgBtmMZRzTCY+wyb8a01c/1cXEKC75IE7Mr9REQJJLq+8
	m3wXXwIQfco6VUxwvd6BNetXCrRupmQYtYxZP7fS86O3rTt8i9y1aiWUn0JyCrXHJ0mBsNjoTNu
	NTL1R6Ke5Y8bsX5wFw1At8sageFqDXr/by02WrVm3uQ5oNzKFpl9FK6z/4fOmUTz29Vec6ToqsB
	K2PfACpcS2SYuA0Bhvui9TjdizHMB5Kh+pV9AXHitXJhDvOZVsIEmb5CmuitoOidRLgqOa4e1ag
	==
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae89776af6mr6425348a91.11.1793560903588;
        Sun, 01 Nov 2026 11:21:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85cb1bfdsm7009849a91.0.2026.11.01.11.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:21:43 -0800 (PST)
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
Subject: [PATCH bpf 07/15] bpf, sockmap: Check the target of an egress redirect before each send
Date: Sun,  1 Nov 2026 19:20:49 +0000
Message-ID: <20261101192057.2296489-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-1-alexei.starovoitov@gmail.com>
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
index aa904ded816f..b635d3ebf4fb 100644
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
@@ -547,7 +569,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
 	int flags;
 
 	/* Don't let internal flags through */
-	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
+	flags = (msg->msg_flags & ~(MSG_SENDPAGE_DECRYPTED | MSG_FASTOPEN));
 	flags |= MSG_NO_SHARED_FRAGS;
 
 	psock = sk_psock_get(sk);
-- 
2.55.0

