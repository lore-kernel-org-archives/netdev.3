Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA8480328
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569743; cv=none; b=JceXdgOjIYd4Z2fM32szwzZrudAsDSfq5GdVYP85M5wKx65KmWQFAGwA49IU8DOm5KgI5dlCpk8x5vqMV6d8H6CwYmWiW2cU7ra0G9cv2h3vrkEdXWNP73bDnQPHj/i2XQlUAGb5ip6o81O5s1T359qpezeT7wBw1NLezxVgTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569743; c=relaxed/simple;
	bh=q8syqySWiH+8Yv5J2OJgmyU2V5Gvl+xUuxrGiiadBMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHgeH+ZpC6LqQWp7OBmux2hDUUcvU5hMs0laqMiYH1BorruHt1xnuzODL2C2D1/KnuRWoTnmxDWQJJp3z/J54JXrVDzjt0oKH+0rgDEqchYGhbcO9ELaOMXVtrbf1tacDQVMuWC4QwuMZsl1auQ3ct9ixvQwF04/VgsWTNnUEHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UkUb0VSI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UkUb0VSI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E9EEF4E40E84;
	Mon, 20 Jul 2026 17:48:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BCDD060360;
	Mon, 20 Jul 2026 17:48:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1330211BD1DCE;
	Mon, 20 Jul 2026 19:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784569729; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=djF07LBbe1E5mTvU7TPS/wHgSJ+GUxxW8gl5fasZef4=;
	b=UkUb0VSIt6gFkUU4NytmWRxNmHD0WaPlFS9fScycoobMPpJY4uLDpzmK4d+IPYtQGErqPt
	yl2mKRUL064qtZdtAqt2VALktLINQ9y7tJDo0mTNgrUbBiGETsprhv2LPUO0G4ri4VXlQ1
	CERQncNIr2X2NmhZns23NghM+yk4dRBKE5udwiZMs1qlBanit9GGQlxkywD4OdiRROEmNp
	ozg/OhDn+oip5Jstpb+lX6091YK6TJ1pPvNoWhO8b6YSo9WbgwB93fOnUfDqFWgVfQdEER
	3+H6al1ZuNnrsH2694rez18VxLw7Y0QRQfCT5xtZko6/paRvgB/Mluv3YIZBMQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>
Subject: [PATCH net-next v14 10/10] Documentation: networking: Update the phy_port infrastructure description
Date: Mon, 20 Jul 2026 19:48:07 +0200
Message-ID: <20260720174808.139573-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720174808.139573-1-maxime.chevallier@bootlin.com>
References: <20260720174808.139573-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

With SFP now properly supported with phy_port, add some details in the
documentation. Fix a typo along the way (driver -> driven).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 Documentation/networking/phy-port.rst | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/phy-port.rst b/Documentation/networking/phy-port.rst
index 6e28d9094bce..2a9b1ec93b70 100644
--- a/Documentation/networking/phy-port.rst
+++ b/Documentation/networking/phy-port.rst
@@ -99,13 +99,29 @@ will eventually be able to report its own ksettings::
             (_____)-----| Port |
                         +------+
 
+SFP ports
+=========
+
+SFP interfaces involve 2 distinct components, each represented by
+a :c:type:`struct phy_port <phy_port>` instance :
+
+ - The SFP cage itself is a :c:type:`struct phy_port <phy_port>`. It's special
+   in that it's not an MDI interface, but rather a hot-pluggable MII.
+   The :c:type:`struct phy_port <phy_port>` associated to it lists the different
+   MII interfaces we can use on the cage.
+
+ - The SFP module, when inserted, will also be associated to a
+   :c:type:`struct phy_port <phy_port>`, that represents the various linkmodes
+   that it gives access to. The module's :c:type:`struct phy_port <phy_port>`
+   doesn't supersede the cage's port, it references it through
+   the :c:type:`struct phy_port <phy_port>` :c:member:`upstream_port` field.
+
 Next steps
 ==========
 
-As of writing this documentation, only ports controlled by PHY devices are
-supported. The next steps will be to add the Netlink API to expose these
-to userspace and add support for raw ports (controlled by some firmware, and directly
-managed by the NIC driver).
+As of writing this documentation, the port's presence and information can only
+be queried, and it's not possible to change any of the port's settings or select
+which one should be used.
 
 Another parallel task is the introduction of a MII muxing framework to allow the
-control of non-PHY driver multi-port setups.
+control of non-PHY driven multi-port setups.
-- 
2.55.0

