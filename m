Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769ED345EAF
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150770; cv=none; b=jUoEr9BzGEzekvECGhLzat4elic+YgCeKENy36NwhvSR0+qLBm2qXtGC2UltBqEt0BCntMuvOORTmnfDw+W95R38iwP0RX0IPsoHOjHFLHOSDTSfo79ZIywx2taEGuiC3TLOpWieulWZJ+eb+qR/7Tog/9jjn8nRC6PKawZdhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150770; c=relaxed/simple;
	bh=RhYEY+bk9hTDqj+0+sCeAfwxUbdlzD76D1Uo+uG3VmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEdvXOmyYzmVss0QzWEsIPPr0xinCzVvYyAuLgktbW8gq5XCjr/QIVNm62D2/AzNak8e/021SR7/+sQNsBoFX4vTGJY7HJ9d/+QDDTSFT+Q5MztY2s0ANBJFuYGl3V7eSMP1E1/jEf5Cv3rtzbzKkxDYxmLKSxsGfaHSuk+Vn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=BVc0cqO2; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="BVc0cqO2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RhYEY+bk9hTDqj+0+sCeAfwxUbdlzD76D1Uo+uG3VmU=;
	b=BVc0cqO2L/0ytgdzH/mZ9KOLvq4sLbKkmwc+GmccF85ueBQoPgkEVoTZca+AN5eQxYqxQuVRd
	ihhfBwRM1udDZZ52/0Pmgs+8A2fHIAKPufHKQ/0f6q0n8xue1qwXMazdkoSMzBffLlZxeJJP00D
	fZWML2Cu9WrbQnKmRz+VW5Y=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hqTkG24jSzmV7C
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:53:58 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id CD98D4056A
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:06:02 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 23 Sep 2026 16:06:02 +0800
From: Fan Gong <gongfan1@huawei.com>
To: <csh0052@gmail.com>
CC: <gongfan1@huawei.com>, <lcy8047@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] hinic3: handle auxiliary device ID allocation failure
Date: Wed, 23 Sep 2026 16:05:56 +0800
Message-ID: <20260923080557.1752-1-gongfan1@huawei.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <179001656835.91284.3719235813225229273.idr-bug-81@gmail.com>
References: <179001656835.91284.3719235813225229273.idr-bug-81@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)

> hinic3_init_hwdev() stores the result of hinic3_adev_idx_alloc() in=0D
> hwdev->dev_id without checking for an error. If ID allocation fails but=0D
> the remaining initialization succeeds, hinic3_add_one_adev() uses the=0D
> negative error code as the auxiliary device ID instead of a reserved ID.=
=0D
> =0D
> Return the allocation error before initializing the hardware. Add an=0D
> unwind label that clears pci_adapter->hwdev and frees the allocation=0D
> without attempting to release an ID that was never allocated.=0D
> =0D
> Fixes: 8133788d023f ("hinic3: Nic_io initialization")=0D
> Reported-by: Changyul Lee <lcy8047@gmail.com>=0D
> Assisted-by: LLM=0D
> Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>=0D
> ---=0D
> Found during source review at mainline=0D
> 5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchange=
d=0D
> at f0100363d8c374bd8e9ea7c9ba02744f0b802ca4.=0D
> =0D
> The modified hinic3_hwdev.o compiled with x86 allmodconfig and W=3D1.=0D
> I have not tested this on hinic3 hardware or injected ID allocation=0D
> failures.=0D
=0D
Thank you for your contribution! We will test this patch later.=
