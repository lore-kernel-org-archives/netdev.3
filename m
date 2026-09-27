Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8813451A9;
	Sun, 27 Sep 2026 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520546; cv=none; b=EHmnJRNDIZr4IrDMgWcRD+Qhw5V9d2/wW1oi06xCOi/J7AnN3z0KkPfA7O1RnhjB5YqBG1RdmYt2dVJ1JCy6C6GX3KDT9pLUc1SSwT6YYjAvFmnoKlG57WHP+K4oFAO0FOBJm6a8yjsCreUg4ieXZCHiJ7ThF/Q2K/zDiBIz+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520546; c=relaxed/simple;
	bh=vunJl81K9qufJZ6kHV1zrsp+YOvm895E4u87ZsA9p5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uufCJ1V4MgRF6ihxqgCuwQQfdYfkk5Dzk5FGULUaJODQh+50bBEUxdu+b/ynH4+uqm9kwtYxk7Ip4hfpJgbqYiKXtmXdWnknVkIDR3lEtQto1S+bJ3OhaqQv2Uh7KI03YlQzlQcW4B4CALdv/VHYq3C9SnOnUjmFmYo25aLbxy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kwMWGViT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kwMWGViT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+0CClvo5rdZNkZTJ7f+8ULkbzjezc+61O9AhMbaXx5U=; b=kwMWGViTuFyAcmVjgWvQ9h9+Kd
	tSizJDaJwDe8H4JPXBJ86zSJPcc07+A+ipKjtf6L45s0OHLL3nENDk05H3zFC9Vd4RaKn3ePFmoks
	Y+oRAoCnrAMst3NwIwnOKTH6mEtQU1yaWZy5niYg4H6/ZG/Sb6fGe1g3PoKDg56HKsGs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAqBP-007WSS-Se; Sun, 27 Sep 2026 16:48:51 +0200
Date: Sun, 27 Sep 2026 16:48:51 +0200
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
Message-ID: <e18c66e9-7ba2-46c0-baf5-b4281a45755d@lunn.ch>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
 <20260923215858.1653-5-yongzhao.derek@gmail.com>
 <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch>
 <20260924234814.1734-1-yongzhao.derek@gmail.com>
 <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch>
 <20260925210153.8717-1-yongzhao.derek@gmail.com>
 <69b36e16-eece-4739-9208-96bd8e60943f@lunn.ch>
 <20260926082129.1632-1-yongzhao.derek@gmail.com>
 <426f9dcb-7473-48d5-a473-4435cc81312c@lunn.ch>
 <20260926215152.376-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926215152.376-1-yongzhao.derek@gmail.com>

> I'm open to selecting the workaround through DT, so that it is enabled
> only on boards known to need it. What I can document at this point is
> the PHY-to-PHY connection, the reproducible boot failure and the effect
> of disabling SmartSpeed. I have not established whether the cause is
> the board's electrical design or something else.

This is tricky. I can understand not wanting to say the board design
is broken without strong evidence. But a DT property is about
hardware. Maybe word it something like ... when the hardware uses an
on board PHY-to-PHY connection, without cable, SmartSpeed has been
seen to incorrectly performed a downshift. There have not been any
reports of a traditional hardware designs, using a cable, having this
issue.

> Would that be sufficient justification for a DT property, with the
> underlying cause left open in the commit message? If so, would you
> prefer a generic PHY property to disable downshift, or a
> Qualcomm-specific property for this workaround?

Also tricky. What we don't want is other developers trying to abuse
this to turn it into a configuration option, rather than a hardware
property. So i don't think it should be a generic property. Lets make
it a qualcomm specific property. I would also put 'workaround' in the
property name, again making it clear this is not intended to be used
for configuration.

    Andrew
