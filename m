Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53547192D97;
	Thu, 18 Jun 2026 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796844; cv=none; b=ekF0f5wZBkEe9oCHkAb3zBd5+pA32nctgqhbxbEo8mSZ8e0JJijuXk+07e1ahCVrN4isyQWaS5gVUk7rEdg+VGuBeJYPnkJRIQuVNXl6iyHwuNnaikmWcyEdibfuZzMlW5YQwaHVwwfjQC4LOiOAMNDOzAB1P4YHIrhsArkItgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796844; c=relaxed/simple;
	bh=QDOK74CejYQCISj4RaZfUjBeSlVOVEbh8UpFRmZBSAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZwRijnEBjjhg3QvEybnGn1nvbRTn4LId/Ikc8Bkcvcp6t8c7PyOx6sUwtS9oGmyobifCu7IqFcoLuLDAYt9L9yltfcSAnzBJxca1jLXSKI1B3/ghLfr5zoRy6H9AkpzOOxQftuu5+0pM4qPqs148af4KtcIdhMlDrkxnSuBzNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jke4vsCK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jke4vsCK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CAB1F000E9;
	Thu, 18 Jun 2026 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781796843;
	bh=kLPU/rwZRovPIoS9N3cQXDgafHve2eRNF4OmJ9OMUt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jke4vsCKC3t0FPlRUdnezv7w9DJWpGR6BuA6tr4yDlI4N5NR34YO7uQS+8Vr5dzBl
	 3TNZ8ojIicRTwEWiYiMAao/arFMEjEPzlJV5xX3cUx+gqjlknnVgmIQKUwaKMqltz3
	 HpqzpdzLQMdyOTtbKvr5z2sEagSfNS4HBpRe9ip8oaGoK8lbbDifKY29B4W3rKUmtr
	 bqLG/B0ogwnT3RU5Bv5jOI9WqxSRP48Us3LVJAy2lLS6BwCPabxOqQjOHUI3/NKc3B
	 DClZYzCw/SLkYa4hNKXu9fN2dAc0sVseJVK2EWbeJCW9UK9UbEI6b1of4tihRE+ExR
	 5M0jUgnQ6BLPQ==
From: Simon Horman <horms@kernel.org>
To: shaojijie@huawei.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shenjian15@huawei.com,
	liuyonglong@huawei.com,
	chenhao418@huawei.com,
	huangdonghua3@h-partners.com,
	yangshuaisong@h-partners.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/5] net: hns3: unify copper port ksettings configuration path
Date: Thu, 18 Jun 2026 16:33:56 +0100
Message-ID: <20260618153356.909862-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617112721.75186-2-shaojijie@huawei.com>
References: <20260617112721.75186-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: hns3: unify copper port ksettings configuration path

Refactor hns3_set_link_ksettings() and hclge_set_phy_link_ksettings()
to unify the configuration path for copper ports.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
[ ... ]
> @@ -863,6 +859,8 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
>  	struct hnae3_handle *handle = hns3_get_handle(netdev);
>  	struct hnae3_ae_dev *ae_dev = hns3_get_ae_dev(handle);
>  	const struct hnae3_ae_ops *ops = hns3_get_ops(handle);
> +	u8 module_type = HNAE3_MODULE_TYPE_UNKNOWN;
> +	u8 media_type = HNAE3_MEDIA_TYPE_UNKNOWN;
>  	int ret;
>  
>  	/* Chip don't support this mode. */
> @@ -878,22 +876,20 @@ static int hns3_set_link_ksettings(struct net_device *netdev,
>  		  cmd->base.autoneg, cmd->base.speed, cmd->base.duplex,
>  		  cmd->lanes);
>  
> -	/* Only support ksettings_set for netdev with phy attached for now */
> -	if (netdev->phydev) {
> -		if (cmd->base.speed == SPEED_1000 &&
> -		    cmd->base.autoneg == AUTONEG_DISABLE)
> -			return -EINVAL;

[Severity: Medium]
Does removing this validation allow invalid configurations for native copper
PHYs?

The previous code explicitly rejected SPEED_1000 with AUTONEG_DISABLE because
IEEE 802.3 1000BASE-T strictly requires autonegotiation. By delegating
directly to phy_ethtool_ksettings_set(), which permits this for 1000BASE-X,
the driver might now silently accept an invalid configuration.

> -		return phy_ethtool_ksettings_set(netdev->phydev, cmd);
> -	} else if (test_bit(HNAE3_DEV_SUPPORT_PHY_IMP_B, ae_dev->caps) &&
> -		   ops->set_phy_link_ksettings) {
> +	if (!ops->get_media_type)
> +		return -EOPNOTSUPP;
> +	ops->get_media_type(handle, &media_type, &module_type);
>  
> -		return ops->set_phy_link_ksettings(handle, cmd);
> -	}
> +	if (media_type == HNAE3_MEDIA_TYPE_COPPER) {
> +		if (!ops->set_phy_link_ksettings)
> +			return -EOPNOTSUPP;
> +		return ops->set_phy_link_ksettings(handle, cmd);
> +	}
[ ... ]
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
[ ... ]
> @@ -3400,10 +3400,28 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
>  		return ret;
>  	}
>  
> +	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
> +	return 0;
> +}
> +
> +static int
> +hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
> +			     const struct ethtool_link_ksettings *cmd)
> +{
> +	struct hclge_vport *vport = hclge_get_vport(handle);
> +	struct hclge_dev *hdev = vport->back;
> +	int ret;
> +
> +	if (hnae3_dev_phy_imp_supported(hdev))
> +		ret = hclge_ethtool_ksettings_set(handle, cmd);
> +	else
> +		ret = phy_ethtool_ksettings_set(handle->netdev->phydev, cmd);

[Severity: Critical]
Can handle->netdev->phydev be NULL here, leading to a kernel panic when called
from userspace?

A copper port can legitimately have a NULL phydev if the port's PHY address
is configured as PHY_INEXISTENT in the firmware. 

Because the updated hns3_set_link_ksettings() now routes all 
HNAE3_MEDIA_TYPE_COPPER configurations here without the previous 
if (netdev->phydev) guard, phy_ethtool_ksettings_set() will unconditionally
dereference phydev->mdio.addr.

> +	if (ret)
> +		return ret;
> +
>  	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
>  	hdev->hw.mac.req_speed = cmd->base.speed;
>  	hdev->hw.mac.req_duplex = cmd->base.duplex;
