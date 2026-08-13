Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF101442FAB;
	Thu, 13 Aug 2026 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611515; cv=none; b=dS45jqexl7anK0ZZr8DCffXmd/4fcVyS9vTSGI1KLmLHQbJM9XDBLmdDh3TnHqnSqZ4AtS6Ybp+CVUVj3+hq/7WbHZPN39yMAreYoIJmKoclvGHHnpL9+//xzjDhyaBwbASYTwypBXQTRa2jrA/dFKOSHm1xLrFbkAYYTAPidRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611515; c=relaxed/simple;
	bh=ijWjaZII05Wuzz3cGoo4XXctJt9c8ypYrEz2YmjoFBI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GK2jvKGwW4kKKSGhbxNLERsHytaGJIucXSnTRP8ipp+UdcdBTIdz7l1gixJCrLGbEU62+OZrK5PAu63ZI6kzqnSNradQviWc+uxM68DFLS1xPZk+0xYZg5Xsq9ceqIyCiDxAZz0c2wmVWh/b1aDClV9y+NniekiiYHQrZQfmFsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=PSz5PR5/; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="PSz5PR5/"
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF5591F654;
	Thu, 13 Aug 2026 08:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786611504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vn52oveGQUApmSOAJO7rTm4D0cNjN77XfbGI6cwt154=;
	b=PSz5PR5/4p/7i7aGl9iMjshNQvALrdjfWPdKl4CHCz9/NxEpqKS996OvckPGQ0Gd50bqhd
	Kza9bEASAlrvy/AZ8Jxr3EgqOhkib+/x25V8iZD4AN92rF+ygwoCz37XCyyRIQsn6OC1Wy
	6sZ6Y3XbvV9lWhPkn9tVJrMC/fIi2B9ktpWb9vRfcJ3DFQRLvwmd62Al+ur+J33EgmLp5b
	ycIcvhbKE79wRA51WR4wjB6HWNVsi6auRITLjdwNwQnjRCsjUlfhqkDSZDGhS1ucn0DC3z
	O/9AXVB1KNkfHPk3tRMxvuEPmHzX7wuQfP+QsAcS8wHEKZzJi61ZOcY71dYQ7A==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Subject: [PATCH net-next v5 0/3] w5100: restore GPIO-based link detection
Date: Thu, 13 Aug 2026 10:58:13 +0200
Message-Id: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACWHfWoC/4XNy07DMBAF0F+pvGaQ33G74j9QF44f7QB1KttNC
 1X+HSdsKhTEcjT3nnsnJWQMhew2d5LDiAWH1A71tCHuaNMhAPp2E065poZKuOJXChU+ML3D4Yw
 DdFsdhXaeybglrXbOIeJtIV/JHE3hVsn+51Mu/VtwdRbn7BFLHfLnsj6ypfH30MiAQa+5jl7Gz
 rn+5WTzaaj1Up5bcpkY+X8IBwqiZ54609Eo1BoiHhG9goiGKMG9tEwKQ1cR+YAwtoLIhkivYue
 tMcqa38g0Td9JAzAgnwEAAA==
X-Change-ID: 20260804-wiznet-link-gpio-796f36cd14f9
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Crepin Leblond <arthur@marmottus.net>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTGJcHHQN43ClLRAtjAJeEXENQ2NJW0/wlGToYOfPebkde+WB0NicxxmK0UCvjOiFUR/mB/BVcXf4eIjFrCvDQzXypzR9n3p3dJmQ5sNUrGI61uqygUeUZ+FdQ9CNAikAqJ89vdSlhI5DCtGRI4Ze1QVdMuEBfIXBAxzYqoW2rDf+stuBu/TZiu0SuTsMDZJNHUx+bIZvHHi5TyY85AgASYdR11BT0VA7lWorG2IlEJq6xw2XUKNXXUeYoZWUgkk68zqD1D3zXRBrCZnwqf6hCYlMmvTRODBn8Px6nRGZ4nlYVVim1mHPzNR1GkosvWtpEIloIJgU/bkZH8zbuWQEtDxs17KDOc0KuTjfRqCwKxdy6e3XhwAbfRldRnjCQ5uBu6lRYXpW7NEDx1cjwTJsWF4QFXjvvFSVwWbSVfO84YlafK72ohdGVJVfKpbRPTS+t36b0Ea5sFeZ07EoRzSxI6jWxRG0vQIR6BLBfsGj6XlI2x6TevmTaLfz6YQStr0sSzx22bosPuUO8lBmot18d3BS71FHQIddZEHHHHYBLkFQisCk+OW+AChPfDXDST42FlY0NOFwzCc+Vvt8KyYbHgXtGCPpAoHgmg2IRX0EiFWVabgVyywxRG4BxtHxbs5AOxPe8P3P1vojcgY5B7PIK42EvevhfHQkEuHOGZkyoyJQA
X-GND-State: clean

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

Arthur Crepin Leblond

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
---
Changes in v5:
- Remove gpio/gpio.h include from DT example
- Make the DT interrupts property dynamic from the compatible one
- Fix DT bindings errors
- Read the link status register only on w5500 instead of checking link_irq
- Address sashiko review
 - call netif_carrier_off on w5500 link status off in open
 - enable/disable the link irq in open/stop
 - enable/disable the link irq in resume/suspend
 - handle link irq probe defer error
 - register the netdev last
- Link to v4: https://patch.msgid.link/20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net

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
Arthur Crepin Leblond (3):
      dt-bindings: net: wiznet,w5100: convert to DT schema
      dt-bindings: net: wiznet,w5100: add link status interrupt
      w5100: detect carrier state using link status bit and optional interrupt

 .../devicetree/bindings/net/wiznet,w5100.yaml      |  91 ++++++++++++++++
 .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 ---------
 drivers/net/ethernet/wiznet/w5100.c                | 119 +++++++++++++++++++--
 3 files changed, 199 insertions(+), 61 deletions(-)

