Received: from mail-qk2-f8.google.com (mail-qk2-f8.google.com [74.125.230.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4713B3BFE
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556519; cv=none; b=NGMUQUQIAC1NJC4i5khEOtJXFu6hic6G2rPvS5raX6XD/QvGWbQfba+3nUASGMZ7WpbxsCQY/DZOc/so/ZB/YAutoaAARGBYjLlxwxihE4rMHMcw5D/yCqMkHfyhYUcaXRJauyfqxUOnbhkUkaiMXQRyl0VIkSqbhtGFc9/GU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556519; c=relaxed/simple;
	bh=M51Pb28xTuQKlfy45if+HMsxPmrZWTqvJOnq+kRZwfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cey+n4ggnrM2VD78HSCb41B3dq7u3NV5JvGeMM6S0C6+Ow2Z55gjNZFqk1uerKyIXPp7fe4ugv4Yo6t2MxqjZWMB/yaLpQyJqpGcUj/IaHO+EG89CflgIUfmCzwpaa/9FdutLCXAnVjx7wwUz/I7Q/6gP1AbbjRoB5Wc22gfLuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=MSTQS0Jm; arc=none smtp.client-ip=74.125.230.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="MSTQS0Jm"
Received: by mail-qk2-f8.google.com with SMTP id d75a77b69052e-53524092d9cso52857991cf.1
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1791556514; x=1792161314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NsWnTIlvL/h4GuHBlTNOAc+vTPtrPntNGG2ofKxiW1U=;
        b=MSTQS0Jmpdxum5sJQueGPAEtCvPnorFffo0wIUjpQOwfTRyU+8mC4adUJSui5Ar4pl
         gJgeiea5igsWD5RfRxN6jW620F3az755tgolrp4Mj7n+sEdDb+P/9aJWOgZAK58obA+v
         5gNZXoaHZzpLtx4+ohKeWuaI+GgIeRLBWDJWgfZSxUcuy+VY5ewCDNxB4TGpqIu+TrqH
         cJNxPZKJ3JwXqyswiShMD8OfUu/VOjz2TJeeDNyzuzsz9udhtYuLBKlNkPklSzYacJyI
         7iR9czFg4MTamQfoI4J0imKomUeDXDSLibxiRKOkmjpK/TlciC8jv2XjkDrPfflkWbc/
         M0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556514; x=1792161314;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NsWnTIlvL/h4GuHBlTNOAc+vTPtrPntNGG2ofKxiW1U=;
        b=S7/d0aYk/YsodbT+MKEctr/ZxNEESDwvWmRM2l1W6PBcYbs7znCWYHF2mKgWAd9ghP
         rEIYvXhPPjg/b3TPUSIB7r5IJrl5d9zWf1EV18+6PluuMWz/sR73Dvpmk15KEwoBeDy4
         zI1u8kMT0JTF8rjWqyJPdKSprLvjVaeCe2UquSm6KgU2hlUrktQXKbUnFueiCdmUXQPe
         8mjWAzKKgDQ0QYCHyN7XBcSpl1MexM5wOfNoZyt96ybmP0hcFSy+o81R2r5W7RVBP+HD
         F3s7WmcVTAgH7RdvrM3bKx8PY+COiL0z8R6rdObsJ/A9l3riB+3GxjcsETJd1zBfwu1u
         3qPA==
X-Forwarded-Encrypted: i=1; AKwUvBzivJFHYU9JRrdTl+fXRDp8nQT2nsrflwqxF7SZveSFNGa5UKmCIlSQW2HaC2o6Hd1+4+KCwSA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKk7oUT0fwXrCi+PKNDqXdo9qJ160PV9y80AOCopMUTXTJoi3QI
	1Bnse5f8jCuKzEEziWytkO4Ed5EZrPLORakAJPOMGZWiNynh0I/0doUn3NuFI6yh5w==
X-Gm-Gg: AYBFou17R5a/yeQFcFy1Ez/wHiwBYDz1Y1qGB5qI5t+9lM3X/Tmq8x2YaSKQoo0aQS+
	YOWzi8HxLJCRC/rJODwpFI/q00y8aa3r5KdpcOJtGhcAwxu54KE5A9VdDcHs0ipgcTrQb2iif/9
	7NNzrh4lCDAsUmJx3Kt8tQ2SySZO7d4VYR/VvhaaC0hCHVbyvnNgEjqKQolGgw9v+OkU6I35cNv
	9wzsWEpRWxL/aZkqPOolhUZgiga3WbxqY5ckU6YQyrV3vWA/Juvobv1qW2pI7JPpIyfza8Beh02
	Bl/zc0bNahSHIVZve76Y9QTGxPJWjtvEZg8Y8sto18130TpfbclNyDxPtPfuYn2qQpoEIgjy+j3
	cg9NzvqhNuNT1+C02g2uBVvUKuLQIuzdNTqm7d1rIGWQ/DdN+9ktuBSNMsBm0K1b6kmXUU8N3+P
	w4UOEGpqVcQwcvxtr6w6vMgnobo49dGNwhlhb2kIq+QDb3ZXNWJm8YQlS3fXKq
X-Received: by 2002:a05:6214:411e:b0:913:ffb2:e8d9 with SMTP id 6a1803df08f44-91b557bcb73mr32107296d6.40.1791556514366;
        Fri, 09 Oct 2026 07:35:14 -0700 (PDT)
Received: from cantal.lan ([58.136.72.162])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5501751dsm19769456d6.17.2026.10.09.07.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 07:35:13 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: mdio: add timestamped MDIO writes for PHY gettimex64
Date: Fri,  9 Oct 2026 21:35:01 +0700
Message-ID: <20261009143506.2507607-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PTP_SYS_OFFSET_EXTENDED uses gettimex64 to bracket each PHC read with
system clock reads. Some PHYs have a PTP hardware clock (PHC) that is
read over MDIO and sometimes multiple MDIO transfers are needed to read
the clock. This leads to brackets in the tens of microseconds.
Applications that synchronize the system clock from the PHC typically
use the midpoint of the bracket as the system time of the PHC reading.
With multiple transfers, the midpoint of the bracket is typically far
from the time when the PHC reading actually occurred.

For example, using PTP_SYS_OFFSET_EXTENDED on the Raspberry Pi CM5 to
synchronize the system clock from the BCM54210PE PHY PHC leads to the
system clock being 32 µs ahead of the PHC. On the CM4, it is about 7 µs.
(The difference is because the MDIO clock frequency is higher on the
CM4: 10 MHz as opposed to 2.08 MHz on the CM5.) The brackets are about
74 µs on the CM5 and 42 µs on the CM4. In comparison, the MAC PHC
on the CM5 has brackets of about 1 µs. See below for measurement
process.

This series introduces a new MDIO operation that allows PHY drivers to
ask MDIO bus drivers to compute a bracket for the completion of an MDIO
write transfer. It then makes bcm-phy-ptp use this operation, and
implements it for both the macb and UniMAC drivers. A bus driver
computes a bracket for completion of a transfer by shifting the bracket
for the start of the MDIO transfer by bounds on its duration.

The effect of this series is to reduce PTP_SYS_OFFSET_EXTENDED brackets
from 74 µs to about 1.3 µs on the CM5, and from 42 µs to about 0.9 µs on
the CM4. The synchronization error drops from 32 µs and 7 µs to tenths
of microseconds, below the level that can be reliably measured with the
methods below.

Note that SPI introduced a similar facility to allow a device driver to
obtain timestamp bounds from the bus controller in commit 79591b7db21d
("spi: Add a PTP system timestamp to the transfer structure"). This
series implements the operation for only one PHY driver. But I surveyed
other PHY drivers and identified at least two for which this operation
could be implemented: micrel (specifically LAN8814) and dp83640,
although they would need updating to use gettimex64 first.

The system clock synchronization accuracy can be measured on the CM5 by
making use of its second PHC. /dev/ptp0 is the BCM54210PE PHC; /dev/ptp1
is the macb MAC PHC. PTP_SYS_OFFSET_EXTENDED brackets with macb are
about 1 µs after upstream commit 9ca4ba242591 ("net: macb: fix ordering
around PTP timestamp read"). So we can use the following measurement
approach: select /dev/ptp1 as the PHC for packet timestamping and then
synchronize it to a PTP grandmaster; synchronize /dev/ptp0 to a PPS from
a GPS using ts2phc or satpulse; synchronize the system clock from
/dev/ptp1 using phc2sys or chrony; then measure the offset between the
system clock and the result of PTP_SYS_OFFSET_EXTENDED.

An alternative way to check, which does not require a PTP grandmaster,
is to connect the same PPS signal to both the GPIO PPS pin (header pin
12) and to SYNC_OUT. Then have an NTP server discipline the system clock
using the GPS PPS signal, and as before measure the offset between the
system clock and the result of PTP_SYS_OFFSET_EXTENDED. But kernel PPS
has a significant bias (of the order of 10 µs). However, I have
developed a tool called ppsbias (https://github.com/jclark/ppsbias) to
measure this, which works by polling GPIO memory. If you configure the
NTP server with the offset from ppsbias, then you can get an estimate
that is accurate to within about 1 µs. The results from ppsbias are
consistent with results from using PTP with MAC PHC. On a CM4, this is
the only method available, since /dev/ptp1 is not available.

James Clark (5):
  net: mdio: add timestamped write operation
  net: phy: broadcom: use timestamped MDIO writes in gettimex64
  ptp: add functions to adjust system timestamps
  net: macb: implement timestamped MDIO writes
  net: mdio: bcm-unimac: implement timestamped MDIO writes

 drivers/net/ethernet/cadence/macb.h      |   1 +
 drivers/net/ethernet/cadence/macb_main.c |  95 ++++++++++++++++++--
 drivers/net/mdio/mdio-bcm-unimac.c       | 105 ++++++++++++++++++++++-
 drivers/net/mdio/mdio-mux.c              |  27 ++++++
 drivers/net/phy/bcm-phy-lib.c            |  25 ++++++
 drivers/net/phy/bcm-phy-lib.h            |   7 ++
 drivers/net/phy/bcm-phy-ptp.c            |  27 ++++--
 drivers/net/phy/mdio_bus.c               | 100 +++++++++++++++++++++
 include/linux/mdio.h                     |   4 +
 include/linux/phy.h                      |  37 ++++++++
 include/linux/ptp_clock_kernel.h         |  48 +++++++++++
 11 files changed, 459 insertions(+), 17 deletions(-)


base-commit: 45ad84d2800e4a092fb8d96006a533b2d0ab13f6
-- 
2.56.0

