Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445873BB11A;
	Wed, 23 Sep 2026 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790168300; cv=none; b=Yvdf9V3EW1P4KP0nH88X+pyPr0MW3uvQ2wZzlXOqGSUSPVfQ8bg//L1A93m7roxgeqsct83U2E3uq65sisXMClRJbF+LmUbPVxKSTzqRtaeF4ab36/AQwc1Wta0AzCqBTnuqnWo2IlHDu0Rqr38Xj1P0FamHfuXmcYNA3QvygVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790168300; c=relaxed/simple;
	bh=vAHeYn404376n5KfIj0AeK1aO8UQRu647kNvAfNMg0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fRJXH30pxUaIBZdWd9eaiZS68+CdCVsgczL6KZRBk2GGCdQ3xHRoUPVoPB/iVypqSiM0JgKcpwANcEDFtDdlQqhShMvRw6xz/pUl6heH5AxXTBzgKO9EPoxTnB0Ct/JY1ys1MPVbMgxJykR+ry81LGyYEj8rmvr38Su0FcYHHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k9TLKfi5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k9TLKfi5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PckSLxc5fmGOmfYCwGJBVkV6mStQJhnt+07SFJ6nFvw=; b=k9TLKfi5As9IyHEAGalTESGe/4
	bybHd2PePTKD1Bk5p5O02g5B7jyQD+36uOqgxA8kT12BBLYOQYz50sh7MLEQ/umPCNAF4Vftsk8Ie
	qhuR2Y/PgpA3dyDg5H11vT/HfovN7jttiJTWuSygCAcY39TLQsTjjHMIyrggM5OGyGoU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9MY3-006o5K-Uy; Wed, 23 Sep 2026 14:58:07 +0200
Date: Wed, 23 Sep 2026 14:58:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: shengchao.guo@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
	mohd.anwar@oss.qualcomm.com, maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: stmmac: support low-speed USXGMII validation
Message-ID: <828e6cff-79d2-4349-805f-cca927f7b908@lunn.ch>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
 <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>
 <20260923084921.3942100-2-zhangfei.gao@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923084921.3942100-2-zhangfei.gao@oss.qualcomm.com>

> diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> index 091c9b57388fa..58ca296fc4420 100644
> --- a/drivers/net/pcs/pcs-xpcs.c
> +++ b/drivers/net/pcs/pcs-xpcs.c
> @@ -23,6 +23,12 @@ static const int xpcs_usxgmii_features[] = {
>  	ETHTOOL_LINK_MODE_Pause_BIT,
>  	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
>  	ETHTOOL_LINK_MODE_Autoneg_BIT,
> +	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +	ETHTOOL_LINK_MODE_10000baseT_Full_BIT,

What does T in 10000baseT mean?

>  	ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
>  	ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
>  	ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,

Compare and contract with KX.

	Andrew
