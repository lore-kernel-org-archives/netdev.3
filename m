Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD672E7F25
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156591; cv=none; b=TSKZ9+EhxmMtL5ylubRvSt+i3JhlDGxmzIiONDa+Ayjqr4fTZ3/n9bJYcByFqtlvGIU4UXQsZuJ0BUNOB6tRUBVeyyWUCkiw5c3WTBxTOkn9J1pEKPRNivphoRPj5IJcsnYto0CGmazHkCFLBIUc08Ouxhn/ATcZXvVdVu0s8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156591; c=relaxed/simple;
	bh=pS5zpsOPuov7uxKZpy7pVBccqd6j6SlEJU/WTiBdiio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai5bfD0RCd4xIbNX4pn46D7EEGQAbsOfk4F+M4ptZ4MdeC9BIRSjyBiShQgw1rgGZMejfBaVI4kdBg3xYohZsDxtvLXwgwptzTKDLMx7JWu3I8ofTuhtbQrJGz4VYZorQBqaFTfk8znccGMb1pFgohx4a8NRhEAovg8DTIr1Mak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GBlkYDUT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GBlkYDUT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=33qxqNzgZGHZpStVX0X5eMtbopKkkIOyjYXbT7yHZdE=; b=GBlkYDUTB+Sc6dhtPzHDLvIdGr
	H4WNmdMAcmDLETSgivuZPyjM77g09SaEaiH3bZWQySTpdJzRZcbNru/aF5x0sNwSdOELE+OuZirEM
	KjapJwEp6l8eF9RPgxC+DYWyBAnpqm0Qxn8viz2iarxlslfzB5ewXbzePr3dkC+a+muo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKxky-001oEG-Ce; Thu, 07 May 2026 14:23:08 +0200
Date: Thu, 7 May 2026 14:23:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, mkubecek@suse.cz, idosch@nvidia.com,
	petrm@nvidia.com
Subject: Re: [PATCH ethtool-next 0/5] ethtool: Add 'pages on|off' option for
 module EEROM hex dump
Message-ID: <5114542a-7c7f-4759-b13d-6873494944c6@lunn.ch>
References: <20260507114721.3409128-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507114721.3409128-1-danieller@nvidia.com>

> In practice, both outputs are often needed together for offline debugging:

> Output example (values zeroed to omit vendor-specific identifiers):
> 
> $ ethtool -m swp61 hex on pages on
> Page: 0x0
> 
> Offset          Values
> ------          ------
> 0x0000:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0010:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0030:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0040:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0050:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0070:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> Page: 0x0

Maybe also add JSON? That would make machine parsing of this easier.

	Andrew
