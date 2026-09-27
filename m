Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985722E5B02;
	Sun, 27 Sep 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790548904; cv=none; b=uZRrt8vm4+siaaex+KnORcg+a5g9UXMSURBYf48KfaYO9i/mKthSQc9cKDl6/O1mPXlNd7Efuuhjhn800bBoqps7XVD0j3BvrwRslU9nqPBzA7JAODRrI/UD4ZgARLI3iO7kj/ApiQ0IQD3yrTunMfm64DH/gdnchOgEuOCteyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790548904; c=relaxed/simple;
	bh=cFe2dJpgBcjSBEKXS1viJw3emq9MtXGDjIo5k2iOQjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBakUqrO/iZ83w45uPzYkMYqNRfkjKmKwdKsHodSgzczwgMBMClyiVx/nBroLNAzR6E7M1B/sni6lBs4NIoEtkRL37MxQg+WRA3Di6E4JI2yyOCedgWXvNvQXVtQzf4+DiGN4L6orEABf1i40dmqi5AwgTENjEXVSZRMKqs9blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ou9CnBwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ou9CnBwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BCF1F00893;
	Sun, 27 Sep 2026 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790548903;
	bh=cFe2dJpgBcjSBEKXS1viJw3emq9MtXGDjIo5k2iOQjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ou9CnBwt1UZIjlcuX4infY08+2W2m23na3UWhspILkBkgY86GMp85ViWBtD20M76J
	 MrAWL5xAXnGTJbhFXuON8+DS2ZMAirax+V9KbkchTV9HbR887n9Dh3KCuEHQ4CMghv
	 zSMvEdUzDWsysRfk+btZso87qG3VM1dUhAvrkGjyaOoHWpQ5eH0AAeX5bBeSQlGi99
	 h0xXH+sHxK7IztIOInpLBeepPTYAD+MCGA9UO331ioo9r2+gfpNdO9OIKTCNi5AjQI
	 Wi3545qgdM17hCbAOks7gl5whw92QlBHtvxYcj1d9tvXLXrAzcu+8/xwFqK/YP62tX
	 A8Kpea5ghvj5g==
Date: Sun, 27 Sep 2026 15:41:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, Kuniyuki Iwashima
 <kuniyu@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 thomas.petazzoni@bootlin.com, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: keep the NAPI_DISABLE flag while napi is
 disabled
Message-ID: <20260927154142.656700c6@kernel.org>
In-Reply-To: <20260926194714.648819-1-maxime.chevallier@bootlin.com>
References: <20260926194714.648819-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 21:47:13 +0200 Maxime Chevallier wrote:
> This seems to be more general than stmmac though, there are lots of
> drivers that create the napi instances in .probe(), so they still live
> outside of .open()/.close(). It was verified by running the following on
> an mvneta board :

Not sure this works, you assume ownership if DISABLE is set but we set
it to start the shutdown, not once we stopped the poller.

We've been tempted to "fix" this multiple times. I'd prefer to fix
drivers.
