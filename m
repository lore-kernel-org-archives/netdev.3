Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A3135C188;
	Mon, 20 Jul 2026 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553376; cv=none; b=c7iEiQ0YOBSgu9HnZNISzc8nate2wmlKGYPRrvrqfC6CmYNRF4SDM+nBfY2jLLFEPbWiYuImNN0ufk6xJgVeYdbpHI19EYGBkBa6dN5Q2JTuRnteHvxpPNF3ahMTKYCWgeKjG1QxdmyB9iGXlB0m/N9qnjFfMUOcAK96JJxppL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553376; c=relaxed/simple;
	bh=K+OXIXi68Rh+DM8RsHl3F/a3Bg7A3e8Zx3wwvMOCuGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckZw9g6EpOpH0EtV8ljh8LbF9wEQbT1xaMT75WDMFj06xDrr3QNb+4wudmQL4EL2K2LwY7WuVIVmefV4DW5YtOVvp1oW9jmyAMLG9EZE7+YEIOJPqTwQ+2lr+4eBfxulPYStr8Lj3EmUL2MZiyKcJvQjX6hZhMU0huLw8dvLAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h3gxY0sW5zYQtvb;
	Mon, 20 Jul 2026 21:15:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BE99E4082D;
	Mon, 20 Jul 2026 21:16:10 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCHuluZH15q6ymyBw--.28143S2;
	Mon, 20 Jul 2026 21:16:10 +0800 (CST)
Message-ID: <7a25d8b5-30bc-45cb-b89b-cce07b2cbde1@huaweicloud.com>
Date: Mon, 20 Jul 2026 21:16:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] e1000e: Fix out-of-bounds MMIO access by validating
 BAR0 size
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260715035850.588070-1-pulehui@huaweicloud.com>
 <al3uh7OU2OtkEkSY@gmail.com>
 <ffc0a0d8-6560-4589-9570-04f40d817009@huaweicloud.com>
 <al4Z4_tFbyQM-ogu@gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <al4Z4_tFbyQM-ogu@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCHuluZH15q6ymyBw--.28143S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Wr4kAr1kJFyUtry3Wr13CFg_yoWDZFb_uw
	4F9r4kCr15CFW5A3ZIyr1fZr9Yy3W7Wr43ZrZ5ZasxZFWfAF4vyF4FgwnayF1rAwsFqFZr
	X34Yqa4Sqr4agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2026/7/20 20:53, Breno Leitao wrote:
> On Mon, Jul 20, 2026 at 07:56:20PM +0800, Pu Lehui wrote:
>>
>> On 2026/7/20 17:47, Breno Leitao wrote:
>>> On Wed, Jul 15, 2026 at 03:58:50AM +0000, Pu Lehui wrote:
>>>> +/* Minimum MMIO (BAR0) len, the largest offset is lower than 64K */
>>>
>>> Why "the largest" in this case?
>>
>> Hi Breno,
>>
>> Thanks for pointing that out. I meant the maximum register offset accessed
>> by the driver.
>>
>> IIUC, common e1000e NIC usually have a 128K BAR0. But since I'm not 100%
>> sure if older NIC might be smaller, I picked 64K as a safe lower limit
>> because it covers the largest register offset used in the driver's codebase.
>> If my assumption here is off, I'd really appreciate any corrections!
>>
>> And for this comment, how about the follow?
>> /* Minimum MMIO (BAR0) length to safely cover the maximum register offset
>> accessed by the driver */
> 
> Thanks, Would something like this be a bit better?
> 
>       /*
>        * Smallest BAR0 that covers every register the driver accesses
>        */
> 

make sense to me, will respin soon

