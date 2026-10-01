Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A1F3164C5;
	Thu,  1 Oct 2026 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858030; cv=none; b=OiwwRYIqjiE6StACXbH5fwnzglGqIxavA6RJ4kvjcD4D912hWN+UbEZcSPhSi/dMmZAFqIooORFy2TVUG3HEQ6eqNcpEfUqYhe9eyN2qpvp90Q8eehJxHrxjw1+EGBrFco3mpFScWBSgo51LnCKahlxuFk+RXwUTQO/++siu42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858030; c=relaxed/simple;
	bh=4ZT/aROE8xKg0iGYQAiFrLiahjxgLK2Ej4pIM6YTeIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8FbVP1W47DyST0quuOED9JcA2jxoIVemSy+lHco2MTCZCXN7+d/3Bsqo2jmotNQsse8rzduGg8ROWNTwDT5T5xNHSZWUyBcWoX9VhyXr2LS1saThe1Q0uCu3wRs5Asjwn/4Qpbm9dyYBb8Bx8rTOpAjZfcMmj6KebYZbjUvLGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dTSeTNfu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dTSeTNfu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fFX5htuzSdP4QTu71gx2Fo7hLlalL+bUbhtdUZCmvQA=; b=dTSeTNfu4mWw57xRAqj2KXYDed
	YEDUHAY22sJ0H+fu3eRfqBo0r8BVCEVPzJTkuCK7N89SgLImyjG+AJzNOXme3KvcHCenViAOvUrYK
	3X9p4stcw/zu81Bew+6RMXIytub3Oriws32gmWdSXAdBavRYmi+O2wPhNvFjq0ueZvro=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xCFyk-008NX2-Tb; Thu, 01 Oct 2026 14:33:38 +0200
Date: Thu, 1 Oct 2026 14:33:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, lxu@maxlinear.com,
	michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	luka.perkov@sartura.hr
Subject: Re: [PATCH 4/5] dt-bindings: net: maxlinear: add MxL86211C lane
 mapping support
Message-ID: <a2bcd146-0462-4ab1-b7be-93d6b4e05056@lunn.ch>
References: <20260930122305.293686-1-robert.marko@sartura.hr>
 <20260930122305.293686-4-robert.marko@sartura.hr>
 <20261001-splendid-athletic-coot-1bbbb6@quoll>
 <CA+HBbNEOiAw+_zzQco13nNzUPdGUgo+kjcRzLFEA4LmnzF8_=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNEOiAw+_zzQco13nNzUPdGUgo+kjcRzLFEA4LmnzF8_=A@mail.gmail.com>

> > > +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> > > @@ -22,6 +22,21 @@ allOf:
> > >
> > >      then:
> > >        properties:
> > > +        maxlinear,lane-asp-map:
> > > +          description: |
> > > +            Mapping of the physical TPI lanes A through D to the PHY's
> > > +            analog signal processing lanes (ASPs). The array index identifies
> >
> > Are there other lanes as well? Not ASP? What sort? data-lanes does not
> > fit here?
> 
> Hi,
> I tried to keep it similar to the datasheet, but looking back, a more
> appropriate
> name would be ASP instances instead of lanes.
> 
> I am not sure if data-lanes describe what it is fully but I am open to ideas.

Analogue front end ports? Or even just analogue from ends?

I do get what you mean with your current description, but i have more
domain knowledge than your average DT writer.

	Andrew
