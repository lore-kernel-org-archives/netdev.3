Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134737E2F9;
	Wed,  7 Oct 2026 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397812; cv=none; b=YOZBPBNra70eClFChYXsSwohN2XEMC9XnOJ2jFutCvHzVuMmfxr8oaHDMS681sPGaUyDNydqr5FijxIiljCfMNHgDgNmjIEbW6PJ770Oo++QVIIWWtnXNrPFIELVmdoZLcogJYMzPTpDjs+Ns2UhPBb1srQb28tH9akzDvXfC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397812; c=relaxed/simple;
	bh=xWC25x4xH0iLUvtj4YPbwHZyVM6sp7MPWnevj1rn5F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AK/OwyEtKnkiWVgsSnznOYvU3i5wzmhp9knFvlI6p+jYDMGY7e+sl85uHVPN6VQKCJZs+171PZBUQqJmPDATHvB8m64cmmbdixQT0WbpcH0q61Ddo3gxhYOS+07Wrste5PpvSZTJqKPObitnc+mRWW5Ljh8O6KccM40XsOv/6EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=v76pyrGv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="v76pyrGv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sBNBpZixlBU4GxqSEXrG8hNTzC/ZM2X1DZIQCPTIlb8=; b=v76pyrGvWVEF5gRes0UyRmEggY
	u7Hg+t1v7zJwaV+Ep9Yr+llRzFOO/75GqRA62jOPv4GEm0tg6Tzv+sAd2/2iWPKBRZQfZ2gU24VzB
	blkpUNxJkD8LB0ZGfqLwytQAg30xBNuOL2oD/Md050NNU99ZxnUQOUBvxU5+XLrSD74U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xEWOn-009V7T-UJ; Wed, 07 Oct 2026 20:29:53 +0200
Date: Wed, 7 Oct 2026 20:29:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Jerry Ray <jerry.ray@microchip.com>
Subject: Re: [PATCH net-next v8 10/11] onsemi: s2500: Add driver support for
 S2500 MAC-PHY
Message-ID: <bc2ffbe6-f258-4b9a-9377-c9d47b45c947@lunn.ch>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
 <20260928-s2500-mac-phy-support-v8-10-7e011aacc309@onsemi.com>
 <1203b096-456b-45b0-9c2c-bbea2b0098b6@lunn.ch>
 <CH0PR02MB786708E230F4E1AF3B0882E383942@CH0PR02MB7867.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH0PR02MB786708E230F4E1AF3B0882E383942@CH0PR02MB7867.namprd02.prod.outlook.com>

On Wed, Oct 07, 2026 at 06:27:05PM +0000, Selvamani Rajagopal wrote:
> 
> > -----Original Message-----
> > From: Andrew Lunn <andrew@lunn.ch>
> > Sent: Tuesday, October 6, 2026 6:54 AM
> > Subject: Re: [PATCH net-next v8 10/11] onsemi: s2500: Add driver support for S2500 MAC-PHY
> > 
> > 
> > 
> > > + /* RX bytes is a 64-bit value that is stored in two regs */
> > > + *(data++) += ((u64)*rptr) | (((u64)*(rptr + 1)) << 32);
> > 
> > Is it guaranteed by the hardware these two words are read atomically?
> 
> 
> Yes. When OCTETSRXL (lower 32 bits) register is read, OCTETSRXLH (higher bits) are sampled and stored in the register.

Great. Maybe add a comment saying this.

	Andrew
