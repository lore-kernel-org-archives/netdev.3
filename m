Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E135CB95;
	Sun, 27 Sep 2026 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790530800; cv=none; b=Bh9AL6hx1MYPtrhrz6YerbRMh7V0i1HoHG5u5xHP5GTcTgMZctXCZHKaPNQ6SbaDiq3GW/oHalJsctjOvl3JATUwHxWyT7eLsqmzQIm+6veEqiW9ttss9Um7v0tNnLgh/xNVGi+vDXiu8ybthr8lprtm5rlxAbnkQPC75JNfbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790530800; c=relaxed/simple;
	bh=U9Q/3E11oseEz/2hH8f1J2cTCxzQ5lJt+Q1fp/l6Vz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQatd0qVkuni0G4oCsHQBJkL0G+VUxSsJQknSZOPcBdIQWvST2/YiehrZHjlpbaHBbJgxlyRJP1+vZO2INQWGo7WfX+JwBR8ONgUeh8eGIfGToFu3a3zyYkjLUc8Lle2B9ThpQE76hSVlAffSVFSOGEyGFazbb48meeOoKYb7iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YHuyWNG7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YHuyWNG7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7WX6+BN1oNRZyY1oWGFe4jd3bJh7R/vmOzZu6ho3ooE=; b=YHuyWNG75/RLzBVWmxiikxHFgh
	zqJY3eKxBCjXK/O0w+bni2s+iZGHNGTPizOnQOoCrilFw66W/9doqw40AtOG6O6TW9vjCcuCSzUwQ
	rDJw3tYMTaivXzIS5E79faCPqIkY4oHdFQUfqPDDy+iR6Csk2Gm1KgM4qlcLRlx+PjrE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAsqo-007Xym-Gf; Sun, 27 Sep 2026 19:39:46 +0200
Date: Sun, 27 Sep 2026 19:39:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] net: ftgmac100: Add AST2700 support
Message-ID: <14a281e2-c88e-42e3-acd3-b20f111a4c28@lunn.ch>
References: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927-support_ast2700-v1-0-9f03f29d2c82@aspeedtech.com>

On Sun, Sep 27, 2026 at 03:16:19PM +0800, Jacky Chou wrote:
> Add the pieces needed for the FTGMAC100 driver to run on Aspeed AST2700
> systems.
> 
> AST2700 keeps using the FTGMAC100 MAC IP, but the enablement is not
> limited to a new compatible string. The SoC can boot with the MAC on
> ARM64, needs the Aspeed-specific RMII mode bit programmed when a port is
> wired for RMII, and requires the driver to use the upper DMA address
> fields in the ring base registers and packet descriptors. Those fields
> expose a 35-bit DMA address range on AST2700, so the driver must request
> a mask that matches the address bits the hardware can encode.
> 
> The series first documents and wires up the aspeed,ast2700-mac
> compatible. It then treats AST2700 as an Aspeed MAC in the driver,
> enables the RMII mode programming, writes the AST2700 high descriptor-ring
> base registers, carries the RX/TX descriptor high address bits, rebuilds
> full DMA addresses before unmapping buffers, and requests a 35-bit DMA
> mask. The high ring base registers are only touched for AST2700 so older
> Aspeed device tree register windows remain unchanged. With that in place,
> the FTGMAC100 Kconfig entry can be made available on ARM64 while keeping
> the existing Aspeed MDIO dependency for AST2600 and newer ARCH_ASPEED
> systems.

There is no mention of RGMII here or RGMII delays. Given the mess that
the AST2600 is, i would expect to see some explanation how that has
been solved.

     Andrew
