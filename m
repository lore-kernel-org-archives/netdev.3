Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CA526A0A7
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379906; cv=none; b=F8xmrdf901i8O54EWLpfxUzxa8QHK4Dm83n6m8wrLpBLoZVo8zXzd54CLnoXcMh5OJGqswxjljA4FRgIp5KKYqF5umOZIxA2UveKSgq/pqo0HPsNSn6Lj4uLb47sNejNBybSh+v+KlvXwv26gE4BYtKV8xmYOXWgPKdgPFRwJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379906; c=relaxed/simple;
	bh=H3EDIrUom8KA6OBFkKWjdlEathG2NZlmFX7R93DaBd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9ZMfpqXwIYAMy0kP4H8yEQxh6kAZ+F/Oz66eq1j/y4XV+F2YowoOFZ9a6iO/vJMI/WyVzzlVmWiBHODXJSuzMuxrNHWsipruBxVG03qnMlg44Q5Qe9r0IK/OGN/3bYg7PoYQqyrHQibeqVVETJmfW1P0Rxryz5yIVmmbQqiYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=djATsU9W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="djATsU9W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Cs7ic6YzFtFMLAqitAFOuEijkQNtWLGZgg6XiVGz0GA=; b=djATsU9WKEFgZi5RLJ6fHO/JKp
	9SiKuXvu+A3pwjMhoC2XC2rf3OHNjYAF6UcCmwNdcaiVtRWFtL7gOONom/8b/JMKCNSate0FUvBjq
	bfe4IlvLEFefhGeQZiVU7Faz0L6+/v5Wi68lDgcK8bvioiVfzHWxculeVHaHPHasnj4s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w57Gf-00D9n3-Tb; Tue, 24 Mar 2026 20:18:21 +0100
Date: Tue, 24 Mar 2026 20:18:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Wagner <wagner.daniel.t@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892
 support
Message-ID: <5ff11a7f-6f92-4488-8138-9f8d6210ae30@lunn.ch>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
 <acKypS845fm_GB0o@shell.armlinux.org.uk>
 <CAMsLQxFnhPT5TLmwQS14rrgD8xmgs6ymH8Q3ee1KcSqm1XEstw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMsLQxFnhPT5TLmwQS14rrgD8xmgs6ymH8Q3ee1KcSqm1XEstw@mail.gmail.com>

> In that case let me drop LEDs from v2 for now. The hardware is a single
> bicolor LED (green/amber) with speed-based color selection (vendor firmware
> does 10G=green, else amber). I don't immediately see an obvious way to express
> that in the LED framework. If there's a good example to follow I'd appreciate
> a pointer; otherwise I'll figure it out as a follow-up.

That is why asked about its capabilities.

The minimum you need for /sys/class/leds is to be able to turn the LED
on and off.

What sort of bicolor LED is it? 2 legs or three? Are green and amber
mutually exclusive, or can you control them independently? If they are
independent, then you can represent it as two LEDs. If the colours are
mutually exclusive its a different story.

Oh, unusual, there is a datasheet:

https://datasheet4u.com/pdf/1561522/BCM84891L.pdf

That is not like Broadcom.

The LED controller has what is needed to follow the normal way of
doing it. So please do drop this part of the patch. For examples, look
at any PHY driver which implements .led_brightness_set and the other
ops in struct phy_driver.

	Andrew
