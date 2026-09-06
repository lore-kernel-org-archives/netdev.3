Received: from out28-97.mail.aliyun.com (out28-97.mail.aliyun.com [115.124.28.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759CC1D47AC;
	Sun,  6 Sep 2026 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659808; cv=none; b=Hka5+uPlqARlrx8e3wlkvh0A+laphQgg3V+482RED0ybG+IKsMWL678GFdmL0TTHGQoJazCBg/4aQLVDyw+1neXvSI7/6P1keiWfRUopsxKvXKj8XQbURpIy6NMgozF3fZ6TSl/RORp/w8/7MLa2nfHNqQMjRAL0PvJ2SHkrw0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659808; c=relaxed/simple;
	bh=wiSwQfSIjKOB2hqNhCrutvYDEwrj7Iws4WuI3+tPA4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoxA2S7P3i1Q2dcvULdChsEPtHcsDuxQUo3cIVkFIYxpC/zGhdvtNeRSe73hyzVJkzkBQcDO+5niScHNaANTPRwE7kpdDxIKddpR/e36XEhJ0yjKodHoF46vswkqmurncnIuYEnsqeLoLV65E6dWXC6J8SfVG0pQPpcmQsKkt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1206527|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0489753-0.00248541-0.948539;FP=3995317364406007121|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j6hIqeq_1788659794;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j6hIqeq_1788659794 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 09:56:36 +0800
Message-ID: <dced7069-6b74-42c5-b604-d0418702a90f@motor-comm.com>
Date: Sun, 6 Sep 2026 09:56:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 3/6] net: dsa: motorcomm: relocate MIB polling
 initialization to dsa_setup()
To: Andrew Lunn <andrew@lunn.ch>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <20260904095416.1692962-3-kyle.switch@motor-comm.com>
 <67c8bdef-cf57-4233-a552-ad715f24c47e@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <67c8bdef-cf57-4233-a552-ad715f24c47e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/4/26 21:37, Andrew Lunn wrote:
> On Fri, Sep 04, 2026 at 05:54:13PM +0800, Kyle Switch wrote:
>> Move MIB polling start from probe() to dsa_setup() so that it can
>> be conditionally enabled based on the actual switch family support,
>> avoiding attempts to enable it on unsupported switch families.
>>
>> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> Much better.
>
> I would word the commit message slightly differently, in order to make
> it clear what this patch does vs a future patch.
>
>    > Move MIB polling start from probe() to dsa_setup() so that in a
>    > future patch it can be conditionally enabled based on the actual
>    > switch family support, avoiding attempts to enable it on
>    > unsupported switch families.
>
> What you want to avoid is my asking, did you forget to make it
> conditional?

Ans: okay,we will improve the commit message and keep this

in mind for future patch submissions.

>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>      Andrew
