Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63001427F96;
	Mon, 20 Jul 2026 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555335; cv=none; b=F2TU9nfQz7pCMlZR0QK96VoRyZkDrlYL178w4pfsoS56Jlgl0cW8fM3Y8aKpDoe1ySVh1vz+WZOm1bqPpu7GfeQCXpzCsNhZsqM5hrDu9zNF++qcGbgHjwDixbgS7MTNrsbVpK1cvvJmwf4eVJk3uZbMMc2sQfuoWjvTj9s72+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555335; c=relaxed/simple;
	bh=zhOdL6Czb0ab5M6qqhBHlqtPjYAwQ5pBcR+/Sh6kEcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJYs+5eeI/TlUGYZ2/FFemER/z5Hplvrbt2wggSz114+oaveVesJraqBlz9X65YAYyH/ZkfpDArIA3yOM1Q2WY6N3viu/yqnjZyvh27ybVtIxCGzpAqpXO4YGxIZm3TpU7I31VnOYnmw3r+75TwyzfsID3aj0NNMnEmlr/LUa2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=R7zzzu5A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="R7zzzu5A"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7qSKy/g33amts1oK+SrM9bDZHgU8q/E7Z64+Dh0BkeI=; b=R7zzzu5Aa1i6/M0ZwDPrgyOQOh
	ubj9TFOWJ8jPB/sSIC8qF10oJvkiPubOhdZRK5CPreSLgBveWa2BZaHg7lmCy4Gb8BRr/5K2OGBFd
	jU63DArTxvLR1yvFopIUIKZv+a4R3lAGOrH4Ic7lc152ImRRZVwiUY6uGc/R5mlR/rcw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wloMK-00DGis-Gn; Mon, 20 Jul 2026 15:48:40 +0200
Date: Mon, 20 Jul 2026 15:48:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v4] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <cafd8d43-7f76-44d8-a579-670d911f9b91@lunn.ch>
References: <20260720091133.2438175-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720091133.2438175-1-kyle.switch@motor-comm.com>

On Mon, Jul 20, 2026 at 05:11:33PM +0800, Kyle Switch wrote:
> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
> 2.5G/1000M/100M/10M speed.

So this is better, however still not correct.

> -		/* Enable WOL feature */
> -		mask = YTPHY_WCR_PULSE_WIDTH_MASK | YTPHY_WCR_INTR_SEL;
> -		val = YTPHY_WCR_ENABLE | YTPHY_WCR_INTR_SEL;
> -		val |= YTPHY_WCR_TYPE_PULSE | YTPHY_WCR_PULSE_WIDTH_672MS;
> -		ret = ytphy_modify_ext(phydev, YTPHY_WOL_CONFIG_REG, mask, val);
> +		/* Enable WOL feature */
> +		mask = YTPHY_WCR_PULSE_WIDTH_MASK | YTPHY_WCR_INTR_SEL;
> +		val = YTPHY_WCR_ENABLE | YTPHY_WCR_INTR_SEL;
> +		val |= YTPHY_WCR_TYPE_PULSE | YTPHY_WCR_PULSE_WIDTH_672MS;
> +		ret = ytphy_modify_ext(phydev, YTPHY_WOL_CONFIG_REG, mask, val);

Look at these lines. What changed?

As a reviewer, i review diffs. Changes like this are just a waste of
my time. Please review your own diffs, look for issues like this,
solve them. I won't give comments on the actual code until these
problems are gone.

    Andrew

---
pw-bot: cr
