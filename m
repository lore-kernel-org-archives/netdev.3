Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8FB51D538
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110854; cv=none; b=pH7hXGTq+4cS5EPGdYxKn4Bmp/XT8PYteMMLWk2999kRcBZw9zcdWbjHxP64wuBg18632PmuEFhC9BcHWlzFBeQAZ3qNbW9AxdoTueZnhVTxlYhujCRzyMs4T+iIeCMn+H4NrsOk2wle89hWl22OD2yg4fO4cAz6pwnszzjIi5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110854; c=relaxed/simple;
	bh=fIbjax6qUjIaC3MAH0iwR3cf3a40k2wDIlzBuP6yytc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAks58BUfrEVBxaILueSdd7VznSQrD4qX63zvEKbS8UskPNMGgJQ1SbYCDUCJjjnHo5Ou9MHUWm0sROdMPdBPeDcUlGFjhyjDBU6W+Lm/4KiG8Y8saIsLZ3vwejVpuN0YOJXPdpqerl4oqt+E9FXcSZ9eNZNqXmQPxczSIbOMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hYWuGThE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hYWuGThE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=glvkBnFt4qSYg5jv443iMTbR+pz+EDMw6LQCzRCUxRs=; b=hYWuGThEaJcfs7YQlswB0bRulJ
	YuIyHuELIvQkj6pBVnypFoTRBtzoWrOuQLU9jjmn6ROqOwDz1T3PWHwUbFxualPukXDqp3AH5k1na
	GXtI9yJ9QNOO5LFzxTNoxTl4SDYPZVkn2LhnrAiVKP2av01/0at/0Ft3qL5Ug+VcX2Bw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x97bK-006fr0-GX; Tue, 22 Sep 2026 23:00:30 +0200
Date: Tue, 22 Sep 2026 23:00:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, ansuelsmth@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	hzyitc@outlook.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [RFC PATCH net-next v2 4/5] net: dsa: qca8k: flag QCA8337
 internal CPU PHYs for SmartSpeed
Message-ID: <e78c661c-67c3-46df-acb2-d1fd925c4549@lunn.ch>
References: <20260922202653.1153-1-yongzhao.derek@gmail.com>
 <20260922202653.1153-5-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922202653.1153-5-yongzhao.derek@gmail.com>

On Tue, Sep 22, 2026 at 10:26:52PM +0200, Yongzhao Chen wrote:
> Mark QCA8337 internal PHYs used as CPU links for SmartSpeed suppression.
> These links can wait for the conduit PHY during boot, causing SmartSpeed
> to remove Gigabit advertisement before the conduit starts.

You need to explain in more detail what smart speed suppression is.

Maybe it is in the next patch?

      Andrew
