Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544AE212FAD;
	Thu, 24 Sep 2026 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258098; cv=none; b=OS++lMcSO7aMYzaAFrHG+e+Vmx1p0uuCKs92Y4h5sEF+PzkMEtCTylYSkmC/Cp34+u//IGt1AaYRPNuLmRWv0jGdMAjQTsF+ueYAwozQUEOh2dQbKniDZcY2itsGwwSADOEkiUdUwtl8CRwnR+MyazbX1NBi/Y8c0sMXucURQkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258098; c=relaxed/simple;
	bh=bpXMpextMi8EnYTm4SLOO6rGSbacgekZYCskfpV7iKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQDqBARDMv0gshbXk6iTcaz8hKvtV8SQLivrtAvQXlDcZZ3tzS51XrgyRc1ieWk/AUppBbi5N8y6HPB4ox1QYmjAD+NoeEbEgigj1oslTSiqd66bdJLuXt/2fADV710klGBvJ3vtZfSyfXAgLBMzZf9QnalKVPVJXVkrknJ0mr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bTUnl3ie; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bTUnl3ie"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NR2x74T2d0daILuAIZ7PUDHm2Hyr5Iyuia+BWapNE2s=; b=bTUnl3ievtFmo6TPRk5PLgpbLx
	PBdR9xJoV4S/6l3LO8f5j3ESUC9Rq0/+idHl3CBdm+4IeSnSX6+k+Bq/1jObpAklGRY5pmVouLld6
	RkU5sqU60pZNhbFZ7LGtKBfWkxeA0lX7Fh14yQ/T8UPY9MYRGTg1Geh272ing09mo1fA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9juG-0070Ks-TY; Thu, 24 Sep 2026 15:54:36 +0200
Date: Thu, 24 Sep 2026 15:54:36 +0200
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
Subject: Re: [PATCH net-next 1/3] selftests: drv-net: Introduce a selftest
 for ethtool flow control
Message-ID: <fb18618d-6402-4f7d-b318-1872570ceb27@lunn.ch>
References: <20260920164732.349744-1-maxime.chevallier@bootlin.com>
 <20260920164732.349744-2-maxime.chevallier@bootlin.com>
 <20260922194251.06e00e2e@kernel.org>
 <72bdfa09-34ea-43ab-88ad-b3c64c7e1f70@bootlin.com>
 <20260923201051.66e9bf14@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923201051.66e9bf14@kernel.org>

On Wed, Sep 23, 2026 at 08:10:51PM -0700, Jakub Kicinski wrote:
> On Wed, 23 Sep 2026 07:41:13 +0200 Maxime Chevallier wrote:
> > On 9/23/26 04:42, Jakub Kicinski wrote:
> > > On Sun, 20 Sep 2026 18:47:27 +0200 Maxime Chevallier (Netdev
> > > Foundation) wrote:  
> > >> Future ethtool selftests are expected to use the same, these helpers
> > >> are put in the net selftest lib.  
> > > 
> > > Please resist the urge to create libraries.
> > > 
> > > If you're doing this I suspect you didn't even read the README and 
> > > you expect people to search around for libraries?  
> > 
> > I did read the README and fought the urge, that was something Andrew
> > was asking for in the previous round :( I'm ok with either TBH.
> 
> I guess it was Andrew that didn't read the docs then :)

Yes.

I apply software engineering principles to tests as i would to any
other code. It has to be maintained, bug fixed etc. For my $DAY_JOB, i
spend as much time maintaining test code as feature code. So i don't
really want lots of copy/paste version of the same code.

So, for flow control, lets follow the README. When EEE is implemented,
we can see how bad the copy/paste is, and then consider a library.

   Andrew
