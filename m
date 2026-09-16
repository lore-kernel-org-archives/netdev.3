Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21C03F1676;
	Wed, 16 Sep 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541263; cv=none; b=Z6PhD/2y45iABl/g9HjkgfPF+gQexDrPswzbylm8PnwS7sDctOj6eQ6Z/EFUrHTvxGv+D6LCfezv6tUpLRzVFJtk+RiQAt9a37qfDye8tuDw+9pL6pEPCGBHxf6YvcIuvyiiwn5OVgyUKQFXgTxonErVLEHlvS59tsi5khfOiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541263; c=relaxed/simple;
	bh=IFulbmEuqy4CF1cg0dkyO+vB+M/ESj+Td8ClQth3vJ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SsepgfsiuiiHht2FcJiUDuxCPKSGpqKPiWB2h2uIYwuOeWiajxSougXuJ2Dk5FgMdzFIUK/jAOvvrQlYyyHXXjOD38bwi2bOd18mO/nvSxru2KYHlMFzfBPnAOpf5jBBdTBwsfsxUbVsmFraoPsFp9Hnmvstf/b5whKuMnRTg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4Dpnovt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4Dpnovt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9908F1F00899;
	Wed, 16 Sep 2026 06:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541257;
	bh=EBYnNfobxkwbJ1VnlYTnwJgXrB89CKfN7NH1vH8X2QA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E4DpnovtuTZ0dvvh5JUE0EJGcWpukf/jJwbQ6rMXOKZf0Ilr7sPrkzabHXmBfaNcn
	 z7tkHmypybofibvgSaqoyaqpjKWO5Q63MiK6s0Bc6tjF3muUmSbC1iJlnpApCingcU
	 fex/pUZKzCwHy6aZzCvOCtKsjsZjNu+qHOR1MIzFyyhBV4TavmRnyXCGdQOO7n5TL0
	 qsc7lq5VPvsxKaDpd1O/lDXd5Z9B2AmBHOtzrTi7FWmTAuMsatIc5YUhWOTZQgaI60
	 pAxX+cveXracnjdBjMyRm+4tgdfkDOoX8ajz/2omvHfJ8ea2UrCUm5GFbGmicoxkmv
	 A7DcftTy/AESg==
Subject: Re: [PATCH net-next v11 12/15] ax88179_178a: Add ethtool get_drvinfo
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Wed, 16 Sep 2026 06:47:36 +0000
Message-ID: <178954125615.22033.17609998606190122195@kernel.org>
In-Reply-To: <20260914-ax88179a-v11-12-5ea7a925ba6d@birger-koblitz.de>
References: <20260914-ax88179a-v11-12-5ea7a925ba6d@birger-koblitz.de>
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
  (drivers/net/usb/ax88179a_devices.c:221-233) exports a four-component…
- [Low] Failed bootloader register reads are exported to userspace as a
  genuine firmware version.

--

ax88179_178a: Add ethtool get_drvinfo

This adds ax88179a_get_drvinfo() as the get_drvinfo implementation for
ax88179a_ethtool_ops.  It calls usbnet_get_drvinfo() first and then, for
chips at least as new as AX_VERSION_AX88179A, overwrites
info->fw_version with the four bytes cached in priv->fw_version.

> diff --git a/drivers/net/usb/ax88179a_devices.c b/drivers/net/usb/ax88179a_devices.c
> index 27836c72ec14a..817d542c4cc08 100644
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

[Severity: Low]
Should a failed bootloader read be reported as a real firmware revision
here?

In ax88179a_bind(), a failing ax88179_read_cmd() on AX88179A_ACCESS_BL
stores a sentinel and binding continues:

	for (int i = 0; i < 3; i++) {
		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, (0xFD + i),
				       1, 1, &ax179_data->fw_version[i]);
		if (ret < 0)
			ax179_data->fw_version[i] = 0xff;
	}

No validity flag is kept, and ax88179a_get_drvinfo() only gates on
priv->chip_version before overwriting the string that
usbnet_get_drvinfo() filled from dev->driver_info->description:

	strscpy(info->fw_version, dev->driver_info->description,
		sizeof(info->fw_version));

So after a transient control-transfer error on registers 0xFD..0xFF,
ethtool -i prints firmware "255.255.255.0" rather than falling back to
the description string.  Would tracking a "firmware version unknown"
state in ax88179a_bind() and skipping the snprintf() in that case be
preferable?

> +	snprintf(info->fw_version, sizeof(info->fw_version), "%d.%d.%d.%d",
> +		 priv->fw_version[0], priv->fw_version[1],
> +		 priv->fw_version[2], priv->fw_version[3]);
> +}
> +

[Severity: Low]
Where does the fourth component of this version string come from?

The only producer of priv->fw_version[] is ax88179a_bind(), and its loop
only reads three bootloader registers:

	for (int i = 0; i < 3; i++) {
		ret = ax88179_read_cmd(dev, AX88179A_ACCESS_BL, (0xFD + i),
				       1, 1, &ax179_data->fw_version[i]);

struct ax88179_data is allocated with kzalloc_obj(*ax179_data) in the
same function, and u8 fw_version[4] in ax88179_lib.h has no other writer
in drivers/net/usb/, so fw_version[3] stays 0 forever.

That makes ethtool -i always report a trailing ".0" that the device never
supplied.  Is the read loop short by one register, or should the format
string be "%d.%d.%d"?

>  static void ax88179a_bulkin_config(struct usbnet *dev, u8 link_sts, u8 speed, bool full_duplex)
>  {
>  	struct ax88179_data *ax179_data = dev->driver_priv;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914-ax88179a-v11-0-5ea7a925ba6d%40birger-koblitz.de
