Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCC04EB85D
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110729; cv=none; b=S8EH1rIPfOIW141/AgnhobXf96OS7lQziNNXilVqjJF+PWx2abSE5baPGZH9sLQ3J7tyW7sCJFvQZ7lsJbFXI2vPyeBSfJoXio54i01Q+Df1p66f0yNC/JJQrZuCjb27kZhUmzA6G6f4Zbn286Ub/9OM1xw8Akp05/neH2tUJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110729; c=relaxed/simple;
	bh=UbaliWE/YD28fBFM0MVPHHZQHNhXa94Cxh7iHoEuD5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pi8G+Igt5uibGAAzsxN2HL4gbLaXRqpYw5sFozzN2wrUgIdSQ1EhHWOmWEkQ14dueGSN2Ex4sNgxxn9w5SdNJmzSGkyl/eLqVnK3Ps9QskEUP/HF9hBX4D53THhVAflIrC9Z9qMrZM50lWy5sxlgb+hstH1r34+wSfk0IZxU+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=r5DFGBez; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="r5DFGBez"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1+xITx8js2DQsjy0n+Ednm7CqhnRyed1CwNs639JXng=; b=r5DFGBezJxbvo02vDnfCGG5k3M
	UAHk2UKjInMeAZmRAz1ib3ApaFkGRIsZJiyHxCf/35axFPslsU3YpBJCvSKN5ILGIBDCO5XWHz196
	z0Z28wKIaLIoOVYYbRNIknQGnvg227fHiF/SmDNuoQQcOm6ojawDcpX3B6qHRTJN1K+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x97ZT-006fod-K5; Tue, 22 Sep 2026 22:58:35 +0200
Date: Tue, 22 Sep 2026 22:58:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, ansuelsmth@gmail.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk,
	florian.fainelli@broadcom.com, jonas.gorski@gmail.com,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	hzyitc@outlook.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Subject: Re: [RFC PATCH net-next v2 3/5] net: dsa: qca8k: serialize CPU MAC
 pause during MTU changes
Message-ID: <367cdf4a-6944-4df1-a218-28fee926dc75@lunn.ch>
References: <20260922202653.1153-1-yongzhao.derek@gmail.com>
 <20260922202653.1153-4-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922202653.1153-4-yongzhao.derek@gmail.com>

>  	mutex_init(&priv->reg_mutex);
> +	mutex_init(&priv->port_status_mutex);

Why not use the existing reg_mutex?

>  int qca8k_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  {
>  	struct qca8k_priv *priv = ds->priv;
> -	int ret;
> +	u32 mask = QCA8K_PORT_STATUS_TXMAC | QCA8K_PORT_STATUS_RXMAC;
> +	u32 status[QCA8K_NUM_PORTS] = { 0 };
> +	u32 ports;
> +	u32 stopped = 0;
> +	int ret, restore_ret, i;

Reverse Christmas tree.

	Andrew
