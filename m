Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA764071F9;
	Mon, 20 Jul 2026 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548589; cv=none; b=gDmAkYjn6YGa5U5xtOHWDdze8qaEUlISkJUnB79/NIAVopLUeMlUJlhhrbxET1gm3bHrnQgMQGNajEw96ibmOntFQipqnEsFrATTy0mSLGOEJ0TwpuhibzNNzqHFDB/tgSY7dYpvDHkV2Rtip/WnLg/XeOMnO5i3pmClPimipRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548589; c=relaxed/simple;
	bh=kB0nNg1rxAiERzqhFZ9R75ADQWgo2Vz7tvUjfUe8FTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lx6vCV6JoSAS3aVZ90bafDXxhnWT6OgJKPZUHsxyN291BDtvkxR3loAsSmUTTWndEV8f0r6NOGdukvgXBz1T7R82ig2XgYGCQhwZsCUuRvm0wb+zU3LCMDgFMbBWU7ZW2S1YE1ZonOt7Oao9qzjLlgQgd4hVhBVsIcylauNUW3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h3f9919yCzKHMvC;
	Mon, 20 Jul 2026 19:55:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8896D4056F;
	Mon, 20 Jul 2026 19:56:21 +0800 (CST)
Received: from [10.67.110.68] (unknown [10.67.110.68])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgA3alvkDF5q8mqrBw--.13903S2;
	Mon, 20 Jul 2026 19:56:21 +0800 (CST)
Message-ID: <ffc0a0d8-6560-4589-9570-04f40d817009@huaweicloud.com>
Date: Mon, 20 Jul 2026 19:56:20 +0800
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
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <al3uh7OU2OtkEkSY@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgA3alvkDF5q8mqrBw--.13903S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFyDurWkWw4DKF13tr43Jrb_yoW3Jwb_u3
	yvgr48CF15CF45C3W2yr1fZrW0va17ur13Zr4rZ3sxXFWSywsYvanYgrnYyr1rJwsrXFZr
	X34YvFy5Kr4SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2026/7/20 17:47, Breno Leitao wrote:
> On Wed, Jul 15, 2026 at 03:58:50AM +0000, Pu Lehui wrote:
>> +/* Minimum MMIO (BAR0) len, the largest offset is lower than 64K */
> 
> Why "the largest" in this case?

Hi Breno,

Thanks for pointing that out. I meant the maximum register offset 
accessed by the driver.

IIUC, common e1000e NIC usually have a 128K BAR0. But since I'm not 100% 
sure if older NIC might be smaller, I picked 64K as a safe lower limit 
because it covers the largest register offset used in the driver's 
codebase. If my assumption here is off, I'd really appreciate any 
corrections!

And for this comment, how about the follow?
/* Minimum MMIO (BAR0) length to safely cover the maximum register 
offset accessed by the driver */

