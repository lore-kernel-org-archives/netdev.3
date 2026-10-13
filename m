Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7C4F68AD;
	Tue, 13 Oct 2026 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894583; cv=none; b=npBVc3Ic7XmPZn2rM+0JFGPXVmTVJUmh503CQgnTR2ggUjUwOF5KidgDZKJ7MDMKRVFU3Nu5Rzl+LuOMMTXzexLYCoAO8jBTFgL0ySETYGqZ+Ak/YNZIpbmnvnYxIVEeffgaKxoyvuYy0+fdaE1sPQgSS4dW19DSSTqJ9G/Shdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894583; c=relaxed/simple;
	bh=Ks+ivWbh/7ENNKIaKS1rSGhKIOGZmaBTGcBcgYGw8mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qx092JwN52KnmXuGjQnzVwMa/CTjxNAuxiCACP/sy8Ti7AqcGS1pE5RZCDwwVzRzeSJJMA8Y6tVbLX2JOQDJGZ+2sJSKrJ/EoOR8cVN0VDRwKSf++tkqQPaCVOrphB16Jra0BVzIYR6C9ieEPj4nPlRtMvUttcAR28SZty4A4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=D+ZwY1IO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="D+ZwY1IO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Ky6lT0aoZuMFsCpOe/FKT6ESRdNQBRkx3K4a3TZD5k=; b=D+ZwY1IO0GwIvxJpnHzHyIyfeT
	CTnkDZgD4mmbWGyfEEG0PCjF3Vu5aqsqCSmdxntgh8Ogh10ok8tZNbLTxgsoI/RZuTYobtgZH4drb
	zz3KDmYVCHjQYEjvi5CqwcmcUWaKbOZqN6aWOimnpqtsCkZBD1e1100A2y24AKgn8vO0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGbdF-00AWWT-9F; Tue, 13 Oct 2026 14:29:25 +0200
Date: Tue, 13 Oct 2026 14:29:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, corbet@lwn.net,
	skhan@linuxfoundation.org, o.rempel@pengutronix.de,
	vladimir.oltean@nxp.com, f.fainelli@gmail.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] selftests: drv-net: Introduce a selftest
 for ethtool flow control
Message-ID: <60fb2177-a08b-4c98-8242-3fa425c48d65@lunn.ch>
References: <20260925182628.214667-2-maxime.chevallier@bootlin.com>
 <179065239849.434549.14198730559380952270@kernel.org>
 <f06aba7f-0e5f-4c9e-b53a-b5b817b3e6c6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06aba7f-0e5f-4c9e-b53a-b5b817b3e6c6@bootlin.com>

> > [Severity: Medium]
> > The defer queue is LIFO (ksft_flush_defer() pops from the end), so at
> > teardown the link restore runs first. The pause restore follows right
> > after it, with no wait for autoneg to complete.
> > 
> > Can the pause restore be refused in that window? i40e ties pause autoneg
> > to the link autoneg state:
> That's a i40e driver issue :) The tests aren't build around the HW behaviour.

Seems like the AI has not understood this is a test to find such
issues :-(

> > [Severity: Low]
> > This isn't a bug, but expect_pauseparams_set() also accepts EINVAL for
> > unsupported combinations:
> > 
> >     ksft_in(ret, (errno.EOPNOTSUPP, errno.EINVAL), note)
> > 
> > phylink_ethtool_set_pauseparam() also returns -EINVAL for rx != tx when
> > Asym_Pause is not supported. Should the docstring mention EINVAL too?
> 
> Docstrings are gonna be shrunk down as pylint says the file's too big... I'll
> update.

Please do consider the alternatives if the documentations is useful
for those trying to understand why a test has failed.

# pylint: disable=too-many-lines

> > Several drivers fail at least one of the four link autoneg / pause autoneg
> > combinations:
> > 
> >   bnxt_set_pauseparam() returns -EINVAL for pause autoneg without
> >   BNXT_AUTONEG_SPEED, which is what the uAPI describes.
> > 
> >   mlx5e_ethtool_set_pauseparam() returns -EINVAL for any pause autoneg
> >   request.
> > 
> >   ixgbe_set_pauseparam() returns -EINVAL when
> >   !ixgbe_device_supports_autoneg_fc().
> > 
> >   i40e_set_pauseparam() returns -EOPNOTSUPP whenever pause->autoneg !=
> >   is_an. That already fails the link autoneg on / pause autoneg off step.
> 
> That's why we write those tests

:-)

I wounder if saying in the commit message that this test is to find
drivers who pause implementation is wrong will help get the AI into
the 'right mind' about what it is reviewing'.

> > [Severity: Medium]
> > What happens when set_local_pauseparams() fails with something other than
> > EOPNOTSUPP?
> > 
> > The docstrings of set_local_pauseparams() and get_local_pauseparams() say
> > "Raise an error if the return is not 0 or EOPNOTSUPP". Neither function
> > raises. Both just return the result of ethtool_ret(), which uses
> > cmd(..., fail=False).
> > 
> > Here, an EINVAL, an EBUSY, or ethtool's raw exit code 1 is silently dropped,
> > and ret is overwritten by wait_for_aneg(). The advertising checks then run
> > against whatever state was there before, because pause_setup() does not
> > put the pause params into a known state.
> 
> Ok will address

EBUSY is an odd error code for these use cases. I would probably say
that is a test fail. It at least needs investigating why it happens.

	Andrew
