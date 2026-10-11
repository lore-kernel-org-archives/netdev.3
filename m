Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168732D46A1;
	Sun, 11 Oct 2026 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791724941; cv=none; b=dig6t8xTpLO0rpt9Zorx8qYPv7gF7hN+V2r54TZOoSWDcA/GJsH2EISgzpVnzXypWeN2Y34nI+Rz8q0AJGTiAC4mlo9pl61bB8H8ZRUzQJYRM9NLvDI/L5hIfWOj0GDhUaI3U56OSY7fe/BOjKRZTW9rvb9SyLAuLD8IEJ3zPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791724941; c=relaxed/simple;
	bh=xGyw+p++J/1JMNTZrdwyX2SWIyBvgqXVssblKq88W4I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=DSyzT6lGrEAzxwBQq1gHo8Q0rnDVNWLZ50VQ0myTPZBfmtI2rnZ8DTVD++A0AwY/0fdb1tu7klK/bNexu9BdTD+PcmT883H1UycK5/4KVmSINSYR50n8nFu/RFuhUruf1O5186ZwoCNdSbCkRRn5YXxWZIzVNV20p0jADakQQ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=0nKwhdZP; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="0nKwhdZP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58F69A1554;
	Sun, 11 Oct 2026 15:22:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791724928; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e5lNDVF0t/BQUG+yFHmQg6qoXpqlEkUU8002OK6qkY0=;
	b=0nKwhdZP/MG1qcfOS421FUHepThtxVHGHj+AJtmxqPnc1udsSBoMtWBWnFq2EyiRWJtkb9
	QWA3tDEATb2l2j9dfaQtLxtdCLWpO7GeY8jgY9D3YCgYfYM9DNDK69sXR8tL8Bx2jDW2+U
	XYPa2NVYPSWlspPY77C8uFDUiQCbICiZzk0PsNQYkvsopooYTpiLxR6cNULaLBa2mCZocP
	VeaIs92PDqFVNatsoPG9LlD34PA6cmXQioJCOakLZ/hHsA7loTg/RbitzZVE+jLSTW30Fq
	ITplGMdX9++tPxg14p/td53jyPT1TioiBM9vFWrYqR1mw6G5DAWUqFlZf5D6yA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Oct 2026 15:22:04 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: James Clark <jjc@jclark.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>
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
In-Reply-To: <CANz3_EYfcBopo=HgRioXkhoT6P+4WWpfFT7UeWkXd5eM_RNpSA@mail.gmail.com>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
 <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
 <CANz3_EYfcBopo=HgRioXkhoT6P+4WWpfFT7UeWkXd5eM_RNpSA@mail.gmail.com>
Message-ID: <41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James

On 11.10.2026 09:20, James Clark wrote:
> On Sat, Oct 10, 2026 at 10:18 PM Nicolai Buchwitz <nb@tipi-net.de> 
> wrote:
>> I dug a bit deeper on a CM4: AFAIU the MDC runs off the GISB clock,
>> which the firmware sets to 200 MHz (CPRMAN 0x1d8, PLLD_PER 750 MHz /
>> 3.75). Bumping that divider to 4.0 at runtime moves the MDIO busy time
>> by exactly the same ratio, so that's the one. The 250 MHz you have in
>> mind is genet250 / genet125, the RGMII side, a different generator.
>> 
>> So instead of a fixed clock or a compatible match this could just be
>> BCM2711_CLOCK_GISB in clk-bcm2835 (critical, firmware owns it) and
>> clocks = <&clocks BCM2711_CLOCK_GISB> on the mdio node. I can send 
>> that
>> if it helps.

I've put together 3 patches, which do the clock plumbing:
https://github.com/nbuchwitz/linux/commits/devel/bcm2711-gisb-clk/

If we agree that this approach makes sense and Florian has verified that
my experimental findings match the actual implementation (+ naming), I
can send to the clk / stblinux people.

> Thank you very much for looking into this. I think this would solve
> the problem from my end.
> 
> Let me just confirm how I would need to adapt my patch with that fix:
> in the pdata branch of the probe, I would call devm_clk_get_optional
> to find the clock on the mdio node, falling back to pdata->clk. I
> would still add the chip-specific compatible string because the number
> of MDC periods has only been measured on that specific hardware.

In the unimac patch you would only need clk_get_rate() and can gate
write_sts() on it. Not sure about pdata->clk though: bcmgenet passes
its "enet" MAC clock there, which isn't necessarily the MDC reference.
If write_sts() only trusts a clock on the mdio node itself, you don't
need the compatible either.

Cheers
Nicolai
