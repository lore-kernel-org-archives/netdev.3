Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546195;
	b=hb0ow8bygYyj7erTnouuQ8YgMzH3L/yxWi5CbT+71rooSjxFVvQvrMKrRrmuGIvAMXYS
	 x6T93nDm136FMQNf+Sp9ikzgKjfDj3jUTzBk19PmIBb2WGWj6eFQf6dSFYIkVN6r69Ne5
	 ya+nDvsuF34/RrYM9TOZijxdKGdK6GhffH0ig1sxGrWVa39+0Bkt8/yVUd47F3O33pHpX
	 TEC77SnqTBb1wwVb/uCLWCxBzac3r2YObEmmdPB4luo9opI/VePwWRmxo778XhOAkBvci
	 bZb6V5pvrhIvyMrTjffDhkd/q/G10eQZBOhbkW1UhECoZpF6ar8VdH4NQrAcnwTnl0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546195;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KZzJxPvWOpazC3XHnU+iFcOAPHLfI64CvA46Z0aosIk=;
	b=Ylz8g8iAjtvO5lpsNfgQJAlnVdyKmUyuiwSSq4UXLktad2TwyfTjeUQ5dgwuI2Gs/MmT
	 sKwh6/qqW/7p6Ol6zylCFLqCIhP4ENmlnT1gNFXX2R0XjKQeqJNZyfMzZsADqEzV3cran
	 24IRcEn25y3uf7nBS2puJp+6HkhYq18075i00E9/QUEB/2qaF2VpZuG1ARCg48QghIZCq
	 hZUMkFplKdpn+yta+vmoJ9kURlyERXbPM52nevPn/4OgHyUHxlU4hLMCTHGC7LebbBk++
	 uBR6bLR8tf3HTolrBX32kt7hS6aDv3QL4uFwSOM4lhzTpJwCG59gWFCjsBEwafUVWVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbuOtfpb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B1606A319;
	Wed, 21 Oct 2026 01:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbuOtfpb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 387131F000C9;
	Wed, 21 Oct 2026 01:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792546194;
	bh=KZzJxPvWOpazC3XHnU+iFcOAPHLfI64CvA46Z0aosIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NbuOtfpbt/ObL+20tpFP5BzYZTstfiX4KdWy5IWfH+YpbHGMO0sAaxberP/+wUkPI
	 YfUcHYUBR/sOAmIvr8DweW37mU051wuqoFQON6nENliZuoR+JnLcO3HQlGPesUwgGJ
	 PxndraVZnC9l2uohLEEpFB7bYSfD3wXStLCxJLJ5/3+pO93BAChDgB/G7eWoklwNWp
	 TTlQocaNJCvJUEjJM2swVa20Z+ylOuY5vRvjMABFPmEEpP/x1m2kk6dPGGVu4Jp8qG
	 zYZ04pdKrXg3RtIVOHqd4rKsCJPty/nYMg5PT6Aenlt4LVWsZ24TTlEjZGecgKE9xc
	 WEoC/9pSUJC2w==
Date: Tue, 20 Oct 2026 18:29:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Eric
 Dumazet <edumazet@kernel.org>, "Heiner Kallweit" <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4 0/7] net: ftgmac100: Add AST2700 support
Message-ID: <20261020182953.37b766a7@kernel.org>
In-Reply-To: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
References: <20261020-support_ast2700-v4-0-4d36b40939b3@aspeedtech.com>
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

On Tue, 20 Oct 2026 19:34:11 +0800 Jacky Chou wrote:
> Add the pieces needed for the FTGMAC100 driver to run on Aspeed AST2700
> systems.
> 
> AST2700 keeps using the FTGMAC100 MAC IP, but the enablement is not
> limited to a new compatible string. The SoC can boot with the MAC on
> ARM64, needs the Aspeed-specific RMII mode bit programmed when a port is
> wired for RMII, and requires the driver to use the upper DMA address
> fields in the ring base registers and packet descriptors. Those fields
> expose a 35-bit DMA address range on AST2700, so the driver must request
> a mask that matches the address bits the hardware can encode.

## Form letter - net-next-closed

The merge window for Linux v7.4 has begun, and the net-next
tree is now closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens. There is some uncertainty
about how long this merge window will last, so please check
https://netdev.bots.linux.dev/net-next.html
before reposting. net-next _may_ reopen on Nov 2nd.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

