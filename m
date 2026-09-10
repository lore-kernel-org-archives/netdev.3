Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F77E25DB12;
	Thu, 10 Sep 2026 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003476; cv=none; b=Sqz1xrtL3k8HZ8jBMWJ/ErmUDYU0KoOhhoFzD2naGlOh19zUfFDd82p6c51r/Sw0r4RD6mqglflTIq2c60jCbMOkTYBuLzvGLIsJyFvuHzVh9f5FvWBr/zQ6r1Ni5u9nEfV6nuL2worqDrE+g9dqMPOK4ZQucltn0IYatQVi7xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003476; c=relaxed/simple;
	bh=D6aKgK/SdIhoUEN7Fn/JpSmeBW9e2XvVl0o1hcPlcEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0DRO0YksrjZ0XGV74ItsFDsGR5tuDf0LbhVXXw2rMnPIlYO9kjDN33AlC/NZmtMmIVXh0uealmn83T0Kcb/Pp+ws6r8Ji+Zsl3VUA4sJx63hIu0E/rV7jqa2ytaNovb/dCHDMP0TMB6cSDrwDkGLhhWzWclrr7fCS7XP0W4J7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.209368-0.0122002-0.778432;FP=17587502375196298806|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.jA40LXX_1789003461;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jA40LXX_1789003461 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 09:24:23 +0800
Message-ID: <be83ed89-aae6-4dfb-ab1f-2e88d3138f22@motor-comm.com>
Date: Thu, 10 Sep 2026 09:24:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
References: <20260909074911.2378402-1-kyle.switch@motor-comm.com>
 <5cd9d733-546d-44e1-ab4f-029cb37399cb@bootlin.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <5cd9d733-546d-44e1-ab4f-029cb37399cb@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/9/26 20:03, Maxime Chevallier wrote:
> Hi Kyle
>
> On 9/9/26 09:49, Kyle Switch wrote:
>> Add support for Motorcomm YT8824 quad-port 2.5G PHY to the existing
>> motorcomm driver, using the phy_package helpers for the shared top
>> extended register space.
>> It also adds a new exported phylib helper, genphy_c45_template_testmode().
>>
> [...]
>
>> +/**
>> + * yt8824_resume() - resume the hardware
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * Returns: 0 or negative errno code
>> + */
>> +static int yt8824_resume(struct phy_device *phydev)
>> +{
>> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
>> +	int ret = 0;
> No need to zero-init
Ans: will be fixed in next version.
>
>> +
>> +	mutex_lock(&priv->shared_lock);
>> +	ret = yt8824_power_on(phydev);
>> +	mutex_unlock(&priv->shared_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * yt8824_power_down()  - set utp power down.
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * NOTE: need WA like softreset
>> + *
>> + * Returns: 0 or negative errno code
>> + */
>> +static int yt8824_power_down(struct phy_device *phydev)
>> +{
>> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
>> +	int ret;
>> +	int r;
>> +
>> +	if (priv->interface_mode == PHY_INTERFACE_MODE_INTERNAL) {
>> +		/* invalid test mode */
>> +		ret = yt8824_utp_invalid_test_mode_paged(phydev);
>> +		if (ret < 0)
>> +			goto retry;
>> +		/* utp power down */
>> +		ret = yt8824_utp_power_down(phydev);
>> +		if (ret < 0)
>> +			goto retry;
>> +		/* normal mode */
>> +		ret = yt8824_utp_normal_test_mode_paged(phydev);
>> +		if (ret < 0)
>> +			goto retry;
>> +	} else {
>> +		/* invalid test mode */
>> +		ret = yt8824_utp_invalid_test_mode_paged(phydev);
>> +		if (ret < 0)
>> +			goto retry;
>> +
>> +		/* sds isolation */
>> +		ret = yt8824_sds_isolate_paged(phydev);
>> +		if (ret < 0)
>> +			goto retry;
>> +
>> +		/* utp power down */
>> +		ret = yt8824_utp_power_down(phydev);
>> +		if (ret < 0)
>> +			goto retry;
>> +
>> +		/* normal mode */
>> +		ret = yt8824_utp_normal_test_mode_paged(phydev);
>> +		if (ret < 0)
>> +			goto retry;
>> +
>> +		/* sds soft reset and disable isolation */
>> +		ret = yt8824_sds_isolate_and_softreset_paged(phydev);
>> +		if (ret < 0)
>> +			goto retry;
>> +	}
>> +	return 0;
>> +
>> +retry:
>> +	/*
>> +	 * If the PHY down operation succeeds but the subsequent operation
>> +	 * fails, revert to the default state.
>> +	 */
>> +	r = yt8824_utp_power_on(phydev);
>> +	if (ret >= 0 && r < 0)
>> +		ret = r;
>> +	ret = yt8824_restore_working_status(phydev, ret);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * yt8824_suspend() - suspend the hardware
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * Returns: 0 or negative errno code
>> + */
>> +static int yt8824_suspend(struct phy_device *phydev)
>> +{
>> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
>> +	int ret = 0;
> No need to zero-initialize it
Ans: will be fixed in next version.
>> +
>> +	mutex_lock(&priv->shared_lock);
>> +	ret = yt8824_power_down(phydev);
>> +	mutex_unlock(&priv->shared_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +/**
>> + * yt8824_config_aneg() - config negotiation
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * Returns: 0 or negative errno code
>> + */
>> +static int yt8824_config_aneg(struct phy_device *phydev)
>> +{
>> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
>> +	int phy_ctrl = 0;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&priv->shared_lock);
>> +	ret = phy8824_page_write_with_lock(phydev, YT8824_RSSR_UTP_SPACE);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
>> +			      phydev->advertising))
>> +		phy_ctrl = MDIO_AN_10GBT_CTRL_ADV2_5G;
>> +
>> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN,
>> +				     MDIO_AN_10GBT_CTRL,
>> +				     MDIO_AN_10GBT_CTRL_ADV2_5G,
>> +				     phy_ctrl);
>> +	if (ret < 0)
>> +		goto err;
>> +
>> +	ret = __genphy_config_aneg(phydev, ret);
>> +
>> +err:
>> +	mutex_unlock(&priv->shared_lock);
>> +	return ret;
>> +}
>> +
>> +/**
>> + * yt8824_phy_package_probe_once()  - init phy packet for phy8824.
>                                                     ^^ package ?
>
Ans: will be fixed in next version.
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * Returns: 0 or negative errno code
>> + */
>> +static int yt8824_phy_package_probe_once(struct phy_device *phydev)
>> +{
>> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
>> +	struct device_node *np = phy_package_get_node(phydev);
>> +	const char *interface_mode_name;
>> +
>> +	/* Initialise shared lock for YT8824 */
>> +	mutex_init(&priv->shared_lock);
>> +	priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
>> +	if (!of_property_read_string(np, "motorcomm,interface-mode",
>> +				     &interface_mode_name)) {
> I don't see that property documented anywhere in the bindings, and besides that
> the typical way we deal with quad PHYs is to have each MAC node use
> QSGMII / USXGMII as their phy-interface-mode. Any reason for needing that at
> the package level ?

Ans: in the next version,we will add the corresponding dts.

The interface_mode here is used to indicate the current mode of the four 
ports,

which mainly includes two scenarios: 1. An independent external PHY 8824;

2. Four UTPs embedded in the switch. Different scenarios have somewhat

different processing logic for power down and power up, so an 
interface_mode

is defined separately here.

>
>
>> +		if (!strcasecmp(interface_mode_name,
>> +				phy_modes(PHY_INTERFACE_MODE_USXGMII))) {
>> +			priv->interface_mode = PHY_INTERFACE_MODE_USXGMII;
>> +		} else if (!strcasecmp
>> +				(interface_mode_name,
>> +				 phy_modes(PHY_INTERFACE_MODE_INTERNAL))) {
>> +			priv->interface_mode = PHY_INTERFACE_MODE_INTERNAL;
>> +		} else {
>> +			return -EINVAL;
>> +		}
>> +	} else {
>> +		phydev_warn(phydev, "%s, motorcomm,interface-mode missing in DTS.\n",
>> +			    __func__);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> Maxime>
>> +/* PMA 10GBASE-T Template Test Mode Register*/
>> +#define MDIO_PMA_10GBT_TESTMODE_MASK 0xE000	/* Template test mode */
>> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0000	/* Template Normal */
>> +#define MDIO_PMA_10GBT_TESTMODE_1 0x2000 /* Template TestMode1 */
>> +#define MDIO_PMA_10GBT_TESTMODE_2 0x4000 /* Template TestMode2 */
>> +#define MDIO_PMA_10GBT_TESTMODE_3 0x6000 /* Template TestMode3 */
>> +#define MDIO_PMA_10GBT_TESTMODE_4 0x8000 /* Template TestMode4 */
>> +#define MDIO_PMA_10GBT_TESTMODE_5 0xa000 /* Template TestMode5 */
>> +#define MDIO_PMA_10GBT_TESTMODE_6 0xc000 /* Template TestMode6 */
>> +#define MDIO_PMA_10GBT_TESTMODE_7 0xe000 /* Template TestMode7 */
>> +
>>   /* PCS 10GBASE-R/-T status register 1. */
>>   #define MDIO_PCS_10GBRT_STAT1_BLKLK	0x0001	/* Block lock attained */
>>   
