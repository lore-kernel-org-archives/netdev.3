Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD4327C13;
	Thu,  6 Aug 2026 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786025583; cv=none; b=ln/h1eDEMTzhku0NNvKvZ4yee5G0wIF9dTQicWDxlxf+UEYNJ53K2VHZgYI+iwsl8UCtQdqyZ9aL0ebMxb1WtwRh5mxpE/8XMAWgLFjFHAK6+3kL1nrqAKeTfD1Gj3l20eS2LS/Kdi2nakzGFIPRybbUXvvZOnAmzybTWEf3PNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786025583; c=relaxed/simple;
	bh=YJaunE3oTPQ3gffzKmm3eA1vuU19wjIh21oZNkffK6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klPnQ53NXMmuDypJWql6Czl7h5gZppHiabXynRJd+fUZv2TTHHRV1MBEIVRSOHxCxRT8g5w5cCK2X5vbkxcCm06f2M3RZGxe9PSArmgHl1egRwILaFBmgVPkJXIgHnIIiC3wkQa2+o5huoUCpFfPrOLK7KTKh4rvwqm/l0yqgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=30OvKTZ9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="30OvKTZ9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=121xU5dcoWPrnt5d8/n5EIpr7xqyUdpe+00oIJZeCSY=; b=30OvKTZ93ZAPzN2IIMTu+j4NtB
	mYGNYIseKxc/5Cq2OnDfvDU8DuE887YGRWosXKtoxv1KshILhrzgzIugsM21ioKDH648tG0d2/PL8
	rC6kk1THIiQy0lfeLLry54someGZ/uVlub7ZKjcVWhn2Y2GVFAimr4mGkwE8mO+rahFI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wrypw-00GO5x-3Q; Thu, 06 Aug 2026 16:12:44 +0200
Date: Thu, 6 Aug 2026 16:12:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 2/2] net: dsa: realtek: rtl83xx: add support
 for enabling supplies
Message-ID: <9181f24b-cd5e-46c8-8e57-cbf309ac1a98@lunn.ch>
References: <20260806140239.3518906-1-o.rempel@pengutronix.de>
 <20260806140239.3518906-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806140239.3518906-3-o.rempel@pengutronix.de>

> +static const char *const rtl8365mb_supplies[] = {
> +	"avddh", "avddl", "dvddio", "dvddio1", "dvddl", "pllvddl", NULL,
> +};
> +

> +static int rtl83xx_enable_supplies(struct device *dev,
> +				   const char *const *supplies)
> +{
> +	int i, ret, count = 0;
> +
> +	for (i = 0; supplies && supplies[i]; i++) {
> +		ret = devm_regulator_get_enable_optional(dev, supplies[i]);
> +		if (ret == -ENODEV)
> +			continue;
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to enable %s supply\n",
> +					     supplies[i]);
> +		count++;
> +	}
> +

I've never used it, i've no idea if it is applicable, but there does
appear to be _bulk_ calls in the regulator API, maybe which is similar
to the clk _bulk_ API?

Andrew
