Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52C23C343A;
	Sat, 17 Oct 2026 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277239; cv=none; b=kJkfJ8l7W0jJQuWAyiPm0XJeNTmC/L1hp30FPoHy+9fsJIW4Yo8cxqYWu/INjPgKIvcEarBVyNp5S9+73castJ5+ryqrEhRCnfZVOTftBapt7MNKWhITtuzN8kB4jSqD/wulJxe9jqVUYhZ7Xicxi20/qikWr6cXTIg024+Q5s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277239; c=relaxed/simple;
	bh=7CGCxEvn5AlOtEB8WSbN+orb8HuM5iT2kqQ2iHysivw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Afrn6C7GCKi6Ixnvqf9kJubJDgOnN8SUgrXMoIAVQQQWs0aNhZ+GumTk0h7MJxMEhqSuvSB1mRWZ9AXbIbhA7lkXDLuDn7iZJsXxWIjkZoiaJaf5mXEre1NeLozCkipeO3Mc6xnWzV0YNrbyYfG5yWjy2GxqJAJuIGys5XG76/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=RXIV9JdX; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="RXIV9JdX"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 8F69EE83404;
	Sun, 18 Oct 2026 00:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792277234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7CGCxEvn5AlOtEB8WSbN+orb8HuM5iT2kqQ2iHysivw=;
	b=RXIV9JdXxHwntGNf1F8J4FUdUefJK4gez4supqjIygp72+cyud6GAqGn4uKtNAyFAlOGNs
	UPy+q+LsMbCYvukC8QQ6vYTb/cMTTfEiLPqleE6lDXnyGpotHXXQ+R+Bd0UMnMN66foP0E
	DJG6rUHR0xC6uSubffGleez7ZMHffCRXbY1jyLL4iub40ASKLT19eXm8zBfW9kA5mpKl61
	PFU63SKzLPLCj0+kSvzfasVO6z8BxexcKuOzOpoazYiKb7gbBHjEklckehfth9P1wVGukG
	TcOmv3vLblLDcBchtVj/bsD6vEAjS2J+eYRCxaEfCkX1Ck2d7v0uYMg4gwmpJQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id LCgX9xUW-xth; Sun, 18 Oct 2026 00:47:14 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 00:47:13 +0200 (CEST)
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
Subject: Re: [PATCH net-next v8 3/7] net: pse-pd: unwind allocations when controller registration fails
Date: Sun, 18 Oct 2026 00:47:04 +0200
Message-ID: <20261017224704.1527400-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005164306.0BDF21F000FF@smtp.kernel.org>
References: <20261005164306.0BDF21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Oct 2026 16:43:05 +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does setting pcdev->pi[i].pw_d to NULL here without holding pcdev->lock
> introduce a race condition with concurrent sysfs accesses?

Yes, agreed. In v9 pi[].pw_d is cleared under pcdev->lock, so a
regulator op that holds the lock sees either the old domain or NULL,
never a change in between.

Carlo
