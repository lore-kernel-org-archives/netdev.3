Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68554134CF;
	Sun, 27 Sep 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790517782; cv=none; b=uQbXnQSthHAbxM7+o1kpd/M78uDQPt32upUAhrQ3gTBPMFSyyd9pqPkcP4V98GBuLTYH/MIcRMW2dPrrbEgsvx6pBV79rrukvQ6bvamZate9aq+YemUEDPVhvZHrb8kBDO+aPPLo+mtMFMGQQD/bIEyyh5LdhWMXlGx3DRD7WjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790517782; c=relaxed/simple;
	bh=1wQTt15FLhcGK97x3sUV3uQpTuhV/Ni8asEd9lTsRQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3QW43bl482OjSKThxNDYsGulyX2123RESMcjBMCbKdkmXxjhjd0CMub1Jx8HN6ukMgM6+d29YVqCpjRaWGqcgY8npmxrGVJWFtROG//blzqdrC+bD2h5k35SAGlBcf1P8e74vBcqen6h+Ovk7Xjgk/l8/uYXBEVt3ug17e2dig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RVaKJiRd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RVaKJiRd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pETkA6K+Iby7RLeHF9T2hVz6sgCZrR1t4j0cnQmHPEc=; b=RVaKJiRdIJ+lrB42N37FsRFmvr
	9agiPaA3DVsq5gqn5VbdHGnNglBMAh3oKabl0jBpGIzCd3PB4RcAxclHiuJjWAKuYmkk0FscRsMRn
	VMgn1Vus2IWQWgdBNUqfexIBGbkYt10uPtqZ5WPtGDX/coM4G63hlzuA0tK9AlVv9Xio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xApSg-007WGq-EI; Sun, 27 Sep 2026 16:02:38 +0200
Date: Sun, 27 Sep 2026 16:02:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev-bot+sashiko@kernel.org
Cc: hongmei.xu@oss.qualcomm.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: aquantia: AQR113c fix up PMA capabilities
Message-ID: <1f4f03ee-59c9-4789-ac84-81bb7c8a7959@lunn.ch>
References: <179047527921.2160803.15181990521063252187@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179047527921.2160803.15181990521063252187@kernel.org>

> [Severity: Medium]
> Does this drop EEE capability discovery on AQR113C?
> 
> Before this patch, the AQR113C entry had neither .features nor
> .get_features, so phy_probe() took the is_c45 branch:
> 
> drivers/net/phy/phy_device.c:phy_probe() {
>     ...
> 	if (phydrv->features) {
> 		linkmode_copy(phydev->supported, phydrv->features);
> 		genphy_c45_read_eee_abilities(phydev);

This is a good point. And it is probably a bigger issue, since none of
the get_feature functions in this driver call
genphy_c45_read_eee_abilities(). Please could you add another patch
the series addressing this.

    Andrew
