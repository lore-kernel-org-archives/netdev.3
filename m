Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDC14A99AE;
	Tue, 15 Sep 2026 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513065; cv=none; b=C1yFUY2XrNC+donJrqNlVtG4FRrQU1g8ejyXD5rHWz9nc9/obMUQz7c6iN59vppAhs9/KncxYaWkrVsuHwO6OD2RRKQdVC/dIKupikOiffxYMYfcHnumUefoDVcuVwNdQTv+kdMdaovkgkNTYEPn01Wjf50A0ROjkTgLBHCstiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513065; c=relaxed/simple;
	bh=qUucvE8YEtnKpvPmVM67J2c7VR2o/3CouzqxiMGep2Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ptcOFYHa37S0d/hMSccyvrvnYhC8jo2fKyUgIybTydP/SXQD+yfl3zSjrC5G24RCJwumtRBz4UVozGkyX8vRCgAFEnWyW1d9T1FKLoHAh6AuqraOtq/usJrdlgdOslsbZGp9626QCg5hwnd3/CD3oRlTP7apI9H8zne5W+xr9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxxpkAU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxxpkAU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED4D1F000FF;
	Tue, 15 Sep 2026 22:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513060;
	bh=qTYOXZ0Whaav9iCRByXnpk+ZpXdtR4YBT++sW6WVe6U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OxxpkAU5b2kWgoyrnnGUMmPjwc+2sW8ZPlFUjXqMsMBio7clLKRnE7PILZXO50si9
	 aVoFQC1ypyYjX7l2mZz4KxdacWbhla8dTb+qLvvseQwPKEiaS2Pqg8OCG7ddk5k3yh
	 9WMkYCCoBbNinWig5EtQqH374LHlWoTYH2aAisbBYtI8gqb1pvGU6ahWzO+DrYS1qb
	 h3kx3QpSV0rc1nbDmD9JDeJBJuxBMT2dyDScsYYlFLEzEksB3JEIB895TcRKIQG70b
	 7avC0fKeQmM+DnijqfJ2M8es+IYHUxrhgf5URlsZeZKSFc1Y9H3OQwASIHHxznjE4d
	 kcCAVCrOBHYRQ==
Subject:
 Re: [PATCH net v10 06/14] rxrpc: Fix error handling in rxrpc_send_data()
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 22:57:39 +0000
Message-ID: <178951305986.22033.17965520525371235903@kernel.org>
In-Reply-To: <20260914151340.3227501-7-dhowells@redhat.com>
References: <20260914151340.3227501-7-dhowells@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 4 · Low: 2

- [High] rxrpc_send_data returns call->error (e.g., -ECONNABORTED)
  instead of -ESHUTDOWN when the call completes while sleeping, causing…
- [Medium] rxrpc_send_data(): the revalidation block moved/changed at the
  `reload:` label now discards an already-non-zero `copied`, and the…
- [Medium] net/rxrpc/rxperf.c: converting rxperf_process_call() to `void`
  and calling it as `case 0: rxperf_process_call(call); return;` removes…
- [Medium] Moving the RXRPC_CALL_TX_NO_MORE test from the top of
  rxrpc_send_data() to the `reload:` label (and turning `return…
- [Medium] net/rxrpc/rxperf.c, rxperf_deliver_to_call(): the new
  RXPERF_CALL_SV_AWAIT_ACK handler cannot distinguish "still waiting for…
- [Low] The patch changes partial-send semantics for conditions unrelated
  to call completion without disclosing it in the commit message.
- [Low] The explanatory comment added by this patch after the new `out:`
  label states a precedence in which "(6) If some data has been copied…

--

rxrpc: Fix error handling in rxrpc_send_data()

This reworks the return-value handling of rxrpc_send_data() so that a call
which completes after the final packet has been queued no longer causes
sendmsg() to report an error, and returns -ESHUTDOWN when the call is
already complete and the last packet has not been queued yet.  The rxperf
sample server and the afs error path are adjusted to match.

A few questions about the new control flow below.

> diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
> index 7e9a536153098..83016830e6965 100644
> --- a/net/rxrpc/rxperf.c
> +++ b/net/rxrpc/rxperf.c

[ ... ]

> @@ -293,18 +293,28 @@ static void rxperf_deliver_to_call(struct work_struct *work)
>  	       state == RXPERF_CALL_SV_AWAIT_ACK
>  	       ) {
>  		if (state == RXPERF_CALL_SV_AWAIT_ACK) {
> -			if (!rxrpc_kernel_check_life(rxperf_socket, call->rxcall))
> +			size_t len = 0;
> +			iov_iter_kvec(&call->iter, ITER_DEST, NULL, 0, 0);
> +			ret = rxrpc_kernel_recv_data(rxperf_socket,
> +						     call->rxcall, &call->iter,
> +						     &len, false, &remote_abort,
> +						     &call->service_id);
> +
> +			if (ret == -EINPROGRESS || ret == -EAGAIN)
> +				return;
> +			if (ret < 0 || ret == 1) {
> +				if (ret == 1)
> +					ret = 0;
>  				goto call_complete;
> +			}
>  			return;
>  		}

[Severity: Medium]
Can this new AWAIT_ACK check tell "still waiting for the final ACK" apart
from "call complete"?

Once the whole request has been read, rxrpc_rotate_rx_window() has set the
read-all flag:

net/rxrpc/recvmsg.c:rxrpc_rotate_rx_window() {
	...
	set_bit(RXRPC_CALL_RECVMSG_READ_ALL, &call->flags);
	...
}

and rxrpc_recvmsg_data() then short-circuits:

net/rxrpc/recvmsg.c:rxrpc_recvmsg_data() {
	...
	if (test_bit(RXRPC_CALL_RECVMSG_READ_ALL, &call->flags)) {
		seq = call->ackr_window - 1;
		ret = 1;
		goto done;
	}
	...
}

so rxrpc_kernel_recv_data() returns 1 (read_phase_complete) and the new code
always takes the "ret == 1" branch to call_complete, running
rxperf_set_call_complete(), rxrpc_kernel_shutdown_call(),
rxrpc_kernel_put_call() and kfree(call) while the final ACK for the reply is
still outstanding.  rxrpc_kernel_shutdown_call() documents the opposite
expectation:

/* Allow a kernel service to shut down a call it was using.  The call must be
 * complete before this is called (the call should be aborted if necessary).
 */

The replaced rxrpc_kernel_check_life() returned true while the call was not
complete, so the handler waited instead.  Re-entering the work item in
SV_AWAIT_ACK is routine: any rxrpc_notify_socket() that fires while the work
item runs (for example request DATA packets queued in sequence for a
multi-packet request) re-queues call->work, which then runs again after
rxperf_notify_end_reply_tx() has moved the state to SV_AWAIT_ACK.

Two of the new tests also look unreachable: rxrpc_kernel_recv_data() does not
return -EINPROGRESS (that value only comes from rxperf's own ->deliver()
functions), and with want_more clear a 0 result from rxrpc_recvmsg_data()
is turned into -EMSGSIZE by the excess_data path, so the trailing "return;"
for the keep-waiting case cannot be reached.

>  
>  		ret = call->deliver(call);
> -		if (ret == 0)
> -			ret = rxperf_process_call(call);
> -
>  		switch (ret) {
>  		case 0:
> -			continue;
> +			rxperf_process_call(call);
> +			return;

[Severity: Medium]
Can this leak the struct rxperf_call and the rxrpc_call reference?

Discarding the reply-send result here removes the only path by which a send
failure reached call_complete (rxperf_set_call_complete() +
rxrpc_kernel_shutdown_call() + rxrpc_kernel_put_call() + cancel_work() +
kfree(call)).  Teardown now depends on a further rxrpc notification
re-queueing call->work, and notifications stop once the socket is closing:

net/rxrpc/recvmsg.c:rxrpc_notify_socket() {
	...
	if (rx && sk->sk_state < RXRPC_CLOSE) {
	...
}

net/rxrpc/af_rxrpc.c:rxrpc_shutdown() {
	...
	sk->sk_state = RXRPC_CLOSE;
	sk->sk_shutdown = SHUTDOWN_MASK;
	...
}

So for rxperf_exit() -> rxperf_close_socket() -> kernel_sock_shutdown() while
a work item is inside rxperf_process_call(), the next
rxrpc_kernel_send_data() returns -EPIPE, the new void error path only
proposes an abort:

send_error:
	rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
				RXGEN_SS_MARSHAL, n,
				rxperf_abort_send_error);

and rxperf_deliver_to_call() has already returned.  The abort completes the
call in the I/O thread, but the notification is suppressed because sk_state
is RXRPC_CLOSE, so call->work is never re-queued and nothing frees the call.
Before this patch the same -EPIPE reached the switch default and always went
to call_complete.

[ ... ]

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index b370e440e2fdb..1012d2d337a55 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -329,13 +329,6 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	bool more = msg->msg_flags & MSG_MORE;
>  	int ret, copied = 0;
>  
> -	if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
> -		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
> -				  call->cid, call->call_id, call->rx_consumed,
> -				  0, -EPROTO);
> -		return -EPROTO;
> -	}
> -

[Severity: Medium]
Does this hunk also fix a leaked call->user_mutex introduced earlier in the
same series?

In the pre-image rxrpc_send_data() is already annotated
__releases(&call->user_mutex) and both callers depend on it to unlock:

net/rxrpc/sendmsg.c:rxrpc_kernel_send_data() {
	...
	mutex_lock(&call->user_mutex);
	ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg,
			      msg_data_left(msg), notify_end_tx);
	if (ret < 0)
		break;
	...
}

and rxrpc_do_sendmsg() jumps to error_put, which only drops the call ref.
The removed test returns -EPROTO without unlocking, so at that intermediate
commit a sendmsg() issued after the final packet had been queued would leave
call->user_mutex held and any later sendmsg/recvmsg/abort/close on that call
would block.

Both commits carry Fixes: and cc: stable.  Would it be worth saying in the
changelog that this hunk is also a lock-leak fix, so the earlier commit is
not backported on its own?

>  	timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
>  
>  	ret = rxrpc_wait_to_be_connected(call, &timeo);
> @@ -352,13 +345,20 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>  
>  reload:
> +	if (unlikely(test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags))) {
> +		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
> +				  call->cid, call->call_id, call->rx_consumed,
> +				  0, -EPROTO);
> +		ret = -EPROTO;
> +		goto out_unlock;
> +	}
> +
>  	ret = -EPIPE;
>  	if (sk->sk_shutdown & SEND_SHUTDOWN)
> -		goto maybe_error;
> +		goto out_unlock;
>  	state = rxrpc_call_state(call);
> -	ret = -ESHUTDOWN;
>  	if (state >= RXRPC_CALL_COMPLETE)
> -		goto maybe_error;
> +		goto call_terminated;

[Severity: Medium]
Can these three exits throw away a non-zero copied?

All of them now bypass maybe_error and return -EPROTO, -EPIPE or -ESHUTDOWN
from out_unlock.  The reload label is also reached after the mutex has been
dropped and the thread has slept:

wait_for_space:
	ret = -EAGAIN;
	if (msg->msg_flags & MSG_DONTWAIT)
		goto maybe_error;
	mutex_unlock(&call->user_mutex);

	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
				       msg->msg_flags & MSG_WAITALL);
	...
	goto reload;

By that point copied can already be non-zero: the first loop iteration filled
a txbuf, rxrpc_queue_packet() published it and cleared call->tx_pending, and
the following iteration failed rxrpc_check_tx_space().  While user_mutex is
dropped, a second sendmsg() on the same user_call_ID can queue the final
packet and set RXRPC_CALL_TX_NO_MORE, shutdown() can set SEND_SHUTDOWN, or
the I/O thread can complete the call.  sendmsg() then returns a hard error
although this invocation has already consumed bytes from msg->msg_iter and
queued full DATA packets that will still be transmitted, so the application
cannot tell how much of its buffer was accepted.

Related to the same window, is the new maybe_error branch reachable at all?

maybe_error:
	if (copied) {
		if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
			/* If we've get here, we must have slept waiting for space and .
			 */
			ret = copied;
			goto out_unlock;
		}

The bit is either set by this thread queueing the last packet, in which case
the do/while loop exits to "ret = copied", or set by another thread while the
mutex was dropped, which the new test at reload catches first.  The comment
also reads as an unfinished sentence ("waiting for space and .").

>  	ret = -EPROTO;
>  	if (state != RXRPC_CALL_CLIENT_PRE_SEND &&
>  	    state != RXRPC_CALL_CLIENT_SEND_REQUEST &&

[ ... ]

> @@ -448,31 +448,73 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,

[ ... ]

> -success:
> +	/* Don't check for call completeness here, but leave that to recvmsg or
> +	 * a further call to sendmsg().
> +	 */
>  	ret = copied;
> -	if (rxrpc_call_is_complete(call) &&
> -	    call->error < 0)
> -		ret = call->error;
>  out_unlock:
>  	mutex_unlock(&call->user_mutex);
> +out:
> +
> +	/* The return value is a bit complicated as we want to avoid returning
> +	 * an error if we have queued the final packet.  In descending order of
> +	 * preference:
> +	 *
> +	 * (1) If we queue the last packet: the amount copied (which may be
> +	 *     zero).  recvmsg() should be used to collect the result.
> +	 *
> +	 * (2) If another sendmsg() has already queued the last packet: -EPROTO.
> +	 *
> +	 * (3) If the send side of the socket is shut down, -EPIPE.
> +	 *
> +	 * (4) If the call is in the wrong state to transmit: -EPROTO.
> +	 *
> +	 * (5) If the call has terminated early, likely due to an external
> +	 *     event such as being remotely aborted: -ESHUTDOWN.
> +	 *
> +	 * (6) If some data has been copied by this call: the amount copied
> +	 *     (which will be greater than zero).
> +	 *
> +	 * (7) Any other error.

[Severity: Low]
Does the code implement item (6) taking precedence over item (7)?  The
->secure_packet() failure path inside the loop does:

			ret = call->security->secure_packet(call, txb);
			if (ret < 0)
				goto out_unlock;

so an -ENOMEM there is returned even though copied is non-zero (the bytes
were copied into txb just above and the txbuf stays as call->tx_pending),
while every other in-loop error exit goes through maybe_error.  The
retryable case is rerouted to maybe_error_rewind by the following patch,
"rxrpc: Fix packet encryption error handling", which also rewrites this
list, but as written here the comment describes behaviour the function does
not have.

> +	 *
> +	 * For (2)-(5), there's no point in continuing with the sendmsg().  The
> +	 * app should abort the call (just in case the error came from
> +	 * somewhere else) and then use recvmsg() to collect the final result
> +	 * of the call.
> +	 */
>  	_leave(" = %d", ret);
>  	return ret;
>  
>  call_terminated:
> -	ret = call->error;
> +	ret = -ESHUTDOWN;
>  	goto out_unlock;
>  
>  maybe_error:
> -	if (copied)
> -		goto success;
> +	if (copied) {
> +		if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
> +			/* If we've get here, we must have slept waiting for space and .
> +			 */
> +			ret = copied;
> +			goto out_unlock;
> +		}
> +		if (rxrpc_call_is_complete(call))
> +			goto call_terminated;
> +		ret = copied;
> +	}
>  	goto out_unlock;
>  
>  efault:
>  	ret = -EFAULT;
> -	goto out_unlock;
> +	goto maybe_error;

[Severity: High]
Is -ESHUTDOWN really the only error afs_make_call can now see for
a call that terminated early?

The new return-value contract documented in rxrpc_send_data() says
that a call which has terminated early (e.g. remotely aborted) gets
-ESHUTDOWN, and this hunk narrows the afs recovery path from
-ECONNABORTED to exactly that value.  But the two sleeping paths in
rxrpc_send_data() still pass call->error straight back to the caller:

	ret = rxrpc_wait_to_be_connected(call, &timeo);
	if (ret < 0)
		goto out_unlock;

and

	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
				       msg->msg_flags & MSG_WAITALL);
	if (ret < 0)
		goto out_nolock;

where rxrpc_wait_for_tx_window_intr() and its non-interruptible
counterpart do:

	if (rxrpc_call_is_complete(call))
		return call->error;

So if the peer aborts the call (or the connection errors out) while
this thread is blocked waiting to be connected or waiting for Tx
window space, sendmsg() returns -ECONNABORTED (or -ENETUNREACH, etc.)
rather than -ESHUTDOWN; out_nolock leaves ret alone when copied is
zero, so nothing remaps it.  rxrpc_kernel_send_data() then propagates
that to afs_make_call(), which no longer matches on it: the
rxrpc_kernel_recv_data() call that collects call->abort_code is
skipped and call->responded stays false, so afs records a plain local
error and loses the remote abort reason it used to pick up.  That is
exactly the case the previous -ECONNABORTED test existed to handle.

Which end should be adjusted?  Making the wait helpers (or the
out_unlock/out_nolock paths that consume their result) return
-ESHUTDOWN when rxrpc_call_is_complete() would keep the documented
contract in one place; alternatively afs_make_call() has to keep
accepting -ECONNABORTED and friends.  Either way the two halves of
this patch currently disagree about what sendmsg() reports for a call
that died while we were asleep.

[Severity: Low]
Should the changelog also mention the partial-write behaviour changes that
are unrelated to call completion?

With efault now going to maybe_error, a copy_from_iter_full() fault on a
later segment returns the positive byte count instead of -EFAULT.  The
SEND_SHUTDOWN and wrong-transmit-state tests move the other way: they used
to "goto maybe_error" and hence return the byte count when copied was
non-zero, and now return -EPIPE / -EPROTO directly.

The changelog only discusses completed calls, the final packet and
-ESHUTDOWN.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
