Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F538C415;
	Fri, 17 Jul 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301130; cv=none; b=qvNXoYX2Uat3ik0TnblW3H3WgQjddiOW6j46EgXpMK0ZOWCF93LYTS1qwb6n4J5blX3gUhJBb60QzAYxMgGPJZrbPTgkAox/n2ztE7A57vaAb5wCdUgBEOvfxf0ZbW7z0nVkNx1lo2vtpc748GIxhAfxbNigLha+242PKP02XaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301130; c=relaxed/simple;
	bh=nhVOjywwZu7BDBsNp2U/oUkqWwXAtEc6SlJ5GVIHxx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U39aPesGWfxVCf5XdJkigYkeQMRwZ6D79UmKSSs1z43cCXEgAmgJL5b6mVtQb3/He4jLAFMuPUkVscJ2jym3nIbw/MDaxF2tdvQt5ZUuCcOlekVruZAjt6sjan+potp1xtiY3URJcBUDPvRqZmKIsfcjUeRrzXeIPZIN7iSZuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BClwOKxD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BClwOKxD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JcuaVS4d0jHhPGA+tmG0IKf2qqxm5Qrp56BEdeR4eWU=; b=BClwOKxD6C0YzFKsQGt8k+juRm
	5btQUJ1UCrHjS8LGYXDnKro8uIRQXCA+hphCL6ZwLTeny3G0Wk6s48cSSGp0CAJONYJkqmHpgh3wa
	biDuOSwEChZQWNkVIXlEDg2sgQCDK+cVfRPFM6OWHOf1TVTeIFa16zMxw0tyjfMFpuyU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkkEG-00CpT9-R0; Fri, 17 Jul 2026 17:11:56 +0200
Date: Fri, 17 Jul 2026 17:11:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [Patch net-next v3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <06a5b8d1-f3a5-40e9-af12-52c5c9fd99e6@lunn.ch>
References: <20260717054807.1321374-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717054807.1321374-1-kyle.switch@motor-comm.com>

> +/**
> + * ytphy_read_top_ext() - read a PHY's top extended register for YT8824
> + * @phydev: a pointer to a &struct phy_device
> + * @regnum: register number to read
> + *
> + * NOTE:The caller must have taken the MDIO bus lock.

Didn't i request this is done in code, not comments?

> +static int ytphy_read_top_ext(struct phy_device *phydev, u16 regnum)
> +{
> +	struct yt8824_shared_priv *shared_priv;
> +	unsigned int offset;
> +	int ret;
> +
> +	shared_priv = phy_package_get_priv(phydev);
> +	offset = shared_priv->offset;
> +	ret = __phy_package_write(phydev, offset, YTPHY_PAGE_SELECT, regnum);

You look to be using the package wrongly.

https://elixir.bootlin.com/linux/v7.1.3/source/drivers/net/phy/phy_package.c#L192

 * The base_addr parameter serves as cookie which has to have the same values
 * for all members of one group and as the base PHY address of the PHY package
 * for offset calculation to access generic registers of a PHY package.
 * Usually, one of the PHY addresses of the different PHYs in the package
 * provides access to these global registers.
 * The address which is given here, will be used in the __phy_package_read()
 * and __phy_package_write() convenience functions as base and added to the
 * passed offset in those functions.

Although it is called base, it can be above all the others. So when
you create the package, set the cookie value to your top address. You
can then use __phy_package_write() directly, offset of 0.

> -static struct phy_driver motorcomm_phy_drvs[] = {
> -	{
> -		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
> -		.name		= "YT8511 Gigabit Ethernet",
> -		.config_init	= yt8511_config_init,
> -		.suspend	= genphy_suspend,
> -		.resume		= genphy_resume,
> -		.read_page	= yt8511_read_page,
> -		.write_page	= yt8511_write_page,
> -	},

I still don't like this. Please stop diff deleting all these and
putting them back later. It makes me thing something changed, maybe
white space?

> +static int yt8824_utp_softreset_paged(struct phy_device *phydev,
> +				      int reg_space)
> +{
> +	int old_page;
> +	int ret = 0;
> +	int val;
> +
> +	old_page = phy_select_page(phydev, reg_space);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +	if (reg_space == YT8824_RSSR_UTP_SPACE) {
> +		ret = __phy_read(phydev, MII_BMCR);
> +		if (ret < 0)
> +			goto err_restore_page;
> +		ret |= BMCR_RESET;
> +		ret = __phy_write(phydev, MII_BMCR, ret);

So here you are using __phy_write() so it does not take the mdio lock.

> +		if (ret < 0)
> +			goto err_restore_page;
> +		/* wait until softreset done. */
> +		ret = phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
> +					    50000, 600000, true);

This uses phy_read(), so does take the lock.

How can this be correct?

Please take some time to think about locking. Please enable all the
locking debug options in the kernel and see if you get splats. And
also really do turn your locking comments into code.

    Andrew
