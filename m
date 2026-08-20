Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A45385D96;
	Thu, 20 Aug 2026 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787250195; cv=none; b=LklNYJpsUNsLz0LqjyE55Ux81uFR+DcHjdY3GSXU/YYLc8NXbDm0TQYNWjPSTxnmo5pHwgDhAh+YLT9/Kbxfh701Kja6PHg+avAcOKbnixIsfanvPYCn25SNgPHHfrVjhgjAumzWtgsY96Q+C92RjUtl1TANwJLidD36+GQyWBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787250195; c=relaxed/simple;
	bh=Y1YKc+G/llcvOU4yL8//3z97TarFfySFhWKXCttgpwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvTOw5pn8Xm6IB+soj9zyb3mjfJ4YYzKRNSbjV50SiRFILDeeDECkMPxzYouOhJjC63zsjEFXuWaCdTpJ5vvoTp76C7LmvxXgig7JnYN8e3fR+soc20m4E4y3d8V9Y5y+IFy6Sw2TUxuWYO6jhC3rU8ZJryWCKhhNiQ1xCQ75l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nyg9qkxY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nyg9qkxY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9Nh8hM6eGcqmXxNtfKV0SneCiTWL1wMe+cf7+rzKghY=; b=nyg9qkxYvGsD3QOnnlBQS6g/Sk
	eaLIwOvjQGmx8c5NQHascJFd30+hKCgbYCZwB1fghU0LYTw1f6Rw0iI5zSm6tHbfc4ZyOHVIpLZUW
	uA4LoTfIX5zg3nCaDQc4nldn9+ra9siE42pVWsIIQGtJRUsatOWEjlzhR4Y4yZIe0hLg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wx7Pn-000pRp-T4; Thu, 20 Aug 2026 20:22:59 +0200
Date: Thu, 20 Aug 2026 20:22:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xuanqiang Luo <xuanqiang.luo@linux.dev>, netdev@vger.kernel.org,
	maxime.chevallier@bootlin.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, chleroy@kernel.org, linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v3 0/5] net: phy: fix cleanup after probe failure
Message-ID: <d2a16ed7-3858-4e52-854b-279f4c8ecab1@lunn.ch>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <305b44bc-0a98-4481-8f92-b0c18a590b7f@lunn.ch>
 <20260820104636.162a6421@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820104636.162a6421@kernel.org>

On Thu, Aug 20, 2026 at 10:46:36AM -0700, Jakub Kicinski wrote:
> On Wed, 19 Aug 2026 15:33:28 +0200 Andrew Lunn wrote:
> > Please submit for net-next, once it reopens.
> 
> FWIW I'd prefer to take these sort of error path fixes to net
> during the merge window. No point backlogging borderline stuff.
> Any particular reason you want this in net-next?

I don't think it bothers anybody, so does not meet stable rules.

But i've nothing against it being merged now.

    Andrew
