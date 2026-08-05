Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511446D2B2;
	Wed,  5 Aug 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934410; cv=none; b=Mqj4n8R0r16ypUa4PNAfIMYjQ0njBzWeEMdgtLK+tKmWz6FKY1SGYu7zoHjHFho3Uwi5arfYbeS21aOPZ+JLm9CyOdja6XqRdODu/91EdBMG1ddsoSNewvBc7GjLjkThnXadR3gf9YFLhJLbBxRuyi+SwKNk2C6HMzL0Bx7zjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934410; c=relaxed/simple;
	bh=NiH4LgVUBcWmck3fotLR0p126xuuJUHvpyzJerZy4mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIjeDOVMiZh0NhReKqaPqFAzcIXxs9PdtIFoxYuP58ztPJPxN6F45L2AbIHE3Wdl5hSGW/5KCKX/IU4VmSlZLj8eEdN+YR+DmdupYP43x4GjqzcRszZk3DalxCMRAcAcusvPOoUbVXVUDC0Ouu3c6um/gbrDS2JNODawscMo59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LL3YpI+U; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LL3YpI+U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ue18Ig2prGxCvEwbVh+C6ugeIwImsiAHy857CfDdF7w=; b=LL3YpI+U1LvNPyuzGsL/Y2DKWj
	tOMH7OADn/ukueznBqi5pVkn7v2d3gCWzZOJMyOR5tZgsVm1QVN7TSJWyCkqE0ofyFrjLdoVqdfYs
	qX5Q9PR3nX4lI33aFR52wnTm2SSCLKQOCp9VKDGVTXLQKakycG8j0FnTY/dEOhg9FtVk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrb7V-00GAVu-B7; Wed, 05 Aug 2026 14:53:17 +0200
Date: Wed, 5 Aug 2026 14:53:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
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
Message-ID: <a60a207e-51ff-4332-b578-fbf032b8adfc@lunn.ch>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
 <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
 <590a933f-85af-4eaa-b9ee-be689dc15c69@lunn.ch>
 <54035cef2167d81b43cbdd076b481db31d74e5d4.camel@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54035cef2167d81b43cbdd076b481db31d74e5d4.camel@linutronix.de>

On Wed, Aug 05, 2026 at 02:40:53PM +0200, Vasilij Strassheim wrote:
> On Mon, 2026-08-03 at 18:43 +0200, Andrew Lunn wrote:
> > > > > +  compatible:
> > > > > +    const: soce,switch-dsa
> > > > 
> > > > Way too generic. I understand that SoCe will NEVER - and you certify
> > > > that - develop a second, different "switch-dsa" model and they call this
> > > > one like this?
> > > 
> > > It is intentionally generic to cover the common basics of all variants and
> > > configurations of the synthesized switch in DSA.
> > > I'm not sure what kind of guarantee I'm supposed to provide here regarding
> > > SoCe. If switch-dsa is already mainline in the future, then a different
> > > compatible will be needed for incompatible new models.
> > 
> > If it is not compatible, it needs a different compatible.
> > 
> > It gets interesting with something you synthesizer, something where
> > there are a number of different synthesise options. How do you define
> > compatible? You might want a very specific compatible, for your
> > synthesise configuration, and a more generic compatible which might
> > work for other synthesise configurations, but maybe not?
> > 
> Yes, that's not really satisfying.

That is the problem with FPGAs and jellyware.

> I will tweak the driver so that it reads as much as possible from
> registers. Currently, I'm considering adopting SoC-e IP Core families as
> the compatible option.

I would probably make that the fallback.

Maybe look around at how IP licensed from Synopsys and other vendors
of IP cores work. It is slightly different use case in that these are
generally integrated into silicon, so are fixed, but the chip vendor
often puts logic around the licensed core which needs driving, and
they sometimes integrate the core wrongly, so need workarounds. So you
often have a compatible for the specific vendors overall integration,
and a fallback compatible for the IP core version.

I would suggest something similar here, compatibles for each SoC-e IP
core version, plus a compatible for your specific device.

     Andrew
