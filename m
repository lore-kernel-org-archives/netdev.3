Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794620588;
	b=Th0mXLa3RD7Rm/xCY7UcUZYo21AKHISHeTYPj+8womImmPd++JmYwX90rpiSB7TWha2f
	 VqICmjzxngcR8AgQWsFGw30nH/ZS8pt3hEk6j3lChw6JvKvXtqv9m3Z7MV0HSzTGrk7Wd
	 pAURwEg7KeZbZtVQu8Tqv+fmUbcxDm8AscqOEGEt1QFxvNqYSJb1Inr+y43Z+WPPqs/cJ
	 kV6yfFu9KcBTN7FLbKeDRvrPzAhY04w2SreqZheYdok+/udPxx3aHSnOGpYocszV/6qe6
	 czVDQgl4QUNmVYI6KXmhjCgOTiTyyg9UOxpgvDllJWPxEitIY8BVaZ3sqnt9QRA4+Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794620588;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=gSEb+snyfa1C/uq6HcvChYZZgnf95qnnJ9XhmYpvJKw=;
	b=EOnPqcsLDuJuSbzv8LnaeRX0ZHWBdmXSm9m+LXnidHw5lrpsNZQ8WZb4Xe28YnDvQcM3
	 XniNMX3X7lPaD5rCfut5oemVtuAp//h3NhUYh8YrPh7OyQiB1R4t23ELfY5+4jE0lMLBh
	 lwyQSNWI4ZxnG/Z8d4cvfx6TDiMkbjONJjITVXI1QmSKGVk1138E0k6VxiHtazbdvcu4h
	 Lw8EQHp2dinX10ujcN9ILILzh1ENVbpXrpnxPXvMolAUhikCJDUbv7D8WbWUKTit4nRBU
	 Ll8EI4eVHYjiba0aPB9wyR+394PbuIFRKXXEJ9PLcEXnUENN5nuhEt+rej4jOaNMUgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=NYEG+OLN;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A59606A329;
	Sat, 14 Nov 2026 01:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12A59606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=NYEG+OLN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1794620584; bh=gSEb+snyfa1C/uq6HcvChYZZgnf95qnnJ9XhmYpvJKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NYEG+OLNirTlaEbmgMVDHePjD+O5Gcvr+aVUcCRGYNMx3syZ2G/LKMtPKlukakF08
	 g6NPVH4ChgC/yvJycWb0iszBO3r/pvLxNZYY3r3dowrEJlZoKGUWGe2Yewnxn49oHr
	 R8mkgNKAfVPCY3WTUnaLIGdGCtE5JfZDjoFMrt6YZLh7btifzyl+pQaKqQyMlG11Og
	 bIBpWT6J0M5LuLdc8OM71qzv2JnGNmIWDlgUJMr055fcamtXACwlM4TAGyikGnVawl
	 pc8eCRBMakXdGghrCy1RfukWF/BY/jYvueHvEFxbq+Gqz+5DTbZVqe8Co/HvauFivd
	 kbYhwes7/OKOw==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 1F71B27A688C;
	Sat, 14 Nov 2026 03:43:04 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: netdev-bot+sinfo@kernel.org, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, Daniel Golle <daniel@makrotopia.org>, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 1/3] net: ethernet: mtk_eth_soc: fix the RX descriptor address on the release path
Date: Sat, 14 Nov 2026 03:39:07 +0200
Message-Id: <patch-18d5b24e95d7d6baf74f3486715cdb10@loljews.com>
In-Reply-To: <179461633631.2168702.17586474086593763386@kernel.org>
References: <patch-4b4c5003bcf028fafd094e719c5e910b@loljews.com> <179461633631.2168702.17586474086593763386@kernel.org>
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
Content-Transfer-Encoding: 8bit

On the automated "looks like a fix" inquiry for this series:

The change in 1/3 was found by an automated review, not in production. The
reviewer read the release path of mtk_poll_rx() and noticed that the guard
added by 6e0490fc36cd ("net: ethernet: mtk_eth_soc: fix SER panic with 4GB+
RAM") relies on dma_addr being DMA_MAPPING_ERROR on every release, while
e10a35abb3da ("net: ethernet: mtk_eth_soc: fix uninitialized variable") had
moved that initialisation out of the loop and left it valid across
iterations.

It has not been triggered at runtime by us. It needs MTK_36BIT_DMA, DRAM
above 4 GiB, and one of the early release paths (no netdev for the source
port, MTK_RESETTING set, or a refill allocation failure) so that descriptor
N+1 is handed back with the high address bits of the buffer that was mapped
for descriptor N. The visible symptom would be the engine writing the next
frame to an address that is neither buffer, and stale contents of the
untouched buffer going up the stack; there is no stack trace to report.

Hardware: the series as a whole was tested on a BPI-R4 Pro 8X (MT7988, 10G
port) on a 6.18.60 backport - 8K ICMP passes and iperf3 with MSS 8900 at
MTU 9000 reaches about 9.87 Gbit/s - but the 36-bit path fix itself was not
exercised there because the condition was never hit. The v7.3 series is
compile-tested with CONFIG_NET_MEDIATEK_SOC=y and COMPILE_TEST=y.

As suggested, this is a reply rather than a repost; please apply it to the
series.

