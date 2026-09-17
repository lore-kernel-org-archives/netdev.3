Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D794FD297;
	Thu, 17 Sep 2026 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680308; cv=none; b=e449FkFyHsxdP8kUcwLWg7cXx9FI263ZdezcjH3HpfeRrSth21KuZVbYxNZTEG9wpB9w7qpCfMKSQqB8Kpz0+4a7FP3KOfBmD3GqobRmHQoWXSh2kZvO9lJhw7kATXBman/vryJ15vvou707k6/CVdrYkBcl5HsLHLRS1CBTXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680308; c=relaxed/simple;
	bh=ig6PLkpRVUOE9dMy5a3f7P5LJnX8+AspprzOd7wuNmg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MdWwpd2NwEMjy+blm8xXN8LMnJzQycUkNRUYQJ3RnuqRCFnH0uQ0zw10bSi4KXel0OCVLXvELh67FozkqEj+R9NOi1OfHWZBzkR86VZgL33+R8Ef4BnKRlkU8nbS1khVKv9c0UIKp+M5XgQIScAIYr+pVJMlXs2o2emqGViR+4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7GhWitN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7GhWitN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727F61F00899;
	Thu, 17 Sep 2026 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680306;
	bh=GWe2Sv68cwfeekZJ2lWUj9svBS+mZ4h6GbdLCiBicfM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D7GhWitNEdaBLaFHWXZKltnfmqV7i8xA6ilcvrz6MO9779b6W8fCl+hYp3BTHdV5R
	 Zf4lAxAP4jVes22ZD/SyHu5Zzmoetd3ZQAc4Rl+0956fWB+NojYPw8Lj28EzAeo9h5
	 AyFrFKw4w1WmzNisCar8YvRpw9VjkUTbqIS3rg48mUnCMbCZ5cnbdZLvQbOEPrenHD
	 x+nrd2JtQkyEcp2eiJLwQmAL2nJ0I7ZZTHE7E1Dr5XiRVejKil0Q9rI1fI6DI5TPvS
	 t4P6sqGjksd7GJ7nuQHM8Qb0s70/01eXA1Ws7bjr9xr1PLcdidx/nmRLVNdCkgR/vJ
	 y4uiy9khAxWRA==
Subject: Re: [PATCH net-next v12 12/15] ax88179_178a: Add ethtool get_drvinfo
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:25:05 +0000
Message-ID: <178968030501.22033.322532364708711574@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-12-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-12-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] ax88179a_get_drvinfo()
  (drivers/net/usb/ax88179a_devices.c:221-233) formats the ethtool…
- [Low] When a bootloader-window read fails in ax88179a_bind()
  (ax88179_read_cmd() < 0 at…

--

ax88179_178a: Add ethtool get_drvinfo

This adds ax88179a_get_drvinfo() and wires it into ax88179a_ethtool_ops so
that ethtool -i reports the cached firmware version bytes for AX88179A and
newer chips. It calls usbnet_get_drvinfo() first and then overwrites
info->fw_version with the four cached bytes.

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index ff41d20c219d4..6225b88681e62 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -218,6 +218,20 @@ static int ax88179a_resume(struct usb_interface *intf)
>  	return usbnet_resume(intf);
>  }
>  
> +static void ax88179a_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *info)
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

[Severity: Low]
Is the fourth component here ever read from the device?

The only writer of fw_version[] is the loop in ax88179a_bind():

	for (int i = 0; i < 3; i++) {
		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, (0xFD + i),
				       1, 1, &ax179_data->fw_version[i]);
		if (ret < 0)
			ax179_data->fw_version[i] = 0xff;
	}

That fills fw_version[0..2] only, and the container comes from
kzalloc_obj(*ax179_data), so fw_version[3] is always 0.

Grepping fw_version[ over drivers/net/usb/ finds no other assignment, so
the last component of the string exported through ETHTOOL_GDRVINFO is a
constant 0 rather than something read from the chip.

Should the loop read a fourth bootloader register, or should the format
string print three components?  The declaration in
drivers/net/usb/ax88179_lib.h:

	u8 fw_version[4];

the read loop, and this new format string currently disagree about how
many bytes the firmware version has, and this patch is what turns that
disagreement into a user-visible string.  The same mismatch is still
present at the end of the series (cfe9f4be1c4a5ee15cf890112026b94028566314).

[Severity: Low]
What does userspace see when the bootloader-window reads fail?

In ax88179a_bind(), a failed ax88179_read_cmd() stores a sentinel and the
error is not propagated, so bind continues:

		if (ret < 0)
			ax179_data->fw_version[i] = 0xff;

With this change, ethtool -i then reports "255.255.255.0" as if the chip
had answered the vendor request.  Before this patch the sentinel only
appeared in the netdev_info() line at bind time, where the surrounding log
gave context.

Would it be preferable to leave info->fw_version as set by
usbnet_get_drvinfo() when the reads failed, or to track a "version unknown"
state, rather than formatting the sentinel bytes?  This is unchanged at the
end of the series (cfe9f4be1c4a5ee15cf890112026b94028566314).

> +
>  static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed, bool full_duplex)
>  {
>  	struct ax88179_data *ax179_data = dev->driver_priv;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
