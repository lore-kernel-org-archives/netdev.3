Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964BA382385;
	Thu,  8 Oct 2026 16:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476006; cv=none; b=BaIUwGkJjX7BDgq2bjwDduNl/m0qjurOMxvGtAGHFvmeOu1y8AYViX3NT4WjOTUxOX3baFLyyCWUEVdnlfTsCYot2Tl/OSjZ21yUdk1AwCNLDikkBRcWRi/vOOLSH9VV98et80JvRQ5MXT0OHreZ01Q1g2tWjjVVfOELokVkd0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476006; c=relaxed/simple;
	bh=hrSIkz7NBDJp42osc28fSCiwfZmrORB0ufzooeouVO8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjOihGJv9QUrn1khL9eKz2KgzPkMGpnC04iipR/jXcK+5f+mp768eLK/ZOrTkF0nuTaqKBMAVf4NIKAOMApJzp6ByqWgl1kvGQs0yET0Xz6EMJY6Uv8DBmOzEwe1yf+q+WYrdEK6HpLj6OjKUJvTl1QfZZUVs/LXyXvmnh7PKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPyvqZvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPyvqZvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7541F000FF;
	Thu,  8 Oct 2026 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791476005;
	bh=djYUaOXxWc8OdTU2UrarcISJqO1bxPSJRiqk5WL9lM4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DPyvqZvDIm2xAVEjMWCDhK9Dt2J+njTjEsF707Z96MFg6kgd8BzcB6XZhAoxq2sWT
	 ag6hBevbMvW5UKm1WeYS9NPfbRsd/qZcxe0EQqJmJ2iVkPgvyqpyMvDvhaHHmgcg9d
	 mSCfmQnvikiZ6uuosgZjyzzYOT7ehdCnKWY+Kij414/2KKlttThB6ndz8ENnv690kP
	 SN2UxgU7oFCM0ArTkGj+Ahw/1wnZz3PjHtunydcjaVeR84+72FlWKcOPMvI4pFG0P2
	 kPcLWQfGDNAU342Ji0d5VxXLmsd/LzNzJUA/rpRk6aLOoXHU5uB6XW6LWhvpN5HAaF
	 xA2gh+IewanMA==
Subject:
 Re: [PATCH net v12 05/15] afs: Fix afs to abort the rxrpc call on send error
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@kernel.org
Date: Thu, 08 Oct 2026 16:13:24 +0000
Message-ID: <179147600427.434549.10415481857508269212@kernel.org>
In-Reply-To: <20261006133011.531806-6-dhowells@redhat.com>
References: <20261006133011.531806-6-dhowells@redhat.com>
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message leaves out the patch's most important
  change.
- [Low] On send failure, afs_send_empty_reply() and
  afs_send_simple_reply() now call afs_set_call_complete(call, ret,…

Pre-existing issues:
- [High] In afs_make_call(), async client calls that use the default
  afs_process_async_call() handler are never completed when the send…

--

afs: Fix afs to abort the rxrpc call on send error

With this patch, afs_send_empty_reply() and afs_send_simple_reply() abort
the rxrpc call on any send error, not only on -ENOMEM, and also mark the
afs_call complete. afs_make_call() now aborts unconditionally on send
error. The afs_abort_oom trace reason is replaced by afs_abort_send_error.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index bcb8bb15d471d..64dd32df8a34e 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -441,10 +441,8 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>  	return;
>  
>  error_do_abort:
> -	if (ret != -ECONNABORTED)
> -		rxrpc_kernel_abort_call(call->net->socket, rxcall,
> -					RX_USER_ABORT, ret,
> -					afs_abort_send_data_error);
> +	rxrpc_kernel_abort_call(call->net->socket, rxcall,
> +				RX_USER_ABORT, ret, afs_abort_send_data_error);
>  	if (call->async) {
>  		afs_see_call(call, afs_call_trace_async_abort);
>  		return;

[Severity: High]
This isn't a bug introduced by this patch, but the async branch here
returns without completing the call. Can this leak the afs_call for async
client calls that use afs_process_async_call()? Examples are
afs_fs_get_capabilities() and the VL.GetCapabilities call in vlclient.c.

Suppose rxrpc_kernel_send_data() fails before the last packet is queued,
for example with -ENOMEM from alloc_txbuf() in rxrpc_send_data(). Then
afs_notify_end_request_tx() never runs, call->state stays at
AFS_CALL_CL_REQUESTING, and call->error is left at 0.

The abort notification then queues afs_process_async_call(). However,
afs_deliver_to_call() has no case for that state:

	while (state = READ_ONCE(call->state),
	       state == AFS_CALL_CL_AWAIT_REPLY ||
	       state == AFS_CALL_SV_AWAIT_OP_ID ||
	       state == AFS_CALL_SV_AWAIT_REQUEST ||
	       state == AFS_CALL_SV_AWAIT_ACK
	       ) {

So it jumps straight to done: and calls type->done(), which is
afs_fileserver_probe_result() or afs_vlserver_probe_result(), with
call->error == 0. The failed probe is then handled by the success branch.

Nothing moves the call to AFS_CALL_COMPLETE, so the drop_ref reference
taken earlier in afs_make_call() is never released:

	if (call->async) {
		afs_get_call(call, afs_call_trace_get);
		call->drop_ref = true;
	}

Wouldn't that leak the afs_call along with its rxrpc call, peer, server,
estate and key references? It would also keep net->nr_outstanding_calls
non-zero, so afs_close_socket() would wait forever in wait_var_event().

This patch adds afs_set_call_complete() for the same pattern in
afs_send_empty_reply() and afs_send_simple_reply(). Would something
similar be needed here?

Async FetchData does not look affected, because afs_read_receive() checks
rxrpc_kernel_check_life() and completes the call itself. The early return
came from commit 9750be93b2be ("afs: Fix cleanup of immediately failed
async calls").

[ ... ]

> @@ -869,21 +868,13 @@ void afs_send_empty_reply(struct afs_call *call)
>  	msg.msg_controllen	= 0;
>  	msg.msg_flags		= 0;
>  
> -	switch (rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
> -				       afs_notify_end_reply_tx)) {
> -	case 0:
> -		_leave(" [replied]");
> -		return;
> -
> -	case -ENOMEM:
> -		_debug("oom");
> +	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
> +				     afs_notify_end_reply_tx);
> +	if (ret < 0) {
>  		rxrpc_kernel_abort_call(net->socket, call->rxcall,
> -					RXGEN_SS_MARSHAL, -ENOMEM,
> -					afs_abort_oom);
> -		fallthrough;
> -	default:
> -		_leave(" [error]");
> -		return;
> +					RXGEN_SS_MARSHAL, ret,
> +					afs_abort_send_error);
> +		afs_set_call_complete(call, ret, RXGEN_SS_MARSHAL);

[Severity: Medium]
The commit message says:

  Fix afs_send_empty_reply() and afs_send_simple_reply() to always try to
  abort the rxrpc call rather than just aborting on -ENOMEM and otherwise
  abandoning it.

It doesn't mention the new afs_set_call_complete() calls here and in
afs_send_simple_reply(). Should the commit message describe them?

afs_charge_preallocation() sets call->drop_ref for incoming cache manager
calls, so this call releases the call's self reference.

Before the patch, a failed reply left the call in AFS_CALL_SV_REPLYING.
afs_deliver_to_call() has no case for that state, so the drop_ref
reference was never put and net->nr_outstanding_calls never drained.

Completing the call is therefore what fixes the leak. A stable backport
could leave it out if the commit message only covers the abort.

>  	}
>  }
>  

[ ... ]

> @@ -913,12 +904,10 @@ void afs_send_simple_reply(struct afs_call *call, const void *buf, size_t len)
>  	ret = rxrpc_kernel_send_data(net->socket, call->rxcall, &msg,
>  				     afs_notify_end_reply_tx);
>  	if (ret < 0) {
> -		if (ret == -ENOMEM) {
> -			_debug("oom");
> -			rxrpc_kernel_abort_call(net->socket, call->rxcall,
> -						RXGEN_SS_MARSHAL, -ENOMEM,
> -						afs_abort_oom);
> -		}
> +		rxrpc_kernel_abort_call(net->socket, call->rxcall,
> +					RXGEN_SS_MARSHAL, ret,
> +					afs_abort_send_error);
> +		afs_set_call_complete(call, ret, RXGEN_SS_MARSHAL);

[Severity: Low]
Is RXGEN_SS_MARSHAL the right value for the third argument of
afs_set_call_complete()? That parameter is remote_abort. It is stored in
call->abort_code, which is documented as:

	u32			abort_code;	/* Remote abort ID or 0 */

Other places that complete a call after a local abort pass 0. One example
is afs_abort_service_call() in fs/afs/cmservice.c:

	rxrpc_kernel_abort_call(call->net->socket, call->rxcall,
				abort_code, error, why);
	afs_set_call_complete(call, error, 0);

The local_abort path in afs_deliver_to_call() and the -EINTR path in
afs_wait_for_call_to_complete() do the same.

The send may fail because the peer already aborted the call or because of
a network error, such as -ECONNABORTED. In that case the rxrpc call is
already complete and rxrpc_kernel_abort_call() does nothing. RXGEN_SS_MARSHAL
would still be recorded as the remote abort code, although no such abort
was sent.

The last packet may also have been queued already (AFS_CALL_SV_AWAIT_ACK).
If this path then takes state_lock before afs_deliver_to_call(), it would
also overwrite the real remote abort code.

For service calls, this value seems to appear only in the afs_call_state
and afs_call_done tracepoints. The same question applies to the new call
in afs_send_empty_reply().

>  		_leave(" [error]");
>  	}
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006133011.531806-1-dhowells%40redhat.com
