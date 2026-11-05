Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910900;
	b=o/dZl7wjcxg98MEx6wYgo0cifawQ9+EwXuRzGg4FTyWu67uq1tXRiypddzXe+f/yWTpZ
	 rfCoOp8hPlcz4Wd+3heTXFiqzcR4bbzgXaoSTtHy4GyOMMw0bMOrLYtLRqlKmj/CU9ykf
	 aoST4b465jvynxh458Y9TP5ivtn5KqokKySU9Pt+8yZoVlutnqm4mJB4fGj9VcXbosWte
	 kJodDVzeYCa75ckjHU+2HQ4IOcg9u0AN/MKRm39WNzXE5MZqCXqgG19sAC4IAbPE5ZcDz
	 T0w/9SCl64GrZIWlGkPFWKn2XJO4FOApifY1w0nkxnbbOz8l4xGCZ+Na7mQXAz2c2fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910900;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
	b=QLkOOQ0j8PLcf3Dsi5nuJ7kwGkQAddLFMZ5I699GHSN1Lzw0pI2si12AvyDsOC0X2vhS
	 F85rfY9bpYErm8o0652ie7Vc0qRB2hilYwKAR2nV+mXGq6YnDD+yYKR6aZaVhdRCCHvcB
	 3QUz5k03KCxiOFWjW76jAuhrPatlEAQeTu2+EN98khcv5VEdZ/ArF8/D5Z29saEAljkdE
	 NYhbJiqtF7iuWJfQx0t3OiDIJKBXWNQCkWB4QEBBkMrprVIV/QyYscgDtBpzEIJm6v7qU
	 SyJ7NkOi40jnjXMYTLd6CvsO5EWMFAibAmenHbRw0+hUYbE8FCOWHYLIaRjEqTmO+/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfDV8RqH;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62E6606A326
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 20:34:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B62E6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tfDV8RqH
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so625c88.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793910899; x=1794515699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
        b=tfDV8RqHdxq2Tir67Fgi3R8YmRMnkFni198pbJyN+2f/wlgyg1u3H/zAskp5NHkOv7
         tIdkAuAZ8WUJ1kMmFVB+y6fHOz8B/caj8wD6aThvegmX02BzNu06iJykZNQp0y6aCkds
         RlikDnWVU951ugzrT3mYdlzvFKlHh7U4jsRYSXIG1h4+jf8Ji6Bx4VcBvQSsJCCbdeY9
         mB7Z2NGEfuJN8Celqb7oNC5peWi2IHdFiN3NSUJbZlwldHAE4GnOhIkhY+aC2WxclROa
         S4gSdge+AsM35XlqkfzkRHJ1/+Vy2cjQlMpoMljhOELSER57fCOwoNKU+WxKYNt0B3OE
         B7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793910899; x=1794515699;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aFjl/l4WKV+VfugNVUlnSUSxj2ZFcfM53muFdv6vcfQ=;
        b=skpft+5NKjWYlFJCxR5kCnusRFKYhkbH/SiMfz1eVebD1bq1AIqiL+rK0Gnih0q4JF
         +zlRT3nJL+b/0XcMdvYUXps/8RGuMYX4xO0yPXpeKObuyUy84Q3XMaB3acIVHdzxG8+V
         pFZ7yroi/aeyHv5HUH+mDJVBBDqULS5RaulUuOw+Wfo2HYCYKtSzl0f5b4EKrbC2R6TN
         buZSv90SRYcxFfkxPyjqejJzk/vhgY9PoH/SSlpGkZjLIdB4vj5oBPrWAcqS9F1rucKy
         YRcueNl7i70xHvXPevCCACuxvvQlCsKHMJI4yTU7GKAYmXYemUo0/UpL+MttOGc1KRWW
         +KuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuDwN+Do9viVYOz0yXBQpeSsQe8pIA4q6c8dsEUSFaqa5tuM3sIX0e7QnGJVV9RH/4jsTHdkM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9P0M4J1EgZY/k8X8BclVX0CwtAv0rq7HDblM0Un812EpL+JM3P
	qoMvPUNEOiKz3o3yvKu3CcTT9UORFNXDRl7Zufit/7zeSz/FVjN1FSLq
X-Gm-Gg: AYBFou1eFFfYzSmc4//4Ut3EiD38UBwu5ML53KYE96dusK2NUO9ImoDGlAMGY5QJP5/
	U1TNcFXsSCXeoM8HpHsgOjD3flxrQjQZQ1RBFFXyiyCnRvUc93HDBhHXbqC8SdlqoRLta1PLxbl
	LLjTW/5nOBsUPDp1NT2CwLTF3d69nrzyu4unQI+jcqzcZbecVK/bBuvnZsnMBbY4b7jAKF1AItP
	Jz6MXD7/qBkyoVij+VztAs//lIIHIfC5xAsb1Pt2OBDHhspSOOmY9ly/xhHtk7x9axlALFnDWkh
	cTkCt6PhdtjwTqDPZRCILQ4ZRT7RGWVXKmg+oPiBQE7l3RkGr+Gnjb1eR3OIQCaMQ0xYlZiZLst
	aKFy3vOH15NCstA7XVViJuDK+rkSZoAii6ETHWvAKqDFxakCiTnPjDqcJw57/pZeMf6dwSmRnN6
	vzCafl2wl4WcsQq+Ou4ghObKLDiyp0ZseIj0oHS5A9dnAnXRdYjntfcQJEIv9qzTaw0T6GtovAL
	gKUefQ6+lkamr71i0lYortxOiGp2eDD4HD7vARNfdnS1oqlXN69lx9lsLGMoWkiBxQrowwZFNir
	Akap0RPk3nuPdbEVX6OFs5oWGZlYzpsK86Mf4lIrBD7O7/wDhL21cT8P4Ewuqnum8bCoIIE=
X-Received: by 2002:a05:701b:2050:20b0:166:5552:780a with SMTP id a92af1059eb24-1b25d31e5a2mr163714c88.8.1793910898553;
        Thu, 05 Nov 2026 12:34:58 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed274sm649631eec.18.2026.11.05.12.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:34:57 -0800 (PST)
Date: Thu, 5 Nov 2026 12:34:53 -0800
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
Message-ID: <auzno3uoL5Pfojfl@google.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
 <auy2plYVi723Qt42@google.com>
 <20261105191940.GI8298@unreal>
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
In-Reply-To: <20261105191940.GI8298@unreal>

On Thu, Nov 05, 2026 at 09:19:40PM +0200, Leon Romanovsky wrote:
> On Thu, Nov 05, 2026 at 09:05:29AM -0800, Dmitry Torokhov wrote:
> > On Thu, Nov 05, 2026 at 01:42:15PM +0200, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Manual serio binding connects a driver before driver core can admit the
> > > device. A rejected binding therefore arrives after functional setup.
> > > 
> > > Keep the port ID check and use device_driver_attach() for the existing bus
> > > probe path. Driver core then serializes admission and handles probe failure
> > > before publishing the binding.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/input/serio/serio.c | 24 +++---------------------
> > >  1 file changed, 3 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
> > > index 54dd26249b027..604440244c1ca 100644
> > > --- a/drivers/input/serio/serio.c
> > > +++ b/drivers/input/serio/serio.c
> > > @@ -81,28 +81,10 @@ static int serio_match_port(const struct serio_device_id *ids, struct serio *ser
> > >  
> > >  static int serio_bind_driver(struct serio *serio, struct serio_driver *drv)
> > >  {
> > > -	int error;
> > > -
> > > -	if (serio_match_port(drv->id_table, serio)) {
> > > -
> > > -		serio->dev.driver = &drv->driver;
> > > -		if (serio_connect_driver(serio, drv)) {
> > > -			serio->dev.driver = NULL;
> > > -			return -ENODEV;
> > > -		}
> > > +	if (!serio_match_port(drv->id_table, serio))
> > > +		return 0;
> > >  
> > > -		error = device_bind_driver(&serio->dev);
> > > -		if (error) {
> > > -			dev_warn(&serio->dev,
> > > -				 "device_bind_driver() failed for %s (%s) and %s, error: %d\n",
> > > -				 serio->phys, serio->name,
> > > -				 drv->description, error);
> > > -			serio_disconnect_driver(serio);
> > > -			serio->dev.driver = NULL;
> > > -			return error;
> > > -		}
> > > -	}
> > > -	return 0;
> > > +	return device_driver_attach(&drv->driver, &serio->dev);
> > 
> > I am not sure how safe it is, serio (and gameport) have pretty elaborate
> > structure and locking rules because they can recurse into themselves (to
> > support case of Synaptics touch-pads with pass-through PS/2 ports).
> > 
> > But this call is for user-initiated probing anyways, I am not sure if it
> > even needs "trust" handling.
> 
> This patch does not change the locking; the lock was already held on paths such
> as the rescan path. This change makes that explicit.

Does this enforce synchronous probing?

Anyway, I would like to get rid of this special probing in serio core.
Given that the code path is only triggered by explicit user request I do
not believe we need to worry about supporting trust notion here, so
please drop it from the series.

Thanks.

-- 
Dmitry
