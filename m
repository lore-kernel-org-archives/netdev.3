Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68138734E;
	Mon,  3 Aug 2026 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775413; cv=none; b=JsHy9l5OpW32BOD1eSPvS9QW0n4ZBVTOqD49U8Q2ZIALgMr/OhKekncM1f8mml00suD13qcNmQyF2iouY9yDNMhxMZC8lQWUOVuHMX1/jo3BJfzk05XKZFAkftp6LQRkKH93/hv+Hi1K3/w1GCi5hnDj9Mo7AVdPPbHPpNiI34Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775413; c=relaxed/simple;
	bh=0kkAeZMdmjfUuU6CQlSVJPTm4Y2lOtxlIkzMy2FLjbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY7XlAVB0FB9yBsvqv9JR5sBPobbu3uxAww+fSA9iiUiII2yqJhgIaSlxVk/cJfUw8IFZsFwwZsnbrKPfXqNbrMWy8gSv16zaZ9kX3Xrfy92LHJvkRd2gbwJTB8qAO1NDd1+YPc+Jhm6oVKFAKgiIpJ4n6JV6hCYrjAeaRCzdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eofLxvUd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eofLxvUd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=km0zhgxKTh3+HxnQUXjeO41ieTZDY4tR2X2UpwcH1mw=; b=eofLxvUdkcF1RFHjun4XajMIHD
	U4q1w13h1xelgW3j8Bl48dqoOp1xz4OEOJh5y056ldyTQ7IoTLhw9xy7FVz7U/Z8vGfoEQ0I2gFta
	sfzRALlV9eEZ0HSTGOMFyZR+M8ip1zUnZkZPOFzEj0pCVqSYj/V41OSk/dLwb0Fj10b8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqvl5-00Fm1E-MV; Mon, 03 Aug 2026 18:43:23 +0200
Date: Mon, 3 Aug 2026 18:43:23 +0200
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
	Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Message-ID: <590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
 <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>

> > > +  compatible:
> > > +    const: soce,switch-dsa
> > 
> > Way too generic. I understand that SoCe will NEVER - and you certify
> > that - develop a second, different "switch-dsa" model and they call this
> > one like this?
> 
> It is intentionally generic to cover the common basics of all variants and
> configurations of the synthesized switch in DSA.
> I'm not sure what kind of guarantee I'm supposed to provide here regarding
> SoCe. If switch-dsa is already mainline in the future, then a different
> compatible will be needed for incompatible new models.

If it is not compatible, it needs a different compatible.

It gets interesting with something you synthesizer, something where
there are a number of different synthesise options. How do you define
compatible? You might want a very specific compatible, for your
synthesise configuration, and a more generic compatible which might
work for other synthesise configurations, but maybe not?

     Andrew
