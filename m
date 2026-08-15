Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51EC38F922
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786823690; cv=none; b=ExDiTs3aTt+6Vnpnrk4fWl6x5g5t2p5BvRNtKkcIlXRbek7MTmMkkurhl4RZdDk0Ff2sIFAn1YbJKM2HSWUwJMbkfvnwtGa6zTD2QeUuVbAmL3Munwux9Mx4+uaDil5K9E4FMDgHRsSzdcvC1S2EfPU4XrKQa9TU4pScrk4DWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786823690; c=relaxed/simple;
	bh=miYZtHBGCb0g+aO//LIJcOYPt0V4WopWlWDWAMp38PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VCqa9ihv+h5XTxPTNwFYRZOu48gUFrsbRQMLjzpFbH8lhSlUf0jp0JbovWxTkgdPusBI5Uy9tgv6JKBfx7L1h7uwic36ZCBvEbPWtjseKQ0EECMGTNK9nxO19X9NdNaxYX2lYDNMJpMT3kwV0hQqDEzciooR/fyhjJ8q8PYJ8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxhcxBai; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxhcxBai"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4955c545a94so2594335e9.3
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 12:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786823687; x=1787428487; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OdMM+C33OrYXg8NL1f3naTX8b+0PfXP8Ol11Fi77gWE=;
        b=lxhcxBaiKQzmLR2Xutttic1WuK0v0mxfAiwXNHguWw7DkVp2+8oLsDE+/iuo5JnyZ0
         WO1XzBNWZD+Z2LSNBVZtxqanZZXyTUK7Etd8v6V78r46bWuTQUHY6gL4st3lQWqfm00G
         263RT7IR2nKpiozNz7CLfqpFHF+idncz9ipCSLc6Dn592Mp280swu2mGltw3dgP8/57a
         MM+BKslsFxunB4SN6WyT2XKrRPlVLCu/l2e/i22g+tjE3irMNmyzF9MkPyCLIk3UBdxg
         z6/YGZg7IRJetzd7Ev9ht3q5QqDUVb8wWcWZdietN2hBQ4l1UfL7el285EnszbB+lXof
         hVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786823687; x=1787428487;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OdMM+C33OrYXg8NL1f3naTX8b+0PfXP8Ol11Fi77gWE=;
        b=Gy2AibKeY0NEEV1uIusO24+0GF8cCnTd+gG4ZyjFUVaGF7f7rj7m5W4yDIvSyta/xh
         +dxSu+4b4MsfS1MfBNR6B9yKwk/KOq4uWk2KTiClqFnoI236mhlSJoW8hXvO68OFR0TW
         BRptxCVZQeMT+6XfNncOd4J11RNVdt5Aqz0gp4Y4zm3Ugv3wURcM6lX0AdVAcLiWUQw6
         ROrPpT3KU2613Y8cRxtSNliEIubKB2wXLKl4cVQzNSHKCF+9yUe50vGQX7y2tVTtMsPs
         vcdAytO8hyxxzLjvga/asVIOeDGRERYwpxgs6U7e6b4ZYXXTnS6y6xDVR/bEvbFN1P5+
         wjxg==
X-Gm-Message-State: AOJu0YwjA68UvDSZ6RRGlB1KCXJSz2I88+TvH5QjToHudVj2Tvf8Q/GR
	n0VaDqEuWwYEmmT912sUfMvOXtTyRrUhCctF2KzcJC4fAxEaJbshbFDfYSQoyixO
X-Gm-Gg: AR+sD10woUh0cg7pJCinbBB/EURf3gyOrRFMTcONtRvCKy4b2Dh0ArYbzCc3XQNpwxo
	ko2pNFuUSiFAvrpyAs6uXFuPKNU3KtTRIxtEV/Qp8gmmRps7Avh9TgKybAzjTqAjVxakTRhkQY2
	D2Qon/0lHnVDJZ1sUSbYSpOp7PTm+ILlNO4XQe0ycSMI/1K4OQsIUjUAjdQdT6qjOAlarDxtrRE
	KBxyMQqQVtitixVQ1jdWenARoiX74WT3alHKTZCATzn1PxI9erHQpCTvcYT85CBQ4l5pkeH8pGt
	VaL+MxDAI3qZ4ysLs6H7FysmXcOckweHUvq2j1FkpGeKDEp2fLyJp81A4AEqVSWaLIB3xYP2e2o
	MSpnXQJ21NDKdjYO67Ur/Ij9moWexV10ez7Ppk3p/wPoN+AoicucbNhWBr3UjdPZWt1V6ATlaU/
	l4cehUQHYOkKuvpeGl9sDlfDGKKN3fU3Prv69S8Ti3boCFQBCXVE+/MKHKphod5ptLrhHYo6nrL
	YCjTc+7LTttuBaaGFztfBRdd164ZjoCYgMFQI9vfw==
X-Received: by 2002:a05:600c:8106:b0:495:4505:dad0 with SMTP id 5b1f17b1804b1-49987961eb8mr112534205e9.2.1786823686886;
        Sat, 15 Aug 2026 12:54:46 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c46besm18757609f8f.31.2026.08.15.12.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 12:54:46 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: netdev@vger.kernel.org
Cc: Rain River <rain.1986.08.12@gmail.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tobias Diedrich <tobiasdiedrich@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] forcedeth: stop the tx_timeout register dump past the
 requested window
Date: Sat, 15 Aug 2026 21:54:38 +0200
Message-ID: <178682367886.3748309.6978554332066826294@gmail.com>
X-Mailer: python-smtplib
In-Reply-To: <178682367884.3748309.5288746298966501007@gmail.com>
References: <178682367884.3748309.5288746298966501007@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Marek Czernohous <marek@czernohous.de>

nv_tx_timeout() dumps the register window in rows of eight dwords:

	for (i = 0; i <= np->register_size; i += 32) {
		netdev_info(dev, "%3x: %08x ... %08x\n", i,
			    readl(base + i + 0), ..., readl(base + i + 28));

The loop bound only checks the row's starting offset, so the final row
reads a full 32 bytes from a position that is below the end of the window
but too close to it. base is mapped with exactly that length:

	np->base = ioremap(addr, np->register_size);

so the tail of that row is read from beyond the length the driver asked
for. Per variant, the last iteration reads past register_size by:

	NV_PCI_REGSZ_VER1 (0x270): row 0x260 reads to 0x27f, 16 bytes over
	NV_PCI_REGSZ_VER2 (0x2d4): row 0x2c0 reads to 0x2df, 12 bytes over
	NV_PCI_REGSZ_VER3 (0x604): row 0x600 reads to 0x61f, 28 bytes over

This happens on every supported device, not just one of them. Note that
it is not a consequence of the sizes being odd: with i <= register_size
the offending row is reached whatever the size, and a size that were a
multiple of 32 would overrun by a full row rather than by a remainder.

To be precise about the severity: the reads stay inside the BAR. Memory
BAR sizes are powers of two, the driver only accepts a region with
pci_resource_len() >= register_size (forcedeth.c:5757-5762), and the
next power of two at or above each register_size already covers the
offending row: 0x400 for 0x270 and 0x2d4, 0x800 for 0x604. ioremap()
also rounds the mapped length up to page granularity, so the reads land
inside the mapping the CPU has as well. What they leave is the window
the driver asked for, not the BAR and not the mapping. That is still a
driver reading registers it did not ask for, and it is trivial to
avoid, but nobody should expect a fault from it.

Changing <= to < is not enough: register_size is a length and every size
above is larger than its last row start, so i still reaches the offending
row. Check that the whole row fits instead.

The trade-off is that a partial trailing row is no longer dumped: 16 bytes
for VER1, 20 for VER2, 4 for VER3. That seemed preferable to reading
outside the requested window, and to open-coding a second, narrower dump
for the remainder in what is a debug-only path. Extending the dump to
cover the tail can be done on top if anyone misses those registers.

Only reachable with the debug_tx_timeout module parameter, which defaults
to false. It has not been observed at runtime: forcing a genuine TX
timeout on the reference machine is not something I can do safely, so this
rests on the arithmetic above and on a build test, not on a reproduction.
UBSAN does not catch it either, since these are MMIO reads rather than an
array access. It was found by reading the function while fixing the
saved_config_space off-by-one in nv_suspend() and nv_resume().

The dump was introduced with a fixed 0x400 bound while ioremap() mapped
only NV_PCI_REGSZ (0x270), so it read about 0x190 bytes too far from the
start. Commit 86a0f04387bf ("[PATCH] forcedeth: fix initialization")
later replaced 0x400 with np->register_size, which shrank the overrun to
the remainder but did not remove it.

Fixes: c2dba06dae7d ("[PATCH] forcedeth: rewritten tx irq handling")
Signed-off-by: Marek Czernohous <marek@czernohous.de>
Assisted-by: Claude:claude-opus-5
---
 drivers/net/ethernet/nvidia/forcedeth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index dc804e111564..f0218a0eab5c 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -2740,7 +2740,7 @@ static void nv_tx_timeout(struct net_device *dev, unsigned int txqueue)
 
 		netdev_info(dev, "Ring at %lx\n", (unsigned long)np->ring_addr);
 		netdev_info(dev, "Dumping tx registers\n");
-		for (i = 0; i <= np->register_size; i += 32) {
+		for (i = 0; i + 32 <= np->register_size; i += 32) {
 			netdev_info(dev,
 				    "%3x: %08x %08x %08x %08x "
 				    "%08x %08x %08x %08x\n",
-- 
2.54.0

