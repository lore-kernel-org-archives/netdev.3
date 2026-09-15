Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6F33CB8F1;
	Tue, 15 Sep 2026 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437469; cv=none; b=LWck7VIcoWsKhztjV7fKcJeVA5hpzJ3E+UpuGMOBk8QRdIc6DlUNgIwcne8ZIGZQ3YEYyXtz3BOczJqc+mZT7ydzgwA4MI/zpbKhnJeI0RXqYKqCf10CVR5oQMH+xGKCJhXy21WGl8jn+HP07k1ilrCb51sCx0DTYA1GB/1kNQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437469; c=relaxed/simple;
	bh=Oj+juQUh54jVOQdigbst1xSh8ndhafBNuuAu5gZ07TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgdCRYbOafOiNdkiUjiiADrAWW73aHeh8dGhKuFzcruyLbyCqkoZnVi+er4KgaMs1Vd8Xz1+x31z1R0Y1pC0x0UawP+Dy35C89IvTRJuWMyYjrZngux55hBnG/62aFi1Aw5eRiIyetPMGoWXVhwMUL9P5QI+BnXA/ajcNrbqPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Bt6gG7CK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Bt6gG7CK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dvxjarOAgaKuFcW163QkcGOkX35M9RIfhRJA2QV98YI=; b=Bt6gG7CK9/y+UIrruf9Iflh226
	S2nyzjVgrDguQUYsHdy+RInI/PYNNVxgT1mM/3d2tJCAO99xZCXXOZOmgwHyx26+7rCCAY0vMbfJ1
	2xAY0XmccQETkJPSZdgRVL8ebATqQQN2XNGPMUmx4UP1UxWpX8xlkPuV/nu6BAMfKJQI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6IQX-005AWg-4P; Tue, 15 Sep 2026 03:57:41 +0200
Date: Tue, 15 Sep 2026 03:57:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH net-next v17 2/2] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
Message-ID: <77c43c66-98f8-479e-a3ab-8717b8132be9@lunn.ch>
References: <20260912065224.2723883-1-kyle.switch@motor-comm.com>
 <20260912065224.2723883-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912065224.2723883-3-kyle.switch@motor-comm.com>

> +int genphy_c45_template_testmode(struct phy_device *phydev, int test_mode)
> +{
> +	int ctrl = 0;
> +
> +	switch (test_mode) {
> +	case 0:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_NORMAL;
> +		break;
> +
> +	case 1:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_1;
> +		break;
> +
> +	case 2:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_2;
> +		break;
> +
> +	case 3:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_3;
> +		break;
> +
> +	case 4:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_4;
> +		break;
> +
> +	case 5:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_5;
> +		break;
> +
> +	case 6:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_6;
> +		break;
> +
> +	case 7:
> +		ctrl = MDIO_PMA_10GBT_TESTMODE_7;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}

You should be able to simplify this using FIELD_PREP().

    Andrew
