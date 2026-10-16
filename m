Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3AD2367B8;
	Fri, 16 Oct 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151749; cv=none; b=F9zjQbLMh+EJBVo7VUIQtIafqThaWEqG29/BjgQ+/Ts4WJ7OzCOAMi0puG1kHPONcjSn+LS1MOmFnTUnbzV7EMBNsqx3zGAr94q1uryHRHZqwOLkR/Pl1bwdHZJtOl29TWyoApcGqhcEaFN0Y5h+5TOUEXGGvlQ9uqeX3zSaFQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151749; c=relaxed/simple;
	bh=sTjE/1pDOm+j09NslTMYhV2ZeMmM2D52Sspy+JXFLGc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dbg/FUPwSEet7pXyxseDBDAl6M4Y/SLqrANKjqNkUXURvampy4Al/W9dwjOk0F2HmUpUnUn1rWRsIn5fMaCI3IZaBXJIuaUQrS3BTtoICYmkxM5f7A0RQdaZ95V8152iyaz86NMqB41ZRBUj8YrPBYNjWHgbvReQVX88i5RUtFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XmpiS8YR; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XmpiS8YR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZWY4dE0y2jxNQCmQxVLWQprOmJdMDfCVLcT1J5dmddo=;
	b=XmpiS8YRDOfhmRVv641IUArjgEwvDIIn1N3sTvU4soSk8ej7n7bvYVh9g7+Q8aP81aitbvWF3
	Z+Qzai3jCUvZ+i1X/8/jew7QxgvQJE73H4eQYyMb9WqPHHnsqUU/48IKZ4ylnd46utF2ijOVDL0
	k4yoLSB9wVh/e8sG0YNlEOs=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j5jkJ0yZgz1prLV;
	Fri, 16 Oct 2026 19:43:20 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C1E14056E;
	Fri, 16 Oct 2026 19:55:41 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 16 Oct 2026 19:55:40 +0800
Message-ID: <637801e7-8b4d-449b-918d-a8f0ebb49664@huawei.com>
Date: Fri, 16 Oct 2026 19:55:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
	<shiyongbang@huawei.com>, <fengzheng6@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: hibmcge: set netdev_ops before hbg_init() to fix
 NULL pointer dereference
To: <netdev-bot+sinfo@kernel.org>
References: <20261016110421.2288670-1-shaojijie@huawei.com>
 <179214895481.408196.13202102373888090421@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <179214895481.408196.13202102373888090421@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/10/16 19:09, netdev-bot+sinfo@kernel.org wrote:
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
>
>   - What hardware the change was tested on. For driver fixes please
>     mention the device (and if relevant firmware version) used for
>     testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi, The issue was hit and verified on an evaluation board.

