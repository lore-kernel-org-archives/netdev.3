Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725130;
	b=nvrMtO3Q67bicckOK3SdA42WXjoEoiyeGM+pfGmWk6k5laLdnjdYhOkDCZlUuX8ZYn64
	 tqdrF9GIFepvqg8N4exqjRMqRJnk0U//iQ+rNZlSvgvMN2KkPeyrYobWXCd2OyiebalKx
	 ThNk6EfQmBqQoOqJU6rkkSKgx+4jO7anaIJr3vhYyxM2orCV51cZJ7gr7zyzZ+ASk4N4A
	 Q0giSQ7CdrKoDJK8DxVcmlMOOugrwdj7PAKc2HK2FKy6jbTgsk4ff7VICbEMG070j1Nwj
	 5FxM0gO8jabkhfBUZcS1OBPPhYdgzSgeyF7vkAt0jGhNCltqMDMJr/GWC3kzBbc00ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725130;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZMykjE/7l/jsGdfR+n3nXl+yG8LC3pOXTPVPEB8YOmA=;
	b=mhP4cXPAyXICWv3sgPfKLS/34agGYwl8UNQriQoSdNoLcrSOHHS73/6qoPTD0iRF3fiH
	 3ybGSng7/QrGdapOONZ3hRDW+l4tkt0DRdMHKomLA+08J2+6ComZ+x/y2UcHfg8wN486j
	 y5W2TR2zxelFgukJH91tNNjl/ygAcY1JXPGk9oyfwah9QY6IP4yBNgm7vmORo44ddaSEF
	 9jEsRjgyNd/gCOQgc2g8W/OLynuhlQkAo/ROGkCaRMIjCJAxepD1fq54ixpSU3Mr77BQN
	 alh+G80SsqsXugO8+e1kp4wMu7D0I+k9W3SBcM5qHY4apbmtHPUdjKXFx8akgkOpw3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b="h69B8+/y";
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8FE606A332;
	Tue,  3 Nov 2026 16:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB8FE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=h69B8+/y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1793725122;
	bh=kLOhx7Xp1VWwEDJ5YlOdluqX5Krp+Iu/TEbVQCaGCzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=h69B8+/yiPfxJltzpSCRsWhjrdhAv1T1htNv6JY8a6Fi7iWIr+n5mGw5eV5u4fhiZ
	 U3rTaOac/nhkUE941dJOI5Wwa9vi68uz1fQUFg6tALuvD9cG6DFrDjXfjR3zb+65TP
	 KyNroY/vhYWr0jIoX10WYzLdmlF/zDgX9VclOUAae32i1d6MNU0Vowj/Qeu1FJih1+
	 mRpfEYu8m2RtOWbDrPWGCYTkVKDFqXVXsLu7WyIuWH/TBQnvgLbtHVVSfdl/fwxu2d
	 SFMv1wqhU5fBsK1Qku6vTDyqz2lfTwH9ntoebpcxNXx+TA39XytP9M1PADd2RLuR3F
	 +EwdBgYwNj9mg==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id C0587819E3; Tue,  3 Nov 2026 16:58:42 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
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
Date: Tue,  3 Nov 2026 13:58:08 -0300
Message-ID: <20261103165808.72113-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
References: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
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

On 11/3/26 13:54, Maxime Chevallier wrote:
> The Multi-MSI interrupt handler doesn't clear the DMA error interrupts,
> and this leads to interrupt storms when one of these interrupts starts
> firing :

Retested v2 on the YT6801, same setup as v1: net at cb284914e749, glue
unmodified, so the MISC interrupt stays unmasked.

4x 64-byte UDP RX flood for 10 s, same kernel:

  without the patch: the MAC interrupt hits about 93k/s within 4 s,
  stays at about 122k/s after the flood stops, and the machine stops
  responding.

  with v2: about 300/s during the flood, 0 after.

8x 64-byte UDP RX plus TCP TX for 30 s: about 25/s during, 0 after,
with TX at 744 Mbit/s alongside.

The 4x flood also runs clean after link down/up, ring resize, an MTU
change, a 100/1000 speed change and a module reload. Throughput is the
same as with v1 (TCP RX 941, TCP TX 825 Mbit/s).

Tested-by: Magnus Leatti <magnusleatti@kernelriot.com>
