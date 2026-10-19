Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439768;
	b=EYGt5ZBRb5UaMApxcd8GadsW2jF6ydfWkBvotiydRxMO1EEiAlq363+oDFXHpCPkd4CN
	 jMU5uU/3etu7lPB8Kb+zPrnHlqdCeZqFZNtllRmW4r85EA/hUShDEnWxp07wWcChLS9/v
	 Dytt8MMo+qeGX2tqHb+MtUsg6hXjJZ3a6ouwOLtFF0Gb9nIhCq5mJfLO/3wR0vrOlYvZs
	 2ltDVivICKTc262ixRzrWUfnWXICwkgLBSaJskxlvu+0nEzRqyvCH3Ru1Xp+3egLfS3uQ
	 G3MMQ0yXHNnvxxsJKRsz0773jMfilYoUT6QbPPzXRRGtb/NeEPVU9ms18XMQo5S42eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439768;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=JXdnIyvrKDz0KNBIWo1vxPO91lly1xbG10WPNnPQ3DA=;
	b=2VxnM3/5p9GqI5i7U/kDHRIaTJO/ovFLK7mJQ9iQZjYkRoRfOLkg9QkFe7sBNonMlK5b
	 vDDnvVoyNXdcIYIfbkGJtItXZh9AYpXWJzlStjLIoa9X+XX1MfLmGzj5gX4PdjPW/Dw2k
	 0nhNGUS9nd08JbAEtaXcaZSkJXHcxwDsrePc72sFF+WECfURmbIbddO8xgy30Rz3JkwXq
	 RLB7C0fpSMXPgWCoSCbS/NABHfEG3h1hlCMBBbeUjvSOwAfzrPX4wfXT9osorER6PaJ3A
	 lfuINrwWArHXJt2bj1/o4D2sxAc0tTEmisyV5DTYzUTCODIoohjfNNdiBxfwOtMWZQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=UtY+sJD5;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD442606A31C;
	Mon, 19 Oct 2026 19:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD442606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=UtY+sJD5
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 95219E83A99;
	Mon, 19 Oct 2026 21:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXdnIyvrKDz0KNBIWo1vxPO91lly1xbG10WPNnPQ3DA=;
	b=UtY+sJD5ZZqeEpJdC1qvpLTqW1CVEKOeQcc7QAm5dmd+3XmRghtEMTU/mfog/p0ZQa1X+0
	PxGp49yF5qad/P4ro2Rek8ZCHRlXzNSz9iwhYfguUVs6dwwvsQPNExvG0bokfdWEsn60P7
	2yyKjzsptwvnlnSQOQbfEQRB/fFNy/qVcOs5/LJ7x+Yn89NY6siGGBQZRpAtnY1I6fwVF1
	XYR2eSjp7PXKpleJCvuQFp+Px/eN0Eiss38LTED1piogBTBw0A0xARVSkWzCGNArz+M055
	IKGLlBXU9weEiGpN/jPOWVhXh/NPtXORgZTAkgp8/MqHn04I2wXS5xxMy31evQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id AwQoPrqbJoi0; Mon, 19 Oct 2026 21:55:59 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:55:59 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
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
Date: Mon, 19 Oct 2026 21:55:43 +0200
Message-ID: <20261019195543.307784-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c652ce20-a3c7-432b-8bd1-dac902f04149@bootlin.com>
References: <c652ce20-a3c7-432b-8bd1-dac902f04149@bootlin.com>
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

On Mon, 19 Oct 2026 14:54:12 +0200, Kory Maincent wrote:
> These are fixes, please send them to net instead.

Hi Kory,

Thanks. I will move 1/4 and 2/4 to net, into the next version of the
net fixes series.

1/4 does almost the same as two patches of my older net series [1],
which already have your Reviewed-by. So I will use those two instead
of 1/4, with list_del() moved first as in 1/4, and fold the rest of
[1] into the net series too.

3/4 and 4/4 are not fixes. They prepare the PSE notifier series, so I
will keep them in net-next and post them together with it, once the
net fixes are merged.

[1] https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/

pw-bot: cr

Carlo
