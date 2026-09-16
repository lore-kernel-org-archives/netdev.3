Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3072931FF;
	Wed, 16 Sep 2026 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519054; cv=none; b=V6oRZ8nS6ClZPNbz6Rl2K0HAapOMmbUlbSYoWaeWEiUqGcTexhmzLlm4xT3lg2W9Y4kK60jEwJBodLKGQewAPlL8XJGqOfWkYY3YXPhW+CXLLBgIQW1vVZBAEIOAV7WcmRLUBBQ5z8T8enxx3FaXMwla3Q04AXOKeP8SKoRYVdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519054; c=relaxed/simple;
	bh=UkAG70pi2/dyoRCYz8wEbaqYu82SIuXi26QHMtt/I5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LR2O7r/Aw9CqerKXfIMBP2KG6iKXDuR9Lzm3hF3YIkax20rqrWL8nD3JToy65SRAkjSXRWNZeikmA/dYGbLF63Ehi9n+y4nvRreWlkdp78DNUlKmrBvcZJ4z+fwGuamrQLzlHgIi1luBeWluJsOdLE5T9BBd57seKLxwVCNa8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09247962|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0533815-0.00289987-0.943719;FP=12248529796002867167|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.jEVUG-r_1789519039;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jEVUG-r_1789519039 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 08:37:22 +0800
Message-ID: <0179cc88-0270-4056-9a71-11bf3e2cf3c1@motor-comm.com>
Date: Wed, 16 Sep 2026 08:37:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank.Sae@motor-comm.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260915082152.3104633-1-kyle.switch@motor-comm.com>
 <20260915082152.3104633-2-kyle.switch@motor-comm.com>
 <321725f2-7012-4fc9-8889-33ea7cef1b65@kernel.org>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <321725f2-7012-4fc9-8889-33ea7cef1b65@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/15/26 17:16, Krzysztof Kozlowski wrote:
> On 15/09/2026 10:21, Kyle Switch wrote:
>> Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.
>>
>> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
> I already asked you to Cc the right addresses. That was two months ago.
> I don't understand why can't you just use tools which do all this
> correctly, but repeating same feedback and expecting different results
> is pointless, so shortly:
>
> NAK
>
> Longer explanation below.
>
>
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
>
> Tools like b4 or scripts/get_maintainer.pl provide you proper list of
> people, so fix your workflow. Tools might also fail if you work on some
> ancient tree (don't, instead use mainline) or work on fork of kernel
> (don't, instead use mainline). Just use b4 and everything should be
> fine, although remember about `b4 prep --auto-to-cc` if you added new
> patches to the patchset.
>
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling. Performing review on untested code might be
> a waste of time.
>
> Please kindly resend and include all necessary To/Cc entries.
Ans: sorry for this, it will be done ASAP.
> Best regards,
> Krzysztof
