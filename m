Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED83128CC
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771801; cv=none; b=mmb2fFxJwQSuSjPwyH5C+aF1igzLHjq13zBZMEuMW8G3osk99wKaUv9/zUQnO/sdnoSHWm87RgIUe2z4zzvVg9mb0nNV5tnUXBmXq5v0JxnwAiMuuFPsSxIC2Uov+rBer4xX+hx7IU4mr/ucKjMr4Oy1FRG0F4jMqM1iloYcx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771801; c=relaxed/simple;
	bh=c9a7BgfKyXpFpPzPymrjIgQx/Q/FQ8LhZrbtEMRk4pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tHA7GdsJ6wmtTk2pNcp7DFAeKWoRpSBQeB+rOfrH4R0jRoM+TZHJ2r8ULK1bDc6NzG5XvMmgmNQ8N6pJkgBuUCHPqd46Uv98ZlCLTaHp4wcME8owE0KQQnWik44RZv6h4UcXRkZ298vOpzoobTW6AJQ+8+06zXUtdG/Em7721Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=l4T+guds; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="l4T+guds"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260918224946db4d950926000207ea
        for <netdev@vger.kernel.org>;
        Sat, 19 Sep 2026 00:49:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Idf8+02UMvhb6WU2BN5Xp0LSgr1Y02lP+wrZ3oddczE=;
 b=l4T+gudsDujoJfQUZn5qu24EZvK5Pka46dfYI1uRCxZEf5coILK0Ydh0+HJoQvUXiUOOI7
 9IyG97R3HA8kun/fCj9HqJSlexDspsadryMgZcSeb+O7VrI4bLtW5omJHFI1thL5k3nyNhv2
 8nCTQvcxmDDltuHxIEuHmrdLLsfFxz6g9AK0pTCSnvKsAehpA/ksX40Fo5KkQMHkdPxdauho
 JLIhe139xD4aRdMRay8RYN89j2nWOLB2IQvJcvTdD1uVgSvZQ8Qp4Jb+OZgYz81uxBB255M6
 B8bMQuVDvXoGt5xBr7wTHqUnaWFIrn6evBq0FVgPPkvWtwSUUlYDaOoA==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ciprian Regus <ciprian.regus@analog.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>
Subject: 
Date: Sat, 19 Sep 2026 00:49:30 +0200
Message-ID: <20260918224934.51998-1-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer

Subject: [PATCH net-next v3 0/4] net: ethernet: oa_tc6: add reset-gpios
 support

This series adds optional reset GPIO support for OPEN Alliance 10BASE-T1x
MAC-PHY devices using the OA TC6 library, and documents the property for
the two MAC-PHYs currently bound to it.

Patch 1 and 2 document the optional reset-gpios property for the Microchip
LAN8650/1 and for the ADI ADIN1140/AD3306.

Patch 3 converts oa_tc6_init() to return an ERR_PTR instead of NULL, so
that -EPROBE_DEFER from the GPIO lookup added in patch 4 reaches the
driver core instead of being turned into -ENODEV.

Patch 4 implements optional reset GPIO handling in the common oa_tc6
library. The reset line is requested asserted, kept asserted for 10 us and
1 ms of settle time is allowed after deassertion for the crystal
oscillator startup, before the OPEN Alliance TC6 communication is started.

Changes in v3:
- Picked up Acked-by tag from Krzysztof on patch 1.
- Added patch 2, documenting the property for adi,ad3306 as well, since
  the reset handling lives in the common library and the adin1140 driver
  gets it too.
- Added patch 3, converting oa_tc6_init() to ERR_PTR, so that
  -EPROBE_DEFER is not lost.
- In patch 4, requested the GPIO with GPIOD_OUT_HIGH and dropped the now
  redundant gpiod_set_value_cansleep() call, as suggested by Qingfang
  Deng, propagated the dev_err_probe() return value, reworded the comment
  and sorted the new includes.

Changes in v2:
- Moved reset-gpios handling from the lan865x driver into the common oa_tc6
  library (drivers/net/ethernet/oa_tc6.c), so all MAC-PHY devices can make
  use of it, as suggested by Parthiban Veerasooran.

Alessandro Zini (4):
  dt-bindings: net: microchip,lan8650: add reset-gpios property
  dt-bindings: net: adi,ad3306: add reset-gpios property
  net: ethernet: oa_tc6: return ERR_PTR from oa_tc6_init()
  net: ethernet: oa_tc6: add reset-gpios support

 .../devicetree/bindings/net/adi,ad3306.yaml   |  5 ++
 .../bindings/net/microchip,lan8650.yaml       |  5 ++
 drivers/net/ethernet/adi/adin1140.c           |  4 +-
 .../net/ethernet/microchip/lan865x/lan865x.c  |  4 +-
 drivers/net/ethernet/oa_tc6.c                 | 46 +++++++++++++------
 5 files changed, 47 insertions(+), 17 deletions(-)

-- 
2.55.0

