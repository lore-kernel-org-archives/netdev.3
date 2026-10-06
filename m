Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351BE45C6FC;
	Tue,  6 Oct 2026 13:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291998; cv=none; b=MhePL5Lwp1M+JWvnSKq2gbaZWXSIYd4XF4prPIwZCkWexDLKAQ+V1aoSBGkDkPI7IblYMuN7Y/gDXA2zJsH7Tys7PL1jOV5Ldt9nEXKvTdbrPO0qwseGapwRBudaLuFcnqqyzF44eisBJKHRSRfgrJlvoDeXWSO9ej2hlQiWxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291998; c=relaxed/simple;
	bh=zhOu27oxfzwSiANFlhZ2HvPrHAiETkc90ajbDcCfLBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crngz9MYagxW501nTZYg5c3dSzpOPb89Wg8kuNXPYPDkQz5mauCORjkUUtcaFGmWZfMEwxEMj0Hlar8dUtvWhH6gTlv+GimMoLYYdln5v2PiYq/5ghrFcn4XmvjvxNpNiC0KcCvGwX4G9mgubNAZGQsf19ApLAZBP7ULxPVBnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uZ3Ug/lK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uZ3Ug/lK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6pVnrxOROFVOkwWfQdTsRuJM4AJzKzSq0bMpts2rh5I=; b=uZ3Ug/lKmjg81E6zeai+YA2uKL
	oHBQ96jo/Zvlz+JrKSMlD77HI2rkFviDHcBL7T3sNk7KYjMArkFYEDYmRwAJ20mm0MlBJpje9i1Wc
	JpgsLli4Yr13TPQFJcEpSxIoJeqgj0eerqWVLwPU/dPaZgyCarIH83K0eWhKWywn5fv0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xE4sC-009GSp-Rl; Tue, 06 Oct 2026 15:06:24 +0200
Date: Tue, 6 Oct 2026 15:06:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani.Rajagopal@onsemi.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <pier.beruto@onsemi.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 09/11] net: phy: ncn26000: Support for
 loopback
Message-ID: <344be351-656f-4e02-8c33-d9dde6bf80b1@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-9-7e011aacc309@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-s2500-mac-phy-support-v8-9-7e011aacc309@onsemi.com>

> @@ -2775,6 +2775,26 @@ int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
>  }
>  EXPORT_SYMBOL(genphy_write_mmd_unsupported);
>  
> +/**
> + * genphy_loopback_fixed_speed - Helper to modify the PHY loopback mode
> + * without affecting any other settings.
> + * @phydev: The phy_device struct
> + * @enable: Flag to enable or disable the PHY level loopback.
> + * @speed: Speed setting. Not expected to be set. Error if it is set.
> + *
> + * Returns: 0 if successful, negative error code on failure.
> + */
> +int genphy_loopback_fixed_speed(struct phy_device *phydev, bool enable,
> +				int speed)
> +{
> +	if (enable && speed)
> +		return -EOPNOTSUPP;
> +
> +	return phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK,
> +			  enable ? BMCR_LOOPBACK : 0);
> +}
> +EXPORT_SYMBOL(genphy_loopback_fixed_speed);

Please could you place it next to genphy_loopback()

> +
>  int genphy_suspend(struct phy_device *phydev)
>  {
>  	return phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 7c5098a0dd6c..c1b9bc305c82 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -2327,6 +2327,8 @@ int genphy_read_mmd_unsupported(struct phy_device *phdev, int devad,
>  				u16 regnum);
>  int genphy_write_mmd_unsupported(struct phy_device *phdev, int devnum,
>  				 u16 regnum, u16 val);
> +int genphy_loopback_fixed_speed(struct phy_device *phydev, bool enable,
> +				int speed);

and this next to genphy_loopback().

	Andrew
