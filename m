Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB53B71B6;
	Wed, 30 Sep 2026 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790792982; cv=none; b=aUqip2bibAX5F2C/zFF0uaytUklCZQjhnweAUcE1q1NLI7C24n4Cakj/+Us/F6QpFBOJWMNyPAnGPkc6TbscR29lRiA3pTLNPUHELz32NyqMB0dxzx3Hb0MzcSJiNenDrYmzgFBgHRm4XhH1/2EcQuSeM0jkCNYmYItbU80x+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790792982; c=relaxed/simple;
	bh=FJXJ9rOr3A9tDJQx0GKaMf/WaVBqlSllsNqKqtSTM2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JI+XheuOZrRp9MblFNBrNjO1CzwMmJEDF5U+qyKvXhFl5xTVllsVF6xO9icuo+tiXCo0UlIcaB2SUp9TGwqUfoTokrWB8CO+NRQplI3Vl+JfQEC5aU9vm7tjYIjlSN4XEhSAEU2ED0KHaDb4/vW702jiyUQvo80vlQS3dzAWtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0A9l+4gY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0A9l+4gY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rsWxAathB9xkA0kZ65lMZmzTqqeHIuqdCcbs6Fglkyg=; b=0A9l+4gYwgNwB6KZ40OHFgNNBJ
	kUjloQCqQrZ4EVwz74JvMvWQhFLp0o0PFnni1TfoZNqnwrEEH1qL9VxCsM2ypstobwvvyBuNAZl2E
	iDKKw2kNqKuKGw+Plhv3w7g1bkC9qzVuWlnMr3bncyEElWJ/CzdA2aKOnN512mndQ5m0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xBz3a-008DMs-Dh; Wed, 30 Sep 2026 20:29:30 +0200
Date: Wed, 30 Sep 2026 20:29:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 6/8] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Message-ID: <32624256-8462-490d-aa37-36ee2453362b@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
 <716486ec-6253-41dd-83ac-b816c845fafe@lunn.ch>
 <4fe59faffa0bb322e68c9c4d43f0bc240a519eba.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe59faffa0bb322e68c9c4d43f0bc240a519eba.camel@linutronix.de>

> > Once all the setup is finished, what is the state of the switch?
> > 
> > What we want is that the user ports are isolated from each other, and
> > can only exchange frames with the CPU. That makes the hardware
> > basically a port expander, and you do bridging in software. Later
> > patches can then add offload of bridging, and whatever else the
> > hardware can do, which Linux can also do in software.
> 
> That is exactly the state I want to achieve after the setup.

Great. Just looking at the code, this is not obvious. Most switches
tend to default to all ports can talk to all ports, and you need to
tell it which port is the CPU port, and block everything else. So i
look for such code, and did not see anything here.

     Andrew
