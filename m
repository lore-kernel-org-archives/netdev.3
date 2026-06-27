Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27A15E8B;
	Sat, 27 Jun 2026 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782520435; cv=none; b=prmUZQr2NLMzKm2+PBZfgmmirp7+uvsGvT8VzMIKaS6Jw+P3vMtb57d0LKWeZTFdQeOcAv8lBnNEUu9hJNYE1rZ1gnpcs9VZ9M7bLG08WFWMXJb4dnFKNGipZYh5dsoubp1+m243C59amDiEKMD9bHtthWTZhPBu02xJouhjdYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782520435; c=relaxed/simple;
	bh=+C/BEdF6lvGSbTa6keZusmPJ06xp4e8rKbeFlpUaU9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVOjrcMcRmLnVpPMef+rcdkpiYadGek2cl25iI2jFnj1mvYukqRQhtZSonCg46GSPc3bOuEBcKrhJWlVsHO18TJmYECX1w4GfPGc0yX4cxf7RXaknJg7upBf3Olpcx17+qzU3zc79/8kMg9YD4OYA4v4qo+yK9x4UJBAhfppmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtdcYGb1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtdcYGb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F9E1F000E9;
	Sat, 27 Jun 2026 00:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782520434;
	bh=DqPytamxWo34FQ+A8Cpi5CAOtOEoeY+hYNvL/0BWVwo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KtdcYGb1Dj9KVZGqVywnASuaOEud/170EaEWu2Kq935YE17hHhyh3IwddFB7GuBr8
	 L5d/dpQ1bgMPJY94/NUC4G5zGbMPXJslDuYOaSabbTuCQxPQE0+RpJpTf09jLS9hC/
	 BfXaOw3t9OJ7bVBT2V07ofb0lB1hAIklpCSrPh92P21SfxgFKPBJmNoisOpe6BKvll
	 O+gzHmhFED/Ejccfrf5+JeJoPZu3pi6OzJxUSpC3Ugi2BhHNx528G8hyGXOSplPyM5
	 GN3Z0tuiEznjH8cxcww0cTGqGxBNu73/jzx/m7Rb77AIwkX0ppW1YILR/E2UYPTu1C
	 MzdTeQEe2MQCA==
Date: Fri, 26 Jun 2026 17:33:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner
 Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <20260626173352.7dc8f106@kernel.org>
In-Reply-To: <5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
	<20260526172447.10ca4b9e@kernel.org>
	<5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
	<38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
	<58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
	<65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
	<5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 14:39:57 +0200 Andrew Lunn wrote:
> On Fri, Jun 26, 2026 at 10:33:50AM +0200, Maxime Chevallier wrote:
> >   
> > > Sphinx follows pythons object orientate structure. So you could have a
> > > class test_ethtool_pause_advertising, with class documentation. And
> > > then methods within the class which are individual tests.  The
> > > commented out section would then be method documentation.  
> > 
> > Good point, so maybe something along these lines :
> > 
> >  - A class for the test
> >  - methods for indivitual tests
> >  - For readability, I've written what the internal test helper would look
> >    like (_adv_test), and how a test would look like without the helper in
> >    adv_rx_on_tx_on().
> > 
> > I'm already diving into coding, but it helps me a bit in the definition of the
> > "description" format :)
> > 
> > this is what the class would look like :  
> 
> I like this :-)

This is very far from what existing python tests do in netdev.

I would prefer to stick to the "bash on steroids" use of Python.

Are you both familiar with the existing tests?
