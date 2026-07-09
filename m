Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6AC37AA75;
	Thu,  9 Jul 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610047; cv=none; b=YfZH8OGo7IGAEYVpZVFz3yQXjc+opCeTOAaBX7ep/7TxgKQ7J6i4c4UQWoKcvwbZdGpKyWI+ZbNYowZ1iVB8Ukmy9Dr0+OoSF3RZ7ftwoSEINOjZJ8jm7TUWRgyVe67QcF4QvPNhlVF6ucU+hDC+u082928GZCJyVVjIZbAsIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610047; c=relaxed/simple;
	bh=V+Y/Ia7EB/rEsGbV3rfH3YzzgfJyOaz9H6MIWhW7Ff0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ab+Z8md6zTPgzD1tp69QLpq5zHQMPdaq6GE1uzEb17tStl97yBoCbrz7ddOqW80M6+esthpcPEUGdOlguDWbaVXHicVNCvRtGBjd3U52yWhs/D8eVvjXFYtaCHIbAeALQNivMYtzHfigFBG7Yme05eicahII+DT2QHfQJc846sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSm5/7Ra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSm5/7Ra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AC31F000E9;
	Thu,  9 Jul 2026 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783610045;
	bh=lhmS+AR5+X10IihQPhnmO4cEQkiEqWD7tin21pzPQbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZSm5/7RaBEag2R79eSf+BS9/50sX31hbfaMmV4QYb4Y34gMV+prmHmJIf3mSGr4Ku
	 DiHpwRD3vO1nSmBS7Io7ZYCzWPmB4HcFMqvieBEuexIdwv1mnltTeBE8c8y12SsJWj
	 HOv7cST5UoxJTBSarK5Ygnq4xzqx3s9+fk6GYWtLgh7rzhfrlIyzIq9AW2r0IFF+NC
	 ANJ81J2SL5Wupi83w+0fXlW5yN85zfHilYL3biO2MSnn4cahN6hK/Ct1gVW2Fji7q8
	 nUntX4GYYCv995ioBjKEKvkEbsr6ksPwTwHzxJRsW7p1l3FJ1M6vQlA8kijV2+JJmF
	 A9NBYW/sP04eQ==
Date: Thu, 9 Jul 2026 16:14:01 +0100
From: Simon Horman <horms@kernel.org>
To: Bence Csokas <bence.csokas@arm.com>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wanxl: Remove pci_map_single_debug()
Message-ID: <20260709151401.GO1364329@horms.kernel.org>
References: <20260703-wanxl-cleanup-v1-1-d5deb23fa941@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-wanxl-cleanup-v1-1-d5deb23fa941@arm.com>

On Fri, Jul 03, 2026 at 10:21:42AM +0200, Bence Csokas wrote:
> Since commit 24dd377a76b0 ("wan: wanxl: switch from 'pci_' to 'dma_' API")
> this has been dead code anyways. The pci_map_single() function it attempts
> to redefine has been removed in 7968778914e5 ("PCI: Remove the deprecated
> "pci-dma-compat.h" API").
> 
> Signed-off-by: Bence Csokas <bence.csokas@arm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

