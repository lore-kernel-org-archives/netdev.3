Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22444C64E;
	Mon, 31 Aug 2026 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186636; cv=none; b=HY/6TrAVAoZIbFYAzN1i2/CASksmwxo4xe7vWcYrc5JJtSeIQhMpcbGtgL3Lz5/lPb7oT+kdc8trPz+Z+HyxmkVnoa9PcqFY2dUzx+kfKSV4od1d+mNr76/YaPHCh3ikrNk2eAyBR6IkgDVkkjYEhQk7StV8XkuCCinK7dZtyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186636; c=relaxed/simple;
	bh=aGra6savxi5QSi4O2O7padzqMH/pYCfn9q4yiYd/+x4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CudrO5HXXozyY/nrxBD7hahHe47yoAfGG6d5yYyNqzg6BcjFjqi8iB69HEjxhJJHBbUjpEF83Nn1Vt/H8zw+KM2RagDDIXCBbzdjNTe202TZVZtuPpxLNgeHz7/9O6gInnSyeKhxNxZowQJmnKw8c94KVQxHVymPH/0/ETW8LhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HeHI4W/1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HeHI4W/1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yOZ706zNGNzymJW9PjmRkDyyrgnyXTX/7XfgBY7R9gY=; b=HeHI4W/1y5HzfbszuLfyOsaIIO
	D+yJx2tRkWK0JD/zhwTqrG9nb9BIQdC7lEdI5z9DKoSEqnaFx4KBbFiujakyVKkTTTOoqY0Kb1Jbg
	oVvfAW+8lB9eH2MxVKBW+PIdiZvkJaDaKUKoldjgoWiZrJyOmkJAqTc5JVEPRw4bVK/k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x131m-002CEP-Iw; Mon, 31 Aug 2026 16:30:26 +0200
Date: Mon, 31 Aug 2026 16:30:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v8 06/15] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <af3f05e6-f5dc-459f-ac2a-5e7aedbf8ba3@lunn.ch>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
 <20260831-ax88179a-v8-6-de905f2ee426@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-ax88179a-v8-6-de905f2ee426@birger-koblitz.de>

> +static void ax88179a_status(struct usbnet *dev, struct urb *urb)
> +{
> +	struct ax88179_data *data = dev->driver_priv;
> +	struct ax88179_int_data *event;
> +	u32 link;
> +
> +	if (urb->actual_length < 8)
> +		return;
> +
> +	event = urb->transfer_buffer;
> +	le32_to_cpus((void *)&event->intdata1);
> +
> +	link = (((__force u32)event->intdata1) & AX_INT_PPLS_LINK) >> 16;
> +
> +	if (netif_carrier_ok(dev->net) != link) {

phylink will not like this. It is supposed to be in control of the
carrier.

> +		usbnet_link_change(dev, link, 1);

This also seems to change the carrier under some conditions.

> +		phylink_mac_interrupt(data->phylink);

Is this not sufficient to make phylink change the carrier once the
status has been read from the PHY?

	Andrew
