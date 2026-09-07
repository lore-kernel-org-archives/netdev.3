Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBD35B136;
	Mon,  7 Sep 2026 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763498; cv=none; b=urJy769vxtavqiNeHehevRxkNVYHmlqNXrd53uA9v7nb/mlvJzl7LPA1Ft/RgOZBh/D+CadLT6P5SCJAjG32zZOh3VAPO86V45A+vfDkO9N+bmkvqFAmmavDpMypABDSU65tiXTwmtXLrZBrt+cbWX1wwLrUlNpiHhuJ2ym9HFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763498; c=relaxed/simple;
	bh=7+D2+ZTHZe/FG+49dWfe0VyOJU6c3xHsKLnKghHMNcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kxPN6QuGHG7538FE6kDexoixlF1d5VY4GuelTp3ej3Mi1v/TVUn3lwMnxStoTuUcS67GcpviLFO4QrakFEC68/aaYZshB4h2fSBk286aw7HG8s46e6SVb82zAiqraPh/H7xZ75Khz1ZyoE6CJg7zJay/3PmI6c1rHKmtlyGEVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1146566|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.346949-0.00196884-0.651083;FP=16817289693868366985|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j7Uo-n9_1788763482;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j7Uo-n9_1788763482 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 07 Sep 2026 14:44:44 +0800
Message-ID: <6f2176fa-7f33-4cd5-8185-c961c9f68e82@motor-comm.com>
Date: Mon, 7 Sep 2026 14:44:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/6] net: dsa: motorcomm: refactor
 registration path for upcoming switch families
To: Andrew Lunn <andrew@lunn.ch>
Cc: David Yang <mmyangfl@gmail.com>, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <CAAXyoMN-RX1aY_isyajES5LgiDMp7_YTbM=jiS6d-8o2kKQXqg@mail.gmail.com>
 <27a16f29-14a9-40d0-941b-f07d5b63ec4a@motor-comm.com>
 <8704e277-3968-4c04-91b6-04ce046fa806@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <8704e277-3968-4c04-91b6-04ce046fa806@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/7/26 11:00, Andrew Lunn wrote:
>>>>    static const struct of_device_id yt921x_of_match[] = {
>>>> -       { .compatible = "motorcomm,yt9215" },
>>>> -       {}
>>>> +       {
>>>> +               .compatible = "motorcomm,yt9215",
>>>> +               .data = &yt92xx_series_info_table[YT921X],
>>> Redundant if you use both runtime identification and the match data.
>>> Also I'm concerned with early IO operations, although I didn't see any
>>> incorrectness here.
>> Ans: we have considered this issue before. in the next version, we
>>
>> will consider whether to do it via chip_detect() or using indexed
>>
>> assignment. From your suggestion, what are the side effects of each
>>
>> approach and which of the two approaches do you recommend?
> One problem with compatible is what do you do when it does not
> actually match the hardware, because the DT author has messed up?
>
> For the Marvell devices, the compatible only indicates where the ID
> register can be found, because Marvell likes hide and seek, they keep
> moving it. Once the ID register is read, it is matched against a table
> to find the correct structure for that device.
>
> Where compatible are interesting is when the silicon vendor messed up
> and produced two different devices with the same ID value, or put no
> ID in the ID register at all. Then you have to work around the silicon
> vendors mess, and hope the DT author gets it correct.
>
> My suggestion would be to use the ID register and not have
> compatibles.

Ans: Now i finally understand why Marvell does this. When i referred

to Marvell implementation before, i had the same question as David-

isn't this redundant? So for the future optimization direction of yt92xx

driver, i can completely do without the compatible info and instead use

chip_detect to match entries in the table. is my understanding correct?

> 	Andrew
