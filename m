Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5049B218;
	Thu,  3 Sep 2026 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438745; cv=none; b=HU+K+gNw2zNEThTdqsxHhxGCLtOoO6zY5zd3LVWPPVhCtF19PDa/fOa+9XRWh+LcjKe5TIiNd3348SJVBe3C5LVzxEGy50CEql7ZJPuSxOR4AjUBNaadVuYuie0aYc1KjhZQqCQvN/D4x6z8O130d+buyMeSMQkVotjKKd9efd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438745; c=relaxed/simple;
	bh=J/492hMOKyBGaM+3iGM+ZCs9lxLrvJV5w7DO+RwkAnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inpq/V6xYt3KVNH7VUurYjKSin+qgt84bv3KwdJHguZKqDYxjFaZhrJn9fW2CrA5Q0X6lcAtTGIwYPeRVuuHToKtQ+k2BlHYJWE56oK2JdThNKzEMsAGeYzGln5Ynx4M0lh9rPqVFsMkbZwylNOQDBkSRw76cMXuZG/OA1TreEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4mRX585Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4mRX585Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qFKWNDBvBgnwTaxe1hyONp7XRCWlf/Jf5MKWkbrYx4Y=; b=4mRX585Q6zNO1FC8tqL8YuTYEM
	ZnpFFIM+uQEuVpzIqq2sFa969n03zZt+CfmBgQjHSXMUaD7lfREcD8W63rvZOaFKA2U3JoIil2niQ
	S517kiNvXy05ka50xj1/qnP/yW2ysQROa4lQ0jYhJ83AQs2MTjqj1J+ilZdM1kaMtkSA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x26c0-002inM-Ga; Thu, 03 Sep 2026 14:32:12 +0200
Date: Thu, 3 Sep 2026 14:32:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: mdio: realtek-rtl9300: Support
 non-default clock frequency
Message-ID: <5335179d-0820-4f54-972a-97b7d9f81973@lunn.ch>
References: <20260903122119.2638354-1-markus.stockhausen@gmx.de>
 <20260903122119.2638354-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903122119.2638354-4-markus.stockhausen@gmx.de>

> +	if (of_property_read_u32(node, "clock-frequency", &freq))
> +		freq = 2500000;
> +	err = priv->info->set_bus_frequency(bus, freq);

Please validate the frequency, return EINVAL if it is not an exact
match.


    Andrew

---
pw-bot: cr
