Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071B3815F8;
	Sat, 12 Sep 2026 05:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789190453; cv=none; b=M0GWsNotlvMdoykBL8A7o8/Sb6O9L41sBEQ2vOFMMaJxNtuvjFCOWLwyYG0XOgH0k1q36NrkE+nDWfwJTqt0kjH2FLu50JK/ki+ztUaS2Gi5MIghCLtovRgjl1FRYzsuBLm5yGlvLGy/updXs0qcZWgsD+qbN+mUweYJ8uYTuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789190453; c=relaxed/simple;
	bh=mR6Q5RZHvsQGq5YvVFmbEtdcSrgyoxHb3FERz37bFLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIhM43oWwdw/T0tVY8sfS2he9i6rs9Qt6+LZhvb8CsKD4rmIFFwq4EDlVfN9XFoyaRFnORbQVNO1lmb1aNTli9vYei0gH3voZr/2yUP7tJfDb05XSlwKlj9qDl3TbkQx7Mb6FtYtb+H+EnjvygPMTdve7GSoiGTRZkg6UyLiJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07967059|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.112433-0.0109105-0.876657;FP=16853552404067528017|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.jBq95gv_1789190429;
Received: from 10.10.26.192(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jBq95gv_1789190429 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 12 Sep 2026 13:20:37 +0800
Message-ID: <01f40bbc-4686-44f9-b9fb-7a334c0327c5@motor-comm.com>
Date: Sat, 12 Sep 2026 13:20:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 2/2] dt-bindings: net: Document Motorcomm YT8824 PHY
 package
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
 jie.han@motor-comm.com, wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
References: <20260910074624.2426899-1-kyle.switch@motor-comm.com>
 <20260910074624.2426899-3-kyle.switch@motor-comm.com>
 <20260911-metal-muskrat-of-finesse-1abf97@quoll>
Content-Language: en-US
From: Kyle Switch <kyle.switch@motor-comm.com>
In-Reply-To: <20260911-metal-muskrat-of-finesse-1abf97@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/11/26 16:44, Krzysztof Kozlowski wrote:
> On Thu, Sep 10, 2026 at 03:46:24PM +0800, Kyle Switch wrote:
>> Document Motorcomm YT8824 PHY package.
>>
>> Motorcomm YT8824 Ethernet PHY is PHY package of 4 PHY-s.
> One sentence is enough. "Document foo bar, a baz bam something".
Ans: will be removed in next patch version.
>> Document the required property to make the PHY package correctly
>> configure and work.
> This is redundant sentence.
Ans: will be removed in next patch version.
>> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
>> ---
>>   .../bindings/net/motorcomm,yt8824.yaml        | 63 +++++++++++++++++++
> Please organize the patch documenting the compatible (DT bindings)
> before the patch using that compatible.
> See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46
>
Ans: okay, the next patch version will swap the order of the two patches.
>>   1 file changed, 63 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
>> new file mode 100644
>> index 000000000000..9907a4a7e63e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8824.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/motorcomm,yt8824.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MotorComm YT8824 Ethernet PHY
>> +
>> +maintainers:
>> +  - Kyle Switch <kyle.switch@motor-comm.com>
>> +
>> +description: |
>
> Do not need '|' unless you need to preserve formatting.
Ans: will be removed in next patch version.
>> +  Motorcomm YT8824 Ethernet PHY is a PHY package of 4 PHYs.
>> +
>> +$ref: ethernet-phy-package.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ethernet-phy-id4f51.e8b8
>> +
>> +  motorcomm,interface-mode:
> Aren't you duplicating protocol-names from
> /schemas/phy/phy-common-props.yaml?
>
Ans: will be fixed done in next patch version.
> Best regards,
> Krzysztof
