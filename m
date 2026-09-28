Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EA2DFA3A;
	Mon, 28 Sep 2026 01:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559965; cv=none; b=D1zCnn/IfofePCXDQa3NoOWBly4jhrXftb8CK8V4BSL2n69uCL7R231MzE3rFup0GpXjzpkQZqXvRxLHJOetIKFjMAG/urs1QGVLSFhRw+bFFMZIPLqN1IFGvctoeOySUCXfW30sDmMNhTEMI14U3ItDAS9d0rRwGX7xPAC9ghY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559965; c=relaxed/simple;
	bh=NS1dt2/hQB+uY5t432nIVrcwt7/uQEymHMdpZRi1cms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lrq5Gq+O7SBHFb9FpFI9q+MVjjkqe5SBIwRgUvxlmCCUqeNw7zOqRwHYK8z5kuq8SzZ/xv4B0qXqCTxdy1EAqQQ3ZLsueWK1C7NbD/XlrdFvDAvlhBMUqjhXZv/vd3vwSAVgAIiF3U8pt/ESVCa9RY6A9pmzsVhZAI9o4yEym1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07992189|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0158915-0.00141759-0.982691;FP=16926155355596582004|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.jPa7AAg_1790559952;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jPa7AAg_1790559952 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 09:45:53 +0800
Message-ID: <415c6c1c-f59e-41c7-9045-22f20408a7f2@motor-comm.com>
Date: Mon, 28 Sep 2026 09:45:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 1/3] dt-bindings: net: Document Motorcomm
 YT8824 PHY package
To: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com, jie.han@motor-comm.com
References: <20260924075048.4060414-1-kyle.switch@motor-comm.com>
 <20260924075048.4060414-2-kyle.switch@motor-comm.com>
 <20260924-vowed-roulette-abda42cec444@spud>
 <c78999ec-82c5-4719-9358-5dbded43ccdf@lunn.ch>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <c78999ec-82c5-4719-9358-5dbded43ccdf@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/25/26 03:16, Andrew Lunn wrote:
>>> +$ref: ethernet-phy-package.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - motorcomm,yt8824-package
>>> +  phy-mode:
>>> +    $ref: /schemas/types.yaml#/definitions/string
>>> +    enum: [ internal, 10g-qxgmii ]
>> This should be after ref, but also have a vendor prefix.
>> Additionally, the qcom ethernet-phy-package user also has a mode
>> property. Net folks, should this be made common?
> phy-mode is definitely wrong, it has a different meaning, and reusing
> it is just going to cause confusion.
>
> qcom,package-mode does have the same meaning as what is trying to be
> expressed here. So yes, a common, vendor independent property would
> make sense. It maybe should be in ethernet-phy-package.

Ans: okay, In the next version, I will revert the previous

         implementation and follow the qcom,package-related approach.

>
> 	Andrew
