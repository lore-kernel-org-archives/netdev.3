Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B78515998;
	Fri, 18 Sep 2026 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789749028; cv=none; b=BctpL1GDjG+lgz0jhsCMaVqQS7bWIL7poAYcqrG2ILLcEhuVZ3Fuvn2iMpSiQ217PKPQky4ZOEj5K+L7RlONMVGLyECDXFdJnRkAcjh0T0H2sAzQhZY4zOxuyeo+4Y2yZ0o4xPedhEXPt4YEAu/cSoy7jM9lruZ+ay+z2O0Fo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789749028; c=relaxed/simple;
	bh=C7tZbt3UhzAnW98cTTSadqBCoS0ctOd08BJmKMbroTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljukIkj4kRfSF9bYLmyJUb5fyHAFjfITnFKMF4ZU0tq+M6xmwDXbxdAKMPeM0YtLZwnVboQKrxSgz8AOIzn9RPT3f/wYFJaZZZy0BbOaoY4ytq6Ie5tB2642qJxlvHyXquBCKZYbqMvDtnxVS0kUJoOWj00YPVM/Pys3r0f0wAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TP4ufNAb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TP4ufNAb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Co3xVIDXNLBJrFTLjjbjwYnTnYTLOg/RMWAScp3+boQ=; b=TP4ufNAbqFlNPjN2V0G7gQeang
	VUuchqOV31oH2h7zhcLaiHIyfwMELf0aCS/Lsi1Dyti/hWKD+hIbp41j7b2BWPz9epJQBENDLmSgL
	dvdYL9E91EC7LtIBER7lt/edWqjr/sWlFqyl9A1i44o4xaJVdpR6MEhly2WwnXMoqXno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7bTK-005ts4-4w; Fri, 18 Sep 2026 18:29:58 +0200
Date: Fri, 18 Sep 2026 18:29:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, daniel@makrotopia.org, dqfext@gmail.com,
	SkyLake.Huang@mediatek.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: mediatek: do not match MT7530 PHY if
 10/100 only
Message-ID: <4fe68c4b-b72e-4cbb-9a0e-2731ec68888c@lunn.ch>
References: <20260918161156.377822-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918161156.377822-1-cjd@cjdns.fr>

On Fri, Sep 18, 2026 at 04:11:56PM +0000, Caleb James DeLisle wrote:
> An EcoNet SoC 10/100 PHY uses the same ID as the MT7530 PHY, but a true
> MT7530 PHY always has gigabit support so they can be distinguished by
> the presence of the ESTATUS_1000_TFULL flag. Add a match_phy_device
> which refuses to match if the PHY is not gigabit.

Don't you also need the opposite in mtk-fe-soc.c? Otherwise don't you
rely on the load order of the PHY drivers?

    Andrew

---
pw-bot: cr
