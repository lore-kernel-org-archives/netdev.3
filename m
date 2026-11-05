Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901723;
	b=Xm95+fWhRvPOE68oFckSmGdAerQRKqnxS9iB6xBd62f65+gaIlp5FDhZACTImqOx8zem
	 agZ9eb+UkFqeSwCpOKF1FDp/f9qFz+kAFugYCbH3WgHJmUPrm6hibUik0Yx3hDRUkj2IH
	 /NUaUsSQ9zoaocfhDNbBiayRfXeUgmd6KwQiJ7UsOh3EiZDSvni0WFZec3apph4cAhsWW
	 Bb89nleDbrRO1z4Ps7A/vFbiYqPFvC5k7CnLmiZ9M6Zo1e0rxueWpgkafwH6K0QkJIwKU
	 xv8dipx/vAPafhrNT+EVjAmdd+dft3b3BwQGfz0sppqStfpoDtfeKZFkwBj+mnowUcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901723;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Dt35qAdpOy+AxuYq/YKWrI68VNaWXEyTiccgSdEoOUY=;
	b=Lkg7X9SQtg4Jf5lhkyCe46DTWbBPZISeb1SrYDwIV/dDNcvND9HlKU+Q/lWMVvdhsSzi
	 tuXcs+hmyMpCbJgkIYj7eFKIxLIhIh5i/7jZjdqA6SyVCCrHV1SgH4aJKJbNnAhhHwjAT
	 RwcpWk2dAU0ZHAruJt6FSEKXIYAE0BTZeOAGnpZ4YmwhJQIHIF1FA0t5yq9mVJNA/osPr
	 XOCRSorcFN7RugRDsHb5rkWDwoNBwteDjaje1To1SwXNGsgeFDkarHWcKpnfyIxlvwu8B
	 Xq+lZg/hsJmsm5mS+XcvCPqCe+X11mvlk1NK1CRwowU2R/LGSCx09+9+qLAMReDl2pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=GRVxAz8B;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C73D606A33D;
	Thu,  5 Nov 2026 18:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C73D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=GRVxAz8B
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 577F9E8365B;
	Thu, 05 Nov 2026 19:02:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793901720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dt35qAdpOy+AxuYq/YKWrI68VNaWXEyTiccgSdEoOUY=;
	b=GRVxAz8BDRw1qmtJ9/pLxAduBFOYNyRB8ztwHMXc9UK+l+V5yGc3l8HSl6FSQTWQMxBGsr
	4Q81TryhyPK3ZKTb4r7zOqcjHZMluTONpuEQkg7/HR7tpN3Nl5QnG6FdXD3zRXDvCqJQ2w
	x21Oo8XDrGsJzF4xxkboPmQMz0ueEzyKpD7VraXfiR9Bp8pcd20Z52Wvq71GUCWc/yY6kl
	hogrSKRPDE0QSFsO2eBb1jTsR+eXlWhfg5ixjn8lX/c0Z/W6Qge7FyxupSK9JRALNlqQUj
	Lyeh1azJiORzyt4hgPr/Ioj9rKxi36CawOKNGB2jP916mXp8r7NAc6F1wSWT8Q==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id uqLmPweoiU4i; Thu,  5 Nov 2026 19:02:00 +0100 (CET)
Received: from p14sgen5.netbird.selfhosted (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 05 Nov 2026 19:02:00 +0100 (CET)
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
Subject: Re: [PATCH net v3 08/14] net: pse-pd: stop async event sources before freeing PI data in unregister
Date: Thu,  5 Nov 2026 19:01:49 +0100
Message-ID: <20261105180149.233435-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179387331572.488856.14138423432886028016@kernel.org>
References: <179387331572.488856.14138423432886028016@kernel.org>
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

On Thu, 05 Nov 2026 10:08:35 +0000, netdev-bot+sashiko@kernel.org wrote:
> Should pse_set_config_isr() filter the -ENODEV from the unregistering
> check the same way it filters -ERANGE? Or would you rather have
> pse_isr() skip the PIs once pcdev->unregistering is set?

Right, thanks. In v4, pse_set_config_isr() does not try to power the
PI once pcdev->unregistering is set, so no false error event is sent.

pw-bot: cr

Carlo
