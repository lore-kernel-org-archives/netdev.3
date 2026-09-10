Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB53481FD0;
	Thu, 10 Sep 2026 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042714; cv=none; b=oN8dGrl/y8z3tPtMliqCCn6Nk0pKxCn5iGlKTYa65FqvEB1tFLDYRStjB0e/AGVQR9dYvguC54+yzYyLl8x4mawRsztR7QTcmj/V4ep5PeEvbTsxrUdZ+a6GROWYwDPtLAcxRMylrl6qxot1zaWLyrcf/DEy3Xuj3+sWChNIKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042714; c=relaxed/simple;
	bh=zJ4+yME/Q7Os+J6hyzP++ZKOiQK5dIN/UxzKF4o52GI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7cepvcxc1tp34wZC9qUgabzhDTGXhvOxG7OVBXRLVDykPyHUKEEZVnOI8UluqlVrRYAdRYnwMZ2Fy3Ot9IK4RD+c5gCOA/yzHH/4vPGsrz1BzRFLIQ+rY0llqVLEVL+ACXl6umIdZJwXOYFRYy/rHsQXKU1PbnIO/bdoLJ5VPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x3ZCxRG2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x3ZCxRG2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gNS3JIqSU8/+D32CAHUVJplRawU3iI1w217293UE1DE=; b=x3ZCxRG2UY5byY0ir/oPwV9lyK
	wiR6f6CkgkKxjnPpGLUnjUa8KIJQ4ELN+MQsXriyfad1i8/AUcvVR11yU/Ml19JhtJk3OSDEA7QZv
	tGO+aqgJ3PaKSvZYOwMJNXNm+V6orCMditwx7L3hpkuxw1qHyRaWbduRXRHeoXtebgno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4djM-004UmW-3T; Thu, 10 Sep 2026 14:18:16 +0200
Date: Thu, 10 Sep 2026 14:18:16 +0200
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
Subject: Re: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Message-ID: <b7fdbd43-d069-40e1-aff4-30197371739d@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
 <3c2c5b39-6a7d-4cb2-af1c-b5015b6bf1e8@lunn.ch>
 <db26d5c9262069a11e5cbe00e176b81e40baebeb.camel@linutronix.de>
 <5c955c96-7883-4e59-97ef-9fc3b63abf58@lunn.ch>
 <ab7e4eeed1b8296188355413cce1aa2b2aa5c670.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7e4eeed1b8296188355413cce1aa2b2aa5c670.camel@linutronix.de>

> ethernet-switch@xy {
>     /* ... */
> 
>     mdio_parent: mdio@204 {
>         compatible = "soce,swip-mdio-23-02";
>         reg = <0x204 0xc>, <0x200 0x4>;
>         reg-names = "data", "control";
>     };
> 
>     mdio-mux@200 {
>         compatible = "mdio-mux-mmioreg", "mdio-mux";
>         reg = <0x200 0x4>;
>         mux-mask = <0x1f0000>;
>         mdio-parent-bus = <&mdio_parent>;
>         #address-cells = <1>;
>         #size-cells = <0>;
> 
>         mdio@0 {
>             reg = <0>;
>             /* PHYs connected to port 0 */
>         };
> 
>         mdio@10000 {
>             reg = <0x10000>;
>             /* PHYs connected to port 1 */

These comments are probably wrong, as i suggested in my previous
reply. There is no reason that port 0 PHY could not be on bus 10000.

I've no idea if it will work, but maybe try:

>         reg = <0x203 0x1>;
>         mux-mask = <0x1f>;

and then you get better bus numbers?

    Andrew
