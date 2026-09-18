Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52299499F0C
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789715512; cv=none; b=DXyHb/ghjdmhozVKmlpZF4cW/wz3DVqmA3U7iYixAwTPaC/fm4y/8H/8qs7joY07PGA2fMKYYaz/e4IXmF6bu120qesVn73dj1/RZ824+6wDKkLJb1Fxmjn1yqGuGfhoNfq/qwmVV9/fgRz/p6Rv5He3cOFU8QZ8Az+EckVG8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789715512; c=relaxed/simple;
	bh=RZtsoVxa1xJ+1U2wH9GbRQgtGgSK3nZ1kCLsz2PhByg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m0nbzlzvPLcwt6LjPuGstRQziRokPKEb2Lv5sggeGpPy4/xcX7bj8sLQ2d1iovwWga336vpRu6+16Ie21Qke7Fo9U3UWkjMBAKtukDp942rVkdexHnMqMUPATbqfWfJkdgaybUaleruE8I38g9+Sku+SSH25KzdU7AxOPAkYafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BOn559NG; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BOn559NG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2D4211A0975;
	Fri, 18 Sep 2026 07:11:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E270960649;
	Fri, 18 Sep 2026 07:11:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8FDDB11C7B021;
	Fri, 18 Sep 2026 09:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789715503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ONcQ26rozGTeYTFN4AmRp548glZjumb6wG79sSd/wGw=;
	b=BOn559NGFM4JJTDaDZomXpW+HeR6L1FpzuDZcpegacC0EWH17CgOUh8GaZeLbsSQA+OKgI
	YJqBv3xsMKPOjMOSHWrbzoJz6mPq8JbhfWjuIQhyAJOi23et+j6/9UkTWFXjrVbEo+DXBA
	LAHVKlG8pvIOHGBjNnC8FqtxEt6J2+/6uHVGmb2y5eHgB1/ziSBondVCal7Tk1qz3mhkpx
	roCnuoCqnGySL7UjrqsowJSlJEqVDnviYjtCb7Rt0e71lCmECtuljGFyXLbqKlKmp+HlbT
	zlpmRCdB42oHn9bH3HrcRcJC6LclwNeN7n8bUBjVSUtQXqS+mt3VqKtAijKPrA==
Message-ID: <986afd25-f69d-4b73-9e7d-f1403a1c6e6e@bootlin.com>
Date: Fri, 18 Sep 2026 09:11:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] net: stmmac: advertise integrated PCS
 interfaces to phylink
To: Thomas Karpiniec <tom.karpiniec@outlook.com>, netdev@vger.kernel.org
Cc: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>, Coia Prant <coiaprant@gmail.com>,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <SJ2PR11MB8401F5C3A075DE2A0013E063E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
 <SJ2PR11MB8401D53F5519472525156BA9E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <SJ2PR11MB8401D53F5519472525156BA9E4872@SJ2PR11MB8401.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Thomas,

On 9/18/26 06:50, Thomas Karpiniec wrote:
> From: Thomas Karpiniec <tom@wendy.sh>
> 
> stmmac_phylink_setup() adds interfaces reported by platform
> get_interfaces() and non-integrated PCS instances to
> config->supported_interfaces, but omits the integrated PCS.
> 
> On qcom-ethqos with 2500BASE-X selected by firmware, this leaves SGMII
> out of the supported interface bitmap, causing phylink to remove the
> lower-speed modes of a switching PHY such as QCA8081.
> 
> Add the integrated PCS interface bitmap to config->supported_interfaces.
> 
> Fixes: 68cff4fff61f ("net: stmmac: add BASE-X support to integrated PCS")
> Cc: stable@vger.kernel.org # 7.0+
> Assisted-by: LLM sparse
> Signed-off-by: Thomas Karpiniec <tom@wendy.sh>

Looks good to me, thanks !

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1350e92943ac..f956e0d2ec64 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1414,6 +1414,12 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
>  		__set_bit(priv->plat->phy_interface,
>  			  config->supported_interfaces);
>  
> +	/* If we have an integrated PCS, add the interfaces it supports. */
> +	if (priv->integrated_pcs)
> +		phy_interface_or(config->supported_interfaces,
> +				 config->supported_interfaces,
> +				 priv->integrated_pcs->pcs.supported_interfaces);
> +
>  	/* If we have an xpcs, it defines which PHY interfaces are supported. */
>  	if (priv->hw->xpcs)
>  		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);

