Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153281;
	b=n2of0uXROiSTyFqky+3N4p8VWum6XV+eHYV4xg8USjqgSK04ks6wlfnqx0HSwu1aiP0n
	 SxluxKpdV9lKJoDNW+yo14zrdaRlCFRyixG+BjUmzD+ynaewO85Vn7wpCHI3D8PUxZG4h
	 ZejUxOXmfnQ+hQD2kiHWgf8G77PaSHa61mEyVjiA5QdY9Y6pgDWA6wOHRK85Z9jwYnQuw
	 01IIqn2zXnstAa3Y2ur1z3leP6O7tTMhVNJtFo5skhiWPFk1HCx+DfdIoPVgpEJjq8dCx
	 B0S+ThwuAB5SwdUPiqvnbUpK1+bmzs1yXEI2sEabgrW+Z5N4wEBieUNjFpZgD9Ia89A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153281;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=x975RPbjrU50lC41m9HmrVr6NK7q9GoZJG5+jFFHqw4=;
	b=R4RUZRCITp3QzfTS41t66dWxpfNWSTxIR66zy23cZFgcc57PU3QNtEOm25mw0ol4WZhK
	 FEFEZe2PdafdwJ+UOjhus9jvKAH0w9N+yiVa7qbbtCXPBaXnoCw4UXO4RP4kjE1euNKpR
	 swxvWWkdi8w/6byID41pVX1NkhKW68pBxjnhWtiL06Ea6TJiYejjSugvcABxJGsyGinWr
	 SBK2f3zfwsPERDrZjLwKnrl6NFeVsLnX4iX5xzTGnBqu3z+xpzkyZdNu+UEVf98j8Pz6A
	 fq3Fxx9izuDbavOfsW8oSlFBTtoqlDLyEcmaNYDVy40fhAVsd5edMNcUQ5rIWjUuvWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Q6z2hs+y;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80CB606A31A;
	Wed, 28 Oct 2026 02:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Q6z2hs+y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=x975RPbjrU50lC41m9HmrVr6NK7q9GoZJG5+jFFHqw4=; b=Q6z2hs+yY4rVCwBAW1v5bDfhbc
	/YM28bMKMNrW7s2hX5/5WTigXP856vo/9TrVFTFfkQxkcYvK+2nx7IW6XunU99c84Gy2thnSSN3Ad
	ecnXZdpSF+X98YRTdpfuEO0LIceyl6/yu/rg2wsz86xHDr1hGrLnYkxVE79bN4wcOWao=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLt4p-00D2ks-DD; Wed, 28 Oct 2026 03:07:43 +0100
Date: Wed, 28 Oct 2026 03:07:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com, daniel@makrotopia.org,
	linux@armlinux.org.uk, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v3 3/7] net: dsa: mediatek: add support for passthrough
 mode
Message-ID: <d4564675-fa56-42df-8c5c-cff14f7884f9@lunn.ch>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-4-cjd@cjdns.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028011317.1557238-4-cjd@cjdns.fr>

> +static int
> +mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu);

Please don't add forward declaration, move the code around.

       Andrew
