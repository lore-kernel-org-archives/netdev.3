Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439768;
	b=KraxitpJfcnZGpgz6w/gOQ1W6fXYWyNU+yZXGOQigjdA48Vu8+0jegSfxNmNFEqj/JdP
	 8CYeSzpT7gDGhUYaOMPfHTzmJGRDxKV9VE7EnaqnvmdW6Uy6/KV7eKUDnVZJJ2xiKwGQ6
	 iM84mCyNlHbWBcrd0l+tGeGvXlqCG97JaN9mt0Rsy75NYViQF+ifTKg9b5WL4XwmP7pb9
	 q9fN9t53ZlLgdYOlBaxy0YgQImXsI9RsKKjqDbSrjLsqHK1azeqnGdmVmMkcK26x9RlJj
	 rXidV9TEviYMvGU+A+tkvwr4X7V/6vwUo0VFKi/rwlhEdKIuW13rqih3deb9EiHnsTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=0nV7miFpGhwYrrBiNxbifZRnNaS9vZKpI4wZQ7tJm/Q=;
	b=FhxgO80k+wR89qGCX5JgF5vQM/RyGLqea4wHhGktL74hAfO1fPm6t/87VXbs63HnovAm
	 6PNso0oyLRcPEhdCZvEg8A+e5vTgIQcuB2rCJTXubFsvyP41D9Bns2i4kyAD3BwarC31y
	 JjtIdrtCed+7wCapGz+XixC/HkO6wHJVVIYatT+Z2yPJGVhYZGNro76HIRe91wMCepZTp
	 ZKBMrpGGkTFVRiJmf0bKREE6Ku1EJzrJ8PSb2kReatwwGfw/rSUJJGqhYQqoCEm2f0sO6
	 Cr4xR7PY1zoaZH+Ogw9kH5wcQWBrcXk/KAJlD3uhaU3zbO5nOD6bJ7paiszO4e9in3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=i1DkPaNR;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4010606A31B;
	Mon, 19 Oct 2026 19:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4010606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=i1DkPaNR
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 702A7E83AA3;
	Mon, 19 Oct 2026 21:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nV7miFpGhwYrrBiNxbifZRnNaS9vZKpI4wZQ7tJm/Q=;
	b=i1DkPaNROpdoXl4/xipfEF9N8PFMthZe6M2xtquo8xL+e6Zi3x/DPX5oZtNkNcCZ75ZigC
	4scKgtkuUMH/z3yFgIeQppKJO4VIFO/aTYeppDWG5Fk1azQAc2r5v1QOQQplpv2iuNp0df
	jcVVepXNSG7SaAYHyYC7fqbPjl9Y1ZP1ebKC+98PKYiCDWBjRICrtwIof7pw2oWO59UQ85
	DwfYAESj51zZWVMHCT4z9P78oCdRA8TztOmnPPxIY1sX3IE4rNeUHG3YUgeQeSrKnKkkdI
	JzhsdDOac6jxxU83TV0R2HLJX/UclsO1F122ODA+5th5DOzA3jdNifyoeo2Rgg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id hf5OaSqNAIb2; Mon, 19 Oct 2026 21:56:05 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:05 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: netdev-bot+sinfo@kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Corey Leavitt <corey@leavitt.info>,
	Kyle Swenson <kyle.swenson@est.tech>,
	Simon Horman <horms@kernel.org>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: pse-pd: core fixes ahead of the controller notifier
Date: Mon, 19 Oct 2026 21:56:00 +0200
Message-ID: <20261019195600.307832-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179231182849.3290.12579854151312214118@kernel.org>
References: <179231182849.3290.12579854151312214118@kernel.org>
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

On Sun, 18 Oct 2026 08:23:48 +0000, netdev-bot+sinfo@kernel.org wrote:
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.

1/4 and 2/4 fix bugs found by code inspection and AI review. I did
not reproduce them, on hardware or in QEMU.

I only tested the fixed code: in QEMU (arm64, KASAN, kmemleak), I made
pse_register_pw_ds() fail on purpose. With 2/4, KASAN reports nothing,
and kmemleak only reports the PI array that the commit message says is
still leaked.

3/4 and 4/4 are not fixes. 3/4 only changes logging. 4/4 defers the
PSE driver's probe while a vpwr supply is missing; I tested that in
QEMU.

1/4 and 2/4 move to the net fixes series, and their commit messages
there will say this.

Carlo
