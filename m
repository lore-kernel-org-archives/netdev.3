Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794576820;
	b=kVoLJmawRdkB6Dh8f7qtYF+hTf3BGUzeyu+X69wpFwo4vD+CCPh87hom5SZWhJKhMiwE
	 brO2yV1W9eQVDpzUJng2gsKyqZjU13U+o+tZCsS8gYxwPIAg+k2K2AYpC94wtDWehm96s
	 s1vaCBzaH9Azi6shU+YdzAoj5bMcMMPu4MjugWdivhdlK1CMJgIUVjhBZcBXIXmYgzOGq
	 pnnErICLMMx66Gtx1jv0G18wCr3R4lgLUxS1Tb01ELTAVTiCSLhCMts82DGJ7WC7eQu/C
	 LFk6Q1qnZIg8XXI2wq3lACZp/OYDGGPmV+qauo6d6YkaWtXRdYiFxZ8tsyMf3AUx/hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794576820;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=MBuJpHp3mo0oc5xPyGY7mPd/0AyD5zGxQMXpwyVexpY=;
	b=04LPZy3QyS0Dc5mcJ9/XhYkk8vSASRTMdru3/y098oN3T0YOJVHn14Yp5A/P1Z3eXKko
	 A5wZmP3K5JfYTq6IvqtFmeSuZTHOsqdXkdM3lZpY7s90Zsz59TKnUJkG/geC64dCdauHS
	 6rm5QTJg87UyLfzVn3TWxDrx03rlbmycxFJsDnxrXVw3MV9FXrxW26dPBi4APOk7OMbyx
	 JWzBpxBbE3lc6+L5VFtLi7NI3RPZN4qujyaHQcAw39/UjwR0l4Y4WF5TugBQEUD7qctXe
	 mH7j/ljmowBdJdEdDJ84863EEdUfUETwrcHcq53XFSdEhVpchzfj3oI8kOVsE6mJlNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LtPFJ58u;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5B6606AB8D;
	Fri, 13 Nov 2026 13:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC5B6606AB8D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=LtPFJ58u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MBuJpHp3mo0oc5xPyGY7mPd/0AyD5zGxQMXpwyVexpY=; b=LtPFJ58ukFwK2zyCaT++BKxDIp
	Szed4Dj7e1ho2ZScZRmKRZhP2emZc6obizQNBfhtmfcFuRAM0a5YVWVy7Dk3pR5oOdCCqrw6e6iOS
	AmJGpJ1hAqEsZaVp0cuBfAYVpq9iFB5OCEKMSR42Gyu32LW1ib6bpyEFiKtjARfvycBI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRrPA-00GHgd-NO; Fri, 13 Nov 2026 14:33:24 +0100
Date: Fri, 13 Nov 2026 14:33:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] net: phy: restore driver state after userspace
 MII resets
Message-ID: <11acd5b1-3099-4e3f-9fdf-a3c5c6f098c4@lunn.ch>
References: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>
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
In-Reply-To: <20261113-submit-phy-mii-reset-v1-v1-0-02a55f352a91@gmail.com>

On Fri, Nov 13, 2026 at 01:48:39AM -0700, James Hilliard wrote:
> An MII ioctl reset needs to restore the PHY driver's configuration and
> software state before the PHY worker can access the device again.

The MII ioctl is a footgun. If you use it for writing registers, don't
be surprised if bad things happen. Even reading registers can cause
bad side effects, like missed interrupts.

The whole design is broken, there is no fixing it, so we don't try to
fix it.

Sorry, but NACK.

       Andrew
