Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC93438B8
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779213594; cv=none; b=Ur1INThXC3r40dH3PClpM/HsefG5jboLVNBMxjHkXY3dcYZnmDknPAdsp3c+4WpyQozCmMztAhQ4IozDRfoAxk+8d9zIEWKOQ3naNrVYxa9kTVOhCOEd4sZFGMjhYj9RNaTXeKkgeqNOVW5IcEtZS92/r81mo1pXieZ0nPwfBbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779213594; c=relaxed/simple;
	bh=G+ikI/M8C/DsyAdfE+9b1G6a5vJMt9NQIRt9DXDOQ94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paET1uXOnQk/eE1Vp/uLhGMEWBrhx/wUUTDWYmMNpVOSXMwbMR3nosYQRw7JaxslxpaNbPbinycNJYIHJ7OWwFGC6fxvUOLJkFpVlxwlvJdMqyDdD3dweuwbd6e8khcdV3SSqC5gTEgg2Gb9g3XKx4RYCRAbrsBNZoxpKq+3hvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sO2+KuYs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sO2+KuYs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6hofCwfWkrYTrxr1rDDsU6ulx04KaKIfFQOGi0fXbWc=; b=sO2+KuYs9GbUiw7T3JrukWUib/
	ATZc8J3B2cxmqCCKf7auW8jSn0rorFiJWOAHY1RF+HoUYhpiDRwUJvQlJf1tDCd6buc3OhScXNvOT
	t9bPnadsv1GfzlSn+guFttjL/BOj4nM4ja7ctmhDvcVUcJkxOqE5TMer5iDKxka0tkO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPOjB-003i6j-IG; Tue, 19 May 2026 19:59:37 +0200
Date: Tue, 19 May 2026 19:59:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
 structure
Message-ID: <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-4-markus.stockhausen@gmx.de>
 <agydm8V25M-jy5o6@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agydm8V25M-jy5o6@makrotopia.org>

On Tue, May 19, 2026 at 06:27:55PM +0100, Daniel Golle wrote:
> On Tue, May 19, 2026 at 06:57:41PM +0200, Markus Stockhausen wrote:
> > Each Realtek SOC series has different number of MDIO ports.
> 
> I don't think the term "MDIO ports" describes it well.
> 
> I'd say "switch ports", also because RTL9300_NUM_PORTS includes ports
> used for SFP+ cages which aren't going to be (directly) associated
> with any MDIO-connected PHY at all.

Hi Markus

It would be good to take a step back and explain the concepts here in
the commit message. An MDIO bus as 32 addresses, as defined by
802.3. Why do we need the concept of a port when we have addresses?

Once you explain the concept, we can maybe suggest a better name. Or
throw the whole concept out because it is not needed.

       Andrew
