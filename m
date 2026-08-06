Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB838736E;
	Thu,  6 Aug 2026 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002509; cv=none; b=MBRVHxNxibt9sYy6GzhBFWhrcIQiXstQ23ElHDrHGcCDRY9QbYgxuNVkzoRkM5QBvqWxbnmGMFAjN6xp9QyPquWTGxZRJpYqAxQqIAlf3WZHfZmufJhZsuxlAa5sbJPRnthHKAtrBKyRJZzwA3H7jKJzr1OltkewxGBVi1RfU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002509; c=relaxed/simple;
	bh=TwcU0Egi7vXQakspJv7HxpudrnlY7U9GjQOPASyLkFQ=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nb0WX73elvZAUYB+61bA0YxSqBqN1754SPsFskAjebk9jDh2rRKvu/2YtEFwZvfdDvxdZ2qs6bK1ItSz3vezXVi2vD1/Fj2N4TVsIzyQFnGjYmPRNGNpaDi7vs8x8ws+HDi2ZCHdlSiyYl0/2bMeR1HyFMdlVbJze37cB11o7ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Z0CYq7UQ; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Z0CYq7UQ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=aNQ1h3B+Ksb0D0UHY6nzvws/vqmWAkNtmD/2I4Xd4uQ=;
	b=Z0CYq7UQVGdyirbL9PrFXA1IdUNieVqlrt+0EWNuYaAbx9OZgJgDaXozkk4P4yhWMmfYlRNcN
	6JkEt2bgslEdJiTtHy8s12wZcbiML99rYLfR8ha1cQ+RUjnZ7NJLVWt0+MLbJuAhE85vDhpHsKa
	8pbKuH0E7F6a2maaA02Exjg=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hFzfx22QVzmV98;
	Thu,  6 Aug 2026 15:38:49 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 642B04057C;
	Thu,  6 Aug 2026 15:48:21 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 15:48:20 +0800
Message-ID: <b632384f-7de3-4411-890f-3b4e148f0de1@huawei.com>
Date: Thu, 6 Aug 2026 15:48:20 +0800
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
Subject: Re: [PATCH net-next 2/3] net: hns3: add missing const qualifier to
 hclge_log_error() reg parameter
To: Simon Horman <horms@kernel.org>
References: <20260804130933.880552-3-shaojijie@huawei.com>
 <20260805165229.606837-1-horms@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260805165229.606837-1-horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/8/6 0:52, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804130933.880552-2-shaojijie@huawei.com?part=2
> ---
> --- Patch [2]: [PATCH net-next 2/3] net: hns3: add missing const qualifier to hclge_log_error() reg parameter ---
> commit c77e6cbb6d302d584ade8cd89a76f4750fe00694
> Author: Jijie Shao <shaojijie@huawei.com>
>
> net: hns3: add missing const qualifier to hclge_log_error() reg parameter
>
> This adds a const qualifier to the reg parameter of hclge_log_error() in
> the hns3 PF error handling code. The parameter is only read inside the
> function, so the change itself is a straightforward const-correctness
> cleanup.
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
>> index 7e124e2c718da..6093a60d257b1 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
>> @@ -1762,7 +1762,7 @@ static const struct hclge_hw_type_id hclge_hw_type_id_st[] = {
>>   	},
>>   };
>>   
>> -static void hclge_log_error(struct device *dev, char *reg,
>> +static void hclge_log_error(struct device *dev, const char *reg,
>>   			    const struct hclge_hw_error *err,
>>   			    u32 err_sts, unsigned long *reset_requests)
>>   {
> [Severity: Low]
> [Finding: main-1-0]
> [Sources: opus-5]
> This isn't a bug in the code, but is the justification in the changelog
> accurate?  The commit message says:
>
>      Callers pass const strings, causing a compiler warning about
>      discarding the 'const' qualifier.
>
> hclge_log_error() is static, and every call site is in hclge_err.c.  They
> all pass a bare string literal, for example in hclge_handle_mpf_ras_error():
>
>      hclge_log_error(dev, "IMP_TCM_ECC_INT_STS",
>                      &hclge_imp_tcm_ecc_int[0], status,
>                      &ae_dev->hw_err_reset_req);
>
> and similarly for "SSU_ECC_MULTI_BIT_INT_0" and the remaining register
> names down to "PPU_PF_ABNORMAL_INT_ST" in the MSI-X handlers.
>
> In C a string literal has type char[N] rather than const char[N], so
> passing one to a char *reg parameter does not discard a qualifier, and the
> kernel build does not enable -Wwrite-strings.  None of the call sites pass
> a value held in a const char * lvalue (such as
> struct hclge_mod_reg_info::reg_name), which is the case that would produce
> the described diagnostic.
>
> Could the changelog be reworded to describe this as a const-correctness
> cleanup instead of a build warning fix?  As written it suggests a broken
> build and reads like a stable backport candidate.

The warning is real in our internal build, which enables
-Wwrite-strings. Would it be acceptable to keep the commit message
as-is, or should I reword it to const-correctness cleanup and note
the internal build context in the changelog?

This series is cleanup, not bugfix — no Fixes: tags, not intended for stable.

Thanks,
Jijie Shao


