Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792542005;
	b=bT0u6xTAcMMz2S/YeRwmT/M9ZtVDLPHUlBl4HTj1MCnxLT/YrXs5toNlssLF8CbdBJj0
	 pAY2Hy/fGOmBGT9PCt+s52DDblnVuKKkhGJENEkyBuHhoJ/THU/ri4UEZ09+atNSApC8P
	 4p5V0bWo+03z+3d+M8USrhR9QBF1LX0JRsmfOo74UY0EohQ3hlUV+Lde6HAgSisodHuJ4
	 PUcVlgyvTgjaBKucjqpak1MRSrgnz37nuAcZgzqghnrjnXxiSxyBzXgsTWQhVOYWAze0M
	 GCQvsLghiRTStIL3RhgdyKvtGIY/UxOfvfhotkIADhAKCAVDzqvhBTKKng0oHkYhGYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792542005;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kT24dhsJQKS+5te/5vxSp+DbgaW7i76ZlWgJKl3EXws=;
	b=p8gKpAw77y+4Pk5R6xwmqeirZpPnKQR4CIwYo86vkij/L+dStw18aZUUKcUQ/nVFm/pU
	 0GMSaw28G2xA8rZTQiCLe3dzGG6TWiBvgdr4x/ZVFtbirgD8i5ikmSB1D4KS9gksdXidf
	 4EizQ0T26xyS8SuOVPHfyf8I7UEJ2wvBIjvVtk5oiy2i+BA7yN9IBscp3R0RlQfDq+XFf
	 b8VoqNZE6LUIhbbPWiwLMG/2ni/wog+2NeLSUeVbw7hoFgNRCG1UX60fp1f/xZ6ben1Hw
	 rY/7YM9Q1PgSXXFUl6ZXfZ+vzNntgiZHIf2PMO+7kWp2kBolq22kurJ2FD7pov+6u4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrmnDnmz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D2606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 00:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrmnDnmz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017821F000C9;
	Wed, 21 Oct 2026 00:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792542005;
	bh=kT24dhsJQKS+5te/5vxSp+DbgaW7i76ZlWgJKl3EXws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HrmnDnmzbCcFtQP9ZBIzihBP4Jp1RdxMinspTggnJLKOMOSg7aUIR1Hf6aKhXw8pr
	 BB7i83p6V8L+l6xBBxt1tJmYNfBCj+YKgKCl7HR/2y3KEbeiFLChI9khXyw2xy0TdV
	 dErcLHtK2P5QcUL+UwntZFiX9FCZwPZpQGKjOhADkJ9YcqS9+LG0/Hg3Z+ACf3yYzg
	 HfrVGiF6MXHkjqySO26nd0Ad+xjhIMNlvsH3tODpZNcY6byoa4sJs8e2M2Vhlh0xBb
	 9opMYlGoBbU1Iz+SjQHysSW/HKsVteOfCmcp0/V2tdDfCNCP93DNj0CkAP6Z3IrDjq
	 I/G/QoffkYx0A==
Date: Tue, 20 Oct 2026 17:20:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zach Schneider <me@zachschneider.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 netdev@vger.kernel.org
Subject: Re: r8169: RTL8126A (XID 64a) TX packets lost with TSO enabled
Message-ID: <20261020172004.69c2d778@kernel.org>
In-Reply-To: <20261013230904.58717-1-me@zachschneider.com>
References: <20261013230904.58717-1-me@zachschneider.com>
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

On Tue, 13 Oct 2026 18:09:04 -0500 Zach Schneider wrote:
> For comparison, Realtek's out-of-tree r8126 10.018.00 driver ends up
> with TSO off by default on this setup: rtl8126_fix_features() clears
> NETIF_F_ALL_CSUM unless built with CONFIG_R8126_VLAN, so TSO is dropped
> too.

If this is VLAN related it could be due to recent regression in VLAN
handling.

Could you please test commit c2124f80be4ceb6e from net/main ?
