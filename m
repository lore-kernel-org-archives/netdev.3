Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FC34119F0;
	Wed,  2 Sep 2026 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384159; cv=none; b=jMGnSWckJGr+334HppJGQNOWGlGy+jh6IiItsQ6+YFOxFlBMlfD+fnbWmA7cZpTDrabJg+hIoFq3IRh/FKglRGVElY1KVWvcpzfGQNNZdyoqYNmYQ2DSyi0OQK00jNGrgwKiKwM5F8hy8r1gxXDsQmUC1GXFNl1ZAgkAIIrmCAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384159; c=relaxed/simple;
	bh=k1lyWfaJP3xU+UHktqeOFB2UIyIAd/PoNQw+0PNA/Q0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=V9LDObiKRrOT3goyCitMViniOoxLGhHb8epPdfQ2LeLSxV+8sKznt/6xAYZhXBTG85Aryps0vQ391uanp10PNoBu1Dfwe7a/XHadL01emXFfbmAlQn/HEmV7sFodR0pvL/krcjv78S5+XHMJhGtHXRtw4oqEhk6L+cBjNnSIyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XU4rtfUs; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XU4rtfUs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ohdz7yiisbhrpfbd5oe2n7vs5a.protonmail; t=1788384139; x=1788643339;
	bh=1WN0P42Ga1UQ2w7ibBx/V/nw/ikQdfeG+Lf+Wqou5iU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XU4rtfUs+3WyvTJQefT2rJK2SpSvi9StMFXRiMXZxoCbhBzHaL4qzdDIX8ysIh+Ot
	 qmaIeIaZgGtIgZpBnjGhXNWFAHz90NU1uMg22HZgug6lPAiIESxjx5fi6LJw7h6/r4
	 7QcBR9WaaJhja7SG+MPhsyQxdOAjvnVT3OTtbyJPQVnXK3Td8kJ9wewymLziCHwyUl
	 Ags8Rl2i+coIFJL+9Ghx7mf2N6cR71W0+0OM2rv10I+AaVL2cxFG2jwLDztt+qQxmn
	 ep/JwKwkVRvlB17Ze1yPJIFXQfwM8StjvW+vs66LCnYYZobQYUGjUwyGNY3iJCQ0QL
	 M/FkFwQrXCHaQ==
Date: Wed, 02 Sep 2026 21:22:14 +0000
To: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>
Subject: [PATCH v4 0/3] nfc: st-nci: Fairphone 5 NFC bring-up (ST21NFCD)
Message-ID: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: c4c498e7a9dd957ae9757fb03f72e5088d442de4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This adds NFC on the Fairphone 5 (qcm6490). The board uses an ST21NFCD
on I2C. That part speaks raw NCI; the current st-nci driver always
wraps NDLC, so using st,st21nfcb-i2c leaves the adapter unusable.

The series adds a st,st21nfcd compatible for the raw-NCI path and the
Fairphone 5 DT node. Boards that already use st21nfcb / st21nfcc keep
the NDLC path.

Patches are against linux-nfc/for-next (Linux 7.3-rc1). Hardware test
was on a Fairphone 5 running postmarketOS:

- 7.1.2 sc7280, earlier raw-NCI modules: nfctool Powered: Yes;
  initiator poll / neard: NTAG 215, NDEF URI read OK
- 7.2.0-nfc-test+ (sc7280-mainline), this v4 st-nci as modules:
  10x initiator poll finds Type 2 in 0.13-0.14 s, no
  "unsupported ntf opcode 0xf02". Repeat poll with a Type 2 tag
  in the field stays Powered: Yes. Empty-field poll SIGINT
  (nfctool -p, no tag) also stays Powered: Yes.

The ndlc: hexdumps are pr_debug. SIGINT during CORE_RESET (nfctool -0
then Ctrl-C during -1) wedges stock nci core; that is not this series.

ese-present and uicc-present follow the public schematic (NFC_SWP1/SWP2:
SWP_SE to SIM1, SWP_UICC to SIM2). SE/HCE is not tested.

CLK_REQ (GPIO 39) is omitted, as on Fairphone 6 NFC. VBAT and VDD_TX sit
on VPH_PWR and are not modelled. VCC_UICC_IN (L4C) is not modelled;
UICC SWP is untested.

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
---
Link to v3:
https://lore.kernel.org/oe-linux-nfc/20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f4=
4d04@proton.me/

Changes in v4:
- Driver: consume ST proprietary RF NTF 0xf02 (Luca)
- Driver: set raw_nci before nci_register_device (Sashiko / David)
- Driver: enable vdd-io and SYS_CLK before driving reset
- Driver: keep named i2c/acpi id initializers; do not add trailing
  commas on existing of_match entries (David)
- Driver: reset pulse uses gpiod_is_active_low so new DT can be
  GPIO_ACTIVE_LOW without breaking old nfcb DTS (Krzysztof)
- Binding: ST21NFCD is not I2C-only (data brief lists SPI); do not
  put st,st21nfcd in the I2C-only spi-max-frequency:false enum
- Binding: SPI $ref only in the non-I2C else (not a global allOf item)
- Binding: clocks/vdd-io-supply on the existing I2C example; drop the
  extra example (Krzysztof)
- DTS: reset-gpios GPIO_ACTIVE_LOW (Krzysztof). Physical GPIO 38 HIGH
  is the run level. Konrad R-b not carried (polarity changed).

Changes in v3:
- Binding: new compatible is a different ST part (not a driver-sharing note=
)
- Binding: drop NDLC/raw-NCI description on compatible
- Binding example uses interrupts-extended
- DTS: one nfc_default pinctrl group, pins sorted, no output-high
- Fresh series (not a reply to v1/v2)

Changes in v2:
- Compatible is st,st21nfcd (no -i2c suffix)
- Sent without PGP/MIME
- DTS: interrupts-extended and pinctrl for IRQ/reset
- DTS: ese-present / uicc-present (schematic)
- DTS: SYS_CLK from LN_BB_CLK2, VPS_IO from L18B
- Binding: optional clocks and vdd-io-supply
- Driver: optional clk / vdd-io enable

---
Kristian Brox (3):
      dt-bindings: net: nfc: add st,st21nfcd
      nfc: st-nci: add raw NCI path for ST21NFCD
      arm64: dts: qcom: qcm6490-fairphone-fp5: add ST21NFCD NFC

 .../devicetree/bindings/net/nfc/st,st-nci.yaml     | 49 +++++++++----
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 34 ++++++++-
 drivers/nfc/st-nci/core.c                          | 22 ++++++
 drivers/nfc/st-nci/i2c.c                           | 82 ++++++++++++++++++=
++--
 drivers/nfc/st-nci/ndlc.c                          | 27 +++++--
 drivers/nfc/st-nci/ndlc.h                          |  5 +-
 drivers/nfc/st-nci/se.c                            |  3 +
 drivers/nfc/st-nci/spi.c                           |  2 +-
 drivers/nfc/st-nci/st-nci.h                        |  2 +
 9 files changed, 197 insertions(+), 29 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260902-fp5-st21nfcd-v4-1685be1d7c52

Best regards,
-- =20
Kristian Brox <isyourbrainfoss@proton.me>


