Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9C94746A5;
	Fri, 25 Sep 2026 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377783; cv=none; b=Zp1knBvyjABEJmoZ1qrWtdt0l05Ps9lUiztpcaehYGKaVGRh8KxySmnD7v42fCFjL6by7LrnnR6Xynw8VbpGhjqe97fHYDqQ/NpzmdUZucibcl6acjjetz1WC85G93pbkoLL7Qi7gzsVr5tcYvy99WPVjNH3NcPyYOdh9BNmN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377783; c=relaxed/simple;
	bh=s1ZM1uqZ03nEW1Q1bfUvFjYe94kCYE4894JFbUlF4Ic=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WNl2BQtEPfAvZ+Pz/myxG2Svq+44A4toKzGAse5YxBTcgp+T02INeVIHFDlpjrQmCLckPtbmmQ0qtkRafwvTKMm0Gv51xPvW95ptdmRl53BtRxTtgHJGQ7/SLxrwb1Qd7usOnPky0pW7zKdnj38ghKDdMhF4u2+YGszLedw+w+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckRyjtLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckRyjtLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDC81F00893;
	Fri, 25 Sep 2026 23:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377781;
	bh=GcWfYkzOOhtvkvYpWSGfJpCOE6dPzj6GDPKW9yEk4A4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ckRyjtLJbscKqYniuxavK+5BOGH3UzNrib8yBVlHvnYgoAQTq6kEP08wKrT60v0oj
	 LDCAvNGRo7g+ApRMFkQNB1sNwAUsKei5GLIAx7uSecOREb9LIJK1EAubZ84HBXSVRl
	 r81DkhbfNgUOElRaCyxq6Gh+/BTNuupebc+3LUmGive6QquqrglFGhmAlvfuz+OY+K
	 NLKuX2Vb6zswpCZ3/hCe/pE3ATd5nwiNZXGNtvjLNJwNHf/gDx1AgiyjgKSCNW3r2e
	 4fXhzLps/obB1jImLagIQfQT0jOq+LSo+cHarf9DRZs4U9qBpOm+Q6uPytHMhtVRKD
	 3HHUdlLKvBBNg==
Subject: Re: [PATCH net v2 4/5] net: bcmgenet: validate Ethernet address in
 bcmgenet_set_mac_addr
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, nb@tipi-net.de, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 23:09:40 +0000
Message-ID: <179037778070.2160803.14102576528369806489@kernel.org>
In-Reply-To: <20260921220021.281418-5-florian.fainelli@broadcom.com>
References: <20260921220021.281418-5-florian.fainelli@broadcom.com>
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

- [Low] bcmgenet_set_mac_addr()
  (drivers/net/ethernet/broadcom/genet/bcmgenet.c:3628-3644) now hand-…

--

net: bcmgenet: validate Ethernet address in bcmgenet_set_mac_addr

This adds an is_valid_ether_addr() check to bcmgenet_set_mac_addr() so
that an invalid MAC address (all zeroes, or a multicast address) is
rejected with -EADDRNOTAVAIL instead of being programmed while the
interface is down.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index bfb74dca55d6f..e9d9d3d7b6369 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3634,6 +3634,9 @@ static int bcmgenet_set_mac_addr(struct net_device *dev, void *p)
>  	if (netif_running(dev))
>  		return -EBUSY;
>  
> +	if (!is_valid_ether_addr(addr->sa_data))
> +		return -EADDRNOTAVAIL;
> +
>  	eth_hw_addr_set(dev, addr->sa_data);
>  
>  	return 0;

[Severity: Low]
This isn't a bug, but with this hunk bcmgenet_set_mac_addr() now open-codes
exactly what the core helpers already do.

net/ethernet/eth.c:

	int eth_prepare_mac_addr_change(struct net_device *dev, void *p)
	{
		struct sockaddr *addr = p;

		if (!(dev->priv_flags & IFF_LIVE_ADDR_CHANGE) && netif_running(dev))
			return -EBUSY;
		if (!is_valid_ether_addr(addr->sa_data))
			return -EADDRNOTAVAIL;
		return 0;
	}

	void eth_commit_mac_addr_change(struct net_device *dev, void *p)
	{
		struct sockaddr *addr = p;

		eth_hw_addr_set(dev, addr->sa_data);
	}

The resulting body of bcmgenet_set_mac_addr() is then equivalent to
eth_mac_addr(). Would calling eth_prepare_mac_addr_change() followed by
eth_commit_mac_addr_change() (keeping the driver-specific comment about the
UniMAC RX/TX enable bits) be preferable to duplicating the validation here?

One small difference: the driver copy tests netif_running() unconditionally
and so does not honour the IFF_LIVE_ADDR_CHANGE exemption that the core
helper checks. bcmgenet does not set that private flag today, so there is no
behavioural change now, but the duplicated checks will not track future
changes to the core validation rules.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921220021.281418-1-florian.fainelli%40broadcom.com
