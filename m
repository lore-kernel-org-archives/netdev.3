Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792539904;
	b=vSaDGdgBy6fuzSd3TMAgRt/nZlQSvADvpaX3ZUSpRfyxDAAOATvcGPUKFtD95wjaTXm7
	 4Vb0wdpphy2/oY8HXC89RvnQiJ1e8rdA93+Q9vRMH9jjji7NpaxXLvMBFY7uqpvEAHDmo
	 +L6DDLCHBSt9GE6hDrElq7Ror7Xbx+dy0aq0AqQJryUCHTaEocQqV9vZ87LJx5I7y6+OF
	 /vBWAXV9qG9lgE1n3a6UaoLFbRM2Lj12+9/RGx514Efa4Z/C+yqi3qjBGmX45qnoqn2A1
	 +qyc30xWHf2KbOft8fdRF2OlvIEPKSX+2rAOzMO5gIewHhISKE/3WhcdIJIT4eBXvYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792539904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FBOQc97nZrdHAQNgEpsF/r9Rzn0ftT3U1q/pgQLpdjk=;
	b=A0B25G/PtzPvWBg+7EJvlhMbnMVQMP+cTZKLOb6aQmOgxR05lH2/r8eN8piYFPncow8H
	 I5B6dNKC46aBb/obC+FzgytTt3domd7EP2EdPdaLZeL9a4/bIEuls37ew8jr46ZDosc4X
	 5VeZIFQl5fIaIeWaWDxOl02HyO6H+QUyJUZVDM5dW6sbZuKh7G22gWWIsouzb9QdMSh8K
	 PePAE6f0ursfIxBPAbH9knnIcD3ZXr16bM1hT0ejSUi7S9+f4EqaYREAYdOxQ8IIOhoXx
	 1BnqBdBZ6PfaRyShw6fyu6PkY/zj6yrK+6nWfrimII9qyukAPf+Vgvpyg9g0Rfj1bEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0nRTSQa;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB2606A31E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 23:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5BB2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i0nRTSQa
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1717761a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792539902; x=1793144702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FBOQc97nZrdHAQNgEpsF/r9Rzn0ftT3U1q/pgQLpdjk=;
        b=i0nRTSQagxndf5XvpYRinhbw9rj8Ro4ZwFe6n24flHdddd1nTD4li+/VBXjySdAmI9
         mpVAuwLFQsJQ9GhfYspnIqiROLkRmQPumQnsI4NMSNmpqd7vytGGB+1wC54U4C0v164z
         PfCdyNdz/NshhBze1Z4YOThkzj8XCtvA7J7uo9+szvRzZ+6aT8JmgwcQwYaLOBgQEuNV
         tXXzBw3cRLax9vAClZ/O276cMHJ3yMuYjNWIS+ArzyvrJe52/+314p2s5YHbymO1U85M
         bSSPnaKsjIcgafHUYNnWFupeMZ6WJwdIBJAoygyd5RfdHyGQEiczsHGfdro8lqQO8itG
         bJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792539902; x=1793144702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBOQc97nZrdHAQNgEpsF/r9Rzn0ftT3U1q/pgQLpdjk=;
        b=Bjm9yRDkipsME1ExWMevq2O8nQsFCVtoOFb1qolhHR/X2J0F9pA1mHMwzwKGjFz+LF
         o/RPsy6s0BbKxr/Uqnr0h72LIgg31f4VN2zG7g73MhGliv+7L6Lh15kd2fIx3jrRPu+Q
         934uoqVYokriOOVcSKGmMZ90pgiVukXXMzYci0kfDoNhUZT61XDKkVW0g7x9LN/UBHrG
         1jSoutq9+18TCMGceT2YhBQFMu/B0dbXMP+fgP1og71snAhEI50/Ty45f+KXx2lo96oP
         26VOwwntZRuU0jvK/NoJE2ZNt9fOm3ubPDPul5Zr+PNiS58wIjyEmd0zqc84IK8sWghu
         WEGw==
X-Forwarded-Encrypted: i=1; AKwUvByrviPRGVwwQmVKXPb7Lm9tJlSrRgK/bElznuzaB5NJrx+/sEJC20OAAh1rnHDSXGgs74DEUsw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIh4QHE9PkAFgTdm3JUTLRPJWpj9WRcvgdw4fk5z5qABmzQNJjR
	z2tnrXP8FxhFZ2E4SacgskRAvsXvMERAXHeKTRMXsuiiQRkwD2kf8W/t9EsWmyzM+cBPqidG
X-Gm-Gg: AYBFou3J7OsGnLNN3rBeJzzEtV7frvXvj9NFhQDyioBAdoMbkxQwZJMUffG7vZf9Tfq
	GdktfnFPztkbKpogG94JFYdeCxo/5QEaUCvfunfklBJyOoNpwhdfk3c0yVAJMqZBDn7B28qimOi
	BVUvLa2Nz87am2Wf8KlTDEcuNYSyPlaaoXWkaf3HhQGtYcQC0ovNbgxBaAJyaiyDVULXsybZsP3
	F3rQjnxDw9sFuGfuFoAsmJfSWq+U/fbed7kxgymYGZoTIxH6AlW3DHnznUpA4w//BjtcJWbmcJD
	eifsPTMmYwhrW0s0OVBJFXXfXaeTE6f2F/Gvl9WaDMVCI7c8B8ZzdJfVaeR05qi44CtrknnlDUk
	CSOrCd7xvEH7C0K3Tiyxy6lRCEVhyzmb+yRJshfLCZPJJ4HSITVRbROvYmCvGPS0JfTJ4RH19Cs
	CyTBCtMAcH3c0fCMPgqZqvYu460PNwTYI7JGGJtO+6c+JNh05sLvs8siSxAsB/n2gBmJ0W0pkUF
	SMIXI0rl9QFC+8WCVQydkdTTff2QQjSvvUu+SuKGv+LRf5r+a8JKs9r7UqzNVT7EMvkPCnT/Q==
X-Received: by 2002:a05:6402:5190:b0:6aa:12f0:166e with SMTP id 4fb4d7f45d1cf-6b408ef00b0mr147336a12.16.1792539902101;
        Tue, 20 Oct 2026 16:45:02 -0700 (PDT)
Received: from DESKTOP-DIIS71I ([5.18.141.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b403110fd7sm216863a12.20.2026.10.20.16.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 16:45:01 -0700 (PDT)
From: Rand Deeb <rand.sec96@gmail.com>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	deeb.rand@confident.ru,
	lvc-project@linuxtesting.org,
	shda@confident.ru,
	Rand Deeb <rand.sec96@gmail.com>
Subject: [PATCH net] net: sundance: fix sign extension of the octet counters
Date: Wed, 21 Oct 2026 02:44:34 +0300
Message-ID: <20261020234434.318-1-rand.sec96@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

get_stats() adds the upper halves of the 32-bit TxOctets and RxOctets
hardware counters to the byte statistics with

	dev->stats.tx_bytes += ioread16(ioaddr + TxOctetsHigh) << 16;

On architectures that use the ioread16() from asm-generic/io.h, which
returns u16, the value is promoted to int before the shift. When the
high word is 0x8000 or more, the result does not fit in a positive int
and ends up negative, and adding it to the unsigned long counter
sign-extends it. On 64-bit kernels tx_bytes and rx_bytes then end up
2^32 lower than they should be. x86 and m68k are not affected, because
their ioread16() comes from asm-generic/iomap.h and returns unsigned int.

Cast the high word to u32 before shifting, so the result is the same on
all architectures.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
---
 drivers/net/ethernet/dlink/sundance.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index 58873fcd3..cbb1f1fe1 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -1545,9 +1545,9 @@ static struct net_device_stats *get_stats(struct net_device *dev)
 	np->xstats.rx_mcasts += ioread8(ioaddr + StatsMcastRx);
 
 	dev->stats.tx_bytes += ioread16(ioaddr + TxOctetsLow);
-	dev->stats.tx_bytes += ioread16(ioaddr + TxOctetsHigh) << 16;
+	dev->stats.tx_bytes += (u32)ioread16(ioaddr + TxOctetsHigh) << 16;
 	dev->stats.rx_bytes += ioread16(ioaddr + RxOctetsLow);
-	dev->stats.rx_bytes += ioread16(ioaddr + RxOctetsHigh) << 16;
+	dev->stats.rx_bytes += (u32)ioread16(ioaddr + RxOctetsHigh) << 16;
 
 	spin_unlock_irqrestore(&np->statlock, flags);
 

base-commit: 4cbdd58dfa7aaad679bf62f81cdbc96a6cb7c6ae
-- 
2.39.5

