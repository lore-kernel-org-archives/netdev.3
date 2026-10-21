Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570022;
	b=eRx6b0rjOlUWyIItczpK6dVnzkCVfm04OfhWNJJyAUGu4KYH0mJDRaVch74cIrfMujYQ
	 5L4/XY/H7TjL7c338DwRVignMnULiESTtJsrJcalq45Z1/vhGEYKN5CzYqu2Vtbo6ktqE
	 dvby0w+u4paiHL3dCzTw150a2x5EUdIo7zdkGOBh8u2JBhW5hbSg+PebPTa5kb0dPwT/h
	 tG0BLWlsIWE+i5vrQcrkvA//FQ6MpaM4riJeeZ3t56v6PFe44HOC6JvE3RwjkRFgB2ctR
	 VTYd+OvMQZe1YeF0851wOUMrgBptHGsZUBbz5QIrzt3ntlssFjxrf88y/uL2/04vaug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570022;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=InVXOIXCe3m05jZFzS8ZP5+QB+qCjxoYFhFi/NTG3Ag=;
	b=z/vIFt+hGI+mS4uJCergtTKotzcor4dhrfXQn/TkOojCEIqrKf5+gIn1A/L0zD65pasm
	 dA1IWzObdyBAre+iiT5x8bRdm6P3p10Qq6kzFw/hqgU7UBOpCWz6JV9YeA0mJ6OKorJIe
	 oPvs4yObdzdhgXY2N38P4nMZgOecukIvA/PzIgv4vL4XMEFcBHWYEJza6u9lElqDuYcSe
	 PZ+qkTMXeedVkX10no5159Z4RV9reC0+YkkCqwh2Xgmi1HaF9v0Olb1wpBIi5NH6mI1yo
	 OMBUdsPxHqQL9e9/zmeuafWYcOKWB/Pzc7zEhxrznuFc9An2TdLD1GrMRtKbfqascpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=aNtmbQo+;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36762606A31A;
	Wed, 21 Oct 2026 08:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36762606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=aNtmbQo+
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0F3EA1626;
	Wed, 21 Oct 2026 10:06:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792570019; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=InVXOIXCe3m05jZFzS8ZP5+QB+qCjxoYFhFi/NTG3Ag=;
	b=aNtmbQo+k5o9kf+g6fQr4GnOKD3RNfs9wIB5WNa+mf2Jd2U2PdOTbYAYOZ+j9cWjhXk5PU
	UA62UzSrod5lncXRgo0JiFlJ5L7RAY1LCKyVRTYQvGch9J/4J83sVO7Yv1PStvPpMU+aM6
	7MR/6NvRumwI2GgzbcdbcwlPibpGF8dYIfS2Lllz4PW7VSS8rsbvjV+wU4o2TfELSvL/0F
	Qzw3QHQfO8K8U1zLxlyuOZoOKrzS+T6zjabqtDXfTvTN2fA/IxdJvXqcX+nNExxFJuy9Kh
	d7nVsbnbNpbrsoMX7+Mby0Nbf3JEvetPr4ZpqR02+SrgizOIeigg1UMjpuJEKw==
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 10:06:57 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Chris Babroski <cbabroski@nvidia.com>
Cc: Raju.Lakkaraju@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, bryan.whitehead@microchip.com, davem@davemloft.net,
 davthompson@nvidia.com, edumazet@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
Subject: Re: [PATCH net-next v1 0/5] net: lan743x: automatically recover from
 TX hang
In-Reply-To: <20261020203641.335809-1-cbabroski@nvidia.com>
References: <c2a65a9425d8a5dbac493a2b4ad3005e@tipi-net.de>
 <20261020203641.335809-1-cbabroski@nvidia.com>
Message-ID: <c0117e4e987c3bd349e56a979cbbdbc5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Chris

On 20.10.2026 22:36, Chris Babroski wrote:
> [...]

> Interestingly, we are consistently seeing FCT_TX_USED=0x34 when
> reproducing the TX hang. We have FCT_TX_FIFO_END=0x27, default of 20kB,
> so it is mostly empty when we reproduce. Is there anything special 
> about
> the 52 byte usage?

Not that I know of. It looks like the head of a scatter-gather frame
whose fragments never came in. Does it match the buffer_length of the
first active descriptor at tx->last_head?

> 
>> Is the MAC in LPI, or paused by the link partner? Does it still happen
>> with EEE and rx pause turned off?
> 
> In all repro cases so far the MAC does not appear to be in LPI and EEE
> is disabled (MAC_CR=0x200C and EEE_EN is clear). I also tested with
> "ethtool -A <if> autoneg off rx off tx off" and could still reproduce
> the tx hang.
> 
> We have a PCIe switch connecting the NIC to our SoC and on the switch I
> can see that the NIC's read requests drop to ~0 implying that it stops
> fetching TX data and descriptors rather than the MAC stopping queue
> drain.

Which one? Ours sit behind a Pericom PI7C9X2G404.

> 
>> The other place to look is the PCIe link. We had a LAN7430 stall on a
>> BCM2712 root complex that was also platform specific. The RC driver
>> cleared an undocumented bit in its CLKREQ#/L1 control register. That
>> one took the whole MMIO window down, so it is probably a different
>> failure, but it took days of uptime to show up too. Do the Device 
>> Status
>> or AER registers on the hung device show anything (UnsupReq, CmpltTO)?
>> Is the link running with ASPM L1 or L1 substates on that platform?
> 
> I do think the PCIe link could be related; our current best guess is
> that there is some issue between the NIC and PCIe switch and we have
> tickets open with both vendors to help debug (along with setting up 
> EVBs
> to run comparison tests on).
> 
> UnsupReq and CmpltTO appear clean. ASPM and L1 substates are disabled;
> the link stays in L0 at 2.5 GT/s x1.
> 
> Recently we found that after every reproduced hang we see that the NIC
> sent a NAK to the switch, potentially in response to a CplD from switch
> while reading TX data and descriptors, but I am not yet able to see the
> rejected TLP or NAK reason with my setup.

Then BadTLP/BadDLLP on the NIC and Rollover/Timeout on the switch port
should tell what went wrong with the replay. Are those clean too?

My guess: the replay hands the NIC a completion it had already counted,
and the DMA engine then waits for data that never comes, with nothing
in the error registers.

Lowering MaxReadReq to 128 bytes with setpci would be a cheap way to 
test that?

> [...]

Regards,
Nicolai
