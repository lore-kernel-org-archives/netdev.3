Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5CA331ED6;
	Sun,  2 Aug 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683117; cv=none; b=BciX37VxWOb5UMqtCVRr0xoQvCoRx9qmxyR57ZKY6D9/qqh0fKmZqfY9bKWffiB0S4X1rqIKEatjrHz1EVKp5KD1PdeM2GLIBugJ/RqEppxh7rZq9XsWYIvA2CPgnFRu0PezaX9XahZGlPWojCx275wzgg05QGkWIYiX11crVmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683117; c=relaxed/simple;
	bh=rv3migE+Az7Osn26SsxseDqtwkwqDZ+JmPVfjRBz0Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cee4zz01FUi+xXW9jYxifMud0l9rVABSSKw/3ePGyxjggEWHkmk/701iPhD3B/fLgdqVVpC6I2TyduIjIVJ1KmMtiRw3/QOKOPnPRJbE+5MRqLrkxN3GRYBerc2SXYp2Op8WGs10xjRR6C4doFjQzb+V52n/IX/vVpazwXVLXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BZf6BNRe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BZf6BNRe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tdjigNFHWB3jQTq+4XuaBomV5UiBENOmHkaoKMGdJLU=; b=BZf6BNRerzS5jRiKTVPr3hhSK1
	VKG760xjgNgyshECm1hKtq/DwNSUbmKYvPm2OCfmMujhz1HokK3HrErRBjC3HPuVR0D983gWdfb/i
	/4/xU8Culb0mXM4Gtlk/c4Cakbp5/ge6JyjQBAnDDYsfYytu5owyXwXAZtffSDY8fmso=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqXkP-00FaM3-E2; Sun, 02 Aug 2026 17:05:05 +0200
Date: Sun, 2 Aug 2026 17:05:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 2/2] net: stmmac: ethtool: Address off-by-one
 when reading the coal rx-usecs
Message-ID: <4e76d7c1-0052-4689-be7c-9c31dc24516a@lunn.ch>
References: <20260802114015.214212-1-maxime.chevallier@bootlin.com>
 <20260802114015.214212-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802114015.214212-3-maxime.chevallier@bootlin.com>

> This does change the boundaries of accepted rx-usecs parameters, as the
> previously accepted values were in the 16-246 us range, and now fall
> into the 15-245 range on imx8mp.

With this change in place, what happens when trying to set 246?
EINVAL?

	Andrew
