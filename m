Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182630;
	b=Wyq603LrM7Ud/gaCIaa2QMPI11o4mRZhHR30wrEF+eH7LKL6hxBCK94gUHNaVoDXJuDK
	 zwWBaqb3XLDyQNVqJEXzzG9eOYVPTqL9CWh60OHrkWFtL+vE2iifUAYfbTYpbfPugkr9b
	 ZkWSqTd3MtNxS2vUDSV9XuaplLjNghtjG+PTy6hq9C8+j0H6o2000ODFIYddb/kz9P4DS
	 7BeRkYqXi8ZqMi/pKsBNoKIqylvYK12PS9KlU3DRRHKYcs01G9xGgMciQaESZUrzC2OuD
	 Sgk5/wbSE2YBKs7jpmfIRcKqbfeQn+vDB8/R1qrpeTvZ+PuldvhhH18uITf9L6VwrWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182630;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=3qRMp8vNhDyi1yKm8uF+4jffdcF8jj7SXyxOJ/lqInc=;
	b=wJiYKehPUW9SJBdnahKS10RCpC+hbkPLbN9n2z8bnYK7t5bIf4arfEUJbaMQhh7vzHm8
	 EY9KygO0sZF1LEB7LG4yKoDbraRNpAHYIzrZegiderizHxSQuiE3oMtTcspYkhI4qJvwz
	 A9ll7mGX6ftTPBuJGaZqQNZwjeY1rI32COKknIWS4Req2FJrJcNZSjyB09SeT2hu5jtz9
	 fNmw1y2lypIQUWKvVTJoSd12qu8btYFQpOceGAOx+gaRMGhXlwyhdyklna6cE/WODuIbr
	 RPuypJmYr8SMzzWEbSdlgs5Y4AqzDz5m/hlJwhnjaUK4PjIB85TAK/YAD3+t1gHG8+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=en099myg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296FD606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=en099myg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072EF1F031E6
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182630;
	bh=3qRMp8vNhDyi1yKm8uF+4jffdcF8jj7SXyxOJ/lqInc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=en099myg5Z7rmETpkfFcW1PdgQI8wvHsCbAIPp0Ru+cPg4hoNKrbWHNj+apx5fGHq
	 VvcP9trwcYvL/7Wtmmf/gvBtxBp01srTPEY72teIqSWwZSRgKC5IUm3DB+r6+Ha7g4
	 PxtrZsMCwxZ7tH+uMLGQLWa2Q+hYTQKUpg02ficXnCjFbeEBog/mCqxTFKjNa6XgVO
	 +EgGH5klFny7xUgqfJ7u7XJP5RPg8Hgvx5ScU22jejE3WFIx7/ZzTF51MgQzeZvkIF
	 +Pgmz4OhD/w3xEoGklsL6+qWP8GZkQMFyEmL0wOrDGCzbEVQQrfQuUdjY/Q77U2K3f
	 er9cOkKFQUjvw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so718510e87.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:17:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz+gueW3b1v40k3q9ZFWOwofJg/ogvx7wyucmAqpfLcKaJcLpBnTUJXLueryPscasNu0yW+bAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYJh7MEO+gqV7urEoO+joJJ7DIAcZ/1GpxQjqdV/MSlb9hsEaRlr
	4xjWFYxJkqt0kL4YZSyKhKCtigda2tIjp2YYhCftlZrQkRNvFBdDwgPo6OKSNnGRMJGIgu85Rpw
	UnbQATu0EHGBQWKeUQkY24Ot5wBGYuTzOVOdMsJRnTw==
X-Received: by 2002:a05:6512:31ca:b0:5bf:a467:32a6 with SMTP id
 2adb3069b0e04-5bfcaddfdb8mr665735e87.39.1793182628721; Wed, 28 Oct 2026
 03:17:08 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:17:07 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 03:17:07 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <auHKt_hdMPaolIR8@QCOM-aGQu4IUr3Y>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
 <20261023-sa8255p-emac-dts-v1-2-a34d778ce9ac@oss.qualcomm.com>
 <at8Q9umfE2AP24lI@QCOM-aGQu4IUr3Y> <CAMRc=McYTWmV6iAbm97C-xs1vh9Atvy-LivQBW10iHQh5+rPzQ@mail.gmail.com>
 <auHKt_hdMPaolIR8@QCOM-aGQu4IUr3Y>
Date: Wed, 28 Oct 2026 03:17:07 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdT4KYz-yVd4ULep-4vnw4_zUN=Q+CY-sN1kzTGAgtCLQ@mail.gmail.com>
X-Gm-Features: AclHuK-WZr3O4JGEIA0zeVydP0kq-elnzPigNZ1OD5X0bmCwX3ayBZNoA3xdKFc
Message-ID: <CAMRc=MdT4KYz-yVd4ULep-4vnw4_zUN=Q+CY-sN1kzTGAgtCLQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: lemans: make the emac compatible
 specific to the embedded variant
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Oct 2026 11:13:11 +0100, Shawn Guo
<shengchao.guo@oss.qualcomm.com> said:
> On Wed, Oct 28, 2026 at 01:25:34AM -0700, Bartosz Golaszewski wrote:
>> On Mon, 26 Oct 2026 09:36:06 +0100, Shawn Guo
>> <shengchao.guo@oss.qualcomm.com> said:
>> > On Fri, Oct 23, 2026 at 11:02:23AM +0200, Bartosz Golaszewski wrote:
>> >> The embedded and gearvm variants of the ethernet MAC use different
>> >> compatibles so move the one for sa8775p into lemans-embedded.dtsi and
>> >> make place for the gearvm variant to be placed in lemans-gearvm.dtsi.
>> >>
>> >> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>> >
>> > Do we run into any problem if lemans-gearvm.dtsi simply overwrites
>> > the compatible without this patch?
>> >
>>
>> Technically no, but then lemans.dtsi is incorrect as the MAC compatible depends
>> on the firmware variant. I'd move it if you're already touching the files
>> anyway.
>
> This will be inconsistent to what we generally do today for both
> Lemans and Nord, i.e. we are defaulting compatible to Embedded variant
> in <soc>.dtsi and overwriting it as needed in <soc>-gearvm.dtsi.
>

Hmm. I don't think I have the authority to make this decision so feel free to
leave it out for now.

Bart
