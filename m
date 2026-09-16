Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BA14483A0
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545266; cv=none; b=owrS6pWjmBKinSwGWFrnZfbjXbbA15jc2oxavB1elLI+RjZ9Qi/MXJDAiNNPL+tGJRLTKOVxFvJ7EXetV8KI8RIrjgVyHtTEbugjOSGBqjg4bkCkaFU1/kYFnuCbHGvmeEuWjByoPDzv4kwxaozmhhlA4GM9XLa9RFEM2Y2uGFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545266; c=relaxed/simple;
	bh=lLSadu/EO310l+5enptiwtcga/navS10peFbAJHVsAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhQGiCjT1ZZjd7ezweHnILtelSlM5ewMaSO7lynKvKa4p+6riDTIgV9pELiMlIFrAZnlLYdsMKNtkcaRXS+uGPPhsJM4ifW+zw/dRNg+hMACVKrsAlMRp1RNiu3Jv77jm20Gvk42lZs0V2ZwEyNCHD/Zieu7L4ZENM8LRNyLoD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=ECf3D7UE; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="ECf3D7UE"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260916075356f81728ef6500020776
        for <netdev@vger.kernel.org>;
        Wed, 16 Sep 2026 09:53:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=9EWFgn3dpCAtj64YounGQfAW1nszSWPj6WwClkhLfOE=;
 b=ECf3D7UEXK3DZ/UQqCAMugQ1kjO3Ek5EPtAWWCiyMqdJuUkucknHhbFac4aubXq0PBXyW3
 HgRugTgAhXQzC1vnAuDl3j9j2NaSK004Wi06XFdhYKXipAuKBVV8VKwizC9Qvn5DONHA5UsQ
 K1EqGRVS6OADzA4hzm9vRGu5D9nFLIGp53mYMg+FlbJfEu7yqbs6GqK6YyvBcRRzm+nDxmZa
 j/nYWIDFoB3hLb97sP8TJabhkNLLxhIH1ohED7Zbv2yJeiOSyLpRWE67+3DP92KBNqBpnoGE
 4KRaD5I2G1n2j93o/YnmZQKVw/VKeL/h2fFDlSSsr4TKQUiE2PNopmKg==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH net-next v2 0/2] net: ethernet: oa_tc6: add reset-gpios support
Date: Wed, 16 Sep 2026 09:53:47 +0200
Message-ID: <20260916075349.21822-1-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer

This patch series adds optional reset GPIO support for OPEN Alliance
10BASE-T1x MAC-PHY devices using the OA TC6 framework, and documents the
property for the Microchip LAN8650/1.

Patch 1 updates the Device Tree binding schema for the Microchip LAN8650/1
to document the optional reset-gpios property connected to the active-low
RESET_N pin.

Patch 2 implements optional reset GPIO handling in the common oa_tc6
library. If specified, the hardware reset line is asserted for 10 us
(datasheet specifies min 5 us) and allowed 1 ms settle time for crystal
oscillator startup before starting OPEN Alliance TC6 communication.

Changes in v2:
- Moved reset-gpios handling from the lan865x driver into the common oa_tc6
  library (drivers/net/ethernet/oa_tc6.c), so all MAC-PHY devices can make
  use of it, as suggested by Parthiban Veerasooran.

Alessandro Zini (2):
  dt-bindings: net: microchip,lan8650: add reset-gpios property
  net: ethernet: oa_tc6: add reset-gpios support

 .../bindings/net/microchip,lan8650.yaml       |  5 +++++
 drivers/net/ethernet/oa_tc6.c                 | 21 +++++++++++++++++++
 2 files changed, 26 insertions(+)

-- 
2.55.0

