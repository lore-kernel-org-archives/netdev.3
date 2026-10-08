Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CBF39EF01;
	Thu,  8 Oct 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476010; cv=none; b=e+m7oIaVz6tNl28Yt0k0fBex6EUqDQZVCllx4tdA60Vwg9zTpj+Rdg8aKcYzBoJhoFL4F6jG5lwYFFSffNwgsQJsrIBEluru81Ejl5C4YUjij2/0Mso5v2G9t6Zm0xQeeJxIkv/CevB7GteW2oAKcMPQtOizoZ7EKaVqEnEtKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476010; c=relaxed/simple;
	bh=zx4/v5aE1eak9n+DnuQK5iQpKSP3pCeddLxXJAbui74=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qR9P48a2gzRjoJBmkPkbofG8+IYN8907cnX9xkDhdnGq7PAIt6fCdpsKwheAYq6i83J9KMx55WSeds4LcaVnwfBUt/LoGI8QkUMsi7eZdq3fzR3p3QM15ADKXQ3Vw6jYB3Bbgk/VCBO4coRIvgnobRK2d9+Mnh8Ai/8bcKq56Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVSjXDs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVSjXDs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7241F000FF;
	Thu,  8 Oct 2026 16:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476007;
	bh=z4Ya8LhcxhOVCJR5Qst1KPnR16o0dAxyC1gBFEdQCKE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CVSjXDs7BQ/fo0dyfqg7UFE3DD4TvydxALA8fBGU01Nb1UTBdLmtWKa7XKAWg96EV
	 z0JA2oi0vRGTxu89fwFxWNiI1NlrHI6yhq11ff8bWOgTcYVQUJi9wwyeW9KF/rcFiO
	 qvbfLiFZz+zqatKaZ+tCsawUCDVDhiKxNDpTBmQ/1kl5p9aQcrkhEXlf6ead8z4DeW
	 VnuAJBXl/rk+BQFpmZET4aNoyMzuaPtAMzMddfmx6Vsm+5Ublpyzi5RMWQ6pNoJWH9
	 E7fBIIjnpB99mCtlf3zMLu7R+iPwkNxA7oebB1q8cd7W1kdwLYPNJxHb2xgvnF5x/6
	 Kaxb00BjIb1OA==
Subject: Re: [PATCH net v12 09/15] rxrpc: Fix return in rxrpc_recvmsg_data()
 for service calls
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Date: Thu, 08 Oct 2026 16:13:26 +0000
Message-ID: <179147600664.434549.7832091583681296373@kernel.org>
In-Reply-To: <20261006133011.531806-10-dhowells@redhat.com>
References: <20261006133011.531806-10-dhowells@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Wrong Fixes: tag on a Cc: stable patch.
- [Low] The commit message does not match the change.

Pre-existing issues:
- [High] Lost wakeup in afs cache-manager service calls: if the call
  completes before the afs state reaches AFS_CALL_SV_AWAIT_ACK, it is…
- [High] afs_deliver_cb_callback() rejects any CB.CallBack request whose
  callback array is not empty (count2 == count > 0), because it sets up…
- [Low] The patch rewrites the return-value paragraph of the
  rxrpc_kernel_recv_data() entry in Documentation/networking/rxrpc.rst,…

--

rxrpc: Fix return in rxrpc_recvmsg_data() for service calls

For service calls, rxrpc_kernel_recv_data() now returns 2 instead of 1
once the whole request has been read but the call is still in progress.
A return of 1 now means the call has completed. The afs and rxperf
callers are updated to accept the new value, and rxperf_deliver_to_call()
now collects the final ACK with rxrpc_kernel_recv_data() instead of
rxrpc_kernel_check_life().

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com

> rxrpc: Fix return in rxrpc_recvmsg_data() for service calls

[ ... ]

> rxperf_deliver_to_call() also has to be altered to call
> rxrpc_kernel_recv_data() to collect the final ACK on a service call as does
> afs_deliver_to_call().

[Severity: Low]
This isn't a bug, but the subject says the fix is in rxrpc_recvmsg_data(),
and that function isn't modified. The change is in the exported
rxrpc_kernel_recv_data(). For service calls it gains a new return value
of 2, and 1 now means the call is complete rather than the read phase
being complete.

Could the commit message mention the new return code, the new meaning of
1, and the changes to afs_extract_data() and rxperf_extract_data() that
accept 2?

About the rxperf paragraph: before this patch, the
RXPERF_CALL_SV_AWAIT_ACK branch used rxrpc_kernel_check_life(). That
returns true until the call is complete, so rxperf already waited for the
final ACK there. What rxperf actually needs is for rxperf_extract_data()
to accept ret == 2.

The rewritten AWAIT_ACK branch also changes behaviour.
rxperf_set_call_complete() now gets the real completion error and remote
abort code. Before, it got ret == 0 and remote_abort == 0. Is that
intended, and could the commit message describe it?

> Fixes: d001648ec7cf ("rxrpc: Don't expose skbs to in-kernel users [ver #2]")

[Severity: Medium]
Is d001648ec7cf the right commit for this Fixes tag?

The READ_ALL short-circuit described above was added to
rxrpc_recvmsg_data() by 93368b6bd58a ("rxrpc: Move call state changes
from recvmsg to I/O thread"), which went into v6.3:

	if (test_bit(RXRPC_CALL_RECVMSG_READ_ALL, &call->flags)) {
		seq = lower_32_bits(atomic64_read(&call->ackr_window)) - 1;
		ret = 1;
		goto done;
	}

The same commit also removed the state switch in rxrpc_kernel_recv_data().
That switch returned -EINPROGRESS for service calls that were sending the
reply or waiting for the final ACK:

	default:
		ret = -EINPROGRESS;
		goto out;

d001648ec7cf is the commit that added the -EINPROGRESS check in
afs_deliver_to_call(). That check was correct while the -EINPROGRESS
return still existed.

This patch is marked for stable. If it gets backported to a tree older
than v6.3 because of this Fixes tag, the afs hunk turns:

	if (ret == -EINPROGRESS || ret == -EAGAIN)
		return;

into:

	if (ret == -EAGAIN || ret == 2)
		return;

In those trees, -EINPROGRESS would then take the ret < 0 branch and call
afs_set_call_complete(call, -EINPROGRESS, 0) in AFS_CALL_SV_AWAIT_ACK.
Wouldn't that complete the call early, and with an error?

Should the tag be Fixes: 93368b6bd58a ("rxrpc: Move call state changes
from recvmsg to I/O thread") instead?

> diff --git a/Documentation/networking/rxrpc.rst b/Documentation/networking/rxrpc.rst
> index 9239f7bd88851..eca055a536aa1 100644
> --- a/Documentation/networking/rxrpc.rst
> +++ b/Documentation/networking/rxrpc.rst
> @@ -909,10 +909,15 @@ The kernel interface functions are as follows:
>        want_more should be true if further data will be required after this is
>        satisfied and false if this is the last item of the receive phase.
>  
> -      There are three normal returns: 0 if the buffer was filled and want_more
> -      was true; 1 if the buffer was filled, the last DATA packet has been
> -      emptied and want_more was false; and -EAGAIN if the function needs to be
> -      called again.
> +      For client calls, there are three normal returns: 0 if the buffer was
> +      filled and want_more was true; 1 if the buffer was filled, the last DATA
> +      packet has been emptied and want_more was false; and -EAGAIN if the
> +      function needs to be called again.
> +
> +      For service calls, there are four normal returns: 0 and -EAGAIN are the
> +      same as for client calls; 2 indicates that the last DATA packet of the
> +      request has been received, want_more was false and the call is still in
> +      progress; and 1 indicates that the call is now successfully complete.

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
prototype and parameter text just above this paragraph in the
rxrpc_kernel_recv_data() entry are out of date:

	int rxrpc_kernel_recv_data(struct socket *sock,
				   struct rxrpc_call *call,
				   void *buf,
				   size_t size,
				   size_t *_offset,
	...
      ... the amount copied into the buffer is
      added to *_offset before returning.

The real prototype in include/net/af_rxrpc.h takes struct iov_iter *iter
and size_t *_len, and rxrpc_kernel_recv_data() does:

	*_len -= offset;

So the length is reduced by the amount copied; nothing is added to an
offset. Since this block is being edited anyway, could the prototype and
parameter description be updated as well?

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index 64dd32df8a34e..768b26820deaa 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -541,7 +541,7 @@ void afs_deliver_to_call(struct afs_call *call)
>  						     &call->service_id);
>  			trace_afs_receive_data(call, &call->def_iter, false, ret);
>  
> -			if (ret == -EINPROGRESS || ret == -EAGAIN)
> +			if (ret == -EAGAIN || ret == 2)
>  				return;
>  			if (ret < 0 || ret == 1) {
>  				if (ret == 1)

[Severity: High]
This isn't a bug introduced by this patch, but this AWAIT_ACK branch only
runs if rxrpc sends a notification after the afs state has already
reached AFS_CALL_SV_AWAIT_ACK. Is that ordering guaranteed?

In rxrpc_queue_packet(), the last reply buffer is published before
notify_end_tx is called:

net/rxrpc/sendmsg.c:rxrpc_queue_packet() {
	...
	smp_store_release(&call->send_top, seq);
	if (last) {
		set_bit(RXRPC_CALL_TX_NO_MORE, &call->flags);
		rxrpc_notify_end_tx(rx, call, notify_end_tx);
	...
}

The afs state is only moved forward in afs_notify_end_reply_tx():

	afs_set_call_state(call, AFS_CALL_SV_REPLYING, AFS_CALL_SV_AWAIT_ACK);

No lock covers the gap between the two. The rst text saying notify_end_tx
is called with a spinlock held to stop the last DATA packet being
transmitted looks out of date.

In the meantime the I/O thread can do this:

rxrpc_input_call_event()
  rxrpc_transmit_some_data()
    rxrpc_transmit_fresh_data()
      /* sees send_top, sends the last packet */
      rxrpc_close_tx_phase()      -> SERVER_AWAIT_ACK

Then, when the peer's final ACK arrives:

rxrpc_end_tx_phase()
  rxrpc_call_completed()
    -> single notification to afs_wake_up_async_call()

Suppose the CM work item (for example afs_send_empty_reply() from an
SRXAFSCB_* handler) is preempted between the send_top store and
rxrpc_notify_end_tx(). afs_deliver_to_call() can then run while the state
is still AFS_CALL_SV_REPLYING. That state isn't in the while condition, so
the function falls through to done/out and does nothing, because CM call
types have no ->done.

The sender then sets AFS_CALL_SV_AWAIT_ACK, but no further notification
arrives. The later patch in this series, "rxrpc: Fix generation of
notifications after call completion", suppresses notifications after
completion. So afs_set_call_complete() is never called.

Would this leak the afs_call and the rxrpc_call it pins, and leave
net->nr_outstanding_calls stuck above zero? afs_close_socket() waits on it
with no timeout:

	wait_var_event(&net->nr_outstanding_calls,
		       !atomic_read(&net->nr_outstanding_calls));

That looks like it would hang netns exit or afs module unload. The
problem is still there at the end of the series.

[ ... ]

> @@ -934,7 +934,7 @@ int afs_extract_data(struct afs_call *call, bool want_more)
>  		return ret;
>  
>  	state = READ_ONCE(call->state);
> -	if (ret == 1) {
> +	if (ret == 1 || ret == 2) {
>  		switch (state) {
>  		case AFS_CALL_CL_AWAIT_REPLY:
>  			afs_set_call_state(call, state, AFS_CALL_CL_PROC_REPLY);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
since afs_extract_data() is being changed: can a CB.CallBack request with
a non-empty callback array ever get through afs_deliver_cb_callback()?

In unmarshall case 3, afs_extract_data(call, true) reads the 4-byte count.
rxrpc_kernel_recv_data() then does *_len -= offset, which leaves
call->iov_len at 0. The discard iterator is set up directly, without
updating call->iov_len the way afs_extract_discard() would:

fs/afs/cmservice.c:afs_deliver_cb_callback() {
	...
		call->iter = &call->def_iter;
		iov_iter_discard(&call->def_iter, ITER_DEST, call->count2 * 3 * 4);
		call->unmarshall++;

		fallthrough;
	case 4:
		...
		ret = afs_extract_data(call, false);
	...
}

afs_extract_data() passes &call->iov_len, which is 0, to
rxrpc_kernel_recv_data(). In rxrpc_recvmsg_data(), remain is 0, so
nothing is copied. The callback array is still in the packet, so it
returns 0. With want_more false, rxrpc_kernel_recv_data() then reaches:

	if (!want_more)
		goto excess_data;

and returns -EMSGSIZE. afs_extract_data() completes the call with that
error, and afs_deliver_to_call() aborts with RXGEN_SS_UNMARSHAL.

When count2 == count > 0, doesn't this mean SRXAFSCB_CallBack() is never
queued and afs_break_callbacks() never runs, so the client keeps stale
cached data and metadata?

This looks like it goes back to f105da1a798f ("afs: Don't truncate iter
during data fetch"). That commit added call->iov_len but didn't update
this open-coded iov_iter_discard(). The problem is still there at the end
of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006133011.531806-1-dhowells%40redhat.com
