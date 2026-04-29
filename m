Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ACF23C50A;
	Wed, 29 Apr 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777425829; cv=none; b=WGiVIX/vG7D1LxxgIrV/pBhbZja2+rwA6oHEbsaWb862yTJ/WlObSM0hXfaL+FqHukkbrIwzc3224SQbpd44iL4/kDLKliDzYrQ/bafDwmCB09ltU/vY9GiWxsZwEojAf8IGBkvJXQOHwSLlhcQP+EGI29I9yASojGaRVrDBOAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777425829; c=relaxed/simple;
	bh=mOOtcFT1oS04KAQythao6QCgqd5THVuMaW2TqiKfM94=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BIc9SD/qe4vBemHuBrFZdXft2FrONPJ/onvxH1Vqo5bLLFuUHbJd/zsoV904N/b3UoO0mped0nEm/FxyRo54yig+w+A0M5M9H76pRu+pB43Ibe9plrUZinfNQV+pNZUaa+Rp+PJLRB8jL11UROfOfGPMvnrScZmfd8MZYUiRTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TheJGKzT; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TheJGKzT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1777425819;
	bh=OdLG3ayENa/HzNtzBdQjmFh/1hrGoIPS/OYpFwidxDM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TheJGKzT+s2FRNlbVVH3FmsFTa/TPOOggq71jD1qWvIEagVM6egJjLGr0yAx7zmi6
	 EXCIONyVMDjDsc24Q1xx9XA8u2s4gJKrc4tzCEUC17I0CcIvgWvsFPgQLE3mXXaTbY
	 nlKjJvh2ucFPtYJLiQRTBShXTwh743cBFjm0aLu10qz2+eJSC7LPsj/0owhBWxCRcw
	 bC0jhM7oEBWKgTcEw6vQa/2iHl42DO4sGVu4QrDsdt9ENkAcxKoVJaMbK+CujuB5X7
	 SVRcC4eDU5DLin10TyLtOeu9vfWriclOIh+cvrf5layeKHeOhLsCvTiHSmKvaYu8OD
	 GwEAohsr8/V1g==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B3BAA600F2;
	Wed, 29 Apr 2026 09:23:37 +0800 (AWST)
Message-ID: <bd8704fe0bd53e278add5cde4873256656623e2e.camel@codeconstruct.com.au>
Subject: Re: [PATCH net v2] net: mctp i2c: check length before marking flow
 active
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: "William A.Kennington III" <william@wkennington.com>, pabeni@redhat.com
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, wsa@kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Wed, 29 Apr 2026 09:23:37 +0800
In-Reply-To: <177737520480.421689.2467854297040801595.git-patchwork-notify@kernel.org>
References: <20260423074741.201460-1-william@wkennington.com>
	 <177737520480.421689.2467854297040801595.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Pablo,

> Here is the summary with links:
> =C2=A0 - [net,v2] net: mctp i2c: check length before marking flow active
> =C2=A0=C2=A0=C2=A0 https://git.kernel.org/netdev/net/c/4ca07b9239bd
>=20
> You are awesome, thank you!

4ca07b9239bd seems to have acquired an unrelated change:

   $ git show 4ca07b9239bd | diffstat
    drivers/net/mctp/mctp-i2c.c |    4 ++--
    net/sched/cls_flower.c      |    4 +++-
    2 files changed, 5 insertions(+), 3 deletions(-)

While the commit structure is probably not intentional, are the Flower
changes acceptable for the net tree?

Cheers,


Jeremy
