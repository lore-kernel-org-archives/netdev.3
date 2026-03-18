Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0041B390C8A
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831096; cv=none; b=VCv7QcqkgWkWB5/F0yqMoRWX5mAsvC9Lwa9SIlA0zxdj+qvrO9Im70epAGzNBxwrk/tWkjvmfNWM6VLQbgFMzgQwW/fQAnbuDJ4y1HDZz1N/0NGug4ccPsbihffKH5K7CDDTMhHJMAteMnhnklzQ9aHY3jUamaG62VkbVgu9TQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831096; c=relaxed/simple;
	bh=avnBIWWRM7DGbD6sCINWQ+cehHGxCkrSwRIkVNy258o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0KW7kDyZ8fLizAu/FWuVMApbiBOE6A9wLkWUX4/339+ZUXl95O6UdtMk69Xpt1ziPDFU+AisGR78K75/GaP8SDl0WmaJMTyOAQczzHbCJgb/0ina5HsrzyeXNavgBFiDGV6YQsFaklb003QGljkgaR4XSONsik6Y/WWIszwodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUn-0001WI-Dq; Wed, 18 Mar 2026 11:51:25 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUm-000tSM-39;
	Wed, 18 Mar 2026 11:51:24 +0100
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w2oUm-00000003RI8-3n2T;
	Wed, 18 Mar 2026 11:51:24 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 0/7] ARM: dts: stm32: Fix mecio1 hardware revisions and ADC/GPIO mappings
Date: Wed, 18 Mar 2026 11:51:16 +0100
Message-ID: <20260318105123.819807-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This series updates the STM32MP15x MECIO1 device trees to properly
account for the physical hardware changes between the R0 and R1 board
revisions.

David Jander (7):
  ARM: dts: stm32: stm32mp15x-mecio1-io: Enable internal ADC reference
  ARM: dts: stm32: stm32mp15x-mecio1-io: Fix ADC sampling times
  ARM: dts: stm32: stm32mp15x-mecio1-io: Move divergent mecio1 ADC
    channels to board files
  ARM: dts: stm32: stm32mp15x-mecio1-io: Fix GPIO names typo
  ARM: dts: stm32: stm32mp15x-mecio1-io: Move gpio-line-names to board
    files
  ARM: dts: stm32: stm32mp15x-mecio1-io: Fix expander gpio line typo
  ARM: dts: stm32: stm32mp15x-mecio1-io: Move expander gpio-line-names
    to board files

 arch/arm/boot/dts/st/stm32mp151c-mecio1r0.dts | 128 +++++++++++++++
 arch/arm/boot/dts/st/stm32mp153c-mecio1r1.dts | 144 +++++++++++++++++
 .../arm/boot/dts/st/stm32mp15x-mecio1-io.dtsi | 146 ++----------------
 3 files changed, 288 insertions(+), 130 deletions(-)

--
2.47.3

