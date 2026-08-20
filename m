Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844053988E0
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259379; cv=none; b=fkp/mPGO6Xr+7Baaw8Divptx1q9btWaf8pa4SjhUhPJe30ctiYXtrRl8ZJyFCzRy1+KYEve9Q1RDr8Wl0gw2h7uR/Yn+eNH/bHuyDL+svENeiQzPm/xXvweEy/mp7fT6pC6iDDz8A21m/DkvBthfxrTZwUB36AOnLhQaX05AFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259379; c=relaxed/simple;
	bh=+jRWGScbkDvS/0VuY4sCszHyoExGq4fuxx+Vp8GJX4U=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uHZJ/QQh3N03nrQzgg6Tf+iBoFdxDJEZjrhdClKAHRnioUncqfs7/SAbMCR4Xkmxmu2JcFlQkxBlZ8WwGKD1b/Y1PWnkpGRJLYT7w8IFPOR9naHQ4D4ZLxvVsTlvEfK7FKk5NQbV0WJcHL4Dt8p3U9ktC+zHoFDpCICpZhJTgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OOzAekfi; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OOzAekfi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=4cmzilhgpjabfgmd3ciiw7y4r4.protonmail; t=1787259368; x=1787518568;
	bh=Rih+OzTQnU1zDzHqT8Rt3T8V0h6swnQZnx+7CGi5pG4=;
	h=Date:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OOzAekfif8CSMp7YERllLbNHzwhDUOPL4U2mxO4KzW3VDN87vA0HF6ALUZR8Jepqj
	 n0GBzkuReneg24+RwND6aBCPvJ86ibSHuQs+zcJrTLkkxIjgNRIRqDyiIEuHVXZCKz
	 VLQ1uLlGt4+1MT6DuhSvl6lPfNFBfOSX3XbgqtGtwj8GZtD38bJnNZ3YXRALW2rwYT
	 P1JQFoDLX5xb21LMeovT+js3gMyOajP1+tEbhOrOKsvcL47UkKZgMZCDJOqSDYQxet
	 /KH5LH1KucV1FYym2znna17w1+neKIzHYWe2pdpMMplPiJHVGl/8uCADreaI7qDv5o
	 htndq3nv4pwTw==
Date: Thu, 20 Aug 2026 20:56:02 +0000
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>
Subject: [PATCH v3 0/3] nfc: st-nci: Fairphone 5 NFC bring-up (ST21NFCD)
Message-ID: <20260820-fp5-st21nfcd-v3-v3-0-5ee0a7f44d04@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: 3f0da69ad66854a9a1cc2a756033fb71cdf72bc7
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

Patches are against linux-nfc/for-next (v7.2-rc7). Hardware test was on
a Fairphone 5 running postmarketOS, with these changes as modules on a
7.1.2 sc7280 kernel:

- nfctool: Powered: Yes
- initiator poll / neard: NTAG 215, NDEF URI read OK

ese-present and uicc-present follow the public schematic (NFC_SWP1/SWP2:
SWP_SE to SIM1, SWP_UICC to SIM2). SE/HCE is not tested.

CLK_REQ (GPIO 39) is omitted, as on Fairphone 6 NFC. VBAT and VDD_TX sit
on VPH_PWR and are not modelled. VCC_UICC_IN (L4C) is not modelled;
UICC SWP is untested.

To/Cc from scripts/get_maintainer.pl via b4 prep --auto-to-cc on this tree.

Changes in v3:
- Binding: new compatible is a different ST part (not a driver-sharing note=
)
- Binding: drop NDLC/raw-NCI description on compatible
- Binding example uses interrupts-extended
- DTS: one nfc_default pinctrl group, pins sorted, no output-high
- No In-Reply-To; To/Cc from get_maintainer.pl on linux-nfc/for-next

Changes in v2:
- Compatible is st,st21nfcd (no -i2c suffix)
- Sent without PGP/MIME
- DTS: interrupts-extended and pinctrl for IRQ/reset
- DTS: ese-present / uicc-present (schematic)
- DTS: SYS_CLK from LN_BB_CLK2, VPS_IO from L18B
- Binding: optional clocks and vdd-io-supply
- Driver: optional clk / vdd-io enable

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
---
Kristian Brox (3):
      dt-bindings: net: nfc: add st,st21nfcd
      nfc: st-nci: add raw NCI path for ST21NFCD
      arm64: dts: qcom: qcm6490-fairphone-fp5: add ST21NFCD NFC

 .../devicetree/bindings/net/nfc/st,st-nci.yaml     | 31 ++++++++
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 34 ++++++++-
 drivers/nfc/st-nci/core.c                          |  5 ++
 drivers/nfc/st-nci/i2c.c                           | 87 ++++++++++++++++++=
+---
 drivers/nfc/st-nci/ndlc.c                          | 23 ++++--
 drivers/nfc/st-nci/ndlc.h                          |  2 +
 drivers/nfc/st-nci/se.c                            |  3 +
 7 files changed, 166 insertions(+), 19 deletions(-)
---
base-commit: 9f69d05b5a85c417c73fa2d5c7a2d507ac81cf4b
change-id: 20260820-fp5-st21nfcd-v3-bde6c248beed

Best regards,
-- =20
Kristian Brox <isyourbrainfoss@proton.me>


