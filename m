Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B784B0481;
	Mon, 17 Aug 2026 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977870; cv=none; b=XoYWfLeMBMTFkP7mRGBU5ZS1x9Md42/AD/ibq8jSjtetJY/w7LLxYtzoCB7Fh7mVg81y9P1PsFEHfx1hjvbrcF4GJmSg6XRIlRftflczyfBsLaZuBXtw9EAkkvBva1exiLYPHeEqkOt2B9G3yfO1SmZAy1MZcodBOfnXX6oEWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977870; c=relaxed/simple;
	bh=HKr2xofbpQ9JXO9MwzuOe+My9ze3UmLLYAlUCLzVVJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPnLmcH9hcBfi9Nklg17er6nBQUehuicBW8RG2eobndLjgo1+LLLPmfMVRKeBlwD7YrwEaDPNDe1cQoMSsgkEnJNdKQJein1b3sEO2aC/FLMsjrTuZKns2uz9Q/JiR5Ih8eSqBAZta2AEzKgaF0wnX3wy7qnyHFDREliyoIFNzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mKmq2bln; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mKmq2bln"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HdLoMqbL7qXLDhoWje1djVaYXM6tXzZNds/0c6IvUfA=; b=mKmq2bln0vJO+ZFR713syCiQRg
	M9v8c9OUZu9TU4CYjMzWJzKFYiMu0ydPS0OZJ1tOWZW27L4x4ekzi9h6UQlVJLH3z9V1qH7nrO8+X
	PC882ycsLMGLAJMLseWp4ILY6FeP1st0uWNjjHCUbgjdmzFi5HCrYAVTQTHg1YO8bXBA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wvyZU-000KEX-6O; Mon, 17 Aug 2026 16:44:16 +0200
Date: Mon, 17 Aug 2026 16:44:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: use C45 for
 RTL8365MB-VC internal PHY MMD access
Message-ID: <b037f809-4d75-4b59-b47c-c14c166379e9@lunn.ch>
References: <20260817134758.4182833-1-o.rempel@pengutronix.de>
 <20260817134758.4182833-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817134758.4182833-2-o.rempel@pengutronix.de>

On Mon, Aug 17, 2026 at 03:47:57PM +0200, Oleksij Rempel wrote:
> The RTL8365MB-VC PHYs are integrated into the switch and have no MMD
> registers of their own. What phylib accesses as MMD registers (EEE)
> actually lives in the switch's OCP registers; the realtek DSA driver maps
> those MMD requests onto OCP and exposes them over C45.
> 
> For a C22 PHY, phy_read_mmd()/phy_write_mmd() would use C22 indirect-MMD,
> which this hardware does not implement. Point .read_mmd/.write_mmd at
> genphy_{read,write}_mmd_c45() so phylib's MMD accesses go over C45 to the
> DSA driver's mapping instead.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
