Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C13D5649;
	Wed, 15 Apr 2026 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776264136; cv=none; b=nXAKj1NweWW0PMKj6UZyLLSpFITdc3b32o7yKtGOPnG0nFhasB5ZJVICplLcyio891jki9DBrK5e2NKUgMHKQlx+Oz9pFQO+Yn95hoOlvE4xDSdhBiralquqzCsSuW+Uqmpqc/yPZwZ8OS2M0wqovl7ZgmddadPWI/FRj5KAzTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776264136; c=relaxed/simple;
	bh=r6howsbtoIvDVeoqDUVWjHDsH+PgHplJ1VmgD9lgJ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u01BaQRPs+vCUwWGpo1FiLaaTNY0IijOsgehNxB/VQhNW8AjwQWXIas4ZC2jMqAddkcncg863hE/EHxIN48/lXYQOE3XKMCdkDiluGKJHx4Z52aoWIkzit+wvSOaOqI3zljy/0PvrgSLWoV5IRft/P9srr3oa0LH+6dOmahg93o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MA1oi+iP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MA1oi+iP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GafeSQPMXfCPOHMEQWCEWif9iKPy7e3G+fkpH6sE1o8=; b=MA1oi+iPiPoFa5iA8TQe7EpEM+
	pDHAUb1FoGKvLsgjp/fEuqLDo26YR5tsQyfxQBCZnLEIj22zNZqhcGLF7kPazTnOl7NZy5/KVqLi+
	gb2AOoGQQYF8SqxPpYhSrv9tKNBep1Od01Wxro4q1q05Hz2xuMe1Vnu0xTixCXiPYPgA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wD1RK-00GBLD-7S; Wed, 15 Apr 2026 16:42:02 +0200
Date: Wed, 15 Apr 2026 16:42:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v1 2/3] net: motorcomm: phy: set drive strength in
 8531s RGMII case
Message-ID: <26068310-a27b-4bd1-ad4c-3d1f3df6f558@lunn.ch>
References: <20260415092654.64907-1-minda.chen@starfivetech.com>
 <20260415092654.64907-3-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415092654.64907-3-minda.chen@starfivetech.com>

On Wed, Apr 15, 2026 at 05:26:53PM +0800, Minda Chen wrote:
> Set RXD and RX CLK pin drive strength while in 8531s RGMII
> case.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  drivers/net/phy/motorcomm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 35aff1519b4b..f3129419f7c9 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c
> @@ -1714,6 +1714,11 @@ static int yt8521_config_init(struct phy_device *phydev)
>  		if (ret < 0)
>  			goto err_restore_page;
>  	}
> +
> +	if (phydev->drv->phy_id == PHY_ID_YT8531S &&
> +	    phydev->interface != PHY_INTERFACE_MODE_SGMII)
> +		ret = yt8531_set_ds(phydev, true);

phy_interface_is_rgmii().

