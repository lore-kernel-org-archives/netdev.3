Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5E545DAA
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955428; cv=none; b=hFduZnpcJ3dA0pUhuxL8hjxT+tJUTbyf0L1lOiH1ptMTdAfTAm9b7opxaAx1FoliE1jmFKo4adSEtIEw5hRMQcLblOmGAIXTqsSTjfKPC3WbtIXFuUrG++KETAGLDa6rBTpEBM/OGvRqMx653vybx5nn0m4r43ml5Y/IL9eYCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955428; c=relaxed/simple;
	bh=1msvGHJDPATInCSiRRIdc2au9nJlgaZHo8hrWZ9ryLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvygs3LUtwBpUfbogf578u48csYR9Rqnm7eriUFkXvSwZAkPWh8OseIAT2WBil2xQdQJlwWym80UVWNENSnSl1H9ngbuk0V+nQAhhlPETc2X3KUs5c3RnjjbyLUhVwKD4glX0q70JLmYVrpRkGHVXcT7fdg/HHjFIR+RQGDYWbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mvISn1vm; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mvISn1vm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1F4E54E415B2;
	Wed,  9 Sep 2026 12:03:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E537B60448;
	Wed,  9 Sep 2026 12:03:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B22BA11C7AF7F;
	Wed,  9 Sep 2026 14:03:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788955419; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=VFLGoEMZIFlEvSHrJExTInX611wuJ54wJXA7+TsBkk4=;
	b=mvISn1vme/Dno5BIJYrPWbkVwaqUU/UCqReVgMBtUQF16yNm2YjcP9OOV6QjvXUE6WXezw
	8kzeBvfHe2xRm27ohts0OyMw4iyzNSqiIRrcbiTbZKQGh24sORnJFzDQnh6TNqJfCrdaVw
	lc9hmYnEI+wU8S/b3O+387NKXSHLreTcGch5ISnlQmjD5Z3O1fTN84yllZlokQ1A7Aqqc2
	CMGBMW3G/NV0aFM1KrJcpPRYwKWNQAhiJq340HBUHTSFhyKh0nVnqRRVZAfcGX9TZIUD3e
	ed7+qvIvpmq2qkMiPc24Hzi6kkkpM7qvVtRCx+TQnsnEQfUgvndjUkqa7Kqt8A==
Message-ID: <5cd9d733-546d-44e1-ab4f-029cb37399cb@bootlin.com>
Date: Wed, 9 Sep 2026 14:03:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Kyle Switch <kyle.switch@motor-comm.com>, Frank.Sae@motor-comm.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
References: <20260909074911.2378402-1-kyle.switch@motor-comm.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260909074911.2378402-1-kyle.switch@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Kyle

On 9/9/26 09:49, Kyle Switch wrote:
> Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
> motorcomm driver, using the phy_package helpers for the shared top
> extended register space.
> It also adds a new exported phylib helper, genphy_c45_template_testmode().
> 

[...]

> +/**
> + * yt8824_resume() - resume the hardware
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_resume(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret = 0;

No need to zero-init

> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = yt8824_power_on(phydev);
> +	mutex_unlock(&priv->shared_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * yt8824_power_down()  - set utp power down.
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * NOTE: need WA like softreset
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_power_down(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret;
> +	int r;
> +
> +	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
> +		/* invalid test mode */
> +		ret = yt8824_utp_invalid_test_mode_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +		/* utp power down */
> +		ret = yt8824_utp_power_down(phydev);
> +		if (ret < 0)
> +			goto retry;
> +		/* normal mode */
> +		ret = yt8824_utp_normal_test_mode_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +	} else {
> +		/* invalid test mode */
> +		ret = yt8824_utp_invalid_test_mode_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		/* sds isolation */
> +		ret = yt8824_sds_isolate_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		/* utp power down */
> +		ret = yt8824_utp_power_down(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		/* normal mode */
> +		ret = yt8824_utp_normal_test_mode_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +
> +		/* sds soft reset and disable isolation */
> +		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
> +		if (ret < 0)
> +			goto retry;
> +	}
> +	return 0;
> +
> +retry:
> +	/*
> +	 * If the PHY down operation succeeds but the subsequent operation
> +	 * fails, revert to the default state.
> +	 */
> +	r = yt8824_utp_power_on(phydev);
> +	if (ret >= 0 && r < 0)
> +		ret = r;
> +	ret = yt8824_restore_working_status(phydev, ret);
> +	return ret;
> +}
> +
> +/**
> + * yt8824_suspend() - suspend the hardware
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_suspend(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int ret = 0;

No need to zero-initialize it

> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = yt8824_power_down(phydev);
> +	mutex_unlock(&priv->shared_lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * yt8824_config_aneg() - config negotiation
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_config_aneg(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	int phy_ctrl = 0;
> +	int ret = 0;
> +
> +	mutex_lock(&priv->shared_lock);
> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
> +	if (ret < 0)
> +		goto err;
> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			      phydev->advertising))
> +		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
> +				     MDIO_AN_10GBT_CTRL,
> +				     MDIO_AN_10GBT_CTRL_ADV2_5G,
> +				     phy_ctrl);
> +	if (ret < 0)
> +		goto err;
> +
> +	ret = __genphy_config_aneg(phydev, ret);
> +
> +err:
> +	mutex_unlock(&priv->shared_lock);
> +	return ret;
> +}
> +
> +/**
> + * yt8824_phy_package_probe_once()  - init phy packet for phy8824.
                                                   ^^ package ?


> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt8824_phy_package_probe_once(struct phy_device *phydev)
> +{
> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
> +	struct device_node *np = phy_package_get_node(phydev);
> +	const char *interface_mode_name;
> +
> +	/* Initialise shared lock for YT8824 */
> +	mutex_init(&priv->shared_lock);
> +	priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
> +	if (!of_property_read_string(np, "motorcomm,interface-mode",
> +				     &interface_mode_name)) {

I don't see that property documented anywhere in the bindings, and besides that
the typical way we deal with quad PHYs is to have each MAC node use
QSGMII / USXGMII as their phy-interface-mode. Any reason for needing that at
the package level ?


> +		if (!strcasecmp(interface_mode_name,
> +				phy_modes(PHY_INTERFACE_MODE_USXGMII))) {
> +			priv->interface_mode = PHY_INTERFACE_MODE_USXGMII;
> +		} else if (!strcasecmp
> +				(interface_mode_name,
> +				 phy_modes(PHY_INTERFACE_MODE_INTERNAL))) {
> +			priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
> +		} else {
> +			return -EINVAL;
> +		}
> +	} else {
> +		phydev_warn(phydev, "%s, motorcomm,interface-mode missing in DTS.\n",
> +			    __func__);
> +	}
> +
> +	return 0;
> +}
> +

Maxime>  
> +/* PMA 10GBASE-T Template Test Mode Register*/
> +#define MDIO_PMA_10GBT_TESTMODE_MASK 0xE000	/* Template test mode */
> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0000	/* Template Normal */
> +#define MDIO_PMA_10GBT_TESTMODE_1 0x2000 /* Template TestMode1 */
> +#define MDIO_PMA_10GBT_TESTMODE_2 0x4000 /* Template TestMode2 */
> +#define MDIO_PMA_10GBT_TESTMODE_3 0x6000 /* Template TestMode3 */
> +#define MDIO_PMA_10GBT_TESTMODE_4 0x8000 /* Template TestMode4 */
> +#define MDIO_PMA_10GBT_TESTMODE_5 0xa000 /* Template TestMode5 */
> +#define MDIO_PMA_10GBT_TESTMODE_6 0xc000 /* Template TestMode6 */
> +#define MDIO_PMA_10GBT_TESTMODE_7 0xe000 /* Template TestMode7 */
> +
>  /* PCS 10GBASE-R/-T status register 1. */
>  #define MDIO_PCS_10GBRT_STAT1_BLKLK	0x0001	/* Block lock attained */
>  

