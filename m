Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794222521;
	b=mWGdjGJ4teiF1AMUrsvYqWquhlhF5Owa4Mk6HhNpOKzSthILPyC0kfBVO7SlGc10rAU0
	 /jd5QxuisdMscqkAnLIzfGnhy0MGSSOTwxQlCgZ8mVoLzA0Xrbh2VCxbXy4TpVr0FBybr
	 qQCcnd/cR7fLBZXK8HuUfMQSWWOPnVJyNlkLGSvcIdtzN608KVgT/14hve049xVJJoZJD
	 FNFE06fCLRp5SVsNORKOwwKx/zR+OhmVo1XLub2+/muVahw0y8Pi0Qjlgy/sj8u7u/+y3
	 2PVuNMeEaWGejw19WViMvY92fS7QcXpmZEYGSx48gT0PDdMG/v55x9Bh2IGu/8VSd0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794222521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=fhrbprpRX7kmNcPax1vb/kgVqKCIO1cjiHj/rfQnbXw=;
	b=A6H7R/x2M5k0NZoD3jz/31PQism4qS6nPx6TTMjcNtdK2pHBVDx/W3uoDpHIMOuY3BA1
	 UEw7di2Tro78JoZ3AOpjxm9XF2hqzK563UkmbV0Sp2QPhVVvBaYGMU1bKHqMekRpkGbvL
	 3olN26TSF6UxhV4wZ366cYzIKCxM5cqZNhOTkHKMWM/esDckimxrpsKoqRTNNvT9QofmQ
	 wAmT2l5fSQhJoBxXB7Yi5BTFkUQsMCKETzqC9+vXWtPkFCc/fbL+/73vkHsii3amYpctA
	 NUO/pTk+/xRxOCKDXLFKuouNJqY0l5iFzgh6+UsFbr4cYxFwfRlHQHiVocogizGTvUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fm9inbie;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16DF606A321
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 11:08:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C16DF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fm9inbie
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso385107a91.2
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 03:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794222520; x=1794827320; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fhrbprpRX7kmNcPax1vb/kgVqKCIO1cjiHj/rfQnbXw=;
        b=fm9inbieny49XZbJnYsWzHOb+OWu8/+F21+6PWlDPyDwBUHncJY7UlyJDlXoR+If7y
         BOc684IJvxABsdSZryMhgCqkZJVKVpGHmXOWORLeTU/1WASVXq9DAMJxjMARurZgFprf
         Z+BG8MafRO9It0vRYzkx8wOnQ5eOmn/+ZGTMtFqAypBOi9dozMbMktZfcvUGCMi5F6R+
         DRhDqgiB+LIypBzWzTtWmhVAmwb1YpYmkQ+Y1bZ1JZlMSVfWII3ROeJXXbSS+zW7eaE7
         wxfDRgUmrImKZMtJra8s1qW6c6lGKlo3qhDmStTp1lBqONuh870FPPGUABOSP8mqaFnE
         WpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794222520; x=1794827320;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fhrbprpRX7kmNcPax1vb/kgVqKCIO1cjiHj/rfQnbXw=;
        b=dJZg6tYV9uffUyg8LxOhcy0a5B0ggUt0vDZYsiwmwjY8ye/G+FLixi5RAnzNqykJ6O
         qzZovjOTHuodgHss8xGxuKLoe8Dt+cxaE+b+P9tQ1D/S0wQ9OmOhl8jQD7wcyYku7p9j
         xRY1P83JVDez6YnDLHFqO9btSHan0wEItAf1ZhXJnWmwulf61147vCJ8GtGmEHr3AQxY
         bjQrmm+DwmXZmHK0V+AK7QKdIRdMYl2f7B+EXPT9Lh3mrSDq/W5Zs5bkk1gyOGNIjBah
         nFBI5oeMG5x1jruGqAghV6Ee1sz/vXoxWifvzBXykdveq7WDfx6A9COkiTw8AK3fnWW6
         X5wg==
X-Gm-Message-State: APuU4Z8yP2drJBjA8HqICHZs3EusFfzrJHUX0EvdMZRmy+MGWeNzn8Ec
	2rDnuqPLu1WYU4iuHtEDzDPSQN46zXTWb7WD7/E1QD79d0/O7rp0BI2X
X-Gm-Gg: AYBFou1K3BLtf9JhUG8ttwOXydmrz/CqdT6cHK1sgRgyN4rgmgv+d3WB47tnlQzNblv
	G1cO0K7z1Hkn1F6iq4MRRVFFecJaIV/n+v1WMy6b7Ege/aLgUKLysh3Cu30AN3f/VQFEFY3fWg+
	pHpOeJwJv2JKWXhjGHsVxa+nPgbGkP/d7ccq9v/h9N37BcEHRrRRBFcSKdn/Hstq9OXFMsjMEtv
	vJAQBQM4HjX3c1VXmR8vWHIicKEYw+8Dff9Onk04CGnhd1AoWrtBkOSU8Kf5qYrHZnxYFBnhhjB
	lDy1UKLijYPLwyVgFBcA88poFq+Sn5dxGeuAfj3vE+VmrMH11rhy+lpSVN/paJ+nTP597lM/1+t
	yrmxesJgLGgf5vgy1grvEtGVSaPqDQw6+Hv+z/qjKqcdbqEBB3n7tAB29nLyxXsAB6yMQxDUVQP
	vlYZ2blSVqatZoHhlLUCytj5l5EHZs6jiLsktj7JffRf5lsSNVn94AzT42MjwvzpnuKCyU+eSQ+
	CYB6we9MlTKJ0Rm1/fOjNVMlB3vP5ykDqi4nUYeTZbnhUKpBA2i6i/WY9ziTGm3QXjhSkv1ycvD
	51AIsS0MK0geA2xfSNHhSrQAW9h8+z3qxcL9oWsmWaLrYhP19P4aLmXJI+wa/HJOItw+Lw==
X-Received: by 2002:a17:90b:3e8b:b0:3a7:ab31:2f4f with SMTP id 98e67ed59e1d1-3b12d3556f3mr3600152a91.28.1794222520031;
        Mon, 09 Nov 2026 03:08:40 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b12790bf20sm6389154a91.12.2026.11.09.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 03:08:38 -0800 (PST)
Date: Mon, 9 Nov 2026 20:08:33 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] tcp: fix NULL pointer dereference when restarting a Fast
 Open listener
Message-ID: <avGpsTb2hsGIjSRk@v4bel>
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

An application can call shutdown(SHUT_RD) and then listen() on the same
listener socket. inet_csk_listen_stop() checks rskq_rst_head without
holding fastopenq.lock. If rskq_rst_head is NULL, it does not acquire the
lock and therefore does not synchronize with an insertion by
reqsk_fastopen_remove() after that function has passed the TCP_LISTEN
check.

The subsequent reqsk_queue_alloc() also initializes rskq_rst_head,
rskq_rst_tail, and qlen in that order without holding the lock. If a
request_sock is added between the initialization of rskq_rst_head and
rskq_rst_tail, rskq_rst_head points to the request_sock while
rskq_rst_tail is NULL.

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
value of rskq_rst_head and detach the list while holding the lock. If
reqsk_fastopen_remove() has already passed the TCP_LISTEN check,
inet_csk_listen_stop() waits until the list insertion completes.

Also initialize rskq_rst_head, rskq_rst_tail, and qlen under the same
lock in reqsk_queue_alloc(). Drop the references to the detached
request_sock objects after releasing the lock.

Fixes: 0536fcc039a8 ("tcp: prepare fastopen code for upcoming listener changes")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e56beec438773..5590fc7efb88d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1333,9 +1333,11 @@ static int inet_ulp_can_listen(const struct sock *sk)
 
 static void reqsk_queue_alloc(struct request_sock_queue *queue)
 {
+	spin_lock_bh(&queue->fastopenq.lock);
 	queue->fastopenq.rskq_rst_head = NULL;
 	queue->fastopenq.rskq_rst_tail = NULL;
 	queue->fastopenq.qlen = 0;
+	spin_unlock_bh(&queue->fastopenq.lock);
 
 	queue->rskq_accept_head = NULL;
 }
@@ -1533,17 +1535,15 @@ void inet_csk_listen_stop(struct sock *sk)
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

