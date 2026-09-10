Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C13769FF;
	Thu, 10 Sep 2026 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010600; cv=none; b=Gh2Kylnsn9NMh183gf6Yhkn3eoYwz3xcy/pxa/oiqACCsBGX2mTmfWiZkyrPZZrD42dj8HOEu5DaEI5/orUMqNDyQL2lscJwsxoONggDI84AMLGRpTf92TRgh90Ct0zWUvmCS0gV/Rwn4uyh/CJNcujKWwVASH2XRFHPmOOCKRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010600; c=relaxed/simple;
	bh=iouvbhhZfixEDdQwyTcpAFyO2f9eDsZZhIh5HjGEswQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XhSm6jStRuMG4n+MukjX96zSzGFPJZSUFIj+7NknO5Ct/tIIAvHdJovilYMVUj2bI/DqtP4jYSOZOt2ZrSrXZYSlRPr/ttI49kwOCfY6LP2JQXw05BUbaDqphBFubo03nlYDtTPjJ3+wClLzM1kWrgfSB0zGj29V2Om8UHFNimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1041459|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0193458-0.00239537-0.978259;FP=5400844641935200081|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jA5tta5_1789010584;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jA5tta5_1789010584 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 11:23:06 +0800
Message-ID: <1bd79ceb-4abf-49e3-a441-7c026a89d220@motor-comm.com>
Date: Thu, 10 Sep 2026 11:23:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 6/6] net: dsa: motorcomm: Add support for
 Motorcomm YT922x
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
 <20260908083614.2210505-7-kyle.switch@motor-comm.com>
 <CAAXyoMMLpaD5B4QojC0OKHxOFfPfFGpsS2nxCMT9e=nJeo8beg@mail.gmail.com>
 <0aa20394-2042-4c52-b30b-cdd742d4da65@lunn.ch>
 <5e492c8b-1afa-4af8-8f66-9b50799911e4@motor-comm.com>
 <0ad7cd3b-006f-41a0-9d58-5f6dad9c22e8@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <0ad7cd3b-006f-41a0-9d58-5f6dad9c22e8@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/10/26 09:57, Andrew Lunn wrote:
>>>> No one else, except you, can maintain this stuff. Drop it for now and
>>>> discuss it later.
>>> There also appears to be similar magic in the PHY driver. Can this be
>>> consolidated?
>> Ans: This part of the initialization is for the switch SerDes, so from my
>>
>> side it may be hard to consolidate.
> Is it the same IP? Same configuration? Or totally different?
Ans: They are the same IP, but there are the following differences:

1. phy8824 only supports usxgmii_multiport mode.

     yt922x has 4utp+2serdes. These two serdes support more modes,

     such as usxgmii_singleport, bx1000, sgmii, etc., which results in more

     initialization configurations for the switch serdes.

2. Another point that I think is difficult to integrate is that the phyID

     of the switch serdes (defined in USXGMII reg space mii 0x2, 0x3) is

     inconsistent with the phyID of phy8824 (defined in UTP reg space 
mii 0x2, 0x3),

     so phy8824 cannot be matched, and therefore two sets of initialization

    configurations are required.

> 	Andrew
