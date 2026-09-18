Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB039F162
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789773310; cv=none; b=jUs12kcE5YiyCfcx+9Ryx9YmedEnE9OFvp7G6umHDaqdWSAxRqSoBkcGvqO/l53CuRyXSFzQoiZ1fTKhC6DMdLzS+qa8/Xg6A7Zdij9/HK5zdiu51hWGtP9OPBTA/w/z3LtWTk/HqSf9URVAAILtBwsa6fCYeoKoX62xyL8M4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789773310; c=relaxed/simple;
	bh=N1+8lTa0cD8Di4i5uB08hdfN+adjhDPO5yydi9aX/Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aQkOzLEcz2tyrW4AFRIWRbW3DxznPYgysGEq5Uyy9aVq+bFYORHfeozHzp4f2Hl7fMeP/L6eC6KZFCX/M7FpMwntkE4KAtR5tnZTJibweIsOvcc+dsbyk4c+g7t3+mIplFb9TcFUnIJ6/9u/eFDbSx+3ovZwi58gP42+ZSskwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=cBhi3G6g; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="cBhi3G6g"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202609182315025e782615d500020759
        for <netdev@vger.kernel.org>;
        Sat, 19 Sep 2026 01:15:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=Zsf3t29XMHxUbmFN/T07chbg3R0ZMS1E1xGPRbiAOb4=;
 b=cBhi3G6gxkYgV3Jdr0QYq6iMgh2AI3XGfoGnyFSiPjIAvE4ekfv8ptkiJ6PcBHYE2C7Cct
 EM4l8hZUm92eJ/fwpgwb68pcUoOUHBLypHVeHquDwfEHL7e0ZUFC8LwSNvdmM4idzeBYtcgu
 IDNKtcQqVexL63k/Dw0+2Dz9Y//tasEn5WCDwajYZGAHKgdjUxQR2J00uZyyfDV8zzgd4+Y1
 RnB6Wj0wsVd9Er/nB8K6bBZFvVsyiW/N/EU2LcS4BjYfxW7pIJAk8UIGKstvti+2XfQW95j/
 YRC0RjIM5q0UgCfZoATiPTdAaAkTrr5sF2J1popUopIlsbzJG6getlBg==;
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
Subject: [PATCH net-next v4 0/3] net: ethernet: oa_tc6: add reset-gpios support
Date: Sat, 19 Sep 2026 01:14:47 +0200
Message-ID: <20260918231450.55966-1-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer

This series adds optional reset GPIO support for OPEN Alliance 10BASE-T1x
MAC-PHY devices using the OA TC6 library, and documents the property for
the Microchip LAN8650/1 MAC-PHY.

Patch 1 documents the optional reset-gpios property for the Microchip
LAN8650/1.

Patch 2 converts oa_tc6_init() to return an ERR_PTR instead of NULL, so
that -EPROBE_DEFER from the GPIO lookup added in patch 3 reaches the
driver core instead of being turned into -ENODEV.

Patch 3 implements optional reset GPIO handling in the common oa_tc6
library. The reset line is requested asserted, kept asserted for 10 us and
1 ms of settle time is allowed after deassertion for the crystal
oscillator startup, before the OPEN Alliance TC6 communication is started.

Note: In v3, a DT binding patch was added for adi,ad3306.yaml based on
review bot feedback, as adin1140 also calls oa_tc6_init(). However, I have
later realized that ADIN1140/AD3306 does not have an external reset pin...
Therefore, that binding patch has been dropped in v4. Sorry for the
spam.

Changes in v4:
- Dropped patch 2 from v3 ("dt-bindings: net: adi,ad3306: add reset-gpios
  property") because the ADIN1140/AD3306 does not feature a physical reset
  pin.
- Renumbered patches accordingly (now 3 patches).

Changes in v3:
- Picked up Acked-by tag from Krzysztof on patch 1.
- Added patch documenting the property for adi,ad3306 (dropped in v4).
- Added patch converting oa_tc6_init() to ERR_PTR, so that -EPROBE_DEFER
  is not lost.
- In the driver patch, requested the GPIO with GPIOD_OUT_HIGH and dropped
  the now redundant gpiod_set_value_cansleep() call, as suggested by
  Qingfang Deng, propagated the dev_err_probe() return value, reworded
  the comment and sorted the new includes.

Changes in v2:
- Moved reset-gpios handling from the lan865x driver into the common oa_tc6
  library (drivers/net/ethernet/oa_tc6.c), so all MAC-PHY devices can make
  use of it, as suggested by Parthiban Veerasooran.

Alessandro Zini (3):
  dt-bindings: net: microchip,lan8650: add reset-gpios property
  net: ethernet: oa_tc6: return ERR_PTR from oa_tc6_init()
  net: ethernet: oa_tc6: add reset-gpios support

 .../bindings/net/microchip,lan8650.yaml       |  5 ++
 drivers/net/ethernet/adi/adin1140.c           |  4 +-
 .../net/ethernet/microchip/lan865x/lan865x.c  |  4 +-
 drivers/net/ethernet/oa_tc6.c                 | 46 +++++++++++++------
 4 files changed, 42 insertions(+), 17 deletions(-)

-- 
2.55.0
