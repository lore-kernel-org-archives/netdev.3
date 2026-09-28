Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A84E77F2;
	Mon, 28 Sep 2026 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609258; cv=none; b=ERrWSm6fOLvkv2mQVbo1Adimtkq246QfLSQ6DoUBDoU6XaV/EZ4hOXfJOjRSHy3+zY1OAe5exF8rTN6kV197btfZzPVX1Y6m9/gx4MKl8sn9zbB8JF0Knb9mbFql2TMR1FFrkNk9q1h1PQRUVPu1pl86Rog+IUL9V7LU37ui7d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609258; c=relaxed/simple;
	bh=IHh8o6Eyf4sfC4fE7VxeoWB53IkyZe751WSqQ1qUIoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVvvolLN5yIk3gt1GTnEGYjXlOzw7h2/h0qmIgt7jmrGEJv18pedO7EaV6XBbzg/JytAFRkQ7gVU1z6REXBubEz87l+21KlLoyUZtLKI4mAR2wq06RJAZEuY5OvW3I5usvNx6F2z75wCTaryhiwxNXadWTifql0hWevxurFzB0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LENBGqWo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LENBGqWo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fK2Cf6Dp2mNF6xY+hMUHlfkWyvQDVQsBw2Z/h6yHNDY=; b=LENBGqWo/bPjVoj6Wj2SGnL4hz
	lZP+sTVfa+B6d83MHJKlY5BFXec/2Y0UQ8iBIdRo+h4u7Ug+rFqB1bR2InYp07ZvvU3scwbB0b9Ro
	f0kPOViyMgVqTORdUwtsM321ihuY9B19tknUYM84+L7GBsih5+rKG67j3nvjXtV2Jx18=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBDGJ-007jt8-6i; Mon, 28 Sep 2026 17:27:27 +0200
Date: Mon, 28 Sep 2026 17:27:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, neuromoments@gmail.com
Subject: Re: [PATCH net-next v12 01/15] phylink: Add phylink_mac_interrupt
Message-ID: <07432e01-1ae7-460c-ae58-8ee5794a9033@lunn.ch>
References: <20260916-ax88179a-v12-1-60c04c9924a2@birger-koblitz.de>
 <178968029017.22033.2874254681410388676@kernel.org>
 <17164abd-05ec-4b6b-bc51-a017cc87047b@birger-koblitz.de>
 <bb4043d1-e89e-430b-8f68-e64fc2b0d11a@lunn.ch>
 <21485f2f-b446-4a38-86c3-dc8d73260a0d@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21485f2f-b446-4a38-86c3-dc8d73260a0d@birger-koblitz.de>

> Thanks for the reference, I understand this better, now. My suggestion would
> be to add a comment as part of the function description:
> This function may be called in interrupt context, and therefore cannot take
> a mutex. However, it is safe to assume that the reference to phy does not
> disappear during the call, as only an SFP module may be unplugged to make a
> PHY disappear. SFP modules however do not support interrupts.

Great.

Thanks
	Andrew
