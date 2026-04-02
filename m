Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA115539A;
	Thu,  2 Apr 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136733; cv=none; b=oBUoLYnsE3YC91hMzikmYtoPGjF/YvNSdBRen+rAhn6SgZdTEbFIpJkGIQds4qql6UrHXQLa0GTPNTFU4VyrwEQtLUTSAAh2VafgWK3/52yAX100B8B+pJWdQSuTawep8uhAZGK+70/YkKIb70GZ8/45LbrtDFYtG/uY3CmTyTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136733; c=relaxed/simple;
	bh=px+ZQL9SeSg0anGR6PYstsU2PYChUwT5huFCIaWspeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTWOn8+CzluB11OEWR8wcLeT19o2k1tcQKa+8E+EziSz8zceWWCH/Alv5gFNIKs3V8KponT3qGTDgWmlF6A1yqkzpr54+oUceS6xJR5pDE1XjX9mqByTRTVVo8PCDy+M1XSaCYsvYJnbGxfRp9yE4ieg1vzlrosvMvTq66VzNOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ciJkpyYl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ciJkpyYl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qX2UAXJjVkLhETIgbS+PRlw18LUdRHYFiQPQcc7qkYo=; b=ciJkpyYlihCKIUiyVKKL86Wdi+
	xZFcjQKYgZmMZCduYgsTcunQe527ogYGukt5qWOSQNlZRdgxd/uvExUknIem2774XBRAsZw7UNRx1
	d11OqRpiolqkZOvVrSMGoZfS9vfcPfwcLKhKYf+9GmJtnexxR4F/lihs7glTuTLg2Jg4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w8I9I-00EWIc-Ax; Thu, 02 Apr 2026 15:31:52 +0200
Date: Thu, 2 Apr 2026 15:31:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/3] net: phy: add a PHY write barrier when
 disabling interrupts
Message-ID: <6bb3aec4-1635-4287-b7ce-f15b693563ea@lunn.ch>
References: <20260402131229.319599-1-charles.perry@microchip.com>
 <20260402131229.319599-4-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402131229.319599-4-charles.perry@microchip.com>

> +static int phy_write_barrier(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	err = phy_read(phydev, MII_PHYSID1);
> +	if (err < 0)
> +		return err;

There are a small number of MDIO busses which don't implement C22,
only C45. You are likely to get -EIO or maybe ENODEV, -EOPNOTSUPP,
-EINVAL for such a read. Returning the error than makes
phy_disable_interrupts() fail, etc.

This is why i suggested throwing away the return value.

Maybe call phydev_info() if there is an error, but i suggest making
this a void function.

    Andrew

---
pw-bot: cr
