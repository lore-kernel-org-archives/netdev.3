Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2067D3A63F2;
	Fri, 24 Jul 2026 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784876457; cv=none; b=KXqePA2R5DYrrJspF0IxaqSMiLTsBIrY6Ngn3gopTSGDeW4IyK4GcCthNtUvpPAB+rYuzRrP3rYV7eFJ+exVstG5keJKNfI1SPhlv+jxT7MzS1NgUAAJ9zDjc+1C6/jmgGGobpJ9Rxs3vE41IrHT/I2HMjHE5T6JapV0JXl8BF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784876457; c=relaxed/simple;
	bh=czJw9inPZNNsKI9eRdOMEX8MxHLsxp45ETyJFRGArSs=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gSthscKX9ZQNMQNKv301U5/qv044JMlSkFGX2QxuW6TjH2Wp3E30ccGYhYaOmqm2kguff6TN9utx0g4T7oQDDIIPy4Dvxrnwxx4/v+6ERcfZmB4dSlmUmQ8iCFB+ViBylgFEzdpBYXGNSiIxZJqUVbAJK7rfa3SihhEhOrC6ung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EeEeD7He; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EeEeD7He"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jlzdTQ1abBHXaQOkVeYar+VZSU5sLBp7pXvv+qyqxfE=;
	b=EeEeD7Hewbk0IEMnyRnVIAG+atwzjiE95KjrF58kNjDv1tzO2GS+GHYFDzYcR0bCmB8DsmjLl
	+D97x280k+QZV3vzPN59wNZ9e6EHCWPwKmWpRotJPYCWce2XZjN8YOQBn8MQqUYQx/r8QAyow5x
	wxXYW5z89FWKO/At8ay7Yq0=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h5zD54QTzz1K9cJ;
	Fri, 24 Jul 2026 14:51:17 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 3896C402AB;
	Fri, 24 Jul 2026 15:00:40 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 24 Jul 2026 15:00:39 +0800
Message-ID: <d3b18a2c-7cec-4a67-9861-f938963dca1e@huawei.com>
Date: Fri, 24 Jul 2026 15:00:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net] net: hns3: fix speed configuration residue after
 driver reload
To: Paolo Abeni <pabeni@redhat.com>
References: <20260708140532.1691493-1-shaojijie@huawei.com>
 <20260721110529.201977-1-pabeni@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20260721110529.201977-1-pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/7/21 19:05, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> net: hns3: fix speed configuration residue after driver reload
>
> This change drops the req_speed overwrite in hclge_init_ae_dev() so
> req_speed keeps the firmware default set during hclge_configure()
> after a driver reload, and only req_autoneg continues to be
> synchronized from mac.autoneg on non-copper media.
>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> index fc8587c80813..164c3ecf195c 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
>> @@ -9498,12 +9498,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
>>   	if (ret)
>>   		goto err_ptp_uninit;
>>   
>> -	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER) {
>> +	if (hdev->hw.mac.media_type != HNAE3_MEDIA_TYPE_COPPER)
>>   		hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
>> -		if (hdev->hw.mac.autoneg == AUTONEG_DISABLE &&
>> -		    hdev->hw.mac.speed != SPEED_UNKNOWN)
>> -			hdev->hw.mac.req_speed = hdev->hw.mac.speed;
>> -	}
> [High]
> Could removing this block reintroduce the scenario that d9d349c4e8a0
> ("net: hns3: differentiate autoneg default values between copper and
> fiber") was written to handle?
>
> The Fixes-tagged commit added this req_speed overwrite specifically for
> optical ports where firmware presets autoneg=DISABLE at a specific
> forced speed (a case its commit message describes as common in data
> centers where the remote switch runs in forced mode).
>
> There appear to be two distinct notions of "firmware default" involved:
>
>    - cfg.default_speed read from flash static parameters via
>      hclge_get_cfg() and stored into req_speed by hclge_configure()
>
>    - the live firmware/SFP state read via hclge_get_sfp_info() into
>      mac.autoneg and mac.speed
>
> On a fiber port where the flash default_speed is 100G but firmware has
> preset the port to forced 25G to match a fixed-speed remote, after this
> change:
>
>      hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;  /* = DISABLE */
>      /* req_speed still holds flash default 100G */
>
> hclge_set_autoneg_speed_dup() would then see !req_autoneg and call:
>
>      hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed=100G, ...);
>
> forcing 100G against a 25G-only peer.
>
> Is that scenario still handled, or is it expected not to occur in
> practice?

We want driver reload to reset MAC speed to the firmware default.
If that doesn't match a forced-mode remote on an optical port,
link drops and the user reconfigures with ethtool. That's fine.

The req_speed = mac.speed line was added in the V2 of the June
series to avoid that link drop, but it caused the actual reported
bug: speed stays at the last user setting across reload. This
patch drops that line and goes back to the V1 behavior, which
only synced req_autoneg.

   V1:
   https://lore.kernel.org/all/20260617112721.75186-5-shaojijie@huawei.com/

   V2:
   https://lore.kernel.org/all/20260624141319.271439-5-shaojijie@huawei.com/

If we need to cover the forced-mode optical case without
reintroducing the residue, that's a separate problem — a one-line
req_speed = mac.speed can't tell user-configured speed apart
from firmware-preset speed.

>
> [Medium]
> The commit message reasons about mac.speed carrying over user ethtool
> changes across a driver reload:
>
>    "In hclge_init_ae_dev(), hclge_update_port_info() reads mac.speed
>     from hardware, which reflects the last user configuration (e.g.
>     ethtool changes), not the firmware default."
>
> Does the same reasoning apply to mac.autoneg?
>
> hclge_get_sfp_info() sets mac->autoneg from the live firmware state, so
> a prior "ethtool -s ethX autoneg off speed 40000" on a 100G optical
> port would leave firmware reporting autoneg=DISABLE after reload.
>
> After this change, req_speed correctly reverts to the flash default
> 100G, but this line still runs:
>
>      hdev->hw.mac.req_autoneg = hdev->hw.mac.autoneg;
>
> so req_autoneg stays at AUTONEG_DISABLE rather than reverting to the
> AUTONEG_ENABLE default that hclge_configure() would set for fiber.
>
> Why is speed residue fixed while autoneg residue is preserved?

The asymmetry is on purpose. req_autoneg has been inherited from 
mac.autoneg since long before this work; that behavior has always been 
there and is left unchanged to avoid surprising users. req_speed = 
mac.speed was added in June V2 and is what caused the reported residue, 
so dropping it is the fix. I'll send a v3 with the commit message noting 
that link loss on forced-mode optical ports after reload is expected. 
Best, Jijie

