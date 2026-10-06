Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639DA4AC179
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 19:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791314787; cv=none; b=Qw4W88ZZH4gjG5uIeotbgZIOqs6ForHWYiWff5DOvg9PA/9T/oNz6uIqkCpJfbExxK6sCZSZNn5HgkMoRoeJgvOWxNsreMOM4dK/rRlVcmkzYvvgckWioKpJ6l2vwevKRoh6y0bM+xwy77NwivikXmv+89FqSdvRO14Db7SIgEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791314787; c=relaxed/simple;
	bh=MJqgr57ELokDQWmXxV95wtW+a49RJ00N5RMj5CD/2oc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=suaVnIrH7iqujD8tD/BjE8V8Bdfz8pnk5e3OwljoWsXrw+AdQ8ugpi4wf7MUj8obgYN0niVhFWhO5jRpdMUn8KERt9TUHAlHWkHsH3wnfnpTaRXMvsHV6D4tvLNFs+5niNfKL/TtfMqwrHpGtCxEhyjqucAwfE8f8OjFxmCoLKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cA/Ul0ag; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cA/Ul0ag"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3a8041a532eso2139610a91.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791314786; x=1791919586; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDBsqEpx31BlKi+YYL6XnghEfDEsuIskSkT8P7QiPEc=;
        b=cA/Ul0agBBkn8QCsiRicYvWgE6gHZuifIUMmDid7Bt8UsMeWgwSchUIbth1a/YdabT
         KfC1n9NKwCYRC05f66rZipeDr3viEKRhrS8ZtTBtsXR0deZxSIWDT+xNPkBByKa5YNGl
         pBBg3dWpny8fIBOKsjjZoUlOCFel+ujuKw9CzNbaDagsfEGGXnZbhhp1EuEcVqFMn8YO
         wgd2rtZ55i29y99aycTWmy4IEATllLIkQTMSc9yp9bqOzXDdmC8JyvgTHV8dVBSIc6Tk
         YnvkchPRiZ55UuRXoLaEIaX8UocTtYNSo2pKS9yw4pNtU565d1MSySJwrhlz7stYhFBW
         KEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791314786; x=1791919586;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kDBsqEpx31BlKi+YYL6XnghEfDEsuIskSkT8P7QiPEc=;
        b=WnDowCyH+Bgd3UroBCFZz7zgFU1ySrXqbY7tqwOhWRDj9+6tL2EF1jLyufrdvrTHkL
         s8PCMfwbW02JDO6YhQwsFsaO8Sf25SwbAZrKhZxRg1AxpxIPzHqGkBMyZ7dTcnguRSVY
         xXt0le5c8fLmEgus+kuHgu/mmxMJW2LBgyZSgqxlzv0S13uftANme4E6SKPLctt1MiGy
         Ew/ll0RTxiWsRJrJAq6Y1+ActmDDNBWEBzEzySvaiwz/eI4KWKDkzdK/vcq50F2nyIKW
         J/lnJr/qR97B9QyF5Qm/pih9OCPJEtNHS0KYBl+UUtitbmmqWUpPdUaGxKGb8N37+qhK
         xdDw==
X-Forwarded-Encrypted: i=1; AKwUvBzsM5meGS80EnAqIW4nzDEOaNmgqnh/3U7HMQx5GpCUnNhJhEF9/G94TfHN9F3EN0WgwrYB84E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLTxhUXSJjn1ZD8KRrJ5ySH3vGFcUQE50W7oxN6Sa7vlz7TVHTP
	esmpRMVz8+M6d/mBwXYNVt0GG3+qJGL8JghNt5NpcmGk6PJuZ9sM8NcQPu5w1dSamoWn0SYlRLA
	oKP8Tow==
X-Received: from plbjd19.prod.google.com ([2002:a17:903:2613:b0:2df:382a:15b2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5830:b0:3a0:a912:e759
 with SMTP id 98e67ed59e1d1-3a8a1bd906bmr128805a91.25.1791314785587; Tue, 06
 Oct 2026 12:26:25 -0700 (PDT)
Date: Tue,  6 Oct 2026 19:24:33 +0000
In-Reply-To: <20261006192601.1875100-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261006192601.1875100-8-kuniyu@google.com>
Subject: [PATCH v4 bpf-next 07/10] tcp: Split out __tcp_set_rcvlowat().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Amery Hung <ameryhung@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

We will add a kfunc for bpf_tcp_ops.{enqueue,dequeue}_rcvq()
to adjust sk->sk_rcvlowat.

These hooks are triggered

  * when the TCP stack enqueues an skb to sk->sk_receive_queue
  * after data is dequeued from sk->sk_receive_queue

In the enqueue path, tcp_data_ready() is always called after
the hooks in tcp_queue_rcv() and tcp_ofo_queue().

If tcp_set_rcvlowat() were used as is, tcp_data_ready() could
be called twice for the same skb, which is redundant and also
confusing.

Let's split out __tcp_set_rcvlowat() and add a flag to control
wakeup behaviour.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/net/tcp.h |  1 +
 net/ipv4/tcp.c    | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d95cbe4da96e..f7624ab9b420 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -512,6 +512,7 @@ void tcp_set_keepalive(struct sock *sk, int val);
 void tcp_syn_ack_timeout(const struct request_sock *req);
 int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		int flags);
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup);
 int tcp_set_rcvlowat(struct sock *sk, int val);
 void tcp_set_rcvbuf(struct sock *sk, int val);
 int tcp_set_window_clamp(struct sock *sk, int val);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5d907a0a0461..c3c756a1ba8c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1827,8 +1827,7 @@ int tcp_peek_len(struct socket *sock)
 	return tcp_inq(sock->sk);
 }
 
-/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
-int tcp_set_rcvlowat(struct sock *sk, int val)
+int __tcp_set_rcvlowat(struct sock *sk, int val, bool wakeup)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int space, cap;
@@ -1841,7 +1840,8 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	WRITE_ONCE(sk->sk_rcvlowat, val ? : 1);
 
 	/* Check if we need to signal EPOLLIN right now */
-	tcp_data_ready(sk);
+	if (wakeup)
+		tcp_data_ready(sk);
 
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		return 0;
@@ -1856,6 +1856,12 @@ int tcp_set_rcvlowat(struct sock *sk, int val)
 	return 0;
 }
 
+/* Make sure sk_rcvbuf is big enough to satisfy SO_RCVLOWAT hint */
+int tcp_set_rcvlowat(struct sock *sk, int val)
+{
+	return __tcp_set_rcvlowat(sk, val, true);
+}
+
 void tcp_set_rcvbuf(struct sock *sk, int val)
 {
 	tcp_set_window_clamp(sk, tcp_win_from_space(sk, val));
-- 
2.56.0.360.g66cac248cb-goog

