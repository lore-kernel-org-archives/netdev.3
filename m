Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825501;
	b=K6ABwXfksSHwkI7F88hPQsygBBlGMGz3nccvbJ3phrloZgcfq1JeCKtlxqkKrZCklaI5
	 FM0ABwBCPq2vEqh6yxPBHyWuEoEaXvbpdJoMOTsh9yM2dRMmkY72DldR/YawsIzN7QuHA
	 seiJONEFm40GRsqZiE01wjGEtFDx2JZ7wnmluekCO3zpUz8pkQD2o34CwnZwrMkqGvxIm
	 x97Gk7AYcoDrCDD/MmNiwcF6tExZ3DqcqHEIPMxFXBhEdq9IMsUuPL0GeLyzhFbJtHZqQ
	 BWqiPwBssJj8SmibrmWgkskZQvCNadIh5a8mZeyEyi5ogLKK9LdnymxwoBgu09bYgyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825501;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ZfTs+ryizwPn0Cl3XX+fYi34UNKxEvbPC3g5XcJfRFc=;
	b=dYJTLAp/5N4zIID7Y6IZ8r1bbODGWq0q+oYCKO3rjubo74iC14O62YoVwIWq8A1+kAbD
	 wVPO3xGf5aHGJMbPwsCX9vFHrIkn4hBwXLIKCkieGIXTKSXxDdRO8mX3JOEJwScRT0YoG
	 HIxBNwoChT5b0gzjSNSOctW5B5umvnVqDQUuv4gGpYqkCZBdixfqC17kFRZEy+cZmV4Sx
	 t/rm5sOcQcblOC1SDbGvheGldz/u5zQ6I8KFDBMZbLEFTl65oZVP0NjXgQCuo0H/dEfjG
	 MJYuzmwjWmxUGczVjpt9p4hovGWc7sK8SMeqy5sXLQc+ZD+wBH1d2RVI+1JrpjqV5Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gYMcabrr;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7886078141;
	Wed,  4 Nov 2026 20:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B7886078141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=gYMcabrr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZfTs+ryizwPn0Cl3XX+fYi34UNKxEvbPC3g5XcJfRFc=; b=gYMcabrrRrrv8R/JgiDQxQdpoO
	B4xeVkOkMAmW5SkgjzvXAXfOQ6JqfSA21vWQ3ZWQJRkwxEO00Cr1X2Q8EZW3y3AT0vPDV9fkXqdBk
	gqDbevO66SBMR4liG1+Nj0cg3+SfEF6DPc6bOe2V8Dj/iZhjs/xwOY6jPcw98oWTSJ+c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOhwz-00ENw1-4M; Wed, 04 Nov 2026 21:51:17 +0100
Date: Wed, 4 Nov 2026 21:51:17 +0100
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
Subject: Re: [PATCH net-next v4 5/6] net: phy: mediatek: add calibration
 logic for AN7581
Message-ID: <68eecc53-ed61-463d-bb5f-c68b507be82a@lunn.ch>
References: <20261103221439.30502-1-ansuelsmth@gmail.com>
 <20261103221439.30502-6-ansuelsmth@gmail.com>
 <2b744929-609b-4529-8b6b-30feb3ebbbde@lunn.ch>
 <6aeb7861.6171b307.11ae12.6b94@mx.google.com>
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
In-Reply-To: <6aeb7861.6171b307.11ae12.6b94@mx.google.com>

> It's safe in the measure that the worst is that link goes down during the
> calibration... I will rework the function to assign the base address to the
> default address for port 0 (it's hardcoded by the SoC) and use the lock and
> read/write helper instead.

Are there multiple PHYs in the package? What happens if both are doing
calibration at the same time?

PHY #0                            PHY #1


phy_modify_mmd(phydev, devad, regnum, mask, cal_val);

		       	      	  phy_modify_mmd(phydev, devad, regnum, mask, cal_val);
				  ret = mtk_cal_cycle_wait(phydev_p0);

ret = mtk_cal_cycle_wait(phydev_p0);

    Andrew
