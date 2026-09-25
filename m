Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C54EE87A
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369141; cv=none; b=qhLDA9BlDu5pyDCQAK3WsXgOyH0SL4TodZU+vImeAVoxY1yLiE037PkOwc0PLsnUPR6T3PoxZWY/WXj79fUEywg3KAAhsFXlT8UPfpSDa4zwSMsz+MtiAlQl5OXWQj+odxgisjT+5eliJ7BM7NX9B/iABSqawrEQdhHIjvCLb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369141; c=relaxed/simple;
	bh=C9Wk62pJBXEx27wZN7UDhpZWa7Y9qZSKBCXv3NHzM8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CtBtcXoAfwdRhpvAsnhcLl4VqBO4qfJFlszwNi75TElcon/djtG3smTL9MF9qaU3Ibu8f0lK2tGH+V+F/kxoXQxV6N1oALBXk7uZfmAFPLOFHKz3t/1Yo2Fo7sff2xiaineh4UC/E3FWUj5+geFqD7IaGtikCA+l8IBHctCKyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdSzuZBk; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdSzuZBk"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-91400f92ae8so10550176d6.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790369139; x=1790973939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AP5S6TmUpYxXbP0ZPL/AqCAE3OTJR9LcuiFAhggbsis=;
        b=qdSzuZBkOCHQ/fVHubV6HsFeeYJdzstngMnaR0b/b2/NmEBrsEfRYGnAA7GEfg6D2w
         TI1GyqAVFQeAmqNr5mAh/elA8PbVQa9WfLQH3LXHqJj9gMl/bi06QcT1A013NoPDvcHv
         nS/Boyw/ysFB4YwSYgJtZs52Y2WOToeE/XdGOc36U9B108fDXNabV1toevOM3GtFmCaF
         0zOfbOwuYHquw5pO/A/wBUFY0/o+G0Mu/WL4NE5Dk3FvuXpxvU96YdId+24ZT8kNtkGs
         CtUdj0EbAdq5+KPUAquNPzxUAtjKXvpr+AO/wPbE9SRqLthbCev7UQvBHjv2B+rv5LaU
         9Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369139; x=1790973939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AP5S6TmUpYxXbP0ZPL/AqCAE3OTJR9LcuiFAhggbsis=;
        b=DiVtamAjorVdL4kvPAuMS24vYnQ8cC5KdYS/KIb7UG+dq8hjGjyBAacynpmtKzaIHy
         Co2r/mARjoi01OpUoV5C+z50a0Lo/c4P5OCqi3sxlsFxOL8G0Rxquj4YhcPjfj240jWl
         83u/R+Hg+JA8/gpqCAeoHrL30zw1/BnbqtfX17U1/YI2989vzr+GqB6sELXMYf1wt7Pg
         YZnMQ4TMlCfvMs4cnnScqIBmb5quNDre08R+1n/P1/mQwiAf8X3O7+USRFLyAiy0qNLy
         eYEw7b6Y9rcWIF39IpXZgpgz7zhci7zut8TJ2IzC3a1h4UzE5CqhbMJn158znfz2hO5b
         yfZg==
X-Forwarded-Encrypted: i=1; AKwUvBwSvRfbVkydZucRukM6xXPqRXLkxmybaiUpx7UnQ7jv+dCfykDbO6CHXTh2g3nBzGKvTOzZbnc=@vger.kernel.org
X-Gm-Message-State: AFuF++kuGzuNkhoxrskNC5tPScAfbVd/nPPLZE3IpIcbTCN4UONwQH5M
	C4a/+HVJLvmHK0dTv52pJh1ls6voGKqst1aoGdE9dq6BrI7DvUcXZVDP
X-Gm-Gg: AYBFou2jKxdb1ni9T8uE0TVEkeDZXHtMCr42YpNRtHb4JEXcCTRoEZUZ1HAMIYwRjc9
	k2JAH+fltg8UPD54tQeGlaoKJf+J1RMngkdooEOXvgz/HuwlCk9agnnHV5+1vgK7iaFsZk9I6Vo
	e/E68mCuJ5tKy1Fa3t0PYl/0HpZerRwrG/b2utqpUti70xs3xSRmUcBCU01DziojPZG7GWQnvNO
	t0tZ4+cC9rb6KZwIChik1K9sAvobdua8mDtPdvzYgRsmlZlR+b3HtKUEHbBfV1TDfG+Aj1O9Fi7
	e5ghRUB0HLdYwsCm7hLbhhGFjQjRlHQCw1mmguIE2c2SRqKUezWm4+OC+NnviZ/WAwPRxOIiQvm
	h5uAViN9lA65YWMTqRtcZCdrC9UCYnX8zVgu+KRDqtVEoUUZ159qnVye3VJL1mBsViNHi9T1N1w
	nbR4cUacsyt/5GTBxOL7ZAoUTcHozCWVfkXLTr5vgmSUVPJfkykRzNBqTsVpkHE/sp5TJeN/snZ
	aN+zfDEgHA/y43f9T2RgRl3RoSSb8iswGs7+NZdzdGlOY8OfL8Layd3US6kgoYwyQ3nOOu53bb2
	4iCG+wkf7GcRjYoM7uN27ddWFEETsfCY3++1VZXDDNQhZHkBLfASAgZGIzd/0FkwjXeLY2S1WGz
	w1cRgu6FZTeovSJKfXuqPhEHMKO8G+QHgC2UMxzZOCYg6iMixfH2Meiw=
X-Received: by 2002:a0c:e091:0:b0:914:33ad:5ba8 with SMTP id 6a1803df08f44-91433ad5e8dmr45171076d6.23.1790369138599;
        Fri, 25 Sep 2026 13:45:38 -0700 (PDT)
Received: from edhar.longhair-great.ts.net (pool-173-48-206-252.bstnma.fios.verizon.net. [173.48.206.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9143d30b437sm12854876d6.38.2026.09.25.13.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:45:38 -0700 (PDT)
From: Zack Gomez <zack.gomez@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	leitao@debian.org,
	stephen@networkplumber.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zack Gomez <zack.gomez@gmail.com>
Subject: [PATCH net-next v4] netpoll: bound the deferred transmit queue
Date: Fri, 25 Sep 2026 16:45:37 -0400
Message-ID: <20260925204537.2664119-1-zack.gomez@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__netpoll_send_skb() parks an skb on npinfo->txq whenever the device
cannot take it at once, and once the queue is non-empty every later skb
goes straight there to keep ordering. queue_process() drains it from a
workqueue and, unlike the direct path, never polls the device for
completions: when the ring is stopped it backs off HZ/10. Nothing limits
the queue length.

A producer that outruns that drain therefore grows the queue until the
host is out of memory. Observed with netconsole forwarding a GPU driver
that logged one line at ~1e5/s after a firmware hang. The NIC was
moving ~17k packets/s: completions for each burst surfaced tens of ms
later, outside the one-tick window, so queue_process() slept HZ/10 per
ring while ~1e5 lines/s kept arriving. The queue grew at ~170 MB/s,
unreclaimable slab reached 51 GiB in five minutes and the OOM killer
ran from kswapd with 341 MiB of anonymous memory on the whole box. What
the queue held was the flood itself; the OOM report never left the
host.

Reproduced on the same host (netconsole over a 10G ConnectX-4 Lx) under
the same slow-completion condition: 200k lines to /dev/kmsg in 0.12 s
grew unreclaimable slab by 173 MiB, about 188k skbs, draining at
~8-10k packets/s. With prompt completions the same burst drains at line
rate; a stall on the link while lines keep arriving faster than the
drain reproduces the growth.

Until the 2006 netpoll rework [1] the deferred path drained through
dev_queue_xmit(), with the stack's own backpressure, and was capped at
16 skbs (MAX_QUEUE_DEPTH). That series moved it to a direct
hard_start_xmit() with the HZ/10 back-off and made the queue
per-device, dropping the cap on the way.

Cap it at 1024 skbs per device and drop new skbs beyond that. The drop
is counted in tx_dropped of the device whose queue is full and freed
with SKB_DROP_REASON_FULL_RING. A netconsole target bound directly to
that device also gets NET_XMIT_DROP and, with CONFIG_NETCONSOLE_DYNAMIC,
counts it in xmit_drop_count. When a stacked device (bond, bridge,
team, vlan, macvlan) passes the skb down and the lower device's queue
is the one that fills, the return value does not reach netconsole and
the lower device's tx_dropped is the record. The bound holds either
way. Nothing is logged on the drop path because that would recurse
into the console being drained.

[1] https://lore.kernel.org/netdev/20061026225645.482978803@osdl.org/

Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Zack Gomez <zack.gomez@gmail.com>
Reviewed-by: Breno Leitao <leitao@debian.org>
---
v4:
 - no code change; target net-next and drop the Fixes tag (Breno)
 - collect Breno's Reviewed-by
 - v3: https://lore.kernel.org/netdev/20260923181111.1182838-1-zack.gomez@gmail.com/
v3:
 - no code change; the v2 mail was line-wrapped and whitespace-stripped
   in transit and did not apply
   https://lore.kernel.org/netdev/CAErB-w3Or6jkhsy9phjf5uo1O-T_hHQLx-XBFZeHX_8tqN38mw@mail.gmail.com/
v2:
 - count the drop in tx_dropped of the device whose queue is full, so
   it is visible when the sender ignores the return value or sits
   above a stacked device (Breno, Sashiko)
 - free with SKB_DROP_REASON_FULL_RING (Breno)
 - skb_queue_len_lockless() for the unlocked length check; the cap is
   a soft bound and the comment says so (Sashiko)
 - commit message: xmit_drop_count only covers a directly bound
   target; slab figures described as what they are; dropped the
   sentence about the 2006 list discussion
v1: https://lore.kernel.org/netdev/20260914041221.1028092-1-zack.gomez@gmail.com/

Tested on 7.2.5 with this patch applied, same host and reproducer as
v1. Under the slow-completion condition the 200k-line burst that grew
unreclaimable slab by 173 MiB on the unpatched kernel grows it by
2 MiB, with 187229 drops counted in the target's transmit_errors and
the same number in the device's tx_dropped; with prompt completions
it drains at line rate with no drops and a sampled peak of ~1.1k
skbs. Slab figures are deltas sampled at 4 Hz. W=1 build of
netpoll.o and netconsole.o on this base is clean, checkpatch --strict
clean.

The first tx_dropped increment on a device allocates its core stats
with GFP_ATOMIC, the same class of allocation find_skb() already does
on this path; they could be allocated at netpoll setup instead if
preferred.

Still open from v1: tail drop keeps the oldest messages and loses the
newest, which for a console are usually the ones wanted, so dropping
from the head is a few more lines; and 1024 is arbitrary, about 1 MiB
of skbs.

 net/core/netpoll.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index fe1e0cda5d6..aafbb19a288 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -38,6 +38,15 @@
 
 #define USEC_PER_POLL	50
 
+/*
+ * Cap on skbs parked in npinfo->txq while the device is busy. The queue
+ * exists to ride out a transient stall; a producer that outruns the
+ * device for longer than that must lose packets, not grow it without
+ * bound. Checked without the queue lock, so the queue can overshoot
+ * slightly.
+ */
+#define NETPOLL_TXQ_MAX	1024
+
 /*
  * carrier_timeout is netconsole-specific and only kept here to preserve the
  * netpoll.carrier_timeout module-parameter ABI. Its value is exposed to
@@ -314,6 +323,12 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	}
 
 	if (!dev_xmit_complete(status)) {
+		if (skb_queue_len_lockless(&npinfo->txq) >= NETPOLL_TXQ_MAX) {
+			dev_core_stats_tx_dropped_inc(dev);
+			dev_kfree_skb_irq_reason(skb,
+						 SKB_DROP_REASON_FULL_RING);
+			goto out;
+		}
 		skb_queue_tail(&npinfo->txq, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}

base-commit: 42a9fb3382fc2573e92f41d203b095d9a372cfc9
-- 
2.55.0

