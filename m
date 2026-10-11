Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAFC283FE5;
	Sun, 11 Oct 2026 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791725433; cv=none; b=Iy6PbCYiIRQH6IwW4OhytJTYvMwmLe9LsNcT3zLoV8yYSSN0U39pTsiRPHx++9c54PYgGLVLD8UOE5sBxhRG+XxAfRXmUv7+QLo85TLPHMTSmRpcc1QtmdBzUvse5H2VDPEquv9AMZkerMW1C/KVRiT5PQpVF8hPju1/9fAVWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791725433; c=relaxed/simple;
	bh=cb90eOADoGhbAVgel/6yM3BDhXRgOkhxGZRhcq45nII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rI7P5l7vlekcllZo8u5OnY5LHsK8G8oJeyUhUBdJ+5bK2/pkSuE9WZuT0YGM31tHshsbPB5r3m/0c+ucV5rhpUjkC8MuG4wuXYMtYdt2MYJxvSpgzXIfRKu8hZwv6CCd7MdckVzQQuMbHvH3Ddm2dzEDP4pWjZOp7VKdBL2YwW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=e06+jbvA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="e06+jbvA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GVOTkKxiXvQcSqwXe8f/f0/6P566vHomflhTXgn/0jk=; b=e06+jbvAgyhvbQ9JguNkZLvu4W
	PX4Frt29kyZ4RknCNnoQ2+poJuKPFczF3tnWNG8uUaLiPSyBGSiv9H/o3NG1MIdbLd9eDNUvnZ1iI
	ZKMUyRhN6puU9YGl5ZjBrx8/+G6NnT4Z4TsOmQeisCc7CgwCwJ0ItkBePnLlwiYAtJ+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xFtdA-00A6J9-PL; Sun, 11 Oct 2026 15:30:24 +0200
Date: Sun, 11 Oct 2026 15:30:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konstantin Meshkov <skyline@mail.ru>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: marvell: add LED support for
 88E1116R PHY
Message-ID: <a5c13131-011a-425a-a136-e32fd4f23ff9@lunn.ch>
References: <179165733751.2921261.13784246298385245617@mail.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179165733751.2921261.13784246298385245617@mail.ru>

On Sat, Oct 10, 2026 at 09:35:37PM +0300, Konstantin Meshkov wrote:
> The Marvell 88E1116R PHY (used on the D-Link DNS-325) exposes its LEDs
> through the same page 3 register 0x10 LED control layout as the 88E1318S.
> Wire up the existing 88E1318S LED handlers in the 88E1116R driver entry
> so the PHY LEDs can be described in the device tree and driven through
> the LED trigger API with hardware offload.
> 
> Tested on a D-Link DNS-325 (88E1116R): both PHY LEDs are registered and
> hardware-offloaded.
> 
> Signed-off-by: Konstantin Meshkov <skyline@mail.ru>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
