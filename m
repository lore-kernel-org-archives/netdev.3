Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0859578F26;
	Sat, 27 Jun 2026 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782604017; cv=none; b=FIBY2R6pal38dB0FSC0u3Ec1K+0/c4mDazQh7GM5D48xvDVb3/DWe2/Wt1030vNAj8tM4qlZLOcqlruZ6bvuQhSpq+y78BIAf6JJ5S2yc9gcr3cy4MgyXygxbb0L6P7yomydlM6c8iBRd9Yf0rG6omzwNAUF3TKhrBuoIwbA39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782604017; c=relaxed/simple;
	bh=0BgutQrxdo0WBm7uLd0I0f5fTxu1d/Bd/eheu73268U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfZ7S+t1+cBt0ocnf+rC+T8nu7m6QxDQRr0SzPrszX8lvShLf3/UaJwQRooIwx+dmvgMnGvKr51kwOwr+rFG6sTPHOrSJZ09+HoU+3fscgdUmG5s/j8hc8OivoDyLoCx5JqOKOJSiKDCWLBCXRZqTSyyu7QJ16z9V9ygVkLYYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xb2AsLYA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xb2AsLYA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=45H8N/PDlf+7m9SmOhmiRitaV8mLGwzcFX/BKLhJgVI=; b=Xb2AsLYAcvqdQxOnoSkgF5aawA
	hUAHREyhw7MNUGU5iRUCXjce1cDO9zgymqLkBpSLS+Y1my5kCZqd5M57AB8c9RMnSIykmFV8nhe2e
	7gWMFcae4nkeNbZvoPWT9fUdXJPadwM0PJScJFG3p8TiA+FQFNc0lJVmQHX6KbySUQtA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wdcjF-009XGt-89; Sun, 28 Jun 2026 01:46:29 +0200
Date: Sun, 28 Jun 2026 01:46:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
Message-ID: <3b8abe17-5da7-4a7e-a42c-eb39a631843e@lunn.ch>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627143028.5afed23a@kernel.org>

On Sat, Jun 27, 2026 at 02:30:28PM -0700, Jakub Kicinski wrote:
> On Sat, 27 Jun 2026 07:34:31 +0200 Maxime Chevallier wrote:
> > > This is very far from what existing python tests do in netdev.  
> > 
> > We can probably drop the class, as it is with this discussion, it's merely a way
> > to regroup doc common to similar tests. The rest really is the usual set of
> > ksft funcs you can feed to the run function, with a set of ksft_ethtool_*
> > annotators for generic checks.
> 
> The common way of checking prereqs in the tests is to call a function
> called require_xyz() which then raises a skip. At a quick glance - the
> rss_api and xdp_metadata are good tests to get a sense of the usual format.

The counter example is the ksft_disruptive() decorator.

Pythons own unittest framework makes use of decorators to skip
tests. Its the Pythonic way.

	Andrew
