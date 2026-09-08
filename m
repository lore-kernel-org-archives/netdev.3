Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3B2EC57C;
	Tue,  8 Sep 2026 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875556; cv=none; b=ULDFBxST7OyzzG/kRLMN1pTdfQlRXnqp+/ZAa+cJh2m/E+FADlGdkphnkxfZ9EsT64CTzxhDaB36VAbs5DjxhCOnBspGu/PyJWtWoZYgul4l25eEiw8EZ6a52I7j1DL0qJklQP14HHfRda6PumQr7tqZGb8WDXE/BG6OLmm/Mj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875556; c=relaxed/simple;
	bh=YQzSOrb6cF+q4UjJOTZpHg5tKXZxtJ7bqpsBK6wGFiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp7WAMXP7Nn7vj7QMDgtcr+tLauMJyTr0gFj8FQKI3cbGWOahV1ofubdsI2JdOzIDPANGaE6BVA9ZP93lw8OpS+CpsbZT2naJQJF2SWZ1rSiDeHW7L9HeZyxXihGudRNYr2nfFT17FbDb3+wOgciCQUrp+UEIYgcWXcHFwupaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gez3hxu8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gez3hxu8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VAXatVKGahitIUlqFkVj2QcQX1N1ATM06SDkNFJyLQ4=; b=Gez3hxu8ldF098qehu+vYdRXv7
	iwPSK7oxGamRMi1ZkTPWAfhNFjfteuEP8KsuvWz8vgUv6T7SLLR/IavF1xqL8xYvyriN2lC/HInR6
	Vg/j5qOOzVmgPqboO+SBUYbeqgmU49RgVDQw2wzKsPLXfD64ON1cqkyhkLzf6FUMdMTs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3wF7-003uBS-95; Tue, 08 Sep 2026 15:52:09 +0200
Date: Tue, 8 Sep 2026 15:52:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yury Norov <yury.norov@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org,
	Yury Norov <ynorov@nvidia.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/9] net: phy: use linkmode operation return values in
 phy_device.c
Message-ID: <67ed1522-cec8-4137-85df-ffbae654e07c@lunn.ch>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-8-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907215439.409858-8-ynorov@nvidia.com>

> -	linkmode_and(sfp_support, port->supported, caps->link_modes);
> -	if (linkmode_empty(sfp_support)) {
> +	if (!linkmode_and(sfp_support, port->supported, caps->link_modes)) {
>  		dev_err(&phydev->mdio.dev, "incompatible SFP module inserted, no common linkmode\n");

From a readability perspective, i like linkmode_empty(). It is more
obvious than !linkmode_and().

None of this code is in the hot path. So we should put readability
above performance. 

>  	/* Some PHYs may advertise, by default, not support EEE modes. So,
>  	 * we need to clean them. In addition remove all disabled EEE modes.
>  	 */
> -	linkmode_and(phydev->advertising_eee, phydev->supported_eee,
> -		     phydev->advertising_eee);
> -	linkmode_andnot(phydev->advertising_eee, phydev->advertising_eee,
> -			phydev->eee_disabled_modes);
> -
>  	/* There is no "enabled" flag. If PHY is advertising, assume it is
>  	 * kind of enabled.
>  	 */
> -	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
> +	phydev->eee_cfg.eee_enabled =
> +		linkmode_and_andnot(phydev->advertising_eee,
> +				    phydev->advertising_eee,
> +				    phydev->supported_eee,
> +				    phydev->eee_disabled_modes);

So, which is more readable, the original or this?

	Andrew
