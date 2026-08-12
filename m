Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438938F64E
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551763; cv=none; b=dGX1JHe0absYXuPdKiCB8D1ScJjyumvYJbII0FTF+Cm2YxqVzA3k+NtB3dSKuaHnQd8a0VwJd5UduwRbgoO+25OGB61ckkK1Ily9Pmmkh0OwBIBNudPUlyCWlrC5+upv5hdexUfG/Oqfn/bdUra68RB4m26scTfh9msxTrS/bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551763; c=relaxed/simple;
	bh=D5928xH8M7VjsEUj8zk5iyDe9sgeDJ+UdCG9xIOVXq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Drpp8gpxZCNv6aXa9OrZl4QKh5MNsaEJBtL0l6ZAZBChIvfhej4233GsAVHPuzJ1Ow1f1fGBz/N20NvV5dSyU9qz/blnW46PC2JIeKy7xpguZSn8CdNDbYRk7R8N34PvEjRUNN22lG5dix4/u+Zfo72F/rTFPe0s0vO5ex1Y0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0TMZ/jXQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0TMZ/jXQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D+hMCisx3VNzAgESo5e/Ggq2I0ERfe5oOq+lEEv6IrM=; b=0TMZ/jXQwnWeeWm3gDyTbgi8R8
	XVnJomgSI8Z9232vgiJvW29JEcXMftIMueN4Q//P54wArmxN4+Mye8+ivIaPuOXe9vKPZNhVP11YC
	PUeqglHtWdAl2hHIYt0VofAFV1TnPjQhbrU31nV6tbUXz0bqQZnvOql19oAaxvGWqB4Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wuBin-00HIlE-Ir; Wed, 12 Aug 2026 18:22:29 +0200
Date: Wed, 12 Aug 2026 18:22:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	theo.lebrun@bootlin.com, conor.dooley@microchip.com,
	charles.perry@microchip.com
Subject: Re: [PATCH net-next v4 1/2] net: macb: Poll for link state changes
 when using the internal PCS.
Message-ID: <16ca48e8-c9d5-4df5-b955-024349730ae2@lunn.ch>
References: <20260807201741.3275-2-nwhitehorn@pa.msu.edu>
 <20260812015433.1687252-1-kuba@kernel.org>
 <d130cf47-1d70-4345-b60a-795d463cb84a@pa.msu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d130cf47-1d70-4345-b60a-795d463cb84a@pa.msu.edu>

> I am a little reticent to include fixes to this pre-existing situation in
> this patch unless it is unmergeable without doing so, especially given that
> I think a full solution would be a substantially larger change, but if it is
> needed, I would be happy to work on adding it.
> -Nathan

The way WoL works has been changed in phylink recently. Many MAC
drivers got it wrong, so we tried to make it easier by putting as much
business logic as possible into phylink.

So i would suggest you do a minimal fix for your issue, but also for
net-next try to rework WoL to make full use of phylinks code. So two
independent patchsets.

	 Andrew
