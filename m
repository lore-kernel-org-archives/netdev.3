Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAD361946
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287633; cv=none; b=Ub95aW8jkGf/UgJGigwv8TM4A2UN2v7oQNPZYzpcaWz6oMofbcUA2SlqBlRUnZgDDgTQCKk7dH9xJkGXhzcwuqkLopZS+/Q4RrHy+pIl+TNTtVpy/yd/P3ZETzSym9wGA52iddCV4CkRqA8HNpoUu+Sv1EWpfWdcWHtq+uOAk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287633; c=relaxed/simple;
	bh=Saj7mGoAz64H/GAiOC3O4o+u0GdZFMvws7XeBicM2rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHXn0DZzDOLTpM+fY4VeJbiZecyhiSoCAmbvaonV2l2ylq7JTkkPpBEvKOWmoouz7f6S4zpA3151Ja71xAzKmlkAWFvGuDQ0ohigutmigO1Ed9Uw2cWsOxjIjcnkWWc+vJ1zqzPLXcKUmEQG/GO8JGmaF1/HN8v9yumhGhjWhlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1O0zmgbf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1O0zmgbf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=5acy5+l25y5LUNF3WKruroAQptdk3m6LUPLS1dXFFHA=; b=1O
	0zmgbfrKkqXGxFQeXsUp05sQWJyppHRUWeW4KNIxe52XNnaKn1PScu+vPviMEyphnFQzJRlhc3VcF
	zQAZKyLNBfW7svf8lIj6JBjMLvF9EyRCXdxuU1Iep5SC6d2mOs3TgI2nOdXWdZAuJ4hxkvbS5WKGs
	PULI82gHo42nYZg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wt50Z-00Gp0L-Ka; Sun, 09 Aug 2026 17:00:15 +0200
Date: Sun, 9 Aug 2026 17:00:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Semih Baskan <strst.gs@gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: skip EAP mode setup on Northstar SoCs
 when using port 5 or 7
Message-ID: <1ec9fffb-77a5-42c9-874a-8a8e807e6e50@lunn.ch>
References: <20260809093934.28098-1-zajec5@gmail.com>
 <CAOiHx==_HzdmNN5BY4DMh3Cr6JK5oQri3ZCNWN9v+xQPjzQZkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx==_HzdmNN5BY4DMh3Cr6JK5oQri3ZCNWN9v+xQPjzQZkg@mail.gmail.com>

On Sun, Aug 09, 2026 at 12:39:58PM +0200, Jonas Gorski wrote:
> On Sun, Aug 9, 2026 at 11:39 AM Rafał Miłecki <zajec5@gmail.com> wrote:
> >
> > From: Rafał Miłecki <rafal@milecki.pl>
> >
> > Northstar devices have 3 CPU ports. This design was meant for dual IMP
> > setups when WAN traffic goes to port 5 (IMP1) and LAN traffic goes to
> > port 8 (IMP0). While all 3 ports support Broadcom header some features
> > are not available for ports 5 and 7. Trying to set EAP mode when using
> > those ports breaks standalone ports.

> > +       /*
> > +        * Northstar devices (SoCs with BCM53011 / BCM53012) have 3 Ethernet
> > +        * controllers connected to 3 switch ports: 5 (IMP1), 7 and 8 (IMP0).
> > +        * Each of those ports can be used as CPU one as all support Broadcom
> > +        * header but ports 5 and 7 have some limitations.
> > +        *
> > +        * Setting EAP_MODE_SIMPLIFIED with port 5/7 used as CPU port breaks
> > +        * standalone ports, see:
> > +        * https://lore.kernel.org/netdev/ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com/
> > +        */
> > +       if (is5301x(dev) && !dsa_is_cpu_port(dev->ds, B53_CPU_PORT)) {
> > +               dev_warn_once(dev->dev, "skipping EAP setup because of not using CPU port 8\n");
> 
> We should print a bit fat warning at probe time, since this is
> essentially a broken device tree configuration.

I was wondering how we got here, is it a device tree problem, but the
commit message is a bit vague.

I agree, for a DT problem, it should be reported at probe. After that,
the driver can do its best, but should be quiet.

> EAP isn't the only feature not working, anything that relies on trap
> to CPU is broken. E.g STP also won't work, likely (if ever
> implemented) bonding would not work (LACP frames won't be correctly
> trapped), I assume LLDP would be broken, and any other protocols that
> rely on reserved multicast addresses as well.
> 
> So we should strongly encourage users to fix the device tree and use
> port 8 as CPU port.
> 
> Also can you try to move the CPU port on all devices you have access
> to and send patches for that where it works successfully?

I agree. This should be changed into a patchset.

1. Move the warning into probe
2. Update the binding .yaml to indicate such a setup is invalid.
3. Fix all in tree .dts{i} files to make the new warning go away.

If there are any boards which cannot be fixed because the correct CPU
port is not wired up, we need to think further about what needs to
happen.

    Andrew

---
pw-bot: cr
