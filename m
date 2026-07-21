Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B746D082
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657272; cv=none; b=d6jnLXL3MYtuynpg/V+339e1cQOKQHPI2FQ5dtJy9UMTbr92Er3B8hOpD/AJif9ovN/EgIuOF+DxS0lM05J7OpmWo39Vm2a4mJ1Ta9CHSv8Lfhe1P2S+jK62ujOnfDDnbII6PXgSrjfALnQ7TC6BkFXZ8dfA1v6x9oYjvBvZlk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657272; c=relaxed/simple;
	bh=WvACp2/z+3E8tw5TZyl7hpOGrNEaHdxpjmDXB5q7X/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hy+Q393I1p03DZqHqh57uxLuW5J2E3y73jzaY4x+fPkPlhwp+z3yMJQpRD0D2Ex/0arEewh1pyb+UXPIRwZWEyEPkINWPDz/Xqb/DDLIAY0ChACrkYnESbGs6/97BGC8sLnEg34sqfYo7b52c4ObqN6MAf0fvtAgDqde8Xf7qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtsJzLj4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtsJzLj4"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ceed7018c8so55155485ad.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 11:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784657270; x=1785262070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c40NBo1W9yHmbmPu6DBj/iUhGmv3QX59r4twZJLz7lo=;
        b=jtsJzLj4UAV43zgQzD43nM1JHvdky2engASx/NtBLSUafUr/ehXChXtFM3eRIVEUyu
         kqCvHaqXUt6DWT3n2u2iqkVneCmncbRrWzrFtXIdAsZzByOFqhgSvbNbAZeEHD1jUzdD
         vZzzbztGNVpP0yuYD1R1NLvx2p4esaG50P6zxsd36It4Tzb69KEEObzXatc2mbVvurCV
         OKy8ateT11+Fa1kniee8y9X7iut7mT4T/9zl65CnQSzmG+KsSzdk8qA5cQ3LuIaApzVf
         +kKw5vyURTKbjDsqS8Z0qZ8YvVJuPVaSs+YG41/o0YFyEaEGl7We1+QwiZQpAG8/IFZv
         BtSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784657270; x=1785262070;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c40NBo1W9yHmbmPu6DBj/iUhGmv3QX59r4twZJLz7lo=;
        b=o+fAjn0LnHi79snB277j/YmsyyD9Vlq+3xzwquVkzN1irO9tGPH+4fw/4eqCer3O52
         RzgaWsYYVKjwS86HZIJRSwOR3x+0yluJQcUANb0StBB7VE/WT3x4WpPaul6iPc/Q45CF
         arB1iHYIwCrek178TxAfASVIEBfrS+foIAj4rSPRdhEl/SENvABUENsK8zw/nqGB2kOO
         jbMZwH5/qwj0kn2X9pacAMtMbnOGb+3BQgWPtr5c8c8KrkxGFy//PIx5c3tQ3hI9dv1W
         IEekueVTJx50+RSazAOvPU9ySwBjDqk/qhZ2S5PSROxjGpjKQTvmXqwUoD+MJHyCysbP
         S8HQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoTHap1FHpYra3UDzZ86FVwmboj/TeQTHlRUvODd/N3lfTlvLL+Tcc2n5uj+dc2HWSkEXE7XU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EXhaO1ZFY3X0rbT5Ok1G/fGdDsXNjiEb1cBvoKH2beWGLuLw
	m1WYPkQMcXYSoVSoie5WFrW9V3KVjyIW91rMdQS6SREdIk1MRj74NeAB
X-Gm-Gg: AR+sD10Sk0EfSl52uPfopl3utUlGXQaCDKLxDyD50OkuBVOnputg82+us0AqQ6rFKWg
	/EyVFn5ZEdCtPRyia6kGL9uZFGf9gNvcr+E8B0SDKxZKK5hXpNbC92cTSpgN0co1zPg0PP7NRnc
	eGRV/2li8tq5b7sv0RwrRdHEorUwIll0wuAww6xRxk4kdLCoBMXw09qiOhfmb+Ew9LLHcaZmYjQ
	6p6M2IEq7vWtY/oqzhqRqBUtGH5zS4X7MlOLqMFdkJn/kNORLukQZNlabzo3wJGEuFVgdB6sYzm
	vStNVW9gBT/u+/Ergh2f4grBDabzCdiUFyKWa0g14VJa3c1NdSlDZqmpv+dA7YliJTdbkIAgx68
	GTQm/sSk1O/oWb8FfleGj5ZLyq56tZ4kDBucyPQEdRU/w+XZNhIbkU42WL7SkjmWReKMKuOjZ7y
	17QlY8hZYTEEx6x9KUtHKKQfJulXJzY2KvRFAc8iXezjWpgh0t
X-Received: by 2002:a17:903:946:b0:2cf:6f7f:55d8 with SMTP id d9443c01a7336-2cf6f7f6a7cmr88695745ad.37.1784657269494;
        Tue, 21 Jul 2026 11:07:49 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c56:221b:35d5:85f? ([2620:10d:c090:500::2:246a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e07000fsm2187984eec.21.2026.07.21.11.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 11:07:49 -0700 (PDT)
Message-ID: <c4473a79-567a-430b-b463-f45d4ef3ea28@gmail.com>
Date: Tue, 21 Jul 2026 11:07:47 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 1/5] hinic3: Add ethtool queue ops
To: Fan Gong <gongfan1@huawei.com>, Wu Di <wudi234@huawei.com>,
 Teng Peisen <tengpeisen@huawei.com>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Zheng Jiezhen
 <zhengjiezhen@h-partners.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <cover.1784538912.git.root@localhost.localdomain>
 <9c55508017d53dd642f1a9c864ad8dfd1e3fd500.1784538912.git.root@localhost.localdomain>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <9c55508017d53dd642f1a9c864ad8dfd1e3fd500.1784538912.git.root@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/20/26 5:53 AM, Fan Gong wrote:
>    Implement following ethtool callback function:
> .get_ringparam
> .set_ringparam
> 
>    These callbacks allow users to utilize ethtool for detailed
> queue depth configuration and monitoring.
> 
>    Change port_state_mutex to state_lock as a unified mutex lock
> in hinic3_nic_dev.
> 
>    Tightens the success criterion for hinic3_rx_fill_buffers() in
> hinic3_configure_rxqs().
> 
>    Changes hinic3_tx_csum()/hinic3_tx_offload() to propagate
> skb_checksum_help() failures into a TX drop.
> 
>    Renames hinic3_uninit_qps() to hinic3_get_cur_qps().
> 
>    Splits hinic3_open_channel() into hinic3_prepare_channel() and
> hinic3_open_channel().
> 

It may just be me, but I feel like there is a lot going in this single 
patch. Ideally, a patch should carry one logical change. This patch is 
doing 3 things: refactor, new code, bug-fixing in the hinic3_close() path.

> Co-developed-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Wu Di <wudi234@huawei.com>
> Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>   .../ethernet/huawei/hinic3/hinic3_ethtool.c   |  91 +++++++++++++++
>   .../net/ethernet/huawei/hinic3/hinic3_main.c  |   4 +-
>   .../huawei/hinic3/hinic3_netdev_ops.c         | 106 ++++++++++++++++--
>   .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  11 +-
>   .../ethernet/huawei/hinic3/hinic3_nic_io.c    |   4 +-
>   .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   8 +-
>   .../net/ethernet/huawei/hinic3/hinic3_rx.c    |   2 +-
>   .../net/ethernet/huawei/hinic3/hinic3_tx.c    |   7 +-
>   8 files changed, 216 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 90fc16288de9..e6dff46a0d00 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> @@ -9,6 +9,7 @@
>   #include <linux/errno.h>
>   #include <linux/etherdevice.h>
>   #include <linux/netdevice.h>
> +#include <linux/netlink.h>
>   #include <linux/ethtool.h>
>   
>   #include "hinic3_lld.h"
> @@ -409,6 +410,94 @@ hinic3_get_link_ksettings(struct net_device *netdev,
>   	return 0;
>   }
>   
> +static void hinic3_get_ringparam(struct net_device *netdev,
> +				 struct ethtool_ringparam *ring,
> +				 struct kernel_ethtool_ringparam *kernel_ring,
> +				 struct netlink_ext_ack *extack)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +
> +	ring->rx_max_pending = HINIC3_MAX_RX_QUEUE_DEPTH;
> +	ring->tx_max_pending = HINIC3_MAX_TX_QUEUE_DEPTH;
> +	ring->rx_pending = nic_dev->q_params.rq_depth;
> +	ring->tx_pending = nic_dev->q_params.sq_depth;
> +}
> +
> +static void hinic3_update_qp_depth(struct net_device *netdev,
> +				   u32 sq_depth, u32 rq_depth)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	u16 i;
> +
> +	nic_dev->q_params.sq_depth = sq_depth;
> +	nic_dev->q_params.rq_depth = rq_depth;
> +	for (i = 0; i < nic_dev->max_qps; i++) {
> +		nic_dev->txqs[i].q_depth = sq_depth;
> +		nic_dev->txqs[i].q_mask = sq_depth - 1;
> +		nic_dev->rxqs[i].q_depth = rq_depth;
> +		nic_dev->rxqs[i].q_mask = rq_depth - 1;
> +	}
> +}
> +
> +static int hinic3_check_ringparam_valid(struct net_device *netdev,
> +					const struct ethtool_ringparam *ring,
> +					struct netlink_ext_ack *extack)
> +{
> +	if (ring->tx_pending < HINIC3_MIN_QUEUE_DEPTH ||
> +	    ring->rx_pending < HINIC3_MIN_QUEUE_DEPTH) {
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Queue depth underflow[%d]: tx[%d], rx[%d]",
> +				       HINIC3_MIN_QUEUE_DEPTH,
> +				       ring->tx_pending, ring->rx_pending);
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int hinic3_set_ringparam(struct net_device *netdev,
> +				struct ethtool_ringparam *ring,
> +				struct kernel_ethtool_ringparam *kernel_ring,
> +				struct netlink_ext_ack *extack)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_dyna_txrxq_params q_params = {};
> +	u32 new_sq_depth, new_rq_depth;
> +	int err;
> +
> +	err = hinic3_check_ringparam_valid(netdev, ring, extack);
> +	if (err)
> +		return err;
> +
> +	new_sq_depth = rounddown_pow_of_two(ring->tx_pending);
> +	new_rq_depth = rounddown_pow_of_two(ring->rx_pending);
> +	if (new_sq_depth == nic_dev->q_params.sq_depth &&
> +	    new_rq_depth == nic_dev->q_params.rq_depth)
> +		return 0;
> +
> +	if (new_sq_depth != ring->tx_pending ||
> +	    new_rq_depth != ring->rx_pending)
> +		NL_SET_ERR_MSG_FMT_MOD(extack,
> +				       "Requested Tx/Rx ring depth %u/%u trimmed to %u/%u",
> +				       ring->tx_pending, ring->rx_pending,
> +				       new_sq_depth, new_rq_depth);
> +
> +	if (!netif_running(netdev)) {
> +		hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth);
> +	} else {
> +		q_params = nic_dev->q_params;
> +		q_params.sq_depth = new_sq_depth;
> +		q_params.rq_depth = new_rq_depth;
> +
> +		err = hinic3_change_channel_settings(netdev, &q_params);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
>   static const struct ethtool_ops hinic3_ethtool_ops = {
>   	.supported_coalesce_params      = ETHTOOL_COALESCE_USECS |
>   					  ETHTOOL_COALESCE_PKT_RATE_RX_USECS,
> @@ -417,6 +506,8 @@ static const struct ethtool_ops hinic3_ethtool_ops = {
>   	.get_msglevel                   = hinic3_get_msglevel,
>   	.set_msglevel                   = hinic3_set_msglevel,
>   	.get_link                       = ethtool_op_get_link,
> +	.get_ringparam                  = hinic3_get_ringparam,
> +	.set_ringparam                  = hinic3_set_ringparam,
>   };
>   
>   void hinic3_set_ethtool_ops(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> index 0a888fe4c975..1e7ac3f330d7 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -178,7 +178,7 @@ static int hinic3_sw_init(struct net_device *netdev)
>   	u8 mac_addr[ETH_ALEN];
>   	int err;
>   
> -	mutex_init(&nic_dev->port_state_mutex);
> +	mutex_init(&nic_dev->state_lock);
>   
>   	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
>   	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
> @@ -330,6 +330,8 @@ static void hinic3_link_status_change(struct net_device *netdev,
>   		netif_carrier_off(netdev);
>   		netdev_dbg(netdev, "Link is down\n");
>   	}
> +
> +	return;

Unrelated?

>   }
>   
>   static void hinic3_port_module_event_handler(struct net_device *netdev,
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index da73811641a9..7f304d7ac47b 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -288,7 +288,8 @@ static void hinic3_free_channel_resources(struct net_device *netdev,
>   	hinic3_free_qps(nic_dev, qp_params);
>   }
>   
> -static int hinic3_open_channel(struct net_device *netdev)
> +static int hinic3_prepare_channel(struct net_device *netdev,
> +				  struct hinic3_dyna_txrxq_params *qp_params)
>   {
>   	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>   	int err;
> @@ -299,12 +300,25 @@ static int hinic3_open_channel(struct net_device *netdev)
>   		return err;
>   	}
>   
> -	err = hinic3_configure_txrxqs(netdev, &nic_dev->q_params);
> +	err = hinic3_configure_txrxqs(netdev, qp_params);
>   	if (err) {
>   		netdev_err(netdev, "Failed to configure txrxqs\n");
>   		goto err_free_qp_ctxts;
>   	}
>   
> +	return 0;
> +
> +err_free_qp_ctxts:
> +	hinic3_free_qp_ctxts(nic_dev);
> +
> +	return err;
> +}
> +
> +static int hinic3_open_channel(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	int err;
> +
>   	err = hinic3_qps_irq_init(netdev);
>   	if (err) {
>   		netdev_err(netdev, "Failed to init txrxq irq\n");
> @@ -321,6 +335,7 @@ static int hinic3_open_channel(struct net_device *netdev)
>   
>   err_uninit_qps_irq:
>   	hinic3_qps_irq_uninit(netdev);
> +
>   err_free_qp_ctxts:
>   	hinic3_free_qp_ctxts(nic_dev);
>   
> @@ -341,9 +356,7 @@ static int hinic3_maybe_set_port_state(struct net_device *netdev, bool enable)
>   	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
>   	int err;
>   
> -	mutex_lock(&nic_dev->port_state_mutex);
>   	err = hinic3_set_port_enable(nic_dev->hwdev, enable);
> -	mutex_unlock(&nic_dev->port_state_mutex);
>   
>   	return err;
>   }
> @@ -428,6 +441,76 @@ static void hinic3_vport_down(struct net_device *netdev)
>   	}
>   }
>   
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +			       struct hinic3_dyna_txrxq_params *trxq_params)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct hinic3_dyna_txrxq_params cur_trxq_params = {};
> +	struct hinic3_dyna_qp_params new_qp_params = {};
> +	struct hinic3_dyna_qp_params cur_qp_params = {};
> +	int err;
> +
> +	mutex_lock(&nic_dev->state_lock);
> +	cur_trxq_params = nic_dev->q_params;
> +
> +	hinic3_config_num_qps(netdev, trxq_params);
> +
> +	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
> +					     trxq_params);
> +	if (err) {
> +		netdev_err(netdev, "Failed to alloc channel resources\n");
> +		hinic3_config_num_qps(netdev, &cur_trxq_params);
> +		mutex_unlock(&nic_dev->state_lock);
> +		return err;
> +	}
> +
> +	hinic3_vport_down(netdev);
> +	hinic3_close_channel(netdev);
> +	hinic3_get_cur_qps(nic_dev, &cur_qp_params);
> +
> +	hinic3_init_qps(nic_dev, &new_qp_params);
> +
> +	err = hinic3_prepare_channel(netdev, trxq_params);
> +	if (err)
> +		goto err_uninit_qps;
> +
> +	if (nic_dev->num_qp_irq > trxq_params->num_qps)
> +		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
> +
> +	nic_dev->q_params = *trxq_params;
> +
> +	err = hinic3_open_channel(netdev);
> +	if (err)
> +		goto err_qp_irq_reset;
> +
> +	err = hinic3_vport_up(netdev);
> +	if (err)
> +		goto err_close_channel;
> +
> +	hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_params);
> +
> +	mutex_unlock(&nic_dev->state_lock);
> +
> +	return 0;
> +
> +err_close_channel:
> +	hinic3_close_channel(netdev);
> +err_qp_irq_reset:
> +	nic_dev->q_params = cur_trxq_params;
> +
> +	if (trxq_params->num_qps > cur_trxq_params.num_qps)
> +		hinic3_qp_irq_change(netdev, cur_trxq_params.num_qps);
> +err_uninit_qps:
> +	hinic3_get_cur_qps(nic_dev, &new_qp_params);
> +	hinic3_config_num_qps(netdev, &cur_trxq_params);
> +	hinic3_init_qps(nic_dev, &cur_qp_params);
> +	hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params);
> +	mutex_unlock(&nic_dev->state_lock);
> +
> +	return err;
> +}
> +
>   static int hinic3_open(struct net_device *netdev)
>   {
>   	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> @@ -458,6 +541,10 @@ static int hinic3_open(struct net_device *netdev)
>   
>   	hinic3_init_qps(nic_dev, &qp_params);
>   
> +	err = hinic3_prepare_channel(netdev, &nic_dev->q_params);
> +	if (err)
> +		goto err_uninit_qps;
> +
>   	err = hinic3_open_channel(netdev);
>   	if (err)
>   		goto err_uninit_qps;
> @@ -473,7 +560,7 @@ static int hinic3_open(struct net_device *netdev)
>   err_close_channel:
>   	hinic3_close_channel(netdev);
>   err_uninit_qps:
> -	hinic3_uninit_qps(nic_dev, &qp_params);
> +	hinic3_get_cur_qps(nic_dev, &qp_params);
>   	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
>   err_destroy_num_qps:
>   	hinic3_destroy_num_qps(netdev);
> @@ -493,10 +580,15 @@ static int hinic3_close(struct net_device *netdev)
>   		return 0;
>   	}
>   
> +	mutex_lock(&nic_dev->state_lock);
>   	hinic3_vport_down(netdev);
>   	hinic3_close_channel(netdev);
> -	hinic3_uninit_qps(nic_dev, &qp_params);
> -	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
> +	hinic3_get_cur_qps(nic_dev, &qp_params);
> +	hinic3_free_channel_resources(netdev, &qp_params,
> +				      &nic_dev->q_params);
> +	hinic3_free_nicio_res(nic_dev);
> +	hinic3_destroy_num_qps(netdev);

free_nicio_res(), and destroy_num_qps() looks like fixes to me on the 
clean-up path. Should these go to the net tree?


> +	mutex_unlock(&nic_dev->state_lock);
>   
>   	return 0;
>   }
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> index 9502293ff710..ccef82d57fdd 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> @@ -10,6 +10,9 @@
>   #include "hinic3_hw_cfg.h"
>   #include "hinic3_hwdev.h"
>   #include "hinic3_mgmt_interface.h"
> +#include "hinic3_nic_io.h"
> +#include "hinic3_tx.h"
> +#include "hinic3_rx.h"
>   
>   #define HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev)  (sizeof(*(nic_dev)->vlan_bitmap))
>   #define HINIC3_VLAN_BITMAP_SIZE(nic_dev)  \
> @@ -127,8 +130,8 @@ struct hinic3_nic_dev {
>   	struct workqueue_struct         *workq;
>   	struct delayed_work             periodic_work;
>   	struct work_struct              rx_mode_work;
> -	/* lock for enable/disable port */
> -	struct mutex                    port_state_mutex;
> +	/* Protects Interface state */
> +	struct mutex                    state_lock;
>   
>   	struct list_head                uc_filter_list;
>   	struct list_head                mc_filter_list;
> @@ -143,6 +146,10 @@ struct hinic3_nic_dev {
>   
>   void hinic3_set_netdev_ops(struct net_device *netdev);
>   int hinic3_set_hw_features(struct net_device *netdev);
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +			       struct hinic3_dyna_txrxq_params *trxq_params);
> +
>   int hinic3_qps_irq_init(struct net_device *netdev);
>   void hinic3_qps_irq_uninit(struct net_device *netdev);
>   
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
> index 87e736adba02..0e7a0ccfba98 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
> @@ -484,8 +484,8 @@ void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
>   	}
>   }
>   
> -void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
> -		       struct hinic3_dyna_qp_params *qp_params)
> +void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
> +			struct hinic3_dyna_qp_params *qp_params)
>   {
>   	struct hinic3_nic_io *nic_io = nic_dev->nic_io;
>   
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> index 12eefabcf1db..571b34d63950 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> @@ -14,6 +14,10 @@ struct hinic3_nic_dev;
>   #define HINIC3_RQ_WQEBB_SHIFT      3
>   #define HINIC3_SQ_WQEBB_SIZE       BIT(HINIC3_SQ_WQEBB_SHIFT)
>   
> +#define HINIC3_MAX_TX_QUEUE_DEPTH  65536
> +#define HINIC3_MAX_RX_QUEUE_DEPTH  16384
> +#define HINIC3_MIN_QUEUE_DEPTH     128
> +
>   /* ******************** RQ_CTRL ******************** */
>   enum hinic3_rq_wqe_type {
>   	HINIC3_NORMAL_RQ_WQE = 1,
> @@ -136,8 +140,8 @@ void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
>   		     struct hinic3_dyna_qp_params *qp_params);
>   void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
>   		     struct hinic3_dyna_qp_params *qp_params);
> -void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
> -		       struct hinic3_dyna_qp_params *qp_params);
> +void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
> +			struct hinic3_dyna_qp_params *qp_params);
>   
>   int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
>   void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev);
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> index 309ab5901379..389b1c2158be 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> @@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
>   		rq_associate_cqes(rxq);
>   
>   		pkts = hinic3_rx_fill_buffers(rxq);
> -		if (!pkts) {
> +		if (pkts < rxq->q_mask) {
>   			netdev_err(netdev, "Failed to fill Rx buffer\n");
>   			return -ENOMEM;
>   		}
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> index 9306bf0020ca..53c065194136 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
> @@ -261,8 +261,7 @@ static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
>   		    ((struct udphdr *)skb_transport_header(skb))->dest !=
>   		    VXLAN_OFFLOAD_PORT_LE) {
>   			/* Unsupported tunnel packet, disable csum offload */
> -			skb_checksum_help(skb);
> -			return 0;
> +			return skb_checksum_help(skb);
>   		}
>   	}
>   
> @@ -412,6 +411,10 @@ static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
>   		offload |= HINIC3_TX_OFFLOAD_TSO;
>   	} else {
>   		tso_cs_en = hinic3_tx_csum(txq, task, skb);
> +		if (tso_cs_en < 0) {
> +			offload = HINIC3_TX_OFFLOAD_INVALID;
> +			return offload;
> +		}
>   		if (tso_cs_en)
>   			offload |= HINIC3_TX_OFFLOAD_CSUM;
>   	}

