Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629E314B8F;
	Wed,  9 Sep 2026 03:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788923463; cv=none; b=j3Q9tqOGGEd1uFuAtzkv708zqOJT4O1doQoK3a1Y0HuXzn7PsdW4sO3se/rasssoDZN5v9OlFXvqLwSDLz3ko7q0ToDclUV+O/V6dhTHUAu4jtSa3rAPPWVCdNoyjbPm5p7mvhOFt/I81uoVUqNKHKGSjUaqI5SGiU4qea837JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788923463; c=relaxed/simple;
	bh=SqGOECwVHFmocHLAkBrnfrFEMZkSNGwAm0dB2nZESwI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LVP5NtN1M2LAzQR06Dpnkw5My2L3geEVkm14Bt1nz+S+gYm6kUeIny8UQIcO34c4aLb1NyjIqDnW5X9SVnVb59BN9N7jrITsO2A7DvSXj/ObS1UvVNAIj8BGQL9tssnwexAl3OBh2fBqRWEV5FzKfIOgPEsw7h2sy+NhosNr1TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=X0GGjrxA; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="X0GGjrxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788923453; x=1789182653;
	bh=Ofh6fpcLN9XRqYRoCzFoB81MGxY2OaZ24p1y9iraXmw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=X0GGjrxAW2d14VA9LGukwDvxPsFRTqwXVZcuw6TsXeFk9iAkwaK5v2bmggdcYvVGx
	 3HNU2hCSjtfxILNKqZElO/wrBt83pYlTsCIZ8GxypbEV55Wg0g2o5upW+8aUcmhsTo
	 7cz2QJ2KFfGkQaedSK4hwqvIOCzbxJCEFiUFci7cWb6U/Iku5etu6qsSCxV0c9/tPt
	 uMcIaRUrGfbjWJTB9OJt1soCQ8F1Jllzuhm8g0Ppq2+h3CcF3TZdJ/nPQaic01ZB+1
	 u56aAB/28wEcG20RviWlleq/2M2vPvh2FiYevu67Axvp8ENhQMrPjKrRKL3AkISjWn
	 Pqjv/4nt0HEOw==
Date: Wed, 09 Sep 2026 03:10:48 +0000
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Esteban Urrutia <esteuwu@proton.me>
Cc: Esteban Urrutia <esteuwu@proton.me>, Nazar Kompanets <xlie7669@gmail.com>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 0/3] SM8450 IPA support
Message-ID: <20260909-sm8450-ipa-v2-0-2deb8b4e91a5@proton.me>
Feedback-ID: 147889766:user:proton
X-Pm-Message-ID: 3b218d2646997f5d755b8356d77a73038258ec5f
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series has been tested on the following SoCs:
- SM7475
- SM8450
- SM8475
In these the modem works as expected and no crashes occur.

Signed-off-by: Esteban Urrutia <esteuwu@proton.me>
---
Changes in v2:
- Add missing resource limits for DMA and QDSS source groups.
  - These are marked as unused downstream, but still have values written
  to them.
- Add Nazar as a co-developer.
  - We developed independent implementations and are both working on
  this series.
- Add the IPA_MEM_MODEM_STATS_DROP memory region.
- Pick tags.
- Rebase against linux-next.
- Remove comment in driver stating smem_size differences.
  For both SM8450 and SM8475 SoCs:
  - All devices based on these SoCs use an smem_size of 0x9000. [1]
  - Specifying an smem_size of 0xb000 causes the modem to assert a
  shared memory allocation failure. [2]
- Remove overlapping optional memory regions.
  - No comments from anyone regarding these, so remove them.
- Reorder patches. (Dmitry, Krzysztof)
- Sort iommus property in DT. (Krzysztof)
- Specify actual IMEM base and size in DT. (Konrad)
- Update commit messages and cover letter.
- Link to v1: https://patch.msgid.link/20260622-sm8450-ipa-v1-0-532f0299f96=
e@proton.me

[1] https://github.com/sm8450-mainline/fdt
[2] https://github.com/dopaemon/android_kernel_xiaomi_sm8450-devicetrees/co=
mmit/0cff0b070363fb9a312ba6e66244898013e7038f

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Alex Elder <elder@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Nazar Kompanets <xlie7669@gmail.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: phone-devel@vger.kernel.org

---
Esteban Urrutia (3):
      dt-bindings: net: qcom,ipa: Add SM8450 compatible
      net: ipa: Add IPA v5.1 configuration data
      arm64: dts: qcom: sm8450: Add IPA node

 .../devicetree/bindings/net/qcom,ipa.yaml          |   1 +
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  59 ++-
 drivers/net/ipa/Makefile                           |   2 +-
 drivers/net/ipa/data/ipa_data-v5.1.c               | 476 +++++++++++++++++=
++++
 drivers/net/ipa/gsi_reg.c                          |   1 +
 drivers/net/ipa/ipa_data.h                         |   1 +
 drivers/net/ipa/ipa_main.c                         |   4 +
 drivers/net/ipa/ipa_reg.c                          |   1 +
 8 files changed, 537 insertions(+), 8 deletions(-)
---
base-commit: a9d7ced84989ec05be09b4b8428759ef60450a0f
change-id: 20260908-sm8450-ipa-4dfc931c8ce0

Best regards,
-- =20
Esteban Urrutia <esteuwu@proton.me>


