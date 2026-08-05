Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7918447127F;
	Wed,  5 Aug 2026 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785938052; cv=none; b=exKk4DSFfltrLTrvjs8UAH552jKzqgAJ8VuAhF/4+fPUNSe8KgES2u2TowsrZzQwbRZRzmIZ9miGFWZ/FMcmbT4niLC0YLwmVo9ww0HolV4W6/AqCa13l9F9utK/zPkEGqxBTyryaygsoQ86Aw/PixQOBkeu/NmDujoXXg4mYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785938052; c=relaxed/simple;
	bh=1i6cLqiq5fKoAG2DxsPLcgj1hvCQ6gFCDmFL+wghbjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bft22pnl7UldMdVC8V6uLhqZlTYtyvZeWlwkfCHtk4tsyUdfbDYdd7IjdCEtqJ3z98dfxs77kjynwKRdR/GMnUAXXH9PV7pxEpA+1agRRi8GkwxMCH5R6zVV2Qry+flUZU0lASRsNgXta/G7RJ2aIIT/lwOIX/26cezdQyAUbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iQYhJUkR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iQYhJUkR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DuiO1OPXdAlYbES1EQ0pzMKTK574ghniz0vyq4qAkBM=; b=iQYhJUkRNRGsgTDi4UNXTVZhri
	0nD7kqsjJA2g6DcKv06apMX40w+3rYm2t0WcSNVdn/bV79JkJoROwfU9kxLSFYBawaEZFHbk3DFRT
	hkWK10aYNUA20Mxhs5/yNBsZ0SPaR1KC8avJ8yRspTkefQLuV7TK6Dl34mHI4eGwCZMQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrc4F-00GBJF-5a; Wed, 05 Aug 2026 15:53:59 +0200
Date: Wed, 5 Aug 2026 15:53:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: Vasilij Strassheim <v.strassheim@linutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Message-ID: <9f8ac30b-6579-4e48-abe3-823302a3da0e@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
 <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
 <590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
 <20260805153220.3860b262@mitra>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805153220.3860b262@mitra>

On Wed, Aug 05, 2026 at 03:32:20PM +0200, Benedikt Spranger wrote:
> On Mon, 3 Aug 2026 18:43:23 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > If it is not compatible, it needs a different compatible.
> This is quite tricky here - namewise. 

Yep.

> 
> > It gets interesting with something you synthesizer, something where
> > there are a number of different synthesise options. How do you define
> > compatible? You might want a very specific compatible, for your
> > synthesise configuration, and a more generic compatible which might
> > work for other synthesise configurations, but maybe not?
> 
> SOC-E sells quite a bunch of switch IPs (MES, MRS, NTS to name some).
> As far as we know for now, these different IP cores can be determined
> by reading specific registers, which seem to be on the same spot across
> different IPs. You may wonder about "It seems". Since we have only a
> limited access for information about different IPs, we have examined the
> vendor linux DSA driver and the surrounding configuration software.

Take a look at the mv88e6xxx driver. Marvell switches have an ID
register. But Marvell keep moving it around. So the compatible is just
about where to find the ID register.

However, that is silicon. For licensed IP, you are not driving just
the licensed IP, but also what has been put around it for integration
into the system as a whole. Regulator, clocks, etc. The stmmac driver
is an example of that, the driver has a core which covers the licensed
IP, and then a number of glue drivers which extend that to cover all
the integration logic. Another example i've worked on is the Open
Cores I2C driver, i2c-ocores.c. It has a generic compatible
"opencores,i2c-ocores", plus some integration specific compatibles,
"aeroflexgaisler,i2cmst", "sifive,fu540-c000-i2c", "sifive,i2c0".

So i suspect you will need to support integration specific
compatibles.

One way to consider this. Look at your FPGA design. Delete the
licensed core. What do you have left? Does it need software to drive
it?

	Andrew
