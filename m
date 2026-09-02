Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343C24A2A77;
	Wed,  2 Sep 2026 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359494; cv=none; b=ardRYv6/sj1J0auBE5P/ZHwOCA7ySvFt4O4PNBJecmVCa0PADyTSd17l9xk2jUT4aI0Ax7UARzVwKtRqwzhW1KWp7H9BTjxrj2qoe1e1WXFEhc1YC/d2MGwL3cWJNYeVFy+LPLvWcS55E+JG/cLJWqjONRDdDrmVebmSrhskO6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359494; c=relaxed/simple;
	bh=HxdOEImSMSQliJKcWoaU8nxLbXCz0YFHWMUvFedS3fA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUmPB+W0lZTYXYYnvLHEMQZ1reCpmi7Sy/dP3ml1L0vazacu7kWpRsiOmtZfhM7LCaHtL7RRBCWlGKVB8pgCWj4DN3eyWg5shUuT2EL1TvXFuMoUQYJ1sC71SzVIAkcKauPk3O/xLFUZ5/9c3RIW8j4piqHyNxR5UNzvcQpOi1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zPtz+WjE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zPtz+WjE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Q12vuIwgvMSKLOaE5szpSL49YewA+cVswq3X6HwatuA=; b=zPtz+WjEuPKmpTE9rFtibElC1O
	1AFUb0AxoYGKMuYzSdO//rEYr7lDkZ7UnYp1xrKoh1L/zOCkKNrdx5Uiym5gVZ05S5OLjKDf1EK3J
	m5U7IZm9VaRuT19AhhJ89H3/CfUSzVpgJ10+vkKJjeSRdKrlUy+A4WIRl43FA1Mn0Zkg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1lzX-002X91-Vf; Wed, 02 Sep 2026 16:31:07 +0200
Date: Wed, 2 Sep 2026 16:31:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel@makrotopia.org, linux@armlinux.org.uk,
	enelsonmoore@gmail.com, daniel@thingy.jp
Subject: Re: [PATCH net-next v9 3/7] r8169: add support for phylink
Message-ID: <22c9d812-e241-4da8-b5dc-d8671f8df022@lunn.ch>
References: <20260831053745.1197-1-javen_xu@realsil.com.cn>
 <20260831053745.1197-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831053745.1197-4-javen_xu@realsil.com.cn>

On Mon, Aug 31, 2026 at 01:37:41PM +0800, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Transfer old framework to phylink. Phylink can support fiber mode card
> which can not get link status or link speed from standard phy registers.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
