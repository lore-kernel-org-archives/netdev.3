Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B873925783C;
	Fri, 18 Sep 2026 06:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712072; cv=none; b=RoDPmmf10q/T6bsFkz2InkC6vozsAOQtGs7DDabN5G3CguH9bdPjG87KEZQ8l/uZU32a2VAuppoCQmwQYj0G6nqm1l6/+jb+ytanU3vfTa5ghKMv2avgO6aqtUAc5deILoAFkkS9xapfjF/cZc4nTA7TpnKHXfYfaCjPQ/PbX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712072; c=relaxed/simple;
	bh=EK2AHSZ8BENId800FO3a2AqmLSU1kHK/FpjeFLd2FD8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A01bhQuxnjeSfCOqloL0bqzuVyssv19/GqzJDkIy/ydmsD3071cBnaBgC2nD9SZm8EGeO/IHpn53sEv4XgqmJaISnzy4RDSwTc/Q7r08VjJRYvKe1EKKjeSLbZM5knQqVagWmuvoPOc4ZvVVtgAKMkzBFMxQpCQHchaHVfK1A5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh14vswn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh14vswn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE7D1F000FF;
	Fri, 18 Sep 2026 06:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789712070;
	bh=/vQTG5gemaY8/t4xYDs1UjQjmKMD4ZqF1G7e+0JF5fQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oh14vswnzx4u99APsY5e/6yCS1jVF3j1r13yHsnUp+fj0u+UvYi2A/JjZtl/9oDhE
	 aC/ftwVv6QRzRsB5TlevRC45/h6mWyPp3iYsgJkMZN/ZVLlC//Uo/UeZClhSIv70kE
	 iUJcRBTnPQ8ERN2XUSS1VyhH+l7KBt60QHcRw7j1wzq5wL0QROaUeUcl6NbAnxk5fM
	 J291a8oAkCKIAR8KQuF407UeQ+IifTlEgjkAKsL5mLNcViVnp59lfY3Lw2Fa/Bd2hL
	 FV8EoYM3wZajpNLRSihgOFklNI3wOLVWIiQjxeaUIh3sdcQ8u7oS7liE3VN75OHUlV
	 D1gM1uOchZiqQ==
Subject: Re: [PATCH net] eth: fbnic: Avoid rounding zero ring sizes
From: netdev-bot+sashiko@kernel.org
To: bjorn@kernel.org
Cc: alexanderduyck@fb.com, kuba@kernel.org, kernel-team@meta.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 mohsin.bashr@gmail.com, mike.marciniszyn@gmail.com, joe@dama.to
Date: Fri, 18 Sep 2026 06:14:29 +0000
Message-ID: <178971206933.22033.236948278674126701@kernel.org>
In-Reply-To: <20260915181229.4159158-1-bjorn@kernel.org>
References: <20260915181229.4159158-1-bjorn@kernel.org>
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

- [Medium] In fbnic_set_ringparam()
  (drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c), moving the minimum-…

--

eth: fbnic: Avoid rounding zero ring sizes

The patch moves the roundup_pow_of_two() normalization of the requested
ring sizes in fbnic_set_ringparam() to after the minimum-size checks, so
that a zero ring size coming from userspace is rejected instead of being
fed to roundup_pow_of_two().

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> index 0e47088ec44ba..8954fcd08cb31 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -334,11 +334,6 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>  	struct fbnic_net *clone;
>  	int err;
>  
> -	ring->rx_pending	= roundup_pow_of_two(ring->rx_pending);
> -	ring->rx_mini_pending	= roundup_pow_of_two(ring->rx_mini_pending);
> -	ring->rx_jumbo_pending	= roundup_pow_of_two(ring->rx_jumbo_pending);
> -	ring->tx_pending	= roundup_pow_of_two(ring->tx_pending);
> -
>  	/* These are absolute minimums allowing the device and driver to operate
>  	 * but not necessarily guarantee reasonable performance. Settings below
>  	 * Rx queue size of 128 and BDQs smaller than 64 are likely suboptimal

[Severity: Medium]
With the roundup moved below the checks, the minimum-size test in
fbnic_set_ringparam() now compares the raw userspace request rather than
the rounded value.  Does this reject nonzero sizes that used to be
accepted?

The effective minimums all evaluate to 64:

drivers/net/ethernet/meta/fbnic/fbnic_txrx.h:
    #define FBNIC_TX_DESC_MIN	roundup_pow_of_two(FBNIC_TX_DESC_WAKEUP)
    #define FBNIC_RX_DESC_MIN	roundup_pow_of_two(FBNIC_MAX_RX_PKT_DESC * 2)
    #define FBNIC_QUEUE_SIZE_MIN		64u

FBNIC_RX_DESC_MIN is 16 and FBNIC_TX_DESC_MIN is 64 for the common
MAX_SKB_FRAGS == 17, so max(FBNIC_QUEUE_SIZE_MIN, ...) is 64 in every
case.

Previously a request like "ethtool -G ethX tx 40" was rounded to 64 first
and then passed the check, ending up with a 64-entry ring.  Now the check
sees 40 and returns -EINVAL with "requested ring size too small".  The
same applies to any rx, rx-mini or rx-jumbo value in 33..63.

The ethtool core does not enforce a minimum, it only validates the maxima:

net/ethtool/rings.c:ethnl_set_rings() {
	...
	/* ensure new ring parameters are within limits */
	if (ringparam.rx_pending > ringparam.rx_max_pending)
	...
}

and ethtool_set_ringparam() in net/ethtool/ioctl.c does the same, so those
values do reach the driver unchanged.

>  	/* These are absolute minimums allowing the device and driver to operate
>  	 * but not necessarily guarantee reasonable performance. Settings below
>  	 * Rx queue size of 128 and BDQs smaller than 64 are likely suboptimal
>  	 * at best.
>  	 */
>  	if (ring->rx_pending < max(FBNIC_QUEUE_SIZE_MIN, FBNIC_RX_DESC_MIN) ||
>  	    ring->rx_mini_pending < FBNIC_QUEUE_SIZE_MIN ||
>  	    ring->rx_jumbo_pending < FBNIC_QUEUE_SIZE_MIN ||
>  	    ring->tx_pending < max(FBNIC_QUEUE_SIZE_MIN, FBNIC_TX_DESC_MIN)) {
>  		NL_SET_ERR_MSG_MOD(extack, "requested ring size too small");
>  		return -EINVAL;
>  	}

> @@ -368,6 +363,11 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
>  		return -EINVAL;
>  	}
>  
> +	ring->rx_pending	= roundup_pow_of_two(ring->rx_pending);
> +	ring->rx_mini_pending	= roundup_pow_of_two(ring->rx_mini_pending);
> +	ring->rx_jumbo_pending	= roundup_pow_of_two(ring->rx_jumbo_pending);
> +	ring->tx_pending	= roundup_pow_of_two(ring->tx_pending);
> +

[Severity: Medium]
Was the reorder needed to reach the stated goal?  The commit message says
only:

    Validate the requested sizes before rounding them so zero is rejected
    deterministically.

It does not mention that previously accepted non-power-of-two sizes below
the 64-descriptor minimum now start failing with -EINVAL.  Since the patch
carries a Fixes: tag and is therefore a stable-backport candidate, could
the changelog spell out that user-visible change?

Would an explicit rejection of zero, or clamping in place with
max(min, roundup_pow_of_two(...)), address the undefined
roundup_pow_of_two(0) without altering which nonzero requests are
accepted?

>  	if (!netif_running(netdev)) {
>  		fbnic_set_rings(fbn, ring, kernel_ring);
>  		return 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915181229.4159158-1-bjorn%40kernel.org
