Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9513A8727;
	Tue,  4 Aug 2026 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809171; cv=none; b=PmhQzKnFzZyfQOo0zUoCzHfvsUrqFEaOjteIce2wPxdnlIweLg+mOU1WqE/pTQynaraFJ6i1ZbU1M9sEPgxlDaWxtxIA+Nc0rbsE9SRbCafv8S35GmBFR7J6N6Zc1UuSZR0+QGcevrWhI0UaVeRwsBGArWWLGo8MGduWDMZdul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809171; c=relaxed/simple;
	bh=r25A/IN2BtM+++kmlhDJMaLKgmohPDQx4+uNDx4kjoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKsXPe8t+z5KlILSRBYI0XoBbJ3Fmp5bx1Fy41KeHtw0KcuxF13dec2ZMsPjHB8tKkl6WUFEsGFMYEnZ5+IYH/YTatNe8Dqr37lKwBl/FxwAveeZSzEwbeyT3t2X4m27KYcQIWp9v9leGI0wEg5UlvjknaTkOqGfrOwCTJ0NfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4PldE1N8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4PldE1N8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=oXoQtXHLerFa43HszVutg9qezy/tGGJRS2lF85L5Apk=; b=4PldE1N8Jr635tZA5HGtjidlQy
	LdNEntUkPYUkIERrlxnmKiP0/doeRK4goTmhlIfWsSi9CQy+ybKQoeFD2jaU+1iMRmuHL1jDJnlTr
	ZIEw+n8e3kom37DW4LF7G4zQCivsRDkhl/TvQNtyQJoBqQ1toxW1jVnUFtQI/vSwlibU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr4XW-00FtGw-Pc; Tue, 04 Aug 2026 04:05:58 +0200
Date: Tue, 4 Aug 2026 04:05:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/3] net: mdio: support dynamic OF device
 changes
Message-ID: <c1c5ce0f-2c65-4c19-a525-cdd2ef33b6e4@lunn.ch>
References: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com>

On Mon, Aug 03, 2026 at 05:48:09PM -0600, James Hilliard wrote:
> MDIO buses enumerate firmware children only when the bus is registered. A
> later devicetree overlay or status transition is ignored, unlike on I2C and
> SPI buses. Supporting live reconfiguration also means that population and
> removal can race address scanning, PHY attachment and bus teardown.
> 
> Patch 1 factors fixed-address child registration and legacy PHY scanning
> into helpers shared by initial and dynamic population.
> 
> Patch 2 serializes MDIO device-map changes, reserves addresses while
> registration is in progress, and coordinates scans, attachment, removal
> and bus teardown. Dynamically removed devices remain pinned until bus
> teardown, preserving the borrowed-pointer convention of
> mdiobus_get_phy().
> 
> Patch 3 adds the OF reconfiguration notifier. It supports fixed-address
> PHYs and generic MDIO devices, scanned PHY addresses, and Ethernet PHY
> packages. It also preflights overlay removal and rejects removal of
> attached or in-flight PHYs before their firmware nodes can disappear.

This is a lot of complexity which i think should be avoided by just
getting the bootloader to put the correct nodes in DT.

If this was a hat on top of a SBC, with an EEPROM indicating what the
hat was, then maybe DT overlays would make sense. But from what you
have said, this is a fixed PCB design, nothing hot/cold plugable.

     Andrew

