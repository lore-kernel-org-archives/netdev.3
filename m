Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304358;
	b=tRznYmiWmNctRDdRokRdR8jCJaX/89ZiyqC1k0KT4rg1EZ3VuiSJOxchbD64t3fiVFBB
	 UpJ5gwTt2zbYPq7sjwXebmFMtlis2f0/TZREDe4upFMfhpMNXz9z3ixWolKKO7dMnetZ2
	 wfkew4dYkdksZBoe7qcNdqZNoiU68D4uWhpTXRJ6uQQWO3OcIqktmFIeik7mrW386N9GI
	 TwKpaLDVJHLvM48UuEfcnLPhfKWMJxSwhqRpqXM9ryMgegobOxIAt5fFfwjTVvN1aEXH3
	 bMsVhPzVhCwnozfW+LYKE0qLPvO32r9DhMunxrfp1ZzsFNxjjDU22/c6kBChEuQEVgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304358;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n0D0+tx7FbyqEL0k4/TajM7uZjJ5rllM2A/2eggVTKc=;
	b=Da2rvd+iRt4k344O52ayxllB3gqaN0xdUMtOU4QvISRXB9wzInnlGsDPKC4DORdwJEBW
	 DmJp7YqY+qk7YS7tnEkOcC4A2kIuuzgDlE4f/7GFkcFlx1elXjo401HVLH1XFD5iMBP4x
	 zJt5v74KvBRITN2GOympLMG7Q3GYAXWjdpG38vLEgCPcAivliQN2kqjlPDlDEMfeYPIZx
	 hb9Za5doslZA/8cZ5FNt6l8IB+lRn/f0/XhvjW6NkeP8XkQA8kR0vjwKJRSPet41uUa2h
	 jiR8CbyJt7/1HdObYZAbPE99SbBMW1Ow0vwgsN78hueM+cbSbE4ByzVR41U7i9mGUaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=IIflIg2E;
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3A606B149;
	Tue, 10 Nov 2026 09:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CF3A606B149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=IIflIg2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1794304357;
	bh=OmSerbMpq8gn3IS3GN6ckwDmRq4C2MPhAgkxcbG8rmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=IIflIg2EfwUPjp+E9jfJgmJyWG5mRTMPmDy/lrl2OeraBoKAvAo4jC360znMbuDNy
	 v+qsloPdkEaIdJBwwfLnuNRQLvvO2AMF+D9yMzPhzQ6zvjArQqmtmgdDk4HDhRucL7
	 0a4tDEdI1gQd31MAAl8FEczSjOzSRFgHl1L1W25Yk6yEJ9usOBC3DckCT/1KFesMvB
	 wU5c2x+3uRiwrvLZwaxtood52WGXUjvKrZAsau/MittT5xXsiEhtMuv9a2sBFGQwwm
	 oSnNRoxqgtLyQ7IM2jeX2SftUooSlFygvoVY1hqXrMi15eFnfDmv20Gx4oriJTCB84
	 zgTht6z0VKkXw==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 40D4F81428; Tue, 10 Nov 2026 09:52:37 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2] net: stmmac: Clear DMA errors for multi-channel interrupts
Date: Tue, 10 Nov 2026 06:52:11 -0300
Message-ID: <20261110095211.16184-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <817d2bd1-64fa-4a6f-bec6-5a4dd4d3a76f@redhat.com>
References: <20261103125430.962715-1-maxime.chevallier@bootlin.com> <179379704484.488856.2140619507341432623@kernel.org> <20261107100140.8279-1-magnusleatti@kernelriot.com> <817d2bd1-64fa-4a6f-bec6-5a4dd4d3a76f@redhat.com>
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

On 11/10/26 09:30, Paolo Abeni wrote:
> AFAICS 'statistics' here means accounting of some corner cases errors. I
> guess this could be a preferable route.

Hi Paolo,

Went and measured it, since my numbers from this morning only had RBU
masked. YT6801@7.3.3, this time with RBU and RPS both out of
the dwmac4 abnormal mask.

Floods first (4x 64B UDP, 3 runs): 0 MAC irqs and ~3.2M of 9.6M frames
delivered, in line with v2 and with RBU-only. Still 0 with 8x UDP +
TCP TX on top.

Then RPS: each XDP attach/detach restarts RX and raises it once.
MAC irqs per attach/detach, 3 cycles, idle link:

  both masked:   0
  v2:            2
  RBU-only:      1.5k - 25k
  stock:         0.9k - 32k

The fun part: I expected RPS to take the board down the way RBU does,
and it didn't. On stock and RBU-only it's a burst that goes quiet by
itself, and the box stays reachable the whole time. My guess is the RX
handler acks it on the next frame. I did not try an XDP attach in the
middle of a flood...

So both masked is the only one that sits at exactly 0 everywhere I
looked. The price is rx_buf_unav_irq and rx_process_stopped_irq, which
stay at 0.

Scope: I masked them for everyone, like d3265c19b35d did for xgmac2.
Masking only under multi-MSI would give the same result here and would
keep the counters on single-irq platforms.

Usual caveats: one board, and it's a 5.2 core so only the 4.10 mask
ran.

Magnus
