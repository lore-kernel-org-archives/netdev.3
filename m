Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7826CE05;
	Wed, 22 Jul 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746551; cv=none; b=EweYPnw/7TVECfQ/bB0ibPoRTIH2qxB7q1IUiUViNISKAQe3dVC/gAeRbpnNgoO5/Mr0OUuAx+9nYphsAWXiweGIjJAm3SOKcwehs2Ektzi/VLvAl9hBauJgYgYQs135Vl8sIV2wr4U/X4+qfkts8tA99AXlxl01wI21b6PiyyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746551; c=relaxed/simple;
	bh=WIw2zOYFjwpDd4MmwdNc/avZf1l5P0jjXnu6r60Eo8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K08av141QwSjkhoxezWQ6Z5yK2eB07cyD1leCBsHA/HWomAeejd1GcRfAUiTmT6QDeuHU4ij3+Pf1Ncvx2pgTJIcv+R9m/dCtsjU1WBnfeP1OR+xt8hXylNK/CJDLXR4zFTKS2nghFb4VOcT05Y7Rn/O2whMBFWhQQxPHzR8YY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0diCQlGU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0diCQlGU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=auVQqnjDEe2OKzsdZZl9cUluqYl5Ja+s/usvSDWVVmg=; b=0diCQlGUvJrUy3YakeA7IIq8kE
	xSFD1vzFRJcXNZnGCKENJhl23B4pZs8cyFbEhTYmtTkL/4yZLZbnVXpwA0x9bvAWdnKF0NYVcyl+e
	2uNGYcC1Sifedj/ZbavHlCOUg8yscd48lxgthKheXVdappBgVH2yoKk5/UZZl1gReLRo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmc6T-00DgBn-QU; Wed, 22 Jul 2026 20:55:37 +0200
Date: Wed, 22 Jul 2026 20:55:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 6/8] net: mdio: realtek-rtl9300: Increase
 MDIO timeout
Message-ID: <5d1cb81a-9497-4fbb-8bd9-5890c6dd5ff2@lunn.ch>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
 <20260722062356.12291-7-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722062356.12291-7-markus.stockhausen@gmx.de>

On Wed, Jul 22, 2026 at 08:23:54AM +0200, Markus Stockhausen wrote:
> RTL838x devices with 28 ports produce PHY access timeout errors during
> one of three boots while waiting for MDIO command completion. This is
> currently set to 1ms.
> 
> Background: Access to the Realtek Otto ethernet MDIO bus must wait for
> a free slot between two hardware polls. The polling sequence consists
> of at least 17 commands on the RTL838x devices. This delay can be nicely
> seen when disabling polling completely. The following times are measured
> on a bus running on the default 2.5MHz. Time measured is from the last
> register write that sets the command-start-bit until the hardware
> responds with the command-finished-bit set.
> 
> - average c22 read with polling enabled on all ports: ~380us
> - average c22 read with polling enabled on one port: ~380us
> - average c22 read with polling completely disabled: ~180us
> 
> For this bus frequency the bare hardware runtime for a single command
> (32 bit preamble + 32 bit data) is ~25us. So the hardware adds quite
> some overhead. On top of this comes the fact that the RTL838x devices
> are low on resources (500Mhz 4Kec core with 16K cache).
> 
> Increase the timeout to 10ms to be on the safe side.
> 
> Remark! In a future patch the bus clock frequency will be made
> configurable with a minimum frequency of 1.25MHz. Setting this
> (e.g. for debugging purposes) doubles the command run times but
> will safely stay below 10ms.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
