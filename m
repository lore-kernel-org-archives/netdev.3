Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353923E0C44
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047166; cv=none; b=QvAu4aTM1GaGO4umDUArDdgRMEZcOZ0tiINb2qkSyWJBS85l1BpsuE1N13gzQNbA6E3GgzGgdSuM80o6u0lZ4q8mE2e0acdLjbgtTmE+ESV3MaMrh6N1YhgjOK1A8VaC5Dc23ySP7cB3/9NIqq4yaYTwEuWQ3KsNN11K0uMk2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047166; c=relaxed/simple;
	bh=OwXICggz84N7p+OQgKb24X/PrSUEc0WE1UwueAjz+lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzAKLIOy4SBeu444bMJeHSGWw2gDFFJxcDPgfgbjfKmZjF75Jw5ePIVISAaZBCjth2rALwtpL66xcLdFXitK+G31yXzQoFhODcUofwBGUnb0jPK0uzpkDYTdb3ur1JxINDyrdmol1SRtlZIcIst4AcdW5RT9aJ2kEt9uENnv6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=G4cWTPcQ; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="G4cWTPcQ"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6261A5842;
	Wed,  1 Apr 2026 14:39:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775047158; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2IVLKaycGaXgLsP9HspIEaxDXMjxc/z36Xv1mZjnLWY=;
	b=G4cWTPcQE5LJeAM2fvB1IkvTRNYIIXw93NH7SS3K/i16Ug6hW9VsmyoIjbUBA1bFPlPoCc
	4sZ4WOl+KORPzJioaRt/5+hlIcriA4rSF0DV4hKeyf73+qmAOKjHhFJJRAdY8hBWrVaSwv
	t2h5EzlGaDTbXUV8Ds/hOHOuDegm501yPthH04hQh7anI0aau9iCmN0d/SbBI7rcqW8NQh
	LKxvBUt5WDJuTTsBpkIrJ4NwQpZ+KFOjwPb16hoSFmmBFd7ulGOKigfY8WQs5dfs99KLQk
	kJ8oWcFMlo5dzEbhxVGuCsSaLh4EdbF7TyCKV5aEOrNdBVtQ95ymT1q3GlBWHg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: netdev@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next v3 0/2] net: phy: microchip: add downshift support for LAN88xx
Date: Wed,  1 Apr 2026 14:38:43 +0200
Message-ID: <20260401123848.696766-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260329224202.500229-1-nb@tipi-net.de>
References: <20260329224202.500229-1-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add standard ETHTOOL_PHY_DOWNSHIFT tunable support for the Microchip
LAN88xx PHY, following the same pattern used by Marvell and other PHY
drivers.

Ethernet cables with faulty or missing pairs (specifically C and D)
can successfully auto-negotiate 1000BASE-T but fail to establish a
stable link. The LAN88xx PHY supports automatic downshift to
100BASE-TX after a configurable number of failed attempts (2-5).

Patch 1 adds the get/set tunable implementation.
Patch 2 enables downshift by default with a count of 2. The setting is
stored in the driver's private data so that user changes via ethtool are
preserved across suspend/resume cycles.

Based on an earlier downstream implementation by Phil Elwell.

Tested on Raspberry Pi 3B+ (LAN7515/LAN88xx).

Changes since v2:
  - Store downshift count in priv struct and restore in config_init to
    preserve user settings across suspend/resume (Russell King)

Changes since v1:
  - Replace switch statements with FIELD_GET()/FIELD_PREP() (Andrew Lunn)
  - Drop unused per-count register defines from microchipphy.h

Nicolai Buchwitz (2):
  net: phy: microchip: add downshift tunable support for LAN88xx
  net: phy: microchip: enable downshift by default on LAN88xx

 drivers/net/phy/microchip.c  | 79 +++++++++++++++++++++++++++++++++++-
 include/linux/microchipphy.h |  5 +++
 2 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.51.0

