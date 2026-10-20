Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487243;
	b=x0o1xjvTO3vXm0+iJQSuwz6JxTp+bFtUZqlO3rP63PXMeOFS1+M/KaUvaSX3BuTU1ucm
	 y9E8P6S1GerErQbEZ4mfY5rBEEVSqz0DTGoEj1P+zW/rCmxN7aAjsAkbnXXzZXu0YoF3v
	 ymHtLVedroEZkmM1jOad7m5h/yhSeG04T+A1qVcAO29TUDryrJUF6N3mwIG/q5dDmmy/O
	 SpYwmeLcbo4Qc8YC3SY7TauVB53jLbXuJBEbkNUu6MDOB380wIeRskH5MJD0sN9bbkpAU
	 GEQng97zrw0CLr+ouLd0r02DC4J+a+KK/Foo+p5IQ/S2NzI7PLmUcRvC6mXvotryGEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487243;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Content-Language:From:To:Subject:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=4awUjCoPkMordNZ7dimHR0j762Iy/DR9nQP5uwRaSgs=;
	b=mxowgF2wCtlUptuBpMKaUPLDBT9I9XIRuPhTp2RjCugdUvoox/ybZJvr6ErYPn3D6hAC
	 qXQsJlJmbfbueWD6b5+SEJ2WcmzxQBVdcpHj1lgsHyg0UkoZa/OpouTb0ZSu66EbNpzhZ
	 A/qbqJUCvbS/Ii1Etf9QQu+HbQOdUwjDpITZwzla2XGUfztR7jYKMUAmZ7FeyYHJZHxsA
	 TYYAc7Hx++fJAseaeMNSzuUUG2OHkxLvYDdw71RDaoVMwpb8RclHFLPkT65resM/v4oRs
	 rqPtle+sZ3gUalsoncqlUD6LeH20qTH1DSL3Is7rI25feKW7m0SZv4ajQfFhrXTtT7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fxW3WUj0;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74107606A31B
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74107606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fxW3WUj0
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D3D3B1A12A4;
	Tue, 20 Oct 2026 09:07:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A1E5360393;
	Tue, 20 Oct 2026 09:07:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99403103289A8;
	Tue, 20 Oct 2026 11:07:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792487239; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=4awUjCoPkMordNZ7dimHR0j762Iy/DR9nQP5uwRaSgs=;
	b=fxW3WUj0J4JZ9qtamgeHIyTlRVX0RuIbIVCw1xH2xs7QROhhVhqS46Xou0mORf3H4sBSgh
	C/xadBgwiuQBxE+oxDOOHZtDm8jgDV6cw9Izd74wd9vVcL1I3SIdrEdM3QyySSphRpAB+y
	oj067Lg9Lbixh8GLaK/mZweW+go4RSMWHEZDSOHMob83giabh6gN6IwFh+JD1T8BDHWNcO
	QcSdUlij83TnIr4GN2MMOLFdDVoIGhXUTmppT07+XSVXkztY6FSXCJZEG4yakO3KY8u0VE
	dUM/5hgCEhSmVge20ZO1k4yAlYFWmWq5VEiXKTO/jx5jKV0B8xCEs4V0i5eh/Q==
Message-ID: <bdc75e18-8ae7-4056-8f43-dc280a3414f5@bootlin.com>
Date: Tue, 20 Oct 2026 11:07:16 +0200
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: netdev <netdev@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Subject: [ANN] stmmac enters the Netdev CI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

It's my pleasure to inform you that the stmmac driver now has a runner
that feeds into the Netdev CI. It runs in a lab I maintain, and the results
are hosted by Bootlin, accessible here :

https://netdevci.bootlin.com/stmmac/results.json

What that means is that now contributions will be subject to CI
validation, by having the kernel selftests run on real hardware.

Results are already aggregated in the patchwork contest, and can also
be found here :

https://netdev.bots.linux.dev/devices.html
https://netdev.bots.linux.dev/status.html

As stmmac is an off-the-shelf IP from Synopsys and is integrated in a lot
of different platforms out there, the CI currently runs on 9 different
boards that include the following SoCs :

 - Starfive JH7110, riscV, dwmac 5.20 (rgmii-id w/ YT8531 PHY)
 - LoongSon 2K0300, Loongarch, dwmac 3.70a (rgmii-id w/ YT8531 PHY)
 - Amlogic S905X, arm64, dwmac 3.70a (rgmii-txid w/ RTL8211F PHY)
 - Rockchip RK3566, arm64, dwmac4.20a (rgmii-id w/ RTL8211F PHY)
 - Altera AgileX5, arm64, dwxgmac 2.10 (rgmii-id w/ KSZ9031 PHY)
 - Altera cycloneV, arm, dwmac 3.70a (rgmii-id w/ KSZ9031 PHY)
 - ST stm32mp157a, arm, dwmac 4.20a (rgmii-id </ RTL8211F PHY)
 - Allwinner A20, arm, dwmac1000 (rgmii-id w/ RTL8211E PHY)
 - Allwinner H2+, arm, Allwinner specific version (mii w/ internal PHY)
 
On top of that, there's a Motorcomm PCIe card with dwmac 5.20 that's
connected to the JH7110 board, also running the tests.

Coming-up is NXP imx8mp, ST stm32mp2 and Ingenic X1000 (MIPS board) that
will be running these tests in a near future. I will also include another
CycloneV setup with SFP and the Lynx PCS.

If you're interested in getting your HW in that CI, I have some room to
spare to host a few more boards, if it's relevant, feel free to contact
me.

This setup is cruelly lacking DWXGMAC IPs (only one now, and it's 1G only),
as well as stmmac boards that use a PCS. Only Lynx will get coverage with
the CycloneV board, there's no XPCS boards yet in the lab even though
it's quite an active area today.

The tests that are run are the tests in :

 - tools/testing/selftests/drivers/net
 - tools/testing/selftests/drivers/net/hw

Not all the tests are currently running, as some of them do not pass
cleanly on stmmac, either because of driver issues, or because the
selftest itself doesn't properly run on the boards.

The following tests are excluded :

  - drivers/net:napi_threaded.py
  - drivers/net:ring_reconfig.py
  - drivers/net/hw:rss_ctx.py
  - drivers/net/hw:xsk_reconfig.py
  - drivers/net/hw:xdp_features.py
  - drivers/net/hw:irq.py
  - drivers/net/hw:tso.py
  - drivers/net/hw:toeplitz.py
  - drivers/net/hw:rss_api.py
  - drivers/net/hw:rss_drv.py
  - drivers/net/hw:rss_flow_label.py
  - drivers/net/hw:nk_qlease.py
  - drivers/net:stats.py
  - drivers/net/hw:csum.py
  - drivers/net/hw:uso.py 
  - drivers/net/hw:nic_timestamp.py
  - drivers/net:xdp.py
  - drivers/net:gro_hw.py
  - drivers/net:gro_lro.py
  - drivers/net:gro_sw.py
  - drivers/net/hw:vlan.py
  - drivers/net/hw:devmem.py
  - drivers/net/hw:nk_devmem.py
  - drivers/net/hw:userns_devmem.py
  - drivers/net/hw:nk_netns.py
  - drivers/net:psp.py
  - drivers/net:macsec.py
  - drivers/net:netpoll_basic.py
  - drivers/net:ping.py
  - drivers/net/hw:ethtool.sh
  - drivers/net/hw:ethtool_extended_state.sh
  - drivers/net/hw:hw_stats_l3.sh
  - drivers/net/hw:hw_stats_l3_gre.sh

This list will likely shrink down in the near future, as the driver gets
cleaned-up, but also as the selftests themselves get adjusted to run on
less capable HW. Hopefully we can get the XDP/XSK tests online soon, as
there's a lot of activity in this area currently.

A few of these exclusions also result from the lab itself not supporting
some features (e.g. macsec or psp).

Note that there's also a secondary CI that runs a few test that aren't
covered by the kselftests, it's not much and doesn't get the same amount
of attention as the NetdevCI runner, but still it's useful for aggregated
results of the "ethtool -t" selftests runs :

https://minimaxwell.github.io/stmmac-ci/

Special thanks to Matthieu Baerts, Jakub and Andrew who helped a lot in
setting this CI up, and to Bootlin for hosting the results.

And of course, thank you to all stmmac contributors, this is the busiest
driver in net and we've seen a lot of efforts lately fixing bugs all over
the place, getting better PCS handling, better XDP/XSK support, better
TC support and overall multi-queue improvements, multi-buff mode, proper
MTU change and suspend/resume error handling, cleaner VLAN support...

Let's hope this CI can help making bigger reworks without the fear of
breaking other people's setup :)

Maxime
