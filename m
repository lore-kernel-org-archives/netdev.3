Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378896;
	b=ch5YeKS2Uji0i4xuJ9nzvy+YIGU5Tf+Yd9VK0w+Qg6Cv0LQeeWmU3GANOzxGWabY7HdF
	 11T+vn2G0PdX/90a8D/LX4rlTU6RCTDSHZBxblOUosHir5LMNM3COt/kTb9irWNbUc3PA
	 vAL3oGwbypI2fyFZkh2llLnpoqpKqBXLdDcE5J/aOObeqHi+2x0hdfxYLuWvytDaLwDvf
	 A+szp2rJK39u/os94gYxvURa2dh8tKt0v5P/MhZQkg6iL/anCXeCIf9ecL3Lf9Whre8tM
	 k56MVlu+Mee3wR1qfaOJctbK1NSyYhwgYvwc88GfZtQKm/M9zDuHyHQten+k/v844Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378896;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=HfJEb3O4xS3Qn2t0Em3EptnBENG/IpkIjGo/eRBHy8s=;
	b=WGp/twVSXJZWLjKqHGndVLfWAPeKJGLtbgi3EyV4iOEnuDilB3HtrNgz0SR05Q+eHFZI
	 erHSaZRuED13kPnJmTDYjPBLxyrZQAdN+a9ceE+VbA+x6NBSJ8L+0Jr2g0EW9aBJO8vQw
	 IF/+h/M83wTFurQumLXidFxu4l6AkghF1pAR1qzQmGBaFQUnIrICCU0ITXXnK8RXXB6BO
	 m6We7OPcvCDSr8ziuXStd3twBhT+AQgsI2wE4hS9vGu77fwfRQCjRkV7IWBw1cSnGkiD0
	 M5RlAKKXPA0LdQZLgbyTCUWzwPnHtfmUgLv8yVdPMBzEdAfTdunE0KzAuj/tH8ialVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kHvoU0oI;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11A606A31A;
	Fri, 30 Oct 2026 16:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A11A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kHvoU0oI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HfJEb3O4xS3Qn2t0Em3EptnBENG/IpkIjGo/eRBHy8s=; b=kHvoU0oIXcmfqcYfTo5+uh8Cza
	bBEbBBovaPWR3w2hXS4be3mAKw4bCFR9uXQb5CzN0uU/ytbpx1QACIU/Tq9EMZo93iF6PV8FGuVNu
	mytZwl46M+tgIVXr5sjte5ITX7LfGGO6KeWLxtpGem2sdWvZBb1B8l8wloNs/liKw7Vg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xMplX-00DPbf-T1; Fri, 30 Oct 2026 17:47:43 +0100
Date: Fri, 30 Oct 2026 17:47:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Emir Beganovic <beganovic.emir@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Eric Dumazet <edumazet@kernel.org>,
	Jianhui Xu <neuromoments@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH net-next v19 00/13] ax88179_178a: Add support for
 AX88179A-based chips
Message-ID: <e7603c1d-4b1a-48be-a9da-9f9cf888cff6@lunn.ch>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
 <20261029005809.19405-1-beganovic.emir@gmail.com>
 <2a66e94c-0fd0-4c90-bc1c-9e5699f80737@birger-koblitz.de>
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
In-Reply-To: <2a66e94c-0fd0-4c90-bc1c-9e5699f80737@birger-koblitz.de>

> > - After a WoL wake the link goes down and up twice within about 2.5 s,
> >    where a normal resume shows a single link up. It comes back fine
> >    either way.
> I see this, too. It is not triggered in any way by the host or the link
> partner, I checked. It appears that this is due to the firmware on the
> device trying to optimize the link settings further, the out-of tree ASIX
> driver displays the same behaviour, although it works very differently.

phylink/phylib might be playing a role in this.

It takes about 1 Watt more energy to have a 1G link vs a 10Mbps link,
even when there is no traffic. So during suspend with WoL enabled,
phylib tries to reduce the link speed to the lowest common speed,
hopefully 10Mbps, by only advertising that one link speed. On resume
it goes back to advertising the full link capabilities.

So one of the down/up you are seeing might be this.

   Andrew
