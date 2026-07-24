Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA5191F94;
	Fri, 24 Jul 2026 13:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900338; cv=none; b=EUqYbbUUQf4Ihlus+QpQsQXZUlZXFVyeNtV86enk73fLgC/gbPSsGm1fJok2zk8COH9025K1GEYWT/329jsGlUHkx2QC3ROwv9kZaaOrEo/Ihll0Atyfe2PeEh5rH85rQN82jHi5fHdfcEiT6dxD4FcEY97v4iZoyD5RbaP2wk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900338; c=relaxed/simple;
	bh=kPIubOjrfl2cOiNdvNDgvP1NBvYjV4+iQXHYQ0kQpo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDdlo10tWhC4kjkUxvexRC0Y+VisfOxsH8WDdpJw+IJzaA47Ssp5JPm4GR5PC0V/jdH4d4APeDnI0USdAtM65Czh97uCOFGID1TrYI1N3qKYAkdyeeQmaQY/1DR5h8+WpgPzSoHu5CCf/i/WmVBPXaGj6XeIM+ZPCEqRuTds/kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O9VQRycw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O9VQRycw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7WNelzegOLWxxBstk4POC8sl6g70r59d/h39R1rzIcQ=; b=O9VQRycwuHlEq+azpBVGGJkeS7
	fBGQGSJOvpjRsLb7WjqrvHPKP5uRsAnb45kQk4ikxdaNM39moz5YuhBHOXMdozYMAgdmvBGRECQLK
	YYCK1cjQYfWBP7cfxaNobbm6w3QoYQBkXGBYsDEIOwEKwbwFnLmPIlshf1nYvB8XTyBQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnG6y-00E05X-Fn; Fri, 24 Jul 2026 15:38:48 +0200
Date: Fri, 24 Jul 2026 15:38:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/13] ax88179_178a: Use phylink in
 get/set_link_ksettings
Message-ID: <0327f4da-a443-4500-871e-ef561bbc9281@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-5-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-5-bdde4f905883@birger-koblitz.de>

On Fri, Jul 24, 2026 at 09:36:48AM +0200, Birger Koblitz wrote:
> The PHYs in the AX179A-based USB-Ethernet controllers can be configured
> via phylink. Use this for link configuration.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> ---
>  drivers/net/usb/ax88179_178a.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
> index 2e2f96a97b8398ece7d70cf349c7db973959629f..136d1d39bf78658758d35372d4a9486e21befd87 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -967,9 +967,15 @@ ax88179_set_eeprom(struct net_device *net, struct ethtool_eeprom *eeprom,
>  }
>  
>  static int ax88179_get_link_ksettings(struct net_device *net,
> -				      struct ethtool_link_ksettings *cmd)
> +				       struct ethtool_link_ksettings *cmd)
>  {
>  	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *data;
> +
> +	data = dev->driver_priv;
> +
> +	if (data->phylink)

When did this appear? Am i missing a patch somewhere?

     Andrew
