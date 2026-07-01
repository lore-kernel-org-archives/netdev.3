Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF32925DB1A;
	Wed,  1 Jul 2026 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782899606; cv=none; b=nRc4zidnrCaNCi/fnNutxlbo6hCKUylDYJ6SzLewCDqP9UQfoEIoo3eZZwCGQpSBDXBWngj0MmeYXcB7PES1Y4xOpOotBUBtBr9Uqi1QFghRzvV+nnGaF1hmmlUOylFWO6F1Uxv/7YVd6TJ9U+4bI4zqw57nqYsXjD0RLBpZeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782899606; c=relaxed/simple;
	bh=4yWx7+wWKll8LfStxFYdc1EZsluomfflESdjuaJGmP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PH2TAHUESWM9W2cOakbL8UKCcy/L1jGwv/nt61tH3muDiD4BNdGoN1qmjl3FNEjgGXd7cxwR+i7kDE/LwwdnN05E1SSdldwTR3TnmcE+AR+9k7aB7wx8U9nSJrbrAdaFm+FYHQufwmu+JzEF+jCLznWvmzIp7Geif7nIIlYX4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k+6F003K; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k+6F003K"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AC39BC5CD64;
	Wed,  1 Jul 2026 09:53:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C6C4460288;
	Wed,  1 Jul 2026 09:53:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3A4C8104C94A5;
	Wed,  1 Jul 2026 11:53:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782899601; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=IEWJEb3JrdbjQ+gEU1Bac3pMIwncFv4u+WEahNukHjs=;
	b=k+6F003KBfLXoimOLdZd07YO1FK/iseBVjlu4mt6RCKoWI59xnq9L2QLghBgHWzUXbs8WA
	rPLOt+yNpLaOWTFTDbwuPGHQBztswCxWWMyTPay4YeCXx/5qWc616eAYZBnTCcWtMDiNgX
	+7axuyepSH2vxcOtoY8/9EKF0jpXSWzAj7Pfpcw78KqhCxi7XnNXhdwm6tU9FCedGP0rkq
	l8te4UcTTuhT6ChSyRuBOc7Wld+YyPv9T/r3vg1IQ2GWgquxmziYUhht821vwFP2UagEjJ
	NrJUuFH46GmDv4mx7R40W91K5MgsoADVgw7uf8VjhyHP38NhAJjyqN9YqQF4Uw==
Message-ID: <b01b4c18-bb2d-413b-a993-4a9cf4d50549@bootlin.com>
Date: Wed, 1 Jul 2026 11:53:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] ax88179_178a: Add support for AX88179A MMD access
To: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-3-13685df67515@birger-koblitz.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260701-ax88179a-v1-3-13685df67515@birger-koblitz.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/1/26 07:42, Birger Koblitz wrote:
> The AX88179A uses a much simpler Clause-45 MMD access interface,
> make use of this interface and abstract MMD read/write operations
> for the AX88179 and AX88179A architecture by introducing
> ax_read_mmd() and ax_write_mmd(), which in turn call the chips'
> respective implementation.
> 
> Make use of the MMD read/write functions in the link-speed and EEE
> configuration settings via ethtool in order to support the
> AX179A-based chips. The AX88279 supports EEE only at 1000MBit speed,
> the other chips require full duplex.

Please split this into smaller patches, one for the mmd accessor conversion,
one for eee, one for the new chip support, etc.

> 
> Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>

[...]

> @@ -866,34 +924,63 @@ static int ax88179_set_link_ksettings(struct net_device *net,
>  				      const struct ethtool_link_ksettings *cmd)
>  {
>  	struct usbnet *dev = netdev_priv(net);
> +	struct ax88179_data *data;
> +	int v;
> +
> +	data = dev->driver_priv;
> +
> +	/* mii_ethtool_set_link_ksettings handles unknown bits in MII_ADVERTISE
> +	 * transparently, so for the 2.5GBit link speed of the AX_VERSION_AX88279
> +	 * we just set up ADVERTISE_RESV before calling mii_ethtool_set_link_ksettings
> +	 * at least for speeds < 2500
> +	 */

ADVERTISE_RESV isn't an unknown bit, it's been added in 802.3 as ADVERTISE_XNP
for Extended Next Page, see :

commit e7a62edd34b1 ("net: phy: qcom: at803x: Use the correct bit to disable extended next page")

we shoudln't use ADVERTISE_RESV anymore in-kernel (there are a few callsites left).

As this seems to be a vendor-specific behaviour for that bit, please add a
local #define for it in this driver, to make it clear that this is a device-specific
value.

Thanks,

Maxime
