Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439781;
	b=FOtPfSJ7V9RW3ZYrQ7Nni3dy7HQeNao8g9IRdoSmqLSYsio8cdC7uEI2YRMSpXMVrPAm
	 m6TfxB8l+dvJ+BPtjqZA46V80klLJ4SUErbmiM6+6yYfu7+vi7g7POAFrgpdPOh3I6hax
	 oHzVVgsD9X0Vs53EH4XeclsfbxTQdfjOzEsTbmEcHJ78tR2t+ADB4ezzfgSPCEXHZbkCH
	 c/nL7VNVHCtU8/dDdiP2CEaM6hdQHU8i47mAqBpdD9dcFP4Q/HSFNdYPp6ZpGMxmS8lWB
	 F6Y63zupR1zwKJn/8LauNdUxUnYRjzMug+kwba3GjDHk9HAqiVX3ZcYSMA+XmoaOscg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439781;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=wBfbZ5ZD+4sqnmNPXqS0Pf4OpoYdm3bMyiWx/T1XVJs=;
	b=s0lZ5IAnf+j59u7zcuXBVN73PAOAnb6SyfSLKnE5j8rqGDxiew6bW9JDB67arkLsqhKT
	 wn3FEA+QZ7gpXlNnkpPEsl3qNBmLxTO3nZYwvSdDKYwZRgGoYzW1uCxiFgZji234hWCiK
	 qYe5lFsLAZnwlj5U3rcTuxTvd2z8hnXX2MPAspDoc0b+3gyqXV1k0KOP2bbBm2EABWfCy
	 eNQgP8fJxCQbaV82rrS9AceUHKhcYzmuRjB7xLRlOuO9ZETjy8JevNZUcCUeZm6Vjy39h
	 ZYDuXRxKQJ/Y9v8UzouWPLZ5h9572jqEzpq8btah+WCaty1e5N741/X/hS+uOV45H9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=S3hooIRy;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FE606A324;
	Mon, 19 Oct 2026 19:56:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F5FE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=S3hooIRy
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id A3189E83AA4;
	Mon, 19 Oct 2026 21:56:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBfbZ5ZD+4sqnmNPXqS0Pf4OpoYdm3bMyiWx/T1XVJs=;
	b=S3hooIRypOy8Qt4llsl4EZc7c/X9gWRj/ZcdmHKuzdAuBP90i9WlFAkpOxEAWJnqbXEWpS
	1XVpN1If/NU4aKVXIWIXzMueUmF1F2IosqRIGnWAEbILWipiVtbWo3WJz94HFqy5qCqS9O
	PuQW8MM94ANhbpDdHRxjYD/n1x9OD3hUeMmVd9vXSI3UxAisGLcTO77STrTd7yfMXSAzA7
	75L+CVCuYpoduxn6Ej+Byn3fG3wP7lMRXJenOUJoX2xJHLogwpc/dYAP8X+5NaRdK7pEwt
	6i7RgI4QM+9GMmmlFbZDy85TgOdGSXpFSVXhr48too/NmDeIOjzCjS2hdoWtJg==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id qxfSNGlZcpcJ; Mon, 19 Oct 2026 21:56:19 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:19 +0200 (CEST)
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
Subject: Re: [PATCH net 02/10] net: pse-pd: fix module refcount leak in pse_control_get_internal()
Date: Mon, 19 Oct 2026 21:56:17 +0200
Message-ID: <20261019195617.307960-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179239987068.3135.2768821007598612150@kernel.org>
References: <179239987068.3135.2768821007598612150@kernel.org>
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

On Mon, 19 Oct 2026 08:51:10 +0000, netdev-bot+sashiko@kernel.org wrote:
> Could the commit message say that the first branch is a defensive check
> and cannot be reached today?

Right, it cannot be reached. As Kory asked, the next version removes
that check in a patch before this one, so this patch only fixes the
pse_pi_is_hw_enabled() path, and its commit message says only that.

Carlo
