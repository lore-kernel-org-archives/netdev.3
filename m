Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275E3859DE;
	Mon,  5 Oct 2026 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233524; cv=none; b=FFa/b3LBEn9oP6LR9rUlHUzaBuCu3s1PlhiTJ7+WIbxuCOfYKCTXaFh/4WdKCIhhAZKsb3RxUjado3MEQcKqoRHkSJyNaGbJE3u3C4XY7VSWlb9QlneVX9bU4ogxQa5btiQOTmb1RsIhIWQzFoDLfvguQTXJIvcuxPU4TyZ09ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233524; c=relaxed/simple;
	bh=w2Pj/aA+ACoJ4sNLQmplkZrq+uo0XkJzKyEiCfYZGjs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AcaGNSlwmS3CcinGcNslMcRo0dhOc8OZoq755Q6WalpjI+4IeoHqIZuwUKcXMtPYaUDdilVMRPrDDf+Soa/vZRa0y1TvnWI/ZDrULBNZh9e28sJ9l9BAAf7V+a4gf5WJwbnbj58IfZoZHHH3tEobWf0WqnMn2m/r5TkwtJFFCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RnO3q848; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RnO3q848"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791233507; x=1791492707;
	bh=6W67tFHd6CiLu3WczG673m8vQK8JeD6Yh/iLbczubAI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RnO3q848bpHeIatqJgLCMEcNkOP3wKufhsvlm4thJpKP5RM2sSJxX0jd3SqgnZo5c
	 CB94MYz11k5/wqNmv6jIwO9kMS58VjoTYhucDbN+vp1oNZORE6tpTJcMEEBXKgAE6r
	 C96ZivhPgUU9Cq6Jv8KPA/aaOvUmT9gsbpvBqngoabYXBoDfdj2/7nAj9WiqDJZ+0Q
	 YyDbS6GoOVuM802IUrDE8GFDnpz1f9wGSVxckiM5e2Eo8tj1zU3nh3QO6S/Fad51Ct
	 sEof4PuhWrv8Ehv6PfIbXsD5no9o7ICFeIjXuEVgT8ZakehIIBNpDh0BSazbHtYfK7
	 v/4qpYnzaZhdA==
Date: Mon, 05 Oct 2026 20:51:42 +0000
To: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Tim auf der Landwehr <tadl-git@taufderl.de>, Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v5 0/4] nfc: st-nci: Fairphone 5 NFC bring-up (ST21NFCD)
Message-ID: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: 770e7dd04a105c11704dbf4d72852d48b538ec69
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

A later poll start that times out in "failed to set local general bytes"
is still unreproduced on this phone.

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
---
Link to v4:
https://lore.kernel.org/oe-linux-nfc/20260902-fp5-st21nfcd-v4-v4-0-ded2f1c5=
01be@proton.me/

Changes in v5:
- Map proprietary RF protocol 0x90 to MIFARE (Tim). On this phone a
  Classic 1K was accepted as 0x90 and was not dropped.
- Binding carries Reviewed-by from Krzysztof Kozlowski. DTS carries
  Reviewed-by from Konrad Dybcio and Abel Vesa. The patch bodies are
  the v4 patches. The raw-NCI driver change is unchanged.
- Tim's reference-clock restart and leading-0x7e check were tried on
  this phone and left out.

---
Kristian Brox (3):
      dt-bindings: net: nfc: add st,st21nfcd
      nfc: st-nci: add raw NCI path for ST21NFCD
      arm64: dts: qcom: qcm6490-fairphone-fp5: add ST21NFCD NFC

Tim auf der Landwehr (1):
      nfc: st-nci: map proprietary RF protocol 0x90 to MIFARE

 .../devicetree/bindings/net/nfc/st,st-nci.yaml     | 49 +++++++++----
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 34 ++++++++-
 drivers/nfc/st-nci/core.c                          | 38 +++++++++-
 drivers/nfc/st-nci/i2c.c                           | 82 ++++++++++++++++++=
++--
 drivers/nfc/st-nci/ndlc.c                          | 27 +++++--
 drivers/nfc/st-nci/ndlc.h                          |  5 +-
 drivers/nfc/st-nci/se.c                            |  3 +
 drivers/nfc/st-nci/spi.c                           |  2 +-
 drivers/nfc/st-nci/st-nci.h                        |  2 +
 9 files changed, 211 insertions(+), 31 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261005-fp5-st21nfcd-v5-1818d4776267

Best regards,
-- =20
Kristian Brox <isyourbrainfoss@proton.me>


