Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3732744F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130000; cv=none; b=olKn9SsXlMhNmKY9H1n8RDujCgQkp9d5Z4fXrWZbQ3PRBKDvpPUVj1dkOtnhbc8fuHKybb3Yg1E2aygXLt3FI6zjXa7SHovFqKI6eq0lCy0Z7ZpIiXkJm2/+OzuL2NtTnRwIXHHAqBuIuE9tKxv/aFPfTF4i/9QQeZcjyk09AKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130000; c=relaxed/simple;
	bh=LcXQdWRW2GsS5I8GuOOeQZtsFoiw+GjNN+se5mePlKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q4AadV+jINPLn/inMWUs9TNKS1o2wkdZEAHpdAXnt4Xevm8eTJ/JNRyTjvYpZxv3WdGO4mFsX6qr6bcFquVUk8R/cwyOM8p1nUZQk5tBwpnNHUCs3JaDp9uH+A0Oq/gGp2RtXmbhbJE9+PP0U03X4cX7Hnksjd+lMM6hkMjRkJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiaeL965; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiaeL965"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f20513so308929b3a.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790129998; x=1790734798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=INaxH1K5pqrMxiyJhIWa4Nj2ZwXkK6QpSGkNU2jCGiE=;
        b=hiaeL965MDC5qSnfkhMsBISJMV6YdJjZoT5uXAzP8TJghOmq9pEKPma9oRPJLroDkZ
         xVcuS7lvxcBRB098rYjT8ONvhzA1edqBxCYCNXn9MkJtwxgSm3yGUU7q+zrHoQ3Z9Ken
         KsAIg/apzr3soec46Opw87fmLyKJZd0JRG0ivXfuyoZr2rIsuPJ1gYRnqOwelJldy0l9
         V1BMNbAkfEJiJQSDaw6rhuJsDZvIPUVlPjV26MAnJy28MbIGStA3okOJfiRMwEXrEdEn
         aZgDh5pAV/sGVL9nubHRjsgPzVxaOIRSQffLCI8QBcCEucNasYFUTsTbcmdv/dnPm/zV
         ISvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790129998; x=1790734798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=INaxH1K5pqrMxiyJhIWa4Nj2ZwXkK6QpSGkNU2jCGiE=;
        b=oTSElvtaDhz8gprCbaTELxoOw1RodjgGS5mGgJpk9rWnT/aWDfeq5A4/+rGFjaCgPI
         NVEniR+z1IZvtRq+pSswNmlqSfey5oxCEoxLukX0EF13K4p7g+diy52eAJ+VgnBS0aI7
         k3vtNKNdN+rsAJW6VgwvN8BT3oa58T20ov19jiYymw/6vnUzCpNdVy2/5sqpH0uVE6qo
         6mrM9f831mgVGfsccahsAEhwBbm2jugUN3sRgp8WwxLQoZnnRUKkhH4bJ85ApRcKQqw1
         odntWymqmoIYQwjnZpv5P45gPHANAe9Qn6nikXUa2EIlfJAUSSnN8hbteotDQqcXpieM
         F9XQ==
X-Gm-Message-State: AFuF++kArnEWZw1Qi5NWT+3hl6ukZtrZ7tzXfylOrXI+ACTkQk2KlJsY
	PQLk8C0E8FdzTrCIv2HjDfQvKYsTW2LvfayogzKWaxjJJs0v/994OjcMQy7jTQ==
X-Gm-Gg: AYBFou21XV44IS6LldDIyUsTY7yX02ArcDDZAGxrD3ti+vyJsAaRSwLJmnJliA7d7Qc
	iNida2wOCHr1wXac2ZWkIT9K/FZqwCvmFDZNm9l6hkfWhtCtn19GmXWAYXbThpdoNg3KJSTRztv
	WpP22XacpSlhrzle6AT0y/t3DmhPZHM74a0EN8/D52w+8gouOWI+4XhVVwio1p51IYp1r7hR+tU
	JHe+erDDLjncPFTcdT3VnHur/ofh20oQiSBMd7mvpNgAYTVfm3Sc1yHUhhLzAGZwnr1q2l1XeM2
	qNmGYp02b/iN7UGs9IPyMi2cQphQxUo4t4LPS5EP3byH2mD6IfMmUD9dSlRuswDQQZJT67Q772+
	F/UzC21JVqL8bIWDHlHQLE7rEEahHLqQDkkID+PihdXkizzx06oXZ2YtvweNAEx26CqxD9QrJE4
	Dju+EWMi4jFax0DWlYb0S04KLBZqYd+yhB4yAo1Ot0j+9xffsIsNz8kUu9UP9s6gimixH75UVwT
	Mpq/0alByOztl8AwR2XgPfL
X-Received: by 2002:a05:6a00:2ea0:b0:878:3658:23db with SMTP id d2e1a72fcca58-87d1d9d2934mr1261390b3a.52.1790129998428;
        Tue, 22 Sep 2026 19:19:58 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fe8sm502924b3a.51.2026.09.22.19.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:19:57 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/8] net: dsa: motorcomm: Add SerDes PCS
Date: Wed, 23 Sep 2026 10:19:32 +0800
Message-ID: <20260923021945.2203368-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework chip_info to tell SERDES ports from xMII ones, identify the port type
at runtime from the pad configuration, and add a phylink PCS driver for the
internal SerDes, so that the link of SERDES ports can be established through
in-band negotiation instead of a fixed configuration.

v4:
  - fix 1000basex
  - YT921X_SPEED_NUM -> YT921X_SPEED_INVALID
  - reword commit message
v3: https://lore.kernel.org/r/20260917185010.3189199-1-mmyangfl@gmail.com
  - fix build error
v2: https://lore.kernel.org/r/20260916164310.3168269-1-mmyangfl@gmail.com
  - Remove YT921X_PORT_MASK_* macros
  - code style nits
  - unconditionally write BMCR_ANRESTART
v1: https://lore.kernel.org/r/20260909190541.466476-1-mmyangfl@gmail.com

David Yang (8):
  net: dsa: motorcomm: Remove YT921X_PORT_MASK_* macros
  net: dsa: motorcomm: Split xMII and SERDES port masks
  net: dsa: motorcomm: Identify port type at runtime
  net: dsa: motorcomm: Fix register bit field names
  net: dsa: motorcomm: Introduce yt921x_speed
  net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
  net: dsa: motorcomm: Split MDIO bus module
  net: dsa: motorcomm: Add SerDes PCS

 drivers/net/dsa/motorcomm/Makefile   |   2 +
 drivers/net/dsa/motorcomm/chip.c     | 524 +++++++--------------------
 drivers/net/dsa/motorcomm/chip.h     | 106 +++---
 drivers/net/dsa/motorcomm/leds.c     |  14 +-
 drivers/net/dsa/motorcomm/mdio_bus.c | 301 +++++++++++++++
 drivers/net/dsa/motorcomm/mdio_bus.h |  54 +++
 drivers/net/dsa/motorcomm/pcs-921x.c | 247 +++++++++++++
 drivers/net/dsa/motorcomm/pcs.h      |  13 +
 8 files changed, 805 insertions(+), 456 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.c
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.h
 create mode 100644 drivers/net/dsa/motorcomm/pcs-921x.c
 create mode 100644 drivers/net/dsa/motorcomm/pcs.h

--
2.53.0
