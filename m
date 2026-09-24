Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD23CCFAF;
	Thu, 24 Sep 2026 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261039; cv=none; b=CN0nUGvqWWqLGPhvK5lG+0lkVNVRl1BXXxmZam8rXN1vp3ZAHTtfdMQ3wZyevuvQCeGh85HZBZzE5PAysOAt7CboQwQP3/9XOS+IINbfsEpPiEPVwVQbenv91rBb63Gwy9ZnA/8+3ckFHBM4WFNzhcH9cqgbyiCjqMjdMlaoUqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261039; c=relaxed/simple;
	bh=I2zwu1o2eKBm3bb8m8xA1aktnk5mFIpImfzHEKDiekc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPCGe+ZKensuEklNGiLZ0yViQ8baGdDButGEcV1AL2W0AqcdxrPC4FWwbgQWo0WJOIoLAyOt8csnm7d0Ysf8pa3nX8kDNOjemJ7tzlq2DDjSsXYjqBceDPAlPV21BMai0plg7yoLKxhMRylTy486eRQiU9i68d4dCZ+ORuYthlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xrmuoxwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xrmuoxwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264C91F000FF;
	Thu, 24 Sep 2026 14:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790261037;
	bh=Z1p21TsolUrg+uQYicc4tIwZwvOpamvsDeXozsny+5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xrmuoxwa4pF+EATlgfIiEuMWkUHMzKmFYhrIicd2EuZjxbVy6l92ge00Lu4JhxAPi
	 9BETJOJrUGKF4mGzti+wT//1/cncnWQCXJZpxQWxnMFJph3ry3nZwVpdka4nZM3J1x
	 O49L96wSqmpv0GhstNI/OoTLdG70jGDQzmOywDSCONSm/+LVfzc8AG+Czi/pExiWB0
	 hB6cdrPKljW7pJNC52GXYFm82PzI/qAMUmmW7SN5K0/z/PmGhmCyMrDJN80SB+uyJ8
	 pHLuIXDkxlwryBSvdDmaKCcor5Oo9ZKuZoGKr4fP/0w5BzAGhaRi9BUk2PkS7oDjrC
	 hjibXRgltyh0g==
Date: Thu, 24 Sep 2026 09:43:55 -0500
From: Rob Herring <robh@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: markus.stockhausen@gmx.de, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/5] dt-bindings: net: realtek,rtl9301-mdio:
 add clock-frequency
Message-ID: <20260924144355.GA4167689-robh@kernel.org>
References: <20260912130451.3757276-3-markus.stockhausen@gmx.de>
 <178956571230.22033.2648098417803980646@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178956571230.22033.2648098417803980646@kernel.org>

On Wed, Sep 16, 2026 at 01:35:12PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 0 · Low: 2
> 
> - [Low] Concern (validated as a FALSE POSITIVE, retained only per the
>   retention policy): 'the binding adds a per-bus clock-frequency…
> - [Low] Redundant re-declaration of the common `clock-frequency` property
>   in Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml.
> 
> --
> 
> dt-bindings: net: realtek,rtl9301-mdio: add clock-frequency
> 
> This documents the MDC frequencies supported by the Realtek Otto switch
> MDIO controllers, adding per-family clock-frequency value sets and
> describing the shared frequency selector on RTL839x.
> 
> > diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> > index 7f5b4897487b2..c5f2289dc0eb2 100644
> > --- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> > +++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> > @@ -56,6 +56,9 @@ patternProperties:
> >        reg:
> >          maxItems: 1
> >  
> > +      clock-frequency:
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +
> 
> [Severity: Low]
> This isn't a bug, but is this declaration needed at all?  The mdio-bus
> child subschema already does:
> 
>   '^mdio-bus@[0-3]$':
>     $ref: mdio.yaml#
> 
> and Documentation/devicetree/bindings/net/mdio.yaml already declares the
> property:
> 
>   clock-frequency:
>     description:
>       Desired MDIO bus clock frequency in Hz. Values greater than IEEE 802.3
>       defined 2.5MHz should only be used when all devices on the bus support
>       the given clock speed.
> 
> So the property is already permitted by the referenced schema, and its type
> is known to dtschema without an explicit uint32 $ref.  Other in-tree
> bindings rely on that, for example mscc,miim.yaml uses a bare
> "clock-frequency: true" and microchip,pic64hpsc-mdio.yaml declares
> clock-frequency with only a default.
> 
> The per-family enum blocks added below in the allOf if-then sections are
> what actually restrict the accepted values, and those work independently of
> this declaration.  Could this block be dropped so the common property is
> only described in mdio.yaml?

Sashiko is correct.

Rob
