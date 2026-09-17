Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3D4F68A6;
	Thu, 17 Sep 2026 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680298; cv=none; b=fLw9++bOmRHA8j6fUFgSomXzLuETkt3HE+kiT/pDNwSkH7FHdgvjNp2P1UZZaSQE2Dj2tnpEoZh7LVup37KoHWdTWMlNjhYt7pe0zWSFxgNGfRlVZdUBnKqXeazcyKKtCec8QHkdTZwt7eLIVthciIdqguQ4ZuObFrRdl6ykeaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680298; c=relaxed/simple;
	bh=+b+Re82fV3XniJuNf9RyLREM1NjNU5D0Y6InUbFlXX0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gxR8ceuaiCsJV3q/DMMu7YpTgkiA6B43hhkBSdWNJ+OnMSLFt9+hokQxKncAOkPJRNJF4AB7kER2p31eOUvn5nNUcDPokFIbW0oAEE/XDMAoVha9xOO0f8Mo0JuRq7ss1MgBSVNSzY1lROSSM+Ov36vcr74O4TtWXRlRBrcn1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tuos27DL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tuos27DL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87A11F00899;
	Thu, 17 Sep 2026 21:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680296;
	bh=T9NdcAX/Gc+WFsg0GZ4lR00nAlUKdnD+K60BQFxUVho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Tuos27DLzto/3gpqtSRS8Iz1NZ0sssqflwP8KYjqSerWecumNmbYAWwEvzGkQnp9S
	 FCewc4TL4BXP8XdJrEdXyZ3s82zU1QVpwkuD8yl8+azRvxLLyHiyHk/lM1t6mCywab
	 6ADK15g4SVi/zGPtZpaXJtjbb4pXBAM6KYDNk79DcAfSSs0rD8FXg0aI27schuG+HI
	 WViMfPP0t+8viQ0BGsukkS4gCDk4UAP6RATUA/ATFsfUlXxoGxeva88W45E8YlLDYm
	 MixKRXZqbFHmDF1fzmluAeDRHyuivC0MkWLPPT3yV5qLrWiYa0OB4HawpG1JoKYruT
	 yghZWSS7nsU7w==
Subject: Re: [PATCH net-next v12 05/15] ax88179_178a: Add netdev2data()
 convenience function
From: netdev-bot+sashiko@kernel.org
To: mail@birger-koblitz.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk, andrew@lunn.ch,
 hkallweit1@gmail.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, neuromoments@gmail.com
Date: Thu, 17 Sep 2026 21:24:55 +0000
Message-ID: <178968029536.22033.3161728030587874115@kernel.org>
In-Reply-To: <20260916-ax88179a-v12-5-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-5-60c04c9924a2@birger-koblitz.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] drivers/net/usb/ax88179_lib.c:131 adds the globally visible
  helper netdev2data() which has no caller at this commit, and the…

--

ax88179_178a: Add netdev2data() convenience function

This adds a small non-static helper netdev2data() to ax88179_lib.c, plus
its prototype in ax88179_lib.h, which returns the ax88179_data structure
belonging to a net_device via netdev_priv() and usbnet->driver_priv.

> diff --git a/drivers/net/usb/ax88179_lib.c b/drivers/net/usb/ax88179_lib.c
> index 761701ebc0692..ea36aef3d3e45 100644
> --- a/drivers/net/usb/ax88179_lib.c
> +++ b/drivers/net/usb/ax88179_lib.c
> @@ -128,6 +128,13 @@ int ax88179_write_cmd(struct usbnet *dev, u8 cmd, u16 value, u16 index,
>  	return ret;
>  }
>  
> +struct ax88179_data *netdev2data(struct net_device *net)
> +{
> +	struct usbnet *dev = netdev_priv(net);
> +
> +	return dev->driver_priv;
> +}
> +

[Severity: Low]
This isn't a bug, but netdev2data() has no caller at this point in the
series, and the commit message describes the users in the present tense:

    Add a convenience function for the ethtool ops that use
    phylink and need to retrieve the ax88179_data structure from
    net_device.

Checking the end of the series, the callers do arrive later: the patch
adding HW support for AX179A-based chips introduces
drivers/net/usb/ax88179a_devices.c, and together with the follow-ups it
calls netdev2data() from ax88179a_get_drvinfo(),
ax88179a_get_pauseparam(), ax88179a_set_pauseparam(),
ax88179a_get_eeprom_len(), ax88179a_get_eee(), ax88179a_set_eee() and
ax88179a_mii_ioctl().

Would it be clearer to say the ethtool ops using this helper are added in
a following patch of this series?

Also, the existing open-coded netdev_priv() plus driver_priv sequences in
ax88179_lib.c and ax88179_178a.c are left as they are. Was leaving them
unconverted intentional, or is that planned as a separate cleanup?

> void ax88179_status(struct usbnet *dev, struct urb *urb)
>  {
>  	struct ax88179_int_data *event;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ax88179a-v12-0-60c04c9924a2%40birger-koblitz.de
