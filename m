Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DBB3C278A;
	Wed, 20 May 2026 23:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320393; cv=none; b=Zn45O5x/a66Y4/0FQC6D4auIK/VnDELuups0lLmhooENjifeBvFQZX7B5wwfAkBheoW9udxlmFDaw8ehSR+3GBJpRk3LMoJ02KkOf7M54WnOtCJbXPrwXBz4kUsETKPjDQIJ52XKqFasUpY7gJgnPm6zD+fbYqtsl48niJcilIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320393; c=relaxed/simple;
	bh=b+6LELwC0+cN9h2iOz94bp+1tN+CmD/GXiFic6noKGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8KJeFXrRtGgAkAF5Dy90MZr6fro0JKyEz1EP1jSZNuhfICVtlsOQ1MzSXkIcIvHmG6Tiba4n022XtwOY/btnxAZxgZp3DrjgkaapVwHK9RHfvSn72A3ybY7FhC2YzLTe/OLGCukC8RGhO0ZPIUI60Ob3gulpWYTvI92/ioXAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aKmvE332; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aKmvE332"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=X+54vEqcBgeIyr9hNnG6OaUs4Z2FB66vP6k1X5WgcXc=; b=aK
	mvE332m82KCAVrpV0ggTmdzClz441ghQY2nx/8pvn/CyApygnDlAiHroVMrbkGOtyw0U8cM+f9ANE
	m/Up8UXBVGov2NHfv3efD4zssPTjNJnS2jl/G2wYrnRrn8malOPAmCCulK16XBnteIDN7qDzoYg7n
	j4I3mBQ4O7+w7mE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPqVh-003vU3-EZ; Thu, 21 May 2026 01:39:33 +0200
Date: Thu, 21 May 2026 01:39:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Leonardo =?iso-8859-1?Q?M=F6rlein?= <leo.moerlein@proton.me>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Buday Csaba <buday.csaba@prolan.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: mdio_device: leave PHY reset deasserted on
 unregister
Message-ID: <5b7e9dad-d346-40a8-8c7b-cfe10f8388a7@lunn.ch>
References: <20260520151355.1371163-1-leo.moerlein@proton.me>
 <57b43ade-2c7b-4eaf-b9fa-406edee0fe44@lunn.ch>
 <hRNIpXMBtfUH-OrabbMVvOWAZ5J4O1XNTvx0lMYIDdSLqFL9hhZKdb3CzPo7VgUrwKi6MD3qlj2li6eHybgzFBB_Wfqu5Lc4dABXt9mpL2s=@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hRNIpXMBtfUH-OrabbMVvOWAZ5J4O1XNTvx0lMYIDdSLqFL9hhZKdb3CzPo7VgUrwKi6MD3qlj2li6eHybgzFBB_Wfqu5Lc4dABXt9mpL2s=@proton.me>

On Wed, May 20, 2026 at 10:53:04PM +0000, Leonardo Mörlein wrote:
> > I'm wondering if we are fixing the wrong thing here.
> 
> In general, I see two options to fix this. Either we fix the
> tear down or we fix the setup of the device.

Can we take a step back, and look at your actual hardware. What is the
state of the hardware when Linux boots, but before the MDIO bus is
enumerated?

Is the GPIO is configured as an input, and there is a resistor keeping
the PHY out of reset?

Is the GPIO configured as an output with the reset not asserted, by
the bootloader?

Maybe when we probe the PHY we need to ask the GPIO subsystem how the
GPIO is configured. On unregistered of the PHY we need to put the GPIO
back into that state?

> Currently, it seems that this case only occurs when the kernel
> leaves the reset asserted. The bootloader initially leaves the
> reset deasserted, at least for my current hardware.

Are you sure about this? Maybe it is simply an input by default, with
a resistor pulling the reset line the right way?

	Andrew
