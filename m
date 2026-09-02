Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63673002C8;
	Wed,  2 Sep 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788309828; cv=none; b=H5tf6j2kp1NEcQ3EH/q0P0vFfWNT0fnTk10aGC2EjzhxuVXCTvdvZss1EzzvW38FDeSLdPXTdUy1WzhpHtFKx9MRVZSxe8qCV0Ghwa5ZST8mPmo1QQN3yqNyMIlcfHdugLj+pLgVgwx38eDd8xpEhdGQI/bCdRBs7cW5Ioa4aS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788309828; c=relaxed/simple;
	bh=jSkSbebLUaFOavlNVjNmP9IG7T4Ps0LGjzfjY/DcH44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcigDNC6FQugDvOi2AEwTCz38E1BtnNs3SE7B3OMaS16usLv9xmdFowMm71IyUV3eqZZOQBb+7O5PzPKp2CBwnOFDzz4MJ/500bDjo+dCzej/AiShFXsH8PkxrVVAjUG03ZyfhbCabPaP3lv43I23PMBAXhY8rLNDWml3AcGoDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=yJkL4QJI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yJkL4QJI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bsd4GQ+oxiEeulWAFYOzdSc/k93ZvAGEODURJZoqQ5o=; b=yJkL4QJI/mB5rfrQ/JTpf7DHiM
	QmFlRjr/KqIjSM19UyeKdTiBVnuMCODB6/XSzoYHf/IDWmowX3ZOsO1YJFlszkiSyyLRkyFQ/y16I
	e9oSqpj19qREgu3SWbqWdhWqJ+uuH+pUuef6OGrg3L4Drn2oSugaHiwYHnOlvA42KxWw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Z4i-002RwU-1c; Wed, 02 Sep 2026 02:43:36 +0200
Date: Wed, 2 Sep 2026 02:43:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ethernet: oa_tc6: deliver the PHY
 interrupt to phylib
Message-ID: <dbb77cce-b574-42d9-8a26-a12a0446d1b9@lunn.ch>
References: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
 <20260901130948.212914-3-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901130948.212914-3-parthiban.veerasooran@microchip.com>

On Tue, Sep 01, 2026 at 06:39:47PM +0530, Parthiban Veerasooran wrote:
> The integrated PHY has no dedicated interrupt line; its interrupt is
> delivered in-band as the PHYINT bit in STATUS0, which raises the MAC-PHY
> SPI interrupt via the extended status. phy_mac_interrupt() only triggers
> a link-status re-read and cannot make the PHY driver read and acknowledge
> its interrupt source registers, so expose the PHY interrupt to phylib as a
> nested virtual IRQ instead.
> 
> Use dummy_irq_chip as the irqchip, map a virtual IRQ and assign it to
> phydev->irq before phy_connect_direct() so phylib enters interrupt mode
> and uses the PHY driver's config_intr/handle_interrupt. Unmask PHYINT in
> INT_MASK0, and when it is seen in the extended status, dispatch
> handle_nested_irq() synchronously from the sleepable threaded IRQ. PHYINT
> is level triggered, so acking the PHY source there clears it before the
> next data chunk, avoiding a storm.


   9.2.8.7 PHYINT

   Physical Layer Interrupt. When set, this bit indicates a service
   request from the underlying physical layer block.  Many physical
   layer implementations support an interrupt output for signaling
   events to the station controller. This bit is optional and will be
   implemented only if the underlying physical layer supports
   generating interrupts to a higher level. When implemented, this bit
   shall be cleared by acknowledging the underlying physical layer
   interrupt source(s). When not implemented, this bit shall be
   reserved with a read- only value of zero.

At the moment, phylib is polling the PHY. That is guaranteed to work.

The standard indicates this interrupt is optional. It might not be
implemented. phylib assumes that if there is an interrupt, the
interrupt works, and it does not poll. So any hardware which does not
implement this interrupt is now broken.

Please find a way not to break other devices.


    Andrew

---
pw-bot: cr
       
