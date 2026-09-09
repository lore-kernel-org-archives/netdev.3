Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAC5237AD;
	Wed,  9 Sep 2026 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951988; cv=none; b=qcW/frKkhmrSWoEx9WG8grfzTEWnGnrBmRxMV4+rs1Ksed/G2jaZUl0FmhpeMjmVasaBKV24Xtprs4ydhCJOXur67ekrSDaXFVFi0vqyT5f2GMRVrz1OEQFZ6dDNfPcX5Ndv4FO8K5+kVWRGRQrhDctz0Dlfg/t11LLQA2r2ddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951988; c=relaxed/simple;
	bh=xYQGAF0ve5ncKxvXj69wlunj82ZvZpm+BXA3PMT0rGk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OTko/cyIKvse1JyDgrP4AffK9dX5FENn9EjPU9IJziQEuuRG4h473hEE7hqRXdBio0j9Za4E47IehsEBoKm4bwOdr7gMLJ01T9IXkTn0eNl4iuZQozYcvZnKYcPQknDjYdUAuukb4QlAZJ43WmpspttbPTd8c0QKtuN34VAFFXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=jR8fGYTA; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="jR8fGYTA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sm5hZKlRG1kdRKEeS9E+CM4U4vHBPHrbqoe03Kq/6mc=;
	b=jR8fGYTA5LjNiB7N9ItZ9pJxW4LBxJ3N3Frsepxkpkhe28tWmq4rYbOr9sddAxn1bjyDvl001
	afuH0mFsR17hmPwenRdyx7RCX3hQTzW5vUEUjN5TfSaOLeAbr3R+NMux6obhhlXwjCtwUmkf7/T
	+xjJ4d3KSw1xejM4c16gk0k=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4hfyQ00gqSz1prMB;
	Wed,  9 Sep 2026 18:55:20 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 101954056E;
	Wed,  9 Sep 2026 19:06:16 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 9 Sep 2026 19:06:15 +0800
Message-ID: <9284cd9f-88fb-4067-be39-3e0025dee2c4@huawei.com>
Date: Wed, 9 Sep 2026 19:06:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Yury Norov <ynorov@nvidia.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/9] net: avoid copies before linkmode_and()
To: Yury Norov <yury.norov@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Raju
 Rangoju <Raju.Rangoju@amd.com>, Prashanth Kumar K R
	<PrashanthKumar.K.R@amd.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jian Shen
	<shenjian15@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-usb@vger.kernel.org>
References: <20260907215439.409858-1-ynorov@nvidia.com>
 <20260907215439.409858-7-ynorov@nvidia.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260907215439.409858-7-ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/9/8 5:54, Yury Norov wrote:
> Avoid separate linkmode_copy() calls by passing the original source
> bitmap directly to linkmode_and().
>
> In phy_ethtool_ksettings_set(), also use the return value of
> linkmode_and() when validating that the requested advertisement
> contains a supported link mode.

Please include "hns3" in the subject prefix (e.g., "net: hns3: ...")
so it's clear which driver this patch belongs to. I didn't immediately
find the hns3 driver modifications from the current title.

>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c | 5 ++---
>   drivers/net/phy/phy.c                                   | 7 +++----
>   2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> index cf881108fa57..5801da6100b8 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
> @@ -205,7 +205,6 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
>   	struct hclge_dev *hdev = vport->back;
>   	struct net_device *netdev = hdev->vport[0].nic.netdev;
>   	struct phy_device *phydev = hdev->hw.mac.phydev;
> -	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = { 0, };
>   	int ret;
>   
>   	if (!phydev)
> @@ -223,8 +222,8 @@ int hclge_mac_connect_phy(struct hnae3_handle *handle)
>   		return ret;
>   	}
>   
> -	linkmode_copy(mask, hdev->hw.mac.supported);
> -	linkmode_and(phydev->supported, phydev->supported, mask);
> +	linkmode_and(phydev->supported, phydev->supported,
> +		     hdev->hw.mac.supported);
>   	linkmode_copy(phydev->advertising, phydev->supported);
>   
>   	/* supported flag is Pause and Asym Pause, but default advertising
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index fce9bc7be330..cd71186cd842 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -1160,6 +1160,7 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
>   			      const struct ethtool_link_ksettings *cmd)
>   {
>   	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising);
> +	bool has_advertising;
>   	u8 autoneg = cmd->base.autoneg;
>   	u8 duplex = cmd->base.duplex;
>   	u32 speed = cmd->base.speed;
> @@ -1167,17 +1168,15 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
>   	if (cmd->base.phy_address != phydev->mdio.addr)
>   		return -EINVAL;
>   
> -	linkmode_copy(advertising, cmd->link_modes.advertising);
> -
>   	/* We make sure that we don't pass unsupported values in to the PHY */
> -	linkmode_and(advertising, advertising, phydev->supported);
> +	has_advertising = linkmode_and(advertising, cmd->link_modes.advertising, phydev->supported);


To keep the file clean, could you please update this part to match thesurrounding code style?
Specifically, we order local variables fromlongest to shortest (reverse Christmas tree) and
enforce an 80-characterline limit.

Thanks,
Jijie Shao


>   
>   	/* Verify the settings we care about. */
>   	if (autoneg != AUTONEG_ENABLE && autoneg != AUTONEG_DISABLE)
>   		return -EINVAL;
>   
>   	if (autoneg == AUTONEG_ENABLE &&
> -	    (linkmode_empty(advertising) ||
> +	    (!has_advertising ||
>   	     !linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
>   				phydev->supported)))
>   		return -EINVAL;
