Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C81266581;
	Wed, 23 Sep 2026 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790125238; cv=none; b=oZSFCiCfIAegsMlgusrvuOLoxOCssEWtft9SFQ27z8+3Xg+JjROy2ER240wk2uViuharWhC+mAiH1Ykef2q5IMolgCdOPkDtbfqS9aGtQPy4+xibGNzQaO7oYDzVk2VEOMtYMpf/Oh9ccaYVWlHgRqEEGFm3ZxdN+4r2TkUTwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790125238; c=relaxed/simple;
	bh=dtpaYbJP1yVNOdjNsC2+sOdd1R1znbe46rz4U4BOp14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HclVJBbRv+gkHysRpkc8m74WcU2HpUCUrt0bcsws5qZsTRKZKy5ELYcuBmcbu9fwYc7VHKA/gOpxglEIUEfOj2N4qSbCM7eLJvd4e/+RnmiZoI1Pl2jwrd9hWJcBluon2M6dJ1PBkpWN9xIknTuTpZKfBCvtyBHMj/karOo/vn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1207203|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0148127-0.000461423-0.984726;FP=16781415920196234326|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.jKYUcQL_1790125227;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jKYUcQL_1790125227 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 09:00:31 +0800
Message-ID: <c4c3476f-5e28-4ee4-a65e-e23806e7c13c@motor-comm.com>
Date: Wed, 23 Sep 2026 09:00:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
To: Andrew Lunn <andrew@lunn.ch>, netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260917131441.3428554-2-kyle.switch@motor-comm.com>
 <178999667530.2160803.2619551882908404136@kernel.org>
 <26e31b64-98bf-45d8-8c9b-b7291a3d783c@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <26e31b64-98bf-45d8-8c9b-b7291a3d783c@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/22/26 20:10, Andrew Lunn wrote:
>>    MOTORCOMM PHY DRIVER
>>    M:	Frank <Frank.Sae@motor-comm.com>
>>    L:	netdev@vger.kernel.org
>>    S:	Maintained
>>    F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>>    F:	drivers/net/phy/motorcomm.c
>>
>> That pattern does not match motorcomm,yt8824.yaml, and no other section
>> matches it either, so get_maintainer.pl will not report the Motorcomm PHY
>> maintainer for future changes to this file.  Widening the existing entry to
>> Documentation/devicetree/bindings/net/motorcomm,yt8*.yaml, or adding a new
>> F: line, would cover it.
> Please do fix this.

Ans: okay, Another question I'd like to ask is whether all the risk issues

flagged by sashiko need to be resolved. Some of the flags may not actually

be bugs, and some that are clearly meaningful have been fixed

one after another previously, so what I want to know is whether everything

flagged by sashiko has to be cleared. Thank you.

>
> 	Andrew
