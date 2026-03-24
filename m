Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CFA92E
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382514; cv=none; b=Gp/kxIlkjIIwuBR/EEr2bKS7aVzKUI0ZZ4UT/p7KQ4gbKLnEBZ1IYmIwUycOXsvnuUsTgZuiy3gpOhLi+DKyO8saGdvsTcakzdmVDKH8GDIniuqttRPQnyrqGkKWre7czWi5qsrugP6L1BQH5JhLdlmBQjd7sIcXYwUzDWLDO8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382514; c=relaxed/simple;
	bh=U4D0yy00AXLSQ6j9F6hob8qUa2ikBm2BvYIJXs2GqMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9fFOc0+p7fzm4Nldd9DJZKF6cwZ/vrO6tx0sPR3BLTDeXYh72sfokhhek4wnjPs5nz/psESKdE/0IIQNoxaBS7pXkQv/5zexhgmbbgFXQ8PS17vs4XHd0UfyizGGzYIhANsvgiYjVWuLdY5kioUCEIxaObahNTUV33K0gMl0sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=JuGIB/+S; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="JuGIB/+S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c5GVfe8+yPkMkVbCYbMZVYNqV0uEZmVD4L1MoitfobY=; b=JuGIB/+S2tdxtTBlXTI0hQ3e1w
	iSvEi3in7kPZn92hJwbOcR52ism+apTnhhXD9dhcrxjbIt2UGw2YxNyT2silqG6fvlbCsmbVwNJat
	42/m5MbfYdK7kJ796ii3f+7HNDK5FPyjPkQOe3Khrg5v/999vYpBzeM4Q98nHiB7YCZDGb1pQm/hb
	WhCQN04Y8vvAB641CRlQuxMRej2f3kNeZl5QGLHCxMjhtekTcaAjTgsGnpaTwgsk0m9OAgqXj/xij
	8uuJxk9XQMFnYjibAPqm3m6N7TqvigluM/mL7yup5Q7M6srMLC5k/RSgiTRy83e/X25iPEffALHH5
	bP+mLvKA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44180)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w57wj-000000002Zr-2zMN;
	Tue, 24 Mar 2026 20:01:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w57wi-000000005Kp-1LY8;
	Tue, 24 Mar 2026 20:01:48 +0000
Date: Tue, 24 Mar 2026 20:01:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Wagner <wagner.daniel.t@gmail.com>, netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892
 support
Message-ID: <acLtrOrZe0G89MBy@shell.armlinux.org.uk>
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com>
 <acKypS845fm_GB0o@shell.armlinux.org.uk>
 <CAMsLQxFnhPT5TLmwQS14rrgD8xmgs6ymH8Q3ee1KcSqm1XEstw@mail.gmail.com>
 <5ff11a7f-6f92-4488-8138-9f8d6210ae30@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff11a7f-6f92-4488-8138-9f8d6210ae30@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 24, 2026 at 08:18:21PM +0100, Andrew Lunn wrote:
> > In that case let me drop LEDs from v2 for now. The hardware is a single
> > bicolor LED (green/amber) with speed-based color selection (vendor firmware
> > does 10G=green, else amber). I don't immediately see an obvious way to express
> > that in the LED framework. If there's a good example to follow I'd appreciate
> > a pointer; otherwise I'll figure it out as a follow-up.
> 
> That is why asked about its capabilities.
> 
> The minimum you need for /sys/class/leds is to be able to turn the LED
> on and off.
> 
> What sort of bicolor LED is it? 2 legs or three? Are green and amber
> mutually exclusive, or can you control them independently? If they are
> independent, then you can represent it as two LEDs. If the colours are
> mutually exclusive its a different story.
> 
> Oh, unusual, there is a datasheet:
> 
> https://datasheet4u.com/pdf/1561522/BCM84891L.pdf
> 
> That is not like Broadcom.

That looks like 0x4011 isn't documented on this PHY.

There's also a bunch of MDIO commands that can be used to enquire the
status of USXGMII enable/AN enable, and what mode is used for 2.5G
and 5G.

It also states:

XFI/10GBASE-KR, USXGMII, 5000BASE-X, 2500BASE-X, 5000BASE-R, 2500BASE-R,
and 1000BASE-X (SGMII) MAC Interface

5G rate over USXGMII/XFI/5000BASE-R/5000BASE-X MAC interface

2.5G rate over USXGMII/XFI/2500BASE-R/2500BASE-X MAC interface

It doesn't say when SGMII mode is used (assuming it does support SGMII,
section 1.11 makes it very vague what is actually going on there - I
think someone was having a game of ethernet protocol bingo, finding out
how many different ethernet protocols they can state one after each
other in a single sentence, while making the sentence meaningless!)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
