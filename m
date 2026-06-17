Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5718871F;
	Wed, 17 Jun 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731029; cv=none; b=kblu7RdJwMDvrVmlB6mvK637r51GAzaCwnK2HNVVFeCIFvJHkqbheBeNj3PBuVGnhKRgy2b6VyDyG4BOnUbRCW3atYVF+7vlYZyjpspO+WTdPZWuejjeCi2Y0fHJA2Zv0mt/ACVJQvLygXazdxNsaFCAHwhXB7Tg6dxDBVCJMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731029; c=relaxed/simple;
	bh=x/nhyE4L/Sy1lDkey1p6FbadOEpfyHK4GdK5pMqLCpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyUF07e9m4+6Yb9Q3zyECUchvF7mYH5YynPN4f1CdYq2ajoJsRMF3YpYgL/94YWzAIO99eMszlqLlyCstRt1EDPuOXz5DzkN9jvB9LxI2rai/ZijsgyoMXRw2Yuean/FmXs3/HQgM7Bu0ozEE3I5/BwVaiAt74v6gDZn+lKRSmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIfZSsqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIfZSsqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C8A1F000E9;
	Wed, 17 Jun 2026 21:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781731027;
	bh=YiY6/DUiKym01gTg/k7ZNmI26ZSUVWZpNWqMLBrw3ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UIfZSsqkXdVoxO6UgpKJZ7JIudjLXxmHoyXNdy1vY4wSR+9xnkpndP9CefdbX+l7P
	 KNRZfGPi5lFxsu9irADs/s41QWlBOmnFA5Ey8QvjwE7L1Ei/cBJqYeEbLm7Q10BTb3
	 I8anIjC95EOacYltkNyn7iC+6MOCspNLbK8i6EHkrlUKfauOvQOIXWYU/w6a8pKJCl
	 edgabzoTOhd6l6+9YFqPt42QnQjhBplkbXdcuBAh9McuoTgWjjUhROsBXJbKRAeqUz
	 Rg/AFsH7IRgUi/qiVz3V0wlq8DR7XlPPS8AdgzeqNGNt43bSS4GWYROuFOGxC8kgkt
	 ymnnHvL0f/Pxg==
Date: Wed, 17 Jun 2026 14:17:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <bryan.whitehead@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 0/2] net: lan743x: add RMII support for
 PCI11x1x
Message-ID: <20260617141706.5ec34d49@kernel.org>
In-Reply-To: <20260617053241.157932-1-thangaraj.s@microchip.com>
References: <20260617053241.157932-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 11:02:39 +0530 Thangaraj Samynathan wrote:
> This series adds RMII interface support for the Microchip PCI11x1x
> Ethernet controller.
> 
> The PCI11x1x device supports RMII as an alternative MAC-PHY interface,
> selected via the STRAP_READ software strap register. Patch 1 reads the
> RMII strap bits from this register and sets the is_rmii_en flag. Patch 2
> uses this flag to configure the PHY interface mode, phylink supported
> interfaces, and enables RMII in hardware via the RMII_CTL register.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.2,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after June 29th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

