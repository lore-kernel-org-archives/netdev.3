Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552996;
	b=zQ7NlcLhUPLL6M6/yzMc60zhRiCCuhw6Lg6Vex/IxRNpiq62gnOvX3bMaZoiMJWEsjnF
	 tfU3a/VcZiAL6pCz3jOt0RxuMdU+hut1WswK7qjILXAnQrShhRMUE0ryqHRDAyByDZ6zO
	 wcskP8ErPg+YWhmnEu6ahIzwkDIWxq8T2ZkfyOBWBnfgSJYutOzHicWd8ZJYO9V1TdmmM
	 otoRW37PUNnwODfg2j+kFTi4DMcIAu+nnbxdv7ajszmaphpOFwLuMFSypMYg6obImGRSt
	 QBLP0MVQwAW+XALrldFARUk/o0pbGM/LmUHiu+YCeVJ0moYOuzhSO2OZBvDKe1K6WCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552996;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EoEfAeSybTxuqzMkNSIRNSyEGqk93d2SQGJNTzWg/3E=;
	b=Pkw3lsaQ4qB3MIt8hfESgXOgtkNVMKh0NBXMWPdtt92PSM+n2U9pshZTUrN57Lbbyhuh
	 4TBN5RR+dy3xuZgUO98BiMnIjWO2BRtyhsl7iouj6UviF/tHH/2wAEI2silD+HI8Ijj6B
	 IcvR2tzMQjn1tc+99L5wm0GMibfw+gvAkm3G0J85n0YC5+Sr2EnzIYSRgxRReeO/tBnKy
	 pX1mnwUhWvkNbYs80lruMLPEF23mDRmIX0gG9YitXSGq9SohpjHxJXyVnCrvCpYrIvwlR
	 sPDjUjrdHDvTDirZLYB6viHnKNbLKNWRvV/r8Z7nHtzkt6PamwI2TlT0dsAMOa+V3pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGtWAUF3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3E606A31A;
	Wed, 21 Oct 2026 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IGtWAUF3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D011F000CB;
	Wed, 21 Oct 2026 03:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792552996;
	bh=EoEfAeSybTxuqzMkNSIRNSyEGqk93d2SQGJNTzWg/3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IGtWAUF3AT6TxqqpSdCCBxOtXiXhnF5JxrTYl7yBFz7GTtWqr46NZHrOxFvxFx6WF
	 NIwT3NdYfw4wswzUlJ01U92L1JnQ+i0Gi5gveJ8Jpnm9K/58fuoWK76BsQiekDdzgi
	 QYusvQiQAVA/H9wnKvkcMHbPTCzlPLzRNuf1QkGiX+A5Pdhsz3hQeglSCJ0rLd5gKl
	 dK6mKfErvODpxaADJGiIKYLOwu42oyJxTAuKRlzUglmAwhyby7NcTuwIJa1geJaZa2
	 TJ05+WouaWUFUThVufwG0jhYVtOuy+CmBs/wxnn71t+aN/KlLSaUlrcXmn7Q7j0RyN
	 U1/5xLSBCZFlA==
Date: Tue, 20 Oct 2026 20:23:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maxime Chevallier (Netdev Foundation)" <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Florian Fainelli
 <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/3] selftests: drv-net: Introduce
 flow-control selftest
Message-ID: <20261020202314.114bba18@kernel.org>
In-Reply-To: <20261015134350.629593-1-maxime.chevallier@bootlin.com>
References: <20261015134350.629593-1-maxime.chevallier@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 15:43:45 +0200 Maxime Chevallier (Netdev
Foundation) wrote:
> This test aims at validating the flow control implementation in drivers,
> using the ethtool API.

Let me merge this in celebration of the stmmac CI running ;)
Please follow up as needed.
