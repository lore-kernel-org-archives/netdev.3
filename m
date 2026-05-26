Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32C13D503
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823672; cv=none; b=FbCa58J61fB5klHFy37Mih5jjb9119O6nZzsAmGjzrCpqBZBQCkqtnUoEgzy64beIube8kNgGf9YHxWNdoVv/STMoI+qAHVrlWUrxOyEkHZ7ulvxcjPhdqr19fOzVGctBaZUKzXGztyqWrdnS6EJYRMtrFSegskpDv3vJXSG1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823672; c=relaxed/simple;
	bh=o8ORo6sJ1fPhEVSNyUrL0oxCdecfR5IDBsK5tzfyPhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgKkTdwlGxXpy2HPr0r0ZnRulS6lTO6cCKqpHr4fjDVJKwY14SzwgumovCWSrtXdcZa8L1rJqpTMmAR+xNCD0ZhZOeIoGZ/DVl+gNZFlT1lCWHTHyDngh/8dZzHdy5brtzNXTKR3QvWL9B1+12ouJOk+HG2V5BhvERdtfw2ZtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hW2lLrdU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hW2lLrdU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jZkUpXo9DyNeZR9ojfq2twwAnnPFbl2L59aGFu5SGQE=; b=hW2lLrdUsFdC0hWzClA447JKMx
	UZJHfLb5wGSx53mPmqnzm4+g4zs5y0RqOPs68dpww5BqxUzCbV5Bj24iwZiImaLo3enX4LQ8VUJ7D
	KEKKdBsLD5Rr076NFVb3C+y0Mrph3kSW7cUN1E4YDeHgRafSADdbgK87K7+BnYxvfaY4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRxR7-004dbS-1W; Tue, 26 May 2026 21:27:33 +0200
Date: Tue, 26 May 2026 21:27:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH net-next 1/5] net: mdio: realtek-rtl9300: provide generic
 command runner
Message-ID: <4c270a3b-c12a-4f3a-82ae-1c6a35a89aeb@lunn.ch>
References: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
 <20260526174344.1186832-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526174344.1186832-2-markus.stockhausen@gmx.de>

> +static struct otto_emdio_priv *otto_emdio_bus_to_priv(struct mii_bus *bus)
> +{
> +	return ((struct otto_emdio_chan *)bus->priv)->priv;

Assuming priv is a void *, you should not need the cast.  You might
however need an intermediary variable.

> +	scoped_guard(mutex, &priv->lock)
> +		ret = (*priv->info->write_c45)(bus, port, dev_addr, regnum, value);

The (* ) should not be needed.

	Andrew
