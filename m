Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAA13845BC;
	Thu, 16 Jul 2026 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219575; cv=none; b=NVFLsmOzZ69WmEN2PvgNZuQ86FKV64mke4nO9YCTqOIO0rCYvhREixI6Li8EnEnI4RgXXtg7mMeQTY/MdWSz3hxSdgqvfQsNvvg77DWZ7oQP116q1Q3YaKcKUzFWoobH9Y4MEVOUiolvPjVZoleIKd7s/Vsruk0LAsDW6iPyRs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219575; c=relaxed/simple;
	bh=Am40HYJWAYFdKkw1yF/Mr081F+9ge9ExRiLPvLGcjQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=se7pjPPr+2TaBk3oj9so6fnGjetCQh3BTHCc8rNEIvEieR7AWLUJMoCPWPkXH943wqOldm//9hAmC3rv/FWbmFoYuX4DdKmZzJZTNpDGTMmtA0LwwVo75OdW5mGi4XKDKbOAFWaY5/W0yCG7WpFB648pNJXSdMJNU3jkcVsopiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fL71lfd4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fL71lfd4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8GsUQvm16w0HapdfB/m7/mIOd3ABKa+l+BhBo1/2bBU=; b=fL71lfd45hcard7hN66wAj/Nmv
	H4hdHAH82O1KHIqmlmyyWrUW8y+1HkbP1PaSUIb/hssjcl24C7J2URAp0ysQzG6o1df/Vg7EXtmF5
	+bvh0C5raK+K5d+DgTVnnO7G64nxwMmL3pnjB7gIHeNE5CGiGPIjRcrS6QyWjSEQ9Lhg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkP0j-00CaFp-Dz; Thu, 16 Jul 2026 18:32:33 +0200
Date: Thu, 16 Jul 2026 18:32:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Liu Changjie <liucj1228@outlook.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: phy: Add Maxio MAE0621A support
Message-ID: <c29b6b04-6cf3-4f7f-8be1-160346ef746b@lunn.ch>
References: <MN0PR19MB6091CD5A84D2DA5DACF434DAACF92@MN0PR19MB6091.namprd19.prod.outlook.com>
 <c03931fb-019d-42d7-99aa-f2d97fb97660@lunn.ch>
 <MN0PR19MB609111152E1C759EC7F13DC6ACC72@MN0PR19MB6091.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR19MB609111152E1C759EC7F13DC6ACC72@MN0PR19MB6091.namprd19.prod.outlook.com>

On Fri, Jul 17, 2026 at 12:14:17AM +0800, Liu Changjie wrote:
> Hi Andrew,
> 
> > What happens when 100Mbps or 10Mbps is negotiated? Has that been
> > tested?
> 
> Thanks for asking. I had only exercised 1 Gbit/s before sending this
> series.
> 
> I have now repeated the test with autonegotiation enabled on both ends,
> restricting the link partner advertisement to one full-duplex mode at a
> time.

Thanks for the extensive testing. There is no need to give the details
in the commit message, just make the current comment indicate that all
link modes have been tested.

     Andrew
