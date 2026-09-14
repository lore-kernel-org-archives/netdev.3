Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C83480DC8;
	Mon, 14 Sep 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390936; cv=none; b=u0IF37ScFM3srqzSVEN2tMt3uBo/fw7ndjBxn2qw+/6dL08Mt6CWvy09U45Ymdtr/uiRRBPDX2z3Y394TiW0MiFapjNHrwn/Hmehysw/Yg06dyJRopAvxdBnVXRW9p3GbllfZljN8ZP7flHjIx3OiTbduYNAwF0wzaf/ZHWT1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390936; c=relaxed/simple;
	bh=3euTqs71rO5y8adr5CxWQ4WBJfv5vQ6vlMhHc0hUv5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcPVNKydNBZ86Sa6y4j7gRWS6/8SFrUkKbumlmfrY8J3XXSkNT6fA6aIqD5Y4TeC90WNeKbjU/W1IDnPStKa2vgDwv7O35+djAlZJNhAiWCf1K3tiAoHc9ghnV1DeeOClFgbxC1c4mBRNWR9u5cmDduTLTkY7JSsVwJ09K6YUnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jNV7rrYK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jNV7rrYK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WgRoETcWkL7FM5tviiSxqHrq/2LFJ5sGv7JiBt2ab3A=; b=jNV7rrYKG5C5Er4VQqXvYl0+SD
	ixxMrUBteJQQHFTJwrunXYjBS1GIjh7+IstnbkUaC88k6sA3Pn+th4aoO9RxDIftJMjZ2V3yqNuzS
	ObiZolmWXHuT6ziLAt7LufXYcMEdXSq4G/YhwFCZXSuommzXQzJvb3FlYCQFEC0AWAMk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x66Jx-0055J7-LQ; Mon, 14 Sep 2026 15:02:05 +0200
Date: Mon, 14 Sep 2026 15:02:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: marvell: wake the system only from
 the WoL event
Message-ID: <d7d3a464-ebd2-4917-9c84-707aaf28f8b2@lunn.ch>
References: <20260912235125.151370-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912235125.151370-1-rosenp@gmail.com>

> +static int marvell_wol_suspend_intrs(struct phy_device *phydev)
> +{
> +	int oldpage, ret;
> +
> +	oldpage = phy_save_page(phydev);
> +	if (oldpage < 0)
> +		return oldpage;
> +
> +	ret = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = __phy_write(phydev, MII_88E1318S_PHY_CSIER,
> +			  MII_88E1318S_PHY_CSIER_WOL_EIE);
> +out:
> +	return phy_restore_page(phydev, oldpage, ret);

What is all the oldpage code for?

     Andrew
