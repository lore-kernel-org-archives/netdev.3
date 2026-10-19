Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439777;
	b=NRfA84vFX/n8msetRMj5V6L2eazvBEIKtHc5rTmAVIto/S39Zm5AIixH7BLw0SWxYumy
	 pN/J/wk7NxlKOFCBikI/YL55DKoQAGByq05HwPyspmuvbGxyuFC6ToNc8YFywS17IWkX+
	 GP1LZlzXXGrFLMBK9yeVsAzbUjt8KsZ+1GkGdS2BuHHlL4YdPPxzCh3tNw95agUQuVeoS
	 Mfs9ZKt68MZ0YUf5VGqPc3stfMeRm2Mex3mgr8Ub36y5zC4F/YZbbduZGenjGsS5QAE+a
	 sEe6/j6q8Jh652Kl/ADqWMqhdS9Dra88mFk6NJgjeQG6f/fqCMupMfQt/A338YU2WUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=wOEmFPNBxCCXLsHZEe36jLOmx0lH4u9D6yFiiT5mTqk=;
	b=quMH0NWA2QJ8G8uK6i58LB2tphUTWT3tbeQNCtelnoY6HsCc8HczfbUQJG+Coe0aiiZU
	 Od/dxEVSkvQpaAkiwpcf5pMgrQ643dw5ukxkybyJoCF+ziS8BRGu1YwxrS9wiwOh/IDWz
	 B5Y1mkl5oSENBkFdHUrFwsqVYa10Vvo+lAeuN+2mmvgcewpPlB4p9/gqpE54Rpbqp/kNb
	 7GY4vmEqqh26yxrOFhoP2LPQ0j+EohDNFj8S1w/71Qw2ahxiPIXhPcdwF8KNduQj5ipPP
	 JXYQEVp+NGiY2acnyVidbVrOeRQSBUutQj4MvrHpAtamppvHISA2Y4duVNREArmg5yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=ZvBR4lR3;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D828606A32D;
	Mon, 19 Oct 2026 19:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D828606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=ZvBR4lR3
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 1C9D3E83AA3;
	Mon, 19 Oct 2026 21:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOEmFPNBxCCXLsHZEe36jLOmx0lH4u9D6yFiiT5mTqk=;
	b=ZvBR4lR38kuiHPkNtzgE5m7tdO22stpFLttlamdbL2VUb6LggwuRiBGcksbbKLR/n7Ttfw
	m431IejrxgcuqY1fU0d5kFL6cFjG98W3U4bmQJKLDHyGEF4BbpphIxRBGDsgk0GDglmcKj
	yUa6GLfa1WV+VP2egUdVZVzKUf3THGXigIGDK/R9+0+Nh3SO6ZGQeI+9bQWm6UWKpUJxOS
	9QmCkkstqpJho89qSzKo4oArY92lAYWxOS2lAJ5ilM9Ge08ZBta1UUcxocht8vPn+w7Vg7
	mA2c3kkBHfJGqHiOjskxgoDeDrToxDM2xNpexKQUPuBSVeCAeq+4VLIJdnaypg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id xkJ-EErgaoIq; Mon, 19 Oct 2026 21:56:15 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:14 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: netdev-bot+sashiko@kernel.org
Cc: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	corey@leavitt.info,
	kyle.swenson@est.tech,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH net-next 4/4] net: pse-pd: check the PI vpwr supply before registering the controller
Date: Mon, 19 Oct 2026 21:56:12 +0200
Message-ID: <20261019195612.307895-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179239893933.3135.9046263155258328713@kernel.org>
References: <179239893933.3135.9046263155258328713@kernel.org>
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

On Mon, 19 Oct 2026 08:35:39 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> Can this check pass even though resolving the PI's supply later still
> defers?

Yes, as the commit message says. The bound check is inside the
regulator core, and a PSE driver cannot do it from outside. fw_devlink
does not help either: the vpwr-supply is in the PI child nodes, and
for those fw_devlink adds no link that delays the controller's probe.
So this window is real while the supplier has registered its
regulator but has not finished probing.

Once the supplier has bound, PI lookups work again. But the notifier
series only retries a failed lookup on the next PSE_REGISTERED, so
until then the PHY gets no PSE control.

> Also, pse_register_pw_ds() only runs at registration. Would that PI then
> never get a power domain?

Yes, until the controller probes again. The commit message says that
too.

> [Severity: Medium]
> Does this new exit, and the pse_controller_check_supply() exit just
> below it, leak the vmain power budget that pd692x0 reserved in
> setup_pi_matrix()?

Yes, an older bug, and this patch makes it happen more often. It is
fixed in net by "net: pse-pd: pd692x0: release the manager power
budget through devres", which this patch will wait for.

> [Severity: Low]
> This isn't a bug, but is this comment accurate?

Right, the fallback also walks the controller's child nodes. I will
fix the comment in the next version.

Carlo
