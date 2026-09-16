Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85E4AA3F0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567161; cv=none; b=KHsehV0PFxLWhvq64K9HpLfxsoRrK4xNIeVHbHDqi8RHvUdq4jxKk3BlHQAcQeKiYQz/VamVOrOOMtKOJnpPpy4XeS1Tyxi9E5oalqvQMyy6APo864qmi6CVlaRV1cn40OsO5VsMLBgoeGsVKnar2G0HdakXfg98BOU7P3rrCGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567161; c=relaxed/simple;
	bh=VC5IBuiajF2UOyg9myfOQQMbSJv4I4e2oPbDYN5Vl/4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uCSuXZkH37LthbOdTf0i9c1fR152td8X0x4Ph53I8vdncGbjY/+dx/6zFcWzVt7q1t4ABRIIa4vUiooNoOFBSVbEaCnb/QPeZXenhvEPUSFJixGpWXSUMnznIw7hlsMOrUaDToGzZUntVyZcjzR/93Ws3HH/U2097mMOnubwd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=d4z6nC+T; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="d4z6nC+T"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pcC68NybRakIZlcxBZiw/O7eaOc4xkx+nwuKQ5TvmB4=;
	b=d4z6nC+TCzNWgeTtvstCoAEaMXit1rar3s+fC20MhsdvBtCCDnbXkvgNnawmn7Plr2vYaQ/fO
	yfLWDjfepNSMBpDtx2KH/Q9hbiFT5s8+6eCe8LQPvhVt6k8tfgYkx6iklLitPTrU5/u+uCdGkre
	JYgJZT5MmLhyj3771QGsKsk=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hlKvr1qMkzcb3G
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:47:52 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 08AB72017D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 21:59:04 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 16 Sep 2026 21:59:03 +0800
Message-ID: <6390cb74-6991-4da1-90da-31e8c9865e0d@huawei.com>
Date: Wed, 16 Sep 2026 21:58:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>
Subject: Re: [PATCH] net: hns3: fix comment typo in hclge_tm.c
To: Ruslan Vagner <rusya92266@gmail.com>, <netdev@vger.kernel.org>
References: <CAF9RqJ5CgjDJNnQT-AKgGfWgJssBGBhs+S_O444dtcg96-Uixg@mail.gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <CAF9RqJ5CgjDJNnQT-AKgGfWgJssBGBhs+S_O444dtcg96-Uixg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/9/15 20:55, Ruslan Vagner wrote:
> Fix the spelling in comments. No functional change.
>
> Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> index 00c3f2548bf6..bf533b8f46ae 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
> @@ -35,7 +35,7 @@ enum hclge_shaper_level {
>    * IR(Mbps) = -------------------------  *  CLOCK(1000Mbps)
>    *		Tick * (2 ^ IR_s)
>    *
> - * @return: 0: calculate sucessful, negative: fail
> + * @return: 0: calculate successful, negative: fail


Hi Ruslan,

Thanks for your patch.

However, it seems this is a duplicate effort.
These typos in the hisilicon driver comments have already been fixed and merged by Hemanth Selam.

You can find Hemanth's merged patch here:
https://lore.kernel.org/all/20260908052602.27497-9-hemanth.selam@gmail.com/

Thanks,
Jijie Shao



