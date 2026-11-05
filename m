Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901725;
	b=sMsbGVjda9hKGtrlAYRBPXKXbhaP+5S7mSmHdMAYwMGAA9DbUd9G54lth7lLTjAPGJaG
	 Yn4xwkmvenH6d6KBJbROj7GkMp6csAROj6XRX3PtnUDHvKqUW4ubpbX4iMk463bI2+OIm
	 R79loGDfKNzyGkt1AQbLpB/0J1bGjrgibFgPxMVPnYqw20e2m+PqYRKuNChM0cZ7otNNU
	 NjFBK6NaQEHqOGQMuIqXfTaIJMSVuCyUhaFmoQ5v4LEPwFMT8OmhHXfXoP/yX+/zcFXFx
	 NlByeonq+afr+l/2C7UFBjmpMyeo2H7HqnlrPksyZZD7jvxGsNX8TbNdytSzRdZ9Mkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=gtFRzP1ofQBr9FOavJvZ0YaWYxGW+VCIo/+DaZMZ574=;
	b=fJCVEz/fM+fW1PxQQnZu24CS3TO0wBD3zwfuxzB2X08aemZlmvLCvwkB9GIbhDaYkDFB
	 OB1SMtdc/a4cetSrPALCI05QI5BO9V4uFQsllZjiuH1QqdrmjyP9UzHucOPcRl0McUyNe
	 ykfDEwvLliwelhwzb8Khn9/VvFDrkxkJX2Oxe/dKL9Av2xgF+TEuvAHkvV/VmtfTpCrX1
	 r62FwsP2QrZrKdcmXXEZZecpD6vAZSkI60TT5FacRybsZDH3VVphUGquolHjnFNkQ+flB
	 YHbb0J+hzfDTIZC7yKxogKIlSWjXk+aqEqp+TXzFdQVUPzO9SGOpXn3fz9wbk2Pqltg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=cwXow5bk;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46781606A33C;
	Thu,  5 Nov 2026 18:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46781606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=cwXow5bk
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 6612AE8366E;
	Thu, 05 Nov 2026 19:02:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793901723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gtFRzP1ofQBr9FOavJvZ0YaWYxGW+VCIo/+DaZMZ574=;
	b=cwXow5bk2zu425zcvqHNbP6WRScM5dDG2ZYo32x+qqY37uh9j2bAACYJGzAESHu7GWJJqh
	TXH5TKj6ZvIMC7BRKvuZeE+0B0D3cCkeCp0ZkVFJ3ZflCejKLiTvdxIqO5wr1NvT9yXjUK
	SDvi9z79w/jgGbewvrVR1AWh1US+iWlE2zK9xVHQRjRvLMXDIlBMMFHkJLOEv5O+Lp/l+Y
	NqdGEfkMNVu+MspTsWsUv+5R1hHUa0dIGRCl22jyUqIkB4VxZ6tuYk1YJtSMNivir/1NhN
	r/dSxrgOTUHt/RMK31iNTYoVR022Lj3x/Pt/L5vXvMF01yG+wqYQZthKOBdNjA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id 3V7vzW-TxMbh; Thu,  5 Nov 2026 19:02:03 +0100 (CET)
Received: from p14sgen5.netbird.selfhosted (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 05 Nov 2026 19:02:03 +0100 (CET)
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
Subject: Re: [PATCH net v3 10/14] net: pse-pd: keep the PI data until the PI regulators are gone
Date: Thu,  5 Nov 2026 19:02:00 +0100
Message-ID: <20261105180200.233479-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179387331728.488856.8945406807366704385@kernel.org>
References: <179387331728.488856.8945406807366704385@kernel.org>
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

On Thu, 05 Nov 2026 10:08:37 +0000, netdev-bot+sashiko@kernel.org wrote:
> Should the commit message say that this patch depends on two earlier
> patches in the series?

Yes. v4 says that it needs patches 7 and 8.

> pcdev itself is freed in the same teardown. Can any ordering of the PI
> array free close these paths? Would the existing pse_control objects have
> to be revoked in pse_controller_unregister(), or pcdev refcounted, before
> the consumer case is fixed?

No, this patch does not close them. A pse_control that outlives its
controller is an older and bigger problem, and this patch does not
change it. It needs its own fix in net-next, together with Kyle's rework
of the PSE regulators.

Carlo
