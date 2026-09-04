Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717C1E98E3;
	Fri,  4 Sep 2026 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484597; cv=none; b=FF8bI4JQtIRw3fcsaXNfc0QFgLb69rkGvMHEK7OT/9OZcC2jMQXe0grNcYVXFsvJoI7rBmtt+RqrBiuahfs6/KvvamtGJjYdaF/RKoG/JbQmYN59uwe3BoH1HrGNJdms1Tg422zisNrZH75ohu3rmN1016N/O3X4vprKply8fL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484597; c=relaxed/simple;
	bh=HtuUSzVjnSOUbYWkxbsHeyujpmWD5W+LaeOHHnOMGoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKqAKvgpqI8WBBKv6ya6fu4BJGhkosRJhR2a2meQ1krb5ERDeuI3MEEz6L9xI552TSQSNq8tA7kxPN4Qo08ZSyScTmfXpuOYplA9nkJqLWEiilrzv58+SWT1fLDUnsllKCKHHSLOn+rTl67M7u3x6SFvZAjj5UfHnE+sHKVsNC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qYz3f8nJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qYz3f8nJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g+iOpUPUToml4C2KUG5NY+B3/8PQEXSvBqlXo4lWIoI=; b=qYz3f8nJfIS+cGCZPiDIw+mlu5
	LZmu/IHWouAOjrI35yKmQ55xqXXthaHnAloz83rETBuKYwTMLdE7f3EhbYmHNZLD5RT/3+W4czHG+
	cxGOAscKG6JKxH+bYmuH6Y8VYzk3mNLQj8wq40dzGIsm7UIqdckzWPJSEdcAv4sJTYbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2IXa-002pPD-4C; Fri, 04 Sep 2026 03:16:26 +0200
Date: Fri, 4 Sep 2026 03:16:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 4/9] net: phy: air: move the EN8811H
 firmware download into the library
Message-ID: <da48c8a4-85c1-40d0-be86-9e6630e97978@lunn.ch>
References: <20260829052546.1152446-1-f@lex.la>
 <20260829052546.1152446-5-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829052546.1152446-5-f@lex.la>

>  static int an8811hb_check_crc(struct phy_device *phydev, u32 set1,
> @@ -405,7 +319,8 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = air_write_buf(phydev, address,  fw);
> +	ret = air_fw_write_buf(phydev->mdio.bus, phydev->mdio.addr, address,
> +			       fw);

This can probably become:

     air_fw_write_buf(&phydev->mdio, address, fw);

> +int air_fw_write_buf(struct mii_bus *bus, int addr, u32 address,
> +		     const struct firmware *fw)
> +{
> +	int saved_page, ret;
> +
> +	mutex_lock(&bus->mdio_lock);

If you are adding __mdiodev_read(), it makes sense to also add
mdiodev_lock()/mdiodev_unlock().

> +static int air_mmd_status_read(struct mii_bus *bus, int addr, bool is_c45)
> +{
> +	int ret;
> +
> +	mutex_lock(&bus->mdio_lock);
> +	ret = mmd_phy_read(bus, addr, is_c45, MDIO_MMD_VEND1,
> +			   EN8811H_PHY_FW_STATUS);
> +	mutex_unlock(&bus->mdio_lock);
> +
> +	return ret;
> +}

Is C45 over C22 required here? At least when downloading the actual
firmware data, you don't want to be doing C45 over C22 if you can
avoid it. So maybe mdiodev_c45_read()?

      Andrew
