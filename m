Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C594AA402;
	Tue, 15 Sep 2026 22:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513060; cv=none; b=ZSERQNYf2etFh7pxwPMC3WSY9f/gA7fngwwpXux45I14NhrImeauAEmA1kg6XZuUQ6DiBkrVZb/pF2RJOABa6n95Bc1FaZRMvZ+2kJgRenKyzIIqbk7Pxf7ga49a0JGBqsMZdI+L1b9/QRwK5FYnvAzHsugCZ0FN8V3SIJgyHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513060; c=relaxed/simple;
	bh=NebeNjGPmONBULKXK5pMgSeP5mLluqTNg+XgOqPfYLY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJ9CW2kYBPB4GzLzepbWe5ApmcxKCv3GN3qtSm2Iu2EMm5Q7DmtYjq5Aneb6Sa46GtU49cQZSGxHzQpFl4y/4GCIld6lgw0JFsuMTu/PT2/57HBG27Pa/ZGNE4MboQoD6678I+isms0Ru5Uc3yyGBayKjDYpp6whQHwcybHUc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXck/zpO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lXck/zpO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AF41F00893;
	Tue, 15 Sep 2026 22:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513058;
	bh=L8G+SKV7jen7rULVBJdriltigZZu5qgSRUMrWlt/sk8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lXck/zpORmWSczpFBRFqli5IXEhhQ/QQ/BSJmIKOcGDgQdxhqKBrpVoys2w1hMRNH
	 Xtxg773OWq2bnobjaS3q86O3FjgVbCEV0UcpXKt9e8wX756OQY4J+9lopeonxSs/IO
	 gcc6aO4/2LZdUFxxrJJejC29MgPekDlVTZHPzYmmNKupPKkyUPilv8kvHjCcZL/qgF
	 4SIuURgBbgSDpX4tlKgUfWxUZprftfIZ2+l+aj//+gvnjk5Z7HINEgFvDpjwDLb9jc
	 1IleSc72MZ2QkM5O4RPSQrC515l7Wf6Vb8d1jZ4EJCE2j3PLx1pMrKlWjUp78Ur9ZM
	 s9K3SjVzBVMgQ==
Subject: Re: [PATCH net v10 03/14] rxrpc: Fix aborting in rxperf test server
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 22:57:37 +0000
Message-ID: <178951305756.22033.4393555534770367709@kernel.org>
In-Reply-To: <20260914151340.3227501-4-dhowells@redhat.com>
References: <20260914151340.3227501-4-dhowells@redhat.com>
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

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

- [High] Stale `dropped_lock` flag across the new retry loop in
  rxrpc_kernel_send_data() (net/rxrpc/sendmsg.c:809-838 at this commit)…
- [Medium] Incomplete fix in rxperf_process_call() (net/rxrpc/rxperf.c):
  the commit message states the function will "always abort if it gets a…

Pre-existing issues:
- [Medium] rxrpc_send_data()'s `out:` label executes `call->tx_pending =
  txb;` even on the path where it has already released call->user_mutex…

--

rxrpc: Fix aborting in rxperf test server

This changes rxperf_process_call() so that the trailing magic-cookie send
aborts the call on any negative return from rxrpc_kernel_send_data() rather
than only on -ENOMEM, and renames the trace reason rxperf_abort_oom to
rxperf_abort_send_error.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

[ ... ]

> diff --git a/net/rxrpc/rxperf.c b/net/rxrpc/rxperf.c
> index dad04062213f5..7e9a536153098 100644
> --- a/net/rxrpc/rxperf.c
> +++ b/net/rxrpc/rxperf.c
> @@ -538,10 +538,10 @@ static int rxperf_process_call(struct rxperf_call *call)
>  	msg.msg_flags = 0;
>  	n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
>  				   rxperf_notify_end_reply_tx);
> -	if (n == -ENOMEM)
> +	if (n < 0)

[Severity: Medium]
The commit message says rxperf_process_call() will "always abort if it gets
a send error", but only the trailing magic-cookie send is converted here.
Is the bulk-reply loop earlier in the same function meant to be left alone?

net/rxrpc/rxperf.c:rxperf_process_call() {
	while (reply_len > 0) {
		...
		n = rxrpc_kernel_send_data(rxperf_socket, call->rxcall, &msg,
					   rxperf_notify_end_reply_tx);
		if (n < 0)
			return n;
		reply_len -= len;
	}
}

That path propagates the error to rxperf_deliver_to_call(), which
reclassifies it rather than using RXGEN_SS_MARSHAL/rxperf_abort_send_error:

	case -ENODATA:
	case -EBADMSG:
	case -EMSGSIZE:
	case -ENOMEM:
	case -EFAULT:
		rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
					RXGEN_SS_UNMARSHAL, ret,
					rxperf_abort_unmarshal_error);

anything else negative lands in the default arm as
RX_CALL_DEAD/rxperf_abort_general_error, and these two return without any
abort at all:

	case -EINPROGRESS:
	case -EAGAIN:
		return;

So a send failure in the loop can leave the call sitting in
RXPERF_CALL_SV_REPLYING waiting for another notification, and the two send
sites for the same reply report different abort codes and trace reasons for
the same failure.  Would it be cleaner to route both sends through a shared
send_error label?  For what it is worth, the later series patch "rxrpc: Fix
error handling in rxrpc_send_data()" does exactly that, so the divergence
only exists in this intermediate commit.

>  		rxrpc_kernel_abort_call(rxperf_socket, call->rxcall,
> -					RXGEN_SS_MARSHAL, -ENOMEM,
> -					rxperf_abort_oom);
> +					RXGEN_SS_MARSHAL, n,
> +					rxperf_abort_send_error);

[Severity: High]
Aborting on every negative return makes this call site reachable in cases
where rxrpc_kernel_send_data() may return with call->user_mutex still held,
and rxrpc_kernel_abort_call() takes that same mutex.  Can this self-deadlock?

The retry loop added earlier in the series declares the flag once, outside
the loop:

net/rxrpc/sendmsg.c:rxrpc_kernel_send_data() {
	bool dropped_lock = false;
	...
	for (;;) {
		mutex_lock(&call->user_mutex);
		ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg,
				      msg_data_left(msg),
				      notify_end_tx, &dropped_lock);
		...
		if (!dropped_lock)
			mutex_unlock(&call->user_mutex);
		if (ret < 0)
			break;
		if (msg_data_left(msg) == 0) {
			ret = 0;
			break;
		}
		...
	}
}

rxrpc_send_data() sets the flag after dropping the mutex and only clears it
once it has retaken it:

wait_for_space:
	ret = -EAGAIN;
	if (msg->msg_flags & MSG_DONTWAIT)
		goto maybe_error;
	mutex_unlock(&call->user_mutex);
	*_dropped_lock = true;
	ret = rxrpc_wait_for_tx_window(rx, call, &timeo,
				       msg->msg_flags & MSG_WAITALL);
	if (ret < 0)
		goto maybe_error;
	if (call->interruptibility == RXRPC_INTERRUPTIBLE) {
		if (mutex_lock_interruptible(&call->user_mutex) < 0) {
			ret = sock_intr_errno(timeo);
			goto maybe_error;
		}
	}
	...
	*_dropped_lock = false;

For an interruptible call, a signal makes rxrpc_wait_for_tx_window() or
mutex_lock_interruptible() fail, and maybe_error falls through to success
with copied > 0, so a positive short-send count is returned with the flag
left true.  The loop then relocks and calls rxrpc_send_data() again with
dropped_lock still true, so on the next pass either mutex_lock() is called
on an already-owned mutex, or the "msg_data_left(msg) == 0" break returns to
rxperf with call->user_mutex still held and the abort above blocks forever.

Should dropped_lock be reset at the top of each iteration?  The later series
patch "rxrpc: Fix update of call->tx_pending without holding lock" removes
the _dropped_lock parameter entirely and has rxrpc_send_data() always
unlock, which also resolves this.

[Severity: Medium]
This isn't a bug introduced by this patch, but the same wait_for_space path
in rxrpc_send_data() also publishes call->tx_pending with the mutex already
dropped:

success:
	ret = copied;
	if (rxrpc_call_is_complete(call) &&
	    call->error < 0)
		ret = call->error;
out:
	call->tx_pending = txb;

Every other access to call->tx_pending is serialised by call->user_mutex, so
if a second sendmsg() on the same user_call_ID acquired the mutex in the
meantime and stored its own partially filled txbuf, does this unlocked store
overwrite it and leak that txbuf, or reintroduce a stale buffer into the
transmit stream?  The new retry loop turns this unlocked store into a
routine resumable step rather than a terminal bail-out.  It is fixed later in
the series by "rxrpc: Fix update of call->tx_pending without holding lock",
which keeps the tx_pending updates inside the mutex-held region.

>  	return n;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
