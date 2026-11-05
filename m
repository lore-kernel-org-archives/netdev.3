Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901714;
	b=pU0Wc31SaIR6kWdj7yeODGok2U0U0rGly8asADjiCOVf8CjMA6sv7ru4Ydi2/z64CvbI
	 MGxheo1IFlpJ19KBg9dHnB92EzodWyQqVxOdqHfba02WeefN6glBfldiLhLj/HHy8AQ4V
	 3T5P2hOQisFXYxwyEgzTj271J/R9R+tuqTGXPD0jOIGVaEkvvdmbUy52V47e4rdbwcfRB
	 C7c9HQ4fqfZ/pR2ZEXCWlCxrYeIS2aUH0Tpg2AmIV4PJMP8YDBWshsvfrqlhFPcdIorUS
	 7nF93BSyVCKnX1CnXZUI9Z8nT4MxejJ8zlTIhwpLCp21aVuC1C+Lvv31iSazv/XaWLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=YvamD+EM1e89sn3KxZAT+ivhfY5a2c+/mKRK80xEFcI=;
	b=CCePpFjLOaHljdZpkEpeRJHKl0IR6F9isIth1b4IHVeYXAvbb2FDs4bwKMG/+89q0KBi
	 aHmrw1T5yczMXv1BRJRBrE5Tgjsi7pIOTJMMaTmUn7Y2pCvu7NfIqtqpyjGxiAHn9bHSc
	 9dA0XTkLcHiFnaFm+WCCvCsOUl5qsW5lIlDAlBd1/4bEV4+QC6usa2p24h3hJPeHIZxIG
	 XABVeWeQq5Sw3TOVRyRJy57JbyLkjFu2Ts1PTgXafauCT+vb2aCwtFHSvwXzldQigX/lU
	 e3b8D6YnEnNpfysi/Vf6G2IxDBXYyxTIEC71BjB5JDyoUPvYwAhF+SfyTNKm7TtW1rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=aSRS96eR;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79715606A32D;
	Thu,  5 Nov 2026 18:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79715606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=aSRS96eR
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 748A8E8365B;
	Thu, 05 Nov 2026 19:01:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793901705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvamD+EM1e89sn3KxZAT+ivhfY5a2c+/mKRK80xEFcI=;
	b=aSRS96eROvJZRKDma9+b5GG0n0dZ5/cuegnvKm/Y6MFKdbaRcYIsLAMmkGr6PYD5LbIIcB
	LBThb8Ri+y1i6/YtnFOiB0DQlX9WeT+E/T4cICngJqtGwT9+X7fIWpDFBGb4nEbTqlQI2T
	WAbWpALOE+UnuroWw70JZD/rkODqFSc28fdPwq1M7Qo6A9NDbIWeg35ZM7zKQRY95fIXHA
	P27JhBw8GxjNI831k4uufzl88e5nlOb5elhd1UC4vRZye7Rd87/XIiMFdjRFZE0tDxXbqF
	BN8oOZtbiL9BQ+KtWSQCoqVSXFiEZX5HNS9HYIjR0wpp6BoGe3bp/0hZsT+AOQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id HCubZ9UPR9iM; Thu,  5 Nov 2026 19:01:45 +0100 (CET)
Received: from p14sgen5.netbird.selfhosted (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 05 Nov 2026 19:01:45 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: netdev-bot+sashiko@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 05/14] net: pse-pd: do not reach a freed PHY from the notification worker
Date: Thu,  5 Nov 2026 19:01:37 +0100
Message-ID: <20261105180137.233390-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179387331238.488856.9819726671704590547@kernel.org>
References: <179387331238.488856.9819726671704590547@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 05 Nov 2026 10:08:32 +0000, netdev-bot+sashiko@kernel.org wrote:
> Could the struct doc and the pse_control_get_netdev() doc mention the
> locking requirement and the shared-PI NULL case?

Yes. In v4 the rule moves into the kernel-doc, and the comment in the
worker gets shorter, as Kory asked.

> This is a pre-existing issue, but is the net_device itself still left
> unprotected here?

Yes, the worker holds no reference on the net_device. This was the
same before the patch, which only fixes the phy_device part. I keep it
for a separate fix.

Carlo
