Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A272AE68;
	Tue, 11 Aug 2026 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452720; cv=none; b=qP16xUhoCgWjFKeWmyejJSLM5rfmYkJmMRIwkAQqwDuUPMYI9c7SVYIC0D6eceVzWES1kAx0KeK6mxlbQfE2uQGo0/ZCuMVSHz5uYFH1uFQ5biTkhd1zuO8itOUYL/S8p1ebfbyl9Kdpp84cubzl0bQkDIA6qb0h/yxEANf8phY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452720; c=relaxed/simple;
	bh=nwJ9YKqkbR2k+hsE/PDM5hw9eWPD8Fzc4D+yslkcfbA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=tQiHYis/XeuCBA3p5jmWyGP8ELVRPhV45rI73MxgVQFdcSE1Kx5F/yKFqi/mfVlQhcTkUMFPWuzFMLc44Hkv+HrNqq0L4O+Zgt0on2sZvguAYxFD1QLkJmAWBMYVF+ERKw01uWDfjQnPcn1T1zC0q5cl/4T2+KYSdI9wAbiknb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=YtpEFiZa; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="YtpEFiZa"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3F813A69AD;
	Tue, 11 Aug 2026 14:51:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1786452706; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dqGGCV7H+PfNP8j8FyeJ5Y/S+SJSQztYrkpKWX7EG2I=;
	b=YtpEFiZan/vFCcPBVmB6R6XHD7bxvU1wWGGhU4Xb/jAe7jyMS7NAGLLSqdMXnnLajC+XyS
	iGl9pfL5qu/5a5k01cmj8oLtyXv94VAuBbBox3NzlJv0MKvLzEyk+3QolYuIdPo8KZzilZ
	IY0McEq7KuVnBKDiAFYvnyF75MfFP4h6A4bHOZuBTrJmGInRCgKHfPOsExotdgTzfGE/mi
	WYpjKybufCjsGA4tLD5FhXGXBCeL84/uIHQNIs9m0puIqNIMbkZfK+WDgkaQmhLSfFTRs/
	zpG6dQmMmv/WMkpYWnOizSjUjE6ID9+dOrEtZvXvqQ+HzKQ1aeg91vODXvdsDQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 14:51:43 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: microchip: enable SGMII port for
 KSZ9897
In-Reply-To: <20260811-ksz9897-sgmii-port-v2-1-04ae287a0b27@vaisala.com>
References: <20260811-ksz9897-sgmii-port-v2-1-04ae287a0b27@vaisala.com>
Message-ID: <462378b275d60c704bd0d97d6383c528@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Tapio

On 11.8.2026 12:20, Tapio Reijonen wrote:
> The KSZ9897 has an SGMII/1000BASE-X capable port 7, but its chip_info
> entry never set .sgmii_port.

AFAIK only the KSZ9897S variant.  AN5513 says the S "contains the same 
SGMII
port as the KSZ9477 however, the KSZ9897R has a second RGMII port", and
the R data sheet never mentions SGMII at all.

Unfortunately the chip id for both seems to be identical (0x00989700), 
so
this would apply to the R variant too. With this the R variant should
return -ENODEV in ksz9477_pcs_create() during probe.

Have a look how KSZ9563 is split off the KSZ9893 chip id, so maybe it 
can
be solved in a similar manner.  PORT_SGMII_SEL could also be worth a 
look.

> As a result ksz_has_sgmii_port() is false,
> ksz9477_pcs_create() is never called, and 
> ksz9477_phylink_mac_select_pcs()
> returns NULL for port 7, so no PCS is ever instantiated and a
> phy-mode = "sgmii" or "1000base-x" link on that port cannot come up.
> 
> The KSZ9897 shares the KSZ9477 register layout and operations
> (ksz9477_dev_ops, ksz9477_regs) and reaches its port-7 PCS through the
> same SPI-indirect XPCS register window. The register-identical LAN9646
> already enables this via .sgmii_port = 7. Set the same for the KSZ9897
> so the XPCS instance is created and 1000BASE-X / SGMII links on port 7
> negotiate correctly.
> 
> Tested on a KSZ9897 with a 1000BASE-X fibre SFP wired directly to
> port 7: the link negotiates at 1Gbps/full duplex and passes traffic.
> 
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
> ---
> Changes in v2:
> - Resend only, no functional change: v1 was dropped when the netdev
>   patch queue overflowed.
> - Rebased onto current net-next.
> - Link to v1: 
> https://lore.kernel.org/r/20260703-ksz9897-sgmii-port-v1-1-387e7632dd0b@vaisala.com
> ---
>  drivers/net/dsa/microchip/ksz_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c 
> b/drivers/net/dsa/microchip/ksz_common.c
> index 
> 1a9d6f83a0232830ac4996ae5f53b8bde0b3747d..a80fde0a8c7e93ea2db4baeb2f941a260e23b687 
> 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -1484,6 +1484,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
>  		.internal_phy	= {true, true, true, true,
>  				   true, false, false},
>  		.gbit_capable	= {true, true, true, true, true, true, true},
> +		.sgmii_port = 7,
>  	},
> 
>  	[KSZ9893] = {
> 
> ---
> base-commit: b54074ffb813aa4b97585d97ae1ead69d96432b5
> change-id: 20260703-ksz9897-sgmii-port-48ddb100e015
> 
> Best regards,

Thanks,
Nicolai
