Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D023284D29;
	Wed, 18 Dec 2024 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491619; cv=none; b=dZivpsjYaI+9nArilHxhK6Ppq65et2b2jprwbapPuAGNUFkLlZbR7njEuZ5sYrp6Dnh11OYPLaAFOASFtzK/vKL5l2fkuoTb7UEJHQ51j6VOeSM8Rlj2nLmT08rAh9jEDWci/xdOy2NAVGB/EoEE19Vr0rvfA5hXZmB47bNpH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491619; c=relaxed/simple;
	bh=UOtdAZS/7C5uGHpW+JSybdHqlBYp1DwMs/EcAnIy6fo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u/jlDEwH+3KK7QdOTkD1kjr6NEKwBcTO1QCPATW5uc0tuKuRGLNuJxzkL0zyIkwTkanubVpqwkQtMnebvLjYS8eoqgjqqD+jBLF57ixeh1jbP4NWB5D9oY92rIVRsKDOGF6jjAgI2QAJ3/amQog57lY1/MPZQcQi/nbDMMgZIsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYZ9PYMr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYZ9PYMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B98C4CED3;
	Wed, 18 Dec 2024 03:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734491619;
	bh=UOtdAZS/7C5uGHpW+JSybdHqlBYp1DwMs/EcAnIy6fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYZ9PYMrGaxeGqOv7d5stY+JwTaksBuxIxz/+8Vzu5yXxvCq2X0CcteLTRVZeOj7z
	 NX61egzZbH9MXUkRnLdlGnITLaI06OKSsc1d0sleHyQ7iBo+iravxDArpikZnAVUlc
	 o1eKTWlIfnaynyCATDTmjyMdfVZwDty8oIaXlBihG4FX76xUBIZ4uDkR2S/iNJLPbx
	 yYcPefzMLPF6CkT4aqczu94/ux19fj+shAPMJmoLO8hMrnAr5VQZBj8he8E/m5F20S
	 gpLFO9cnFbHqpU1ydHQOruGiisdArA1f8+yEHgf+rpcK8cdKkrHHrPqPeseU6u+3Vf
	 zRwtUsKUUvP9Q==
Date: Tue, 17 Dec 2024 19:13:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v7 5/5] net: phy: microchip_t1 : Add
 initialization of ptp for lan887x
Message-ID: <20241217191337.717be46a@kernel.org>
In-Reply-To: <20241213121403.29687-6-divya.koppera@microchip.com>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
	<20241213121403.29687-6-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 17:44:03 +0530 Divya Koppera wrote:
>  static int lan887x_phy_init(struct phy_device *phydev)
>  {
> +	struct lan887x_priv *priv = phydev->priv;
>  	int ret;
>  
> +	if (!priv->init_done && phy_interrupt_is_valid(phydev)) {
> +		priv->clock = mchp_rds_ptp_probe(phydev, MDIO_MMD_VEND1,
> +						 MCHP_RDS_PTP_LTC_BASE_ADDR,
> +						 MCHP_RDS_PTP_PORT_BASE_ADDR);
> +		if (IS_ERR(priv->clock))
> +			return PTR_ERR(priv->clock);
> +
> +		priv->init_done = true;
> +	}

If this only has to happen once, why not call mchp_rds_ptp_probe() from
lan887x_probe() ? If there is some inherent reason the function needs 
to be protected from multiple calls maybe it's better to let
mchp_rds_ptp_probe() handle that case ?
