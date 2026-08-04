Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0D3DAAD1;
	Tue,  4 Aug 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847616; cv=none; b=s02IbgYrT2KCsgd06kqHP4LbJXRXGtnkXEzNoW9Oxbw0fJmjposWQgUZcTWHNkxCR4pIlHvQ/bbMI3ijuc0noBYBGg9zwF1tSiY0tRKK5sE26eUsWGbMavPIgqyLag7TgKUvZSeg/55+17p0u6yYa7e+tA3UCkLq+JpWiy3j6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847616; c=relaxed/simple;
	bh=MdWztLrjSzWzs60Kxlj7iz7DpJdgmfm3sg5c9aX+XI8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UvKRj1JLmT33/0QHi+z6NA6GWFB0PtXzbSbUK85FzSvLvsZYGx0I6cSysxPNOGiiuFyz278tTY/CM2hSynY/yiyJCSPbnsEApFFlc89qBW0nqHvFYBOHYLLCe6UV3qCX8XZ73x9kuEbu4kZZCTGuNi2GuBKIeHNeM2te70+jK9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AD5CC20005A;
	Tue, 04 Aug 2026 14:46:45 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1wrEXd-002s0o-1u;
	Tue, 04 Aug 2026 14:46:45 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH 0/2] net: dp83867: add new output-impedance DT binding
Date: Tue, 04 Aug 2026 14:46:32 +0200
Message-Id: <20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjfcWoC/yXMQQ5AMBBA0avIrE1SrbSNq4gFNRgLmhaRiLsrl
 m/x/wWRAlOEKrsg0MGR1yWhyDNwU7uMhNwngxRSCytKPAxK3FbPDntvldUGyajWlk4ZUWhIoQ8
 08PlN6+Z33LuZ3Pae4L4fzoAjcnYAAAA=
X-Change-ID: 20260804-v7-2-topic-dp83867-e73a84c37016
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=MdWztLrjSzWzs60Kxlj7iz7DpJdgmfm3sg5c9aX+XI8=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ1bhfZM1hflHL6oyt+qwzPk094Rj9OWOoKd9Eq/TjdJLL
 gnmGVl1lLIwiHExyIopsqgsrOAT9fjgGTlNhAtmDisTyBAGLk4BmMivNIZ/VjEhn2ZJyPYYfLqn
 bjRDoldnt9jXe1HxXIXbZV/fd4lJZmQ4nHW773HiRYO2aSs5N92oiRLy61qim5xbv7VeeM6c1Rk
 cAA==
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Currently the dp83867 supports setting the io impedance to minimum,
maximum, default or a value from a nvmem cell. In situations where there
is no backend for a nvmem cell, the value can not be set to anything but
minimum, maximum or default.

Add support for a ti,output-impedance binding, allowing to specify the
impedance via the devicetree. The existing boolean bindings for minimum
and maximum take precedence over this new binding. The nvmem consumer
still takes lowest precedence.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Steffen Trumtrar (2):
      dt-bindings: dp83867: add binding for output-impedance
      net: phy: dp83867: support setting output-impedance

 Documentation/devicetree/bindings/net/ti,dp83867.yaml | 13 ++++++++++---
 drivers/net/phy/dp83867.c                             | 13 ++++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260804-v7-2-topic-dp83867-e73a84c37016

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>

