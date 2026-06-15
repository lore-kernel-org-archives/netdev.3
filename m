Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851B026A1AC;
	Mon, 15 Jun 2026 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781546900; cv=none; b=nweJlbWbPdBc5QRIOInuIqDjZf5lHjcpLhnOnFaqCazJ996lENg/lJHznpBZZoIkhvSAUdYW9y4qgmQmCrU29Jz6pS5Da05LV33vpYLMY9/X1jS78hltkXk5rxZFUCbgXeh2VndSVnohz/JEWHUfPn/kZDNlJA1BAlPpwoJd6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781546900; c=relaxed/simple;
	bh=U6C2qKMwr8EsK4mfzTGjNKCIxqE7A8KQ32aGXqRNLmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTkejF5fYYTJ6WyCRXwo4B//6NDxtFfAVS6Vp8fPCvBzrR9Q6sUoZnN5iharDExGkFApB6o6Mmj67gtGP0FepYbkVcK2SjMSuRLnciYn1XJgbg6tzBgeYoDk6VgMNShOxoa+AgBlcKJdjSOa+wI3nKNEFN1L8QZCuDhHV6YThM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=XiqL0VFv; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="XiqL0VFv"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 27CDBE83B55;
	Mon, 15 Jun 2026 20:08:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1781546897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6C2qKMwr8EsK4mfzTGjNKCIxqE7A8KQ32aGXqRNLmw=;
	b=XiqL0VFvJ4SwlFfVjkzd0QR3Hj+B+C9HYpHDssVIxLagdqjBevPD8UFH2q7WPX9y1Lypj/
	ADl2lWF8vvMzXVSHM9BG1PZzxa9A7YX7/0dwS4PgRieJs2bLOo8YTrf7GqXQFVS5Xurwpv
	OHjI0vLa8oKxuKIuAHMx2933P7wGZyIsD8txNVxmwgAbA0rQYWR5oLPOevgCWgUZpnJ1iE
	a8UxQmW3+nmk29vyRNjohLE8R/oMWu5tZWO4XYkyq9s5lLDS8/Age+IsdsIr6UCeqKJTHD
	1MgYadJ5jrAc+6aaF7CZNWlktjjxmWUGNHL1meljDb/iDwRJmfFnV2r0hVfC1A==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 1bEVtuS11M5U; Mon, 15 Jun 2026 20:08:17 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 15 Jun 2026 20:08:16 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Corey Leavitt <corey@leavitt.info>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Date: Mon, 15 Jun 2026 20:08:12 +0200
Message-ID: <20260615180812.829678-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <177795581584.12433.14568712745388778289@leavitt.info>
References: <177795581584.12433.14568712745388778289@leavitt.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Corey,

just checking in on this one. Did you get a chance to continue with the
series, or is there anything I can help with to move it forward? I'm
happy to test a v2, and I can still run the SFP path on the
S600WP-5GT-2SX-SE once it's back on my desk.

Kory, Jakub, Russell :-) it would be great to hear your view on the
approach so Corey can plan the next version. The series fixed the probe
loop in my testing and I'd really like to see it land.

Thanks,
Carlo
