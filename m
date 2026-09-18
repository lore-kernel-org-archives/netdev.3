Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A3A519E17;
	Fri, 18 Sep 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750745; cv=none; b=AoRjH2N8JHyZNaLgHwsdsgymFpfnJybPZxL8FiFEmctk24QMyTuFaOVMIMqOD84rrRZ3lBAvbABEnCzaTg0OIehBEfM7ZeC1aIzMB2E8k+a+Q8XLUALMVwCFX/Vax0JK6RVEWAhZ85sJlEQcTkN/U01KE9i2m3SZf47QL2ldSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750745; c=relaxed/simple;
	bh=CuV37cVr9nH2SMCflxITHM7p7CV+giqcW0TbsRt+teY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbrCQ/KrDyEoHZo+JXVns8Y8zluPMan74dRikwcheo9JVOzZxJjAJeLm/PXfmcZnUCxLs9Hsibg8wc82WU6pcGYCRsKywC3tvKdNE+dDv/jfF8O3qY/RTLBEZR8Rw2dbNbxQ4urxA3aFWwsaQRU1GqkGxHHmlJIxVOdE+B13yjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xH+yP9SV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xH+yP9SV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3K8Iq73fzmMlqTsh2CJ5HJ1Gr7k25mdx85nm05tpVr8=; b=xH+yP9SV05DdBY/JrZ4TeBp0qa
	/QV5tyQshBb7qPQfOX9amtOgDIr2HtilHxkq3+DuuSsB/i7+dkppTSYa6DNOC/N4fvvGSXXi6U9xK
	wvzrJ5M1xda7d1knjM61cgt6LOIC82l465loAXG8ZSdcnuJrreqG2lEjsOROJj48sKgQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7bvB-005u5E-Sa; Fri, 18 Sep 2026 18:58:45 +0200
Date: Fri, 18 Sep 2026 18:58:45 +0200
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
Message-ID: <c45590b8-91a0-4499-b613-df1ace5acc0c@lunn.ch>
References: <20260918161156.377822-1-cjd@cjdns.fr>
 <4fe68c4b-b72e-4cbb-9a0e-2731ec68888c@lunn.ch>
 <accc40a4-f447-498c-ab45-96d1f2d2cc33@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <accc40a4-f447-498c-ab45-96d1f2d2cc33@cjdns.fr>

On Fri, Sep 18, 2026 at 06:47:02PM +0200, Caleb James DeLisle wrote:
> 
> On 18/09/2026 18:29, Andrew Lunn wrote:
> > On Fri, Sep 18, 2026 at 04:11:56PM +0000, Caleb James DeLisle wrote:
> > > An EcoNet SoC 10/100 PHY uses the same ID as the MT7530 PHY, but a true
> > > MT7530 PHY always has gigabit support so they can be distinguished by
> > > the presence of the ESTATUS_1000_TFULL flag. Add a match_phy_device
> > > which refuses to match if the PHY is not gigabit.
> > Don't you also need the opposite in mtk-fe-soc.c? Otherwise don't you
> > rely on the load order of the PHY drivers?
> 
> The collision is in econet-fe-soc.c of
> https://lore.kernel.org/netdev/20260827065930.2618729-3-cjd@cjdns.fr/

Ah, you have a similar match function there. Good.

> And I notice now that I did add it in that patchset as well, but this
> implementation is better done.

Yes, the one here is nicer. It would be good to use the same idea in
the econet-fe-soc.c.

     Andrew
