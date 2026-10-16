Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E143A785D
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119084; cv=none; b=qIOt5m2sjRNwE3q9/Q9fVfKSoqKXmSu7D/7hav0QdO0wIPOJ9Sot4Jw/KCSjmTw3kEz2e1d3O+0ylA6SUhjHj2npIGZ9CrcTwBTPWme0PS77i4nD7PZmzK+Hv52IZUEMZZRsMJZiFb9XJwlxm/JY2+DnGEmbEgR431n6G/39Pq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119084; c=relaxed/simple;
	bh=JjdXEPG/U5vqUqSZIywp833GrTDota8M7ZvHvy/w8R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oW1SVX6v+GKy1IemYnwkkofbdZcGvG7wEOiXsFQwQBiAX8hOUwHw9VG/NngUmz3ARPPM/++Fzkx3rCmrNfVZGxvPCSVKDxv7MgEUCZgcfBGP6Gof4iG0bHTzaN4O5rtk4jWZxwtXDMDfrdZ0NVG9wk44Uvlqb1kT9o6vlV3iVDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Mnv+IlfZ; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Mnv+IlfZ"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1047091a91.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792119079; x=1792723879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Yzu8glrSiVcPVBKtq1mDlwwIGvowgBD7oCGZg/F8NY=;
        b=Mnv+IlfZVDdHuX8GzUCvMW2kS7C9dpi7dDj90jnl37fTqHmvPTj4KHph0twH406Rwv
         X7lkxOYPGhKEQRGVRX2IFnPg4MeK6ZjsdDN8PXQfLuzj9OxrpgiERDOEbhrIphjCp1uK
         UOXrHigrw5hBf6J0MhWTPo/aIl7MI3tddXzdasVjPQm8vF9YhNhAXgHygGncx8z/MzwI
         u5c4sm1FsclStuyY3E6Ys/6DDyr0PEUvRMv5K8soFja0MEg11TfxGSLIpGkEJbXu455e
         qFGHSvIh+4lGzDTYpgl7sKPAz6MefJiBXkbq66dKMjtlrbWaE4oE5He0o+LXapwZKEdJ
         HPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119079; x=1792723879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Yzu8glrSiVcPVBKtq1mDlwwIGvowgBD7oCGZg/F8NY=;
        b=W69g3ewiGJ2uiuX/AsTlmmtouM5zJSl0q2yGfdqxOb6pdfBWDKGmbXLN6MTsPfGa+7
         mlThM5pSPA6VzStCNUUVDd86CYF9t7OB+SbvFPXkt7HE1FTCOd94kQewFRqT9WOYGpTM
         hoI2M+pyKh1qvsswhtESrvSK3dMvFcOGR592RQtqHzriAod//zIzI2kPgkvTer9KHiON
         yNHSPnvO7oUAmp1yZ7YyEIj2zAL+xaQmuyXGmkrBSnemtr8uNQ4Q9wUAem/ipkWzwU1W
         q+HY7oLt1118ROqdoTgE/kARkO8xt92EPCpu+A0QHnvAiNRef1dB4LkVTWiV0H6Lm4BD
         0a6A==
X-Gm-Message-State: AFq9FYLuIkgxcc2xs0dziQnP+gs0Hp43L/QQvoNkHt5R/FUAOK0pfSKn
	WvabNPn/yR3bx2oJ3hgmAhw8MX2yXyyiGooAczeO7FtcJvV2v39XQ3cf1AuXIMlbFfWclbGpyL4
	BnMH6LmKyzXcjy0bCH8jrL9eWlu1T/IB/Od6b
X-Gm-Gg: AYBFou2XvoZ9MBcqCIjqBGdjr5i4e1B20h+Vzam7kCNp38aX93olGKMEsBMW+V4Oz6w
	CfcBSn9g5boJaKTA/r8O59nHBqc68xcM2cu2W34pQkx9sGyp91QT4sjgHOv8kELSmQrLwDrQOmS
	PZlOV/kM7fihjeofFQGlUatjsT4dQq2Br6fUuH+AlQdtHUNdUT7Cp8EH9yNOvHgTjZp6l33N1wn
	cObvd12N5VjFhGhaUezEy4LkQIl1Dq4SWuRYRps6f3uvQ89di7a99WzHLLw2Z6/R1r2Cpnof+EQ
	Ofs6HEOlYta4xrN7/clKz4XeHF+B9b/UBr0Q8+o3hG/X61NAO9LT73trRDCyJE8iOnrrMZcR4vc
	8GDPNmsVm5BoUszB5TFxmg9PPF0v6YyCc5BA=
X-Received: by 2002:a17:90b:4f83:b0:3ac:d17c:2a70 with SMTP id 98e67ed59e1d1-3acd17c2cc4mr629128a91.62.1792119079019;
        Thu, 15 Oct 2026 19:51:19 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acbee7ae31sm950974a91.7.2026.10.15.19.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:51:19 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [IPv6:2620:125:9025:23::2ea])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 3A4BE400B8;
	Thu, 15 Oct 2026 20:51:18 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 37D0EDC12FA; Thu, 15 Oct 2026 20:51:18 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net v2 1/2] kcm: defer receive parsing when the lower socket's read_sock may sleep
Date: Thu, 15 Oct 2026 20:44:53 -0600
Message-ID: <20261016025059.289202-2-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261016025059.289202-1-rjethwani@purestorage.com>
References: <20261016025059.289202-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

psock_data_ready() is the lower socket's data_ready callback and can
run in softirq context, under read_lock_bh(&sk->sk_callback_lock). It calls
strp_data_ready(), which, when the socket is not owned by a user,
invokes sock->ops->read_sock() inline to pull records out of the
receive queue. For a plain TCP socket that is tcp_read_sock(), which
does not block.

A ULP may install a different read_sock. kTLS installs
tls_sw_read_sock(), which can sleep: it waits for an asynchronous
AEAD to complete via crypto_wait_req(), flushes the socket backlog
through __sk_flush_backlog(), allocates with sk->sk_allocation, and,
on reader contention in tls_rx_reader_acquire(), enters
sk_wait_event()'s socket release/reacquire path despite the zero
timeout. It passes nonblock, so it does not wait for data, but these
paths can require sleepable context, which softirq and a BH read lock
do not provide. Attaching a kTLS socket to a KCM multiplexor can
therefore sleep in atomic context.

With CONFIG_DEBUG_ATOMIC_SLEEP, a loopback TCP connection using software
kTLS RX, with the receiving socket attached to a KCM mux, reports:

  BUG: sleeping function called from invalid context at include/linux/sched/mm.h:321
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 189, name: ksoftirqd/34
  Call Trace:
   __might_resched
   kmem_cache_alloc_node_noprof
   __alloc_skb
   alloc_skb_with_frags
   tls_rx_one_record
   tls_sw_read_sock
   strp_read_sock
   strp_data_ready
   psock_data_ready [kcm]

Keep the inline fast path for tcp_read_sock() and hand any other
read_sock to the parser work via strp_check_rcv(). The work runs
do_strp_work() under lock_sock(), where a sleeping read_sock is fine.
sk->sk_socket should not be NULL here, since KCM holds the lower
socket's file reference while a psock is attached; if it is,
defer as well, as strp_read_sock() would not read without a socket.

The deferred path also skips strp_data_ready()'s need_bytes early
return. That check counts bytes in the TCP receive queue, which for
kTLS is ciphertext rather than parsed records, so it would not be
meaningful there. Without it, a data_ready event can queue work that
finds no complete record and returns; queue_work() does nothing if the
work is already pending.

kTLS installs tls_sw_read_sock() by replacing sk_socket->ops with
WRITE_ONCE() in update_sk_prot() when TLS_RX is configured. That happens
under lock_sock() only, and can happen after the socket is attached to
KCM, so read it with READ_ONCE().

The deferred work runs on kstrp, which is currently an ordered workqueue
shared by all strparser users. The next patch makes it per-CPU, so a
psock whose read_sock does software decryption does not hold up parsing
for other strparser users.

Tested with the reproducer above: 5/5 runs produce no splat and full
datagram delivery; without this change every run hits "BUG: sleeping
function called from invalid context" in strp_data_ready ->
tls_sw_read_sock.

Multi-record messages (>16 KiB each) also deliver completely when kTLS
RX is installed before the KCM attach and the entire stream is queued
before the reader starts: the parser correctly pauses on KCM flow
control (psock RxPause/RdyRx) and resumes on read, with no strparser
need_bytes stall.

Fixes: 662fbcec32f4 ("net/tls: implement ->read_sock()")
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/kcm/kcmsock.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 71af69d442f2..ec7aaba17fe6 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -30,6 +30,7 @@
 #include <net/kcm.h>
 #include <net/netns/generic.h>
 #include <net/sock.h>
+#include <net/tcp.h>
 #include <uapi/linux/kcm.h>
 #include <trace/events/sock.h>
 
@@ -348,6 +349,30 @@ static void unreserve_rx_kcm(struct kcm_psock *psock,
 	spin_unlock_bh(&mux->rx_lock);
 }
 
+/* strp_data_ready() calls the lower socket's read_sock() inline, from
+ * softirq and under sk_callback_lock. That is only safe for TCP's own
+ * tcp_read_sock(); anything else goes to the parser work, which runs
+ * under lock_sock(). Called with sk_callback_lock held.
+ */
+static bool psock_can_parse_inline(struct sock *sk)
+{
+	struct socket *sock = sk->sk_socket;
+	const struct proto_ops *ops;
+
+	/* KCM holds the lower socket's file reference while a psock is
+	 * attached, so sk_socket should not be NULL here. Defer if it is,
+	 * as strp_read_sock() would not read without a socket anyway.
+	 */
+	if (!sock)
+		return false;
+
+	/* A ULP's read_sock, such as kTLS's tls_sw_read_sock(), may sleep.
+	 * READ_ONCE() pairs with the WRITE_ONCE() in kTLS's update_sk_prot().
+	 */
+	ops = READ_ONCE(sock->ops);
+	return ops->read_sock == tcp_read_sock;
+}
+
 /* Lower sock lock held */
 static void psock_data_ready(struct sock *sk)
 {
@@ -358,8 +383,12 @@ static void psock_data_ready(struct sock *sk)
 	read_lock_bh(&sk->sk_callback_lock);
 
 	psock = (struct kcm_psock *)sk->sk_user_data;
-	if (likely(psock))
-		strp_data_ready(&psock->strp);
+	if (likely(psock)) {
+		if (psock_can_parse_inline(sk))
+			strp_data_ready(&psock->strp);
+		else
+			strp_check_rcv(&psock->strp);
+	}
 
 	read_unlock_bh(&sk->sk_callback_lock);
 }
-- 
2.50.1

