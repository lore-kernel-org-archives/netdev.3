Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2F379C26;
	Mon,  7 Sep 2026 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788808162; cv=none; b=Or/k70QhXXpBFTViprZQh8QDbSibwJxPvSHYUtN3dEe8Fw9CypZzQCuWvHpcBK3nF1I6sNgOqKG5kU7y6qV+doQZ8DPamOXjNVT1iZQnkSh0o7R6PpP2hwcgrBectxSZO3oO5CHt46UVlIiguf9O+Mc+bpA5yUikMg+oyxsHt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788808162; c=relaxed/simple;
	bh=SxG4mydLPL0b44W7HenPavvdKDZ+ghWUlVIAk6pqWFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQZ1Y/nbGHqsQbHdRyw1j6myYXhGnrCMlOW6Qzwdqa6NNyE3HPLdMFO2Bfs1JlKJkhEDHWC8e5XI7IcV7pwrRFN3DVWABlkXOqC5nMmxjgC6qoSRIT1avNPr1LzZeovzrFneAYd4wDr+bLaSYNMKkr4rH4JDVwChDqoMhHHZhG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QDfcucAC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QDfcucAC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9KA/RIOTdUOUelTOruwIkRNdBbHGvnBGIwlOIaJfc94=; b=QDfcucACTrqSdZrS5bECSYkSnU
	hJKF2Wvzd6nnflFXLSZ0VeNt0HO/Nl0kPjhYJUxTOZqZ7w8StFkD1fleY0ITsnF/Lt1nqQCY/erxU
	KvR6yyPsGEGsOSuXKYphBN80YSripZ7ChfYTKb8WKaAcCN46pUa9O65PQbp2qzKKLxqc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3eiN-003bfl-Vw; Mon, 07 Sep 2026 21:09:11 +0200
Date: Mon, 7 Sep 2026 21:09:11 +0200
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
Message-ID: <fd202b11-9cc6-439a-a75c-df345a7de2f1@lunn.ch>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-2-fb0587cb466b@linutronix.de>
 <28f8ec21-162a-4c2c-8e01-6586f39f06f8@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f8ec21-162a-4c2c-8e01-6586f39f06f8@lunn.ch>

> > +examples:
> > +  - |
> > +    ethernet-switch@80020000 {
> > +        compatible = "soce,swip-00-04-0c-10";
> > +        reg = <0x80020000 0x10000>;
> > +
> > +        ports {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            port@0 {
> > +                reg = <0>;
> > +                label = "lan0";
> 
> label is another thing in DSA which is today not best practice. I
> would drop this.

Humm, actually, since it is a DSA driver, it is O.K. You can keep
it. It is however better practice to allow udev to rename the
interface as it wants to.

	Andrew
