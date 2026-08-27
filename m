Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3B44ADD8F;
	Thu, 27 Aug 2026 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853195; cv=none; b=cb4aONdF4PdUfCOtu42UH4CjjUEWpg1ezzUwFQy5/b4v0M5ON7JxZoIjQpWT1w8c/JL2qwFl7xCs1ZU/qQjOQfiEb2p24FwWBdE01HMUYwZYKA8batsdNNRdajk1Z94n1ASWb7BUxFIxdUnnquIA438q0XipTYzfQsHpcUB+kDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853195; c=relaxed/simple;
	bh=49PNsauquX8wMlouSPg41oQrEyzbn2o9ESy9LrutxnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EctuwzHSnslIABrSmocb2PqeFtn4uELJP/1cguLOJBFe36cpZ6mkHUCjd9Fl2YGzOHwYIzt+ynNgKwPSZJomU5NqbXphNpkNwCWy7AAUa+jublH2S2pcfgJlXwH8+t9H0I364r4h5MHlSCXVttpam7VoqDOngWf6+q+g7IKduVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IBuOm2+R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBuOm2+R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0931F00A3A;
	Thu, 27 Aug 2026 17:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787853194;
	bh=49PNsauquX8wMlouSPg41oQrEyzbn2o9ESy9LrutxnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IBuOm2+RVm3gN++lGHOOW+T6SvNEh9YGn5NjoND97UYf1JjSJYJy1WU7+M39wvF0c
	 mlPRSatDFWc6/2Lj+NB6Ersf8zaFSjk45NHCltx95lizUNBAsco6h2ctm6IgvN/FWW
	 wPeggda1opgBd3Wj4KZzkA8RRU+9zcBqSDvNfPoCKy0QRItyGseNvtz0nvd4QMMXjs
	 sgvpAXkOc02/jTfUUQyG3GICtOtXLoY5h19oaeI94NRqYkHfzzvrhGKgfEIYu8O5nE
	 hWZe1ldM0PrfAwzo8kpgg5+9sLxnG3iQe07BdhSFBIVD+F4aJiMU9J/ho7+mRibStK
	 U+F+47AOiuHBw==
Date: Thu, 27 Aug 2026 10:53:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jan Petrous
 <jan.petrous@oss.nxp.com>, Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Jose.Abreu@synopsys.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net 0/6] net: stmmac: More selftest related fixes
Message-ID: <20260827105312.34f58822@kernel.org>
In-Reply-To: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 16:04:52 +0200 Maxime Chevallier wrote:
> This series addresses some (but not all) issues found while running the
> ethtool selftest on various stmmac platforms. As a reminder, ethtool
> selftest are run with 'ethtool -t ethX', and for stmmac the goal is to test
> hardware features and bugs from the IP integration in the platform.

LGTM, please double check if any of the Clashiko complaints are
worthwhile, and if so - follow up:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826140500.616466-2-maxime.chevallier@bootlin.com
