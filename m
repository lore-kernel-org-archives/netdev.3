Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA63F443E4E;
	Mon, 14 Sep 2026 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395440; cv=none; b=t6FXAcvobNgg/rlErQHhyLUZl90pgVnJHQgI+HRrDJOI2uiBmiFbf49lNAzT5C8+dJph6/mSqFVLkQKPAy1TRT0/3LNseT9y4EXEaFg31a6gHn4wjAHSr6EiJpgsgZfy0mV80PUeeXanJuFNNQ5XEyQ9ytyFtvyV5AVVS5eXDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395440; c=relaxed/simple;
	bh=WwyemPfCGtGpaGhIaw8oeDMtCAwfUBPK7mE2W6HoOzA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=THYgZdmmJVV8y3khWdVMJGhUUgsZog3hJ9nMVOkusJfhgD5xngy7IjRc4Kq1ifDEJ1qsdc6vqzCsGIneUQAwuIr9T+ORI9XQCDQilSIrTWYPL4dYEYPD7s07+jlR23ksbBNcvLlC1qAmDZcf//ANDykeG9Vowo4X+UVI5WhAAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=EOMZj8c5; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="EOMZj8c5"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0A01A02A9;
	Mon, 14 Sep 2026 16:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789395436; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LV2rFuTqxnUvpT2kKgZ/ZRhHzzkTqV9h4yZ9JGUnT6w=;
	b=EOMZj8c5UtgRvJy+/sEDZwAeK5OGNoYne0yZIcNvi7ZvnMeLwrFBjk4gtfpTcPxwH7GAwO
	eEtkw9QWZQS3fIEW2B0+CpzoBwWN1ac2TLKrOW6bES/wVwmdNYI5bIKMM1CEo8hVXYzfce
	q4V/i1zD6jZNO7Tpy/eXIqoNVm91RtSjeTIxI+Ml3g8t2jWy14REoGLY6A8T1BCzGQ51S7
	K9aHbmMBaYfXUBRwc0hBJcH5DaKihoJiC9ocoiISkvjAuNOqUNOCeEJRhOknnaSAoexVqm
	nB12Vr8k/uGS1/+TWBKPA0ITc9lBlbfDDvbRB/3eDn6uWkNRfchrE195KUONZA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Sep 2026 16:17:15 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v11 13/15] ax88179_178a: Update driver name and
 information
In-Reply-To: <20260914-ax88179a-v11-13-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-0-5ea7a925ba6d@birger-koblitz.de>
 <20260914-ax88179a-v11-13-5ea7a925ba6d@birger-koblitz.de>
Message-ID: <d60ef2f11fa4806fe9ed449c927702c8@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 14.9.2026 14:46, Birger Koblitz wrote:
> Add additionally supported devices to Kconfig description, add
> further requirements such as PHYLINK.
> 
> Update driver name in usb_driver and update MODULE_DESCRIPTION
> to include the additionally supported chips.
> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/usb/Kconfig        | 10 +++++++---
>  drivers/net/usb/Makefile       |  2 +-
>  drivers/net/usb/ax88179_178a.c |  8 ++++----
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
> index 
> 115990b0d9537aea2776544c9768b034f32aa7a4..4158455a2da76cd43a9a9d9d0e8c66028d57b095 
> 100644
> --- a/drivers/net/usb/Kconfig
> +++ b/drivers/net/usb/Kconfig
> @@ -195,11 +195,12 @@ config USB_NET_AX8817X
>  	  This driver creates an interface named "ethX", where X depends on
>  	  what other networking devices you have in use.
> 
> -config USB_NET_AX88179_178A
> -	tristate "ASIX AX88179/178A USB 3.0/2.0 to Gigabit Ethernet"
> +config USB_NET_AX88179
> +	tristate "ASIX AX88179/179A/178A USB 3.0/2.0 to Gigabit Ethernet"
>  	depends on USB_USBNET
> -	select CRC32
>  	select PHYLINK
> +	select AX88796B_PHY
> +	select CRC32
>  	default y
>  	help
>  	  This option adds support for ASIX AX88179 based USB 3.0/2.0
> @@ -207,6 +208,9 @@ config USB_NET_AX88179_178A
> 
>  	  This driver should work with at least the following devices:
>  	    * ASIX AX88179
> +	    * ASIX AX88179A/B
> +	    * ASIX AX88279
> +	    * ASIX AX88772D/E
>  	    * ASIX AX88178A
>  	    * Sitcomm LN-032
> 
> diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
> index 
> 2ecead0181eaf8d66fb6f5dbd6f2905b22b6eb57..4026f19ecb826a6465de38f1d9bb0e4c0af80421 
> 100644
> --- a/drivers/net/usb/Makefile
> +++ b/drivers/net/usb/Makefile
> @@ -12,7 +12,7 @@ obj-$(CONFIG_USB_HSO)		+= hso.o
>  obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
>  obj-$(CONFIG_USB_NET_AX8817X)	+= asix.o
>  asix-y := asix_devices.o asix_common.o ax88172a.o
> -obj-$(CONFIG_USB_NET_AX88179_178A)      += ax88179.o
> +obj-$(CONFIG_USB_NET_AX88179)      += ax88179.o
>  ax88179-y := ax88179_178a.o ax88179a_devices.o ax88179_lib.o
>  obj-$(CONFIG_USB_NET_CDCETHER)	+= cdc_ether.o
>  obj-$(CONFIG_USB_NET_CDC_EEM)	+= cdc_eem.o
> diff --git a/drivers/net/usb/ax88179_178a.c 
> b/drivers/net/usb/ax88179_178a.c
> index 
> 44a768c5808ac1f7071e186d9c86cd6149601971..1d35ef90eceb77b27e8d96e64a008c63b40f4bd7 
> 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -1341,8 +1341,8 @@ static const struct usb_device_id products[] = {
>  };
>  MODULE_DEVICE_TABLE(usb, products);
> 
> -static struct usb_driver ax88179_178a_driver = {
> -	.name =		"ax88179_178a",
> +static struct usb_driver ax88179_driver = {
> +	.name =		"ax88179",
>  	.id_table =	products,
>  	.probe =	usbnet_probe,
>  	.suspend =	ax88179_suspend_wrapper,
> @@ -1353,7 +1353,7 @@ static struct usb_driver ax88179_178a_driver = {
>  	.disable_hub_initiated_lpm = 1,
>  };
> 
> -module_usb_driver(ax88179_178a_driver);
> +module_usb_driver(ax88179_driver);
> 
> -MODULE_DESCRIPTION("ASIX AX88179/178A based USB 3.0/2.0 Gigabit 
> Ethernet Devices");
> +MODULE_DESCRIPTION("ASIX AX88179/179A/178A based USB 3.0/2.0 Gigabit 
> Ethernet Devices");
>  MODULE_LICENSE("GPL");


Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
