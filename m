Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B5339380;
	Mon, 10 Aug 2026 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383364; cv=none; b=SEVpk2Zp9g6ZtDd7hWdX8LvTOb0zs153vA+kTsKrXAgJVXusEWxVuKA6re21YCuqyfzNcUuC5XnRFMNP2syo8/Dptk4MepIXETqkIeIqYyvZH6reCFI3PmAePgdr4kQdpGj/2PFBKFR6Kty6xPBIvCYBXSrO2aBDewVSknPgK8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383364; c=relaxed/simple;
	bh=K6EWAEJezE3jVhwMfkJzv9gx9dVGv6vtUZ+nLTgS+Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOHtTy76OtqSrU+tE92OI+E2r7NzmMEP3V7CbTXWqUS5Ctt3T5ElH6D8YFF+rs71GwvdAC4fJ9d1t2YObYlYa7dzGzf1Qs54uVY5wXDF/rvbgIT268Y4OhvN1x9/FVM3C9b1BXvxK6dWbU01iA+1P37hRc1f955bf1bdz7Jnqnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=30mWfu7u; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="30mWfu7u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zn4VQmuotBpmLN+M4aouGi71z10fZOiTXnJCrsxOzMc=; b=30mWfu7uMXUw49PpigbtG7v+r/
	ttjCVYB8jbF1X+n50ewmUxQGYrJhwbTxdyMJPGryMuktjntYwyYpc8Rt9IiNXhhkMVujU5W2+TQQX
	sHukpUYE0pMACsWl/ED8rNKy++ciRYg7JqJHmiIlY6wHzYr1zMCHwbcY6JMV2fprTdMA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtTua-00GxeV-4X; Mon, 10 Aug 2026 19:35:44 +0200
Date: Mon, 10 Aug 2026 19:35:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Jianhui Xu <neuromoments@gmail.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux@armlinux.org.uk,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v6 00/13] ax88179_178a: Add support for
 AX88179A-based chips
Message-ID: <11b179af-eb30-41bd-a110-a5d3b036d3a0@lunn.ch>
References: <2eeb01b5-7d3d-425e-9865-4e2fe1614e67@birger-koblitz.de>
 <20260810013549.2510969-1-neuromoments@gmail.com>
 <5b2c4498-2e3c-4ae6-b078-deeccf8b7a5c@birger-koblitz.de>
 <60e05662-5f0d-4b2e-9646-f7d42e04ef13@lunn.ch>
 <904f166a-b3c4-4579-9614-6ebe3dc18277@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <904f166a-b3c4-4579-9614-6ebe3dc18277@birger-koblitz.de>

> The device has LEDs, but they are entirely controlled by firmware. The behaviour
> can be configured from the EEPROM. Writing to the EEPROM involves stopping
> the firmware on the device. There are no temperature sensors, or maybe there are,
> but the firmware hides them from us.

That keeps thinks simpler.

> There is no physical access to the MDIO bus, as MAC and PHY are in the same
> chip. I hope that otherwise we are safe from firmware interference, though.

It is the sort of thing which you find out in time. As you have seen,
there can be race conditions, and there could be issues hiding until
specific timing is hit to trigger them. But there is little we can do
about that, so lets just go with what you have.

      Andrew
