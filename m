Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B98E39792C;
	Thu,  8 Oct 2026 16:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476012; cv=none; b=hmPM975rbXjSS830GyhELSjVZVN8X0EP1eR6Bl0XtorIVV9txBVR54LmWYbJBzf93fhWc3LTpz2E1ftUOht6Q5+tckIQ4JAxRaX3mxT0n0xxweZotBl0GZbfs+lqMC9/Qq9PO77vnpsPtPwLeax5adCtVP5bkcdySJjJuzaNtPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476012; c=relaxed/simple;
	bh=zqQZ6jdm0ceVVB7R3Vutk3K6r2GU7OQMp9IP1wz0HqI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkcfH9PXF1Tk9gG1O4Oao35AiV6TcK5PesxYjtqEs6tJC+4sqXBQulrXC4+uUSg1qOqeea9nZZqUQZ35OvK9EqE4K+aJAtuvAHl2f2DHWcPxKHnKo9zL8GuYPZRuTM7W5BxkgqVOBirxZr4hyVdx1B2D13Q54sFGK0eOHow/QHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqCQnEFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqCQnEFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3673B1F00893;
	Thu,  8 Oct 2026 16:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476008;
	bh=/ROSAK714TRvZdumEdoLDVdO5UU6u3+FWRvebnsvW4s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FqCQnEFsB+M0Pr+xhzLerPN/yX+DZsiWJCoRD3TUVS044+dtCOVxTh0id5QSFTz/i
	 UVRiDRkR4/y7IDncaNTbmjg8c1d8xi3PWARyY/I7fWC1z3JBkOs++jFFeTfJ25S1jy
	 O4bm8hKcayWD/c57gQwOuomHssLm7IVZ+zlcQ5TTQ71Cs59oghp5rY9sGKcAQrwKBa
	 ZlAsSAcOC79z8ylzB9dIxBPys4p+pcY6a+NQ9dPRqi0bYPGznBfZ6nGO4UR6FP+kPC
	 Jcu90nSEt65ddTMlMTDxLkmFG/KxRQ+nc8swrgmhsB73pFBAfWSXQ9tpvuYUxP6S5F
	 dK7BH2XjVSQzQ==
Subject: Re: [PATCH net v12 10/15] rxrpc: Fix the cleanup of service calls
 when socket shut down
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Date: Thu, 08 Oct 2026 16:13:27 +0000
Message-ID: <179147600776.434549.5890389716719244101@kernel.org>
In-Reply-To: <20261006133011.531806-11-dhowells@redhat.com>
References: <20261006133011.531806-11-dhowells@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new wait in rxrpc_release_calls_on_socket()
  (net/rxrpc/call_object.c:631) waits on `rxrpc_call_is_complete(call)`.
- [High] Because notify_rx now runs when the socket is in RXRPC_CLOSE,
  rxperf's notification during sock_release() starts its own cleanup of…
- [Medium] Now that notify_rx is called even when the socket is in
  RXRPC_CLOSE, rxperf gets its last notifications from inside…
- [Low] The commit message says "neither afs nor rxperf" ends its calls,
  so calls are not cleaned up and rmmod of rxrpc can stall.

--

rxrpc: Fix the cleanup of service calls when socket shut down

This commit makes rxrpc_release_calls_on_socket() wait for each call to
reach the complete state after it proposes an abort. It also makes
rxrpc_notify_socket() call ->notify_rx() even when the socket is in
RXRPC_CLOSE. The aim is for kernel services to be notified about each
outstanding service call, so that they can clean up and rmmod does not
stall.

> When a kernel AF_RXRPC socket is shut down, rxrpc_release_call() detaches
> each outstanding service call from the socket, but doesn't send the app a
> notification for each call that the socket to end the linkage from the app
> side, assuming that the app will do this - but neither afs nor rxperf do.

[Severity: Low]
Is this accurate for afs? afs_close_socket() waits for all of its calls to
go away before it shuts down and releases the socket:

fs/afs/rxrpc.c:afs_close_socket() {
    ...
	kernel_listen(net->socket, 0);
    ...
	wait_var_event(&net->nr_outstanding_calls,
		       !atomic_read(&net->nr_outstanding_calls));
	_debug("no outstanding calls");

	kernel_sock_shutdown(net->socket, SHUT_RDWR);
    ...
	sock_release(net->socket);
    ...
}

kernel_listen(0) only moves the socket to LISTEN_DISABLED, which is still
below RXRPC_CLOSE. afs_free_call() calls rxrpc_kernel_shutdown_call() and
rxrpc_kernel_put_call() before it decrements nr_outstanding_calls.

So when rxrpc_release_calls_on_socket() runs, there should be no
afs-owned calls left on rx->sock_calls. That suggests only rxperf is
affected on this path.

Could the commit message be updated to say that?

> diff --git a/net/rxrpc/call_object.c b/net/rxrpc/call_object.c
> index 817ed9acb91e6..68d4096994bdd 100644
> --- a/net/rxrpc/call_object.c
> +++ b/net/rxrpc/call_object.c
> @@ -628,6 +628,7 @@ void rxrpc_release_calls_on_socket(struct rxrpc_sock *rx)
>  		rxrpc_get_call(call, rxrpc_call_get_release_sock);
>  		rxrpc_propose_abort(call, RX_CALL_DEAD, -ECONNRESET,
>  				    rxrpc_abort_call_sock_release);
> +		wait_event(call->waitq, rxrpc_call_is_complete(call));
>  		rxrpc_release_call(rx, call);

[Severity: High]
Does waiting on rxrpc_call_is_complete() guarantee that the notification
has run before the call is released?

rxrpc_set_call_completion() publishes COMPLETE and wakes call->waitq
before it calls rxrpc_notify_socket():

net/rxrpc/call_state.c:rxrpc_set_call_completion() {
    ...
	rxrpc_set_call_state(call, RXRPC_CALL_COMPLETE);
	trace_rxrpc_call_complete(call);
	wake_up(&call->waitq);
	rxrpc_notify_socket(call);
    ...
}

rxrpc_set_call_state() itself already does smp_store_release() on
call->_state and then wake_up(&call->waitq). rxrpc_notify_socket() then
tests RXRPC_CALL_RELEASED without holding any lock:

	if (test_bit(RXRPC_CALL_RELEASED, &call->flags)) {
		rxrpc_see_call(call, rxrpc_call_see_notify_released);
		return;
	}

Suppose the I/O thread takes an interrupt or is preempted just after the
wake_up(). Could the releaser then do this on another CPU?

I/O thread                          releaser
rxrpc_set_call_state(COMPLETE)
wake_up(&call->waitq)
  <irq / preempted>                 wait_event() returns
                                    rxrpc_release_call()
                                      test_and_set_bit(RELEASED)
rxrpc_notify_socket()
  test_bit(RELEASED) -> return

In that case notify_rx is skipped. That is the lost notification that
point (1) of the commit message says the wait prevents. For rxperf, the
kernel service's ref on the call would then never be dropped, and
rxrpc_destroy_all_calls() could wait forever on rxnet->nr_calls.

The other ordering also looks open. The I/O thread can pass the RELEASED
test first, and then the releaser can run rxrpc_release_call(). That
function never changes call->notify_rx to rxrpc_dummy_notify_rx. So
notify_rx can call into the kernel service after the call has been
released from the socket.

The spin_lock_irq()/spin_unlock_irq() pair on rx->recvmsg_lock in
rxrpc_release_call() does not order against this, because notify_rx runs
under call->notify_lock.

The race seems to still be there at the end of the series. "rxrpc: Fix
generation of notifications after call completion" renames the function
to __rxrpc_notify_socket(), but it still wakes waiters before notifying
and still tests RELEASED without a lock.

Does this need a different wait condition, or a lock shared with the
RELEASED check?

[ ... ]

> diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
> index 0c960f13b5fc4..214eea04b1c2c 100644
> --- a/net/rxrpc/recvmsg.c
> +++ b/net/rxrpc/recvmsg.c
> @@ -37,12 +37,12 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
>  
>  	rx = rcu_dereference(call->socket);
>  	sk = &rx->sk;
> -	if (rx && sk->sk_state < RXRPC_CLOSE) {
> -		if (call->notify_rx) {
> -			spin_lock_irqsave(&call->notify_lock, flags);
> -			call->notify_rx(sk, call, call->user_call_ID);
> -			spin_unlock_irqrestore(&call->notify_lock, flags);
> -		} else {
> +	if (call->notify_rx) {
> +		spin_lock_irqsave(&call->notify_lock, flags);
> +		call->notify_rx(sk, call, call->user_call_ID);
> +		spin_unlock_irqrestore(&call->notify_lock, flags);
> +	} else {

[Severity: High]
notify_rx is no longer gated on sk_state < RXRPC_CLOSE. Can rxperf's
notification during sock_release() now start rxperf's own cleanup of the
call while rxrpc_release_calls_on_socket() is releasing the same call?

The sequence looks like this:

rxperf_close_socket()
  flush_workqueue(rxperf_workqueue)
  sock_release(rxperf_socket)
    rxrpc_release()
      sock->sk = NULL
      rxrpc_release_sock()
        rxrpc_release_calls_on_socket()
          rxrpc_propose_abort()
          wait_event(call->waitq, ...)
          rxrpc_release_call(rx, call)

I/O thread:
rxrpc_set_call_completion()
  rxrpc_notify_socket()
    rxperf_notify_rx()
      queue_work(rxperf_workqueue, &call->work)

kworker:
rxperf_deliver_to_call()
  rxrpc_kernel_shutdown_call(rxperf_socket, call->rxcall)
    mutex_lock(&call->user_mutex)
    if (!test_bit(RXRPC_CALL_RELEASED, &call->flags))
        rxrpc_release_call(rxrpc_sk(sock->sk), call)

The socket release path calls rxrpc_release_call() without taking
call->user_mutex. Nothing else seems to serialise the two releasers.

If the kworker wins test_and_set_bit(), it passes rx == NULL, because
sock->sk has already been cleared. It then dereferences rx in
spin_lock_irq(&rx->recvmsg_lock), and the release thread hits this:

	if (test_and_set_bit(RXRPC_CALL_RELEASED, &call->flags))
		BUG();

If the release thread instead sets RELEASED between the kworker's
test_bit() and its test_and_set_bit(), the kworker hits that BUG().

Before this patch, the sk_state check suppressed these notifications, so
this window did not exist. The rxperf close sequence and
rxrpc_release_calls_on_socket() look unchanged at the end of the series.

[Severity: Medium]
A related question about the work queued from rxperf_notify_rx() during
sock_release(). rxperf_close_socket() flushes the workqueue before it
releases the socket:

net/rxrpc/rxperf.c:rxperf_close_socket() {
	kernel_listen(rxperf_socket, 0);
	kernel_sock_shutdown(rxperf_socket, SHUT_RDWR);
	flush_workqueue(rxperf_workqueue);
	sock_release(rxperf_socket);
}

The last notifications now arrive inside sock_release(). The work they
queue therefore misses this flush and is only drained by
destroy_workqueue() in rxperf_exit().

Could that work then run rxrpc_kernel_recv_data(rxperf_socket, ...) ->
rxrpc_recvmsg_data()? That does rxrpc_sk(sock->sk) on a struct socket
that rxrpc_release() has cleared and __sock_release() has freed.

On this path the call has failed, so rxrpc_recvmsg_data() jumps straight
to done without using rx. Depending on code generation, this may only
show up as a stale read, for example as a KASAN report.

Does rxperf's close ordering need to change to handle callbacks that now
arrive during release?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006133011.531806-1-dhowells%40redhat.com
