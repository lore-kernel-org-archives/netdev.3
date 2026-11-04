Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759942;
	b=1ckhxscXPKf2LTbPmOL+dCEILwZrpGIn+gN4WWHgwfbStrZqmLYX0em6BQebZ7C9IC1K
	 qQBsQ2DkEOhwatUCQGUNYuHx8w+38jEfM1DTLgsvGhfGb0nmGrh1HlsyOlb4fwufOfRYl
	 7xw80QKJyIn6vk1nGMfhgbn89tTW4Aw4dohkT5MvGUUXwFEL21doqKUuu0l3mBfmTcV3b
	 OJHzzXZKj4JfpTwVNOIYrbVofhcutfW8MFzCo4VGxVOYbPNPIJP8zFaH3VJlO/Sl2mLql
	 vpguD8BJo6a/tqIjwkAQhtDpovNCey9AqRkO+VKuzp/gJqn742EENb2qHN4Bh6p2c6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759942;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=fU2ChYjBPo4nvLGQJzBPlznzncMEQQvQBt25dnNrUZA=;
	b=HMk7V/nLOmmRAXil19eFTCc5N6S8xRnF/KJqPkFFAKLbDJeb9zRy7OBws09buM87PDRK
	 6Njba4UgUzOFXo/1vdwJ6qg6v5XFKU3q7ImkJhgI8uqDwdX8CplZgpwKk7VVoL0vR00K9
	 kaKb9+Xu6Jc3jaePyfYKHzIYO0g5vcgbrs/cxgnf4RV3qU+ZNordn869btOzdO/VlYg95
	 7q6+z6DBi1NdoNE6g1ZSrEQk4kiUf6TOVkbWE7yJA7/xgHMv6g/3hS0krFDPL4EH4fXZ/
	 93CsoFA0KWjnscM2k8O6AUQxJQqfDV/xzehOmUHQgs/huQZBOcFHhUM52tY4smwXcRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=byp2i7pb;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742D606A326;
	Wed,  4 Nov 2026 02:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5742D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=byp2i7pb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fU2ChYjBPo4nvLGQJzBPlznzncMEQQvQBt25dnNrUZA=; b=byp2i7pbwSpJjX7Rve32SDJOEe
	DNPA3fxdUxb94g17nXBBVarGELm75stL4Y52Jw7LARakl6h11TZNGbVVhlNGtkJtfowWzmSmLp+Bf
	4haX3JtFT2RcdcaRWt06zePifYhNUkGzei6pMmD5Lb3WFA12zL+CO5JQCpxSCCWUuyHI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOQtj-00EDr5-Rq; Wed, 04 Nov 2026 03:38:47 +0100
Date: Wed, 4 Nov 2026 03:38:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	Ahmed Naseef <naseefkm@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v4 4/6] net: phy: mediatek: split Airoha code to
 dedicated source
Message-ID: <5cc94032-60b6-4154-bf19-26fce16e738c@lunn.ch>
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
 <20261103221439.30502-5-ansuelsmth@gmail.com>
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
In-Reply-To: <20261103221439.30502-5-ansuelsmth@gmail.com>

On Tue, Nov 03, 2026 at 11:14:35PM +0100, Christian Marangi wrote:
> In preparation for Airoha PHYs software calibration support, split the
> Airoha code to dedicated source following Mediatek naming pattern of
> "ge-soc".
> 
> This is to tidy things up and not overload the mediatek driver of specific
> Airoha code and ship a bigger PHY kernel module with dead code.
> 
> Move the shared LEDs function to mtk-phy-lib to permit the split instead of
> duplicating the code.
> 
> Also add myself as MAINTAINER of the now new airoha-ge-soc driver.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
