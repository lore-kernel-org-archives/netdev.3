Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68B211A14;
	Mon, 15 Jun 2026 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567436; cv=none; b=RqZ5pBE1KYHYgkQSCPjntVKqna1GHFgleVtMT/05pC8bdiCDpQjhxO9ZYaUvSb4/xdhCJJSE+dsKFKi66ALu+DqedMlqbWnNe3X2YKt3D/JhTdgIbd9N+Px1uq1kqu64OaH2djSU2ZxP2Z3yy1RWIx4Nd/FPd/9caDiTgPBK+ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567436; c=relaxed/simple;
	bh=zarUAXzA1VjzaAP4jkMzfGD1W8Ao9hpAZEzZHEjGZfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1PWAMKqmGzVNQzxit5UAu9J6EdkgcwUrFvcGlbZaDtNdaz/Ab0YGVJTrKn82MtRxGktpxN6DPUULeoO22l7pY0oOs6tiP6XhhG/sHeQ3t19nrsPt+RuNGpOx6MF4eNwKVZcVCeS1AnxvgMUIEGSs+tveEbeP98cE5FtyN1i5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wZH4U-000000006lY-2qLk;
	Mon, 15 Jun 2026 23:50:26 +0000
Date: Tue, 16 Jun 2026 00:50:22 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Rob Herring <robh@kernel.org>
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: pse-pd: add bindings
 for Realtek/Broadcom PSE MCU
Message-ID: <ajCPvreGRnamixW0@makrotopia.org>
References: <20260612132944.460646-1-jelonek.jonas@gmail.com>
 <20260612132944.460646-2-jelonek.jonas@gmail.com>
 <20260615212959.GA1679454-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615212959.GA1679454-robh@kernel.org>

On Mon, Jun 15, 2026 at 04:29:59PM -0500, Rob Herring wrote:
> On Fri, Jun 12, 2026 at 01:29:41PM +0000, Jonas Jelonek wrote:
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - realtek,pse-mcu-rtk
> 
> The "rtk" feels redundant.
> 
> > +      - realtek,pse-mcu-bcm
> 
> "brcm" is the standard vendor prefix, so use that instead of "bcm". 
> Though who defined the protocol in this case? Realtek or Broadcom? In 
> the latter case, I'd argue that "brcm" should be the vendor prefix.

The microcontroller firmware, and hence the protocol, is designed
by RealTek in both cases. However, they chose to design two incmpatible
protocol dialects based on the features of the PSE(s) connected to the
MCU.
