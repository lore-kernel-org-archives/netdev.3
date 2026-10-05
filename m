Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515338A73F
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233541; cv=none; b=ubhdjAwywoRHvbT1KBFf1QyGrpNtUeQXZ76/ExC3bcSrzPYDbNNRH1GoLHDQBDT/nr0l9kJm+a0YzdP4bRILYl5p0EnnFr7ijek2ba/vFprgeFNGqpKvTrGx49aVEtleOtOZqncAqgo6w/NzCXtc0RDAZSbg7SsdaZjacE1dpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233541; c=relaxed/simple;
	bh=3biLYym7vGQpoSXoqvf4kLmr25gXZLB/lOyVRb/ctvM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Htm66ZqCH1oQrbiX+cK5Kj2QEkw3u580Q12sGHaOE5JADE7zWCDCvP3vLi0b3HOlYnmfMtXD6XmVtwezZtYTM25GdHxtVvvTACF3ceABbE+6w/7xdzCzwklgBd29XxJCXh6HsX+/dqoKsMpLGBHXa1nkJ4di40XcwuYbZQLSGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WB2iIX4U; arc=none smtp.client-ip=185.70.43.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WB2iIX4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791233527; x=1791492727;
	bh=3biLYym7vGQpoSXoqvf4kLmr25gXZLB/lOyVRb/ctvM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WB2iIX4U1quNpTcSKN4up5AQyFB3Oxkyn7MH+R7QxZfP7YQqYFDigr/W9hW8qL++Q
	 bB0mxFLQy46UV0Nod2auCdhEsyGRG5pQ8LTMb7Ta36fSLOKs7VFVJMzAlLl1eW9byu
	 OYv23XtyhayFEZuePlxRK7xZ6w1zpI2QoG68Yp231VpvoVWs6KKziB8Adx+CSICMQ3
	 /4EJgFtBYBFWvW+b+4BKWz5QQrQdNmbly1R3gTgyzl665EX3m3eVQg5/sluzg4rPEl
	 JjnQEQiuDS0KREPO2FuFRJtcDIiRaurYQOdUhQ1EGNg8BEMn0dhKka56HT/jLLBzT4
	 rg9qcK2PDNDrg==
Date: Mon, 05 Oct 2026 20:52:02 +0000
To: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>, Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v5 4/4] arm64: dts: qcom: qcm6490-fairphone-fp5: add ST21NFCD NFC
Message-ID: <20261005-fp5-st21nfcd-v5-v5-4-7be15a86c61c@proton.me>
In-Reply-To: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
References: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: dd6ccd5ffe37ad9a70df7ac726de46ab6a0c595b
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Enable the ST21NFCD on i2c9 (0x08), IRQ TLMM 41, reset TLMM 38
active-low. Compatible is st,st21nfcd (raw NCI).

SYS_CLK is LN_BB_CLK2. VPS_IO is L18B (vreg_l18b). ese-present and
uicc-present follow the public schematic (NFC_SWP1/SWP2: SWP_SE to
SIM1, SWP_UICC to SIM2). Reader path is tested; SE/HCE is not.

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 34 ++++++++++++++++++=
+++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm6=
4/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index f41ad446a..b028d1bb2 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -933,7 +933,23 @@ redriver_ss_in: endpoint {
 &i2c9 {
 =09status =3D "okay";
=20
-=09/* ST21NFC NFC @ 28 */
+=09nfc@8 {
+=09=09compatible =3D "st,st21nfcd";
+=09=09reg =3D <0x08>;
+
+=09=09interrupts-extended =3D <&tlmm 41 IRQ_TYPE_LEVEL_HIGH>;
+=09=09reset-gpios =3D <&tlmm 38 GPIO_ACTIVE_LOW>;
+
+=09=09pinctrl-0 =3D <&nfc_default>;
+=09=09pinctrl-names =3D "default";
+
+=09=09clocks =3D <&rpmhcc RPMH_LN_BB_CLK2>;
+=09=09vdd-io-supply =3D <&vreg_l18b>;
+
+=09=09ese-present;
+=09=09uicc-present;
+=09};
+
 =09/* VL53L3 ToF @ 29 */
 };
=20
@@ -1462,6 +1478,22 @@ hall_sensor_default: hall-sensor-default-state {
 =09=09drive-strength =3D <2>;
 =09=09bias-pull-up;
 =09};
+
+=09nfc_default: nfc-default-state {
+=09=09reset-pins {
+=09=09=09pins =3D "gpio38";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09=09};
+
+=09=09int-pins {
+=09=09=09pins =3D "gpio41";
+=09=09=09function =3D "gpio";
+=09=09=09drive-strength =3D <2>;
+=09=09=09bias-disable;
+=09=09};
+=09};
 };
=20
 &uart5 {

--=20
2.55.0


