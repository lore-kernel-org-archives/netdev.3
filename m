Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9037392806
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088892; cv=pass; b=rzDEfnUcqtfCDzt2DovoYCs0c8LJGxagbfmocFuOKgOVp8aE+SAUu8GgikuNGI97t1dGCuOEiKzswsIZFMyp3f1KMhrbq31P4TpfOx4aXxPaArLwRoC6vvXaoPeaZ5yjWMWZ9L8PHdpm1mhZ9JvpNfdSIzRJ0UXNun9xIvfgemk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088892; c=relaxed/simple;
	bh=rPBFj5OgHpPAzdqofII1NYME28RRKuDK+Vnxhgs6ylo=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=Kc0Kjscc2wWOMfIgMziT3GxcrHA8NeCsGf2xugjr5HChk3BTmKj1X396JmgjpggYtQT+nFtqJfZH3ugR+MokP4H3FwNqPjsTiGKvb9J1MnFRHfu7ge7f5zNRkHVp/6uRa/G1ncoyiMcCVhTXj/IH95xtIvCKI/8DBSbtrPjLCoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm4xfgJO; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm4xfgJO"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso654942166b.1
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790088889; cv=none;
        d=google.com; s=arc-20260327;
        b=EmLRV2r/zShJOUy4roVXAY8W09xUhjKLlmduWAQmBNLwbVfPYzTX7DuzUCIKawymVX
         X2P2blb9XUIteTiC62P4rW8kjnduwltGYQe5AYwSVSKMybR6bOIrBwqD0A4u/ubncQgt
         Cn1AnsA+Wi1R6POocRSfnUcm+wqWpC/fVZ75SQPphZ26iEa9DdjzCbuAbfGfPNByGkPl
         +8uFqDYhx413JQDuZULbohuEZHEkHqscnwP9bqA5UuVpwVcyBSFKKykzTfZ3F0p0IcTf
         NmU3qWzqwUzRUNqJCVTlS+PSCPg0ddfz6hGrVqJqkXTqZKfePMJuKnFNIHoUv7vPi5uL
         ItCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=+a1vidkZWMn5yLQTL4wXmDS7ONKk7G2JmZar9AG6UtI=;
        fh=WTvnx+kaTQZcp6nHnwrk0Eiq8eFEvt1Ug8h2lp0ecEQ=;
        b=OhxboWojjH4cLdMnvHWgxVBnIJcQd3GEWPhioChprdkL8c6nOzFq6Ml7ZgTcY/W0mR
         ogWgR+sanhgZZcekLnwpHyOy12sPQ5wBZ8BLv6QSukgx4fGXKncabts8MsCReOq8ajBn
         V8QuN8HrsrnzXU/VqbNi6YDdyLY4+1K2WFvKdok/GU61iW7/Rlil3FQ90XzRgMOHyvYN
         0sytL2W9RvIxsg0Qxx8+0pc3S627LgwBXOkR4kk4hgKVkNImRkTcbuOgCse3g5c1Fjcy
         QRiB2qLT7+LEfRqqibH+d1N5k0pySwOK73GtPsXVJy+CZilxaVzgGGVPj1WEadUWfLNR
         zOkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790088889; x=1790693689; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+a1vidkZWMn5yLQTL4wXmDS7ONKk7G2JmZar9AG6UtI=;
        b=Rm4xfgJOSjIGSqxza+e12heW4xXZx7UJlnYcZJ69gkT9v9hAMv4E4ucaMM/PJlJb49
         Y4M6SzihxcFNNdJAHcEpzRkb7mnQNN2KQjia1CjbcT6r4IOJK/UOKP1/Z9cVNpuvqT+R
         +1LUNHQZXg+zmMW+TOkrBOfxoS6gebgKbFIapsUKcX6aNX/Fkf6akuKQf70MZR7Hh+FX
         9z2PnuA6XCgO224UY8GWcpRmZpDlY9Enw7ADA3lM49lNyyqjMpvza4nZrDTwT9g01Bb7
         QUEV60lOJai2n2/gL9SBxwkqUyniy+4l2Pn/xjs1Xf1cQr9nYRltdp3Iz2Ig/34on9Hd
         /4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790088889; x=1790693689;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+a1vidkZWMn5yLQTL4wXmDS7ONKk7G2JmZar9AG6UtI=;
        b=dOSGYixyLKgJnZP6v5RT6sTqV06z9ee7vCdFkaiJt9IgbQI6ylMjdy3dr/mzH9/vhD
         FT9LBHwjAYShOZlDfshp3rldiTql/jn140BOxPV2hoipV936PbFZOzDzpHl1UTaD9nKv
         ExOC8HXuTFSdzs53OJnlvUbdJbJH/CrbKWiaXAOYSqTBduhK8b+9ghCuqixGetLEW7IT
         yPBMu15E6dqhiZ9lBop/qrJx8IycvBXqPzB7yX91ETBOQhbU7C3Ua45WoKGPc2MT5l7w
         38SqlIuRNSXe26CiCC/xymDhiT7ZKaU/pAJ4s/HQC+k4vNeYpIEJHS+6HwkD4qQfRnS1
         Fbbw==
X-Forwarded-Encrypted: i=1; AKwUvBx3FhKhzHkpYiYO/pKOSYDuNrPJxqQa5lBqoq2lrykYdqx37ktyPDC0LKIsAXJtZR9vZ/+6AuI=@vger.kernel.org
X-Gm-Message-State: AFuF++lB6beewXy3mMcRkts9GmpMQh1Y3sBFFpBVO4hEmLlxNJSvFUo+
	8hPoeNAA4j0yovmdjWZYRcodmnT0FsdLgNyUqyF87nDCiStdCG02yepSndXXUvBxjaC98/xW3XB
	5fDRpSamE2EUAbXHmRLVWus4nZ1TQvU0=
X-Gm-Gg: AYBFou0T33J7e7925pb0h96YpxxPWTRl3RiSupXsxPU9ZGeXPr/SCmhHEOSITBmSS9w
	2abJcu8++uFUbGZyPvAyVO8PuXoxgYHrk9VPeUiNlBwpGpWXiqCnOIOlNn62aGWMG2Ps5cBDqEU
	v2vDu42LiCy0lgvj9nhqvqSm1i8LFuOOYy64rvYW4r8bYb5jYPQcFdgiMkdoA9KBldQhmu2pfj5
	LHKJTUL1/odjP938ngS8TuoGO0AtEcspgzn9+tsxRc8iv6JYSYA2Qgj+sdesYUOlELhcd3LWGeY
	IwMi7MCc9sPMZxxooO13MTO5iUiE+NKMI2juZOhMxCGKS82OdAI808wiiHDBtKiUNbJ+i0ig4Dg
	VAoO5obJpBjsvej3tAflSD2mCg7CyTcingDdFggB+at7GlTmm23Bs/uKQ72PplAbEWXQajogLi4
	0mCgRyev6hM3O9ZcjX98MzfY/R+cIbLXEeB8Sjy2cdqw==
X-Received: by 2002:a17:907:9813:b0:c29:f5d8:9c71 with SMTP id
 a640c23a62f3a-c2a15812476mr1161704166b.32.1790088888514; Tue, 22 Sep 2026
 07:54:48 -0700 (PDT)
Received: from 1057883412519 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:54:48 -0700
Received: from 1057883412519 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Sep 2026 07:54:48 -0700
From: Zack Gomez <zack.gomez@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Sep 2026 07:54:48 -0700
X-Gm-Features: AcwNN1UrauIs-Z038m17bYDGari6DmdyWUeZlNknW_w0fbp_aqbS_LdqLWNugHE
Message-ID: <CAErB-w3Or6jkhsy9phjf5uo1O-T_hHQLx-XBFZeHX_8tqN38mw@mail.gmail.com>
Subject: [PATCH net v2] netpoll: bound the deferred transmit queue
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com
Cc: horms@kernel.org, leitao@debian.org, stephen@networkplumber.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
@@ -314,6 +323,12 @@ static netdev_tx_t __netpoll_send_skb(struct
netpoll *np, struct sk_buff *skb)
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

base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
-- 
2.55.0
