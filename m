Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610200;
	b=0mYbV+SqSlM3n/p5Rxgk47mwQqlh5V4Ggz0pMSLJUkYOGbtKlu7YYdDLCVz55wY1eGmt
	 +YWfXxLeSbB5DvlxfDVSO8bbF9y7T6sD4eScQiJnrdS3hG2T6p0sv0LhsUkgLfEzXhluc
	 Y8rrjL24HSDgboc9+TLkbJmswgGRZlLKiaKjt0eYqNRVI/6qZyZ5/TW/xQ+qDBkZxMVas
	 yjERPgDaESR0dJ+om/XCVaW7gk/KxOcIc2x4UrvxEVTHUnZZd6fg/EBQ/Og87YdBHysb6
	 zd6KuTzpfgBVBQfyJVQt+Vqay7M9jfxxncFCYN9U0mc6Nh4SnGuSEIMjBpvGNs/ekwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610200;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dzgmecBVachGINg3yF3uYgoPmBMO2/R7Vya4aZJJS/o=;
	b=Lg6eP8CeuZ9n9zddmgTWZJx27yYoXaW0hvXHtItS/eZ1evw0cPFoG3QsLV1s452CIZA7
	 9OPIl3wVncGItPXu43lkh/V+ud+QkU7OrkKUitSON/f7qRnf6I7ixlswaNai4Ih9565Gm
	 t+kX9Lv7Tn+RUaC5r/teERMjEZd7nbobSFHvt8Bb44LvaiDMjZ/0Z5FCAMlL3lyCIlW39
	 7m1HQ6qXnJHE3twzG4tmeFkshrrmBBQNEUZLfRhua1MedqNdlWxE3VZUfhzTr2uS2YUFv
	 Mx9KyYOTT30mI0pJs6P/Sgo95Z3g35hJw90P/eobF/KlFjxpr2vWlQ2LOIHqB68D5zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=EYZv+AQP;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2E606A324;
	Mon,  2 Nov 2026 09:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C2E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=EYZv+AQP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1793610196;
	bh=TBb/GsUsOb/1xhSwjR7HNDvxrH90IM0dwt3lhowgT5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=EYZv+AQPRMIjgOOoVuctoIf7/3Cc/VK9FrUWQCLvmPx9BOgesu8Q4KdBfYIbhfAO9
	 H/0Eeemb0vR9sM6FGkbAUDmP2X30EZPfOqYbFt1nq6DrcGyXIieuAKQmd5Wwo40ITT
	 a3STA24Y1BshPbVXGqQV6QHLZVk07q75w6Wh6Q1kKYv8D2pSwKlBy+9wIxHRW0jJro
	 FUfa1H0pOEHn7UhYyY3nSE8fT/zjs4O1LBHSMoZfUlvMWdAkdUPfTUrro14sbTrkPU
	 qC0s2ElIj8K0A3F3wwzGsIE3fWrRP+S4u0ZoxlpIEkLDJhWDzVBBb/dil1GwoNb4yr
	 7bSGN2ajdvyKg==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 9486F819CD; Mon,  2 Nov 2026 09:03:16 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Yao Zi <me@ziyao.cc>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-motorcomm: mask the MISC interrupt
Date: Mon,  2 Nov 2026 06:02:41 -0300
Message-ID: <20261102090241.5862-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <805aeb73d9e32b237bcb30c8fd44ffed@tipi-net.de>
References: <20261102080938.2955-1-magnusleatti@kernelriot.com> <805aeb73d9e32b237bcb30c8fd44ffed@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Nicolai,

On 11/2/26 09:29, Nicolai Buchwitz wrote:
>> +#define  MGMT_INT_CTRL0_MASK_MISC		BIT(21)
> 
> Where is this bit documented? The vendor driver?

Yes. The vendor driver writes 0x00200000 there unless it services MISC
itself, and the yt6801 driver Motorcomm posted in 2025 defines the mask
field as bits 16-31 of MGMT_INT_CTRL0, with MISC as status bit 5.

>> +	writel(MGMT_INT_CTRL0_MASK_MISC, priv->base + MGMT_INT_CTRL0);
> 
> Doesn't this turn off the stmmac MAC irq on vector 5 completely? If so,
> please mention it in the comment.

Yes. On this device vector 5 only carries MISC. I should have said so.

> Also, does the MSI fallback still get RX/TX interrupts with MISC masked?

RX and TX have their own mask bits, but I did not test the single-MSI
path.

Maxime's patch fixes the hang here without the mask, so I have asked
for this one to be dropped.

Thanks for jumping on this so quickly, Maxime and Nicolai! I really
appreciate it. Have a good Monday :)

Magnus
