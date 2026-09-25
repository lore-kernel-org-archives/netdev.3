Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98842E437;
	Fri, 25 Sep 2026 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314467; cv=none; b=QUvrrp+2snOGWsNoBG41DpqTLZ0WIKCEUP9+hEG/oZTH/YnEdeCot/LtWnNCB+e+iLOfBynrN6+W05zh+fD1+FCESBrT595OtDk79/noby54FIcEt2xFpnsHOaP7hc+vrWonUHdDpqfI0opZwZMQa8s3EiUQ7J1hcwCJJ1Gf0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314467; c=relaxed/simple;
	bh=fU6Wbsft1wL3tiHwqhy+D4YuGagBlWpYiM4Mto7kixQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kDz60ZD5leSI5aeb/izj+gm2w4fAnGkayycqlYV3I4jZq+j+W0j79vanqu7DTba/NALTXwr75u/jhPSlY6aiH5+OI+iPvRim9TcoIGCvlgd1z3KF/NAmdnFdkJf+8eQqjMbKhHuvLO96o04U5h+mWBIDdWt2jx46ky7VMPa+noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qacdg9Si; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qacdg9Si"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF211F00893;
	Fri, 25 Sep 2026 05:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790314465;
	bh=0zjee7LBZp4ThBjD99PhmhzgGuaGV/k+FawOuYMWgkM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qacdg9SiUc7GylU/vTNMtldVIANA8q3ZTJiKCcida94JY+XPlspz4KcFWd1X8l9TF
	 1KoQtbXV0HQqFj7F+eAbQ+/ALcC3+ThAL0eSuOIzX5buQg+Aj4d5Gf6chIDO7gIhAI
	 nbioD7M/3qXB8d+YXh5zRcvr1Cq3z+AUEjM6KDdaBo/q0an599Rox+LVCuKUw//Zmf
	 m+RJiJhZ4R0m4mqbPJbluwhXVwHWCwl7ua8H6N4z8Vhhtv2Z2nXAkl5qQ0bZs69f8X
	 i9B0RnQYA/yM4J7DxJ06cBZc6jvgQFvGFAzZ90yga4MQZkAPhPkNPrH0kc1Qct0lVu
	 gyCTMxg3Nt+jQ==
Subject: Re: [PATCH net-next v17 6/6] net: dsa: mxl862xx: document devlink
 flash and info support
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Fri, 25 Sep 2026 05:34:23 +0000
Message-ID: <179031446380.2160803.7779219284987374198@kernel.org>
In-Reply-To: =?utf-8?q?=3Cac0b51c0505596d1523b3d471b497a0c5515108e=2E1790130?=
 =?utf-8?q?482=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cac0b51c0505596d1523b3d471b497a0c5515108e=2E17901304?=
 =?utf-8?q?82=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] mxl862xx.rst says that "In the rare case that the reprobe cannot
  be scheduled at all, ``devlink dev flash`` reports that error and the…
- [Low] The "Rescue lifecycle" overview comment at the top of
  drivers/net/dsa/mxl862xx/mxl862xx-fw.c says "devlink dev info exposes…

--

net: dsa: mxl862xx: document devlink flash and info support

This adds Documentation/networking/devlink/mxl862xx.rst. The new file
describes the devlink info versions and how flash update behaves,
including recovery from MCUboot rescue mode. The file is linked from the
devlink index and added to the driver's MAINTAINERS entry.

> diff --git a/Documentation/networking/devlink/mxl862xx.rst b/Documentation/networking/devlink/mxl862xx.rst
> new file mode 100644
> index 0000000000000..793f3521f505f
> --- /dev/null
> +++ b/Documentation/networking/devlink/mxl862xx.rst
> @@ -0,0 +1,91 @@

[ ... ]

> +Flash Update
> +============
> +
> +The ``mxl862xx`` driver implements support for ``devlink dev flash``.
> +The signed firmware image is transferred to the switch over the same
> +MDIO bus which is also used to manage the switch, then verified and
> +installed by the MCUboot bootloader running on the switch. All ports
> +of the switch are closed for the duration of the update and the driver
> +reprobes the switch after it has rebooted into the new firmware; they
> +come back registered but down, so userspace brings them up again. A
> +complete flash and reprobe cycle takes about one minute. In the rare
> +case that the reprobe cannot be scheduled at all, ``devlink dev
> +flash`` reports that error and the driver stays bound to a switch it
> +no longer tracks until it is unbound and rebound. A reboot started

[Severity: Low]
Does this hold on every path through mxl862xx_devlink_flash_update()?
The reprobe scheduling error is only returned and logged when the
transfer succeeded:

drivers/net/dsa/mxl862xx/mxl862xx-fw.c:mxl862xx_devlink_flash_update() {
    ...
	priv->skip_teardown = true;
	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
    ...
	err = device_schedule_reprobe(ds->dev, MXL862XX_FW_REPROBE_DELAY_MS);
	if (!ret && err)
		dev_err(ds->dev,
			"flash: new firmware is running but re-probe could not be scheduled (%pe); unbind and rebind to reinitialise\n",
			ERR_PTR(err));

	return ret ? ret : err;
}

Suppose mxl862xx_flash_firmware() or mxl862xx_wait_ready() failed, and
device_schedule_reprobe() then also returned -ENOMEM or -EINVAL. In that
case the reprobe error is not returned, and the dev_err() that tells the
user to rebind is skipped.

skip_teardown has already been set unconditionally. With no reprobe
pending, nothing clears it. Would every later flash then fail here until
a manual rebind?

	if (priv->skip_teardown) {
		NL_SET_ERR_MSG_MOD(extack,
				   "a previous flash awaits its reprobe");
		return -EBUSY;
	}

The document says -EBUSY only means that a rescue recovery is in
progress. Should the code report the reprobe failure on this path too?
Or should the document mention this -EBUSY and the rebind it needs?

> +while an update is running waits for the transfer to finish, and an
> +update requested after the system has begun shutting down is refused
> +with ``-ENODEV``.

[ ... ]

> +If the driver gives up on the recovery, ``devlink dev flash`` returns
> +``-EIO`` and says so in its extack message. The drain runs once and is
> +never resumed, so a failed MDIO transaction ends it as well. A loader
> +that stops answering the drain needs a power cycle; a completed drain
> +whose reprobe could not be scheduled, and a drain a bus error cut
> +short, need only a driver rebind. The driver re-examines the switch
> +when it binds and at no other time, so a power cycle on a board where
> +the switch can be cycled on its own still has to be followed by an
> +unbind and rebind for the recovered switch to be recognised.

[Severity: Low]
This paragraph documents the -EIO case. The rescue lifecycle comment at
the top of drivers/net/dsa/mxl862xx/mxl862xx-fw.c was added earlier in
this series, and it still says:

 * devlink dev info exposes the fw version (the "flashable" signal) only once at
 * READY; flash_update returns -EBUSY until then, and reprobes to WSP firmware
 * on success.

However, once rescue_failed is set, mxl862xx_devlink_flash_update()
returns -EIO permanently:

	if (READ_ONCE(priv->rescue_failed)) {
		NL_SET_ERR_MSG_MOD(extack, "download recovery failed");
		return -EIO;
	}

rescue_failed is set in three cases:

- mxl862xx_rescue_heal_work_fn(), when the drain fails
- mxl862xx_rescue_heal_work_fn(), when the post-drain reprobe cannot be
  scheduled
- mxl862xx_rescue_mode_detect(), for an interrupted opening handshake

In each of these cases the loader never reaches READY.

Could that comment be updated to mention the -EIO state, so that it
matches both the code and this document?

> +
> +A download interrupted during its opening handshake, before the image
> +header reached the loader, is reported the same way. The loader waits
> +for a header that no later session can supply, so that state needs a
> +power cycle.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790130482.git.daniel%40makrotopia.org
