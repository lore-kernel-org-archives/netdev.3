Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5B42FE56E
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 04:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784955016; cv=none; b=GtMJxaPKAvVl7X50pwRrGuNwPRNWFrp3cOSro1uajSjnBrf+dVms29AS72O7gz7fwsnQXjF/pchjiSCJVB4Ni9hu2iu8SVpcLeR8yg92LBRfbuaXbfuIICurr4ujSrwcu7sAndgwbVpBFarWjk5m/YOOpdzbQa/0Haj2DWMPs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784955016; c=relaxed/simple;
	bh=IGPdho9EqaqpXIp9jnYxg6268NNEl+usHfHQBEcwgHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZtZlZ+Vae1IxE/493HXUhatYwr/Y1SST4pFQvSpfWqSZG95uFhD1ohkJMAS8YFU5UFgrqBMwhZGoeGz17brM2ccWkWRm62EfQV/Nsd1pBJwC+tEA5P06hCsU3syXlytYifQ+16zthjZAI6YThHhqVjQtz1gJqRdrlLyyxnLYGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OB21N06D; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB21N06D"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38deea72eebso1245786a91.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 21:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784955015; x=1785559815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TWLnHt37jEockT0IeD12T5LOGAw74alvbIB38aQy734=;
        b=OB21N06DpwhCjOxmcIif2o3nvQagamFRCiDhoN6anAtOurdNhxdAYmRaucrIf06eWX
         8/xV6blgK2OTYIfgd+05HZcvXhXTKh7HHw+bo1wuVR4L3V0vfq7sKdslGL2IYRaBuIHM
         qaPcUecSwdkUh3Rx+56LVqpqh9dK4sjPnn9gY64+xxZDJaSCwTlt10DgUYqEefNOykFc
         MyGLgFKgY7sas5Wr/acVZeQMo6m2TRngWNXBnKB9uivGgmxLXCK2cjriKbe8jAEN6YV7
         BDeEiEi61HnNHDPJ08Wew8Pw1XPn9sJnCqKNFdJEFd25UwxmZrQ2iubIunnVHySvQaIz
         4N9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784955015; x=1785559815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TWLnHt37jEockT0IeD12T5LOGAw74alvbIB38aQy734=;
        b=F9+MbRbQZDyEWxVVO3YSHeGIIkYEPC2ikieJUPOeICkofeNZtI03Gz64BO9Oi8erhl
         /bkmETooYJSBvoeK8icDzwKnZCov5uqdqQNLbBjjJfIHew732aR9uj9+kL0Bnp3puTK5
         C9BOIsQMmoyOaeb6O2szHBU9rJk/Sm9jH/P+Qp530+Adc48f5yAgY/LGRXtHaqlUvBJc
         VxSDV3qG6IDQQON5Z5KEicivfGOs5LX9S/eBau9dSX5aDL/5BBAM8owOgqeXHcmoL2U3
         l8CbyI6/KUQs9JOcgwwRKRtgLX34B2pABy5MAUSSpJJfgKvAAID3iZTlTu18CxM6AJ+v
         1IkQ==
X-Gm-Message-State: AOJu0Yyql8OqKVHS8vw6j7U1kQiLCAHXFbrKrR5iv1RlX53rOpz75K9J
	Eo0iJQu7LWcC5Z8NWI/Nzls2aXTjCwcN0taWuYAZGpo3jgCT5dZJFvUj1UnYvbzM
X-Gm-Gg: AR+sD10BTrCTp+LS3rWsq8w96kDpw47oT9GxLmvFCWqg73IQmxzW63Jx1WQxgyx3UrR
	ucBlZiLXG4UPDLTE7CASW9hdHke4ItaWbx6X+1bfcqcDqw7TNzsLYRC0/WFipRy294XDHDatD6T
	RRSZPdPp7DM7oVjS6PNfRlSaBKeta55x/LdboeINF+Ore6i88swt4PedZ81yZtiIoN3wIBKbMv+
	MfggMJk5KJYvHUmivxY74+c9NgqXsoXZEqkEbd1lRqHraUfPWTiQQo6xrtQ4wgMVZuvGaU2n/9p
	ZsYznqwJgWX8JDUhiBrY29vNj5TISowWAZHx5RxyzfJI28TELlasM3cvmrFSsJvwH2PVP9J6qO2
	NcSMWefWTaNpnqF3xaYRwSMklvkIaMlCLjQQX+3AndxUHw9LI8bL8hg/DxiFrxQsLddv/b9t3k5
	Q0s5LpYqEExv8wxKlFr1qsUr3B2QT9
X-Received: by 2002:a17:90b:520a:b0:37f:9ce1:cdb2 with SMTP id 98e67ed59e1d1-38f2965f911mr1269364a91.32.1784955015048;
        Fri, 24 Jul 2026 21:50:15 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:6619:3046::4cf:5c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f090b0c9dsm1204155a91.4.2026.07.24.21.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 21:50:14 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 0/3] net: dsa: motorcomm: Add LED support
Date: Sat, 25 Jul 2026 12:50:02 +0800
Message-ID: <20260725045008.858692-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  - do not set up .brightness_get() to prevent dead lock

David Yang (3):
  net: dsa: motorcomm: Move to subdirectory
  net: dsa: motorcomm: Split SMI module
  net: dsa: motorcomm: Add LED support

 MAINTAINERS                                   |   2 +-
 drivers/net/dsa/Kconfig                       |  10 +-
 drivers/net/dsa/Makefile                      |   2 +-
 drivers/net/dsa/motorcomm/Kconfig             |  17 +
 drivers/net/dsa/motorcomm/Makefile            |   5 +
 .../net/dsa/{yt921x.c => motorcomm/chip.c}    | 222 +-----
 .../net/dsa/{yt921x.h => motorcomm/chip.h}    |  11 +
 drivers/net/dsa/motorcomm/leds.c              | 647 ++++++++++++++++++
 drivers/net/dsa/motorcomm/leds.h              | 121 ++++
 drivers/net/dsa/motorcomm/smi.c               | 157 +++++
 drivers/net/dsa/motorcomm/smi.h               |  88 +++
 11 files changed, 1063 insertions(+), 219 deletions(-)
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

