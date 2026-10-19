Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439783;
	b=pwvcATv3IVaSkkAWWQRKcHbWYUhSg60+FAp2GlqHeZXTCNXG84uGTPODwO+Ar7rnswqE
	 a432/B7ujxpydDrtaAtqvg+T6dYBoGd/R6PYMtMHe13uYCEv9wgGFqkbOUwUm2Z0Y6/oi
	 B76cuG2YO1zTMQlF1CwBdoS1pnXfgf5gdnGNeIgZSLGwk1JTU7A8XyrZcPpAEKdN0aIR7
	 0f9+HSHrhJZ4qPlc+jUbSzi2eI+vTC8xlY8G62N52pc/p46XOjDEC6s/Z6zeRJVYVLwad
	 rWWOnJN2bmBG+O3MIT+BlRlRQgzKqfiKZHjZg2yu908/Nhm7yNib5oOEEpBoyrnQjhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=1bVzGkkVIuAB9Sp9dcdkqyIFj5RPtf9MftuzgbWTX94=;
	b=Mffy8Rj2jWWeRXyDM4PeUnybpSyvSSh0/6ZsTtCCFFV225MsmdBsmifSOI/Q4NezQt8U
	 RFgGwVr/VNPCaCo2krcDItc/mY6zGuL0ZVwjhhPJwlsFCeXH4br8gs5nKqcaRHTF2QC4F
	 wg2Te7D7a6qTzW4sYwQqzYEejA5vIYTiMY+d+WQ22zuTxKRbcygzJl21jRaAmUs8GVKsm
	 d/FpwAhizlsUjcIn5l/vJbgTvt6IeQSLWauoYCYBQvISsnft3IxHQC9g9XWIdF58EljUi
	 WPV7F/YnVg+Zny5m57NRhDIET0zExssJGQq1b4bGhk/3e1ixtc3y6nTN4D8jRLuOB9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=ZAaA193m;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258E60A2631;
	Mon, 19 Oct 2026 19:56:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5258E60A2631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=ZAaA193m
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id D17EAE83AA5;
	Mon, 19 Oct 2026 21:56:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1bVzGkkVIuAB9Sp9dcdkqyIFj5RPtf9MftuzgbWTX94=;
	b=ZAaA193mEsUKfAg6m2W7kgIOyyEkBVs9m3iAPpL0yMeVoBnT0kBB5nHevIoz/f2rC35GvN
	v3bsYH9Rg2A89DeAJi0deX08f4nBKjWOtLL1LiG/OnpwgC1943cMyANtxyo7/WkfF2Bxxy
	cITWzAbjHkzfzZclQTqKKwddhtT6cJdrNdX0MkCbQxuZrIHPEcV/3AP0sy7gXOS0kJZ5X3
	N2u5KMcKMMGatN2y52u4kMz7IiwmQ+xmqx004vWVoV6RhnhR5M0OI02jfmxVYC1zXsGzxY
	pfKgbQvLnM5VAPWfCylScl3nGECKTeNaDwPjVkkp4sdFn8oKjmKGqv4sYBW65g==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id KG_j7LmHt1hH; Mon, 19 Oct 2026 21:56:21 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:21 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: netdev-bot+sashiko@kernel.org
Cc: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	piotr.kubik@adtran.com,
	saikrishnag@marvell.com,
	horms@kernel.org,
	kyle.swenson@est.tech,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH net 04/10] net: pse-pd: do not reach a freed PHY from the notification worker
Date: Mon, 19 Oct 2026 21:56:19 +0200
Message-ID: <20261019195619.307990-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179239987207.3135.17141454695480717442@kernel.org>
References: <179239987207.3135.17141454695480717442@kernel.org>
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

On Mon, 19 Oct 2026 08:51:12 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Low]
> Could the comment say that it relies on attached_phydev being cleared in
> the shared-PI case?

Yes. I will add that to the comment in the next version.

> [Severity: High]
> This is a pre-existing issue and was not introduced by this patch. This
> patch relies on the pse_control_put() in phy_device_remove(). Does that
> call leave phydev->psec dangling?

Yes, an older bug, and it is not fixed in net. The PSE notifier
series for net-next fixes it: phy_device_remove() clears phydev->psec
under pse_phy_lock(), and the ethtool PSE handlers take the same lock,
so a request that is already running ends before the handle is
dropped.

Carlo
