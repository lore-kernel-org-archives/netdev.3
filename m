Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5871B25B2F4;
	Thu,  6 Aug 2026 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001560; cv=none; b=Y/znJIluizITJDEbOHIr0LvBAvYrENz1BoB0Lv/xTrD+UsbZ5qKMjKRK5IOHYxbazWn9sqxZxZDczJu+de7xRg5wOBxWjzKAgUkegdwiaMOIHjUPZiDM5ihng7AoCRfjsx3VjC/BvYJ6HSkW3YDtQZEqPLFypEvBsMM4wp+5cFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001560; c=relaxed/simple;
	bh=gONC+HIOiePNaTQfkeKU9E1qMT6zshkGo5T7wKov/oY=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BPnFkt47sX8SOl3HEc33Yk2+4H4gLiA/i8gb8oTmRTqBmjkDAYyD+7kTCq8t7FYmvhqgof2/4QdU9v9XCEti0St6tJO8QFMe5Dt6XvkLoXBuLR+6OsgpKLfxOKXpRI8WjeL3Fzcmf8lXfsTZgwsS/vFuTq20iBrZRcNJeIpC/e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=B5S76X2k; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="B5S76X2k"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ElIRU49dUfPDtiRnaKh0n+6c/DDnee/pnb2lBpOcJaQ=;
	b=B5S76X2keiavoat06hWvpJ/3tm8eyxH1Aa2IVPl3lEIEl5y6wxLcgaUwAarPhpUs8wMxJBhXs
	Sv2fdTxUEUOox4M75zh/TUoPsaLwdZqpElZo5ix9PFkvo9smyOtlOA8cg7F+x1QfEIvrcsfqYvW
	tkSp8HYxy2Z6XySmi01piw0=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hFzHV6Fs0znTVd;
	Thu,  6 Aug 2026 15:21:58 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id D28A54056C;
	Thu,  6 Aug 2026 15:32:24 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 15:32:24 +0800
Message-ID: <241a437e-bffb-4454-b9cd-f067e673922a@huawei.com>
Date: Thu, 6 Aug 2026 15:32:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: hns3: set msg->desc to NULL after kfree
 in hclge_query_reg_info()
To: Simon Horman <horms@kernel.org>
References: <20260804130933.880552-2-shaojijie@huawei.com>
 <20260805165214.606778-1-horms@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260805165214.606778-1-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/8/6 0:52, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804130933.880552-2-shaojijie@huawei.com?part=1
> ---
> --- Patch [1]: [PATCH net-next 1/3] net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info() ---
> commit ba3e282274aa0911fb278f48937385c06cc8f3a1
> Author: Jian Shen <shenjian15@huawei.com>
>
> net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()
>
> This adds msg->desc = NULL after the kfree(msg->desc) at the end of
> hclge_query_reg_info() in the hns3 PF error handling code, described as
> avoiding a dangling pointer in a struct that the caller reuses.
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
>> index dac051e798da2..7e124e2c718da 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
>> @@ -1592,6 +1592,7 @@ hclge_query_reg_info(struct hclge_dev *hdev,
>>   	}
>>   
>>   	kfree(msg->desc);
>> +	msg->desc = NULL;
> [Severity: Low]
> [Finding: main-1-0]
> [Sources: opus-5]
> Is the commit message description accurate here?  It says:
>
>      In hclge_query_reg_info(), msg->desc is freed by kfree(), but the
>      caller continues to use msg across loop iterations. Set msg->desc
>      to NULL to avoid leaving a dangling pointer in the reused struct.
>
> The only caller is hclge_query_reg_info_of_ssu(), and it re-initializes the
> whole stack struct from the static template at the top of every iteration:
>
> 	for (i = 0; i < num; i++) {
> 		msg = hclge_ssu_reg_common_msg[i];
> 		...
> 		hclge_query_reg_info(hdev, &msg, loop_time, loop_para);
> 	}
>
> None of the hclge_ssu_reg_common_msg[] entries initialize .desc, so msg.desc
> is NULL again on each pass.
>
> Even without that, hclge_query_reg_info() overwrites msg->desc before any
> read of it:
>
> 	msg->desc = kzalloc(desc_len, GFP_KERNEL);
> 	if (!msg->desc) {
> 		...
> 		return;
> 	}
>
> so the freed pointer is never dereferenced or freed a second time.
>
> Would it be worth rewording the message to describe this as defensive
> cleanup rather than a dangling pointer fix, so a stable backporter does not
> read it as a use-after-free fix?  The patch correctly carries no Fixes: tag.

Keeping the message. kfree'd pointer is factually dangling; the patch
is defensive. No Fixes: tag already signals it's not a UAF fix.

Thanks,
Jijie Shao

