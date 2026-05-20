Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1173EF0BE;
	Wed, 20 May 2026 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289963; cv=none; b=HuqiadTAaeNtxwAjkCTt/DFpyygQiZYFtTHUmLaPChoUHIyzw9git8uuWxCqNI9LBiT3QclDNDK+1T3uZL6v4gc4/Bv0ifkv+prge2+K81fZkdtJE7VzNBz2oXrWxfgLgJtrzx2MHWpVa42ypLXBMyvtn4JX+xhY8LOHc5eHT58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289963; c=relaxed/simple;
	bh=tnAabweQiPGTrq4s5/XIUn2e/+Kp0dnE6fhKkBjI0zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/T8mI1edYT02rS5dzXauVkX3F53Y5Ywzk+4pSoalglBkIwS2T9jbuqm6DBdD41YCAa37kHlMxEkISSq8QNrNM4ouiOL5kVqgL4uooM6YbXHk0wLxwNdUltY+bFG0g6Zpx7Xe9veSFMCCKjb1XkXi0wbmp0a2e+QXFIcZSLcKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r5gYaW/l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r5gYaW/l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BxqIHkTrG2nPrftKJCbRNMPOYiQbepsL94rJ0TP7lWQ=; b=r5gYaW/l4lrtCKTy2DQqljigs8
	SSwUnBAmM7jXZtLpmH3WKe7GsWm00/7fqRbzsP3bC7c3K8sEQBBJIb788ujvYQPYTG65YGy/vjceo
	6N4056u7A8S8mUJj51/lQFvh5ZCuDfhlovnru9avTqk6xgwIMG54RU3gcf891h70sVZ4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPian-003qvT-OD; Wed, 20 May 2026 17:12:17 +0200
Date: Wed, 20 May 2026 17:12:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 1/3] net: phy: motorcomm: move mdio lock out from
 yt8531_set_ds()
Message-ID: <83bae20f-7de1-4868-9a7b-d903af1b62ac@lunn.ch>
References: <20260520101310.128969-1-minda.chen@starfivetech.com>
 <20260520101310.128969-2-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520101310.128969-2-minda.chen@starfivetech.com>

On Wed, May 20, 2026 at 06:13:08PM +0800, Minda Chen wrote:
> yt8531_set_ds() default set register with mdio lock and only called
> with YT8531 PHY. But new type YT8531s support RGMII and has the same
> pin strength setting with YT8531, YT8531s need to call yt8531_set_ds()
> setting pin drive strength. But YT8531s config init function
> yt8521_config_init() already get the mdio lock with phy_select_page().
> If calling yt8521_config_init() with mdio lock will cause dead lock.
> 
> Need to get the lock before calling yt8531_get_ds() and move mdio
> lock out from it for YT8531s.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
