Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB2B495AED
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791455736; cv=none; b=fe+T6N4rJhUuA3xeAuf2nJymjlPMKpQjE1iYt13ztmNgRSJu57n3O6oCGu4BaEddA5XjF2SiCCAWJiUh2Y7IxvyXeQ84EVpWmQyOA3EUT+PleN4ppWCY45UTWXaQhbqgI6jN6NjTyA1aNElE+fTx1ezwHwExM5O44Vmcls/tUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791455736; c=relaxed/simple;
	bh=AnsBZ0Quk8k4z6+2J2nCg16gmmMRexQPeED0TV++fkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lmk6Eq+07/j6EZIDgyfHFp/u4/HmEvRwuQD3ZtpSDk1cNUuoq9JhSljj99/RJVb2XjeCcbnFYdYWdj4nKWz+z5/66D7t5gZwUb978b+Ahx42pzXmCcD76hFozWeW37rfVoGyLw34PKQFiEDok/OeUl3NkliaLSicl4ONzXWJahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, cake@lists.bufferbloat.net, Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next 3/4] net/sched/sch_cake: widen buffer_used to u64
In-Reply-To: <QDISC-5RTM.v1.20261007130704-4@mojatatu.com>
References: <QDISC-5RTM.v1.20261007130704@mojatatu.com>
 <QDISC-5RTM.v1.20261007130704-4@mojatatu.com>
Date: Thu, 08 Oct 2026 12:24:22 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y0c8sd61.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> This is a follow-up to commit 4c660ee8c809 ("net: sched: fix 32-bit
> backlog wrap in gred, bfifo and plug enqueue"), which promoted the
> backlog + length admission sums in gred, bfifo and plug to u64.  CAKE's
> own memory accounting has the same 32-bit wrap.
>
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
> Widen buffer_used and buffer_max_used to u64, the same shape as the
> gred/bfifo/plug fix.  buffer_limit stays u32; the comparison promotes it
> to u64, so the bounded queue stops at the configured limit below 2^32 and
> the counter can no longer wrap.  buffer_used is subtracted on dequeue and
> drop, so the widened type flows through unchanged.
>
> The ACK-filter replacement applied the net delta as one expression,
> q->buffer_used +=3D skb->truesize - ack->truesize.  Both operands are
> unsigned int, so the subtraction is evaluated at u32 and a larger removed
> ACK wraps the delta; the old u32 accumulator folded that back to the
> correct net value, but the widened u64 accumulator would persist it as a
> roughly 4 GiB over-count.  Apply the replacement as two exact operations
> on the widened counter instead; the queue already accounts ack->truesize,
> so the subtraction cannot underflow.
>
> Conditions to recreate the bug: CAP_NET_ADMIN (root or a user namespace,
> the qdisc attach is gated by netlink_net_capable(CAP_NET_ADMIN)).
>
>   # hold a tun device's tx ring so the root qdisc parks packets
>   ip tuntap add tun0 mode tun
>   ip link set tun0 txqueuelen 32 up
>   ip addr add 10.99.0.1/24 dev tun0
>   tc qdisc add dev tun0 root handle 1: cake memlimit 4294967295
>
>   # drive >4 GiB of resident truesize through the qdisc (e.g. several UDP
>   # sockets with SO_SNDBUFFORCE). On the unfixed kernel buffer_used wraps,
>   # the drop loop is bypassed and the guest OOMs; with the fix the counter
>   # passes the limit without wrapping and drops the excess.
>
>   # the ACK-filter over-count is reached with ack-filter enabled and a
>   # queued pure ACK whose truesize is larger than the replacement ACK:
>   tc qdisc add dev tun0 root handle 1: cake ack-filter
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
