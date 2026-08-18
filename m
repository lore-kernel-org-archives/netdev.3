Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7941A926;
	Tue, 18 Aug 2026 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066088; cv=none; b=qtTUVaLfr0Bbpb+KAo4qZGv7i7zXrLHyXA+JmySHE6Pw0F3N2KeQCkgRHuUiPnEYH7mG1zZsQYFdaBjP87TxH77C/lZAf/fgeNeBCUxWcEzrq007dbGimZHvGOCJNqwszSqMbtcU4tt78CFCEmqd3rFOcO8b0mtRg9BUCdyLFKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066088; c=relaxed/simple;
	bh=Zm/kg2ysL9SI51z5qwV5z882sv0gm8jzLRcgSFCW0yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIvUBZetwyGTsKuVchxwifWcUQr5uBLLONykLYlCfc50TeWTKLC+BO843hNKASVUzE/+la6hIPrhD3ZoMxFVQWKiOyRRQSYp9Ocu1jOMbHw2XoQWy1aeO6gsEaDkcwHrqsQt+rQ+Ibok7J3SvfmYlSqXmpyNDYVxSdqNjDEA584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwwrdj7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwwrdj7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F86E1F00A3D;
	Tue, 18 Aug 2026 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787066086;
	bh=2JaBU4soOMuzTlkocTQTKPCG7lFA4Jq4D6arXavXLvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lwwrdj7Cq4hpCLgQM4mRf8LEbdb8otzQEkPATaq4K1gqiPd7jOBvQByAOTNEZxc8z
	 Z5ACDMv+COsJPxvTXR6gTHZW7N2p1BToKQW3lYR1tpN0zZUWKrqBUi4lgp9Rg0bAS5
	 zkB1OjyH54RHG7ISj2CvTwRg7ZCb0LVeIjGTQlefXenVv6n4vWbM5qWsCcYMLix9Kd
	 FaVTwsYjaTKb6JJ8JoTrNjQYwJ9BG+6ahkzpQaWX6J5y9nk8iyxNSNvKzJ8nZn6+xo
	 uTxsL63ktOGjSDpEBvLeYxjAAQ60QqUEQGOvjaU65LW/VZ1U/1oTL2XtQYrWsC+m1n
	 NNoRRlZhczPGQ==
Date: Tue, 18 Aug 2026 08:14:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Jagielski, Jedrzej"
 <jedrzej.jagielski@intel.com>, Andre Przywara <andre.przywara@arm.com>,
 Chen-Yu Tsai <wens@kernel.org>, Jernej =?UTF-8?B?xaBrcmFiZWM=?=
 <jernej.skrabec@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-sunxi@lists.linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH net-next v9 0/2] net: phy: add X-Powers AC200/AC300 EPHY
 support
Message-ID: <20260818081445.43f327e9@kernel.org>
In-Reply-To: <20260818-submit-acx00-of-dynamic-v1-v9-0-b8c8d9ad0d83@gmail.com>
References: <20260818-submit-acx00-of-dynamic-v1-v9-0-b8c8d9ad0d83@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 00:21:15 -0600 James Hilliard wrote:
> This submission contains only the networking binding and PHY driver and
> is intended for net-next. The AC200 I2C register provider was submitted
> separately for the MFD tree:

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

