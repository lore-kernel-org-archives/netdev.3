Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4664A3F26;
	Sat, 17 Oct 2026 22:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277250; cv=none; b=scGi39aPQtaTOVKavWBUjDXOGmN3AUyOPrjhTUa5wU+pLuxmkdgfIQPso6Y+3A1VIy9TOA2mDmMtlw999EMnHlhWvnDdqjcHih0wVJuVE/5uNstejsTb6xkIQLQ1WvNRWqXbStoA+U//ujPbc5LlYJRlvng/fROZdNhBEkZzSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277250; c=relaxed/simple;
	bh=jD4vlbbmmWvkhvLchPAO7I/M4krCE5RGGC2DMcApkGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFNCJXje8JTWbNXTjmGQ/w381knR6ZEExX+c2b6Soikk7O9rBb2NIw9x+/fpBwzQz3LpqiAa69EsLLS3BWQTDwqn6hTk6EkjAfsOHidgJhzjiCJE9NfDKakzostX7hK2++ZoAAQxllJ4/A+m8ZSht+szJQQgthgw8EMAm0xODSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=SgcDvhTm; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="SgcDvhTm"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 16824E83404;
	Sun, 18 Oct 2026 00:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792277246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScwdTuhzZINXtODHQG4RTmOjqFwDmM/HQjD/jlKcXxQ=;
	b=SgcDvhTm74TphCCjCV84TrMTZthyqVsRCGjGYxC4HNAev6HoDGec7zWcEah9aOptaIw7zz
	OL8b3BMfbmPOeDTdt3uqi5YCc2VW56CSEsbTWvdT9NNvJwOwDX3C/vTlDRqan2c2v+Y3sL
	HBb9HUlh3HR/RIozkj2Ov+OlkcsypvY0NYzZL+Ovg0Oi+2tyrEzSM8vYuC3T1Ca2hvZvVP
	C/Pu9YMxATQABJAhXuatZIebjUioCrckt+jmnnAP6DbxF8pV2GNNl5vxDRP6r8PDRW20ia
	ZvR+nhHu3rjhKC2mZknVVbfPSfTOfVyG3ytPycho62QFvlHzFk5iLMXR/2cvPg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id BH7wBReCclG0; Sun, 18 Oct 2026 00:47:26 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 00:47:25 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	devicetree@vger.kernel.org,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 0/7] net: pse-pd: decouple controller lookup from MDIO probe
Date: Sun, 18 Oct 2026 00:47:23 +0200
Message-ID: <20261017224723.1527477-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004164219.1161294-1-github@szelinsky.de>
References: <20261004164219.1161294-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks to Paolo, Kory and Oleksij for the reviews, and to Kyle for the
kind words.

I have now my own sashiko instance. Different models have different findings,
but I got some progress ... 

I answered the AI reviews in reply to each of them. v9 follows, split in
two series as Oleksij asked: the PSE core fixes, and the decouple series
on top. The older bugs the reviews found go to net as a separate series.

Carlo
