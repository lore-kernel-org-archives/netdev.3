Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812CD3F0761;
	Tue, 20 Jan 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919267; cv=none; b=JLmQaHaBwNQpyMxfn0iQFZXZGy1GwoZhBmEyjahINEdFIZXy10jKLjZtlIyWnbrJoi1n1BpWG8Lnem5gVRgTb6y5mc9x6j1fYhLtrqxz9rYnXzQvVtIhSy3EN+4zQV+585Sn3qzzpyYNI3U9eZVEsmwGeVpeFssVzWvcw3aVAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919267; c=relaxed/simple;
	bh=/kaZD482ztKQm6dva7sKhb5SOm2P7we2cLRb7wcmsYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpoqYu0qJt1/zMZIav08sJPHZF4ip+tpblfc0Gy23ePhNwWiu2INT7Whba9NuwJVF2Gd/4eOOgweJs++pfHe/Dm5KXIUle4okI5CpbXeZT1zDoNQDUC7LmX3CiGFZ8weJziCB6Hi8vfLmsoLeV/Sas/0GD7QNgDSSl2xagxQgdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FwJ3VUnw; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FwJ3VUnw"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/kaZD482ztKQm6dva7sKhb5SOm2P7we2cLRb7wcmsYQ=;
	b=FwJ3VUnwAMSBF/yZRa72dz9865AHeS8YbWLSNbjkRhnZYTg8iIaG6QS473HgZ+2n+gfCVUBV5
	meufbt+6dQVyyJUMWncC/nU6NpAL+ca/ncsaVIkwttNOpBefmKfcMwN2Y3ZFSmPyNqlpEZFkWqj
	TLD0BreDj9P3+e/0G73RdT0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dwV1X1SGNzcb0S;
	Tue, 20 Jan 2026 22:23:44 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id F2F3A404AD;
	Tue, 20 Jan 2026 22:27:39 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 20 Jan 2026 22:27:38 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <gongfan1@huawei.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<guoxin09@huawei.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<luosifu@huawei.com>, <luoyang82@h-partners.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <shijing34@huawei.com>, <wulike1@huawei.com>,
	<zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net v01 0/5] net: hinic3: Fix netif_queue_set_napi input parameters and code styles
Date: Tue, 20 Jan 2026 22:27:34 +0800
Message-ID: <20260120142734.1000-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1768911232.git.zhuyikai1@h-partners.com>
References: <cover.1768911232.git.zhuyikai1@h-partners.com>
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

Sorry for choosing the wrong branch. We should send to net-next instead of net.
We'll send a new patchset to net-next soon.

Thanks,
Fan gong
