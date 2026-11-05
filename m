Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898336;
	b=Ckizqi/70h6qfQSXVuIzwBllssOdz0+ZQle93hHhyxn6Ee99PrLo14zhUzNA2AXjM/Lo
	 2wxsAs4wR+qtlRlm0zPi56A47EVaFidKQ3R8Nf6nplAzB/HYVT3SlZUCgM8DwUX0kZUI6
	 3hI5DjkymldwXmZLMhb1xFd+XjUHyp2Hj7cZg2/DOujT/X+YZHMiwPXHQRa8rGjXjQAxY
	 8TAJKSqZLlrUkEpujHTFwdmge1+PQ4vwaBFUxR3z75zXGOp5akCHq/eSuC6V5H/aJ7HHY
	 EzCLByNFRGKyjbtfHL4lsvKh8Kswaas7WMtoHTgW3rhGrFaB/WT+Yhqp/4ZynuasFsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
	b=I3vbVATNXTd4jKfNy4cpgyTq/Fcw9ZyvmEKBFD2gQ6ZRdmkh9bA6jVaCtqeGx492Qw/R
	 CPT0LwlCR/Hl+lfdj6qVjEEMgaiwPujEQJvMGZ8vbuvxD9O3zWXVjE3FSIL/VHOfQBH6S
	 6CTgmICNI7M3Gzw9Vz3ulyqigOZz2cQFETxw6JxgimW3ox1cUZxsXM2B/fX/xbxAz+VSv
	 0zZUQzMVd5YpkH4KGRRjHkhy6/20R7RlKS/sdo7iQsnOlZqUEt5Eh0JzHeGaYq8x/vazS
	 uT01yiGT/raMpLsEASn9LopfiQ8WmhzBato2Cw5CG7ma5/P0zbRG8tStSVE9jQlvDMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezhGUhXo;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709E606D802
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 17:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8709E606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ezhGUhXo
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3516057eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898335; x=1794503135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=ezhGUhXoIUl09y6+rx0VThMrADfNJzLtbjELvheIq2XUjEVn+F/n+Ri2C53TV9L6Aq
         JdGhkEmCnwmkPVTv0OB6x5RGwGBQJHUjt1KyKJv1eSBurgKo52RA3J8/QRIyxJZsDOQU
         n7s5HLJdofzUUsrlUP5HhN1OEHjO1pTWgNUtwsTp5+pkRYp1fI+C+uqlY+LxQRirvNrb
         Ex3MFhTRMHWMTtME2TIEuo7EsT/3ZplABIXud7NOWlPeo0lDAdVbld/IOwaCZ8vfz4uj
         z22wAGLVFJBUWinFMtheNWfoQbFjMbEjptQEjYgl4R/mPdYwQwSpcnETlWlj/Aj3CrCr
         m0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898335; x=1794503135;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7Mrcemi56BF5iayGoRjCtdHcIwbWskinGPPufbe/aA=;
        b=Wr2YIIRm1ojz+aRkTHvXNz86kx2e96wzYA3MCUQ6sO2iGD5RrbH2WSb3c/zEctula4
         N/j9vEHiRpckt29xVHPQ21wkMGdAtYsEzUGG09pIeF5hCKHjJJOdaYioByKKTr9mDu9r
         3/DG6PMhlz6hTXc/Z3w9G25BgYM2arh2wNoHCjJI0aKWg0dVuIhGjsttdGtX7Rkl9389
         OJsrKxZ8f9Z+Hto/THr/CxL4E2as/cdiGaT4O+aZhSjf3wM26hnb7Pqq2+T/0ot2t9Hu
         RQbG9jViFQdy1cBGdwPXYLFc08Q9BNXILrGAgVKVc6MXNMfBZES+F4uloh2jRGPoaVGH
         MmIw==
X-Forwarded-Encrypted: i=1; AKwUvBx1TRJTI8jlEAdM7PgVeBGYXrUdeAWOifbq3kms2klIgrj1RtyYkccDF96oOk6emy5lGdcFvlo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nBT7tcyS7f3lkZDH4X7CqBBJF83HvMBMeRM/4UwRJOhOkrg0+
	wD/BCPzXZbfk4aekG0jGqW3Fs0577EaT2Kdz0MNoCS4exyW8mOKBrAyD
X-Gm-Gg: AYBFou2zTvDKrzRgbz/lBEsoBm67PC/I9whZQb/a3EsiAbHKDDf94BP/vQThnRWhSLQ
	kgJTN+Us30bmj221An1yzXR80oBqSSSdycXfWw37+DE2BDQgeX8kZy3rYeVyRinvoBMAvVLx/yj
	cBbtgbf0K+vqFBwkKHRCDU+1kjDUPgZXeHSLoSSiThCaSWA5guZidj9N4PT+VG4fetIYBhrGA6D
	OLpZwrhWsFJuEyeByzMW+Hzm0FIsyr/HaUfxOU55PHQuk6iqTbhhAvZwOX56DCquITiyF1uWWur
	E45pGWpQ/zCEXNHNgtupN3EUZtdcDeUIzM+g5/HzTXwb/fov2+6gjq1Nl5WdCiRZ7o720APlU3h
	9D63VZyoJOraH40AhUxeNEoktETq4j5GuzaQb5U1G5zyOia2syhwWWuTU2Htw/q7IksqnQNsTAk
	4WNrj2CVLhrZGvRO8bFuuIg+57BUKpNaCLE8SYflYGwD2wjFIbLJO10icMxitwBOp4uXyHlQs6R
	/KEx2Db0fOPQCLLKIpmVpMdgx1j9UTMPCno/42lI6MRZlwFid0yyN1GBotb/RcXnZHMyMJhIi1l
	OpKL7/sAhWEcYzUJMX0L803X1LGdGBjccyvzEQuQf+yopaQtW3f6LOfMuCGxzD78NvH52muQhpt
	suhfqnUnF5LLZiWY=
X-Received: by 2002:a05:7300:fa0d:b0:36d:7feb:8bd3 with SMTP id 5a478bee46e88-36d7feb8e1amr5835338eec.11.1793898334471;
        Thu, 05 Nov 2026 09:05:34 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3989670sm23943795eec.25.2026.11.05.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:05:33 -0800 (PST)
Date: Thu, 5 Nov 2026 09:05:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>, 
	Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, 
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, linux-input@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 02/17] Input: serio - attach manual drivers through the
 driver core
Message-ID: <auy2plYVi723Qt42@google.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>

On Thu, Nov 05, 2026 at 01:42:15PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Manual serio binding connects a driver before driver core can admit the
> device. A rejected binding therefore arrives after functional setup.
> 
> Keep the port ID check and use device_driver_attach() for the existing bus
> probe path. Driver core then serializes admission and handles probe failure
> before publishing the binding.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/input/serio/serio.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> index 54dd26249b027..604440244c1ca 100644
> --- a/drivers/input/serio/serio.c
> +++ b/drivers/input/serio/serio.c
> @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
>  
>  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
>  {
> -	int error;
> -
> -	if (serio_match_port(drv->id_table, serio)) {
> -
> -		serio->dev.driver = &drv->driver;
> -		if (serio_connect_driver(serio, drv)) {
> -			serio->dev.driver = NULL;
> -			return -ENODEV;
> -		}
> +	if (!serio_match_port(drv->id_table, serio))
> +		return 0;
>  
> -		error = device_bind_driver(&serio->dev);
> -		if (error) {
> -			dev_warn(&serio->dev,
> -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> -				 serio->phys, serio->name,
> -				 drv->description, error);
> -			serio_disconnect_driver(serio);
> -			serio->dev.driver = NULL;
> -			return error;
> -		}
> -	}
> -	return 0;
> +	return device_driver_attach(&drv->driver, &serio->dev);

I am not sure how safe it is, serio (and gameport) have pretty elaborate
structure and locking rules because they can recurse into themselves (to
support case of Synaptics touch-pads with pass-through PS/2 ports).

But this call is for user-initiated probing anyways, I am not sure if it
even needs "trust" handling.

... And I even thinking if we really need to keep these custom
attributes or if I can rip them out in the future ...

Thanks.

-- 
Dmitry
