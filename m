Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F0175A88
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 04:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788754764; cv=none; b=mR7ONJKF7QgB9iDTnVK2D1pN34tAU3zVog8KxoF5Dia9+sbEPa6856fBLjy/up1s2tB3+0ktVzHhXzR5Q7S6pX4y91uMuzbaDIc6IrlAUt0WYxQFewx+6+U02v8hXq1HEu8w8EddSH+WRJ14PmO4Pb3sYuz0PARS6orGi/a6RH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788754764; c=relaxed/simple;
	bh=AFX2GY533XlMz1KHLwb+VQZOsHx1DGLdUNxvIrruQFs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUt4u9ndyUUSOkuov+InSohRt/LLEiDbyoOLRcLllllhI1T6UCJ6ppzv1wv42YkxTbRPq067OG0KsYTQ3OqBBHOy/e1Awjy15c82N6W9qXHRdhU8EMHyHALe4THlbsp0ryR4Nek9c1lQbmFUm/qTevo1XO4utt00atv/ZbkjLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhpajWGq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhpajWGq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251881F00A3A;
	Mon,  7 Sep 2026 04:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788754762;
	bh=My7KWwRBUnKU8P/F0aX9IsYbItxTYgkvGHQTHxX5L48=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MhpajWGqo2nidNvZkjUOcjhQD8nn/YLhIauSqrn7IL1+vO+ICWUjBW/pdUUkmmqBK
	 RN2TJVaHUhtithQqpVE0lU0u03zLYnWNJeo3VzjohJEc3+c5P7nC0M9yJ8fTvF1q4p
	 1Je6Kzxs9ffXkXzJAeve41lCf0zD2czZFjCvVXonpq6OAzJuu9wYGJbksIS5UZrPjL
	 lERLOF4wl+XDLHt97fcxivQgppXDEr6izfy0CprNzFlRTlaltN0Ez+VgxczrLykFIs
	 ZPPmDudmt8rJdqFYVZuQadl6uW9MsCVQspomby6iARl7Z7CGPElTzS4VafbSUitxXs
	 OQtzdmsaUePjw==
Subject: Re: [PATCH v1 net-next 1/2] tcp: Do not allow buggy transitions
 between ehash and lhash2.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ncardwell@google.com, willemb@google.com,
 dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org, 4ncienth@gmail.com, imv4bel@gmail.com
Date: Mon, 07 Sep 2026 04:19:21 +0000
Message-ID: <178875476169.219967.7521705515853835324@kernel.org>
In-Reply-To: <20260904033543.2635540-2-kuniyu@google.com>
References: <20260904033543.2635540-2-kuniyu@google.com>
X-sashiko-severity: Low
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

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] The commit carries three Reported-by/Closes pairs for concrete,
  user-triggerable bug reports (including a sockmap/TCP leak) but no…

--

tcp: Do not allow buggy transitions between ehash and lhash2.

This adds a new unhashed_state field to struct inet_connection_sock,
recording sk->sk_state at inet_unhash() time, and uses it to reject
listen() on a socket that was unhashed from a non-listening state and
connect() on a socket that was unhashed as a listener.

Closes: https://lore.kernel.org/netdev/20260731140512.566464-1-david.lee@trailofbits.com/
Closes: https://lore.kernel.org/netdev/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/
Closes: https://lore.kernel.org/netdev/20260824033331.1084971-1-imv4bel@gmail.com/

[Severity: Low]
The changelog carries three Reported-by/Closes pairs for concrete,
user-triggerable reports (including the sockmap/TCP socket leak), but there
is no Fixes: tag and no note about stable trees.

Since the same change also tightens observable behaviour in inet_hash() and
__inet_hash_connect() (listen() and connect() now return -EINVAL for
sequences that previously succeeded), would it help backporters to either
add a Fixes: tag, or state in the changelog why no tag is given?

Without either, stable maintainers have no anchor commit and no record of
the trade-off between closing the reported memory-safety issues and the new
-EINVAL returns from listen()/connect().

> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ba0faa9ae2bb3..5abcb0debb270 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -803,6 +803,11 @@ int inet_hash(struct sock *sk)
>  	inet_init_ehash_secret();
>  
>  	WARN_ON(!sk_unhashed(sk));
> +
> +	if (unlikely(inet_csk(sk)->unhashed_state &&
> +		     inet_csk(sk)->unhashed_state != TCP_LISTEN))
> +		return -EINVAL;
> +
>  	ilb2 = inet_lhash2_bucket_sk(hashinfo, sk);
>  
>  	spin_lock(&ilb2->lock);

[ ... ]

> @@ -1058,6 +1066,9 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>  	int ret, i, low, high;
>  	bool local_ports;
>  
> +	if (unlikely(inet_csk(sk)->unhashed_state == TCP_LISTEN))
> +		return -EINVAL;
> +
>  	if (port) {
>  		local_bh_disable();
>  		ret = check_established(death_row, sk, port, NULL, false,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904033543.2635540-1-kuniyu%40google.com
