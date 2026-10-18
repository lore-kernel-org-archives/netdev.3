Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC474AD4CD
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340553; cv=none; b=METFWHVJFMceQam3+cg8Z9yBr2vDmrKjysCOB0zsfHC9ycY585wm3YF6xuVnf0n0JWiXSPT/lszl3qjQgDjhAramQoDlBFBGUFKH3RF5/tox+MsolTutdn7eU7t+zvsPm7rqMf2Z2ZBHhfTZiQ6z2UBjGHG2KVThFUn/8ceDnjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340553; c=relaxed/simple;
	bh=3H4IscU/TXX2mp9uO9toIfgWvRJ0vS30N+G82TUQx/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p2g8A7BJa0Aw0gR6EtJv1w8U7cfe+KL/roa4Qukbup0Gl4MjMIFK/GbZVRKbX+8Op1XkcHiJhrN+aerYFMkB4bWgDkqhbeueonP+cZJlw/dXsh8IyGvAgrxHfzVnluZbrqU5xzVFGz4I1SeskeZqIyapOSIP8ajAGuHmHSdTqEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=1YFhKwGi; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="1YFhKwGi"
Received: from terra.vega.svanheule.net (2a02-1812-1620-5d00-3535-4149-dfc3-da80.ip6.access.telenet.be [IPv6:2a02:1812:1620:5d00:3535:4149:dfc3:da80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 9DFE7955C9E;
	Sun, 18 Oct 2026 18:13:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1792339986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bd8yAyBoc0oE9NlFGWjwmYkR6VMH6Mg95VbMEB+tYYM=;
	b=1YFhKwGiX3DcFJ3rfLm6nvaX4lO2OO086pYIqV/GFrWOga+QeO4q3SAq9RVAr8HeuWuEM7
	J895FIdJwuO8blXNXv4QS+k8BsFbvkWoHKt5Gn66KWHDRqNEX/FIARimlsM5zoqvvI9fXF
	+piJzG0/yMLpEGR9HsLPZ9yTxRKiu44ldNzfs4xHmhqgJcTcUgKK6NhibH+3onVf/O3PSb
	w5rav2FuBI1jNWMNjdL6ejMIL+Sxaa+Bf93KPfHZ4CJARVsILh/3cO1CHzP2CQ6qUpLcZp
	nQuUVs1i1pufA00E0vwY2g8Qvk3N1YhBm6YngVcanQLoYXmHBKIVksIC1wsopA==
From: Sander Vanheule <sander@svanheule.net>
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH net-next 0/2] net: pse-pd: Plain I2C transport for Realtek Gen1
Date: Sun, 18 Oct 2026 18:12:46 +0200
Message-ID: <20261018161248.376205-1-sander@svanheule.net>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While for the Gen2 protocol both a plain I2C transport and an SMBus
transport were provided, Gen1 only got SMBus. The Unifi Switch Lite 16
PoE uses the Gen1 protocol to manage a single BCM59121, but does to
using plain I2C.

These patches simply add a new compatible for the plain I2C transport
and the associated match data. This is sufficient to let the existing
code talk to the management MCU.

Sander Vanheule (2):
  dt-bindings: net: pse-pd: realtek,pse: add gen1 I2C transport
  net: pse-pd: realtek-pse-mcu: add gen1 I2C transport

 .../bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml         | 7 +++++++
 drivers/net/pse-pd/realtek-pse-mcu-core.c                 | 8 +++++++-
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c                  | 1 +
 drivers/net/pse-pd/realtek-pse-mcu.h                      | 1 +
 4 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.56.0

