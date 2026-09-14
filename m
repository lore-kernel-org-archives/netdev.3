Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C24399D5;
	Mon, 14 Sep 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395369; cv=none; b=er2PLe6hNZvqEwMOLgxYhl/NnAmSHVwWgrRjVnQrLWYj7/ubffPCLSU9QhfTrmJ7M7pkhCMg/nG+pfpkk38kOgpguAh24fIOlED9BUkAI3d0qDARdrrgWHdAxtQ5elvx9z6kEMgcIA8q8oJ9Lsb1PKQAiPbOIvaeUxtkzXL+bHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395369; c=relaxed/simple;
	bh=+olHVyisOg8KJkBtrrQvtpCdUxTiqAOiFUn02xDQfNA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iCSWZFnpL0iG8A24ZUsNH6hYNn1AzHfQrKc+cl0Qy6nuqnZEpWTllgqPw9D+1HOKFtqnj6i2tMqU5KI922L/jHpeawKYLgWap43uYMFjumEo5DJYYSCqUfMpmDDHnzrJ+pWClwg8q7EjupZo1apsnogc4C9J9uLPPhd8mgLqUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=FdN6OHkN; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="FdN6OHkN"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CD1AA9006;
	Mon, 14 Sep 2026 16:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789395365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MDfg/rB7iuomgolFgHAPAwwyhVSXuAHKCymFJSRMbzY=;
	b=FdN6OHkNXweCoJRC2jTSTbCMRr9dzT33bY7wSGl88DaDwgS7KrNvAgUJYhs578a4L5QFdB
	OsjKgUuck052WFdSZ8fyrkS/EmhxuIkRWR/pH4sFiLMmaTdtpU2YFWFH48Zds+Md9kLJu7
	BXgGM7ZwtxQlwGSUrLsxgbKSvicHk1YaLMby0rxgl/g9k3r7gtz+biG2ljuaw/nT5xT7OD
	D99/Y2Q9IWZnsoBanm/uoZfIzxAzicqgyy1azCjSxrRmvMKsaAG7KIrfpkjosPhvKNxcvn
	TDByH2Xk8NRhwYsA1AHOI2QPOmJ1U6ryC9apPmfZAXwr0HbVf1iQP1M2vaJY2g==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 16:16:05 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v11 12/15] ax88179_178a: Add ethtool get_drvinfo
In-Reply-To: <20260914-ax88179a-v11-12-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-12-5ea7a925ba6d@birger-koblitz.de>
Message-ID: <caaf9aa05e670470da72f9a8533677b5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.9.2026 14:46, Birger Koblitz wrote:
> Add ax88179a_get_drvinfo() as implementation of get_drvinfo, in order
> to provide information about the device firmware.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/usb/ax88179a_devices.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/usb/ax88179a_devices.c 
> b/drivers/net/usb/ax88179a_devices.c
> index 
> 27836c72ec14aaaedfaa97ef95730bc7980074bc..817d542c4cc085d57837f2cd60d486efdb7f108e 
> 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -218,6 +218,20 @@ static int ax88179a_resume(struct usb_interface 
> *intf)
>  	return usbnet_resume(intf);
>  }
> 
> +static void ax88179a_get_drvinfo(struct net_device *net, struct 
> ethtool_drvinfo *info)
> +{
> +	struct ax88179_data *priv = netdev2data(net);
> +
> +	/* Inherit standard device info */
> +	usbnet_get_drvinfo(net, info);
> +	if (priv->chip_version < AX_VERSION_AX88179A)
> +		return;
> +
> +	snprintf(info->fw_version, sizeof(info->fw_version), "%d.%d.%d.%d",
> +		 priv->fw_version[0], priv->fw_version[1],
> +		 priv->fw_version[2], priv->fw_version[3]);
> +}
> +
>  static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 
> speed, bool full_duplex)
>  {
>  	struct ax88179_data *ax179_data = dev->driver_priv;
> @@ -307,6 +321,7 @@ static int ax88179a_set_eee(struct net_device *net, 
> struct ethtool_keee *edata)
>  }
> 
>  static const struct ethtool_ops ax88179a_ethtool_ops = {
> +	.get_drvinfo            = ax88179a_get_drvinfo,
>  	.get_link		= ethtool_op_get_link,
>  	.get_msglevel		= usbnet_get_msglevel,
>  	.set_msglevel		= usbnet_set_msglevel,


Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
