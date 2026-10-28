Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153778;
	b=sK8mK9o36Cc5I0SsHXIPqu+RRQY1gGknRczJtDLR/UVTpvTUtd10evuuZ1QSM4WY53bd
	 WVqiqF9jixNNFxe3qPHNRcz1qp9Y39LAA6LJfPAdKs5iN5821cdcuvcl/3pSSenLdYIBm
	 nsAF91thc9heQhgRFeuCuXRPaa4Sagq4s8RqGrsxi/7ydKvSFsze+PjqmYsTXo9UDg6YL
	 7mDGLSnRrOiYq32UFKwNYYQI9y0FmH9WZPZxt3kpjU4M/6o7TJDQYSP85Y9hNmWwd4Xc2
	 SVgxs2/mVyhaQEn+6bSUtrwT08sefvbazZXagXNmC/ZCd7zrz2pDQIjrCOmG8MQ+W8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153778;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=S0yM+Za6i75m67uWOOTgt8atqe/7TENA3+sFmUmADnw=;
	b=JWCuBntVaQ5oFeC1BzQR3Y5MwdC5rVz8CPRzWuIB+gwX1zlMwIXkO3Fqg9LTiA2pVvkd
	 q9nKQsBdLJP9YaONRzpaTRwTpwocjjp6WlxmD7qAYa1QnCqnXre6IfSmy7rOKxwDk2M+l
	 /Vu5QEj5LCQx4+tEc98+/JkSrDqXEJsYVwH/ZoJfhHuIq+XVNs3UqCOIkIIKbc5TVS2Kq
	 RoWPXJiy7HUdUF9a+Ghh2xihxWMrHMsxKQNJPd1l2CeqKuVLgi99+UdEaSWpYWgQDox9p
	 fuO/bZlB2cFY7+kUuo/6VOCaYi5kbY+64Uw9hMun8utZjDfZYKAm3ElFL25YiLVrDcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=E3j3F7Y+;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19C4606A31A;
	Wed, 28 Oct 2026 02:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D19C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=E3j3F7Y+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=S0yM+Za6i75m67uWOOTgt8atqe/7TENA3+sFmUmADnw=; b=E3j3F7Y+u/kGXbJaO3M9WgbuEH
	w8vTnDWs03s3uQEcnY6GlWG6WNhfro/6yV0Ngud7HTlLGWFvp9FYHTF6Hp0IFmB/28PDpPdSB4NQs
	1HezBmIZWGKMi9mCnPMzSIuS6M0GllBwq36s+ZIMF+kcOGhlMwlURjT/ufM5LMDRuF64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xLtCp-00D2nO-NZ; Wed, 28 Oct 2026 03:15:59 +0100
Date: Wed, 28 Oct 2026 03:15:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: netdev@vger.kernel.org, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com, daniel@makrotopia.org,
	linux@armlinux.org.uk, arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com, dqfext@gmail.com, sean.wang@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v3 3/7] net: dsa: mediatek: add support for passthrough
 mode
Message-ID: <734d4f06-26af-4bea-9c83-eb92c1b3b894@lunn.ch>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
 <20261028011317.1557238-4-cjd@cjdns.fr>
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
In-Reply-To: <20261028011317.1557238-4-cjd@cjdns.fr>

> @@ -199,6 +199,9 @@ static void mt7530_port_fast_age(struct dsa_switch *ds, int port)
>  	u32 val;
>  	int ret;
>  
> +	if (priv->is_passthrough)
> +		return;
> +
>  	mutex_lock(&priv->reg_mutex);
>  
>  	/* Flush all non-static MAC address entries */
> @@ -970,6 +973,9 @@ mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
>  	unsigned int age_count;
>  	unsigned int age_unit;
>  
> +	if (priv->is_passthrough)
> +		return 0;
> +
> @@ -1386,11 +1446,14 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
>  	int length;
>  	u32 val;
>  
> +	if (priv->is_passthrough)
> +		return 0;
> +

What is actually left?

Is there sufficient code reuse that this makes sense?

Would it be simpler to have a much simpler DSA driver just for pass
through? Or the mt7530 driver has a second dsa_switch_ops instance
with all these functions set to NULL?

     Andrew
