Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496735;
	b=ZEM2aGCfR59RiHEdySwxQvFIo2fU/oaJyrrfK/NI9N/rdAXq1XFPyjZQP5ZZC/F2PTsk
	 Adj9cjl3N1ZMt71dv7LFYzRx1IIpJ+QSaNCTMw8Oa2ZPw6H+SHesdPXEOp6gNxx73JJs3
	 dJ049fuB5O8ogcAGBxkN/waoUBnkP7rxs3wki/xsRwvEpcyjkvoWFm2reies9XF0op/mH
	 QliNKrfMQN27aVHj5X7X6e1Hanc0YsNAQnikbrwqMHrq+RJls6C6Zr2H/Wxa3HUG8IYKX
	 8lXUgrcGPtTbr2Pv8bf1UZBvZooBejX0WT+D4RCFTdD143CmflNrsN2jyuJsIkoZ18A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496735;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=O4retKXfZfGi5TkhdGR048w8yXstFJMdaut+TLhYad0=;
	b=Hey86aIPAjVD9tvluGraa/YhcQpwJgkZUqPgu3f0RmJXVtppf8P6rTothv5m+whdnulI
	 MVByV4IiAgkev0Q701Uq21NzNkQdJ0r4X/9ivBkVDavBmgpJGksGBgf3hQF1S59qrfLvz
	 COOJTBOKJUZCg+HHJN+3ODgos84Rda1fM9kc4MwRQyptUd1T2Wt02VyLaK7nSfPP8gv/W
	 WfztXGJ79FJLq8T8xMIdYmqvT6A4TyXCOl9Ab4qmdZPO7dRhh/l2gwu01gCbiFvKJdPdR
	 e2+NgEX+AwBjV0c/G5mis/iraZDHhAzlYoNTGd0pm4R3jVPwZGPMRrrid4KBD9nxmdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171F60A2607
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 15:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1171F60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v9 3/4] net/sched: cap the accounted backlog
 before it can wrap
In-Reply-To: <QDISC-BA27.v9.r0.20261108195325-3@mojatatu.com>
References: <QDISC-BA27.v9.r0.20261108195325@mojatatu.com>
 <QDISC-BA27.v9.r0.20261108195325-3@mojatatu.com>
Date: Thu, 12 Nov 2026 16:18:50 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ld6yoz6t.fsf@toke.dk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> This is a followup of commit 709f34f7c28d ("net/sched: fq: add overflow
> bounds to quantum and initial quantum") as reported by Sashiko.
>
> The issue: fq_codel, cake, codel, pie, fq_pie, dualpi2, RED, pfifo,
> plug and (non-WRED) gred account every enqueued packet's stab-adjusted
> length into the 32-bit sch->qstats.backlog. A crafted tc size table
> inflates qdisc_pkt_len() up to QDISC_PKT_LEN_MAX (1 MiB), and a dodgy
> GSO skb can account even more through qdisc_pkt_len_segs_init(), so a
> few thousand packets wrap the counter mod 2^32.
>
> The AQM then reads a small backlog and makes the wrong drop decision,
> and the dequeue-side subtractions leave it corrupt (for non-WRED gred
> it is the reported stats and the dequeue-side subtractions that go
> wrong instead). In fq_codel a wrapped per-flow backlog can also make
> fq_codel_drop()'s scan pick an empty flow, dereferencing a NULL
> flow->head.
>
> The Fix: drop at enqueue once the stored backlog cannot represent the
> incoming packet's accounted length.
>
> Ordinary packets (qdisc_pkt_len() at most QDISC_PKT_LEN_MAX) are
> covered by a standing ceiling: drop once the backlog is within
> QDISC_MAX_BACKLOG (U32_MAX - QDISC_PKT_LEN_MAX) of the wrap point, the
> largest backlog one more 1 MiB packet cannot wrap, so there is no
> per-enqueue 64-bit add.
>
> A larger wire estimate is checked against the space that actually
> remains (len > U32_MAX - backlog): qdisc_pkt_len_segs_init() adds the
> headers replicated on every output segment, so a supported small-MSS
> BIG TCP aggregate can carry a wire estimate above 1 MiB while its raw
> length stays within GSO_MAX_SIZE, and such traffic must pass on an
> empty queue.
>
> qdisc_pkt_len() itself stays truthful for every input: it is not
> clamped and the initializer keeps succeeding, so BPF
> __sk_buff.wire_len, act_police and the HTB/TBF shapers read the real
> length, and sch_handle_ingress() -- which ignores the initializer's
> return value and reads pkt_segs for packet statistics -- keeps
> complete metadata.
>
> Cover sch_plug, pfifo and non-WRED sch_gred as well. In RED, account the
> packet before handing it to the child, bound the child backlog too, and
> re-derive the aggregate from pre-reservation snapshots on failure.
>
> The guard bounds each qdisc's own enqueue path: a child that segments a
> GSO skb (tbf, netem) can still grow a parent's aggregate through
> qdisc_tree_reduce_backlog()'s unclamped byte delta, which is left to a
> separate change.
>
> CAKE's split-GSO branch is the other exception; 4/4 sums and checks those
> segments before linking any of them.
>
> Conditions to recreate the bug:
>   ip tuntap add tun0 mode tun
>   ip link set tun0 txqueuelen 32 up
>   ip addr add 10.99.0.1/24 dev tun0
>   tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
>       fq_codel flows 1 limit 20000 ecn
>   # hold the tun fd open without reading so the backlog persists, then
>   # send 6000 packets: the counter wraps and the unfixed kernel reports
>   # a wrapped backlog, while the fixed one drops at the ceiling.
>
> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatat=
u.com/
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.=
16203-1-jhs@mojatatu.com
> Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczk=
JjJEWN5sCuWd-ug@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrH=
uDggZu9kPC_m6tQ@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/87a4oottcj.fsf@toke.dk/
> Link: https://lore.kernel.org/netdev/87pkxks68f.fsf@toke.dk/
> Link: https://lore.kernel.org/netdev/179231932946.3135.749747899018638568=
8@kernel.org/
> Link: https://lore.kernel.org/netdev/179269577131.3135.396791539040313801=
5@kernel.org/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
