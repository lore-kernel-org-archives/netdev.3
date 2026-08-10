Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421935C68C;
	Mon, 10 Aug 2026 11:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361789; cv=none; b=qsRKw3Q+g6IlmGEAL2QW73oIN3PcHe22rJJzkU7/X1Uy8VLQYVjyDEYHMQudkcNXprHeZ/jIefKZLnjLL0rRL+fK556zUSZkHzfWHpXu1qvW4Izy0wzmFgImJBKBHJO6doqEblSXf0dYz98hIXD90sQRrjAJjm8hTHqNrRlxefs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361789; c=relaxed/simple;
	bh=j+OilKFaZNEGiwVeMk+oVe1GWSo3vUeVa8Ma3gbCFwg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RIy4k7nIc4rMoHynSMRiYbmFlQlVzB1jRCaPW+cJMZiL2mkmMCBOKh4oIIlkR4Jk/1k0/4zINzFNNtQp/MQ6iLuyXCESah4VeljP1qDhcLxQDXb1GaLMnYCTJSDg581SdSZJt1Wr9/kQ0KVF6SaFfCgiirKDSndhtKZcuMaoLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=sJxsxcCj; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="sJxsxcCj"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D1EFA3875;
	Mon, 10 Aug 2026 13:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1786361446; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OJRkod47pGUKol758rbruWygNXU9G73OSiRH6n3orPA=;
	b=sJxsxcCjuvM96JRhQ5coqK3fyAjs1ySbkVj5dnl1s65mInK5b6z0qyRpIPIwRi9C7vtuTC
	XaRyFhoXJiQi0+hur5YKpIUYUvK6rSD9bWv6NIfHWXyu7bg3BJRklWEq4fW0uezp3hrqR9
	srhKQY9yAPVN4sA6tpuHxVs2mPH5DouhhAepkAvWq5PoS8bFkHaMi+spUn6gzXZy8K2Nv2
	wTbByByu77KVAKzlEgsbpbc8b9bYCIStBB60u1iYcVVriig4vZeGMePvOYwn0OtMTtlInY
	gYnCfjQl5mhPj/M4uso95m4tJBYuWmK3EnkYL4mzUOipxez3HRwQN0cLjpL4HA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 13:30:43 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: phy: realtek: fix EEE advertisement write
 on the internal PHY MMD path
In-Reply-To: <20260806134716.3511821-1-o.rempel@pengutronix.de>
References: <20260806134716.3511821-1-o.rempel@pengutronix.de>
Message-ID: <690ccf5721774e377b091ba92a601925@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 6.8.2026 15:47, Oleksij Rempel wrote:
> In rtlgen_write_mmd(), the MDIO_AN_EEE_ADV case swaps the arguments to
> rtlgen_write_vend2(): it passes the MMD register number as the OCP 
> address
> and the OCP address constant as the value. The caller's value is 
> discarded
> and the write lands on the wrong register, so the EEE advertisement 
> cannot
> be configured on the affected PHYs.
> 
> Mirror rtlgen_read_mmd() and write the value to RTL_MDIO_AN_EEE_ADV.
> 
> Fixes: da681ed73fb9 ("net: phy: realtek: improve mmd register access 
> for internal PHY's")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c 
> b/drivers/net/phy/realtek/realtek_main.c
> index a0a79192384e..177b62a7b2d1 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -1768,7 +1768,7 @@ static int rtlgen_write_mmd(struct phy_device 
> *phydev, int devnum, u16 regnum,
>  	if (devnum == MDIO_MMD_VEND2)
>  		ret = rtlgen_write_vend2(phydev, regnum, val);
>  	else if (devnum == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV)
> -		ret = rtlgen_write_vend2(phydev, regnum, RTL_MDIO_AN_EEE_ADV);
> +		ret = rtlgen_write_vend2(phydev, RTL_MDIO_AN_EEE_ADV, val);
>  	else
>  		ret = -EOPNOTSUPP;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
