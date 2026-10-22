Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682950;
	b=DfzQGdmUkgb1+JZXxvQG00aY+2N3YzFaBmRcRB/I/lr4EW1c/Ra68bW14MyvDOwVY6KZ
	 HSNmNdOITKb1GeIX0dy394vyPhvsM9eQl/gnokoM/CIALRmD01RjTNqaSxuEsXnXOWb9x
	 8koQNlXema9EWSdzYxUJT992kspsG2B1N8b9OGYX5YqTmBhJS+QCtSb1SfmzqL6tyaZSe
	 snn/7isj3eXlvl2ybFNrhIrkjuTAvvpNBj1OzRWd279Vug9JYtcDF2MDzzrw6WbfKtc7g
	 oMikxKMTo9ZFSCr6BoivE3VFr9/1lLjYiv6UQ8BOpZ/5HEH8jpBuL+WinSLfNUf+9vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682950;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=P14smC1/+z2W+JWOEuuUE0ezGGrEUtQSP3dGqU1E/Os=;
	b=LFMd6u/PVce21dbXeBw6LwS4EcyjgLhtQhzd2YXbzIy6+UOErAL2/riubdRVzwCJes65
	 JxPzERvZOz9cFyKl75LcXOpyn69JnxlOzo/dG0CCZTVq7WKxskhLYzfG2YxfIUg1WJh1i
	 0b2HhBohM05Nd7apPZk7lr/O+BMS1B9pT9KeRF68OEw7YZONN+44hnE1oYwNQEZtuJRkR
	 aGiPz0NaCcY3BNqyeQ8oRRlkpL7wj1lc98aUsXvE7FfWhIB9NHaYyjItt1bIVKNOh6nOn
	 LGVyTIxFSmLgNOzDbZORjvOWqbxra0WR7u1H11u45lln6UXkoL1RCCc9dm9Zc+BHkyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKCfEwNO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8404606A31A;
	Thu, 22 Oct 2026 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dKCfEwNO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284961F01828;
	Thu, 22 Oct 2026 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682949;
	bh=P14smC1/+z2W+JWOEuuUE0ezGGrEUtQSP3dGqU1E/Os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dKCfEwNOtXwx7hp8DSra4CzrDgs+hmaYNiop2wLM5jIRPwBu7hU4k6EUgXs52k58K
	 RTT0uemsr5ai1tk/KYBJEzPyyHrfNy28VCrv/plGw8Dx8i+C5n99fgQU0GaA4cquLY
	 tCTRGIQ/TMOdaNMneCuPx/98VtQTPnxOLQhpl9p9fPC55Ne4XCG62rze31MDlmJzA3
	 o7zYwCd/YHdYqFLoA/2Qw4CNQ9g9+r5jsViSAA0idBpy3ZYHwVmu77/uKDeUIkBGLb
	 muwH7BWUeJwKX/138AzIUnO3GGdx+Uhc3m37pVRTAMjxcNey7TKWcLKHPT7rqNV7LS
	 4KHKxFSPvuIrg==
Date: Thu, 22 Oct 2026 08:29:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>, Andrew
 Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Russell King
 <linux@armlinux.org.uk>, Jon Mason <jon.mason@broadcom.com>, Arnd Bergmann
 <arnd@arndb.de>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps
 link speed
Message-ID: <20261022082908.5bc9f6d6@kernel.org>
In-Reply-To: <20261021191035.751684-2-florian.fainelli@broadcom.com>
References: <20261021191035.751684-1-florian.fainelli@broadcom.com>
	<20261021191035.751684-2-florian.fainelli@broadcom.com>
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

On Wed, 21 Oct 2026 12:10:34 -0700 Florian Fainelli wrote:
> Subject: [PATCH net 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps link speed

Does not apply & not correctly threaded
