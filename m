Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365D63DBD41;
	Mon, 14 Sep 2026 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789405717; cv=none; b=WvS71arLoIxxezy68wG5ZeK8ASOnPdDDBfEXm0QmJcK+Pheo9scLyEDpukL/ub86B3wVwzGlyZAFIYlIozkbqT1TD3o4DAbptsOpAO8fMJWnVnuHkcck1sYtPhk/y0zcnCngomGALKBkNbyJjaBi83t8YJTmHNXntWtmmIYUDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789405717; c=relaxed/simple;
	bh=nRqt152/JpqKXtofIaMoWz7ZTrjz0/OIzKUfXoPcREE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9w82d5nj0KJLbQgEwoKEYIUffboCYxARmLkFK56Zce6VEPioBvhFvzvrt1Z7B7rf8kugRGqOxztbBqnEJUv2pJ7RL+EHKkbVQumPFVZYVzvOUyVrzH5SuztRGVJ112wkOZd8frOSwjONItSTTXxWdY4appb5mIVkf5YPWVJHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dTQumUwn; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dTQumUwn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+oNmXB9c6p5BxQS/CIhFVNfDBYPpAbrReno9ZSRxJTY=; b=dTQumUwnChHIHUyWuBfPz89gFQ
	WR9x3rgKusF1JvusNYkQm0l95mZIgkyLMo5oxG6p8V1b1SbMor4AKALBxRMe4Ha/l96UUecNLYvfM
	qhM6LQmuurwjKpnHVna8qDslNts5OStm0Gpv2tpr5L0pu8DR/x1PD0kMmgV9VSpBYLeY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6AAL-0057JE-OW; Mon, 14 Sep 2026 19:08:25 +0200
Date: Mon, 14 Sep 2026 19:08:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Hendry <khendry@reliablecontrols.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: pcs: rzn1-miic: Verify port number from dtb
Message-ID: <948a213d-df62-4e4d-87c5-a7f063938acd@lunn.ch>
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
 <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
 <81869e14-2dff-4bff-b2b4-07185c4e9086@lunn.ch>
 <3b638508-6c03-47e5-80ef-49b05961c9cb@reliablecontrols.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b638508-6c03-47e5-80ef-49b05961c9cb@reliablecontrols.com>

> > While reviewing this, i noticed:
> > 
> >                  /* Adjust for 0 based index */
> >                  dt_val[port + !miic->of_data->miic_port_start] = conf;
> > 
> > Is the ! correct?
> > 
> >          Andrew
> 
> Yes, this is correct because dt_val[1] is where the port config entries
> start.
> 
> Depending on the SoC, the port numbering might be 0 or 1 based, so this
> prevents the input config entry at dt_val[0] from being overwritten. The
> logic works out to the same as:
> 
> index = port + 1 - miic->of_data->miic_port_start

It is unusual to see a ! used like this in the middle of an
addition. Sometimes the more verbose form is less likely to get
questioned asked...

	   Andrew
