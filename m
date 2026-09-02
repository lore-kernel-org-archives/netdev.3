Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0751D5CC9;
	Wed,  2 Sep 2026 00:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308317; cv=none; b=GHy+DsboQG9I7jhjbb1fs4PpaPOVgXmrFJSy7DPNLkgXaNY7NuRZsneatma6VAwcUHiChspzpMfyhtENt0eOVe0UTJG1FLf+uFsjErazQusmFOvhuppUu7iTXgZ7B0JEgKniQHMA1AHrf9kV6hvm7MtdtWQf1lvbgOAvBksmknE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308317; c=relaxed/simple;
	bh=n9Ge/gXaL5mfXcuLJY9hHd0aURCwcAySdBOd/oArW9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2AXSbOaykkIJWE1nSeNX4am41KxKrYBipbri2vaG5aPDs6NnWJOPPMKSv/2pw6FJdaeZcIeqaolocRzMYh8haqr/NxRpQXIudVt+qRLDfN2xJA1qbr8cYsBzCW/csF6odURm1LKYoIeamAEKf6Wqy6OiA8u9nPZQ+ZBGBimYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IACB39V6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IACB39V6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NBdGhoHYd+jo7mRDIo0xCaNSRycIx2YS4OtMbfvPStA=; b=IACB39V6fpqXWekH6vYml6Hhj/
	Pd1I7n0MM7eP9RbV/VxGYgvGOkgD+HM3lQ+Ldra0we6+9o7Fj0opY9pF/OO5sPMIe9atEh6wHKJGr
	buYlja6pb8LQG3Q4UW415VRRy9a+ILOVU/oT7SC/rO/jMZwPi6OBWxyCOO0t04h/cxZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1YgK-002Reb-DD; Wed, 02 Sep 2026 02:18:24 +0200
Date: Wed, 2 Sep 2026 02:18:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 12/13] net: mdio: realtek-rtl9300: Add
 support for RTL839x
Message-ID: <be7ca09a-25ca-4ef9-b753-715db4223be7@lunn.ch>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
 <20260831143439.2404484-13-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143439.2404484-13-markus.stockhausen@gmx.de>

On Mon, Aug 31, 2026 at 04:34:38PM +0200, Markus Stockhausen wrote:
61;8001;1c> The MDIO driver has been prepared for multiple device support. Add all
> required bits for the RTL839x (aka cypress) series. This is straightforward
> but some things are worth mentioning.
> 
> - The device has a lot in common with the RTL931x series. It has 8192
>   (Realtek) pages and 7 MMIO registers.
> - There are two SMI buses for 1G PHYs. Neither the bus nor address map
>   registers exist.
> - The hardware has not much to configure. So the setup_controller()
>   function is not needed.
> - The bit specific registers (polling & port_mask) are 2x32 bit wide. The
>   ports 0..31 got to <reg> and the ports 32..51 go to <reg+4>.
> - C22 read/write functions must be called with PARK_PAGE = 0. Keep code
>   clean and avoid setting it to zero, matching the behavior of the RTL9310
>   logic.
> - As per SDK the broadcast register allows to write to multiple ports
>   at the same time. Unlike RTL9310 where this is filled with a bit mask
>   for the current port RTL8390 does not use it for normal reads/writes.
>   It is simply set to 0 like the SDK does.
> - The SDK fills the EXT_PAGE register with 0x1ff for C22 access and with
>   0x0 for C45 access. The reason for this is currently unknown and a
>   meaningful name can not be given. Align the driver coding with the
>   RTL9300_PHY_CTRL_PARK_PAGE settings and simply fill the hardcoded value.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
