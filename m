Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270958;
	b=Sln5mOwvjyCxln0rI755Y7yUsZUsf6jCXhWUkeYWOhMdaxb+6oENiJnG1Uc1ZawTYh/K
	 zQKqoomPZqXQPC/uWxLZzh+DLpIY5sRaWf841A74NnzQybCoXmOotgVOuwPd1WwFOYZjz
	 msKevvzBT5tmAxc9Ir/dvAjDCeqmRrjAHICulFi0xg+YTotVwkxYYVpwkgMyNqCBv9Jdr
	 dF9iAYYTjZMk7Ut0Jvc9gzTYV7PNUUsDnYll6RW/fm5P8pvxLCBdCmdEZrYe7w33OqUnM
	 URyoRIdvVDaVpO+JaDiMr0TgHxuWXG+MHseK+h2M9J7Rv43d4aqo0EYKOu0Nk0waanw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Zv964du6fZsHkcN7ICiRxz6KH8GpYgyZJRuVSNtH34s=;
	b=n7NJuQct3FKGMh1BhAlE20XSUZ1pGtIoU0rO+/t4h4YaimUsOlILoI9vuFTWnwzaYn1I
	 QS+Sve5tJJsAFWVKfRjJYoR82+ZVAoU2DuVQgdR3v1C4snHUvI//rJsKH4gltLvcGeoKU
	 ophAwt/OLLs4uu8GcniF0Iu61tXDpRrSxqKCk1dTGjZTf++8+rTN8YnLM65DhIV+vyikW
	 Z8et1RwYlgm7W8G7LwEt8PD9EtB8Wp/QgXRmZz7cNYbTq6dq4R0zumwl5qAFgrhkdFOl2
	 CPe8iFSYljYjw4Ib6wMvXYJr/TXLxjgb9NsLBYCfHQCGU22Uqb6qfNI6pAn6cfpdjYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=KggNcmsQ;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D7606A31A;
	Thu, 29 Oct 2026 10:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B68D7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=KggNcmsQ
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id D0424E83336;
	Thu, 29 Oct 2026 11:49:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793270948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zv964du6fZsHkcN7ICiRxz6KH8GpYgyZJRuVSNtH34s=;
	b=KggNcmsQw1LQLZx4zWHxxL1L1t4omXtLGeKCaNVpRA0jyJ73NJwxLu+Qg/PDmQ15vAW4go
	CFgAIntUHYiwei5cgqKSeVL4b8OMZAI5cSPIMP+3Xv9O4DfSgTo/CTY6E7bhDtp6rITrWj
	1NNNdRp56wwSuNwsl6wz6qw7WkTsoxix2s/PGsD7EAJ1LzvQa7yja8aeGnMf/SKnEwj3Iy
	Sj1AeYelo3NXig2f9i0ULUFUiAW8K8UDLfQnSQ2S6MFkqEp6BcdwkCKNrfSOxe7DUaStbp
	TU+2Xx0zB9cMhOn9p/tPoXE1+8DuAkxAfd+3oQ5ix4qDe1hWWPY2BeA78EptPQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id hECxmLQLJyMP; Thu, 29 Oct 2026 11:49:08 +0100 (CET)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 29 Oct 2026 11:49:08 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 07/14] net: pse-pd: do not tie a shared power domain to its creator's devres
Date: Thu, 29 Oct 2026 11:48:51 +0100
Message-ID: <20261029104851.464294-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023215416.1087206-1-github@szelinsky.de>
References: <20261023215416.1087206-1-github@szelinsky.de>
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

On Fri, 23 Oct 2026 23:54:15 +0200, Carlo Szelinsky wrote:
> One downside: Mark and Liam would then have to review the rdev->supply
> change inside a bigger patch. If you prefer, I can keep 12 separate
> for them and only merge 7 and the power domain part of 11.
>
> Is that what you meant?

Hi Oleksij,

a short ping on this. The answer decides how I build v3, and I would
like to send it soon.

If I hear nothing by Monday, November 2, I will keep 12 separate and
merge only 7 and the power domain part of 11.

Mark, Liam: if you find a moment, Oleksij's question on 12/14 about the
PSE core using rdev->supply is still open:
https://lore.kernel.org/netdev/atnK9lEinSLgx5yK@pengutronix.de/

Thanks,
Carlo
