Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BCE13B293;
	Wed,  5 Aug 2026 02:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896149; cv=none; b=rnak+X2uyVbTb8t+F50KNSNUM2toggdQJG61V+Cw1bSKi1RX0zLIpfuTBO+pVC4CzvKpPTK3N/T+sf9NzDNTl6kfSY+zQhWXOmjbjuVYMpvMLMoQRT3t72LrE19gK9dYvmwAVNPcIBR3wcZrpJJL8ituvgwnCApSFft69cDQQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896149; c=relaxed/simple;
	bh=EvmAidhAh1BmCZc0K6oW1sZ1tSXWht1+EZFkPDs9Pmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/jfC0U4bLgC2K099cUSARPTKJ6K0lZmbmwjS0nfRRWTTpRQSQPDKxV2I4kXZe1nZ5QBfJ0qowu0pPdNlUemFsGX58slF/t1KXKuU/VzNA31XpQ9RSnJvAvbVSbwu87bnquUvO4QpADkAJB8YcswRt5Ybm1BaxWObYGDZxvA2vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Axy4gkCF; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Axy4gkCF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EvmAidhAh1BmCZc0K6oW1sZ1tSXWht1+EZFkPDs9Pmw=;
	b=Axy4gkCFYWwhAWovzNyCpDvE5BOk8AC3kxpokj0kg5R+UiEFiEhUz8HUXDjMGJ+IFTM6+xyE3
	+fH8FWqe5e33N9sQvFYuqUzMXXtddqTA08P3RCpb8TQvLZiiSbhZSb+xtk794Z6mrgBnMK+aIvm
	YGu3A5g8ntBdXHUG9WhjVYc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hFDKb1b4VzRhWV;
	Wed,  5 Aug 2026 10:06:11 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 08E8140561;
	Wed,  5 Aug 2026 10:15:41 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 5 Aug 2026 10:15:39 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <larysa.zaremba@intel.com>
CC: <andrew+netdev@lunn.ch>, <august.hewei@huawei.com>,
	<chenanwen@huawei.com>, <davem@davemloft.net>,
	<dimitri.daskalakis1@gmail.com>, <edumazet@google.com>,
	<gongfan1@huawei.com>, <guoxin09@huawei.com>, <horms@kernel.org>,
	<hramamurthy@google.com>, <ioana.ciornei@nxp.com>, <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <maxime.chevallier@bootlin.com>,
	<mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shijing34@huawei.com>, <tengpeisen@huawei.com>, <wudi234@huawei.com>,
	<wulike1@huawei.com>, <zhengjiezhen@h-partners.com>, <zhoushuai28@huawei.com>
Subject: Re: Re: [PATCH net-next v12 1/8] hinic3: Fix drop skb when skb_checksum_help() fails
Date: Wed, 5 Aug 2026 10:15:36 +0800
Message-ID: <20260805021537.1986-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <ams16FJUl0Oo-qC5@soc-5CG4396X81.clients.intel.com>
References: <ams16FJUl0Oo-qC5@soc-5CG4396X81.clients.intel.com>
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

> Regarding patch 1/8 and 2/8 in this series. A change either fixes a bug or it
> does not. If it does, the patch must go the net tree and contain a Fixes: tag.
> If it is a prerequisite for your -next series, you need the fixes to be merged
> first (but it's usually not that long). If you are rather sure that the code
> inconsistency that you are correcting does not have any real negative impact
> (e.g. failure is only for features not supported by the netdev), it can go in a
> normal -next patch series, but it's best to explain, why it has no real
> functional impact and avoid using the word "fix", otherwise both humans and AIs
> can get confused.

Thanks for the feedback. You are right, these are actual fixes. We will split
 them into a separate submission targeting the net tree, add the Fixes: tags,
 and refine the commit logs based on your suggestions.
