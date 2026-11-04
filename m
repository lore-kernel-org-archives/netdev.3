Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805597;
	b=jWwiZxVahhv+iKrMKwfLpTbW4cKR0O/TJP7LtlLY+YDwYGiw8VXaY9hirlQxfXXGtn4l
	 E3f0/zJ/a44ddJxTLBuHvhRtShr0hc1GFWVVSH1BbYYnVggSCUyKMaDZ4RRx0q65bYrf7
	 NrBRGg2i2AkiZbvxhVV+tQ6Lq1NN4opOoLFYnyNwbwYzBWshGE9vSvAcGbg9d9s8bDrrK
	 3tu1Qwqeu7PNZrLS04m5ImxXDoSzqhiWxGd2sp31v5wlTrLcRANnEnTAxjPNN1M66KFwi
	 mNKLnDyme+wZ0uuQSw/LG8VY/8LUD05xgw/Xhi6jU7s9XixoqTbYrc1GQEI6CvPhpFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805597;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=kkdyMP4SKS1JVf6/+csyql5Th5btPnXDMEmXeFc2r4A=;
	b=0T5PYIftx8CSJebgQorAT/lpO7Xy8j35dKNK0YjA/YAwrTgoGnGi7M58pOdW0YR4f6dm
	 5zjfI/64alplAQ+ZXJi4dyP4BqLP9DJv1ZZNlPX98K2QJOv08WJ1fCDHm8IFY6Zwg+qyM
	 9QiBifYQqnfgvINBfAjWvq+m3c8YUIhlIIf8jRIq6XujNx7pdfmqt28kOB2YAlFKYJuOX
	 imPNclntjq68KTBXS4vsQ5MeR5DaWYHeWVjjzfcwHSjEtxslB/72/4IWOsb5LMflQtCdR
	 I+d+lY20q7Iga1J9Wv3tfIKMhAI6FD88IVJ44u+FXhN76ulAglwV7cHGw8+N79db6oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ktTG2+iX;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD4D606A7DD
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DD4D606A7DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ktTG2+iX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D70F91A145D;
	Wed,  4 Nov 2026 15:19:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AB3D660770;
	Wed,  4 Nov 2026 15:19:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59759103291D2;
	Wed,  4 Nov 2026 16:19:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793805593; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kkdyMP4SKS1JVf6/+csyql5Th5btPnXDMEmXeFc2r4A=;
	b=ktTG2+iXZiY9Mon3B69k8zvtF4HZIh8HzQQDZiFhKOIlKcr3UzRsB3+Pqfz48ubgD27c/c
	M/fUJc9O1DW/YOqZNVfTAzix4enH5GC8H9PqIaxFsNgedbegEH0uyjdXof31MvjjcTqDNX
	NgjssTjdsVTO2QHlJfcz9oMywFO3YYNyx+dlJCUUyRse+0rdFr1fmlL5Ln+4Ay07L6qn3W
	SEenIYGF1CkNTDrmSzYuNLAvvePVIE10Jkmub+TsUJBNqUYYABwytXJmMP8okgNPdfMSrJ
	GWnCNKUnDGCB2SvFVDi+X1h4ebmu8M0GB5/K6NlNyjTT4YqAbkNW6A99sxatFw==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 07/14] net: pse-pd: do not tie a shared power
 domain to its creator's devres
From: Kory Maincent <kory.maincent@bootlin.com>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kyle Swenson <kyle.swenson@est.tech>, Ross Cawston <ross@r-sc.ca>, 
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261103220217.1131971-8-github@szelinsky.de>
References: <20261103220217.1131971-1-github@szelinsky.de>
 <20261103220217.1131971-8-github@szelinsky.de>
Date: Wed, 04 Nov 2026 16:19:34 +0100
Message-Id: <179380557478.1333589.6060800004280605045.b4-review@b4>
X-Mailer: b4 0.16.1-dev-17221
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 03 Nov 2026 23:02:10 +0100, Carlo Szelinsky <github@szelinsky.de> wrote:
> A power domain is shared by all controllers on the same supply and
> counted with a kref, but it is devm memory of the controller that
> created it. When that controller unbinds while another one still uses
> the domain, devres frees it anyway, and the other controller and the
> global map keep pointing at freed memory. The same happens when
> pse_register_pw_ds() fails part way: the domains it already set up stay
> in the map, and devres frees them.
> 
> [...]

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

