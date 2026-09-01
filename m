Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB5357D1D;
	Tue,  1 Sep 2026 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273089; cv=none; b=WpZfyUf6S/FI+Ykjm+u3J0ttviln7bpp3U9dUeef2k4SK30TdkH7HO/+spWGM1I0bjPJvhkUbKE81PV3R3UX0pCw6NS18XgRji4gvS6Hf4BvXHOQZjcCROZvF1r60QzedYYD6aSLSuQSI41IlCCZ0w72VsxbD1ABb4lr/qop7s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273089; c=relaxed/simple;
	bh=YyjW9um9L4Kv5A2B2DP+59GCF8C1H41HnVX0oD61lgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3/JNzzVjygJrr5u7kqO/ynvZXxKlBfLqRbRC5W4P66/qKcFobPhtCyxZIWjv5gqK1A/+rISMQhElvRW2RIoU60kFkV4W9icW3Yv4RZCMc8zL8ejCBeCT7V2xeq7xykyn43hyr397GE89iu124Xl7yLBTEqPcpUgCPH9ma/2yqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MEU3tJ7+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MEU3tJ7+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aXjp/EXi0ZgIATNPUvVJ6EllQtEXiudIzx0WzYh/Gy0=; b=MEU3tJ7+SkxV2q7efdUiHkyCBh
	Zpd75OjCTB3G2CH/Z/0njGMDG/OMSN9Mb4xnOHHXof2iXKYHGgJytaHCje0ndFc0mQ7f84lkarODL
	GVEh9h4CxBjeQ7VEon7Rgt5KVHnJjIQCYCibHfMfCPXc+OGDGO7rn++fgDvT93bMddb8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1PWA-002MyK-6p; Tue, 01 Sep 2026 16:31:18 +0200
Date: Tue, 1 Sep 2026 16:31:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Gupta, Suraj" <suraj.gupta2@amd.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/6] dt-bindings: net: xlnx,xxv-ethernet: Add
 Xilinx XXV 10G/25G Ethernet
Message-ID: <b5126d72-734b-4f4d-b953-807579c8583e@lunn.ch>
References: <20260831150816.1020883-1-suraj.gupta2@amd.com>
 <20260831150816.1020883-3-suraj.gupta2@amd.com>
 <bb36094f-07d1-49fb-be2a-ffe126e1b919@lunn.ch>
 <9717ad8d-0117-4320-9d6c-dda6b712ecee@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9717ad8d-0117-4320-9d6c-dda6b712ecee@amd.com>

On Tue, Sep 01, 2026 at 08:48:18AM +0530, Gupta, Suraj wrote:
> 
> 
> On 9/1/2026 7:57 AM, Andrew Lunn wrote:
> > > +  The Xilinx XXV Ethernet Subsystem implements a 10G/25G Ethernet MAC with an
> > > +  in-core PCS/PMA driving a high-speed serial transceiver. It supports the
> > > +  10GBASE-R and 25GBASE-R line rates, with 25G operation following the 25G
> > > +  Ethernet Consortium specification. It has no external MDIO PHY
> > 
> > What about MDIO bus?
> > 
> > 	Andrew
> 
> The 10G/25G (XXV) Ethernet Subsystem IP does not provide an MDIO master.

O.K. Please change the wording to make that clear. There are plenty to
10G PHYs available, but it seems like you do not consider that a use
case.

Has the MDIO bus master been replaced with I2C? I assume you intend
this device to be paired by an SFP cage, so an I2C bus will be
required. Is that a different IP which needs to be licensed?

> The contents of the appropriate MDIO registers are available in the IP control &
> status registers.

What does that mean?

     Andrew
