Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF2475357
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200756; cv=none; b=AsYd/7JoJ3K0dEL8ZiGQ/8aT5q+HKcO4KXAsTUIf4I9xz1BEXcap6SGNftwPkUCw0t2uX8QedtpxtVbWyxqPDVga+xm+/57QA7BYkCpzJ/XSAkcQ7It3l8Mj0i/UxxXqUmUcw6lhMoHFfIIZDdrU1ZK1NFG/EKY2RkaY9Y35f7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200756; c=relaxed/simple;
	bh=8RGeXtjXxObOBlh27DtryI+xEEeTDaHvX+2W2+vTgIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=snyAtl8HidbzZfujbfO4jWsBWNkILJ7HJvr8D7s+u/DYIrzvOntN+RaG3GJRueA+pBEGIK9LlK4G6FdZgE2e0p26//4+pmxjbsccrm/RtiSgV5xTRNpzsZ4j9F9238fr7Y8vxwui5csFBZPDrDjmKPsLbJXsyLaU2/giQTCfqHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVaHzNiK; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVaHzNiK"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f8694aeso96364666b.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200753; x=1790805553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=25b6rXxcvDVFluQ29z+eb44YMWbVsajT92YPOJsFwDw=;
        b=OVaHzNiKBqx/cr/Ll3JDJZ7dYL3Fn+7fMw4pizbJCd9e3P40Sj0XPMLtiS8YLUCxsf
         /9+X3fr5DoXx8vCjvQSK/L3M10gdbQe+dnXTCyNDIOxmnvfPBnpVLKmJSLuly1qDNlcl
         o1mZJav7Fm6NxxbCDbOVPWIaWv/P1sFvsLlEAayLut3ZyWi6kpWFaRWCCSh7FqaVcJum
         lihbTEfqe/g265nj6v38zxEuHNz7LLuTvES2CpLeo4JDKx+yc1r0U2hQA7aPdXsiruDA
         p05nESDNvkzAHiLJoo4I0m6ZxSl9YAAfDXfDexdWg2pyWkKCDHsmPZTTrGC7Jd2XxOsL
         1uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200753; x=1790805553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25b6rXxcvDVFluQ29z+eb44YMWbVsajT92YPOJsFwDw=;
        b=nDpKj+weg1EU4kdsr7IG7lxHLkbPd6b0pMGg0x9jT6nP5FL3RPi2i+VDImKJ9dlDqr
         miJqp3r7QNnUAO6k5jgrRvPzhFzejiNndbrKuf+Z7/nwdvoY7gmZRmI33WJc8202jy3H
         lJIUle5j0UvRn0lSbeq1Z+jvqw6qNaiBs5LKeQWoUkOFbQKATDlwkjg0QjvhL97/Dhd8
         ewbNgptbLIQo685eTsksesYR68cijRbBWaqz1rnBnA1/aIjUtZ1arzfWzuF9ukbtu31e
         HK+v5kO4b5tiN0oOkYkq6RrVn3HXE5JFgWp6KzGvOHAVdvUeYn8v67FNZiFvKq0hGXlJ
         OwjA==
X-Gm-Message-State: AFuF++kXlgOVH0otqd8MFPgAIN4HbfP+7RDzFZJPz/hOLJi9k7laibIh
	M8t58lrW2dFuKDbU4S2zlg102R+s8FJ1OLmMXzy6oXfjK6u0l7ya0drzmcBGvRuK08wQkg==
X-Gm-Gg: AYBFou0lHFkqGAENN2gYqa8CfGOYTJKZzmNdVzx0Vzqy8TtS5gZD2ocRH3JjOkQ0cci
	fTxPDD5gQkZrxmXVGIoLSSavYvV3Q64sK8ldfjDik0OasbUu/6zeskAkYF5hzsHNIM6YT5y01VJ
	AECT0kGTgo0xpigno2jRiqoj5nDXFA/MvLMbtwYUUhOobMzZ914hL1pi9G3rJh7ybgidG9pNJtR
	iAfh37VrpWNPxWmLUV4sTeEn1KuL2qlq7y/FrdwCYn+VlrgQ+dNwk6zVRI56KIgxLoPPeV66DkB
	NGxlx039MBzwkxchOIaV5SSJuY/u9rWdy9FtGIjtMReESGOj6ubV2erTtjr9f5EnMk+LTPpt3LF
	3Cfg1bnH/EgwmA322A2BMTPsQlUuRf2nQfBO3XJDuP2ijF1K7jUWrmhMOVtfBnpRlAzKoHVvd0I
	z730GpPpgBB+TJWa7FptJuHo1aA7/M9ZWIop4ZbQkKO1PA+UbuydBG3prCWw0OfMEvBCbMVj0BH
	/0QiGa4lUpH6SN2zSy343nNdVGh7mqRCHgA530KN16yq28/DPVDRwvoqbyKzn8lqssHkGRyPDKH
	kJ6dzk0sU/bhNgsYajge
X-Received: by 2002:a17:907:6a11:b0:c25:f7db:4beb with SMTP id a640c23a62f3a-c2ac236053emr38359966b.17.1790200753378;
        Wed, 23 Sep 2026 14:59:13 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6dcf0dsm197647666b.61.2026.09.23.14.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:59:12 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [RFC PATCH net-next v3 0/5] net: dsa: qca8k: add a QCA8337 CPU PHY consumer
Date: Wed, 23 Sep 2026 23:58:52 +0200
Message-ID: <20260923215858.1653-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qca83xx PHY driver is already in net-next. This series allows
passing PHY flags on DSA shared ports and adds support for a QCA8337
internal CPU PHY. It implements CPU port selection, serializes MAC state
across global MTU updates, and proposes disabling SmartSpeed prior to
CPU PHY resets.

The first patch extends the DSA core interface; the qca8k patches
provide its concrete user. No board-name matching or board-specific DT
properties are introduced.

The minimal topology uses a single CPU link: a conduit PHY connects over
MDI to QCA8337 PHY4 on switch port 5, with each endpoint having its own
phy-handle. A reduced devicetree fixture based on Redmi AX5400 wiring
passed dtc and validation against the complete net-next schema set. This
is a binding fixture rather than a bootable board description. Because
the pinned base tree lacks the IPQ5018 Ethernet MAC driver and RA74
board support, this series has not been boot-tested on RA74 under pure
net-next.

On one RA74 board, diagnostic boot logs showed PHY4 advertising
1000BASE-T full duplex after generic config_aneg() succeeded, but a
later read found the advertisement missing. No intervening write was
found through the instrumented Clause 22 BMCR/CTRL1000 path; other paths
were not excluded. The exact trigger remains unknown. Clearing
SmartSpeed before the initial reset preserved the 1 Gb/s internal link
during the tested boot sequence. Runtime testing did not establish
late-peer causality, a broken pair, or successful fallback to 100 Mb/s.

Two scope questions remain for this RFC:

1. Internal CPU port selection currently falls back to ports 1 through 5
   only on QCA8337. Dedicated ports 0 and 6 retain priority on all
   models, including mixed CPU port descriptions. AR8327 documentation
   describes per-port headers and destination bitmaps, but I have not
   established its internal CPU link behavior. Should this fallback
   remain limited to QCA8337, or can maintainers confirm the same support
   for QCA8327?

2. The proposed SmartSpeed policy applies to QCA8337 internal CPU PHYs.
   SmartSpeed is the hardware downshift feature, so disabling it removes
   that fallback behavior. Current hardware evidence is limited to PHY4
   on a single RA74 board. Is the internal CPU link role sufficient
   justification for this policy, or should the quirk be scoped more
   narrowly?

Changes since v2:
- Patch 2 uses reg_mutex across the MTU pause, frame-size write, and
  state restoration. Variable declarations now follow reverse
  Christmas-tree order. This patch precedes topology support so MTU
  protection is in place when internal CPU ports become available.
- Patch 3 adds internal CPU port fallback while retaining port 0 and 6
  priority, leaving QCA8327 support as an explicit RFC question.
- Patch 4 masks the revision before setting the CPU PHY flag, clarifies
  SmartSpeed downshift behavior, and drops the delayed-conduit causal
  claim.
- Patch 5 clarifies reset and config_aneg ordering along with hardware
  evidence limits, keeping generic config_aneg.

This series depends on the separate net patch "net: dsa: qca8k:
propagate MDIO errors":
https://lore.kernel.org/netdev/20260923215748.1336-1-yongzhao.derek@gmail.com/

Testing:
Fault injection against the actual MDIO/PHY functions and kernel polling
macros covered busy-read errors, timeouts and successful transactions.
The old polling code reproduced false success on read error; the fixed
path blocked SmartSpeed writes and initial/resume resets. Tests with
mocked hardware also covered flag scope, CPU-port selection and
MDIO-to-MTU error handling.

The changed qca8k-8xxx.o built with W=1 for x86_64 and ARM64 under
allyesconfig and allmodconfig, with no compiler diagnostics. Unchanged
qca8k-common.o and MTU locking retain the earlier build and concurrency
test results. Hardware tests used downstream RA74 firmware. This
revision has no full kernel image/modules build, pure net-next RA74 boot
or hardware lockdep run.

Original RFC:
https://lore.kernel.org/netdev/20260919085406.1395-1-yongzhao.derek@gmail.com/

v2:
https://lore.kernel.org/netdev/20260922202653.1153-1-yongzhao.derek@gmail.com/

Base: net-next 8830e65ed46de41f849eefb8ba227d4852c460f6.
Local prerequisite: 3ba847ea54227f704ee3b04f95d4b52d4e22d483.

Yongzhao Chen (4):
  net: dsa: pass PHY flags when connecting shared ports
  net: dsa: qca8k: serialize CPU MAC pause during MTU changes
  net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
  net: phy: qca83xx: disable SmartSpeed before resetting CPU PHYs

Ziyang Huang (1):
  net: dsa: qca8k: support QCA8337 internal PHY CPU links

 Documentation/networking/dsa/dsa.rst |  2 +
 MAINTAINERS                          |  1 +
 drivers/net/dsa/bcm_sf2.c            |  4 ++
 drivers/net/dsa/microchip/ksz8.c     |  4 ++
 drivers/net/dsa/qca/qca8k-8xxx.c     | 39 +++++++++-----
 drivers/net/dsa/qca/qca8k-common.c   | 79 ++++++++++++++++++++++------
 drivers/net/phy/qcom/qca83xx.c       | 32 +++++++++--
 include/linux/qca83xx.h              | 11 ++++
 net/dsa/port.c                       |  6 ++-
 9 files changed, 145 insertions(+), 33 deletions(-)
 create mode 100644 include/linux/qca83xx.h

-- 
2.43.0

