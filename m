Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1A3B3BF1;
	Fri, 28 Aug 2026 08:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904329; cv=none; b=jzrdY02FupwDBZKnfhCXGJkUXVsAowpbJZ4eF+2pUwJPyjdbvUGFwf5+dNmwmzH/iCF3WQtbwsBz+zn0AXaJ7j+hMppAdi12t32tHL78vgwr7Gc9rpBmKSxC3lRMxdD7wH1tnv6awylqIAFVly6Hnsmcd4ouFZAqPvHcHjwpl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904329; c=relaxed/simple;
	bh=dDYe2dsAmYdbhtB1Y0FBTOh4Dk1kVDi5abPY3yTRpjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUtVjUJC0kb+olaQ+CMuSyEP0IIVfMLidmeZ4RBssBmTn21d5pfeEdmWmNzDz1at9DZCRTZYJif3PLbPB9X+I0pW3d1hKyFjXIE+mNOlwiaDIK0Y8XjgqqrNNinkwV5SNr6SBL2+NKdh0gu6gI4cF5zMma++btrjQUqXtAyEn8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbfrG/2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbfrG/2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617021F000E9;
	Fri, 28 Aug 2026 08:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787904328;
	bh=Qr2mTh/gK8eJeQ1I7Ps6yQaqCGJLHoro3vBrVADu4xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lbfrG/2pZRTWPjF6YmfVl5HB/Urm9rGx37TOyotnLOim7vXMr8HpDqazIioMrIT4O
	 rxZEL7hWznFR5kL9BKyhnfAIKP8J1qpOLV8TxbhCuNHFk953K5uSez4wYbT0E6jx0y
	 yR//LH8nEKToT0OGm/7i74Jhf8FGwYkM85Veue5t5RRaA8StHZsz12lyu+zoyGdjQY
	 iHZNTAO4aFjopYj/Tuzymf+SffUe9DAKK8b3vCcvbwNv3pYsXmJnoKR+Z4MRczuW4k
	 rGCZUTwn2oROFDcaBPVmArnGefptojqoCUA8eJEg418kEf7LdAhomW/VKDLfn9KQLE
	 gaaGj8e0XiNbw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wzraX-00000003NdI-38Mh;
	Fri, 28 Aug 2026 10:05:25 +0200
Date: Fri, 28 Aug 2026 10:05:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Ian Lin <jisayme@gmail.com>
Cc: bjorn@mork.no, gregkh@linuxfoundation.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: add Compal EXM-G1x modem support
Message-ID: <apFBRfGm_3-ly5A8@hovoldconsulting.com>
References: <20260828075644.6228-1-jisayme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828075644.6228-1-jisayme@gmail.com>

On Fri, Aug 28, 2026 at 03:56:44PM +0800, Ian Lin wrote:
> Add the USB device ID for the Compal EXM-G1x modem.
> 
> Bind its QMI WWAN interface 8 and expose its vendor-specific serial
> interfaces with protocols 0x30, 0x40, and 0x60 through the option driver.
> 
> Tested on a Compal EXM-G1x modem.

Do you know which chipset this is based on?

> Signed-off-by: Ian Lin <jisayme@gmail.com>
> ---
>  drivers/net/usb/qmi_wwan.c  | 1 +
>  drivers/usb/serial/option.c | 3 +++

Please split this in two patches as this will go in through two
different subsystems.

Please also include the output of usb-devices (or lsusb -v) in the
commit message (at least for usb serial).

>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index 8178a8758..e17afb22c 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -1451,6 +1451,7 @@ static const struct usb_device_id products[] = {
>  	{QMI_FIXED_INTF(0x2692, 0x9025, 4)},    /* Cellient MPL200 (rebranded Qualcomm 05c6:9025) */
>  	{QMI_QUIRK_SET_DTR(0x1546, 0x1312, 4)},	/* u-blox LARA-R6 01B */
>  	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
> +	{QMI_QUIRK_SET_DTR(0x04b7, 0x8217, 8)},
>  	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
>  	{QMI_FIXED_INTF(0x2dee, 0x4d22, 5)},    /* MeiG Smart SRM825L */
>  	{QMI_QUIRK_SET_DTR(0x2dee, 0x4d63, 0)}, /* MeiG SRM813Q w/ Modem(PPP) */
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index e4ad14375..56b43bf1f 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2547,6 +2547,9 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_INTERFACE_CLASS(0x1bbb, 0x0640, 0xff),			/* TCL IK512 ECM */
>  	  .driver_info = NCTRL(3) },
>  	{ USB_DEVICE_INTERFACE_CLASS(0x2949, 0x8700, 0xff) },			/* Neoway N723-EA */
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x8217, 0xff, 0xff, 0x30) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x8217, 0xff, 0xff, 0x40) },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(0x04b7, 0x8217, 0xff, 0xff, 0x60) },

Try to keep the entries sorted by VID/PID and add a comment with the
product name after the first new entry.

>  	{ } /* Terminating entry */
>  };
>  MODULE_DEVICE_TABLE(usb, option_ids);

Johan
