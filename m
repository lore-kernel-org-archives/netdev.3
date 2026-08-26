Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2983B4E9E;
	Wed, 26 Aug 2026 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775693; cv=none; b=HB5M+iaCDhNC2EOkxLw+jCN4NkLC1PHoUMyqk/UgqhyoQod+QtrnOXdJ2SFOYov2WCi3cEWg0H1xV9marZ9/zEwwfhGeuDz5faec7JCzITWBOYkaSLWogf+bMUT4kbHPnUq3t9hlmgkDvJ7kcdcVK7rWmlsmF2s7+qqK4Kdjz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775693; c=relaxed/simple;
	bh=hZjeU9H8oI+OTM9gVzydGZxxFXpS8vEp6HnihhWPFBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=avPiSKOHYgF3fid4jZ03EKZ/7GTPBnvhzhV2V/VipTAnlY+lJGnXBOrkL40VTZMf267Q5J1V/YP4sth9ABfsU+AcM66RObfBNBrSj6VMg67wmKFpn6IKWxnBI/MLfW8278r3n3VRji03RcVUZZ2mLYOVhK6K65LR+Am+FQlN7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=LjtkvY82; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="LjtkvY82"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A2CF1E1D7F;
	Wed, 26 Aug 2026 22:21:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787775683; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=toXwB0eW1pt+JnqYWTN4MSM2M7LRyf7NLGCct1UemPk=;
	b=LjtkvY82U8kiio0xI6s+Qh1TRTyuAicf+3kCqQLtu4UOgmYBU+mYtZ+26Nvd1ADfin6kIP
	HCHzLmZvCL/8Si3jxhjA/KktIByG/pAqCd/3CP8v/ZE+DiGSJJ8Csem6Zvkn74AvpTURyl
	aVNoe//W/BFGJpDo7y0EQHHO0v4HZ103qCWKen6F/Hn2z6SLar5fm3dxZkJiWbPWPFHM4z
	FL7amKUB31BWKItZM7vHqp+/W9ey41Sfnpkq7Du+8pUVvDvPX4eBqmFuzQsVVJrgOvl3YS
	+8tqYNyosFZiSoGl9oPVHeb51va9A/EC8q1VToPTIqwzzlhLJT4VzCpCvsJuZg==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org,
	ansuelsmth@gmail.com
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	SkyLake.Huang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	cjd@cjdns.fr,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 net-next 0/3] net: phy: mediatek: support EcoNet EN751221 gbit SoC PHY
Date: Wed, 26 Aug 2026 20:21:00 +0000
Message-Id: <20260826202103.2280645-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

NOTE: This patchset bases on https://lore.kernel.org/netdev/20260708102341.53919-1-ansuelsmth@gmail.com/

Add support for the EcoNet EN751221 SoC gigabit PHY, as identified by
product IDs 9451, and 9471.

Changes since v1:
* Make calibration tables const
* Stop disabling EEE as it does not show problems in testing
* Stop setting MII_BMCR before calibration as testing shows it unnecessary
* Add comment: master/slave resolution is unreliable and is therefore disabled.
* Fix typo in phy_restore_page()
* v1: https://lore.kernel.org/netdev/20260825193456.1823985-1-cjd@cjdns.fr/

Caleb James DeLisle (3):
  net: phy: mediatek: move mtk_cal_cycle_wait to mtk-phy-lib
  net: phy: mediatek: bug fixes to airoha-ge-soc.c
  net: phy: mediatek: support EcoNet EN751221 gbit SoC PHY

 drivers/net/phy/mediatek/Kconfig         |   9 +-
 drivers/net/phy/mediatek/airoha-ge-soc.c | 231 ++++++++++++++++++++++-
 drivers/net/phy/mediatek/mtk-ge-soc.c    |  27 ---
 drivers/net/phy/mediatek/mtk-ge-soc.h    |   5 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c   |  29 +++
 drivers/net/phy/mediatek/mtk.h           |   2 +
 6 files changed, 258 insertions(+), 45 deletions(-)

-- 
2.39.5

