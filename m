Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDB39A7EF
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787047178; cv=none; b=j+Q4FY1O2LrAInVwAZkF+W92D8amxlDosaiUbPB+VJEu9FzNEbhyrf4n0nKm+zO10K+L5kdPUVEvZxRqVUH6npaxtXcVICoShiuOj2jAhLAeiAleDrZw/lMC/0ejWMvcW1uPEe+0pwEFHyXbkugswA5uQ1ic+bVQtM27wbE5wNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787047178; c=relaxed/simple;
	bh=5u8fqtUZicxB3yEdtSB90F7qmMvwCOPD6nA4msBr57M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DcSKsI6NOiw8JLZIv8QwH+bobzLVYVDxdJXUKMvbrkZr/ypymORy++cMdx4ikOxEvfAtGpR6BqNFky/TClWsLv772dRJzjkaZAjFoJDKRBVHLdJypelEILYM+ZruXNu+810IQ7Dmb9HVQho/VbKUE3mU+EbacpknD87lJTjoTzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=QhgeYcvp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="QhgeYcvp"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e65e18969so71591585a.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787047176; x=1787651976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYwTcLeF+btFWttAuBsk3+cG8NPflYKJAIfuTzy7tRc=;
        b=QhgeYcvpjVroqBQJV2+Dp4S0LY43n3mV/LU9pzrn8ZFESJB/eU7HTcTYyiujdGubQ6
         R4kF9qPnytAB68UwId4GiBqkxb284TxRgRgWka9tCYjEqitKl94pV9V5XCVUH63Nw+Nh
         9KX2oBCNKDuI94bqMFq8Y7kI/7nF7amHnGg8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787047176; x=1787651976;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bYwTcLeF+btFWttAuBsk3+cG8NPflYKJAIfuTzy7tRc=;
        b=neGateuyDWbCeiyHR7SF9Aq9eM7eykhY3NmngryEvoZKruJB6lxYuFeTRB0LzON0Vl
         4li3Vo0/oXeyddKrWnNp4hYGGNTRWMEw1CjV64jiqjs9suL0tL/VuGi9IEyQe1yT8ULc
         tX0C467BKiN6cwWuIwi2f4KKZ09z71saURBno7uTiGZQRc6vp8GT0EHqCj02P6jnKyqH
         i4UzFRZQL5yyFlnJpkxfOg4tzaAB476HM/SDHfXvjEqgbEfCZ8NvmbTwDKHgK6pZ2FnE
         dY+pO/MXQlpyoTyahWyee+paRpNiqN16fVUdgrwrW4OMTni/SNi7nni5QBcH8WJj21LM
         OfYg==
X-Gm-Message-State: AOJu0YxFodhseIh3F3+II0FGPXHdT2vBsnubTPzpMhO6gPDPYxTsqskF
	OG29T5YUqXFyh/lJUlSoNTQ/EnQ6OqMjLXB6I+vrIGW86XJGf5WPlRRugtpCeeNAuRZ0ePLLZmL
	BGSDtNg==
X-Gm-Gg: AR+sD11mvtZJXshmGsLWtp9r0iEI+Wpy6qKgPkgd2Cr5cZ3Vqff0c84qSd68yHPiGxM
	H5D0vf0bQtby8LnUOE8vvyxkR7NcavhayaNBia+uIZYEAjJ4A20zjgBUtMUJht1xC0LfLnoEHyf
	WES9eo7t+VCN3TgYy6rN9alFU46oX+MLUoiSOXJBN8i1pVL/h8dO3fklYWYzvNoadDMypY0xh1s
	2IaFn1apOD4mfSHiD5voIRcRsEctMBTSbXhbNf/HA45W8ke8pgmuCYME1U+CjiuDZ/aFJok6g5i
	Bg/XPOxGuKLMKTlFubVyoR/kGLGgmAi+mzHCCZU/ovxJ/ZqlJOYLflQv6cwYkVtGZqYXIdol+ME
	i0VzpvrLRAYVC+OHuHIkjBzTL1LVWZ+yNDw1heZyISRDdfKq5mZ/Mdc0vfidSizJ1BbxpOpj5qJ
	FQ3lgydwt1siQkBztmiJqlsjSwIJ/tJ+fM6smM4noQRLQ40Os+bl22c4yhxcZaPwVRU8phyEKvt
	tS3xl0Is4xxtN/1batpvxiSdVB2sAUMv+ipqOidlTNregbEOOXMqhPU
X-Received: by 2002:a05:620a:44cd:b0:92e:d2d4:2d04 with SMTP id af79cd13be357-93706699d3fmr532054085a.23.1787047175576;
        Tue, 18 Aug 2026 02:59:35 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010c32f8sm289740985a.6.2026.08.18.02.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:59:34 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	david.ward@ll.mit.edu,
	vega@nebusec.ai,
	victor@mojatatu.com,
	zhanxusheng1024@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: sched: fix 32-bit backlog wrap in gred, bfifo and plug enqueue
Date: Tue, 18 Aug 2026 05:59:27 -0400
Message-Id: <20260818095927.15901-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gred_enqueue(), bfifo_enqueue() and plug_enqueue() admit a packet when the
current backlog plus the packet length fits within the queue limit:

  sch->qstats.backlog + qdisc_pkt_len(skb) <= sch->limit (gred default VQ)
  gred_backlog+qdisc_pkt_len(skb) <= q->limit  (gred configured VQ)
  sch->qstats.backlog + qdisc_pkt_len(skb) <= sch->limit (bfifo)
  sch->qstats.backlog + skb->len <= q->limit             (plug)

sch->qstats.backlog and q->backlog are u32, and qdisc_pkt_len()/skb->len
are unsigned int, so all sums are computed in 32 bits and wrap at 2^32.
Once the true backlog exceeds 4 GiB the wrapped sum becomes small and
admission keeps succeeding, so the queue grows without bound and the kernel
can be driven to OOM.

Promote the sums to u64 so admission stops once the true backlog exceeds
the limit.  The limit is u32, so the bounded queue stays below 2^32 and
the stored u32 backlog never wraps.

The bug can only be reproduced as root (albeit with ridiculous setup):
 attach a gred (or bfifo/plug) qdisc with a limit near 4 GiB,
 leaving the default VQ unconfigured (for gred), and drive >4 GiB of
 queued traffic (e.g. via a size table / stab to inflate qdisc_pkt_len,
 or sustained high-rate traffic). The u32 backlog+len sum wraps at 2^32,
 admission keeps succeeding, and the queue grows unboundedly to OOM.

Fixes: a3eb95f891d6 ("net_sched: gred: add TCA_GRED_LIMIT attribute")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v1->v2:

1. Added bfifo+plug into the same patch as gred since it is the same
   pattern. Flagged by Zhan Xusheng and Sashiko[1][2].
2. Starting this patch, and for the rest of AI found bugs,  i will start
   adding the conditions required to reproduce the patch (see the
   above commentary "The bug can only be reproduced as root...").

[1] https://sashiko.dev/#/patchset/20260809091657.879929-1-jhs@mojatatu.com
[2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809091657.879929-1-jhs@mojatatu.com
---
 net/sched/sch_fifo.c | 2 +-
 net/sched/sch_gred.c | 4 ++--
 net/sched/sch_plug.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index e6bfd39ff339..1b6388d50967 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -19,7 +19,7 @@
 static int bfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 struct sk_buff **to_free)
 {
-	if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=
+	if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
 		   READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index fcc1a4c03636..f04f425c6c44 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -179,7 +179,7 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 * if no default DP has been configured. This
 			 * allows for DP flows to be left untouched.
 			 */
-			if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=
+			if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
 					sch->limit))
 				return qdisc_enqueue_tail(skb, sch);
 			else
@@ -244,7 +244,7 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		break;
 	}
 
-	if (gred_backlog(t, q, sch) + qdisc_pkt_len(skb) <= q->limit) {
+	if ((u64)gred_backlog(t, q, sch) + qdisc_pkt_len(skb) <= q->limit) {
 		q->backlog += qdisc_pkt_len(skb);
 		return qdisc_enqueue_tail(skb, sch);
 	}
diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
index cefb65201e17..b60ddfee6a68 100644
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -89,7 +89,7 @@ static int plug_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	struct plug_sched_data *q = qdisc_priv(sch);
 
-	if (likely(sch->qstats.backlog + skb->len <= q->limit)) {
+	if (likely((u64)sch->qstats.backlog + skb->len <= q->limit)) {
 		if (!q->unplug_indefinite)
 			q->pkts_current_epoch++;
 		return qdisc_enqueue_tail(skb, sch);
-- 
2.43.0

