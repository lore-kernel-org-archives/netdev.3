Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40847F3D7;
	Mon, 14 Sep 2026 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789404444; cv=none; b=PrqAvhEVWzQjBhzcuzG+FfQC4GaKz3U6bx+Kunw1svp6p8jmo3KmInCF88q3emodenYZ2qKxF9xHF9p6wbJOhb5q8yK+si4olbkO0GTbCYydbBcL+sXUkEjmN1tWBl84nVp4g/Lj601Oj5jmZW/dJG+qal4+qvpFBI2Ep8FVEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789404444; c=relaxed/simple;
	bh=HNtcd+ewiXvHrJ9yBZI4T6p8YJwLsvj2rvRAawMR5yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSeSl9rhDrhvz6S9mJGkhBxCCliVrATvYZahbXhhByR0kX4CcOFU9NzrQNrjqvLmF/9mFrzjZM4X4nhJVY6nMmLswaytdClLNZBjYQzPrp2pXY2t5sd1Tt0Lo35FN0ZuirrcH8TFDoaKN2Iiiuhz9s6bnS4BXdhT2vuddYa5b2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RuJJcVyI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RuJJcVyI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+xj57OvvQeQlUrS4UVi7WN1UdWQAEAOQPl3JtQkTp7c=; b=RuJJcVyIXrOmEY76DBdxeMGlN8
	XEG62SHjEyVgcgTUgY5Y6R9zBjtntlHf/YFvKyJA5OqVxAXnMQ8rQWPMf3mSPqNvJgn+cLDIWWOuV
	Y7HuCTE6k1Tok5yPrQIKEHkVeZ8vIGkDmKdUM7hwypvcZq9apMZaL9qyTRq//t6dTUe4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x69po-0057Bg-7k; Mon, 14 Sep 2026 18:47:12 +0200
Date: Mon, 14 Sep 2026 18:47:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/5] net: mdio: realtek-rtl9300: support
 non-default clock frequencies
Message-ID: <14d8680e-a64d-4ce3-aafd-314b32f579fc@lunn.ch>
References: <20260912130451.3757276-1-markus.stockhausen@gmx.de>
 <20260912130451.3757276-6-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912130451.3757276-6-markus.stockhausen@gmx.de>

On Sat, Sep 12, 2026 at 03:04:51PM +0200, Markus Stockhausen wrote:
> The Ethernet MDIO controllers in Realtek Otto switches use an MDC clock
> frequency of 2.5 MHz by default. Hardware configuration fields allow the
> following frequencies to be selected:
> 
> - RTL838x: 2.5 MHz or 10 MHz
> - RTL839x, RTL930x and RTL931x: 1.25 MHz, 2.5 MHz or 5 MHz
> 
> Add support for configuring the MDC frequency through the
> clock-frequency property of each MDIO bus node. Lower frequencies can
> simplify protocol analysis with a logic analyzer, while higher
> frequencies reduce MDIO transaction times during normal operation.
> 
> Program the frequency selector during every probe. If clock-frequency is
> absent, select the defined default of 2.5 MHz. This matches the
> configuration observed with a protocol analyzer under the stock firmware
> or after issuing "rtk network on" in the bootloader.
> 
> RTL839x is an exception because both MDIO buses share a single frequency
> field. Use an explicitly specified frequency as the shared frequency and
> let buses without the property inherit it. Use the 2.5 MHz default if
> neither bus specifies a frequency. Reject conflicting explicit
> frequencies because the hardware cannot configure them independently.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
