Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52E29898F;
	Wed, 27 May 2026 13:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888223; cv=none; b=tq1w+aAActtmiEWCttl3AKiKv6SuNoSVu1AjpjKU4V7w5zHMtjS1G5GfCkFgY48RWCNHuckB64FavmbyTKju0SclVus8lW+VdQeEZKG4rdMiyiHDPyhswDr1MsoH3n2lkJPZI8QEkKaNQTEAjWdW+BMba8JyTPw6ruVFI3dh5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888223; c=relaxed/simple;
	bh=NlN6jTcVGVQod/T6/pDzvwKHuC9exqNQVAEAnBbEa+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fab7tUCZJJoGZbzBDk2JDX8ScCPZe0+57GRN0LsTw2I8TMhUU6XvjdzalR+eV2qeomLl9swEERK2XmhQfLemJzTI9bDMWx0WjwKsz0YrpIEQ+uPC0PH83pGKStxSI8Lcv0oL9QRO62pb+YXPvpykpxzfkxRVriVdn1KldvAqlfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m2x5AERU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m2x5AERU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=H5aprNpB+u2skc8+Um2/wrrPcxGOx+/3mNx0Yo8rNJc=; b=m2x5AERUZNJwUkSZMf6ZhZKxIR
	WYgKDaRAcJAGkvJ628QXwEnr3pvGdrStV6oi1IwlN5aBSxpkVBBD1ywHsaF/a1ShmOuKetRIediF4
	uHo19xSDsg5E1l+JU4W+z60TBoBzHxzIVLsyVkawI8gIqFw3FUZsQlW+XBOdyHR+CGvY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSEEI-004ket-GT; Wed, 27 May 2026 15:23:26 +0200
Date: Wed, 27 May 2026 15:23:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj.S@microchip.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Bryan.Whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] net: lan743x: read SFP straps from PCI11x1x device
Message-ID: <af49a018-952a-439a-8beb-2e300a1d266a@lunn.ch>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
 <20260514105028.42942-3-thangaraj.s@microchip.com>
 <053eaadf-07f3-431f-a0a4-28980adb8213@lunn.ch>
 <DSWPR11MB971561B42BB157F7C8C436C2EC082@DSWPR11MB9715.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DSWPR11MB971561B42BB157F7C8C436C2EC082@DSWPR11MB9715.namprd11.prod.outlook.com>

> > > Introduce CONFIG_LAN743X_SFP to guard SFP-specific code
> > 
> > Why? Does this add a lot of code? Most MAC drivers don't have such a Kconfig
> > configuration, so i think this needs some justification.
> [Thangaraj Samynathan]  CONFIG_LAN743X_SFP was introduced based on
>   Jakub's v3 review feedback. There are devices on this LAN743x family
>   of devices (LAN7430, LAN7431, PCI11x1x) that do not support SFP at
>   all. So while the amount of code in the common LAN743x driver itself
>   may not be that much, the dependencies could force an intended
>   minimalistic build of the kernel that wanted to use the lan7430 device
>   (which is rgmii only capable device) to have to include tons of kernel
>   code (sfp, i2c, gpio) it does not need otherwise.

In practice distributions turn on nearly everything. So the code is
likely to be built. Rather than a Kconfig symbol, can you move the
code into a module, which only gets loaded for pci11x1x?

	Andrew
