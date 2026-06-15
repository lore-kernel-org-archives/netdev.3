Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471940863D
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537992; cv=none; b=B6SFD72IYyl+7etwNM1htQxXBk99rIBgcMDxvcwlwl5yCJ/b9poVPnD4lAprTj/WxxLquUZJCqAR62BOBeoxsJHwJ59n0GjhT06fimhicLcs3Y7O0vhzRa5mNOGRwAekutC8I+uiXFYU/+lRJQzUym5r8CtYB43uariDI+tSwDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537992; c=relaxed/simple;
	bh=JOtbpi4SADCvpSm0vUIE0JvMOiz8jnz8Ujtk1N4yVxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=for8qYj1kHBpaAh+8YOEAPYJdlJcZQgkl97kEaCMjzh1FZcP6bScwi9V7lq+0wEP3ZeSeqdmCydu8g4txIQE4h1YyBsoXuYY7BmaydYfrlPgXG/jQFHkJQyXtNvgTiL+Zi43LUhmsPG9lGjLD503p5isbtN+1Am4bWuk/GeImNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uB0bp6M3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uB0bp6M3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 56C281A3938;
	Mon, 15 Jun 2026 15:39:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A55060015;
	Mon, 15 Jun 2026 15:39:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6DBF0106C971E;
	Mon, 15 Jun 2026 17:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781537988; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aKGCdkLhQi+Dlzkgpitf7PCsr2EJXcuWkaJEATQz8n4=;
	b=uB0bp6M3FJSrYF21lNfKKnob2OIIdFgrhvaXenyO3+sN63XOWwcTXpGuQ7ATDrZOvX5f1X
	36SEWu/3Q71blMoAnJJ6/Ng0dY1LWK4qqyGrexar+8I50rCpTeaYPbN4jWm+PP5UZmISU0
	Gne8Uo0YYYt0iwCIG9F6Dvts5KtW+IFBhUQSWUNgQN5f/cV6lXv30CJy5PVFj4u26+/Klg
	2Z/DK9wjc5Tc1fbSQ+KudW1lQTPiy0gobP/o6qZKSOvgPrLkTcloSyvQQCEhDkpSosIXK5
	xDDXeESr8Rxxj9x1IkGoi/XzH6MwyLesCf/nptNA/E06Z6L35WBarhn73JUh0A==
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
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: [PATCH net-next v12 10/10] Documentation: networking: Update the phy_port infrastructure description
Date: Mon, 15 Jun 2026 17:39:06 +0200
Message-ID: <20260615153907.862987-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
References: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
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
index 6e28d9094bce..73ea06db0fd9 100644
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
+   doesn't supersedes the cage's port, it references it through
+   the :c:type:`struct phy_port <phy_port>`. :c:member:`upstream_port` field.
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
2.54.0

