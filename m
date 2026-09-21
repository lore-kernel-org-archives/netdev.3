Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6C32F691D;
	Mon, 21 Sep 2026 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003574; cv=none; b=S3pL23+3fY8eJL+9gzRZWGMkn6bmZuugqfoFawP3nhOhuFpzTivzk6QlSvvFy5EJlDURR7uBIYPOElWeQG16DTwAB9AdK+yflshiyd61+GCspE4OSDCpOg8Ehbfjqlc06918eN3z55rg9NvGaV9mPnGWlaL2qfM/swwVd0wv2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003574; c=relaxed/simple;
	bh=a6zimdAEqAyBLiaa9S6cD7DnsxQcZVKnCdls2uP6dhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYnqZu8JoNvNkLUArC8/nlFrRKKiE81SFgGrdpJ/4zGhl4/Mxk1ppmpbUiX1GlYmlJoYnAKqukFeUEpsdBjlCINEGuOFNoBcjGWZk/sYPofQVR1PuPbG9ctug7aXVkuc1TK5hiQjIUIibMmPbDB9ztSFqpqZoT998rlsv8i/mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0t2YQpE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0t2YQpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F8C1F000FF;
	Mon, 21 Sep 2026 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003573;
	bh=JB/jSD+SCGd237c4gXoZg8G0IUuNqzBaNTHBbjbv1bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n0t2YQpErzkJBFvRaIVTnei/pqtXw66iTiejNvAiiNnNhkOcFWnpz5OSIxNGxqqcV
	 Hlp23OLpfbVGZAE3AW8N7uD03Onr0ZfdAJKfC7LAIF9GX/5GqUlJ+MCObvteEtXl9g
	 8qigMN36hNiewOq4by/dhq7vN7dD5OE4J0vLs57aD0rNGYQ3KCta3lgaxQy3gtJ//E
	 30ExF6qbM84E5l2ni/f2Ak7HE3Hh/XjcBqxZGRkIFqn6gVh7pQtOX3EeZ/WF784a5c
	 uwMxwdyqWdHqgnLQBMfLsrtvBbpcpUaENl/IzunbIzu8F2CgbdQruzxS6CHTFpgGZU
	 U0S34ekpe/aOw==
Date: Mon, 21 Sep 2026 17:12:50 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, edumazet@google.com, 
	davem@davemloft.net, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: llc: clean up unaccepted child sockets in
 llc_ui_release()
Message-ID: <arFJcfmsjM41ABys@quoll>
References: <20260919213635.3314344-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919213635.3314344-1-benquike@gmail.com>


On Sat, 19 Sep 2026 21:36:35 +0000, Hui Peng wrote:
> When an `AF_LLC` listening socket (`sk->sk_state == TCP_LISTEN`) accepts
> an incoming connection request in `llc_conn_state_process()`, it
> allocates a new child `sock` via `llc_sk_alloc()`, holds a `netdev`
> reference on `child_llc->dev`, attaches `child` to `child_llc->sap`,
> sets `skb->sk = child`, and queues `skb` onto the listener's
> `sk->sk_receive_queue` waiting for `llc_ui_accept()`.
> 
> If the listening socket is closed without calling `accept()`,
> `llc_ui_release()` calls `skb_queue_purge(&sk->sk_receive_queue)` in
> `llc_sk_Component` / `llc_sk_free()`, which frees the queued `skb`s
> without removing the unaccepted `child` sockets from `child_llc->sap`,
> releasing `child_llc->dev`, or freeing `child`. This permanently leaks
> the child `sock`, its `llc_sap` reference, and the `net_device`
> reference (blocking `unregister_netdevice()`).
> 
> In `llc_ui_release()`, drain `sk->sk_receive_queue` when `sk->sk_state
> == TCP_LISTEN`, and for each unaccepted child socket, orphan `skb`,
> remove `child` from `child_llc->sap`, release `child_llc->dev`, and free
> `child` via `llc_sk_free()`.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> 
> ---
>  net/llc/af_llc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



