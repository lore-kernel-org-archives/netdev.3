Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4808C38E8AD;
	Wed, 29 Jul 2026 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325531; cv=none; b=A6XeiXZcQ6hS1HjrubqRyRne3erDa3tf0WKcq9mjB+Yv3R+HQ0Jxn02BXA8inXRn/Olp9qdnjJpykbK2b4IP2Qp65b7BKr91hrjcLQcD4YeNbhzxsvWchAQ09MyAX46FGfONkXhHf2BomCuX623tE0a4iMQblRgU24kqyPOibLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325531; c=relaxed/simple;
	bh=hrTe45srEcaZpYx7JqvSg2VG8caJBP0VUEZFMqtvjm8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UxZS+Y51VhOSHSRgtK9fm4G0LFO2tASGjwh5FJPO95hafslZB1mr82XWorolrfex7FIWr4N2wcbEndDl+PioX2OlEWtuRa4M+VwG37CC6YjvmypFP7HRVTZUgmS7rxGdFhnty00v9QaU+kF9gNE6pNRdJoDyRTiZR4Cn+Xc6Yqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uklSJOFa; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uklSJOFa"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LocgF+XkNe2qcdGDa3yE9jO+3GMm+ut1Fqgv4PPkloc=;
	b=uklSJOFaUT2F2eYhMffSTJ+e9LtoGfKuLcquVz6Wcx4lUUtmNtuzyWn9QinRK8OywdcgkACoX
	I3FUlf7yBrMC9o+qAG95KkcxH4+m5XIyPxPUox6G/KEnaLjQOdNn2R9kENeNTaXbXCQ67vw80bo
	JGiPZ3NABgDU6UJVIMPw0Pk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h99JF16msz1cyQ2;
	Wed, 29 Jul 2026 19:35:57 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id C35504048B;
	Wed, 29 Jul 2026 19:45:22 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 29 Jul 2026 19:45:22 +0800
Message-ID: <87b5d9ec-3a8d-4bca-92d0-53d27beb9e2b@huawei.com>
Date: Wed, 29 Jul 2026 19:45:21 +0800
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
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net] net: hns3: fix speed configuration residue after
 driver reload
To: Simon Horman <horms@kernel.org>
References: <20260724093036.426631-1-shaojijie@huawei.com>
 <20260729110240.GA76598@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260729110240.GA76598@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/7/29 19:03, Simon Horman wrote:
> On Fri, Jul 24, 2026 at 05:30:36PM +0800, Jijie Shao wrote:
>> After setting a 100G optical port to 40G via ethtool and reloading
>> the driver, the port remains at 40G instead of reverting to the
>> firmware default speed of 100G.
>>
>> The commit referenced in Fixes: added two overwrites in
>> hclge_init_ae_dev() for non-copper media, so that optical ports
>> connected to forced-mode remotes inherit the firmware-preset
>> autoneg and speed instead of the hardcoded defaults:
>>
>>    req_autoneg = mac.autoneg
>>    req_speed   = mac.speed         (when autoneg disabled)
>>
>> The autoneg overwrite keeps existing behavior:
>> hclge_set_autoneg_speed_dup() already uses mac.autoneg (not
>> req_autoneg) since it was introduced, so autoneg inheritance from
>> firmware was already in place. This part is kept.
> The AI-generated review on netdev-ai [1] flags that this isn't strictly
> true as req_autoneg does appear to be used in hclge_set_autoneg_speed_dup().
> I don't want to nitpick, but perhaps this is worth clarifying.
>
> [1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260724093036.426631-1-shaojijie%40huawei.com


The intent is to restore the pre-c711f6d1cee9 behavior for non-copper
media, where the helper read mac.autoneg directly and fiber ports
inherited firmware autoneg at init. c711f6d1cee9 switched the helper
to req_autoneg, breaking that inheritance; d9d349c4e8a0 (same patchset)
added the explicit req_autoneg = autoneg copy to restore
it, and also added a req_speed = mac.speed copy.

This patch keeps the req_autoneg copy — load-bearing as the sole
init-time path for non-copper media — and drops the req_speed copy,
which is the residue source. The commit message wording about the
helper reading mac.autoneg describes the pre-c711f6d1cee9 state,
not the current code.

Thanks
Jijie.


>
>> The speed overwrite, however, introduces the residue: mac.speed
>> reflects whatever was last programmed into the MAC, and after unload
>> firmware does not restore the MAC speed to the flash default. So if
>> the user changed speed via ethtool in a prior load, mac.speed still
>> carries that value on reload and req_speed inherits it.
>>
>> Fix by dropping the req_speed overwrite only. req_speed keeps the
>> firmware default value set in hclge_configure() (cfg.default_speed),
>> so a reload reverts the speed to default, matching the expectation
>> that a driver reload resets link configuration.
>>
>> Trade-off: on optical ports whose firmware default speed does not
>> match a forced-mode remote, reload now drops the link and the user
>> must re-apply ethtool configuration. This is acceptable: a driver
>> reload is expected to reset link configuration, not to inherit
>> runtime state from before unload. The autoneg inheritance is left
>> in place as established behavior; changing it is out of scope for
>> this patch and would itself be a user-perceivable behavior change.
>>
>> Fixes: d9d349c4e8a0 ("net: hns3: differentiate autoneg default values between copper and fiber")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>> v3:
>>   - Expand commit message to explain the two overwrites added by the
>>     Fixes commit: req_autoneg inheritance is kept because it matches
>>     existing behavior of hclge_set_autoneg_speed_dup(); req_speed
>>     sync is dropped because it introduces the reported residue.
>>   - State explicitly that link loss on forced-mode optical ports after
>>     reload is acceptable, since a driver reload is expected to reset
>>     link configuration rather than inherit runtime state.
>>   - Explain why autoneg inheritance is left unchanged: it is
>>     established behavior, and changing it is out of scope and would
>>     be user-perceivable.
> ...
