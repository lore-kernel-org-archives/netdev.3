Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249674B7A21;
	Mon, 19 Oct 2026 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792403238; cv=none; b=FE4vBwd3aDfCe/N/qTmt575PPR6UzPey9ZOkghAys5Vyd58KgRi68em9dY/Cd4ifVxXa9idO47hw5ymFz9mj2oJGwIE09WjbAt6R8IlrQCnKOKcMbULjSQgEsRB79ZtIMeaiNSj182d31qF8dGYJz6Cw0mkgNXs4iqQO7KUwtVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792403238; c=relaxed/simple;
	bh=goyLzvYOqssRp0+BpiXM1BokD87KkSw3vymP7GKwegs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IQBEmlQyfKfRalotNhU6Z9crZ47OhZW1Kv6plJJN9kZ9ULQolBlk2fNSFLWM0AAeIN5kpkbbBaTBExC8e2aQqSB8+g0i/e3HmzwVrbiVwpvA7uLs0be8d3lvUeZPUIYgRCiXz4fTOn/1HXQUgUgjxpRD0m5YeUZ6ptCR4SfoOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=VU8RIu3O; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="VU8RIu3O"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5CE7FA15A5;
	Mon, 19 Oct 2026 11:47:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792403234; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7nW1HUg12OjktfsDmpAE0SRcq69jSs3Spx8UTAosGwo=;
	b=VU8RIu3OHgoFHz0jRNnvzVFLShA3unGa27EMWO3E317aLed2Gf0oYoZM3W+y2GL3APn3gQ
	+LX8F5KAZDBbf/d3Xfz9NToBjq2R3d2M+/1PIaYnm0Fa/nZLLqxg1dHF4EQApXeInzE68S
	wrMEBxURGmct835tXBKJXByqJV3z3r4kLGcrXcJVtoK8/j2p8ded1/BVbLsFsLzQ/uijE+
	6LQTVLfsBxfdpBnriD8bk1EfV4IE38j1FFbnUQDNZluP2PCzVES8odDcWE9HtneSLl4m7e
	VNGdyReayq9RZJG+ldynWmUAAS5NJbZS/dpXBp/U2gOzFCoV9OLLwVvEPO9SiQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Oct 2026 11:47:12 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 Raju.Lakkaraju@microchip.com, davthompson@nvidia.com
Subject: Re: [PATCH net-next v1 0/5] net: lan743x: automatically recover from
 TX hang
In-Reply-To: <cover.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
Message-ID: <c2a65a9425d8a5dbac493a2b4ad3005e@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Chris

On 15.10.2026 17:00, Chris Babroski wrote:
> Background
> ----------
> On a custom HW platform that uses the LAN7430 NIC we have been able to
> reproduce a scenario where the SoC stops receiving TX completion
> interrupts, appearing as a TX hang. After dumping and decoding the
> LAN7430 registers we see that the TX channel reports that it is in
> started state with no error, but TX_HEAD stops advancing. TX MSI-X 
> stops
> incrementing while RX interrupts continue to increment.
> 
> This scenario has most often been reproduced in large server cluster
> environments, but it's also been seen locally during repeated SCP and
> iperf testing.
> 
> The root cause of this issue is still unknown and we are continuing
> debug. It was found that bringing the interface down and up recovers 
> the
> network. This issue has not been reproduced with the LAN7430 EVB
> connected to a standard Linux server.

A TX channel that says started, no error, with TX_HEAD not moving is
also what you see when the MAC stops draining the TX FIFO. When it
hangs, is the FCT TX FIFO full? Is the MAC in LPI, or paused by the
link partner? Does it still happen with EEE and rx pause turned off?

The other place to look is the PCIe link. We had a LAN7430 stall on a
BCM2712 root complex that was also platform specific. The RC driver
cleared an undocumented bit in its CLKREQ#/L1 control register. That
one took the whole MMIO window down, so it is probably a different
failure, but it took days of uptime to show up too. Do the Device Status
or AER registers on the hung device show anything (UnsupReq, CmpltTO)?
Is the link running with ASPM L1 or L1 substates on that platform?

> [...]

I will have a look at the actual patches later today and test with
our devices.

Regards
Nicolai
