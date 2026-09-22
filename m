Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207C154147F;
	Tue, 22 Sep 2026 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790080452; cv=none; b=B298xX08+CsBdtd0LNBbXi3h382wg0sJvrDEJcrcqpOqu5AZKWawWYKHDtsq+vlJhNiqHyrQciyAWjYDP+HZb+h2gT8pEV5+D+RhKiABQ2EnRvJlCfBDlWZL8EYjCPIbH9rdjcx5Ztqj/pmv2Oyw7FwJwUMf70zz+VUUvsZKVuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790080452; c=relaxed/simple;
	bh=Dqvs0rgUGSexRgQ+KJdh6fBoIAiLyge9y9+EBKbrZE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNf/7Cb75F8wY/R7xNxzPx06if7Wj2cJ+XfLJx3qsf/2j287I/7gH8YI7VpaWnrTLobgCD05ryytUEK/uRlK5UMUyOFIvrXriFhdZCELHGd5sTSIx/9E6Xpm3rweEbABOKRJ1gp6/TDLQRPhwcHgPkOAv12xykVU5ihlBAmmrQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Lf6S8LmW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Lf6S8LmW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jb0fX5ONx8zXHS4pu+Mu0wsvWmdwtiVXcv1U399pV8A=; b=Lf6S8LmWwlRiCwjhZtaQMkvMuS
	geYDhrwj/zUrHagz9BowKvO3U7q3T5kw3K8yqseBLtpENL2Utn4hPXM9LBrlWRzbTFqD8KR4ajGb4
	RDSCHCdIewZGMJ1XN1f1Wiy+J56CznnCnWWnBmQNav/jokWrnI4a307/xxE8WNBqoSbg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zh9-006aTK-W5; Tue, 22 Sep 2026 14:34:00 +0200
Date: Tue, 22 Sep 2026 14:33:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: rouven.czerwinski@linaro.org
Cc: Xu Liang <lxu@maxlinear.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: mxl-gpy: add 2.5G for MXL68211C
Message-ID: <b281721e-fcb3-4302-9bb8-589333d9cda8@lunn.ch>
References: <20260922-mainline-rouven-mxl2g5-v1-1-a0ed53631a5f@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922-mainline-rouven-mxl2g5-v1-1-a0ed53631a5f@linaro.org>

On Tue, Sep 22, 2026 at 01:25:09PM +0200, Rouven Czerwinski via B4 Relay wrote:
> From: Rouven Czerwinski <rouven.czerwinski@linaro.org>
> 
> The MXL86211C also supports 2.5G via 2500BASEX, switch the config init
> to indicate support for that mode. Datasheet checks indicate that the
> 2.5G speed indication is the same between GPY211 & MXL68211C.
> 
> The same should be true for MXL86252 & MXL86282, those are not modified
> for a lack of testing hardware.
> 
> With this change 2.5G negotiates correctly with a Mikrotik
> CRS310-G+2S+IN.
> 
> Signed-off-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
