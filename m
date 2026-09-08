Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7403F99F4;
	Tue,  8 Sep 2026 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856857; cv=none; b=SDthw1Z9Pi9wjmALgQoO0+gpq0ioLibRypHVEU/dCO/IU/hq9zl4a394O24KbRoqSfzGFqxzZUFB/nMj1ovkwGt3jDtbwIoCp2Obtdkk2ylyFBbHbhSyhTF8MVtNiAOXG3GCkwx5pnIylazReJIKUzwoRKqqxnJAySTDjdzO/CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856857; c=relaxed/simple;
	bh=oPG8VBNrRlqipsMmtZpmQ3beL9mc/4dKsNEBMmlHVzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1L5eavygcg3bbt6Gn1711bUIWGN4hOVHgufFTd9D2jz5p94RgUaAP4mdaCrNzWYmpk64KNgxs/jawBXxVRUKhl5MHbQR6z6G0dia8jEr/4op73nqseyQ39jGRAiFbdaJRsNdf3vLaEHiLkNU7qjze1NoNH8FcD2MA60MtWSQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhWtAtE0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhWtAtE0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B582E1F00A3D;
	Tue,  8 Sep 2026 08:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788856854;
	bh=jSuLEe6P7QY7UzfjfsGtEwmzDfa2TYxR0HKzgMeZmUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PhWtAtE0KEcCG98o1pIsJJ6a3rK1l6z+R9VmbKYDRmWiJcQ3H0AblQV9Q9DElj/K2
	 9DdzrzLxjLdApNdLM5QUyNugyFFw3OpDQ3rGJIwApIPTmloOgJ4C85emmurItDWD5i
	 KtLG7BXjtOJyH/OExhNyJWsWvtAAc1qDz9RGM1CIVa47QMf9LbJifJPgdWxenngJPk
	 5F8/5FStfc87d42IPU0eROCZahzFTosbELD41d7O7oqz0dAHcUBuiOuFKpS/go+2GX
	 c4N9bFWmyax34NmoGtTAxqi6OSRqXWt4zirCd0S5zCmHshCYwoEQ/pAIAjfISq1yDB
	 U9/X+prdEhmdw==
Message-ID: <fd428d1c-646f-47f1-9fbb-91f3b50760dd@kernel.org>
Date: Tue, 8 Sep 2026 10:40:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH PRELIMINARY 0/5] arm64: dts: qcom: shikra: add Ethernet
 support
To: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
 Anurag Pateriya <apateriy@qti.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260908-shikra_ethernet_dts-v1-0-69c0c5c7c124@oss.qualcomm.com>
 <e9388ffc-ddc8-456f-ad7f-1d185d35ab69@kernel.org>
 <ap+zd/2QmerMwi0o@oss.qualcomm.com>
 <c23369fc-84ff-4881-8327-c18fc3692306@kernel.org>
 <ap+3+Xhq6ygnPzQ7@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <ap+3+Xhq6ygnPzQ7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2026 09:23, Mohd Ayaan Anwar wrote:
> On Tue, Sep 08, 2026 at 09:14:45AM +0200, Krzysztof Kozlowski wrote:
>> On 08/09/2026 09:04, Mohd Ayaan Anwar wrote:
>>> On Tue, Sep 08, 2026 at 08:56:39AM +0200, Krzysztof Kozlowski wrote:
>>>> On 08/09/2026 08:23, Mohd Ayaan Anwar wrote:
>>>>> Hi,
>>>>>
>>>>> This preliminary series adds the DTS changes required to enable
>>>>> Ethernet on the Qualcomm Shikra CQM, CQS, and IQS EVKs.
>>>>
>>>> What is "PRELIMINARY" patch in upstream? Where is this process
>>>> documented or expressed?
>>>>
>>>
>>> My apologies. The code is ready, and I was hoping that sharing the DTS
>>> changes would make reviewing the driver and dt-bindings a bit easier.
>>> The original RFC had them together, and I split it out for net-next
>>> and linux-next.
>>
>> Yeah, but why calling it completely different than every other patchset?
>> Why coming with different style? Why this cannot be RFC?
> 
> Agreed. In hindsight, this should probably have been an RFC v2. I saw
> some recent series using a PRELIMINARY tag, but I see that its

Where?
https://lore.kernel.org/all/?q=s%3APRELIMINARY


Best regards,
Krzysztof
