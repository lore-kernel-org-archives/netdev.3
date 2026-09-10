Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A2D4657D8;
	Thu, 10 Sep 2026 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042378; cv=none; b=tGezk8DBm6AJXivZ/cQ6csGnHhhlmAdhq2QF7qoVCq4jzkSLt8JG+HCpEZ2k1ZNMiryE0dHPOZZV63bJFh0oRezc+1f3lVu0RolIYVmzA2IstTBNmCsztTKxqSV+VUtbDhw7wioBGUR4FVUtyB/naF+CmOxbFzowPAwWAKSwkj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042378; c=relaxed/simple;
	bh=Px66x/NSI1qxbIE4tMH3Y9GcHCMn5G7N54fP+mRx+Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjE5YpSD+nOH+cO6LhGrmWINGo5AnylfOKxZI1Efb7WVuUsvutRYRNIzBDlnffQ3ZrCJfPyRycdsDeFVrlluAPjIn8o8D9133IHNeRhgYWthFtXU+8BZRPme9tcnfIpGkTosPIDxFVGOd4mP7orfuYe2fOAVDwPe8A2uPu54n/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HJUgdK3N; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HJUgdK3N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tGyisL244PhSPlcSKvXQ5DNtTUfMaXu/9jASRdndF48=; b=HJUgdK3Nbnq3POGblLGt01dchg
	2WK2S1IQ+fS+UUEmAXnF/6MuoassAZwvv/gTnVQLz8jLi9mcsJuVg5jxmrXxuTmBFJxeBQiy751m2
	6jOd3D1kZOlIE/FM0ro3AIwHzWxEDBmt7Uh1JysnBl6Ce7QxJCTQRvyNJqS3gW1V9aBk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4de4-004Ukx-J0; Thu, 10 Sep 2026 14:12:48 +0200
Date: Thu, 10 Sep 2026 14:12:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v2 2/4] dt-bindings: net: dsa: Add SoC-e SWIP
 switch
Message-ID: <ee045b16-978e-4208-b447-bb422a45dbf5@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
 <28f8ec21-162a-4c2c-8e01-6586f39f06f8@lunn.ch>
 <041e2884bc1aa1725a86efd413e2e3301b54d91d.camel@linutronix.de>
 <df6dc527-8b4a-4775-828a-2633369277cd@lunn.ch>
 <20612d5a45783ed49927fb1075c7ea1f3293f514.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20612d5a45783ed49927fb1075c7ea1f3293f514.camel@linutronix.de>

> > Since this is an FPGA, i assume there are no internal PHYs. Mixed mode
> > is not something FPGAs do. There are sometime "interesting"
> > relationships between port number and address on the MDIO bus. But
> > without internal PHYs you don't need to worry about this.
> > 
> 
> Correct, the FPGA IP has no internal PHYs. Each port is associated with
> a dedicated external MDIO bus.

How is a port and the MDIO bus associated?

Linux, in general, does not care. You have a collection of MDIO
busses, and on those busses you have a collection of PHYs. The MACs
use a phandle, or some other means to point to the PHY it should use.

Given this is a 31 port switch, why would you dedicate 62 pins to
MDIO, two per port, when you can put 32 PHYs on one MDIO bus?

So i doubt there is a strong association between port and MDIO bus.

What i could image is the one real MDIO bus controller is in global
scope within the RTL design. And then the logic to provide a port with
its multiplexor on that shared bus is in the per port RTL design
scope. I've not done much FPGA design, but i assume if you don't
connect the per port MDIO lines to anything, while place and route is
performed, they get optimised out?

> > So in theory, a 0 port switch is possible!
> 
> In theory, yes, but I prefer to treat it as invalid until it can be
> tested.

Yes, i would treat 0, 1 and probably 2 as invalid. 2 ports would
technically work in the DSA setup, but is pretty much pointless. It
only gets interesting with 3 ports or more.

     Andrew
