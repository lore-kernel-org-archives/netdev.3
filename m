Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B58348C6B;
	Fri, 16 Oct 2026 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185170; cv=none; b=URquqrl97N0ZrUyromNlu9YH1wp8A8J4UOrGfchhwJfHzSSlTVujIxcJ7rhdi/5CUpyVBaNbH4lAOLEhy9ZnQVn0psT6OoEH+EVh17otD4We3z2Plx2iSiwnxnmF7SBRgWxYOpLAGh+AUjQ86QHJ6ocCPPpJn9EFDh/j3WqfzXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185170; c=relaxed/simple;
	bh=xEDBDZLnCA1TaZqZJKoAlK6nDOVbDceU/MIop2KkYeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JlIvzluUU8shsUA4e8qhZbZElIUcwxy5890MJOATIWDLJvxCxBl1mBdZ/tM7TrhwMwfNMLMIsWaePf6aVr+akdX2s4PRT8ovJSpBv2hi4PQo2G+Pwe09eRE9ET281kdIeLKp6wCbG8pQ/O6OV7YFBzR+qt+IfClxk9X15cJKiJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=olJw8sxb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="olJw8sxb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xzkj/ZBHK+z7M4G04Cm+Pn9IBQkeIvv/Jc//KeKDVZk=; b=olJw8sxbieC1HTdPa0kHf0eGnc
	HTqN7iFZDlQEOx08ZBDM0oe2CHW/6z0gnYl83w9N4VZPHZxD20KrFM6VhuVNcXXKaZ7lrQItC9saC
	Petg2DVXdZWVonrEqF1jGKlNztXv9Wycn7IiNH+NmATARJFRVWiJrbkrFIbddbIdpV5s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHpEF-00BE90-HA; Fri, 16 Oct 2026 23:12:39 +0200
Date: Fri, 16 Oct 2026 23:12:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lxu@maxlinear.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, michael@walle.cc,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lrosu@maxlinear.com,
	luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v2 2/5] net: phy: mxl-gpy: add MxL86211C VDDP
 supply
Message-ID: <5d2c866f-9c01-4f9b-b50f-ec95696fa2ef@lunn.ch>
References: <20261016112033.949026-1-robert.marko@sartura.hr>
 <20261016112033.949026-2-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016112033.949026-2-robert.marko@sartura.hr>

> +static int mxl86211c_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct gpy_priv *priv;
> +	struct regulator *vddp;
> +	int ret;
> +
> +	vddp = devm_regulator_get(dev, "vddp");
> +	if (IS_ERR(vddp))
> +		return dev_err_probe(dev, PTR_ERR(vddp),
> +				     "failed to get VDDP supply\n");
> +	if (!vddp)
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "VDDP supply requires regulator support\n");
> +

>  static bool gpy_sgmii_need_reaneg(struct phy_device *phydev)
>  {
>  	struct gpy_priv *priv = phydev->priv;
> @@ -1406,7 +1467,7 @@ static struct phy_driver gpy_drivers[] = {
>  		.name		= "Maxlinear Ethernet MxL86211C",
>  		.get_features	= genphy_c45_pma_read_abilities,
>  		.config_init	= gpy21x_config_init,
> -		.probe		= gpy_probe,
> +		.probe		= mxl86211c_probe,

This is an existing device. You cannot add required new DT parameters,
that would break backwards compatibility. Anything you add news to be
optional.

    Andrew

---
pw-bot: cr
