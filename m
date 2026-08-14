Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A06D46F4AC;
	Fri, 14 Aug 2026 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712685; cv=none; b=YO62EQsVNzIU2TVtzLOKutMi9U1QUuYCJXgPlcUHlkBX4WpWRm/RaHLedFOHPzDehV62vR8jPs7HEEqfPmk6h3idCY7al9TjlavOed6gmXbO2Y/SWJAOaCEDAvuAo17GTX9rDoRO1o6kRV41kzNn/K2R03LmsoFOWs1cIsJ4jlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712685; c=relaxed/simple;
	bh=OutcEnyo1/Y00vbxlVmzdLf/3zNv6UpjyfhMa95wmK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7XloBe8pIf+QPZv5M0AA0rk3kS18LwD1qZJZUGhNvneeBrOWpifK5TyF9Ie9dxcrYG6XH1g8hUkbuA2YbNVIJvvyzP2bmZBBbD33FoIAgqD44FxluAh6Fy2EICOb6da+B3ROF2x0zhuMsATtlIa6f6/5ETqKQdLDvAIZi7lIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LRBkeKxN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LRBkeKxN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XqEkZtQtFc+Y2yeyfWjbtZeABOSuYCmwryVRfU2PCLI=; b=LRBkeKxND1INacGj4TwmTqsMGt
	hW4D1XVJkYuZ4gzNxKVKGqXwsXu+drqpsuGJtFcjyCBh48txR87qqUbHgKKd2PXhwGXY8qTabXhVz
	TFX39Th9OMM8NGGTYwUNAwO7o755Pz3fPgal2kV9g5fPuC1cW+EBz7/cddJXiU+aYywc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wura8-00HaIS-Lh; Fri, 14 Aug 2026 15:04:20 +0200
Date: Fri, 14 Aug 2026 15:04:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Javen <javen_xu@realsil.com.cn>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"enelsonmoore@gmail.com" <enelsonmoore@gmail.com>,
	"daniel@thingy.jp" <daniel@thingy.jp>
Subject: Re: [PATCH net-next v8 3/7] r8169: add support for phylink
Message-ID: <2430d845-3f82-45fd-9b58-f61a981266cc@lunn.ch>
References: <20260730065014.883-1-javen_xu@realsil.com.cn>
 <20260730065014.883-4-javen_xu@realsil.com.cn>
 <cfcf87aa-3d4d-411a-9af0-5a5b78c9ae89@lunn.ch>
 <4338caa7b5d244e1b0d9a6713ed8fce3@realsil.com.cn>
 <0ddca9cd-4834-4d00-adc5-520e74a803eb@lunn.ch>
 <13ac909ae522426f9352fe8770ba2a5c@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ac909ae522426f9352fe8770ba2a5c@realsil.com.cn>

> How would you prefer I handle this limitation?

In ksettings_set return -EOPNOTUSPP for what you don't support.  And
in mac_link_up add a comment.

Also, please test that it does the advertisement settings correctly,
for the four different modes:

ethtool -A|--pause devname [autoneg on|off] [rx on|off] [tx on|off]

with autoneg on, but:

1) rx on, tx off
2) rx on, tx on
3) ...
4) ...

Since phylink/phylib is doing this, it probably does.

Testing the MAC actually does the correct thing is more difficult, you
need to slow down either the local MAC or the LP MAC to cause buffers
to fill and pause actions to be taken.

You also have the issue of how is the hardware getting the results of
the autoneg? If it is directly performing MDIO transactions, that can
go wrong on PHYs with pages, since Linux could of swapped page.

   Andrew
