Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2648347C7;
	Wed,  3 Jun 2026 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780445210; cv=none; b=rPU0KXB6OhTTG2lM6vCzlJT4ILwIoEqdwx2lFFZWe/1s2yTIdXf5pbgkA1I5rU8LE5rrZ6O9COgvm0IT5jORi45dHTyjlQHolLr0S0LHKA5cS+d2anp3wPtE5K6k868t6L5wM8R+kzdYTUYxL/K1cnD2Ie3r5uDbub0dTx3Hx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780445210; c=relaxed/simple;
	bh=LZRtbmZsg6XUZya4eWwAn4B95sUgsuk/qmf+bETbq2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjhoWf/CUhJFFQiPIhV3yKYpfcPmiDOdsQRmR3yXLES4jCIYf/PzYZfLc6PSy8jRI38M+qV8KvCLpryP/ZerdKJSKpOsSUSHip+fOrOh4tbNOq09wkJGkSw/PHMDEbM3V0++G7PHMc4fmdxIMVd91/FNK0u2ifZsSfmZLYfHTA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xoS1dNUO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xoS1dNUO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OHVFGVpvJEXkJP+/BGW7oO5sY9qjknMA9bIgh3KIEW4=; b=xoS1dNUOHzePH+ZuaU2TQciOKZ
	MERT7LBOaBM3T7J9kghLqsvDp1c8IsahKqjrqZA/l6tqXRKVR1+r1X4tpR3zq8/xlGF6xIpgAPOzY
	6rJGjNvyAKisuOLRN6pggq0MpB9VMypm9EjmlvVhIHDF7p7/O9Oh15W6ie6wFJQ6wdto=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUZ86-005mGD-Ge; Wed, 03 Jun 2026 02:06:42 +0200
Date: Wed, 3 Jun 2026 02:06:42 +0200
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
Message-ID: <dd3c9c23-a9de-4505-8e49-97d4bf18f465@lunn.ch>
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

> Posting for review per a downstream discussion (OpenWrt PR #23579) on adding
> the NicGiga S100-0800S-M, an RTL9303 8x SFP+ switch that wires none of the
> cage sideband signals to a software-visible GPIO.

Are they wired to a software invisible GPIO? Or nowhere at all?

> Open design question: this changes behaviour for *all* boards without a
> MOD_DEF0 GPIO, from "always present" (sff_gpio_get_state) to I2C-probed
> presence.

You might want to differentiate between an SFF and an SFP, using the
compatible. An SFF has no need for an MOD_DEF0 GPIO. I did not look,
maybe the code already does?

	Andrew
