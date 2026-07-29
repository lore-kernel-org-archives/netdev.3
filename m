Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16973407CE8;
	Wed, 29 Jul 2026 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311110; cv=none; b=jezKLENeVo9NeDAQ4ZgNZ9QU/ghluW17Kj7BAQheSv+h+UrLYx0cFnOMLnAKJwfu6cdfPI2hcP7glh0kOJ0KR/DJMem4ecYgDKj5ZPtSXvzSIuN+xXjz3V8LU0Fvso79E5eGn2/ksiivjaguOUlVfoclgrbA7nBqesv+UDNwmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311110; c=relaxed/simple;
	bh=y+PdN7puxCwuy3Rjn8pZ5sPvULK4TuhEmZR8DiFefT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uyz1ZqMMVF5OQoF7ofdgV278Gajo9Xnw+FQXXoT43Mdy7u3m+WfXgCRKgFzKPvsnAU499PTDMhNiSyW0xq6leJ2R4FfYvaw+jqBaBvCJfCLtn0rhRNltq7A6VTXJYTtwsng+5OgOVhw0pKvApc6QsBJj871LCrSaF+eLsjSJ+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zxR4uWeh; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zxR4uWeh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dMrzsz5h8lOzA65z9IvJBnP9H0ItgwDUTF4ULnZKIeI=;
	b=zxR4uWehqfdXDIUhW6cqAONUAe/xi8rGMF0uaIfAACkmfSfvwFIR50LIGAs82IyxNy/1Q6rIZ
	HZHmgYY6qh7G8XFLi30/YlhWhywesruHmGO3p5m0Po3SA66KyUl0cw9TBkdCeVUzt5TR/fX7PRc
	0D3z7VG0k4/a6Q6NkMZQnuY=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h93yn5wWlz1K98Z;
	Wed, 29 Jul 2026 15:35:29 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CD0640586;
	Wed, 29 Jul 2026 15:44:55 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 29 Jul 2026 15:44:54 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <mohsin.bashr@gmail.com>
CC: <andrew+netdev@lunn.ch>, <august.hewei@huawei.com>,
	<chenanwen@huawei.com>, <davem@davemloft.net>,
	<dimitri.daskalakis1@gmail.com>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <horms@kernel.org>,
	<hramamurthy@google.com>, <ioana.ciornei@nxp.com>, <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <maxime.chevallier@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shijing34@huawei.com>,
	<tengpeisen@huawei.com>, <wudi234@huawei.com>, <wulike1@huawei.com>,
	<zhengjiezhen@h-partners.com>, <zhoushuai28@huawei.com>
Subject: Re: Re: [PATCH net-next v12 2/8] hinic3: Fix loose success check in rx buffer filling
Date: Wed, 29 Jul 2026 15:44:50 +0800
Message-ID: <20260729074450.909-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <13ebe4e4-d744-4473-bc6e-2742ac0af492@gmail.com>
References: <13ebe4e4-d744-4473-bc6e-2742ac0af492@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> >    Tightens the success criterion for hinic3_rx_fill_buffers() in
> > hinic3_configure_rxqs().
> >
> > Co-developed-by: Wu Di <wudi234@huawei.com>
> > Signed-off-by: Wu Di <wudi234@huawei.com>
> > Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> > Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> > Signed-off-by: Fan Gong <gongfan1@huawei.com>
> > ---
> >   drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> > index 309ab5901379..389b1c2158be 100644
> > --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> > +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> > @@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
> >   		rq_associate_cqes(rxq);
> >
> >   		pkts = hinic3_rx_fill_buffers(rxq);
> > -		if (!pkts) {
> > +		if (pkts < rxq->q_mask) {
> >   			netdev_err(netdev, "Failed to fill Rx buffer\n");
> >   			return -ENOMEM;
> >   		}
>
> Given the subject, curious if a partially populated ring result in any
> functional failure? if so, then perhaps failure mode can be explained
> and this specific change be sent to net tree?

Thanks for the comment. It fixes a previous review comment of the patchset
as the following quotes. To see the full review, visit
https://lore.kernel.org/netdev/20260413171817.1e1eca30@kernel.org/

> > +int
> > +hinic3_change_channel_settings(struct net_device *netdev,
> > +			       struct hinic3_dyna_txrxq_params *trxq_params)
> > +{
> > +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> > +	struct hinic3_dyna_txrxq_params old_qp_params = {};
> > +	struct hinic3_dyna_qp_params new_qp_params = {};
> > +	struct hinic3_dyna_qp_params cur_qp_params = {};
> > +	bool need_teardown = false;
> > +	unsigned long flags;
> > +	int err;
> > +
> > +	mutex_lock(&nic_dev->channel_cfg_lock);
> > +
> > +	hinic3_config_num_qps(netdev, trxq_params);
> > +
> > +	err = hinic3_alloc_channel_resources(netdev, &new_qp_params,
> > +					     trxq_params);
> > +	if (err) {
> > +		netdev_err(netdev, "Failed to alloc channel resources\n");
> > +		mutex_unlock(&nic_dev->channel_cfg_lock);
> > +		return err;
> > +	}
> > +
> > +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> > +	if (!test_and_set_bit(HINIC3_CHANGE_RES_INVALID, &nic_dev->flags))
> > +		need_teardown = true;
> > +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> > +
> > +	if (need_teardown) {
> > +		hinic3_vport_down(netdev);
> > +		hinic3_close_channel(netdev);
> > +		hinic3_uninit_qps(nic_dev, &cur_qp_params);
> > +		hinic3_free_channel_resources(netdev, &cur_qp_params,
> > +					      &nic_dev->q_params);
> > +	}
> > +
> > +	if (nic_dev->num_qp_irq > trxq_params->num_qps)
> > +		hinic3_qp_irq_change(netdev, trxq_params->num_qps);
> > +
> > +	spin_lock_irqsave(&nic_dev->channel_res_lock, flags);
> > +	old_qp_params = nic_dev->q_params;
> > +	nic_dev->q_params = *trxq_params;
> > +	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
> > +
> > +	hinic3_init_qps(nic_dev, &new_qp_params);
> > +
> > +	err = hinic3_open_channel(netdev);
>
> This "open" function allocates Rx buffers, and fails if it couldn't get
> even one. That's no good.
