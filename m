Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42623E325;
	Wed, 24 Jun 2026 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782266273; cv=none; b=G1LFhmebGEy3efnwj8VYUaR5MCupj3RInyzZjuyuA1+4e2YMIr4DlVH8z9Cg/10HMGCG5XkVuhCmpvn/YgQOIzN+wu4IC5J7PPRXLwf8Bfr6O0nFoFrcxSjel/tiM/O14JKI0yzsH8R/ZFd0fEjpoJO+Y1UXVZCte0tDZB04KPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782266273; c=relaxed/simple;
	bh=xF3sFcPi0EOxkKDjR9PcSPmEdFj8kGYq0amzycQg8rk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qf7GyBISszJvWnHFBz07+TWFGAmgQjGUJ3ZhhdNlpUWXo4KzuI3eudkGiAwuI11JKAl9Xgr0kKueVSmcj7uJ9/Uq9uaPO/MQEBBtS7Oxfro9XFFGsHJ5KQNz0at1YgT9ZigoEjqo5l3rJg5Mmuqec6x/N/B7Tyh/0TdyV6NNn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GcBxWjgR; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GcBxWjgR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=fgadyb3edffxfnzbdpg4if4jyy.protonmail; t=1782266261; x=1782525461;
	bh=FMYU/AuXJxQ3vbFR2572qW7X6ukHUbrFodSqJLoxnxg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GcBxWjgRU9f7HNFgFeGY8Ep1nORqIQNwsFPCnRuGHzEPeqrGhhIMNRcfNFhjjJM4E
	 A1gVRBBSJG7g/4pZq4FlkQruvB1zZ3I6dBrVO4KwaLx46Q2/V/NCkPuRv6y53XAy12
	 cOXOgSYmW8+6h9EHS8TqWFDw1tVC9MadVdlzmtzkbgCvpCjv5LTwgP5KbCAkVNFebT
	 mZB2JKUW6zPXPWy/Ek74wJyhpnRB8NKHW5nPlnvTF0pPojTqqLUCjm0L0w4DTGM5zk
	 Voz7fMbZQaY1ayxwbM/1IiOQFjjGMRO0f4yKhz+CZEdZz7mvTZvfmDLAel2HQB5u0+
	 qNUniHoh3YnZg==
Date: Wed, 24 Jun 2026 01:57:33 +0000
To: Alex Elder <elder@riscstar.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] SM8450 IPA support
Message-ID: <48c624c3-5408-4862-b4ec-9321ad279bf9@proton.me>
In-Reply-To: <959db395-ae71-4a50-bd46-ac5add545a52@riscstar.com>
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me> <959db395-ae71-4a50-bd46-ac5add545a52@riscstar.com>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: 6d2e7d5a8228660f0c093f05f6ae7dd76fdff2b6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/23/26 11:56 AM, Alex Elder wrote:
> I assume you have implemented this based on what you found in
> some downstream code.  And if so, could you please indicate
> where to find that (so I can do some cross-referencing myself).
> I no longer have access to any Qualcomm internal documentation.

Hello. Yes, that would be the case. What I used goes as follows.

1. My personal findings regarding IPA:
https://gist.github.com/esteuwu/bd49ed67ed9290f41612bdae1cacb5bc

Note that these may be subject to errors since I mostly cross-checked
values to get here.

2. SM8450 downstream device tree:
https://github.com/LineageOS/android_kernel_qcom_sm8450-devicetrees/blob/li=
neage-20/qcom/waipio.dtsi#L3304

3. SM8475 downstream device tree:
https://github.com/LineageOS/android_kernel_qcom_sm8450-devicetrees/blob/li=
neage-20/qcom/cape.dtsi#L2624

It's worth mentioning that between SM8450 and SM8475, IPA SRAM size is
different, so I used the smaller SRAM size to support SM8475 as well. Hence
the reason why I included SM8475's downstream device tree as well.

4. SM8450/SM8475 downstream IPA driver:
https://github.com/LineageOS/android_kernel_qcom_sm8450-modules/tree/lineag=
e-20/qcom/opensource/dataipa

Most of my cross-checking came from the source code in this folder.

Finally, for some values such as qmap, aggregation, tre_count and
event_count, I had to cross-check on the same folder that all
ipa_data-vX.Y.c files reside, since I couldn't find any reference to these
values in downstream code.

Regards,
Esteban

