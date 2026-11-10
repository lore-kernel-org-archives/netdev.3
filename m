Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274723;
	b=N0+lzbKcGb/0Be7JR9kKlfKHVq6I+UjtdyriOFhknSd2tyIDt2bK15HaRGktjscFTZR6
	 ueqpqxzeq9ycrA7sQIrT3iIna5QlGLUmtG6c0dEDRAuHVd/EdaqtyjmyCU5YBQts/4ESE
	 26er82+dvrksgf5kNmizF2p37eirrK6hck4SH+lLbGTG5o37Lt0jOu8/Z3DfEf4hX6BdZ
	 g83EMbNFiOjHh7qGYy5EmuuAnnsdNkWSYlZY7ih+sMr/N8WjSsp09tDbwJ3QlVuAY4Tgg
	 K7HOeHw+dWyOUtj/+IIJIvapwNFBkBwP7JCnk687BEOHWaad8L7lZariZoRDs+2LMDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274723;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=doZoe4aIFR153J4DeHnx0h6Brqb1kP7U8s4t1gWPqrw=;
	b=G6Vl2sqgYAPzUZlsTRP5wD5x4lGcCU45Kt8Wvd6dYVvg9Fs63Y1oNPtUpaTqfUdKhBRr
	 8c1GA8FV8J0l0lYmHp+ocx+hyiP/47asl00nBEoYn3PT5Md3m+XE3T80xvedfP8aH82QC
	 lsdQh7RxoyUgxwKq4poOVX3DHvwD25Y0jIWzoM4WqV2xxsazdYfqhfzAdEC4bHXmmaalV
	 GjFjRmTgYNH6DpkGP8cWE1FuG8o2GJKykoC4ckrsgoxAC0nQR2lTKnImVTXu8KUV2/GEu
	 s8lR1v5SABkh844sgpwiFbFewgM3GffgQkpfjalbnpbx37M8TojpSUKj75sS7upwEaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZgYQ6v3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B6606A923;
	Tue, 10 Nov 2026 01:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eZgYQ6v3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B4F1F008A1;
	Tue, 10 Nov 2026 01:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274722;
	bh=doZoe4aIFR153J4DeHnx0h6Brqb1kP7U8s4t1gWPqrw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eZgYQ6v32m3laP4GzmNCTFoNzlivGQYASsZ64kjndKUbgJFCqUFzJOd/8uSRjkHLe
	 xrkUwU9+2J8/S5NrssKKLwpe2kqkrPnZlzGFDvxYm2Ik/rZ+RX0ln36bhmN+7PhhWV
	 Gaawzk/rBZkx3geHkz0jK/so4rnKM/3M/Ms7qwnorC4OjOvvTY40E8ZajFR/5WpKTF
	 TNPoT8zvxWd71k/lZbeMa+rSxiOuhurqVhf6x7NW4Z2z6SZGBfpxUPTNdtC8pZymqc
	 hKa0PS8uSgdhQ/0gzEHdnpWXK08ZbSwKLhclZ1HJHP13LeN8D6RUQlEXneIokKw7fb
	 WmbhnieJACgNQ==
Subject: Re: [PATCH net-next v20 10/13] ax88179_178a: Add ethtool get_drvinfo
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name,
 edumazet@kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 neuromoments@gmail.com, beganovic.emir@gmail.com
Date: Tue, 10 Nov 2026 01:38:41 +0000
Message-ID: <179427472156.994134.3745486112542949621@kernel.org>
In-Reply-To: <20261106-ax88179a-v20-10-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-10-37b5a1189983@birger-koblitz.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] ax88179a_get_drvinfo() (drivers/net/usb/ax88179a_devices.c)
  always overwrites info->fw_version with the cached…

--

ax88179_178a: Add ethtool get_drvinfo

This commit adds ax88179a_get_drvinfo() as the get_drvinfo ethtool
callback. It uses the usbnet defaults and then, for AX88179A and newer
chips, overwrites fw_version with the four firmware bytes cached at
bind time.

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 01d6a35f68b2c..69095110e7043 100644
> --- a/drivers/net/usb/ax88179a_devices.c
> +++ b/drivers/net/usb/ax88179a_devices.c
> @@ -235,6 +235,20 @@ static int ax88179a_resume(struct usb_interface *intf)
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

[Severity: Low]
Could this report a firmware version that the device never returned?

In ax88179a_bind(), a failed firmware read is replaced with 0xff and
bind keeps going:

drivers/net/usb/ax88179a_devices.c:ax88179a_bind() {
    ...
	for (int i = 0; i < 3; i++) {
		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, AX88179A_SW_VERSION + i,
				       1, 1, &ax179_data->fw_version[i]);
		if (ret < 0)
			ax179_data->fw_version[i] = 0xff;
	}
	ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, AX88179A_SW_REVISION,
			       1, 1, &ax179_data->fw_version[3]);
	if (ret < 0)
		ax179_data->fw_version[3] = 0xff;
    ...
}

If any of these USB control transfers fail, ethtool -i would show
"255.255.255.255", or something mixed like "1.2.255.3" when only some
reads fail. That string also replaces the driver_info->description
default that usbnet_get_drvinfo() has just written.

Before this patch the 0xff sentinel only appeared in the netdev_info()
line printed by bind.

Would it make sense to record whether the reads succeeded and, when
they did not, skip the overwrite (keeping the usbnet default) or report
something like "unknown"?

aqc111_get_drvinfo() in the same directory also reports firmware bytes
without checking for read errors.

> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106-ax88179a-v20-0-37b5a1189983%40birger-koblitz.de
