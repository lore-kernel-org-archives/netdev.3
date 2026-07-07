Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF2434E5A
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442091; cv=none; b=WYjBIJ58PcH8qp1x9kHnWj1KpdeTaJjhtQVzMw4l3cexmrr7jzjggDPhvZyH0g3iESTkv3s0PGymNMeWN1unam2zlM5OU6VmoK66P7/03IbWub6dFXqZb+U48ZEQsGtSw2cI3P1mLsN/90/hM72NtK/cF5Qck/jvJSg6LZ9BJrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442091; c=relaxed/simple;
	bh=Mzs8SuveZMo5RAd1ZZoYdnYkNRzqIAba+zrREv7yGOI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EX5UF9PbZGCoVgLBisHlke/Wps3wL9SajOxStgsi+7WMmy5p4sPjkCpN7Q6Xtyi5s/Y0g/BfmMLwO4DHbnwjl677atQkoS/HdnmQcmKMdvwj/VYwZTXZ7tUJ1wQlNYvW8nXdhu4NniDwGBIbE4O+y45hJLnJCzn20yA3u2YtDJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I0uTCUbL; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I0uTCUbL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1783442085; x=1783701285;
	bh=e1mEXN3Io1+cxS8ymD1K/F8t95agWjX3EwyhwfhzKIw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I0uTCUbLfIf/k8Yyl/dFVy5xj2obGWjaPB/uhDp6vua4d5flxTzHvn9BfShSwx7AS
	 +dQFwnNXhHUyyBxh0Yvpqv4KFGwfHc4UNBBxNv/Qex4EPkflfhmp780L2LoozdXQOF
	 lrx9TNBvWZqPnaO4et9/vIfpSclIcb9jhXIeWj0v8ZeKRASeU7J1vZRvvDr1wMKmld
	 HO1ZC+8UMkOiRo4+b4ALvgfi4c9Hg3wA2bMPeMTdUvBw6DtkWmOnKXTZOh3OcINNHx
	 0csB6HJilTIN9jVNGLS3eXMG5qLFRROAZl161JHmgmy7cLGcB1eiW++4UFGSjbW8jC
	 H4bNY9lVExxGg==
Date: Tue, 07 Jul 2026 16:34:40 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8450: Add IPA support
Message-ID: <3b7d997c-ecea-46d1-9e5a-effad3486676@proton.me>
In-Reply-To: <4afa8797-1cb1-4cf1-bdbd-9cb5725377b8@oss.qualcomm.com>
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me> <20260622-sm8450-ipa-v1-1-532f0299f96e@proton.me> <806046b2-20ed-437e-a7e6-b3c0699f5a2d@oss.qualcomm.com> <b1f872f5-66cc-45fc-ad42-c308f8970691@proton.me> <66330ed6-826a-431e-9e8e-f2998af55168@oss.qualcomm.com> <1e151b08-5d3b-4b75-8d71-635617868285@proton.me> <4afa8797-1cb1-4cf1-bdbd-9cb5725377b8@oss.qualcomm.com>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: 2c3f07974c2d266b2db99000671eb75cfc5fb6d8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/7/26 6:35 AM, Konrad Dybcio wrote:
> Yes

On SM8475 I get this warning though:

[    9.551813] ipa 3f40000.ipa: limiting IPA memory size to 0x00005000

Both SM8450 and SM8475 use the same IPA version, so that shouldn't be an
issue.
On SM8550 and SM8650 this area is set to 0x5000 as well.
What should the proper solution be?

Regards,
Esteban

