Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7343DC4CD;
	Tue,  2 Jun 2026 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780403036; cv=none; b=DUd2t2nIU28Jn1b1Qg0bfAt8ZN/ejwJTB+M2w0ZpQMbQ/+jWsCPb6auvD+2hrqaT7zU3w005cQCp0DMvHLZ3X0JQm6KIxwU/nO68YeHug8oNmJVCJqE/TrHv9zL7GVEyv9V1QB2H/5yrRpmA8MCyzkVQ34UHHVXhPAEfZsXrBok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780403036; c=relaxed/simple;
	bh=uvYQRvn0koVa3714BC7WrIY5vPTTHKciC2aF0uDWm5M=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fEe/ssHdg84AyFPfAQSMi90ZUDXysilp3Da1wm3bhWR3raz3R32U3B0uvwVHokoTO5RtCFmzMqckPzuHVY9/U0iK60YK+pA92R3+3Beseqd/eW/dWMNZ3pLRwBqdeJWA3A/J4FKevbzMjSqLIgksJhnb8O7c91PYzwov0o0Yrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1Z5FCDuh; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1Z5FCDuh"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1ddtsQxECmx9KGDpzRgapSEpQS/LBWrUlZCqDyezqHY=;
	b=1Z5FCDuh+jjJW0VdtItzdPLoWkKyWF62A/e5Q+c4JkBvGqsAxviAQ8CrVP4H3JGOxpprmepWp
	uOov75MitMJ0Xt8BoyEjgbCIc5CcemvcVKeo3jTktntSw00aDxO5hrQxL9XQlcx2juaP8//nKbG
	zqNVhOMecYURXxIuGk11Kzg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gV8td4NkRz1prL9;
	Tue,  2 Jun 2026 20:15:53 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 846A84048F;
	Tue,  2 Jun 2026 20:23:45 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 2 Jun 2026 20:23:44 +0800
Message-ID: <2a075720-f3cd-4b12-8048-8ead10c40322@huawei.com>
Date: Tue, 2 Jun 2026 20:23:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Paolo Abeni <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 0/6] net: hns3: enhance tc flow offload
 support
To: Simon Horman <horms@kernel.org>
References: <20260523105449.661848-1-shaojijie@huawei.com>
 <20260527095930.GI2256768@horms.kernel.org>
 <c6dc79ef-5f6e-4c97-97da-fa50eb1d1370@huawei.com>
 <b0b0ac82-bcbf-4aef-bf6f-7340f9517fc6@redhat.com>
 <83f34836-c848-469a-9c1c-7f28bf3035fc@huawei.com>
 <20260529093448.GV2256768@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260529093448.GV2256768@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2026/5/29 17:34, Simon Horman wrote:
> On Thu, May 28, 2026 at 07:24:28PM +0800, Jijie Shao wrote:
>> on 2026/5/28 17:06, Paolo Abeni wrote:
>>> On 5/27/26 3:12 PM, Jijie Shao wrote:
>>>> on 2026/5/27 17:59, Simon Horman wrote:
>>>>> On Sat, May 23, 2026 at 06:54:43PM +0800, Jijie Shao wrote:
> ...
>
>>>>> Hi Juijie,
>>>>>
>>>>> There are AI-generated reviews of this patch-set available at
>>>>> https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/
>>>> Hi,
>>>>
>>>> I'm sorry, I don't understand how to use https://netdev-ai.bots.linux.dev/, it seems to require an API Token?
>>>> I find it difficult to locate my own patch-set in Recent Reviews.
>>> The nipa sashiko instance has the same web UI as sashiko.dev. The full
>>> URL for the former is:
>>>
>>> https://netdev-ai.bots.linux.dev/sashiko/
>>>
>>> You can lookup your series by the cover letter title or you can use the
>>> direct link including the msg id for the cover:
>>>
>>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260523105449.661848-1-shaojijie%40huawei.com
>> Thanks,
>>
>> It appears that the two URLs mentioned by Simon Horman are the results of the one AI-generated reviews.
> Hi,
>
> Firstly sorry for truncating the netdev-ai URL, that was not my intention.
> Secondly, let me explain the relationship between the AI-generated review
> on netdev-ai and sashiko.dev.
>
> Both use the same underlying review engine - Sashiko [1].  But they are
> using different AI models to run the review.  And I believe that the
> prompts also differ a little.  Overall, netdev-ai, has been tuned for the
> Netdev review process.  While sashiko.dev is more general.
>
> My observation is that netdev-ai tends to flag things relevant to the
> Netdev development process that may be skipped by sashiko.dev. While
> sashiko.dev has a tendency to report pre-existing issues that are not
> strictly related to the topic of the patch under review.
>
> But, as the underling engine is the same there is also a lot of overlap in
> the output produced by these two instances. And in some cases both
> instances flag all of the same issues.
>
> [1] https://github.com/sashiko-dev/sashiko


Thank you for your detailed introduction.
In the future, I will proactively check the AI review issues.

Thanks,
Jijie Shao



