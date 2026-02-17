Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EEF2032D
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286836; cv=none; b=fzerOWQmHMnD47Si6ld7BwQCbenGZCYccFSoWXW5FPQJGTsVL9/w6GhKcauLmq+55pIO0Hsil93mHI63zUBxORBJ/CRAu5kWyQnxf4hC2rNNe4w37wRJFgcakkwHgv82uo0wY3ZZytAEfPxdbvwmUOSOZPwnuqSDlj9rNxC1lEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286836; c=relaxed/simple;
	bh=ZqoEGUwkgOjkNMykBkGRV+enmkZyBleyNoh/QI2Ii04=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qyVuD/bN+sn5fLgezrGg8yQUmrp6T9WQQrsh2A5jab/PpZz5YBbm4lYxSM+GMaza2prH2YQmAsO7rRKsWTN8FXOJt5PPlC8p6RevMA9u6wW2a7wKQjSS+OIPcgBfsGjI93e3oy1tbmiDZ3KfKUZzZ2Q++k6qUwMPePvIiLOemcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIkQXd+S; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIkQXd+S"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c56848e6f53so2350954a12.0
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 16:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771286833; x=1771891633; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXkOpCMh8SxTrfC2IWENxO6f2nAwVIkrgIkGC463PV4=;
        b=AIkQXd+SiqHuGuonFBZCorwRUWBL7Gu+drWca9MbBi+YUn4160IZYnDAB1MQLbS3zK
         TE5WRNpaLAWAkDVG63PBLh9K9k32AeyYMNajfgB3r7VTrMobUIK8Ynrz8xOnbRgUtVWM
         OsoA+uqp8UFQzBn9WcoeBDxcZIGlmtTo6AadQmH5gKDoKWX+nNBwOXiVZOzFMz4xr9lY
         kolyCqOhxoOAGmgq51lYx6bAX7ZfKHJdzJz1OxM5cPFGqwlk+zoTME49tWlHdCttshE1
         DjFOrImVMD25bCokZhWG+uUYK0gnsU1K5WBQTJnQP7eRX+d9+AizejdZ1TAdKsoD34mf
         Btpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771286833; x=1771891633;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXkOpCMh8SxTrfC2IWENxO6f2nAwVIkrgIkGC463PV4=;
        b=X+gXdcqivt3PNtxfUpyRUrIf33xW4+UP/WTwXCXTr2syrWErgt3oyXKCZZ3t1LLYp5
         OkkmLhLkwJhUkX/ouywlIlLHhSsowRjrZT0GKyW1J6U/tf+DgzPdwhhj7rRhb6lFN8RH
         1kVTOOGTSg2aFFMf1TL3ng0NVeF8RTC+zTF/QNNF8JxBDEXVZkNeDKfBFlb0cyc4iXFE
         bRwtYArmh3grwNpVQaq8413xa774JZktZQU7GeavdPM3fKgi6bs8WZVjiy/GhUag7mcD
         2kTl7oZecKz9Ng5tKecRLIWhsDA9lmGiEEK1MslkW+dw1YtNIhrmwJDITiZkSRlos+7R
         QLPw==
X-Forwarded-Encrypted: i=1; AJvYcCU3LkYRy40Qtdxalhi55emea7d3lNKDQ2VMYUYQhBJCIQQ31e6XB/Zy8WpzMe4yVCZOAIP6oMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/wj5n9dDBKAKjLBdNjJy6lELOw/gAUiLjIZOPYStwXXQKqUhR
	ilKyLGQENRMNI2dvlwjTnH8b4xaAyko9n2PqJbCcqkBnxHJzTX6GfayUYNpcD2uL6aZ3kA1DAzX
	TOhKBHQ==
X-Received: from pgbfe5.prod.google.com ([2002:a05:6a02:2885:b0:c61:3a0e:23ea])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a1f:b0:341:d5f3:f1ac
 with SMTP id adf61e73a8af0-3946c8bf8b3mr10721048637.41.1771286832287; Mon, 16
 Feb 2026 16:07:12 -0800 (PST)
Date: Tue, 17 Feb 2026 00:05:17 +0000
In-Reply-To: <20260217000701.791189-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260217000701.791189-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260217000701.791189-6-kuniyu@google.com>
Subject: [PATCH v2 bpf/net 5/6] sockmap: Consolidate sk_psock_skb_ingress_self().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SOCKMAP memory accounting for UDP is broken, and
sk_psock_skb_ingress_self() should not be used for UDP.

Let's consolidate sk_psock_skb_ingress_self() to
sk_psock_skb_ingress() so we can centralise the fix.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Keep msg->sk assignment
---
 net/core/skmsg.c | 62 ++++++++++++++----------------------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 57845b0d8a71..6bf3c517dbd2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -572,32 +572,31 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
 	return copied;
 }
 
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref);
-
 static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
-				u32 off, u32 len, gfp_t gfp_flags)
+				u32 off, u32 len, gfp_t gfp_flags, bool take_ref)
 {
 	struct sock *sk = psock->sk;
 	struct sk_msg *msg;
 	int err = -EAGAIN;
 
-	/* If we are receiving on the same sock skb->sk is already assigned,
-	 * skip memory accounting and owner transition seeing it already set
-	 * correctly.
-	 */
-	if (unlikely(skb->sk == sk))
-		return sk_psock_skb_ingress_self(psock, skb, off, len, true);
-
 	msg = alloc_sk_msg(gfp_flags);
 	if (!msg)
 		goto out;
 
-	if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
-		goto free;
+	if (skb->sk != sk) {
+		if (atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf)
+			goto free;
 
-	if (!sk_rmem_schedule(sk, skb, skb->truesize))
-		goto free;
+		if (!sk_rmem_schedule(sk, skb, skb->truesize))
+			goto free;
+	}
+
+	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
+	 * data originates from the socket's own protocol stack. No need to
+	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
+	 */
+	if (skb->sk == sk || !take_ref)
+		msg->sk = sk;
 
 	/* This will transition ownership of the data from the socket where
 	 * the BPF program was run initiating the redirect to the socket
@@ -606,7 +605,8 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	 * into user buffers.
 	 */
 	skb_set_owner_r(skb, sk);
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
+
+	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
 	if (err < 0)
 		goto free;
 out:
@@ -616,32 +616,6 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
 	goto out;
 }
 
-/* Puts an skb on the ingress queue of the socket already assigned to the
- * skb. In this case we do not need to check memory limits or skb_set_owner_r
- * because the skb is already accounted for here.
- */
-static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb,
-				     u32 off, u32 len, bool take_ref)
-{
-	struct sk_msg *msg = alloc_sk_msg(GFP_ATOMIC);
-	struct sock *sk = psock->sk;
-	int err;
-
-	if (unlikely(!msg))
-		return -EAGAIN;
-	skb_set_owner_r(skb, sk);
-
-	/* This is used in tcp_bpf_recvmsg_parser() to determine whether the
-	 * data originates from the socket's own protocol stack. No need to
-	 * refcount sk because msg's lifetime is bound to sk via the ingress_msg.
-	 */
-	msg->sk = sk;
-	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, take_ref);
-	if (err < 0)
-		kfree(msg);
-	return err;
-}
-
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
@@ -651,7 +625,7 @@ static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
 
-	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL);
+	return sk_psock_skb_ingress(psock, skb, off, len, GFP_KERNEL, true);
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -1058,7 +1032,7 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
 				off = stm->offset;
 				len = stm->full_len;
 			}
-			err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
+			err = sk_psock_skb_ingress(psock, skb, off, len, GFP_ATOMIC, false);
 		}
 		if (err < 0) {
 			spin_lock_bh(&psock->ingress_lock);
-- 
2.53.0.310.g728cabbaf7-goog

