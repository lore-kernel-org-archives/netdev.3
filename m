Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A55F425864;
	Thu, 16 Jul 2026 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209412; cv=none; b=fSQgMzrxAJ5gPLdr35ZksQITQD8iho9zOf1SSPmpnH7Cqzpdndlp/n+6T43Kkk3inLZKvd4TtEc94ugN/JAmD5pYPRRH0eftUMd2yvNU7KAQRPwwT1BqDL3D0ljHKO0MLS2gfAMXO7rjhetVC8//4BVsjBGY65mshFcyk7guvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209412; c=relaxed/simple;
	bh=aKFCvGcqRuQA3crbvQY1MHZCLZ8pA8MycYHCH2PUSyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvUIj8RmJ2ssgkVZ3r3C9E+HQskDHirGasqF1JzBb1FeS8b7ystqkaMqRNTVfe/gLDmvGFEgqiqV15+zSuQ3DLlXas37i2P+UxHPXJv4U/RFci+qq2Us3JPSNXJeUbyCV94WRwcZCvMHbI4wx7KIaM4KRh/cfJvtBYnRPBOG2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZE4mMMgj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZE4mMMgj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0u4r4MyLXqZXJJZVxOXjWr3X1QHKvpYa2D9w7s3m1KA=; b=ZE4mMMgjyWNbCL6U+cVWOcbZWq
	HfYxyt1L2OeWZPsg28PWMx7hS3cHMUy9+29Jdbq64eXTQJlDpMdmy9+8BQEyTY0bWa0uHmKXUO4O8
	H28TnG45+5uH8N6QTlMmIC1MLD0WpZL6UbhwTSzdfSkce7DWV216E+Tr2QykjfwmElxc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkMMq-00CXWS-NH; Thu, 16 Jul 2026 15:43:12 +0200
Date: Thu, 16 Jul 2026 15:43:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Carpenter <error27@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Michael Grzeschik <mgr@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Yibo Dong <dong100@mucse.com>, LKML <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: net: rnpgbe: Pass an expression directly in rnpgbe_rm_adapter()
Message-ID: <d70814de-30b3-4315-9455-db58477ab085@lunn.ch>
References: <7958e26e-a4f9-48ee-8d79-3797016944c5@web.de>
 <alScHkiC3EmGzOlI@stanley.mountain>
 <8110bb3f-70d9-4f0f-82f2-ffe1262b2962@web.de>
 <aleFN4Z2XT3NP3od@monoceros>
 <85ad473e-b2f5-4458-8973-a643f90eda5e@web.de>
 <alikx3W3NX7r9o99@stanley.mountain>
 <95abcefe-2211-4abb-9af2-7e8d7f4a9b76@web.de>
 <062f9181-e494-4576-bedb-36de488c11ca@lunn.ch>
 <aljdzTZ_f5v6ckVg@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aljdzTZ_f5v6ckVg@stanley.mountain>

On Thu, Jul 16, 2026 at 04:34:05PM +0300, Dan Carpenter wrote:
> On Thu, Jul 16, 2026 at 03:24:22PM +0200, Andrew Lunn wrote:
> > On Thu, Jul 16, 2026 at 11:48:43AM +0200, Markus Elfring wrote:
> > > > In C writing if (!p) and if (p == NULL) are always equivalent but weirdly
> > > > the NULL doesn't have to zero.  It's part of the C FAQ.
> > > > https://c-faq.com/null/machexamp.html It's just a bit of fun trivia that
> > > > doesn't really matter unless you have a time machine.  Even if you invented
> > > > a time machine, the code here would still be fine because we have a NULL
> > > > test before dereferencing the results of our pointer math.
> > > Which expression evaluations would you interpret as pointer dereferences finally?
> > > https://c-faq.com/sx1/
> > 
> > This is all interesting, but nobody has yet explain how this function
> > can be called such that we have a NULL pointer.
> 
> mucse cannot be NULL.
> 
> We call pci_set_drvdata() during probe() and it is still valid when
> we call the remove() function.

Same as what i thought. So while this is an interesting discussion,
please could someone post the real fix, remove the NULL pointer check.

       Andrew
