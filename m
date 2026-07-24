Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50030175A99
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856472; cv=none; b=WOQ4cjVo/3D80bxAsvV8kV5JwQI4Ot1obLjPx7qyZ2IGL/ikRyamurRtO2YUC7GPvV9IroSGZ1PARhy/YH2z2TYQ7hwBZzjcFJjxeNRIdEn1dCZuqMOSO7CjnQtLK7PfGRvhR9oDvp3v/o6BIf8mfO7K082K5PlvzKpdInlsAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856472; c=relaxed/simple;
	bh=rd1umf0VSLrHXu1Qxtjxl3cIR8b2H++AaAMoFeEpxYM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=CHrx/W4neVAW/aD5mHCH7rBY7LpFAWFzUT7W8BrYJpDgRLORxyDFIW9vCoF/wnC5zt232dHSb5o/onu16716pNegWB8tk98x6y/ugflU6aLtn/16dFRwntNhqKVWnRMXYHHxcXRDwsWl59+rgomXpjQZ5Q31W20sguwoHFNQUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h5r1w1VhNzKHML8
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:27:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 60548407BA
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:27:46 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCn1leRv2Jqy_pcCQ--.22068S2;
	Fri, 24 Jul 2026 09:27:46 +0800 (CST)
Message-ID: <0655607d-9aa4-472f-b7f5-b2abf3cbfe75@huaweicloud.com>
Date: Fri, 24 Jul 2026 09:27:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] e1000e: Fix out-of-bounds MMIO access by
 validating BAR0 size
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
To: Andrew Lunn <andrew@lunn.ch>, sashiko-reviews@lists.linux.dev
References: <20260722031603.1471127-1-pulehui@huaweicloud.com>
 <20260722033703.2E5A71F000E9@smtp.kernel.org>
 <3322e323-da9d-453d-8c41-470e4649684a@huaweicloud.com>
Cc: Networking <netdev@vger.kernel.org>
In-Reply-To: <3322e323-da9d-453d-8c41-470e4649684a@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCn1leRv2Jqy_pcCQ--.22068S2
X-Coremail-Antispam: 1UD129KBjvJXoWxury7JF1fCFyrJF1Uuw1xKrg_yoWrJrW5pa
	ykKas8uFW8Jrsaqa12vr48ZFyDGa13tF4UGFyYqFn0va4Y9r1xKrW2grW5u347Xw4kZryx
	trn0y343ZF4DA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


Gentle ping~ hope this message would not miss.

And +cc netdev@vger.kernel.org as I missed it.


On 2026/7/22 16:34, Pu Lehui wrote:
> 
> On 2026/7/22 11:37, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential 
>> issue(s) to consider:
>>
>> Pre-existing issues:
>> - [High] The newly introduced minimum BAR0 length check 
>> `E1000_MMIO_LEN_MIN` is too small because it fails to account for 
>> flash registers mapped into the GbE memory space for newer MACs, 
>> leaving the driver vulnerable to the same OOB MMIO access panics it 
>> attempts to fix.
>> -- 
>>
>> --- Patch [1]: [PATCH net v3] e1000e: Fix out-of-bounds MMIO access by 
>> validating BAR0 size ---
>> commit 9c24a014d2bfbd3a6822ff92be6a5c7aceb588d4
>> Author: Pu Lehui <pulehui@huawei.com>
>> Subject: e1000e: Fix out-of-bounds MMIO access by validating BAR0 size
>>
>> This patch adds a check during e1000_probe() to validate that the 
>> device's
>> BAR0 size is large enough to cover the highest register offset 
>> (E1000_SYSSTMPH)
>> accessed by the driver. This is intended to fix a kernel panic caused by
>> out-of-bounds MMIO reads when dealing with small BAR0 allocations.
>>
>>> diff --git a/drivers/net/ethernet/intel/e1000e/regs.h 
>>> b/drivers/net/ethernet/intel/e1000e/regs.h
>>> index 6c0cd8cab3ef2..1e875227eef24 100644
>>> --- a/drivers/net/ethernet/intel/e1000e/regs.h
>>> +++ b/drivers/net/ethernet/intel/e1000e/regs.h
>> [ ... ]
>>> @@ -242,4 +242,7 @@
>>>   /* PHY registers */
>>>   #define I82579_DFT_CTRL    PHY_REG(769, 20)
>>> +/* Smallest BAR0 that covers every register the driver accesses */
>>> +#define E1000_MMIO_LEN_MIN    (E1000_SYSSTMPH + sizeof(u32))
>>
>> [Severity: High]
>> This isn't a bug introduced by this patch, but does this minimum length
>> cover all register accesses for newer MACs?
>>
>> For MAC types e1000_pch_spt and newer, the driver accesses flash 
>> registers
>> mapped at E1000_FLASH_BASE_ADDR (0xE000). For example, during flash read:
>>
>> drivers/net/ethernet/intel/e1000e/ich8lan.c:e1000_init_nvm_params_ich8lan() {
>>      ...
>>      hw->flash_address = hw->hw_addr + E1000_FLASH_BASE_ADDR;
>>      ...
>> }
>>
>> And then later accesses like:
>>
>> drivers/net/ethernet/intel/e1000e/ich8lan.c:e1000_read_flash_data32_ich8lan() {
>>      ...
>>      *data = er32flash(ICH_FLASH_FDATA0);
>>      ...
>> }
>>
>> This results in an access at offset 0xE010 (57360 bytes).
>>
>> Since E1000_MMIO_LEN_MIN is currently based on E1000_SYSSTMPH
>> (0xB64C + 4 = 46672 bytes), could a malicious or mocked PCI device 
>> expose a
>> BAR0 size of 12 pages (49152 bytes), pass this new check, and still 
>> trigger
>> an out-of-bounds MMIO read panic when accessing the flash space?
>>
> 
> Hi Andrew,
> 
> Sashiko is right about this one.
> 
> On ich chipsets, the driver sets the flash base address like this:
> 
> hw->flash_address = hw->hw_addr + E1000_FLASH_BASE_ADDR; // 0xE000
> 
> Then it accesses flash registers up to ICH_FLASH_PR0 (0x0074), so the 
> max offset ends up being 0xE000 + 0x0074 + sizeof(u32) — that’s about 
> 57.1 KB. Pretty subtle, and yeah, we totally missed it in v3.
> 
> Since PCI BAR sizes are power-of-two aligned, the smallest standard BAR 
> size that can cover accesses beyond 57.1 KB is 64 KB.
> 
> So for v4, I’d like to set E1000_MMIO_LEN_MIN to SZ_64K. That keeps us 
> safely covering the largest register offset we use, avoids fragile 
> hardcoded values, and should be more future-proof if other chipset flash 
> ranges come into play.
> 
> wdyt? :)
> 
> Thanks,
> Lehui

