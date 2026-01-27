Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2031DBB3A;
	Tue, 27 Jan 2026 14:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769522833; cv=none; b=YYrZfQ6TNTZTDHU+3T5krG0SCS/cK29UJL85Xy3nIRGLLmE/F2BHbmyanKil5JbWinfevY7P/tyx0BQbI5f5UaqOVNew+DwC3esckg5KVLt3FIqni1Tbpapt5RG3RQPSEs3jVS6Qj3LI/PnfCkA69d7z/q5h1IOdb9ZMCvn9IXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769522833; c=relaxed/simple;
	bh=jhxPYUHn4abz35bb/vdbcxeGRufyU4vOpUwViuGbJnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT/lT+JOGI5qsWkXePm6COmeUqdO8hh9m+iByElVyuDNb8eGl3exuBLGjj6LinnixcI2JjsPtmzWzv9B9cwL4mF7Exk8uIgZk1RzmZ0wVpFxMKU587mjM/VrSCRJnURZB4N0OqhoLtxn0pls0uc1uV3Q/vQBtWkRGusLO3iHO4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkjik-000000000pu-2fqr;
	Tue, 27 Jan 2026 14:07:06 +0000
Date: Tue, 27 Jan 2026 14:07:03 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip:
 reference common PHY properties
Message-ID: <aXjGh1nzeAz8TQzH@makrotopia.org>
References: <cover.1769519758.git.daniel@makrotopia.org>
 <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
 <20260127132919.xsvapgqc65f44iah@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127132919.xsvapgqc65f44iah@skbuf>

On Tue, Jan 27, 2026 at 03:29:19PM +0200, Vladimir Oltean wrote:
> On Tue, Jan 27, 2026 at 01:18:37PM +0000, Daniel Golle wrote:
> > Reference the common PHY properties so RX and TX SerDes lane polarity
> > of the SGMII/1000Base-X/2500Base-X PCS can be configured.
> > 
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > ---
> >  Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > index f601e5f9fa6a..bf199b096dc5 100644
> > --- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > +++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
> > @@ -105,6 +105,7 @@ patternProperties:
> >      patternProperties:
> >        "^(ethernet-)?port@[0-6]$":
> >          $ref: dsa-port.yaml#
> > +        $ref: /schemas/phy/phy-common-props.yaml#
> 
> Is the PCS integrated into the port?

The PCS is hard-tied to port 4 of the switch. Neither can that port be
used for anything else than this PCS, nor can the PCS be used elsewhere.
It's a bit like they nuked one of the TP PHY ports and glued in that
SGMII PCS instead. The PCS is probably a ready-made IP block, visible in
places like EEE/LPI features being documented for the PCS, but known not
to work on the switch MAC (while it does work with PHY ports). So it's
not a design made for that particular switch chip, but something which
already existed and was then used there.

> have you considered whether it will ever need to have its own OF node
> representation?

Yeah, I thought about that, but it would be a lot of work to
let the driver expose and simple-bus as MFD with devices (clk controller,
reset controller, pcs, ...) sitting on register ranges. Imho not worth
the effort in this case, we discussed it.

That being said, of course, should the PCS IP ever get reused in other
hardware, that part of the driver could be turned into a helper library
working on a regmap, while the hosting driver still takes care of the
resource lifecycle, similar to other PCS helper libraries in
drivers/net/pcs/.

However, even in that case imho it's fine to let it share the OF node
with the ethernet-port. Why not?
