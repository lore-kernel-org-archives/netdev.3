Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879D477E4D;
	Fri, 25 Sep 2026 22:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376640; cv=none; b=D1duI5b7xUUdbzMnTkK32W9vO51oAXS8WEwTQoCqjTLA4CU7upROVsp5oqG1iIG7xZ6r0O5E+6KTaY5fEdIdC3G0wNYtphvyajpnorOZ46lTspMfkxBb67cDSxSignm0MaJBu0UgyzkZyxrUJCw6TBmidY4KA8+fHIz5YPckgI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376640; c=relaxed/simple;
	bh=K67OLEesOc9nO2zeVBV+6/k5zzTb6mq4mIFmerb2zJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFQThqT9z4rjWvJQECbui0D6FOe7yjs85vFWbyxScuRajK4fb8W/10AcqH5XAG5/8lD22bcI8jjKgqwnfmFf7xxMK2zfPohvQALvvanRijXQer0OqbCNbcpgfw7v6e1iqenDRXLSYZpm/F01VsfTBLPrbDrjKjK4qSXtktjxIj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4eXsj751; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4eXsj751"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=J4L3+lqhmes3y+7WfrQGnAbo7ex/YqSvINFt5W+eRhM=; b=4eXsj751EpGiScTX9KlpUPwfpW
	NQL4mRuuVCPQRTOFZyj8G5bzTGWuVIMa2HFrrLL0ARiBQhF6jZRSqoIZTa0yyTpt8IOYeKYYIs9AY
	D9TgkNA/NBZST6p18Ac1ZoZPCAKj+XyWUn70HrJCi/eSE8IHTf2KPnYPuqmZVGt/sxCg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAEkT-007Jx9-FL; Sat, 26 Sep 2026 00:50:33 +0200
Date: Sat, 26 Sep 2026 00:50:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>
Subject: Re: [PATCH net-next v17 10/10] Documentation: networking: Update the
 phy_port infrastructure description
Message-ID: <e8633f0d-9c6f-4986-ae92-0f37002c1e35@lunn.ch>
References: <20260909093912.1290810-1-maxime.chevallier@bootlin.com>
 <20260909093912.1290810-11-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909093912.1290810-11-maxime.chevallier@bootlin.com>

On Wed, Sep 09, 2026 at 11:39:11AM +0200, Maxime Chevallier wrote:
> With SFP now properly supported with phy_port, add some details in the
> documentation. Fix a typo along the way (driver -> driven).
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
