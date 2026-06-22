Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102EB3B42F0;
	Mon, 22 Jun 2026 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135039; cv=none; b=IySUzRrx9HuMve5Zg0E1ZeLKalCej6FlNKC16Fied2iA1O90HFz27GfX4ghNMa5Cmka863icGTG8arPA5W/ifcRN3IDrXc7OrcrmnSq8zfCv0Wbdt5NZuUWDqV0dFnNSIwRFwXzl0t7xFHZU0C0p23KlVnecrrryeosExjGq5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135039; c=relaxed/simple;
	bh=8AqsMvadxuFWfHfYw8crofEQMmcUk7zKS2AbKNXbt5w=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TeT/g1O11xXte1y+bMw3B0QgJDMIvJastOx7bC/skq0tREEi+v1RYl203m1uATwNFPALlwDjiU9hAWtTV9IgtLjw+Zs6g4iED4OhRLlz0tNLMy3jEPvPO8fISs1ecPLRVd4C1tgnEnVULkfIrrapAPr/wQ2CP42EqWEbM+WBQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dordxwy/; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dordxwy/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TWC7MTrugdDTnZdaMyvV3BZMuoIFjYZawKtL03lAs8Q=;
	b=dordxwy/ehmjARP4v/yPcjmuG/EkQvOxBT+bZvlluwjr26crO0a1uhE5b6p5pWRyAthgkyzrC
	pLHKiJ/wZ7/0VZCBgsBBWdNQUx6wTSNs7Cv7cDNEgG1HvwTpywtVeIoEH+uUYdgd8bWOxrrDa7N
	IRlCzDRUVSagxviSGJrrwN8=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gkTPP504rznTw1;
	Mon, 22 Jun 2026 21:21:45 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F4574056E;
	Mon, 22 Jun 2026 21:30:30 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 22 Jun 2026 21:30:29 +0800
Message-ID: <cbffec36-994a-48ec-94e6-3c94a260d37a@huawei.com>
Date: Mon, 22 Jun 2026 21:30:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 1/5] net: hns3: unify copper port ksettings
 configuration path
To: Simon Horman <horms@kernel.org>
References: <20260617112721.75186-2-shaojijie@huawei.com>
 <20260618153356.909862-1-horms@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260618153356.909862-1-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/6/18 23:33, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: hns3: unify copper port ksettings configuration path
>
> Refactor hns3_set_link_ksettings() and hclge_set_phy_link_ksettings()
> to unify the configuration path for copper ports.
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> [ ... ]
>> @@ -863,6 +859,8 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
>>   	struct hnae3_handle *handle = hns3_get_handle(netdev);
>>   	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
>>   	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
>> +	u8 module_type = HNAE3_MODULE_TYPE_UNKNOWN;
>> +	u8 media_type = HNAE3_MEDIA_TYPE_UNKNOWN;
>>   	int ret;
>>   
>>   	/* Chip don't support this mode. */
>> @@ -878,22 +876,20 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
>>   		  cmd->base.autoneg, cmd->base.speed, cmd->base.duplex,
>>   		  cmd->lanes);
>>   
>> -	/* Only support ksettings_set for netdev with phy attached for now */
>> -	if (netdev->phydev) {
>> -		if (cmd->base.speed == SPEED_1000 &&
>> -		    cmd->base.autoneg == AUTONEG_DISABLE)
>> -			return -EINVAL;
> [Severity: Medium]
> Does removing this validation allow invalid configurations for native copper
> PHYs?
>
> The previous code explicitly rejected SPEED_1000 with AUTONEG_DISABLE because
> IEEE 802.3 1000BASE-T strictly requires autonegotiation. By delegating
> directly to phy_ethtool_ksettings_set(), which permits this for 1000BASE-X,
> the driver might now silently accept an invalid configuration.

[Accepted] Yes, this is indeed an effective bug.

>
>> -		return phy_ethtool_ksettings_set(netdev->phydev, cmd);
>> -	} else if (test_bit(HNAE3_DEV_SUPPORT_PHY_IMP_B, ae_dev->caps) &&
>> -		   ops->set_phy_link_ksettings) {
>> +	if (!ops->get_media_type)
>> +		return -EOPNOTSUPP;
>> +	ops->get_media_type(handle, &media_type, &module_type);
>>   
>> -		return ops->set_phy_link_ksettings(handle, cmd);
>> -	}
>> +	if (media_type == HNAE3_MEDIA_TYPE_COPPER) {
>> +		if (!ops->set_phy_link_ksettings)
>> +			return -EOPNOTSUPP;
>> +		return ops->set_phy_link_ksettings(handle, cmd);
>> +	}
> [ ... ]
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> [ ... ]
>> @@ -3400,10 +3400,28 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
>>   		return ret;
>>   	}
>>   
>> +	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
>> +	return 0;
>> +}
>> +
>> +static int
>> +hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
>> +			     const struct ethtool_link_ksettings *cmd)
>> +{
>> +	struct hclge_vport *vport = hclge_get_vport(handle);
>> +	struct hclge_dev *hdev = vport->back;
>> +	int ret;
>> +
>> +	if (hnae3_dev_phy_imp_supported(hdev))
>> +		ret = hclge_ethtool_ksettings_set(handle, cmd);
>> +	else
>> +		ret = phy_ethtool_ksettings_set(handle->netdev->phydev, cmd);
> [Severity: Critical]
> Can handle->netdev->phydev be NULL here, leading to a kernel panic when called
> from userspace?
>
> A copper port can legitimately have a NULL phydev if the port's PHY address
> is configured as PHY_INEXISTENT in the firmware.
>
> Because the updated hns3_set_link_ksettings() now routes all
> HNAE3_MEDIA_TYPE_COPPER configurations here without the previous
> if (netdev->phydev) guard, phy_ethtool_ksettings_set() will unconditionally
> dereference phydev->mdio.addr.

[Accepted] Yes, this is indeed an effective bug.


Thanks,
Jijie Shao

