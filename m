Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F1282F2C;
	Thu, 13 Aug 2026 00:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580135; cv=none; b=of8eBBmcv8NHvvUxphgZiX3Hf2gJqrIuPMtUBZv8GXildFnOaUKxhhGit6KiTJWzvg+x4FxVN06bOSNASORLcm2XGyzraeceLLGAdwkXBae/tCInrPiNYF49Lsx6uwK1FynG4KT0kyFCuxtEH7HkfmPltjm1ZNoRUXO/DsDi8xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580135; c=relaxed/simple;
	bh=5xSx5g/AmiJtEaLhLvS9bRYktPpTWxt1BeowjDl8aps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSOEeul7xPP/bwu69B2pKG/cpH0R53X8AD968BirziNH8U2+bvqM+rd0gKBMV+J2pgFXZmUyGA78/vTFiEC4RKcz/PpYeTQixJ3cUVZjfmwpTR9AKUnPonq0AgQispxD7lHbzDu7YAkx9k8kaUyIIQYI6gp+9pTwJUXYLVBarlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1m2RRbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1m2RRbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1AD1F000E9;
	Thu, 13 Aug 2026 00:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580133;
	bh=FxfKIMihAHNFNLxSFUWc+kmXiLJ0MXVXoAh6NjutnqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G1m2RRbNGFELBYw+ab73bRbh0FvMk/h+0zRJV3ykANEP2oghbFMgBBqV93sUe+zDL
	 UZvNPCBt2a128VBT/hO3WCadaXNAWbt1rovRLeEcOVL0UawKFTlXDdNNHNjJ94ICsU
	 1gaFAvzzXBRcovAuWvERIGlK4O/DSPao4dYjl73WzVYECatz4j/FrHE6/MmXVRHwcN
	 L4gtCDm/Kf65Y+r1trTgi8oFVVm/7AwzRWYMFOTlQMi3ceeVgabdUoq+v89yXFb4EA
	 sxJRiSkuVo7gOBMzMS1xKkvBxtHoq3kjDxV8ao7tIqkux6pFAiusBEUxEhh0R8BiAF
	 xy26olopJ5mRw==
From: Jakub Kicinski <kuba@kernel.org>
To: qingfang.deng@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	pali@kernel.org,
	linux-ppp@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	arnd@arndb.de,
	gnault@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] pppox: drain queued packets on channel handoff
Date: Wed, 12 Aug 2026 17:15:32 -0700
Message-ID: <20260813001532.2234258-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811035314.302878-1-qingfang.deng@linux.dev>
References: <20260811035314.302878-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
pppox: drain queued packets on channel handoff

PPPIOCGCHAN marks an AF_PPPOX socket as bound to generic PPP as a side
effect of returning the channel index. This patch adds a synchronize_net()
after setting PPPOX_BOUND and then drains sk->sk_receive_queue into
ppp_input(), since a bound socket is no longer readable from userspace.

A few questions about the new code below.

> diff --git a/drivers/net/ppp/pppox.c b/drivers/net/ppp/pppox.c
> index 5861a2f6ce3e6..a6f72c813bef9 100644
> --- a/drivers/net/ppp/pppox.c
> +++ b/drivers/net/ppp/pppox.c

[ ... ]

> @@ -85,7 +87,22 @@ int pppox_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  			break;
>  
>  		rc = 0;
> +		/* PPPIOCGCHAN historically marks the userspace handoff to
> +		 * generic PPP; pppd then attaches the returned channel to
> +		 * /dev/ppp.
> +		 */
>  		sk->sk_state |= PPPOX_BOUND;
> +		/* Let lockless receive paths finish queueing against the old
> +		 * state.
> +		 */
> +		synchronize_net();

[Severity: Medium]
Should this skip the grace period when PPPOX_BOUND is already set?

The only gate before it in pppox_ioctl() is:

	rc = -ENOTCONN;
	if (!(sk->sk_state & PPPOX_CONNECTED))
		break;

so every repeated PPPIOCGCHAN on the same connected socket re-sets
PPPOX_BOUND and runs another full RCU grace period. Neither pppox_create()
nor pppox_ioctl() has a capability check, and pppoe_connect() only needs a
session tuple plus an up device, so an ordinary local process can loop the
ioctl and drive grace periods back to back.

synchronize_net() escalates to synchronize_rcu_expedited() whenever
rtnl_is_locked() is true:

net/core/dev.c:synchronize_net() {
	might_sleep();
	if (from_cleanup_net() || rtnl_is_locked())
		synchronize_rcu_expedited();
	else
		synchronize_rcu();
}

which sends IPIs to every CPU. The wait also happens with the socket lock
held, so the socket's receive path is pushed into sk_backlog for the whole
duration.

Would something like

	if (!(sk->sk_state & PPPOX_BOUND)) {
		sk->sk_state |= PPPOX_BOUND;
		synchronize_net();
		...
	}

be enough here? For PPTP sockets pptp_bind() already sets PPPOX_BOUND
before any ioctl, so for that transport the first synchronize_net() has
nothing to wait for either.

[Severity: Medium]
Can this reorder frames for the pppol2tp transport?

PPPOX_BOUND becomes visible before the sleep, but the already-queued frames
are only delivered after it. Meanwhile pppol2tp_recv() reads the state
under rcu_read_lock() only, with no socket lock:

net/l2tp/l2tp_ppp.c:pppol2tp_recv() {
	...
	if (sk->sk_state & PPPOX_BOUND) {
		struct pppox_sock *po;

		po = pppox_sk(sk);
		ppp_input(&po->chan, skb);
	} else {
	...
}

So for the length of the grace period newly arriving frames go straight to
ppp_input() while the older ones still sit in sk->sk_receive_queue, and get
injected only afterwards. PPP receive processing is stateful (VJ header
decompression, CCP/MPPE history and sequence numbers, multilink
reassembly) - would injecting the stale frames after the newer ones
desynchronize that state?

Would draining before publishing PPPOX_BOUND, or draining under the
receive queue lock in the same critical section that sets the state, avoid
the inversion?

> +		/* Drain packets queued before the handoff because a bound
> +		 * socket is no longer readable.
> +		 */
> +		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
> +			skb_orphan(skb);
> +			ppp_input(&po->chan, skb);
> +		}

[Severity: Medium]
Does this feed raw PPTP-GRE frames into ppp_input()?

pppox_ioctl() is also the .ioctl of pptp_ops, and pptp queues frames that
are not yet decapsulated:

drivers/net/ppp/pptp.c:pptp_rcv_core() {
	...
	if (!(sk->sk_state & PPPOX_CONNECTED)) {
		if (sock_queue_rcv_skb(sk, skb))
			goto drop;
		return NET_RX_SUCCESS;
	}
	...
}

That branch runs before the skb_pull(headersize), before the
GRE_IS_SEQ()/payload_len validation, before the seq_recv/ack_recv check,
and before the PPP_ALLSTATIONS/PPP_UI strip that the connected path does
prior to calling ppp_input(). Once drained, skb->data points at the GRE
flags/version word, which ppp_decompress_proto()/PPP_PROTO() then
reinterpret as the PPP protocol field, and ownership is gone so the frame
cannot be recovered - it lands on pch->file.rq and pppd reads it as a bogus
PPP control frame, or it is dropped with rx_length_errors.

The commit message says "a bound socket is no longer readable", but for
pptp PPPOX_BOUND has a different meaning entirely:

drivers/net/ppp/pptp.c:pptp_bind() {
	...
	if (add_chan(po, &sp->sa_addr.pptp))
		error = -EBUSY;
	else
		sk->sk_state |= PPPOX_BOUND;
	...
}

pptp_rcv_core() never consults PPPOX_BOUND, and pptp_ops.recvmsg is
sock_no_recvmsg, so that queue was never readable by userspace to begin
with.

The queueing path does look narrow: lookup_chan() only matches when

	if (opt->dst_addr.sin_addr.s_addr != s_addr)
		sock = NULL;

and dst_addr is zero before pptp_connect(), so a frame with IP source
0.0.0.0 is required; net/ipv4/route.c treats that as martian for ordinary
unicast but still routes it through brd_input() when daddr is
255.255.255.255, and a unicast destination MAC keeps skb->pkt_type ==
PACKET_HOST as pptp_rcv() requires. A same-segment sender that guesses the
bound call-id could therefore park a raw GRE frame on the queue before
connect.

Should the drain be limited to the transports whose queued frames really
are bare PPP frames gated on PPPOX_BOUND (pppoe, pppol2tp), with the
queue simply purged for pptp?

[Severity: Medium]
Does the socket lock actually exclude concurrent readers here?

recvmsg() consumes the same queue without lock_sock():

drivers/net/ppp/pppoe.c:pppoe_recvmsg() {
	...
	if (sk->sk_state & PPPOX_BOUND)
		return -EIO;

	skb = skb_recv_datagram(sk, flags, &error);
	...
}

net/l2tp/l2tp_ppp.c:pppol2tp_recvmsg() is the same shape. Only the receive
queue spinlock is shared with the drain, and the PPPOX_BOUND test is a
check-then-act.

Three things seem to follow:

A reader that passed the PPPOX_BOUND test just before the ioctl set it can
dequeue a packet the drain meant to hand to PPP, so the PPP session loses
it silently.

The drain can also steal the packet a blocking recvmsg() was woken for.
__skb_wait_for_more_packets() watches the queue, socket errors and
shutdown, but not PPPOX_BOUND, so the waiter finds an empty queue and
sleeps again - and since PPPOX_BOUND is now set nothing is ever queued
again, leaving a recvmsg() with no timeout asleep indefinitely. Is that
possible?

With MSG_PEEK, __skb_try_recv_from_queue() bumps skb->users and leaves the
skb linked. The drain's skb_dequeue() then unlinks the skb the reader is
still copying from, skb_orphan() runs sock_rfree() and clears skb->sk, and
ppp_input() mutates the buffer (ppp_decompress_proto() pull/push, then
skb_queue_tail() to pch->file.rq or netif_rx()) while userspace copies from
it. Should the drain check skb_shared()/skb_cloned(), or otherwise exclude
peeking readers, before handing the skb on?

>  		break;
>  	}
>  	default:
-- 
pw-bot: cr
