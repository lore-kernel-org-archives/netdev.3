Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC534B203D;
	Tue, 15 Sep 2026 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513066; cv=none; b=GB6nbCo4swUkkb81mbo+3+kQfoDxSnTtDBvLaU8Dv/qtt0wjRFij6T+XWAUDPeht24PuNUFkcFvmM3hCLGKC4ymYK+E5QFHrtrxAv/eIDT+6SQLeUSHAgOYoIvSn3ERsBagpe+EFaHU8wNo+x0wu5EDjzfp6YLY27HV30v796Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513066; c=relaxed/simple;
	bh=uyujR+GN5s0FwJVmmO0kMRpaIHTvaGqNuCLCHMmdLVk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AvPosHIZUt7hBUb6uHvaKW++qDAeKaI8KEuOWvnDxBwI+oBwXjaODjBh6TAqDyYv6eqOOB7gKALPjhYvWyVgmDc9aMWqubsmJisd7bk5vhfs2DLoJcB0qNherlyrfutr3I7qS1vWAywPPIuIHndFqDwwWigiKbV3DXdQ3zvIhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my/mUf1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my/mUf1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1221F00893;
	Tue, 15 Sep 2026 22:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513062;
	bh=T5GukWYecNimm+sA6rjLbn3TgIySCprpB9uMNHz5d4A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=my/mUf1Z9UQ39dXQ83910qiDFecFU/eAnG315VhpVaZfjM+fuX+1Kw8mRjxounwR2
	 ELOAngLbm9sW7vi58u1AGmKza/uh+kpPJIez/jW+nLn/A5Ui/9Su4hbt6rSO5kOCQl
	 ak8kKlZQfJvtISNvlRFaX9SgRyFHZNUhNYPedF5tvz8rfFL51DJFD8bKXhsY428kQE
	 KSXQevwZP90S48LurAat30uBVlyc7qa1roBHv99QpozMbw+/ZzF5LTiYj+hoNkgidk
	 zFuIYHnZk3ZvHodG4jCTo4FX7cXZXygtlvGJc1EKDldpe4SMIxX49/he9FtbLv+0xE
	 oyy0iiriVC9ig==
Subject: Re: [PATCH net v10 07/14] rxrpc: Fix packet encryption error handling
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 22:57:41 +0000
Message-ID: <178951306107.22033.1008932333966506338@kernel.org>
In-Reply-To: <20260914151340.3227501-8-dhowells@redhat.com>
References: <20260914151340.3227501-8-dhowells@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1 (2)

- [High] rxrpc_send_data() leaks call->user_mutex on the newly added
  terminal crypto-error path.
- [Low] Return-value documentation vs behaviour in rxrpc_send_data(): the
  reworked comment (net/rxrpc/sendmsg.c:492-521) adds item '(3) If an…

Pre-existing issues:
- [Low] Documentation/networking/rxrpc.rst (in the 'Send data through a
  call' section that this patch edits) declares the callback type as…
- [Low] The paragraph reworded by this patch in
  Documentation/networking/rxrpc.rst:881-884 states 'msg must not…

--

rxrpc: Fix packet encryption error handling

The patch reworks the ->secure_packet() failure handling in
rxrpc_send_data() so that -ENOMEM is treated as retryable (rewinding the
last packet and the iterator), while any other error marks the call with a
new RXRPC_CALL_TX_ERROR flag so subsequent sendmsg() attempts return -EIO.
The documentation and return-value comment are updated to match.

Closes: https://sashiko.dev/#/patchset/20260702144919.172295-1-dhowells%40redhat.com

> diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
> index 01ad12fdf3058..9b7eeae841485 100644
> --- a/Documentation/networking/rxrpc.rst
> +++ b/Documentation/networking/rxrpc.rst
> @@ -878,8 +878,10 @@ The kernel interface functions are as follows:
>       exclusively to in-kernel virtual addresses.  msg.msg_flags may be given
>       MSG_MORE if there will be subsequent data sends for this call.
>  
> -     The msg must not specify a destination address, control data or any flags
> -     other than MSG_MORE.
> +     msg must not specify a destination address, control data or any flags
> +     other than MSG_MORE.  The last-packet flag will only be set on the
> +     outgoing packet if MSG_MORE is not set and all the data in the iterator is
> +     buffered.

[Severity: Low]
This isn't a bug introduced by this patch, but while this paragraph is being
reworded: is the "any flags other than MSG_MORE" restriction still accurate?

The only in-tree caller, afs_make_call() in fs/afs/rxrpc.c, does:

	msg.msg_flags		= MSG_WAITALL | (call->write_iter ? MSG_MORE : 0);

and rxrpc_send_data() itself looks at MSG_WAITALL on the wait-for-space
path:

	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
				       msg->msg_flags & MSG_WAITALL);

Should MSG_WAITALL be mentioned as permitted here?

[Severity: Low]
This is a pre-existing documentation issue rather than something this patch
introduces, but it is in the same "Send data through a call" block being
edited.  The documented callback prototype is:

	typedef void (*rxrpc_notify_end_tx_t)(struct sock *sk,
					      unsigned long user_call_ID,
					      struct sk_buff *skb);

whereas include/net/af_rxrpc.h has:

	typedef void (*rxrpc_notify_end_tx_t)(struct sock *, struct rxrpc_call *,
					      unsigned long);

and rxrpc_notify_end_tx() in net/rxrpc/sendmsg.c invokes it as
notify_end_tx(&rx->sk, call, call->user_call_ID).  Could the documented
prototype be updated while this section is being touched?

[ ... ]

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 1012d2d337a55..ed7ff32da1847 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c

[ ... ]

> @@ -352,6 +353,13 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  		ret = -EPROTO;
>  		goto out_unlock;
>  	}
> +	if (unlikely(test_bit(RXRPC_CALL_TX_ERROR, &call->flags))) {
> +		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_tx_error,
> +				  call->cid, call->call_id, call->rx_consumed,
> +				  0, -EIO);
> +		ret = -EIO;
> +		goto out_unlock;
> +	}
>  
>  	ret = -EPIPE;
>  	if (sk->sk_shutdown & SEND_SHUTDOWN)

[ ... ]

> @@ -440,14 +449,29 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  		/* add the packet to the send queue if it's now full */
>  		if (!txb->space ||
>  		    (len == 0 && !more)) {
> +			/* Do any required crypto.  If this fails, it could
> +			 * have corrupted the txbuf content with a partial
> +			 * encrypt.  Assume that ENOMEM is retryable, but
> +			 * everything else is terminal.
> +			 */
> +			ret = call->security->secure_packet(call, txb);
> +			if (ret < 0) {
> +				/* Assume that ENOMEM here means that the
> +				 * encryption hasn't happened yet.  The data is
> +				 * aligned to avoid the need for slow buffering
> +				 * in the crypto walk.
> +				 */
> +				if (ret == -ENOMEM)
> +					goto maybe_error_rewind;
> +				set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
> +				goto out;
                                        ^^^^

[Severity: High]
Should this be goto out_unlock?  The out: label sits after the unlock in
rxrpc_send_data():

	ret = copied;
out_unlock:
	mutex_unlock(&call->user_mutex);
out:

The previous code used "goto out_unlock" here, and the function is annotated
__releases(&call->user_mutex).  Does this new path return with
call->user_mutex still held?

For the userspace path, rxrpc_do_sendmsg() does:

	case RXRPC_CMD_SEND_DATA:
		ret = rxrpc_send_data(rx, call, msg, len, NULL);
		goto error_put;

which skips its own mutex_unlock(&call->user_mutex), so sendmsg() would
return to userspace owning the mutex, and any later sendmsg()/recvmsg() on
that call would block on it.

For in-kernel senders, rxrpc_kernel_send_data() takes the mutex on each
iteration and breaks out on ret < 0 without unlocking:

	for (;;) {
		mutex_lock(&call->user_mutex);

		ret = rxrpc_send_data(rx, call, msg, ...);
		if (ret < 0)
			break;

and fs/afs then goes to error_do_abort, which calls
rxrpc_kernel_abort_call() -> mutex_lock(&call->user_mutex) in the same
task.  Can that self-deadlock?

The error is reachable from the security layers without -ENOMEM being
involved, e.g. rxkad_secure_packet():

	ret = key_validate(call->conn->key);
	if (ret < 0)
		return ret;

which can return -EKEYEXPIRED/-EKEYREVOKED, and rxgk_secure_packet():

	gk = rxgk_get_key(call->conn, NULL);
	if (IS_ERR(gk))
		return PTR_ERR(gk) == -ESTALE ? -EKEYREJECTED : PTR_ERR(gk);

plus -EPERM and crypto errors.

One further consequence: since the sendmsg that sets RXRPC_CALL_TX_ERROR
never drops call->user_mutex, does the new -EIO gate at the reload: label
ever become reachable for that call?

This same "goto out" is still present at the tip of the series
(619b79dff7d2).

> +			}
> +
>  			if (len == 0 && !more)
>  				txb->flags |= RXRPC_LAST_PACKET;
> -
> -			ret = call->security->secure_packet(call, txb);
> -			if (ret < 0)
> -				goto out_unlock;
>  			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
>  			call->tx_pending = NULL;
> +			rewind_by = 0;
>  
>  			/* At this point, if that was the last packet, it may
>  			 * have been transmitted and the reply (client call) or
> @@ -474,19 +498,22 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	 *
>  	 * (2) If another sendmsg() has already queued the last packet: -EPROTO.
>  	 *
> -	 * (3) If the send side of the socket is shut down, -EPIPE.
> +	 * (3) If an error caused it to be impossible to continue with the
> +	 *     call: -EIO.

[Severity: Low]
Does item (3) describe what the failing sendmsg() actually returns?  The
sendmsg() in which ->secure_packet() fails returns the raw error from the
security layer (-EKEYEXPIRED, -EKEYREVOKED, -EKEYREJECTED, -EPERM, or a
crypto errno), since the new terminal path leaves ret untouched:

	set_bit(RXRPC_CALL_TX_ERROR, &call->flags);
	goto out;

-EIO only appears on a subsequent sendmsg() via the new RXRPC_CALL_TX_ERROR
test at the reload: label.

That path also bypasses maybe_error:, so when copied > 0 the error is
returned rather than the byte count, which is the opposite of the stated
preference of item (7) over item (8).  Could the comment say that -EIO is
returned on subsequent sendmsg() calls, and that the first failure reports
the security layer's error even if data was consumed from msg_iter?

> +	 *
> +	 * (4) If the send side of the socket is shut down, -EPIPE.
>  	 *
> -	 * (4) If the call is in the wrong state to transmit: -EPROTO.
> +	 * (5) If the call is in the wrong state to transmit: -EPROTO.
>  	 *
> -	 * (5) If the call has terminated early, likely due to an external
> +	 * (6) If the call has terminated early, likely due to an external
>  	 *     event such as being remotely aborted: -ESHUTDOWN.
>  	 *
> -	 * (6) If some data has been copied by this call: the amount copied
> +	 * (7) If some data has been copied by this call: the amount copied
>  	 *     (which will be greater than zero).
>  	 *
> -	 * (7) Any other error.
> +	 * (8) Any other error.
>  	 *
> -	 * For (2)-(5), there's no point in continuing with the sendmsg().  The
> +	 * For (2)-(6), there's no point in continuing with the sendmsg().  The
>  	 * app should abort the call (just in case the error came from
>  	 * somewhere else) and then use recvmsg() to collect the final result
>  	 * of the call.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
