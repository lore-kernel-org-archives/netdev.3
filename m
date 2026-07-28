Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5442BEB9
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241565; cv=none; b=obhK/qcv5vMmBcd5X0f+JfN/7maWTOomMfcnlSNv9ZOEJaBJFK3g6VwGjdlquRBATazIfvmHT/Ij9JuVrpailjuTHUoHeSRHsaUaaqLuVz1U1KbaYKPfFnmvv1EGulTE3xAv28YWZb/ooAAsvXLsHgt1D1helZz1/NhPW2iQDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241565; c=relaxed/simple;
	bh=1HyV25WAh144h2RcA8Q/ogDHhrNzrEB972OiZUhndPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cP9pAvMqpeOldprea/cvWMM71zmuOnDZovb3qEDbsyDT/koksd1XbjVPyPLCc7ZFoFOWiVBnovcl28dVOl8szGRUbmGJPlNY7dh38iC2fg0SIfbWZRw1FGADMcoPLeeRNMNi3bo1+WU0XVB7n+6ZmYxHsd2bMgS6OjOt2CpFaa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2/oeJh4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2/oeJh4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216E01F000E9;
	Tue, 28 Jul 2026 12:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241563;
	bh=fZN/+KHGC66DLLnPGV5lsj9Fqr2bAVnATdrZpKLj68U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S2/oeJh441qRUfd41s4Hxd4/+Dg5ItYop4SgSYz9LklXb7/IdEiYUcB/NY7dPhxpC
	 Brgoapan1eOx/NMZJtG1LovN8i4tfgF2N06nrxi1kDBNi0xSpxQLyVlpSzFBRSW+B6
	 pPd0Aq0JuXB62aY6MKTABlY75PW0kE4ml+d77HQfs9A3I91hXriaFzgXnO/Q3nHkiS
	 PyzuWbDBhW/ncc4zb3bd++g2VYFVDLTkeKxaFEE28IAviJWXsxX3JzXZUwSLcndHXn
	 MPm11nB3scxoUSpME6DGLirl0fqSYHm8dLNcxW2hQWpLZ5fPtvzp7Jav2A+Sq8Q/Pb
	 QblL1ve4qXd2g==
From: Simon Horman <horms@kernel.org>
To: enjou1224z@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	dhowells@redhat.com,
	marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: Re: [PATCH net 1/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Tue, 28 Jul 2026 13:24:49 +0100
Message-ID: <20260728122451.899477-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <b640f1b3e27afeb9f397b2bab9ce23f4f2f864a7.1784742007.git.zihanx@nebusec.ai>
References: <b640f1b3e27afeb9f397b2bab9ce23f4f2f864a7.1784742007.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/b640f1b3e27afeb9f397b2bab9ce23f4f2f864a7.1784742007.git.zihanx@nebusec.ai?part=1
---
rxrpc: fix encap_rcv skb accounting exhaustion

This patch adds UDP rcvbuf accounting to rxrpc_encap_rcv() so that an
AF_RXRPC service such as the AFS callback listener cannot be flooded
until local queue memory grows unbounded. It also switches
rxrpc_destroy_local() to clear sk_user_data via RCU and defers
sock_release() until after the local rx queues are purged.

> diff --git a/net/rxrpc/io_thread.c b/net/rxrpc/io_thread.c
> index dc5184a2fa9d..85411a2d8428 100644
> --- a/net/rxrpc/io_thread.c
> +++ b/net/rxrpc/io_thread.c
> @@ -41,8 +41,6 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
>  	if (skb->tstamp == 0)
>  		skb->tstamp = ktime_get_real();
>
> -	skb->mark = RXRPC_SKB_MARK_PACKET;
> -	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
>  	rx_queue = &local->rx_queue;
>  #ifdef CONFIG_AF_RXRPC_INJECT_RX_DELAY
>  	if (rxrpc_inject_rx_delay ||
> @@ -52,6 +50,19 @@ int rxrpc_encap_rcv(struct sock *udp_sk, struct sk_buff *skb)
>  	}
>  #endif
>
> +	if (atomic_read(&udp_sk->sk_rmem_alloc) >= READ_ONCE(udp_sk->sk_rcvbuf) ||
> +	    !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
> +		atomic_inc(&udp_sk->sk_drops);
> +		kfree_skb(skb);

[Low]
Should the drop reason here be SKB_DROP_REASON_SOCKET_RCVBUFF rather
than the default SKB_DROP_REASON_NOT_SPECIFIED that kfree_skb() maps
to?

The regular UDP receive path in __udp_enqueue_schedule_skb() uses
kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_RCVBUFF) so that
drop_monitor / drop-reason tracepoints classify rcvbuf-full drops. As
written, rxrpc's rcvbuf-full drops will show up as unspecified.

> +		return 0;
> +	}
> +
> +	skb->dev = NULL;
> +	skb_set_owner_r(skb, udp_sk);

[Critical]
Once skb_set_owner_r(skb, udp_sk) installs sock_rfree() as the
destructor, skb->sk / skb->destructor are bound to udp_sk for the
lifetime of the skb.

The io_thread then hands these skbs off to further queues without
re-orphaning, for example:

net/rxrpc/ar-internal.h:rxrpc_queue_rx_call_packet()
    __skb_queue_tail(&call->rx_queue, skb);

net/rxrpc/conn_event.c:rxrpc_post_packet_to_conn()
    skb_queue_tail(&conn->rx_queue, skb);

net/rxrpc/oob.c:rxrpc_notify_socket_oob()
    skb_queue_tail(&rx->recvmsg_oobq, skb);

None of these paths call skb_orphan() or re-run skb_set_owner_r() with
a different sk, so skb->sk stays pointing at udp_sk and the destructor
stays sock_rfree.

rxrpc_destroy_local() only purges local->rx_queue and
local->rx_delay_queue before sock_release(socket):

    rxrpc_purge_queue(&local->rx_delay_queue);
    rxrpc_purge_queue(&local->rx_queue);

    if (socket)
        sock_release(socket);

Meanwhile rxrpc_put_connection() can defer rxrpc_clean_up_connection()
to a workqueue when called from softirq or when the processor work /
timer is busy, and rxrpc_destroy_local() does not flush_work() /
cancel_work_sync() those destructor workers.

If the deferred cleanup runs after sock_release() has freed udp_sk,
rxrpc_clean_up_connection() -> rxrpc_purge_queue(&conn->rx_queue) will
invoke sock_rfree() on each skb, which does atomic_sub(len,
&sk->sk_rmem_alloc) and sk_mem_uncharge() on freed memory.

Can this produce a remotely triggerable use-after-free on the UDP
sock, since any peer can drive rxrpc_post_packet_to_conn() or
rxrpc_queue_rx_call_packet()?

[High]
Is any lock held on udp_sk when sk_rmem_schedule() and
skb_set_owner_r() run here?

Both paths do a non-atomic RMW on sk_forward_alloc via
sk_forward_alloc_add(), which is only WRITE_ONCE(sk->sk_forward_alloc,
sk->sk_forward_alloc + val).

The comment above rxrpc_encap_rcv() states the socket is not held
locked by the caller and this runs under RCU only. The regular UDP
path in __udp_enqueue_schedule_skb() takes spin_lock(&list->lock) on
sk_receive_queue before udp_rmem_schedule() and sk_forward_alloc_add()
precisely to serialise this counter.

With concurrent softirqs on multiple CPUs delivering to the same UDP
socket, and sock_rfree() destructors firing asynchronously from the
io_thread purge and deferred conn/call cleanup, can updates to
sk_forward_alloc be lost, allowing the rcvbuf ceiling this patch is
meant to enforce to drift?

[Medium]
Is the sequence

    if (atomic_read(&udp_sk->sk_rmem_alloc) >= READ_ONCE(udp_sk->sk_rcvbuf) ||
        !sk_rmem_schedule(udp_sk, skb, skb->truesize)) {
        ...
    }

    skb_set_owner_r(skb, udp_sk);

racy across CPUs?

N concurrent softirqs can each observe rmem_alloc < rcvbuf and then
each add skb->truesize in skb_set_owner_r() -> atomic_add(...,
&sk->sk_rmem_alloc), so the effective cap becomes rcvbuf + O(NCPU *
truesize) rather than a strict bound. The commit message states the
patch will "drop packets once the socket rcvbuf limit is reached" —
should that be qualified given this overshoot?

> +	skb_dst_force(skb);
> +
> +	skb->mark = RXRPC_SKB_MARK_PACKET;
> +	rxrpc_new_skb(skb, rxrpc_skb_new_encap_rcv);
>  	skb_queue_tail(rx_queue, skb);
>  	wake_up_process(io_thread);
>  	return 0;

[Low]
rxrpc's UDP endpoint is opened by kernel code via udp_sock_create() in
rxrpc_open_socket() and is not exposed to userspace, so there is no
SO_RCVBUF path to tune sk_rcvbuf per endpoint. After this change,
net.core.rmem_default (typically ~200 KB) becomes the effective drop
threshold for all AF_RXRPC / AFS traffic on the host, with no
per-endpoint or rxrpc-specific knob to raise it.

Was this tradeoff considered, and should the commit message note it?
On busy AFS deployments this could drop legitimate traffic that is
only tunable via a global sysctl affecting every socket on the system.
