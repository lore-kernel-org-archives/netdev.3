Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057639;
	b=miMDahqawaiJyFsJPv4gf2goUwvhu7NX+oMNkNmSeaLERf08nly6gdq07IbNLZ5vFseb
	 Q29BgNcASsaPi9VIqbuf/So89HBERbJWC7aP+ZESe9uT2X2P64YjpoT9p1eppWMmdiZaE
	 dUoYFDB04+ZDEXu8PYA5B2rzU7ih8fRZrXKgBGeO7FqFPxbagjJpZA9NhP8y5sRQEhFBv
	 FNN0KH/HXoHqfK92KGQnDqdDxl3WA2DBBDB9LW3agJ3/KeJj1muvHUdkX2rCQjhvzD91x
	 ZmZg7vbs0PuibkPnvo2LlAzmqxL4IFr6W+b4r39O3VsxG3fh+dZdlwhId1ZQcGyIi3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057639;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=daP6GwsRM9DByuR5xTLfMIYYnF/wV/XvrTIz+Eg7eJ0=;
	b=wpFcIBEiP4pWELiIVlAPZX8m9nyCQTzohPghJryUq3KbM858Z1UH/prLm8Ea7wEYa43n
	 LGuyRUAQCgKw3eYqU21AKVxeEb17g+ddtk6we8klpErnY4MbrYDbietvzOKuNvB6tbEt4
	 NNJGIvky+FzEVoYXnP5ZPKY7p4aRJTUgRhEGpZ3FTCsEatjiQnCc1eNfVgMKzkntjZTwt
	 DIp0aNE0UKMnwDU5irnm6j1IbYG6Ygb6qPOrDCoi38kzHp/MKMo7xK5nAU8PfCr6EAmu2
	 Oo60gZD9q2wGRHB3I5JCUFULbv7K4IkmUjX9BCnuGQ3iP1Ica0XHQl560AdX78HTR5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDUN4QUB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CAE606A31D;
	Mon, 26 Oct 2026 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HDUN4QUB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B891F01825;
	Mon, 26 Oct 2026 23:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057638;
	bh=daP6GwsRM9DByuR5xTLfMIYYnF/wV/XvrTIz+Eg7eJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HDUN4QUBXLiS13EHvgIM04q1mhOpLKbV0FZqTXhXVZTtqZZM0Z6Y7e43kXv2xSWGQ
	 etxWIv+D8AwDnDJBH9llN3Sb/ntvEOhPNqU/GtVRgm2j0GSlEQczvQ01vFG4scoPB7
	 brgq8QA08G7L1miCBwje1eJe8aZh+T8Lbm1rIBVgWJqJhU0fcwgbSFSPIN0iNZxEk0
	 vaf4sFyo3rWJ8kRmAO/RLyTkYy3XPzCqc1cCADSMUtm86kwrQM6X/XLu/5iFSwpvr5
	 0oSeQ7uZv8cfaI8JzhZWf6ebnZdKK2vDWgBOqUHmWKhNa6ZCLAbxgTXZeUWNXCnbRF
	 NZgriV7l3SRtw==
Date: Mon, 26 Oct 2026 16:33:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Kuniyuki Iwashima
 <kuniyu@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 thomas.petazzoni@bootlin.com, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: Use a dedicated flag to track disabled napi
 instances
Message-ID: <20261026163357.5d1bdb29@kernel.org>
In-Reply-To: <20261022075757.1164283-1-maxime.chevallier@bootlin.com>
References: <20261022075757.1164283-1-maxime.chevallier@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 09:57:57 +0200 Maxime Chevallier wrote:
> Trying to disable the napi threaded state while the napi instance is
> disabled will hang forever in napi_stop_kthread(), as it waits for
> NAPIF_STATE_SCHED_THREADED to clear.

does not apply
