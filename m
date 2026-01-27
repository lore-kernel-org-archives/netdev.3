Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8853002CF;
	Tue, 27 Jan 2026 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530966; cv=none; b=QFTJqIoAfj0NjsajxUPpfJbL1ffdZXjpog2TGlFaHwvgzoLBoDXd9GTvMM6vhIQ+m1k73Xs8PFWaZIFZ33opVQnLkROqthEG4ow2jECaFVnSRhhPt0z5S62iIVkbpS/cGH1NBwWW6EUvv1opkUurJDI0dZUXyh70pHMaiDNmR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530966; c=relaxed/simple;
	bh=bzEzsJt4MXGUIhvPjvkK2AeikSGIbnB2herqMgXFsDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6u5jZqzU3ISElVAOzDchiP3SGPHgjie2ATLw3MvrrrzAH3LiqFalIfv2SYF9TaMthPW+yU86MtVOjbK/PXtbmQ9efndssEnqyAO3zVnROvxQyajbs4MXgjaBjUrfoAtXQwVfLyDll00itadHKsBXFg/LOWoURIS7wQLh48QAWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vklpv-000000001ZH-0WCi;
	Tue, 27 Jan 2026 16:22:39 +0000
Date: Tue, 27 Jan 2026 16:22:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, Hauke Mehrtens <hauke@hauke-m.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <aXjmTMasMdE52Gfw@makrotopia.org>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
 <20260127132919.xsvapgqc65f44iah@skbuf>
 <aXjGh1nzeAz8TQzH@makrotopia.org>
 <ad3bbac2-1aea-401a-881f-a8a9860f84a9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3bbac2-1aea-401a-881f-a8a9860f84a9@lunn.ch>

On Tue, Jan 27, 2026 at 04:21:26PM +0100, Andrew Lunn wrote:
> > > Is the PCS integrated into the port?
> > 
> > The PCS is hard-tied to port 4 of the switch. Neither can that port be
> > used for anything else than this PCS, nor can the PCS be used elsewhere.
> > It's a bit like they nuked one of the TP PHY ports and glued in that
> > SGMII PCS instead. The PCS is probably a ready-made IP block
> 
> Does it have IDs in register 2 and 3?

That'd be too easy ;)

register 2 is SGMII_PHY_MPLL_CFG2
register 3 is SGMII_PHY_RX0_CFG1

register 2 and 3 of the XAUI PHY which can be indirectly accessed also doesn't
contain anything meaningful (0x000a and 0x0000)

> Is there any clue if it is licensed from somebody?

At least it's not obvious in any way.

The documentation is public, see
https://www.maxlinear.com/product/interface/ethernet/ethernet-switches/gsw145
"Ethernet Switch GSW145 Data Sheet"
Section 4.2 SGMII_Registers

My guess that it is not genuinly designed for that switch IC stems from
the fact that it has features (EEE, for example) which aren't supported
in the way it is integrated in the switch.
