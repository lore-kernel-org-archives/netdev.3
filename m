Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98653330D35;
	Thu, 16 Jul 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210129; cv=none; b=PPzE3ajRreWkNhm605VBlLFICsAtCe5moVWJEYJ3adOu+ScXeegiGU8+/mTbY38fpeheFOwpGJ7x92NZNTHW59yM8NEs1M5p4n17qyFIqjQZOCKw31OCBRPW4ei1fj3mq1P5EoDK8CE3Gtx/Hg1eYRgitl9aDYL14rBGtJt0FcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210129; c=relaxed/simple;
	bh=gvXFjOPykqDql/p9B8mhilpMKqLdkfhPnV65gpA7FTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmshLuPRJaMgD3q6P+dvpkMhfXyVs0H5x1MGlHhgCmMBxrnjg6L1gS8mTNbRWwp9+v+WdGBHPVZiV5mwdpzF2zkKJPosRD4bLKcHp2kkJrSFWaeIIkB+U/uTrxgW7hOKH/EF3Zuf6AUuiPr6IVJctaWVSqUR9tXhmeNHq5GlC9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fseFKIbq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fseFKIbq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GDFKz5jKJQX9s45qo0f8KCysTxh9DEvXf8Hx/7+Fx5M=; b=fseFKIbqtaVNU1TL0i4IUrc9Hv
	+5g3yamrwwEmokIBCQ8DYWafFeARzVXWGe/zvbQS6NJkP+YP5CEv+M8UV887we9/Zs0bm6PQ+9/Zk
	AgUGxYaFdMYsWIJC2qfd+u5REOURB750Y9MQABsCaGCPvPgD0al0Ah2ID0tWKNUnsB1w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkMYZ-00CXgk-VS; Thu, 16 Jul 2026 15:55:19 +0200
Date: Thu, 16 Jul 2026 15:55:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: add DAPU Telecom DAP8210R(I)
 Gigabit Ethernet PHY driver
Message-ID: <f3be1229-1d46-4cb3-a83f-0715d6789651@lunn.ch>
References: <20260716113805.593215-1-a.shimko.dev@gmail.com>
 <20260716113805.593215-3-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716113805.593215-3-a.shimko.dev@gmail.com>

> +	/* Wait for reset self-clear */
> +	do {
> +		fsleep(20);
> +		ret = dap8211r_read_ext(phydev, DAP8211R_PHY_CON);
> +		if (ret < 0)
> +			return ret;
> +	} while (!(ret & DAP8211R_PHY_SW_RST) && --retries);

This does not have the usual problem, but it is still better to use
something from iopoll.h.

	Andrew
