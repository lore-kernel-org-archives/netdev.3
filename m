Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1FA7E0FF;
	Thu, 28 May 2026 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937825; cv=none; b=CjDhcy9bBj/oivl5eRRgWWBh3vQa12CPyeMG1mP85Qy9McptM/l6/zvmndXTZeRVoLzcpAqLULG1RDOKxWZqobbz3Ka0Nvc2aVnvUu2SNJkgymB9/PWP8dT5kPLR1DVot6S5/B9onwPAm8AHRjPrsVKH2qdowluzt5qYFVDAOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937825; c=relaxed/simple;
	bh=JKPT2uOitDGMc9hKsCeI1Ib7wNX2r4iiEK8ueiYERgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNlFo1aKcUPFWPtXrnuqjE656vecp7llqu8S0n0cfEDdqBK8yYKc+sb2OgfemM39Q2OF9hasxl4Y4A1ARPN7On0rO7sQIYfSf0Os9OHG2sLLbjbUFXdrYCtzZYGVlOf79SANBJMQngjD6HVfhVmRSzz19oGfIVygUzHa+1Bu99g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZQrKHCc1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZQrKHCc1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b/EifuVIGghQo+9boHyYh61kG7BnRjT0tZEcVKkgI5c=; b=ZQrKHCc1mUHR3viQts8Dk7qHU1
	esGBTSsJijbExowQrmjQI4oIFgayx2ry9r7O9vWZXYQ+wkPqaWVt8QIwIdIQN/nBd19IXHeNod/Jh
	U7/pDewdZhggcCg462mjJkvWzk/EYgCw52NGdSSe52MoOHMOUdZQhEH0+n29l+i0SU08=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSR8N-004qh5-4w; Thu, 28 May 2026 05:10:11 +0200
Date: Thu, 28 May 2026 05:10:11 +0200
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
Subject: Re: [PATCH net-next v2 10/10] net: ethernet: adi: Add a driver for
 the ADIN1140 MACPHY
Message-ID: <0aaa9a58-fac1-4de7-90f0-443db37228c8@lunn.ch>
References: <20260527-adin1140-driver-v2-0-37e5c8d4e0a0@analog.com>
 <20260527-adin1140-driver-v2-10-37e5c8d4e0a0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-adin1140-driver-v2-10-37e5c8d4e0a0@analog.com>

> +static netdev_tx_t adin1140_start_xmit(struct sk_buff *skb,
> +				       struct net_device *netdev)
> +{
> +	struct adin1140_priv *priv = netdev_priv(netdev);
> +
> +	/* Pad frames to minimum Ethernet frame size (60 bytes without FCS).
> +	 * The MAC will append the FCS, but we need to ensure the frame is
> +	 * at least ETH_ZLEN bytes.
> +	 */
> +	if (skb_put_padto(skb, ETH_ZLEN))
> +		return NETDEV_TX_OK;

Does the standard say anything about this? It seems like something
which could be moved into the core.

	Andrew
