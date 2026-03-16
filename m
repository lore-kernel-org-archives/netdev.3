Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6760359A76;
	Mon, 16 Mar 2026 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703361; cv=none; b=SsmCaSH6Uc90RpYgMdv0E1FBba29v8pjv/o0PXQQXQOWAkNYUrrPibnd/sgHyAlgtEdpsoXDDHZipi/e/g0P71E+ZSjmi6q4A8PmP/MHwEpObWGHbguBtHBUahuRai0cbwdbW91GG6xYj+YwfSRuayxByogw1qTCKvKRsfOVZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703361; c=relaxed/simple;
	bh=cQlrLztk/fNWxwJS7iqCXIHtdzfjmWRGZfLUfKYcmJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=suE2SpZ1tNlMWlx2pEAmJKL/H+iIwjvVx2JVVj7MHtyLiztJp4jHaehJS4AEhGQCa/XorWI0FrE6hf0WyEJDPtSbirWpQJwA1ekHDpu3MOLBz2PG3d52U0Cpx/98vYEq5/GlVKSrxTfwqBTMli0J051HVOBfsUmw87gT3Y/tUlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igNReghP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igNReghP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DA0C19421;
	Mon, 16 Mar 2026 23:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773703361;
	bh=cQlrLztk/fNWxwJS7iqCXIHtdzfjmWRGZfLUfKYcmJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=igNReghPGzZ2+oqgMoDN4fAkoHOEC3ysz9+83AwzVJxAplaxiPUblrJw6LcHHKgEJ
	 tzO7FEFnKokBe9JKMATJBKj0rZ7P67EruGUtYnPJL20dJgTaZ2E35/nfW3HKLIf/y2
	 lywGuS73AgNfiz3GYxFUyCd5BraVdAe5TJ3nBIbdhWBV4EVXaoScnC05fRjzRzG1L1
	 OB1PYKMFaRteOSqEYjXjQuwbVBqXWDdhrCcKpD7m7NMWStImT6S9YuII0ksoXW0Jqp
	 zjDLkZ9Xdz7bYD7d0qCJ2qXfWeB9zRTf5T4B0qqPStbOEXOjuwF4PF2COUK1urByGz
	 hb1jiEltgsBCA==
Date: Mon, 16 Mar 2026 16:22:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, eichest@gmail.com, conor+dt@kernel.org,
 krzk+dt@kernel.org, devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
 robh@kernel.org, davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [2/2] dt-bindings: net: micrel: KSZ8041RNLI supports LED mode
Message-ID: <20260316162240.3e0873c2@kernel.org>
In-Reply-To: <CAMuHMdW7TJoDTYRtca1Y86pVuvUbnDX_x3MUYtvEbgPu915Yhg@mail.gmail.com>
References: <6ccda7a00f250e87b0457e276ac1070cb0708d71.1773321267.git.geert+renesas@glider.be>
	<20260314020107.2241383-1-kuba@kernel.org>
	<CAMuHMdW7TJoDTYRtca1Y86pVuvUbnDX_x3MUYtvEbgPu915Yhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 09:22:19 +0100 Geert Uytterhoeven wrote:
> > > diff --git a/Documentation/devicetree/bindings/net/micrel.yaml b/Documentation/devicetree/bindings/net/micrel.yaml
> > > --- a/Documentation/devicetree/bindings/net/micrel.yaml
> > > +++ b/Documentation/devicetree/bindings/net/micrel.yaml
> > > @@ -54,6 +54,7 @@
> > >        KSZ8021: register 0x1f, bits 5..4
> > >        KSZ8031: register 0x1f, bits 5..4
> > >        KSZ8041: register 0x1e, bits 15..14
> > > +      KSZ8041RLNI: register 0x1e, bits 15..14  
> >                   ^^^^
> > This isn't a bug, but there's a typo here. Should this be KSZ8041RNLI
> > instead of KSZ8041RLNI?  
> 
> Yes, it is a typo. Shall I send a v2 with this fixed?

Yes, please
