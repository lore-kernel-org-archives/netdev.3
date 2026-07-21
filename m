Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9A396585;
	Tue, 21 Jul 2026 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643554; cv=none; b=T49c/wQ/hHSIij4E8EjmGksaVy000GobIlebAF5gCOBcvxrE7kT6OM74wx4jOEi905cxeJwnqRHrPM/e83m6vnJb4it12ILrZ7IzrjvP6jYxN+MW+lmzPQ5fInGb6Q+mO3IX/2usWHaTRoUNYnWQGuwjFoguGq6ji2oHg8vsQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643554; c=relaxed/simple;
	bh=qTI8WfH78BTeA3vSW5SYvP0UeE2B7kf40oFrD4FoKVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSlVaZGLavN5ChWs2164NnhA4rwnmYEHJwCyozm8h2KyripQfOJtXHJXnaKMwNk0AfGWAj0Rpx1GUPzbHtQ6gbZvIQQDMmZZ+30Tr/MOHAuAxhHQm9o9iFkr02AVnYCGmk1O7CNlmKWu8l0BmT4vmwHNsWC0vqwM1LRs0+JRpAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V9OfiOAc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V9OfiOAc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dg9L6LK7pNjj4ehhigz7jhjh3OZzyHlLyvvcCIFVCCQ=; b=V9OfiOAc24p043hQcDZYvsjMyA
	JGj/IW44YZw26mlNibAPEvfmEKm9xO4f3c5aNalri81xl+lpqYB61zTHAQ0vEJue4BZnt8OQRAZhb
	y6brtT+0gHmzXrcqjaxl0FhOLbVAx7ZH8OCZX/CI50aGY21MP0GS2F6XA/mAD5EqOgDQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmBJB-00DSgG-RQ; Tue, 21 Jul 2026 16:18:57 +0200
Date: Tue, 21 Jul 2026 16:18:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v5] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <d394347a-4162-49ea-b65a-c2e2bd3769aa@lunn.ch>
References: <20260721114810.660718-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721114810.660718-1-kyle.switch@motor-comm.com>

Just checking something here....

> +/**
> + * ytphy_write_top_ext() - write a PHY's top extended register for YT8824
> + * @phydev: a pointer to a &struct phy_device
> + * @regnum: register number to write
> + * @val: register val to write
> + *
> + * Returns: the value of regnum reg or negative error code
> + */
> +static int ytphy_write_top_ext(struct phy_device *phydev, u16 regnum,
> +			       u16 val)
> +{
> +	int ret;
> +
> +	lockdep_assert_held(&phydev->mdio.bus->mdio_lock);
> +	ret = __phy_package_write(phydev, 0, YTPHY_PAGE_SELECT, regnum);
> +	if (ret < 0)
> +		return ret;
> +
> +	return __phy_package_write(phydev, 0, YTPHY_PAGE_DATA, val);

The _top_ registers are in a different MDIO address, and are shared by
all PHYs within one package. Correct?

> +static int yt8824_write_page(struct phy_device *phydev, int page)
> +{
> +	int old_page;
> +	u16 data;
> +
> +	old_page = ytphy_read_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG);
> +	data = old_page & (~YT8824_RSSR_SPACE_MASK);
> +	data |= page;
> +
> +	return ytphy_write_top_ext(phydev, YT8521_REG_SPACE_SELECT_REG, data);

The page register is in a top register. So when accessing a paged
register, all other PHYs also get swapped to that page. And so it is
necessary to block all other PHYs from accessing registers, until the
paged access if completed?

If i have that right, that is an odd hardware design. Since this is an
odd design, it deserves to be documented. Locking is hard, and it is
made harder by not having good documentation about the design of the
locking scheme. 

> +	old_page = phy_select_page(phydev, reg_space);
> +	if (old_page < 0)
> +		goto err_restore_page;
> +
> +	if (reg_space == YT8824_RSSR_UTP_SPACE) {
> +		ret = __phy_read_mmd(phydev, 0x1,
> +				     YT8824_UTP_TEMPLATE_MODE_CTRL);

What address spaces are paged? Every other design i've seen only has
pages of C22 registers, since you only have 32 of them. But looking at
this code, does this hardware also page C45?

     Andrew
