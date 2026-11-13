Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794569157;
	b=XF1j4vAzlgHK9fiVJM5+VMNG71fJKYiaQYWzsI8hsfGzMwCuKkY8Rg/Bxa8Enfzc025M
	 l1dXNDbkfOFrKNySwzgDhV3613RxyxMVRLoKAGxgo/VxYj83cCG/tiPkNFG4PLah/v46F
	 sMSV7YLe8yBYnNHxKD30SSn4fwUXoKKbTodvkjrDUzIlThxovpG4xDAmS2/nObeVN1OEC
	 2L6NMrpin6jct0JnKBIm1FOumxmjSDp0b8M3i/BC2zSSfEdNIBpohmPPQw4XGgMd2Spm7
	 qwVSpZX+0n/0bLZRren4Zm3f1jofdbZed5wb3i18AghQ9UbYK+cHqbSxq96KRot84IQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=TdnaEhEEMD62fi/Ro4pHyfdxHQ5g+8KcZWgKshSQ4QI=;
	b=HrWlNnzDTXtkJRK+y/xfUb6fDC2ipKh6H4bajIxpm+I/Wa+ArZrErCSc/Z/FIETgxIIz
	 73vrtdKtiNb12fnMWZWK/UpF0CkpFzkY0Cf/lDPwMlsyaCVx/mN15GtqOnuJWqGr+IT4U
	 KT7/99nd2j7AkL/37YNWQk7P+4pfWcgPmREJQyYXhZM2mE/7D6Tt5a3zgQp2SAeKb7j9K
	 2Y/ZrE6W/DyfQ4jb+rUzX7xdI4CUji5hLyiZoUy+hHgKOaWMDuyN5uV/CkYOUJCHzyIi/
	 QYr76lFSu/UspAfBoZFdUN9w9bjAeCFDfc2EN7i7Xt81CAVuWu64wi7XVYRduKKPXdw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KH7W4nS3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B89606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3B89606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=KH7W4nS3
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a05b210703so349672b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:25:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794569156; cv=none;
        d=google.com; s=arc-20260327;
        b=QtRO+RAISWnV0t7Xdkk9XvggajKwcr6/BbTtfMGUQrOQWE59QLgtSqrZm3ubuqPDQH
         3DXvlMYa/35hnZQRpdYKHzCvSr66iikcSzdy9Szi6ot24QQoYLE/NMfGQmymOy9Ic9go
         1PhHi2N5Yctg0djdTQko71QVmwt3t/3aUi4otE7xO683tSB4xertClFCGcm31VBUxgXW
         jCbiHa3L8pXTdk48W7MeWziwNLYScW+chi6rGl1Q74lkFiOWmWzprEFVATneWAclKxvq
         5OlQtk3DU58T8dsSMBSiLA7FJdHTRlVgX2z2McrglJ0IyAcF5TpWaBaAFGU2jNdR+25M
         3xEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TdnaEhEEMD62fi/Ro4pHyfdxHQ5g+8KcZWgKshSQ4QI=;
        fh=0ND5cusOqB+elCdvGXmAw+cr/viCVJcrDFrkI5lfAxw=;
        b=NtJ3K7hRWcECMkQnxzJQnt5RLgxvwz8iFb0DcgA0Zva0bcifP7MCdtxtd/6HwyRYeK
         2EFbfQusOvlxFxBNFYTSvxvuF1OjpgaQTss2BHDZHRb2iKeVrHiUbOFT5cZNQwBFEo3Y
         jMk7uHmIsxMvxzmbssn5xBTheRoCmJMeYZtS+UVnMBGvzdJlutzaiCmII3lPqjxzvJYU
         AWn7/3qHKB4LbgQBWGC6kORUKcb5gxiv5zjogOf5mzH1SHq7tZk++yDSHTbJhIOyPfYW
         TdVHQMoXFLFBcO0NyxLbOpk+QVAcDMyEOYrhr8dPtZvfLv8YjB+GXl4Y25yWoluTqXgm
         LZEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794569156; x=1795173956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TdnaEhEEMD62fi/Ro4pHyfdxHQ5g+8KcZWgKshSQ4QI=;
        b=KH7W4nS3xaaMbZooOAif9RxXc0zvpGvOUoQoYnJTyDqfBy6bnOEi+z6YWzYM12FdEQ
         lXUe/jm2SiG6o3Sb4cc6aZ1IQ8dNrG1NE1swYn8xt6KjDhwkQ26LjqiIXBWume0kmxEH
         szevfkjex+cYKoCt2HmfQSiHDI5jXrZo+1sjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569156; x=1795173956;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TdnaEhEEMD62fi/Ro4pHyfdxHQ5g+8KcZWgKshSQ4QI=;
        b=QDgEJSmvjkb0NbnaX/uE7T2dWVE4DCmkn2+Z474LdfRwBGC+qZunom6+r96sM7evSM
         urxbmLP0yiGEOduJ7hyJGCgOwFp/wjCW25JCHYPECR9Zpt3KEy9dDko5EUbMXEhLgZ1C
         UMqVlEDrx+iBZSDI5/yUqScIq+Jb/Q2LP1yolBkcSFtQYckkLpA+4QBTx/rZDuNx3WTA
         0gIh8XpKP+ZSwwbFZMqNC68d81dbWl7gbOgAB8k7G6TX//2z7aA3bG02az34GzRVD9GL
         YJQf4aA18JM3flqh59PHMheQFVQDz49VOmSPwhO0HWraP36AGM/FOfZc1Ba6L3jqgc0b
         TCQg==
X-Gm-Message-State: APuU4Z/ANI2df308yP5qiT5E+1L26U7G08B8Cb3udZ2TnlQ3a+VG0CHz
	9X39vYDS82VME/d+fGUN9QHqZaN5JTuHa6luKRfubN5h3GmnwW0/4HGXVS3CUY3VZM0CfujRJ7H
	Iwg32YaRKHKdeCs3ZHocXCT425bQ4SLIEqopKG7lET4A4o9fbutUbfA==
X-Gm-Gg: AYBFou1XHN+D700pNHG1/SJuWwcnOFyoBLEjYpDjAXCpsUHyh+URn3PVlRidTOAEb+h
	HgNOOzvynEUUKafjx2r6X5OTIdYKsK0t1rOVcvpP2G+V4ubG5ej4U/4c8leYUdA/0y1hrVf+SEz
	mwwQuGq/KncvTQSsFs+XNzseU+Cyz7baZysVdGLv5Ko8JlTkNnqf7Pg3SvnSoJRptY5m/6L/GL/
	Lvwrh3Mu9pLQNbiUdSf2zLuIh5EkXtvWF6NaqPVwCHR8uDCuzKmN02i3wuzNkBEFqzbWQMvgCTg
	BMZJDLyHGyksFktsrUW6QHqYXu4vZ+M/1/kAOE0gbncy95LnhueGr9JH2Yb9ldxfzaYXpIpKB68
	r838K+Uc1CLCc9Fp1eIT+xI7BNF+YwR3q+t86Poel4BxJ61giQK8v9FMPXfwCIPKgtY/lSGqyKe
	w8fDKA05GPbIXT0AUsHtRI
X-Received: by 2002:a05:6a00:1392:b0:88d:5832:d96c with SMTP id
 d2e1a72fcca58-8beb7635d7emr2402379b3a.50.1794569155890; Fri, 13 Nov 2026
 03:25:55 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-BA27.v9.r0.20261108195325@mojatatu.com>
In-Reply-To: <QDISC-BA27.v9.r0.20261108195325@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 13 Nov 2026 06:25:44 -0500
X-Gm-Features: AclHuK96mncIjxXhejNUYScJbQHU9ubCEaLBlj3fEgR-aNIYI2z9TX3wJX2a0VM
Message-ID: <CAM0EoMkoXEtqWZ+qCJqLNjUEP5c86hoJP39ybJE2avaMJjh8_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v9 0/4] net/sched: cap the accounted backlog
 before it can wrap
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Victor Nogueira <victor@mojatatu.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> This series bounds the accounted backlog of the AQM qdiscs so that it
> cannot wrap mod 2^32.
>
> v1 widened the counters to u64 and was rejected; from v2 on the fix drops
> at enqueue instead. The v5 posting was a single patch; at the reviewer's
> request it is split into four:
>
>   1/4  cake: classifier refactor: cake_tcf_classify() returns its result
>        to the caller.
>   2/4  cake: use a dedicated split-GSO list iterator.
>   3/4  the fix: drop at enqueue once the stored backlog cannot
>        represent the packet's accounted length -- the standing
>        QDISC_MAX_BACKLOG ceiling for ordinary packets, a per-packet
>        representability check for the larger wire estimates. Covers
>        fq_codel, cake, codel, pie, fq_pie, dualpi2, RED, pfifo, plug
>        and gred.
>   4/4  cake: split cake_hash() into side-effect-free key extraction (on
>        the unsegmented skb) and set-associative resolution (after
>        admission), move the split-GSO path ahead of the resolution, and
>        tag every deferred split segment.
>
> For the sashikos: This series targets net-next with no Fixes: (the
> aggregate wrap predates every touched qdisc).
> Unfortunately something broke in the sashiko reviews. Review for v7
> showed up a while later after v8.  So you will see that this series
> has fixes (majority in comments and commit logs) from both.
>

Responding here to address the two sashiko reviews that came out
(thanks for getting that out in record time!).
Sashiko-nipa found legitimate commit log misstatements; the code is fine.
Looking at the history, this patch series has now been going on for 3
months! At some point between v7 and v8
a bunch of merges occurred (one that had the most effect on the
accuracy of the commit  log was Eric's c6648c9f3b51).
I am sure all of us look at the code to make sure we are compatible
with latest target tree, but does anyone look at
"the comment i made on the commit log i made in v6 is no longer
accurate somewhere between v7 and v8" - you have
plenty of time in your hands if you do. But on the other hand i admit
that the commit log is not accurate anymore.
I am honestly exhausted sending this series over and over. I can send
a v10 but sashiko will find something to nitpick on.
and this could go on for another month and i have plenty of other
patches in the backlog this is taking time away from.

Thoughts? One other option is i send a fixed v10 and you apply it as
fast as possible..

cheers,
jamal

> Changes in v9 (late Sashiko nipa reviews of v7 and v8, delivered on lore)=
:
>   - 1/4: reword the "The Fix:" heading; this patch is preparation, not a
>     fix.
>   - 1/4: the classifier helper's comments now say the caller must drop
>     the skb, since a terminal action does not take ownership of it.
>   - 3/4: bound the child backlog as well as RED's aggregate, and re-deriv=
e
>     the aggregate from snapshots taken before the reservation when the
>     enqueue does not succeed. A child that returns NET_XMIT_CN may or may
>     not have reduced its ancestors already: pfifo_head_drop, sfq and
>     fq_codel do, while hhf and skbprio evict a packet and return without
>     qdisc_tree_reduce_backlog(). Keep what the child actually accounted
>     for and pass any difference on to the ancestors above RED, so neither
>     counter can diverge. Verified with two A/B witnesses: RED over a
>     grafted hhf child (control ends with red_backlog 2042016 !=3D
>     child_backlog 6177600) and RED under an HTB class over a grafted
>     pfifo_head_drop limit 1, where an unequal shrinking replacement
>     otherwise wraps the aggregate and wedges the new admission guard --
>     control 4294966052, fixed 92 with RED =3D=3D child =3D=3D HTB.
>   - 3/4: note that CAKE's own split-GSO branch is the second exception;
>     the segments it accounts are summed and checked against
>     QDISC_MAX_BACKLOG by 4/4 before any of them is linked.
>   - 4/4: add the split-GSO "Conditions to recreate the bug" recipe for th=
e
>     segment-sum rejection at the split ceiling.
>   - 4/4: the IS_ERR_OR_NULL(segs) segmentation-failure return uses
>     qdisc_drop_reason(..., QDISC_DROP_GENERIC); __skb_gso_segment() has
>     already clobbered tc_skb_cb.drop_reason through SKB_GSO_CB, so the ol=
d
>     qdisc_drop() reported an unrelated core reason and skipped
>     trace_qdisc_drop.
>   - 4/4: pass the flow_mode snapshot to the later flowchain calls
>     (cake_get_flow_quantum(), cake_inc_srchost_bulk_flow_count(),
>     cake_inc_dsthost_bulk_flow_count()) as well, so one enqueue sees one
>     mode (KCSAN-visible race and stale host index).
>
> Changes in v8:
>   - 1/4 is cake-only. fq_codel_classify() is line-for-line the same as
>     fq_pie_classify(), and fq_pie is not changed by this series, so the
>     two stay in lockstep: fq_codel keeps its original classify shape and
>     the fq_codel backlog guard is placed inline in its enqueue path
>     (3/4) instead. (Toke H=C3=B8iland-J=C3=B8rgensen)
>   - 3/4: the fq_codel guard sits between idx-- and
>     codel_set_enqueue_time(), so a dropped packet cannot touch flow
>     state. The commit message is reworded as suggested. (Toke
>     H=C3=B8iland-J=C3=B8rgensen)
>   - 4/4: the original skb is consumed unconditionally right after a
>     successful split -- that is the caller's reference, since a fraglist
>     GSO takes the list's own reference on the same skb in
>     skb_segment_list() -- so the reject branch tags every deferred
>     segment and drops the whole list with qdisc_drop_all(), and the
>     admitted path no longer consumes the skb after the walk. (Toke
>     H=C3=B8iland-J=C3=B8rgensen)
>
> Changes in v7:
>   - 1/4: complete the fq_codel_classify() comment (Sashiko nipa v6
>     main-2-1, Low). The comment listed only the terminal-action and
>     no-class-ID cases; the function also returns true when no filter
>     matched or when the selected class minor is above q->flows_cnt,
>     and those packets are BYPASS drops, not a fallback to hashing as
>     in cake. Comment-only, no code change; folded into this resend
>     since the series is revised anyway.
>   - 3/4: do not clamp the shared qdisc_pkt_len() (Sashiko nipa v6
>     main-2-6, Medium). The clamp silently undercharged BPF
>     __sk_buff.wire_len, act_police and the HTB/TBF shapers for a valid
>     large GSO estimate. The initializer now stays truthful for every
>     input and the overflow protection is enqueue admission: each
>     affected qdisc drops a packet once the stored backlog cannot
>     represent its accounted length -- the standing QDISC_MAX_BACKLOG
>     ceiling covers ordinary packets, and a per-packet representability
>     check covers the larger wire estimates, which a supported
>     small-MSS BIG TCP aggregate can legitimately carry above 1 MiB
>     while its raw length stays within GSO_MAX_SIZE. The consumers read
>     the real length, and sch_handle_ingress() keeps complete pkt_segs
>     metadata.
>   - 4/4: tag every deferred split-GSO segment with QDISC_DROP_OVERLIMIT
>     (Sashiko nipa v6 gpt-6-astra-2-5, Medium). __skb_gso_segment() stores
>     SKB_GSO_CB at cb offset 32, aliasing tc_skb_cb.drop_reason, and the c=
b
>     is copied into every segment, so tagging only the head left the rest
>     with GSO scratch as their drop reason.
>   - 4/4: snapshot q->config->flow_mode once with READ_ONCE() and pass it
>     to both hash helpers (Sashiko nipa v6 gpt-6-astra-5-9, Low). The spli=
t
>     introduced two loads with the segmentation work between them.
>   - Not folded: the 3/4 intermediate-commit split-GSO limitation (4/4
>     closes it; the pre-series path was already unbounded) and the
>     Fixes:/stable suggestions (intentional net-next target). The gemini
>     v6 TC_ACT_CONSUMED High is the v5 finding already rebutted as
>     unreachable from a qdisc classify switch.
>
> v6  rewrite as a four-patch series per Toke H=C3=B8iland-J=C3=B8rgensen's=
 review of
>     v5 (split the classifier refactor, the split-GSO iterator, the
>     overflow guard and the cake hash split; drop the machine-written
>     prose). Considered the Sashiko gemini v5 TC_ACT_CONSUMED report and
>     did not fold it (unreachable; see below). Reworded the cake block
>     comment that had an embedded "/*" (Simon Horman's W=3D1 warning) and
>     reworded a comment that overstated the classifier's return cases. The
>     TC_ACT_CONSUMED switch case was dropped from the final 0001 because i=
t
>     still reached __qdisc_drop(); no in-tree producer can deliver
>     TC_ACT_CONSUMED to a qdisc classify switch (act_ct returns it only on
>     a clsact/ingress qdisc, act_mirred only for a non-cloning ingress
>     redirect, and cls_bpf/act_bpf remap an unknown verdict to UNSPEC).
>
> v5/v4/v3/v2 history: see the v6 posting. In short, v3 adopted the stored
>     backlog compare qdisc_backlog_at_max() (no double-count of the 1 MiB
>     headroom, no per-enqueue 64-bit add), moved the classifier and the
>     ceiling check ahead of the hash/shaper state, and added pfifo; v4
>     split the hash keys from the set-associative resolution and handled
>     the fraglist-GSO self-link; v2 replaced the rejected u64 widening wit=
h
>     the enqueue drop; v1 widened the counters.
>
> Jamal Hadi Salim (4):
>   net/sched: cake: return the classifier result to the caller
>   net/sched: cake: use a dedicated split-GSO list iterator
>   net/sched: cap the accounted backlog before it can wrap
>   net/sched: cake: hash before segmenting and reject an overlong split
>
>  include/net/pkt_sched.h   |   1 -
>  include/net/sch_generic.h |  20 +++++
>  net/sched/sch_cake.c      | 185 ++++++++++++++++++++++++++------------
>  net/sched/sch_codel.c     |  16 ++--
>  net/sched/sch_dualpi2.c   |   1 +
>  net/sched/sch_fifo.c      |   6 ++
>  net/sched/sch_fq_codel.c  |   9 ++
>  net/sched/sch_fq_pie.c    |   3 +-
>  net/sched/sch_gred.c      |   9 ++
>  net/sched/sch_pie.c       |   3 +-
>  net/sched/sch_plug.c      |   9 +-
>  net/sched/sch_red.c       |  46 ++++++++--
>  12 files changed, 237 insertions(+), 71 deletions(-)
>
> --
> 2.43.0
>
