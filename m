Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3507531B13B;
	Mon,  2 Mar 2026 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474913; cv=none; b=Qv7MlWs45grsHGs2WjS6EWCaw/pryuW3FMcr0A2I5YLow2g/MWiWP0L3lFVnl6SkY9wZF30a1fma7UCuvz17oAEf4Eeo0Xuru8yAhWp6HUZMyrBfLcnYy25XEOjkzicyFbC441hEhV6JpS4n5z39rP5BdM02FYa2y9hBk/56l4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474913; c=relaxed/simple;
	bh=oulVRINFDT/6gDGtV3K6TJRIxGyRS4NjQHz7UJPaAOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mjwfe3WhFN+9ftl12rC3flf6HLeFhp1QT75Zh+oZCqdq/R0WmUGj2vP/LAOqXG/iXFsFQl2gRa9Fb9Psou18FIs/ef3DbSE2Ee+Gh6XaKhDCBk3AeIzwd9HBxt/VA0NOgVLYsDN5jFApNaCy2KW3CpRGTqR/UAYAOMMB2P2/LZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XRRBkTEc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XRRBkTEc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CLPUXhVrrl5QkMzjH5mUtpnyTmkgWM8SI70aL7C8RrU=; b=XRRBkTEc7bDHuakd9vZCJt1Y9V
	lmFV+qXLMCNS+d3/vQGdUf6hoC3xENg1EfuBry1YYdFrL0yFAZ24Ng0TTYhcp02X0XVBKSOseFIwY
	8ACEGFnOmF/iz2Li8QsKlwljsx5Z2EgReewomye0gve3PHj2RrDE60S1OvVBNIPiEM5Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx7gj-009idt-Cp; Mon, 02 Mar 2026 19:08:13 +0100
Date: Mon, 2 Mar 2026 19:08:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v6 0/5] Add AST2600 RGMII delay into ftgmac100
Message-ID: <81c7c39f-8e52-4749-9f87-0ea707114821@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>

On Mon, Mar 02, 2026 at 06:24:27PM +0800, Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the
> Aspeed AST2600 FTGMAC100 Ethernet MACs. It introduces new compatible strings to
> distinguish between MAC0/1 and MAC2/3, as their delay chains and configuration
> units differ.
> The device tree bindings are updated to restrict the allowed phy-mode and delay
> properties for each MAC type. Corresponding changes are made to the device tree
> source files and the FTGMAC100 driver to support the new delay configuration.
> 
> This enables precise RGMII timing configuration for AST2600-based platforms,
> improving interoperability with various PHYs

Please add more about backwards compatibility. With just a quick look,
i'm not convinced it is. So it is missing text in the commit message
and probably comments in the code explaining how it works.

    Andrew
