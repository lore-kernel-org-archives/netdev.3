Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488E1A6808;
	Sun,  3 May 2026 15:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821361; cv=none; b=GPJG6AXhP9shC6yFLNrP0IhfrN/sgSGJd7/1NU2VMUUMreZuu6OynEQDE6rWQXyFgqwTVsmD2rjB8werA86IU95N6635mrdEE08WDc7JuvcWRNAoL/I7jk94e3m+rPWJD7cBUv01Smdf0Dne9JKD7aCCkXKk6ZcaSSGQ06R1tS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821361; c=relaxed/simple;
	bh=B4u1yf6XCYjfHxnZlqZ92N6PosuuT1NEM8RoX52Sdy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIEdmKl+sOYbpBCT1AmWk49f2DUMY4I4kpNPGA1yWda2Ub4x5Vzd/Xs0GOK3kBwR8/79tclmw2Jpfzi0O93PUjIRrffjLBG7wEaznemTBiSxDXYgczs2kBoOHatZHBCG9BRsop67cgcWz18u8HQLiRItQAO2Ic5F+WbTHr0dF8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=z8CN0SXf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z8CN0SXf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=V4vajo9ZHeJX6wm70gR3OUzvzOPnc/VpEKoUULfy+YM=; b=z8CN0SXfLMJrbx0AvDydbPhxw9
	MuJBRrDp4aHs/H2OmXH7QO4WJcVOWHQoj7PzWiVcxczUEMabCqd+IlcqnENFrNDxDfL6mqEOsHFpT
	shD2tkSJbb4EBYHIp2J6BDwZuPdWcwATvbfdeGm88NqXdOlvLpHypvppB0EeKay9AP1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJYXn-0018to-Al; Sun, 03 May 2026 17:15:43 +0200
Date: Sun, 3 May 2026 17:15:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: ethernet: adi: Add a driver for the
 ADIN1140 MACPHY
Message-ID: <0b09b317-0a21-4b9f-aba9-0b9caa14c0d9@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-4-dd043cdd88f0@analog.com>
 <afc1cf8d-4a02-430e-89a5-b213c15a4f70@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc1cf8d-4a02-430e-89a5-b213c15a4f70@lunn.ch>

On Sun, May 03, 2026 at 05:36:13AM +0200, Andrew Lunn wrote:
> On Sun, May 03, 2026 at 02:24:53AM +0300, Ciprian Regus via B4 Relay wrote:
> > From: Ciprian Regus <ciprian.regus@analog.com>
> > 
> > Add a driver for ADIN1140. The device is a 10BASE-T1S MAC-PHY
> > (integrated in the same package) that connects to a CPU over an SPI bus,
> > and implements the Open Alliance TC6 protocol for control and frame
> > transfers. As such, this driver relies on oa_tc6 for the communication
> > with the device. The device has an alternative name (AD3306), so the
> > driver can be probed using one of the two compatible strings.
> > 
> > For control transactions, ADIN1140 only implements the protected mode.
> > The driver has a custom implementation for the mii_bus access methods as a
> > workaround for hardware issues:
> > 
> > 1. The OA TC6 standard defines the direct and indirect access modes for
> >    MDIO transactions. The ADIN1140 incorrectly advertises indirect mode
> >    only (supported capabilities register - 0x2, bit 9), while actually
> >    implementing just the direct mode. We cannot rely on the CAP register
> >    to choose an access method (which oa_tc6 does by default, even though
> >    it only implements the direct mode), so the driver has to use its
> >    own.
> > 2. The ADIN1140 cannot access the C22 register space of the internal
> >    PHY, while the PHY is busy receiving frames. If that happens, the
> >    CONFIG0 and CONFIG2 registers of the MAC will get corrupted and the
> >    data transfer will stop. Those two registers configure settings for
> >    the transfer protocol between the MAC and host, so the value for some
> >    of their subfields shouldn't be changed while the netdev is up.

This device is pretty broken. Has it been shipped to customers? Is
there going to be a new stepping of the silicon which is less broken?
A new device to replace this one?

	Andrew
