Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403267;
	b=ZcjuWT9ELzHAeeBqXtj/blDkjtAj0WClgITgYHZhde0sWmx98qyCVuDo6iEn6aNbWpcT
	 0OnKY2qMMibVqgKSsyTqG9gUF4LEDKi6yzMda66bH8aBN/lz0RXTS/plSRxxJ5FoibDap
	 lNaWQJ2ZyyNFjyFbXYqlZjEokGdqMhhdaIkIyNyWEmZN2u1QZvpSRTn/+TGF+iAJY7e80
	 eri6Zi3RcdoOvW5nwXkKHo0kv3w3veV95waqGYD5TRKxVBfUfUmkGi0DMArJKrYVbwwfe
	 P8//clJ67IK5ZQ3FpsYKX+VuyTBXvXk6p0umaRRbtmrQlu/MCAjiOdXdMSMPyF5pAhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403267;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=0KSZQK+e3fXGXP/bR6YXqZZOEGql24xZ4tNIbfWIlb8=;
	b=GNB6WyqYf+MmcdGYuncYPxkF4wgGrcMlmvTEu/mEiwpTB+gbCTRvEVoQ1xo5NLCFIK2r
	 rjk61XXDsKtpjZeFu/qKk+mwCZlAhhrVHyDTSg6av3/V29muzjL2EBnV0zBp9OEJ2qElZ
	 VGdXj4KkbLrfChDs4NyMhHE9ZBGCf+PnnJKut48/MgRqZhGVajn+rRgUmFgbGL3aXVVCw
	 nEkmGM/CTu5OFfNVSWtkfh7m/7tuPr0YPLLeNEXb1hVDM0O9UvyG8Q1Fwa6N/ZwyBi7e1
	 kxhrli31qSLIhUCFX5XNq3ID1YQDF8Ut4OySNSvSTeFWABeTLdkDzegh+mCkyAQDn7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ajw94cdb;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F2606A324;
	Wed, 11 Nov 2026 13:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE8F2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Ajw94cdb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0KSZQK+e3fXGXP/bR6YXqZZOEGql24xZ4tNIbfWIlb8=; b=Ajw94cdbSvCUHxyPnYrlgIuGze
	0rC8awMCck7PjIKxCiuD93Epc8gp6vrVgVroQadXM43l/1SXBK8C539vYbuzVOh/q9+YV2RDbA0TL
	SOEz0IeSSukWm5lO4CYpMV5HfC/mg85tLdyfIHa9ywVyF70VY3fMKQ7gtkIcA3Hxi8us=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xR8Fs-00FkfO-EB; Wed, 11 Nov 2026 14:20:48 +0100
Date: Wed, 11 Nov 2026 14:20:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Frank.Sae@motor-comm.com, davem@davemloft.net, edumazet@kernel.org,
	hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH 1/2] net: phy: motorcomm: add led_brightness_set for
 YT8521
Message-ID: <45f91901-bb11-45a7-a09c-db9ed4ef0117@lunn.ch>
References: <598009be-95f3-4091-b3bc-98815c65216e@lunn.ch>
 <20261111065010.2040437-1-amadeus@jmu.edu.cn>
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
In-Reply-To: <20261111065010.2040437-1-amadeus@jmu.edu.cn>

> Only supports forced LED on/off. Forced blink is disabled by default.
> Do I need to implement heartbeat?

drivers/leds/trigger/ledtrig-heartbeat.c

You can enable it just like any other trigger.

I find it useful to know when my bugs have caused a deadlock, etc.

    Andrew
