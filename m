Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F420E456E10
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828637; cv=none; b=Nkdf4m3EIX8fmxcH3YKO/JuAouj0KL1zEd+AMf4anF19HO/dQqfN1TDgNgFEWXkE9KKVbSFORhSiic1OcV6JZwrcz9LKRIrCdiv3f3ZqsR7Ip5QEc7wHgQQYOpiF9DNsNQsL2s5B8UBjIJ3kDqv/AO1oQ1W2NHHN8mWvWlA4LQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828637; c=relaxed/simple;
	bh=c322EHDzFGam+ndRvOaWlDiA1R9KPnzqIwrYTJ3Zk2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JI9t3ifMu4xV296KzntK3jWa3A3Jm2hE1WDa53mUiOJFB1ZDXFq/fSqIjVTqrdqZAz26vtRusWz97UDcyJfxxiPzFoZjz1D9Bjvp9ZW9ImFDwvxsYLaj858OzNmW7PMjTirOiyr7KOO5yyC2lcWy2sb4u0jTnKjD2bdFkRrSBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Swx6cGWY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Swx6cGWY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84864086bfeso928056b3a.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828627; x=1785433427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xJ6powf+TQgoOgkFgiejVdCeilWUk8LopsA2dzbOUgM=;
        b=Swx6cGWY9hUE4zrqrZ4OHOslc9Yr6LuPKMt4aNLjo4b+PjPS6oAZF6GO64zpJQUN10
         4GzSoS15iH1TMHfbEVbqwCBWsGHZ3uBSOPEeyDPhUsmtULX7/E4VUjPiLlfb+dWnBSYK
         rU9hGeStyBh2wgTcMgHOmx/GJpQOFr5o7cZ+oRVKP1KtuAhWd+nsVPUIEYAaWjQfszj/
         KsDYKYgU625KNIdnvnWgqzhinjrqhvD9BYy+YLwKV9OxoqtcRXOvflA1yQHJL1k6sbIG
         sTRFSZGVFBSIadxK8/TNCNm+22AUhsN5pUliuu5jgtHpCjRPQRT7tya4WspQt4i6oqL9
         5IlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828627; x=1785433427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xJ6powf+TQgoOgkFgiejVdCeilWUk8LopsA2dzbOUgM=;
        b=QjWfl2wHpc7H67RszTr04e3ihByjFhHrG3W5KqG6ny1W2P4vd4vQZoFIehy+ukmXhT
         qOD8ANJhrAdUd7txAWVTqqN9y6e/f0fNA6NrTmbBbXDiW85GoXCpYp8q7F1lK1HezSPz
         EeSGAPAjCgmvaOgiw3JYZhXgubXy+oo7Idebdp34PZ0kp9Z7DPxSw0A33dIOD2P6QaZn
         43Xpwa0TPN78iEMBc0SV0WdF8hs08e4odCkFekPN7GnCti0PXr3tpb2UJewpsgyRivk6
         khPRxGoEQmZ7iMas6rW6mJ8lDmEZeMyIyX/8J20vVKXhHpjTtRERUxsr8anJPE2ne1b6
         dNpg==
X-Forwarded-Encrypted: i=1; AHgh+RrSk7uESvhRH2OsVKsMlOBoShKHJKmoHflgENys/rzwGNjjXQt3e/nshhUuuC+BaX+8RxSnLaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXcYqe7Hyh0mk/2e0eQjdKA6TsvR9WA1wo3hrYXpOTY8+cVe3Q
	PiCKkg6Riu9eRLS2qRh5Gb3Erf7JgcNTac6T0fQl3E6d0HzS6kk6GPxv
X-Gm-Gg: AR+sD10wJtI4XG85V5aoiKP3jocqLr/DVNPAfn4aiyXo6fFgLRAiajeVWtXwwvnv0Kg
	eltvupGU6THhp1Amo79HzYvWhYs3jcSd3BhG3Up6wmEecoE8SQkapuZ0VZ8wvEXHCwJqjBQsMhn
	TSwvAg2IyCX3sJJ88rFxYfj6qeQ48B6NBNykiiM5FgSuAwkOFI2qdvrYzpJw2eJcG0Vxm3Sy8sU
	JIe4boHAOUZpLejAQ7TEBz+CAQcttlZq6pFON5kRLg/JRn3f82mJJbwI4TytrJLzWcTzuqVZGq+
	r5VHko5UCVwzdO0Ycb5rAPVrScYQzUYhOmQLSzxJ1+q3njW4fIlmqLCqZ4DkYjwx25U5kfGk+gV
	4eCuIKdnUAumi3k0zhBvsDDpHj5G5aQ33DJDk7RqKLRHJEVxYYc20LZlNe/KcVghFc6nKadqCdj
	B1Q162yKL5WlR9Nj2aG+Q=
X-Received: by 2002:a05:6a00:a8f:b0:84c:539e:a355 with SMTP id d2e1a72fcca58-84e2c29caf1mr4833717b3a.74.1784828627483;
        Thu, 23 Jul 2026 10:43:47 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e175cdc21sm3425111b3a.47.2026.07.23.10.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:43:47 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zihanx@nebusec.ai,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Fri, 24 Jul 2026 01:43:28 +0800
Message-ID: <b640f1b3e27afeb9f397b2bab9ce23f4f2f864a7.1784742007.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784742007.git.zihanx@nebusec.ai>
References: <cover.1784742007.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <zihanx@nebusec.ai>

rxrpc_encap_rcv() moves encapsulated UDP packets onto the local
RxRPC queue without preserving UDP receive-buffer accounting. A local
AF_RXRPC service such as the AFS callback listener can therefore be
flooded with RxRPC-shaped UDP packets until the local queue grows
without bound and consumes large amounts of memory.

Reaccount encapsulated packets against the UDP socket before queueing
them on the RxRPC local queue and drop packets once the socket rcvbuf
limit is reached. Clear sk_user_data under RCU protection and release
the socket only after queued skbs are purged so the new skb ownership
does not outlive the UDP socket.

Fixes: 17926a79320a ("[AF_RXRPC]: Provide secure RxRPC sockets for use by userspace and kernel both")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/rxrpc/io_thread.c    | 15 +++++++++++++--
 net/rxrpc/local_object.c |  8 ++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index dc5184a2f..85411a2d8 100644
--- a/net/rxrpc/io_thread.c
+++ b/net/rxrpc/io_thread.c
@@ -41,8 +41,6 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	if (skb->tstamp == 0)
 		skb->tstamp = ktime_get_real();
 
-	skb->mark = RXRPC_SKB_MARK_PACKET;
-	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	rx_queue = &local->rx_queue;
 #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
 	if (rxrpc_inject_rx_delay ||
@@ -52,6 +50,19 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
 	}
 #endif
 
+	if (atomic_read(&udp_sk->sk_rmem_alloc) >= READ_ONCE(udp_sk->sk_rcvbuf) ||
+	    !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
+		atomic_inc(&udp_sk->sk_drops);
+		kfree_skb(skb);
+		return 0;
+	}
+
+	skb->dev = NULL;
+	skb_set_owner_r(skb, udp_sk);
+	skb_dst_force(skb);
+
+	skb->mark = RXRPC_SKB_MARK_PACKET;
+	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
 	skb_queue_tail(rx_queue, skb);
 	wake_up_process(io_thread);
 	return 0;
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 169f9dfda..6604f9f95 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -437,8 +437,8 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	if (socket) {
 		local->socket = NULL;
 		kernel_sock_shutdown(socket, SHUT_RDWR);
-		socket->sk->sk_user_data = NULL;
-		sock_release(socket);
+		rcu_assign_sk_user_data(socket->sk, NULL);
+		synchronize_rcu();
 	}
 
 	/* At this point, there should be no more packets coming in to the
@@ -448,6 +448,10 @@ void rxrpc_destroy_local(struct rxrpc_local *local)
 	rxrpc_purge_queue(&local->rx_delay_queue);
 #endif
 	rxrpc_purge_queue(&local->rx_queue);
+
+	if (socket)
+		sock_release(socket);
+
 	rxrpc_purge_client_connections(local);
 	page_frag_cache_drain(&local->tx_alloc);
 }
-- 
2.43.0
