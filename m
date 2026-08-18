Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B7466B5E;
	Tue, 18 Aug 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787058650; cv=none; b=NmGeKHfvFGBL5kKsxYFqKysidA3v51CVYd3TaSlrD9j7GwFXSsbei1+lU9ajRsQqFL1uCTeosY3L5w+dgAdIZKCSTVJGGvouVdUrwGzvkbXCCrD4Lqw1Lgu2jKe9fHKj4ZymUS0VfpDiexVQElGO5Y1YebkkFqgHlAr62C80WV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787058650; c=relaxed/simple;
	bh=07EAIixBzY/yCB52or2BvZMc+hEquo+XOX+dCMidaBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3iu1IW665OICYewZpaXZRucMGK9NTWW+y82GKB2fQD4EpCNkSgWp4T9s3JyjxhfY87dmFz0IAGLe0vkZTUApRKy3lOJjNCfUGiR/Q0CVdaUJHWIZI7rkiKOgqRNkUKI2BGF93aw20arlz6voDDuy3/KJ+eOsZUDse4S3dLCht8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PTDB97bQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PTDB97bQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M4+64oG3F01w5MagjBhSI357B+hDykwWi44WkgxNBk8=; b=PTDB97bQnzCRe+70u8B/T/J/yv
	Q+ZYgNhIyFbSBoWGED7Y2zWT+DrFC8hZwlzM/JD+4aqoPL8T39Wx0z63DCGNdVe9OhFqjXYUV4GFY
	1ouCnHIX0ud6G6NcxQ8pw/C217/sUWOcIRzFq4mf9FpNCcpKBlB8v/BXR5TxFkVxw9mQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwJaD-000TNb-PZ; Tue, 18 Aug 2026 15:10:25 +0200
Date: Tue, 18 Aug 2026 15:10:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl8365mb: add EEE
 support
Message-ID: <71b40b25-1681-4df4-abe4-c4f7043875a7@lunn.ch>
References: <20260817134758.4182833-1-o.rempel@pengutronix.de>
 <20260817134758.4182833-3-o.rempel@pengutronix.de>
 <8be5a31d-55af-47ba-bd7b-4e581c3950bd@lunn.ch>
 <aoROhXF2XJabMMM8@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoROhXF2XJabMMM8@pengutronix.de>

On Tue, Aug 18, 2026 at 02:22:29PM +0200, Oleksij Rempel wrote:
> On Mon, Aug 17, 2026 at 04:53:52PM +0200, Andrew Lunn wrote:
> > > +static int rtl8365mb_phylink_mac_enable_tx_lpi(struct phylink_config *config,
> > > +					       u32 timer, bool tx_clock_stop)
> > > +{
> > > +	/* The hardware manages LPI itself; there is no MAC-level LPI control.
> > > +	 * This callback only signals LPI awareness to phylink.
> > > +	 */
> > > +	return 0;
> > > +}
> > > +
> > > +static void rtl8365mb_phylink_mac_disable_tx_lpi(struct phylink_config *config)
> > > +{
> > > +}
> > > +
> > 
> > So what happens when i do:
> > 
> > ethtool --set-eee eth42 off
> > 
> > or
> > 
> > ethtool --set-eee eth42 tx-lpi on
> 
> In current implementation, with "tx-lpi off", the driver will return
> -EINVAL, "tx-lpi on" will be passed. It is aligned with KSZ driver.
> rtl8365mb_set_mac_eee() is used as filter.

Ah, good.

> Currently it is -EINVAL as in KSZ driver. If we will go with -EOPNOTSUPP
> then probably both drivers should follow it.

-EOPNOTSUPP would be better.  It is not an invalid configuration. This
 hardware cannot support it.

	Andrew
