Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505181;
	b=r5Q5RqnrgPJ7pI6ZlHpPH097nK1eSfKNRRVl3JUX3eFQB1bMKTFckttkJDQrzOybApaq
	 aVhMJpkLyQFN8AT0NyCleE/B6VsyNjU21HFXEernR3aEXTsKqP/DDwebk3FSXqNYF1sPN
	 sYf9+Yi5z+WPwzuvRgshfGjsOREM4XxlFzU8HLLXAXuKb400AouUYfWLbYHAP4mN99vOn
	 2i6WuMNxU50lNnXtIJKgU7iPKbxZ2YhoeUxcnspg58ejk6/k9HEO5+F6FAxw4x3GBQWRj
	 cSK4RmAhp7Yb2ZtJ93zokQuR8i7Hyknh2DT6u5sn6w9soZYpQ0jfatAxtwi6UtQVSOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505181;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=gBPuTVDgEiGC7gv3ImQ1lrlNU1MOvL9EhgW5csxKSjA=;
	b=Iw72ESx8D4Y6PzbGZcU7o21p6Ej0Dp+ibv1zm8hxvXI9ivkkF89heNzzy4HEsZznTmx3
	 EawzWXD9m6RfR5zw9EPQl9H3OrqX1//L95O9+x3hu6qqDyMa1IEUBXNsXIUY4EOejuu1Q
	 m6cxp+79ODOWaAiyZryiWKXceun1EUUmi+Mt7RqpPvdBqMvI/+wP0Q7j7rmAhRI0x0YMJ
	 emqZzGp6yEwlvD5k8JFbn2vGOTmy6wXULomClRTn5CVh98sSImF8pMKzixKDc/lMyck5m
	 2vOeW9Yhpqkg0uPWTQ+GW2ropVa+4gfigiZUmirnvUF2peNHy6zYIeoDgkhm2+uZxew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="K/dtBbdT";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F1606A334;
	Tue, 20 Oct 2026 14:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 573F1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=K/dtBbdT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gBPuTVDgEiGC7gv3ImQ1lrlNU1MOvL9EhgW5csxKSjA=; b=K/dtBbdThHETNk7iWl4Qtq6Bz8
	UVUwNm2oLf7CLYIU+sbuB522PSdkJff8BUpIZvY7iTTuepaofbkQ+GTxmGLi1sLELuYhcbRMmOc0V
	mUghmsGFwb5E9VIm2x//0ShsytGdaxl9rfXEN3rVGOfh2sJ/f3yj9DUKjtc7zzJ9/hDE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xJATh-00BrYm-S4; Tue, 20 Oct 2026 16:06:09 +0200
Date: Tue, 20 Oct 2026 16:06:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, lxu@maxlinear.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, lgirdwood@gmail.com,
	broonie@kernel.org, michael@walle.cc, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lrosu@maxlinear.com, luka.perkov@sartura.hr
Subject: Re: [PATCH net-next v3 3/5] net: phy: mxl-gpy: release MxL86211C
 Super Isolate
Message-ID: <3a43a496-42ba-467d-8771-a777be5d0e42@lunn.ch>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
 <20261020093655.344585-3-robert.marko@sartura.hr>
 <21892f3a-8e0a-4c72-938c-b2e77b9f0dbf@lunn.ch>
 <CA+HBbNGLc+imr9geBVSZthromLUCBTbC-4roVuz7SM2PdYPfuw@mail.gmail.com>
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
In-Reply-To: <CA+HBbNGLc+imr9geBVSZthromLUCBTbC-4roVuz7SM2PdYPfuw@mail.gmail.com>

> I think that Sashiko confused me, it claimed that PHY HW reset could
> happen during interface up/down, etc, so these would be lost.
> 
> Is that correct?

It is easy to put a printk() in the reset code. Just make sure you get
both. There is MDIO bus reset as a whole, and individual PHY reset.

Also check out suspend/resume, with and without WoL, if that is a use
case you are interested in. It could be suspend without WoL might
cause a reset? And if the board actually powers the PHY off/on, i
assume the strapping defaults are reapplied.

      Andrew
