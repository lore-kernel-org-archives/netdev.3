Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA82D7DD2;
	Tue, 27 Jan 2026 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769493413; cv=none; b=cXS0OzkvyIs0q0mg/exa6H05CfM6soSqUK2mszyBEWgE6h/b3z5eK3HRRuZf2LKHG7u2qRHVueMFdYo7FEhtGmuw02ufetgEEcsfKS5r4TpIryqTUrScdbd0+teMEYoXgk8X9cmpsOMXZCqC7ZfMzBlXHyZ5Y2kqE38yyPB61NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769493413; c=relaxed/simple;
	bh=/0l95Fz3L0POzoSccl4xQyAyISd12aGYkGpuGDszotc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U3ANgpp+8ffHcq21A+FKpA05i9IOywP8trxwW+dEs/wwC0JUXEz7fdsEgqwSiiCeaME7WFIFgYkKjUjDo6Nog6Csx3SU9lonZetYNwUOYKlK4/3+bKqviSyd+epMOW1aMoVniPZXCj6zwXl2a99oZGABVQVfPJB6fATWBpOf9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0ZQZ1X3CzJ46F8;
	Tue, 27 Jan 2026 13:56:06 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id A344D40086;
	Tue, 27 Jan 2026 13:56:41 +0800 (CST)
Received: from [10.123.122.198] (10.123.122.198) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Jan 2026 08:56:40 +0300
Message-ID: <a4a16ead-a534-47e6-8468-58898350415c@huawei.com>
Date: Tue, 27 Jan 2026 08:56:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/3] ipvlan: Common code from v6/v4
 validator_event
To: Kuniyuki Iwashima <kuniyu@google.com>, Dmitry Skorodumov
	<dskr99@gmail.com>
CC: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
References: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
 <20260123170412.906280-3-skorodumov.dmitry@huawei.com>
 <CAAVpQUBGAitiYbXjGoU7ByaXuU9oYF3nfywu43susMHi8mSy8g@mail.gmail.com>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <CAAVpQUBGAitiYbXjGoU7ByaXuU9oYF3nfywu43susMHi8mSy8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 1/26/2026 9:01 PM, Kuniyuki Iwashima wrote:
> On Fri, Jan 23, 2026 at 9:04 AM Dmitry Skorodumov <dskr99@gmail.com> wrote:

>> +static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
>> +                                         unsigned long event, void *ptr)
>> +{
>> +       struct in6_validator_info *i6vi;
>> +       struct net_device *dev;
>> +
>> +       if (nblock == &ipvlan_addr4_vtor_notifier_block) {
> 
> If you check this against the v6 one instead, the if block
> and the i6vi definition can be guarded with
> #if IS_ENABLED(CONFIG_IPV6)

Hm... Few months ago, I had a conversation here that convinced me: avoid 
#ifdef whenever possible. They overburden code and reduce readability.

It even might be a good idea to replace wherever possible preprocessor 
checks with runtime checks. Use
if (IS_ENABLED(CONFIG_IPV6)) { ... }

instead of #if IS_ENABLED(CONFIG_IPV6) ... #endif

--

I'm ok with both approaches (though i tend to like runtime checks) - but 
unsure what is a common practice in bpf-net

Dmitry

