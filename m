Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3537C926;
	Thu, 17 Sep 2026 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610206; cv=none; b=E5sIta7bANoTcq3v6GNSvxnG0Ebq9+aMqhGfgGW8rvitWpLbR2QzPLIlX9vPeS6hSAJFtRSxxtQ7FyWKBdtoskAnMQnpFGpCQZQzMQDmR2H7YPVr0Bey3N+Ln3eAM+NGAR+FErisHn2Yd/xR8OQRcCdehOu93NbDS9p28nfHiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610206; c=relaxed/simple;
	bh=g8aKfI8ofYXh0JrV5QcxvrY6yNVT+H+GWcGmFV4iq2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBoDjOEsyzww1h+54T18ZJIc6JlYPAcDqBA0D/i+oLyepEOGUfyaoSFUxL4NwXfijs0YxJ6/KlDARi1MCoUJp4M4vyvnKJsCH3W728oZZSAA85abzQeqFAOEF5xQ/o6bURu4WLj9aTKdNBglx+G1lVRCPDI703lbE8/yuwtoKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5iLOYODN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5iLOYODN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pxKVKahFL4XhN7C/p73Dfil3k8M5EG8zN/hEhL5DFGA=; b=5iLOYODNTkR9t3xwJFLrOm6VKF
	Ch+MmF21SNA4I02uax4Smm+Xp52Va8391xLpQ4wvvWuEpN2ZgGkkIYZhrB3GsJVmyDQdCLqBd2y7p
	pFGMYv8C8TN3t5kmoMP6KJi/ryK8WmT29FVAYo86pLbqAe29T2ESc0mcK+5gOMxMbwHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x71MX-005aCN-Ie; Thu, 17 Sep 2026 03:56:33 +0200
Date: Thu, 17 Sep 2026 03:56:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Weiting Lee <weiting.lee@airoha.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org, bjorn@mork.no,
	ericwouds@gmail.com, frank-w@public-files.de, joseph.lin@airoha.com,
	wenshin.chung@airoha.com, lucien.jheng@airoha.com,
	albert-al.lee@airoha.com
Subject: Re: [PATCH] net: phy: air_en8811h: add dedicated suspend callback
 for AN8811HB
Message-ID: <d9ec8019-0603-4884-9bbc-d20153dba204@lunn.ch>
References: <20260917012102.3103131-1-weiting.lee@airoha.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917012102.3103131-1-weiting.lee@airoha.com>

On Thu, Sep 17, 2026 at 09:21:02AM +0800, Weiting Lee wrote:
> The AN8811HB hardware requires a re-negotiation sequence before
> entering power-down to correctly restore the link upon resume.
> Add an8811hb_suspend() to handle this.

Is there an errata for this? Please mention it in the commit message.

> +static int an8811hb_suspend(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	clk_save_context();
> +
> +	ret = phy_modify(phydev, MII_BMCR, 0, BMCR_ANRESTART);

Why use phy_modify() if you are going to pass a mask of 0?

	Andrew
