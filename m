Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439791;
	b=Jdu1ke5Y4PI3sx2HfYMb9T8xNVR1e0SAvhsH7zZyWHEQN+VpOUeDvZ8SASiw/usnMRgk
	 CBVssBMBdLv4A5yEjAJRl4JDzmOAB6tC1VSWQoPROqRKlTK+PPTrjqnWiUlgNYxywoyNn
	 Mji5bLAistXPQmY0aW5+xpS5I+anqKpCHBpFybmOaEY42QK1AmQvAXDImGzE4zNwBDIkx
	 hQsYPXHS3fQvJ6iFzvGVCandDDeMUm0ou80UoLnhBhesHorUOVvKR/atppJNCldRLFKDJ
	 FJVUdPPdE1yIaBUc8u2cBMABxKXmXByACRdvM1fW7vr8pw3rCPgMS8wIYOqJntVy/NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=z6Q4znAUwU8ygMs3ZtMnWx0/GEYlAn9YQfEqXgE+Lfk=;
	b=jJn8ofucE7dqpHaZ5SUSQubWAJlc/Yz8kjrv1h4ZHS84e3V8g50vRUWW0p/t8MeMTZ8U
	 2m3vNHV0XIMeRBe1b/Dr+nYc2ilMmljLBXMWKIL1a+eMneoSd65wfMJ7VbkHm0qEn69g9
	 XKwEEqCH1E1ZcVCRLbFP/oR3Jf1SD9FhcGIsOpFx5PK7+t2sXoBzE5vlwHfts60r7mVfl
	 o3zqjpxVDfKBhfNE1lEyKv5BKzLlTbYvEVyKqd5VZlGYj98km/6Rcn9+J94m5QJO+q8Wa
	 UlA3r/Da7v/gy2mGdatVfbkTAn+zylaIV+CDCS7sHcbm8sdtv4v9pZkael1ZsGGhrxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=VOFYu46j;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C760A381A;
	Mon, 19 Oct 2026 19:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D30C760A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=VOFYu46j
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 173B7E83A99;
	Mon, 19 Oct 2026 21:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z6Q4znAUwU8ygMs3ZtMnWx0/GEYlAn9YQfEqXgE+Lfk=;
	b=VOFYu46juEGt02xeZzi8HLmB+Ir9fzSh/gVK/tMdzx8YU8jvWxEnclsv6t1Ke4JPkt91xT
	6LL5EKutoiobkGROHMZ/guZHJPV1DckJ1cqpfg1w/QAmLNri1Q6+8r7kfQoyXXoCMmV5EX
	4izLo/cXdnT+kPzoK2oXxGSlG69DTvjjuANOkgQUgQZDRWgxQ94K9p9cDyhLiGwoVORgAd
	vO5iFKmwADAJWeKokkOyJoyXdZEqgmPI6JbTeWVAlYPqyBTKylBgHVwhebDNf/BMFvsUxL
	xM5VX2RhMpxuFFhIW1TImDtn0+xrbHjAck4KcT1JCklQNkUVxeFTncq40VzHgA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id ff5yUXR36H9i; Mon, 19 Oct 2026 21:56:29 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:28 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Piotr Kubik <piotr.kubik@adtran.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Kyle Swenson <kyle.swenson@est.tech>,
	netdev-bot+sashiko@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 09/10] net: pse-pd: si3474: fix use-after-free in ancillary client error path
Date: Mon, 19 Oct 2026 21:56:27 +0200
Message-ID: <20261019195627.308064-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d9233496-7549-4c53-b240-344bb7a8d9a5@bootlin.com>
References: <d9233496-7549-4c53-b240-344bb7a8d9a5@bootlin.com>
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

On Mon, 19 Oct 2026 14:50:32 +0200, Kory Maincent wrote:
> That's not really a fix but well:
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thanks, Kory. You are right, so I will drop it from the net series
and send it to net-next with your Reviewed-by, together with 10/10.

Carlo
