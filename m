Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEF643D4F7;
	Fri, 11 Sep 2026 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789127228; cv=none; b=LK+MKidnsKPypBFgUJbPYFQqGRBngBqugeJRMC1qTlR1PGMXGFG2yVRr6RKuENEfGNPGA0Y6o8xdgCTBwxT/6dsOVcAq+c2wLCmhViz4NicxLRJ4y8Lpl1Cf+X0vDYblJmba9Xl632O7cRuV/LorVWL++ibAxnkWCA7JwtN27eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789127228; c=relaxed/simple;
	bh=Qogs01YpZShm0/GXSyhaulSMfHxKylKvvQaBMm9Khu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLoxsaUVRRw7ZaHaUl6FOJsT/6RwWvKmB8F0VY8/QQsmapq8t461TlrwwBQ/3VLOYYlTt+i0R7yYYX192OSp9PmLdhG+Yt1CaT+sgXU3L9SYoPgbXKHR61F8Y9ArGjtv3y9hmsELNaurLElYD4ODhS8plGNaG34ncy7YqLaAANY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5ekdaGoW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5ekdaGoW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=bXmVFEys3cXBY1+wCAiUJyO011XYfpjfHaUknc567eI=; b=5e
	kdaGoWoCsTLq4rbzRN9A2gWIXfoYEGgNZUwML4BeRBhFEvCeenGp6p1l0u18n9bPZB6MejJEbWFW8
	ie6hczylNin913Y9MdNDPcxRiwbifAffdMrN36os3HM7Od2uY6IQwKWRP9FuNb+AzCB4AxmgZBLdO
	+SHAt/YhDzSRd2w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x4ziU-004gFy-Ay; Fri, 11 Sep 2026 13:46:50 +0200
Date: Fri, 11 Sep 2026 13:46:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/7] net: dsa: motorcomm: Split xMII and SERDES
 port masks
Message-ID: <39ddc2cb-46c9-4754-99c1-0011a4cfdb7f@lunn.ch>
References: <20260909190541.466476-1-mmyangfl@gmail.com>
 <20260909190541.466476-2-mmyangfl@gmail.com>
 <40e425e2-7d0b-4e20-9880-41e46ff340c6@lunn.ch>
 <CAAXyoMPG6s_z3g8fZ5CAF8BJa0OY7uzzO5PccaR6amfmYrYYHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMPG6s_z3g8fZ5CAF8BJa0OY7uzzO5PccaR6amfmYrYYHg@mail.gmail.com>

On Fri, Sep 11, 2026 at 05:37:45AM +0800, David Yang wrote:
> On Fri, Sep 11, 2026 at 4:59 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > >  #define YT921X_PORT_MASK_INTn(port)  BIT(port)
> > >  #define YT921X_PORT_MASK_INT0_n(n)   GENMASK((n) - 1, 0)
> > >  #define YT921X_PORT_MASK_EXT0                BIT(8)
> >
> > I'm i right in says YT921X_PORT_MASK_EXT0 refers to port 8, because of
> > BIT(8)? And YT921X_PORT_MASK_EXT1 BIT(9) means port 9?
> >
> >         Andrew
> 
> Yes.

Can we give these better names then, YT921X_PORT_MASK_EXT8, or
YT921X_PORT_8_MASK_EXT.

	Andrew
