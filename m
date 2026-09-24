Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FE33B995D;
	Thu, 24 Sep 2026 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790218280; cv=none; b=BScDjXnwgN+m6j++YnKboJYB69P1tXsLFPOHN0mRLaCP2VoxqafZ7raxEwFb1C6QeTvZjf5LuTfQivvCPeBP+/DNsL1x9HXeMFnVcQwr3T2e7NTgXYxmJA1zJhWoFkalWGub/9F4d9bPB6HhjQwbvzkECoSFdoK7aLK4/wCNo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790218280; c=relaxed/simple;
	bh=Gy/qa+NbNLt/dx3hCaZU3UQrKU1LA2ULNMhU+gsKr18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1esQKM4aBOUE7jDeQpTtQttqAtMKd6GrfrmMXcy5V6TjT+hkwWpnG2HHUU8zrbT2ox0NNGiz9/YzKGA73HRyScMOI9LY0eaU3jVaZgEIL8y+ioYkjygFsWX98Wv10juq25HcpQ4EWSEyZfA3YBCeZUo+SY65Bd48l/rj4lg0ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fv3iShXv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fv3iShXv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fRZRUAQGtdbTlWUxn+HO7PkGr8VFeQjlaiGB0WK3BhY=; b=Fv3iShXvZE+w3SeYUcwvo2rAPB
	PynUUtrIsHtIdN8B5n01vsVbRxnhqfcqlyNjZDfiuAKo10U82VX2bgLHZCzMj0bvRHBXFzlDfsBMV
	vHFSViWHcsbtnKvKqdiOVdIIGtf31Za4i/ravf40Oxouur/zHQrNu2MDalCz3Dr0FcQI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9ZY9-006uqZ-1t; Thu, 24 Sep 2026 04:51:05 +0200
Date: Thu, 24 Sep 2026 04:51:05 +0200
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
Message-ID: <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
 <20260923215858.1653-5-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923215858.1653-5-yongzhao.derek@gmail.com>

On Wed, Sep 23, 2026 at 11:58:56PM +0200, Yongzhao Chen wrote:
> Flag QCA8337 internal PHYs used as CPU links for SmartSpeed suppression.
> SmartSpeed is the Qualcomm PHY driver downshift feature configured in
> register 0x14.

As far as i can see, nothing configures register 0x14, so this is not
very useful.

Please look at other PHYs which support downshift. There is a tunable
for it. Also, the read_status is expected to return the real speed,
which often is not in BMSR, but in a vendor register.

Is there an errata which covers this?

It would be interesting to know if downshift is broken in general, or
only when used in switch integrated PHYs.

What might be possible here it to look at phydev->is_internal, rather
than add a flag, to differentiate switch internal PHYs and discrete
PHYs.

	Andrew
