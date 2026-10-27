Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793066286;
	b=1P64LrZs+9Wo/GdfccJPl0pszmEr4HfqI4b0eea2m5TyeYPlfgITxk4IJfhGsbP4Pczw
	 Puhokn8D67QeNUz1XNCqizQQ3o2K1Zdzbl0ff4tW7r6sBnXSayQIcF3TjooUKGem8dw9c
	 r/GR7NEGQ6PI7W1Z8VhdBnTALO82p2CN0o/5QZP0JZ1c9btOOb7iUCOrK46XNuQjnIfXJ
	 iF9FBFWamw68mDSqlX9WL1GUdqDe7hXvJo/gaIe9J0PFD3KY2YLsw5/+Npn1AtTBkUnZY
	 SxUKp+z/pK9Em1O5OeoLQWoYttpKhK41iHcUWxJARUVwHc2ldln5vsWype6KdWoSyqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793066286;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XBh+jeGWrVrdbr6WBz3wJMEAmK/99nIJkgC+bD2BzG0=;
	b=QCWQBa+ZesGK8FiImQT7tReepxsihBImOZs6AzT7i3xJe2xnk8NYgvYDjrcm1T4n58sp
	 7Zbtd5u/dcOcaT/0reiktrEkm6kKvww6vzV11zb4pyrWhsZNsIjMMVF+u2yVU6O/hU9fI
	 OBuyCnsxBq71sup16XzgaIZlbdexx6eaNAxty7BlZgcTlBA/L9jjmITiig7txJm4C20s9
	 o/47Vu5uxX57+A/VVvAkUCuPXWnwcn92MpM9RxC9RqqV+x7I+mrEiv1F8xSLA+2d6qGg9
	 twhrQmJTH9TB4z/euA5W7bKB/2A/E5yJJnc4fpd3btIDWTpea7guartNb9MLbMlcChQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHp1U2Mi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47A1606A31A;
	Tue, 27 Oct 2026 01:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHp1U2Mi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928811F01825;
	Tue, 27 Oct 2026 01:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793066286;
	bh=XBh+jeGWrVrdbr6WBz3wJMEAmK/99nIJkgC+bD2BzG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jHp1U2MiXgFMKY2AwTfz5Q5ipJlhyRGGVtqu81/sfx2430GOztUWQcnyO6yhyhe4p
	 HNvKtcAULOSUCAgDy4S1HhNGPYiHlqYxh/YO70+3fcZ9o7nbiK2tN356J0xBgwf1Tq
	 0wCR2HU7u0bkHwRXb3ghUdLodrPZ1N/q2X0bXqLB5VcED05+FJd+CUZ3TDD50RJiQT
	 6g1A70vNR7tLWmpeSC85nv7UGQGl9LtEeeqdOWEZjkZP1X/dxVrN64wvAlmtVwJdTQ
	 KT9r7yyDeSGu+dgQpVJx4LvLqGYP9jMWke+25SmcvWplMjMY7/E1y9ZNs/NzgIBcVA
	 5dOLS4kl51Fyg==
Date: Mon, 26 Oct 2026 18:58:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: acx00: report receive statistics
Message-ID: <20261026185805.2e508286@kernel.org>
In-Reply-To: <20261025-submit-acx00-phy-stats-v1-v1-1-d3d461e46db0@gmail.com>
References: <20261025-submit-acx00-phy-stats-v1-v1-1-d3d461e46db0@gmail.com>
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

On Sun, 25 Oct 2026 06:35:17 -0600 James Hilliard wrote:
> Expose receive frame and byte totals through the generic PHY statistics
> interface as rx_packets and rx_bytes, alongside CRC errors in rx_errors.
> Report the hardware totals directly: the packet and byte counters include
> errored frames as well as successfully received traffic.

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

