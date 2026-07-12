Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84334040A;
	Sun, 12 Jul 2026 20:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888496; cv=none; b=kDqx6roGagFRWnXRw2NKZUapi962KPKzJjLTWtZbBMDrmetV788C5L1464XlF/VDFMoivITCo7k4Q90e2Z9AXh1omgePY65s1rozYSxNe6sQNkFGLK0+M00hMoErEk+ZvQ7QX6gVbE2JcV7COVkZ+GRoCQSmY//u6ztOHpVjamw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888496; c=relaxed/simple;
	bh=acDJnTd5MEKvTipUGPLMCNBOBwkkCVfP0RZS48esP/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCUGFfZzVphMsl2cPITKqYycCm95yeEPdkCEcGmZNM5OxlVuztoKUGbqM2dp1QDrQc2vXeC/kV+xhVnad7VeG9qa2E8ymCpE1pSXCBMtO/lILVkuQvbKxoICEk47zBUeRRnwYUA4VkzW++w2RyIJRNNmI9/N2efzPrKnYzkV9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ctJpl8nT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ctJpl8nT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Mv2WgGTz6WKIqtoJnLFA34PaD05R6doIbVvqCh8lFG4=; b=ctJpl8nTmjSPbLdy7AePVUSEcT
	4SU8EprP9Zha+ttcLt3cuQ6gy3de/Nx2IcCVXn+Ur2u9z3rvkl0k85qyLgLVY3Isde/CeUCrsd4Ib
	ZAGsRB5w4feaOa1KpOapEuzihotjFf4UAmebxw8jth2ErWFcLeLdICBSs/HxLxu2KT0bd2x1bhxgg
	kpH4XNgIxuS3CrTuDcD+ixXLw0+mOhmX5xqlIHxbMm3SO6YH9aSsJWzGv0yIRh+LfTPiJOofmOqCZ
	JkrEQUEinoNIaL5LVIdgrMSih1NbP47hsBTnsMKfF99I/HNZvJ/kFVEWuFx8sSe4knQanm+KgzRJ9
	jwHO712Q==;
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wu <david.wu@rock-chips.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yanan He <grumpycat921013@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: (subset) [PATCH v2 0/5] ARM: rockchip: rv1126: Add support for Alientek ATK-DLRV1126
Date: Sun, 12 Jul 2026 22:33:57 +0200
Message-ID: <178388833980.1396294.8103967667500299878.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
References: <20260706-rv1126-alientek-dlrv1126-v2-0-ff3176ca362b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 06 Jul 2026 17:14:40 +0800, Yanan He wrote:
> The ATK-DLRV1126 board consists of a CLRV1126F core module and a
> DLRV1126 carrier board. The core module contains the Rockchip RV1126
> SoC, eMMC and RK809 PMIC. The carrier board provides Gigabit Ethernet,
> SD card, AP6212 WiFi and Bluetooth, PCF8563 RTC, ADC keys, GPIO LEDs and
> audio connectors.
> 
> This series adds the Alientek vendor prefix and board compatible, updates
> the Motorcomm PHY driver to consume an optional external PHY reference
> clock, adds missing RV1126 SoC description pieces, and finally adds the
> CLRV1126F core module and DLRV1126 carrier board device trees.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: vendor-prefixes: add alientek
      commit: 068a6bd57167cb97058b08f22db0584fabdaab95
[2/5] dt-bindings: arm: rockchip: Add Alientek DLRV1126
      commit: f1522feb72aa5231532c9f69e7f5cc91972697e1
[4/5] ARM: dts: rockchip: Add RV1126 I2C5
      commit: 17bee9ee734e56d512ec7803eb7948adb56d1d9c
[5/5] ARM: dts: rockchip: Add Alientek DLRV1126
      commit: 44045aa7a9a9e6484617f44f77a3efb2d8e78565

Please double-check the sorting on future patches :-) .
The dtsi was perfect, but I did some re-sorting on the carrier-dts.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
