Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FDB5452BD;
	Wed,  9 Sep 2026 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953415; cv=none; b=p89JHP/UsD7ymhnMYRXlHnec5AVoKBW8m7BC/v9onOcjBWltWga6gx2ITvHDJ0oOwlJonz91U9Kxfa58nGOxq2TWe7eFQZvmsQEUqEFddllsTtbC4nwhc9zTYZ3vuAzVZQErfDdje/BsYu3fXprABcge6zYh3ZI1LijBzkVhbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953415; c=relaxed/simple;
	bh=fkEYmLZdN32k5AMFaNhqmEaA7/FEsVAeDNxA8L1bqGo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qw1v/2BUs5tYvIhDRQKSCEoYSZ6EICMuoW/7IH5o62uGzVluoIDRPidzYOepmKaapP3j83vEe6PVnKBt1sTKBka2LjvSNu9bGeB7lIptRGMXOcGov9R+vWAG5gPableoh71RNC7DgyBP5g8Yl6hfvit1UqPEAgfOCpGVGI8OFww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gz7LElvN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gz7LElvN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D551F00A3D;
	Wed,  9 Sep 2026 11:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953413;
	bh=U9/PVisJndqXPVEBJYwCPRJvkMsp2nPsLH4JBynlXe4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=gz7LElvNAhIlmxcKivVP/vLctwmkAOdr1uUB3wIOH2FlHkWN6afKWKUb6pdmOIrZt
	 92NIY69r12Ds5vwcRpKvgKl2r8N/Pw2Buz4T4D8ILfioCx+HNbwINkutG/iqmhvg0F
	 fkwKmjJqdHz/ulqLrKCrJ/lajMD1I2P3+uLU2T9GqVVlkRqT60Kkpp6C4OTUKm5v57
	 LDFG1zRjIOEkii+wXT8pXrn3aftiXCmdHFo77HmJdqgSIqFTGIQMnGGBxFaF1ymSYQ
	 a+92wQRESKFsergPCIelyxdgKdMzrgIcnL4AbQS0LU2rJ0Z+kFTKA4Zv++S08buVqR
	 0zwMgETTaT8Nw==
Message-ID: <98602703-4a1c-4e91-b7bf-934bb9894eb7@kernel.org>
Date: Wed, 9 Sep 2026 13:30:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PRELIMINARY 1/5] arm64: dts: qcom: shikra-iqs-som: fix
 GPIO138 reservation
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
 Anurag Pateriya <apateriy@qti.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <20260908-shikra_ethernet_dts-v1-1-69c0c5c7c124@oss.qualcomm.com>
 <4aee70eb-bd1d-4320-8921-e55bb8e0d176@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <4aee70eb-bd1d-4320-8921-e55bb8e0d176@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/09/2026 13:24, Krzysztof Kozlowski wrote:
> On 08/09/2026 08:23, Mohd Ayaan Anwar wrote:
>> The GPIO mappings on the IQS variant differ from the CQ variants.
>> GPIO138 is connected to the RGMII1_RX_CTL pin rather than the NFC ESE
>> Secure IO pin; the latter is connected to GPIO49. This incorrect
>> reservation causes the probe of the second Ethernet port to fail:
>>
>>   shikra-tlmm 500000.pinctrl: error -EINVAL: pin-138 (5d20000.ethernet)
>>   shikra-tlmm 500000.pinctrl: error -EINVAL: could not request pin 138
>>   (GPIO_138) from group gpio138 on device 500000.pinctrl
>>   qcom-ethqos 5d20000.ethernet: Error applying setting, reverse things back


Apply this patch and reproduce it. Is is possible? Didn't we talk about
this already?

>>
>> Replace gpio138 with gpio49 in the reserved list.
>>
>> Fixes: 779aead2dace ("arm64: dts: qcom: shikra: Add gpio-reserved-ranges to tlmm")
>> Signed-off-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> This looks duplicating:
> https://lore.kernel.org/all/20260820085347.822-1-xueyao.an@oss.qualcomm.com/
> 

Ah, no, mixed patches. Duplication is between other works:
https://lore.kernel.org/all/20260820085347.822-1-xueyao.an@oss.qualcomm.com/
https://lore.kernel.org/all/20260826-shikra-dtpm-v4-1-8476223184de@oss.qualcomm.com/

But nevertheless I am sure we talked about this, that commit msg and is
not accurate... Cannot find the thread, though...

Best regards,
Krzysztof
