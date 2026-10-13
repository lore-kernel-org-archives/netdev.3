Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C44718FD;
	Tue, 13 Oct 2026 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858983; cv=none; b=u8dZQUVyi/GPv4FHks+M7pDb5JUqghdsar7T+HOg6sr3OI+qU9TiUwYDyes35C6moV5ggEjxEtDHCxBH7YyO7CnPyW5cpIqrYiCroKuf7byYlchbtBOjPqeaPiYBDRlqMAeSZKTtPUNxEmY7U7wkFysbFVzn6y3Jj69RegsgpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858983; c=relaxed/simple;
	bh=c+vZOs4AMstSBp8TqoqmWWZhW+Sl/Vx5Pob7zqdsTIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2p3WDgTIBsKf8hhuq/FusCgq+kCKRO1bcVyMm/hnXymmt7W5okNeGAckhvbolq/dlEdzA8xNado+x5DlO8RLSBPee7+O1PN+c+yCJUp6E8QHVjDlY/MGXyYKufAjmyQze5tBR8cWyd3efm7guFRIWqR7Y1tuN+oajh0zvBadYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4QYSSTy0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4QYSSTy0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vhs/1zyh476BoXqL8DHijdewSoYAz39LBtzN4oSRRNM=; b=4QYSSTy0d4gCkdZggHH6vN12fX
	ZhNN0xbhDDeJytUhpvXdT6mQQvk05OmAt97Ej2KzRlIFm3WNYoyvIi7QpN2bMfvLgX1VUdmdkW99U
	TN1mvSslDisHoHdYCX8mA9bcg3BkwdGBUo2g7MCx1IZ9QvURkR4s0VeMUjRGaPSpwwO8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGSNB-00ARHx-Lg; Tue, 13 Oct 2026 04:36:13 +0200
Date: Tue, 13 Oct 2026 04:36:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 3/4] net: phy: serialise attach and detach
 with PHY driver bind and unbind
Message-ID: <1b3b1e49-1638-4dce-ac45-300d76e2559d@lunn.ch>
References: <20261009180551.1234107-1-f@lex.la>
 <20261009180551.1234107-4-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009180551.1234107-4-f@lex.la>

On Fri, Oct 09, 2026 at 09:05:49PM +0300, Aleksei Sviridkin wrote:
> phy_attach_direct() reads phydev->drv and d->driver with nothing held
> against the driver core, then calls into the driver through
> phy_init_hw() and phy_resume(). An unbind that runs during an attach
> can remove the driver under it, and an attach that runs while a driver
> is still probing can call config_init before the driver's probe has
> finished.
> 
> Found on a Keenetic KN-1012 (MT7981) while testing how a port copes
> with its PHY driver coming and going, on an OpenWrt 6.18 kernel.
> Unbinding the wan PHY driver through sysfs while "ip link set wan up"
> ran oopsed on the first attempt, with nothing added to widen the
> window, inside the driver's own calibration code:

Given the complexity, i'm don't think it is worth fixing. Unbinding
modules is not a normal use case, it is more of a hackers tool to
speed up development. So i can life with crashes like this.

      Andrew
