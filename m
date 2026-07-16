Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFD5336EC0;
	Thu, 16 Jul 2026 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226747; cv=none; b=jwQeJp6v6MAYhVVTOTL6woPpqHDmFlgbv2lnqZ6y3Fs4lhpwYzTKZ+wDemad/848X1i9or1hwC8o9x0fVnrkjpvBToQP9d8Oxdb/MWrurrTpcUCuSnh76xEedvO1oFXN/0RnOC5K0yxwtn5712b9CXT/1DEG6GJCAzHhKVambOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226747; c=relaxed/simple;
	bh=EfQs6+wNNb/9efWhP7XEPNOFW5aVo5BqNQQkEMuR7xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hyA2S7d7xLsWzv5TDYDPHOcmB8nxOi9EoSZcURqHdEy7ePuDu9PK3ltmXBeBwWOIO+Rj8QJ6Ae+EYhnGtM/0FxKLhrZaXbjKG8p6h7JbbgCN2Eujp9j4uBBrG4AeHZEoU64ehiUBVWobYlXLP78fNyqu880Os5nNQquepClLdRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ljLNnZkN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ljLNnZkN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z19MpaSTimTXpDTgIgf+WTg7/YH7/BLGU5EcmEIpnlA=; b=ljLNnZkNasfSLnAUBBdo+vpqVa
	8h5YiadwuL1mLKcGxdq2oKMbYBeDD43ijoju1DZcG+O5Oc9mPmbpg4EE8uSNI7U7g6BR0R/fbkZ34
	lfe62ueCQmO3QbXDQLLG8LT2/guglLPg6+Xm98UQsdrGSww45ecorv866l6pqpxljl2A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wkQsU-00CbrF-2C; Thu, 16 Jul 2026 20:32:10 +0200
Date: Thu, 16 Jul 2026 20:32:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Artem Shimko <a.shimko.dev@gmail.com>, netdev@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Zhi Li <lizhi2@eswincomputing.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] Add DAPU Telecom DAP8211R(I) Gigabit
 Ethernet PHY driver
Message-ID: <05bbadc9-95b0-421e-9c5a-8223a891cb5d@lunn.ch>
References: <20260716173325.653164-1-a.shimko.dev@gmail.com>
 <77f1cc14-cc5f-4f32-a972-f0350a60931b@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f1cc14-cc5f-4f32-a972-f0350a60931b@bootlin.com>

On Thu, Jul 16, 2026 at 08:11:26PM +0200, Maxime Chevallier wrote:
> Hi Artem,
> 
> Please slow down a bit, you need to wait at least 24h between patch
> submissions :
> 
> https://docs.kernel.org/process/maintainer-netdev.html

Adding to that, there is no version history. How does v3 differ to
v2.

https://docs.kernel.org/process/submitting-patches.html

	Andrew
