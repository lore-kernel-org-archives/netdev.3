Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9AB44E66B;
	Tue, 15 Sep 2026 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513059; cv=none; b=H9ONEZou2CPVNJ9Jnz8BF03v+BIaktE105qwGTJJLw9l+Q16CAwH6qGcfjY1nAjtzfnW+ofGPYhpaD0NsVzMgDB1w+A9ID765MzvHYKPVUlV2VNoiDv3dwfNDD+FOyjsUfYvdD4/bMBvQ7QmFmQXFnF007ogtGkggjGrKLsVt5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513059; c=relaxed/simple;
	bh=m5TKUD/72Bz1YpkFRwPW/oyNV/NKe+F5de04AFK84Zw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZvG6gRje9TeGusVoEw9PdTgF3RW/nvrzijZUjAyW72HDlnRonR1Ecso3YxzNEp2duqFyhKMgbGIEHfxY9aLrLeWylVaj+jhoAkrkvWsYul6VgfAmQuK5r5v07dkYxcYst6tz3EyG84667s0GC2l/wvjMSyLrolWge2outwYvN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abEqWO2X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abEqWO2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB4D1F000FF;
	Tue, 15 Sep 2026 22:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513057;
	bh=kJHoKNIxjyFTbxfMAC5glAbEm+M3DYVyUzlY00192L4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=abEqWO2X0tDx1dFzBJIB+L3zcmRpYcW53CHybD5yu+ccrROcFgLOdsgGYmn1Xrco0
	 J8S731qFww5DcpTdWCct4IQxQhUrWEG9gdI8NZMRN5XhOcayI/t7fllaYEsAXZ/872
	 z/WpSESTGmvJ85D8b8MOz1YniDfX1G2h60oqyS8FciDr/DfnABjpeXXg8xZAhuOVTu
	 QablmVRcWpNB9coNk48QCTei/P8r6F7PqRYj3Xi7e1YZIbnMT8Lr+UxfRqixrY84bf
	 On/W8xGyfFZ5R88mRnzfTtIMSFRYj94yjsp/0j5IKG6+p5gPzozWBGvaXrZW2EgjcM
	 KUH5T1tN7nTgw==
Subject: Re: [PATCH net v10 01/14] rxrpc: Fix lack of short-send handling in
 rxrpc_kernel_send_data()
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 22:57:36 +0000
Message-ID: <178951305637.22033.12781717417913872095@kernel.org>
In-Reply-To: <20260914151340.3227501-2-dhowells@redhat.com>
References: <20260914151340.3227501-2-dhowells@redhat.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The new retry loop in rxrpc_kernel_send_data()
  (net/rxrpc/sendmsg.c:817-838) re-acquires call->user_mutex…

--

rxrpc: Fix lack of short-send handling in rxrpc_kernel_send_data()

rxrpc_kernel_send_data() now loops internally when rxrpc_send_data()
reports a short send, the len argument is dropped in favour of the
iterator count, and the function returns 0 rather than the number of
bytes copied.  The AFS and rxperf callers are updated accordingly.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
> index ed2c9a51005ad..34aae8e789a43 100644
> --- a/net/rxrpc/sendmsg.c
> +++ b/net/rxrpc/sendmsg.c

[ ... ]

> @@ -805,8 +804,7 @@ int rxrpc_do_sendmsg(struct rxrpc_sock *rx, struct msghdr *msg, size_t len)
>   * Return: %0 if successful and a negative error code otherwise.
>   */
>  int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
> -			   struct msghdr *msg, size_t len,
> -			   rxrpc_notify_end_tx_t notify_end_tx)
> +			   struct msghdr *msg, rxrpc_notify_end_tx_t notify_end_tx)
>  {
>  	bool dropped_lock = false;
       ^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Should dropped_lock be reset inside the new loop rather than being
initialised once here?

rxrpc_send_data() only ever writes to this flag in its wait_for_space
path, and never initialises it on entry:

net/rxrpc/sendmsg.c:rxrpc_send_data() {
	...
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
	...
	*_dropped_lock = false;
	goto reload;
}

and maybe_error can return a positive short count with the flag still
set:

maybe_error:
	if (copied)
		goto success;
	goto out;
...
success:
	ret = copied;

>  	int ret;
> @@ -816,15 +814,29 @@ int rxrpc_kernel_send_data(struct socket *sock, struct rxrpc_call *call,
>  	ASSERTCMP(msg->msg_name, ==, NULL);
>  	ASSERTCMP(msg->msg_control, ==, NULL);
>  
> -	mutex_lock(&call->user_mutex);
> +	for (;;) {
> +		mutex_lock(&call->user_mutex);
>  
> -	ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg, len,
> -			      notify_end_tx, &dropped_lock);
> -	if (ret == -ESHUTDOWN)
> -		ret = call->error;
> +		ret = rxrpc_send_data(rxrpc_sk(sock->sk), call, msg,
> +				      msg_data_left(msg),
> +				      notify_end_tx, &dropped_lock);
> +		if (ret == -ESHUTDOWN)
> +			ret = call->error;
> +
> +		if (!dropped_lock)
> +			mutex_unlock(&call->user_mutex);
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Can call->user_mutex be returned still held here?  The mutex_lock() at
the top of the loop is unconditional on every iteration, but the unlock
is gated on a flag that is only cleared by rxrpc_send_data() when it
re-acquires the lock after waiting.  So the sequence looks like:

  iteration 1: rxrpc_send_data() takes wait_for_space, unlocks,
               dropped_lock = true, the relock fails, maybe_error sees
               copied > 0 and returns a positive count
  loop:        msg_data_left(msg) != 0 and ret > 0, so we go round again
  iteration 2: mutex_lock() succeeds, this send never reaches
               wait_for_space, dropped_lock is still true, so
               mutex_unlock() is skipped and we break out of the loop

The kernel callers then take the same mutex again on the following
statement, e.g. rxrpc_kernel_abort_call() does mutex_lock(&call->user_mutex)
on the AFS and rxperf error paths, and afs_make_call() issues a second
rxrpc_kernel_send_data() for call->write_iter, so the task would block on
a mutex it already owns.

Reachability of the seeding iteration looks narrow: for the
RXRPC_UNINTERRUPTIBLE and RXRPC_PREINTERRUPTIBLE calls used by the AFS
client sends, the non-interruptible waiter only returns negative when the
call is complete with call->error < 0, and success: then overwrites ret
with that negative error.  It appears to need an RXRPC_INTERRUPTIBLE call
whose task has a pending signal, which I could not demonstrate for the
in-tree kernel senders running on workqueue workers.

For what it's worth, the later patch "rxrpc: Fix update of call->tx_pending
without holding lock" removes the dropped_lock out-parameter entirely and
moves the unlock inside rxrpc_send_data() with an __releases() annotation,
so the flag no longer exists at the end of the series.  Would it be worth
reordering so that this patch does not introduce the intermediate state,
or clearing dropped_lock at the top of each iteration here?

> +		if (ret < 0)
> +			break;
> +		if (msg_data_left(msg) == 0) {
> +			ret = 0;
> +			break;
> +		}
> +		if (ret == 0) {
> +			ret = -EIO;
> +			break;
> +		}
> +	}
>  
> -	if (!dropped_lock)
> -		mutex_unlock(&call->user_mutex);
>  	_leave(" = %d", ret);
>  	return ret;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
