Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC387445ADD
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567753; cv=none; b=TDXZXJJlVgBKjPS/eDADDAJXMh9ZJ9HVxHOCcnYtUaQD2iq4raKRtMLw5XfdUFMUdJ+Sgj0XLfIaVcu0a8LwdUsIoHJHWwOJsjSIwrr03Wrbr6rTd1ApXABsfklnDA+rm8GTNhEA2WTecME+xV8V9BblWe3Nh9gjeQG+gVAZXLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567753; c=relaxed/simple;
	bh=s3q9wJaNCd4aqGAfSgzhEmwkY7JI4EZuWLp6kixzQpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/EFW+zSlRk/VXGfgZmPlV+8bBc88gGlEBl6kMY23k3W0udd2u5b8j4YcURHwMt6bw3FKCf2ecOXK98osd9QgupxKn9i3J1fDfvjkmrS5komyzgHmEv/C5Vh5a4mudpJ82L+7PbyArXGjPk0pgrI2D/pzX+zdqUiPs4w9NFvR2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJE/aLy+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJE/aLy+"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-495437bb891so32908585e9.1
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567741; x=1785172541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OyPjQCXherIdXkhKswzDtmo6q9pYSImGwr9J9riqS9s=;
        b=MJE/aLy+n80Qn8eLMtQUA/z+7+7ItLAeV6oiuk/7083Fcdl1QBRd6KtMX2yM6zU65P
         ekSwc3wzkWx7ZrRfPipG/Q4/eKu6ULxiiXG8jzOZPzn2yYhDkTKiPrpMjIGy+lRJweNC
         NzWd4sPunNBMjZu08ITIADwiE435M++jcSw5EAFcQWFGn4CcFlfi8zs9YetMnQBJU3gU
         iv74pnfDjScIe4+hQm5Knfzb9Uv1fgiu+huAyhT0XsP8OZFfuNHmFuNQ6GmSn+cpnojo
         eQH/IqabGi9pLptY+ddmNSZZlPdNYUr2vCNyipIPXti1NupQAP9FA/dKi9VwBBcOvsAS
         6vFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567741; x=1785172541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OyPjQCXherIdXkhKswzDtmo6q9pYSImGwr9J9riqS9s=;
        b=Huf8lUllPYoZYGzmGR/vMZAjhbDcQZt6znSt7jxmIOsUE5f5P66ksGpWR9GO+Paain
         K3dT16x/xo/UE/mtfz3d8Zy/Ds4ndmTr10r3H0mvtYrlC+N/njE1RzqEQr3PBYrQMQdl
         dPgiOH8MFStvX/Wn2D8bgXKYFHPXyKZ2vX1ALMqGyM+B7rB0xivTwI5b533Z3Mlr0lTG
         8JLW+hAnNfl0tAwNonQEPC7Lu8PvpAYrWN+gpqx1Ytvvblr2b1NoPY0wfRKnzeoPrxTm
         Gqo14InWLLcC9gMdCOat1K5x5SCz7VsS+N4Dy0LL8PDRhlLsHTag5Mcgy0WaRGGxc+5L
         8yNA==
X-Forwarded-Encrypted: i=1; AHgh+RoSgdcU/Ofb7feEN0clxTj6/+5cLmcBM+vM1tLomsS42OYoF9MmJdC9t4FGewb2efD7XYzfIQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgGPacNxozWj6386jweqxeHFg7+L+y1u1hf+nFbzhAQPvPJUF
	dKYHmZudJTIMkHF2vJMoQ2sMBKLM74whZlTNouPtpIyNfwEnahZLauN/
X-Gm-Gg: AfdE7cnBWtsibcE8xpK8aOJcNlJpdn1gqSE0N3NQjUJ2DQkEksV5uNl0c5SiFws1NBL
	Avkeke1kibpEsoJg6Oir69l5zoiPw5/FkjaMeGl0/T9CBGAhLvciLkycTZVRUbhqLyuc60+HH9X
	R3keO1qMObLAd7KWvpOufjIfQfdcREjV5fVa1t0F0+YOf0DzKJqugMYvFPcr07rtfrFbRzyLJj7
	/LFdcQxINxIKtSsb84D8Kp8t5dQMM6HaQdDu+ZrZJuBUGXsRA76TjKjiDDwzVXWbzzQaPWXz1m0
	YWfTv2/Vi8piYsKIdBcRkWgqq4NBZlsrfKJAVrpLl1cbHfuMWIaVgASgyIdcqal7w2nU/e0J1gN
	WQtA5N0sGXaqEBUDPZPEvYBzrBUG4FxOgmQFBe1tk+3G7L3EnSgU29i2WSsJoJgQ3T6r3mAp6vz
	h0TLv1irkd69gEEKD0lBRDRhtiBpIHr0SjXSlBJLIZ6VDSgm3S1U8sO3H9pJXtSZFi+w==
X-Received: by 2002:a05:600c:35d1:b0:495:3a52:71b1 with SMTP id 5b1f17b1804b1-4954aa1a34fmr143514195e9.5.1784567740489;
        Mon, 20 Jul 2026 10:15:40 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547af7esm2304865e9.8.2026.07.20.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:15:39 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Mon, 20 Jul 2026 18:15:34 +0100
Message-ID: <20260720171535.67867-2-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260720171535.67867-1-nnamdio@gmail.com>
References: <20260720171535.67867-1-nnamdio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

recvfrom()/recv() are documented as only returning EAGAIN for blocking sockets
when they have a receive timeout configured.  However, adding a blocking
ipv4 tcp socket without a receive timeout to a sockmap will cause EAGAIN errors
sporadically.  A socket with a receive timeout may return EAGAIN before the
timeout expires.

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
 net/ipv4/tcp_bpf.c | 69 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..aa5c5d741599 100644
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
@@ -371,14 +375,59 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
+			goto unlock;
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
+			if (!sk_psock_queue_empty(psock))
+				goto msg_bytes_ready;
+			if (!skb_queue_empty(&sk->sk_receive_queue)) {
+				release_sock(sk);
+				sk_psock_put(sk, psock);
+				return tcp_recvmsg(sk, msg, len, flags);
+			}
+			ret = 0;
+			goto unlock;
+		}
+
+		if (sk->sk_state == TCP_CLOSE) {
+			ret = -ENOTCONN;
+			goto unlock;
+		}
+
+		if (!timeo) {
+			ret = -EAGAIN;
+			goto unlock;
+		}
+
+		if (signal_pending(current)) {
+			ret = sock_intr_errno(timeo);
+			goto unlock;
+		}
+
+		data = tcp_msg_wait_data(sk, psock, &timeo);
 		if (data < 0) {
 			ret = data;
 			goto unlock;
@@ -390,6 +439,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			sk_psock_put(sk, psock);
 			return tcp_recvmsg(sk, msg, len, flags);
 		}
+		if (!data && timeo > 0)
+			goto msg_bytes_ready;
 		copied = -EAGAIN;
 	}
 	ret = copied;
-- 
2.52.0

