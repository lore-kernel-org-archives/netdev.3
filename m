Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503EB30F526;
	Tue, 15 Sep 2026 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476744; cv=none; b=ly1/W0lo50NeTD4+KSZva4f8VKBrJB4x4k0jgVsc7kOmBcUq2rvU8OKxrFO9G0Lbw8rzMVc6W/bWVFDzblzn1NqNFl8D+C+eckW1Y58URSxKmNwCWjONmJNXdnSYJU3PH0NAr6RxCdmosEPvnXmI+pIpghsYFXEFHXg5XxBcmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476744; c=relaxed/simple;
	bh=mMLYgR1AXITKQzBrT4eEkFvMzhMMthwpB1/vcGjJY4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGglWTCIFrtkaDCL5MdkowffwNZNXZGfX9UsdRsHSyAifzesPtEw6RNxXooenEGeiec3Fez2lrxAOse3cwhnDYdUO5u893CH/I/BIr6ocXcn+mFjT4DKK0OWVhWMMAq5D78m3mrR81X457ziDuewLfu4npbOk5qdLU5lfqdu/D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q0IvopDM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q0IvopDM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aVjmajoWZA+fNP8+N+fthhQUMSTEoLuyXpYERW7m0pg=; b=q0IvopDMkJ3dN7Gs4t40aq3mpl
	XPPRs92CTFuO6yGa2fPF572OlZdfmhqUdE6L9RlOxJeVUrLR/N46AB0PmdxF+YZ8VDvf+14AYvSVS
	RyEfrIJqW1H4T8vPoBq6PBIkcy6vJrD/ZLDNSXr+sLJ+nDLR4LFNNk6FI0+PitSeavdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6Sdy-005HDz-UV; Tue, 15 Sep 2026 14:52:14 +0200
Date: Tue, 15 Sep 2026 14:52:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Message-ID: <2346e6ee-4075-4d64-8e3e-8fbd1ce81cd6@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
 <3c2c5b39-6a7d-4cb2-af1c-b5015b6bf1e8@lunn.ch>
 <db26d5c9262069a11e5cbe00e176b81e40baebeb.camel@linutronix.de>
 <5c955c96-7883-4e59-97ef-9fc3b63abf58@lunn.ch>
 <ab7e4eeed1b8296188355413cce1aa2b2aa5c670.camel@linutronix.de>
 <b7fdbd43-d069-40e1-aff4-30197371739d@lunn.ch>
 <3007fddf91fb4260538073482f5148ce8ac6a6ba.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3007fddf91fb4260538073482f5148ce8ac6a6ba.camel@linutronix.de>

> Although mdio-mux-mmioreg might work, I have realized that it is not
> suitable here.
> 
> According to the switch documentation, the bus selector occupies bits
> 26:16 of the MDIO control register, while bit 0 is the transaction
> start/busy bit. A partial write might trigger an operation before the
> other fields have been updated.

Maybe. I can see at minimum it is a bit messy.  The mux would need to
write the upper bits, but set the lower start/busy to 0. The MDIO
driver would then need to read back the register, OR in the bits it
wants to set, and set the start bit.

This start bit is pretty common, and generally, writes without it set
are safe. But you need to test it on this particular hardware.

> Also accessing this register without checking the controller state
> could interfere with an active or failed transaction and introduce
> races (as noted by Netdev-Sashiko).

The mdio mux framework should take care of all the locking for you.
Take a look a mdio_mux_read(). It takes the lock of the real MDIO bus
controller, sets the mux, performs the read, and then releases the
lock.

The only thing you need to be careful of is write must wait around for
the write to complete before returning. Some MDIO bus implementations
don't wait, they leave it running, and do a check the bus is idle
before doing the next operation.

       Andrew
