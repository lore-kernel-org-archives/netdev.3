Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A43C3F70;
	Thu, 24 Sep 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790261186; cv=none; b=f7W7Wyo1HfOxbuoh6vvIoaCddDGJrTx+xZWn0naLEQgr0Fd+w46Uu3LqgRcW2Omh5c1/35Hy8HiEDnHlURQiV6DVzG9ADS1rQlslMoY2mihUCecrgR19fod4E/OEBjAB8YS0jc36dO3P6NaS8IJEIi04wv3vm0/c280fLmATcso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790261186; c=relaxed/simple;
	bh=Rynx6fYwOQEX11x0Txpe6Q4EuFUTIqBUi6DHBzBnmwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaA2nNEDPVkrh/x3BOs6p2ieThsGucOK00cR2VKUgx4oXUIzpLD6127kSNxrrLXwVz1Y2LbnuV8w/iET4hvTmayNTQEFbOpw6l5KtZan1Q8f1fBnjqd7oc5/PuZvhsTDSDVg10b9Nj/4/3jQiDseRFmg9BvUgHs1tA3OeKdzGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5NS+WFb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5NS+WFb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C58C1F000FF;
	Thu, 24 Sep 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790261184;
	bh=Oco91rZ8SLGi4ef9P3VbK8DXkHpHcqyYrILacBBh0A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G5NS+WFbIem0a8FzuzrO5QnW8wEhjHhnSIdbOtUvBE9HkY1q7uw0l5dtDFzYcsssZ
	 vt1jeGjjboHPAKFigfenCvH6YjLMi0cauc+PIYVS3wH3YeKKEesF32mLCwrsz/x+7D
	 xXXNrWS2y27uU9+9UU7WYVc1a8TKgELVjRl5yO1q2Ja5SNVVLQVYa8O+lfX1kS/4F4
	 lePhCwFKBk357xd65iA9HBT/xUoudTH55UVO6TacsGJr5/70VBxfTOUlocsz7ygPYa
	 9jY4dxoEx2WInCGoOpU44BSPya8KPY85yhiSs2SjN5mmYrQHor056ldvC5n3wmKphv
	 6nVRbiFQnHaPA==
Date: Thu, 24 Sep 2026 09:46:22 -0500
From: Rob Herring <robh@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: markus.stockhausen@gmx.de, andrew@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/5] dt-bindings: net: realtek,rtl9301-mdio:
 restrict MDIO buses by family
Message-ID: <20260924144622.GA4180569-robh@kernel.org>
References: <20260912130451.3757276-2-markus.stockhausen@gmx.de>
 <178956571096.22033.1324157422276350284@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178956571096.22033.1324157422276350284@kernel.org>

On Wed, Sep 16, 2026 at 01:35:10PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> - [Medium] Incomplete constraint: the new per-family `allOf`/`if-then`
>   blocks in…
> 
> --
> 
> dt-bindings: net: realtek,rtl9301-mdio: restrict MDIO buses by family
> 
> This adds two per-family conditional blocks to the Realtek Otto MDIO
> controller binding so that mdio-bus child node names are limited to the
> number of buses each family has: one for RTL838x, two for RTL839x and
> four for RTL930x/RTL931x.
> 
> > diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> > index 67e0b23a8470e..7f5b4897487b2 100644
> > --- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> > +++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> > @@ -67,6 +67,30 @@ patternProperties:
> >  
> >      unevaluatedProperties: false
> >  
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - realtek,rtl8380-mdio
> > +              - realtek,rtl8381-mdio
> > +              - realtek,rtl8382-mdio
> > +    then:
> > +      patternProperties:
> > +        '^mdio-bus@[1-3]$': false
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - realtek,rtl8391-mdio
> > +              - realtek,rtl8392-mdio
> > +              - realtek,rtl8393-mdio
> > +    then:
> > +      patternProperties:
> > +        '^mdio-bus@[2-3]$': false
> 
> [Severity: Medium]
> These two conditionals only reject child node names, but the bus index the
> driver consumes is the child's reg value.  Should the same conditionals also
> bound reg?

No. Ideally we would check reg vs. unit-addresses which would prevent 
anything out of range and/or mismatched. However, there are gaps in that 
checking currently.

Rob
