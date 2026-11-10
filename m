Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321039;
	b=34tojwny1qRtQuxiQ/WP/aQ0kLEDdtMZAxWb3RTOoY22Pz9qQFVk2QQ4yap831LBnNhK
	 VDIabdY5OLK/cakrMPxachpgcrOO5mAucSm3hQXvvR5jcNdtSxQ2fBDqWmt4ulHbA7g1s
	 vdPk1uIR1h3Y49j0DJ2yp0zBevlIe2lFjIUGX70tbaIqG0ASghFG+bFEXo/AT9aeZ05op
	 mvE/cgkXWpF8vybqP+yEOuhH/AnOEQWhWna2A4z2ol4vdJyR9GsvVBBnsjvoVAX7GMuNV
	 zHAkOTflal7LwfssvYisSkyo3W4wO0w4IRlaUxcgCydbhknEJwtxH/ZG7iGD7hm13sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dXg2KhGammKk7e5/zT09/CLKKKN02OSmrzKHGGV6cAo=;
	b=E8Vg0iKDcOHao9GfHgEiJei5z5aI0KWydHI0VIOUD1fL6GMS6JhMpT5Cst1CuoZ1mqk8
	 vkiZHCUSVgTqv3oGRgf+BS483OzjhfmeaGT2QUiDhVk8uQPhhe1I1gCyuGgwPWhJifWrO
	 LCHPr19JkXHPXDAp2DpyGNwzJHet9maZKvLnB4C2T6JYy07xuT+oWoOOdRpfJe3cSBmQf
	 AHyVJCYYFLzlp6qlZodyZrnUxsatefolyIkKvr9Y42Wymqrc91VDgB6sf6+qoZ3/SlGop
	 ukyBBO1n72SKpqXhE9YFHQDJzFYXWEBeRzXwfeel/m+GpveBmKSTScUuYdsPdNfgTmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=OjxydD3Z;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E25606A326
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82E25606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=OjxydD3Z
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0cf2c0785so20709477b3.3
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794321037; x=1794925837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dXg2KhGammKk7e5/zT09/CLKKKN02OSmrzKHGGV6cAo=;
        b=OjxydD3ZNR3vVJI3T4F24Di9tYkKQXizlIR/gT/kbyXDWcWbdddHqMgJx0309tDY3/
         R4vAYEUAH9cLLEkZvFfS44PT4jz/aknEIae/6fPDB9ZndvJR9EaW7UY/wM5N8/dWaQg1
         VVUWMv8I5rBGMUYLRL46hz2y0MQNTpAl17IM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321037; x=1794925837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dXg2KhGammKk7e5/zT09/CLKKKN02OSmrzKHGGV6cAo=;
        b=con9SEfDbp/YsP8u36awhWNyuBqVIE4QpnFTxiXS7+K7jI8Pt51bG8uirpZ2XbmRs4
         a/Dwtqdu7tY11Nbcln89etk1Hm8KMuKta5scZrvt5zpk1Hdz9duYiVpLzn2EtHmjWUPu
         AmUGZdHdyXzcwrlXxX1HT6zrhMYIlJ55xIGJIZdIt6JqgFFPC9IV8XeIE4TvlcLD557t
         k/BNT7v5mwRHx15Mx7nOy28GlX+SwhmXrtEeQnsXVyfDZYffh0q0bqltwB5oSVgpHsRG
         /Gx3DH5ValWObd4VwicROTSFX308LIgSXHoKYWBgK3c/PCeSHo5m5gCielpENmVecnBR
         7ECA==
X-Gm-Message-State: APuU4Z8hxMJjXhXMql5k25zqfBRfETA1V/592e7tk4ibuhV1oJnlasAY
	ZRm7czZJ/q2ZhEdUiuISuOrRVGe14avA7j2PxRZ+stojo2AcSroXHaq5jcfYpq8wfbWlzJbShzU
	i/N0=
X-Gm-Gg: AYBFou2OFQSQmI96Py/GipHFBr67A0s4KiOGvYejBQcljAZER3+VHbIpXQf0zmH0HfN
	RpE0c4YAqGejHqPDZCkOO/WxyOPJ5z0AeNO/YfEzKakne1U8EN2ss6/hNyABreX6rjJsjZ2SZZJ
	EUxIOcFmK4EDk1rUVH0eWVEWwYdqbndTIYLQnAdEGOmyMFztBBIfNrSinte6LMNO4w8h5Sb4fB2
	UsBP6bCNPl2OwENeKNOz9PgmMB0UMnJmjUVr5hyHfQZptLdCGdFkyzzvI5smAd26aOZngO8DDGZ
	8Osl9iFtYhL5w9hYVWfe/BIG/uXtJGwkR0EUJJRVUUCOz2jJdcC30KYopUuWHyxH09Oax5Mbdnc
	pYUZnfwCIUPxJpn+fzDN5/2c7v5kbNjQIYqtD0rGs0pgyvlopQxjNXbik6aA4la+llDtAAUecw1
	7BaoTb2dJKi1fx23S+Pj2CWvh8QlDS52dIKez2nhmVJ0XwfliYtFrDCIFHN93utTnh2uJ6RHTqd
	pByFTiqhxjVApS3GGBOqOXDpycUQRWoUh8AH2AyLDjLFGoPnXmGkdoSI8615QUllmq/i0xU2syp
	9v0td6QL8JqF
X-Received: by 2002:a05:690c:39c:b0:8b1:55f4:eb4f with SMTP id 00721157ae682-8b392c20442mr12852537b3.71.1794321037492;
        Tue, 10 Nov 2026 06:30:37 -0800 (PST)
Received: from exu-caveira ([2804:14d:5c54:4d67::1c9d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393479120sm20091647b3.45.2026.11.10.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:30:37 -0800 (PST)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 1/3] net/sched: drr, ets, sfq: skip empty rounds in the deficit-refill dequeue loop
Date: Tue, 10 Nov 2026 11:30:23 -0300
Message-ID: <QDISC-TIAE.v3.r0.20261109173518-1@mojatatu.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <QDISC-TIAE.v3.r0.20261109173518@mojatatu.com>
References: <QDISC-TIAE.v3.r0.20261109173518@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue: DRR and ETS refill the head class one quantum per iteration
until its packet fits the deficit. A size table that inflates the packet
length to QDISC_PKT_LEN_MAX (1 MiB) with a quantum of 256 makes that
~4096 iterations per packet, so one dequeue over N backlogged classes
can spin N * 4096 times under the qdisc lock with BH disabled. Draining
16384 DRR classes this way takes about a second.

The Fix: after a full round in which no class could dequeue, compute how
many more rounds it takes until one can and add that many quanta to every
class at once. Deficits and service order are the same as with the
one-quantum loop, and a stalled round costs one pass over the active
list.

The skip is repeated after every bulk refill, so a child that exposes a
longer head once its deficit is positive costs one more pass, not
N * 4096. A child that empties itself while being peeked is skipped
instead of ending the scan. DRR and ETS change a class quantum under the
tree lock, the same lock the dequeue path holds, so the rounds and the
refill come from one snapshot.

sfq has the same loop and gets the same one-shot bulk refill. A slot's
readiness depends only on the allot the bulk pass sets, so it needs no
repeat scan. ETS has at most 16 bands, so it was never that slow; it is
changed to match DRR.

This follows commit 8f735d64382d ("net/sched: bound qdisc_pkt_len to
prevent qdisc soft lockup"). With 16384 DRR classes the drain goes from
~1.0s to ~0.12s.

Conditions to recreate:
- tc qdisc add dev veth0 root handle 1: stab mtu 2048 tsize 0 \
    overhead 1048576 drr
- 16384 classes with quantum 256, one packet in each (sent with
  SO_PRIORITY set to the classid), plus one catch-all u32 filter so ARP
  is not dropped
- CAP_NET_ADMIN (unshare -Urn is enough)

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260819143213.57401-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/3ab59725-e34c-4243-bc72-d93f837bcad1@redhat.com/
Link: https://lore.kernel.org/netdev/CA+NMeC_kwd5yihR3SSqb+Z8wX+NuobntbvpKtAyOwjZ1Xa4mVg@mail.gmail.com/
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v2 -> v3:
- drr, ets: the class quantum is changed under the tree lock, so the
  round count and the refill use one snapshot.
- drr, ets: the skip scan is repeated after a bulk refill and tolerates a
  child that empties itself while being peeked.
v1 -> v2:
- drr, ets, sfq: the dequeue loop skips the empty rounds in one bulk
  refill.
 net/sched/sch_drr.c | 57 +++++++++++++++++++++++++++++++++++++++++++--
 net/sched/sch_ets.c | 53 ++++++++++++++++++++++++++++++++++++++++-
 net/sched/sch_sfq.c | 41 +++++++++++++++++++++++++++++++-
 3 files changed, 147 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 8621d057edd9..bff7b307e98e 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -98,8 +98,15 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			}
 		}
 
-		if (tb[TCA_DRR_QUANTUM])
+		if (tb[TCA_DRR_QUANTUM]) {
+			/* The dequeue path reads the quantum while it holds
+			 * the tree lock; take it here as well so that the
+			 * rounds and the refill come from one snapshot.
+			 */
+			sch_tree_lock(sch);
 			WRITE_ONCE(cl->quantum, quantum);
+			sch_tree_unlock(sch);
+		}
 
 		return 0;
 	}
@@ -372,7 +379,8 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 {
 	struct drr_sched *q = qdisc_priv(sch);
-	struct drr_class *cl;
+	struct drr_class *cl, *first = NULL;
+	bool scanned = false;
 	struct sk_buff *skb;
 	unsigned int len;
 
@@ -402,6 +410,51 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			return skb;
 		}
 
+		/* No class could dequeue in the last full round. Add the
+		 * quanta for the rounds still needed in one pass.
+		 */
+		if (!scanned && cl == first) {
+			unsigned int rounds = UINT_MAX;
+			struct drr_class *iter, *tmp;
+			bool skip = true;
+
+			scanned = true;
+			list_for_each_entry_safe(iter, tmp, &q->active, alist) {
+				unsigned int pkt_len;
+				struct sk_buff *peek;
+
+				/* A child that emptied itself while peeking
+				 * is no longer in the list and needs no rounds.
+				 */
+				peek = iter->qdisc->ops->peek(iter->qdisc);
+				if (!peek)
+					continue;
+				pkt_len = qdisc_pkt_len(peek);
+				if (pkt_len <= iter->deficit) {
+					skip = false;
+					break;
+				}
+				rounds = min(rounds,
+					     DIV_ROUND_UP(pkt_len - iter->deficit,
+							  READ_ONCE(iter->quantum)));
+			}
+			if (skip && rounds != UINT_MAX) {
+				list_for_each_entry(iter, &q->active, alist)
+					WRITE_ONCE(iter->deficit,
+						   iter->deficit + rounds *
+						   READ_ONCE(iter->quantum));
+				/* A child may show a longer head now that its
+				 * deficit is positive; scan again if it still
+				 * cannot send.
+				 */
+				first = NULL;
+				scanned = false;
+				continue;
+			}
+		}
+
+		if (!first)
+			first = cl;
 		WRITE_ONCE(cl->deficit, cl->deficit + READ_ONCE(cl->quantum));
 		list_move_tail(&cl->alist, &q->active);
 	}
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 6cc902a03838..86fdf772fe2e 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -243,7 +243,13 @@ static int ets_class_change(struct Qdisc *sch, u32 classid, u32 parentid,
 	if (err)
 		return err;
 
+	/* The dequeue path reads the quantum while it holds the tree lock;
+	 * take it here as well so that the rounds and the refill come from
+	 * one snapshot.
+	 */
+	sch_tree_lock(sch);
 	WRITE_ONCE(cl->quantum, quantum);
+	sch_tree_unlock(sch);
 
 	ets_offload_change(sch);
 	return 0;
@@ -459,7 +465,8 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_buff *skb)
 static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 {
 	struct ets_sched *q = qdisc_priv(sch);
-	struct ets_class *cl;
+	struct ets_class *cl, *first = NULL;
+	bool scanned = false;
 	struct sk_buff *skb;
 	unsigned int band;
 	unsigned int len;
@@ -493,6 +500,50 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 			return ets_qdisc_dequeue_skb(sch, skb);
 		}
 
+		/* No class could dequeue in the last full round. Add the
+		 * quanta for the rounds still needed in one pass.
+		 */
+		if (!scanned && cl == first) {
+			unsigned int rounds = UINT_MAX;
+			struct ets_class *iter, *tmp;
+			bool skip = true;
+
+			scanned = true;
+			list_for_each_entry_safe(iter, tmp, &q->active, alist) {
+				unsigned int pkt_len;
+				struct sk_buff *peek;
+
+				/* A child that emptied itself while peeking
+				 * is no longer in the list and needs no rounds.
+				 */
+				peek = iter->qdisc->ops->peek(iter->qdisc);
+				if (!peek)
+					continue;
+				pkt_len = qdisc_pkt_len(peek);
+				if (pkt_len <= iter->deficit) {
+					skip = false;
+					break;
+				}
+				rounds = min(rounds,
+					     DIV_ROUND_UP(pkt_len - iter->deficit,
+							  READ_ONCE(iter->quantum)));
+			}
+			if (skip && rounds != UINT_MAX) {
+				list_for_each_entry(iter, &q->active, alist)
+					iter->deficit += rounds *
+							 READ_ONCE(iter->quantum);
+				/* A child may show a longer head now that its
+				 * deficit is positive; scan again if it still
+				 * cannot send.
+				 */
+				first = NULL;
+				scanned = false;
+				continue;
+			}
+		}
+
+		if (!first)
+			first = cl;
 		cl->deficit += READ_ONCE(cl->quantum);
 		list_move_tail(&cl->alist, &q->active);
 	}
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 8bbcfc9e85d9..83a698af2d58 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -479,9 +479,11 @@ static struct sk_buff *
 sfq_dequeue(struct Qdisc *sch)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
+	sfq_index first = SFQ_EMPTY_SLOT;
 	struct sk_buff *skb;
-	sfq_index a, next_a;
 	struct sfq_slot *slot;
+	bool scanned = false;
+	sfq_index a, next_a;
 
 	/* No active slots */
 	if (q->tail == NULL)
@@ -491,6 +493,43 @@ sfq_dequeue(struct Qdisc *sch)
 	a = q->tail->next;
 	slot = &q->slots[a];
 	if (slot->allot <= 0) {
+		/* No slot could dequeue in the last full round. Add the
+		 * quanta for the rounds still needed in one pass.
+		 */
+		if (!scanned && a == first) {
+			unsigned int rounds = UINT_MAX;
+			bool skip = true;
+			sfq_index i = a;
+
+			scanned = true;
+			do {
+				struct sfq_slot *s = &q->slots[i];
+				unsigned int r;
+
+				if (s->allot > 0) {
+					skip = false;
+					break;
+				}
+				r = DIV_ROUND_UP(1 - s->allot, q->quantum);
+				rounds = min(rounds, r);
+				i = s->next;
+			} while (i != a);
+			if (skip && rounds != UINT_MAX) {
+				i = a;
+				do {
+					struct sfq_slot *s = &q->slots[i];
+
+					WRITE_ONCE(s->allot,
+						   s->allot +
+						   rounds * q->quantum);
+					i = s->next;
+				} while (i != a);
+				goto next_slot;
+			}
+		}
+
+		if (first == SFQ_EMPTY_SLOT)
+			first = a;
 		q->tail = slot;
 		WRITE_ONCE(slot->allot, slot->allot + q->quantum);
 		goto next_slot;
-- 
2.43.0

