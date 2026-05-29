Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFBE31197C;
	Fri, 29 May 2026 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059855; cv=none; b=D1GXac6CXPc2CaA6oEm4HH7zwuREXBGH9CAF5rppDezFd5T0KYk0yhIDKstKvKx8Cq42oL91q3eobdJ6lyrkwz3r1plI0zxLGyax2Yrp3Mjtp3RAxvMybAjgmJBp0oBgWOhNjIRZyiJO1X0m21MSVhoErvKcAOZN2PmzJzxorL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059855; c=relaxed/simple;
	bh=OVQ0tA8+eFU5RLkX369uWTW1RTrTI3CHGxuTvryVfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTw76OcRK2GOpMOZ7vTkJetWyf8TLb3RliFLWn/J+OaZdkRUj+DRkzINKrTuN8jkuRoPcUR2RjAh6dpGPR8uE6mXDpqMLJDbBiQB+/zV8l7GzZxNKcQRwf9HnYnnEySl3sJDwvQcjqmVnqeQL/00403CytH9cMYksQOrfXgbopo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tlLWJsVY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tlLWJsVY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BUsVTXtWac4HLSNT5dWtOS8zRSibeIPlKQyEy6fXA8g=; b=tlLWJsVY8p0/R9sesXCKHs094J
	PosCTQnW6A1Z05qQit3q+/aGqEuX1zhMcb+gezKm0VEXGYC23KIc90iqxTMMFcsVCWJWPdNBvjzYl
	lba/KNhFT6+GdSzG1ehzr+OyNAp9W9ub7MiLNATP9fRVBSj285n6FbYOmsfbv++53v90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSwsY-0055SF-7z; Fri, 29 May 2026 15:03:58 +0200
Date: Fri, 29 May 2026 15:03:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: ciprian.regus@analog.com,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/10] net: ethernet: adi: Add a driver for
 the ADIN1140 MACPHY
Message-ID: <a272f9ae-1958-456f-b177-7c966694c047@lunn.ch>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-10-37e5c8d4e0a0@analog.com>
 <ahlY8WSRO_HPmGtK@nsa>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahlY8WSRO_HPmGtK@nsa>

Hi Nuno

> > +static void adin1140_stats_work(struct work_struct *work)
> > +{
> > +	struct delayed_work *dwork = to_delayed_work(work);
> > +	u64 stat_buff[ADIN1140_STATS_CNT] = {};
> > +	struct adin1140_priv *priv;
> > +	u32 reg_val;
> > +	int ret;
> > +	u32 i;
> > +
> > +	priv = container_of(dwork, struct adin1140_priv, stats_work);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(adin1140_stat_regs); i++) {
> > +		ret = oa_tc6_read_register(priv->tc6, adin1140_stat_regs[i],
> > +					   &reg_val);
> > +		if (ret)
> > +			break;
> > +
> > +		stat_buff[i] = reg_val;
> > +	}
> > +
> > +	spin_lock(&priv->stat_lock);
> 
> Maybe consider using scoped_guard() and similar for other places?
> Marginal win though so up to you.

Please trim the text when replying so just the needed context is
provided. It is easy to miss comments when you need to repeatedly page
down, page down, page down to find something.

> > +	ret = register_netdev(netdev);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Failed to register netdev (%d)", ret);
> 
> If we go to devm, this could be return dev_err_probe().

dev_err_probe() is not really about devm, but handling EPROBE_DEFFER,
and not issues an error message when it is not wanted. I don't think
register_netdev() can return EPROBE_DEFFER, so it probably does not
apply here.

    Andrew
