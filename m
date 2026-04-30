Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965A29CE1;
	Thu, 30 Apr 2026 00:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508342; cv=none; b=IJbEkcX71hfz7Xlp2IAtfsA5g02vURUVMyF5zf0t6iiQBeHVUrX6CoJbIUU4GyG9SBmoBVlZqDRLDljcWYPdrN0C77Kz2eC8opxk1wZxD3FoL3B2UzUUkp7wsIRB37MGNk96TPxTL4tPl7FjZX1GYA0IWswh50xbAngRe1JZahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508342; c=relaxed/simple;
	bh=hJNz/8PRHKHkiAftvNMkkZEnvBERhqC9AWqUQ3QCs5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjRSiskzoXiHy4/sRq1JsyAr0QrbQMfvLwddoY9kHGPd6UP4blKhuJ5ecQISzSREcApd3VfVq1OjJI7enHEACh3TsjFZ/tbpUv1Y8o2izSVIxgc6JMTS2Sciw21k36QgAmQsqqjrlnsHl7RWu50KBBDUaH7ln+/p0hT9Dm1LBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KBLaFtqs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KBLaFtqs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NuM3kpmeo2F6HKXd8wBcwkLWijAbJptVoNwo165S570=; b=KBLaFtqsUaq15T7ZKF8mMKT4e2
	aba9bK2a1AAKyxgi4scTYhlyyLE5R2ZMFH42io+JKgvfk5/58XAXZ3z/YOgvaMiQcwlzpq+oRqPdz
	KXd4E+LVYzaT7kvIxM1FVNu5Ok9/be/hmQ4DYj1nmpxxSmjjQkoFmX9i7Wh94uHQytzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIF77-000bGb-RC; Thu, 30 Apr 2026 02:18:45 +0200
Date: Thu, 30 Apr 2026 02:18:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jan Hoffmann <jan@3e8.eu>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Damien Dejean <dam.dejean@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: phy: realtek: support MDI swapping for
 RTL8226-CG
Message-ID: <fe792ddb-a5b2-49f4-a888-5b38dc068209@lunn.ch>
References: <20260429211235.2607782-1-jan@3e8.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429211235.2607782-1-jan@3e8.eu>

> +	if (!swap_enable) {
> +		/* Patching is only implemented one-way, see next comment. */
> +		phydev_warn(phydev, "MDI swapping disabled, but PHY is already patched.\n");
> +		return -EINVAL;
> +	}

This appears to cause the probe to fail? If so, it should really be
phydev_err().

Otherwise this looks O.K.

    Andrew

---
pw-bot: cr
