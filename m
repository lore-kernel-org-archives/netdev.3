Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABAD43D4EA;
	Sat, 26 Sep 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790428348; cv=none; b=YLMmLgxBiAHHzCMTQ9+xfCabksVPlUl9q+czglcoVzXsi33f5301LG8qemI70r3h9Hgy8l/QJd9AV1oMx7nGUh8F3Dmnf1TtxLXi3tycdq+O18rOiOfPGu9kAUWnM/i4ZMAJON6K7AfpX6G6GGnbwp6vfpAiv5DcEH152+zJdVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790428348; c=relaxed/simple;
	bh=np868+PCQ0Dv1vEpNrfzv85QUBz6RJfM+QiP7Ncb4N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awYErSLIeQIa3mPLJpATsr93fnmFgwBpcm2XZQTlGFUoZzBALfJ5TYwFSIjPnCiIV6DA/RoYTLvbN61CWIXnKoTDY4CkPgdyNG8+70Xavwz/ez/ewPWWEo7nUo0H5aH55SRwA0tz7cKM2wNvVfkF33baMevBNvvONQQSfd4LKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hZr7VzwS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hZr7VzwS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DWe7cZoB//kCgDjMe0HkstXi0WmxvSYDDMy4xoCwSvw=; b=hZr7VzwSko396VLxISUXuX3byo
	cq6dKwLDxyY2FmJZORYuovwuuaJtBGMx+HIvhY+E+rtZ4MJ9n+REXNROLZAAe0fstAUtHrv3VehK0
	LeV0+xAFG94QOUKlBvw1K2ZlQAayCTBHPhorqrLfddSTKmdZ3FzG1CB7tb6LM0kICLUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xASC0-007NcS-Sj; Sat, 26 Sep 2026 15:11:52 +0200
Date: Sat, 26 Sep 2026 15:11:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337
 internal CPU PHYs for SmartSpeed
Message-ID: <426f9dcb-7473-48d5-a473-4435cc81312c@lunn.ch>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
 <20260923215858.1653-5-yongzhao.derek@gmail.com>
 <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch>
 <20260924234814.1734-1-yongzhao.derek@gmail.com>
 <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch>
 <20260925210153.8717-1-yongzhao.derek@gmail.com>
 <69b36e16-eece-4739-9208-96bd8e60943f@lunn.ch>
 <20260926082129.1632-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926082129.1632-1-yongzhao.derek@gmail.com>

> The OpenWrt DTS for this board sets qcom,dac-preset-short-cable on the
> IPQ5018 GE PHY. The qca,ar803x.yaml binding describes it as adjusting
> amplitude, bias current and error correction for a PHY connected to
> another PHY over a short distance. There is no equivalent setting on the
> QCA8337 side.

I'm leaning towards the hardware design is broken, not enough
attenuation etc, causing the PHY to wrongly detect a broken pair.

The IPQ5018 PHY driver does have cable test support, have you tried it
out?

Downshift itself, in the normal setting with a cable, probably does
work, otherwise we would of had reports of issues.

Although the PHY on the CPU port is not associated to a Linux
interface, it is still probed, and has a phydev. So you should be able
to represent it in DT, and add a DT property to disable
downshift. This would sometimes run into problems in that DT should
describe hardware, not the configuration of the hardware. But in this
case, if in the commit message and comments you say downshift needs to
be disabled because of a bad hardware design, i expect it will be
accepted.

	Andrew


