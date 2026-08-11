Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332137C90A;
	Tue, 11 Aug 2026 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454080; cv=none; b=h38agTR6Bxcwf+2CzWkseEmsFIEcxQbtlkQTW54aUwy5zdy9PLlm5EXLswhHwBR8Uqpen4yMu/Taaj4cvNu8rDqAH3XlryKqPM84wv6Gds9H6nBbgFDAB5DW5nuEVQIgkJnLeHlsM80YXpWZ+OWr0VrXD/kL3Jp2xzlqv6TpDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454080; c=relaxed/simple;
	bh=Lnh0bMG90tvcU6DhgUINWiCd9LHrN5NObdGta+FC7sk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALqrxDqgkuTX9jt6Ci5EGEmYkyx5Xhrvw9n3QLksRfBqPOguWtQBhoF7fXw/9fq9bK5KW7zl2XgXl7f76Xn623GPdJ+xJMnaMeeca+D4v3c5rUaTZEJkOvQf6wzUC1FITJblid7ezjS8ROLZvdjo0XC9T30QFj2/0SQdsvY/t5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6gjuVcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6gjuVcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4DD1F000E9;
	Tue, 11 Aug 2026 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786454078;
	bh=gTLskmDphRkVYVwpl41sbsstdMinqtNg1UCBu3syw1o=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=f6gjuVcyWlT8EB+FZpuop61ElX4m5opJokg+xrM6ThiCsPAtFo+x8WKMTOJrIka6U
	 NM+QfT24d4CPLrCNxeIrixc+qppiMR/arGXHoboIurowoZpLz11fz9HWypd8A35I+T
	 LCIMc8gKTVOOV5bHuGgtZSBOMeZJKwIUYSopVNuyNTtMRIODfW3GDpIvRzBbBFQV0U
	 5R7Oas7c8O4t3nD2Jle2hrqr5gBiklPa8xQhVOeMr/pWS/nZ210IzINIuA3gMP4m95
	 sMe30rA5JFO/jDz1wkKpWPxLCzDkPh/HyXgZ0oomAzD8KIkQJqLPR0lslv+vhjAr2R
	 wSWo8ufUdlnMw==
Date: Tue, 11 Aug 2026 14:14:33 +0100
From: Lee Jones <lee@kernel.org>
To: David Heidelberg <david+nfc@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Szymon Janc <szymon.janc@tieto.com>,
	Samuel Ortiz <sameo@linux.intel.com>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nfc: llcp: Fix race condition in accept_queue
 lifecycle
Message-ID: <20260811131433.GU2869284@google.com>
References: <20260601140934.1040144-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601140934.1040144-1-lee@kernel.org>

[INTENTIONAL TOP POST]

This one has been knocking around for a very long time.

Would you like me to [RESEND] it, or does everyone still have it?

On Mon, 01 Jun 2026, Lee Jones wrote:

> nfc_llcp_socket_release() walks the local sockets list and the listener
> socket's accept_queue under bh_lock_sock().  However, bh_lock_sock()
> does not provide mutual exclusion against process-context lock_sock()
> held by nfc_llcp_accept_dequeue() during accept().  Since socket_release()
> runs in process context (workqueue or kref cleanup), it never checks
> sock_owned_by_user(), allowing both paths to manipulate the same child
> socket concurrently.  This leads to a double sock_put() (Use-After-Free)
> or a NULL pointer dereference of child->parent in nfc_llcp_accept_unlink().
> 
> Fix this by converting nfc_llcp_socket_release() to use lock_sock().
> Since it is called with the local sockets write-lock held (which disables
> preemption, preventing sleep), repeatedly pop the head socket from the
> list under the write-lock using a new helper nfc_llcp_sock_list_pop(),
> then safely acquire lock_sock() on it after dropping the list lock.
> A sock_hold() is taken under the list lock to keep the socket alive
> across the sleep and balanced with a sock_put() after release.
> 
> Additionally, add a check for a non-NULL parent in nfc_llcp_accept_unlink()
> to ensure idempotency and prevent NULL pointer dereference if the unlink
> races with dequeue.
> 
> Fixes: 50b78b2a6500 ("NFC: Fix sleeping in atomic when releasing socket")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  net/nfc/llcp_core.c | 47 +++++++++++++++++++++++++--------------------
>  net/nfc/llcp_sock.c | 13 +++++++------
>  2 files changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index dc65c719f35f2..e51bd0d081b62 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -63,21 +63,33 @@ static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
>  	}
>  }
>  
> +static struct sock *nfc_llcp_sock_list_pop(struct llcp_sock_list *l)
> +{
> +	struct sock *sk;
> +
> +	write_lock(&l->lock);
> +	sk = sk_head(&l->head);
> +	if (sk) {
> +		sock_hold(sk);
> +		sk_del_node_init(sk);
> +	}
> +	write_unlock(&l->lock);
> +
> +	return sk;
> +}
> +
>  static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>  				    int err)
>  {
>  	struct sock *sk;
> -	struct hlist_node *tmp;
>  	struct nfc_llcp_sock *llcp_sock;
>  
>  	skb_queue_purge(&local->tx_queue);
>  
> -	write_lock(&local->sockets.lock);
> -
> -	sk_for_each_safe(sk, tmp, &local->sockets.head) {
> +	while ((sk = nfc_llcp_sock_list_pop(&local->sockets))) {
>  		llcp_sock = nfc_llcp_sock(sk);
>  
> -		bh_lock_sock(sk);
> +		lock_sock(sk);
>  
>  		nfc_llcp_socket_purge(llcp_sock);
>  
> @@ -92,7 +104,8 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>  						 &llcp_sock->accept_queue,
>  						 accept_queue) {
>  				accept_sk = &lsk->sk;
> -				bh_lock_sock(accept_sk);
> +				lock_sock_nested(accept_sk,
> +						 SINGLE_DEPTH_NESTING);
>  
>  				nfc_llcp_accept_unlink(accept_sk);
>  
> @@ -101,7 +114,7 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>  				accept_sk->sk_state = LLCP_CLOSED;
>  				accept_sk->sk_state_change(sk);
>  
> -				bh_unlock_sock(accept_sk);
> +				release_sock(accept_sk);
>  			}
>  		}
>  
> @@ -110,23 +123,18 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>  		sk->sk_state = LLCP_CLOSED;
>  		sk->sk_state_change(sk);
>  
> -		bh_unlock_sock(sk);
> -
> -		sk_del_node_init(sk);
> +		release_sock(sk);
> +		sock_put(sk);
>  	}
>  
> -	write_unlock(&local->sockets.lock);
> -
>  	/* If we still have a device, we keep the RAW sockets alive */
>  	if (device == true)
>  		return;
>  
> -	write_lock(&local->raw_sockets.lock);
> -
> -	sk_for_each_safe(sk, tmp, &local->raw_sockets.head) {
> +	while ((sk = nfc_llcp_sock_list_pop(&local->raw_sockets))) {
>  		llcp_sock = nfc_llcp_sock(sk);
>  
> -		bh_lock_sock(sk);
> +		lock_sock(sk);
>  
>  		nfc_llcp_socket_purge(llcp_sock);
>  
> @@ -135,12 +143,9 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
>  		sk->sk_state = LLCP_CLOSED;
>  		sk->sk_state_change(sk);
>  
> -		bh_unlock_sock(sk);
> -
> -		sk_del_node_init(sk);
> +		release_sock(sk);
> +		sock_put(sk);
>  	}
> -
> -	write_unlock(&local->raw_sockets.lock);
>  }
>  
>  static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
> diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
> index feab29fc62f44..3d30f0233b986 100644
> --- a/net/nfc/llcp_sock.c
> +++ b/net/nfc/llcp_sock.c
> @@ -384,11 +384,12 @@ void nfc_llcp_accept_unlink(struct sock *sk)
>  
>  	pr_debug("state %d\n", sk->sk_state);
>  
> -	list_del_init(&llcp_sock->accept_queue);
> -	sk_acceptq_removed(llcp_sock->parent);
> -	llcp_sock->parent = NULL;
> -
> -	sock_put(sk);
> +	if (llcp_sock->parent) {
> +		list_del_init(&llcp_sock->accept_queue);
> +		sk_acceptq_removed(llcp_sock->parent);
> +		llcp_sock->parent = NULL;
> +		sock_put(sk);
> +	}
>  }
>  
>  void nfc_llcp_accept_enqueue(struct sock *parent, struct sock *sk)
> @@ -622,7 +623,7 @@ static int llcp_sock_release(struct socket *sock)
>  		list_for_each_entry_safe(lsk, n, &llcp_sock->accept_queue,
>  					 accept_queue) {
>  			accept_sk = &lsk->sk;
> -			lock_sock(accept_sk);
> +			lock_sock_nested(accept_sk, SINGLE_DEPTH_NESTING);
>  
>  			nfc_llcp_send_disconnect(lsk);
>  			nfc_llcp_accept_unlink(accept_sk);
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 

-- 
Lee Jones
