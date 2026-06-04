Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC673C37AC;
	Thu,  4 Jun 2026 08:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562970; cv=none; b=bXJZjAm+ONJKNmJILycib/n7OdqMentybbmj1dLTi+rGw5q/eMRLrhHKFqoorbFJodeRzoiEqRq1qKDa4SMiMAe8pwV+LDafhqY/n1SBB0vm6WijhS/+/q0O6e0KCjRKHh1Zd9P67pzhaa2Td+OwTvdbkKWRHeXx8QR13R0bmYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562970; c=relaxed/simple;
	bh=k4Azq0MQ+WyzKh7QHZp7hckLTDape11Sl1KkrWJUI9E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=USo6tVGE/ztOopVyA1B4zxewvD7Z7wgznRpLMfq7h5qTyntAJotYkn/sNH97iDbcb2aVSN5sBkGe3TpG6Q/fWXQhJgzqJ8JX2JXBHQLzSlMCyNa1mKxuebx++nqdkY+UXYmSKV5Ft6Uqg2KaFHEniDBs0uCgK4VSjLS5vIcwAg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=uxk2j58F; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="uxk2j58F"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D949EA027B;
	Thu,  4 Jun 2026 10:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780562967; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=y1TmL6XUHxSu6zxj61u379IiRdxDdicnUhfIlf5MmjE=;
	b=uxk2j58F4ws5gEllgITLJHlKFnMb45MnmXWVOxJaFJUFCHjm1a5O+TAbIKvAh2iji3VEbb
	j48dr4o0RcFFwZ9N7SDjFOBOx/2qW2SP5MVnkbpTaAl4b2jQQU9sIwZksYoksoQCaZJ2nh
	ar9Jh8z/fVHKcAPUEpPOj9tMSHJCvcqfUKDxwX6m2Cwjy6HuCKAtEMGCOkkk+6x7oUQcT7
	CDjQ19rPXd3lR+8DMXhDWjLblVfk5euuJChLmUt2EMz5m0u3t5aSnugRCUB6SOh8X+ftL/
	AA1djHq4HwUE01Mfe9R8Ntw2LtHccptvfIz3BCxrD2B0/DvVvEF6w1/PRv0EUg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 10:49:25 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2 2/4] net: phy: c45: add
 genphy_c45_config_master_slave()
In-Reply-To: <20260604074209.93-3-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
 <20260604074209.93-3-javen_xu@realsil.com.cn>
Message-ID: <521e53fe8f22eb938ea7b9073516378f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Javen

On 4.6.2026 09:42, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic helper to configure forced master/slave mode for Clause 
> 45
> PHYs using the 10GBASE-T AN control register.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

> [...]

> +/**
> + * genphy_c45_config_master_slave - Configure Master/Slave setting for 
> C45 PHYs
> + * @phydev: target phy_device struct
> + *
> + * Description: Configures the Master/Slave manual setting in the
> + * 10GBASE-T control register (MMD 7, Register 0x0020) according to
> + * IEEE 802.3 standards.
> + */

Please document the return value (0 = unchanged, 1 = changed, <0 errno), 
like
it is done for genphy_c45_an_config_aneg().

> +int genphy_c45_config_master_slave(struct phy_device *phydev)
> +{
> +	u16 val = 0;
> +
> +	switch (phydev->master_slave_set) {
> +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> +		val = MDIO_AN_10GBT_CTRL_MS_ENABLE | MDIO_AN_10GBT_CTRL_MS_VALUE;
> +		break;
> +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> +		val = MDIO_AN_10GBT_CTRL_MS_ENABLE;
> +		break;
> +	case MASTER_SLAVE_CFG_UNKNOWN:
> +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> +	default:
> +		break;
> +	}

Per IEEE 802.3 (45.2.7.10.3), 7.32.13 (port type) is a copy of 9.10 /
CTL1000_PREFER_MASTER, like it is done in c22's 
genphy_setup_master_slave().

So set it for MASTER_PREFERRED, clear it for SLAVE_PREFERRED and leave 
UNKNOWN/UNSUPPORTED
untouched (return 0). Use -EOPNOTSUPP only for default.

> [...]

Thanks,
Nicolai
