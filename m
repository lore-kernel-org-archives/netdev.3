Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501220;
	b=F8S+asPPDj03KYAli4D9Zwm07zbJ15gJpY39PP0IE6LMdqIidGfIXeplEbDRErhkYLzj
	 tYpehHh9eO8k+QdoO/I8USlhAnVv+1UWyLW1DmDW3YinLIHOB7ZnrGp1zL1qCO9n6FvAK
	 XoGGHcuNkR/Ddy7qlbT2oKFjFAKMOTXeWLoGKc0whVcrtnyhVZYmcFydZjDxQZYjagIBc
	 QMwOFRZ72CtSr2dpWJDi5ji+/lmJ2Q7ZudRE70bn9PiUGV2hi2D/6V55+7tJZpuiAANEv
	 sNhYHE0zInE0EO4ng4TQvpPkaYZquBV4DT370Ggg4felYZapwHBlig4InVonAwRsdiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fTf5xwUaVqhCGYlOB3/ivLsxy/QQjCllvG43X3tVGp0=;
	b=uRAp0vuzzdfrwMTuotcl1nWhE7DZW3wku6s3J6REf/dc6Fih45SwDmiQhnljqMDSEyFf
	 tcZ6umtjuxF837MOLmuorQOmzD8nwnB0tBSBBRkIC6cGL1PW7gtKf9UozL9hZ9shB0hlF
	 yB8jY4y7D1EWSus+dFwv4dDSoIvyRXUYOdYIGqKs9jCI5mTA0P6y4WGuGXbpPzg9txEwi
	 p1/hk5XAvnAgBiu5P3vZV9pimpYAR1kYz16QLfq1EjiwsrSLEQ8S5bI1FCMOY7v+E8XYY
	 kT6ISgGfIgo44b6CYjW9xI+sKpZsfGtNhVvOxcqlWS+7OoD8OHl2IWOeKpzIBYnTVTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOOolabN;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17CC606A88D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A17CC606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOOolabN
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a8cc11ac42so4481968c88.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501219; x=1795106019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fTf5xwUaVqhCGYlOB3/ivLsxy/QQjCllvG43X3tVGp0=;
        b=bOOolabNHffCQAuwLQ0DkkrmI/0xfrlO3ZGMi4uEqUSA/ruC8Kgzg3IfqETXANiCSc
         nE5XTUMOGB8+pm3D1vOJLl2dghi+dV6+Vf8rRysaZFAcqdtvPVkoe6QXZX87YeIv7qG7
         lfylAT9DyUHn+4Eh7Ynj4HzZCeDttzszv+l+bobVFsJjNhRSkAE3y5pQNLVCbqsXZfvX
         0sFEpdUsLOmCJy7pb/Wb5YJ0zdceVdrQpVM+F7Q5aHZisnn6mlBxmXh9varoskvH9SSU
         ko83HninfW0bnflBqx4NP0nlDvUvEjXEhUVdASmv8xP0a8g+0Ska9Eos+DzE6V4AAGlQ
         ELAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501219; x=1795106019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fTf5xwUaVqhCGYlOB3/ivLsxy/QQjCllvG43X3tVGp0=;
        b=Bd6M0BB2SuUczgPyu7jEFohn2YxtMDeSHMeaVBQ1vcC+9zDOfnQHEmrwqMHrIySzQ6
         dHPpgSLu9RWFZCMMdEzt8itG6tfEnIaFLcM0TcIsI0wnZpS4FKeuDFDmzjBKPqITccrR
         EC/n6Lru7KbExKa9BPSMFEngXMEY8pCBCf31CM7r4bLvq5FT2LxeF3ap/TxBthiF8sBP
         UIWFI+5CVd06lk0bRLsP/EcDC5RIBGH9dcTlYXzLZpRuVqKyEBrmX004sBkpL6pnCtBc
         CZNz3Hu0DDohzxBtz9FzEyrWiFqt4T2Ia0YXPsqbkmIhAxdetXef8usLcTzvpmzHzMnH
         TIAQ==
X-Gm-Message-State: APuU4Z8cmhcf0e+EAt133oxQLcEOnuV5WoxwEEWSDXDYvKFzZoXrzShU
	MHFmNnlhjv1mrRGIqMSeyjdjLDDCgnLwg/SMU+/+/lBD8i0krbu//28gmSvslDFm
X-Gm-Gg: AYBFou0owYvMB2JITvOk1KpjKw8Do+CvhqSmD9gdJRKVyNvHznDl8MMD6BoICR0sWXQ
	jrnF21slHl8dzYzcrNPaPgPH89T0EGA0CvoLHKGn2qa9zpKEylQk1SZ7iNksD9KH3cIGuvJxtQ/
	ktuCGs1B1XeDSx+V0O09OYE2rlpL3fOPgkS6tHz+nQY2bVo01rx+OEm/5Y6naxpZeFbzGGpQLtO
	V9cd8Ih2dYAt5S1O/lZi5xzagJJHoK1rxSWomRQZbMDTQzOCN2pItT6Ua3+A2SMHS1kRengU+A3
	/5J8oIBcMa5m9eNy3yzJqxRRjin+AUOsaBHoEHmIA95cYIaPagcse5y9h6XrhM3HziC8z2bQsts
	OVIkKWXKRnVUivNSErubM0M6xshtzhjGURHmvX/O5B4+0AnONR8SsKFfKT/A3sSmMYGkI4+zQCV
	qSf1JeYhiunppf9o2kd6GKzs9hbD0F7D7cp183KIe+dw6Sd8VB45+UBqIq8VTcgtqxIm0P4+uEm
	LFgQTaPnbLLFey3bRZ4g6NTGppfGHjqaZsjb0itHGQpyiw7/w6k3Y1/mrZY7sKpYV6yQEY1mgt3
	PqYxmyGRAXJ0B3Poe3TFNhcvMy2qmBD1msE9nBwunoBL5sR7zAqjom3cT/yXOeshayQgAU2cDAm
	fpbog6ffpienTjQEW/w4kDuECLsRudrSq759gGHVlL9Yep06JeMr2vmun7t2G8RL+fDXZyD2C
X-Received: by 2002:a05:7022:409a:b0:1b2:3b5b:b80b with SMTP id a92af1059eb24-1b5030d7a9dmr70385c88.8.1794501218632;
        Thu, 12 Nov 2026 08:33:38 -0800 (PST)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50300e5dcsm230248c88.0.2026.11.12.08.33.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 08:33:37 -0800 (PST)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org,
	vadim.fedorenko@linux.dev,
	andi.shyti@kernel.org
Cc: linux-i2c@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michal Simek <michal.simek@amd.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 0/3] ptp: ocp: support the WiWi production Time Card
Date: Thu, 12 Nov 2026 08:33:29 -0800
Message-ID: <20261112163333.12523-1-ahmadexp@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The WiWi Time Card (2163:1008, subsystem 10ee:0007) uses a
Celestica-compatible register map behind LitePCIe. Its bridge does not
support the subword MMIO used by the XIIC driver. Add an opt-in word
access mode, exercise both modes with KUnit, and enable ptp_ocp on the
revision 02 interface. Other cards retain their existing access modes.
The series does not enable WiWi flash updates or change LED policy.

Patch 3 uses the platform-data field from patch 1. Could the I2C
maintainers review patches 1 and 2 for an Ack to take the series
through net-next?

Changes since v1:
 - 1/3: Drop five explicit inline annotations in the C file and
   shorten the platform-data comment. No access semantics change.
 - 2/3: Wrap the offsets and expectations flagged by checkpatch.
   The four test modes, register offsets and expected values are unchanged.
 - 3/3: Follow NetTimeLogic's PCI revision convention. Replace the exact
   image ID and per-core version checks with a revision 02 gate. Reject
   unknown revisions before FPGA MMIO and retain the BAR/MSI-X checks.
   Report the full build ID in devlink; select capabilities by interface
   revision. Update the documentation and wrap overlength lines.

The revision 02 driver was tested on a physical card running build
0x0000800f under Secure Boot. It bound with 64 MSI-X vectors; the PHC
advanced 3.000441080 s over three one-second sleeps. SPI NOR and both
EEPROM clients bound. The PHC was UNSYNCED at probe; this test does not
establish PPS lock or valid UTC. Only that firmware build was tested on
hardware. Subsequent edits to the tested drivers remove inline hints or
change formatting and comments.

On the rebased v2, the XIIC and ptp_ocp objects built on x86-64 with
W=1 under allmodconfig and allyesconfig. Four XIIC KUnit cases passed
in an isolated x86-64 QEMU boot. Fixtures exercised all 256 PCI
revisions, bad PCI layouts and multiple image IDs. These are not
additional hardware tests. No full allmodconfig or allyesconfig build
is claimed for v2.

Codex assisted with the changes, tests and changelogs using the board
layout, machine-check evidence, vendor revision rule and v1 CI reports.

v1: https://lore.kernel.org/netdev/20261111041904.48916-1-ahmadexp@gmail.com/

Ahmad Byagowi (3):
  i2c: xiic: allow platforms to require 32-bit register accesses
  i2c: xiic: add KUnit coverage for register access modes
  ptp: ocp: support the WiWi revision 02 Time Card

 Documentation/networking/devlink/ptp_ocp.rst |  36 +++-
 MAINTAINERS                                  |   1 +
 drivers/i2c/busses/Kconfig                   |  14 ++
 drivers/i2c/busses/i2c-xiic.c                |  60 +++++--
 drivers/i2c/busses/tests/i2c_xiic_kunit.c    |  91 +++++++++++
 drivers/ptp/ptp_ocp.c                        | 163 ++++++++++++++++++-
 include/linux/platform_data/i2c-xiic.h       |   3 +
 7 files changed, 341 insertions(+), 27 deletions(-)
 create mode 100644 drivers/i2c/busses/tests/i2c_xiic_kunit.c


base-commit: 368fbf5d82da9ebce309449c74fc0b128f7d0219
