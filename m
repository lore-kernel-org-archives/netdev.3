Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29F364925;
	Sat, 17 Oct 2026 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277227; cv=none; b=V+HJYFHOYfkE/MnrJBqYQBPcbUoiYPnOv1mpgJ+RJpVjr4nBX239DlzaWCq/3hVIHF1YBMvIOPuIzgObYEcnd8ZXxAq9TrOrJt3FxGa4c1W3NLWZQu9hy56UBtnxX78kC9Qaw0snk8eQumm0zeO2y4U6YVuGZ99riPGe5g79C0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277227; c=relaxed/simple;
	bh=Pvyi2ArAZm0W2gqWX2T/4EOrz+xEfDtkZJG4BfoPzO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6eMi66FhQu+oBwB33A/Atu5Qlhwy732Lic1U85KYRRlQoRQ1074r46LHQLzRFCRaTlOenA2fG4JLgNjZIT0zu6OEEuVShoGIWsSioiHlbpFvYC7oPuAsF28lsTDE/JCy/1PZY2wJWqKzDm1cMwFm4Uu/L8RIIvk9U9KQIGhst8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Abo8X9+t; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Abo8X9+t"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 5A8FAE83404;
	Sun, 18 Oct 2026 00:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792277223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pvyi2ArAZm0W2gqWX2T/4EOrz+xEfDtkZJG4BfoPzO8=;
	b=Abo8X9+tdgLsamp0ho5mslOxzobAFJJ1imN0NWDN9k5rLPOOwh4a5VYroj9boY22gdvOy+
	i+PYBiWPUcnuaZlYvtq4y6UMNZs343W87k6Crq0xqtdxzWWHEiXXi49MuBBUe3ufsim3Rc
	qc39AF6Ag67rsN7yJhQ3KyEkG8JlaCG8YPQ/Vmh8Ebb8TwUKRNkcJ4Y63/CCdU6MTzrbxu
	xnfn8Rpv9q8/xoOzE++6I8/MCzqO+LoC6pi8vT2YWa3pRcQpYrufFtBiwW3t4LgxHcsrl1
	7RbDU0e439APtU74Q5Hq9jjy/ujFyqGIG92ExK2E7tgrFXONjkQUwOZZsgddrA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id M3PTw-Mib_ap; Sun, 18 Oct 2026 00:47:03 +0200 (CEST)
Received: from p14sgen5.netbird.selfhosted (dslb-088-070-183-026.088.070.pools.vodafone-ip.de [88.70.183.26])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 18 Oct 2026 00:47:01 +0200 (CEST)
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
Date: Sun, 18 Oct 2026 00:46:55 +0200
Message-ID: <20261017224655.1527348-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179122160743.434549.17705968645948888828@kernel.org>
References: <179122160743.434549.17705968645948888828@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Oct 2026 17:33:27 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Is this store enough to keep pse_pi_is_enabled() away from a freed pw_d?
> The store is done without pcdev->lock, but the reader holds that lock:
...
> Would it close this window to take pcdev->lock around the pointer clear
> and do the kref_put_mutex() calls afterwards, outside pcdev->lock?

Yes, agreed. In v9 pi[].pw_d is cleared under pcdev->lock, and the
reference is dropped afterwards, outside that lock.

> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch, but
> this patch reworks the kfifo handling here. Can the kfifo ever be
> allocated for podl-pse-regulator?

No, it can't, so podl-pse-regulator never registers today. That is an
older bug; its fix goes to net.

> [Severity: Medium]
> Doesn't this still leak pcdev->pi and the OF references on the PI and
> pairset nodes?
...
> A devm action on pcdev->dev that releases the PIs could be added right
> after of_load_pse_pis() succeeds.

Yes, the PI array is still leaked once the PI regulators exist, and the
commit message says so. The devm action is a good idea, but it also
changes how unregister frees the array, so I'd rather do it as a
separate follow-up than in this series.

> [Severity: High]
> Can a controller probing at the same time still hit the use-after-free
> the commit message describes?
...
> Could pse_register_pw_ds() undo those domains
> itself before the out: label, doing kref_put/xa_erase/regulator_put while
> it still holds pse_pw_d_mutex?

Yes, agreed. v9 does exactly that: pse_register_pw_ds() undoes its own
domains while it still holds pse_pw_d_mutex.

> [Severity: Low]
> Should this patch carry Fixes: tags and a stable Cc?
...
> Could this also go to net on its own, rather than sit inside the
> notifier chain / phylib ownership series?

v9 moves this patch out of the notifier series, into the separate PSE
core fixes series. That series goes to net-next, because the notifier
series builds on it. The older bugs it touches that also hurt on their
own, the kfifo size and the shared power domain, go to net with Fixes:
tags.

Carlo
