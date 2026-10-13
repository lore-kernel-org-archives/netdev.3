Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B64189BA;
	Tue, 13 Oct 2026 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791856332; cv=none; b=aqofm6zCOFnHxQ5urfcaituPQG69BTBzFSzFEkCMRoPqLbSeOOOH4PYESVYFVwbYdc7cXb3n97MR8Jmh0zDjKcaQE8eXjSzWOgxlEngT+bJMToPgoH5Uw/y/tfUxPQe1zu7T1Yuffe5vOcA7ZJgI4RnpIbx6k4FNU6CvV+2Uppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791856332; c=relaxed/simple;
	bh=ub78VIex2rnxPMZMleJn9rZJme1N+g8OkfdlnypJ7jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz3SICWS+8s1qn1tA58kNSx+TJIGDcAilAmkW+TN8YwCkodEFh+ecHzAr0YN2If4oGWt0nYp+BJYpN3chAhaI76L0rXysOWwtjXnVaKamCO/t/NhFPKpctRpE98VheXQ4S0plj9TbCPy+DTuxVuLCMSRdnSzWf4EopTvg8tmZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rdOy0y+b; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rdOy0y+b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EFkxmZvJJs7CeSiO2J58mCcYEfBG1Dz8RCcKQBv4EX0=; b=rdOy0y+bh5YBb6Iv9D6HjhBoBr
	u1S3LdYPp7kU8lrSPhp6TiEy6qCSftM379Mm1qsJ7pXsC95YSr4oltyU6kOqUYOHAzHGSbqXdHw6v
	hkSFj04Wz1pukq+2PLndvT/LscvMCF43kwjGNSADnOoO/gh59y+V1gf36cbM5Bsq052g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGRgK-00AQVy-Ky; Tue, 13 Oct 2026 03:51:56 +0200
Date: Tue, 13 Oct 2026 03:51:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v14 5/5] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
Message-ID: <bc293fd1-4414-4d0e-9247-a5a91db90f15@lunn.ch>
References: <20261013011122.1889766-1-kyle.switch@motor-comm.com>
 <20261013011122.1889766-6-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013011122.1889766-6-kyle.switch@motor-comm.com>

> +++ b/drivers/net/dsa/motorcomm/mdio_bus.c
> @@ -299,3 +299,42 @@ int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
>  
>  	return 0;
>  }
> +
> +/* intif extend register read/write api */
> +int
> +yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 val)
> +{
> +	int res;
> +
> +	if (port > priv->series->max_ports)
> +		return -ENODEV;
> +
> +	res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
> +	if (res)
> +		return res;
> +
> +	res = yt921x_intif_write(priv, port, YT92XX_PAGE, val);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +int
> +yt921x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
> +{
> +	int res;
> +
> +	if (port > priv->series->max_ports)
> +		return -ENODEV;
> +
> +	res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
> +	if (res)
> +		return res;
> +
> +	res = yt921x_intif_read(priv, port, YT92XX_PAGE, valp);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}

Why are these in mdio_bus? They don't have anything to do with MDIO.

Since they build on yt921x_intif_read they seem to fit in yt921x.c
better? Or am i missing something?

> +static void yt922x_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
> +				 struct phylink_link_state *state)
> +{
> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
> +	int port = pp->index;
> +	int res = 0;
> +	u16 data;
> +	int addr;
> +	u16 lp;
> +
> +	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII);
> +	if (addr < 0) {
> +		state->link = false;
> +		return;
> +	}
> +
> +	mutex_lock(&priv->reg_lock);
> +	switch (state->interface) {
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_1000BASEX:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +		res = yt921x_intif_read(priv, addr, MII_BMSR, &data);
> +		if (res)
> +			goto err;
> +		res = yt921x_intif_read(priv, addr, MII_LPA, &lp);
> +		if (res)
> +			goto err;
> +		phylink_mii_c22_pcs_decode_state(state, neg_mode, data, lp);


Rather than data, call it bmsr. It then fits:

void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
				      unsigned int neg_mode, u16 bmsr, u16 lpa)

> +static void yt922x_pcs_an_restart(struct phylink_pcs *pcs)
> +{
> +	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
> +	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
> +	struct device *dev = to_device(priv);
> +	int port = pp->index;
> +	u16 data;
> +	int addr;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII);
> +	if (addr < 0) {
> +		res = addr;
> +		goto err;
> +	}
> +	res = yt921x_intif_read(priv, addr, MII_BMCR, &data);
> +	if (res)
> +		goto err;
> +	data |= BMCR_ANRESTART;
> +	res = yt921x_intif_write(priv, addr, MII_BMCR, data);

Again, bmcr. It then looks a lot like
phylink_mii_c22_pcs_an_restart().

> +	if (res)
> +		goto err;
> +	mutex_unlock(&priv->reg_lock);
> +	return;
> +
> +err:
> +	mutex_unlock(&priv->reg_lock);
> +	if (res)
> +		dev_err(dev, "Failed to %s PCS port %d: %i\n", "an restart",
> +			port, res);
> +}
> +
> +static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> +			     phy_interface_t interface,
> +			     const unsigned long *advertising,
> +			     bool permit_pause_to_mac)
> +{

advertising does not appear to be used here. Does this pcs not support
it? That would be odd, because you looked at lpa in earlier functions.

	Andrew
