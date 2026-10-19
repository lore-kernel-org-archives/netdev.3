Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425645;
	b=e7LAsW8jKQLbXU7UMLl3wCqtqBKPbUo3gGsDUW3tKPVcBU48L9LzNAlvJE74rSwTKsIa
	 UDgPlsvG06mu8YbSaiVefjTdEZDlZVNgk7kp0KoI5xnA8lHpOsXce0TmnxMH32ZCVIXfG
	 +cKzSNMl6w5A46bfmHNUkEBFolai4MM8q5snBqzISo68w7PrR5BRUwQ8wkdA629NSLGRT
	 tTnxaE/qeXNAF4kJCaaipl0qeh+a87VQ59I8t9FVezfnhwPskxLjsUMkG3DIgzjW93rJV
	 qOsss17b+JLRba8vfBP7iN2ne1WnHA//19Yu66bDgKqA00iU7XmRWYCexatt4UvwZKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wl2l3xZiV3GMdkN8yEd3Pd+wMwnhZ/psQh4P8Rru1cw=;
	b=ZlEHRUmM3u97nej4uoahXdpKqMfOnS6Aqo7Nxm0A6HSJiCzhaGfVH3ta12lCmEfNy4Zy
	 bNlQ5GxBFgBAf+S6TVyTjM8YYcMe+YURo7vNcQDuyOWb5kOiOeJIcQFQ9BiUHZNznUu0c
	 sU5md6LSksJVpK26h58ByWVi8YToN9btZ2V7iZ/m2ass1j5Xqrk1x+S6zCCRtviDM7Ypn
	 hf1bHrpDn5BDXIA1jfTvXYWdi6rWEEVVkaBHCfCFNPgoNxKgZKy8nCXOO8xIP2lqImR9u
	 Mpas7ZUGktHchSxqg8N994CEl4ZC3hytIGE3O2hbUCVqghPdQXChScl2ZXXsb/nfqKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=iSwUOA3T;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21B606AAF9
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F21B606AAF9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=iSwUOA3T
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53512cd2f85so25954701cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792425643; x=1793030443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wl2l3xZiV3GMdkN8yEd3Pd+wMwnhZ/psQh4P8Rru1cw=;
        b=iSwUOA3TmMag/WGBrQQoZPqDrDhWIcYIXTz1kLkhq/7BFcs/+X1GEwPh/sjcPuQJpy
         PUO0vf8i97/zp8JnALSzsA3Aj7UwoHnPzM2Ym3mmryo3kiXcTdGmGT81ioM00SiJIlVS
         4crN3oiIkBS0pAfVWbye6E9DZ9S92AWPWoumM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425643; x=1793030443;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wl2l3xZiV3GMdkN8yEd3Pd+wMwnhZ/psQh4P8Rru1cw=;
        b=OAd/pc28oMU3VRvcEi8pB2nWsb58xQ4jjoFDGCAwqLw9sZylYvOGmJAxmpqp72zkl8
         thPAfgesJHJ6UbPE+w9T7Sj9kd+QnC3BC97ae2zsmeiKwKllFU94T8zh95efc3O25Xb6
         mrvguLXJqJ8l8PI0TWrTv2jlPd1pDqgDR7ZwkA3XcXkzEBarG2a7El9EQZfwjlY//Quv
         HWYCpT1OLA6ezbC9Ge5DV6pcTQtN1Zqo9f8bNb8+pWmFSRJrdvQ+QZXLhB6skNL431A3
         ctYRl2T9iYpYmMbmWZGsQhNiE6q0wK+v2UJpUYuiygba5tRI71Ij//OJY1tUtGeLCSG4
         a9Mw==
X-Gm-Message-State: AFq9FYI3uGELJLjdAeRUC0ck5KDwBpmHUlVFmqK2KNxrUFQHscVV7VZQ
	gwbENYaEoMcbqIWRRzENxrRV9FiltOfQrpSF3Sxl9m8cNuNJQooBVOBgYtCQn/PSKFnUS1hwRQ8
	2xrk=
X-Gm-Gg: AYBFou19A+oMBeq7o+6zJJ2oiS4i5SlG4bYpZ4BOHFxaS6E3WyRlQxlmkSYX/bRqfAN
	+nRMSEZS5uqRcdYm2mmpkcxQgEeM2L1F1BBWhEJOF9E6YnH15BsrheFZhPHovkvoRlax6vvAyMH
	i/HZ/fgzZoZRt0E4OFX+6ejm+JSOTpZqBDMUTvFfo7lGekQNO86c4u4L4iZs/Nfkd8qUXawwlzD
	JXUp0+Sgayv+2xflcRcvpsd3AT6sNOnlJoIT7uhOgIbYbU/8BjBh1DtSTg8BjCUMzQEtTnEtVMu
	tszMJtrRR48ONjXFsX6Y9M1nHkCfSudLWu9U24l1qRnQ75+uw9vLtFGUKgn39OJHs2qADX6LUvP
	xnAZZhONyw8lVZFO2S2YjPeP7ZUu9TX4QSiwz7fF7rt8eSctCbLgsfMt9tHWSlCqnV0zVkhVUdI
	JjBqO4DxaclxjJK2JfooN6vpZX5Eet4p/gIacfvaFEjqSJIsIieW3eQktxjzxAIkz0yyNpqh0rB
	+DP5KinMCcM8IVprCwFFcn3s5xhncE3CGKdqmrEQBUT
X-Received: by 2002:ac8:5a15:0:b0:536:764e:1527 with SMTP id d75a77b69052e-536764e18e8mr32331801cf.44.1792425640866;
        Mon, 19 Oct 2026 09:00:40 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91be9d8acb5sm64846846d6.0.2026.10.19.09.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:00:40 -0700 (PDT)
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
Subject: [PATCH net-next v7 0/4] net/sched: cap the accounted backlog before it can wrap
Date: Mon, 19 Oct 2026 12:00:31 -0400
Message-Id: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
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

  1/4  classifier refactor: cake_tcf_classify() and fq_codel_classify()
       return their result to the caller.
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
  net/sched: cake, fq_codel: return the classifier result to the caller
  net/sched: cake: use a dedicated split-GSO list iterator
  net/sched: cap the accounted backlog before it can wrap
  net/sched: cake: hash before segmenting and reject an overlong split

 include/net/pkt_sched.h   |   1 -
 include/net/sch_generic.h |  20 +++++
 net/sched/sch_cake.c      | 184 +++++++++++++++++++++++++++-----------
 net/sched/sch_codel.c     |  16 ++--
 net/sched/sch_dualpi2.c   |   1 +
 net/sched/sch_fifo.c      |   6 ++
 net/sched/sch_fq_codel.c  |  55 +++++++++---
 net/sched/sch_fq_pie.c    |   3 +-
 net/sched/sch_gred.c      |   9 ++
 net/sched/sch_pie.c       |   3 +-
 net/sched/sch_plug.c      |   9 +-
 net/sched/sch_red.c       |  23 +++--
 12 files changed, 251 insertions(+), 79 deletions(-)

-- 
2.43.0

