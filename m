Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817915;
	b=u9QJuE6xQMWJNs5lCKf8NZzxdJlToYQ1dMc6jD4LLnMTE98Spv1XshhMFoBaSUO7Dn65
	 cq9D7SJmhGKo75eBmJ85GlF1/lyBF0v9MHk03coKujY8TOsm56sXioDReI2cpcczJS6q0
	 +LPeGgZGV9m6LDf0wSKFb2cbJd8XFJpVal8QywAxq8uoZapTQx4FndIgsF4Ajj9lLB1JA
	 rfDOoqm/PUyV3MINr4s9n8YzC0XSpyn9j04C43ONuj3kc9W1LAfbYRHvdKo2nGTHvumr5
	 oSMshweJ6ljTZ2OuC1ZATPHVB804ddnXG/xaqAsnTifgmsT4GwSI8jUUuSugIdlnlOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=c0J55K+HNnBXYLt9cXulf94L6m9YsnTQiAUpqidrHh4=;
	b=uKoXjW8EAyYkpJ4rQkMus7k68TGMtd0YLuKaUDUnqmf0c0SWdxmhpMGjbyjVno7MdEPj
	 a5f1zT9JHVrXMzhTTdKRjyW4txWye7X/QVrxT6jZ0iVCxIAMRkeNA+zcBsffcGlmfBXKx
	 yu1QnxUaKQmdnrEGpDwD41AzWCpH4v8+9zjo12edSWJ5v55+qwS09jcvb4yiwIuWSY9j5
	 oeAnlNAjoOIGZh1zde1DlOqQA7VHtbrUOLWhXKmca0NpaYKBDw3NDJIZgN9Dzaah2Qy+x
	 xyTwm0sZhSsW5pBZwzwlaMht1wT4omtbKjSEFZSE1IVDiCFafTPbqd9FZECgmvdZ8qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=PNuTxwgc;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8D606A326;
	Wed,  4 Nov 2026 18:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FA8D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=PNuTxwgc
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 74C81E8382D;
	Wed, 04 Nov 2026 19:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793817909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0J55K+HNnBXYLt9cXulf94L6m9YsnTQiAUpqidrHh4=;
	b=PNuTxwgckhaw5lJE15hTNcNFbznXe3ltBBiystUnDDXDN9yI8RyIjYqozl6jgqVYdGsA9W
	srp+n8fAihJb4MWhQZ2OI1yMvRvBPl+GiDIJjl4YnSQwGUjRn/Jr0jKL+oC4pFiEogNKaJ
	BcN5y+cJl08tRSNvP7dOUK7Fy/1NK0aB6RSEeipUy6/2cm7xaw7Si1XrhIY4YjSIMFUK41
	z/NNcOh8cL6/R2IJrLgswmIAjg+RxiLTopcy7y/FRHDSXM47U+qELmt0JtAIHqMENYcTf9
	RMjuvcrS6Zz19tO84dLc2pRoG/rKa6aG5V2iky6SpYg58vACRVdeyMNwGr+kmw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 3t3_aLBeANmp; Wed,  4 Nov 2026 19:45:09 +0100 (CET)
Received: from p14sgen5.netbird.selfhosted (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed, 04 Nov 2026 19:45:09 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 00/14] net: pse-pd: assorted lifetime and error-path fixes
Date: Wed,  4 Nov 2026 19:44:43 +0100
Message-ID: <20261104184443.98789-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179380557476.1333589.1226488492070925173.b4-review@b4>
References: <179380557476.1333589.1226488492070925173.b4-review@b4>
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

On Wed, 04 Nov 2026 16:19:34 +0100, Kory Maincent wrote:
> It would be nice to test these fixes on real hardware, to validate that
> it still works without issues.
> I will try to do it when I find time but if someone does it beforehand I
> would be thankful.

Hi Kory,

thanks for the reviews.

I will make the two comments in patch 5 shorter in v4.

Before I send v4, I will test the series on my hardware and report the
results here.

Oleksij, I would be happy to get your feedback on v3 as well, mainly on
7, 8, 10, 11 and 12, which changed since v2. I will also wait for the
sashiko review of v3 before I send v4.

Thanks,
Carlo
