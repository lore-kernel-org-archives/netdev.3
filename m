Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE52C11EE
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792317789; cv=none; b=VN3ckI7udE0egkpMIA8fNHKy88ITRT2X21qkjBTFyWLdR6FBKjCCZ4hO5Z2GQ4p+rAckZoMqSdSHcDEA31EkVDuFnqLqadFnbHGNiJMtz+LBaOG5M5JHdb+DSCJ6SNuNszGJFdOfbrixE0S3uIpcF2D/mDshZxDUvQdVCQtF5l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792317789; c=relaxed/simple;
	bh=5nA+NpVODDGW7a/fZNS1phsWWhfm6+31tlWMSZPfgvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XcPN6eaHATde2L3duYq4yXluBOimLcmN+HbNb/LM5rgI7/VwLe7bAODxTyDvJjjAHMrcUPCCDsxYZQR4JxsNFTmjGb0tGliG6TOlmLlf0wVYLUoH0fv8Rg/3IdjQ4cQniZeCqUoCnP3TW/yDTt7qdlwnNTngxp2oqIeUFSjuk9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com; spf=pass smtp.mailfrom=jclark.com; dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b=VCa99jWf; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jclark-com.20251104.gappssmtp.com header.i=@jclark-com.20251104.gappssmtp.com header.b="VCa99jWf"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so1086137a91.2
        for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 03:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20251104.gappssmtp.com; s=20251104; t=1792317787; x=1792922587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2QGxZk0CSTcUQZfGW+udjHe4KJev4M9fi0vyPUY59KE=;
        b=VCa99jWffShU/Fmb8yVUkcEgZr/+/8R7XiIQ3qTA6Qm0ziKB0P9brsq1alsA2QIzZr
         RObrCK6lHw0LmBmUo0FIxPehpcatR3DGEuI/jqUJkZ5i5wF8ltRmDuQRZRsHKlk86S+e
         EgpAXs9GA4TjNaxnvV2ECRJ+WkAqczFdnqWhZpwjTnXjNlKlcmMgP+J4ewhWYrxOSoCD
         +QN6mSHEejnUn+RfJMlJW6UTtnUZT+IfUXiP7BXxT34JOvAL3LdZYHrDwc/wCm4IrGmS
         Tpk/CDfq0UFUYr1wGIbyqwLYCrx48Oyi2PDmiltu+NptJgA4/yEH99YkA1nUQDWijbP+
         8vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792317787; x=1792922587;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2QGxZk0CSTcUQZfGW+udjHe4KJev4M9fi0vyPUY59KE=;
        b=NN9CmwCKTwCoX7hIqLjeGlnbrRYYDd+Xt53WmkBN1kglJnfpTnEGsjScjnFL86CdkM
         GCeLFJTgkiBl/xO0+N/+3l80Tho+9qQeByjiehdxT/asZkXId87JH2kfO8YVGltqjAkn
         uYtj2ggspcAPp0jpBUPtQZhtBdMKSrcBtCv/UhG4xflt6FptQTLMsbVWNrCPK+tmXW50
         O2O9EJclNUsGsleQsIU3nJRcTfZ6y3JY2vcbJcyc83W1SXbHOTILax8vyPubny2+kzN0
         y2asw7uKvuvtqrU4iUpVkalTceJLO1eDR0EJ0vF9UdCdyJSUxMBspuvDw/eRxep8uzsq
         QioA==
X-Forwarded-Encrypted: i=1; AKwUvBzL/h1ujADWKbCJiUlVgX+SDhUMcykX2/h4smmbHk1XA5j+xA2DWArazp7UicJ/KHLsBzgmVWM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKu3Q76NiXyhQ4ikqgQo/4ahnZnp2/EmItE590j7CC+tcskNVVM
	Ls7VR9l2lE7Ub7XITDiVlWKCsTA36awdcVhGjsCWGtQeB97SBgt+/2L2miQkgNUzXA==
X-Gm-Gg: AYBFou0gD6PtorEYxU3eNOmnl2EjiFo645xzFEkDtuXyAaJr4qJzAeQYqT48xGHFXJW
	0Xb00yf179+JFuSYLCTc6T09WbVvMA4gioAUQARnmCbaTyXxn7xIRg6gmUDhTO0FdFKOteuuE/m
	ainDh0DKm27gpFsLpL4b/QvMHqv2s6UNZl3n9oInymXwu19xdhv+nOs4RTGO7daSU7Zs5MMiART
	Z1+E/+ClLQumSh80pgrHLaBZWzY5gUX26at7f4N2qxMIinseMebnJuCZZcCXPttiKhRGUy6+o+e
	rSEGJwm7a0eG5ErrGFyKKwvkoyeSEH7TJhXIfUw6kOVtdiLTDtYMKfZvWDQ4H2iUjJ30jSm9+i9
	kLSCbmrJW6/Bte/c1+qz3ec7vYQs9sVyxKr/OwdaVVZjX06qABBX6zsmCDP+/+jVKqYTQZTXSiA
	vcPypOqNYMEt+AFd4GVjqi/Rqr8BOVG6UgZXDcOdCO52LeImZ1x3Jnms6Q7UXcnsZzp44vqLw3M
	HUiwcBJ4OoI63yVNI90eMv0xiSaesRPCR7ANdyfLMNhUZKKoKRgOhH6+q78x4w=
X-Received: by 2002:a17:90b:3d48:b0:3ac:9df3:6b07 with SMTP id 98e67ed59e1d1-3acef0c8753mr3970311a91.24.1792317786595;
        Sun, 18 Oct 2026 03:03:06 -0700 (PDT)
Received: from cantal.lan ([58.136.73.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac940055f5sm16101210a91.0.2026.10.18.03.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:03:06 -0700 (PDT)
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
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Hubert Feurstein <h.feurstein@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/6] net: mdio: add timestamped MDIO writes for PHY gettimex64
Date: Sun, 18 Oct 2026 17:02:51 +0700
Message-ID: <20261018100257.566267-1-jjc@jclark.com>
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
on the CM5 has brackets of about 1 µs.

This series introduces a new MDIO operation, write_sts, that allows a
PHY driver to ask the MDIO bus driver for system timestamps bounding
the completion of a clause 22 MDIO write transfer. A bus driver
computes them by shifting the timestamps taken around the start of the
transfer by bounds on its duration, worked out from the MDC period and
the length of the frame. The series:

- adds a timekeeping function to scale a CLOCK_MONOTONIC_RAW duration
  by a clock's frequency;
- adds ptp helpers that use it to shift system timestamps;
- adds the operation to the MDIO core;
- makes bcm-phy-ptp use the operation for the write that triggers the
  capture of the PHC time, allowing 350 ns for the PHY to capture it;
- implements the operation for macb, with tighter bounds on RP1, where
  its timing has been measured;
- implements it for UniMAC, when the mdio node has a clock giving the
  MDC reference rate. On BCM2711 that is the GISB clock, which Nicolai
  Buchwitz is adding to clk-bcm2835 [1]. Until then BCM2711 does not
  get write_sts, and nothing changes.

The effect of this series is to reduce PTP_SYS_OFFSET_EXTENDED brackets
from 74 µs to about 1.5 µs on the CM5, and from 42 µs to about 1.0 µs
on the CM4. The synchronization error drops from 32 µs to about 0.1 µs
on the CM5, and from 7 µs to about 60 ns on the CM4.

There was an earlier proposal addressing a similar problem, in 2019, for
the PHC of mv88e6xxx switches [2]. In the relevant respects the
situation is the same as with the BCM PHY: the PHC is read over MDIO
with several transfers, and one write fixes the moment at which the
clock is sampled. Richard and Andrew suggested taking the system
timestamps in the MDIO bus driver, around that write, and Hubert
Feurstein posted a series implementing this [3][4][5].

Like Hubert's v2 and v3, this series shifts the timestamps to allow for
the time the transfer takes. The discussion of that raised some points,
which this series addresses. First, the meaning of the timestamps
returned by the MDIO core operation is clear: they bound the end of the
MDIO write transfer. Second, the bus driver uses a lower and an upper
bound on the transfer time, including the preamble. The lower and upper
timestamps taken around the start of the transfer are shifted
separately, so that the returned bounds are guaranteed to contain the
end of the transfer. Third, the PHY driver gives a bound on the delay
between the end of the transfer and the PHY acting on the write, which
the MDIO core adds to the upper timestamp.

This series also differs in having a write_sts operation, rather than an
sts pointer in struct mii_bus. This allows the bus driver to compute the
transfer time bounds at each call, from the same divider and clock rate
that it uses to set the MDC speed. Unlike Andrew's suggestion, there is
no fallback in the core, because a bus driver's write may return before
the transfer has completed.

The earlier discussion also raised interrupts arriving between the
timestamps and the write, and the latency of the posted write. In this
series, the bus drivers take the timestamps with local interrupts
disabled, and flush the posted write before taking the upper timestamp.

SPI introduced a similar facility to allow a device driver to obtain
timestamp bounds from the bus controller in commit 79591b7db21d ("spi:
Add a PTP system timestamp to the transfer structure").

This series implements the operation for only one PHY driver. But I
surveyed other PHY drivers and identified at least two for which this
operation could be implemented: micrel (specifically LAN8814) and
dp83640, although they would need updating to use gettimex64 first.

The measurements come from the method described in patch 4/6, with
ppsbias (https://github.com/jclark/ppsbias) timing the PPS on the GPIO.
On the CM5 this is consistent with an independent check: with the MAC's
PHC synchronized by PTP to an external grandmaster, and the system clock
synchronized from it, the system clock and the PHY's PHC read with
PTP_SYS_OFFSET_EXTENDED agree to within about 0.15 µs.

Changes in v2:
- Improved measurement method (described in 4/6), which measures the
  synchronization error more precisely
- New timekeeping patch (1/6), so that the ptp helpers (2/6) scale the
  shift by the selected clock's current frequency
- Patches reordered: the ptp helpers (was 3/5) now come before the mdio
  core (was 1/5), which uses them
- mdio core (3/6): sts required, clause 22 stated, and frame-length
  constants for the bus drivers (Andrew); an event delay added to the
  upper bound; the wait and its 1 ms cap explained (Andrew)
- bcm-phy-ptp (4/6): a 350 ns bound on the PHY's capture delay, found by
  measurement
- macb (5/6): wider bounds unless the MAC starts the frame with the
  command write, as RP1 does; the MDC rate recorded when the divisor is
  chosen (Théo)
- UniMAC (6/6): the reference rate from a clock on the mdio node
  (Florian, Nicolai); a suppressed preamble allowed (Andrew)
- v1: https://lore.kernel.org/netdev/20261009143506.2507607-1-jjc@jclark.com/

[1] https://lore.kernel.org/netdev/41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de/
[2] https://lore.kernel.org/all/20190805082642.12873-1-hubert.feurstein@vahle.at/
[3] https://lore.kernel.org/r/20190816163157.25314-1-h.feurstein@gmail.com
[4] https://lore.kernel.org/r/20190819172827.9550-1-hubert.feurstein@vahle.at
[5] https://lore.kernel.org/r/20190820084833.6019-1-hubert.feurstein@vahle.at

James Clark (6):
  timekeeping: add ktime_scale_raw_ns()
  ptp: add functions to adjust system timestamps
  net: mdio: add timestamped write operation
  net: phy: broadcom: use timestamped MDIO writes in gettimex64
  net: macb: implement timestamped MDIO writes
  net: mdio: bcm-unimac: implement timestamped MDIO writes

 drivers/net/ethernet/cadence/macb.h      |   2 +
 drivers/net/ethernet/cadence/macb_main.c | 115 +++++++++++++++++++-
 drivers/net/mdio/mdio-bcm-unimac.c       | 128 +++++++++++++++++++++++
 drivers/net/mdio/mdio-mux.c              |  27 +++++
 drivers/net/phy/bcm-phy-lib.c            |  27 +++++
 drivers/net/phy/bcm-phy-lib.h            |   7 ++
 drivers/net/phy/bcm-phy-ptp.c            |  33 ++++--
 drivers/net/phy/mdio_bus.c               | 107 +++++++++++++++++++
 include/linux/mdio.h                     |  10 ++
 include/linux/phy.h                      |  39 +++++++
 include/linux/ptp_clock_kernel.h         |  55 ++++++++++
 include/linux/timekeeping.h              |   6 ++
 kernel/time/timekeeping.c                |  54 ++++++++++
 13 files changed, 603 insertions(+), 7 deletions(-)


base-commit: 98c2ad4f5d805dbc1ea436a334ee59311806a48c
-- 
2.56.0

