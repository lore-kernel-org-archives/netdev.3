Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6E53D1ABD;
	Wed,  7 Oct 2026 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791378867; cv=none; b=g6JGtHCPiAonF8NGXYENUITh17dHUBFJk9UE8PBuH4+zgUuA5pvrczl3yOHG3jpnbzCOsWSVkCE/p13ePRTnXt+8pMgVoKz40szprme3bdlm6zXt1FYkLD0/wCAtc/eZSarTgkPM7NDwq2XYbElaFMqCgi0RPWpaWuG3SVq04vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791378867; c=relaxed/simple;
	bh=eKwbDkO4+HnyjyvoGYwD9VulbmzTXzBokVQuiWHlvAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9hKSXxePaD575YV3Nd2Xv6apRvshKmZOokGLgBzgJzzKwvpgtGY7NUgRJ3TdIt/jkVqdJRZNoIjH3+jqjXFoIm4YvZxWo1Uv45PA7hqnyBlmKcwmP/hND4FFnWOg4Rh9D8+04qh2PdzKyAOiYQpfZAajHh+S5/9rCQErRsR5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XerqC5BY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XerqC5BY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Im4V+Rt/IisH7q38IS8cEegphTQYou0EBsEjpW96IHI=; b=Xe
	rqC5BYl0o29eW7OAYhFXxw8MBPIeqnXXPfjjRJiwnEUMrE+LaDbyVMA/v9qv30oJ/qvgxUKzjKgG0
	hDqeE6up/i7eu8Ha8sycwt0qk5xL5kyD6Nhp+Tuia+8sSp4YR6n7aaFrynb6BtLSOgBR1Lqz/BvAX
	PnrivrWwm2e3o0A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xERTB-009Sm4-Kf; Wed, 07 Oct 2026 15:14:05 +0200
Date: Wed, 7 Oct 2026 15:14:05 +0200
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
Message-ID: <c05a0966-35e5-4a81-8da5-8c24734a9ee2@lunn.ch>
References: <20260930122305.293686-1-robert.marko@sartura.hr>
 <20260930122305.293686-4-robert.marko@sartura.hr>
 <20261001-splendid-athletic-coot-1bbbb6@quoll>
 <CA+HBbNEOiAw+_zzQco13nNzUPdGUgo+kjcRzLFEA4LmnzF8_=A@mail.gmail.com>
 <a2bcd146-0462-4ab1-b7be-93d6b4e05056@lunn.ch>
 <CA+HBbNGUbR3KeZMaWoBqEqMLMkELMLxuL4taCcOG7V03VsuUEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNGUbR3KeZMaWoBqEqMLMkELMLxuL4taCcOG7V03VsuUEw@mail.gmail.com>

On Wed, Oct 07, 2026 at 10:49:01AM +0200, Robert Marko wrote:
> On Thu, Oct 1, 2026 at 2:33 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > > +++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
> > > > > @@ -22,6 +22,21 @@ allOf:
> > > > >
> > > > >      then:
> > > > >        properties:
> > > > > +        maxlinear,lane-asp-map:
> > > > > +          description: |
> > > > > +            Mapping of the physical TPI lanes A through D to the PHY's
> > > > > +            analog signal processing lanes (ASPs). The array index identifies
> > > >
> > > > Are there other lanes as well? Not ASP? What sort? data-lanes does not
> > > > fit here?
> > >
> > > Hi,
> > > I tried to keep it similar to the datasheet, but looking back, a more
> > > appropriate
> > > name would be ASP instances instead of lanes.
> > >
> > > I am not sure if data-lanes describe what it is fully but I am open to ideas.
> >
> > Analogue front end ports? Or even just analogue from ends?
> >
> > I do get what you mean with your current description, but i have more
> > domain knowledge than your average DT writer.
> 
> If analog front ends are fine with you I would like to use that in
> next revision.
> Mybe keep the "(ASP)" so that anybody looking at datasheet knows immediately?

That is O.K. with me.

     Andrew
