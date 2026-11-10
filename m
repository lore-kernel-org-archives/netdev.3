Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274439;
	b=VSZfEXw9DIbgEN9Gk81jw9jK+j8WyV0C58HOkHYax6RXuvuKa37PSK4r61uHdmUssWVa
	 nJCE63+lwj/RUTXg2qdoicd6VXVSiYHZUskgk3MczAc48af57prJUI9jtns7uohSwlD7W
	 jHN4HAvr5SVEr6+M+rpQQZYsIJG6p1/Gn3LLsR44KoV6jYoySelkUdwsYPufsAtnobu1s
	 mdantNr/isAQU6RzLvSZ9A9z4pxNyr6YoA8RS+0e8wAPOhcU4j+8Ku44DeFiV37L/z+3y
	 jqWxHHXlKBTid5ccuB39eeMVcCn/akYg0Xdj+T0UaZtEomREbf5Axz34vGu18fOyTMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274439;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IPEvodokfAyud/YruPH/rS1l37Gq1EzJHqG0mFFK13M=;
	b=Ir3Gdlku3o0kB/kA4iRplVAV2XgLsM15L2Pw4neb3IyRbGIWx0mhQT2UuUeWQRQ3ggBp
	 yjx4RW8vSUObc9rZeOBdVf1ndm7JboMbYJv4GJeuf8FPv97tOL3ZEH/G8FGNaF6kiOju5
	 oS1TrqAMt0WP6bka/nLljSuytLQjj5cLHCibLjEa/931kmPBRtov5aSgpyF5TsEUWy1sV
	 BCM4EStBJ49imAl4qcPXdXKqrKKN352kekeekPd9V+kX6n8adgmKPX4xBR15Xm5Ito4nf
	 aosQw9iqxL9CaKCZzFEcjIHCH95c4O7xWASYXJwAkvSQFy4uE6nvlQLJp4xFdvKwBOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmxX5Xwk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13639606A31C;
	Tue, 10 Nov 2026 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmxX5Xwk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B6C1F008A1;
	Tue, 10 Nov 2026 01:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274438;
	bh=IPEvodokfAyud/YruPH/rS1l37Gq1EzJHqG0mFFK13M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NmxX5Xwke0Mhw1t5LuMxSOzjyYgn/2s0bpNYTWX2XPaD3XN1Xpq0BOjhodXrNhXtC
	 XVx/FOJ/xPomOcGdTbZNWx04fQ10EPuGh867ab2fvEzAQN/dahfI+k7TMpMLp1Y9CQ
	 yqs58/2jl3brCaCbg/bm2HObMZinkBCOUFZSviS8V9vM66qX2wGpbivogAX4Kj4G/x
	 DutwpeeiiFArbhX60Y2uT+subW8O+2iP/m1v43QuUb2mJcJZA3CDyHCnhuNxwdcbgZ
	 dPSIpxEI6hEWTpFtmBtWbBmYyObs18Dr3KD2W6usmqa8WBjC2tLus3bH9OdpwXk13M
	 9o31emCx4RhzA==
Subject: Re: [PATCH net] rxrpc: Fix rxrpc_sock UAF caused by missing poke in
 rxrpc_abort_eproto()
From: netdev-bot+sashiko@kernel.org
To: juanagusnicco@gmail.com
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, dhowells@redhat.com,
 marc.dionne@auristor.com, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, davem@davemloft.net, horms@kernel.org,
 jaltman@auristor.com, linux-kernel@vger.kernel.org
Date: Tue, 10 Nov 2026 01:33:57 +0000
Message-ID: <179427443746.994134.16851409559930782509@kernel.org>
In-Reply-To: <20261106011550.59902-1-juanagusnicco@gmail.com>
References: <20261106011550.59902-1-juanagusnicco@gmail.com>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The patch only makes the stranded-call UAF a race.
- [High] rxrpc: race on call->_state in rxrpc_abort_eproto() outside I/O
  thread

--

rxrpc: Fix rxrpc_sock UAF caused by missing poke in rxrpc_abort_eproto()

This commit adds a call to rxrpc_poke_call() in rxrpc_abort_eproto(). A
call aborted with EPROTO from recvmsg() or rxrpc_kernel_recv_data() then
gets queued for the I/O thread, which disconnects it from its connection
channel. Without the poke the call stays in conn->channels[] and its
call->socket pointer dangles after the socket is freed.

> diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
> index 865f05fe37ab9..31528b5e34cbe 100644
> --- a/net/rxrpc/ar-internal.h
> +++ b/net/rxrpc/ar-internal.h
> @@ -1455,6 +1455,7 @@ static inline int rxrpc_abort_eproto(struct rxrpc_call *call,
>  	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
>  
>  	rxrpc_abort_call(call, sp->hdr.seq, abort_code, -EPROTO, why);
> +	rxrpc_poke_call(call, rxrpc_call_poke_abort);

[Severity: High]
Is it safe for rxrpc_abort_eproto() to complete the call itself here?
The alternative is to ask the I/O thread to do it.

Since commit a343b174b4bd ("rxrpc: Only set/transmit aborts in the I/O
thread") and commit 96b4059f43ce ("rxrpc: Remove call->state_lock"),
rxrpc_set_call_completion() takes no lock when it writes:

  call->_state
  call->completion
  call->abort_code
  call->error

This relies on only the I/O thread changing call state. Other contexts
are meant to use rxrpc_propose_abort(), which sets call->send_abort and
pokes the call.

rxrpc_abort_eproto() runs in process context and holds only
call->user_mutex, which the I/O thread never takes:

rxrpc_recvmsg() / rxrpc_kernel_recv_data()
  rxrpc_recvmsg_data()
    rxrpc_verify_data()
      call->security->verify_packet()
        rxrpc_abort_eproto()
          rxrpc_abort_call()
            rxrpc_set_call_completion()  /* _state = COMPLETE */

For a multi-packet service request, the I/O thread can be handling the
DATA packet with RXRPC_LAST_PACKET at the same moment:

rxrpc_input_queue_data()
  rxrpc_end_rx_phase()
    /* reads _state == RXRPC_CALL_SERVER_RECV_REQUEST */
    rxrpc_set_call_state(call, RXRPC_CALL_SERVER_ACK_REQUEST);

Suppose rxrpc_end_rx_phase() reads the old state before the abort and
writes after it. RXRPC_CALL_COMPLETE is then overwritten with
RXRPC_CALL_SERVER_ACK_REQUEST. call->completion and call->error still
say the call failed.

The poke added here then runs rxrpc_input_call_event(). call->send_abort
is 0 and __rxrpc_call_is_complete() is false, so the call never reaches
rxrpc_disconnect_call().

Userspace may have seen rxrpc_call_has_failed() before the overwrite and
released the call. In that case the call is gone from rx->sock_calls, so
rxrpc_release_calls_on_socket() won't abort it at close either.

Doesn't that leave the call stranded in conn->channels[] with a dangling
call->socket? That is the situation this patch is meant to fix. The
direct rxrpc_abort_call() predates this patch, but the poke relies on
the state staying RXRPC_CALL_COMPLETE.

There is a second problem even without the race. The poke wakes
rxrpc_input_call_event() with send_abort == 0 and often an empty
call->rx_queue. __rxrpc_call_is_complete() is only checked inside the
if (skb) block. So the timer expiry, delayed ACK/ping and retransmission
code all run on the aborted call before it reaches the out: label that
disconnects it. Is that intended?

Would it be better for rxrpc_abort_eproto() to use
rxrpc_propose_abort(call, abort_code, -EPROTO, why)? The state change
would then happen in the I/O thread, as for other aborts made outside
it. That changes when recvmsg() sees the call as complete, though. What
should the caller observe after the -EPROTO return?

[Severity: Critical]
Does this close the use-after-free in rxrpc_post_challenge(), or does it
turn it into a race?

rxrpc_poke_call() only adds the call to local->call_attend_q. The call
leaves conn->channels[] only later, when the I/O thread runs
rxrpc_input_call_event()->rxrpc_disconnect_call(). Nothing in the close
path waits for that to happen:

close()
  rxrpc_release_sock()
    rxrpc_release_calls_on_socket(rx)
      rxrpc_release_call()   /* sets RXRPC_CALL_RELEASED, call->socket kept */
    flush_workqueue(rxrpc_workqueue)   /* not the I/O thread */
    rxrpc_unuse_local()   /* I/O thread keeps running if another
                             client socket shares this rxrpc_local */
    sock_put(sk)   /* SOCK_RCU_FREE, freed after a grace period */

call->socket is set with rcu_assign_pointer() and never set back to
NULL, and the call holds no reference on the socket.

rxrpc_io_thread() also handles the whole rx batch before it splices and
processes local->call_attend_q. No RCU read section covers the batch, so
a grace period can end partway through it.

The peer can make the batch longer by flooding packets. Suppose a
CHALLENGE in that batch is handled after the socket has been freed but
before the poked call is disconnected:

rxrpc_io_thread()
  rxrpc_input_packet()
    rxrpc_input_packet_on_conn()
      rxrpc_input_conn_packet()
        rxrpc_post_challenge()

net/rxrpc/conn_event.c:rxrpc_post_challenge() {
    ...
	rcu_read_lock();

	for (int i = 0; i < ARRAY_SIZE(conn->channels); i++) {
		if (conn->channels[i].call) {
			call = conn->channels[i].call;
			rx = rcu_dereference(call->socket);
			if (!rx) {
    ...
			if (test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags))
				break;
    ...
	if (call)
		queued = rxrpc_notify_socket_oob(call, skb);
    ...
}

Wouldn't this still read rx->flags from the freed rxrpc_sock? Couldn't
it then reach rxrpc_notify_socket_oob(), which takes rx->recvmsg_lock and
may call function pointers from the freed object? That is the same
use-after-free the commit message describes.

The same window looks like it exists in the generic close path too,
where rxrpc_propose_abort() pokes calls that are not yet complete. That
predates this patch, but it is the same rxrpc_post_challenge() access
this patch is meant to fix.

Would it make sense to remove the stale pointer as well? One option is
RCU_INIT_POINTER(call->socket, NULL) in rxrpc_release_call(), since
rxrpc_post_challenge(), rxrpc_notify_socket_oob() and
rxrpc_notify_socket() already handle a NULL rx. Another is to have
rxrpc_post_challenge() skip calls that are RXRPC_CALL_RELEASED or
complete. A third is to make release wait for the I/O thread to
disconnect the call.

The poke itself still looks needed for the call leak and the
rxrpc_destroy_client_conn_ids() BUG() and netns teardown hang described
in the commit message.

>  	return -EPROTO;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106011550.59902-1-juanagusnicco%40gmail.com
