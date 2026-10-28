Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203449;
	b=sJi3BJ2d5yG1a4xD353je6NMGapEgBhMaOAelYwjec3d4X9GyeZ0ofv/587lUBeTE5jP
	 SGT/FGQAg8DeRPnebt7FAK93mP/NZ0hWAT6U7Lop0JNi/9EKEXBLvb4Vb/aNaapWuXjl9
	 CP6yvamG8f/ozhOxP6604qrdliIGeHWajOCUWHUEiiJ5UuK3XBSmB5IxLeI5vJxlLiJxi
	 Z/Tya9ji8skGEUgZEpRSC10T64cx+XLqygco0MZyWjWLmXX0Pl3VqdjeYkVUP9atluEzK
	 6J04CUtff9Hogdq44xc++0yfAgxCC7rE1TWwVc00m8Omp0V7MZWXDJet/WRpCANrMdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wW+/Xd8Krv/fKYtWcQLYyD+KltWSe3OXoRZLQJCTD0I=;
	b=fkt9e33KUDX7N724FthTmjIOAEnRQBFcdOYupKKZFNWVUFPPc9ai1XR0OP8Ihs+z8kAn
	 6U3f1Yu3h0Dyrswl6hSeMHCNFI0l873VPUOrJ/zJT6ccIYGx+2lI8Tl/nM8l6nhuFP0Do
	 JBQMd0CpVufBHKqORevrV8YvlWhe0HHWUpzg4CkEVNPBSTz3DDpzvCwSZRKjUuYp8HuAL
	 KJos1Vd2c7HUdNtLTCLIrOnPRWKM1QGKXwYvnMDy0gzarxGAuYMTift+Tf+nO3kGLZd9/
	 sqMQHl1lu9jAKA5kvsai7fhtgHmSbyCthOfv3ZEBatckjwqFd/OOPCk9e7HUl/1pVGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="h7w/6mjk";
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8F606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 16:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1B8F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h7w/6mjk
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-9909e82513fso852081241.0
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793203448; x=1793808248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wW+/Xd8Krv/fKYtWcQLYyD+KltWSe3OXoRZLQJCTD0I=;
        b=h7w/6mjk6+6kpdKforROPrJX+UDA63yf6nVts44aIrSXJJDyONSXYHDrGBuI1KOZ3h
         0GakPDtGQJ9AX5Yms9cJyOljn/cP6nLUH/BmSGtMjmj9Hnu7FJ6nSdn6V59f5/OuWqYs
         TGq/8hmQ0Hoqoo+pLKrhtcng01yYB+b7azWGX4l7IoRFQFewVB6GQBDGGOarGsrR1qQb
         DlcV7TFre0T6I6/A0qDwyCVc89uhVesfZjRVenTMQfNAufO6WUEdgQWnfborHpREF/SL
         znFx4+xOEhqvA5Qmz9AuntimIS0MGiMsgWK5uZJWFUNTWwMfS81dSK+TBz8jLyrfPwa3
         obMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793203448; x=1793808248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wW+/Xd8Krv/fKYtWcQLYyD+KltWSe3OXoRZLQJCTD0I=;
        b=VeKVs7kO93lAyitu1/FYRzXumBGmMAAzL5q969x+8BwX+2v7vn20/YSLzEzy7fGGlp
         HAtx6IzLCQZCSYTY+hHTn9IlEJJhzJWxnaEVzrP7BvelwamzPA6oJfTa++UmccJ0tFDL
         EirA+l+N+j/V981Twh9OGZp+2Pi5jJ1MD+Adb9aoInwh+vMx3Ns9WY96bbo6YD0bovZs
         jh+ZOu39xtvBY/SliCRaGGtlKt/gKuApO/RPDN1CmsH3284pWJhtleaSUr1hkZ/grKgv
         g+JnzAwa81mOHrjKMpdvs7bWn7qFY4lyL0580qqatnYZ2xDEhmkrin6hYIj1vTf6B51U
         /YMA==
X-Gm-Message-State: AFq9FYLJHwGcEiQ74X19eRoUNSrn5ulWW/tIQTXA8a28qWhOTX7HfucQ
	ebBgB6QZqjKDm49IlV/cIvFHtI00h5rMGOlurEbaUd0MNLqvZS7O4iOP
X-Gm-Gg: AYBFou0iUK7rI5NbXCaIkPEerqS8PTjm+wORfBm79RjeFgmk6zSSA/+j2s8lIDiF8gw
	kqyYaRCHtzVFoZjYMP57m0lMX2rVQ0bo5nAYgk91sy8zG3oki/ZJp5u8Fo102E7w8QydXH5NVhN
	HdJTyCQ98w+xMI6SB9x6W56ViDFlXaSIgayD6Sq+UMU8Aaj9oCN5dy/0ky1ilDZZJ62uKyp3LeD
	oFfn5AyM6xjBdOtSsdCQq8f5BlqyZahTvZaif3sbLhrJ9+DDv4EUhqtikk7b8B7EPW8cg/a/JbB
	c4K0NBa+gA+gcXiPrWxA+FJ3pbi7KneX9MRlQ6b2Htof4EP8YDv5WMORGZ1JDX53iWlr0ImqKto
	8uLPT8uLdRFzIrWWezxgSyTVh4dF4ty2cIkiQYRtadK1oLXEmgq23NL8q8xY79OmJ/y/b94ybnH
	hGlgihI4Gunu8Vgmjp+1ZqeY0k/IXH7auZ4JtuIeignOBOFu+CQL1ONU6RTTqMZ2fbfBok3wOc3
	W66599+b37S7oMALqgxPkqlvnpSBfwJQyS7H3ukds6W0FMhkgI2HhaJxFwEH1uky6BhToDUxNPh
	uP2oYQlrm1YqHL69AO6eCs6LAABVfyTeAmILKltWBhSc15nMfx4iABS1o+opQGkqmUUibsHCJBG
	loQ==
X-Received: by 2002:ac5:cd4f:0:b0:5cd:4fdc:4c30 with SMTP id 71dfb90a1353d-5ec3ea67966mr1617819e0c.8.1793203447486;
        Wed, 28 Oct 2026 09:04:07 -0700 (PDT)
Received: from localhost.localdomain ([190.177.146.128])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259db2d3sm6354565241.6.2026.10.28.09.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:04:06 -0700 (PDT)
From: Cristian Papa <pcristian292@gmail.com>
To: cjd@cjdns.fr
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	linux@armlinux.org.uk,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	naseefkm@gmail.com,
	b.larsson@gmx.com
Subject: Re: [PATCH v3 0/7] net: dsa: mt7530: support EcoNet EN751221
Date: Wed, 28 Oct 2026 13:03:53 -0300
Message-ID: <20261028160353.4239-1-pcristian292@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028011317.1557238-1-cjd@cjdns.fr>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
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

Hi Caleb,

I tested v3 on a TP-Link Archer XR500v v1 (EN7526G: on-die switch plus the
MCM gigabit switch).

Setup: OpenWrt with kernel 6.18.44. I took the four mt7530 files from
econet_eth at 3a8bcd2e6398 (they contain every line added by 1/7, 3/7,
4/7, 5/7 and 7/7 of v3) and booted from RAM over TFTP, nothing written to
flash.

With the DT from en751221g.dtsi in openwrt#25330 (MCM "econet,en751221",
no "mediatek,mcm", dsa,member <0 1> on the on-die switch and <0 0> on the
MCM):

- 18/18 boots: all 10 TRGMII lanes found a window, no "calibration
  failed", "TRGMII inter-switch link initialized", DSA tree set up, ping
  over lan4.
- The chosen taps were stable across boots (+/-1): SoC->MCM 15-22,
  MCM->SoC 27-29. In the SoC->MCM direction the window always starts at
  tap 0.
- 6 of those boots ran iperf3 for 6 s each way through lan4: 0 RX CRC
  errors on on-die port 5 (~1.05M frames) and on MCM port 6 (~1.29M
  frames). In 4 of 10 boots MCM port 6 already had 1 CRC error before any
  traffic, probably from the calibration; it did not grow.

Following the binding in 6/7, the MCM does not come up on this board:

- "econet,en751221-gswitch": mt7530-mdio.c in 7/7 still matches
  "econet,en751221", so nothing probes the MCM and there are no LAN
  ports.
- "mediatek,mcm", which the binding requires for -gswitch: the probe
  fails with "Couldn't get our reset line", since nothing provides an
  "mcm" reset yet (the TODO in en751221g.dtsi).

So I think 7/7 should match the new compatible, and the binding should not
require "mediatek,mcm" while there is no "mcm" reset for the EN751221.

Not covered yet: cold boots, and the other LAN ports beyond link-up on
lan3/lan4. I'm happy to give a Tested-by once the compatible strings line
up, and to rerun anything you'd like; the full boot logs are available.

Thanks,
Cristian
