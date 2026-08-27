Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C7B3914ED;
	Thu, 27 Aug 2026 20:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787863212; cv=none; b=qvKDH2rAnpyGZKBXn+2ds+lOaIXeJXGnuEGJ+PxE6fvkhqcmVAZbeSC+gocd/wSfAHroyl7ph2ByPf+Xtf9xu95mephFr5ARwChHX5n/pUig5lmTWLHecWtL7FjuxTm+SPTJcAW21icVWpuygjjpBQmvP2Pk/8vEgEFMbP8CW4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787863212; c=relaxed/simple;
	bh=gJYAIMEVJz+yW04sHbC+x6poPPKdkOrpT40M7nAfvO0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKnl+UE5pz9lUbO1fc111g3yMBnuHMHf2cV9wPeiaxOTVOm1CPWtr0zD/3MrQ7ysL2xSMkgg4MXu7BQyumHMccC4Eyf0dBltK6KkEJ3LhdtdqRGgxBhe8npPO3dY6R78M2uDPbCxRv+F2Q+ZwVbql/SmXvTqALs7nlwE6W1ZTyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDIx0HST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDIx0HST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2CD1F000E9;
	Thu, 27 Aug 2026 20:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787863205;
	bh=gJYAIMEVJz+yW04sHbC+x6poPPKdkOrpT40M7nAfvO0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hDIx0HSTZn5+n8AyY8RtGNrP0jx08HYrijnX172FcdXu1N9kIsX5vmfZ30QdR1XOR
	 aeA/ndyYcWs5VYTfuKOlMayCm7+5wZ2fhN3X8bAgpDpnANvl6r6GpBJXwEuI0TaWDg
	 h8H+wQiGmXAZUP69YJW8e+4zZcdVgkLunwJq3/Z/MqllXgsgYLJ9Cc2Xz40t1eH/VY
	 CA96NPrWkXW2xQ5xt8f/fPGTUS7wBlMmhKDfUOUt6mD0EMh/YTz4l0OpFAzas7EBxS
	 i2pVI+OeLWGYdRcK1k6uqv3lnGk0lD4aliurLbMQYOTkCTK2T2JPz8G552qS7Okrqb
	 c03mohZFs6ZsA==
Date: Thu, 27 Aug 2026 13:40:04 -0700
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
Message-ID: <20260827134004.45ffb57e@kernel.org>
In-Reply-To: <5ad6cfc0-94df-4528-b2af-8a190c1eee7a@bootlin.com>
References: <20260826140500.616466-1-maxime.chevallier@bootlin.com>
	<20260827105312.34f58822@kernel.org>
	<5ad6cfc0-94df-4528-b2af-8a190c1eee7a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 22:16:18 +0200 Maxime Chevallier wrote:
> The main thing AI points points about the UC filter is "but won't we hit UC
> promisc sooner ?" and the answer is yes absolutely, but it's the right thing
> to do.

Indeed, that false-positive one was very disappointing to see :/
High severity when it's obviously the intent of the patch.
Or maybe the AI knows something we don't know :D
