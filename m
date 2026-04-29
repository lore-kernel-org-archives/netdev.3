Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C2F271A6D;
	Wed, 29 Apr 2026 01:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777426928; cv=none; b=ZSDVHDQgLp72TA7EEUJaKiItI59WUAIw/YZ7DLjywfWx1Kt8cm3fbeJIGRcs254623loA4VXJ3/SemYoBR/JqAl0bfqJJPA2Wpx5UzFhGvm2OCnAsTWty9ZA3EmrRXe8r8pddnXJSyx7lgr0Ov/QSRxqPg5tJYjpFVmo51AK8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777426928; c=relaxed/simple;
	bh=v67v7KT5BIZDe+T4/abHvDx4Y87f8RhD9dCoqpqCDHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeZdT4b9B79ZvTYTGsK72QhXOLMuKGQNMmMwAlS4I4V53AdSKE+t/cA3MYnbkUGF+QLyLzIKL6UxPu2Jg+P7atboTZd63CVmJF9YRl3tuaArFvs4h/B890jzE5Q6KUBglalzqb5YXiVcpxEghGwQii/rILEfYj7e4nJjxNzxrjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kp+edf72; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kp+edf72"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xr++0uW3/aWfxubO3cxQcvyMCVatN4XOXUV5OwG2V2w=; b=kp+edf72edokyxU3mtqEnZKTr3
	IdsBZ36KjZkY+e6Mq+wkNkDnqeAGDWrgyJ93hMP+ALlz9+l3ZutV6C30c3TTf1iuG0U5PLgIzieVn
	XNbOI/kNLVqt5Yk26Maej/3KG2oCWZjyZb6Uwktr5gIfLqnUtIv8x4BMfVTQ1yt+/QTY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHtw1-000Rgl-Lj; Wed, 29 Apr 2026 03:41:53 +0200
Date: Wed, 29 Apr 2026 03:41:53 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com, weishangjuan@eswincomputing.com,
	horms@kernel.org
Subject: Re: [PATCH net-next v7 4/4] riscv: dts: eswin:
 eic7700-hifive-premier-p550: enable Ethernet controller
Message-ID: <d662fa07-cd0f-48c4-a6e4-03c5fd390e92@lunn.ch>
References: <20260427072353.1114-1-lizhi2@eswincomputing.com>
 <20260427072603.1191-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427072603.1191-1-lizhi2@eswincomputing.com>

> +&gmac1 {
> +	phy-handle = <&gmac1_phy0>;
> +	/*
> +	 * For the TX path of gmac1, there is a skew between the TX clock
> +	 * and data on the MAC controller inside the silicon. This skew happens
> +	 * to be approximately 2 ns. Therefore, it can be considered that the
> +	 * 2 ns delay of TX is provided by the MAC.
> +	 * No delay configuration for tx is needed in software via PHY driver.
> +	 */
> +	phy-mode = "rgmii-rxid";

This is wrong. Take a read of

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

phy-mode describes the board. If the board provides the 2ns delay, you
use rgmii. If the MAC/PHY pair needs to provide the delay, you using
rgmii-id.

If rgmii-id is used, it is up to the MAC/PHY to decide which will add
the delay. If the MAC adds the delay, it needs to mask the value of
phy-mode it passes to the PHY so it does not also add the delay.

Your broken hardware means you cannot support 'rgmii' or 'rgmii-rx',
since you cannot turn off this 2ns delay, so you end up with double
delays if anybody designs a board with 2ns TX delay on the board
itself. So please validate the PHY modes and return -EINVAL if these
modes are used.

    Andrew

---
pw-bot: cr
