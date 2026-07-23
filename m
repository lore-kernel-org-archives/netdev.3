Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F144641D238;
	Thu, 23 Jul 2026 16:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824005; cv=none; b=rnxaDD8tVLb0hdmgY0D/JBWDgwnS4YNnhvtTIXxSZJqvFVO+ImZFCsxcxOWxz8ay67ugSr4t1Y8CsGVoM6w4lPnp6E5GRsKsBQJwDHRyDx3WmeLUh1Kj0dqm4cn+dDi1hYoLwLaVqdB2fplruTf7XQmoEBw7wCIuilgzGH0UcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824005; c=relaxed/simple;
	bh=BQoYUP/AFIR8KukaOienCGe5QHk9qn+ZU3eIAVrGbqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwIb5eowGO+FnqRU5X/M/RT1diFT3mhOMgmvbqJweypCj9TSLoepQBJi3qBSOph5Kdov2w7DNvM2FhT17wRP/x4KQrWkHuUFsXBYtimxqDU/npd6lAIDvL/WTld2JDarfhizwXgEkf17QN9PQZrl6z0B6KwCceW6XDNwVue9NLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVu+wo9a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVu+wo9a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F80E1F00A3D;
	Thu, 23 Jul 2026 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784823995;
	bh=LDeSsTLzv1Tc7tfKsPfIo0p1m5cUwZ/ShQ7uxEDtfwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jVu+wo9av+maq+zRSN5PuApOLveOjhiZ2MJkylAoE59mVXa8XDKhj0M9ZI7Opm+RG
	 3/cUgoCKirEwNw2h8H1iHzj8A+osgyGnnoAAqWQ1vEDHiTcnPImayBRoakkx9+FM/L
	 +9yIkc60PN8oRjJpgtHc3SLAHUL6RROTVCmvaHz3xHe3X3YdRzYTxPjL/fpAVT6eFO
	 v5P+bwV9ulUvbXJVg+oesdrqI7SMA6ONpptZuSeNzTx9dEkTN6NtyYb+krNYTY8yqM
	 HxPrDLnG+nWJ1blmxJUvFjjsyRqnJ5fb6HtjXKq54scDXZtevF7Id0mtKdwsJNbqDV
	 TWrzD4PP3LXiQ==
Date: Thu, 23 Jul 2026 09:26:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bcodding@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 svens@linux.ibm.com, brueckner@linux.ibm.com
Subject: Re: [PATCH] tls: don't abort the connection on signal-interrupted
 sends
Message-ID: <20260723092630.1a1c9b4e@kernel.org>
In-Reply-To: <20260720090940.1334523-1-maxbr@linux.ibm.com>
References: <20260720090940.1334523-1-maxbr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 11:08:47 +0200 Maximilian Immanuel Brandtner wrote:
> When a signal interrupts a blocking send, tls_tx_records() treats the
> resulting -ERESTARTSYS as a transmission failure and marks the socket
> errored via tls_err_abort() with the raw error code. Later syscalls
> return the kernel-internal errno 512 (ERESTARTSYS) to userspace, as the
> signal it stems from is no longer pending during syscall exit and thus
> never translated.

Can we just add ERESTARTSYS handling? I never heard of the other codes
you're checking TBH, can they actually surface?

> An interrupted send is not a connection error: the partially sent record
> stays queued and is resent later. Interrupt error codes are therefore
> excluded from the abort in the same way as -EAGAIN.
> 
> Fixes: b341ca51d267 ("tls: Fix tls_sw_sendmsg error handling")
> Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
> ---
> Tested on top of net commit 3f1f75536668 ("net: openvswitch: reject
> oversized nested action attrs").
> 
> Several subsystems contain static helper functions to classify these
> interrupt errnos. It might be worthwhile to refactor these static
> functions into a generic helper function.

Yes, please.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index d4afc90fd796..3c9e94069e82 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -405,6 +405,24 @@ static void tls_free_open_rec(struct sock *sk)
>  	}
>  }
>  
> +static bool tls_is_non_restartable_err(int err)
> +{
> +	if (err >= 0)
> +		return false;

This doesn't belong in a helper for classifying errors.

> +	switch (err) {
> +	case -EAGAIN:
> +	case -EINTR:
> +	case -ERESTARTSYS:
> +	case -ERESTARTNOINTR:
> +	case -ERESTARTNOHAND:
> +	case -ERESTART_RESTARTBLOCK:
> +		return false;
> +	default:
> +		return true;
> +	}
> +}
> +
>  int tls_tx_records(struct sock *sk, int flags)
>  {
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
> @@ -458,7 +476,7 @@ int tls_tx_records(struct sock *sk, int flags)
>  	}
>  
>  tx_err:
> -	if (rc < 0 && rc != -EAGAIN)
> +	if (tls_is_non_restartable_err(rc))
>  		tls_err_abort(sk, rc);
>  
>  	return rc;
-- 
pw-bot: cr
