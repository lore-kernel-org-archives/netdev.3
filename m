Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3363A451D;
	Sun, 27 Sep 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790518741; cv=none; b=YubEKrxqKBMAVl2W//mTc5/4PazrF5PPNYzH8qIbFApdZ+hrcf3gCDEY10ank6MRhQZ/VLOnYZFOCSRoMw4XXCTuF8h/PFpejULw8jE77luLewR/IwuvIZIE+MAnQ/Ahj2SoG83vYTYLxS0qjR5bdVl5girutMYX5GOgxmXntBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790518741; c=relaxed/simple;
	bh=Z714Mjof1T+sY9Yb8gP9rQT3vhyW2YxosEAHVxi3JCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDfOfnx2K9fITFNcTsuNj/OzQ7l9RHIy7lCcGN1wON+MwgHTioYxhEOZB6tNOhWt1e/CUTwkl9momqTpoCTxZLU5lUC1RWfvQYZ/l/fAHCRMDhXm9mlEPKut/us9tevd/AuO1s4Imi3RgjAgAvh4VwJGMzJl75Z0tJT6EuRkjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hya7EIw1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hya7EIw1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=wCoLihxYq/933oU5j6FovhD5Bp++7vB+8UCbH6zZyXM=; b=hy
	a7EIw1o+BIzVY9mIPxOVvMEoNE1dg6tBbJJ7Ot5azVLwYPvBQthqc852HQ8h4N8ToEDIrf1fhf/BL
	sqF+BWnRddwlrXl+9kU/wnhOVEn/xv+ydAm/duhp86Zgb3V96mOAqyY+kJhzJTAyrFXA/uCqdU7FM
	Lk9KosawyHq+cfQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xApiK-007WKO-UP; Sun, 27 Sep 2026 16:18:48 +0200
Date: Sun, 27 Sep 2026 16:18:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: netdev-bot+sashiko@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, neuromoments@gmail.com
Subject: Re: [PATCH net-next v12 01/15] phylink: Add phylink_mac_interrupt
Message-ID: <bb4043d1-e89e-430b-8f68-e64fc2b0d11a@lunn.ch>
References: <20260916-ax88179a-v12-1-60c04c9924a2@birger-koblitz.de>
 <178968029017.22033.2874254681410388676@kernel.org>
 <17164abd-05ec-4b6b-bc51-a017cc87047b@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17164abd-05ec-4b6b-bc51-a017cc87047b@birger-koblitz.de>

On Sun, Sep 27, 2026 at 11:03:17AM +0200, Birger Koblitz wrote:
> 
> 
> On 17/09/2026 11:24 pm, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider:
> > 
> > Critical: 0 · High: 0 · Medium: 1 · Low: 1
> > 
> > - [Medium] `phylink_mac_interrupt()`
> >    (drivers/net/phy/phylink.c:1621-1628) reads `pl->phydev` with no…
> 
> This does not look like an actual problem, as the interrupt is not really an
> IRQ, it is a call from the MAC layer, calling phy_mac_interrupt(phy) did the
> same in the past.

We need to be a little bit careful here. phy_mac_interrupt(phy) can be
called in interrupt context. It does not perform any blocking
operations, it just queues up the work to handle the actual event.

Here it is used in interrupt context.
https://elixir.bootlin.com/linux/v7.2.8/source/drivers/net/ethernet/broadcom/asp2/bcmasp.c#L81

I would expect the phylink equivalent to be the same.

Since we are in interrupt context we cannot take a mutex. But do we
need to worry about phydev disappearing? I don't think so. In
practice, ignoring unbind via sysfs, the only way for a PHY to
disappear is for an SFP module to be hot unplugged. But SPF don't
support interrupts, so there should be no need to use
phylink_mac_interrupt().

It might be worth adding some comments here?

   Andrew
