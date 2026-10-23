Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792745866;
	b=Z36S4e04+90DsPqOlpFiz8UJkbEwPTzBwuHjsCaGf951CD0z59fNcTfNN0XffKwCxqcl
	 A6gvWPeRdVjrdJze7GtjmVd/N0z2u2NGyP48rzxcZ+gHKR1acOwN6AaKMoP2ThNOl+fmi
	 w5qtX/LcpUWzkBUTUrgKVp1AHxwd+9Xt3Rlc0nk+86srIfaXKAegCdqGByNp3va5QXthE
	 bPq67TBrRc4OWb4OC1wWoxZG5FmrPDjTahiGxzQGkuU/WfCAAQI72j7NA2YVulXA2rK54
	 o+VTBewhskJnnMfXDFs6kYRd03eefMzEiuNG15BXTHoCFwxrJIQ6WP8BeCLz7iq8QuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792745866;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=mJWrTaQByyrjZ9PzA2t7oDsC+zy0u+1OpsBHzdHiLYo=;
	b=gzYUKsuTz0CzJPrddl2skS3Ef17OlTIj0JRQUvkvGkMH+lrSloEzWHOqoCIb8Qs/+o1r
	 dZWDKy79U6XOPOuX6TrsGDm89MXIo9NpmXxdP67/USnCp+/n9rMUlPUvEpYbcl4CrcYPi
	 OyUH7yx+G5NTB1ffr073uBPDbKFn9j/8KtKuyoTYt446kkR8fq5bjpG0yJeCfg8e4dcrI
	 Vl6n/25owjtwsrrYHaNgOsCseJ4v+6tXsjepJzAf/iHYOm/Z/rovBdKZpuLL5+PuWHbOr
	 S89qaSu1rr/1Tjof40Ki04b8X42L9mrRUCo1O6ECA77yQ8I8U0ycVnqmPDhx+8YxLOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Q60yuWtc;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317C4606A31A;
	Fri, 23 Oct 2026 08:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 317C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Q60yuWtc
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B8962A0190;
	Fri, 23 Oct 2026 10:57:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792745854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mJWrTaQByyrjZ9PzA2t7oDsC+zy0u+1OpsBHzdHiLYo=;
	b=Q60yuWtc2CnGQxUSE7WHIOdfQsWM5KjPO16yW9IORmCsDGt7U5NabgOqv5hjw3x4NsghQI
	MxdJKf7Mhujwbv5U9/t8Q66af268MICJiWD9RKSWdSywhr+3v9x8P1m+bQwo3G7QENRD0W
	Y3CScMdYTN+o4biwhQUdmF2QfSjg0H9p4q4w8o5Z0V2HPGT7SF4NTU0xq50WBeutHrFYjP
	ZfrrOUVG+oEmkZJXlydlyWU78JjzScESx5RFsmjELyQ9pL/vs/0gH5DiaLlkIeBCb8CRc6
	bbtQ3OBBAoHt2MDiuCRGNOs9sjGnyT0TBEfJRSqP5qif8y4Rgj7Qe6uRdQpbzA==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 23 Oct 2026 10:57:32 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Divyanshu Jha <divyanshuj2006@gmail.com>
Cc: Oliver Neukum <oliver@neukum.org>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: cdc_ncm: add Apple Silicon MacBook Air
 (05ac:1903) device ID
In-Reply-To: <20261023070419.235361-1-divyanshuj2006@gmail.com>
References: <20261023070419.235361-1-divyanshuj2006@gmail.com>
Message-ID: <a386789d3d2d6709cc5e9c8b2b05a283@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Divyanshu

On 23.10.2026 09:04, Divyanshu Jha wrote:
> The Apple Silicon MacBook Air exposes a CDC-NCM interface (05ac:1903)
> when connected host-to-host over USB-C.

Which model and chip? a5148bc2fa27 says the MacBook Air shows up as
0x1905, and the Mac PIDs so far (0x1901/0x1902/0x1905) seem to follow
the SoC generation, not the product line?

Please add the lsusb -v or ioreg output for 0x1903 and the dmesg lines
you saw, like the 0x1902 commit did.

> 
> Like other Apple CDC-NCM peripherals (0x1902 and 0x1905), Apple's
> firmware omits the CDC status interrupt endpoint. This causes the
> standard cdc_ncm probe to fail with a missing endpoint error.
> 
> Add device ID 05ac:1903 to cdc_ncm_devs binding to

nit: cdc_ncm_devs -> cdc_devs

> apple_private_interface_info so the driver bypasses the interrupt
> check and initializes host-to-host networking successfully.
> 
> Signed-off-by: Divyanshu Jha <divyanshuj2006@gmail.com>
> ---
>  drivers/net/usb/cdc_ncm.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 35db38cb3..6848b9421 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -2019,6 +2019,12 @@ static const struct usb_device_id cdc_devs[] = {
>  	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1902, 2),
>  		.driver_info = (unsigned long)&apple_private_interface_info,
>  	},
> +	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1903, 0),
> +		.driver_info = (unsigned long)&apple_private_interface_info,
> +	},
> +	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1903, 2),
> +		.driver_info = (unsigned long)&apple_private_interface_info,
> +	},
>  	{ USB_DEVICE_INTERFACE_NUMBER(0x05ac, 0x1905, 0),
>  		.driver_info = (unsigned long)&apple_private_interface_info,
>  	},

Please note that net-next is closed during the 7.4 merge window [1].
So please wait until it's open again, before you re-spin.

[1] https://netdev.bots.linux.dev/net-next.html

Thanks,
Nicolai
