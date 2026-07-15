Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39D03C4B82
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101384; cv=none; b=Sk5S50WqCD8NrA/40aYq44Z5LVOdGe3RwnIjoIT34WzxHVR7Bqk09KpEOdEr6pWbJ93UgSTKJ0RehncRKIbNg+cGCOdFdVFfKYF6IFRfsh5z567Ssj7/arxSYYVDbo7i14Ezp/W2THb7769auF8xy02uRWSBgfR0nawU/qEh5C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101384; c=relaxed/simple;
	bh=NcAElaD8sUPAH/N68yI6IGuU8KvxdjdQAR9Xh87DRg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+X6p78DJaDd8nQm35xURRUPpO9iy6cJF6gdUTsv4iF6mJw9evRY8RMSxW6v4p2l5MiQ87agcx0wVYMpcZtwoN0EIus5SO0hYze087F9iT3aLoB0J7ghAhW6b2aSDURTyCq8PtHgcKc7GKXsjFuDiW4kwe/Y/WlLmkL/AKQRHEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=y3/wcrVG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="y3/wcrVG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 38FBF1A0FEF;
	Wed, 15 Jul 2026 07:43:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F1C456035C;
	Wed, 15 Jul 2026 07:42:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB67711BD3B89;
	Wed, 15 Jul 2026 09:42:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784101378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=l5VRDyCcYFi+uaCDadAWQtjOhPYTHQGMGvYp4MEsRiQ=;
	b=y3/wcrVGRpQenD/40dpK7mGAXs97/j8JkHoT+sK0VgLZinBzeYlHoLP8kzwe2UbK4+tz2g
	djqHOAubn8ocLtRmxM6vaheZzZHK31iZQfroJsyvLqQY93fv2pltcPCnX8/T0+8U/sunGg
	rU4uqX4GolCr7k6FV4MYeWSkOZuKM1OwuSlP6Sw93YvHdebR81roekBgtTq6/OAc6XK5CT
	YFSVNKLzPLI7cGBKPywgofVBbdPLwAhcawjlVcJB/NyTTRayvg+88Q7GpvgGW+8PpPa1Wi
	kw3vnVowNZ/59rqdDoZIZ/q+20TK2bP51wBp+G4X9gSdHHsSJ8pv6FTuPXXt3w==
Message-ID: <4823c1d9-51d9-45fa-a96c-f2caab1cb29e@bootlin.com>
Date: Wed, 15 Jul 2026 09:42:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/10] net: pcs: xpcs: add Rockchip RK3568 platform
 glue driver
To: Coia Prant <coiaprant@gmail.com>, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 robh@kernel.org, krzk+dt@kernel.org, heiko@sntech.de
Cc: netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org
References: <20260714191341.690906-1-coiaprant@gmail.com>
 <20260714191341.690906-8-coiaprant@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260714191341.690906-8-coiaprant@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 7/14/26 21:08, Coia Prant wrote:
> The RK3568 SoC integrates a Synopsys DesignWare XPCS that is accessed
> via APB3 memory-mapped registers.
> This driver provides the glue logic to make the XPCS accessible to
> the generic pcs-xpcs core.
> 
> The XPCS block contains four MII ports (0..3), each of which can be
> routed to GMAC0 or GMAC1 via the pcs-handle property in the MAC node.
> The hardware maps these ports to different MMDs:
>   - port 0: MMD 7 (ROCKCHIP_MMD_MII)
>   - port 1: MMD 2 (ROCKCHIP_MMD_MII1)
>   - port 2: MMD 3 (ROCKCHIP_MMD_MII2)
>   - port 3: MMD 4 (ROCKCHIP_MMD_MII3)
> 
> This driver creates a virtual MDIO bus that translates MDIO operations
> to APB3 register accesses, with proper address remapping for each port.
> The generic xpcs driver then creates a phylink_pcs instance on top of
> this bus, allowing the MAC to use the PCS via the standard phylink API.
> 
> Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part2%20V1.1-20210301.pdf (Page 2078)
> Signed-off-by: Coia Prant <coiaprant@gmail.com>

[...]

> +static int xpcs_rk_probe(struct platform_device *pdev)
> +{
> +	struct dw_xpcs_rk *pxpcs;
> +	int ret;
> +
> +	pxpcs = xpcs_rk_create_data(pdev);
> +	if (IS_ERR(pxpcs))
> +		return PTR_ERR(pxpcs);
> +
> +	/*
> +	 * The XPCS may be attached to a power domain (e.g. PD_PIPE). The domain
> +	 * must be powered on before any register access, otherwise the SoC will
> +	 * trigger a synchronous external abort (SError).
> +	 *
> +	 * Accessing the XPCS registers also requires a TX clock from the SerDes,
> +	 * which is needed for the soft reset.
> +	 */
> +	ret = xpcs_rk_serdes_phy_init(pxpcs);
> +	if (ret)
> +		return ret;
> +
> +	ret = xpcs_rk_serdes_phy_poweron(pxpcs);
> +	if (ret)
> +		return ret;
>
There are 2 unusual things here.

The first one is that you manage the serdes phy from the PCS driver, usually it's
the MAC driver doing so. In stmmac, we have the serdes_poweron and serdes_poweroff
callbacks to hook into for Serdes control.

The second thing is that you're setting the serdes ON at probe time, there's no
dynamic control of it. Usually we try to only power this on at admin-up time.

Can you explain the rationale behind controlling the serdes here directly, and not
from the MAC driver ? I don't see any mention of that in the commit log, and I'm not
convinced this is the correct approach.

Maxime
