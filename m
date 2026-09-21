Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D123BCD19;
	Mon, 21 Sep 2026 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007546; cv=none; b=IVUAPOwvdAnw3W2qf+fA5wm23uvNhQAtK0yHSqMaCYKm1X6bfpP1elRQYZvwl2/g1RJ7sljK/jkBTyzQmsrVxHQkCYUKk4cS4hBjdp6Ic/pbbZOyLW/dT2VVn39fiKItGXT0kMEgXvmDbBP9MJR5/NTeDYK12YwfkFIHU3UXV50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007546; c=relaxed/simple;
	bh=LTY9kDm4F/ezuQg+kP3vLMxDgN+aPfKP/KTaASbyRxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rf5zgb2vv3YYB9X+ppWDwiBBmrsEj2N7Mcp/pm9FJ1a9C0A1altdokcpMwMTOuDz6eEOjFlBa+I3udZA0pv9/kaZphrtsDx885ITBKf1ucSbAvnR+ESX96UoniLa+6oUtYNN9vehFD0gOKQVerxa39wkFAjiqZApZGebDO6usx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YdPOzklC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YdPOzklC"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hpT1p4J3hzKn8Y;
	Mon, 21 Sep 2026 18:18:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1790007534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N0yznBJHBQOwk1LGXmpLWdONlhIy/Ls9T9aqUlopZuQ=;
	b=YdPOzklC0ZqI/gSYkByXpI8CN+SHLzBKDyen4L3JpUUqOYCc8rRihPb/WnTz5Mngd9oX0/
	TQEO6VNPc07R6U7OPapN8pqef0mn/OXOsry5I0taWc0zdm9dVtcXNIBRxMBDsmsr8RGm7J
	PEtYv20DI+SMJLSdNIR6SRLmMVHEyYMTQlZta8nMkdX3BujIuLPw81dEXxf4cP3IZamQgj
	bo/fU4B8Bcp7toeEDivmI9mJRRqm557+30IWCF3nYynmGJOSsvosjHRXD6MVSaRECziYn6
	v+uAXHXxdRO8n2Kr/DBeHt48wFKxw20JEOH9viRXPb0yha3aJcCeAbiMJyy9Fg==
From: Simon Polack <spolack+git@mailbox.org>
To: andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: f.fainelli@gmail.com,
	javen_xu@realsil.com.cn,
	chad@monroe.io,
	vladimir.oltean@nxp.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] net: phy: realtek: SerDes lane polarity and LEDs for RTL8261C/D
Date: Mon, 21 Sep 2026 18:18:14 +0200
Message-ID: <20260921161817.565185-1-spolack+git@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2ed75e5816b356509da
X-MBO-RS-META: 551d6at9j9tepsxy16i7tekt877omiku

The RTL8261CE on the Gemtek W1700K (Airoha AN7581) binds, but the 10G
ports don't come up: the board routes the USXGMII lanes inverted and the
driver never applies tx-polarity/rx-polarity from the device tree.
Patch 2 fixes that; the link then comes up at 1G and 10G.

The inversion is done in the PHY because the AN7581 PCS has no known
polarity control - nor does its MT7988 XFI T-PHY sibling - and Airoha's
own EN8811H driver handles it the same way.

Patch 3 is Chad Monroe's LED support, rebased onto the merged driver
with the RTL822X_VND2 LED definitions reused and a polarity bit fix.
Patch 1 adds the bindings for both.

Tested on an RTL8261CE (W1700K). Polarity is applied unchanged to the
RTL8261C, RTL8261D and RTL8261D_VM, which share config_init() but are
untested with inverted lanes. LEDs were also tested on RTL8261C
and RTL8261D boards.

The LED callbacks duplicate rtl822xb_led_*(); sharing the code means
touching the RTL8221B path, so that is left for a follow-up.

An LLM assistant (Claude) was used for rebasing, restructuring and the
changelogs. The register usage comes from existing driver sources and
was verified on hardware; the code has been reviewed by me.

Chad Monroe (1):
  net: phy: realtek: add LED support for RTL8261C/D

Simon Polack (2):
  dt-bindings: net: realtek,rtl82xx: Document RTL8261C/D PHYs
  net: phy: realtek: apply SerDes lane polarity on RTL8261C/D

 .../bindings/net/realtek,rtl82xx.yaml         |  52 ++-
 drivers/net/phy/realtek/Kconfig               |   1 +
 drivers/net/phy/realtek/realtek_main.c        | 402 ++++++++++++++++--
 3 files changed, 427 insertions(+), 28 deletions(-)


base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
-- 
2.55.0

