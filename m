Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B081A8F7B;
	Wed, 23 Sep 2026 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125572; cv=none; b=ffEcqgdnKarSZK5Ec4dUf1IFSbAsgHlNHBmakwi4us8ONWEkoSnF73yJM5C0aqEBSa/zsDayDkByd4Wukl8hYGvPeZagVEaCeyjmTM6Oq1uPTFGjxrJvvmaRSLe+rk8qVnkRkQyW5FABPGlV236pCsM3ID/GCeB5/y+rPMGUPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125572; c=relaxed/simple;
	bh=R39r5F5xAwfo+30P9rkTB4nPnc+YzK8QRzhgoZSHIHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQA0piYgky2NPsvakTXgFLCUenehhs0V1tWXcPYUMNYyrm2+XYdd7yzn8fn+Fdl3SmE8sUvs/JRbTkhudE2/V6we69o/xc0vkUVUMNt3hrAeIsE+i2M8C9G1hWPM4f1m0dlMYmI5/mA6Ma9rM3Y3O7S0XUqSXh+LSIRl4WBBdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1326787|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0571846-0.00403219-0.938783;FP=7635599001785502803|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.jKXanyD_1790125557;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jKXanyD_1790125557 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 09:05:59 +0800
Message-ID: <adef0d63-9f7a-46bf-8946-a6493c9e190d@motor-comm.com>
Date: Wed, 23 Sep 2026 09:05:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 0/3] net: phy: Add driver for Motorcomm Quad
 2.5GbE phy
To: Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, Frank.Sae@motor-comm.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260917131441.3428554-1-kyle.switch@motor-comm.com>
 <a5fa376d-0826-4fdc-b99e-cc4a0a623cbc@redhat.com>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <a5fa376d-0826-4fdc-b99e-cc4a0a623cbc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/22/26 18:23, Paolo Abeni wrote:
> On 9/17/26 15:14, Kyle Switch wrote:
>> changes in v20:
>> patch 1: Add phy-mode description in properties in
>>      motorcomm,yt8824.yaml
>
> At least some of the sashiko comments looks legit and
> relevant to me.
>
> Note that the cover letter must carry some brief relevant
> description of the overall work.
> /P

Ans: Thank you for your suggestions and comments.

I will improve the cover letter description in the next version and

also pay attention to some of the issues mentioned by sashiko.

