Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246511C5D7D;
	Thu, 28 May 2026 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779936621; cv=none; b=eTqezi6fjhxH2SRh5AR72KypnxeKLpLJQPR7GVRb/GQs2wXWzsW7vbyF/afy+CY65peSB3yTxTXpAUQaNuuiixuY0FQza2M3Kf1NoywGY2cEWY6cqv3JFvpvwjtlNsK1NR/H3zcFofJjA0yJzKqnwStUIE5KLpzDC7x5XLj0n0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779936621; c=relaxed/simple;
	bh=FPclTH03l9Yt7L1jGq5YcyMGTA4Tq90bDxn8yn0jsn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R04Cc1v5fI0LI3Obpf2sZ4fMeICwqgX7n/BdX4Zpm9zH1OoMBJINlGvOinSvsjsvd9ixViC5NiDshPBrNlRq5Yj0l8kuh+UMso9zWYSkDW9rs7XrqaYSEBeZPjBiBrgNydUrZZ69sU96sBW/e/hrEfjQrpbdUqC/f8V/NVzNqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fG5jYt0K; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fG5jYt0K"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DsWVnO/eXmqtGauPYqIZ0hLahnQl89rtKzFLexhCFHk=; b=fG5jYt0K0UhDjn1cjT2LERST9d
	6IiVoPaMdeX57dlq3JvW30HiPTKeCEbv4JtTl28nrXEWYvHV92l3sLl+j9VMSn8MMRbOQlgY5FIVd
	IxoExANcplImlnf50trs4mHdUcIl0+bkRZgKoUdJ/478WLPJGl4TMQRUDXnPk9i6L4kw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSQow-004qXj-Nl; Thu, 28 May 2026 04:50:06 +0200
Date: Thu, 28 May 2026 04:50:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
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
Subject: Re: [PATCH net-next v2 09/10] net: phy: Add support for the ADIN1140
 PHY
Message-ID: <74a44fe8-52a3-4d06-94d3-be32a2e39c4c@lunn.ch>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-9-37e5c8d4e0a0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-adin1140-driver-v2-9-37e5c8d4e0a0@analog.com>

> +static int adin1140_config_aneg(struct phy_device *phydev)
> +{
> +	/* phylib tries to clear BIT(12) in MDIO_CTRL1, since AN is disabled.
> +	 * However, on the ADIN1140, that field is non-standard, being used
> +	 * to control the reset status of the PHY (thus it needs to remain set).

More brokenness. 802.3 defines PMA/PMD control 1 bit 12 as reserved
and always 0.

How did this chip get passed QA with so many issues?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
