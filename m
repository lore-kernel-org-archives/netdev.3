Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00031388E5A;
	Thu, 16 Jul 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208099; cv=none; b=SaFgIZA4UF+6c7kE0nN7E/Z1G3QXH/wIkK7fnFTRcGjZeAVXWYS44syvRX9Tz6bnFxF786gg9WZ0aopt/Knl7lTOJTeAJFOCzYU5+u7v0wsz3/VRcQVdO5YhnF7jM5AcZXSVWfmDmrw8CIfqpQEIm0/UIpZgNfMYtMwZ8ApxPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208099; c=relaxed/simple;
	bh=mLoFe/xIIzaVN5uR/zuEhmT1F+NJC8K6vHS6AYI8pqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJXHv1Zt9pVJXMC75Bv3299PGnUo9uYPKAdCqF8oX3JRtHMZcJ4prx1z7J/RyW5W+Ssi1ZUUSOYAwTMmvIYFKN2+YDroTv5i3ZM6Qf7rpUXifVba91hs03Fs7bmuUzoFikG/JYF6SaFqhcJHCD3wdBNjTA4x2roPsdZvq/bJoUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2Fzpmqp8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2Fzpmqp8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GJR7gVJyRXrLY++XR9JQ1vCya65axpJvhZr2icFxhVk=; b=2Fzpmqp8ywnO6URqrTy6u4JIzf
	OMPPvpjpys6nhxarYYe5eQ+lpPjXkxevWd8sJ0Xr0R3tPb5S6cXGtggdQPZQR9UnzzxKtBAHFD5BJ
	BxsHEWZ6T79iKWrmfkewAEN8Ey+zPhVCcg3it8R+rAlE7ZDZ0HNjAwXz7IDgmOzd2+Tk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkM1h-00CX7e-2J; Thu, 16 Jul 2026 15:21:21 +0200
Date: Thu, 16 Jul 2026 15:21:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, heiko@sntech.de,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: dwmac-rk: enable the reference
 clock for output mode
Message-ID: <dac6db00-b286-45d8-8ce4-ed76a7aa019a@lunn.ch>
References: <02ef3409-4078-4c3a-8c17-cb1a7f1f07e4@smtp-relay.sendinblue.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02ef3409-4078-4c3a-8c17-cb1a7f1f07e4@smtp-relay.sendinblue.com>

On Thu, Jul 16, 2026 at 06:56:06PM +1200, Jiaxing Hu wrote:
> 
> rk_gmac_clk_init() only requests the refout clock group for RMII. The
> ArmSoM CM5 has an on-module YT8531 RGMII PHY with no crystal that needs
> the SoC 25 MHz reference (clk_mac_refout), so in RGMII the clock was
> never enabled and the PHY did not respond on MDIO.

Since the PHY is the consumer of the clock, it would be better if the
PHY enabled the clock.

    Andrew

---
pw-bot: cr
