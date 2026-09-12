Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373352D5C83;
	Sat, 12 Sep 2026 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176001; cv=none; b=bVI6SOfYZj9TS3S9gXMTIcNf6OsSj3JHVv2Onkl+e9ifbZdfYzJfoQn4n9U6bYZiyFk7Szu+Bc0Myi1+vqetMGtVAq+8Jvp0ac83TYrVXW5GIKSV2DA4as7av8rWmucrTRDOBCZ5RnoTlQ0RKW51C5B5KGZ8nPBfuvlfzLI+1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176001; c=relaxed/simple;
	bh=ephaR4bIgMA26WYDb3Sngj9TzLFSaWEQcVUN0gYI1T8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UhskJCdcKmDmwEVJkQk//GuJQtU+Y9iMRXZG6+mr2ybIwFqUTVB35iDYMAWiKO2hXbf6Zr+Q+ybXmrPOZSEfUJsHR6QjP0IiN2xmnvlFvcQA0HlR98tGqSHUNw9S0dT5+61IFVZ3r4DEePc79WIVeevxxSwJ1kw26bQxpeTqwwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0dwHTeN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0dwHTeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9891F00893;
	Sat, 12 Sep 2026 01:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789175999;
	bh=yFUCTXzxiNJFA6+r12NyFlxWdjRr1Bs0V9mLuAgIuZo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D0dwHTeNAv3xoE2i0lgjWvq2oLsG1ePDTwnQVt/9Umlj9o8dutf4ZTIoZI1VQyCxq
	 C5xtZEDqy+92JSq++jKq6iMl6iarKqyJjPPiBw+JEirntl5rm7eMBnwGoOPgc6qW/Q
	 J2waXkDOzuaCQSWD60YGzSYU6uq4QT9qvkwnITuZskNSkYaqLmP8wDaC1Bt6r+Ssqf
	 YlY5vEtRVHUo4OsTSceZeqWGD9IBV3kf5Y3D7q7QI4qPfOOouami7Al9ahom+F9nIL
	 AclKv2fvgFHTktE3FlrQ2dpCCtiZCdHXnQxJOSj24wBwMN1aBzY+WPThM4DkRBL2uR
	 RvZcAMBqvJqkQ==
Subject:
 Re: [PATCH net-next 2/2] ipv4: igmp: convert ip_mc_msfget() to sockopt_t
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
 kernel-team@meta.com
Date: Sat, 12 Sep 2026 01:19:58 +0000
Message-ID: <178917599835.219967.6363929586904032206@kernel.org>
In-Reply-To: <20260910-getsockopt_phase6-v1-2-e681e102d5b8@debian.org>
References: <20260910-getsockopt_phase6-v1-2-e681e102d5b8@debian.org>
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

- [Medium] In do_ip_getsockopt() (net/ipv4/ip_sockglue.c, case
  IP_MSFILTER), the output length is now written back to userspace…

--

ipv4: igmp: convert ip_mc_msfget() to sockopt_t

This converts ip_mc_msfget() from the sockptr_t optval/optlen pair to a
sockopt_t built at the do_ip_getsockopt() call site, and replaces the
optval copies with sequential copy_to_iter() calls after growing the
output iterator with sockopt_expand_out().

> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index d56355aca7977..144fca158adcb 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c

[ ... ]

> @@ -2755,14 +2755,19 @@ int ip_mc_msfget(struct sock *sk, struct ip_msfilter *msf,
>  	len = flex_array_size(psl, sl_addr, copycount);
>  	msf->imsf_numsrc = count;
>  	msf_size = IP_MSFILTER_SIZE(copycount);
> -	if (copy_to_sockptr(optlen, &msf_size, sizeof(int)) ||
> -	    copy_to_sockptr(optval, msf, IP_MSFILTER_SIZE(0))) {
> +
> +	/* The source list is sized by the imsf_numsrc the caller left in
> +	 * optval, not by optlen, which only has to cover the fixed part.
> +	 */
> +	err = sockopt_expand_out(opt, msf_size);
> +	if (err)
> +		return err;
> +
> +	opt->optlen = msf_size;
> +	if (copy_to_iter(msf, IP_MSFILTER_SIZE(0), &opt->iter_out) !=
> +	    IP_MSFILTER_SIZE(0))
>  		return -EFAULT;
> -	}
> -	if (len &&
> -	    copy_to_sockptr_offset(optval,
> -				   offsetof(struct ip_msfilter, imsf_slist_flex),
> -				   psl->sl_addr, len))
> +	if (len && copy_to_iter(psl->sl_addr, len, &opt->iter_out) != len)
>  		return -EFAULT;
>  	return 0;
>  done:

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> index a55ef327ec932..c58e565f2a5aa 100644
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c

[ ... ]

> @@ -1715,7 +1717,13 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
>  			err = -EFAULT;
>  			goto out;
>  		}
> -		err = ip_mc_msfget(sk, &msf, optval, optlen);
> +		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
> +		if (err)
> +			goto out;
> +
> +		err = ip_mc_msfget(sk, &msf, &opt);
> +		if (copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
> +			err = -EFAULT;
>  		goto out;

[Severity: Medium]
Should this write-back be guarded by if (!err)?

Before this patch the *optlen store lived inside ip_mc_msfget() and only
ran once the lookup had succeeded:

	msf_size = IP_MSFILTER_SIZE(copycount);
	if (copy_to_sockptr(optlen, &msf_size, sizeof(int)) ||
	    copy_to_sockptr(optval, msf, IP_MSFILTER_SIZE(0))) {
		return -EFAULT;
	}

All of the ip_mc_msfget() failure returns left the user's optlen word
untouched: !ipv4_is_multicast(addr) returning -EINVAL, !in_dev returning
-ENODEV, and the !pmc "must have a prior join" case falling through to
done: with err = -EADDRNOTAVAIL.

Now do_ip_getsockopt() writes opt.optlen back on every return from
ip_mc_msfget(), including those three error paths and the new -EINVAL
from sockopt_expand_out(), since opt->optlen is only assigned on the
success path in ip_mc_msfget(). Is that change of behaviour on failure
intended?

There is a second effect from the missing guard: if the optlen pointer is
readable but not writable, copy_to_sockptr() fails and err is replaced
with -EFAULT, so -EINVAL, -ENODEV and -EADDRNOTAVAIL are no longer
distinguishable by userspace. The earlier copy_from_sockptr(&len, optlen,
...) and the copy_from_sockptr() inside sockptr_to_sockopt() both succeed
on a read-only mapping, so this state is reachable.

Would something like this preserve the old semantics?

	err = ip_mc_msfget(sk, &msf, &opt);
	if (!err && copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
		err = -EFAULT;

The commit message describes the change as a conversion, with "the bytes
land where they did", and does not mention that the optlen store moved to
the caller and now also runs when ip_mc_msfget() fails. Could that be
called out explicitly?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910-getsockopt_phase6-v1-0-e681e102d5b8%40debian.org
