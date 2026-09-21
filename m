Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF63AE18A;
	Mon, 21 Sep 2026 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790029325; cv=none; b=BMHNIMtClzHNjD4F/U2lOVBg0w8iwKvdJiS1Ia3V7XzbVBnrqdWwpST4yuYs4B7ijBvSd77i1C6SbtEqqo+j4480b8JKk/JAAIjExdfEgkp6gq9x9+DqcGNL0C01bpMsyDKI1kfZbuFK8yjTqWjk7LKQARH0EQrIeojTMh/x0Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790029325; c=relaxed/simple;
	bh=tJHWfxoP+zjBOHbLeaVaarbONpKFYAIF83a6bpmAYPM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PllYP6NCX/YxZ48kmTsQfdLVZ/kRTnfSciGaCtaKr3CXa8tfOr6gs9iBodladmTP36dbnnab2PpM0xpR+/EGjMNnYwtAIGqoxFSlfxI58J/m85rktozyLRcuqs50xsmIW5hWeJqgGjg3MjIULhX1jSlRiACfFAyMHzxL43cJV74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoYGRW1W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoYGRW1W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A1A1F000FF;
	Mon, 21 Sep 2026 22:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790029323;
	bh=RxhnBak1xJH1AGk2N4hZ7YSgAZBIEX9Uhz0IHaeExdo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eoYGRW1W0ewpO2qK4BMXQphjf2JvipC8nP6hq0uQjXqaVE1dgkgdEAw4LEW03BCrL
	 Wnxkh49j0uxFEuzc4IZVFzNix4STPD4p2tMiPTM3J/PSwR1OXxjCuM7k0hxeTYzFjV
	 X7SEE3sxZAnuosGsCaK8r98QP0fgBijJnNfK5xhT6IfMG7sN8BtO0gbHQJ12sj9sZ9
	 ZbCbc9pe8+B3slQKQwukS7YTsZnrc1qA4OH2TrrkM42B8wxlf4ZB9I+a/+D+5VNVlf
	 gAVIksxVpY96z5orSsZLXEIBAv4UbdK3Np4WXdgjSPHHaW9vvxZaQ+hBpNPjcsOoIp
	 vuBT48B92+zlg==
Date: Mon, 21 Sep 2026 15:22:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, Alexis
 =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Emil Renner Berthing <kernel@esmil.dk>,
 Minda Chen <minda.chen@starfivetech.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Jan Petrous
 <jan.petrous@oss.nxp.com>, Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Jose.Abreu@synopsys.com, Nicolai Buchwitz <nb@tipi-net.de>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, PKneuper@dspace.de, David Laight
 <david.laight.linux@gmail.com>
Subject: Re: [PATCH net v4 0/7] net: stmmac: More selftest-related fixes
Message-ID: <20260921152202.64d4c67a@kernel.org>
In-Reply-To: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
References: <20260917215339.2022523-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 23:53:31 +0200 Maxime Chevallier wrote:
> This is V4 of stmmac selftest fixes, addressing Sashiko's issues over
> the MTU patch. This lead to the introduction of a new one. The
> dev_add_pack races have been addressed, however the double-vlan issue
> stayed there. Ovidiu is actively working on it, let's wait for his work
> to land before fixing that.
> 
> Nicolai, I took the liberty of keeping your review tags on affected
> patches, let me know if this isn't ok.
> 
> This is another round of stmmac selftest fixes, mostly about the selftests
> themselves but a few things were discovered w.r.t MTU and buffer size
> handling, see patch 5 anf 6.
> 
> After this is merged, I consider the selftests to be now reliable enough
> to run them nightly on every stmmac series that's sent, and I'll be requiring
> clean selftests for new glue drivers.

This got to the top of the stack for me, LMK if none of the AI feedback
is legit. You mentioned the VLAN one, not sure about the rest.
The EEE complaints look like nit picks but also some are easily
addressable? LMK..
