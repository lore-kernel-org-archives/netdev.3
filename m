Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189EF4D1789
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971739; cv=none; b=Q7P3esIb5GTNmF7fBDWKWmjkNeOp9Slt8i+w9DTFiDa7x48bGXb/duRObeU8Q9YZzrql7Yzj4WMP/5M2ECGdxIbIy4P1lCFt2R6JK8G2u302gaqVKZlv/crNSz8sIVCOm+dYa/bPYJ1fD7xofBnW+ShzsolqJKrI9Fyi6ea8jUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971739; c=relaxed/simple;
	bh=SyE1EGc7dnPZYAGMHddDJRiSrj1ZiXZzQjSLg2ZgsX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=X+HHtf/cXa58NyV/eln8I3auVpZxTXtMhv2DsqIZ5zw1aV4kZqLMYZoDHl+Nm1XOtx14rDIjM4pTcepx9KgdZ9MsWL3UZsYN5+bYUciQCQQWtRqSVMHodYl533BqQ5wYzzESQqvDVSmUvTs+nNMXR3bddGZDcIaWLPz79blOQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gbMtnxCT; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="gbMtnxCT"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93cc1ab5f6cso470848885a.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791971737; x=1792576537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZRYZNseXUhnvz2KZdmuG4MOlfPEQusM15CemEJWkdiU=;
        b=gbMtnxCToHHlJFzLgHjrhKa+tlfNS0H8+vKN0hQJ0Q40ZQYlDn1jw+shNpgfxfVgKV
         y0nLDRr1FbVldvmaFKGAJfs3VxV4sqPlF2Er/CZGEh/EMMSL4c3bvxwcgs2oR+c568PX
         +6MPFT9yPTbOV1ysffLOH4j8lBne2jKtyOzfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971737; x=1792576537;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZRYZNseXUhnvz2KZdmuG4MOlfPEQusM15CemEJWkdiU=;
        b=I2blv3aQv6xe83g1UFJZRw45+2f6icev/x9YYUu7M0UIG4NjcN6LGw/lr1TcQppv3t
         BN3w7P+ENJsgWqdtkHamUrsciKLqL9YAB4/QDdUcC0LPQ0W7jxsM62/g8Buggeuib0/Q
         4tMvP2HpLBUj93BhXQCDuM1PHlsZTluvUVtvkHyMBry0+BHn9eXbXikFQsapDkuJsF+x
         itMANsyCraZ279JCRYNLGZ862O3BUrf1wRzGkilrODESlURStOKRnGkh7DWl+uGNOQFY
         XNgURO/YDYX55xAwXnIvHhfGhD9dS0RlIaCTC28JXldOB1D29BtbM24yewGhAHhKx+bp
         qtUg==
X-Gm-Message-State: AFq9FYIvNa4jfmGvZOlYCKcDAY35HRAMw95xcTVI8OF2LVUzNZxar5M+
	wJfUulMIbMWM87lZpCAmT/xf0KPt/iI0l/yl7aW48+TMt7ytrO4Qk+7NPsdRWPM9bGPldu7EdQN
	Xk0M=
X-Gm-Gg: AYBFou1+004bRuf4NtgSaZ9wpeU1S5rmL2dP12E+YT2Lpmoq7jx/oAZjK2BmdA4qZ1F
	FSx3j/l18Jw8dRMgcXg7bvxmaqUnbdBLGpDYThdY9A/odFUgfFfqDMeU4tf7qpBVgpn2rlcrqYu
	sT5GiRZF+R2PHF4R5b5W7bHrhAkF2UNJfszrDN2O/0i0LWA+JQrRq7Pg13THzBIhey7Keki2IvU
	H5Li/H4VoCxujNBelh4zrGyh09SeXpsqJliMyKKnRbSRF3+KhYFXBmXiLjQmJ4kvZNJ8legeruR
	InDaDZ78mjYAacrrYqmq6rCUCwhJWaP3C3ucPVPnvjnFyvfXjkFlkPXFrsH9TXj11pOQo1KnhLc
	NVQxdYc8QdOlD3lXtNpReV8TOduYxzB2XjkJsnagxGeoDpH2qCFkZcWQFXVzTCahW3P3FPb1iiQ
	RJc9MfpwvehOeP7Eq1qYVIi1vX/2alKozIbg+GyvTF8ALEKO22gVyAVQue0b1UKsIg+9iwk14aX
	WdU4MFGfmZTUW5ENX9OdNw2YEV14iuiG6c8BKHbPZ+/xi4oqEZmQE52hgvfcMLieq81yKjH
X-Received: by 2002:a05:620a:710e:b0:93e:5e2c:8c12 with SMTP id af79cd13be357-93ebd2aae46mr2482764785a.60.1791971736775;
        Wed, 14 Oct 2026 02:55:36 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5055eb3sm453074985a.33.2026.10.14.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:55:35 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v6 0/4] net/sched: cap the accounted backlog before it can wrap
Date: Wed, 14 Oct 2026 05:55:28 -0400
Message-Id: <QDISC-BA27.v6.r0.20261014054826@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series bounds the accounted backlog of the AQM qdiscs so that it
cannot wrap mod 2^32.

v1 widened the counters to u64 and was rejected; from v2 on the fix drops
at enqueue instead. The v5 posting was a single patch; at the reviewer's
request it is split here into four:

  1/4  classifier refactor: cake_tcf_classify() and fq_codel_classify()
       return their result to the caller.
  2/4  cake: use a dedicated split-GSO list iterator.
  3/4  the fix: drop at enqueue once the stored backlog is within one
       maximum-size packet of the wrap point, and clamp the stabless GSO
       producer in qdisc_pkt_len_segs_init(). Covers fq_codel, cake,
       codel, pie, fq_pie, dualpi2, RED, pfifo, plug and gred.
  4/4  cake: split cake_hash() into side-effect-free key extraction (on
       the unsegmented skb) and set-associative resolution (after
       admission), and move the split-GSO path ahead of the resolution.

The commit logs and the in-code comments are rewritten for readability.

The guard half is a net fix, but the CAKE hash split is new-code net-next
material, so the series targets net-next with no Fixes: (the aggregate
wrap predates every touched qdisc).

Changes in v6:
  - Rewrite as a four-patch series per Toke Høiland-Jørgensen's review of
    v5: split the classifier refactor, the split-GSO iterator, the overflow
    guard and the cake hash split into separate patches, and drop the
    verbose commit prose and the in-code comments that read as
    machine-written.
  - Considered the Sashiko gemini v5 TC_ACT_CONSUMED report; not folded.
    No in-tree producer can deliver TC_ACT_CONSUMED to a qdisc classify
    switch, so the fall-through it describes is unreachable: act_ct returns
    it only when bound to a clsact or ingress qdisc (11cb63b0d1a0), and
    act_mirred returns it only for a redirect that does not clone, which
    requires an ingress skb. cls_bpf and act_bpf map an unrecognized opcode
    such as CONSUMED to TC_ACT_UNSPEC.

v5 Considered Comments from Sashiko nipa and Simon:
  - cake: the cake_tcf_classify() block comment had an embedded "/*"
    ("else *flow/*host"), which trips a -Wcomment / W=1 build warning.
    Simon Horman reported it on v4 and noted it likely suppressed the
    Sashiko nipa review; reworded to drop the nested comment.
  - cake: reword the same comment so it no longer says the function
    returns true for "a matched no usable flow" result (Sashiko nipa v3
    Low): cake_tcf_classify() returns true only for a terminal TC action;
    a matched-but-unusable classid leaves the overrides at 0 and the
    packet is hashed as before (fq_codel_classify() differs).
  - commit log: soften the claim that the 1 MiB headroom always bounds a
    single packet (Sashiko nipa v3 High).

v4  fold the Sashiko nipa v3 review:
  - cake: compute the flow/host hash keys from the packet as received
    (before skb_gso_segment(), which can rewrite an encapsulated GSO
    packet's headers to the inner ones), but defer the set-associative
    resolution that writes q->tags[], the flow host indices, the way
    counters and the host bulk-flow counts until after the split-GSO
    segment-sum admission check, so a packet rejected by that check
    commits no flow state.
  - cake: in the split-GSO rejection, handle a fraglist GSO (whose
    skb_segment_list() returns the original skb as the list head with an
    extra reference, segs == skb) by dropping the caller's reference and
    queueing the list once, instead of calling __qdisc_drop_all() and
    qdisc_drop_reason() on the same skb, which self-linked *to_free.

v3  fold the v2 review (Eric Dumazet) and Sashiko gemini v2:
  - Test the stored backlog via qdisc_backlog_at_max() instead of
    (u64)backlog + qdisc_pkt_len() > QDISC_MAX_BACKLOG: no double-count
    of the reserved 1 MiB headroom, no per-enqueue 64-bit add.
  - cake: run the external classifier first, honor its terminal TC
    actions, then the ceiling check, then the hash and the shaper state;
    the SPLIT_GSO segment sum is checked before any flow/host state is
    committed and the list is deferred to to_free rather than freed
    under the qdisc lock.
  - fq_codel: run the external classifier (terminal actions honored)
    first, then the ceiling check before fq_codel_hash(); document the
    fq_codel_drop() NULL flow->head consequence.
  - pfifo: same ceiling guard, since RED reads a (graftable) child's
    backlog and SFB's default child is pfifo.

v2 approach rewrite per list discussion of v1:
  v1 approached the wrap by widening the per-flow backlog counters to
  u64. Eric Dumazet rejected the framing ("Storing 4GB in a qdisc is
  absolutely insane") and asked for a drop at enqueue once the backlog
  approaches the wrap point. Sebastian Moeller noted tc-stab is the
  generic overhead-accounting mechanism, so the fix must not penalize
  normal stab use.
  v2 replaces the u64 widening with an enqueue-side pre-check against
  QDISC_MAX_BACKLOG and drops with QDISC_DROP_OVERLIMIT. No counter is
  widened, so the 32-bit sch->qstats.backlog the AQM reads can no longer
  wrap. Same-pattern siblings fixed in one patch: fq_codel, cake, codel,
  pie, fq_pie, dualpi2, RED.

Jamal Hadi Salim (4):
  net/sched: cake, fq_codel: return the classifier result to the caller
  net/sched: cake: use a dedicated split-GSO list iterator
  net/sched: cap the accounted backlog before it can wrap
  net/sched: cake: hash before segmenting and reject an overlong split

 include/net/pkt_sched.h   |   1 -
 include/net/sch_generic.h |  15 ++++
 net/core/dev.c            |  15 +++-
 net/sched/sch_cake.c      | 183 +++++++++++++++++++++++++++-----------
 net/sched/sch_codel.c     |  16 ++--
 net/sched/sch_dualpi2.c   |   1 +
 net/sched/sch_fifo.c      |   6 ++
 net/sched/sch_fq_codel.c  |  55 +++++++++---
 net/sched/sch_fq_pie.c    |   3 +-
 net/sched/sch_gred.c      |  10 +++
 net/sched/sch_pie.c       |   3 +-
 net/sched/sch_plug.c      |   9 +-
 net/sched/sch_red.c       |  25 ++++--
 13 files changed, 262 insertions(+), 80 deletions(-)

-- 
2.43.0

