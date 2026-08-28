Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF1C44AB83
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923836; cv=none; b=Vv3TjOtAI8UOznHIqcfl+KUlUeQONALqtrRD5gqMTCiIkH3gvo6gEfi712ALXL2Kz+p8YDrpHCbi+ZpKDKDJBY9V/LMWCBWUsSMICJWL83Ey4cZObnlEZoGe8yuNNeJUrDt8+R6pasRN7djgRPPIx9w4MaIS75KGRl/eAEJTdV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923836; c=relaxed/simple;
	bh=LvuNzzf+3gvrJu6HsvCYdN7vrpISWz+VZayi4LEofCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOTLIJ5tcyyZoLU4mxHhNfY/sY1YlDJqzrXZMxXqwNC9Qosr3wPdegGdx5o3Xjw0ukMcycwYf3cxYj5j+S3YL0d/lULy9Xo8lcjAiEDiQn9IsHO1HgKRWyP9Y6O6U2rvdsW1MLjtoGlEMBj6sIzVM86acAkvHV1QDQoJawtqv/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Tp4HS8PB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Tp4HS8PB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OBN4i2GxthG2WF7Rk1snABJlEX1yY3EriJFGG8SfnDg=; b=Tp4HS8PBwy0B6oI//9L2qe7K+n
	Z5CWVU4rbQF4rt2tpoIAP/pITmXodaAOxkVTWI/Fa+SsnmZeuI/LU0hY+ktyvaiB6kvhqgL47KsYg
	2f6Mwj9MuCVeY3r4SiRwDqqpD5E00cK0qh1oKExure6zasJIpnNxcNB2/XgquJcWcWEQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzwf9-001olo-DE; Fri, 28 Aug 2026 15:30:31 +0200
Date: Fri, 28 Aug 2026 15:30:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: survive a PHY whose driver arrives
 after the switch probes
Message-ID: <29f973e4-980d-4198-bbec-452f7421d416@lunn.ch>
References: <a230d199-5d4d-4637-aff3-e725a37e1da1@lunn.ch>
 <20260825082512.63501-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825082512.63501-1-f@lex.la>

> Two questions before I send the series.
> 
> My MCU driver only waits for the firmware files and registers the
> nested bus; the download stays in the PHY driver, which already does
> it. Moving it into the MDIO driver duplicates the loader for a quad-PHY
> case no board has yet. Is the MCU-side download a hard part of the
> design for you?

I think logically it belongs in the MDIO device. But we have to keep
backwards compatibility. I would refactor it out into a helper, which
both the PHY driver and the MDIO driver can use. At the same time, i
think you need to extend it to check if firmware is already running on
the MCU, and is so, don't do the download.

> On this board the minimal variant, slow-to-probe alone with the PHY
> node directly on the bus, carries everything by itself: the chip
> answers its ID from the bootloader, and the driver and firmware arrive
> together. The MDIO-device layer buys the general case (chips silent
> before firmware, quad PHY, reset ownership). Both layers in one series,
> or slow-to-probe first?

So long as you have not hit the limit of patches in a patch set, i
would keep it as a single patchset.

      Andrew
