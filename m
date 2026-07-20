Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1128BAB9;
	Mon, 20 Jul 2026 08:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537278; cv=none; b=TJBlptXopc0Lm50ojANrL0TcpjIqVwSpxZiMHbmn+HtFr2ljI9OryxIm6umOi3ndCbfwEUg3UD6iuyyVyUD2Dx7l06wvFdVODxxkfyMCc/Lp1LYH8Fa5QI/hMtH0pjFlC1wwXOIfVbMVLfKlRal0bqYElKIqD6B1Ix38ub2fnsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537278; c=relaxed/simple;
	bh=eNVoQWCsY88XSPGXToUf83Z/hnpE5QmO5d4QiDHwV/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROjNEPnMoXcQ49RurVvEwlFN15cVEeugGs97kZ7hTZuvue7Pi/8xAAU76MNXjK2CrRKH3ZuUMlMIQVxpzzelo4xax6yrYT0/tIlj4naumqde421kyXs5WcfUnoD7e2obXdImJwTbBhdperXY/8n1FyB50DypKvBT3OBtjxp9Kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2421101|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0128683-0.000886955-0.986245;FP=7778592403467836759|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iQ-dXBg_1784537251;
Received: from 10.30.1.98(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iQ-dXBg_1784537251 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 20 Jul 2026 16:47:34 +0800
Message-ID: <9ebac788-4ce9-4beb-9e98-4117abbd55ff@motor-comm.com>
Date: Mon, 20 Jul 2026 16:47:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net-next v3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260717054807.1321374-1-kyle.switch@motor-comm.com>
 <3a576b50-f2be-476f-b702-964a8158cf1a@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <3a576b50-f2be-476f-b702-964a8158cf1a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 22:53, Andrew Lunn wrote:
> On Fri, Jul 17, 2026 at 01:48:07PM +0800, Kyle Switch wrote:
>> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
>> 2.5G/1000M/100M/10M speed.
>>
>> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
>> ---
>>
>> changes in v3:
>> 1. Using common apis defined in phy_package.c to handle shared top
>> extend register space.
>> 2. Add dts demo in motorcomm,yt8xxx.yaml.
>> 3. Fix unnecessary redundant judgments.
>> 4. Fix BMCR registers operation using magic number.
>> 5. Rename funtion based on its approximate functionality.
>>
>> changes in v2:
>> 1. Remove duplicate code and replace it with existing api. 
>>
>>  .../bindings/net/motorcomm,yt8xxx.yaml        |   30 +
> 
> Please put binding changes in a patch of its own, in the patch
> series. You also need to Cc: the DT people.
> 
>     Andrew
> 

Ans: as mentioned in other emails. patch v4 will remove binding changes,
and updated in another patch thread.

> ---
> pw-bot: cr
