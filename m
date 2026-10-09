Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EB14D6C44;
	Fri,  9 Oct 2026 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791548122; cv=none; b=A9ng/32whY9H+PzNKRqoSvAu4MiESVrmVIvE26l0YMOJbdcwJJMIv4R/JEOr+xC/WiehrArrxqcJvrnd0KEFGpk/N+atXGRFFMUYP2c3/bpbps5+b2j7kCDMUkeuVXLvpVvhXiWahGkLqE4qhQlOv0C+N/y0xJDg2z4CUyx/rNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791548122; c=relaxed/simple;
	bh=akh2/KY6vbUjpMPax7LEcPyou8t/F1Tq3ulvHtvoxRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPOaRDPymUVMN6HWBI8CS0xtXcImr3HkI+e5AkXcsIv8YX0SEpsFZDR3h0FfKMeT8gE6m/cVZn3aMICTZtJUCz/BEbOHf7DgLStZe9sbO5JnbwjH5mEHWCSUG0Sd+xLh4NrqGKQ+FW8akd5xPtXEttCjFW8R4o8ye7VDVGpcVaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mi+OrU15; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mi+OrU15"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7MhystBVEOVDZzGPDoVICEB1oSofc5klmxZ9TwVsffo=; b=mi+OrU15ZngXhA95MFG+UAr3RA
	i/pviWuDKK9hGrYug4XbQQZgB2DDaV+aoHV2ISQVc+AXah/j1g6ckvwUOe034NSrwOnKWKEOLmSGk
	6Fa7G5LZUh9uBzSjwoRSOZnTjycq0eAjZJJ8R1fy9eypRX/Qp5dU2XfNQONIIC9pIMWw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xF9V9-009mbx-B0; Fri, 09 Oct 2026 14:15:03 +0200
Date: Fri, 9 Oct 2026 14:15:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konstantin Meshkov <skyline@mail.ru>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: marvell: add LED support for 88E1116R
 PHY
Message-ID: <1bef1633-8213-476f-a019-f29a71553e09@lunn.ch>
References: <179152610952.2918676.6625057760354797023@mail.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179152610952.2918676.6625057760354797023@mail.ru>

On Fri, Oct 09, 2026 at 09:08:29AM +0300, Konstantin Meshkov wrote:
> The Marvell 88E1116R PHY (used on the D-Link DNS-325) exposes its LEDs
> through the same page 3 register 0x10 LED control layout as the 88E1318S.
> Wire up the existing 88E1318S LED handlers in the 88E1116R driver entry
> so the PHY LEDs can be described in the device tree and driven through
> the LED trigger API with hardware offload.
> 
> The LED polarity is configured through the led_polarity_set() callback
> shared with the 88E1318S family.
> 
> Signed-off-by: Konstantin Meshkov <skyline@mail.ru>
> ---
> This patch depends on:
> [PATCH net-next v2] net: phy: marvell: add support for PHY LEDs polarity modes

I've not be tracking. Is this merged already? If not, please resubmit
once it has been.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
