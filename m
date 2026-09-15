Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508747ECD3;
	Tue, 15 Sep 2026 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474748; cv=none; b=iy8d0sJa0K5rSuLKqW9SVZvDr9PQP+ICXklD5p3fhhdKR4mVeuQwBZVTkuSuUroN5cRkcB8OAsY6FT5QgFm8C+OjlsJ7ozGU+EM4NV7g6FHrdljwm3k4A8WAMXpeHFHXoJ3zX4ohaiutRmSlDywxIZPtD8/yFlswTaopeKR+YEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474748; c=relaxed/simple;
	bh=D0xLRVt71fkEBU1S4cvbdgpgfNOl+OJ47ahB27ySe6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=In4VvR0eY5gwhjgtnaRPRh83TWtpkldh3moMGbKawbhezL6ThmH7ys5oXTjAauGjdJ4HJQU+sIKcxzId4frdLzbCMi0EYS/DzNiLVsg05lT7eajaehGVBKpd98uyR1OBeOfHKycI2qPlaEUxFBJywgN+68H5u+Zg3y+Y9yJMH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bxTAoxqo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bxTAoxqo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xUMIRyRgF+J1QkbwTu1z8LNA2IpOUkXjHPIEqoAgFeM=; b=bxTAoxqoBFNCEnhGNIMaYKHCw0
	noO2zUY2QffyLscG8qDO+GuhX1sRI/vHvqK0LMoMP44bwO+f79nqkwPmFUubJ7Oyae0O++vWZ9tcm
	0QQpHQ60tBhyZY87PiAKCpdU1NcZy7RE2rZhUgpMlZfjhYuL3lcYU9wSE73l+Itsqxwg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6S7l-005Gnn-8k; Tue, 15 Sep 2026 14:18:57 +0200
Date: Tue, 15 Sep 2026 14:18:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v18 2/3] net: phy: Add support for Template
 Control register for PMA
Message-ID: <14de4b19-254b-4d45-9239-5a3badbbb73d@lunn.ch>
References: <20260915082152.3104633-1-kyle.switch@motor-comm.com>
 <20260915082152.3104633-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915082152.3104633-3-kyle.switch@motor-comm.com>

> +/**
> + * genphy_c45_template_testmode - configure template testmode registers
> + * @phydev: target phy_device struct
> + * @test_mode: testmode includes Normal to Test mode 7
> + *
> + * Description: Set template testmode include Normal to Test mode 7
> + *
> + * Return: 0 on success, or a negative error code on failure (e.g. register
> + * read/write error).
> + */
> +int genphy_c45_template_testmode(struct phy_device *phydev, int test_mode)
> +{
> +	int ctrl;

I would suggest test_mode is a u16, or at least an unsigned type. ctrl
should be a u16, since phy_modify_mmd() and phy_write() etc take a
u16.

> +
> +	if (test_mode < MDIO_PMA_10GBT_TESTMODE_NORMAL ||
> +	    test_mode > MDIO_PMA_10GBT_TESTMODE_7)
> +		return -EOPNOTSUPP;

And once test_mode is unsigned, you don't need to test if its is less
than 0.

    Andrew

---
pw-bot: cr
	
