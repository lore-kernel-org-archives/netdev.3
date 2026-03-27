Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49989351C1B;
	Fri, 27 Mar 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611150; cv=none; b=ueggs9AnTC8IzLAs+UZ4zPPfE9qPoB0aHWaw9bnY6CIFL8VVGuHt1fLxcY6ItptL4WdAfkF5p2Ee3QkQbQ5Xx1Ua9Wj5ESu5WMROCFaJ3tz2P7Qmpl+Gytjk6rewobVtz8vf97Un5F5MssfRjQp7l+1R8g8WQML+m/GW77x2yZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611150; c=relaxed/simple;
	bh=RtXQCJ0TXrzXdGoLnh5AEt9Fy5qnNmlf5vZHFBE71GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSqH4qDJ/7FN/Ywe5TmMekAtHxkDTxYoxrpqRotg7pSCLuDi3AGOMaoHf6YEjA4upAYJw/8krhjPNSY60QytutVp+V7QlrwlSIpXmV/U55y1a9dYFjGVUUB3vFfo6cERSqhOy0x0ycTs96mYtL2/fxDpbyjntA13UhPsHfsJtu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w65QG-000000002WE-3FcO;
	Fri, 27 Mar 2026 11:32:16 +0000
Date: Fri, 27 Mar 2026 11:32:13 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: dsa: add MT7628 ESW
Message-ID: <acZqvZfYXR_4sMlT@makrotopia.org>
References: <20260326204413.3317584-1-joey@tinyisr.com>
 <20260326204413.3317584-2-joey@tinyisr.com>
 <acW9G8vrMz89Enss@makrotopia.org>
 <acYZOEksxcc-uHcT@archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acYZOEksxcc-uHcT@archlinux>

On Fri, Mar 27, 2026 at 08:00:51AM +0200, Joris Vaisvila wrote:
> Hi Daniel, thanks for the feedback
> 
> On Thu, Mar 26, 2026 at 11:11:23PM +0000, Daniel Golle wrote:
> > > [...]
> > > +            port@6 {
> > > +                reg = <6>;
> > > +                ethernet = <&ethernet>;
> > > +                phy-mode = "rgmii";
> > 
> > Is this actually RGMII internally? Or some unknown internal way to
> > wire the switch CPU port to the CPU MAC? In this case, "internal"
> > should be used here as well.
> 
> I don't know how to find this out for sure.
> 
> In the MT7628 doc (https://vonger.cn/upload/MT7628_Full.pdf) port 6 is
> refered to as RGMII port 1 (RGMII port 0 being the non-existent port 5),
> but there are no clock registers to be seen.
> In RT3050 docs there are RGMII clock registers for port 5, but nothing
> for port 6, so maybe the CPU port is really using some mystery internal
> connection and only uses "RGMII" as a way to say it's a Gigabit port?
> 
> On the hardware I'm testing on, it works fine with the port set to
> "internal" or "rgmii". Would it make more sense to set "internal" then? 

"internal" then. It's a single-die SoC, the switch sharing the same
memory space, clocking domain, ... with all the rest of the SoC makes
it very unlikely that RGMII would be used as an on-die connection
type. (unlike eg. MT7621 or MT7623A which are using multiple dies in
the same package, and actually RGMII or TRGMII to connect the
MDIO-managed switch part to the main SoC, see "MCM" / "multi-chip
module" in the mt7530 driver...)
