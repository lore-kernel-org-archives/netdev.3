Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AEC38C401;
	Tue,  4 Aug 2026 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785866912; cv=none; b=bXUEx7Bb2ITSgObhOFtr04BxS0TJeIUX4V+kUtu6iHDGHO5cDpmKNyJTixAKVBVr92KetgxbYiEhtLNi5Mx5juJz1SKhM0UH611u0Nr0gUcwS3t8xRxAXyfzd4SGOVnpqJwxIudvWv+agCxvJ6dU3n4Q6x2D3t9jBkUQPRb+6YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785866912; c=relaxed/simple;
	bh=AFXKGqywNtt35BVbUbavYl6E98YlXgxG2GHuWS9cNF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwyx6t0V/KeMGIQ5/h06ihKnFK/g+Fy7LUS2g+5KraZUIh8sMrpaPXCWkIs/RZyfw+jTQBahe1743hPb7etjGdEHEv5IXeESPQNNQ9AW+PeKinds0c0c4kaCt39lzk39JiQBd0RU6IjxazMCuyVpUS4QnYr2sHUMeDjEjKzYl7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QKFRQvVv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QKFRQvVv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=8kfQfoeExNgnaWTd3IYmnlXLicSQbdbr3t2fr0Mx4mY=; b=QK
	FRQvVvF5NL4EtRtchB6oA4eRCmDVREx6FctONxJpn/SYnEo1G0gGDA6e+5/4rowycif7vu30Mi6SZ
	3DIX9yzFJ3+ZEaNefyPhp+jliV32T02QzA3PTLfKPtvp4WI33zqY0pjHqDf4A+B8oH+feBnu4v2Wl
	THy9dv3k2h3+PEc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrJYp-00G2CU-1C; Tue, 04 Aug 2026 20:08:19 +0200
Date: Tue, 4 Aug 2026 20:08:19 +0200
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
Message-ID: <2536faa6-0888-47e1-be99-127e098929fa@lunn.ch>
References: <20260803-submit-mdio-of-dynamic-v2-v2-0-f8841f3124d7@gmail.com>
 <c1c5ce0f-2c65-4c19-a525-cdd2ef33b6e4@lunn.ch>
 <CADvTj4o+B933k4TUshgcvZ4tENDbit3fHEBtwy5ODpsf60osyw@mail.gmail.com>
 <c6f001d6-b9db-4434-8468-4705d62ffdbb@lunn.ch>
 <CADvTj4rA5QaeccDvSP2qrseFKv+7MKhj=pRWdSnNzKKjMCdK6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4rA5QaeccDvSP2qrseFKv+7MKhj=pRWdSnNzKKjMCdK6g@mail.gmail.com>

On Tue, Aug 04, 2026 at 09:10:30AM -0600, James Hilliard wrote:
> On Tue, Aug 4, 2026 at 6:54 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > If this was a hat on top of a SBC, with an EEPROM indicating what the
> > > > hat was, then maybe DT overlays would make sense. But from what you
> > > > have said, this is a fixed PCB design, nothing hot/cold plugable.
> > >
> > > Some H616/H618 boards have the ethernet port on an expansion board:
> > > http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/2W-expansion-board.html
> >
> > I don't see a list of pins which go across the connector. Does the
> > MDIO bus go to the expansion board? Is the PHY on the expansion
> > board. It all looks passive to me.
> 
> Pins are listed under "24Pin expansion board interface pin description":
> https://orangepi.net/wp-content/uploads/2023/10/OrangePi_Zero2w_H618_User-Manual_v1.1.pdf

So just the lines after the PHY, basically the UTP lines without the
twist.

So please stop wasting my time by making invalid points.

   Andrew
