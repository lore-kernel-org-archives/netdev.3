Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367F0488D82;
	Fri,  2 Oct 2026 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937146; cv=none; b=Xa1Ek7LLqXsMPSgDELTT8aOJaSxFoEC5+Ui2WdSwIa5G1bQbOiMfQx8JaR1v1cJ1jPWpON9Jfdqj4XPZoDdWbfWi48JabbDyi+HYRsymgLTPcSb8y98BuN5WhJibIInAhUvlM61+gkyHFTdgjf0J9rPVHYLDS81dIGo5VIBq9Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937146; c=relaxed/simple;
	bh=A8gz5qz9N1UX6bWTK8QHr5k+qRdRd0cSQ3jFGMwLcRU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6y8bA/P07mI5IdbHb7dw3lpBEosXaoZhiLJIyP472D/tta0enMtzhRHNEh4/lQKLtmpvbEv5qkll2ljlgYEOZ75pSWMoKy5W4EU2uwrkvNixXyvGxgKhB1bAWmy6i8XlQihjO7nDgovOsDLskXTHCSWjiqhREgfVbW0U0C19lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRyHZXi2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRyHZXi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F5B1F0089A;
	Fri,  2 Oct 2026 10:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790937145;
	bh=/cX837TM+ZFRxm0LpqTSE8XEPQ+LWDUMln75gopRunI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hRyHZXi24HNmmEVBMKEPnSBi04ze4B2Bzi9gaNlaGR4KPktjKceiix4QMAKUedK/f
	 VdyB+8YAl79mhp+jxtKRVfDiNas1A4C6YxsKEoZESX/OGH4NpwxXWHkaLrnrANCeic
	 gZh013ISzVjL/bZKeWQw+/1HuKcVKJXktwDQailBumJyLHuwkPpp8pZhyU8HFQD0bW
	 e181J7+R7aItIO22oXXAZm+aLDvvjxaFQGAw0nxowTBU0qyN5zpYhkMZy9jIr4JTxW
	 37iA1rplTGbQBVDO6fjkS4iJCJFyFtBuV69VvTN8qXDyfsO/ouubKqUsiHajhLI3tJ
	 Bu1/rORDAlDGA==
Subject: Re: [PATCH 07/16 net-next v2] ipv4: icmp: split IPv4 specific logic
 into icmp_ipv4.c
From: netdev-bot+sashiko@kernel.org
To: fmancera@suse.de
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, davem@davemloft.net,
 edumazet@google.com, ebiggers@kernel.org, ardb@kernel.org, krzk@kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 10:32:23 +0000
Message-ID: <179093714377.434549.5306640210578239341@kernel.org>
In-Reply-To: <20260928193046.6698-8-fmancera@suse.de>
References: <20260928193046.6698-8-fmancera@suse.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch moves the per-CPU ICMP control socket setup (a
  for_each_possible_cpu() loop calling inet_ctl_sock_create()) out of…

--

ipv4: icmp: split IPv4 specific logic into icmp_ipv4.c

This commit moves the IPv4 specific ICMP code (packet processing, error
handling, the icmp_pointers[] table and the per-CPU control socket setup)
out of net/ipv4/icmp.c into a new file, net/ipv4/icmp_ipv4.c. The new file
is built only when CONFIG_IPV4 is enabled, and icmp.c is moved to obj-y.

> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 90c0e22c29bea..5e8dcf71d135f 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c

[ ... ]

> @@ -1757,28 +366,11 @@ static struct pernet_operations __net_initdata icmp_sk_ops = {
>  
>  int __init icmp_init(void)
>  {
> -	int err, i;
> -
> -	for_each_possible_cpu(i) {
> -		struct sock *sk;
> +	if (IS_ENABLED(CONFIG_IPV4)) {
> +		int err = icmp_init_ipv4();
>  
> -		err = inet_ctl_sock_create(&sk, PF_INET,
> -					   SOCK_RAW, IPPROTO_ICMP, &init_net);
> -		if (err < 0)
> +		if (err)
>  			return err;

[ ... ]

> diff --git a/net/ipv4/icmp_ipv4.c b/net/ipv4/icmp_ipv4.c
> new file mode 100644
> index 0000000000000..24a1fb497cf6f
> --- /dev/null
> +++ b/net/ipv4/icmp_ipv4.c

[ ... ]

> +int icmp_init_ipv4(void)
> +{
> +	int err, i;
> +
> +	for_each_possible_cpu(i) {
> +		struct sock *sk;
> +
> +		err = inet_ctl_sock_create(&sk, PF_INET,
> +					   SOCK_RAW, IPPROTO_ICMP, &init_net);

[Severity: Low]
Should icmp_init_ipv4() be marked __init?

The per-CPU control socket loop used to live directly in icmp_init(),
which is __init, so it was freed with init memory after boot. It now sits
in icmp_init_ipv4(), which has no annotation.

The only caller is still icmp_init(), which runs once at boot, so this
code can never run again. It now stays in resident .text instead of being
discarded. The commit message describes this as a plain move and doesn't
mention the change.

Would it make sense to use int __init icmp_init_ipv4(void) here, and
maybe put __init on the prototype in include/net/icmp.h as well?

> +		if (err < 0)
> +			return err;
> +
> +		per_cpu(ipv4_icmp_sk, i) = sk;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193046.6698-1-fmancera%40suse.de
