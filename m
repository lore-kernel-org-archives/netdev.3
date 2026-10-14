Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3405563FD1;
	Wed, 14 Oct 2026 17:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791997993; cv=none; b=isiR0XC1nFAFCE0RaqOO/XDHkRZlAMnXWHLZplJf07CP0zYBvfVHfMSVYj3e9RNdgwv/HmcPAGX74jSRnqR4G3ComAZ2RoHNG9E7Kf9wAhnffHd6CXkjzFSG488h2MKz2RVaRTeJ2mBH4Bnkngf5RAkjnO/90x6c41fB//HDIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791997993; c=relaxed/simple;
	bh=CVQxqMXh+iMEuOOzMPhyTVJt6istyAm4Y525++iIRZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHlVbW3B8TeSNZE9xPY8Z3tpMMZZWfCdZ9XU7XH9BPIRpLWR0c3O/CqTS11a4G9Jqp2WkTNG00PBVIdXVLxixLhsb/0IUTpTUq7cy4e/yPecUcY4tt6wjGeMnyv3NLitXfA5eF218ImYeJfs9GIbMO/KDsj3eoePEuZkhhtPsb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OgqjSpOg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OgqjSpOg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=hsC2J19Y8A8XnCWJEN9jMl8NLoIbisoNJrizDvKnD3Y=; b=Og
	qjSpOgR6hRC+0DD1i47+0fZDjgyHKJHlZMM7QbH3O6fzgRkTFKQYfk3UVMlwXTOmCzjE9GT9+aF28
	xQiNI85DprNM7wyYfLs4Y/Q2dD3ZWKrA7q6zNoEBDZgJSdzqO0j7nkPti74UiTBr+RA3s4UXyvziR
	ivwnPqrwfOd6i2c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xH2XF-00Amng-Ni; Wed, 14 Oct 2026 19:13:01 +0200
Date: Wed, 14 Oct 2026 19:13:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phylink: allow stopping a suspended instance
Message-ID: <209159e1-bd74-4462-bf00-8c2421af29e2@lunn.ch>
References: <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
 <224296ea-f196-44f3-91d6-1461846c55a5@lunn.ch>
 <CADvTj4qgcXE6azsNx-Wg5afatezLeuctGR607qO1WhZSmuqzBg@mail.gmail.com>
 <7ffb9b38-75e1-42e2-86e2-21a1666fc51f@lunn.ch>
 <CADvTj4pVtoMh=H=nJJaPxYf-ZqU8xJEJLMANUAXTFJWb5zBe-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4pVtoMh=H=nJJaPxYf-ZqU8xJEJLMANUAXTFJWb5zBe-g@mail.gmail.com>

On Wed, Oct 14, 2026 at 11:07:27AM -0600, James Hilliard wrote:
> On Wed, Oct 14, 2026 at 10:02 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Tue, Oct 13, 2026 at 01:46:24PM -0600, James Hilliard wrote:
> > > On Mon, Oct 12, 2026 at 7:22 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > >
> > > > On Mon, Oct 05, 2026 at 01:09:05PM -0600, James Hilliard wrote:
> > > > > After a failed MAC resume, a driver must be able to stop phylink without
> > > > > resuming it and reconfiguring the failed MAC. This is needed when recovery
> > > > > leaves the interface administratively up but detached until a subsequent
> > > > > down/up: ndo_stop() must finish the suspended phylink lifetime even though
> > > > > the MAC could not be restored. The missing transition was identified by
> > > > > code inspection of the stmmac recovery paths.
> > > >
> > > > I don't particularly like this. It feels like a workaround for a
> > > > broken MAC. It would be better to fix the MAC so that resume does not
> > > > fail.
> > >
> > > Fixing an identified cause of resume failure belongs in the MAC
> > > driver. The intended purpose here is narrower: allow orderly shutdown
> > > after the driver has returned an error, rather than recover the MAC
> > > through phylink.
> > >
> > > stmmac_resume() already returns before phylink_resume() when hardware
> > > setup fails.
> >
> > But why did the hardware setup fail?
> 
> The exercised failure was injected, rather than a diagnosed spontaneous
> MAC fault. This change comes from auditing the existing error paths for
> the deferred stmmac recovery fix.
> 
> > This is what i mean about it being a workaround.
> 
> The deferred fix addresses a separate software failure: suspend has
> already disabled NAPI, but an unsuccessful resume leaves the interface
> administratively up.

But why was the resume unsuccessful?

Sorry, but i've asked this multiple times. You never give a good
answer, so i'm just going to:

NACK.

	Andrew
