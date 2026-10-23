Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792491;
	b=fyFiSpAlz7Osjqj6AXAEPzsiZXVfCt3ouAs6HgOIXuRTmZezAZPQdrYYUkYhDxQCihNE
	 yeQlRnXZ5muiDaJkLBCCHCsUPGSk33JeNwDcgbnfnS1GVUHRykoG3OM/V8gt5Zro1xKne
	 e0lv7cT4UapgXh9E5L2hVpe818pD7uARVOyri5W7R1KB6PIXYOurrleZHeUCQweR2YqZB
	 hXJqjNkPrd2I0rDghhVwhzjBwK58kZG6FSYX/xg3MYvwTkTjOpvYCTEkCGpu+tQw9vzp1
	 7uIyce1YH7uiX5an3Ikwf9ZCdaumgudhpWzwDlUHL4+Nl5YKhp2H+fOCr0vtOiLLkMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=f49VQTmPcbTpQbiCT/gCl4FT2Eea+TPPlJl6da1zU30=;
	b=0yynDMXWFx9Fj7EAQStVN1tQfCKZmmUQY6++K8sksowRHf1zIuSL3O3hNFzfFdPeCOy1
	 Bqdz/Qggk0hypV1SbayC3xfQNsnBNyrS0TdxyvQHNMcIRzJxYOyfdXAo4fC9b5fuxJPcr
	 nPgLnLwaXVCKa+2mkcAbhySpcQwBjLN8h2kXXImIFLcqUwXy/L1HpQm5POAAuYqP5Pe0Z
	 o+Atyk29AFYUzc+IFsOfpGGRvGn8f23mzGypE4sze+F/aWd1vOdvsTPh7unW1JTdQ805D
	 uYTV8XC3LtitBqqbhH4MOpbyMUgzxhyrBhCN3aXi8XUtbHFTHsWqxfy/vtyx1iewevw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Bu7MqO6n;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D24606A31A;
	Fri, 23 Oct 2026 21:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D24606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=Bu7MqO6n
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 21708E83892;
	Fri, 23 Oct 2026 23:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792792481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f49VQTmPcbTpQbiCT/gCl4FT2Eea+TPPlJl6da1zU30=;
	b=Bu7MqO6nC1E3tKPO3jtFzypf4FUN4eUDYJjRQLaBaFWNU4JknbK1cSCs8LKfMqo9HWAL9T
	3k2cLPgjzNakYnbQ64eobwVpqrEC6BseDP/93LJ7aT8w/hWEQ2FyMN5L8JDGj8ugwE5/ah
	VCGVDyI/pW7tjJrkqzmy4gQVk+2CbvSBp/ZQmwIaXLv1Yf7xxDxmPIdsrLNui5oEkhBpR1
	QghAnCpsx+4fwYzkuT42u7uCOnPiYr3uKodFGRxH42o/ZI4nyQn95ye7XhujmCBDAaXDks
	dhp+LHuEugY9exhLqou6RWlmoF4P/mhzvfNl/fZ+k8VU7j4VIMTo//PP3Jz1LA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id et1qZnqfkZG0; Fri, 23 Oct 2026 23:54:41 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Fri, 23 Oct 2026 23:54:40 +0200 (CEST)
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
Date: Fri, 23 Oct 2026 23:54:15 +0200
Message-ID: <20261023215416.1087206-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <atmbjbxVUCXRq-3m@pengutronix.de>
References: <atmbjbxVUCXRq-3m@pengutronix.de>
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

On Thu, 22 Oct 2026 07:13:49 +0200, Oleksij Rempel wrote:
> The power domain lifetime changes in 7 and 10-12 build on each other;
> if there is another round, folding them into fewer patches would make
> them easier to review.

Thanks for the review. For v3 I would merge 7, the power domain part of
11 and 12 into one patch. Then no commit in between still has the
supply handle problem or the leak on a failed registration that
sashiko found in 7. The kfifo part of 11 stays a small patch. The
release function is then pse_pw_d_release() from the start, with the
lockdep_assert_held() you asked for.

I would keep 10 on its own. Without pse_pi_power_off() it only moves
the free of the PI array to devres and adds the unregistering flag.
It does not touch the power domain any more.

One downside: Mark and Liam would then have to review the rdev->supply
change inside a bigger patch. If you prefer, I can keep 12 separate
for them and only merge 7 and the power domain part of 11.

Is that what you meant?

Carlo
