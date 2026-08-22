Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53157080D;
	Sat, 22 Aug 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787427509; cv=none; b=b+KGu97yb+YzDl8OX0xhyVePQD9fvmTxhdf74IQW8NzJzQ453M9WLFXEK2YvAMkFQ8ta9uwSeXDL158czhu1kD94ROfNNxZS0qqWGF2keRRTxjdTxxmEjsLVFcKs8XE69Nj4bLkMXzNAfAzve/JS7tjMJg1GmXseeJrEHT/WeZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787427509; c=relaxed/simple;
	bh=J94+UkJiJ2P52MpL/uHE/uZt8PBhu/MevM63q7+lriE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pELByX6QDEoFV+gRuiCPa4wexOg3s/HIf6GuOOCyuLMpXwTK2bxOwO/Cre0XknEQRb31EpF/7DxIH4+ytMOKpnHAe6i20ZrjKQjXtJoyZmGSbIzwPmkbptcCOKDadb5+oaoFa3nSilK/RmD1TYvbw+AEOjVW5xgaLlt3/KzcQfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1NF3B+LF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1NF3B+LF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WwJaqB3W3Tt+j9p+GyciwNcUMs9HmqAniHSlXsaRx5Q=; b=1NF3B+LFunxukcZLascTheGhAk
	++MyptZQhYQJM/hk4ByeSakffnUKVUmITTFI+CrUrZqsaCvif4GiAcFEm+38YP4/h9dB1c/6ufBG+
	w32NipyvYMtGKTRF+Ua1M4BxVhXcovJKFLZUzFgZ6rVoovuqQhCpGjYiwLIJDdPf2SAs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wxrXo-0013Sf-2P; Sat, 22 Aug 2026 21:38:20 +0200
Date: Sat, 22 Aug 2026 21:38:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: dsa: connect a late-arriving PHY at
 ifup
Message-ID: <9557daed-f039-434a-ae64-ac849b9860be@lunn.ch>
References: <20260822155259.87146-1-f@lex.la>
 <20260822155259.87146-4-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822155259.87146-4-f@lex.la>

On Sat, Aug 22, 2026 at 06:52:59PM +0300, Aleksei Sviridkin wrote:
> A PHY whose driver loads firmware at probe has no driver bound while
> that module still sits in an unmounted rootfs. phy_attach_direct()
> falls back to the generic driver, whose feature set lacks the modes the
> port is wired for, and the port is dropped for the rest of the uptime:
> 
>   mt7530-mdio mdio-bus:1f lan4: validation of 2500base-x [...] failed: -EINVAL
>   mt7530-mdio mdio-bus:1f lan4: error -22 setting up PHY for tree 0, switch 0, port 5
> 
> The same PHY wired to a MAC on the same SoC comes up. The difference is
> when the connect happens: the MAC driver connects from ndo_open, DSA
> connects during setup, at 1.9 s, before any rootfs exists.
> 
> Keep the port when the connect fails on a PHY that has no driver of its
> own, and connect it from the open path instead

The problem is, this is not guaranteed to work. The driver might still
not be loaded, or it is still downloading firmware to the PHY.

Think about the case of NFS root. The kernel will open() the interface
as soon as netdev_register() is called.

I think you need to look at the PHY driver. Make its probe function
return success, but start a thread downloading the firmware. While
firmware is downloading, either soft_reset() or config_init() needs to
block. That should allow the MAC to bind to the PHY, blocking
everything until the PHY is ready.

	   Andrew
