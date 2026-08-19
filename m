Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE9397E91;
	Wed, 19 Aug 2026 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787173796; cv=none; b=DdIPjQPxnU8GcvLOA6FbU3yJSmbBPcI/9FmUWxBoVzXPCLS7lrbTvga0DIxqOxXhpvsCGxKLuJu1A+xAEAoOabCxDScXR4osIZwASJwtQGqPLtSSwtWcXzRWL09HoE639NhWJUQpgJhxJ8biOReQ25tde10H+PMjyizacQG2cLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787173796; c=relaxed/simple;
	bh=4T6w3Jq+fsVkSUa/RSMCvPR8LYYuUevIOuXZFa8+0Sg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kDzYvpqV/ypLkteDLv5hUw0BWEZo3YQxGNMczuWVbbmQ7ZNAiOUVWNG90UPF2SHmGJBC7oqBI1R0Pu/Gi5MdLcINyfc8vZt0gx00zb6my2ESPgp6Vn3b0dpYx8IYj7Vrd4YSf62+EUfQ7nxBClHbDhfgVBuOC1kDeLoX3n9/W/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PC5yk7S9; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PC5yk7S9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787173785; x=1787432985;
	bh=4T6w3Jq+fsVkSUa/RSMCvPR8LYYuUevIOuXZFa8+0Sg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PC5yk7S9nSOaOwBePWwts3HMvfaKjpaunb44hLrAAsTccsHWD71Q6Jg8xDGELK+DO
	 L8J2S/SN8Z0O5EeSHuLSPEbS0rlhlkQCFhpeSduhNnq7ybaBHJY1/oS7M5os87jo5V
	 Lw3Vkp/42C+OXeNofTZufuDMqqWqkOdee2v9/eTkyf7DzV312B0UjSs1huyYH38dZc
	 SZisS3g9U0xthZciBAjJCqv8UTak55WEgIe8jk6Y1AzHVqyrWRIq9PYkEe5Hn/M6Ge
	 SPmSyhHWaaCP2pzZjO9yByxGw+SnHJEvRneOdmg30t2Fzvse87KoJxL4e2d0SNiJpd
	 7LhN0Slou9CLw==
Date: Wed, 19 Aug 2026 21:09:38 +0000
To: oe-linux-nfc@lists.linux.dev
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: david@ixit.cz, krzk+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, luca.weiss@fairphone.com, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: add ST21NFCD NFC
Message-ID: <20260819210906.2500789-4-isyourbrainfoss@proton.me>
In-Reply-To: <20260819210906.2500789-1-isyourbrainfoss@proton.me>
References: <20260818205940.1973944-1-isyourbrainfoss@proton.me> <20260819210906.2500789-1-isyourbrainfoss@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: 78d32f01369695d17cf0d846295c987050d0d41d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Enable the ST21NFCD on i2c9 (0x08), IRQ TLMM 41, reset TLMM 38
active-high. Compatible is st,st21nfcd (raw NCI).

SYS_CLK is LN_BB_CLK2. VPS_IO is L18B (vreg_l18b). ese-present and
uicc-present follow the public schematic (NFC_SWP1/SWP2: SWP_SE to
SIM1, SWP_UICC to SIM2). Reader path is tested; SE/HCE is not.

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
---
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm6=
4/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 29d6265..394237c 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -1004,7 +1004,23 @@
 &i2c9 {
 =09status =3D "okay";
=20
-=09/* ST21NFC NFC @ 28 */
+=09nfc@8 {
+=09=09compatible =3D "st,st21nfcd";
+=09=09reg =3D <0x08>;
+
+=09=09interrupts-extended =3D <&tlmm 41 IRQ_TYPE_LEVEL_HIGH>;
+=09=09reset-gpios =3D <&tlmm 38 GPIO_ACTIVE_HIGH>;
+
+=09=09pinctrl-0 =3D <&nfc_int_default>, <&nfc_reset_default>;
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
@@ -1649,6 +1665,21 @@
 =09=09drive-strength =3D <2>;
 =09=09bias-pull-up;
 =09};
+
+=09nfc_int_default: nfc-int-default-state {
+=09=09pins =3D "gpio41";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09};
+
+=09nfc_reset_default: nfc-reset-default-state {
+=09=09pins =3D "gpio38";
+=09=09function =3D "gpio";
+=09=09drive-strength =3D <2>;
+=09=09bias-disable;
+=09=09output-high;
+=09};
 };
=20
 &uart5 {

