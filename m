Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319490;
	b=pLRVGsQ33XpKAR9ii7YWj8uCC9qY9t62KS4rdmEcV3Vhgc7YBl42+q6OWE+h3g3uycco
	 TUm7SVQW71B4YH2zsH3o+1CFC/P/ALHozv32sZ5QeKo7KjT+4mR76sGiqLyDi/wg6gVlk
	 esgOlFl4ujJ7B78krKq9i48hsk0ftvrKWf1E7xhskbFAqJc+elaQF6vgf9PxH3q+KBIwo
	 +cix/CxdOnVRuYj2lvH77Eog0pmtRVuV8G1/rLxsUxvqmQJ7UVSGMMNQYh9Vnt+p6Qrlf
	 YXt13ETB8GA1Mc9qNGZgjA+mjmQfuewkk6A9hwcCuV6bmuHv0tHGyQuzkKsXiZib6MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=zBuXy9jdTVr6pR6g2vkAz5ct9RzLM8u8jpsiIH1qYk4=;
	b=0yCN149iGbbj9QFFYU5CKxwKupat85tRrzf3oiAouU7Q/KN5vMMAh3VR33O5Jyry55gU
	 DiOO34zjRb32jvT8PbMIWwvC7gSIBuUahvFp1l7HY0vlyIyX9nTwcfRhnWVEJdTiEdFz7
	 BYojcJv3C+KcS8y+lRmLTggUBeGgPuC5mY9d9SkcOcW8tLuiNP4IuKHtMxuLNG8rih1/K
	 sduv/9xOjN3ixWBLWkUanzIOCLampuD48z9ZeoZatkf6XG+g9KmFm9Qgibp3HXZW0b41T
	 lXqINjBfRopzoUn3qahY8Xx9dejWBOCBSmL9KVQNO4S88Es3Gq+/ADJDZjWS+HsK0Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aXWtJTf3;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974F160A380C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 974F160A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aXWtJTf3
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so1460158b3a.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794319489; x=1794924289; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zBuXy9jdTVr6pR6g2vkAz5ct9RzLM8u8jpsiIH1qYk4=;
        b=aXWtJTf3k6V4BiAiCWZ+e3KUO2J6V08EUL9bxzmP8GVZv5uJ4uQPeiSGlPQyIffrp5
         D4I3aLrJ4JerZvzP5Dg3z6l0oRWtzVMlGKRR6dpJNSiBbvuiRIrrT2EMOjczFUk3LT/v
         d9viXKjN4g60bCdkxh2E3C5QzHG5fejkbVSHunjvLc642qYmoR35fHWNYQukT/rRuZNS
         t3JyFE6ege7iglA+/fuzMs8dElwSr/bZ5kt1SaENqoGg5c8MiVUfmuoWcEFgPPD4iLcn
         eqZx3SuwwCkP3nr9KGHCGedtz1KZ+jyAQJK2FxCdnFhUtEP4yjr02cnootS5lMDGz08o
         CRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794319489; x=1794924289;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zBuXy9jdTVr6pR6g2vkAz5ct9RzLM8u8jpsiIH1qYk4=;
        b=1ZHNgD/NgJDvUa1eG1ntZzUPNdX+jDys7pnsGYRA+SY0KFpfGVeW9gXfde+z1QHD6J
         m67qnZAgrOybewa8ZDo8O7js77YF3sBU4TzGDkcAuFyB17Otr/PPa9h+8o62aiWHdAzm
         LrBnlgH7LvCRsRs+/bPTOTAVHn+4UxY5RNkOndfzCMRJr3PpPlsE0s+xhrHHEoMlIjsu
         9fOXNnnrcIB47XiUKEKephVjM7TIynq+LxVSCFuqvdlryfF5r6OPUjWvEy8mGsjTSlsc
         NszEDgS9dPgZBs0p5cLuGmapnDzKDkevGuz2Bc02gYqGN2/3AtcXAy5AZYQ8XSGJZk0W
         X7NQ==
X-Gm-Message-State: APuU4Z8Q2oohieYsXaJGMsK/x7kYjlHTzNnJDlqezFCyER2PxZ59rLyZ
	ZmkWXa9jtH3tM+AbVac6EAgVbL5vgYM9sgLLgewqEDd4qXBf1NrQ+3FL
X-Gm-Gg: AYBFou2wHmRzX5sgmhi/Qrn2hcV7EMqdyFy469i5Ix1SXGs/xypktzNiycN9N1gwXgV
	a8ATK1xGrIcSgE7AJvjHnh3zEVO5AwlnK3yzwDsmhHSN6TEV9uJe4L7r5a7QzQ8J+cbKSJB6JzI
	FcdnnRc4gQsvLZS+c0blW9vs3fDDO+10rWrMkihw6SUUYLwDw1ht5vT3lLNT+F0+bwD7ij8A1cV
	vU7ss4s3MnRavfWo7YkDenesHe66IlEBr6VfnnKurqLPhXk2yH3FJKDe2gm4fGK8+x0JVq00M1G
	zjCp1Crdu9Vn2cI7Kx/vx6R+VP+RihNDufj2JEEIuWBkPh9CApUHyjG5G1T40j2n7UI9SUW49/C
	dmAJB0jKXID03sNIFt5fuKO/T6QUN5UffPTtwlOeslm9zDxo4VnCn5loSOZmFe+d7k9wtPjNySr
	uqSEV8vCCUljZLZqrFhcuoayYjF+AiA3p8jSjB3T9hv1v7VfgIE6CtIsHd+rULi4qUPDQK4CsPY
	Sc5e9EgHTlmq0nvzxGMI2jz5wNyuu6VCLG4gLRcUKZ6zWrfr6MJrBzQ5yFys+k4t1J3oprfkNYC
	ovTVNc08InRttV7UIWxCosw68nJHCa17zLuD5/yElKaQymcs
X-Received: by 2002:a05:6a20:3d07:b0:3e9:15c2:83b5 with SMTP id adf61e73a8af0-3f190990c5amr2907012637.74.1794319488789;
        Tue, 10 Nov 2026 06:04:48 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d5eb471sm778468a12.2.2026.11.10.06.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:04:48 -0800 (PST)
Date: Tue, 10 Nov 2026 23:04:44 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] tcp: fix NULL pointer dereference when restarting a
 Fast Open listener
Message-ID: <avMkfJrXhCFXn8M_@v4bel>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a valid RST is received for a Fast Open child accepted before the
three-way handshake completes, reqsk_fastopen_remove() adds the
request_sock to the listener's RST list if the listener is in TCP_LISTEN.

An application can call shutdown(SHUT_RD) on a listener socket.
inet_csk_listen_stop() checks rskq_rst_head without holding
fastopenq.lock. If rskq_rst_head is NULL, it does not acquire the lock
and therefore does not synchronize with an insertion by
reqsk_fastopen_remove() after that function has passed the TCP_LISTEN
check.

The more likely outcome of this race, even without a subsequent
listen(), is a leak. If reqsk_fastopen_remove() inserts a request_sock
after inet_csk_listen_stop() observes an empty list and returns, the
request_sock is stranded in rskq_rst_head and keeps a reference on the
listener. The socket is already in TCP_CLOSE, so a subsequent close()
does not call inet_csk_listen_stop() again.

If listen() is called again on the same socket before the delayed list
insertion, the insertion can overlap the queue initialization in
reqsk_queue_alloc(). If it occurs after rskq_rst_head is set to NULL but
before rskq_rst_tail is set to NULL, rskq_rst_head points to the
request_sock while rskq_rst_tail is NULL.

When a valid RST is later received for another accepted Fast Open child,
rskq_rst_head is not NULL, so reqsk_fastopen_remove() attempts to write
the request_sock pointer to rskq_rst_tail->dl_next while rskq_rst_tail is
NULL. KASAN reports:

  BUG: KASAN: null-ptr-deref in reqsk_fastopen_remove+0x147/0x210
  Write of size 8 at addr 0000000000000088 by task swapper/3/0
  ...
  Call Trace:
   <IRQ>
   ...
   reqsk_fastopen_remove+0x147/0x210
   tcp_check_req+0xa70/0x1060
   ...
   tcp_rcv_state_process+0x1cb/0x2ae0
   ...
   tcp_v4_do_rcv+0x1fe/0x740
   tcp_v4_rcv+0x1744/0x2070
   ...
   ip_protocol_deliver_rcu+0x5c/0x280
   ip_local_deliver_finish+0x171/0x330
   ip_local_deliver+0x107/0x370
   ...
   </IRQ>

To widen the race window, the issue was reproduced after adding
mdelay(3000) immediately after reqsk_fastopen_remove() checks that the
listener is in TCP_LISTEN and immediately after reqsk_queue_alloc() sets
rskq_rst_head to NULL.

Make inet_csk_listen_stop() acquire fastopenq.lock regardless of the
value of rskq_rst_head and detach the list while holding the lock. With
this synchronization, reqsk_fastopen_remove() either inserts the
request_sock before inet_csk_listen_stop() acquires the lock, in which
case inet_csk_listen_stop() reclaims it, or sees that the listener is
not in TCP_LISTEN and does not insert anything.

Fixes: 0536fcc039a8 ("tcp: prepare fastopen code for upcoming listener changes")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Drop the reqsk_queue_alloc() locking hunk and keep only the
  inet_csk_listen_stop() change. (Eric)
- Document the more likely request_sock leak and the listener reference
  it holds. (Eric)
- v1: https://lore.kernel.org/all/avGpsTb2hsGIjSRk@v4bel/
---
 net/ipv4/inet_connection_sock.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e56beec438773..b9f3efb671017 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1533,17 +1533,15 @@ void inet_csk_listen_stop(struct sock *sk)
 		if (!has_current_bpf_ctx())
 			cond_resched();
 	}
-	if (queue->fastopenq.rskq_rst_head) {
-		/* Free all the reqs queued in rskq_rst_head. */
-		spin_lock_bh(&queue->fastopenq.lock);
-		req = queue->fastopenq.rskq_rst_head;
-		queue->fastopenq.rskq_rst_head = NULL;
-		spin_unlock_bh(&queue->fastopenq.lock);
-		while (req != NULL) {
-			next = req->dl_next;
-			reqsk_put(req);
-			req = next;
-		}
+	/* Free all the reqs queued in rskq_rst_head. */
+	spin_lock_bh(&queue->fastopenq.lock);
+	req = queue->fastopenq.rskq_rst_head;
+	queue->fastopenq.rskq_rst_head = NULL;
+	spin_unlock_bh(&queue->fastopenq.lock);
+	while (req != NULL) {
+		next = req->dl_next;
+		reqsk_put(req);
+		req = next;
 	}
 	WARN_ON_ONCE(sk->sk_ack_backlog);
 }
-- 
2.43.0

