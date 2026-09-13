Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355F2348C4B
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789302749; cv=none; b=udjIWb5SXEwVRoiuhYB8O8ehETBv4cECexSIXE8VzoKgDSCyf2DnHuS4UkbEZqvbNk3pA8+r5f0yi/b77M4kvIzILu/LMcynjtsTgMTWnPIFEWP5AaGmZjmMfldlSFAR+h+u1+WbF/NJ0jJNgvoA2KSN/YRDEE8LMTEzNAtyie8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789302749; c=relaxed/simple;
	bh=F1I1jQs6I1fHODPkYWl+RNriAp+rNE7pnEcpuM1KUKw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nn4lQ9jDbYeXftXi3DlmL1Yg8mdLJQgCDsiOkfoJxVsXGJtIGbGBDPKcEgiDeT0eUvH9vtIPXb0vFUR9AHApQucZ+i80GEcrbyAZ9DfrslZpofuBAEZuY0OlKJNyZ1PV/lTGo9JFw4SOtT3FN8+kgHou+xe0tGUAfH7B6S/xhes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IxmANlX9; arc=none smtp.client-ip=209.85.160.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IxmANlX9"
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52ffe24490bso59127181cf.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789302747; x=1789907547; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qopGVev17jhOE3UkvSEyivlw7RORgzCSVyu66c3s7LU=;
        b=IxmANlX9L0I5An2HUGtFdrwW8hcP9oZ8HORBkA2tbU5B7ajnA4Oqb+YnWMfjD+dcYF
         RYXzQc0O7uq0ipvDRTJad2dJ642twMkFc+4GagvmJJEfyql4IuUEmyoxvND3wGS/IA9v
         RZeTyniNTGigJbau0ubdKi261cG8n0dqtUr3OngOdOjwHsdm5IHXRbxYJzV4GDVidMzs
         /AspK0RGm19UmJEw0NvBjmwkJEMPfAPyTtvpgcP5F5cKWkO7QnB5h5EUFhwWTB+/dKzX
         Y8Lr1koFfZnthQp8xgTx9abz/t3Boy8zlhnh1PmhQyJrtqFEB8SW2M/tYUyZQbmCbCoJ
         GpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789302747; x=1789907547;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qopGVev17jhOE3UkvSEyivlw7RORgzCSVyu66c3s7LU=;
        b=sJzO0eXTuzqF4fhAHPXmGTythIZ11OjbIw5a/Xzm9WJzhF9zy4G6qjbWOJUvcfKaXM
         vU9UnFXdDOfQyQL9pJ5Ix4rLnJRKHmPk3KOI3vfN8fxug/FFR7xHU5vWL+LXN7jWz4dM
         FuZmvycPVKEtG7Ml0luxAX8FXXWjYSaBnlAQ/FvbDAy1LNSEVy2RYG/K+R3k/1f/iObp
         eDYgwxQJiKu1uRYG+3EpFv/91z7jMROI7VH4AcSbXaFCAHDkYqyKvb40meLv/L2UEpLe
         /6C4nVnkE7EFUP7bimjy5L7WMOyvoTmLF/vWbWUPCEGACul9oA/fSredXlDTjIRqCjvA
         IBHw==
X-Forwarded-Encrypted: i=1; AKwUvBzAolzWZIpBxW99BNEIEBDTucxa10iGvsw01A7g7Dkc3WEpHiyQJGTko8mRTncY2guDyPUpLKM=@vger.kernel.org
X-Gm-Message-State: AFuF++k285v0QmFqEWx/khQ7y/KZO4yvXQngtmWr0ogMspS3X0cnrbGK
	G0gCViPCnv5G6ugC+0MWnUzCTwsvpHPNBrNe/9xKq0zZGHByrnHGpLV23eo52FWhoIqSw9O5Tpr
	jwv1v2P6pHQMmfQ==
X-Received: from qtqf2.prod.google.com ([2002:ac8:4982:0:b0:530:a841:5d04])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1e05:b0:530:b2e4:d5a1 with SMTP id d75a77b69052e-530e8326c56mr119770311cf.60.1789302746920;
 Sun, 13 Sep 2026 05:32:26 -0700 (PDT)
Date: Sun, 13 Sep 2026 12:32:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260913123224.762935-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: make smp_rmb() conditional in tcp_poll()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit a4d258036ed9 ("tcp: Fix race in tcp_poll") added smp_rmb() in
tcp_poll() and smp_wmb() in tcp_reset() (now tcp_done_with_error())
to ensure that if tcp_poll() observed socket closure, it would also
observe sk->sk_err.

Currently, tcp_poll() unconditionally executes smp_rmb() at the end
of every invocation, which on weakly-ordered architectures such as ARM64
emits a memory barrier instruction (dmb ishld) on the poll fast path,
even for healthy, active sockets.

However, tcp_poll() only needs this barrier if socket closure has been
observed, to ensure that the error code set by tcp_done_with_error()
before socket closure is visible before returning EPOLLERR.

Move smp_rmb() inside the conditional block handling socket closure
(shutdown == SHUTDOWN_MASK || state == TCP_CLOSE). For healthy
connected sockets in epoll, tcp_poll() avoids the barrier entirely.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 562752352afe4d7ab864c00b8562c8b8489a76f9..3ac4856852794736c5d49f042ecd08e4246bdd6d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -578,8 +578,13 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 	 * blocking on fresh not-connected or disconnected socket. --ANK
 	 */
 	shutdown = READ_ONCE(sk->sk_shutdown);
-	if (shutdown == SHUTDOWN_MASK || state == TCP_CLOSE)
+	if (shutdown == SHUTDOWN_MASK || state == TCP_CLOSE) {
 		mask |= EPOLLHUP;
+		/* Coupled with smp_wmb() in tcp_done_with_error() to ensure
+		 * sk->sk_err is visible if socket closure was observed.
+		 */
+		smp_rmb();
+	}
 	if (shutdown & RCV_SHUTDOWN)
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
@@ -626,8 +631,6 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		 */
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
-	/* This barrier is coupled with smp_wmb() in tcp_done_with_error() */
-	smp_rmb();
 	if (READ_ONCE(sk->sk_err) ||
 	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
-- 
2.55.0.1007.g17ff1f9808-goog

