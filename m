Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA134239E7E;
	Sat, 30 May 2026 10:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138254; cv=none; b=DKsabucE0jbmA6a456bNjicQdvKYK+KD92hTRT9T6KA6xCe1+8yfCFVgN8CcdkgG1VTt8lhJ/78WZUb6i0BrYLzTnbi3rpm9d3iEztgRVQQBqo0E8hvWZXQBAgYIBsExHqFXxNkeSH+lBYfIsw6O7Yl9u239lLaH7k8TKJv0t0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138254; c=relaxed/simple;
	bh=yd7P6rhgwXSyE4z+bMhL8rl4mmJmInT6iFaKJPVqnTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7hxDRWHsPhNfYfsmgEMeV4EixvguGniE0rhfIMND+8zvPyB6X34G5rO6zBg8qrAM6HzGCJwAO5Qasg9hdbz2d/4ZEaENjgorFCXgB1OIwaw2YKRbTeaqGmGaUHh8amgeoSxhBELDIo79Z6sSH5Wthr/txjAxu/fyfCkyXczLAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=WeA9AdLF; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="WeA9AdLF"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 96BFFE83701;
	Sat, 30 May 2026 12:50:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1780138244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yd7P6rhgwXSyE4z+bMhL8rl4mmJmInT6iFaKJPVqnTc=;
	b=WeA9AdLFrNImS4zgHqGcT0eM71LnDXLtljNoRQdR+kZUJgJWveXFxp4LL3uyjouT4YJU2Q
	BLEyBH/YyjMEPk8DnpnrVbEhkN3WaLHRyouALc/uvp/dWpkWnvP4mcr10zhaFaWo3kwVCJ
	8hPxX4RK/dx8QoiTxVM19Uidifqvgu3+umzms47NxLqYdAF1On566RuX9WM/k440QYT9ka
	ZSdJfsT026Ge+TA2MNj+nB7p8V9Cn7hBM3uGlhwXKiS4OTHD+yi++JI8jpqb242dDwcZyq
	HfPYpFbmret/bnwkf5MzjULVIUJ7iuYZaePCmg+FyLQ+v5ecGWZKDg5KHPOjcw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 67frtJP9kPV9; Sat, 30 May 2026 12:50:44 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-174.002.205.pools.vodafone-ip.de [2.205.89.174])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sat, 30 May 2026 12:50:43 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Simon Horman <horms@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net 1/2] net: pse-pd: disable IRQ before freeing PI data in unregister
Date: Sat, 30 May 2026 12:50:31 +0200
Message-ID: <20260530105031.3274303-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527125551.2425511-3-horms@kernel.org>
References: <20260527125551.2425511-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Simon,

Thanks for the review.

> pse_flush_pw_ds() runs before disable_irq(), so an interrupt could
> hit a freed regulator.

Correct, and it's the same bug. I moved disable_irq() above
pse_release_pis(), but pse_flush_pw_ds() still runs while the IRQ is
live, and it can free pw_d->supply. The ISR uses that supply via
pse_pi_deallocate_pw_budget(). So the race stays open.

Fix: disable the IRQ (and cancel the poll work) before
pse_flush_pw_ds() too. I'll fold that into patch 1 for v2.

> cancel_work_sync() after pse_release_pis() may use freed pcdev->pi.

I don't think so. The worker only touches the kfifo and the
pse_control list, not pcdev->pi. The patch 1 message says this.
Did I miss a path where the worker reaches pcdev->pi?

> Regulator ops still reachable after pcdev->pi is freed.

That is what patch 2 fixes for the disable path. Are you pointing at
a different path than the regulator_unregister() disable flush?

> device still in the list / external consumers / power domain tied to
> devm lifetime.

These look pre-existing and not part of this series. Do you agree, or
do you see one of them as caused by this series?

The pre-existing items above (list, consumers, devm lifetime) - would
you want them fixed inside this net series, or handled separately on
top? So I know what to do before sending v2.

Thanks,
Carlo
