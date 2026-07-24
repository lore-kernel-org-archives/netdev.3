Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2F34398F5;
	Fri, 24 Jul 2026 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911081; cv=none; b=Ng30sMpGFjYKsUiTftFWdAdgYlHzPZEDbwQOQq5q2ssqAivc3/NXubuuLkH0ibj1zfEykOfwgua6izKT9GLT8Q5nweA4IfM/WjjX9/I9rijxiknWtms44pK+CnHJGbXIlmsyuU6y5vWUsQDWFCHVxzR4t6ZP9waD+FBEu2WHjBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911081; c=relaxed/simple;
	bh=ltGf1KOxXKsp0jz4oKz1OI/2uglE5T/KkAEiyAV1pUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+q+r9Or+jf0seBxrvWHNkO1lAnq3Xl+9+bAUeYAn2OTXUoxZRwkDwMPZFRcB8AI8yoMFcBdskEUDSKojgtbnNCqHu7L3daEyXrKPtVAQHrfq0N9I7frNd2ZPiH5Zd25bQFiOgDnH63SfIr66EK/OCOBt2470M1D5LSXx5QDdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OfBFddg5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OfBFddg5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GY6iapSH0lwmHqNW+xbZdSb5vYcsqWDKLshR4pDNby8=; b=OfBFddg5Ch2rWCMEt8SxSnm8y0
	tNBq6lKg8HEbrgJOo7BH/iXWNLzG0Iu23ZYM1TtlSxE291XZW9zyce8oApMgHHzjw8TeWwB60AX7n
	8l3MsTvnwggdEhGkCNwQLWJRtd6iWxowBZGRMSf08fHPiJwgQDXDfWGnTB6PFw7wEmu4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnIuD-00E1gI-Vd; Fri, 24 Jul 2026 18:37:49 +0200
Date: Fri, 24 Jul 2026 18:37:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/13] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <20384ea2-dbb4-4794-9f77-662e3b476ba2@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-2-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-2-bdde4f905883@birger-koblitz.de>

> +static void ax88179a_mac_link_up(struct phylink_config *config,
> +				 struct phy_device *phy,
> +				 unsigned int phy_mode, phy_interface_t interface,
> +				 int speed, int duplex,
> +				 bool tx_pause, bool rx_pause)
> +{

...

> +}

I don't see you doing anything with tx_pause and rx_pause.

This is another case where MAC drivers always got something wrong,
pause. We solved this by moving as much code into the core as
possible. You need to configure the hardware based on these two
values. Nothing more. KISS for MAC drivers.

	Andrew
