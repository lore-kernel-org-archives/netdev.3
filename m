Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C12F5337;
	Wed,  9 Sep 2026 03:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923515; cv=none; b=ZsM73wN/p5naqFnztsXZraxPnNXwwykBziILlbrtPIsaXDiFfeUtn7WkMRoiUz2F2lDI4R2sHeMaRtT0v7TDfWZtuObKfFcShY1GN1Wq8inm3UDmsN8plccDCr+WeFYQdTBS+8dANzTzQireonOCXWmAGW0ksN6+P6E8KqzaIUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923515; c=relaxed/simple;
	bh=X7A6ojzz9jLweLIbQWl37phoYRhtbnjKLl8m+DfmcRQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y78fCh4eSiBPs5CJ0IktciEd9VHoOF0/Ka1e1JZFwbt9ZlRPWgp+cyuO38bD/MYPUMJoeS8/LopFGXBP+jRq57aqPjOQYcwXWTO1BfJI8LUD3TqbxKWJIjKnCRu1nyw9RRiuaRBVqT+nrEIA5zJLYt8NBKTQ5exJMBZMd6Squw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZewXl7t4; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZewXl7t4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788923507; x=1789182707;
	bh=uTyRo5++uD9VOWNFI9Qj67BwgOEdeIX49Io4VvHWzn0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZewXl7t4iN6BherGDbIJyRFYRNdCqFL+LTB4QXlA+/Wz4aqmZfZY6Bed1oAmHT0Df
	 bE3COl5Uo5nkh0prXonKuN/xAKJyEUhDDh1/Ct2aIngae8d7w5WLvAfG7FARa0glyQ
	 1E+4CIiswxP3AHiaQ4qQ/6nCj/AhSZccttTAs3jmDEh4dyFqqWABV1gBIz2p4l/R5X
	 ELrWmQB05iXJBgnGdRYz/CTrMZ/e+j2s/eP3FCkHLsEuvAcP85tShknUNExMoBYup7
	 +4ihSw8ohw2iZEDKcYwDtYSVVLVNznD3P0xZ69OL+iAmlQdM8dn4NrQHAefuLQqJYW
	 m7CMYgNir5BJA==
Date: Wed, 09 Sep 2026 03:11:39 +0000
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: Esteban Urrutia <esteuwu@proton.me>, Nazar Kompanets <xlie7669@gmail.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm8450: Add IPA node
Message-ID: <20260909-sm8450-ipa-v2-3-2deb8b4e91a5@proton.me>
In-Reply-To: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
References: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: 07fb0d36c9eba0c0c5ab037e212d75d3f31050e9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add the description of the IPA block in the SM8450 SoC.

Co-developed-by: Nazar Kompanets <xlie7669@gmail.com>
Signed-off-by: Nazar Kompanets <xlie7669@gmail.com>
Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 59 +++++++++++++++++++++++++++++++-=
----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qco=
m/sm8450.dtsi
index b8793482b181..95b6fd22a846 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2625,6 +2625,47 @@ adreno_smmu: iommu@3da0000 {
 =09=09=09dma-coherent;
 =09=09};
=20
+=09=09ipa: ipa@3f40000 {
+=09=09=09compatible =3D "qcom,sm8450-ipa";
+
+=09=09=09reg =3D <0 0x3f40000 0 0x10000>,
+=09=09=09      <0 0x3f50000 0 0x5000>,
+=09=09=09      <0 0x3e04000 0 0xfc000>;
+=09=09=09reg-names =3D "ipa-reg",
+=09=09=09=09    "ipa-shared",
+=09=09=09=09    "gsi";
+=09=09=09iommus =3D <&apps_smmu 0x5c0 0x0>,
+=09=09=09=09 <&apps_smmu 0x5c2 0x0>;
+
+=09=09=09interrupts-extended =3D <&intc GIC_SPI 654 IRQ_TYPE_EDGE_RISING>,
+=09=09=09=09=09      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+=09=09=09=09=09      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+=09=09=09=09=09      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+=09=09=09interrupt-names =3D "ipa",
+=09=09=09=09=09  "gsi",
+=09=09=09=09=09  "ipa-clock-query",
+=09=09=09=09=09  "ipa-setup-ready";
+
+=09=09=09clocks =3D <&rpmhcc RPMH_IPA_CLK>;
+=09=09=09clock-names =3D "core";
+
+=09=09=09interconnects =3D <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI1 0=
>,
+=09=09=09=09=09<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
+=09=09=09interconnect-names =3D "memory",
+=09=09=09=09=09     "config";
+
+=09=09=09qcom,qmp =3D <&aoss_qmp>;
+
+=09=09=09qcom,smem-states =3D <&ipa_smp2p_out 0>,
+=09=09=09=09=09   <&ipa_smp2p_out 1>;
+=09=09=09qcom,smem-state-names =3D "ipa-clock-enabled-valid",
+=09=09=09=09=09=09"ipa-clock-enabled";
+
+=09=09=09sram =3D <&ipa_modem_tables>;
+
+=09=09=09status =3D "disabled";
+=09=09};
+
 =09=09usb_1_hsphy: phy@88e3000 {
 =09=09=09compatible =3D "qcom,sm8450-usb-hs-phy",
 =09=09=09=09     "qcom,usb-snps-hs-7nm-phy";
@@ -4957,21 +4998,25 @@ cti@13900000 {
 =09=09=09clock-names =3D "apb_pclk";
 =09=09};
=20
-=09=09sram@146aa000 {
+=09=09sram@14680000 {
 =09=09=09compatible =3D "qcom,sm8450-imem", "syscon", "simple-mfd";
-=09=09=09reg =3D <0 0x146aa000 0 0x1000>;
-=09=09=09ranges =3D <0 0 0x146aa000 0x1000>;
+=09=09=09reg =3D <0 0x14680000 0 0x40000>;
+=09=09=09ranges =3D <0 0 0x14680000 0x40000>;
=20
 =09=09=09#address-cells =3D <1>;
 =09=09=09#size-cells =3D <1>;
=20
-=09=09=09minidump_config: minidump-sram@1c {
-=09=09=09=09reg =3D <0x1c 0x4>;
+=09=09=09ipa_modem_tables: modem-tables@28000 {
+=09=09=09=09reg =3D <0x28000 0x2000>;
+=09=09=09};
+
+=09=09=09minidump_config: minidump-sram@2a01c {
+=09=09=09=09reg =3D <0x2a01c 0x4>;
 =09=09=09};
=20
-=09=09=09pil-reloc@94c {
+=09=09=09pil-reloc@2a94c {
 =09=09=09=09compatible =3D "qcom,pil-reloc-info";
-=09=09=09=09reg =3D <0x94c 0xc8>;
+=09=09=09=09reg =3D <0x2a94c 0xc8>;
 =09=09=09};
 =09=09};
=20

--=20
2.55.0


