Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793515463;
	b=r+W9GlwsjL6OXMF9DxQuT+atcFd4281L9rFb5RIUaysswhOJN+glvXJp0lsopBmnTAqZ
	 Z9ifhzHSheoqFEwP52wDyQLogW/WSkt0MeRhTjY++FkM9jyJUd6JJuFGve6kFCErMnEyd
	 cOn7d3ScNEZtYx01F91KIZGOViSJJ9Ee1Ohz2OkaWLZ5zRgoE/P2dYLNA8d16ytjk/t71
	 pSrH9EUBMfabIrJI7s833778stIuFVFNvt4d9a4Uc7hkltWV8AHy7u5R9AMoe7OYpVdK5
	 H7J+DrK3gEXIWnhp6vzrY5n7VSx4KmDyJ2Ixwix/98bfV/+ukf27mAY69sybdNyE0xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793515463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=iwkIcvW356hY+a5RZFPTmcdpZufrBHQDQQa4SRFI7U8=;
	b=OIQmZlXHhphEnvOHLk8hFaYA3l0PRnuMU1lDz/7ssqV46rYAUUmT6BK73CXMU9+VOSaR
	 0gEOp82jhdUVitqiPkrmd2g3Qs8kKRJzRXK8NqR/S2/SvGB2MdlxihWHSIirMZjW8mA1p
	 2Nfx4s9qMG8y35ZXRuygY1HQEzXlvPTcp4rjE0CZ2MWoBQys2qPshv1XKPmOYUpvywVZ0
	 e81w2JUC3Z2TVIjZCZ0zEN65MIok/p84+KBic/WGOQAI30XTyLbqSTy8spPNgPIU7iKWo
	 g1H8uSCZEjCfjJfyX5RspPI0C6WV18VOCHuA1777QIR8fSyftBsq/xmdRfOaY7vclBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iikhb6HO;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952B6606A329
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 06:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 952B6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iikhb6HO
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d5dbso1578934a91.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 23:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793515462; x=1794120262; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iwkIcvW356hY+a5RZFPTmcdpZufrBHQDQQa4SRFI7U8=;
        b=iikhb6HOZw0PVJNGv6aagI1n8z2L5KCZ1irCxHGJ5ailJu5xNnmg4zLM3bO1t7k+My
         /qzMOCWyqTThI/iCBsPJpUZN9x7X18r+z7plvdWIFtvgaPkExUldpgUs+q3bT6QoIIoB
         ycz7a9NHkgQtB+ArdHqHm4k5EnvURHD/piUJA1kmH/RDpxTU4ZIjUyhU67jSg4heqCls
         RbOjaNB21HJLdaTHUy3zRTY43J1JoCywEZqq+voUqr4/ORlJSYG0pjjldmLCyeWG8yrM
         LEpndAzlLPYU6jK8LUETd7hsupS3fHhdkQ3sGuzHlWWJmPsj9iGMFIcshJcOVbao68p8
         VdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793515462; x=1794120262;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iwkIcvW356hY+a5RZFPTmcdpZufrBHQDQQa4SRFI7U8=;
        b=FTovwLCJkY1NsRdfAUM5drECQw88ndLSMGrRQl4T1jn578J71QYffNjpsKWalnephP
         MvkI9WKUHQ+GOZ5zPaKH36uCh3KPUVxIQ3taK7ycFIDt6lYPlTx2GWxfkkxUDJUiY9aH
         TgnCujfM400hdAi4a2wDWcR/7LACBX9Ix+8EX+TS0dBv/1aJM7mRaOLNOw0S7SWzrRiK
         nBXb23OH5oSAIz/aOqOb3QtbLhBz3lIcq7JyGDKiT31MvQtoWGrF2AhoJxyVAx4ogQCk
         IV9BsCu4A4ofkgvCv4V80mWBt7kMfr8l3Zpj3EaOrP4RxXO1Mn9uXIn+SGQQOew/yBb6
         OokQ==
X-Forwarded-Encrypted: i=1; AKwUvByrLNqmJravUHXGY+Q947WVYsAdZrLSWYB9jAXazea15U38GBxGfelKxh9nhwoFE/MDsLcIHAk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nBaormE4lfd1tgfaMcAdEUPnGjLdlBHa5xZmAdrhUXkzvzSRo
	nUAZDn2ZUo6RY3YBuMILkfsr6JXfboqx9mCYyjZzslZkiY47L4GYZc/m/cwuKGzTZgBsfC4bsYH
	4i2UuTw==
X-Received: from pjbci22.prod.google.com ([2002:a17:90a:fc96:b0:3a8:d9d:78ef])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a8f:b0:3ab:413:49b6
 with SMTP id 98e67ed59e1d1-3ae89787ee3mr5558440a91.41.1793515461788; Sat, 31
 Oct 2026 23:44:21 -0700 (PDT)
Date: Sun,  1 Nov 2026 06:35:23 +0000
In-Reply-To: <20261101064418.2055158-1-kuniyu@google.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261101064418.2055158-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261101064418.2055158-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/3] ipv6: Flush rt->from in rt6_uncached_list_flush_dev().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jason Zhang <jdz@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a device is unregistered, rt6_uncached_list_flush_dev()
iterates over uncached routes and switches the dying dev
with blackhole_netdev.

However, rt->from could be cached via sk->sk_rx_dst and
hold the device reference.

Then, unregister_netdevice() gets stuck with the splat
below. [0]

Let's release rt->from in rt6_uncached_list_flush_dev().

Note that ip6_rt_copy_init() could set rt->from even if
in6_dev_get() returns NULL (e.g. mtu < IPV6_MIN_MTU is
set concurrently).

Also, rt->from->nh could be replaced with another device
than rt_dev and rt_idev->dev, and in such a case,
nexthop_flush_dev() sets fib6_destroying before
rt6_uncached_list_flush_dev().

[0]:
unregister_netdevice: waiting for dummy2 to become free. Usage count = 2
ref_tracker: netdev@000000006fb9da8c has 1/1 users at
     netdev_get_by_index+0x14c/0x170
     fib6_nh_init+0x1ae/0x1950
     ip6_route_info_create_nh+0x15d/0x780
     ip6_route_add+0x55/0x150
     inet6_rtm_newroute+0x15d/0x1360
     rtnetlink_rcv_msg+0x606/0x710
     netlink_rcv_skb+0x14f/0x2f0
     netlink_unicast+0x71b/0x940
     netlink_sendmsg+0x595/0x840
     __sock_sendmsg+0x119/0x150
     ____sys_sendmsg+0x3e9/0x5c0
     ___sys_sendmsg+0x157/0x1a0
     __x64_sys_sendmsg+0x119/0x170
     do_syscall_64+0x109/0x330
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 93531c674315 ("net/ipv6: separate handling of FIB entries from dst based routes")
Reported-by: Jason Zhang <jdz@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/route.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index fae698c5522b..2eb884558c24 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -179,12 +179,20 @@ void rt6_uncached_list_flush_dev(struct net_device *dev)
 		list_for_each_entry_safe(rt, safe, &ul->head, dst.rt_uncached) {
 			struct inet6_dev *rt_idev = rt->rt6i_idev;
 			struct net_device *rt_dev = rt->dst.dev;
+			struct fib6_info *from;
+			bool release_fib;
+
+			rcu_read_lock();
+			from = rcu_dereference(rt->from);
+			release_fib = from && from->fib6_destroying;
+			rcu_read_unlock();
 
 			if (rt_idev &&
 			    (dev ? rt_idev->dev == dev :
 			     READ_ONCE(rt_idev->dev->reg_state) == NETREG_UNREGISTERED)) {
 				rt->rt6i_idev = in6_dev_get(blackhole_netdev);
 				in6_dev_put(rt_idev);
+				release_fib = true;
 			}
 
 			if (dev ? rt_dev == dev :
@@ -193,6 +201,12 @@ void rt6_uncached_list_flush_dev(struct net_device *dev)
 				netdev_ref_replace(rt_dev, blackhole_netdev,
 						   &rt->dst.dev_tracker,
 						   GFP_ATOMIC);
+				release_fib = true;
+			}
+
+			if (release_fib) {
+				from = unrcu_pointer(xchg(&rt->from, NULL));
+				fib6_info_release(from);
 			}
 
 			if (rt->dst.dev == blackhole_netdev &&
-- 
2.56.0.317.g454f8302e1-goog

