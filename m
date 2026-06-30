Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BE2F8E98
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784646; cv=none; b=X6GSMyFGhpUt5hTnQaU/JrG5/EXSChcNSVuQ9/x9HT0aWdLjSS/TsqEXzTCZBwEndrtDvdk9pMhW8R26kNO3bmG6M/ygwSoeUObBWBMM57MtRuS7nIsW1WFdUfc3KrgcHHVoy/YGo5utt3SxQNFCX6Vdd49MN69kVQEfsSvdr/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784646; c=relaxed/simple;
	bh=ZfoG/+QKnrfYCirFVYlyh+Zu0G4dZxrFIRndgI2AFW8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwCOjZxfKQtrdx0b0koSM8eo5X11+A4QnWjMeTxOxckVp6y5IoK+OxrKB7aqMke2VoJwU16jDoje8AmSkw4rM0UqEUvPhKhRynF2RRsBw9NNy7Cpm8lsPuYaMMGNx80K35R3uJLNHe8vIeAeYRv8JaU/kGvBitDKfKbWTVz3wYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NevV1SaL; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NevV1SaL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1782784633; x=1783043833;
	bh=abt1Km3rhqF/kozSRmSM/863AzbKoF9WEhHJyA3rzFI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NevV1SaLMK9EaM/8nsFnFZqmVS2NBh1OjbbzFxFVfaaOGt2TJyiSfTafSqCRb/1kC
	 ZfP4lVW08oP0eo3RQInrKxi3uafn98+8QY+w6IdzssFXST+uWCJ7nWbRxX+Z9lyF3u
	 BvFeUc/CIqTVBY9/10ejOnclnllSYGV/py6k2bAoKU9c0/tx23FewiEiGJqACI+PCg
	 dubck7cR7AtA09b6b6XbOzBvlc3qfcsgNWZNTzanOjdHEVaOFxWccD4YX/SFo9SIuz
	 GxsUHbeCav/RZ81bTCyhL2+bWopMEaQGzig6aZpcMFy30JBXkJJ8wUP/v7+pYvbrCM
	 rwjn9Swv8rdtQ==
Date: Tue, 30 Jun 2026 01:57:10 +0000
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sm8450: Add IPA support
Message-ID: <1e151b08-5d3b-4b75-8d71-635617868285@proton.me>
In-Reply-To: <66330ed6-826a-431e-9e8e-f2998af55168@oss.qualcomm.com>
References: <20260622-sm8450-ipa-v1-0-532f0299f96e@proton.me> <20260622-sm8450-ipa-v1-1-532f0299f96e@proton.me> <806046b2-20ed-437e-a7e6-b3c0699f5a2d@oss.qualcomm.com> <b1f872f5-66cc-45fc-ad42-c308f8970691@proton.me> <66330ed6-826a-431e-9e8e-f2998af55168@oss.qualcomm.com>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: ef11aeb475485be296f237c5a719643ca92d8730
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 6/29/26 10:18 AM, Konrad Dybcio wrote:
> Please alter the size of the register range that I mentioned this under,
> as the range is wider than what you specified - the driver takes a big
> offset from this base and accesses far outside the bounds of that range
Just to make sure:

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qco=
m/sm8450.dtsi
index dd151a2c48ec..100daf8120ce 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2643,7 +2643,7 @@ ipa: ipa@3f40000 {
                        compatible =3D "qcom,sm8450-ipa";
=20
                        reg =3D <0 0x3f40000 0 0x10000>,
-                             <0 0x3f50000 0 0x5000>,
+                             <0 0x3f50000 0 0xb0000>,
                              <0 0x3e04000 0 0xfc000>;
                        reg-names =3D "ipa-reg",
                                    "ipa-shared",

Is this what you're referring to?

Regards,
Esteban

