Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B23815C3;
	Tue, 24 Feb 2026 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940607; cv=none; b=l+DXgojXSX6sLYVI4mn5JeikHFmzKPxL77KoDUTneCSmnaVIzqur1NCuso5spg2k2OHSEpSZPWpsOnl9nETkNtJ4lJICFbMLeNLG81CHVnun0jJ55tYJ+/D7YudpiHKha/GEDXX4Yu1+pKxvjnGrhjQc/tgZaqsMBn/4mFepd7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940607; c=relaxed/simple;
	bh=Jpj7Oorc5cxJiadctBj9x+AGBJR8mkNSvyFDCxax/xg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXoH7D4ueKLeGfSAIvWeiBdUW3lStjp5SQKRpK5OGx+z6icLrMJi5q0VlsxUppQ5CaxhwpmSC1dzn5LDU60DI7uyMgDGbTfoIMps2Td2/70QEsVjw8+Pgt0YpbJ/HEeXcBPm0ZrHpxgG1Zngzbu8Uv90QXuQiZ4dVpT59e7lK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=C8ne0Clc; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="C8ne0Clc"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Jpj7Oorc5cxJiadctBj9x+AGBJR8mkNSvyFDCxax/xg=;
	b=C8ne0ClcyM0IRyAyTn5cpoyGVHI7+4mZl4N7BpNQLCcSI63n44CmW913hSkWboY7ruv4J3m2w
	3qBAjIkR0+CaMCNyG/MF+IBAtreyjYKY4eaN1NpkVkVUEm92M73Za24S8Ep85ocK0G15BDDiEmR
	8NY/QNxXKayEPD9M/RlOz1Q=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fKzMH3PQgzpSv4;
	Tue, 24 Feb 2026 21:38:35 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EE3B4056B;
	Tue, 24 Feb 2026 21:43:21 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 24 Feb 2026 21:43:20 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <gongfan1@huawei.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<guoxin09@huawei.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shijing34@huawei.com>, <wulike1@huawei.com>, <zhoushuai28@huawei.com>,
	<zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v01 00/15] net: hinic3: Fix code styles
Date: Tue, 24 Feb 2026 21:43:15 +0800
Message-ID: <20260224134315.1735-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1771916043.git.zhuyikai1@h-partners.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)

On 2/24/2026 9:15 PM, Fan Gong wrote:
> This patchset provides 4 code styles fixes:
>
> Remove empty lines between error handling.
> Remove defensive txq_num check.
> Use array_size instead of multiplying.
> SQ use SQ_CTXT_PREF_CI_HI to improve readability.
>
> Changes:
>
> PATCH V01: https://lore.kernel.org/netdev/cover.1768915707.git.zhuyikai1@h-partners.com/
>
> PATCH V02: https://lore.kernel.org/netdev/cover.1769142701.git.zhuyikai1@h-partners.com/
> * Send "Fix netif_queue_set_napi queue_index parameter passing error" to net (Jakub Kicinski)
>
> PATCH V03:
> * Modify commit description to be more accurate and clear (Simon Horman)

Sorry for forgetting to replace cover letter to a newer one.
We will send the next version with correct cover letter and commit contexts, and refer to
possible AI review for revisions after 24 hours.

Thanks,
Fan Gong
