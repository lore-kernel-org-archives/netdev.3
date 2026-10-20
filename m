Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515457;
	b=IZPNf71YL6qOw7ivGuu9xaulK7H4aMiAtFvYCpqPo1YDCDHP0PmwK7o6AOCpitRxpaXV
	 JDkA4Qqheb+Pa/GqbCH2JG70McVe6Hpz4Gj8VsQbH3xWQd2csmU7rAHgs6PBx+Gy1aXBv
	 oOImbsddlSIjmbY9C9puP+cBJT27Ezw/TeUg88+I+Qpi8oQq9/Ok7DTYbKmEuCYcIKZlr
	 BeVgGl58VHtN/5MOdZcotTOH2O0yS0MT4sZa+dakS8vRMyL9t9FqcGFs6PvxYSw7cA+aw
	 AAbEIS0oguNLPSrMvnxFXreUzCQ6gfBogtvRhXXzx58pmWIDU122AMY78UQJ66M4SHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JHEt6N5Ticf96mw5x9ZzEm52SQKQT8zrU+XA8kvKCYM=;
	b=th8WvV+ewgTocNq/3pL5/d2o1+jWg6uXFSTG4tJT6sSyp0vrlfWah1xBOv61rtdsYGro
	 qkaLuvy+zPOoSPxh7x/pYuPT2dun6H/OI5O9AMwhW3xQDmr68v6nRISDXd2KXzBHviRhr
	 NadtqGrGxFwIktGFVtXYz8YAJ4UhmZj0korZJX9PwXrPr1QxlFGYwxa8lW9iKTTMyfotk
	 yglry7kwIJANYWiSwNfjQ5JBb/MFOd8+Zc1ZeYgosQUvkf5NgXwpPmY2SIWYnXlBT9yKm
	 Xv7KzeYfCjQB99dJ43hA5utLs/43LiIpczbBJ/Y2uYb+sMeLc4xVGxVgfR6VvgcSoiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LL1tZR23;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A38E606A320
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A38E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LL1tZR23
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917866225aaso32579106d6.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792515455; x=1793120255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHEt6N5Ticf96mw5x9ZzEm52SQKQT8zrU+XA8kvKCYM=;
        b=LL1tZR23b8WQlsx7F+v+5P4/QsK7so1JJg5oRbEte9SovoIxbcR3JIqNzYebDgRjXE
         FSTmMaCOmVUDgR5nNE9FOfcUHPmLiOxnAICjswnYPkli2ue1nKd2PHDxut4LdXGiexNK
         S9lNdxmhZypZPZNCW+t8CY6ba9QxrpTaqKNvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515455; x=1793120255;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHEt6N5Ticf96mw5x9ZzEm52SQKQT8zrU+XA8kvKCYM=;
        b=JptGYNY69qljLFTTPm7gzi6yGykCGJmhBVeLHIempZahVmCWuqmVI/1YOaAAKVjH75
         VH9r7pEFcujkEv1bTnaQ6TJMfn8mTgB/bR2f5OUfqK3gStby/1iXB8awwg6uyOoJaClY
         ExENoM7UlWsRv0fbBILg6ByFTcNJcW0wcwMV0+QF90UNrv38a4yV4Cc0XIM2q3RpUNxx
         v+5GIQ94fIn/jkWGy3g4pIfOBafeJUcHuLMhd9JkX95zK0jwVEEVhEc8GQSmlUrqk9F/
         CmALFXgDJJpc3gV42sgldqhrRgKMO8Vho/0wTkSfz3PLRQlOv7ZBdUMGKgaqW+zIjriw
         LVsg==
X-Gm-Message-State: AFq9FYIEZkmV8bXAHc46Bk7MEKJG1PqAvHIlI31fIWN9a9QCeUtf4Orp
	pSapwDX7drbWeZBAIZ1TUjPPkUbeSMNDXeg5mSCcly+MIHcQW+1fT7OvEM3EtPv8OTOO6rE8K9L
	hRIk=
X-Gm-Gg: AYBFou3BvRgzRmfsv50g1Cm/QWKJNfl43/Vo6Jen0p6O/X2UVxLV+nm+LcbRUZrtQnJ
	8rv6aD05w6v9jmfrSfPowRhLhLmKkBF7/BEK7cS2dkripYLZgIPuSd2sBKKCedDVduZvOR1hUdM
	j9O3wWIPk0W7RujPCD+PaYkLAa/ugWF4CFzDdh7xiDvsVREfvoEoqZU7CXA58GrVypzMCsrYeUz
	EG0TlMJ5iJGBJmpfg+URN/CMZAmaQBkhhHJwXSXyUiJAjErXA81WaqWGMOuDKeAR4yJQZ1/kqfb
	l0iUnjVv2MfZD4XcYpkabPbdHbfnwAye2ltpLIlYksVzqD+oqBRiWlnq9fcvCKlHYBFiBlCL7ws
	3U6oLHwpEqI1wHOhHdkJu3UkRjYMSeiWNqMsNyfMET++IXRbSWCT/P/KXD89pwQmyj67usl+qhW
	V8HvLYtPHcfLJJAXqe52Oe2+bTpeEgaUf/OR6T//+fvWpV/VKbf7PCGQ5bRQaIXCVW+aZsT8sxk
	PnlvwIlk83h8hXpvVVKLtjeqbdm3mIJUkLrLCwYHBbX
X-Received: by 2002:a05:6214:2f89:b0:91b:8d3b:7d44 with SMTP id 6a1803df08f44-91bdf0a1fc1mr203880666d6.19.1792515455088;
        Tue, 20 Oct 2026 09:57:35 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a441acsm3034586d6.6.2026.10.20.09.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:57:34 -0700 (PDT)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v8 0/4] net/sched: cap the accounted backlog before it can wrap
Date: Tue, 20 Oct 2026 12:57:26 -0400
Message-Id: <QDISC-BA27.v8.r0.20261020063241@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series bounds the accounted backlog of the AQM qdiscs so that it
cannot wrap mod 2^32.

v1 widened the counters to u64 and was rejected; from v2 on the fix drops
at enqueue instead. The v5 posting was a single patch; at the reviewer's
request it is split into four:

  1/4  cake: classifier refactor: cake_tcf_classify() returns its result
       to the caller.
  2/4  cake: use a dedicated split-GSO list iterator.
  3/4  the fix: drop at enqueue once the stored backlog cannot
       represent the packet's accounted length -- the standing
       QDISC_MAX_BACKLOG ceiling for ordinary packets, a per-packet
       representability check for the larger wire estimates. Covers
       fq_codel, cake, codel, pie, fq_pie, dualpi2, RED, pfifo, plug
       and gred.
  4/4  cake: split cake_hash() into side-effect-free key extraction (on
       the unsegmented skb) and set-associative resolution (after
       admission), move the split-GSO path ahead of the resolution, and
       tag every deferred split segment.

The commit logs and the in-code comments are written for readability.

The guard half is a net fix, but the CAKE hash split is new-code net-next
material, so the series targets net-next with no Fixes: (the aggregate
wrap predates every touched qdisc).

Changes in v8:
  - 1/4 is cake-only. fq_codel_classify() is line-for-line the same as
    fq_pie_classify(), and fq_pie is not changed by this series, so the
    two stay in lockstep: fq_codel keeps its original classify shape and
    the fq_codel backlog guard is placed inline in its enqueue path
    (3/4) instead. (Toke Høiland-Jørgensen)
  - 3/4: the fq_codel guard sits between idx-- and
    codel_set_enqueue_time(), so a dropped packet cannot touch flow
    state. The commit message is reworded as suggested. (Toke
    Høiland-Jørgensen)
  - 4/4: the original skb is consumed unconditionally right after a
    successful split -- that is the caller's reference, since a fraglist
    GSO takes the list's own reference on the same skb in
    skb_segment_list() -- so the reject branch tags every deferred
    segment and drops the whole list with qdisc_drop_all(), and the
    admitted path no longer consumes the skb after the walk. (Toke
    Høiland-Jørgensen)

Changes in v7:
  - 1/4: complete the fq_codel_classify() comment (Sashiko nipa v6
    main-2-1, Low). The comment listed only the terminal-action and
    no-class-ID cases; the function also returns true when no filter
    matched or when the selected class minor is above q->flows_cnt,
    and those packets are BYPASS drops, not a fallback to hashing as
    in cake. Comment-only, no code change; folded into this resend
    since the series is revised anyway.
  - 3/4: do not clamp the shared qdisc_pkt_len() (Sashiko nipa v6
    main-2-6, Medium). The clamp silently undercharged BPF
    __sk_buff.wire_len, act_police and the HTB/TBF shapers for a valid
    large GSO estimate. The initializer now stays truthful for every
    input and the overflow protection is enqueue admission: each
    affected qdisc drops a packet once the stored backlog cannot
    represent its accounted length -- the standing QDISC_MAX_BACKLOG
    ceiling covers ordinary packets, and a per-packet representability
    check covers the larger wire estimates, which a supported
    small-MSS BIG TCP aggregate can legitimately carry above 1 MiB
    while its raw length stays within GSO_MAX_SIZE. The consumers read
    the real length, and sch_handle_ingress() keeps complete pkt_segs
    metadata.
  - 4/4: tag every deferred split-GSO segment with QDISC_DROP_OVERLIMIT
    (Sashiko nipa v6 gpt-6-astra-2-5, Medium). __skb_gso_segment() stores
    SKB_GSO_CB at cb offset 32, aliasing tc_skb_cb.drop_reason, and the cb
    is copied into every segment, so tagging only the head left the rest
    with GSO scratch as their drop reason.
  - 4/4: snapshot q->config->flow_mode once with READ_ONCE() and pass it
    to both hash helpers (Sashiko nipa v6 gpt-6-astra-5-9, Low). The split
    introduced two loads with the segmentation work between them.
  - Not folded: the 3/4 intermediate-commit split-GSO limitation (4/4
    closes it; the pre-series path was already unbounded) and the
    Fixes:/stable suggestions (intentional net-next target). The gemini
    v6 TC_ACT_CONSUMED High is the v5 finding already rebutted as
    unreachable from a qdisc classify switch.

v6  rewrite as a four-patch series per Toke Høiland-Jørgensen's review of
    v5 (split the classifier refactor, the split-GSO iterator, the
    overflow guard and the cake hash split; drop the machine-written
    prose). Considered the Sashiko gemini v5 TC_ACT_CONSUMED report and
    did not fold it (unreachable; see below). Reworded the cake block
    comment that had an embedded "/*" (Simon Horman's W=1 warning) and
    reworded a comment that overstated the classifier's return cases. The
    TC_ACT_CONSUMED switch case was dropped from the final 0001 because it
    still reached __qdisc_drop(); no in-tree producer can deliver
    TC_ACT_CONSUMED to a qdisc classify switch (act_ct returns it only on
    a clsact/ingress qdisc, act_mirred only for a non-cloning ingress
    redirect, and cls_bpf/act_bpf remap an unknown verdict to UNSPEC).

v5/v4/v3/v2 history: see the v6 posting. In short, v3 adopted the stored
    backlog compare qdisc_backlog_at_max() (no double-count of the 1 MiB
    headroom, no per-enqueue 64-bit add), moved the classifier and the
    ceiling check ahead of the hash/shaper state, and added pfifo; v4
    split the hash keys from the set-associative resolution and handled
    the fraglist-GSO self-link; v2 replaced the rejected u64 widening with
    the enqueue drop; v1 widened the counters.

Jamal Hadi Salim (4):
  net/sched: cake: return the classifier result to the caller
  net/sched: cake: use a dedicated split-GSO list iterator
  net/sched: cap the accounted backlog before it can wrap
  net/sched: cake: hash before segmenting and reject an overlong split

 include/net/pkt_sched.h   |   1 -
 include/net/sch_generic.h |  20 +++++
 net/sched/sch_cake.c      | 177 +++++++++++++++++++++++++++-----------
 net/sched/sch_codel.c     |  16 ++--
 net/sched/sch_dualpi2.c   |   1 +
 net/sched/sch_fifo.c      |   6 ++
 net/sched/sch_fq_codel.c  |   9 ++
 net/sched/sch_fq_pie.c    |   3 +-
 net/sched/sch_gred.c      |   9 ++
 net/sched/sch_pie.c       |   3 +-
 net/sched/sch_plug.c      |   9 +-
 net/sched/sch_red.c       |  23 +++--
 12 files changed, 209 insertions(+), 68 deletions(-)

-- 
2.43.0

