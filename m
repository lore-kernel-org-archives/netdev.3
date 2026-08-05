Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28A31B3925;
	Wed,  5 Aug 2026 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896543; cv=none; b=fqmtSV1PmTa00hILOhxKAK4zq+ynv8pzIdB894FNAPkIh+IMPbbx/FAIXsCJDeJsS2ReohYbVlUts+coJnFkXzl1J0nbNqYkPPMoc95XCmRB9KU9Dpe7PwfmDyPvGnAPzMmRx/7YWHa6oPWwiO7N/1+lq+ZMKLYTYREE6frOIsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896543; c=relaxed/simple;
	bh=T4zRLFVRXeCQIb/+UUj9Xr5UNCNS2b12vW7JO4BgYjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZymR6NvymlNpMc74gpsFBQB6naqyollyoa7suny0DgAahU64n9+1sqjP+KcaPUlciTqbPqr9O6TUz03qK2CzqS3z8l6WudZ6t9hEZG3oA81zHR0I4TloQy/CA3q2eymXFVkdrgO9sHFt5WwVUhxO+OJ0iahjxK02WidX1GDAEtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t2hSuyN4; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t2hSuyN4"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LQlgvljLpgu1qw/OI40qw8oSFr13eKFGLTXpMAMjsRI=;
	b=t2hSuyN4QiBHNITPlX9aIFADTxMJH8W09IIB41uefAkRcCNLaFxiaHcpK9QeL4u/TBTlXD7Ki
	qJWxi6vCXH3V8MLYxjyHB4gw7slKcK3wVpjyB4clxiHvyO2m2JJTJPsEhcM+z+9yBeZBbg7ddzN
	O2nWvmda5etn7c0ikqygtXg=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hFDS33dylz12LGW;
	Wed,  5 Aug 2026 10:11:47 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C225040561;
	Wed,  5 Aug 2026 10:22:16 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 5 Aug 2026 10:22:15 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <august.hewei@huawei.com>,
	<chenanwen@huawei.com>, <davem@davemloft.net>,
	<dimitri.daskalakis1@gmail.com>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <horms@kernel.org>,
	<hramamurthy@google.com>, <ioana.ciornei@nxp.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <maxime.chevallier@bootlin.com>,
	<mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shijing34@huawei.com>, <tengpeisen@huawei.com>, <wudi234@huawei.com>,
	<wulike1@huawei.com>, <zhengjiezhen@h-partners.com>, <zhoushuai28@huawei.com>
Subject: Re: Re: [PATCH net-next v12 2/8] hinic3: Fix loose success check in rx buffer filling
Date: Wed, 5 Aug 2026 10:22:12 +0800
Message-ID: <20260805022213.2017-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260803161314.6d173920@kernel.org>
References: <20260803161314.6d173920@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> > > > diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> > > > index 309ab5901379..389b1c2158be 100644
> > > > --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> > > > +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> > > > @@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, u16 num_rq,
> > > >   		rq_associate_cqes(rxq);
> > > >
> > > >   		pkts = hinic3_rx_fill_buffers(rxq);
> > > > -		if (!pkts) {
> > > > +		if (pkts < rxq->q_mask) {
> > > >   			netdev_err(netdev, "Failed to fill Rx buffer\n");
> > > >   			return -ENOMEM;
> > > >   		}
> > >
> > > Given the subject, curious if a partially populated ring result in any
> > > functional failure? if so, then perhaps failure mode can be explained
> > > and this specific change be sent to net tree?
> >
> > Thanks for the comment. It fixes a previous review comment of the patchset
> > as the following quotes. To see the full review, visit
> > https://lore.kernel.org/netdev/20260413171817.1e1eca30@kernel.org/
>
> You misunderstood the comment there.
> The concern was not about this function.
> The concern is that hinic3_change_channel_settings() in the proposed
> patch may fail after already tearing down the old configuration.
> Driver should allocate memory and other resources for the queue
> _before_ freeing the old memory. This limits the downtime and prevents
> failed reconfiguration from bringing the device down.
>
> IOW, when I said "this function may fail" I meant that you can't call
> function which may fail after stopping the device and freeing mem.
> Not that there is anything wrong with the function failing as it does..

Thanks for your explaination. We indeed misunderstood your comment, so we
made this change. We will remove it in the next patchset.
