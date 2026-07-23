Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB32FE56A;
	Thu, 23 Jul 2026 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784770516; cv=none; b=b0k1kEKNpYCHQKWAaJRxjHZdQpYHNe+NX26FrfV377TRmXCCyoBShT7PqnfminiFg5tGiq6hDRURiSspyX2vkQWpHbhyoWV5eXzsHFqdJbireEiDia7cEozXzK81AnUql1BPzGuvtx63WQozQLe3tj1o52Ro94AEhBWVUvXw6kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784770516; c=relaxed/simple;
	bh=z32hagR2pVPlVHDHTbgPYqfmURH9DLxxHRPNzM5uiKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbwD0Gs3brHY4lsDIcimRFPs2qMcIOwiFWB+7WzZlGvU+wqFnZrlO/W4P250V6jIQJ072JBAMjWL51l5V+FxcvpIVtytOHCwqB0hyLytF4ia7bxQh4QONXrHrb5YDyQyg0VIObwCoru5E8jiG/SsF/tMkUQ0E+7cnthK1Q7SjCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6KtTOTVY; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6KtTOTVY"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m88/wnZi2HmmBU7oTkKzrqmiE0MyVz66T+UUEEQ8B5Y=;
	b=6KtTOTVYXoiIYB0ugSPI5T+TkUscciClBFGVtdWNlNe0ddJCWhfGx/OYzDQI9ZuEAaL8GsGXD
	TdWHv0xgxEetmKliviYWpmGOXAVATu0QKw31Az0LtuXTYtu/elKR1vmRQy7Gxg+rJAF1BvL+vs7
	UDBjiFdDn3v/LvI5PPjZ4VY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h5D2m4mnQzcb0T;
	Thu, 23 Jul 2026 09:25:36 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id A4A7B2025F;
	Thu, 23 Jul 2026 09:35:06 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 23 Jul 2026 09:35:05 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <dimitri.daskalakis1@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <horms@kernel.org>,
	<hramamurthy@google.com>, <ioana.ciornei@nxp.com>, <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <maxime.chevallier@bootlin.com>,
	<mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shijing34@huawei.com>, <tengpeisen@huawei.com>, <wudi234@huawei.com>,
	<wulike1@huawei.com>, <zhengjiezhen@h-partners.com>,
	<zhoushuai28@huawei.com>, <august.hewei@huawei.com>
Subject: Re: Re: [PATCH net-next v11 2/5] hinic3: Add ethtool statistic ops
Date: Thu, 23 Jul 2026 09:35:02 +0800
Message-ID: <20260723013502.828-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <190879f9-2447-449d-acf8-9f9e26651b24@gmail.com>
References: <190879f9-2447-449d-acf8-9f9e26651b24@gmail.com>
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

> > +
> > +static u64 get_val_of_ptr(u32 size, const void *ptr)
> > +{
> > +	u64 ret = size == sizeof(u64) ? *(u64 *)ptr :
> > +		  size == sizeof(u32) ? *(u32 *)ptr :
> > +		  size == sizeof(u16) ? *(u16 *)ptr :
> > +		  *(u8 *)ptr;
> > +
> > +	return ret;
> > +}
> Why is this needed? It looks like all the counters in
> hinic3_rx_queue_stats, hinic3_tx_queue_stats, and hinic3_port_stats are
> u64.

Thanks for the review. We will remove it in the next patchset.
