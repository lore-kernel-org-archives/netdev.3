Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C57036492A;
	Sat, 12 Sep 2026 05:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789190237; cv=none; b=qTT3Sd0DvTigqsR8C13LuuTG7OEucPFJr/XlHcEczrBqCTkc8Mecrr9NAKfobeCPvmXarJJBs0/Nlna+vpRnH6akYyMSiPUjznhcdQchsDzP63TU329JDVnaW/cpim3SKK5USoJOOcZ4Xh7/QUNZzuhNfGWdIJ++tjuBHCABWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789190237; c=relaxed/simple;
	bh=MODSap1JZcee0eyU9zx5bZXw2Dy1Bjzav+OjTAMC3HA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=izFiuz9HI6/+93APs7U4pzSlb50L0C6UQmezZy3XzddgzChzZlxrqRZpyL2THjhi3xB8m9GYMlpSG3/2cBnLhn3zRuaI2Q9D8S/jwpzR9yPqbr06HHxe8X2AsIoxuvQNSkvizNnkWELY3gvN8j4HGy7MjyRQYr8VTSkr3DlS2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1475422|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0171497-0.00133156-0.981519;FP=16782269107539192950|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.jBqQrbc_1789190214;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jBqQrbc_1789190214 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 12 Sep 2026 13:16:59 +0800
Message-ID: <1710b612-05a9-48e7-a087-a18c5caf4da8@motor-comm.com>
Date: Sat, 12 Sep 2026 13:16:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 2/2] dt-bindings: net: Document Motorcomm YT8824 PHY
 package
To: Andrew Lunn <andrew@lunn.ch>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
 jie.han@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260910074624.2426899-1-kyle.switch@motor-comm.com>
 <20260910074624.2426899-3-kyle.switch@motor-comm.com>
 <4246e368-42f5-4037-8882-6ad87a85724e@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <4246e368-42f5-4037-8882-6ad87a85724e@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/11/26 19:52, Andrew Lunn wrote:
>> +  motorcomm,interface-mode:
>> +    description: |
>> +      PHY package interface mode.
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    enum:
>> +      - internal
>> +      - usxgmii
>> +    default: internal
> You are not the first vendor to use usxgmii, a vendor property is not
> required.. e.g. fsl-ls1028a-qds-13bb.dtso.
Ans: will be fixed done in next patch.
> 	 Andrew
