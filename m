Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2D23ACF00;
	Mon,  6 Jul 2026 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353078; cv=none; b=n43ouR1jQI3MRcrImOKlPbWVrDYNLK5wcvtTm9AW1y1pE318/4aPb3fqiS4GsnT3T43x4h5iMVaQGk4ko4lg4iUzW/o/hzjrf8Or1Qk+AMzUyisN7Y1zwHdVzVIAmK7NuFqVUx+woYrFKExtvdw7zDp5iveJYcdVZrvkgfYjgvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353078; c=relaxed/simple;
	bh=T8uQDftGeQcVHaybDPXQ+2XVTagwT4Ab1saqKyRZ61w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=okkg7WGCJ8clT4JivJoNRj9ofuqubdHQ8RKbzfVgQZB7BE2S8FKaHzBA9T1lrf3zNZl+KLD389Nxe7xUCQ4a18EXH6yGg/m2m3DfaeudxmFHlVWUadQ4CmYLnKcufXcP0Iu8d2xM3gtDZbAkDnwbGbF0Jr3BoJJVSoNEMxW2tQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6LSFvjSo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6LSFvjSo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0n4o/4/hLK6M+oKVTRlGobXEsnI+F1F/g6UriRBdnP0=; b=6LSFvjSowVG1eU9vkHDXmYgUok
	l24fYGo1SoltygNBKg1RnxMxlWM0yfq7ZZLOYRILkTRKH1H2L0ua+iiF1RJh/aNx63wjnnx5k3v0M
	OAIjtmSlDA2St0AaUYTWUQwQcx13w4Hb3R5na9cXgupaBziCb/gBfYc4OKxN0du4y3dU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wglb2-00B1Be-Av; Mon, 06 Jul 2026 17:51:00 +0200
Date: Mon, 6 Jul 2026 17:51:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Guru Das Srinagesh <linux@gurudas.dev>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: phy: qt2025: Use vertical import style
Message-ID: <c1d24c8b-1c1d-4784-88a6-3cbb519d0406@lunn.ch>
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-2-95a35ddff411@gurudas.dev>
 <d2c1e11e-e616-4b2f-aa17-5eb96f045833@lunn.ch>
 <DJRKZD8LBXXH.MCISM5ZLNVMP@garyguo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJRKZD8LBXXH.MCISM5ZLNVMP@garyguo.net>

> This is one of the quirks of rustfmt. Before style edition 2024, if an
> identifier is all caps, it sorts it after non-all-caps identifiers. The
> motivation was to ensure constants are ordered after types, however for things
> like C45 it is actually a type, causing this weirdness.

How often does the style edition change? Is there a 2026? How much
changes in each one?

At least in netdev, we tend to reject checkpatch.pl patches, which are
mostly about style, unless they are part of a patchset adding new
features. Style patches are mostly a waste of reviewer/maintainer
time, because some actually break stuff, so need to be reviewed just
as much as code adding new features. But style changes have a low ROI.

So while there is currently not much rust code in the kernel, making
style changes is not wasting too much reviewer/maintainer time, but as
the amount of rust code goes up, you might see some subsystems
rejecting such changes, or wanting to pin to a specific style edition,
to reduce churn.

     Andrew
