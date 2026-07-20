Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B563B0AED;
	Mon, 20 Jul 2026 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559212; cv=none; b=BYl82b824PfvCfi4ck21DuDzneG1Evpt8bsH6J6m6exc8OUobc3cUsMafTIQ/4r9j4RsS3onse4w4rzGcRot8dJVgKuMrJlxwTtl6TivVBZI7HzsUVCu4PXaMh4PoglkOe712i4xf0BLGR53mrZxeStz0V6XXJWsvOb049A9G/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559212; c=relaxed/simple;
	bh=WeMf0JHovGDTVgzWFWwlri9FTJpUBPD0bg7X3DGpmJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGMHU+FSC60X5yMhI5cBQOYDSIWg3umaxNJBh/LbUn5kqdEMLyCeN5NdRaSEU3qruZ8LvQPVWywOfByCH15QX8C12reZeFa5nU5UY1Fo21Hs3UFobIcFjUbHj4SmazlK0Dr37Ug6GOek0l+4Cm0qAFwm/Bi+kGbeS1HfoLS3Y0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N01ECOsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N01ECOsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAB11F000E9;
	Mon, 20 Jul 2026 14:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559210;
	bh=jEeGLA26Ei5GPIIdD++7YIfrWZXzkgydX2oLjqQPJLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N01ECOsWqv3C9gtm/J3d5s771GL2TFMImHLqkTjuaF+hknXoyoaWdufi7dSwZRgaT
	 A6J57lSxFJ8OZfKlLQdwHTOHI6QKXikCMusZu/Nmqf5vORCuQXbCzr7YYcZ1pweh65
	 H/0Wp/lv0eX/JpAY7OExjybRG4INlKKUjoJkhev4K+BRG222NKPJCS/GsiVOKaC73c
	 wHYCrGFZdWWq8Vr9O5AUXEynj4eUhp8hsJaUuBYQxBg3wKib2fdcRsc2KEnQ9dh5zc
	 5QQ36KOE76AgwAucIhGJsTsAa4SU3/V+7Sb73+CUvcvlwCRD0esJuDl/wW81bzgQdK
	 N03jNAc5DOPwA==
From: Simon Horman <horms@kernel.org>
To: dhowells@redhat.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	marc.dionne@auristor.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH net v3 07/14] afs: Simplify call refcounting
Date: Mon, 20 Jul 2026 15:52:56 +0100
Message-ID: <20260720145255.192194-2-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713081022.2186481-8-dhowells@redhat.com>
References: <20260713081022.2186481-8-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260713081022.2186481-8-dhowells@redhat.com?part=7
---
--- Patch [7]: [PATCH net v3 07/14] afs: Simplify call refcounting ---
commit 467b175328043584d311b0ca542f46ebdef122fe
Author: David Howells <dhowells@redhat.com>

afs: Simplify call refcounting

This commit simplifies afs_call refcounting by removing the ref held by queued
async work items and dropping the retaining ref upon async call completion
instead. It also dispatches cache manager server RPC handlers directly from
afs_deliver_to_call() and changes call->work to a function pointer.

> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index 06c711c75f556..a404b6f0cc7c2 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
[ ... ]
> @@ -479,8 +445,7 @@ void afs_make_call(struct afs_call *call, gfp_t gfp)
>  	if (call->rxcall)
>  		rxrpc_kernel_shutdown_call(call->net->socket, call->rxcall);
>  	if (call->async) {
> -		if (cancel_work_sync(&call->async_work))
> -			afs_put_call(call);
> +		cancel_work_sync(&call->async_work);
>  		afs_set_call_complete(call, ret, 0);
>  	}

[Severity: Medium]
Can this leak the struct afs_call object?

When rxrpc_kernel_begin_call() fails, the code jumps to error_kill_call and
cancels the async work here. Since afs_set_call_complete() no longer drops
call->drop_ref, and the async work function is cancelled (so it never runs to
drop the retaining ref), it seems the retaining ref acquired via afs_get_call()
earlier in afs_make_call() is never released on this error path.

[ ... ]
> @@ -704,19 +671,16 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
>  				   unsigned long call_user_ID)
>  {
>  	struct afs_call *call = (struct afs_call *)call_user_ID;
> -	int r;
>  
>  	trace_afs_notify_call(rxcall, call);
>  	call->need_attention = true;
>  
> -	if (__refcount_inc_not_zero(&call->ref, &r)) {
> -		trace_afs_call(call->debug_id, afs_call_trace_wake, r + 1,
> -			       atomic_read(&call->net->nr_outstanding_calls),
> -			       __builtin_return_address(0));
> +	trace_afs_call(call->debug_id, afs_call_trace_wake,
> +		       refcount_read(&call->ref),
> +		       atomic_read(&call->net->nr_outstanding_calls),
> +		       __builtin_return_address(0));
>  
> -		if (!queue_work(afs_async_calls, &call->async_work))
> -			afs_deferred_put_call(call);
> -	}
> +	queue_work(afs_async_calls, &call->async_work);
>  }

[Severity: Critical]
Can this result in a use-after-free and workqueue corruption if an RxRPC
notification arrives right as the call completes?

afs_process_async_call() drops the final retaining reference and synchronously
frees the afs_call object when call->state == AFS_CALL_COMPLETE. If
afs_wake_up_async_call() is executed concurrently by the RxRPC thread before
rxrpc_kernel_shutdown_call() unhooks the callback, it will now blindly modify
call->need_attention and call queue_work() on a freed &call->async_work without
first acquiring a reference.

> diff --git a/fs/afs/file.c b/fs/afs/file.c
> index 0467742bfeee3..35d68f7f498df 100644
> --- a/fs/afs/file.c
> +++ b/fs/afs/file.c
[ ... ]
> @@ -316,15 +316,17 @@ void afs_fetch_data_async_rx(struct work_struct *work)
>  	struct afs_call *call = container_of(work, struct afs_call, async_work);
>  
>  	afs_read_receive(call);
> -	afs_put_call(call);
> +
> +	if (call->state == AFS_CALL_COMPLETE) {
> +		cancel_work(&call->async_work);
> +		afs_put_call(call);
> +	}
>  }
>  
>  void afs_fetch_data_immediate_cancel(struct afs_call *call)
>  {
>  	if (call->async) {
> -		afs_get_call(call, afs_call_trace_wake);
> -		if (!queue_work(afs_async_calls, &call->async_work))
> -			afs_deferred_put_call(call);
> +		queue_work(afs_async_calls, &call->async_work);
>  		flush_work(&call->async_work);
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but does flushing the async work here cause a
NULL pointer dereference?

If afs_make_call() fails early (e.g. rxrpc_kernel_begin_call() fails),
call->rxcall is NULL. The error path calls call->type->immediate_cancel(call),
which resolves to afs_fetch_data_immediate_cancel(). This queues and
synchronously flushes the work.

afs_read_receive() is then executed while call->state is still less than
AFS_CALL_COMPLETE. This calls rxrpc_kernel_check_life() and passes it
call->rxcall:

fs/afs/file.c:afs_read_receive() {
	...
	if (state < AFS_CALL_COMPLETE) {
		netfs_read_subreq_progress(op->fetch.subreq);
		if (rxrpc_kernel_check_life(call->net->socket, call->rxcall))
			return;
	...
}

Because call->rxcall is NULL, wouldn't rxrpc_kernel_check_life()
unconditionally dereference it when calling rxrpc_call_is_complete(), causing
an immediate kernel panic?
