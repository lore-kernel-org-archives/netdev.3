Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5D443ABC;
	Thu, 10 Sep 2026 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043124; cv=none; b=qr8dOYGSsZhIAikdZworvS83QQmceUYVLLstgVU5zsHBLtbDyGwDfnlsQqCC4t3G1SkzC3BUds0CwmdUWjp8b6iiz5y8FnerTGjYGzbXpN1oZJHN3jGX6ch0O/mKA1MpfMpYfpUrAfXgcTap6D+1qzWuQgDxzWzXVGu5vkauNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043124; c=relaxed/simple;
	bh=QiXAAenKgtFWKjScIN1SfxNP+tUCy8/UzWGYhjRd1VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV4GfFj2mR7SsxE+bLIVNoz8rDNoUx7N/yULGgpMPsCBRxuU0FM23gJnspW2+0OIRZZ1Bt0/VeAH//sfe+/ueAlYeKNBpoq1Sh4115tkJ2PUDrev2h9rD6kwT3SC/V1opHceclsfIvO5FUoz41jdwp6pJ8SthRp+I7eTE8wHkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zv4rkFJS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zv4rkFJS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mnb9ZC+mUyCPOdlRifCNjqEjYd1XZexi7oZMMjAkoUA=; b=zv4rkFJSABaWnLVSFBTh94hAoE
	+Ay/oh8pCZIGXzH4EW2+4Zj1A747X4CmNeczYB8Q2H7aWaNq5UMJUR7pXd2VgmiVxweJd5+zjixq1
	U5LOu5TWj4yU5KBqkiRuiZ6G0/5R+rb62KxO4ZxgJ/V3M2/2LKcg7AsVF5UgTGK8P9Ig=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4dpx-004Upo-KU; Thu, 10 Sep 2026 14:25:05 +0200
Date: Thu, 10 Sep 2026 14:25:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	freddy_gu@realsil.com.cn, nb@tipi-net.de,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel@makrotopia.org,
	vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1] net: phy: realtek: improve firmware write
 speed
Message-ID: <06862775-e6cb-425c-9118-d2571e8ab222@lunn.ch>
References: <20260910024927.1644-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910024927.1644-1-javen_xu@realsil.com.cn>

On Thu, Sep 10, 2026 at 10:49:26AM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Firmware execution routine unconditionally uses phy_modify_mmd() for
> all OP_WRITE entries which introduces an unnecessary read transaction
> when updating an entire 16-bit register. So we optimize this by
> checking bitmask boundaries. Use phy_write_mmd() directly to speed up
> firmware loading process.

For optimisations, it is normal to include some benchmark numbers to
show how big a change it made. Is the added complexity worth the
change?

	Andrew
