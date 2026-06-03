Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E33DC4CC;
	Wed,  3 Jun 2026 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780455484; cv=none; b=dXc3QfKZfw0Irwvwp1zCjtrFknwi8GP/aIxfybZSl1GleTr0tha83ffo2XCuxAFq8F//LmMEPrMJeff71ratidhNcT9Zxkr/XznArd5NJ26zRgEJZbC4yaU6J2MgwuF5ZZaDj5ZAVpZJawmHoXgMuyLRj8x8y7zO9/V3K6k6sYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780455484; c=relaxed/simple;
	bh=32S/JeI3COWaV3zz0O0QavmW5XvRTB9WfOfkTWq86JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nV7YzavWiTbU1qTnsvnm6KtxHMZoq83p5gKDX/+h3mWOSkXYwIplRAahVC03zu0TAHPvjeaxCnZpO+HcKCHcy5BUNkTwZ62xrpAr+xqB0Y5ML87KEYvVspp5WLmcR8g5QvVJzGBZg2p5uagxe++o5d7Fo0Fi2Qj3tlUj1K82y/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dsaVZKFS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dsaVZKFS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fZSCPtkOATWB8zuR8SXfWy/LtG2NjTWEQXDI83pfLtE=; b=dsaVZKFSfz+B++OvfPtGKjktHN
	zMEoef0T50dYZz4Bu0x9XMoAk7Os27/A3YfwK5DhtbonXq7gerjn3PFJf7dXnIFb07I1r2qLsjNx/
	Tvhrg5LVTKgdHacRHE3oHN4PPjKrO1l46pZhYtGr+6dZjEcRdo3AdQ3tJwmrxSw7RElQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUbnf-005oSp-98; Wed, 03 Jun 2026 04:57:47 +0200
Date: Wed, 3 Jun 2026 04:57:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: "nb@tipi-net.de" <nb@tipi-net.de>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	=?utf-8?B?6aG+5pmT5Yab?= <freddy_gu@realsil.com.cn>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
Message-ID: <26c9ecf2-d284-4b4b-b41d-d0a84a31427a@lunn.ch>
References: <10b6718e8fe84e1895f82ea05c446925@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10b6718e8fe84e1895f82ea05c446925@realsil.com.cn>

On Wed, Jun 03, 2026 at 02:32:37AM +0000, Javen wrote:
> Hi, Nicolai
> 
> >> +/* Concatenated 4-bit speed code values (SPD_H << 2 | SPD_L) */
> >> +#define RTL8261X_SPEED_CODE_500M	0x3	/* H=0, L=3 */
> >> +#define RTL8261X_SPEED_CODE_1000M	0x7	/* H=1, L=3 */
> >> +#define RTL8261X_SPEED_CODE_2500M	0x8	/* H=2, L=0 */
> >> +#define RTL8261X_SPEED_CODE_5000M	0x9	/* H=2, L=1 */
> >> +#define RTL8261X_SPEED_500		500
> >
> > 500 MBit/s isnt a standard rate which also isnt represented in ethtool.
> > Is this just for documentation or intended to be used? If yes, how?
> 
> Giga-lite (500M) is a Realtek-proprietary speed: when two Realtek
> PHYs supporting Giga-lite are connected and the higher speed is
> disabled or unstable, auto-negotiation may fall back to 500M. Since
> ethtool has no SPEED_500 definition, the driver reports
> SPEED_UNKNOWN for this case.  So we add this.

Is it negotiated? What bit does it use in which code word page to
accomplish this? Is there a register which can be used to control the
advertisement? Can you see the link partner advertisement for this
bit?

	Andrew
