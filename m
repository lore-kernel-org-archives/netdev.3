Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E03DB632;
	Wed,  1 Jul 2026 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894001; cv=none; b=YBcSL8vomZkcU4o5AGw/efQyxMRX9ECjwZtzl/dgaiXs/fbQCh44sQ1m5XaxzM6XXjFKjidbv4yiQnfYZKvBqMUGsOjKst0i8byEqmy6KwTyP4Da3VjMgBdstT3CqnFBQ2DgD7ZuclMvMHvS/8J7gN1LCpkNquiMHqd/7C/5biY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894001; c=relaxed/simple;
	bh=3R6JmAjYl5RM8D0eR5ST8pScNy8ZEPT+leHcx8mc8Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7iVrRmo+95EiNaXKqIcMmey0VvgIxr0Ny7NTaQZzI0FeUKKIfWFne9FS7/QsKsjbewvNea29ZTD0AN0PkgmWVlWWAjaMQ8TV9i1kaNYN0TlCtWdRDhYEPv7RcEh5KfejLgubdbC3hFxSI/O1QuKN9WHA4EHsYUJmkH7MiLppMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ekvaf2l/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ekvaf2l/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XwfiMxm/VslrMjuWKYBcm8WB/vPk43KcoUspz20czZo=; b=Ekvaf2l/apov9/eCCvnxoPsXas
	vu9PwBTYDr45wPIKVVhMjLzhCRVDL5wyRP/3W6iaYnCRSGvfaXwj4cmzfiWkg631FyEEZG3OPI2w8
	awColwkCrW49s5Oi7OTYDhzVENIIPeKsyZBX109l2/dqRBSIoqGWuAEccGw979GkwIALC86GL6UOL
	DRyAmFFHRxy0rgWV+tuJxUBTMA9w41k1bMHEWzywpfru99Afw2Io9N58S0ReTzcq+n1kkAYG8YL9J
	zjNiVo7tKjaSThgdmNkqyGQQp+2c1ySAxIWUd2jPpWu+Z9RTTNq5Vr4+LzFz9kyq1xqdaIe5DL7X9
	r1rQxfVQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weqAg-007i0B-07;
	Wed, 01 Jul 2026 08:19:50 +0000
Date: Wed, 1 Jul 2026 01:19:45 -0700
From: Breno Leitao <leitao@debian.org>
To: Clark Wang <xiaoning.wang@nxp.com>
Cc: "Clark Wang (OSS)" <xiaoning.wang@oss.nxp.com>, 
	"Frank.Sae@motor-comm.com" <Frank.Sae@motor-comm.com>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH net] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Message-ID: <akTNEN5o1J-Uv-mK@gmail.com>
References: <20260701075730.133707-1-xiaoning.wang@oss.nxp.com>
 <akTLmyF0r70Jyn9m@gmail.com>
 <GV2PR04MB12213F4758648CD71F5D5B3B7F3F62@GV2PR04MB12213.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PR04MB12213F4758648CD71F5D5B3B7F3F62@GV2PR04MB12213.eurprd04.prod.outlook.com>
X-Debian-User: leitao

On Wed, Jul 01, 2026 at 08:16:13AM +0000, Clark Wang wrote:
> > > In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
> > > driver uses phydrv->features. Drivers that implement .get_features are
> > > responsible for reading the EEE abilities themselves.
> > >
> > > yt8521_get_features() does not do this, so phydev->supported_eee stays
> > > empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
> > > not supported", even though the PHY has the standard EEE capability
> > > registers.
> > >
> > > Call genphy_c45_read_eee_abilities() at the end of
> > > yt8521_get_features() to populate supported_eee.
> > >
> > > Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521
> > > gigabit ethernet phy")
> > > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

> > > +	genphy_c45_read_eee_abilities(phydev);
> > 
> > Don't you want to return error if genphy_c45_read_eee_abilities() fails?
> 
> EEE is an optional functionality, and the call in genphy_read_abilities() has the following comment. Therefore, I do not return its error here either.
> "
> 	/* This is optional functionality. If not supported, we may get an error
> 	 * which should be ignored.
> 	 */
> "

Ack. I've look at the code, and no one is even checking for the return
value anyway.
