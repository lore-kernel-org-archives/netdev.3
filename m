Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CE6145348;
	Mon, 16 Feb 2026 04:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771217111; cv=pass; b=ngUquaOW2rHmBAkSJvvwbig5Cly+uY9XpB28pCbR628YYRroYX0X9agIuLtHZl5zljYNV9nFZMzmHDORRlgFmIK802ySuddHcaTiWggG4WDUu38mvSfkB0W6t9yTcTxq74cei08d0D66c5aG/KLplFe9Dzb10fWqhhJiC5ejdjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771217111; c=relaxed/simple;
	bh=P/1qhIyAZEiykNohWV1DmzJhR7R+Knovx2ve5mqgFG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1gLwWzCpht2fgj7X7Yo3HGzXRKrY8lUqOw67iWTlxbyeAiwwgSDKEI9YI3tRnT/tEnjKHLKTrPUAcwMgoBwnZtIbHYkdp8gvDOHDy9oInrwWcbcg4n3aFyGOsRWaYtesi5R/UTm0JK7ur2ZIO/UBRU6ALIPswVM8BmpuDMay5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=bjyVvXSl; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="bjyVvXSl"
ARC-Seal: i=1; a=rsa-sha256; t=1771217081; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=B7wCwXOO1D7g0K+7R5ASkP5b3rvxhtu5zZxL8YqVpQFt1/JZ0OGfTEvtEhSvZ1aG9kzbcuyqRKjnrFiKzDTa1D6As2i02L5aF3EGxVt4I9o78gOelgMF8pM6sBw+iyy8hJiZq6gYg1rV20YRQVOBiKThhEWsQIDzQegXKAbQSMY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771217081; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mlee/apZf5PJS46oj3LoJC3aGU8uMTOOND+HuontO9M=; 
	b=dplu+3QZvL7/81pGX2ryCEfkAGq6mlrKFOaZeiFG//OurBZ8Uqc5PGxtrF7/HlodlIydn7QFlPrXT/SvAmP6M5rsqw62Qw2FGcZSvtxzaA5bHjIiEUsle5GGq5B9lXnACv666S9z3iBNE/mp6hEijEQTvFglYPkiAo898Hw24VA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771217081;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=mlee/apZf5PJS46oj3LoJC3aGU8uMTOOND+HuontO9M=;
	b=bjyVvXSlGZiyFG6yYoHm9AktJOZNCeprYLUxXM/NS63tlxpFiaDSAVLC5FMVjqVB
	YeHyDUJPkr+EIwpzIhvu1Gs/0dwaYQMJZ6UJI6UErZdBEkgTxZ7ER9u6McAe5Eyz6ws
	/tGSrhTmCseqKZbrvvx7+WAmQxNMrSBxn2Xy4Gko=
Received: by mx.zohomail.com with SMTPS id 1771217079900392.5437106229082;
	Sun, 15 Feb 2026 20:44:39 -0800 (PST)
Date: Mon, 16 Feb 2026 04:44:27 +0000
From: Yao Zi <me@ziyao.cc>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: Problematic understanding of phy-mode in Rockchip DWMAC driver
Message-ID: <aZKgq0-aptu-PnsB@pie>
References: <aY9s5PXP4zZ7R6fa@pie>
 <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
X-ZohoMailClient: External

On Fri, Feb 13, 2026 at 06:47:14PM +0000, Russell King (Oracle) wrote:
> On Fri, Feb 13, 2026 at 06:26:44PM +0000, Yao Zi wrote:
> > Hi folks,
> > 
> > I was looking through the RGMII delay setup logic found in
> > rk_gmac_powerup() of dwmac-rk.c, and found its behavior is strange,
> 
> dwmac-rk is very broken and is unfixable thanks to Rockchip not
> understanding the RGMII interface modes used by the kernel.
> 
> It is what it is, we can't change it without causing regressions.
> Please do not try to fix it.

Thanks for confirming. I understand concerns about regressions and
agree keeping the driver/dts as-is is better.

However, should we mention the difference between "phy-mode" defined
ethernet-controller.yaml and "phy-mode" understood by dwmac-rk
driver in rockchip-dwmac.yaml to avoid confusion in the future?

Regards,
Yao Zi

> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
