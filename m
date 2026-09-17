Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9BC265621;
	Thu, 17 Sep 2026 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789606918; cv=none; b=ZWSNtvqkxms4V04r9qZFpsemo+Y507Oa2LIU9orfamLDqDfhp4umOFAs6EEQjSaS9y/y5aI/jCuHusNvnVls+HJy7sobVWY5uNNhDVVELVm8pPCeYuMjhj4X/y9TxfU44BjvBB/OUs4YSFjiLRt0EYfoV2jDLZ3xAA9gET4DLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789606918; c=relaxed/simple;
	bh=UYj33uToIe6OR13RPp5d3tTHqWSnJ5S7fiV/rx58uk8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kSGetfSZzXLhllI89AGqIuj1rQLSx4pnAo/rrmodjP1n+3IAWeF1B1D88bJte06uJs/ynURB5HmIXIuAZkhCPNuowRuoJ9FFA4140WkDi9IKKnOPwQtBM4Z4xwSLbjle3qldEyzsaWwxtecfr6ylHscFjQKonfsNJ1JHbm+12mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxytH7O6tqydkMAA--.37580S3;
	Thu, 17 Sep 2026 09:01:47 +0800 (CST)
Received: from [10.130.40.83] (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxlMz4O6tqoqUhAA--.44539S2;
	Thu, 17 Sep 2026 09:01:45 +0800 (CST)
Subject: Re: [PATCH net-next v1] net: stmmac: Default DWMAC_MOTORCOMM to m on
 MACH_LOONGSON64
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260915073206.6665-1-yangtiezhu@loongson.cn>
 <90a666a8-9f6a-4640-a219-731f3d551c66@bootlin.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <f6b93b98-e0d3-9e28-e366-4df126e6ab5f@loongson.cn>
Date: Thu, 17 Sep 2026 09:01:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <90a666a8-9f6a-4640-a219-731f3d551c66@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxlMz4O6tqoqUhAA--.44539S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur15CF18Zw43AF15JFW5Jwc_yoW8KFy3pr
	4qya429r1kJF45Jw4kA3y8WF90ga97KrZ8u3Z7Jw1fXFZFkryjqryqqFWYqF1UCrWDXF12
	yrW5uasxC3WDAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==

On 2026/9/17 上午12:54, Maxime Chevallier wrote:
> Hi
> 
> On 9/15/26 09:32, Tiezhu Yang wrote:
>> Currently, there is no network connectivity when upgrading to the
>> latest upstream mainline kernel on certain Loongson machines such
>> as Loongson-3C6000 server, because the driver for the onboard NIC
>> is not enabled.
>>
>> Enable the Motorcomm PCI DWMAC driver as a module by default when
>> building for the Loongson-64 platform.
>>
>> This ensures out-of-the-box support for Motorcomm YT6801 Ethernet
>> controllers on Loongson machines, enabling demand-loading without
>> increasing the core kernel image size.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> index ab3c4cf96423..c86d6c08977c 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> @@ -408,6 +408,7 @@ config DWMAC_LOONGSON
>>   
>>   config DWMAC_MOTORCOMM
>>   	tristate "Motorcomm PCI DWMAC support"
>> +	default m if MACH_LOONGSON64
>>   	depends on PCI
>>   	select MOTORCOMM_PHY
>>   	select STMMAC_LIBPCI
> 
> I agree with Yao Zi, this belongs in your .config, maybe your
> defconfig, but not in the stmmac Kconfig.

Thanks for the constructive suggestions.

Before moving forward, I'd like to share an alternative thought.
As noted in the earlier review, this network controller could be
used across multiple architectures. To avoid the redundant churn
in the defconfigs of every single architecture, I am wondering if
we could unconditionally set it to default m in the Kconfig instead.

Please let me know whether it makes sense:

```
diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig 
b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index ab3c4cf96423..bea18cb4b697 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -408,6 +408,7 @@ config DWMAC_LOONGSON

  config DWMAC_MOTORCOMM
         tristate "Motorcomm PCI DWMAC support"
+       default m
         depends on PCI
         select MOTORCOMM_PHY
         select STMMAC_LIBPCI
```

If no, I will modify the arch-specific config.

Thanks,
Tiezhu

