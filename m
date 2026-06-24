Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079A238171;
	Wed, 24 Jun 2026 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782265946; cv=none; b=OI+8602AHFixYyMRVBS6vthJw8Dsjbo9QlNOZKUIxAACU/pwZVMTplFD4C3j0AZ2ZPsnfV06QftmRhq7trCh2bxNNd8Ilo5cIN/f1MnLWzTHBz83XqAH/tccr1kJ1c7C055N37JMgg6Hk3QdjrlXBU30XWIGEnG/+XlC1n95ryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782265946; c=relaxed/simple;
	bh=kUWgSY2kxKAcWmKIuycXxqSBSlQg+3S5pklblzvoN5Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohYm8+L5ux9O5Wahzv9o27rCARkUpdOJUvxUObKrFVl4qAyyDExH6v1ErhcYYj1W/qnpmUnok45vQ6tqbCuOZrPkhlN3mRMVnJHmLmoV3v6H7i0aQ7+syBDCNIUnqmZK1YqAyXmsDtkS5b6opg2bKPfrrHFJrvtIPhyekrViL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GhsNbA05; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GhsNbA05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1782265934; x=1782525134;
	bh=kUWgSY2kxKAcWmKIuycXxqSBSlQg+3S5pklblzvoN5Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GhsNbA05s08p64h/BiqmkBpmUTA9uutN1cZpEhSDKGxr7lTpH0FP9dBRUu/dXRw8I
	 e50osvcWKAbQcFBJ5ds2q2J5JdB7iQyj0n1z94BKqzbLqyfajwWaC/wcN2EnzhJFPs
	 PUmFwE/raz6PYMQ06PUExb7FJAMQogByK2n+K7JCVXjp+Ds3y5iryEq9HHwCYLLtjV
	 MTXSKTIfjfWnDMwGiAzl0LwFGETBiYxpPXS9VH7KMBDUOYrQRVK9ydU+3k1qYFdk0V
	 Yr6Pd2/Lc5DZ2u7U/MvSOShLSb6vz14XJsRePLq4yJUu8a9GyUNH3nMVa2wcsuixyD
	 Aa/9sDYSYv+8g==
Date: Wed, 24 Jun 2026 01:52:07 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8450: Add IPA support
Message-ID: <b1f872f5-66cc-45fc-ad42-c308f8970691@proton.me>
In-Reply-To: <806046b2-20ed-437e-a7e6-b3c0699f5a2d@oss.qualcomm.com>
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me> <20260622-sm8450-ipa-v1-1-532f0299f96e@proton.me> <806046b2-20ed-437e-a7e6-b3c0699f5a2d@oss.qualcomm.com>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: ea45ab5fb6d49a38f2da8add30cfb2bb0dfe5677
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/23/26 5:37 AM, Konrad Dybcio wrote:
> size =3D 0xb0000 for the RAM and uC regions that the driver seems
> to poke at (at a glance anyway..)

Sorry, I don't quite understand. Could you please clarify?

> base=3D0x1468_0000
> size=3D0x40_000

Noted, will fix in v2.

Regards,
Esteban

