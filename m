Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270960;
	b=c3JY99SPmm3pwAMN2Fv3N/nSMe6PpenBco93Ys0TFrWeqzJ0RLxdzxD/SE2f1xMpKkzn
	 vz1JU9NrSBjZoQ5txxi3g9OojRl7reIYWuTTsC0OBv/53lyXp67bDcspsj8hKUadbEU9N
	 bgkAv1ARQDx892HH5WzhA4AVISN7gzpBI9Bku9tQ8ekUQ/KfIjIhtvKmIwHFgxezpqJFf
	 alfummeqM1faHQl8oLnkAzYwKT6YBOw5nck1dp6UeJq5c6WVSfHyoU1r/7o0zdCuO4xea
	 n06JL9zWYWhtsjPWfG7FxwbTHTE2GfmHfd29wd7zgQBQIYtgc3w15tScInMWsF1n5Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=OYpGrg56OyyO3IwveA/BBLM+IgsIGZbVv+HOwFpKGOI=;
	b=U/2Jfq/bmIxxLGGkOO9s0gyjhZ0fnL5fJsSAmyp1SNacNom7xYjSD+GPo1U3ugtByFKW
	 CQ0cwvfnjimPdQDIg6dsVDHv4V+EuSWQPReGlWtRVOPRUGwGSb+bkjN+D6FXuPz0uL2q1
	 7Ut7YZc2d4XgwAnsP+7zMu1Wm+P0RNL3/N8VZuTRqGzaSNrRDkeWAsuPIMDXYe1Zc1A6y
	 aAaGTSPKY48tE2UPoGVIudxWOoR8h3nW/Oc8zGa9EB4PtztGYPtR3AZUglp17jGaFewXi
	 mDSBKwiTa4xN5unjUqz0D3RFFNy644cSBLGtNaKxU2cLfHQwGGh7zNvFeAt0Tru61gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b="kb/+vwke";
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92DA606A31F;
	Thu, 29 Oct 2026 10:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E92DA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=kb/+vwke
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 50E7EE83537;
	Thu, 29 Oct 2026 11:49:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793270952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OYpGrg56OyyO3IwveA/BBLM+IgsIGZbVv+HOwFpKGOI=;
	b=kb/+vwkel5RKFklkBv6mYPcIm8loEqt4GRaxnkNyLo+vx/46Uu8zed5aVtP/ji6gmfu3QY
	eWnRliJTlZAKXzi9e+165fIN2rhhZSQLMAN3FRsOSPP0QLtErfZiFpIvQuZMxibLk8b1EB
	IMmEXMKBnAi3TsK2z7D3j3a6E3SZBKcLX7L7RkhzUH9EMUvTSHuMZXHeevvYMpkgfRqe8d
	coxcBFOUciWlZOv8JLBYYHXYCJPbhjXCAz1xkk0xpHal6ez3crPErh320PuPF/7X8C6vHG
	jJ2BqbgXBsk00UOjSZiYQQ2T82rtIbAq37RmWEZ9Wg6++fVRXvsokuz1fh29Ig==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id VQ4gxc1nAiYE; Thu, 29 Oct 2026 11:49:12 +0100 (CET)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 29 Oct 2026 11:49:12 +0100 (CET)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Ross Cawston <ross@r-sc.ca>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 06/14] net: pse-pd: check the PI state under the lock when setting a power limit
Date: Thu, 29 Oct 2026 11:49:09 +0100
Message-ID: <20261029104909.464347-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023215441.1087277-1-github@szelinsky.de>
References: <20261023215441.1087277-1-github@szelinsky.de>
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

On Fri, 23 Oct 2026 23:54:41 +0200, Carlo Szelinsky wrote:
> This was the same before my patch. Should set_pw_limit skip a pending
> PI, for example with pse_pi_is_admin_enable_pending()? If yes, I would
> send that as a separate patch.

Hi Kory,

a short ping on this question about pending PIs. It does not block v3.
I only need your answer for the separate fix.

Thanks,
Carlo
