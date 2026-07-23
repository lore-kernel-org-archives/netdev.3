Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CFCCA6F;
	Thu, 23 Jul 2026 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784770348; cv=none; b=SHfhWDyY2y43EQ93JhdKHoNZVKZBCLHH390+zRuanENcN2JCWrzujh/zxkGfY0tbiPhJlEQsAQwba/81u98tMo/i2Zw2ff2Z8qlhc2Bw89nJ+FWmHnSAsikMaNbQK2Tx9TMB9Ekj1s0Z/50T0aKgD9gRfkGr5TCaIND7gvTOFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784770348; c=relaxed/simple;
	bh=TLlQNRXPLF+YxlPFDsSOgTJ+Ey5FA+B0UvbxDEajwhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBSRm2WWEr3KajHjkJP5gSelHxdQs+GWKt7M9XTkzDOd7dvjrUDvPh+SFfUAgyQ7CFwwmYruMlbP4w2K9rUPpYgJzcQff0jx0T/tDnylos/+YOCZ85zdQfUW56nM6eYU3fqmZPnGaM+ErLrA/Zf7ZA04c1BpRpxf3+hONi4eAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vK/zF+iA; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vK/zF+iA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=audvSCQc0QgHY2F+gHYSpR9XSwpj+q/gEJuyAmQScmU=;
	b=vK/zF+iA3uNyEQ1RIA8G538q/R05jmbVIJoPxOUV0Ove3jX32J3Dw/l02+E6wAb/QqiXNOBQV
	AJtnRwy3doidpxxLildyyQHAs2VzznNz0+8G9leeM8oUT5LpNMbrYUlHlFIMDa4+YlDdDn3p88N
	xUYi/P92gdedKMefF6jQ/cE=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h5Czj6jhJz1prQc;
	Thu, 23 Jul 2026 09:22:57 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D1B840575;
	Thu, 23 Jul 2026 09:32:23 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 09:32:21 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <mohsin.bashr@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<dimitri.daskalakis1@gmail.com>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <horms@kernel.org>,
	<hramamurthy@google.com>, <ioana.ciornei@nxp.com>, <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <maxime.chevallier@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <shijing34@huawei.com>,
	<tengpeisen@huawei.com>, <wudi234@huawei.com>, <wulike1@huawei.com>,
	<zhengjiezhen@h-partners.com>, <zhoushuai28@huawei.com>,
	<august.hewei@huawei.com>
Subject: Re: Re: [PATCH net-next v11 1/5] hinic3: Add ethtool queue ops
Date: Thu, 23 Jul 2026 09:32:19 +0800
Message-ID: <20260723013219.797-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <c4473a79-567a-430b-b463-f45d4ef3ea28@gmail.com>
References: <c4473a79-567a-430b-b463-f45d4ef3ea28@gmail.com>
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

> >    Implement following ethtool callback function:
> > .get_ringparam
> > .set_ringparam
> >
> >    These callbacks allow users to utilize ethtool for detailed
> > queue depth configuration and monitoring.
> >
> >    Change port_state_mutex to state_lock as a unified mutex lock
> > in hinic3_nic_dev.
> >
> >    Tightens the success criterion for hinic3_rx_fill_buffers() in
> > hinic3_configure_rxqs().
> >
> >    Changes hinic3_tx_csum()/hinic3_tx_offload() to propagate
> > skb_checksum_help() failures into a TX drop.
> >
> >    Renames hinic3_uninit_qps() to hinic3_get_cur_qps().
> >
> >    Splits hinic3_open_channel() into hinic3_prepare_channel() and
> > hinic3_open_channel().
> >
>
> It may just be me, but I feel like there is a lot going in this single
> patch. Ideally, a patch should carry one logical change. This patch is
> doing 3 things: refactor, new code, bug-fixing in the hinic3_close() path.

Thanks for the following 3 review comments. We are pushing new codes to the
net-next. However, fixing review comments leads to some refactoring and
bug-fixing codes.

We are considering split patch #1 into smaller ones in the next patchset.

> > @@ -330,6 +330,8 @@ static void hinic3_link_status_change(struct net_device *netdev,
> >   		netif_carrier_off(netdev);
> >   		netdev_dbg(netdev, "Link is down\n");
> >   	}
> > +
> > +	return;
>
> Unrelated?

Sorry for our negligence. We will remove this unrelated change in the next
patchset.

> > @@ -493,10 +580,15 @@ static int hinic3_close(struct net_device *netdev)
> >   		return 0;
> >   	}
> >
> > +	mutex_lock(&nic_dev->state_lock);
> >   	hinic3_vport_down(netdev);
> >   	hinic3_close_channel(netdev);
> > -	hinic3_uninit_qps(nic_dev, &qp_params);
> > -	hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_params);
> > +	hinic3_get_cur_qps(nic_dev, &qp_params);
> > +	hinic3_free_channel_resources(netdev, &qp_params,
> > +				      &nic_dev->q_params);
> > +	hinic3_free_nicio_res(nic_dev);
> > +	hinic3_destroy_num_qps(netdev);
>
> free_nicio_res(), and destroy_num_qps() looks like fixes to me on the
> clean-up path. Should these go to the net tree?

As mentioned above, we reckon it as a necessary fix to commit new codes, thus
we put it in this patch.
