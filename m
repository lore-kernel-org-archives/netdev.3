Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9C336885;
	Mon, 11 May 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512217; cv=none; b=kS3i67BwzAVCDFFQD6x1lg+klVwEM9DP9ZTpgSsGZd9zxr/6J1ftMDZEHTH6jpBU2RNOxwjp9egcqmjVtFPtdK+2VB0P4W99iqwkUngyl/+3nl6u3JEibGAbbZsMk++NGFCn4QT4iQXa/d0sG4xWB3X23RRRPbBo05V1FuMXsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512217; c=relaxed/simple;
	bh=ys83PkI6XyCyc8FfLpraQ72jzzuQKRyb8TEMZqWqShc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeWANAUcntvo6e6hDA8F2oYdCgf3ClXDWt0W+iNXUFFLNvigkANQTio1xnFcjEvL/9DoTLYQu52yEPXrb6EC5XYHUJIBByVCIqvNhNr5/TuYWnZfUTldjatv/r7cIlutAjShNHJOY5K6F3DG+DMhBpMO9PrzdeG/AJ4+unKDw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NE2SM2Qo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NE2SM2Qo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yTbRWKoT9oaYNP1VOEwwsMmpgeLM4mWYfjOKTR8cklE=; b=NE2SM2Qo5wRbX4g2hKDCYMXlGI
	lpxAMUgLxWIXhsHKtJREVIomywgae+hdf+uxh+sJv5lvE3SasB4CGYu4y16IfbpCANeGMkz1BboUR
	TjglyFWPxHeJLZEFQA64X87qxkfpzDEblDIjsfxw2apkNdzHkiOl2Kd+76kowGQwizL0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMSGe-002O9U-J0; Mon, 11 May 2026 17:10:00 +0200
Date: Mon, 11 May 2026 17:10:00 +0200
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
Message-ID: <40caf9ff-076e-43dc-92f9-84cfe514f6d1@lunn.ch>
References: <20260511145630.31618-1-schuchmann@schleissheimer.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511145630.31618-1-schuchmann@schleissheimer.de>

On Mon, May 11, 2026 at 04:56:30PM +0200, Sven Schuchmann wrote:
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
