Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8E1EE7B7;
	Sat,  4 Apr 2026 15:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315496; cv=none; b=qhXZwqBZti4sPF5twlGdBuTM2AHpft6ODmBSPNaFl+a2hvv5Rg/NvTAK6OQQIsyaAhWAYzEYfXwhH+o63i/2T/jpb/Ilv7fcbx3dvLdStCDejBaCsM8OsWhMpD7yxjg2xhIfWmGMxXAU7PFD83bkp6NLN7XoGc3BfR7/yI0Mrto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315496; c=relaxed/simple;
	bh=JFg+44ZtlWadw8GbNvgoAXXoEWp0PXVcexgx1yrffhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAhubwJ9qXABw/XZsBFeYDTaX4hbqBV86cH4pUySR3mjOWgt9sGl3oLmzIkSRGulBC05eKaD4VAI8GO+3TyWG1ouKGm1u0nFeHsZjJa2VgIE3u5q7V5r+qYXypHuAmsPahzsfr45BV4H2m5KwzcDWrA7u+ZYEgkaO3sUJkP43+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RcBbY4XS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RcBbY4XS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=rJ2Kz5fyYhZ/DoR3804kQI8bTPhgJbRYVJqu/wtU9cc=; b=RcBbY4XSPXTsX4qvkUK+SLI4Ys
	36V+j+E1qfvnCocxs6uc+H8UtQduvIa+KMDjnED9Dg2HNsIvVe1ueOSyHs10b8r7V8TwDdEWttZJN
	mKJGWom6xjLNwE7vnPODoGdnSWzoZxcCGAhei2ks3iWKTNMxVf9VJdqJHWgHqebUyKHo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w92ej-00Emxv-9E; Sat, 04 Apr 2026 17:11:25 +0200
Date: Sat, 4 Apr 2026 17:11:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next v6 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
Message-ID: <b2db9800-2c3f-41ce-a7bc-b16734724def@lunn.ch>
References: <20260402-rtl8157_next-v6-0-a9b77c0931ef@birger-koblitz.de>
 <20260403160608.04f2408b@kernel.org>
 <741bde66-45b7-49e4-88be-7fb1ca8a92df@birger-koblitz.de>
 <2026040421-kite-ethanol-2e28@gregkh>
 <23860a3b-5c89-42d8-bf7f-2f77f35cf14a@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23860a3b-5c89-42d8-bf7f-2f77f35cf14a@birger-koblitz.de>

> Thanks for the feedback, Greg!
> the underlying issue is that parts of the patch I submitted are now also
> submitted by others, and that gets fast-tracked. This has now happened twice,
> and I am being told every time to re-submit, without efforts to coordinate
> this, or hints that this pattern may stop. This has somewhat made me loose
> trust in the process.

It is somewhat on you to coordinate with others working on the same
driver.

As is often said, Maintainers are overloaded, and push whatever they
can onto developers. It should not need a Maintainer to get developers
to coordinate, they should be able to do that on there own. Since you
are subscribed to the netdev list, you can see the patches flying by,
you know who else is working on this driver. Please go talk to them.

    Andrew
