Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CD42E7162
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596327; cv=none; b=FKaZ0By1s3pyQ+gHMt33FS+ioJuQiy5PjxGWo2823neItAaZtoTd4jC05Z0YBFKJ612pEcxfO3SPzEg3GueRB/6YotK4zAddozoEZdAPKZmrk8vLkNdfvqG2WJ2jfTGmn72rTW1b6nt0Jok82J7OssM3991mByHEUOunZ8TsulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596327; c=relaxed/simple;
	bh=UleVRLQeX7/EZv2DQznaxHjkonPd/+d0J49jgGtExWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mH6K1qGMk9KX5+UA1+21ZQocwfuH8upCApYRd2+atNbA9Z8IvWEFBJKdv7oQAOCwuJ/cvmN2qzh9WimJgcriNyOg1tImmEj4uVaFTKCaYuirFVx6sd7UZnzaDxX3kbSzJVWxprtL4WE+LMUfXXgju9xz7DzpFfXYk9fJvxmX9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=oFKF96FE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="oFKF96FE"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so2155399a12.3
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788596323; x=1789201123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6n+MxWK/M6q3SzPBPjKueM2StMDrv+VHYWiWFtLihRY=;
        b=oFKF96FEEwBYCEoa/UlT8ZGgimBWQr2heae9059rPZV9V2ETSlks0I5DBGkA2mlsZa
         Bcm+zdhornhSigjGo5wlKGxZ44hj/f/ThDB38EuPMAFyG6Im38xcKUC1GUcR0s7NGQcf
         Ly0ipmBIJIwUN/99hDSkaIiMs7UOShdcgj8O/Xcw8mBHpOJM1ROtu7fjIpGAhDzTXqFE
         l1KvjtaOE6MslG5kF4ppQrNEFbwaCviu++4t8aUlT6rlQfwomPq8znhqFU9QnFNcqsof
         Rlr3g+2MrD4Nr0ZDTwoNb1c/ZqUgVhD/duIKnnwXl9vUzLgSxzjBOXhTnpZnbtU8s/hM
         dxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788596323; x=1789201123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6n+MxWK/M6q3SzPBPjKueM2StMDrv+VHYWiWFtLihRY=;
        b=kCVxb2MHiz9VTCG9xcndCc285xSyRN7sI87E66uwQxNViihtGc1EYcpl+ChLPqvRAM
         uJtT+BNloX3w0Dlw33OofYBoPSWvD6oE1d9FGFRyx0EGDqERLQQog1mqJRvQI1T3oMjB
         5ynaYBylPcyqxeodGitp9OG/3RocG+5CqwqSzafYJhttRcUfkPBDN8oBRgTX40mUEhg4
         MjPsvWZrSPpPTtky90WOfM4iC7KU/PWGU6BHHHkSOrJZ7IM2gj5zSmz340powQepFFJo
         Rr0UXAyDKM6xVkb+s0pwlRUBD3Y+GRP2bZiHD6Y0op+yfUAS8KdpYIJoVvz2UdKnXEop
         memg==
X-Gm-Message-State: AFuF++n3RCZu4nFBmHmabfc4zCO+f3MuTRtFUs/Si3ek04LQ5BSx6uFS
	FxmHrBOixHDTpyPa5upqROebGpyBTubkecX/fiBQ8ZIbxCstTo3Gifak64OPrdwrA3cZXhpOmbO
	xs9w+7PEO
X-Gm-Gg: AYBFou1M4BHbn7fpu3ONspboy/MHtGgX0mNihGGs8D5SoHLMg0ScIAsxkQHqsyx9am1
	N5FmsfWd7Gi08dDEyEcWlJk6ZYbpFuINaV+IX2nd0rkcOWq4ks1Ju4iB0KJ2x7a3c+o+EpC0Z57
	RZeUJop1BaNXQ6Bj1ADh9aoOSaXxDGJVzgi4FVDXDz9Zfkv+mKro1GjoIQUOb6sibW09JFVX5yA
	xKM12XXNcUe4WBXgp+LlbroFCeAb5kjOskk5DOQqqu2ZbpWfukp2J5lO/1ilG/weyDe/N46AZjL
	z6G3EsuNmkcHlnqKA1mnj08vxz07WMHw/jYIiwj1BxKMvLwHwpqZe5n1jsENAnpKN3c47ViT0Wq
	pEQ+zQOcstFmF76NQf1mJQrb1uhRVB9uPnJVU9tGegVkqKlGhzZKbIBvSMXFe+T6F2umbs74gQz
	hgn5narr8bAUBCkLADSCujJ8SCsFj+H9UdS+C5QcZp0wLyhs+Pt/lN3X0SSOq/JaKF/mGOX3s2g
	ysurAr/5ohTHUVFAKM=
X-Received: by 2002:a05:6a20:7283:b0:3a0:bc61:62e6 with SMTP id adf61e73a8af0-3da39d0d473mr17840288637.8.1788596322675;
        Sat, 05 Sep 2026 01:18:42 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc455451b46sm1713049a12.18.2026.09.05.01.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:18:42 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v3 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Sat,  5 Sep 2026 08:17:40 +0000
Message-ID: <a2bd6f3ed29919a7328363b548299ae583f052b0.1788539302.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788539302.git.zihanx@nebusec.ai>
References: <cover.1788539302.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rxrpc_encap_rcv() moves encapsulated UDP packets onto the local
RxRPC queue without preserving UDP receive-buffer accounting. A local
AF_RXRPC service such as the AFS callback listener can therefore be
flooded with RxRPC-shaped UDP packets until the local queue grows
without bound and consumes large amounts of memory.

Reaccount encapsulated packets against the UDP socket before queueing
them on the RxRPC local queue and drop packets once the socket rcvbuf
limit is reached. Orphan each skb when the I/O thread dequeues it so
UDP ownership does not follow the packet onto call or connection
queues. Clear sk_user_data under RCU protection and release the
socket only after the local queues are purged.

Fixes: 446b3e14525b ("rxrpc: Move packet reception processing into I/O thread")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
changes in v3:
  - orphan the skb when the I/O thread dequeues it from the local
    queue so UDP rmem ownership does not follow packets onto
    call/conn queues
  - mention both io_thread.c and local_object.c in the cover opening
  - do not describe the recorded panic as a complete non-root-only
    reproducer; the flood is unprivileged but I/O-thread starvation
    used privileged steps
  - attribute the OOM to skbuff growth rather than incoming-call
    setup
  - describe the recorded panic as a downstream OOM in
    rxrpc_reject_packet()/sock_alloc_send_pskb after I/O-thread
    contention, not as an allocation at the encap_rcv enqueue site
  - note that cgroup.freeze does not stop krxrpcio; the crash still
    shows that kthread allocating, and the CPU pin plus SCHED_FIFO
    hog are the steps that slowed it
  - v2 Link: https://lore.kernel.org/all/cover.1785339953.git.zihanx@nebusec.ai/
changes in v2:
  - switch the drop path from atomic_inc(&udp_sk->sk_drops) to
    sk_drops_inc(udp_sk)
  - retarget Fixes to 446b3e14525b, the first boundary where encap_rcv
    queued the skb onto local->rx_queue for later I/O-thread consumption
  - rebase onto current net/main
  - refresh the cover crash log from an unfixed 7.3.0-rc1+ net/main run
    and include the decoded stack
  - explain in the cover why packetdrill was not used
  - document the actual local flood command instead of a generic
    unshare invocation
  - v1 Link: https://lore.kernel.org/all/cover.1784742007.git.zihanx@nebusec.ai/

 net/rxrpc/io_thread.c    | 17 +++++++++++++++--
 net/rxrpc/local_object.c |  8 ++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
index dc5184a2fa9d1..8b77d137888ea 100644
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
+		sk_drops_inc(udp_sk);
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
@@ -471,6 +482,8 @@ int rxrpc_io_thread(void *data)
 		/* Distribute packets and errors. */
 		while ((skb = __skb_dequeue(&rx_queue))) {
 			struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
+
+			skb_orphan(skb);
 			switch (skb->mark) {
 			case RXRPC_SKB_MARK_PACKET:
 				skb->priority = 0;
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index 169f9dfdaa77f..6604f9f952660 100644
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

