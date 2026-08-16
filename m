Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC924E4C6
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909178; cv=none; b=mt7MhB43Azk6RhN+qpInAgAn0dWTb+GU1qUFNdmQ3SVIFjRvV9NgzV79ptGqucOjObSfc+OfpbBpnFoF3c6rYNP0WOeQ5LbJ+0MHQcZLThZIKxDdzuCglWECHrJIA0pcTn9OucwevCb6UdBGwwuV3hPx3DBgo1LlBjhUwPkP5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909178; c=relaxed/simple;
	bh=H0cRKZZ2MjqNmr096So3MTgyiAvLaZm6t7uBdOfnhVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJujvKh0BJcPPM/VfiTynuCA84PC+ay1GRW05J10jqAvsUs6T3pEXr52dn6sRmD49NOSaVcOz/TZkkJMyAyOWkxHB30j+dxFVPqXCmE1L60Ks+jyqM1mQd8JBwPzzJ46yel6O5F3vTU2xLzQ1D18kUgmhW0LAxd9RckcCj7YM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJPyqqND; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJPyqqND"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2657800a91.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786909176; x=1787513976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=znLE3PVhG1CfiCDEEbGSq37ke+ClAwZowEQNF98Jd+w=;
        b=AJPyqqND3k8XO6CXDDQl08doKBpkBPPWpzk9902LKK7UeTfnQ+dj/6uV8xztZVYX3r
         uFPMg7VBtshs8kCSy3RTYZfGSDKjDcFivR7Th0zofEZmhgv6oKiJHGy4wICoxbPkUULN
         U8Jbj7+aRXyFqIxyT8eHT24UrCZXGGEPyobfUq84eZip8S/DVmZZPjU6bnkWfeZbQmfm
         dqUdXlYR046kx/sbmEdChnorGaRtgbBg6NfeL49RFRn/v57/gWsrMm/oBIM+JlGNfmy2
         3Y7p1ACM9m48Li09ZvHr4v083TTwXfhqtiVt9hQgQ/a0rUH1q8gPWs0yXsMyFsignQac
         1/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786909176; x=1787513976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=znLE3PVhG1CfiCDEEbGSq37ke+ClAwZowEQNF98Jd+w=;
        b=oDD+UK2btT6aVYHZfBo5G/W3dV0eN4VIT5oLgTeakwg43ROqmlVlEKvc20e2I/aleJ
         M0Bpji1MAeetMkbr9bnp5J5unenHVH7YpFHwqRHx72APtmyfVhqMHVdd7ALFIhyylF/E
         yK63QPzgiKajNaceplBY6ZVjsOFps8ND1eJch2nwSpW1h0tUHsiO2VNh0AwsdWQhxAK4
         Wy9ermplBaPOpEoMHNzxzuIREXxvAKhW3TRQBrYjUU5+9TEXOen9BY8kCy7D8YctNVQf
         3M4JfztGJDbPhsEPnbNwUftGyCzW/KobsrU/4UcZQJrZwqOWJDWHubfPQ8iOj/yfEl3K
         yLAA==
X-Gm-Message-State: AOJu0Yz17PiLHFI0R6gc8keV/IsrihoBVG67Jahbg5n66RNc6PPWu5xg
	RKmEWeZf1ucd8tr68HKnJfyFUUGpJp+H4JqdZbyd37jYcWfcMRNAI0QrpZkd7w==
X-Gm-Gg: AR+sD11DaoI75o2CjMnBIDtampulPbmvDR3s7ygNYDtQuMDFLWoUEsIwxqdritVPcPD
	hwEVjKJK2Zt2mO2Up8C24UviSXUUL3ZCPf6h6BzBY9371FYkXo1qtt1YLO+xRneovo9L5be+/nk
	mYwwUMYXWttTeiq4Ohtghn+snt7A6EkSAU8wWYUEtunZnltvtb35dLslURrHjB0rigeN/H2ArHL
	kVl8UXmH6itOl2YGh+MJndvJML7mu6MTomXPIVBIBivLn6lweUr+LJn96lSUrFdkDhrPrXbHO2u
	0J4eo7ma2ib8eg3sD8Av98HdeDRvWZgO7cqRpCtAOS4Pa/cXxOfkcEWJ8PKaJoGdrxOWK91tz3V
	6UiRt+mQFS4Y8atwBxQqdK3RN8DoeNS2Je6vIc+MibFB5tiBKEpZU3VpBQgvPs/pWjMZq0nwQLe
	wlUbN+rVV6DIFTof85tWkyyQA9z1pgD/HGNI4zShO81hze/bm5WXP5HhOw70uwWlaO8jZfREPtL
	D2aiJst6J61S0dWIWdS5mn0
X-Received: by 2002:a17:90b:2781:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-3933b87a55cmr22555356a91.13.1786909176293;
        Sun, 16 Aug 2026 12:39:36 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:1a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e10d9fsm2244065a91.3.2026.08.16.12.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 12:39:35 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v10 0/4] net: dsa: motorcomm: Add LED support
Date: Mon, 17 Aug 2026 03:38:55 +0800
Message-ID: <20260816193905.218112-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LEDs can be described in the device tree using the standard LED node
notation. Currently, only parallel mode and strict 1:1 mapping (i.e. the
HW default) are supported.

v9: https://lore.kernel.org/r/20260726162731.1005803-1-mmyangfl@gmail.com
  - LED initialization sequence adjusted
  - add DT description
v8: https://lore.kernel.org/r/20260725045008.858692-1-mmyangfl@gmail.com
  - limit the led port number
v7: https://lore.kernel.org/r/20260723195335.806002-1-mmyangfl@gmail.com
  - rebase
v6: https://lore.kernel.org/r/20260709014812.1158178-1-mmyangfl@gmail.com
  - per-port initialization support
v5: https://lore.kernel.org/r/20260707064752.1030345-1-mmyangfl@gmail.com
  - improve trigger selection
v4: https://lore.kernel.org/r/20260703165241.542195-1-mmyangfl@gmail.com
  - fix some reg op typos
v3: https://lore.kernel.org/r/20260701155519.273212-1-mmyangfl@gmail.com
  - fix null pointer dereference
  - support polarity auto-configuration
v2: https://lore.kernel.org/r/20260629183137.541341-1-mmyangfl@gmail.com
  - allocate LED structures only
  - eliminate double locking
v1: https://lore.kernel.org/r/20260618202716.2166450-1-mmyangfl@gmail.com
  - set up polarity correctly
  - do not set up .brightness_get() to prevent dead lo

David Yang (4):
  net: dsa: motorcomm: Move to subdirectory
  net: dsa: motorcomm: Split SMI module
  net: dsa: motorcomm: Add LED support
  dt-bindings: net: dsa: yt921x: Add LEDs definition example

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  23 +
 MAINTAINERS                                   |   2 +-
 drivers/net/dsa/Kconfig                       |  10 +-
 drivers/net/dsa/Makefile                      |   2 +-
 drivers/net/dsa/motorcomm/Kconfig             |  17 +
 drivers/net/dsa/motorcomm/Makefile            |   5 +
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 222 +-----
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  12 +
 drivers/net/dsa/motorcomm/leds.c              | 654 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 121 ++++
 drivers/net/dsa/motorcomm/smi.c               | 157 +++++
 drivers/net/dsa/motorcomm/smi.h               |  92 +++
 12 files changed, 1098 insertions(+), 219 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/Kconfig
 create mode 100644 drivers/net/dsa/motorcomm/Makefile
 rename drivers/net/dsa/{yt921x.c => motorcomm/chip.c} (96%)
 rename drivers/net/dsa/{yt921x.h => motorcomm/chip.h} (99%)
 create mode 100644 drivers/net/dsa/motorcomm/leds.c
 create mode 100644 drivers/net/dsa/motorcomm/leds.h
 create mode 100644 drivers/net/dsa/motorcomm/smi.c
 create mode 100644 drivers/net/dsa/motorcomm/smi.h

-- 
2.53.0

