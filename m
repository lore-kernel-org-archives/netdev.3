Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539518;
	b=ib+voWgkQD+/4uVSUy3WJFUVmDyhNAF4dkckVkyomBUH6/G4MOVygF8mT/y+BA3ILUk1
	 Svg5n00NoHN9SLv6uX5B0Iyl/dh924YHc+KoVjYVKNioxp9npM6Rau3qMT/l80O1JFf1u
	 pCD/pMSfWlO7y+m0pTTZDibplNIMKKCOch7hy8he24qglMsdT3ymYJqfqUVwKC6mGaVE5
	 2uixX0hHgw19yN5lgCK6TmO1cUFnAtz/oOizYAKU004BW6OfezMNFCvrFZVmOglaHZO4B
	 /3IR+N47eoknp8UVhHCHsMBIUQdkXNzFXcEbnmrbMBBXWT6BcqnREgZ5E6yllwif+FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539518;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=7s9q7iT7517JA05XtS0w28CIONg1wuhBMt23qJEENZs=;
	b=pzwx8o99aO30emfmkoWKs15z3fQWP/BgOtgyZ/uRGNHwB4GG0Au7YUvgwdLdz2Chocva
	 PbhhDtgiJQE2ZGjVoK8z4Uex2g/FbJMQzX+THHehve/f2POBBQ476z937TNRkRlE/Ta3E
	 M/PEFp8XHU2Ro8b/GUso1ydgmETKFoRsHbTtKGcZrD13DVc/d9+vBT3gKn5HAMC7PfyzO
	 mFDQJw5+kI/kFP38LYfNl2n3JXMMkyii57QRrQYHS/jfGAsDsvzacWeq5AZDuSM9SQmQy
	 4Cp7w0a2DeTZDnAKUi3/d8f3ZP3mhPLdSQdAeMH0bOetFA4mQlyJ/cio7HrnGRMTl3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hNyI4iAH;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E4606A323;
	Fri, 13 Nov 2026 03:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C0E4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=hNyI4iAH
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7s9q7iT7517JA05XtS0w28CIONg1wuhBMt23qJEENZs=;
	b=hNyI4iAHu65O2kVvjmnV6j7d9OWJa28UdjhM/6Op2xE6PL/dCkRxZEVFLB6wdaUwSfMvxsvni
	PmYQP5u1YQBXXzniPY9pFmvkNpYN7dcn4bm+XF7X1HSC8tWm7DTSoZ6jesMehxNGjBIadfH95ME
	BatOpRj2i8L+T+HiBXoikbk=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jQj2c2PKwz1T4lB;
	Fri, 13 Nov 2026 11:11:20 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 85BFA4057A;
	Fri, 13 Nov 2026 11:11:52 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 13 Nov 2026 11:11:48 +0800
Message-ID: <23712c53-4b0e-47b7-b080-a8b5e5584a1d@huawei.com>
Date: Fri, 13 Nov 2026 11:11:47 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <shenjian15@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <ningwei15@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 net 0/4] net: hns3: fix multiple bugs in reset/error
 paths
To: Jakub Kicinski <kuba@kernel.org>, <netdev-bot+sinfo@kernel.org>
References: <20261111125810.3359030-1-shaojijie@huawei.com>
 <179440206352.2168702.1328392786936670574@kernel.org>
 <20261112110631.2ec2d378@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20261112110631.2ec2d378@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/11/13 3:06, Jakub Kicinski wrote:
> On Wed, 11 Nov 2026 13:01:03 +0000 netdev-bot+sinfo@kernel.org wrote:
>> Please do not repost the series just to address the above. Instead,
>> reply to this email with the missing information, so that reviewers
>> can take it into account. If the series needs another revision for
>> other reasons, please include the information in the commit messages
>> then.
> Please make sure you include the answers to these questions in the
> cover letter if you repost

ok,

Patch 1: found in internal code review. Not hit at runtime - it needs
devm_kcalloc() to fail after get_vector() has succeeded.

Patch 2: found by Sashiko on v2. Error path only, not hit at runtime.

Patch 3: real customer issue. Under memory pressure the RX ring filled
up, no more RX interrupts came in and the interface went dead. No stack
trace, the interface going dead was the only symptom. Reproduced and
fixed on EVB.

Patch 4: hit on a lab EVB while reading the debugfs queue files during
reset/unload. NULL pointer dereference, machine hung.

All four were built and tested on a Huawei Kunpeng evaluation board (EVB)
with the on-board hns3 NIC. Patch 1 and 2 were not exercised on the
failure path.

Thanks,
Jijie Shao


