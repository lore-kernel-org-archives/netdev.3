Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7077545000;
	Sat, 13 Jun 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781362684; cv=none; b=hG6Vgt0ygpv1TdtDdPFEy9IERuP4T1FO6eg0YyBKBqaVUoFHWqsSy9L50QtMWL411X4jcuSSYRgAn76Ob0jfvg3HE6dzOjZrEuyltPIvTe7F7edwmyVcnPD7ijVFonltF1G2ZvCsZcQqQD08TC9pJWEkrJtvUAnPu98MLwnZqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781362684; c=relaxed/simple;
	bh=KpGy/xgmjeqVtv28pgBLxTu0nspaEBgTAZDTc019vHc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=shvZ3YyoIc2CGHnOzAqiYichQQNAU97uDUkv3+1IweBXK4BxQ8TSxhEXlH6hAp+o+tCPAuj1AG7mR5WzssU1bPGiojV8XT+M1mGVtGiwNg+9RHgMwnTnIKRwwaS1hp+E6K3mvhD/q/SSGOFtnpM3Vc0j7crlrHw/CAPsh1mHj/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Pg6Otlk8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Pg6Otlk8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 39B87A4BFA;
	Sat, 13 Jun 2026 16:57:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781362676; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=75JZwRU8ofRYMiyvgeE4ErJRyM3JYS/4nW4KHNBGmTs=;
	b=Pg6Otlk8j0u009mcy2koX7Gexqvlud+CcJ2DbA/2aTV52MsaiqbT5C+mOgiG16IFJhQk3l
	uscMh8ilV5NFEM0YbxppbketZdB1YyDb3ja0uIw3CSHAxwxgD21L64HmGL/N1mn2wyD+tS
	kiWIo1Z4CyGnPwE23rvF6IZ7JfQQlmN6X3PxpjQIHdnF3wEh7h/7+cPgs3noWw77M74tVM
	9sbScAlUBgjmg7FZ3jnrB5S7YNySm2E6JquaUVRnH+JQMoM8MUyJ2xOELudLBocWs0UAHK
	AmXxKAJjhRjvh2yd7Yieodu1sKAJUYN3ePq67iCUdNnCJv//er8vQB3dQSeokA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 13 Jun 2026 16:57:54 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: zjzhao@edatec.cn
Cc: hayeswang@realtek.com, andrew+netdev@lunn.ch, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8152: add vendor/device ID for CoreChips SR9900
In-Reply-To: <20260613090154.1975753-1-zjzhao@edatec.cn>
References: <20260613090154.1975753-1-zjzhao@edatec.cn>
Message-ID: <588cf92dc4ca2b8199f5c80915207468@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 13.6.2026 11:01, zjzhao@edatec.cn wrote:
> From: zjzhao-eda <zjzhao@edatec.cn>
> 
> The CoreChips SR9900 (0x0fe6:0x9900) is a USB 2.0 10/100
> Ethernet adapter. Testing shows it works correctly with the
> r8152 driver, reaching wire speed (94 Mbps) with zero packet
> loss on both TCP and UDP.

Do you know how they differ to the other CoreChip devices (eg.
drivers/net/usb/sr9800.c and others)?

> 
> Tested on Raspberry Pi, including hotplug and extended data
> transfer.
> 
> Signed-off-by: zjzhao-eda <zjzhao@edatec.cn>
> ---
>  drivers/net/usb/r8152.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index d61074178279..ea1733e3619c 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -10062,6 +10062,7 @@ static const struct usb_device_id 
> rtl8152_table[] = {
>  	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
>  	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
>  	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
> +	{ USB_DEVICE(0x0fe6, 0x9900) },

Instead of hardcoded 0x0fe6, please add a proper VENDOR_ID define in 
include/linux/usb/r8152.h

>  	{}
>  };

Thanks
Nicolai
