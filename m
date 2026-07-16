Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B57039B969;
	Thu, 16 Jul 2026 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222182; cv=none; b=tThdW7t0oa7JyC/W8kv8QHH3di206WMPQYM21jZcLOIYW8VxpfZZfuH8orzimb8RG6iev8rSIy6BLjm+codwOdSkevRmLfHwoDXhb8LE+S4V+H6d26SFBMFh6zzDXn8oumeaB1OrlP5wcSl2mlmYSgd9ZZ5mndeamtKJ3J0cvWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222182; c=relaxed/simple;
	bh=qmEikZ1WceGlarCo8ksMA+4s9OZujq3vhfdB8wg6w0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTjFptOGLjmRm5CJbAc/jNu6xJCU6w47xZQY+u3QF6wSP3C0oNomhNI57ck3u6WcKaovrkFgXnzVy1LE9N4ezqwnI0t19auhuicku2oHHLbeCn4meN1xBjDpIMMv6MIePXOHjPrjcfg9g55esy1bXG07WkLN1AbZMAMxIbFoerk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e5xvgILB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e5xvgILB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Di7b29Q27a+Ub4UTiW9pTXKPNbUHl8HkTkwrlXnqZPc=; b=e5xvgILBG5MmIktSbn6fcvHO9F
	60nuv9xHZRddP5DYej7JlNrcBRntqFT0RE7Toqz1HBoJTaA5OK7OGUTQ2plGhAYo5ZcjPo3HBcO7B
	rLzKnmIgLsndQQZTI2/1WmzZJDkariTg7GmPpj1Ty5OVCF9jheNDbzwtPOZ9eTjRXr/A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkPgx-00CatK-OH; Thu, 16 Jul 2026 19:16:11 +0200
Date: Thu, 16 Jul 2026 19:16:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianmin.wang@motor-comm.com,
	xiaolin.xu@motor-comm.com, ming.xu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [Patch net-next v2 2/2] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <6bb415f2-5e41-4002-90e5-3d37d881b391@lunn.ch>
References: <20260715121012.1113552-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715121012.1113552-1-kyle.switch@motor-comm.com>

> +#define YT8824_RSSR_SPACE_MASK			BIT(0)
> +#define YT8824_RSSR_FIBER_SPACE			(0x1)
> +#define YT8824_RSSR_UTP_SPACE			(0x0)

Since there are only two pages, one bit:

> +/**
> + * yt8824_read_page() - read reg page
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * returns current reg space of yt8824 (YT8824_RSSR_FIBER_SPACE/
> + * YT8824_RSSR_UTP_SPACE) or negative errno code
> + */
> +static int yt8824_read_page(struct phy_device *phydev)
> +{
> +	int old_page;
> +
> +	old_page = ytphy_read_top_ext_with_lock(phydev, YT8521_REG_SPACE_SELECT_REG);
> +	if (old_page < 0)
> +		return old_page;
> +
> +	if ((old_page & YT8824_RSSR_SPACE_MASK) == YT8824_RSSR_FIBER_SPACE)
> +		return YT8824_RSSR_FIBER_SPACE;
> +
> +	return YT8824_RSSR_UTP_SPACE;

You can simplify this to just

    return old_page & YT8824_RSSR_SPACE_MASK;

> +static int yt8824_write_page(struct phy_device *phydev, int page)
> +{
> +	int old_page;
> +	u16 data;
> +
> +	old_page = ytphy_read_top_ext_with_lock(phydev, YT8521_REG_SPACE_SELECT_REG);
> +	data = old_page & (~(0x1));

Use YT8824_RSSR_SPACE_MASK here.

> +	data |= page;
> +
> +	return ytphy_write_top_ext_with_lock(phydev, YT8521_REG_SPACE_SELECT_REG, data);
> +};
> +
> +/**
> + * configuration YT8824 to one template test mode.
> + */
> +static int yt8824_soft_reset_step1_paged(struct phy_device *phydev,
> +					 int reg_space)
> +{
> +	int old_page;
> +	int ret = 0;
> +
> +	old_page = phy_select_page(phydev, reg_space);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	if (old_page >= 0) {

What is the purpose of this if ()?

> +		if (reg_space == YT8824_RSSR_UTP_SPACE) {
> +			ret =  __phy_write_mmd(phydev, 0x1, 0x0084, 0x2000);

No magic numbers. 0x0084 is probably not a vendor register either, so
please use its proper name. And is 0x2000 a value, or should it bit it
use the BIT() macro?

> +			ret = __phy_read(phydev, MII_BMCR);
> +			if (ret < 0)
> +				goto err_restore_page;
> +			ret |= BMCR_RESET;
> +			ret = __phy_write(phydev, MII_BMCR, ret);
> +			if (ret < 0)
> +				goto err_restore_page;
> +			do {
> +				msleep(50);
> +				ret = __phy_read(phydev, MII_BMCR);
> +				if (ret < 0)
> +					goto err_restore_page;
> +			} while ((ret & BMCR_RESET) && --retry);


> +			ret = __phy_read(phydev, MII_BMCR);
> +			if (ret < 0)
> +				goto err_restore_page;
> +			/* disable isolation */
> +			ret &= ~BIT(10);

That is probably a standard BMCR bit, so there should be a#define for
it.

> +			/* soft reset */
> +			ret |= BMCR_RESET;
> +			ret = __phy_write(phydev, MII_BMCR, ret);
> +			if (ret < 0)
> +				return ret;
> +			do {
> +				msleep(50);
> +				ret = __phy_read(phydev, MII_BMCR);
> +				if (ret < 0)
> +					goto err_restore_page;
> +			} while ((ret & BMCR_RESET) && --retry);
> +			if (ret & BMCR_RESET)
> +				goto err_restore_page;

Look at all the duplicated code here. Please add some helpers.
Also take a look at phy_device.c, and follow what it does.

> +	if (phydev->interface == PHY_INTERFACE_MODE_INTERNAL) {
> +		/* invalid test mode */
> +		ret = yt8824_soft_reset_step1_paged(phydev,
> +						    YT8824_RSSR_UTP_SPACE);

Why not call this function
yt8824_soft_reset_invalid_test_mode_paged(). Having the comment is a
big hint your function naming is bad.

> +static int yt8824_internal_config_init_paged(struct phy_device *phydev,
> +					     int reg_space)
> +{
> +	struct yt8521_priv *priv = phydev->priv;
> +	int old_page;
> +	int port = 0;
> +	int ret = 0;
> +
> +	old_page = phy_select_page(phydev, reg_space);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	port = phydev->mdio.addr - priv->phy_base_addr;
> +	ret = ytphy_write_ext(phydev, 0x1, 0x3);
> +	if (ret < 0)
> +		goto err_restore_page;
> +	ret = __phy_write(phydev, MII_BMCR, 0x1900);

All the magic numbers need to be replaced. But this is especially bad,
because BMCR is well documented and has all its bits covered with
existing #define's.

> +	netdev_info(phydev->attached_dev,
> +		    "%s done, phy addr: %d, phy base addr = %d\n",
> +		    __func__, phydev->mdio.addr, priv->phy_base_addr);

Very unusual. This is a PHY driver, so it should be using
phy_info(). But i also think this should be _dgb().

	Andrew
