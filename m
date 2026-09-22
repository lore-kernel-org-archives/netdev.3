Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398EF3E835F
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108840; cv=none; b=UFrniIyIDIDERtlOQdOhjjgbhWOzK9Zhcm71M2aVBhyl6ABncf/0o9oPi+Qw1DfJU8zxcrHSLWwa3ev5MW34rGltbjlatQ4LFap+DMgR4KmPypRcA2TkJTRBTF/zBwNZ8lxge+0Cc7YH9oNkIUyc89nXPlLJXkvOJVI9+8jVck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108840; c=relaxed/simple;
	bh=tRfXfoxrp+0Njce/21UQI5M+qARptzu/vP1Jo/2gMMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oez3uv/wAzQTZow/Ob8KIkeQYNB9i/CTXEWsMk+GKzluDGpdbCza6gUUXNT1nLSDuxZSwCJtK8HtNMgX1eBI4Hy0hGirSJrnL1z4mPs7IYiozSfyk0vPNo+zaJVxjTx1TkIpDCi1Yv4TTM4NF2rRqaH73DWIQyXWrgzaEevipZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU5eneIv; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU5eneIv"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c254f9f0b20so29999166b.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108826; x=1790713626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VxtaLde05pB4PcHsmAfTEQbvIyCGZbUg7Mi/kjz9pd8=;
        b=DU5eneIvFfoHHeMoU7/9fXIyJRFB/GqkbMpXau5Gkwwrb9luDpHQImCu82eD8wZUXx
         Zuv1XFzZqbqS9kShS0qsIJUfjkuP4qQ6oHRl2FvVc31a3Thh/t0lyXHRgY5ZvqrPSTZF
         slDMqlYyIBvmrIiAWTxQwTWWus355FrSkLr173YJjPiRdNxBkSkEx9EzrxYQWawOxVNe
         zcAEWXUEw+mauqOm9w6gaAXkG72zzKd6+l1kJsnBNgWo8C69MnN+D7PVm44wKNJ11FLW
         mUn1qQgASl6uVN/v/1fcrYacxn8undvtv6/Boe5VRjfXb75x4cpwQPsmDIU6Gf+kAxCJ
         +2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108826; x=1790713626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VxtaLde05pB4PcHsmAfTEQbvIyCGZbUg7Mi/kjz9pd8=;
        b=L4Ph38FwqVhztccW136vJTjEuCA0Xyi61VGP8rHWlLFwYYZEstoyvnBJiufVvexrGt
         A+1SzPHIztZDrqKuqkQ/elJETsQ1Jr+OYUxpVBC3KJ1u746PgXkl4g2UPMNGBA4qp9W4
         HKOQRy1r78KqEmE2XbkXOn6Ztof7wNPHvv4wUOZ3v2A4tvu4pJuAo6923wrqM6Wmzenq
         41Fhw/DJU0lTLoaXuiMoapUvqfyZdq0S056wpxa4wQpChdnxTZtzwggi5CLGByrEsi8n
         qvuktarH+AE1N0CwuIds7EmvkxsC9bUFyfkDkdZoqoCJOSGsLfitP9EqNXXds+IVjTiu
         yRJQ==
X-Gm-Message-State: AFuF++l7SliDWrt1mkGRnJ2LH6FSepeo7Fb/jaNisTeU7MeoSENsk39b
	er846/WKdIvdm29fTMWp932P6DpS5GZ6/mtp2w8lCI72lCwhy65TuGT6l+F1bN4m2xo=
X-Gm-Gg: AYBFou3JAytcnTwaLGWA0/RY46YMfolFLJ3mBMr/Grupy3Up/SPEElWUdQhlyTYgfr2
	YQdzO53V2YwDmYGYs33ymkkhIM52QtwSeqAf3BBLvOT2C18yDfnOfHFeV+eU8gyAmKAMjymbmt9
	hAHObjsUUsNWw1uJTlZP7Y3O0bBZvsRpCyXNqq7qmRaAo6BlX9Ns24KDrRyxv89VxtorPYfJgJw
	/O+K0NMmOOZU+//CCQCXrvwqKLMdyxlg2cBkLsyGKu/5IV7OBm1PqM1Qu+NLtogHQWY9DuJuaIB
	ESTDju0dwv2OiTOknoGAB471TMnZOIKnjSCuyhj9tVvljsj1uvfc1FySgpoJYTySWTy4RCA4vAK
	5dfu6l5/lhUZ15VkrbUljafljmXLSal385fnsf0P7Z/dnKISSBgXlGLtN3JaTbOZLuw9OK9R/5f
	21i301NtEoktQebNMAR59RTR1lfu8MIpUhMhFhRlol6A/sOOxVmylEncwDZ3zBmI2oMLqkx3ZOs
	usyYVOIhd8YfpfrXWn1EEStxWm+whXZhKkm3pBCVZj5e1xBHJ4FuOtepliUsNRghfNz391HPAZ0
	SdAJ7WxdvSvlEgutrie5
X-Received: by 2002:a17:907:6b05:b0:c29:f5d8:9c76 with SMTP id a640c23a62f3a-c2aadc84872mr33478266b.37.1790108826181;
        Tue, 22 Sep 2026 13:27:06 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c6f5asm11080466b.15.2026.09.22.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:27:05 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	ansuelsmth@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	florian.fainelli@broadcom.com,
	jonas.gorski@gmail.com,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	hzyitc@outlook.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yongzhao Chen <yongzhao.derek@gmail.com>
Subject: [RFC PATCH net-next v2 0/5] net: dsa: qca8k: add a QCA8337 CPU PHY consumer
Date: Tue, 22 Sep 2026 22:26:48 +0200
Message-ID: <20260922202653.1153-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following Andrew's feedback on the v1 RFC, shared-port PHY flag plumbing
now includes its consumer within the same series. To clarify a prior
misunderstanding, the qca83xx PHY driver already exists upstream; patch
5 supplies the new flag consumer alongside internal CPU-PHY selection in
qca8k.

The minimal topology has one CPU link: a conduit PHY connects through
MDI to QCA8337 PHY4, belonging to switch port 5. The two sides have
distinct phy-handles. A user port provides the data path; ports 0 and 6
are unused. The existing binding accepts an ethernet phandle, phy-mode
and phy-handle on port 5. A reduced fixture based on the documented
Redmi AX5400 wiring passes dtc and the complete net-next schema set. It
is a binding fixture, not a bootable board port.

The pinned net-next base lacks an IPQ5018 Ethernet MAC driver and an
RA74 DTS description. Consequently, this series cannot demonstrate a
runnable RA74 platform upstream, though this does not preclude other
hardware implementations. We would appreciate review of whether this
code-level qca83xx consumer is sufficient scope for the RFC while the
board and MAC support remain downstream.

In this revision:
- Patch 3 serializes MTU updates with phylink link-up/down and port
  enable/disable. It restores each CPU port's original TXMAC/RXMAC
  state, so a link-down port stays down while LINK_AUTO is preserved.
  Failed status reads or MAC pauses abort before the frame-size write;
  restoration failures are logged even if the original operation failed.
- Patch 4 defines the shared switch-to-PHY flag and marks QCA8337
  internal CPU PHYs for SmartSpeed suppression.
- Patch 5 consumes the flag in qca8337_soft_reset() and before the resume
  BMCR reset. It clears enable and bypass-timer bits, preserves other
  register bits and returns an MDIO error without issuing the reset.

Validation:
- All five exported patches pass checkpatch --strict and git mailinfo;
  each parsed commit message retains its DCO sign-off. Independent
  sequential application reproduces the tree.
- ASan and UBSan function-model suites pass 7,189 CPU-selection, MDIO
  and MTU cases plus four resume cases, with 14 negative controls.
- The current qca8k-common.o, qca8k-8xxx.o and qca83xx.o pass x86_64
  and ARM64 allyesconfig/allmodconfig W=1 builds without KCFLAGS overrides.
- Physical hardware testing on upstream net-next has not been performed
  due to the absence of upstream IPQ5018 MAC driver and board DTS.

Changes from v1:
- Clarified that qca83xx is already present upstream; patch 5 provides
  the SmartSpeed flag consumer.
- Added internal CPU-PHY support (retaining Ziyang Huang's authorship).
- Serialized MTU reconfiguration with MAC link-state changes and restored
  each port's original TXMAC/RXMAC bits while preserving LINK_AUTO.
- Narrowed MDIO address filtering to preserve external user-port
  behavior.

Original RFC:
https://lore.kernel.org/netdev/20260919085406.1395-1-yongzhao.derek@gmail.com/

Maintainer response:
https://lore.kernel.org/netdev/59975387-5539-47e7-bcca-4a5ed0a84bad@lunn.ch/

Yongzhao Chen (4):
  net: dsa: pass PHY flags when connecting shared ports
  net: dsa: qca8k: serialize CPU MAC pause during MTU changes
  net: dsa: qca8k: flag QCA8337 internal CPU PHYs for SmartSpeed
  net: phy: qca83xx: disable SmartSpeed before resetting CPU PHYs

Ziyang Huang (1):
  net: dsa: qca8k: support an internal PHY as the CPU port

 Documentation/networking/dsa/dsa.rst |  2 +
 MAINTAINERS                          |  1 +
 drivers/net/dsa/bcm_sf2.c            |  4 ++
 drivers/net/dsa/microchip/ksz8.c     |  4 ++
 drivers/net/dsa/qca/qca8k-8xxx.c     | 37 ++++++++++-------
 drivers/net/dsa/qca/qca8k-common.c   | 79 +++++++++++++++++++++++++++++-------
 drivers/net/dsa/qca/qca8k.h          |  2 +
 drivers/net/phy/qcom/qca83xx.c       | 32 +++++++++++++--
 include/linux/qca83xx.h              | 11 ++++++
 net/dsa/port.c                       |  6 ++-
 10 files changed, 144 insertions(+), 34 deletions(-)
 create mode 100644 include/linux/qca83xx.h

base-commit: 8830e65ed46de41f849eefb8ba227d4852c460f6
-- 
2.43.0
