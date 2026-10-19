Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25A948489C;
	Mon, 19 Oct 2026 07:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394979; cv=none; b=eVb6xs4iJ9bnvqo6xg6dVs+LDlYm5EsVGACMVfeFIlUdU0nyLoa2A/ZiD5mVtOYhMOEW5eadiKEQxv1+owX+R/oilWJwtMEJ0JBwLzyVWc7g93Th+mLSJteOAPyIadbMnASOz4SExIv3xdJgTgS9YiESL3p/JQBC/qdWH2Ds/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394979; c=relaxed/simple;
	bh=RVrK23n9guhCLD0KdjKHBkNh91t7VI15fVyUzbwdeHQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dvs26hVz3jzj6cbbCLbgoq792BivLwKOvwh4e2KZ8yl2gaJa09SH7urQpexJLIHzoxFLwFtLw6n+6xdcflQ7KaAVK+OInpnebe7+W5EGxolFYW/6o9ONXEzCYPMwSdwo2q5AHdgAMjUjAXwZIbKavTY0rQ1qf6r2rKSUaN6R99k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=UH3OWFJU; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="UH3OWFJU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZbmY88yNudks0srVUF6WYDBtPygxpDMPSGSGxE3bBK4=;
	b=UH3OWFJUC5LbHgZLqmkPP3DGN7DuPqiC6tV7M+6PbNEBMqGMBGMTFp50mKmzASsc0jv/SLJBZ
	Ka+A2ilhudqUGZui2q4oVmKBg2P89w8K5W+/rQb5H7gdVb5HEcDZzJF0KMD/mrCNw8CR3v+hOlo
	X2j6h9R6kWW4VnV84YyOMgg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j7Rxp5JDsz1prLh;
	Mon, 19 Oct 2026 15:29:18 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AF284056D;
	Mon, 19 Oct 2026 15:29:21 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 15:29:20 +0800
Message-ID: <013a154b-1211-4b54-821b-5621a69ddd6a@huawei.com>
Date: Mon, 19 Oct 2026 15:29:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] net: hix5hd2: serialize timeout recovery with
 interface teardown
To: Myeonghun Pak <mhun512@gmail.com>, Jian Shen <shenjian15@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
References: <179203116093.2621539.3718842986255459438.G202@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <179203116093.2621539.3718842986255459438.G202@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/10/15 10:26, Myeonghun Pak wrote:
> The timeout worker calls the driver's close and open methods without
> RTNL or a running-state check. A timeout queued before an interface is
> closed can call close again after ndo_stop has disabled NAPI. The second
> napi_disable() can then wait indefinitely. The worker can also race with
> an ongoing close.
>
> Take RTNL and skip recovery when the interface is no longer running.
> Use the netdev core close and open helpers so a failed reopen leaves the
> interface down, rather than leaving it marked running with NAPI disabled.
>
> After unregister_netdev() has stopped the watchdog, drain the worker
> before releasing its MDIO and descriptor resources. This wait is outside
> RTNL, allowing an already queued worker to take RTNL, observe the down
> state, and finish.
>
> This issue was identified as part of our ongoing research while
> reviewing kernel code.
>
> Fixes: 57c5bc9ad7d7 ("net: hisilicon: add hix5hd2 mac driver")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Thanks, The code changes look good to me.
Reviewed-by: Jijie Shao <shaojijie@huawei.com>

> ---
> Compile-tested with GCC, W=1 (arm64). No runtime testing.
>
> Related remove-path change (devres-managed netdev lifetime):
> https://lkml.iu.edu/2610.0/05627.html
>
>   drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> index 02282dc..12a5657 100644
> --- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> +++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
> @@ -12,6 +12,7 @@
>   #include <linux/of_net.h>
>   #include <linux/of_mdio.h>
>   #include <linux/reset.h>
> +#include <linux/rtnetlink.h>
>   #include <linux/clk.h>
>   #include <linux/circ_buf.h>
>   
> @@ -890,8 +891,13 @@ static void hix5hd2_tx_timeout_task(struct work_struct *work)
>   	struct hix5hd2_priv *priv;
>   
>   	priv = container_of(work, struct hix5hd2_priv, tx_timeout_task);
> -	hix5hd2_net_close(priv->netdev);
> -	hix5hd2_net_open(priv->netdev);
> +
> +	rtnl_lock();
> +	if (netif_running(priv->netdev)) {
> +		dev_close(priv->netdev);
> +		dev_open(priv->netdev, NULL);
> +	}
> +	rtnl_unlock();
>   }
>   
>   static void hix5hd2_net_timeout(struct net_device *dev, unsigned int txqueue)
> @@ -1283,6 +1289,7 @@ static void hix5hd2_dev_remove(struct platform_device *pdev)
>   	struct hix5hd2_priv *priv = netdev_priv(ndev);
>   
>   	unregister_netdev(ndev);
> +	cancel_work_sync(&priv->tx_timeout_task);
>   	mdiobus_unregister(priv->bus);
>   	mdiobus_free(priv->bus);
>   
> @@ -1290,7 +1297,6 @@ static void hix5hd2_dev_remove(struct platform_device *pdev)
>   		hix5hd2_destroy_sg_desc_queue(priv);
>   	hix5hd2_destroy_hw_desc_queue(priv);
>   	of_node_put(priv->phy_node);
> -	cancel_work_sync(&priv->tx_timeout_task);
>   	free_netdev(ndev);
>   }
>   
