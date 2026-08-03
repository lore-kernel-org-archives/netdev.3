Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D8C26980F;
	Mon,  3 Aug 2026 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785790199; cv=none; b=NxrRuYiYj61jmUxVwb4Ng/ZnTJT/FK1p4WTWHCT0buVxeEXhF7vw90AONexM+iuo/iIFWvLyUKZT+oMsVBeiQoqk7x0Hq/0HG4iz6CTB03M58vdv+AVCvxU3ojPgBorfKBBOr7dmchRJg1r3DA6RDuU84dRja4iZHpOMREk9E4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785790199; c=relaxed/simple;
	bh=I5MpcksMm1qYxAC+eBLdjXY3RfdapMLAWA8ctlOhYuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLdHCEqxlmZ8+OPtjkEeLYc8sZU+tWlGCiD8EsXP6bDWvANvtS5YF/R/utqn3ZjSjC0N/iUBeKAoX2UJh326b53NFFqsGjrSwLzuWf6iDaUhvFp206NigbU0G5qrZHcJQ2WRGZ57GUXsJRWNgrzK+tv+smqcIvMHlF3i9OvfjuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MhBpm5A9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MhBpm5A9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JyAp8Z5ouo6gaw7s2MFN91ZHH4i9uTtAFI6phADjrlU=; b=MhBpm5A9eHoj5UiIEmx5YnHV6y
	HJ+F1JGns8UBnrMv8+Vty+FY8Z6O0lXH+qh3BkQS2isdpu83wYpyZ2OpLMN71wvMVTXvf35z39PSx
	DEIlKe+yJVTGORr2WfRrn0Dx2NHAQ1ideCXeKMkmOI5NekWMXxXc6tBFPBIaZcTz214k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqzbT-00Fpo6-Rt; Mon, 03 Aug 2026 22:49:43 +0200
Date: Mon, 3 Aug 2026 22:49:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v8] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <50f7c213-0791-41e3-9eac-049ce87ee260@lunn.ch>
References: <20260801035236.3560015-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801035236.3560015-1-kyle.switch@motor-comm.com>

> +static int yt8824_config_aneg(struct phy_device *phydev)
> +{
> +	int phy_ctrl = 0;
> +	int ret = 0;
> +
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			      phydev->advertising))
> +		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
> +				     MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G,
> +				     phy_ctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	return genphy_config_aneg(phydev);
> +}

What i'm missing now is some explanation why this is safe. What is
stopping something from changing the page after the call to
phy8824_page_write_with_lock() before genphy_config_aneg() completes?

	Andrew
