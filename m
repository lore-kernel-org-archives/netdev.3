Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DB73C09F2;
	Wed, 14 Oct 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993764; cv=none; b=feOVHEMiQ1Dyrm85cYEreJWrQ+gixQoCkwM0EyLJ/79brT0PCH6/6TLiigaHSffSOPx/k4R/Fbyv7Sd2BvNK1FdfYP4QtmpmuJa9SBd+vUjt/HftaZpiWTLh6kJ7xh1M8cl7IrHrCibpAqCiFEFf1Fq0g2jIOqXnElY6nTiVSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993764; c=relaxed/simple;
	bh=eHtrIYNUI30G3uIrgMWpjKj1RPDVGNJ3XDGwXzNmooA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4fPzsDOqFiaOo0rz/macM4YFJqiRQeEmcwKNxcjLqHgqoUh+AV7A2yTsK449nkIEMAYn99ULA31f7cfZzncvbxU6bgGcPXS1u0/dTd+GuuIlVeHcaUUWSsejzMr/EVwe/JtOF6pPb4oxkI3q5UsySprPKD5ETQ543VghoWSqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DbHwErFE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DbHwErFE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zxbJyqOh3q1HjCr39eG3Dlk0wV+43/JWcmZnniHJUAc=; b=Db
	HwErFEH3SO459MkYWZsOEjdbPMKnF3pswDJ4SfxwKfBrWkQLohdvXOOduZz5eVwjaZOsLIT9MSiR7
	QL93wzU1t1JpoGNdYCKS6Jrjjd4VNHF/vO/mna9MN03gKe5ZoPmX8FBDrmI3b9nzYptK9FZ3HSrmF
	0A5jZO1GEss4JvI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xH1Qr-00Am9g-Ib; Wed, 14 Oct 2026 18:02:21 +0200
Date: Wed, 14 Oct 2026 18:02:21 +0200
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
Message-ID: <7ffb9b38-75e1-42e2-86e2-21a1666fc51f@lunn.ch>
References: <20261005-submit-phylink-suspended-stop-v1-v2-1-8b8e5d53dfc2@gmail.com>
 <224296ea-f196-44f3-91d6-1461846c55a5@lunn.ch>
 <CADvTj4qgcXE6azsNx-Wg5afatezLeuctGR607qO1WhZSmuqzBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4qgcXE6azsNx-Wg5afatezLeuctGR607qO1WhZSmuqzBg@mail.gmail.com>

On Tue, Oct 13, 2026 at 01:46:24PM -0600, James Hilliard wrote:
> On Mon, Oct 12, 2026 at 7:22 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Mon, Oct 05, 2026 at 01:09:05PM -0600, James Hilliard wrote:
> > > After a failed MAC resume, a driver must be able to stop phylink without
> > > resuming it and reconfiguring the failed MAC. This is needed when recovery
> > > leaves the interface administratively up but detached until a subsequent
> > > down/up: ndo_stop() must finish the suspended phylink lifetime even though
> > > the MAC could not be restored. The missing transition was identified by
> > > code inspection of the stmmac recovery paths.
> >
> > I don't particularly like this. It feels like a workaround for a
> > broken MAC. It would be better to fix the MAC so that resume does not
> > fail.
> 
> Fixing an identified cause of resume failure belongs in the MAC
> driver. The intended purpose here is narrower: allow orderly shutdown
> after the driver has returned an error, rather than recover the MAC
> through phylink.
> 
> stmmac_resume() already returns before phylink_resume() when hardware
> setup fails.

But why did the hardware setup fail?

This is what i mean about it being a workaround.

    Andrew

