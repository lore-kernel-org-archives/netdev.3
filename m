Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFB9478E49
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131100; cv=none; b=fZu5DsCIG523GOX4mcsyAJzpAXLbKceLtIhaLHYjWUTHjehH1npnZPIZoLqw/qjMC/ld4+0CGMZ220ADi5olU5MBdvDwc3szEyT7PTaJMIR7HwyWtMeaBjTZtxT7I3x8DUw0ETcerIDpg+dcy/KnHnlF/IVUpycX8nQeXTzLdSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131100; c=relaxed/simple;
	bh=jnXJUyKEzUOe1DGopQmuWdcuJdGM+OlM4MR9U0HckE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAhoG+hUrKz+3t1UaxM9KQm6csorhPKTWsDhuARFqFIgDMGdjDsIlzXc7mGx1gmFJAAB5tqJVhI8E32qBpqK0utjlRcGvRPLeZWe5roKWQRpqAih5H7WswTtJ6n8ZBlPZjQ6Ru87Fj9thx8Q/wv8qSABlyc9i1Sez1+1Oyc3iT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=46YdHvrS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="46YdHvrS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9vB138tRCu1D++im2GbnTzKT34GL5TbeGe43VQSLV/Q=; b=46YdHvrS4vXuUrSDlLBI5MbwFl
	PgS+c3JrySkleZO3JRrNLA5JqhIo6yac6SXxNzqOFl8/+XUh3xHuFt16tvjtriCP2iY2kK66QOz2k
	e+ImafMpvRP54+d0SnVN6vTn+WX5/VD5sIW/WnkvgduzyRan5FCQMBnnUXxLIt4D7RJI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wk200-00CNb8-8v; Wed, 15 Jul 2026 17:58:16 +0200
Date: Wed, 15 Jul 2026 17:58:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
Cc: Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	=?iso-8859-1?Q?Dr=2E_Lars_V=F6lker?= <lars.voelker@technica-engineering.de>
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Message-ID: <44ec224b-3c50-4aa6-b460-d7d7df175259@lunn.ch>
References: <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <23323308-6278-47ba-834e-662b0e408705@lunn.ch>
 <AS4PR08MB8021E0A64800F977B6887141B7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <cd58995a-6bcf-4283-a072-84651a4f0031@lunn.ch>
 <AS4PR08MB80219505FEC2334B503C55DCB7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <259dbf46-5d93-4fc4-bf67-a7356a70ed26@lunn.ch>
 <AS4PR08MB8021EAE9D0196FA87849F74DB7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR08MB8021EAE9D0196FA87849F74DB7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>

> The issue is that automotive PHYs have extra functions, not
> available in standard SFP 1000BASET/Fiber modules.

But this is not a fiber module. It is a copper module. How are you
setting the connector byte at 130? Do you have an RJ45?
SFF8024_CONNECTOR_RJ45? The other option is SFF8024_CONNECTOR_UNSPEC
and transceiver byte 134, bit 3 e1000_base_t True to mean twisted
pair.

> Namely:
> 
> * 1000BASET1 PHY needs to be assigned a role (either master or slave), a standard NIC have no concept of this.

Nothing special here:

ethtool -s devname [master-slave preferred-master|preferred-slave|forced-master|forced-slave]

Standard NICs do have this concept. I cannot say if NICs using
firmware actually implement this API, but any NIC using Linux to drive
the hardware probably does, and it is a standard part of phylib, and
802.3 registers in C22 and C45. There are helpers for PHY drivers to
set the bits.

> * The PHY have multiple operational speeds, for example 100BASET1 and 1000BASET1

Again, nothing special. The PHY driver should enumerate what the
capabilities of the PHY are, there are bits defined in 802.3 for this,
so nothing special needed. From that, the MAC can decide how it
configures itself. Again, nothing special.

> In order to set those configurations, we need to send an I2C command
> to the SFP module; to inform it in which mode the user wants it to
> work (the entire config is just few bytes of data)

How are you intercepting the ethtool netlink messages at the top of
the MAC? You need to intercept the ksetting_set/get calls.

Sorry, but for Mainline, you need to follow Mainline way of doing
things.

Linux is however open source. Feel free to fork Linux, make whatever
changes you want, and ship your fork to your customers.

	Andrew
