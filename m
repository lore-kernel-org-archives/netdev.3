Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565373;
	b=JfWJL8uNuIJ3HtbhSULRqgWjng6TwcjbmtogeYEx1XDoY4zdH2jRN5urjsi3PY3HFjPW
	 Xp0+7LS9Zh1cZsbfq8NwX/FZDj7x/KT6PSTPbgyC86y2ESPNjvyhDZ+wYuqxOCuVAR8M9
	 foc7FiIEVX8joT2P6za1zlZqBTcAJdGJZ9EWAXcvwuOh6IWq3UJSFpSmQ4QaBu3ulqCD0
	 wP62mNUayl9C3zjyZiNHEtfYcKE3AEwwNfQh81sp2uovLlCJOrAS9M0tz6lB2k//L2i5a
	 vC5fr5fvkNjnISs2EKYwmMCOfK389raoMkc0iSoW7JUxYdliJ4z5bv9xNjbqV/Rl3Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565373;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=pi88JNixZmcWaddx5lRAH9DSN3eosQbzcNOIuvCC9TE=;
	b=gJZgHsVKe48/dLrCn/Zcxx7cO56T7O4QwLstNaK5jNe78x1yTO/yXtVVNn0CwJfW8dxc
	 q3f9t4Zg58QrVFjXIxD64lSpiF96tyzlxfv/dASfRjswPslMlh9+Y2TsLlve+7z+2Uerh
	 AMR09W6oekyMZsF2Q4UQkE9LUk40JBTFF66QadQGA0RjVjzyWJxUIIv3jrasaJj9IRMZD
	 VE2Da09/KYGzXWKiiMs24Kw79ThvljmMx137tfuLdrF+tdgo429KZKy1ZztkxWKzl8se5
	 xIr5uMywG39/IYHKWAaQIEJEqx/JlpWHYx0ZorigWTGatxjZmKzTV3dTdRakq4O0biQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mq1BDs4s;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA15606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BA15606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=mq1BDs4s
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 070EBC5CD71;
	Wed, 21 Oct 2026 06:50:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0D43F606E3;
	Wed, 21 Oct 2026 06:49:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4C3410328934;
	Wed, 21 Oct 2026 08:49:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792565367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pi88JNixZmcWaddx5lRAH9DSN3eosQbzcNOIuvCC9TE=;
	b=mq1BDs4sMGdmIu0bKerATqH1DtzeBiZLBPZCU43d32pCEnMAXrG6+jOoLJWSm8COHhXhKF
	Lu89Y3T0FPk/WhSkZfmCfjleb+GrwXK2yKzkFcXfOzXd6ecw13swJDQBOPUmnzdWZTPEXw
	qJ6cRRC0Ou0kkdNwh0lxq1JfZqxzloNNDbX4Qc9Gi3xr9ZcMWoXaFaJMXh87/mvWALR3FY
	/oFmLyyNPDrExL3UI731wHQLzLzTEa/nnRS5ivVPOJb4rgfWNwFkL7oVJER+WsGPyY/8hN
	6Q28bd1IQTqUDhIRho+yzW/tBEoDNCA60r3Wdr5hfJE9KmKdoXlbTF3gictnjw==
Message-ID: <3e98563d-36f6-49d1-bf0c-f161016ca926@bootlin.com>
Date: Wed, 21 Oct 2026 08:49:22 +0200
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
Subject: Re: [ANN] stmmac enters the Netdev CI
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev <netdev@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
References: <bdc75e18-8ae7-4056-8f43-dc280a3414f5@bootlin.com>
 <atgaQZiiuMDC6wiv@fedora>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <atgaQZiiuMDC6wiv@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/21/26 03:49, Hangbin Liu wrote:
> Hi Maxime,
> On Tue, Oct 20, 2026 at 11:07:16AM +0200, Maxime Chevallier wrote:
>> Hi everyone,
>>
>> It's my pleasure to inform you that the stmmac driver now has a runner
>> that feeds into the Netdev CI. It runs in a lab I maintain, and the results
>> are hosted by Bootlin, accessible here :
>>
>> https://netdevci.bootlin.com/stmmac/results.json
>>
>> What that means is that now contributions will be subject to CI
>> validation, by having the kernel selftests run on real hardware.
>>
>> Results are already aggregated in the patchwork contest, and can also
>> be found here :
>>
>> https://netdev.bots.linux.dev/devices.html
>> https://netdev.bots.linux.dev/status.html
> 
> Thanks for your update!
> 
>>
>> As stmmac is an off-the-shelf IP from Synopsys and is integrated in a lot
>> of different platforms out there, the CI currently runs on 9 different
>> boards that include the following SoCs :
>>
>>  - Starfive JH7110, riscV, dwmac 5.20 (rgmii-id w/ YT8531 PHY)
>>  - LoongSon 2K0300, Loongarch, dwmac 3.70a (rgmii-id w/ YT8531 PHY)
>>  - Amlogic S905X, arm64, dwmac 3.70a (rgmii-txid w/ RTL8211F PHY)
>>  - Rockchip RK3566, arm64, dwmac4.20a (rgmii-id w/ RTL8211F PHY)
>>  - Altera AgileX5, arm64, dwxgmac 2.10 (rgmii-id w/ KSZ9031 PHY)
>>  - Altera cycloneV, arm, dwmac 3.70a (rgmii-id w/ KSZ9031 PHY)
>>  - ST stm32mp157a, arm, dwmac 4.20a (rgmii-id </ RTL8211F PHY)
>>  - Allwinner A20, arm, dwmac1000 (rgmii-id w/ RTL8211E PHY)
>>  - Allwinner H2+, arm, Allwinner specific version (mii w/ internal PHY)
> 
> 
> I’m curious about how our lab is maintained. Do we stick to a single distro
> across all machines, or reinstall systems periodically?
> And how are > reinstalls done, manually or via BMC?
> 
> Also, do we run all selftests via virtme-ng or docker? Does virtme-ng support
> all the architectures?

Tests are run baremetal on the hardware directly. All the SoCs mentionned above
are on single-board computers, devkits, or just some products out there that
have the right HW.

We're talking embedded devices here, so there's no BMC at all :)

The distro used is based on Buildroot, a build-system similar to Yocto, I can share
the configs if need be. It allows me to generate small images fast, that that
work on the plethora of CPU archs the lab has.

All the boards in the lab are booting an initramfs image through the network, and
the whole test session runs in it. Using a pure ram-stored rootfs allows bringing
the network down afterwards, while the tests are running. It also allows easily
updating the rootfs running on the boards when a new selftest get added for example.

All the boards are controlled through dedicated relays for power. As we're dealing
with embedded devices that consume only a few watts, it's only a matter of switching
some low-level DC voltages on/off (5V/12V/24V). I have a few mains-powered boards, also
controlled through relays.

The whole lab is managed via labgrid + some custom software on top of that to manage
the jobs, the builds, reporting results, etc.

I'd say, this setup is quite different to ones used for server-class HW, but the
whole thing runs on very simple hardware, cheap to acquire and run.

To give you an idea, the build machine I'm using is based on Intel Core Ultra 9 185H,
a laptop-class 22-core CPU that's in a NUC, and this is more than enough to build
kernels/rootfs for 10+ boards every 8 hours, with lots of time to spare :)

Maxime

