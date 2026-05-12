Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EEC37207B;
	Tue, 12 May 2026 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588642; cv=none; b=aq52JYxXtzXeFeb/yBP13Y/1P62zX5ixm6aOS4oxCeks+YEXhKvzpDSUlH0mxQxFl+yTTG4PzLwLxDw5bMCgfNy3yyiF5TLbmEpwmmBOZ68V6hbXLOHa26jUaI47k55ebG641key5hiHZp3bm+Al7pROuPNQqw/JhfAowasedxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588642; c=relaxed/simple;
	bh=SY4rfSEpPy3VovMEnZT4ZruykpRnFFmtc8LsfuxZ3NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB7W+azDYWkW2rkrMw3Br3fE+LMi4sHl70sBGoqVP/2F/x/Ohm0jfr2miMYB2S2rqXpD0gX5N9dmRtGbAOihr3LRrRwTXaYwOwXHjsWlTVm6ErGZd0P56oAkyi/qKYXp2O562Q+d315fKnU3jMXP4XXx5h0ixYVcLnBtH/3GTNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OBm8LXAj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OBm8LXAj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OcGh6zvS8CMdQfxpgC7dI+kI4RTFdz0qxQiRg00rcrk=; b=OBm8LXAj4kM0sZ6zphRnku2Q2r
	OuxHC6aQPVxwgqK2jrgZ7KceXO+/Q9Xd//q7S/qOis+zelC2HTB4XcrbPIg9uPYiMjycx5Hs+G3K7
	6HPFYc2UqG3jqjv+nwUOHHrGYznPi26mTtocthuFRcawxdj3QX45Cn5FVQ6RK8v2mXlI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMm9A-002Xdl-7F; Tue, 12 May 2026 14:23:36 +0200
Date: Tue, 12 May 2026 14:23:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Dan Murphy <dmurphy@ti.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com
Subject: Re: [PATCH net v3] net: phy: DP83TC811: add reading of abilities
Message-ID: <ff18ea41-e058-4efd-a229-966f1a28d909@lunn.ch>
References: <20260512071949.6218-1-schuchmann@schleissheimer.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512071949.6218-1-schuchmann@schleissheimer.de>

On Tue, May 12, 2026 at 09:19:47AM +0200, Sven Schuchmann wrote:
> At this time the driver is not listing any speeds
> it supports. This should be ETHTOOL_LINK_MODE_100baseT1_Full_BIT
> for DP83TC811. Add the missing call for phylib to read the abilities.
> 
> v3:
>  - Fixed indentitation problems. no code changes.
> v2:
>  - Fixed subject and added fixes tag. no code changes.
> 
> Fixes: b753a9faaf9a ("net: phy: DP83TC811: Introduce support for the DP83TC811 phy")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
