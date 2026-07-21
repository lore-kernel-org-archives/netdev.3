Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A073DDB03
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784673507; cv=none; b=V7ISD4rrKPU0AVGVHcyp6vn1YNoRlHRfaJ52g2V5S8FcgX9+S8RzFu6felVy5lx6g0Ykh5cUGjG1ZQfSw5q7RPpBcvgZ61gh0kkchXr6JdEbAHombdZFEtFK45XqQtX2eI/BG0OUYqmvsUpMiY3Lk/Eb5nIsPgGEhW8/FncVqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784673507; c=relaxed/simple;
	bh=uQ+F/GDx2k+rZa43OcCjQHAPPId7y4rF1PfHE0gi9Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieR512Y52wRUq8A7c6xn3NCE6VSwb/6suKncZDKxTk1zCgcUUxGmtbKVEF4zw7VeaOTEo02gbQqHsi07RXKUFrDStO15ceUXwnwd+bLfeFa9ClCmdLhuDpRT2GkFWoBbTTgRqaazerhKsedBXC53Iw+i892zIgW2eNF6ym/Cjjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPx4PHpc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPx4PHpc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49547fc63a0so24443345e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 15:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784673492; x=1785278292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yr1536DE3VKasNzBXuW54z7w/XcJshRbpQVnWBAXxn4=;
        b=sPx4PHpcRonJ6KT7EtbY9PVNBtY+yR2K0ryy/WSoFlOPwnDhUe+NJz78/qEft9GzP9
         E9hYN3F5AOElFuJSQ+YytHtj+pfH2/8BRz8QhqMkL4olzyDmI4XiRkrTyI5RjadD1/sO
         Jhzt8Q8XdGaEWDSPU2LvSREWJETHDSSQFKC8VOmy6BAoFLA3AO0lCF1t68GxwNdz4JYc
         6SodbumqgLaEc2+9cfsTz/A+vDL9pCxjUuovhgBasvWAg30rVqP5322DJBd2zlJN4GkD
         cnxX3wbOY5n6Z+9kBMzTqelG9nHFrEeA8Aeb02abzYUcVxnw9qC8RiLfhUdu5QVHGU2Z
         2NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784673492; x=1785278292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yr1536DE3VKasNzBXuW54z7w/XcJshRbpQVnWBAXxn4=;
        b=q2R+Frkrb/YsfB708WuRhrN7tjiltw1AxJn/40DtEMQBI+uMCm1q55x569JKU25g6Q
         WBxuQt+Ek6kkoI8gp/WH9nU8+Yyi9r0q4Ol7ZVeAitfnVL2Y3uWP14pntewe77HytQjK
         lqJbLTl70RHHGPASmJ2FGxFBo4so+hE20RaAdK77Vwa2Qhztn0GMyuqunFQq4lIZeeaJ
         hS0vTb7w3qxHWKw1i/2gpROVEUy3108NDszwNMbisDjDUQycLiFTRVEpiPeyW9rNqtwl
         edkLKl6uTpQ1vHQzwT7nDwdJQzKOa2obJEB68eCWPt/V0w40uBO1/IpunpId55VFJo1w
         2I3w==
X-Forwarded-Encrypted: i=1; AHgh+Rr76mkrjYOiQBa6Y78LFTg8kvwAQ8VJORJaCtSufzz10S2R7Z8+D0UAbEuvZ45Q9LlmLWs+TVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1JufMxJjqzufKAAq/pOKPTlv9OAHqQqtO//RTQZvdpkiROhi
	TNcTArObPH5fI35IM4oLPDHjaDIh0Vt28w2V4w3Wf2TLeo0YbA4Lf6fl
X-Gm-Gg: AR+sD10vp/+yscbUQ1y385vP4IqAfbZpWb17KvNtjccJspThbpxlihFmDEp62VP+SOh
	6T85p7KVY4VFawn9UOXXBGsB+99PhANYU8W93fwU1sD0DuKzCnRzXfYdXSQnZMvMPcV7iMYBS9i
	VmIPE4XhTrgPYeBf9nGUI+aHE9v9n4i+U/s5r8poeQ17NKNjAyGu42ypMrThh2+Ykj+Jcluri46
	Pg7HIpbbOfoUnUZzYz01OSVgODwkcN/06VNHAtR3lRISgJWUWZ1BXqlQk6RQEN4d58Tnps8FyLc
	utYAhlit9NrMFmvoOTLkbXVghDqcfA9in/5OuQG3ATAkfxHmS6f99AE87gIpYsgjk91Mbz5uNZa
	fZDiKsKzUhZ4bHwdmLK84BzZZFGh2EA+FUYOegfOHs0f4fcNRHEh6P+AGrc1TZ5wIfvpWoc3PJd
	buvd6xpJr1cyNdP8Uaqy9Ka+ZowV2ONIlCfaydxRQctrNpIQ6HVPHHv/879kEPYvBWqeb3EOEJG
	XiI
X-Received: by 2002:a05:600c:3b2a:b0:495:5e86:4e11 with SMTP id 5b1f17b1804b1-4955e86514amr111000995e9.12.1784673492483;
        Tue, 21 Jul 2026 15:38:12 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c9d99sm101290455e9.12.2026.07.21.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 15:38:12 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: nnamdio@gmail.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashiko-reviews@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	emil@etsalapatis.com
Subject: [PATCH v7 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Tue, 21 Jul 2026 23:38:06 +0100
Message-ID: <20260721223807.75101-2-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260721223807.75101-1-nnamdio@gmail.com>
References: <20260721223807.75101-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recvfrom()/recv() are documented as only returning EAGAIN for blocking
sockets when they have a receive timeout configured.  However, adding a
blocking ipv4 tcp socket without a receive timeout to a sockmap will cause
EAGAIN errors sporadically.  A socket with a receive timeout may return
EAGAIN before the timeout expires.

There are 2 code paths affected by this:

  1. tcp_bpf_recvmsg() - Used when the socket has been added to a sockmap
     that has no verdict program attached.

  2. tcp_bpf_recvmsg_parser() - Used when the socket has been added to a
     sockmap that has a verdict program.  To reproduce this issue, it is
     enough for the verdict program to do nothing but return SK_PASS.

In both cases this happens when tcp_msg_wait_data() wakes spuriously
(returning 0).  To fix it, we now loop back to msg_bytes_ready instead
of returning -EAGAIN on spurious wakeup.

To ensure the looping does not cause sockets with a SO_RCVTIMEO set to
wait excessively long, tcp_msg_wait_data() now takes a pointer to timeo,
allowing sk_wait_event() to update it as appropriate.

The logic in tcp_bpf_recvmsg_parser() that allow it to handle signals,
socket errors and closuers in its loop was also added to tcp_bpf_recvmsg().

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
 net/ipv4/tcp_bpf.c | 72 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..1755fcf726fc 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(tcp_bpf_sendmsg_redir);
 
 #ifdef CONFIG_BPF_SYSCALL
 static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
-			     long timeo)
+			     long *timeo)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int ret = 0;
@@ -187,12 +187,12 @@ static int tcp_msg_wait_data(struct sock *sk, struct sk_psock *psock,
 	if (sk->sk_shutdown & RCV_SHUTDOWN)
 		return 1;
 
-	if (!timeo)
+	if (!*timeo)
 		return ret;
 
 	add_wait_queue(sk_sleep(sk), &wait);
 	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
-	ret = sk_wait_event(sk, &timeo,
+	ret = sk_wait_event(sk, timeo,
 			    !list_empty(&psock->ingress_msg) ||
 			    !skb_queue_empty_lockless(&sk->sk_receive_queue), &wait);
 	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
@@ -229,6 +229,7 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	int copied_from_self = 0;
 	int copied = 0;
 	u32 seq;
+	long timeo;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -262,6 +263,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 		}
 	}
 
+	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+
 msg_bytes_ready:
 	copied = __sk_msg_recvmsg(sk, psock, msg, len, flags, &copied_from_self);
 	/* The typical case for EFAULT is the socket was gracefully
@@ -280,7 +283,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 	}
 	seq += copied_from_self;
 	if (!copied) {
-		long timeo;
 		int data;
 
 		if (sock_flag(sk, SOCK_DONE))
@@ -299,7 +301,6 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 			goto out;
 		}
 
-		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 		if (!timeo) {
 			copied = -EAGAIN;
 			goto out;
@@ -310,13 +311,15 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
 			goto out;
 		}
 
-		data = tcp_msg_wait_data(sk, psock, timeo);
+		data = tcp_msg_wait_data(sk, psock, &timeo);
 		if (data < 0) {
 			copied = data;
 			goto unlock;
 		}
 		if (data && !sk_psock_queue_empty(psock))
 			goto msg_bytes_ready;
+		if (!data && timeo > 0)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 out:
@@ -355,6 +358,7 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 {
 	struct sk_psock *psock;
 	int copied, ret;
+	long timeo;
 
 	if (unlikely(flags & MSG_ERRQUEUE))
 		return inet_recv_error(sk, msg, len);
@@ -371,14 +375,52 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 		return tcp_recvmsg(sk, msg, len, flags);
 	}
 	lock_sock(sk);
+
+	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
+
 msg_bytes_ready:
 	copied = sk_msg_recvmsg(sk, psock, msg, len, flags);
 	if (!copied) {
-		long timeo;
 		int data;
 
-		timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
-		data = tcp_msg_wait_data(sk, psock, timeo);
+		if (sock_flag(sk, SOCK_DONE)) {
+			ret = 0;
+			goto check_queues;
+		}
+
+		if (sk->sk_err) {
+			if (!sk_psock_queue_empty(psock))
+				goto msg_bytes_ready;
+			if (!skb_queue_empty(&sk->sk_receive_queue)) {
+				release_sock(sk);
+				sk_psock_put(sk, psock);
+				return tcp_recvmsg(sk, msg, len, flags);
+			}
+			ret = sock_error(sk);
+			goto unlock;
+		}
+
+		if (sk->sk_shutdown & RCV_SHUTDOWN) {
+			ret = 0;
+			goto check_queues;
+		}
+
+		if (sk->sk_state == TCP_CLOSE) {
+			ret = -ENOTCONN;
+			goto check_queues;
+		}
+
+		if (!timeo) {
+			ret = -EAGAIN;
+			goto check_queues;
+		}
+
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			goto check_queues;
+		}
+
+		data = tcp_msg_wait_data(sk, psock, &timeo);
 		if (data < 0) {
 			ret = data;
 			goto unlock;
@@ -390,6 +432,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			sk_psock_put(sk, psock);
 			return tcp_recvmsg(sk, msg, len, flags);
 		}
+		if (!data && timeo > 0)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 	ret = copied;
@@ -398,6 +442,16 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	release_sock(sk);
 	sk_psock_put(sk, psock);
 	return ret;
+
+check_queues:
+	if (!sk_psock_queue_empty(psock))
+		goto msg_bytes_ready;
+	if (!skb_queue_empty(&sk->sk_receive_queue)) {
+		release_sock(sk);
+		sk_psock_put(sk, psock);
+		return tcp_recvmsg(sk, msg, len, flags);
+	}
+	goto unlock;
 }
 
 static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
-- 
2.52.0

