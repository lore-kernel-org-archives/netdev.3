Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24420175A8A;
	Thu, 24 Sep 2026 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790212669; cv=none; b=VvZk5f8Yh1ldrmYRjsHm+ESdHLEgIqneppqTm81R2hALbceyBqY+y87+PKsr+Pi54BoeBPbvIwU/Fp+kjv2JUMQlNcDjq5wK2HnU1XtBFG1Piz/TwFTUBnZxgQzNyo3NxRb/hdu97tC1/6OYnYcHz4TruW+y6s5ZdZi6zditx0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790212669; c=relaxed/simple;
	bh=SLsOeE6Ka1724pbnGrfEVJxC3T52flvCkiZvh2sA6VU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2HkOGGWA5bXGvTSgAWnAX9hK4mWUs5QIdhbKTp/QT/X+F2K1dKGohA/zqvKgzuV7E2A3BWDCG6nnI8lzkitK5haqNuLHnhI1/zXdl/XIw0R6R05kioDtVEmOGhvlgWnihFtdSGz3K9qYNsKZ/84uW8pwfS9ks2+PfYK3/TNmI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkXhNbT9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkXhNbT9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE1A1F000FF;
	Thu, 24 Sep 2026 01:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790212667;
	bh=hxHiUbfsf5c+GWemUKjp3aUVwBjDaOzLwtzJymo0Vlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kkXhNbT99Pck9PTJ/6N6g8iwjKW0cI2xsRr4qJvjb+rdNsO1jhyA4WS+gfbPjJjtt
	 aOM5DmsWKP/biyxh+u2fDOYxXRb+EMLvDs7CBFF3kD3DJ4COUDaDkGhjjC1GRJ9DoY
	 QWxhEmeZq7vkAV69LW4Fm+PcKf+dCdruv2cLi2yTJN9sl1FGpBFwjQIYyoWEO1C8jp
	 hpP4a3aUVJgWZ0rCCuIkX+PSp/EUzK7be3CSVkSKWK2+0ScKFnGuRCErlZ0V449vGv
	 EOZhnPsMmUMScqmkSSDzfXU+NKh61Yo0/99s44VuAhST753tLBTGNacz0x7IhSB+Px
	 iN5xjEKAkae6w==
Date: Wed, 23 Sep 2026 18:17:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zijin Tao <taozj888@163.com>
Cc: linux-kernel@vger.kernel.org, theo.lebrun@bootlin.com,
 conor.dooley@microchip.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH] net: macb: rate limit netdev error info print in the
 data path
Message-ID: <20260923181733.1af289cf@kernel.org>
In-Reply-To: <20260920100920.65773-1-taozj888@163.com>
References: <20260920100920.65773-1-taozj888@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 18:09:20 +0800 Zijin Tao wrote:
> Now the MACB ethernet driver print the netdev error information
> directly by netdev_err(), which would lead to a large number of
> error information print if there was a significant number of
> error or just jumbo packets exceeding the MTU received when booting.
> For example, it would print a large number of:
> 
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> macb PHYT0036:00 eth0: not whole frame pointed by descriptor
> ...

Do you have the HW or you're acting based on LLM output?
If the latter, and since you can't follow the process please
don't post any more such patches.

If you do have the HW to test this - put into the commit message
what HW you have, and covering all the cases.
-- 
pw-bot: cr
