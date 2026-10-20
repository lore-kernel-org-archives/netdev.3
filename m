Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500939;
	b=Wan4eLQ0nxj75XLrzTUbivjPp0F8luLDxGB11nIDpOs4FC0+PMuQ9/8SK+H+birzxHO3
	 krXWjjX6vvPsanle54/QYrfGzK/7793uVql+KjKlecWvIHZwjAPh8m+lfuEeE9Ni9qFKO
	 cgJ6XOyUgsOjqtmnEvJ++WTY3kYmu4zWUfVuZJrZg3JgLLQiKS1NGImY7dRZ6rrQKba8a
	 WVBfOW44kE8iXj2lEKcfm1L6r4Hdf3t4ZaD0uUokx8JIoPbdPwkqp7q9U1P7gE03LrjXY
	 HOxMk5RewA+1/v7fGHtpYtPdlQwE9jMlymdERgEHIJ2UPC6kJsn+Wj6PoEHIkossT9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500939;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZYAc1wx3Vua5Vp0s1jMJClpzyO/jsYX8bKYKZg99y3g=;
	b=H0Mqrwpk2vFialZ/+e75zuTo8TTpXvoXOXxUh2B/2shcQK5g2QAtZm2ZWFzibNZ05rhz
	 EMlcx/j1kLBuVkCxl5iBmDdY5PjahoEcvpITYuZ7YxZfOKrP5hzVHqWcy7rfDupeh0B29
	 994KQ/Kmes3BUXYtbB6sXqLrbr77XHszdpMOkxXeFNa1x3RBQLmwothpTl1Iai3yBomHP
	 L61SBnXsAo/6aOUrS56DVxCBNry/30Ad3GQjhw6mZ72E4qtCEx/7E5+d3WV7SJ5LvvC3Y
	 KSohHEZx2j4JSuhftJR1nLOgTU968H81ZzeB7yKfQEsucyyBsc4A+XSxT0HQMzgUhDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB1606A31A
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 12:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AFB1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 cake@lists.bufferbloat.net, Victor Nogueira <victor@mojatatu.com>, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v3 3/4] net/sched/sch_cake: widen buffer_used
 to u64
In-Reply-To: <QDISC-5RTM.v3.r0.20261020053711-3@mojatatu.com>
References: <QDISC-5RTM.v3.r0.20261020053711@mojatatu.com>
 <QDISC-5RTM.v3.r0.20261020053711-1@mojatatu.com>
 <QDISC-5RTM.v3.r0.20261020053711-2@mojatatu.com>
 <QDISC-5RTM.v3.r0.20261020053711-3@mojatatu.com>
Date: Tue, 20 Oct 2026 14:55:36 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87tsmgtttj.fsf@toke.dk>
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

> This is a follow-up to commit 4c660ee8c809 ("net: sched: fix 32-bit
> backlog wrap in gred, bfifo and plug enqueue"), which promoted the
> backlog + length admission sums in gred, bfifo and plug to u64.  CAKE's
> own memory accounting has the same 32-bit wrap.
>
> The issue:
> cake_sched_data.buffer_used accumulates skb->truesize and is compared
> against memory_limit:
>
> 	q->buffer_used +=3D skb->truesize;
> 	if (q->buffer_used <=3D q->buffer_limit)
> 		return NET_XMIT_SUCCESS;
> 	while (q->buffer_used > q->buffer_limit)
> 		drop...
>
> buffer_used is u32, so once the resident truesize passes 2^32 it wraps to
> a small value, the <=3D test passes and the drop loop is skipped even
> though far more than the configured limit is queued.  memory_limit is a
> u32 attribute (TCA_CAKE_MEMORY), so buffer_limit can be as large as
> U32_MAX and never caps buffer_used below the wrap point; with a large
> memory_limit the queue then grows until the machine is out of memory.
>
> The fix:
> Widen buffer_used and buffer_max_used to u64, the same shape as the
> gred/bfifo/plug fix.  buffer_limit stays u32; the comparison promotes it
> to u64, so the bounded queue stops at the configured limit below 2^32 and
> the counter can no longer wrap.  buffer_used is subtracted on dequeue and
> drop, so the widened type flows through unchanged.  The ACK-filter
> replacement applied the net delta as one expression,
> q->buffer_used +=3D skb->truesize - ack->truesize.  Both operands are
> unsigned int, so the subtraction is evaluated at u32 and a larger removed
> ACK wraps the delta; the old u32 accumulator folded that back to the
> correct net value, but the widened u64 accumulator would persist it as a
> roughly 4 GiB over-count.  Apply the replacement as two exact operations
> on the widened counter instead; the queue already accounts ack->truesize,
> so the subtraction cannot underflow.
>
> Widening the counters alone is incomplete because cake_dump_stats() still
> exports buffer_max_used through PUT_STAT_U32(MEMORY_USED, ...), and
> tc.yaml declares memory-used as u32.  buffer_max_used only ever rises, so
> once the widened counter passes 2^32 the export reports peak - 2^32 for
> the rest of the qdisc's life.  Clamp the exported value to U32_MAX; the
> counter itself is unaffected.
>
> The dump path runs without the qdisc lock: tc_fill_qdisc() passes NULL to
> gnet_stats_start_copy_compat(), so the reader races with the enqueue-side
> update.  READ_ONCE() is not an atomic 64-bit load on 32-bit CPUs, so a
> reader can observe a torn high-water mark and report a bogus MEMORY_USED.
> Publish the counter as u64_stats_t under the qdisc lock, which the enqueue
> path already holds, and take a seqcount-protected snapshot in the dump.
> The counter stays u64; only the exported value is bounded.
>
> Conditions to recreate the bug:
> CAP_NET_ADMIN (root or a user namespace, the qdisc attach is gated by
> netlink_net_capable(CAP_NET_ADMIN)).
>
> A TUN device is needed so the root qdisc can park packets instead of
> dropping them.  Open /dev/net/tun, request TUNSETIFF with
> IFF_TUN | IFF_NO_PI | IFF_BACKPRESSURE and keep the fd open without
> reading it (run it in the background and stop it at teardown): with
> IFF_BACKPRESSURE the full tx ring calls netif_tx_stop_queue() rather than
> dropping, so the queue behind the qdisc can grow past 4 GiB of resident
> truesize.  A plain 'ip tuntap add' attaches no fd and does not request
> IFF_BACKPRESSURE, so it cannot park the queue this way.
>
>   ip link set tun0 txqueuelen 32 up
>   ip addr add 10.99.0.1/24 dev tun0
>   tc qdisc add dev tun0 root handle 1: cake memlimit 4294967295
>
>   # Then push more than 4 GiB of resident truesize through the qdisc: six
>   # UDP senders using large SO_SNDBUFFORCE buffers send 1400-byte
>   # datagrams (the reported OOM witness used 6 workers for 100 s on a
>   # 12 GiB guest).  On the unfixed kernel buffer_used wraps, the admission
>   # test passes, the drop loop is bypassed and the guest runs out of
>   # memory; with the fix the counter passes the limit without wrapping and
>   # the excess is dropped.
>
>   # The ACK-filter over-count is a separate corner: it needs ack-filter
>   # enabled and a queued pure ACK whose truesize is larger than the
>   # replacement ACK.  Use a fresh interface (or 'tc qdisc change') rather
>   # than a second root 'tc qdisc add' on an interface that already has a
>   # qdisc:
>   tc qdisc change dev tun0 root cake ack-filter
>
> CONFIG_NET_SCH_CAKE=3Dy and CONFIG_TUN=3Dy are required, and the
> memory-residency recipe needs a root-run sender envelope with enough
> guest RAM to hold the queued data.
>
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260818095927.15901-1-jhs@mojatat=
u.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818095927.=
15901-1-jhs@mojatatu.com
> Link: https://lore.kernel.org/netdev/20260818095927.15901-1-jhs@mojatatu.=
com/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
