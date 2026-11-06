Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988770;
	b=gnrze8wgfOxlCx3IzaZdphGf9xGv0x2rv8K3NJofmss9C41GdiPW3VblYH413fBowIcw
	 krfx4/aVAsplQ2ApskCAOvn6V/GYWAFmwBKLqb2qXuVlU8xgAuyiUhClIrmqkKv1Ta8Cd
	 McOr8ftAJa5dlxdAqdtbUV+LKBh3augpq8gB0Hz1A5VIPy9WCOv43KyYxlhSs7EABNCya
	 DGSLPyKFZapcj0/3ZxHV7qlwG+uEQ1puEPAx7U2J5krJBCS30D2h5MyUTyT5k/V977Dc+
	 FpIBRTRYDyuSlojZaLjUn0L2yHmxn3KG+abVMesR18rpz2dIS6NN6nJGASfaR1d3sfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988770;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sgRmgrlCmLHVGsBUVwEOPeglhQGTfDiNl+DwyII1fEo=;
	b=1RHW08BIrT+dhd4Fb1tGBX9I2py3Ty4M2aoZ61Qniu4EKRly1JHTnOu+J3DiFwyhvkHr
	 i+eWEGZ9c8mNcsv6c3JuPnQ6MQcR30xa84jO+YeghiUedqgw3eEJQAjQ8lbvQsCBzZV2J
	 fxP+EnNvjXzE836+a/llvdjTMBBAnpyoEL2bZ0mYhwUFaSqBMtbAwS4qTEwLQV6GgPVX+
	 DKE7AFrd/ZHa0kDsbnDzsN6eGyi7VENzkMhzcOW9YOokCcLdOWX9hX4QuVGEzjLLakvX1
	 adR73/Yhk4irjVLDmvXUf+oam/yYrO9I16kVnq7MyJ72675mPB4Eo9wrU0wHUD0UdZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bllMkXDT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA460606A32F;
	Fri,  6 Nov 2026 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bllMkXDT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607E81F0089F;
	Fri,  6 Nov 2026 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793988769;
	bh=sgRmgrlCmLHVGsBUVwEOPeglhQGTfDiNl+DwyII1fEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bllMkXDT3LSQU2IBLf6ImeuG01urX91GJtFfpeVRO/ttNF/7LbMvFGabZD70cfzZ5
	 2Lk8V+kwemwzVhRZsVZfSvHVJ0iEtpmG4IhHirF0s/1CNqTYDQ7eQeHHKJl783VHh+
	 VHTPPLolxek3RZg6EFoefOeZP3F9eSZqcPG8kKC+13jacgrx4pZlBmyEkAya+kcW7y
	 YvxlMkS3vtXWBVxNm0p4yRQcAyN3f3FrevqHG28bOQpUcZKRB6Uj8qcMFkwPUfmVj/
	 1gJsE3QWgK2nd30Esuhvc7peLQyR8Z/stXxolnRvgyq6x8TE/nlY2qjg/CBtFkejqQ
	 uCJqKFWkvbwqQ==
From: Simon Horman <horms@kernel.org>
To: qingfang.deng@linux.dev
Cc: Simon Horman <horms@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	manizada@pm.me,
	ericwouds@gmail.com,
	nbd@nbd.name,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/2] pppoe: pass bound packets directly to generic PPP
Date: Fri,  6 Nov 2026 18:12:29 +0000
Message-ID: <20261106181228.1263020-2-horms@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103111711.28202-1-qingfang.deng@linux.dev>
References: <20261103111711.28202-1-qingfang.deng@linux.dev>
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

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103111711.28202-1-qingfang.deng@linux.dev?part=1
---
pppoe: pass bound packets directly to generic PPP

This changes pppoe_rcv() to hand frames for PPPOX_BOUND sockets straight
to ppp_input(), instead of going through __sk_receive_skb(). It relies on
commit ec4215683e47 deferring the channel free to an RCU grace period. It
also clears skb->dev, matching what __sk_receive_skb() used to do.

> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
> index 67c28ac763efd..5d5187e4976b3 100644
> --- a/drivers/net/ppp/pppoe.c
> +++ b/drivers/net/ppp/pppoe.c
> @@ -415,6 +415,12 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (!po)
>  		goto drop;
>  
> +	skb->dev = NULL;

[Severity: Low]
Should the comment in ppp_bridge_gso_segment() be updated as well? It
still says __sk_receive_skb() is what clears skb->dev:

drivers/net/ppp/ppp_generic.c:ppp_bridge_gso_segment() {
	/* skb->dev is NULL here (cleared by __sk_receive_skb() for PPPoE),
	 * and some GSO handlers (tunnels, IPv6 UFO) dereference it.
	 */
	...
}

Bound PPPoE frames are the ones that reach the bridge path, and they no
longer go through __sk_receive_skb(). The invariant now holds only
because of this assignment in pppoe_rcv(). Nothing in pppoe.c says that
the GSO path depends on it.

The follow-up patch "pppoe: queue unbound packets directly" does not
touch ppp_generic.c, so the comment stays stale after that patch too.

> +
> +	if (likely(po->sk.sk_state & PPPOX_BOUND)) {
> +		ppp_input(&po->chan, skb);
> +		return NET_RX_SUCCESS;
> +	}
>  	return __sk_receive_skb(&po->sk, skb, 0, 1, false);

[Severity: Medium]
The commit message says:

  "The direct bound receive path also skips the socket filter check in
  __sk_receive_skb()."

Does this path skip more than the socket filter? __sk_receive_skb()
calls sk_filter_trim_cap(), and that function runs the LSM hook before
the filter:

net/core/filter.c:sk_filter_trim_cap() {
	...
	err = security_sock_rcv_skb(sk, skb);
	if (err)
		return SKB_DROP_REASON_SECURITY_HOOK;
	...
}

apparmor_socket_sock_rcv_skb() mediates sockets of any family when
skb->secmark is set. BPF-LSM programs on socket_sock_rcv_skb also apply
to AF_PPPOX. After this change, neither runs for bound session frames
from the remote peer. A configured policy would therefore fail open.

Some other checks are skipped as well:

  - A filter attached with SO_ATTACH_FILTER or SO_ATTACH_BPF, even one
    locked with SO_LOCK_FILTER, is still accepted by setsockopt(), but it
    never runs on bound frames and never trims them.

  - The sk_rcvqueues_full() check and the sk_drops / drop reason
    accounting in __sk_receive_skb() no longer happen.

pppol2tp_recv() already calls ppp_input() directly for bound sockets, so
there is precedent. Could the commit message still describe the LSM
bypass and the other skipped checks?

This stays true after the follow-up patch "pppoe: queue unbound packets
directly". There, only the unbound path still reaches sk_filter, via
sock_queue_rcv_skb().

[Severity: Low]
Does include/linux/ppp_channel.h need an update along with this? Its SMP
locking notes say:

 * The channel code must ensure that when it calls ppp_unregister_channel,
 * nothing is executing in any of the procedures above, for that
 * channel.

PPPoE followed that rule before this patch. ppp_input() ran under
bh_lock_sock(), and every ppp_unregister_channel() caller (through
pppox_unbind_sock()) holds lock_sock().

Now pppoe_rcv() calls ppp_input() from softirq without the socket lock.
So ppp_input() and ppp_unregister_channel() can run at the same time on
the same channel.

That looks safe in practice:

  - struct channel is freed through call_rcu().
  - pch->ppp is cleared and then followed by synchronize_net().
  - pch->bridge is cleared and then followed by synchronize_rcu().

Even so, the documented contract no longer matches the rule PPPoE and
pppol2tp now rely on.

[Severity: Low]
Is chan->ppp now accessed locklessly without any annotation? ppp_input()
does a plain load:

drivers/net/ppp/ppp_generic.c:ppp_input() {
	struct channel *pch = chan->ppp;
	...
}

Meanwhile, ppp_unregister_channel() can do a plain store at the same
time, protected only by lock_sock():

pppox_unbind_sock()
  ppp_unregister_channel()
    chan->ppp = NULL;

For PPPoE, the socket BH lock used to serialize these two. Without it,
this looks like a data race that KCSAN would report.

There is a second ordering gap. ppp_register_net_channel() publishes
chan->ppp before it initializes pch:

	chan->ppp = pch;
	init_ppp_file(&pch->file, CHANNEL);

This store has no release ordering, and the sk_state test in pppoe_rcv()
gives no acquire ordering. In practice the gap between connect() and
PPPIOCGCHAN hides this.

Would READ_ONCE()/WRITE_ONCE() on chan->ppp be appropriate here? Should
chan->ppp also be published only after initialization, with release
semantics?

The sk_state access is volatile, so that side is not a KCSAN concern.
The chan->ppp race is still there after "pppoe: queue unbound packets
directly".

[Severity: Low]
Can frames reach generic PPP out of order during the PPPIOCGCHAN
handoff? pppox_ioctl() does:

		sk->sk_state |= PPPOX_BOUND;
		...
		synchronize_net();
		...
		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
			skb_orphan(skb);
			ppp_input(&po->chan, skb);

A frame that arrives after PPPOX_BOUND is set now takes the direct path.
It reaches ppp_input() during synchronize_net(), ahead of older frames
that are still in sk_receive_queue.

At this commit, frames that go to the backlog while the ioctl holds
lock_sock() arrive even later, from release_sock() -> pppoe_rcv_core().

Before the patch, the socket lock kept these frames in wire order. The
follow-up "pppoe: queue unbound packets directly" removes the backlog,
but the reordering against sk_receive_queue remains. pppol2tp already
behaves this way. The frames in this window are mostly LCP and other
control frames for pppd.

[Severity: High]
This isn't a bug introduced by this patch, but ppp_input() appears to
call ppp_receive_error() without holding ppp_recv_lock():

drivers/net/ppp/ppp_generic.c:ppp_input() {
	...
	rcu_read_lock_bh();
	ppp = rcu_dereference_bh(pch->ppp);
	if (!ppp_decompress_proto(skb)) {
		kfree_skb(skb);
		if (ppp) {
			DEV_STATS_INC(netdev_from_priv(ppp), rx_length_errors);
			ppp_receive_error(ppp);
		}
		goto done;
	}
	...
}

ppp_input_error() makes the same call inside ppp_recv_lock() /
ppp_recv_unlock(). ppp_receive_error() then calls slhc_toss(ppp->vj),
which does a non-atomic comp->flags |= SLF_TOSS.

A peer can reach this branch with a PPPoE session frame of length 0 or
1. pskb_trim_rcsum() trims the frame, and pskb_may_pull(skb, 2) then
fails in ppp_decompress_proto().

Can this race with PPPIOCSMAXCID in ppp_ioctl()?

		ppp_lock(ppp);
		if (ppp->vj)
			slhc_free(ppp->vj);
		ppp->vj = vj;
		ppp_unlock(ppp);

Without rlock, ppp_receive_error() could load the old ppp->vj and write
to the slcompress after it has been freed.

This patch adds one effect in the common single-channel PPPoE case. The
socket BH lock no longer serializes ppp_input() calls for one channel.
The lockless slhc_toss() can therefore run while another CPU is in
slhc_uncompress() / slhc_remember() under rlock, and a comp->flags
update can be lost.

Would taking ppp_recv_lock() around ppp_receive_error() in ppp_input(),
as ppp_input_error() already does, fix both cases?
