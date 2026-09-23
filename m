Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF5F233944
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187077; cv=none; b=PbVEb1nMDAnC34FxChklPCsnNfEAP0qfMynmSHIWDf3/ydKOy7Jd+HYZDRj2HHQ08OgeO+st6YsR+VZUd24GZWxSqCGI4e/PBpLrap1h5xbz4LjNNwQdNYvzJN4z9eFCOx1q4fM0sUYYA+Ci1dYzoSXIAKnyeuGwPjsVUn3UInw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187077; c=relaxed/simple;
	bh=Nbf7J5/uQxjKUD4SiZ4Ipyp3eMxFGADZSKJEVPUUy4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YH1x+kddhVKqoljLGKQ3OIxxfUZsNaUpVjVORypa8JWAcCMwXdRfnDJQ4mg2ZacXjeRAG9rlbck34Mgn+CEVc/4J0zEJW8xQcAZKGD9izJnwFTQcnNdY1QgVbhn68xpCtAX6WnjIbGO4p1MWacf916UZe6FDmLBjaCt9jIJ1kyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltTHQEil; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltTHQEil"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66f943b286fso1126958d50.2
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790187075; x=1790791875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ps7ykDSERcuXzXnfyskR5kOcFO84vVgX7+2fTS/wYAI=;
        b=ltTHQEil8xVbciZ2FaY5W2Gb7VvGgpTbFDMC+Wf39f3hBZ8jBtSt2LKAs3l5hjU5pT
         QHimi39Fmx91X+/exymwSELTszDoPQUpp5+L6vlQ2awGfvwO8HQfJQAMzh12alm/shn+
         A4oJfxHSFiTDszI9Me8oFezncu9WxWZ2vOmdwgLWzOuT83C7+6x2rYWdlVeC4NeiSwMS
         IXWe8u/Z8945oEhgWqtTDiiXFrwdMDU4dOgTpARuR5wK153QWUdN+eTQeqyjZpyXqCHb
         x6lHglFhwkHAEAifWMG/It4HCUV+SRqsscd7OaY8mPmkFP95AoUAL1rtDXZwKzcBqvKx
         b9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187075; x=1790791875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ps7ykDSERcuXzXnfyskR5kOcFO84vVgX7+2fTS/wYAI=;
        b=MTYsJiTZjmolgb1rD7S8x+eGPy2zMY1xr3STrmQKm91l+B8NXCBJu0ets4M/6s4wfR
         /YaHbxwRbunNmJvEFgPH+pLWJitScM2ugqqBeU+APNw3w1e/zuwJ7tIR1AF4ebz+a1oA
         ymLRYZTeIsbVdcdIl/h6xLZebe+COli6B6c7rD0pwVek9eaYIuil+PR7Yj1HOHRJdB1O
         HyPlJUj8xidD4g8UwV8O6iNifWa5RoEOUmWiNoIoytuZ+vuPhuC+xBul6tmdeZm+OTSo
         Je9XrOULdAT1TwQ7V3bP0xqrVdaQoVubKrkmEMn3EGEm7lmZt6uFsKa2d3HyKEA5Mons
         4OGg==
X-Forwarded-Encrypted: i=1; AKwUvBw0zYRD5cTHvyjUAzUNyl2J/WE1p5pWyJ30lA3P3NaYQKofogFzrY85q49xAPhStri3VuV1pAw=@vger.kernel.org
X-Gm-Message-State: AFuF++lZKA9WrFsSi5ShC8X4O0C++uTdUc3zpOFp7PYBmEF8DpK5qCua
	U5HVGUVtEMYuW2AdA1NbzmII/lZ08Ksty1T+w6NbTnt1c5oIKZLF/Zik
X-Gm-Gg: AYBFou37fUHxPq6blm8YU0kwgEjRX02xwoHdRNBEo5IPrXB+ntRGBifWgN5MnKI4e0/
	ZRvBOKUxICshLzY9PUJ8M9RwDLW9mB73GZT1t0JqpU81yJM5G1cIinpUN7v2l5PXQnQ5cXyID9v
	IK4SpN8gXnfnjNHf0H+NsGVaXn92MeIQudRDgoFI9+9mi9aAbM5+Um77B/J4+QvNFM6hs7lFFDp
	y9BNJUH1DuXULVh/oWwtWEyPjlzThDwFbcT//uS/nN3T86D1dqB9sJq7U3QCMYwRhkh2pMFDHRf
	5z65ObcCA3q+9Wo9KJDSwXf6jJg9E5A2kfwd/hdTfWLAi85iA9AG3H4Z6PdDQ2EoBhj/1oFs/zP
	kFGQUmhmF0uz+lstRs1ExakrA6c3iDvCYV/skSGwy/OF+qgS+voav6ObRDmgHNO1H9nHBj3e/1I
	CsWEFkLjw3+V9MHg+68BJzX3kbt/mubmkiMtRNPXxnooYFSh4kYANh1i/hOfdk7E1mbiQcKTGTY
	0PL+6aiDni+2HaL3uceUbAYi96UEL0Yj/UZN/Bme9YE1DSrjhg3qtWO/O6VgVDRh/XyG8EV7UYP
	3O/d9NdH1zK6ZphSrO+w9l0ZrNOXg7va7PERyHbQ2rpEppE/Erjw4ygUDEaqVNu5Mt7RjQJ+Gg0
	NEJfcQpIWGAzp+i7MekXBQ0CAJMOy4K6a17zYWIrmi9JNYl9/WUTrKkVGxf2BsbWUxg==
X-Received: by 2002:a05:690e:1c09:b0:671:2a71:63ed with SMTP id 956f58d0204a3-672ed1d0186mr63223d50.34.1790187074782;
        Wed, 23 Sep 2026 11:11:14 -0700 (PDT)
Received: from edhar.longhair-great.ts.net (pool-173-48-206-252.bstnma.fios.verizon.net. [173.48.206.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9141e217944sm264136d6.9.2026.09.23.11.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 11:11:12 -0700 (PDT)
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
Subject: [PATCH net v3] netpoll: bound the deferred transmit queue
Date: Wed, 23 Sep 2026 14:11:11 -0400
Message-ID: <20260923181111.1182838-1-zack.gomez@gmail.com>
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

Fixes: b6cd27ed3388 ("netpoll per device txq")
Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Zack Gomez <zack.gomez@gmail.com>
---
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
 - Cc Stephen Hemminger (Fixes: author)
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
-- 
2.55.0

