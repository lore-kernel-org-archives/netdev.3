Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E942CAF6;
	Mon,  7 Sep 2026 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788768362; cv=none; b=iV1oYv9xhluYfEEsUnpOvIJrcICJHrdclb+QkMrBs0/ozwSnwbcufJyNPVXGTA5c3tlRTyDMdnm8Y65nVZTowDIgC4woAQJDtSniWmxLLE7pXJXIJrmr4OddX/Y6q2h0+mk0E8QeGij4kRFe1Z1NXMgMqzMioCeniXvXdcB7OtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788768362; c=relaxed/simple;
	bh=8w48dTQb3RhyDHJ7Jct7hUycV7Z3Zn1TcYs2qu9l1iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a3YI6qtcBkn4/k/BfeyRU5zgC3soBRS6DVjRtO+d3FZ/FnYZKE+R1M+8JDgSlbPgqNWSxTMpdEJd3b+n+GMYfZX0hbU7ZVmZUP5TycZh91RgM2dpAG8+mqjox1udE8R9dDTtMgi1fHysY3Obv1AGsxh1nkmdq1eeJZN5hi24XWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bFHSS9VN; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bFHSS9VN"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RzHd1JASvcx8FMNHnb3zPVsqRwqQGrruqqTmhSWJAV0=;
	b=bFHSS9VNBYwMo01MuIiREqhcc7DYssKxZXyjmivk7nE0chlhgM5k2sMA8tLOkiBqY13aEjPB/
	MtdSAqXvSKzuhVaXbE4jK2ioNa4yqHwlqUSQzww9oXTt7DkcSqLza1HCCWcfdfn8xptar1CV/xS
	ZhkzR+DDmmOnw+P1RPGtlow=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hdfVk6p30z1cyPY;
	Mon,  7 Sep 2026 15:54:54 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5923F40586;
	Mon,  7 Sep 2026 16:05:47 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 7 Sep 2026 16:05:46 +0800
Message-ID: <25327839-d493-4e12-9b6b-1dda1f1b8704@huawei.com>
Date: Mon, 7 Sep 2026 16:05:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: sched: act_gact: use acquire/release for
 tcfg_ptype
To: Jakub Kicinski <kuba@kernel.org>
CC: <jhs@mojatatu.com>, <jiri@resnulli.us>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260902071659.395509-1-ruanjinjie@huawei.com>
 <20260905134221.233ae6b5@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260905134221.233ae6b5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/6 4:42, Jakub Kicinski 写道:
> On Wed, 2 Sep 2026 15:16:59 +0800 Jinjie Ruan wrote:
>> @@ -160,7 +155,8 @@ TC_INDIRECT_SCOPE int tcf_gact_act(struct sk_buff *skb,
>>  
>>  #ifdef CONFIG_GACT_PROB
>>  	{
>> -	u32 ptype = READ_ONCE(gact->tcfg_ptype);
>> +	/* Pairs with smp_store_release() in tcf_gact_init() */
>> +	u32 ptype = smp_load_acquire(&gact->tcfg_ptype);
>>  
>>  	if (ptype)
>>  		action = gact_rand[ptype](gact);
> 
> Clashiko points out that you are turning what used to be a conditional
> barrier into one that's always obeyed, even if ptype is 0.

What do you think of the following fix?

 #ifdef CONFIG_GACT_PROB
        {
-       u32 ptype = READ_ONCE(gact->tcfg_ptype);
+               u32 ptype = READ_ONCE(gact->tcfg_ptype);

-       if (ptype)
-               action = gact_rand[ptype](gact);
+               if (ptype) {
+                       /* Pairs with smp_store_release() in
tcf_gact_init() */
+                       ptype = smp_load_acquire(&gact->tcfg_ptype);
+                       if (ptype)
+                               action = gact_rand[ptype](gact);
+               }
        }



