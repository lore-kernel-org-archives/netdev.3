Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE2B25B082;
	Thu, 27 Aug 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843164; cv=none; b=pr5xwhIX0I5lvMmaimSbMwwOrvudyq4d0Eaen3P/cJkPi76C0GH0Pgz2BW2jsNyavrq+LsGF0exMfos2ukeDsu7u7z41eqmmfitNds2sAUNkJ/6qlEoEh+ggEHCvFfXC6Ov071MWWoDDy3rk1tjXWhn+baaLoj7RgPyAQKsjBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843164; c=relaxed/simple;
	bh=KqsacFKRSHjFtwkCxgPvOi12201UTpRXBFohncTQso8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxkzfZi9Hdyb/0i7HRnKYrnD5UL0KKNcYcMYw6x2H2RE3uF2wCUJnoIQQeLGB9ZWNk2pmYSgtQ7BLKQRer9RTV6T6fAE0nUpRe8i3B/vpdWdlb+/nh0IkRAD8vclSkOjjZOmq2DZ7PlYpk1fqurgJbbEtCGmr5m5LsouIo25/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hAfrHBL5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hAfrHBL5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=s0uIwDQ2Pq/fTiE7oatopPfUB0tvlKHsPE9DE/ga6Ns=; b=hAfrHBL5xby1VejzjI3GwwFHl5
	KkWbZ+4LqAmP6+qp6E+gIQQQ3+nJXR+HvNkA2pDQRmB6s6qxjZXodepr/hOy0LO4fRmbeESapIh62
	PMumbocy2KPJHZ1pq/qf/arDmltcrUMslVbwFejuGoT9cboUP+H23GPF/ZXsD2Lx0MSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzbfl-001gHE-Lm; Thu, 27 Aug 2026 17:05:45 +0200
Date: Thu, 27 Aug 2026 17:05:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Conor Dooley <conor@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: dp83867: add binding for
 output-impedance
Message-ID: <b10f5ca1-d0bb-4cf2-9cc3-9ed66ab427b0@lunn.ch>
References: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
 <20260826-v7-2-topic-dp83867-v2-2-a97b4cec6e93@pengutronix.de>
 <20260826-salutary-skype-524c69932dc2@spud>
 <87ik4wgfbc.fsf@pengutronix.de>
 <d944329d-9ad5-4acf-a7d3-b2f8eaf1e92c@lunn.ch>
 <87a4q74ris.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4q74ris.fsf@pengutronix.de>

> So, just allow values between 35 and 70 in the binding and then
> convert that value to something near the truth in the driver?

Yes. And you can add a comment that the values are not exact, due to
process issues.

	Andrew
