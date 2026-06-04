Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B7637106D;
	Thu,  4 Jun 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575711; cv=none; b=Ea2pRnTThkPlQO4hWcdpFHMPi6yiMbSapfOSG37JR2bOweNj6TXnAOk04MWc6vgEv8/D5OVP/E8v6vxSDvq/vrIGQIL21cZksXNWcfDA4DArWQVFCKF+xjPtPTi6F/ZgpYkUwyLe/g+MbolThGe948/RkeLypLyPxsQS+Bt9ZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575711; c=relaxed/simple;
	bh=EBOGZAZBpe9lJRSHV9rUOOG0nfNd+yRb+ioWV0gPjrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jjadr4RKe6PATSOKuRU2we8Ytrr2+5Z5uI+dwt83yurLXhhsvszbHeYpKFkiq8Vcccv3A5U8tPS+JPb7NDHB0pTJyy0VIQKWLfsjoL4y/akhLaBZ5Mqx8VyTtoC7jP0Z/uCfTDnCTZSwMHJqk1dxzHrnxmmFRkkZNpH9v+zTklM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vCIdrZOX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vCIdrZOX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ugmz9XEK1aHJ48et251gx7959TULBGUCHT0e+RTmo4M=; b=vCIdrZOXYYHpdsOHeBiYOdNfKV
	8jxeQnBF08R4Tr+lpZ8S1kmFrB1G0+CT7cfc3ZGis/gVWnFElTr8d/g7pdyKRAdbEUjwJ+UudlhT7
	nd1IHGzbPieSyulWpm3G/jKOkkWmECewe71xduKUcFZJjVJGb9ORmCIfrl75e+4lQ+ik=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wV74u-0062YC-Fn; Thu, 04 Jun 2026 14:21:40 +0200
Date: Thu, 4 Jun 2026 14:21:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2 1/4] net: phy: c45: add
 genphy_c45_soft_reset()
Message-ID: <c9d4621d-c628-4fe3-b437-7e23d96c69c8@lunn.ch>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
 <20260604074209.93-2-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604074209.93-2-javen_xu@realsil.com.cn>

On Thu, Jun 04, 2026 at 03:42:06PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic Clause 45 software reset helper. The helper sets the reset
> bit in the PMA/PMD control register and waits until the bit is cleared by
> hardware.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
