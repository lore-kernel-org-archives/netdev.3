Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24BE3FD139;
	Wed, 26 Aug 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748544; cv=none; b=hmP/yKTqV1C2u8CVS79dTpw8lkNNM2L/Myk+oYjlXE6rH6Iz/6v3hemSWCQoIalF4ASZew+eGU5nW/n1gXUUU5QVaCjCZGJlVJIGkIGrWx6tnTWRT8NCMIlhh0pL24y7P+dGXry2aHezW3llMISPWRy7PBCki/i/RO3qARtpDBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748544; c=relaxed/simple;
	bh=/RYNfUur2igYikcCTLtsJTw9NmqouEwWBRy73ncqdEk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Opcr/4lcTpq0SKZcCwTWiDuJEIs1eJ8h5JiVMz9j1OEaQJDfp8T22hgZw2lpcTl4ty2+3tGFGf8Yycgs7jwYxNqrdnobB6yogNwKdZC/G2dE0zglBnn+AtgHg07n+eWuzn1RUh4Z/JgzBy+JhceeW2SGy1c3VVI93zeSwM4llfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 64B84200F53;
	Wed, 26 Aug 2026 14:48:55 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1wzD3n-003RRH-10;
	Wed, 26 Aug 2026 14:48:55 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH v2 0/3] net: dp83867: add new output-impedance DT binding
Date: Wed, 26 Aug 2026 14:48:38 +0200
Message-Id: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6DIBAFf8Vw7jaAVmhP/Y/Gg+Kq2wMQQGJj/
 Peqvfc4ybx5K4sYCCN7FCsLmCmSszvIS8HM1NoRgfqdmeSy5ppXkBVISM6Tgd7rUtcKUJWtrky
 puKjZPvQBB1rO6Kv5cZy7N5p0lA5jophc+JyvWRze34MsgIMwrbpjd6sQh6dHO84pOEvLtUfWb
 Nv2BZJLouXLAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2057;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=/RYNfUur2igYikcCTLtsJTw9NmqouEwWBRy73ncqdEk=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ1bfg23u/d/VlA1e2VrmZPkyvtBYaFWz+Nj+vsvxUhuYD
 iodcdPqKGVhEONikBVTZFFZWMEn6vHBM3KaCBfMHFYmkCEMXJwCMJEXexn+1zAlTcj07FwnrXZ2
 zz3BAGXe4rjVP33Tk9YXhk75cGPVAkaGozwazI4G76L7pk85wP6ALfaY3RX2ZT/i81o5l/wIvcP
 NBwA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Currently the dp83867 supports setting the io impedance to minimum,
maximum, default or a value from a nvmem cell. In situations where there
is no backend for a nvmem cell, the value can not be set to anything but
minimum, maximum or default.

Add support for a ti,output-impedance-ohms binding, allowing to specify
the impedance via the devicetree. The existing boolean bindings for
minimum and maximum take precedence over this new binding. The nvmem
consumer still takes lowest precedence.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes in v2:
- change 'u8 *val' to 'u32 *val'
- fix logic in driver
- update description of new binding
- rename ti,output-impedance -> ti,output-impedance-ohms
- make mutual exclusivity explicit in binding
- Link to v1: https://patch.msgid.link/20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de

To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Andrew Davis <afd@ti.com>
To: Andrew Lunn <andrew@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Steffen Trumtrar (3):
      dt-bindings: net: dp83867: make exclusivity explicit
      dt-bindings: dp83867: add binding for output-impedance
      net: phy: dp83867: support setting output-impedance

 .../devicetree/bindings/net/ti,dp83867.yaml        | 26 +++++++++++++++++++---
 drivers/net/phy/dp83867.c                          | 18 +++++++++++----
 2 files changed, 37 insertions(+), 7 deletions(-)
---
base-commit: 495561a136eaf585a305d36fc3affdba94aaf28e
change-id: 20260804-v7-2-topic-dp83867-e73a84c37016

Best regards,
--  
Steffen Trumtrar <s.trumtrar@pengutronix.de>

