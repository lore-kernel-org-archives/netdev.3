Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B94BD7A8;
	Tue, 15 Sep 2026 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513067; cv=none; b=ptpO5ojLogG0b/gA00pJYQWcjIeRRGIEcZLPn53OAtSidtZ8TtEjV70YOAEge52ds1J7IZ+iC5V5FYyhYvEuifcduyhCro7MtbkJt855gYL7UbaeJtH2a+GW4wr44UnZVXcH17QNfMoixNjavczLIyLG8Di5832xqq4hYRwIBAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513067; c=relaxed/simple;
	bh=eiLJHJUpHDNsyvfYWF635kM1t5fIgWpFmztseQQGrm0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LXMcBw7gT55TclJYhzMLs0l7QWlVlSsnJ+rgjLe1oAfqmPJpgf1MS62gDKKfqqM07VZZZ6CDyHt/PDg/2D7uCQ42Vj1ypSjDnldJksE+2Elph6yoGuexXchlVY6PhRhO3OPsNyJpZ0iStb07DBegpRTTHISp2heLB3DiF/WYTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtOSNRSX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtOSNRSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB1561F00898;
	Tue, 15 Sep 2026 22:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789513063;
	bh=a/6cwh2cspRrRFf8wyVmMORT5BamXKXoug79Q0AFHXk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MtOSNRSXAOHJjIkMoWknarGD6xdxkKoh1FqLSGo42kE9frRqhSuuJfktkiWHLFYcJ
	 fhMcwPW2DlT86ZfaWayXdsAwfQNzuetE/6VigXoEvbt7mV/nT+BQ3gvMBv0GkOMZ62
	 UxAt33sUj1FdCh0PcHWkO6TMOU0es1J/p6U0tWzLDuIqEf8Llj3CFeuu5SGFIfjzLC
	 PppgIRsVInIbAJrcgwh9Xtp2BzPMQh9vfWx3768OjSZhxUCMxy5HhTU5ok+GV07gcx
	 fGREcop1TYHI+ti+OaQMktcasLFsOHM7FwI9wzIoejXoFIspfYpMasZU4WOIigarZL
	 NOeKt/TabuNmg==
Subject: Re: [PATCH net v10 09/14] rxrpc: Fix generation of notifications
 after call completion
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 22:57:42 +0000
Message-ID: <178951306222.22033.8453547695665314169@kernel.org>
In-Reply-To: <20260914151340.3227501-10-dhowells@redhat.com>
References: <20260914151340.3227501-10-dhowells@redhat.com>
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

- [Medium] Undisclosed behaviour change: the new helper
  rxrpc_requeue_call() (net/rxrpc/recvmsg.c:24) drops the `sk->sk_state…

--

rxrpc: Fix generation of notifications after call completion

This splits rxrpc_notify_socket() into __rxrpc_notify_socket() in
call_state.c plus a wrapper that skips notification for completed calls,
and adds a lighter rxrpc_requeue_call() helper used by rxrpc_recvmsg() to
put a call back on rx->recvmsg_q without generating a notification.

> diff --git a/net/rxrpc/call_state.c b/net/rxrpc/call_state.c
> index 6afb54373ebbf..52465e88a0440 100644
> --- a/net/rxrpc/call_state.c
> +++ b/net/rxrpc/call_state.c
> @@ -7,6 +7,61 @@
>  
>  #include "ar-internal.h"
>  
> +/*
> + * Post a call for attention by the socket or kernel service.
> + */
> +static void __rxrpc_notify_socket(struct rxrpc_call *call)
> +{

[ ... ]

> +	rx = rcu_dereference(call->socket);
> +	sk = &rx->sk;
> +	if (rx && sk->sk_state < RXRPC_CLOSE) {

[ ... ]

> diff --git a/net/rxrpc/recvmsg.c b/net/rxrpc/recvmsg.c
> index 56fa324d0962e..22afc71ea474f 100644
> --- a/net/rxrpc/recvmsg.c
> +++ b/net/rxrpc/recvmsg.c
> @@ -17,14 +17,14 @@
>  #include "ar-internal.h"
>  
>  /*
> - * Post a call for attention by the socket or kernel service.  Further
> - * notifications are suppressed by putting recvmsg_link on a dummy queue.
> + * Requeue a call for recvmsg() to pick up.  We ignore RXRPC_CLOSE, allowing
> + * recvmsg() to continue picking up calls that are already on the queue if it
> + * wants to, but no new calls will get added.
>   */
> -void rxrpc_notify_socket(struct rxrpc_call *call)
> +static void rxrpc_requeue_call(struct socket *sock, struct rxrpc_call *call)
>  {
> -	struct rxrpc_sock *rx;
> -	struct sock *sk;
> -	unsigned long flags;
> +	struct rxrpc_sock *rx = rxrpc_sk(sock->sk);
> +	struct sock *sk = &rx->sk;
>  
>  	_enter("%d", call->debug_id);
>  
> @@ -33,31 +33,18 @@ void rxrpc_notify_socket(struct rxrpc_call *call)
>  		return;
>  	}
>  
> -	rcu_read_lock();
> -
> -	rx = rcu_dereference(call->socket);
> -	sk = &rx->sk;
> -	if (rx && sk->sk_state < RXRPC_CLOSE) {
> -		if (call->notify_rx) {
> -			spin_lock_irqsave(&call->notify_lock, flags);
> -			call->notify_rx(sk, call, call->user_call_ID);
> -			spin_unlock_irqrestore(&call->notify_lock, flags);
> -		} else {
> -			spin_lock_irqsave(&rx->recvmsg_lock, flags);
> -			if (list_empty(&call->recvmsg_link)) {
> -				rxrpc_get_call(call, rxrpc_call_get_notify_socket);
> -				list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
> -			}
> -			spin_unlock_irqrestore(&rx->recvmsg_lock, flags);
> +	spin_lock_irq(&rx->recvmsg_lock);
> +	if (list_empty(&call->recvmsg_link)) {
> +		rxrpc_get_call(call, rxrpc_call_get_notify_socket);
> +		list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
> +	}
> +	spin_unlock_irq(&rx->recvmsg_lock);
>  
> -			if (!sock_flag(sk, SOCK_DEAD)) {
> -				_debug("call %ps", sk->sk_data_ready);
> -				sk->sk_data_ready(sk);
> -			}
> -		}
> +	if (!sock_flag(sk, SOCK_DEAD)) {
> +		_debug("call %ps", sk->sk_data_ready);
> +		sk->sk_data_ready(sk);
>  	}
>  
> -	rcu_read_unlock();
>  	_leave("");
>  }

[Severity: Medium]
Should the changelog mention that this changes behaviour for sockets that
have already been shut down?

The code being replaced only queued the call and rang sk_data_ready() when
the socket was still open:

	rx = rcu_dereference(call->socket);
	sk = &rx->sk;
	if (rx && sk->sk_state < RXRPC_CLOSE) {
		...
			list_add_tail(&call->recvmsg_link, &rx->recvmsg_q);
		...
			sk->sk_data_ready(sk);

rxrpc_requeue_call() has no sk_state test, while the extracted
__rxrpc_notify_socket() in call_state.c keeps it, so the two paths now
differ.

The gate looks deliberate, since rxrpc_shutdown() in af_rxrpc.c sets the
state under the same lock that guards recvmsg_q:

	if (sk->sk_state < RXRPC_CLOSE) {
		spin_lock_irq(&rx->recvmsg_lock);
		sk->sk_state = RXRPC_CLOSE;
		sk->sk_shutdown = SHUTDOWN_MASK;
		spin_unlock_irq(&rx->recvmsg_lock);

So after shutdown(fd, SHUT_RDWR) followed by further recvmsg() calls, a
partially-read call with data still in call->recvmsg_queue is now re-added
to rx->recvmsg_q with a rxrpc_call_get_notify_socket ref and sk_data_ready()
is called on the closing socket, where before the requeue was dropped and
the buffered data was never delivered.  The extra ref does appear to be
accounted for by rxrpc_release_calls_on_socket() draining rx->recvmsg_q at
close, so this looks like a visible semantic change rather than a leak, but
the patch is cc'd to stable and only the new function comment hints at it.

Also, is the new comment self-consistent?  It says "no new calls will get
added" while describing a function whose job is to add the call back onto
rx->recvmsg_q.

> @@ -562,7 +549,7 @@ int rxrpc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>  
>  	if (!(flags & MSG_PEEK) &&
>  	    !skb_queue_empty(&call->recvmsg_queue))
> -		rxrpc_notify_socket(call);
> +		rxrpc_requeue_call(sock, call);
>  	goto not_yet_complete;

[Severity: Medium]
Is item (1) of the changelog accurate for this call site?  It describes the
helper as requeuing "a call for rxrpc_recvmsg() without creating another
notification", but rxrpc_requeue_call() still calls sk->sk_data_ready(sk).
What it actually drops is the call->notify_rx dispatch, which is unreachable
from rxrpc_recvmsg() anyway since calls with notify_rx set are not put on
rx->recvmsg_q.  Could the wording be adjusted to say that?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914151340.3227501-1-dhowells%40redhat.com
