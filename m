Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527C3B7748;
	Fri,  3 Apr 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230179; cv=none; b=dL1h5x/szLTEGhmJ3SUDK1MxhIYgAoCsuyNtZ6LTFA9KTQ5wuyFdKoDGaNwgiwAYiGiIyg1bhASLhcgsxfCNmlQEFQ4IsfcQLeddDd6jZfZlfUZl7TphfQT2jMvWD7ouPOHkOtPU2WK92xD0MFNAARf3pZbhfTKbBESWKj5r+RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230179; c=relaxed/simple;
	bh=948WofqEdvmRhmI3AiY//WYcq+d0J+EFyMtWm7oy+Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IADb0024zMMDR7f6vk5Qu8k2fJmSSqhhe2CH9IJC77WnjB7oYtvP5t+jYGYZBwpDUgUFUyV2uj+DT0owb0U06g6HNWqa6O8tB/hqeKFP0dUX7M+yGUCvuUfcB70HX28BQhqHz6jN+p29bvYsXPDmWIWiewmkqFkFbf28qQ/xzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YqFthxAa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YqFthxAa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ddzJxjKJQU4KzvxxoyzwS63tJ1jgqLlNbYPp2xW/ONE=; b=YqFthxAa6D5M8yEFF9G3WD26Pa
	cTBo927eQrppEAQm4BKrfCBUqw+UMyLd29HC71Vsx/s9CwQd4ehA+y48hvAA8LJ3LnIWPBcOulF7S
	vpT1PoGZxwwAi3dg30NvA3u3LAAji3/nYR5R9lLPZjIuXjQgRRVp7G4qdtgVg6Pj3Jig=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8gSg-00EgKn-8j; Fri, 03 Apr 2026 17:29:30 +0200
Date: Fri, 3 Apr 2026 17:29:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 2/3] net: phy: broadcom: implement
 .disable_autonomous_eee for BCM54xx
Message-ID: <364ecf1e-766d-4219-8724-635072df4702@lunn.ch>
References: <20260403090656.733985-1-nb@tipi-net.de>
 <20260403090656.733985-3-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403090656.733985-3-nb@tipi-net.de>

On Fri, Apr 03, 2026 at 11:06:52AM +0200, Nicolai Buchwitz wrote:
> Disable AutogrEEEn mode on BCM54210E when the MAC indicates EEE support
> via phy_support_eee(). In AutogrEEEn mode the PHY manages LPI

At the driver level, it should not matter why this is called, what is
happening above. It should just do what it is told.

    Andrew

---
pw-bot: cr
