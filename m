Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.127.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439795;
	b=fNO3c6kQfiuWmxPY/TtGJwW8ahtviYGmiv86KSo87MbeyNx6Kz4SuqeAy8hv03Vysobs
	 E3s8SLeYrt5RNYxNqhBkh3gQ38iuxOR4dOtZ04ZZRc4sP+nmWxMARkjM6I6Z/ngthwzkU
	 3XhkwxTkiBUB4Iustzt3ldDFwrOuGnmNXFVHC1fq0lMM1G2s9Wb+4YTlawFOntwQ8umM4
	 /JQqbuB0N8yjUxxXkFPuBhZdJPcq+eExThxoAaXv3/EQyrvYwRzIYzIoJBJU8AKCrr4GR
	 g1VxzB4JbKk2KsGZ4FLm4qmzrzRS/MNcRyVmZJnWlU8UfiChedOoZwv+gixGIgShoLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439795;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=uoNcw3Nhn9Izkj42+MTfJqa2BYvBEr+4x7TkSyadd+Y=;
	b=mO4hL3M06Xc9DXk0PkGyjdrDWYlmnYwTM5j0ENbtvHMSDOl6RY2/L//46FcGS/6Mnlz4
	 SZrRrTn0fZpfux9FkqpJYeSF1UNgdnqEfvHVw4pSgA4lDmmXL3w9nyRdau3bV7HMyPIfQ
	 NqLU/GOGZHFjnFh1cUvPSz4jWR4NyqgdoTszLRLhIBr1V2hGj0xaSsZgqmRR/mykSqIbe
	 oQiBEleIiQ66jwiUEfJRu4/aDpFVjMYViesvLKHZPz7cEOKcBWA6nSepGFYEax5ro3C3t
	 bfEzRlTY3e7x4SeP8HtJZmmW05s0ER8ykxQxUJukKfTrDoLCpjFHrTqjPYVByHNatPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=szelinsky.de;
	spf=pass smtp.mailfrom=szelinsky.de;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=lJda8EfF;
	arc=none smtp.remote-ip=85.214.127.56
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547C760A383B;
	Mon, 19 Oct 2026 19:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 547C760A383B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=szelinsky.de header.i=@szelinsky.de header.a=rsa-sha256 header.s=mail header.b=lJda8EfF
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id E47EAE83AA4;
	Mon, 19 Oct 2026 21:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1792439793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uoNcw3Nhn9Izkj42+MTfJqa2BYvBEr+4x7TkSyadd+Y=;
	b=lJda8EfFZAhLGzBVJOOhhV8ZvUv9RyV2GzET4dnJ80YAsbjaKcaqdreUvuY1offrDos1l1
	QwJUA2NslGaSb+AYcxen8ys22eNtC8Qvu6824WftW7qMbMYA3/n9xyzAdTJc+27BBgYBnI
	8hVFLtkfRAC1iYqtBENV8BnTea+zmVzoRvo71PvwWYFtj5iP3hzPJHouiYvu01H1X/T/DA
	DGmZLfvhVlB1g2u4LvX0cGk+x4xfnlo/CJ4jySN+YlwubfDrgfma3WxUP4Hne3qY0RRukH
	232G9Oe00XbfcycFerzSw75W0sTCVy+or0kISg0EegTwt5mAiju0Epujykr3PA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id rzorLfoyTC4K; Mon, 19 Oct 2026 21:56:33 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Mon, 19 Oct 2026 21:56:32 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Ross Cawston <ross@r-sc.ca>
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 00/10] net: pse-pd: assorted lifetime and error-path fixes
Date: Mon, 19 Oct 2026 21:56:31 +0200
Message-ID: <20261019195631.308098-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261018233229.462-1-ross@r-sc.ca>
References: <20261018233229.462-1-ross@r-sc.ca>
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

On Sun, 18 Oct 2026 16:32:29 -0700, Ross Cawston wrote:
> It changes _pse_pi_disable(), pse_disable_pi_pol(), pse_pi_disable()
> and pse_set_config_isr(), none of which your series touches, so I don't
> expect the two to get in each other's way.

Hi Ross,

Right for this version: I checked, and your patch applies on top of
it. The next version will also change pse_pi_disable(), because it
takes in my older fix for the PI regulator ops during unregister. If
the two then overlap, I will rebase on yours, whichever is merged
first.

> Is a v6 of that planned once these fixes are in?

Yes. I will finish the poll and LED pieces as soon as these fixes are
done. Thanks for offering to test on the RTL8239 switch, I will Cc you.

Carlo
