Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFBF4B402E
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577029; cv=none; b=T/BDtEtt6h+TwJL0tQxLkK37mylr3SBn6fXVCafGMFfJ8WTV+tQsNh4XBRP1VOiVrOHyACZMtd5AOhlOZ/KmIEGINGIBzabQGWkMGshoy15KOvhMgOw5fw2ZAPmGVQa59yk4SZv5nyzS2HNSKpGOuhr892m2hOLrxL7KpPNUBsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577029; c=relaxed/simple;
	bh=cRIImi/lPk53n1lWQ4BsxrEtpf2R34//cfhxTWVnMy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKkSWzV62wYjjUHCgudXbaLKPi4SEtNWJuPiMwHZbqfgUbiLQkk6MBW1iiAXUo06YW84DP5fTuxoj4W3ZVaswb3d0o5twXOXS+Wfx5Nh3Gv61kiOt41tVu/GoZvb253KoZEZIshaB3yRq6nVOTpuUQY1SjmglvBiwYiur2U+Zpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRus32LU; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRus32LU"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso997724a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577009; x=1790181809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0VTiuPg5ZB9LmT2MDT455GVREdoYqL1EhzCrifxbyUE=;
        b=JRus32LU/EnkGj5DeuL5SLHyT1OD2lCGh1d+YHTlCbRk04adSiTFP3zQj1vSlsfgCY
         57tNl7brpwFsYy4fTQQyAEcfXpJBIbgqcLv1Gfuy37h/HY7bL7TD038rNCgZAFTQTRLy
         Jhg0voYfBrhywPUNd84UGM70kiD1Zfkrkomf/N9XhKp84dyXDmFg58/jXMsGzIsBtiUZ
         2ZLo9T4FOvjVYCfOEeodedJymBRADJDb5b7tOV8WgU/ZIH1WxLON1EXduj7SlVaVdKrZ
         jor8yuHKNtUgGFa1J5U7eDGFc4Zyr4NtKojZNsogHBgbWNtnjVlG9fSdJLs9KJXDrE82
         QtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577009; x=1790181809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VTiuPg5ZB9LmT2MDT455GVREdoYqL1EhzCrifxbyUE=;
        b=e07KqV2TOl87SO59hupR2GhBisdLkWMw56oMd8gFD2/qiBs+jg/JhqZeeA6trpPous
         aBsQPVDQFlQMZxBCcMqk22csAYc4rESbSgHm0rRNbnuWEXeKL8NBYYYqwCqVcmUxbgpW
         0FZPr9d9ij3XZJftjpOBvs1hHrtN1iYYo0Y0XtGov3THPravDgPE4jEyhukW/EVcbUch
         vuLcUy+gQDacjOZL3kG2BpPkrOFgQjPwCbqW3+E236hButgd+wYgRaEFHavPpodTd6Z3
         ZQZhvDKpq2rwm5lwP4Mtdzr9BXeAvwH0YtnH//+EH+ZVR0DbBiThSKUc470ToBFV4Ht4
         FGWQ==
X-Gm-Message-State: AFuF++me35/ce/6JVlAlUIt1jPCA3bu70glNdAnTtmP3CzbKOXzS9fnD
	cuWwkIDL+lVpNT0BIoZCRw796tsJ0kpkXrpI0LJf7czUKSDtbtak6C/v0r3lhTsl8UY=
X-Gm-Gg: AYBFou3xbdoU35muLwRKGed1akJhtugesajooh9BO0ZebBit9MpHbpe/KnAgkTH5xvz
	bWX+i7pGQ1fNZdp0n/YzHfASuxyMhdIoTVoKlIebQtWuTTx0bJboWfIOSnv5GHMzImmWLgZvNMA
	ogqnX03/HqmqzwZmCeFZTUXhemsj7iHZ8uu2Ur5Hj0hZI8V7o1OMBa4+RsNoBJmcRUMXuY7NvRv
	H7yV9/GMQWA8kt9xbkERZK3ksjOkBgjRaWfnFsisRGChg6VZyNmycw1LPb+4hntSnTBVD6xiFqk
	gusBhAzcAxmAxz2XOBiL/6b3aBUB2705Y+P1EnnsA69t1soeqx9+2Tr4MYks4C/8kqroMAmZ2tZ
	QYhc41PKdCfJA+MSxywtwAzTioxcMSq9p7VEro8Qb7crqzLr5ODM1y2XqP+oJKzMw9sOEzwtqQs
	SVL0F0LhDYxT9y/uUsE72Zw6qikDpvKMGfEFyHkz41mdGLyQyyMRAQ2OGmKzzlUBQSQrw7YlOrj
	3tQjJAq9JgMd8rMX3iq3/a2fBISCBqeEb1V
X-Received: by 2002:a05:6a21:e8a:b0:3d3:b00b:50fc with SMTP id adf61e73a8af0-3dd5f7b3ab7mr8788940637.28.1789577008744;
        Wed, 16 Sep 2026 09:43:28 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc757csm1902278a12.32.2026.09.16.09.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:43:28 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/8] net: dsa: motorcomm: Add SerDes PCS
Date: Thu, 17 Sep 2026 00:43:00 +0800
Message-ID: <20260916164310.3168269-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support in-band negotiation of the SerDes ports.

v2:
  - Remove YT921X_PORT_MASK_* macros
  - code style nits
  - unconditionally write BMCR_ANRESTART
v1: https://lore.kernel.org/r/20260909190541.466476-1-mmyangfl@gmail.com

David Yang (8):
  net: dsa: motorcomm: Remove YT921X_PORT_MASK_* macros
  net: dsa: motorcomm: Split xMII and SERDES port masks
  net: dsa: motorcomm: Check port type with runtime info
  net: dsa: motorcomm: Fix register bit field names
  net: dsa: motorcomm: Introduce yt921x_speed
  net: dsa: motorcomm: Hoist port_to_priv helper into chip.h
  net: dsa: motorcomm: Split MDIO bus module
  net: dsa: motorcomm: Add SerDes PCS

 drivers/net/dsa/motorcomm/Makefile   |   2 +
 drivers/net/dsa/motorcomm/chip.c     | 525 ++++++---------------------
 drivers/net/dsa/motorcomm/chip.h     | 106 +++---
 drivers/net/dsa/motorcomm/leds.c     |  14 +-
 drivers/net/dsa/motorcomm/mdio_bus.c | 301 +++++++++++++++
 drivers/net/dsa/motorcomm/mdio_bus.h |  54 +++
 drivers/net/dsa/motorcomm/pcs-921x.c | 235 ++++++++++++
 drivers/net/dsa/motorcomm/pcs.h      |  13 +
 8 files changed, 793 insertions(+), 457 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.c
 create mode 100644 drivers/net/dsa/motorcomm/mdio_bus.h
 create mode 100644 drivers/net/dsa/motorcomm/pcs-921x.c
 create mode 100644 drivers/net/dsa/motorcomm/pcs.h

-- 
2.53.0

