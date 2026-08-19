Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C92394EBA
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787173786; cv=none; b=lRV/CkiFVxfH3aTsSIszKd/AUJ2oF+Rf6QAQ+yQb0t/rrtqdime2MahFwh+nZ0Cuw7bUdUQQdEfL8bdX3ccL51jwlttC487k9/K9tAXA8UodI1QDwbPvG0yNSYv1oMdl+OdMHv7nUrTI+eiCNiaJWsGCoez+35htyqWqfu70weU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787173786; c=relaxed/simple;
	bh=rd5cX7w7fswUkVXvydF+ntM68OwGUPyxL0IlOFTX0Fo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9a2vqJSQKkGz86ddk2X825qXuHOG+4hdysgcAiqeA4wuWYYwJBgJgtum4ZnRWZ3OQzmiWuIFWzgfSa5dnoAT1l9E0ycSSlVHfmzT0vWzpPwDh4IvqMrNK2yoRbLqxJSoMYva0oVNPk3xqp8zFKmgIHE0X5yjhNaoiva8Csy5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Zwu0nnaU; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Zwu0nnaU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787173765; x=1787432965;
	bh=OaI/2SFVou5bwt+CK9BjXU79ImauIvELCSE5lrKqiNU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Zwu0nnaU3O5ULOYnSgUqiEFkcRWbGM3Ot6W0ePg8l0jD7F7zWN/4sBqfmfbYuiMet
	 9NlqjDZSSvFUscYAJdLjwVQKvaFwpiDt0UMVXbkvb/+lAamGG9KlajhPbEufexy/qV
	 0h4ciu2LdNYAdIgkOgNXeGQg6qNte3LOnP/CQTvdKsO/ck9Okm+ms1kbiMuDivlOPq
	 rj44SAEjTN/QBPqORRuOiRgV3/+Gsy2p/XItDnNTojOh4QPedVACPlxMvUnhY8ozgZ
	 J8lsWxQ14oiSiKMrzGYQEFQ/xMiKZCG90aRKmkipNfYtk8fKejaZem1JEDsHcCDbP4
	 XJ9XymfIWCNFQ==
Date: Wed, 19 Aug 2026 21:09:19 +0000
To: oe-linux-nfc@lists.linux.dev
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: david@ixit.cz, krzk+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, luca.weiss@fairphone.com, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 0/3] nfc: st-nci: Fairphone 5 NFC bring-up (ST21NFCD)
Message-ID: <20260819210906.2500789-1-isyourbrainfoss@proton.me>
In-Reply-To: <20260818205940.1973944-1-isyourbrainfoss@proton.me>
References: <20260818205940.1973944-1-isyourbrainfoss@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: 6c406f8952cfa46404618812332ab2303f8fe093
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

The series adds a st,st21nfcd compatible for the raw-NCI path and
the Fairphone 5 DT node. Boards that already use st21nfcb / st21nfcc
keep the NDLC path.

Tested on a Fairphone 5 running postmarketOS, with these changes as
modules on a 7.1.2 sc7280 kernel:

- nfctool: Powered: Yes
- initiator poll / neard: NTAG 215, NDEF URI read OK

ese-present and uicc-present follow the public schematic (NFC_SWP1/SWP2:
SWP_SE to SIM1, SWP_UICC to SIM2). SE/HCE is not tested.

CLK_REQ (GPIO 39) is omitted, as on Fairphone 6 NFC. VBAT and VDD_TX sit
on VPH_PWR and are not modelled. VCC_UICC_IN (L4C) is not modelled;
UICC SWP is untested.

Changes in v2:
- Compatible is st,st21nfcd (no -i2c suffix)
- Sent without PGP/MIME
- DTS: interrupts-extended and pinctrl for IRQ/reset
- DTS: ese-present / uicc-present (schematic)
- DTS: SYS_CLK from LN_BB_CLK2, VPS_IO from L18B
- Binding: optional clocks and vdd-io-supply
- Driver: optional clk / vdd-io enable

Kristian Brox (3):
  dt-bindings: net: nfc: add st,st21nfcd
  nfc: st-nci: add raw NCI path for ST21NFCD
  arm64: dts: qcom: qcm6490-fairphone-fp5: add ST21NFCD NFC

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
---

