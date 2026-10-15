Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D13442FA0
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099135; cv=none; b=nLC5jbtJza86xYqopJnnDkCRb6Y2tYSk9f7lR8eb4c8IduJ2en3L88a8JiWqVz6xWvmCkNCgtXbtKyZfxfCcn3xUrWoU7CDBnNPVTOWJICg1CV5g1q1QTQ908fjTUnBcyIBai1k//DWgnVPEW8KhF35/3ho6+AzbS+Utn9wpPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099135; c=relaxed/simple;
	bh=+2/vvKbWoAbvspskcU3rN/lCGQ9o1XB7p6MUcTKEXB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qlojelmhSrv6H1mrGOAXhPKNkUh+E3BCNPMSa8dHtxzjk5/Hp9co3nMVinrFi0jPhS18IVd9ApujBTRa4uLEjvYq+GZsl+PPAhKo/R3GCdiLokhi5xh8LmisC1bZO5eyqrLqqBx7RVxq1QtPye/UsQ1wbO7GgLqPe3SDX5QT1/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=rfNQSCcb; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="rfNQSCcb"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-16079d54c17so1041652c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792099131; x=1792703931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VOV9lrbQ6U/ePh3qjqflN4zmHKmWIEXGerAj9rmp8aE=;
        b=rfNQSCcb5z27dmPF15x0VQMKjmG68hDj2PYynDPbdSgEMhfpI8mfrPkoFuX54WcJKZ
         YELtMqlI1YxKaXpNrZX3zPepZ04MzPkMdujnD5qK78bLGfNGvvP61ok37lQXavAeWcRU
         g89fWnilEPtjM20QXWTVjUhvZE1s4dCTH/gwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792099131; x=1792703931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VOV9lrbQ6U/ePh3qjqflN4zmHKmWIEXGerAj9rmp8aE=;
        b=pB9zQFqdw5MDqBgiSps9G1K6z8slDzrPLxaV1Vtfi+WgFE6qQ30um57OMJWjNOCtKE
         qRQhuqoU/xqW83NriUxaTgOF96wNMxULH0Jj2irEGmjQP64A63VugEP3iH7T8TokBgKC
         /6QI6xqpI9KXrN1Ikc3CVjYnP2Db9oWcODYI1csM9dJdtUvNjqdgkknb7p9ZpNamLc3U
         KZD7qmCDabQj8cFFkOECRHsB6QZQmCnXIkAjs37O00eV1qP9SVsOfqxbJ/RC0M0fZjAS
         wXUMx5QHKaV7zfJlIQN/37CrD0OY3lpF8k1E7/IUKW6wgITBHqlAaoTmZcQ2esoSDE+l
         MZxg==
X-Forwarded-Encrypted: i=1; AKwUvByH33oVogWFrJIR3QQpv4J+YlarjAjFZ6SNv8C/ekqdC1VhRvQLWetL86/BNWfzHb3rhXiJjtE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeb7oqd55c3E5rB/mZZOKh0ZToraBHBYgdv9cCDAaQb/SUoVDs
	3bs0ws11uHFrv0mf8YrXQDKlKTyJiGLnC7bjIohARjnQPY7q1hHwk8uqYafnEczYtg==
X-Gm-Gg: AYBFou3OpGVAKXpwImc7OUtzOO3yX4j5nkUjN5K5aFC5geDOJ477wNcM2ZWhAu0RM7J
	LG/mLqniCgojkycnRhYmMzqknXu/FDDiIjGCtNoplDz/W08v8s5eA7OO+OnI/FSeerTsCx0um2+
	G+s1ysbJAk1F7CAKTc2kPft5ym7W5uVPjg651wUTvEHefU7gFbHoTBYP7LXFvGPZN20gN5MknO2
	vpllnpr88R/6K29+u6jyAc7Ks0q7cbi7hq1fz7iYs8Gted289ivtZK8E9bYaAN2StfDQAmfCbZp
	Y8a26q20c6D7ZUYcLE8tAZdXYB6OEPS6oPpCv5IC0KYMHZPep8JyW0X7axG1/A/ME4ocqsd7eRD
	5TJLApMhOFZZjGI45qyLaA8KS6iAl5wYg1GrdgE9feqgucaGFbXJNawUfMxJC5wXSTP4+mkFu8K
	l2xsCmAGMTLCL5c9GClXDXv2AfZMKl+MREncaQXFu00WWDCi7Xip9LhEr8UoiD1O5cbHUVS8ub6
	1i/pQ==
X-Received: by 2002:a05:701b:21c5:b0:143:3617:c5ae with SMTP id a92af1059eb24-16a554812f4mr27717450c88.2.1792099130997;
        Thu, 15 Oct 2026 14:18:50 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b859142sm216711c88.18.2026.10.15.14.18.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:18:50 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	sashiko-bot <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net/sched: drr, ets, sfq: skip empty rounds in the deficit-refill dequeue loop
Date: Thu, 15 Oct 2026 18:18:29 -0300
Message-ID: <QDISC-TIAE.v2.r0.20261015163454-1@mojatatu.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <QDISC-TIAE.v2.r0.20261015163454@mojatatu.com>
References: <QDISC-TIAE.v2.r0.20261015163454@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
one-quantum loop, and a dequeue costs O(N).

sfq has the same loop and is fixed the same way. ETS has at most 16
bands, so it was never that slow; it is changed to match DRR.

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
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
v1 -> v2:
- drr, ets, sfq: the dequeue loop skips the empty rounds in one bulk
  refill.
 net/sched/sch_drr.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 net/sched/sch_ets.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 net/sched/sch_sfq.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 8621d057edd9..d6cb389a55f0 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -372,7 +372,8 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 {
 	struct drr_sched *q = qdisc_priv(sch);
-	struct drr_class *cl;
+	struct drr_class *cl, *first = NULL;
+	bool scanned = false;
 	struct sk_buff *skb;
 	unsigned int len;
 
@@ -402,6 +403,45 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			return skb;
 		}
 
+		/* No class could dequeue in the last full round. Add the
+		 * quanta for the rounds still needed in one pass.
+		 */
+		if (!scanned && cl == first) {
+			unsigned int rounds = UINT_MAX;
+			struct drr_class *iter;
+			bool skip = true;
+
+			scanned = true;
+			list_for_each_entry(iter, &q->active, alist) {
+				unsigned int pkt_len;
+				struct sk_buff *peek;
+
+				/* An empty child unlinks iter; stop here. */
+				peek = iter->qdisc->ops->peek(iter->qdisc);
+				if (!peek) {
+					skip = false;
+					break;
+				}
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
index 6cc902a03838..331c6d886fde 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -459,7 +459,8 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_buff *skb)
 static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 {
 	struct ets_sched *q = qdisc_priv(sch);
-	struct ets_class *cl;
+	struct ets_class *cl, *first = NULL;
+	bool scanned = false;
 	struct sk_buff *skb;
 	unsigned int band;
 	unsigned int len;
@@ -493,6 +494,44 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 			return ets_qdisc_dequeue_skb(sch, skb);
 		}
 
+		/* No class could dequeue in the last full round. Add the
+		 * quanta for the rounds still needed in one pass.
+		 */
+		if (!scanned && cl == first) {
+			unsigned int rounds = UINT_MAX;
+			struct ets_class *iter;
+			bool skip = true;
+
+			scanned = true;
+			list_for_each_entry(iter, &q->active, alist) {
+				unsigned int pkt_len;
+				struct sk_buff *peek;
+
+				/* An empty child unlinks iter; stop here. */
+				peek = iter->qdisc->ops->peek(iter->qdisc);
+				if (!peek) {
+					skip = false;
+					break;
+				}
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

