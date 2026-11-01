Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793519589;
	b=pA0Fs3v57e1ODjxkmSVaZycWhuRgenSzSg60H4u1xD8fOz9wCOrjbtDeRBSkRLmVhFDy
	 wXv5brKFM9qhul/BatQtTIq7LyeZzt58ptouxqhX8DejoqYru/lLIioIPDJzGqn3lBbYC
	 JSGV/Q9Gw2ERUbk+66DVMsSs3mqtPqIz0zmgpKEw+07vlxWWzT2l/8HRb2hBl1BoUHSu7
	 RkN+WmRP7mqpVKJDs0xiOascCiYlHVDHBYkEMybYPl6r44AqxwRaMR+COaotA7rGFAFWE
	 3KpCOhKXW4F+obyiQJ7hzsScEZ3pijxhp/0JzraU3qrGmxNwpIwdj3tuLmBZkqhheiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793519589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=OuHPb5BnUNYHQ7S5xQzTpeXYGXd1c8j2VbkTuL8vhYQ=;
	b=FPz+YHKs8MvlZm5ly1lJSbVZ/M6B9m+ISOUkjgW+R2Q2teUgzwcnkeaYJD5wTlbzA+jN
	 KLeSLFWpvKc2ktMw+Ebr7UvIUO8PSorymr881cgWZfXZWvJOb1OvGiT0910aPg4fqnXHl
	 TQwKUa/yN0NTOjz4DROh7BXlSyrZAbhL8pXYHOqvpNCnyXsAOLGWtvhP7ErNvSpY6YavO
	 TO1P4xhQgleMEvXMyT9u2OFc/5sJEqs5OSo2WKm8rrjQ+vvKDPTIVg8+QuyohBUoNWCbs
	 /EwY46qTwUN8FXH3nuegYIRRC2n0xhbGUPb/Ky/Xi9pd5v3tJnCjcuFOHvfwnOu3omA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sgzhang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T5AkWNou;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDABC606A325
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 07:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDABC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sgzhang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=T5AkWNou
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc7e92f36f9so1508338a12.3
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 00:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793519588; x=1794124388; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OuHPb5BnUNYHQ7S5xQzTpeXYGXd1c8j2VbkTuL8vhYQ=;
        b=T5AkWNouwodDcP4IB/ERF7vG+QYJ998+5MCCQmxB2ZGHS6tXoBOmjNdbUv4FKUM3D8
         5G9NLLyDQG6+I012g77byWxcIe8w/De1g73KAmFICtWBcN9KWmo2OdD/hIbLa+Ne/jOk
         AJSqikeX4CCx8IdCyajGJtTV3oTlRy0n1qKC4anRFY7SIjLn5gqpXxd2kdP+9hkYtUTl
         u9ej/hvWYRPxNSYs68mx0GJHBlMnhiR55cTBh9Jzuo25vW//NasU389GrAw3mbg6WHFu
         btuISQbbuZVbuJWDosHDCU+vQaOQ5GD5S/ZGTVeIP2ybT7hvxC4Vmg/VNIIGLeyoesXX
         0CkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793519588; x=1794124388;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OuHPb5BnUNYHQ7S5xQzTpeXYGXd1c8j2VbkTuL8vhYQ=;
        b=SrH/R0777/DSjLiP06R0ujUN+v5iLrqIQ4yQVvcXQZuB50XjspHL9srWDR61VQA2vD
         A/sd0MR031CAIPICmFCc65uoaqMaPICsd/EMDlJZpbs0thV/s/sm4/vw5xzfrEbEz91V
         5rDMp5XmZkjmrFDLrYA0qrlf52eNuXZuXkYOfHtobjz8FhdKlSlboWDO2qLZDACVh7wN
         L1BDwEJzc9WLdOKhHKkVTyUloiSwPVH9Ub8rctRFLFTc6Kaeaa0JVPEoO8xSYnXePZTD
         y7Aoz7sPXrgrYyJkzkFY0G6yvLplKroL17WvYJWl8oyI1vRK39KPPgagh+eMqOuyYjT5
         dqDQ==
X-Gm-Message-State: APuU4Z9JN/biuCAFhLEeaIf4CkLy+FeoL1SWMYspGIhFLZZtjYqdCBfz
	HQTFKYD5+C6P0EZDzsY2om8aBlD7+WR9AqtDTf7pafotCLo7UZ15KQ8Awj4cYj/DZQe1CrknKIM
	1pIS0Bb/9Rc9XiWEnYhFitKBXHnthzgyC+XzlEI5qUT4oWV/bTbw8HoZINri9JWwMKd3LSN4ubf
	w44DAYa4/dUBXeltOkMZ9LYKclygE8dOFVeZn9LGG4VQ==
X-Received: from pjyt8.prod.google.com ([2002:a17:90a:e508:b0:3ae:7abe:56ae])
 (user=sgzhang job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e70c:b0:3ab:2737:3393
 with SMTP id 98e67ed59e1d1-3ae89835d94mr5728121a91.40.1793519587822; Sun, 01
 Nov 2026 00:53:07 -0700 (PDT)
Date: Sun,  1 Nov 2026 00:51:45 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261101075145.698399-1-sgzhang@google.com>
Subject: [PATCH net] net: count last skb of each sk_backlog pass in __release_sock()
From: Ray Zhang <sgzhang@google.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Decotigny <decot@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ray Zhang <sgzhang@google.com>
Content-Type: text/plain; charset="UTF-8"

Running 500 concurrent TCPv6 streams (neper "tcp_stream -6 -T 1 -F 500")
on a 2-core Cortex-A53 (CONFIG_PREEMPT_NONE=y, HZ=1000, LATENCY_WARN)
triggers resched_latency_warn() in __release_sock():

  [ 3655.311821] sched: CPU 0 need_resched set for > 100006892 ns (100 ticks) without schedule
  [ 3655.311889] Call trace:
  ...
  [ 3655.311944]  resched_latency_warn+0x7c/0x88
  [ 3655.311958]  sched_tick+0x1c0/0x418
  ...
  [ 3655.312578]  net_rx_action+0x238/0x438
  ...
  [ 3655.312641]  do_softirq+0x4c/0x90
  [ 3655.312651]  __local_bh_enable_ip+0x84/0x90
  [ 3655.312663]  local_bh_enable+0x1c/0x28
  [ 3655.312674]  __dev_queue_xmit+0x4a8/0xb00
  ...
  [ 3655.312782]  tcp_v6_do_rcv+0x240/0x5f8
  [ 3655.312793]  __release_sock+0x9c/0x188
  [ 3655.312806]  release_sock+0x150/0x168
  [ 3655.312817]  tcp_sendmsg+0x4c/0x70

__release_sock() can loop past 100 ms without calling cond_resched():

- Each outer-loop pass drains sk_backlog, but "if (!skb) break;" runs
  before "++nb", so a pass of B skbs only adds B - 1 to nb (0 for 1 skb).
- With 500 TCPv6 streams and NAPI sharing two Cortex-A53 cores, runnable
  tasks keep TIF_NEED_RESCHED set on CPU 0.
- During spin_unlock_bh() and TX softirqs (__dev_queue_xmit() ->
  local_bh_enable()), tcp_add_backlog() coalesces arriving pure ACKs into
  a single tail skb.
- Repeated 1-skb passes never advance nb or call cond_resched(),
  triggering resched_latency_warn() after 100 ticks.

Restore the do-while loop and drop "if (!skb) break;" so every skb
increments nb across passes and calls cond_resched() every 16 skbs.

Reproduced the issue and verified the fix on two 2-core Cortex-A53 hosts
(CONFIG_PREEMPT_NONE=y, HZ=1000, LATENCY_WARN, latency_warn_once=0) with
a userspace reproducer over /dev/net/tun:

- CPU 0 runs a TCPv6 sender and a second runnable task while CPU 1 writes
  pure ACKs to /dev/net/tun (~30k TCPBacklogCoalesce/run), sustaining
  1-skb sk_backlog refills in __release_sock() for ~400 ms (ftrace).
- Before: CPU 0 stayed unscheduled in __release_sock(), hitting
  resched_latency_warn() 293 and 275 times on the two hosts (> 100.9 ms).
- After: cond_resched() yielded CPU 0 inside __release_sock(), with
  0 resched_latency_warn() hits on both hosts.
- Also observed no regression with the workload from
  commit 16c610162d1f ("net: call cond_resched() less often in
  __release_sock()"), "super_netperf 4 -H srv -T,10 -l 3000 &".

Fixes: 16c610162d1f ("net: call cond_resched() less often in __release_sock()")
Cc: stable@vger.kernel.org
Signed-off-by: Ray Zhang <sgzhang@google.com>
---
 net/core/sock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index e7405be8941f..e2401d735c5a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3333,7 +3333,7 @@ void __release_sock(struct sock *sk)
 
 		spin_unlock_bh(&sk->sk_lock.slock);
 
-		while (1) {
+		do {
 			next = skb->next;
 			prefetch(next);
 			DEBUG_NET_WARN_ON_ONCE(skb_dst_is_noref(skb));
@@ -3341,12 +3341,10 @@ void __release_sock(struct sock *sk)
 			sk_backlog_rcv(sk, skb);
 
 			skb = next;
-			if (!skb)
-				break;
 
 			if (!(++nb & 15))
 				cond_resched();
-		}
+		} while (skb);
 
 		spin_lock_bh(&sk->sk_lock.slock);
 	}

base-commit: cb284914e749388eef402938bdb3115fe1f6d337
-- 
2.56.0.317.g454f8302e1-goog

