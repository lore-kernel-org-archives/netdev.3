Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348593749E9;
	Thu, 20 Aug 2026 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237233; cv=none; b=UFr2LDXxndf1QEi2NBFFTL3hKk5wfRSMhipoJUNm5ycyDHlfPlWE6VDMfkrJjRrbh7RzwA0z3Gc+E4/wOHdszNAa3wH+91GHJ8oPvSDJUk7bDcX9KbF3hxyVB9j2HIvfIG11dGiEnvqDDdUTtdNSjlB8cN676R/sN/3u7fPGukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237233; c=relaxed/simple;
	bh=0wNsDk4sbm3wXUasKul18svlAhhbvr4k73JtfUuWU5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOS9xS9rRcY9beLQtYkmfkaF6cfMoQeuh/aODRKKrnCa048Mq+sV1QeHMmqGj0M7QC06E8DMR/fJs+xX2tdGMG7+z/pqU71WHWLPPkVWyasRn3ORqQCsyuP6+HlDBb80omzsuOD+G9YKl/fR2d5p3luyzs+yTTMhi+aa6Dz+VwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rZJT1Tnc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rZJT1Tnc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oRbEG7PaEfvjm2nhf698Hlc7tW99p1LGSFKLhBk84fo=; b=rZJT1Tnc4LRe335xYReSzXoFMZ
	lbykKhMATzWNX5lZN/+GCl6Mfduk/8b8ORn5MmV6TaZ4KWqvs3bDiDJh8uaStR1IXWFKktZ1zgoWj
	EidLNuKC8i5QqLfz1Tas+7NY1KECriylSu4HO6UXa0BQuNqIo+ZZQvR60ITaTZZ0c4Vg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wx42m-000neU-Ih; Thu, 20 Aug 2026 16:47:00 +0200
Date: Thu, 20 Aug 2026 16:47:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com
Subject: Re: [RFC net-next v2] net:dsa:yt922x: Add support for Motorcomm
 YT922x
Message-ID: <10c23416-dce1-4ec6-91bd-3e9eda9b18a3@lunn.ch>
References: <20260820080542.2017118-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820080542.2017118-1-kyle.switch@motor-comm.com>

>  drivers/net/dsa/Kconfig  |   7 +-
>  drivers/net/dsa/Makefile |   2 +-
>  drivers/net/dsa/yt921x.c | 819 ++++++++++++++++++++++++++++++++++++++-

That is a lot of new code. Please try to break it up into a number of
smaller patches, with good commit messages, which are obviously
correct.

Since this is a new device, it does not need to work with a big
bang. You can slowly add the needed bits, such that when the last
patch is merged the device is functional.

> +#define YT922X_INTERNAL_SDS1_PHYADDR 0
> +#define YT922X_INTERNAL_UTP0_PHYADDR 4
> +#define YT922X_INTERNAL_UTP1_PHYADDR 5
> +#define YT922X_INTERNAL_UTP2_PHYADDR 6
> +#define YT922X_INTERNAL_UTP3_PHYADDR 7
> +#define YT922X_INTERNAL_SDS0_PHYADDR 8

These don't seem to be used. Generally, a MAC driver does not need to
know the mapping to PHY addresses, the phandles in the DT indicates
it.

>  static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
>  {
>  	struct yt921x_priv *priv = mbus->priv;
> +	int max_ports;
>  	u16 val;
>  	int res;
>  
> -	if (port >= YT921X_PORT_NUM)
> +	max_ports = priv->series_info->ports;
> +	if (port >= max_ports)

This sort of code change would make a nice simple patch. Change all
current instances of YT921X_PORT_NUM to priv->series_info->ports. Easy
to review.

> @@ -4748,6 +4766,13 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
>  	struct device_node *child;
>  	int res;
>  
> +	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
> +		struct yt921x_port *pp = &priv->ports[i];
> +
> +		pp->index = i;
> +		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
> +	}

This should be a patch, with an explanation why it is needed. Also
please take a look at ethtool -c stats-block-usecs, which indicates
how out of date the statistics are. It is currently not well
supported, i only learned of it recently, but setting it will help you
get the self tests passing.

> +static void
> +yt922x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
> +			     phy_interface_t interface)
> +{
> +	struct dsa_port *dp = dsa_phylink_to_port(config);
> +	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
> +	int port = dp->index;
> +	int res;
> +
> +	mutex_lock(&priv->reg_lock);
> +	res = yt922x_port_down(priv, port);
> +	mutex_unlock(&priv->reg_lock);
> +
> +	if (res)
> +		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring down",
> +			port, res);
> +}

This appears to be a cut/paste of
yt921x_phylink_mac_link_down(). Don't do that. Refactor existing
functions to make them generic.

> +static int yt922x_port_sds_init(struct yt921x_priv *priv, int port,
> +				phy_interface_t interface)
> +{
> +	int addr;
> +	u16 data;
> +	int res;
> +
> +	addr = yt922x_sds_phyaddr_get(port,
> +				      YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
> +				      YT922X_PHY_REG_SPACE_SGMII);
> +	if (addr < 0)
> +		return -EINVAL;
> +	/* write protect */
> +	res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
> +	if (res)
> +		return res;
> +	/* CDR */
> +	if (interface == PHY_INTERFACE_MODE_100BASEX) {
> +		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x0);
> +		if (res)
> +			return res;
> +		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x3458);
> +		if (res)
> +			return res;
> +	} else {
> +		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x800);
> +		if (res)
> +			return res;
> +		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x4558);
> +		if (res)
> +			return res;
> +	}
> +	/* PLL */
> +	if (interface == PHY_INTERFACE_MODE_USXGMII) {
> +		res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x1006);
> +		if (res)
> +			return res;
> +		res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3029);
> +		if (res)

What is this function doing?

    Andrew

---
pw-bot: cr
