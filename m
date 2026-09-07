Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A913A254C;
	Mon,  7 Sep 2026 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788807426; cv=none; b=Nrb1Bgpk2Q2tJBtTEYpFhK9AF/c8PNIez1ugequInUD9OjwnqgSK+8951KXb8b07Pkq1G0s98Ke1RoF8W7S7zmP7okXd0AiQltS0T4KAKVcmR4Vt+A1C6nNG1+F9rhO1xLPb5kK9TrgcYBjFteiRrg+dj6c/kpyA3FOCcJxYcgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788807426; c=relaxed/simple;
	bh=yUbDhVJszfsuJ8wED5O42ImI8IY8bIMOaw/b+/NOwxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4QkR8mhKB0vgBxSiFLvhXSSYBs02q0qY4LtwqRPALtH6kO/yqD8tjJtWjWNp1LLtyFOsYn0SWI9hOiyR0VhaeLW6NE5vUaPLPpWbo2mP+OJed00+c6EY4BFehkspxAMWKmEE1cdI8Zz6yIo9ZbdkPUZdSlUP5xWnky2HllSbTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pWGOO6qe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pWGOO6qe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Iero7y6MF946V8B6Q2ByJCfiNWDFBRPzga56lAEBewI=; b=pWGOO6qerkyvSlOhntGXoGROoh
	7ZVY7F8v8U8FUwEs2D+Kg65+bfpVMZDZu1Pud8A9tfNb4mhh1Ckq5udPG3B9ZuBpNHMp0TDa6PRbV
	soD00xMc+dUKiKC4KVSh8A5gPBah5YpEmfBNU7TS48tVEijqFw5mguEv8u5oAaTILCyM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3eWW-003bR3-Kj; Mon, 07 Sep 2026 20:56:56 +0200
Date: Mon, 7 Sep 2026 20:56:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Message-ID: <85b4b052-e97c-40b8-b434-de1b6e3af1b5@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
 <20260907-petite-pillbug-from-atlantis-dd3ea4@quoll>
 <9751fadc03ab555327f5baf1d2adc10821f13b1e.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9751fadc03ab555327f5baf1d2adc10821f13b1e.camel@linutronix.de>

> > ethernet-ports
> > 
> > > +    patternProperties:
> > > +      '^(ethernet-)?port@[0-9a-f]+$':
> > 
> > ethernet-port
> > 
> 
> Is there a reason for such a restriction?
> The pattern intentionally follows the generic DSA binding in dsa.yaml,

You need to be careful with the DSA binding. It is old, and uses some
things which are not considered best practices today. But they cannot
be removed because of backwards compatibility.

	Andrew
