Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69C3F823E
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061586; cv=none; b=BRGdIkyGg2mzNwz5LpznE3L4K0QqHE5Fb7dS2enk2/MZQjZSDmJZXJoUFYMPwTuBBEiP+5yGICd4aCXC3UwfId2j+ylnhIWMYVybl8N9alvNSbtQ80FKquaH7tMgGYDWBQMvc+oljVv9AlwGOXSHxJ0iETUqlvIr/plS62WQBz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061586; c=relaxed/simple;
	bh=FBBa9dhL9917F3OcmR5Tscs1K6cFUVbxn1jGmTddpkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbfxCAKQ7BH0Q6lqrt0KrWax+OiEOeURgrTCeg7Vkdco8pwAn4xpIVvwmMQu6VqHOJcqSxECEsRDVXUOLnykWExozZvCnjV9wMg+UO/7oAwmDymjUXxVJsNXzynZ8t3/v37S7eAM3oEy5P+U5DAJRbe7SaLHivh48z+gf6RmLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9UG+WU4; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9UG+WU4"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493ece78b0cso34176615e9.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784061583; x=1784666383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/u8DsZ0eIRa2g/5SoCaTvebv+Ssy+0KgOmxxIfNFxNA=;
        b=o9UG+WU4FE25ADehgev7na3V9ncvklEkqYvLGO5DX8fjGEB4M9P7dV5EOmwSIWXu7n
         Z2t0hnX9/lJSj5YWxfFTiv7Mh06dEh8t7PYQNUqlfxJ2EcNM3I0/YIk/CpASq7HCbfwh
         h23PyqYzFTa7k3q1aO2XoP5lNzuFlUogX/ChIKO0I6wdSWbaCu1zuvWhu3pnDN5CGBE3
         EYXO8tGGBACpJBXrq3/rTymYxggKuByluRgqOQL45SRiRrLj85onlJ+HyQKsuaW8Siby
         1t6M+Ase+11FVvKK2CvAAM0jEMTWkWVoyezNjPAuPN4hZzZIovqhhrOZQurBOr7KrD6V
         Du3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061583; x=1784666383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/u8DsZ0eIRa2g/5SoCaTvebv+Ssy+0KgOmxxIfNFxNA=;
        b=Wod7VHMB+I7E2hMWDGEiCBpXVjfp2fcsIH/UZJVSec66jUnj0HkcEws26Br6XhXuNd
         a9bkQcmArROCeUrzM9ePzjiQfuKmhQA4kzanDpXJt5VW1pnBiubq+gdgS9DfYLTEAYOU
         jAqT1ScEPAGaBH6RLXveK6qs7xa7I6IMScBtY3iNFrUsmrltNTZA7+LlSTjITi4FdLSu
         8zCeFt1BowLvNy+s1Nlq7w8qiFf0F99esrBejh9BVRpkrOwGekwtb8h8KLUbfVrndTje
         dbadYwHldFV3FcCGS00FfKddG5IQPXL0UkeWHq8wfF9L3cFZs6/Tg6naunnBe/JdrRSu
         9K2g==
X-Forwarded-Encrypted: i=1; AHgh+RoAIBZMvIysCbD5+gHaC/TQ3WuqrHA8u6RK5ey8EopIue2wcstMnzPv2afHSaTkWdrRW68+oVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYq1Nsq5Kt+ZqRC8zX2zXJop7orSLuUK5WJTi9XvHVvFRA5kcw
	v/lQ6d7fNnvo/88QhQirhYfufrJnfk1tX9e/LBHQ0DAfldTrgdA6SgT7
X-Gm-Gg: AfdE7cn3GIMBqIjMA6zIONbja7HKzcDLbxWMTzH2BCd6BPOk/oq67irvFAIqqHiz3DO
	gEpA/BdWUxjXcWhClB8AxrpSI8vtiQdKpXoHvKrYAjquPEIfG7mHWaoRWR/F0BIH8v4bzNJ+eGo
	ehjev3v/EU0acHrpHSe/rypZFMFJ2dYh/lHgvP1demHuTQBlKO0tZtUh7apxjjOBzc0uOlFAPQU
	WvtOsCPjtkMsP1qb7WiVBN+8dPihWUe4WLaAaTDdQDVjBavqeEFGQAX7DZMukZIbUjrpw+tX8Tk
	bx7zR1aWqdixZ5y9wBwezOUBu5nqJ+Qfb4Oa6ho2i1BEdaxTqB9otWU2LHchD1IdKO+yhZph7/L
	pvg2Kam4EtbdEmemQkc+MDwDzCc3EAmZ0NdGDLYtr5fredJ9gZFllKY7IzCqjAuMWARj3gGecMs
	iVf/8aYBZwlWaGJQbuVbZcsWNulQXtT9uGywBVMzFKdDdhsnyoEkru9CnAAiJvdwEPaJBKwoZ6I
	CgA
X-Received: by 2002:a05:600c:c16e:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-49515904fa9mr60720155e9.19.1784061582835;
        Tue, 14 Jul 2026 13:39:42 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32c65asm98894115e9.14.2026.07.14.13.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 13:39:42 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: jiayuan.chen@linux.dev
Cc: nnamdio@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH v3 1/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Tue, 14 Jul 2026 21:39:26 +0100
Message-ID: <20260714203927.32289-2-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260714203927.32289-1-nnamdio@gmail.com>
References: <5b07d2ab-84ee-46ae-84c9-7542499d26d7@linux.dev>
 <20260714203927.32289-1-nnamdio@gmail.com>
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
 net/ipv4/tcp_bpf.c | 55 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 9 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index cc0bd73f36b6..e58ab2d1ee94 100644
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
@@ -371,14 +375,45 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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
+			ret = sock_error(sk);
+			goto unlock;
+		}
+
+		if (sk->sk_shutdown & RCV_SHUTDOWN) {
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
@@ -390,6 +425,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
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

