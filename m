Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534614DD3CE
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157564; cv=none; b=Y94WuOB1adSXuU/RVwBi6/2+7wV7zVaSk59VK8QPTgmtg+mmfl4mWeOBD0KzhYIj9gY5qz4Fd/h0/hE8hrZ4Tu9cx4vT62XUVoTgjJWOdvDSxyeQvHOn32k/hIePfDWNwbnQvMDJZNjguM2E1Tn33mfIiWYLdQnWMplB1IZ+vbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157564; c=relaxed/simple;
	bh=GNyeH/D9UU4ZxGlYZD3OAvLEgpyEDAMsyOBqyoPf5EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vE3P6gQxVOHIGs+9GeYDAp9x1C5xebXmz5PFRi3/ja37KRaN/cF8Rj+8VceoIgPtKM+4Y+VEzY1zWBLO2kkhrYS6wazN1uHE9qSRkszC8QujEptYwg/BEi0fNy0DfcG0HCBmtyCtMYBqsboIm3WDx79nTY+fNHcGoU0efgSiaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mx2Uoe4b; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mx2Uoe4b"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 540E0C62214;
	Fri, 16 Oct 2026 13:33:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 805116075D;
	Fri, 16 Oct 2026 13:32:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 45226103284D3;
	Fri, 16 Oct 2026 15:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792157559; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=cVQ/yz+hr0m1zgxRRhngs2LjC3ut/PdlaKhQBKO2pc0=;
	b=Mx2Uoe4bJdVKZsFZ24I1hgqEeUBxqVOq8Z7lFhCymVeuBTI04qodGHTvcALS/9nscptAHi
	LTt9d9z7UJrfpl02YVXHBLd2LsXl9fGBTzL21WUsUTwvsfWZghwpamNp02Ln+i+MXeaM5B
	5ALUguLwl5nQXBaMiroadd7JbJ0xWB7D4xp9WPZRPm174Akta9p/bJsAtCDQLLKhuyQr+9
	pAdx2CoFH2vrgOjLI7Af50UR69wb2G1yazY01TPHg0zYIPiVKv3QZNtZ1aVGnkCnP0eRwb
	Dvd0cqoIoVVlSyjbrP4IxHfTiJzxk6bPpSc1EMkF+WgUG8jGH9UiZ0fkzWGE2g==
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
	Pietro Ameruoso <p.ameruoso@live.it>,
	Aleksei Sviridkin <f@lex.la>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH net-next v19 10/10] Documentation: networking: Update the phy_port infrastructure description
Date: Fri, 16 Oct 2026 15:31:05 +0200
Message-ID: <20261016133107.54054-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016133107.54054-1-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-1-maxime.chevallier@bootlin.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
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
2.56.0

