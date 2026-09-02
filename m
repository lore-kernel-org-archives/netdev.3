Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B23F3290B0
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 04:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324159; cv=none; b=rzQAWMtZ04oeV31ESEzUnbxwnS89Ak3vFuOZghd4Mp+65cs34wew4Fm/5MCLQIYCv2pCy6Pwp7VtWNaPs/u9I9+qY9XZ42llELixV4qJf0hIhip/p2Yqyx1URoMDbFH4Qryyoj8OnrIKH/qW/4pjoijmt9seUBNeHPkz/Jsk6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324159; c=relaxed/simple;
	bh=+sQjzs5GJoXwuRBHuC+lUm9JDrE1H7apLMAsW9pyFcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YIrknbouhthyxnivezfWbP3n9iX22PtPzh9D3NbsSIxHpquZxSMcl2SYxeVtO9z8YR3kAMg5+iIVGX8hFf1VYAGFnft+G1p5V7vNUtoEmgypYaBKKe97i7Lxup++Snk1nZNP79SAn3tH7bYdlutW9/EVzos6rlVPoweZ3XiWCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=METp9Wlt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="METp9Wlt"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-495590dde14so5272455e9.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 21:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788324156; x=1788928956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JtWKIpNLXlriEGn93C9K9TziWn2g7UFHuiQX5OgZJiw=;
        b=METp9WltQOP0TVQYiDvT0ZWooCcBS0gf0IVme7NqChEgjPA2sjMvpQU0A427ng8wED
         Sm0pvgIrZap0lYTXLuhOMgbKNO+nel8ULQOtv7MYJb8IWaiWQc6Xr0MZJcdEp8i6imhD
         K6/bhqtOY0UBNAcuywMs/5R7/Qj1eDjCoeqTRMGMjNZQu5OiE4fYxzRAZXjGi7upD+93
         J3DM+iusIHPojUR8/SWY9fbEI8QSN3nyYQp1qHelVrFHmY5YLH5/TJepVjQ3LSjd1wWY
         wi6837AavEsk3VDgbKi6bRgFByaxzJ/u7wuj67PHktmfju+Qx4USOQRYfUiU1/czsNer
         zETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788324156; x=1788928956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtWKIpNLXlriEGn93C9K9TziWn2g7UFHuiQX5OgZJiw=;
        b=pTprrQaOoJM1n034zYo0c0/ZCD9f7q69Nq4MgEGaz87kXsruuxn3bzmnN0OfPqAxCb
         GmQY1NlayWAM/LpavmqqQF0UUAi+kk3xSlfYSYgEa/BDap9iSeBi9FjIC3Fjs/EgAhDT
         zeFjsRvGKd22/QkIBk8G9uMU6okVJFgg22CYGBvD5zbe5AjFMdQx36R4uBDUvIv/M3WN
         eJYjexQrilnxumUkEsafXsrzFSGFTXa1qHWKY29ZlbjGOOqTxhJy44PLE9LmSbFdv1qw
         3gn8YcWlVjRI41kJ1ZrUd7rdNnEsv4A05L6eT9usUv0DrhiUM36Eah4ookNLbzgPzgE3
         bmQw==
X-Gm-Message-State: AFuF++mXg/1axrSM6U+rn64qGHXdImX7SELwucKYRc2EsFpFPBGrUlgh
	cgRrlGwjjkVpd5AqU0WMe17wnSv6EWuOaycZ7YdWO8NcauR41AQogVyYrlLhd/yq
X-Gm-Gg: AR+sD11RfrTo1QiGJw+syfVSBdolw0OPGoxvVLNFYwkcTG3xAg+BUnyadPCTJ+WYJUb
	MdK86+gBDcNVhcwAvBm589l5i2Vf4XcNHP10TEUSTjFycDOCJ1uQVHKZfml+CXyQouT//j5Ojxi
	FF/FxxZPdZJX3HKYpx/R7lzgXh+VtcGCBCysiTtL6UBoyZQYcqd+1w7dG1yXVYywh7zlA0GkPDN
	iH8jftKj7R+QKtxOxuIkDIcyz1xM1RHLYcOSxXW1cflJuMbb6Gsi+5YnYDPxfe08OMK9p/kOoON
	wDc0jiEUeddvgrqA2XXOZwLWGKiOhxzp/s3ld/2D+ffLobpOqd7VzsnJqsD8fhtnTT4DXo2pLmU
	ExvjcBASjTSbhxlYkoBncy+9SNFLM1aCmz8lQFGYTGnxomH+RZwjvCzhTj1l0G2oRBRoL+oRcB+
	u5qpBIHJa95CwgHb01SxeID5WLHmKzQk/9tORjBVXFXnR0pAR7rQ/5RrEIVxa+PUhhAvkL/EXM0
	rXRoxK2jbg245SrlqNDHOB7tSbOdjE=
X-Received: by 2002:a05:600c:3b11:b0:49c:dca4:94c with SMTP id 5b1f17b1804b1-49ce5843baemr32203165e9.13.1788324156118;
        Tue, 01 Sep 2026 21:42:36 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce10153sm127274165e9.4.2026.09.01.21.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 21:42:35 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v12 0/2] ptp: ocp: add TAP CPLD support for ADVA TimeCard X1
Date: Wed,  2 Sep 2026 07:42:30 +0300
Message-ID: <20260902044232.21188-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADVA TimeCard X1 (PCI device 0x0410) carries a Lattice MachXO3 CPLD
on the TMC I2C bus.  This series adds access to it and an update path
through the kernel firmware-upload subsystem.

The card has two I2C controllers.  Linux registers only the one at
0x00150000, normally routed to the config EEPROMs; the one at 0x00120000
belongs to the on-card MicroBlaze and is routed to the TMC or M.2 bus as
its firmware selects.  A request/grant handshake re-routes the host
controller onto the TMC bus, where the PCA9548 and the CPLD behind its
channel 0 live.  Everything here is built on that handshake.

Patch 1 adds the arbitration and the read-only interfaces on top of it.
Patch 2 adds the flashing.

v11: https://lore.kernel.org/netdev/20260811135720.109580-1-maimon.sagi@gmail.com/T/#u

Changes since v11 - all from Vadim's review of the ISC command path:

 - adva_x1_i2c_xfer() takes the opcode as its own argument and assembles
   the message in a scratch buffer taken once per bus claim, so the
   opcode and its arguments are copied exactly once and a firmware upload
   costs one allocation instead of one per 16-byte page.  The bound check
   lives here now, against the scratch size.  Patch 1.
 - adva_x1_cpld_write() takes just the opcode; the per-command argument
   bytes come from adva_x1_cpld_args(), a switch-case helper returning a
   pointer to the static data.  This drops the seven per-caller argument
   arrays, including the dis_args duplicated between prepare() and
   cleanup().  Patch 2.
 - Commands whose arguments are all zero (RESET_ADDR, SET_DONE, DIS_CFG,
   REFRESH) pass NULL and the transfer sends zeros, so the zero3 arrays
   are gone.
 - Comment fix: the LCMXO3LF-2100 IDCODE is 0xe12bc043 (0x612bc043 is the
   4300-LUT part).  Patch 1.

No functional change: the byte sequences on the wire are unchanged, and
CPLD programming was verified on an ADVA TimeCard X1.

Sagi Maimon (2):
  ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
  ptp: ocp: add TAP CPLD firmware upload for ADVA TimeCard X1

 Documentation/ABI/testing/sysfs-timecard |  24 +
 drivers/ptp/Kconfig                      |   2 +
 drivers/ptp/ptp_ocp.c                    | 693 ++++++++++++++++++++++-
 3 files changed, 715 insertions(+), 4 deletions(-)


base-commit: c29b37ed7a4d9856ed758a82282456d69cee2ed1
-- 
2.47.0

