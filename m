Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1F2393DC0
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290900; cv=none; b=VHvEFo28CmarSUq63KlNVbiRU4UqKQ6ZqIsTyczovyGAyJRBC2hgoKtrpLt30byIBhTA3U+y636GgQpc5QHAPRtBgdy76oJ15ej/soyebsWLUI82kzmpNH4XW159yBnt0I/MC/1eYpg1Uw6AGzhwhNHbcsUonuww4d3aWdHdVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290900; c=relaxed/simple;
	bh=aIRCW6KbHxdbp5jOkhzcjZuC0MZaBeh1lcArKDpufL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIpS7TTyiaovxIETZgm4P2qkGKQrRltitbC7/gHPLR5SOtp1KgDaI7zKzFRTNTUXNVuWHyUxaMpCJV2YcEQmuw7aGzx9CvwCO+UoatO8VNZVD6zJTC3Svxb3lVjpLOa0K1nGhhJ/QpjN5xYqeq8JG5OZuccq/iBJwIOa8m4RVTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHK7pGcM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHK7pGcM"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49241a577d8so4608885e9.3
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290897; x=1782895697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k1FzrumTX3WZt5WL8bKsZ9SyEzh7Lzm7lk8O+J8ro9A=;
        b=CHK7pGcMwB10vbjwbQawkrUVdXyxmbtX8ngc7pE4u6IN6n/Q4QtUUAaJYTvFKBf51k
         hIOTeu3uw4HeJXHbR4HVHFW0z/+m/+i5JMt5ETm1JHbvRot9ICPujXlSqJYIzQlp5VYx
         rYGCaEy9aussWvlMI58uButr/MjoJaw3qBT3Gqwx5QFFZVKqHqz7nyDGBzs5Y0g9mYpt
         KYCf9UexmaeAdZ9sCqclsKEN8pDW2eh4TP5FozNcqxbvj95/d834m92k70xGTzN6849L
         1etWBasA79vFXMIu3rkeDc82RC0KXiebd4Cw333JTEKsoS9ip+SbAQm4JnTDXh22LsYw
         RdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290897; x=1782895697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1FzrumTX3WZt5WL8bKsZ9SyEzh7Lzm7lk8O+J8ro9A=;
        b=jXwDD1dZj13X49qXYtuaHeGZoFe6/Py13w4DlwNbyPFuJ6OzzdT5a5nd2Tz8l3UCEE
         AajslfedoSAvWuu+8aeiBk9vJ0Ibhqio9RQ5aY+W7AQyk3IEA6GBkx+GDLzUUMJYYL/I
         Me0UVwXP5qSnkEPeISmvLMELqtLwTwCfq4NvL0oYWy4Kt7FyF59gJ8Q5uxc4I+RzE+AH
         qhSwKeLu9MAFcjmoLLjS5jBWg/Ygweylv9mB/NHhFZl2RE6g98YQqAPYHyhtotuFlQLm
         zyRhdf8dg9Q7J0WAEMgi3fNRmsmP259LIrr/cIqZcCNqMow7zuZTUilt2+VVsSrHr9ZD
         9pHA==
X-Forwarded-Encrypted: i=1; AFNElJ+3IsP0v4yn8mCD5mggI7W0rx3/E3GUkh1At16AzS8Ap6wpmvZT/n6nGJfEB2LKoQhPia0lFwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcB0dKQn4WtbZJgXQwExILcQZMMS36s2Xa2bmENGGP81CmTpVn
	4Ka1y5aiKNyhFaZf4wK08dI5wOLk6RRQMRtBuRkxCqPDfhWc3CwqjLjo
X-Gm-Gg: AfdE7ckBfNuEs/aq9yyi/slzsqh9CQ7vI9gWaGEE1pbPhVX9iS3ZXM5fK+SEluI7f94
	w8Uxg7Wn1MOA4uLwUrfxsVu/apIZAj1Wcj7aFLVgCK+Irm2W/KAqxfSgrEyDu6gDhOIRLNkoeJA
	RWd0KqZlYLwr1XSVUAoJcsaGZWW7M4iiJmDGcqEdYocq5qpGZvyeHmnkdHHIAzWIVMXyc7lTSbe
	gIgbFaft2ysolalyOedaYqfeRtSVin6BdazmhpueuxayuIp/G+769Ypc54BPcYw4ygvdPgHyKpC
	fQfzcMnKeXoOpnJFlgkLuNHOx5Ur2e2N4DYdYK5Rx7285JC/9SUHTtYSFUkuHi6er9X537n07xE
	AYeosINAinpq2Hyu8Gg+fn0TDGqUvveIlI3AmIJlqrGjZ0IXS9TWjzvHDluplQOVsXDCiTzUoru
	qmzpZ8jP6BNINVwYSccZYhgE3GQnigjE9oLJUgDnXyv3LlpSgHaL4whcvpaiXSUuaCjtCYGetZc
	OICGrQ=
X-Received: by 2002:a05:600c:548e:b0:490:bd66:db49 with SMTP id 5b1f17b1804b1-4926084b8admr29211765e9.12.1782290896994;
        Wed, 24 Jun 2026 01:48:16 -0700 (PDT)
Received: from localhost.localdomain (ip-89-176-136-191.bb.vodafone.cz. [89.176.136.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9371sm5065849f8f.21.2026.06.24.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:48:16 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Bjorn Mork <bjorn@mork.no>,
	Aleksander Bajkowski <olek2@wp.pl>,
	Marek Behun <kabel@kernel.org>,
	Petr Wozniak <petr.wozniak@gmail.com>
Subject: [PATCH net v4 0/2] net: phy: sfp/mdio-i2c: defer RollBall probe + fix mii_bus leak
Date: Wed, 24 Jun 2026 10:48:12 +0200
Message-ID: <20260624084814.20972-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series resends the RollBall bridge probe deferral (a fix for the
regression in commit 8fe125892f40) and adds a related mii_bus leak fix.

Patch 1 fixes a pre-existing mii_bus leak in sfp_i2c_mdiobus_destroy()
that has been present since the helper was introduced in 2022. Patch 2
introduces a new -ENODEV path that destroys the MDIO bus via
sfp_i2c_mdiobus_destroy(), so patch 1 is a prerequisite to avoid leaking
the bus on that path.

v4:
 - Retargeted net-next -> net: both patches carry Fixes: tags and
   8fe125892f40 is now in mainline.
 - Patch 1: added Reviewed-by: Maxime Chevallier.
 - Patch 2: reworked post-probe error handling to drop an over-80-column
   line and moved two block comment terminators to their own line
   (checkpatch); set err = 0 after switching to MDIO_I2C_NONE so the SFP
   state machine does not schedule a redundant 1 s retry. No functional
   change to the probe logic.
v3:
 - Resend: v2 defer patch was corrupted in transit and failed to apply
   (netdev/apply); regenerated against current net-next.
 - Fixed block comment style flagged by checkpatch. No functional change.
 - Added patch 1/2 (sfp: free mii_bus in sfp_i2c_mdiobus_destroy).
v2 (defer):
 - Generalized scope: regression affects boot-inserted and hotplugged
   modules where bridge init exceeds 200 ms; Aleksander Bajkowski
   confirmed FLYPRO SFP-10GT-CS-30M / AQR113C broken when hotplugged.
 - Corrected state machine description (probe runs in SFP_S_INIT after
   SFP_S_WAIT) - Jan Hoffmann.
 - No code changes from v1.
v1: initial submission.

Petr Wozniak (2):
  net: phy: sfp: free mii_bus in sfp_i2c_mdiobus_destroy
  net: phy: mdio-i2c: defer RollBall bridge probe to PHY discovery

 drivers/net/mdio/mdio-i2c.c   | 15 +++++++++------
 drivers/net/phy/sfp.c         | 23 +++++++++++++++--------
 include/linux/mdio/mdio-i2c.h |  1 +
 3 files changed, 25 insertions(+), 14 deletions(-)

-- 
2.51.0

