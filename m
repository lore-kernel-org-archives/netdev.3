Received: from out198-13.us.a.mail.aliyun.com (out198-13.us.a.mail.aliyun.com [47.90.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF09626A1AC;
	Wed, 30 Sep 2026 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790728790; cv=none; b=luYdEBY4bWo15J+pO6hqqcSNlL3R8M9tznA8b41og0nE8Qc4X49eYx41R7P6sTbn8zE+JxcS3bgcHkfAZeYPriXybudnOVSDLtA91v7mCAHXNCMqG5wbZQgW0dpIkJD/Jct99X6aF2l350QR2TKHYegOE/Uq/vwqW+j0d5GHHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790728790; c=relaxed/simple;
	bh=kpZWKhkTh54QLeiLP/UW0ZvL/5icVZNQjYS3l66JHio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPhRO/AI/88uJXJDz/2qfMseqggI6ys+KEnx2pnI70kQ98cPcQbdctsE9wiz+DJ1XlvGsouDaJ3e+8bWwTFAai3skpud3xJ7F5hJPkogVDVADR7h1u83IxsjDIyp3PDJIgbk7svyFr7N8NKFos4+RO/fkzG5OTj4eF9Afmc/d2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07448903|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.224787-0.000657697-0.774555;FP=14452996897367414002|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jRqO6DN_1790728762;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jRqO6DN_1790728762 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 30 Sep 2026 08:39:25 +0800
Message-ID: <3f31de5e-2a62-46ee-b857-64f8a353d8e6@motor-comm.com>
Date: Wed, 30 Sep 2026 08:39:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v22 3/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
References: <20260929095430.508657-1-kyle.switch@motor-comm.com>
 <20260929095430.508657-4-kyle.switch@motor-comm.com>
 <0eb0fe92-86c0-425d-8002-a7ce448ba751@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <0eb0fe92-86c0-425d-8002-a7ce448ba751@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/29/26 20:18, Andrew Lunn wrote:
>> +static int yt8824_restore_working_status(struct phy_device *phydev, int ret)
>> +{
>> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
>> +	int r;
>> +
>> +	/* configure normal test mode */
>> +	r = yt8824_utp_set_template_test_mode
>> +		(phydev, MDIO_PMA_10GBT_TESTMODE_NORMAL);
> The opening ( should be on the line before. The phydev as well.
>
>> + * yt8824_soft_reset() - called to do PHY software reset
>> + * @phydev: a pointer to a &struct phy_device
>> + *
>> + * Returns: 0 or negative errno code
>> + */
>> +static int yt8824_soft_reset(struct phy_device *phydev)
>> +{
>> +	struct yt8824_shared_priv *priv = phy_package_get_priv(phydev);
>> +	int ret;
>> +
>> +	mutex_lock(&priv->shared_lock);
>> +	if (priv->package_mode == PHY_INTERFACE_MODE_INTERNAL) {
>> +		/* test mode 1 */
>> +		ret = yt8824_utp_set_template_test_mode
>> +			(phydev, MDIO_PMA_10GBT_TESTMODE_1);
> Please look through the code and fix all these problems.
>
> Also, what value does the comment have?
>
okay, meaningless comments will be removed.
>> +		if (ret < 0)
>> +			goto retry;
>> +		ret = yt8824_utp_softreset_paged(phydev);
>> +		if (ret < 0)
>> +			goto retry;
>> +		/* normal mode */
>> +		ret = yt8824_utp_set_template_test_mode
>> +			(phydev, MDIO_PMA_10GBT_TESTMODE_NORMAL);
> And this comment? You only need comments if the code is not
> obvious. The name of the function is often sufficient to explain what
> is happening.
>
>> +	/* pll calibration */
>> +	ret = ytphy_write_ext_with_lock(phydev, 0x0001, 0x0003);
>> +	if (ret < 0)
>> +		goto err_restore;
> This comment is useful, it is not possible to know what 0x0001,
> 0x0003 means.
>
>> +	ret = ytphy_write_ext_with_lock(phydev, 0xa20e, 0x0cba);
> and this is just magic. Which is why we recommend #define, not magic
> numbers.
>
>> +	/* power down */
>> +	ret = phy_modify(phydev, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
>> +	if (ret < 0)
>> +		goto err_restore;
>> +	ret = ytphy_write_ext_with_lock(phydev, 0xa20e, 0xcba);
> You comment about the obvious power down, but nothing about what this
> magic does :-(
okay, magic numbers will be replaced with meaningful definitions.
>
> 	Andrew
