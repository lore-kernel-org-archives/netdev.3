Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25B429CDC;
	Tue, 11 Aug 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453005; cv=none; b=m3zC4y4C1Sell9tJDSUkgKibwnbv4cciWzJD+9ZiS3JgMvL0F4i6jRyxLOnXzRt3KxYohmbPFX3AXgIr0/6FOzJ2ib98eLNqRspUDsDSoeNN/vGu4hMtmcv8/+qD5owL9M3d/dIK7a+mJ/GwH57L7owbHYPUgY/YHuq2yDNcpUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453005; c=relaxed/simple;
	bh=C9376KVvYMpLGEvzElruJOk07NdEmwGqUKhJp2MqHcU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TzDTIjfsb7SOGENuMAzLzeG/in/YsPAyhE4CT1X8qL4LTslMUJNrwGuteLEJmTBd7Zn0veg1+4CexM8jmMwzAYbCK1S6xp0T+++7bEOEWAbm+EIlDmneRluGV9e7BVbLcp5LdVLKkkC9xqGGBtyYxtkzUVLOsg38q8weRx1HeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=V97wmH3t; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="V97wmH3t"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 004C05822E9;
	Tue, 11 Aug 2026 12:34:50 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A01353EC59;
	Tue, 11 Aug 2026 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786451682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cr7x32ZtQYXLaFqmEeLed8VnggnTdsTYCOEYVFF2jDQ=;
	b=V97wmH3tUtZce5P2jYo1gXNIBvnHlDiWI25r4rVApWKYguwnzpEqWwN3zPo8MuHkOLfFQk
	NYroaxEbeT0LeL4gWCKELXCGIcmhh5tiyiap96PcFwG3jmV0fGBsZekA2bNSBvTZnyJ5sf
	AScGGWwJSJ1KN6jbd1M3Oyty5f5Ka8dogukyIzidXQk1jeN6lMbveJ7iXYL4OoIPJZp2sE
	NEAQFNE1XiKE+oiBE55alixeTBx8jBOLJ5gEG75W2SS20YvjzabfgKOcuD7JIGSwii3a5k
	FPAq2mhI9wsSHkaIIDtERvMAzrwBR9n/qj2/ZMNcj/TrAVdmJ0M8ZNoo3e8klQ==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Subject: [PATCH net-next v4 0/3] w5100: restore GPIO-based link detection
Date: Tue, 11 Aug 2026 14:34:32 +0200
Message-Id: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANgWe2oC/4XNOQ7CMBAF0Ksg1wzyhhOouAeiSLzAAHGQbcKm3
 B0nNEiAKEfz//sPEm1AG8ly8iDBdhix9fmQ0wnRu8pvLaDJN+GUK1pSCRe8e5vgiP4A2xO2UCy
 UE0obJt2C5NopWIfXkVyTIertNZHN6xPP9d7qNIhDdocxteE2rndsbPwe6hgwqBVXzkhXaF2vm
 io0bUrnOMvJcaLj/xAOFETNDNVlQZ2Yf0PEO6K+ICIjc8GNrJgUJf1A+r5/AlgxmgdaAQAA
X-Change-ID: 20260804-wiznet-link-gpio-796f36cd14f9
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTEgpHH57XgBQ9EHwME48wOaF+RJscoqdWkNllJPAr1D/gXKIweqPkLqYVCJHh9tlWpXV6BRSb9Wb57RJiVgCmAjZe1EgcRshWaNHiWGfgnGuZK4LUxu1WbpDGjU8yZQaAITf0I9nLwnvypZ0wVOdVFfZaIAkbtgQ35RsksGw5mIAyzP8tDEkyTfjgaE6UQO6QtANLdnPDnzlY9d1z1x+7sld1oQLTGeX78gLoSgrpQKnOVFX4u2mXIR6f81GKsIi1+3q957VDw80H9XIiVoIU93vD4Xno9By0wS+xvmwAgf719Mso5NngvxC3pNa71M7Y+yPrEQpQXyDNH8oFfocl2voStsj/DYdqylkFHn3uEWfDwIL608bBqhkdIuahPgg6cNxYN9uw1TABD7af5pjEQ+NPZoCJFLfVFHJ8odEkEKN46UevVRaRLA0mWnl9QbPN25B1yCCtILj/2pelSM+CXTo8fBMa2MiZOYGHEnrhMz4/vB942T/SLXMJJ42likI/qul+iTcbL355oJM+9gYUnv4tYMaWHU8cm5mBT+54slLvkzVOY/GIKUFCINuakARbzsmsMb3cPYSrlyowi1K1a3BbZXEMff48NNDqDaJf7Yb+S48pU3dQdQ4MywTwMFgMkMrIfr2yztzsof5dstPMPWrcpyLIRPSkHcC21j9m9PTQ
X-GND-State: clean
X-GND-Score: -100

Hi,

In the previous version of the w5100 driver, the LINKLED pin could be
wired to a GPIO to detect the link status changes via an interrupt.
This only works on w5500 as it is the only one documenting its LINKLED
pin to hold the link status (on w5100 the LINKLED pin is changing with
RX/TX activity).

This series of patches is bringing back the link status detection on
w5500 using the Link Status bit of the PHY Configuration Register.
Additionally, the LINKLED pin can also be wired to detect link status
changes and read the register in the interrupt handler.

Arthur Crépin Leblond

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
Changes in v4:
- Use directly an interrupt line instead of gpio -> irq
- Update interrupts in DT bindings
- Address sashiko reviews
 - drop devm_ on request_threaded_irq to avoid use after free
 - disable/enable the link_irq in the suspend/resume
 - only call netif_carrier_on|off if the link interrupt is present
- Link to v3: https://patch.msgid.link/20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net

Changes in v3:
- Change cover letter
- Fix DT binding errors
- Use the Link Status bit of the PHY Configuration Register
- Use the LINKLED gpio binding for change detection only
- Link to v2: https://patch.msgid.link/20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net

Changes in v2:
- Convert device tree binding to YAML
- Use devm_request_threaded_irq instead of request_any_context_irq
- Use devm_gpiod_get_optional instead of gpiod_get_optional
- Call dev_err_probe on gpiod_to_irq failure
- Remove link_irq from priv
- Use a fixed string for the IRQ name
- Remove empty new lines
- Link to v1: https://patch.msgid.link/20260804-wiznet-link-gpio-v1-1-b626fd4f7ccb@marmottus.net
---
Arthur Crépin Leblond (3):
      dt-bindings: net: wiznet,w5100: convert to DT schema
      dt-bindings: net: wiznet,w5100: add link status interrupt
      w5100: detect carrier state using link status bit and optional interrupt

 .../devicetree/bindings/net/wiznet,w5100.yaml      | 72 ++++++++++++++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       | 50 ---------------
 drivers/net/ethernet/wiznet/w5100.c                | 68 ++++++++++++++++++++
 3 files changed, 140 insertions(+), 50 deletions(-)

