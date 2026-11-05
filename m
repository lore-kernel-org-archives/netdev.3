Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901717;
	b=wNY2y9gvqSbzOa9D6iBnx+eybA+UqHVubILzSzQXX+KJy2A03Q1TEu+zQq91HsKHdt5A
	 bqU6J0Sg/4w3zEsdv2rZSg6jxJsztdSZ/S7y0tfXvsWKamHFUGpl/ekQBuWo/UtgP8mrX
	 f3fnz3k5lUJn+meN1YZLQMwJRaIpEiGsVq/3AjTJe5h3jVCuGB8+GGeU4Xg7t7ad/Ve3g
	 pxQvNnQeTb28BAnb7A3fZGeTQpffAtBaYW8euzFer6+ArgwsM3dqdBwXGBByL4fYfPcak
	 yOMGXVP/mfW3+AAA/Xzc8Sem+5BkRScGZUEHq+DPC+YUZKFGYlr+f1Cnb9/o5A1mWNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=XRCSXklmvc1dWEYUzb6atLKgSJiBFRSmBAFbmXYYn8c=;
	b=NVN+gI/YYw6n7e+IbjNd6RKQ3RH+S+zIDMrxzeJXANo1Fc6Rgf3S1Q1RhZx2UQ3W8u5v
	 2wuBB9vK7t9hRB8ccmak2GRseUk5ARr0YGsqjAj6UFz+KoImeY4a61pG5jcoBrt+P2TfS
	 PSVVSgBx+ryDtNhqD/Tmw2megYGOEiqGknYGn+zuBgrJv9lvTRK370WBiC3/ccRzz+7WF
	 hSMNxhbr7pDFMnvjFOafMQLQ6/D43y2WdRJMjW9zOK8avopsTB6d7wRjGhAGY0FAsd23l
	 /gcTTizCp6RjSIRu9XUkt9sgN27VZx21xw6bC+H/6Wfa9JonL5mbh4sBIy/i1V3jsQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=ddW8XJf7;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79E606A336;
	Thu,  5 Nov 2026 18:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C79E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=ddW8XJf7
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id C2381E8366E;
	Thu, 05 Nov 2026 19:01:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1793901709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XRCSXklmvc1dWEYUzb6atLKgSJiBFRSmBAFbmXYYn8c=;
	b=ddW8XJf7kDov9pEKU/fdHb1hbvVXLKk57QRL+lscAH4ID4yTMdm+u0vAjvW8ugasKPKnAX
	kjwBXxOeLEJ3AWnlx/qiTsAtXq7ky5ecioHQzW0mcCaIQf46cPX3nVQiGcsqDgaS58182N
	M2WbMwb0gUrGost87oQV15j7ZhrB7zKzAdAZgqBXcKMAkt/HMRQyOX5Hoi0yBDXcsAVRK5
	CV4zHz7OAvr6peb3/CTPTSiUzNdhQh6qzRLVthVNjyYDYgSsiAIyeIyDhzgBd56pzbI77Y
	jUFlKkhjUxGf1zLLCsso5XznU26DgReopRZedPbOcFtBC0uiOi4K9aSJKyoU6g==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id E-uieR51W0ag; Thu,  5 Nov 2026 19:01:49 +0100 (CET)
Received: from p14sgen5.netbird.selfhosted (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 05 Nov 2026 19:01:49 +0100 (CET)
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
Subject: Re: [PATCH net v3 06/14] net: pse-pd: check the PI state under the lock when setting a power limit
Date: Thu,  5 Nov 2026 19:01:45 +0100
Message-ID: <20261105180146.233418-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179387331403.488856.16797302256454828469@kernel.org>
References: <179387331403.488856.16797302256454828469@kernel.org>
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

On Thu, 05 Nov 2026 10:08:34 +0000, netdev-bot+sashiko@kernel.org wrote:
> Does this check tell whether the PI is actually powered? Both flags can be
> set while the port is off and pw_allocated_mW is 0, and no race is needed
> to get there.

No, and it did not before this patch either. The patch only moves the
same check under the lock. That fixes the race in the commit message:
a disconnect clears isr_pd_detected, and the check now sees it.

The pending and shed cases need their own fix. Kory and Oleksij do not
want set_pw_limit to skip a pending PI, so it is not a one-line change.
I keep it out of this series.

> Is previous_pw_allocated still valid when the rollback runs?

> This is a pre-existing issue, but the return value of the rollback
> pse_pi_update_pw_budget() call is ignored.

> This isn't a bug introduced by this patch, but the budget update and the
> hardware limit write still happen in separate pcdev->lock sections.

All three come from the same thing: the budget update and the hardware
limit write run in two lock sections. That was already the case before
this patch. The real fix is to do both under one lock, as Oleksij
suggested, and that needs a different structure. I leave it for a
follow-up.

Carlo
