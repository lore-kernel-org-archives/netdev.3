Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792630052;
	b=IWm2YBKT7KBJ5lSjZiMh2diQWlbpASCu+y+DPY0DDqZ6Zvu3fHnO/JFD7j1zTtCfLyXH
	 3ggt9qYd0G8DPjY3QwOuHwaWKFCWAWQQ/EtXSqxms1Ikdz3g0p/mvQkV/K7QpZT/E0FNi
	 cZ3Dc/5/Y45zjjVQUWUZgLUkLBY6d4E+GNa3cvCYpX6TjOiTzzVaxG8O9vlqmtKCRIXmR
	 5qOiDUZGAyPcedYZWavkctCIY7o4hy2e31VsgNRjwyfVFETeXOEZ0ai9f1q8KucfJtZ7F
	 aYAVdR9uF1sdqoA3xG9KyGTJYUSUVSU0iudyJVCoon8bj7H+qN5ud8omos50xQAnoqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792630052;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=fccNkRIzbL1uVdjGLSaZSq1bbXrNDwuFn9uqm1aWWUk=;
	b=SKb9u+hwj7v+VKm61D9a6Fro2m4lbjh6HchMyNKm2LEBb4ipDyUeiJfBuFVoYjLTtKgj
	 DuByaCo9V8AXHCxb4cR8WAL+KFx60dSsZ7dy9L0Uir3lKftZm2Tt/C6flPW1zilPaV74W
	 JCUU8leoFTb9lFEm0V2ryANjA6h1Y7evyNz2SYJzh4M3TYkhBQameygxyC1wNaSPuiNig
	 wS/q8H1h5jzxAGRl6GmMBQkeRM8tpExcIZ6gEIU2AF8tUpzPvckCz/vr9kb/1D/LgRopf
	 DKRGIlHov4pRTNuOqQtkr4nedV+4qRrvHMjFmWCdqGnWZDfhnt1OCj4MWywMZDESgzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=v9aNKs75;
	arc=none smtp.remote-ip=91.218.175.59
Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F5606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 00:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 736F5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=v9aNKs75
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6tkczwA2q6u+IycSsvI/27MATZ11ACORQeuZVFrGy5Y=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792630049; v=1; x=1793234849;
 b=v9aNKs756roknew3ibwPRUx73nSsC9mqHhkSfWIFuHMt+bb81THUhFzGlLDtLlsUiWndk/Kt
 OJ82ZqXpvh0V4qW7iMF+qBmr7BDbFUaAkW8eTAk9KBw1pdu51NgaG2Hh7KWPY0UfcgpgD/HTrQN
 HCVGZhkGloRaiEizHlm0GR2U=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f972ac63ba462e2d;
	Thu, 22 Oct 2026 00:47:29 +0000
X-Mizu-Trace-ID: f972ac63ba462e2d
X-Migadu-Flow: FLOW_OUT
Date: Thu, 22 Oct 2026 08:47:21 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev <netdev@vger.kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: Re: [ANN] stmmac enters the Netdev CI
Message-ID: <atldGZy2tH1FYTnf@fedora>
References: <bdc75e18-8ae7-4056-8f43-dc280a3414f5@bootlin.com>
 <atgaQZiiuMDC6wiv@fedora>
 <3e98563d-36f6-49d1-bf0c-f161016ca926@bootlin.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e98563d-36f6-49d1-bf0c-f161016ca926@bootlin.com>

Hi Maxime,
On Wed, Oct 21, 2026 at 08:49:22AM +0200, Maxime Chevallier wrote:
> On 10/21/26 03:49, Hangbin Liu wrote:
> > Hi Maxime,
> > On Tue, Oct 20, 2026 at 11:07:16AM +0200, Maxime Chevallier wrote:
> >> Hi everyone,
> >>
> >> It's my pleasure to inform you that the stmmac driver now has a runner
> >> that feeds into the Netdev CI. It runs in a lab I maintain, and the results
> >> are hosted by Bootlin, accessible here :
> >>
> >> https://netdevci.bootlin.com/stmmac/results.json
> >>
> >> What that means is that now contributions will be subject to CI
> >> validation, by having the kernel selftests run on real hardware.
> >>
> >> Results are already aggregated in the patchwork contest, and can also
> >> be found here :
> >>
> >> https://netdev.bots.linux.dev/devices.html
> >> https://netdev.bots.linux.dev/status.html
> > 
> > Thanks for your update!
> > 
> >>
> >> As stmmac is an off-the-shelf IP from Synopsys and is integrated in a lot
> >> of different platforms out there, the CI currently runs on 9 different
> >> boards that include the following SoCs :
> >>
> >>  - Starfive JH7110, riscV, dwmac 5.20 (rgmii-id w/ YT8531 PHY)
> >>  - LoongSon 2K0300, Loongarch, dwmac 3.70a (rgmii-id w/ YT8531 PHY)
> >>  - Amlogic S905X, arm64, dwmac 3.70a (rgmii-txid w/ RTL8211F PHY)
> >>  - Rockchip RK3566, arm64, dwmac4.20a (rgmii-id w/ RTL8211F PHY)
> >>  - Altera AgileX5, arm64, dwxgmac 2.10 (rgmii-id w/ KSZ9031 PHY)
> >>  - Altera cycloneV, arm, dwmac 3.70a (rgmii-id w/ KSZ9031 PHY)
> >>  - ST stm32mp157a, arm, dwmac 4.20a (rgmii-id </ RTL8211F PHY)
> >>  - Allwinner A20, arm, dwmac1000 (rgmii-id w/ RTL8211E PHY)
> >>  - Allwinner H2+, arm, Allwinner specific version (mii w/ internal PHY)
> > 
> > 
> > I’m curious about how our lab is maintained. Do we stick to a single distro
> > across all machines, or reinstall systems periodically?
> > And how are > reinstalls done, manually or via BMC?
> > 
> > Also, do we run all selftests via virtme-ng or docker? Does virtme-ng support
> > all the architectures?
> 
> Tests are run baremetal on the hardware directly. All the SoCs mentionned above
> are on single-board computers, devkits, or just some products out there that
> have the right HW.
> 
> We're talking embedded devices here, so there's no BMC at all :)
> 
> The distro used is based on Buildroot, a build-system similar to Yocto, I can share
> the configs if need be. It allows me to generate small images fast, that that
> work on the plethora of CPU archs the lab has.
> 
> All the boards in the lab are booting an initramfs image through the network, and
> the whole test session runs in it. Using a pure ram-stored rootfs allows bringing
> the network down afterwards, while the tests are running. It also allows easily
> updating the rootfs running on the boards when a new selftest get added for example.
> 
> All the boards are controlled through dedicated relays for power. As we're dealing
> with embedded devices that consume only a few watts, it's only a matter of switching
> some low-level DC voltages on/off (5V/12V/24V). I have a few mains-powered boards, also
> controlled through relays.
> 
> The whole lab is managed via labgrid + some custom software on top of that to manage
> the jobs, the builds, reporting results, etc.


Thanks for sharing. Labgrid looks quite promising for embedded device control.

> 
> I'd say, this setup is quite different to ones used for server-class HW, but the
> whole thing runs on very simple hardware, cheap to acquire and run.

Yes, I’m looking for a stable lab controller that can manage servers with
poor BMC support. It needs to support OS installation, system reboot, and
automated test execution.

> 
> To give you an idea, the build machine I'm using is based on Intel Core Ultra 9 185H,
> a laptop-class 22-core CPU that's in a NUC, and this is more than enough to build
> kernels/rootfs for 10+ boards every 8 hours, with lots of time to spare :)

Thanks, very glad to know these.

Cheers
Hangbin
