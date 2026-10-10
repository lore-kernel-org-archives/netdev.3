Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7B135C691;
	Sat, 10 Oct 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791645503; cv=none; b=BpRm7FLX61cx+pOskYYHdvmQ+zXTCkS2QMER6ozW/yw0AcU49fnQ5Riv1saV2gUQUEnrArv+ju9PGlsvLN4zk+Dhlrm7oTL2+7IC5z0TQWTG5tOh2urMILDefChRkNK0cGG4qm3Q+QWvXrA3nUazVoLnnqzeuGbgIbzcrTZEz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791645503; c=relaxed/simple;
	bh=PugPBopIbjU+Mph4q4eNzKWaALuRpl3D+GgMEso11qo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nlLeGIKeCZOH17FoIz+HK338XhQL38uOxy3hbNSCcPWeBnsh8GNs75RqIaXa8Sehj57fBT9tCWXWyFo0pWBvlrd8pP/+8Gkp6xquy3m5Li2OqBH9SbQzEnNO2t+01+OWX2Kj5rFJz3mNOJ9fevjJF6Buzk8IdJPWB/IZ/C6bAQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jLnv4Ix+; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="jLnv4Ix+"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 101AFA1554;
	Sat, 10 Oct 2026 17:18:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791645495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OFji6mK5hVh4IRqyn2mb1ycCkKmMpbTGNcgel/+gPgk=;
	b=jLnv4Ix+rxmKtY3Xt+YQswGD3nTUK3HrvXg2OerlmUpm8sl8Z66elzW66+DQp0OO2OlqyI
	NrI5eNvItJDtWmkBn4CNQmZXgrArX5GAdqHfsLBszClH1pbENEv2ie78tfKhqYmKVK22mc
	bfpA9+ScFFBoBNWduYSzQk+riVJRcLoJz7Me6VDvp4FDIHylVZS9DmIfAE8zFDwk1scKEd
	ryx0oxVfisBqWW2NFEkSr6CImKbnCh5ahyeAGAaDHNtXwei8OZPRvQCq0iMcExN4lvMZb4
	4Sc6PMOXpQ46ZnO8bP0DGLdPIe03aTpRHag9J/vw7NGUfkhPPcyTPLnMzscpRQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 10 Oct 2026 17:18:11 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>, James Clark
 <jjc@jclark.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>, Doug
 Berger <opendmb@gmail.com>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Russell King <linux@armlinux.org.uk>, Conor
 Dooley <conor.dooley@microchip.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
In-Reply-To: <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
Message-ID: <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Florian, hi James

On 9.10.2026 18:04, Florian Fainelli wrote:

> [...]

>> When there is no clock, unimac_mdio_clk_set() assumes a 250 MHz
>> reference rate, and no in-tree DT gives GENET or UniMAC a clock. For
>> BCM2711 I have no documentation of the reference rate or of the clock
>> that supplies it, but MDIO busy times measured at several MDC dividers
>> fit a rate of 200 MHz. This patch checks the parent's compatible 
>> string,
>> which is unsatisfactory. I would prefer to get the rate from DT, and
>> would welcome suggestions for the right DT description.
> 
> You can, and should define a chip-specific compatible string for the 
> MDIO contorller node. We have one for 2711 already for GENET 
> (brcm,bcm2711-genet-v5), so you could define brcm,bcm2711-genet-mdio-v5
> 
> The clock frequency is fixed, so you could also provide a fixed clock 
> to ensure that the clock frequency is derived correctly. I will check 
> the actual clocking because 200MHz sounds odd to me, since the RGMII 
> interface does require 125MHz and therefore a 250MHz source makes that 
> easy.

I dug a bit deeper on a CM4: AFAIU the MDC runs off the GISB clock,
which the firmware sets to 200 MHz (CPRMAN 0x1d8, PLLD_PER 750 MHz /
3.75). Bumping that divider to 4.0 at runtime moves the MDIO busy time
by exactly the same ratio, so that's the one. The 250 MHz you have in
mind is genet250 / genet125, the RGMII side, a different generator.

So instead of a fixed clock or a compatible match this could just be
BCM2711_CLOCK_GISB in clk-bcm2835 (critical, firmware owns it) and
clocks = <&clocks BCM2711_CLOCK_GISB> on the mdio node. I can send that
if it helps.

Regards,
Nicolai
