Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792970395;
	b=IdjU0GSJ++Ed2HoLn1DqvOnv60fd0S07Os67mVc0PO7MJABuQeq+CcFSXMPm/RNthbg0
	 +enc/mXwXa7p4rNC+nEAyk+aup0sLM4W8DdHVVuHchkypCD+sO2O8a6rBp/pLMEfuZKxB
	 MT2dGJDuRMXPzv5m4cUt5SSwPt4HPwH1HflriuM2uk0uvv8d7a/a/VE5wIIKf6ZKwj2gY
	 PyITnojicbQONUO0Ov12EUcFwQLfZRFvnchl9S8Mv8Up9bl/2bkMJiNJJtEBiailPzABL
	 bMtgPi0cXUNNsf5fnFNVHUZLX6lNgthwvOrhovBUANmSsZ3FuscvkdZ322ozD1CE5Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792970395;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=BXYLJY9K1cAyRPcEkZGWWS3NjbVkZ4Vrb3MP3o5lY2s=;
	b=DpOOjyXsG+l9Goslm7oK8x8lDuWzazHQHK+fiHsdDLLGWT1Uv8JVOT7dETFL1OVuQuLK
	 x1tlhebGJ8Jpkb+TIrEs+I2KeRkOQ+WtWEa85LHJTArgC+XhTl/jJm0Kb2jnN0aCjRp2H
	 /lc2gt45TD07hb1iZfSlmiWM3a7oB5mBZy26jrcpm9eVPWAJHtTQBcJkHCjxDa6rDyAqo
	 kXrV8kkhiLNFkjCtE5NlKKmQ6quKB3HYnoV7RL7ti6aEwadRNQYJaQGq77cNs1E0zVrCQ
	 3iWsw/Tj6tXkG9/gDG632tjpec69ngWDgPSkCy+JcqMLcmfWy+tGtnXEZqnTAHERqag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=HLfAQquV;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B68606A31A;
	Sun, 25 Oct 2026 23:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B68606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=HLfAQquV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BXYLJY9K1cAyRPcEkZGWWS3NjbVkZ4Vrb3MP3o5lY2s=; b=HLfAQquVTjqmBqbZcxjCEleMCZ
	UmJ33ObBPuHqBaABeTKe8AsVWsP3s1T2yfAQBDRLO3QpBrvXXvEWMDW5EwSN6zLkQ9cYuidGO7CjF
	RBdKYblXCuYqjYfF1XHU8Hd09zSl37sFb+/rh0KNIPzh74BY61pVc75UrV4E6yFgDd+M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xL7VD-00Cj3g-DB; Mon, 26 Oct 2026 00:19:47 +0100
Date: Mon, 26 Oct 2026 00:19:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: dsa: mv88e6xxx: fix 88E6171 statistics type
Message-ID: <1b33f916-18ea-46d7-b6b2-1f14d3ef6afe@lunn.ch>
References: <20261024182124.296988-1-f.fainelli@gmail.com>
 <20261024182124.296988-3-f.fainelli@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261024182124.296988-3-f.fainelli@gmail.com>

On Sat, Oct 24, 2026 at 11:21:24AM -0700, Florian Fainelli wrote:
> The 88E6171 uses the 6095 statistics operations, which advertise and name
> BANK0 and PORT counters. Its stats_type bitmap instead selects BANK0 and
> BANK1. Since statistics collection started using that bitmap, it has
> written a different set of counters from the one advertised to ethtool.
> 
> For this chip, get_sset_count() accounts for 30 BANK0 counters, three
> PORT counters and five ATU/VTU counters. Collection instead writes 30
> BANK0 counters, 26 BANK1 counters and five ATU/VTU counters: 61 entries
> rather than the advertised 38. This mislabels the tail of the returned
> statistics and writes past the advertised statistics buffer.
> 
> Select BANK0 and PORT counters to match the chip's statistics operations
> and restore the filter used before the bitmap was introduced. Tested on
> an EA4500, where the two-bridge forwarding and multicast snooping tests
> now pass their hardware counter checks.
> 
> Fixes: 5595e3613ea7 ("dsa: mv88e6xxx: Move available stats into info structure")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
