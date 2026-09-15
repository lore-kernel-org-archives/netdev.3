Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7C24AA57A;
	Tue, 15 Sep 2026 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513061; cv=none; b=bS/Z7M7BTeZVLRHZLu03qc74zjRkWm1r3x0bLSMAyhN43Sbx4udehYa+BxShr5mGA9ivxSXv7geLWalfRi86dGvEuiB3+2PAc8ASx3Vt7YVAuah+vm29yrSwRr0e3Q6c+V4YeFjBw+sV/hpEgAKAAmV9LgXi3v2+q8c5mNYqbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513061; c=relaxed/simple;
	bh=5Jmwmt2LbEjbLvEK7HPvwOsQdXihavGsJPYpIP1qvlk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8OuL6VROe0ICx8wF01BdlR7PZH1/O3XeikGsz/QAG2baPg9FXr8FX6EhY2KLkLzMvOAVGR9wnwempAtas+ZSkaGLWLycZYJZZHNsr9NhT2d5UuyutmcdpEWGYfW/NSPtem0csgIwj3iUVB5nykr0FxS0UxG7DUVR4ZI2Xp6Fds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lycGnGSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lycGnGSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282991F00898;
	Tue, 15 Sep 2026 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513059;
	bh=fKrE2yvAmVqQNgBkjdgquVpeQNXMMKke58YkcJm3KAY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lycGnGSemzupwpe+GMUTI67j6pOUq1A+zp6JpEDR9NG+WgRsKfXS8bpfkaEJFIRJy
	 /QQVLjSnZxjO25gk+Ub7DD5RgDPG3lOk3Oj7pSo4MV5KTovMKVfJZ83fKmARiiRJBr
	 GsGeFF651WaDSXbrHJPG8sQ4EjPMrAVw9iK+EjevC+HTSPR70ClEBwV+va8uZnrsQX
	 ndXepyrYS2IK0JrFyTfrmi5IXLC9+4Y1zxa0xFOBaRsMnnSBknVnfpTp+9OgoXq7D+
	 F4zPTUszsG7F6s/qNZkfYSwe2oQjWnk6yqNZ5onNNKgaAvewFsVpB1mz9fFkTWMLPW
	 6ovZfgbyYJrZA==
Subject: Re: [PATCH net v10 05/14] rxrpc: Fix update of call->tx_pending
 without holding lock
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 22:57:38 +0000
Message-ID: <178951305871.22033.17597631281343046532@kernel.org>
In-Reply-To: <20260914151340.3227501-6-dhowells@redhat.com>
References: <20260914151340.3227501-6-dhowells@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] rxrpc_send_data() (net/rxrpc/sendmsg.c) leaks call->user_mutex
  on the RXRPC_CALL_TX_NO_MORE early-exit path.

--

rxrpc: Fix update of call->tx_pending without holding lock

This moves the release of call->user_mutex down into rxrpc_send_data(),
drops the _dropped_lock indicator parameter, and keeps call->tx_pending set
until the txbuf has been queued.  Both callers no longer unlock the call
mutex themselves.

Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index bbb39835ef9e7..b370e440e2fdb 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c
> @@ -320,10 +320,9 @@ static int rxrpc_alloc_txqueue(struct sock *sk, struct rxrpc_call *call)
>  static int rxrpc_send_data(struct rxrpc_sock *rx,
>  			   struct rxrpc_call *call,
>  			   struct msghdr *msg, size_t len,
> -			   rxrpc_notify_end_tx_t notify_end_tx,
> -			   bool *_dropped_lock)
> +			   rxrpc_notify_end_tx_t notify_end_tx)
> +	__releases(&call->user_mutex)
>  {
> -	struct rxrpc_txbuf *txb;
>  	struct sock *sk = &rx->sk;
>  	enum rxrpc_call_state state;
>  	long timeo;

[Severity: High]
Now that rxrpc_send_data() is annotated __releases(&call->user_mutex) and
owns the unlock, does the RXRPC_CALL_TX_NO_MORE test just below these
declarations still need converting?  It is not touched by this patch and
still returns without reaching out_unlock:

net/rxrpc/sendmsg.c:rxrpc_send_data() {
	...
	if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
				  call->cid, call->call_id, call->rx_consumed,
				  0, -EPROTO);
		return -EPROTO;
	}
	...
}

Since the callers no longer compensate with their own mutex_unlock(), can
this path leave call->user_mutex held on return?

RXRPC_CALL_TX_NO_MORE is set when the last DATA packet is queued:

net/rxrpc/sendmsg.c:rxrpc_queue_packet() {
	...
	if (last) {
		set_bit(RXRPC_CALL_TX_NO_MORE, &call->flags);
	...
}

So a sendmsg() without MSG_MORE followed by a second sendmsg() on the same
user_call_ID would take the mutex in rxrpc_do_sendmsg() via
mutex_lock_interruptible(&call->user_mutex), pass the
rxrpc_call_is_complete() pre-check (a client call is in AWAIT_REPLY at this
point), and then hit the -EPROTO return above.

Would that leave subsequent users of that call blocked indefinitely, given
that recvmsg() and the kernel-side users such as rxrpc_kernel_abort_call()
use an uninterruptible mutex_lock(&call->user_mutex), and would the task
then be able to exit while still owning the mutex?

Would "ret = -EPROTO; goto out_unlock;" be the intended form here?

> @@ -457,45 +456,46 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	if (rxrpc_call_is_complete(call) &&
>  	    call->error < 0)
>  		ret = call->error;
> -out:
> -	call->tx_pending = txb;
> +out_unlock:
> +	mutex_unlock(&call->user_mutex);
>  	_leave(" = %d", ret);
>  	return ret;

[ ... ]

> @@ -770,16 +769,15 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
>  		ret = 0;
>  		break;
>  	case RXRPC_CMD_SEND_DATA:
> -		ret = rxrpc_send_data(rx, call, msg, len, NULL, &dropped_lock);
> -		break;
> +		ret = rxrpc_send_data(rx, call, msg, len, NULL);
> +		goto error_put;
>  	default:
>  		ret = -EINVAL;
>  		break;
>  	}
>  
>  out_put_unlock:
> -	if (!dropped_lock)
> -		mutex_unlock(&call->user_mutex);
> +	mutex_unlock(&call->user_mutex);
>  error_put:
>  	rxrpc_put_call(call, rxrpc_call_put_sendmsg);
>  	_leave(" = %d", ret);

[ ... ]

> @@ -819,13 +816,9 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
>  		mutex_lock(&call->user_mutex);
>  
>  		ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg,
> -				      msg_data_left(msg),
> -				      notify_end_tx, &dropped_lock);
> +				      msg_data_left(msg), notify_end_tx);
>  		if (ret == -ESHUTDOWN)
>  			ret = call->error;
> -
> -		if (!dropped_lock)
> -			mutex_unlock(&call->user_mutex);
>  		if (ret < 0)
>  			break;

For the record, the same unconverted RXRPC_CALL_TX_NO_MORE return is moved
below the reload: label and changed to "ret = -EPROTO; goto out_unlock;" by
the following patch in the series, "rxrpc: Fix error handling in
rxrpc_send_data()", so the final state of the series does not have this
problem.

Could that conversion be folded into this patch instead, so that this commit
on its own does not leave call->user_mutex held for anyone bisecting through
it?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
