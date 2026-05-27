Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D62332EAE;
	Wed, 27 May 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888575; cv=none; b=m04lPGR16K0h5PWjac3+LHJwYVljo3GYUah7ae/NhrEPUIMpFsZApPWbMlHON5Rp25mNitMe45FzsBE0TSEeZPuSgfCuC4gO1K3wo0tcb2ALj768sdA4kmQPWeJNDGqTJ5pzHhXFMRK+iuC7J9bUgNKEXixEOkm98yRy3vJ0J6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888575; c=relaxed/simple;
	bh=8cxSrdtf5QsGYAuRco1x3mmJyLM2//dGg+JYRXd/jWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKe91PkbTjsOA96ttiKegDaFgoufultxEg7eExnY9fmKRC26xYLKYZzYHysgOc2y/nBMlkXLupJhWw/RrJhslJ1963DbcTVLSE3gfBJkalq5cDOhVl7+jGJowT9pwp1+BSK9GWqxZBM/VCiiFUz/wFQoetVF3Qd/xyq0egVJjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bMc5+Xnj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bMc5+Xnj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VIRZVnUypkX6C/0qJxFEVh0qeAAj+EZsc1OpTr5K4v4=; b=bMc5+XnjBn2mER+bnqgtYbFpqi
	ER7i7NILhvGLC4nKXbB5btfc2ptF+kXnuAIb+Ea113qiyVb6wcLOJXj1r1RLRVCALVFcrGYQCCbXd
	wI6EDMari4uLuCm0AjXZjzTj1luWRziMIuBUsMS0A/jPT3xUpySfzNHwdWOr/Lr5tlSc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSEK5-004kgf-8v; Wed, 27 May 2026 15:29:25 +0200
Date: Wed, 27 May 2026 15:29:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj.S@microchip.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Bryan.Whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] net: lan743x: Add support to software-nodes for
 SFP
Message-ID: <10ada54c-43eb-4129-abc9-aa5b1b94bfb5@lunn.ch>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-4-thangaraj.s@microchip.com>
 <40f567f0-e6eb-434f-9d54-7f226f0f70fb@lunn.ch>
 <DSWPR11MB97150CCAF4008FFA5193F5FDEC082@DSWPR11MB9715.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DSWPR11MB97150CCAF4008FFA5193F5FDEC082@DSWPR11MB9715.namprd11.prod.outlook.com>

> > 
> > > +#define PCI11X1X_TX_FAULT_GPIO               46
> > > +#define PCI11X1X_TX_DIS_GPIO         47
> > > +#define PCI11X1X_RATE_SEL0_GPIO              48
> > > +#define PCI11X1X_LOS_GPIO            49
> > > +#define PCI11X1X_MOD_DEF0_GPIO               51
> > 
> > How do you know these values?
> > 
> > Can i buy this device, design my own board, and decide to use a different
> > mapping of GPIO pins to SFP cage pins? Or does the data sheet say you MUST
> > use this mapping?
> > 
> > Maybe consider drivers/misc/lan966x_pci.dtso.
> [Thangaraj Samynathan] ]  These values are from the Microchip EVB reference design,
> not mandated   by the datasheet. A board designer is free to wire SFP signals to
> different GPIO pins.
> 
> However, the PCI11x1x is a PCIe add-in card that can also be used in
> standard x86 systems. A .dtso overlay has no base DT to attach to on
> x86, and ACPI _DSD properties require the platform firmware vendor to
> add them - which is not realistic for a PCIe add-in card in the field.
> 
> We propose using the EVB default GPIO values as a fallback when no
> firmware description is present, and reading from DT/ACPI _DSD when
> available. Does this approach seem reasonable?

lan966x_pci.dtso can be used with a PCIe add in card. What is
important is that the PCI vendor/product ID represents the specific
board, so that the correct dtso file is loaded, which then has the
correct GPIO mappings.

The EVB documentation needs to be clear that the microchip
vendor/product should only be used when the board is 100% compatible
to the EVB, otherwise bad things will happen. Each OEM should use
their own values.

Or you need to stuff the complete configuration, including the GPIOs,
into the EEPROM/strapping pins.

      Andrew
