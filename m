Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACFD3BB4A;
	Mon, 27 Jul 2026 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154803; cv=none; b=AvYxS68kr4N+pdtyrByTz64sQHhvDW30Ecr1tcs8TM92yCHt5EXnUvVmRY58pn94cLX2IvlTohMAOk4wJJHP7vTR2920y1WE1/6G6zYJBxTQliH7w4tV6S4eXtLeQkR+KFoLRsJ1ESTAieaMWFIj3PFnzp1ui99OQCsdfHXqGfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154803; c=relaxed/simple;
	bh=xh9Fni2Hs25zCaJsSQLUmBgiGc90T+LMFjKzyDngqOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f832YeM7gwNiFqMXpzvjLfaMMjuj0e42GC2G/0DO+9YQsasG/NjPW096CHtUukc1nlS7YRq5z8PDEGHhdt4KPzZLYc5fbJnK/gEihuhkPDeJPllJaoQSmAcDrLb3ThrhAwHpO0eaPG4okhUgpH5s+N/jwYIZW8xK5tafei8FjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB3DA3EC09;
	Mon, 27 Jul 2026 12:19:55 +0000 (UTC)
Message-ID: <1b96b673264782427636f9924c3bc1221e199655.camel@hadess.net>
Subject: Re: [PATCH 1/4] usb: core: pass THIS_MODULE implicitly through a
 macro
From: Bastien Nocera <hadess@hadess.net>
To: Shashank Balaji <shashank.mahadasyam@sony.com>, Andrew Lunn	
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet	 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni	 <pabeni@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Matthias Kaehlcke	 <mka@chromium.org>,
 Valentina Manea <valentina.manea.m@gmail.com>, Shuah Khan	
 <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, Heikki Krogerus	
 <heikki.krogerus@linux.intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Daniel Palmer <daniel.palmer@sony.com>, Rahul
 Bukte <rahul.bukte@sony.com>, Tim Bird <tim.bird@sony.com>,
 linux-embedded@vger.kernel.org
Date: Mon, 27 Jul 2026 14:19:55 +0200
In-Reply-To: <20260722-mod_name_usb-v1-1-96d781530f3f@sony.com>
References: <20260722-mod_name_usb-v1-0-96d781530f3f@sony.com>
	 <20260722-mod_name_usb-v1-1-96d781530f3f@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Score: -100
X-GND-Cause: dmFkZTFCoccScwC5eVdujGPuhT/cg/ZYb0LWRLOgqTl+QHzAiK4piS5l1d5izVMuPwRODDq/oQKpFBzarL7h6HiAvcn/ERfLmojsC+5jFe0sn+MibMrLpjOWNWtim4YuVJCmN8mautHRow0AzLyDZlYa+9F+KHmrauC5xIsNrp10A/BjCkMkMG+tIncF1P5N0hXXemDjBAsp2mDi2UGU0xLwdwRjQe57mEvzfqJ8a4QhpFloLcNfEoMZzLmQqyA9pDS90qlYPPKG8lGX4S4m7zC89pK26Hy78n1XtcC3lJW+oOREubK6tT4JHtZs+XzVwBad3WxImw7g+Z93zPwPguBGd5eeE4LN/mvLaL//zC0AQTviUCX/3DVZt7ojsi/pxoUCg3KFyQBnk21X3hp7kSCJxFDtMZcXXJFUI/rdjBA5Jnrk7vBl89K1hddKYChze5M8JYum6Uib49RYuFtxNEDQJ4sdC7uCR0ciROPpRqNT+gbynIV9z1Q/v2gHkdfCANr/pa91/GiRcv/oClTubrmpnlpLVABYUdbdt0CoTKPos5lDKoy5hsffVzcIhQn8OinnX+HuAufe4Nm/9Ue2dXCPFPxii2Cv5RDKIc4KodX+HzT5u8OtMkusoBSPQ/fX5zGMp32ikKzdeOTsUIKecw8Z11VYikuU4yqxOL/7aBmB/AD/Uw
X-GND-State: clean

On Wed, 2026-07-22 at 12:31 +0900, Shashank Balaji wrote:
> Rename usb_register_device_driver() to __usb_register_device_driver()
> and replace
> it with a macro wrapper that passes THIS_MODULE implicitly. This is
> in line with
> what other buses do.

I found some examples by grepping for:
git grep 'THIS_MODULE)' include/ | grep driver

It could have been useful to mention some examples by name in the
commit message.

Cheers

> Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
> ---
> =C2=A0include/linux/usb.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
4 +++-
> =C2=A0drivers/net/usb/r8152.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/usb/core/driver.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 +++---
> =C2=A0drivers/usb/core/usb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/usb/misc/apple-mfi-fastcharge.c | 2 +-
> =C2=A0drivers/usb/misc/onboard_usb_dev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
2 +-
> =C2=A0drivers/usb/usbip/stub_main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A07 files changed, 11 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 1da4ad1610bc..2466183a45f0 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -1368,7 +1368,9 @@ extern void usb_deregister(struct usb_driver
> *);
> =C2=A0	module_driver(__usb_driver, usb_register, \
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 usb_deregister)
> =C2=A0
> -extern int usb_register_device_driver(struct usb_device_driver *,
> +#define usb_register_device_driver(new_udriver) \
> +	__usb_register_device_driver(new_udriver, THIS_MODULE)
> +extern int __usb_register_device_driver(struct usb_device_driver *,
> =C2=A0			struct module *);
> =C2=A0extern void usb_deregister_device_driver(struct usb_device_driver
> *);
> =C2=A0
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f61686433031..73b9b2af1ed2 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -10495,7 +10495,7 @@ static int __init rtl8152_driver_init(void)
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D
> usb_register_device_driver(&rtl8152_cfgselector_driver, THIS_MODULE);
> +	ret =3D
> usb_register_device_driver(&rtl8152_cfgselector_driver);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index f63004417058..eac1ff468c08 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -980,7 +980,7 @@ bool is_usb_device_driver(const struct
> device_driver *drv)
> =C2=A0}
> =C2=A0
> =C2=A0/**
> - * usb_register_device_driver - register a USB device (not
> interface) driver
> + * __usb_register_device_driver - register a USB device (not
> interface) driver
> =C2=A0 * @new_udriver: USB operations for the device driver
> =C2=A0 * @owner: module owner of this driver.
> =C2=A0 *
> @@ -990,7 +990,7 @@ bool is_usb_device_driver(const struct
> device_driver *drv)
> =C2=A0 *
> =C2=A0 * Return: A negative error code on failure and 0 on success.
> =C2=A0 */
> -int usb_register_device_driver(struct usb_device_driver
> *new_udriver,
> +int __usb_register_device_driver(struct usb_device_driver
> *new_udriver,
> =C2=A0		struct module *owner)
> =C2=A0{
> =C2=A0	int retval =3D 0;
> @@ -1023,7 +1023,7 @@ int usb_register_device_driver(struct
> usb_device_driver *new_udriver,
> =C2=A0
> =C2=A0	return retval;
> =C2=A0}
> -EXPORT_SYMBOL_GPL(usb_register_device_driver);
> +EXPORT_SYMBOL_GPL(__usb_register_device_driver);
> =C2=A0
> =C2=A0/**
> =C2=A0 * usb_deregister_device_driver - unregister a USB device (not
> interface) driver
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index df166cafe106..2559a180fdee 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -1241,7 +1241,7 @@ static int __init usb_init(void)
> =C2=A0	retval =3D usb_hub_init();
> =C2=A0	if (retval)
> =C2=A0		goto hub_init_failed;
> -	retval =3D usb_register_device_driver(&usb_generic_driver,
> THIS_MODULE);
> +	retval =3D usb_register_device_driver(&usb_generic_driver);
> =C2=A0	if (!retval)
> =C2=A0		goto out;
> =C2=A0
> diff --git a/drivers/usb/misc/apple-mfi-fastcharge.c
> b/drivers/usb/misc/apple-mfi-fastcharge.c
> index af266e19f2fd..02adec28d9e6 100644
> --- a/drivers/usb/misc/apple-mfi-fastcharge.c
> +++ b/drivers/usb/misc/apple-mfi-fastcharge.c
> @@ -245,7 +245,7 @@ static struct usb_device_driver mfi_fc_driver =3D {
> =C2=A0
> =C2=A0static int __init mfi_fc_driver_init(void)
> =C2=A0{
> -	return usb_register_device_driver(&mfi_fc_driver,
> THIS_MODULE);
> +	return usb_register_device_driver(&mfi_fc_driver);
> =C2=A0}
> =C2=A0
> =C2=A0static void __exit mfi_fc_driver_exit(void)
> diff --git a/drivers/usb/misc/onboard_usb_dev.c
> b/drivers/usb/misc/onboard_usb_dev.c
> index 11508ed4df25..c60406240416 100644
> --- a/drivers/usb/misc/onboard_usb_dev.c
> +++ b/drivers/usb/misc/onboard_usb_dev.c
> @@ -706,7 +706,7 @@ static int __init onboard_dev_init(void)
> =C2=A0{
> =C2=A0	int ret;
> =C2=A0
> -	ret =3D usb_register_device_driver(&onboard_dev_usbdev_driver,
> THIS_MODULE);
> +	ret =3D
> usb_register_device_driver(&onboard_dev_usbdev_driver);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> diff --git a/drivers/usb/usbip/stub_main.c
> b/drivers/usb/usbip/stub_main.c
> index 79110a69d697..01452f7bdabb 100644
> --- a/drivers/usb/usbip/stub_main.c
> +++ b/drivers/usb/usbip/stub_main.c
> @@ -371,7 +371,7 @@ static int __init usbip_host_init(void)
> =C2=A0		return -ENOMEM;
> =C2=A0	}
> =C2=A0
> -	ret =3D usb_register_device_driver(&stub_driver, THIS_MODULE);
> +	ret =3D usb_register_device_driver(&stub_driver);
> =C2=A0	if (ret) {
> =C2=A0		pr_err("usb_register failed %d\n", ret);
> =C2=A0		goto err_usb_register;
