Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35C63AAF55;
	Thu,  8 Oct 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476015; cv=none; b=Af2eiPgHV0Pa2EsGnw52UvDAmOM9aosPpFdFDKtwtjI35tMw7+Myw1e4jgqcFH6uuTHau00CUEuD8bgWy25aUZvDAR/kT9N308bJZQuTSid/9nRThiUeT5agP7W/cVnEva+8ib0LwEtuoZ/Oi6/Z1jd7WHCerofiD+cPqYwus8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476015; c=relaxed/simple;
	bh=ipT1rPKjbJBLsD7WCDyHLEyp9aZ1/DbUCFalxD5G35o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MWkjZGqpRU4gj5zwj0bKlyI+4KWHxb+/1uR//rOPABCqrSxnuDRSlGLfwb/c4YuRw/fk4ocWn5NG6QWfyQVBi4+A96DoIw/y4Rvm6Jm9QOwG816VNgOV6fdDeAPSsG7ZGX3jq1czimfFSF7wWyi8wTTs9jT4x1UAVWJZDdYUuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJAThB5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJAThB5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6857F1F008A0;
	Thu,  8 Oct 2026 16:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476010;
	bh=2fe5GDWdniepA4IFM6p4gDJa1e7vllvP1Cxo47vwcxY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oJAThB5nk8k+UQoYtrLbrWw1J7VSWx/++CvxhQkfZN9dBaBPZKSZJKGW/9Vo2J1cR
	 o38Xy/1P0KtAjba6FM87LgYkqhc7rMH/E86ReoU75vm9nYRM+G6Fxdb66KIh+Ta0F3
	 c2zqmwZW5f0eSImVoAWsfJsEYPK5oenNr81Mqrc5QMT+qhDB829pIzAqKe/tdOab3f
	 KMeZ6twgcZgOP/lLGel+mqeJr73Y8+phcSOplaBWlw11eVtzoPyyjl7u/pjZX6bxJm
	 MgJYNbqadI9VhYrTcx2FLahxfR8oTpXenFvn7bCG1CJK6mKh+6vsR4vE/GiOpWE2Dg
	 WrMJZAE/EN1kA==
Subject:
 Re: [PATCH net v12 11/15] rxrpc: Fix error handling in rxrpc_send_data()
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Date: Thu, 08 Oct 2026 16:13:28 +0000
Message-ID: <179147600897.434549.10688916020887869134@kernel.org>
In-Reply-To: <20261006133011.531806-12-dhowells@redhat.com>
References: <20261006133011.531806-12-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In this patch, rxrpc_send_data() sets RXRPC_LAST_PACKET on the
  txb before calling secure_packet().
- [Low] The new return-value comment in rxrpc_send_data() says '(2) If
  the call has terminated early ...: -ESHUTDOWN' takes priority over…
- [Low] The new 'Notes on sendmsg' text says EAGAIN, ENOMEM, EINTR,
  ERESTARTSYS and EFAULT are retryable and that any other error means…
- [Low] The patch renames the callback parameter in the rst prototype of
  rxrpc_kernel_send_data() to 'notify_end_tx', but the paragraph below…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  rxrpc_queue_packet() publishes the final DATA packet…

--

rxrpc: Fix error handling in rxrpc_send_data()

After this change, rxrpc_send_data() no longer returns an error once the
last packet of a call has been queued; recvmsg() reports the completion
instead. If the call completes before the final packet is queued,
-ESHUTDOWN is returned instead of call->error, and the afs and rxperf
callers and the rxrpc documentation are updated to match.

> diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
> index eca055a536aa1..58c2ce97f641d 100644
> --- a/Documentation/networking/rxrpc.rst
> +++ b/Documentation/networking/rxrpc.rst
> @@ -290,6 +290,10 @@ Notes on sendmsg:
>       EINTR/ERESTARTSYS if nothing was consumed or returning the amount of data
>       consumed.
>  
> +     If sendmsg() returns EAGAIN, ENOMEM, EINTR, ERESTARTSYS or EFAULT, then
> +     the sendmsg can be retried.  If anything else is returned, the call should
> +     be considered unusable and should be aborted.

[Severity: Low]
Should EBUSY be in this list as well?

The first sendmsg() on a new client call registers the call under its
user_call_ID in rxrpc_new_client_call_for_sendmsg(). A signal can then
interrupt it in rxrpc_wait_to_be_connected() with EINTR or ERESTARTSYS
while the call is still in RXRPC_CALL_CLIENT_AWAIT_CONN.

If the application retries as described here, or the syscall is
restarted through SA_RESTART, rxrpc_do_sendmsg() finds the existing call
and does:

	switch (rxrpc_call_state(call)) {
	case RXRPC_CALL_CLIENT_AWAIT_CONN:
	case RXRPC_CALL_SERVER_RECV_REQUEST:
		if (p.command == RXRPC_CMD_SEND_ABORT)
			break;
		fallthrough;
	...
		ret = -EBUSY;

The EBUSY return was there before this patch. With this text, though, an
application would treat it as fatal and abort a call that is only
waiting for a connection.

> +
>  
>  Notes on recvmsg:
>  

[ ... ]

> @@ -879,7 +883,9 @@ The kernel interface functions are as follows:
>       MSG_MORE if there will be subsequent data sends for this call.
>  
>       msg must not specify a destination address, control data or any flags
> -     other than MSG_MORE or MSG_WAITALL.
> +     other than MSG_MORE or MSG_WAITALL.  The last-packet flag will only be set
> +     on the outgoing packet if MSG_MORE is not set and all the data in the
> +     iterator is buffered.
>  
>       notify_end_rx can be NULL or it can be used to specify a function to be
>       called when the call changes state to end the Tx phase.  This function is

[Severity: Low]
The prototype above now names the parameter notify_end_tx, but this
paragraph still calls it notify_end_rx. Should the paragraph be updated
too?

The paragraph also says the callback is "called with a spinlock held to
prevent the last DATA packet from being transmitted until the function
returns". Is that still accurate?

rxrpc_queue_packet() calls the notifier with no spinlock held, after the
last packet has already been published:

	sq->bufs[ix] = txb;
	smp_store_release(&call->send_top, seq);
	if (last) {
		set_bit(RXRPC_CALL_TX_NO_MORE, &call->flags);
		rxrpc_notify_end_tx(rx, call, notify_end_tx);

The I/O thread reads send_top without a lock in
rxrpc_transmit_fresh_data(), so it can send the last packet before the
callback runs. Both statements are still there at the end of the series.

[ ... ]

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index 312be27ca75b5..dff166ff78eb1 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c

[ ... ]

> @@ -449,31 +451,65 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  				goto out_unlock;

[Severity: Low]
This goto out_unlock is the exit taken when secure_packet() fails:

	if (len == 0 && !more)
		txb->flags |= RXRPC_LAST_PACKET;

	ret = call->security->secure_packet(call, txb);
	if (ret < 0)
		goto out_unlock;

The new documentation says ENOMEM is retryable. What happens when a
caller retries after secure_packet() fails with -ENOMEM?

By this point:
- the data has already been copied out of the iterator
- tx_total_len and copied have already been adjusted
- the txb left in call->tx_pending has RXRPC_LAST_PACKET set and may be
  partly secured

None of this is rewound before the error is returned.

A retry would then add more data to a txb that is already marked last.
Could that queue the last packet too early and clear call->send_queue?
If the remaining data then needs a new queue, could it hit
WARN_ON(call->tx_queue) in rxrpc_alloc_txqueue()?

This looks to be fixed later in the series by "rxrpc: Fix packet
encryption error handling". That patch sets RXRPC_LAST_PACKET only after
secure_packet() succeeds, sends -ENOMEM to a new rewind path, and sets
RXRPC_CALL_TX_ERROR for other errors.

>  			rxrpc_queue_packet(rx, call, txb, notify_end_tx);
>  			call->tx_pending = NULL;
> +
> +			/* At this point, if that was the last packet, it may
> +			 * have been transmitted and the reply (client call) or
> +			 * final ACK (service call) may have been received,
> +			 * completing the call.
> +			 */

[Severity: High]
This isn't a bug introduced by this patch, but as this comment says, the
reply can arrive before rxrpc_queue_packet() has called notify_end_tx.
Can that leave an async AFS call stuck?

rxrpc_queue_packet() publishes the last packet with
smp_store_release(&call->send_top, seq) before it calls
rxrpc_notify_end_tx(). If the sender is preempted in between, the I/O
thread can send the packet from rxrpc_transmit_fresh_data(). The reply
can then come back while the AFS call is still in
AFS_CALL_CL_REQUESTING:

rxrpc_notify_socket()
  afs_wake_up_async_call()
    afs_process_async_call()
      call->need_attention = false;
      afs_deliver_to_call()
        state is AFS_CALL_CL_REQUESTING, loop skipped, goto done

Then afs_notify_end_request_tx() runs on the sender side:

	afs_set_call_state(call, AFS_CALL_CL_REQUESTING, AFS_CALL_CL_AWAIT_REPLY);

Nothing requeues the work at this point. Notifications are suppressed
once the call is complete. So if a single-batch reply completes the call,
is the reply ever processed? This could leave FS/VL probes or async
FetchData calls hanging.

The rst text about the notifier being called under a spinlock describes
exactly the guarantee that would prevent this, but the code does not
provide it.

>  		}
>  	} while (len > 0 && msg_data_left(msg) > 0);

[ ... ]

> +	 * (2) If the call has terminated early, likely due to an external
> +	 *     event such as being remotely aborted: -ESHUTDOWN.

[ ... ]

> +	 * (6) If some data has been copied by this call: the amount copied
> +	 *     (which will be greater than zero).

[ ... ]

>  maybe_error:
> -	if (copied)
> -		goto success;
> +	if (copied) {
> +		if (rxrpc_call_is_complete(call)) {
> +			ret = -ESHUTDOWN;
> +			goto out_unlock;
> +		}
> +		ret = copied;
> +	}
>  	goto out_unlock;

[ ... ]

> @@ -496,7 +532,9 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
>  	goto reload;
>  out_nolock:
>  	_leave(" = %d [intr]", ret);
> -	return copied ?: ret;
> +	if (copied)
> +		ret = copied;
> +	goto out;

[Severity: Low]
Should this path follow the order of preference in the new comment, where
(2) -ESHUTDOWN comes before (6) the amount copied?

Take a call that completes while sendmsg is waiting for Tx space after
some data has already been copied.
rxrpc_wait_for_tx_window_intr(), rxrpc_wait_for_tx_window_waitall() or
rxrpc_wait_for_tx_window_nonintr() then returns -ESHUTDOWN, and
out_nolock overwrites it with copied.

The maybe_error path above returns -ESHUTDOWN in the same situation.
Here, though, a peer abort during the wait reaches the caller as a
successful short write. This is still the same at the end of the series.

Would it make sense to keep ret here when it is -ESHUTDOWN?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006133011.531806-1-dhowells%40redhat.com
