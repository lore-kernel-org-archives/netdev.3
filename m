Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33982874E1;
	Sun, 27 Sep 2026 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790530307; cv=none; b=a9H4DFzSe7w9nFsyBqp5Xncmcg1nhOlW+fU2yJElYiwzQTPW6Gmc8tEUwTVHE9tI4JBk5xNAUSvtp3ePE8lwsqvGeok4dFinIadRfLP4bQ7o7sosG6p4dboGQxM4oNAyOaon4s2aA2uV1Q76NgLmoBI5JF+OPlHyw/5GRqHM8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790530307; c=relaxed/simple;
	bh=CZhuxDYZSLHRj7R/HhMSvvL6ZUf1wnDNgVE7vzNTSD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFQR6OJ+GKrnkOQRpnEPp5QZGA48CkrhMvMhtQiKAj2jSWHIAhvryBzhfNQCdi1MJd5ZaC4sTaAsdBGuLXfPEBe30K4xjs9dG+BXjXAi9p1aNy5GrqNxEQ10aQL8divm8JkW2WGu6oonQDuQYD3vTAtVzGO+Upp7Tr/lNOpsrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5E3+zUw2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5E3+zUw2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TBNBXKgdbSNrtNKFB7Hzbz/CEbM1OBZxbHlqjekA/FM=; b=5E3+zUw24QCCO19JFosRAFr5cT
	8hob8yECi8IApFPjr4gPGooPQxxRMbQ8AsPcKGiohmojN5BXCau451PKzp1zedfwZOXm/1dlz3spX
	+6T3nCuGLRryumj3WEsPAJwWpzSdMxUoHsnWo1Hxt5/i6Fxl91NMKibYxK8ehnd797qE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAsir-007XvB-PH; Sun, 27 Sep 2026 19:31:33 +0200
Date: Sun, 27 Sep 2026 19:31:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Liu Changjie <liucj1228@outlook.com>,
	Per Larsson <per@palvencia.se>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] net: phy: maxio: prepare for more DT
 properties
Message-ID: <0618bc2e-76b7-4b82-8f5f-ad84409e80bb@lunn.ch>
References: <20260926225625.25969-1-andre.przywara@arm.com>
 <20260926225625.25969-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926225625.25969-4-andre.przywara@arm.com>

On Sun, Sep 27, 2026 at 12:56:23AM +0200, Andre Przywara wrote:
> The probe routine for the Maxio PHY returns early if the optional
> maxio,clk-out-frequency-hz property is not found. That prevents looking
> for other properties.
> 
> Refactor the routine to handle the property in an if-clause, to allow
> more actions in the probe routine later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
