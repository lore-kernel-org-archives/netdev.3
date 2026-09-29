Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3280551A158;
	Tue, 29 Sep 2026 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684298; cv=none; b=coZVE1aVo9bb/tDoH6FdYIGiiQrvPcWB5HXlK4lBQMDXnRD21U24mPv6Ki5s7WmQDic6O3yTo358V9ptjjQB8ChFWoDsblJFcJgEfZn0U0CF55SiyB/swrPD082M74VHnN3TpuB57+zIDOstVbElE22uoTjhjmf5OwM+6TLMOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684298; c=relaxed/simple;
	bh=0JGQeMPMPO2ba6FkpsntALtINcAAtIQ29jf29yZc01w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/eiQMMJJR3QnRivqgkZzHT6gHHA6FUoUJvDMfzOcN6x1FwjRhksBi4sQCK9gWfyY0dRltEbD5TMrp1/jN/AH9kTPHJq108PmuKy7o4FSQA4wvm6LEfgodzqpfC2zje6t9Av3+o6t0kjYYBgXqX4air7Qmcmobbvxeu8dTpDvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cB5e6107; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cB5e6107"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MenmzKidbrS8g6QcaYPj8r8h1pcZL69WHf+rdGKbdgE=; b=cB5e6107Mn0xqXNeQESHNs/94+
	qRDZEFIjloJKLScJ8tzJKsK4k2BTOaA4y7w3RUR/z5E/6N0M+VqTI7TLNw81Oe1comx20+Sf0NzV+
	goSx/RTB3tEZWITHOzxNzcIrGgFbVMODtP3MtPt6Ej4cvOYyiHH82/0caQ84evbAIEmo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBWmd-007wfH-OL; Tue, 29 Sep 2026 14:18:07 +0200
Date: Tue, 29 Sep 2026 14:18:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Frank.Sae@motor-comm.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [PATCH net-next v22 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <0eb0fe92-86c0-425d-8002-a7ce448ba751@lunn.ch>
References: <20260929095430.508657-1-kyle.switch@motor-comm.com>
 <20260929095430.508657-4-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929095430.508657-4-kyle.switch@motor-comm.com>

> +static int yt8824_restore_working_status(struct phy_device *phydev, int ret)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int r;
> +
> +	/* configure normal test mode */
> +	r = yt8824_utp_set_template_test_mode
> +		(phydev, MDIO_PMA_10GBT_TESTMODE_NORMAL);

The opening ( should be on the line before. The phydev as well.

> + * yt8824_soft_reset() - called to do PHY software reset
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_soft_reset(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +
> +	mutex_lock(&priv->shared_lock);
> +	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		/* test mode 1 */
> +		ret = yt8824_utp_set_template_test_mode
> +			(phydev, MDIO_PMA_10GBT_TESTMODE_1);

Please look through the code and fix all these problems.

Also, what value does the comment have?


> +		if (ret < 0)
> +			goto retry;
> +		ret = yt8824_utp_softreset_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +		/* normal mode */
> +		ret = yt8824_utp_set_template_test_mode
> +			(phydev, MDIO_PMA_10GBT_TESTMODE_NORMAL);

And this comment? You only need comments if the code is not
obvious. The name of the function is often sufficient to explain what
is happening. 

> +	/* pll calibration */
> +	ret = ytphy_write_ext_with_lock(phydev, 0x0001, 0x0003);
> +	if (ret < 0)
> +		goto err_restore;

This comment is useful, it is not possible to know what 0x0001,
0x0003 means.

> +	ret = ytphy_write_ext_with_lock(phydev, 0xa20e, 0x0cba);

and this is just magic. Which is why we recommend #define, not magic
numbers.

> +	/* power down */
> +	ret = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
> +	if (ret < 0)
> +		goto err_restore;
> +	ret = ytphy_write_ext_with_lock(phydev, 0xa20e, 0xcba);

You comment about the obvious power down, but nothing about what this
magic does :-(

	Andrew
