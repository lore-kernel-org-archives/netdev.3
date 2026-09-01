Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E703220687;
	Tue,  1 Sep 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265154; cv=none; b=ds6vJXKR50AAF1DC3yeK6PJmJsCQM1AaAq8zQlVlSYfHyeGmC6IFZLdsHIsjurSQRWdO/isUc3qn2vwYNPH+w+lxSjGUxiJyLc7NtwDwLuoBieXxwut/j6Uhws51uTGEH04bA+DgNLTr6KBM3JHAS2LWg+gMgCWB2aCI2UstKtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265154; c=relaxed/simple;
	bh=NQYQLBBoAiiCGBr+b14hRW1oV2++VtwdOjDRFyDTa/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr+dJKKnXPPDrfYzQpcgU4kUixiwn0qNYbMOmPT/p6cnTYXH83n1ARwsDEzyz10XWkTGjmXoQ/q9cVLq4/ErrQSN5PeRMqXxI8wQuJo81kQFvgnU0ZECu9oh3PcevQlotskUo7bxhgLAt9wFCIFRs7oJScIiJ1IbcxWiJW3w3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=inr+6Ohl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="inr+6Ohl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tTg7Bo2wbjcRAUaxL1UEgGC/z6y7gvvxxIrjwzhUMXw=; b=inr+6Ohlz4RN7rLPYiLjzI4aYf
	4TVsOlrxoOmr6Zx7CKUnmemKhTUkxJIBfi4hNvs9yerdiHWTBkvh8sgbBGkBy3PHfgWzGsKWDLTXm
	jRYbOQAgAiG8YFBmEt5a3T8TO4X5cxzOLji/CUfrK5+m34t7Pz1uyrVhwwuNfx6iS8vg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1NRr-002Lx0-P9; Tue, 01 Sep 2026 14:18:43 +0200
Date: Tue, 1 Sep 2026 14:18:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: guoqi0226 <guoqi0226@163.com>
Cc: Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	cuiguoqi@kylinos.cn
Subject: Re: [PATCH] net: phy: motorcomm: keep chip delay defaults when
 firmware provides none
Message-ID: <0dc278ab-c370-4e13-a727-a5e92f18703d@lunn.ch>
References: <20260901061915.3410228-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901061915.3410228-1-guoqi0226@163.com>

On Tue, Sep 01, 2026 at 02:19:15PM +0800, guoqi0226 wrote:
> From: cuiguoqi <cuiguoqi@kylinos.cn>
> 
> ytphy_rgmii_clk_delay_config() unconditionally programs the YT8521
> RGMII delay registers. When firmware describes neither
> rx-internal-delay-ps nor tx-internal-delay-ps,
> ytphy_get_delay_reg_value() falls back to the default 1950 ps values
> and those are still written into CCR and RC1R, overwriting the chip
> strap/OTP settings. With phy-mode "rgmii-rxid" this clears the RX
> internal delay the MAC relies on, causing CRC errors, packet loss and
> link training failures at gigabit speed until the link falls back to
> 100M.
> 
> The fallback only supplies a value and does not skip the register
> write, so the check belongs in the caller. Since the hardware links
> cleanly at gigabit with the chip defaults untouched, return early when
> firmware provides neither delay property. Delays supplied via DT or
> ACPI _DSD are still honored.
> 
> Since commit fffedfece2b4 ("net: phy: motorcomm: use device properties
> for firmware tuning") switched the driver to the generic device
> property API, this applies to both DT and ACPI platforms.

This seems wrong.

phydev->interface describes the basic actions.
PHY_INTERFACE_MODE_RGMII means no delays are added by the
PHY. PHY_INTERFACE_MODE_RGMII_ID means delays are added for both RX
and TX, by PHY.

rx-internal-delay-ps and tx-internal-delay-ps are about how big the
delays are. The RGMII standard says the delays should be 2ns, so if
these properties are not present, if delays should be added, 2ns
should be added.

The chips strapping does not matter, the PHY should do what it is told
to do, via phydev->interface.

So, does your PCB have extra long clock lines? That decides on the
phy-mode value, you are describing the hardware.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

You say "rgmii-rxid". That would be a very odd value, it means you
have an extra long clock line for one, and a regular clock line for
the other. It does happen, but it is very unusual.

If you really want to have the PHY not touch the delay configuration:

/**
 * enum phy_interface_t - Interface Mode definitions
 *
 * @PHY_INTERFACE_MODE_NA: Not Applicable - don't touch

and you need to patch ytphy_rgmii_clk_delay_config() to support this.

    Andrew

---
pw-bot: cr
