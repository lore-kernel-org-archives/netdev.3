Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E1F47010D;
	Wed,  9 Sep 2026 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987863; cv=none; b=hStVDwXO7HM2tF4BIUcWLKGLnj8emNBZqr4wMiAqE6qtP7FvNjctBA8BC0EfKYds9qIG52WvRNRG9VOolyk1hnfUJdYENj+vvJDNdBW2vc8aYrmQux4Foa6v1FXX95OzVSfAmFlgtGN23OHKyxAFu/SmdLelnOzGacJjegIgjlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987863; c=relaxed/simple;
	bh=ux4LwqZlbuHjN5pDgf+R+mKnPiisvTQFqDbT/x5yXuE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dAbB7JjXvQp8nAs/lt/s973W0BFrP4tX88qjCoeiU+QDQGJqz7zf3I85OjxSHMgk6lgld0dkOwRs9p/vEz7EQVuA964QTdLHbGuk+g+F6xCo5zeN1j/Lc2BkRsjZxDyFDWzcDrYfdhtX6UO+CVj8djMjp93FovjCUJurbgEW3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kflyLVDU; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kflyLVDU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2yofm2bllvcebmrjy3frax4z3q.protonmail; t=1788987854; x=1789247054;
	bh=P91JSApwUvPyWA9CkkLfouUbbAesRpLSdan/W/e1NLc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kflyLVDUd+HQMXYvAACOjgkarCgP+mmFkRMoSd9fUdmqTUY1pbe7/o+bZjzhKNEs1
	 GsiXJ2VniwDyxkYH5twLDlQl3Jenxb6RZdPHmnZnN01XcTEjvRK9qTH7bWFT8SwL6D
	 YBdDibUGVVPY/gRznESkCYqozO8+Ph1CCfdVRYyWcLl7h3wv7Wivdabk50pdzlm9Bh
	 9xfhunZH79+W1j/Gko1RuKmQrhY+1CGQshIIf9IsM/De6yDTdaYP4RUmi23VUghx6G
	 os8sL2x+Y1z1V61EeiETk5ZQOGNGRXRBOWL/krHoV2iXMmwTTtgJBBhaYtx46mf7wm
	 Jewj0gYlYHNvg==
Date: Wed, 09 Sep 2026 21:04:05 +0000
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Nazar Kompanets <xlie7669@gmail.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sm8450: Add IPA node
Message-ID: <530a28fb-28da-4ee0-9c77-6bac7ea6c047@proton.me>
In-Reply-To: <kirwxhjjskimczzf7fv6go5b4j27qouqvj27n7vckd4vkr3rkd@tf2ugwqbp3kc>
References: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me> <20260909-sm8450-ipa-v2-3-2deb8b4e91a5@proton.me> <kirwxhjjskimczzf7fv6go5b4j27qouqvj27n7vckd4vkr3rkd@tf2ugwqbp3kc>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: d485751c4d99f1bb18b42b75c245d66e48bc113a
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 9/9/26 4:06 PM, Dmitry Baryshkov wrote:
>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/=
qcom/sm8450.dtsi
>> index b8793482b181..95b6fd22a846 100644
>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>> @@ -2625,6 +2625,47 @@ adreno_smmu: iommu@3da0000 {
>>  =09=09=09dma-coherent;
>>  =09=09};
>>
>> +=09=09ipa: ipa@3f40000 {
>> +=09=09=09compatible =3D "qcom,sm8450-ipa";
>> +
>> +=09=09=09reg =3D <0 0x3f40000 0 0x10000>,
>> +=09=09=09      <0 0x3f50000 0 0x5000>,
>> +=09=09=09      <0 0x3e04000 0 0xfc000>;
>> +=09=09=09reg-names =3D "ipa-reg",
>> +=09=09=09=09    "ipa-shared",
>> +=09=09=09=09    "gsi";
>> +=09=09=09iommus =3D <&apps_smmu 0x5c0 0x0>,
>> +=09=09=09=09 <&apps_smmu 0x5c2 0x0>;
>> +
>> +=09=09=09interrupts-extended =3D <&intc GIC_SPI 654 IRQ_TYPE_EDGE_RISIN=
G>,
>> +=09=09=09=09=09      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
>> +=09=09=09=09=09      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
>> +=09=09=09=09=09      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
>> +=09=09=09interrupt-names =3D "ipa",
>> +=09=09=09=09=09  "gsi",
>> +=09=09=09=09=09  "ipa-clock-query",
>> +=09=09=09=09=09  "ipa-setup-ready";
>> +
>> +=09=09=09clocks =3D <&rpmhcc RPMH_IPA_CLK>;
>> +=09=09=09clock-names =3D "core";
>> +
>> +=09=09=09interconnects =3D <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI=
1 0>,
>> +=09=09=09=09=09<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG =
0>;
>> +=09=09=09interconnect-names =3D "memory",
>> +=09=09=09=09=09     "config";
>> +
>> +=09=09=09qcom,qmp =3D <&aoss_qmp>;
>> +
>> +=09=09=09qcom,smem-states =3D <&ipa_smp2p_out 0>,
>> +=09=09=09=09=09   <&ipa_smp2p_out 1>;
>> +=09=09=09qcom,smem-state-names =3D "ipa-clock-enabled-valid",
>> +=09=09=09=09=09=09"ipa-clock-enabled";
>> +
>> +=09=09=09sram =3D <&ipa_modem_tables>;
>=20
> No qcom,gsi-loader / memory-region ?

Right. I forgot about this change. I'll add those in v3.

>> +
>> +=09=09=09status =3D "disabled";
>> +=09=09};
>> +
>>  =09=09usb_1_hsphy: phy@88e3000 {
>>  =09=09=09compatible =3D "qcom,sm8450-usb-hs-phy",
>>  =09=09=09=09     "qcom,usb-snps-hs-7nm-phy";
>=20
>=20
> Also the device is disabled by default. On which platform did you enable
> it? Is it supported upstream?

Yes, as it should be. It has currently been tested as working in:
- sm7475-realme-senna
- sm8450-oneplus-negroni
- sm8475-motorola-bronco
None of these devices have device trees upstreamed at the moment.
I plan on eventually upstreaming support for motorola-bronco.

Regards,
Esteban

