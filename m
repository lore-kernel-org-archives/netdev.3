Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF6391855;
	Mon, 29 Jun 2026 22:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782772827; cv=none; b=ZOjb3OUkNPHnr3MHyXcEg1Ywel+M656l8Zb3nKBuQMbHrnqyNoBSJOPbmDKLfN5CAoPsFeMmwmpRRjeriWYGVaRGHTrnQX5ASJqles8CoI0x63zVRA2QtjcFM2CnWD3fT2sYFLtx3X08YOIEuRZMZCiEEobWkifkwwezbqfFCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782772827; c=relaxed/simple;
	bh=dPZ3segv2FAUEfe6M9Awn0cpqW7tus+ys1U4WhpcUyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPXS+5v9GUMYyXov/XCTZhaQG3cbb89Pa8jKkdKeW/kEawRtZWiM1+S2ri/tnY3sULsxMh+ZGxqPFbSh8RpyqLhn/2yWvVQUFCQizBHoGtYOBHLr7cY1HT6KvFCKQomXt3j5jBxHonQ5yJD1XXbAKd/dUCvFXzZoiSEGXyiqliA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0CggxJv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0CggxJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE4F1F000E9;
	Mon, 29 Jun 2026 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782772826;
	bh=415hvTDl6HOVAKxexnyqVh+Y4i8kKG1abfryN7EQEiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R0CggxJv9p3Sttd5H4gaQXOAKmn0OOGkjqSgCvUbYI/wg/0skGxuvU2kgaR1qgtH7
	 XEEkTD/CzHhb8WzRlT4n6VtB5ghdvZT+5tPLalrggUMWjRuW32mySe4V52FFZRzaRH
	 0KWJpZmoJDnmc3xcXghEXC0OY69OEilsps8uJSGB7uwkUrjMtCCAVcOfQrqnu6BGCh
	 EUHmb+a39im0lMrnQXbBw3GuNbh0tJGV0ZbON1hk5EmP/A9UHBQWZDrcGxkuuvsxMo
	 19L74gFt2bVfhFbPjkfZ9gDCa32BctTOzBP30Eu2H5IFA7Bl1XVDCo3VmeWdi/Am9E
	 mUgtDY8VU6oCg==
Date: Mon, 29 Jun 2026 15:40:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <20260629154024.1aca45b0@kernel.org>
In-Reply-To: <01e3d32b-6d50-4179-8e2f-25cdf8ff6c32@bootlin.com>
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
	<20260526172447.10ca4b9e@kernel.org>
	<5cb8e2b4-8eb6-4446-9b90-1cd4c7964cd9@lunn.ch>
	<38bafe7e-d419-46f7-8fa7-87e9183e578c@bootlin.com>
	<58f37d6e-973b-4242-be82-0561ccdb1a6f@lunn.ch>
	<65d26fd2-fbb3-49cd-a9ac-07863d9a8909@bootlin.com>
	<5b7dbdbc-93fd-4664-abad-0f47855fab55@lunn.ch>
	<20260626173352.7dc8f106@kernel.org>
	<12b66ea3-42df-4ecb-8eb7-44471407b83f@bootlin.com>
	<20260627143028.5afed23a@kernel.org>
	<3b8abe17-5da7-4a7e-a42c-eb39a631843e@lunn.ch>
	<01e3d32b-6d50-4179-8e2f-25cdf8ff6c32@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 17:24:51 +0200 Maxime Chevallier wrote:
> On 6/28/26 01:46, Andrew Lunn wrote:
> > On Sat, Jun 27, 2026 at 02:30:28PM -0700, Jakub Kicinski wrote:  
> >> The common way of checking prereqs in the tests is to call a function
> >> called require_xyz() which then raises a skip. At a quick glance - the
> >> rss_api and xdp_metadata are good tests to get a sense of the usual format.  
> > 
> > The counter example is the ksft_disruptive() decorator.
> > 
> > Pythons own unittest framework makes use of decorators to skip
> > tests. Its the Pythonic way.  

Problem is vast majority of our developers do not know "Pythonic" ways.
And bash tests for HW are an absolute pile of impossible to debug
dookie. Half of the time bash doesn't print anything when test fails,
so good luck figuring out what happened on someone else's setup 10%
of the time :|

I'm hoping to strike a balance with keeping Python relatively dumb,
and pulling as many people as possible away form bash.

> So maybe in the end, we can try to have something a bit less python-y, while still
> using extensive documentation using sphynx doc format ?
> 
> Let me send a V2 with the full test list, we'll see how much scaffolding
> we can build for ethtool testing, and how. I suspect that running/skipping based on
> the device's capabilities is going to be used throughout lots of tests
> beyond pause.
> 
> For now the important part is to get that test list right, and iterate on the
> test implementation once we agree on what to test, why and how.

Maybe we should step back and figure out the full story for the
self-documentation thing. The good tests under tools...drivers/net
already have module and test-case level doc. So we can come up with
a way of extracting that and weaving that into NIPA? That way we are
all on the same page?

How should the test info be presented? I think it'd fit best in here:
https://netdev.bots.linux.dev/devices.html ? Or do you have something
else in mind?
