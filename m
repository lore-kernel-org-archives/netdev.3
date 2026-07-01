Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB74A34252B;
	Wed,  1 Jul 2026 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916066; cv=none; b=pFeqydGP6kNkCPL9pFnX04mKDN0D2Y/Lqdy+MIdDAmrfA1ytpqv7JPHRYRjPePS07y9ywlO7sUXzariw70wZgW50pPJcy1hAn+i5faSJKq+QvdnusQQnVIvVlmq8ZAUk/y0y0QyCcPu9j0j8o16qrz3Vx9WfFzoMn+ltOkMi6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916066; c=relaxed/simple;
	bh=4ACXg25L2qUmFtkuO+CCeMDMWFiZyJTJRNtNPgYpYtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j01AVmpOYQFjiPhqRCAcWdflZe9Hec7Z0ljrzKjDbVoQg4+H6RfvRvxR0Gl7S5E6LT/eah0By03iZ/BWL8WoxhOV2Pfh5F3jmR7bFaOpx+yYW+PfrZdAyHw/QQWj1SNVxCwu0tjyw5nKc9PjhPXiJP2/hq5PMSCvkmeK/xNc7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NU+Elp1H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NU+Elp1H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y8sHsYBxIg8HCHsDZSNktD8E9LhB/IoZ5xG4waVKg2A=; b=NU+Elp1HkzxY6PwwGkFnjIUxV4
	ak8VdjroR33Jhbn7XOstEKgO/EFBEZqAZ6Vfm2CR9AzCeXF/GRnWXD1ikxNk0gdxY+Yblhqixl2Ml
	VvuyAhM0H0ecpLQuvuAzug3uSS4z352Qe8Boyjf5YcoD3NpHGdBaZYK8EWZeIIoyRVtA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wevuM-00ABI2-Fn; Wed, 01 Jul 2026 16:27:22 +0200
Date: Wed, 1 Jul 2026 16:27:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: muhammad.nazim.amirul.nazle.asmade@altera.com, linux@armlinux.org.uk,
	hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phylink: reject unsupported speed/duplex in
 ksettings_set() with PHY
Message-ID: <c3a0e35b-a633-487c-bc08-d62f809047a6@lunn.ch>
References: <20260701031746.23448-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <37005060-acfb-4791-aa2c-caa3710d4450@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37005060-acfb-4791-aa2c-caa3710d4450@bootlin.com>

> I think rejecting these settings makes sense, I'm however wondering
> wether this is a fix or not, as this will change user-visible behaviour.
> I'd err to the side of caution and send that to net-next, but maybe
> Andrew will have more insight :)

net-next seems reasonable.

	Andrew
