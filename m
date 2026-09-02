Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7905480DC0
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384175; cv=none; b=VILbHjBww/GHLOTRMOq2S0kAczfY+Z/FZaPrz8pmXVHuxiFy3pVJUp1wc2Hn8IulJVMK16Uo/hrI1dK6YBr9q839rTgGWApkAKvRvQTbTnlGij+bfozuED3PFoyHPN1mSsyXttmRciSUjhD+3oxwMCU2/ZHO6/NasS/AK9h6dTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384175; c=relaxed/simple;
	bh=N38+peKMXiO4pZtIjokGtVOkCxm0tkIOhgMfwECw6wM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgcV+miGXjEdXGOIE3JYd2zTva3sIbIVQDqkNkmSZEcL0qcsyAAmb2qo5ZpC+SClgR+c7MfQhNuY0ZipUINENwqk4sOLJrZ2d4d9Q765HcmJ6xpAEvkGGw/gBJy+YsJofoYhGNvVMWPo1rQYdl9d2kldSl1MADGacyFwdR+XxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Dwh5vIWo; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Dwh5vIWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788384149; x=1788643349;
	bh=N38+peKMXiO4pZtIjokGtVOkCxm0tkIOhgMfwECw6wM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Dwh5vIWo0NqSQEetDSwtJXlBkB9z+q03yjX0K1vpN2k406kEZcaBSMB0tKIZGgAws
	 TLlae7qV+ExvPPBcyh3YscJTay4jjYaihNLwOpxJ7i14PCUE/XMWbeM8tntjIJNgYy
	 nCDdHO12ee8LSpvphFN4bxMcapopXN7rRnJCKNEiao7RMrjvSSelQPL+/ivLohowfi
	 sfUFU+daogueFlKPLJ4Mi5PIqFczvwOZRt99KG9lQI4HbIpMgYaS6BBzA+IpKNgaTu
	 5VXKJ4+EzheaAqClmw+xti86bUyVyGKbvvpMZEUFVQm2r1ag9ZidBM8SpTqQBoQXOZ
	 cavLCiY7qxExg==
Date: Wed, 02 Sep 2026 21:22:25 +0000
To: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>
Subject: [PATCH v4 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: add ST21NFCD NFC
Message-ID: <20260902-fp5-st21nfcd-v4-v4-3-ded2f1c501be@proton.me>
In-Reply-To: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>
References: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: 3c1b6f39bba4351a7e3072044bfe914a77b17bcc
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
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 34 ++++++++++++++++++=
+++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm6=
4/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index f41ad446a39e..b028d1bb25d4 100644
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


