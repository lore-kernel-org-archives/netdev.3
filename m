Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA684B0484;
	Thu,  3 Sep 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443716; cv=none; b=C1DcXKXiMezdb8R1gdzEhmxOGLyPKrvs5VwPEqWks84zrNJ6AY8hAqHzq6qaU0HKY0BzWSD2TOU9LAiHKBnXXI9BWJnyyMRg3TeDRhXCriZ939k6V1jOcvxmUs4KQ7wPbQdddI898zkLvgDTcK9scp4JGZmP4CPYpaDSyk5TYnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443716; c=relaxed/simple;
	bh=N3i3seY2GMXtNf2ZOYxwxY0s0SsTSpvuFoYOdBYcYAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMiBO0z0JB5fYBv4m2v2rLE6TVwkmWF3brAg4JmmcmqEiL9Mgf57h8XSA5QGnpj2Viodt5VhxnYpmf0v40VTjndwJZFPQ/bfLAQMxyI6Rb+PK2l1fYNCAUlHrxCRoib01+bZmD52QvgWmL6tkdEXLLPOk1BDVMQEGnQrMpsUBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GoWyJgjE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GoWyJgjE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=T0+z8MZQqEl7S1DDfmkPFQ4iRR8dJTk53FtzHDBKGno=; b=GoWyJgjEWYlotQLFi/Z2OB04zz
	wq0/SDO4WicKuKYqfpBj4QyTCMqyG2urfEZofPmPLy7n62BqgT7ZCqgD7lRXzw4S7s/MLkQ9rRTRS
	ZHnsdiG/3ELHjb1mzL4MttK1Fmp6WGPw8a58GV6PT8HydSVXoxjE35P25K4kPV1GW/dg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x27tu-002jiE-Q6; Thu, 03 Sep 2026 15:54:46 +0200
Date: Thu, 3 Sep 2026 15:54:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ethernet: oa_tc6: deliver the PHY
 interrupt to phylib
Message-ID: <b7386bf3-dfd0-4ddf-8a14-76c29cb8ac9b@lunn.ch>
References: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
 <20260901130948.212914-3-parthiban.veerasooran@microchip.com>
 <dbb77cce-b574-42d9-8a26-a12a0446d1b9@lunn.ch>
 <28cf906d-cd94-4497-9641-6220d57da3dd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28cf906d-cd94-4497-9641-6220d57da3dd@microchip.com>

On Thu, Sep 03, 2026 at 06:32:26PM +0530, Parthiban Veerasooran wrote:
> Hi Andrew,
> 
> Thank you for reviewing this patch series.
> 
> On 02/09/26 6:13 am, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Tue, Sep 01, 2026 at 06:39:47PM +0530, Parthiban Veerasooran wrote:
> > > The integrated PHY has no dedicated interrupt line; its interrupt is
> > > delivered in-band as the PHYINT bit in STATUS0, which raises the MAC-PHY
> > > SPI interrupt via the extended status. phy_mac_interrupt() only triggers
> > > a link-status re-read and cannot make the PHY driver read and acknowledge
> > > its interrupt source registers, so expose the PHY interrupt to phylib as a
> > > nested virtual IRQ instead.
> > > 
> > > Use dummy_irq_chip as the irqchip, map a virtual IRQ and assign it to
> > > phydev->irq before phy_connect_direct() so phylib enters interrupt mode
> > > and uses the PHY driver's config_intr/handle_interrupt. Unmask PHYINT in
> > > INT_MASK0, and when it is seen in the extended status, dispatch
> > > handle_nested_irq() synchronously from the sleepable threaded IRQ. PHYINT
> > > is level triggered, so acking the PHY source there clears it before the
> > > next data chunk, avoiding a storm.
> > 
> > 
> >     9.2.8.7 PHYINT
> > 
> >     Physical Layer Interrupt. When set, this bit indicates a service
> >     request from the underlying physical layer block.  Many physical
> >     layer implementations support an interrupt output for signaling
> >     events to the station controller. This bit is optional and will be
> >     implemented only if the underlying physical layer supports
> >     generating interrupts to a higher level. When implemented, this bit
> >     shall be cleared by acknowledging the underlying physical layer
> >     interrupt source(s). When not implemented, this bit shall be
> >     reserved with a read- only value of zero.
> > 
> > At the moment, phylib is polling the PHY. That is guaranteed to work.
> > 
> > The standard indicates this interrupt is optional. It might not be
> > implemented. phylib assumes that if there is an interrupt, the
> > interrupt works, and it does not poll. So any hardware which does not
> > implement this interrupt is now broken.
> > 
> > Please find a way not to break other devices.
> Thank you for pointing it out. PHYINT is optional per the OA TC6 standard
> (section 9.2.8.7), and unconditionally setting up the virtual IRQ breaks
> devices that do not implement it.
> 
> I checked both the OA TC6 standard (V1.1) and the LAN8650/1 datasheet, and
> there is no capability register bit to detect PHYINT support at runtime.

I also did a quick check of the standard and could not find an
indication if interrupts were support. So a quirks flag does seem to
be the correct solution.

   Andrew
