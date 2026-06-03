Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881DA223DE9;
	Wed,  3 Jun 2026 00:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445760; cv=none; b=l7nP79C4py7f8PKIrHIgJuqd1L8jzWXLsAxTwkNKHDDLUx3aa8EwpWF0zKkrtqYctf/cIHQMCj9Z9TjsbKaMNIFYZWzd87KRD1QD4BOIYryw2mYQbmJ/y1pynZCwkAATaS0Vipd0Q5pTGFxRKx6vTV+qbSUfPOSJ6sFY5gMhCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445760; c=relaxed/simple;
	bh=9flrw53HNgG8jcIR9SckLbImG0fNZXaaC4jde+qluCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnqG5CaT0vtgCXftSwwFuPFyjAeIG+ICQDcR9i6c22IH6KberZuhv5ruj+uaGKbwba0w/oslFlVbHOwgW1yF3y45/EJUxOd5hsviE7KEo4We9hcsx+KyZel2w2DmM+QdFYg+jGsuCdk2gPRpga7pXGW9FGkRhMrDMc2SQi4ySfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pw4zxjhT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pw4zxjhT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WyLvf9bqb1QFIVpJ/5XsqBvvssIE6x5Mu3bV8kLzoug=; b=pw4zxjhTJ8SZ2lNyPM0MZneYWx
	3VtctziaWRv91SEyhJlRnF1MaOL5k9INUjIzxj6Gp1M35aODEjpb6XhsF+WtN4dHT7keObBbMLGBh
	9aaMuCVqq0ENsZerthmjxNJynfzrWnIX4+EZmh8+s1NhBibvXA79fhpzB2/bLcZ8sMxQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUZH0-005mKN-BC; Wed, 03 Jun 2026 02:15:54 +0200
Date: Wed, 3 Jun 2026 02:15:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Patrick <gregspatrick@hotmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1] net: phy: sfp: detect presence via I2C when
 no MOD_DEF0 GPIO
Message-ID: <193b3aba-fc64-45bc-81bb-ea248efa9c3c@lunn.ch>
References: <20260602235528.2795028-1-gregspatrick@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602235528.2795028-1-gregspatrick@hotmail.com>

> +/* Probe whether a module is physically present by attempting a single-byte
> + * I2C read of the EEPROM identifier (an empty cage NAKs). Used as the presence
> + * source on boards that do not wire MOD_DEF0 to a GPIO.

Did you try a 0 byte read? That is what tools like i2cdetect use.

	Andrew
