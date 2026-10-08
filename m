Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0148FF6E;
	Thu,  8 Oct 2026 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460326; cv=none; b=TNYGxBe8nnB2eDpfrM2K0rzncg7yZVevYh/2c6Na/7BHRXDgUXfLONV5vTGQDTW9Je9Vcc3h+Bj8cj7JQohQNU6PBiYC5j+xwY7cAqlcvxkb3CPOi9LtnOjaYN5lifwHQPOdkxRylhPsvRAtvkq1CQoj9cYVmY+peoY3n9DytBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460326; c=relaxed/simple;
	bh=sSgOnEoVt7eSKsz+ert+jgFMYGUR9X37qUz5JfZJVyk=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jvY6pm+xLGYqWb/jCt6kPGK6VwBISd2J/QN1v5igySo+SFeRAvTONY15PwAgxr8rylRbnw02QZQJudRtPplseE7x5A96KU5vZ6gZirV/azPrNZeFP0ZPOodgVEIRwzdQVgFMJldT5YipUXQBZ/q8hbF3VgCrRWe3lVZoy67e5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3d9z4sVc; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3d9z4sVc"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3fA0RfKlCLOR4tyjI9DEwkzA+ujWn8C0TB1eHPFjASo=;
	b=3d9z4sVcxhMuqoMhExHO4m/28s8t6X3OLpgAwmRDfgi7gemSrBtPUowFdfcR+hkgDbyQcVqeq
	/2aQcXg0m7soqF4tj6dViIpnF9123FBbOPWYTfgnHO6vBtcN4xm0qAeBJ+o9JG2MpDSa3KLVkJ5
	Ixoi8D75pwUlL1yp8lsBmls=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4j0p1x5pMvzRhXN;
	Thu,  8 Oct 2026 19:39:49 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id B2F6640575;
	Thu,  8 Oct 2026 19:52:00 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 8 Oct 2026 19:51:59 +0800
Message-ID: <59b7118e-0bd9-4638-9a1f-a9b36eccff15@huawei.com>
Date: Thu, 8 Oct 2026 19:51:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 01/10] net: hisilicon: hisi_femac: Move setting of
 netops to fix crash
To: David Yang <mmyangfl@gmail.com>, <netdev@vger.kernel.org>
References: <20261008022656.3592191-1-mmyangfl@gmail.com>
 <20261008022656.3592191-2-mmyangfl@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20261008022656.3592191-2-mmyangfl@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/10/8 10:26, David Yang wrote:
> hisi_femac_drv_probe() connects the PHY before dev->netdev_ops is
> assigned. phy_attach_direct() -> phy_link_topo_add_phy() reads
> dev->netdev_ops through netdev_need_ops_lock() since the commit in
> question, so probing crashes with a NULL pointer dereference when
> CONFIG_NET_SHAPER is enabled.
>
>    phy_link_topo_add_phy from phy_attach_direct+0xec/0x37c
>    of_phy_get_and_connect from hisi_femac_drv_probe+0x1f4/0x558
>    Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>
> Assign netdev_ops before the PHY attach, as was done for emac in commit
> 7c9f391ec89c ("net: emac: move setting of netops to fix crash").
>
> Fixes: ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev() locking assertion")
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Reviewed-by: Jijie Shao <shaojijie@huawei.com>

If possible, modify this file as well. I have observed similar issues on the hibmcge driver recently:
drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c

There are similar issues:
The driver assigns netdev_ops after hbg_init(), but hbg_init() calls
hbg_mdio_init() -> hbg_phy_connect() -> phy_connect_direct() ->
phy_attach_direct() -> phy_link_topo_add_phy(), which invokes
netdev_need_ops_lock(). With CONFIG_NET_SHAPER enabled, this function
dereferences dev->netdev_ops->net_shaper_ops. Since netdev_ops is still
NULL at this point, a NULL pointer dereference occurs.

Move the netdev_ops assignment before hbg_init() so that
netdev_need_ops_lock() can safely access netdev_ops during PHY
attachment.

Thanks,
Jijie Shao

> ---
>   drivers/net/ethernet/hisilicon/hisi_femac.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
> index d244a40df430..016605e86f0b 100644
> --- a/drivers/net/ethernet/hisilicon/hisi_femac.c
> +++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
> @@ -830,6 +830,8 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>   		hisi_femac_phy_reset(priv);
>   	}
>   
> +	ndev->netdev_ops = &hisi_femac_netdev_ops;
> +
>   	phy = of_phy_get_and_connect(ndev, node, hisi_femac_adjust_link);
>   	if (!phy) {
>   		dev_err(dev, "connect to PHY failed!\n");
> @@ -850,7 +852,6 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
>   
>   	ndev->watchdog_timeo = 6 * HZ;
>   	ndev->priv_flags |= IFF_UNICAST_FLT;
> -	ndev->netdev_ops = &hisi_femac_netdev_ops;
>   	ndev->ethtool_ops = &hisi_femac_ethtools_ops;
>   	netif_napi_add_weight(ndev, &priv->napi, hisi_femac_poll,
>   			      FEMAC_POLL_WEIGHT);
