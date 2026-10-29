Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290518;
	b=Ykldp9L5FOD2zbDBNNGis3S9vMoo45LUARVhlVFoHvpcx9xhUGGBa33m+T1ssGhMVM6y
	 +Qe2HBInUL9533MaZ6AYMRaKvFc9qSgXbOB45YksIHmTUiKbyM0+WaniHweS9URCgJpel
	 ViUzAL6xpJ27SGbxlBlfzdOfc4Qi/Ha5HYcgKCZF0q0ZMhL7JoTUnIKqOmjHoeuT2a9yH
	 /qZOnNKCuvVRo0KmoxOzCmOg74515tDL5dYrXWVLxLeeG2+v+p7q150HYMoT2FUt6Ubaw
	 bflEdxu5M0EaBtS8ea7UW1L5eqRXMsXkyCXH8AyN2X04D/oNHRmMakKbRW6Y0+FlCPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290518;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/ixsccMVhQQFsyZTijSDqJU2Yn/nNlxSIzZkTKWFQDU=;
	b=N7C5Y4PyI4rAC1FBIX4y3u9VFtZs3fzWeNTm36SZDIvacC7IrYiwVawBm7phz8s+yoXc
	 14SmoWY2xo3oNceDWQ8Igc7BGYqkwiNM2DE0at2+WaR5kRbm/FmI/bJ5SZoQCPbioPDsp
	 QUVsI6HJMc3Bm6brR5vwO5GYxwXnAFoRNLlmxqddkgn5PkjSjnsD8SBUCw7KK8XNH2T//
	 VjiSCke07hE6anraWiCysZGPXC2Zk7lkm8eXct47+ZDJX7IfF+sXAy3uEdbSKeoi2PnOZ
	 v9AmsDyxG5QIqx/Yf2U/94GxWz96kgRnE1VfcOZYfMIX5CCXn3YBUwt4sPR+BdlmaAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEi8K5yC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA9606A333;
	Thu, 29 Oct 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEi8K5yC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDE61F01816;
	Thu, 29 Oct 2026 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290517;
	bh=/ixsccMVhQQFsyZTijSDqJU2Yn/nNlxSIzZkTKWFQDU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WEi8K5yC45PD7IOiavDKRd2ByVXzmOWB6fnAv2y2q+o92eY6d98MjLO/wjON5mxXE
	 POh1QmKHfk6HD8S6R6ByLQrF2lZefHgXkUN+yaRJHh3FXV3gZvEtFYLApRotcksgU7
	 c2ObdUuq5z0NkElphy1LervXQjKebCnfs0yrtTxzcjVlbJQaBOmjcS68o449sva5aK
	 zxcIXxIkW6iF/ieMgHLw2pnffZoA16InLx1ALibfVdU+2hg3M5LjUBuPrNkIsdmmOg
	 NST3nVuUdWHa9mR+JH8JC/Hj/VhA03cFyFSnLfrNHSHqam2aITt862y2DwUAIErplr
	 aYkoFhABdIuMA==
Subject: Re: [PATCH net 06/11] net: au1000: assign a valid MAC address without
 platform data
From: netdev-bot+sashiko@kernel.org
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, shaojijie@huawei.com, horms@kernel.org,
 runyu.xiao@seu.edu.cn, mmyangfl@gmail.com, hvr@gnu.org, jeff@garzik.org,
 danny.kukawka@bisect.de, mugunthanvnm@ti.com, sebastian.hesselbarth@gmail.com,
 linux-kernel@vger.kernel.org, manuel.lauss@gmail.com
Date: Thu, 29 Oct 2026 16:15:15 +0000
Message-ID: <179329051563.3134.3476237104312720828@kernel.org>
In-Reply-To: <20261027223140.3774570-7-f.fainelli@gmail.com>
References: <20261027223140.3774570-7-f.fainelli@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The code change is correct, but the commit message overstates its
  impact.

--

net: au1000: assign a valid MAC address without platform data

This commit adds a call to eth_hw_addr_random() in the no-platform-data
branch of au1000_probe(). Without it, dev_addr stays all zeroes and
eth_validate_addr() refuses to open the device.

> The supported no-platform-data path leaves dev_addr as all zeroes. The
> device can register but eth_validate_addr() prevents it from opening.

[ ... ]

> Fixes: 7718f2c27dbd ("au1000_eth: use eth_hw_addr_random() instead of random_ether_addr()")

[Severity: Low]
The code change itself looks fine. Is "supported" the right word for this
path, though, and does a Fixes: tag fit here?

As far as I can tell, no in-tree configuration reaches the !pd branch in
au1000_probe(). The only "au1000-eth" platform devices in the tree are in
arch/mips/alchemy/common/platform.c, and both set platform data
statically:

au1xxx_eth0_device:
	.platform_data          = &au1xxx_eth0_platform_data,

au1xxx_eth1_device:
	.platform_data          = &au1xxx_eth1_platform_data,

board-mtx1.c only copies replacement pdata into those static structs
through au1xxx_override_eth_cfg(). au1000_eth_driver has no
of_match_table either, so device tree can't create an instance without
pdata.

On in-tree boards, a missing or invalid PROM MAC leaves pd->mac zeroed.
That case already takes the existing else branch:

		if (is_valid_ether_addr(pd->mac)) {
			eth_hw_addr_set(dev, pd->mac);
		} else {
			/* Set a random MAC since no valid provided by platform_data. */
			eth_hw_addr_random(dev);
		}

So it looks like only out-of-tree board code that registers the device
without platform data can hit the zero MAC failure.

Could the commit message describe this as a latent fix for users without
pdata? Without in-tree users, would net-next without the Fixes: tag be a
better fit than a stable backport?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027223140.3774570-1-f.fainelli%40gmail.com
