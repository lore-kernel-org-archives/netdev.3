Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86503C1F45;
	Wed,  5 Aug 2026 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897073; cv=none; b=Qt+uReXFm/7DDImQo7Cjb12csg0gpKs0dRNJEMWIuFuDKZiCZWcjQ6trsDMwrsNDJE0SnyWrUULMYstXlc5H/fczuI9bh4wtE42WnfuhFslarddZvSDxnkCtiwCaWXEAWukL2S9+VBUA8cXomMQVIVaUlli11e51UG2LnbOZakM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897073; c=relaxed/simple;
	bh=DIr2Q04lO8c7g5YifszBX/tgpihSNW2RkZlQuLJQbaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aX4tuhcJc3j1AAhz84W0wXhHJxX781E1fPZ+LjbJVL26zKtx6JwTnVxc+c8Fb3Vrbw2keXrN2dID4HRyjYAJVemh6Dc+wdgDtRAVE1gL6/WDzlxYHR4gVxc2vcatCb4n5brSHuH2Qo45nwQA8DYSqyNWnZpOBlOLQdlHok/BMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MIW9R9Ro; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MIW9R9Ro"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=DIr2Q04lO8c7g5YifszBX/tgpihSNW2RkZlQuLJQbaE=;
	b=MIW9R9RoQtNs6HtlH8+86sD/BsdftwDHxgRE/Ju1UOKnErGjslFzc4ApY7vYh1wwj1jI+vdon
	VHcpdFJQ2NIbuxltNxPpgD+YSBKR3kANi/3vb9X3k+YI+h3kcQxb5PEQgFb9RKyQhpFe6zGtWQG
	wbm13UUB2Ew8cIuCK0b9Zmg=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4hFDgB5BP7z1T4LH;
	Wed,  5 Aug 2026 10:21:26 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id BD13E2025F;
	Wed,  5 Aug 2026 10:31:06 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 5 Aug 2026 10:31:05 +0800
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
Subject: Re: Re: [PATCH net-next v12 1/8] hinic3: Fix drop skb when
Date: Wed, 5 Aug 2026 10:30:55 +0800
Message-ID: <20260805023055.2188-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260803230745.2291141-2-kuba@kernel.org>
References: <20260803230745.2291141-2-kuba@kernel.org>
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

> This is an AI-generated review of your patch. Larysa is right, this patch
> looks like a fix. And there seems to be more bugs in the csum handling
> according to AI.

Thanks for the review. We will drop this patch from the current series and
submit it separately to the net tree as a bug fix. We will also revise the
commit message according to your feedback.
