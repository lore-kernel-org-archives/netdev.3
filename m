Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA5231E825
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214052; cv=none; b=utj/QOgOuiaoodJeTlJIrB/gLdWt+taPjLdLElD6c6N1krXdcvNYdR5nyJQNMaYYf4iRly+ykU+HoeeHbAYX1xRukRZvkws3/+C8V8/IP3AnK6N8nj/FIMF4FyFusTu3HsfH1Y/M6kq0QGm/mDl4c6DULT8Y//ViKANbw8mLiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214052; c=relaxed/simple;
	bh=n10F7fh22NV/jCWbwe1x/iP5oDU29w3qvRkgjfcDCak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQEmzWa7/WJasEfageFKvjWPRvSYhM2pnDoKivnVd10ajJSqriR4vkJ850t3gL3P4f7JEkzhzuDlu/CpVtlFRGIBdLMFQEQ274sd18TMkXm2mwfS4Od+GfoOqRFoIXzNJfrG7bt1QnxRkN04y6lp9XahO9gSA3ssb+U1M1mo7FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YEmEuPZB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YEmEuPZB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VzHMLcYxXuC1b7JMl3FupKpgsFmG1z3nap4YDS6ySMs=; b=YEmEuPZB4HoQriFey3CX1RyNTs
	429bhpQkUMw0iNQccVXtabvRNWf2Lg3s7xXEKMP2j0KZErgP0codzsViAGEjK/BQSXj1GKk5VyV+k
	fClNq3nbcDLbhNGH+VrTNp3yGBtXGWy7kdpMgeAf7AtQskjC5JWRXJ6RZmzlv4UvSmHw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPOqe-003i8u-TU; Tue, 19 May 2026 20:07:20 +0200
Date: Tue, 19 May 2026 20:07:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH 4/9] net: mdio: realtek-rtl9300: Add pages to info
 structure
Message-ID: <eafa6d73-082b-4c31-bea5-09566a5e7314@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-5-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519165747.1288903-5-markus.stockhausen@gmx.de>

On Tue, May 19, 2026 at 06:57:42PM +0200, Markus Stockhausen wrote:
> The Realtek MDIO controller has a paging feature that allows to run C22
> reads/writes in one turn.

You need to be careful with the wording here. C22 has no concept of
pages. Pages is a vendor concept not an 802.3 Clause 22 concept.

> At least this holds true for attached Realtek
> based PHYs.

And this makes the point.

< The controller is given the page, the register and the data
> and it runs all the page switching in the background in hardware.
 
> There is however one special page that allows to pass through all C22
> commands directly to the PHY - without any caching. This so called raw
> page is dependent of the hardware. It is the highest supported page
> number minus 1. This is either 4095 for low port count SOCs (up to 28
> ports) or 8191 for high port count SOCs (up to 56 ports).
> 
> Provide the number of supported pages as a device specific property.
> The raw page directly derives from that as "num_pages - 1". Make use
> of it where needed.

I've not looked at the other commits yet, but i assume that in order
to not break the Linux model, every access goes through this raw
page. So why have the number of pages when all you need it to know the
raw page number?

	Andrew
