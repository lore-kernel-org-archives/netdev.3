Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1F4D8DA0;
	Thu, 24 Sep 2026 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271375; cv=none; b=GyAvVWmTzVGXodcuXT3r6TiJpSsew7gyvaHzaVmqUmbIVqR53dUGRCvbtsXL+Um0XUkS56ubAsqLIafy714EBBed+yJ62fD8XsIvgvyO5oXZ3rWm/mHMzQJyOlaOa77KBJOn+PHJpirlVZaItYAQuiEuKcutYhrVMEjylKac3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271375; c=relaxed/simple;
	bh=kss/VRntA2Wy6C5i4ORdBNDU0I8ad92Vbz1l2QOxTUA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qz+gu5DdvpIn7aMIsrtTA0S/BYkzZAHPEXP+MdlilAM+B5G+7k/47iHeY1AWvYZktJMFAjxtOPkm9/QZlTo3EppT6pt1/GnNA1pIf8zRdMYd1YfeGdnId6wd9mUsJtpqbXfHD2Py9ho70dHm8lGwIUT3ojrC7ClJOtOdeDQWe8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6Ir5dMe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6Ir5dMe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902CA1F00893;
	Thu, 24 Sep 2026 17:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271373;
	bh=++QjQ9FIKNiXge5phH94VybrtJ6GBT0lhyWR7Btuc3s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m6Ir5dMe7GF7ul8pwyYkVswFpZuCEGHd3M3Mxu96NVei58Jo3EOv/olX2ZCN83Rft
	 kYx8UkybtJjODZ6u1qOVJqdjMn7endZJnAmixeBEN3TGOY8T9TF57SnuULUs7Hw96L
	 pa/FFx24Hm1V1+1cWgYU88Jeya0O6VosnSpn2tM2vhlMwgq7WsoWa7wqZi7zLlRk92
	 6SnIlYnSJSXEMH1kQQvpYR5Vrg9lkXVOD7pF8RzrhesuQzFkB6wGpdyN9C8yJUUuiP
	 /Zdh9pYftO3KgN+TDcuRIE1YZLfD9O/c9V6bpTtdDu+mPojjB/vo9ErldFTiMCNSvE
	 6V6iZNbexI02g==
Subject: Re: [PATCH net 6/6] net: bcmasp: fix network filter lookup and wake
 filter pair allocation
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:36:12 +0000
Message-ID: <179027137214.2160803.17069957616847301356@kernel.org>
In-Reply-To: <20260922221630.3864427-7-florian.fainelli@broadcom.com>
References: <20260922221630.3864427-7-florian.fainelli@broadcom.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] When bcmasp_netfilt_get_init() runs as a lookup (init ==
  false) with loc == RX_CLS_LOC_ANY, it still returns an arbitrary…
- [Low] The commit message presents issues #2 (an unpositioned wake
  allocation picking an odd index and claiming across pair boundaries)…

--

net: bcmasp: fix network filter lookup and wake filter pair allocation

This patch rewrites bcmasp_netfilt_get_init() so that a lookup of an
explicit location only checks that slot. Wake filter pair allocation is
now restricted to even slots where both entries are free, and loc + 1 is
checked for positioned wake filters. It also adds a parity and bounds
check to bcmasp_netfilt_release() and factors the companion slot test
into bcmasp_netfilt_is_companion().

> 2. When allocating an unpositioned wake filter (wake_filter == true and
>    loc == RX_CLS_LOC_ANY), if an even index was claimed or its adjacent
>    odd index was claimed, the check fell through to the non-wake branch
>    "else if (!priv->net_filters[i].claimed)", picking an odd index and
>    subsequently claiming the next filter across filter pair boundaries.
> 3. When allocating a positioned wake filter at loc, only loc was
>    checked for being busy, but not loc + 1, which could overwrite an
>    existing filter at loc + 1.

[ ... ]

> Fix these by checking only the requested location on lookup, properly
> restricting wake filter pair searches to even boundaries where both
> entries are free, checking loc + 1 for positioned wake filters, and
> preventing out-of-bounds release.

[Severity: Low]
Can issues 2 and 3, and the out-of-bounds release, actually happen with
the current driver?

The only allocation caller is bcmasp_flow_insert(). It rejects every
rule that is not a wake filter:

drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c:bcmasp_flow_insert() {
    ...
	/* Currently only supports WAKE filters */
	if (!wake)
		return -EOPNOTSUPP;
    ...
}

This means every allocation in bcmasp_netfilt_get_init() runs with
wake_filter == true. num_net_filters is always even in the platform data
(32, 32 or 16). The only code that writes priv->net_filters[] is
bcmasp_netfilt_get_init() and bcmasp_netfilt_release().

So each pair is claimed and released as a unit, and only even slots are
ever primaries. With that invariant, the old unpositioned loop always
takes the wake branch at the first free even slot and never gets to an
odd slot. An unclaimed even loc also means loc + 1 is unclaimed. And
bcmasp_netfilt_release() is only ever passed an even primary whose
companion is in bounds.

Only issue 1 looks reachable. The other changes look like hardening.
Could the commit message say so? With a Fixes: tag, describing them as
filter table corruption and an out-of-bounds release may lead stable
triage to overestimate the severity.

> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> index 972474893a6bc..bbd152bc3a8a9 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c

[ ... ]

> @@ -673,41 +677,61 @@ struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
>  	if (loc != RX_CLS_LOC_ANY && loc >= priv->num_net_filters)
>  		return ERR_PTR(-EINVAL);
>  
> -	/* If the filter location is busy (already claimed) and we are initializing
> -	 * the filter (insertion), return a busy error code.
> -	 */
> -	if (loc != RX_CLS_LOC_ANY && init && priv->net_filters[loc].claimed)
> -		return ERR_PTR(-EBUSY);
> -
> -	/* We need two filters for wake-up, so we cannot use an odd filter */
> -	if (wake_filter && loc != RX_CLS_LOC_ANY && (loc % 2))
> -		return ERR_PTR(-EINVAL);
> +	if (!init) {
> +		if (loc != RX_CLS_LOC_ANY) {
> +			if (priv->net_filters[loc].claimed &&
> +			    priv->net_filters[loc].port == intf->port &&
> +			    !bcmasp_netfilt_is_companion(priv, loc))
> +				return &priv->net_filters[loc];
> +			return ERR_PTR(-ENOENT);
> +		}
>  
> -	/* Initialize the loop index based on the desired location or from 0 */
> -	i = loc == RX_CLS_LOC_ANY ? 0 : loc;
> +		for (i = 0; i < priv->num_net_filters; i++) {
> +			if (bcmasp_netfilt_is_companion(priv, i))
> +				continue;
>  
> -	for ( ; i < priv->num_net_filters; i++) {
> -		/* Found matching network filter */
> -		if (!init &&
> -		    priv->net_filters[i].claimed &&
> -		    priv->net_filters[i].hw_index == i &&
> -		    priv->net_filters[i].port == intf->port)
> -			return &priv->net_filters[i];
> +			if (priv->net_filters[i].claimed &&
> +			    priv->net_filters[i].port == intf->port)
> +				return &priv->net_filters[i];
> +		}
>  
> -		/* If we don't need a new filter or new filter already found */
> -		if (!init || open_index >= 0)
> -			continue;
> +		return ERR_PTR(-ENOENT);
> +	}

[Severity: Medium]
Should the lookup path reject loc == RX_CLS_LOC_ANY rather than return
the first claimed filter owned by the port?

The only lookup callers are bcmasp_flow_delete() and bcmasp_flow_get().
Both pass the user-supplied cmd->fs.location through unchanged:

drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c:bcmasp_flow_delete() {
    ...
	nfilter = bcmasp_netfilt_get_init(intf, cmd->fs.location, false, false);
	if (IS_ERR(nfilter))
		return PTR_ERR(nfilter);

	bcmasp_netfilt_release(intf, nfilter);
    ...
}

ethtool_set_rxnfc() and ethtool_get_rxnfc() in net/ethtool/ioctl.c do
not validate fs.location for ETHTOOL_SRXCLSRLDEL or ETHTOOL_GRXCLSRULE.
The capacity check at the top of bcmasp_netfilt_get_init() also lets
RX_CLS_LOC_ANY through.

So an ETHTOOL_SRXCLSRLDEL with fs.location = RX_CLS_LOC_ANY would
release the port's lowest-index wake filter pair, and silently drop that
wake-on-net rule. An ETHTOOL_GRXCLSRULE with the same location would
copy an unrelated rule's spec back to userspace.

The uAPI documentation in include/uapi/linux/ethtool.h says that for
these commands fs.location names an existing rule. RX_CLS_LOC_ANY is
only documented for ETHTOOL_SRXCLSRLINS.

This rewrite fixes the problem for explicit locations. Could this loop
be replaced with an -EINVAL or -ENOENT return, so a request that names
no rule does not act on an unrelated filter?

>  
> -		/* Wake filter conslidates two filters to cover more bytes
> -		 * Wake filter is open if...
> -		 * 1. It is an even filter
> -		 * 2. The current and next filter is not claimed
> -		 */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922221630.3864427-1-florian.fainelli%40broadcom.com
