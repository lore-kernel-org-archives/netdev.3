Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F91330330
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996034; cv=none; b=GWrEiSpfS9enhcC0iAg9Czn0b3Nf4XGm/plwFXXdICgFnYtrxS1zGEHhBpseNVGbs/+CPMYt47GPasbXX9xXecPXQ9SAzS4FZxhFLiGT+eNoHIdcEXHzVclvxPEDNLxIal75WLdC5JJCWh6YMVk6h0+IFo7qJK7f3wdmhOi9aIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996034; c=relaxed/simple;
	bh=BaYU7E/e2f/xOHSPRCx454NSYL8AOLLmDE0umlyvslc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldRnIPwuLM0flpAdkWVaqOYUphZ9/W94njblbEerMchZkuo4OwGO0RnG7cPXCgS7oVofcj5WLjTjWw1CDympBvcdSgHhpdhHlkUz9Du96WIYPIxLs6ylgW0tlD9kl9m9Oguf+Bkvlwm3Ro6gIwNgWEILw+3rBAAAUD7b0pA0T0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2No3U1c7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2No3U1c7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/Mli6TEl+h/8mSKgzE+JMWrFzTXlw/67o4a9jrr7Sng=; b=2No3U1c7jD2PblF9RM4mbgTi0o
	QhDrnTsQWkUswA3zkDWy3P14UZD8krss/kQLJv6BogcJPab6OlOjOL8SL5pEt6yCVVC1cX+Vy2J4D
	zD4fLnIyAFq4s+36+HP53JLvi0WviozHqDkYdLe50E1yq3TqWGu8xNMxcuzHnwBA/lfY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSgH3-004xAO-Cl; Thu, 28 May 2026 21:20:09 +0200
Date: Thu, 28 May 2026 21:20:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH V2 1/2] net: phy: dp83822: Improve readability in
 dp8382x_probe
Message-ID: <5aeb4f1a-221e-4977-a024-9e08f5fd0b04@lunn.ch>
References: <20260528184642.33424-1-wahrenst@gmx.net>
 <20260528184642.33424-2-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528184642.33424-2-wahrenst@gmx.net>

On Thu, May 28, 2026 at 08:46:41PM +0200, Stefan Wahren wrote:
> Introduce a local pointer for device so devm_kzalloc() fit into
> a single line. Also this makes following changes easier to read.
> 
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
