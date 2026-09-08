Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812DD4ADD81
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870234; cv=none; b=nTrEyCXetloQIlMTn9vGWDAdUjTBu14/1kNzLKNva8bxQlyZCbB4sUGXjg4Eo0vt7fGxGXHP28oNknKL5D+Yb//LjzeFYu3GtJFA/U2fZMj4oXwPwQ/Yx5fCDmtCPgzGrS1/M/cWYKCIXKnpdF1J/P036dv2SD1/8+YBQ+6uBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870234; c=relaxed/simple;
	bh=QGDd+Wf5YTS54FG8U77vN5sHZpKZ7uQB3OGWdhKUJ58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K1D3gTukdCGaFy9ujHfLaukouiamXvug+o315g45bNbTc6aFTY8VvvwGdTJBqKU0bsrg72AGWEvX/cDp9p/sC3YcVySH+sgfXLC3r2kWmn3Kp5lvFdhKnBPw7vdMCHCsd/aCT6Df2hQM3XyApLkRIgnQel/ioxA0rIjHBAbVR1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRcsM8Ky; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRcsM8Ky"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49b0d78a801so45947655e9.2
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 05:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788870231; x=1789475031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wy1gR36S2TG5IgHxj5GTNM1vyU6VarOdbRnTBOfTjOQ=;
        b=IRcsM8KyY5cX8OXyyoXDY+cIPc6ZqfEO4AKqNt8OVGYfKZAzc569mCuQeSxRDS0Cgt
         I7SRTLv66Y3aXnElsJmZkKb93DGYUIQhoE/36qJapAwiNLdUYyo5KbCRfgEQx8rGFugh
         zY5JxCvJXtBlWBv6D8SEMVin/gVRKvtbDkAz3Oj9RrNYdSu8XIkBFH/0jAVVQAvBHKWz
         0MaNcPNZgdmsa9oKLagkxo6p/0UGBlioxXsNMmftmBw1BqNRz+eICPhZdM79kXMuulBS
         uhLH7qFvmOoHwuL//X4L86QHxaGzWklTu1zIMU1ohJG8IoH3ingQu1q4MtVLZ7yaQlnG
         xH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788870231; x=1789475031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wy1gR36S2TG5IgHxj5GTNM1vyU6VarOdbRnTBOfTjOQ=;
        b=qPJqGSYS4xJxYLvgzrEvTCRu0hq3B4a6rwICJej3wVVSk9G+5wzVnz5P4OJHUQ3b3x
         r33nrJjGYNKYbyMcLPFjwKdRLaX/H8BiX0Rah+BAf4gmawqXMXVD2ZwT8whaZtwjBqjq
         PvP6EB3Y5Fuc53JEOt/xjM5pHmXtYaKtaMuJgpwGj4w7KD+79M49qt1o347ZCyX5O55l
         89X1iw/Z4t+e/gzwbIqa84fir6mnYpf6rGrz4nL2JTdXBY3E9Rl/bnSzDLQzW0U+clmo
         M2GRo7DJVLztRZnnwqPxYs55A5Rqnq1rLxylH9dLuxX3XyzwR5ZlodTk4dqWNPKSr6KR
         RE3g==
X-Gm-Message-State: AFuF++kE3Rk+a2bXCPQIq16IePan1WTFHWuqAbcEh06SpmbufJodU/3G
	UCO76DuWCArlb1gAzMBpDvTwrUJkdiONHY/tOaDMXZCFyfMhEpuCCXXPnAJyKXuL
X-Gm-Gg: AYBFou3wKgbmOpday8o6+RVeci7lAz68O6wa16FR4hcg3iWdcB+Ixwb8aVWUU/8OL+r
	ts2QT8lI7SMojIt00VYG2uzZF1WpTN1KwROzJ1Q2YHGeSc5ZILCXvW+Z2wReFGegZ45nGrSxAh+
	n2KFUHHkcPcOGhz7AtZ63UOAHHbXdDvWQqHx15X8jRafhfbO5E1ZVQUcUyVNns+6MAtUiAiCn3s
	m5kk2iAKdpBJR9flq0QV63VrheMGdW+lSzrZYe2E0B4aj5NvAGrSxJ0UpLEZkGHg3TU0faspZNQ
	sLzQGrcC6/fgywc1pZr/efnHvZdHKQ8poUVvoNLGBQZk5tA74BRSSjInZEFhMdKYgy+4ruk8mQp
	7sBEJRSmHUpgemC1JoKpaNJF0guiFNhNTZIG9vZF3QLT4KqYp2baF9e//X5kejay+0atYCK6XnB
	g5ve7q3oj8H9W0H7V2B1CmLWbyxM9tliffAHHv73Mj+EMvrTMOeHtTX+9I4hVurXLYfKGHLB8aN
	9PGZK+h9AWwkCwqzMnAHdjJhnJfpbihQN+VvlzIoi7Cb0mU+DrEFRjCnLYXn1ukGmFaZ+0hszVq
	edA=
X-Received: by 2002:a05:600c:4e46:b0:49b:910c:7703 with SMTP id 5b1f17b1804b1-49cf823f160mr280175115e9.9.1788870230385;
        Tue, 08 Sep 2026 05:23:50 -0700 (PDT)
Received: from fedora-tap.advaoptical.com (bzq-84-110-212-205.static-ip.bezeqint.net. [84.110.212.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm496744995e9.6.2026.09.08.05.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 05:23:50 -0700 (PDT)
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
Subject: [PATCH net-next v13 0/2] ptp: ocp: add TAP CPLD support for ADVA TimeCard X1
Date: Tue,  8 Sep 2026 15:23:26 +0300
Message-ID: <20260908122328.52641-1-maimon.sagi@gmail.com>
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

v12: https://lore.kernel.org/netdev/20260902044232.21188-1-maimon.sagi@gmail.com/T/#u

Changes since v12 - all from the automated review of v12:

 - The CPLD device ID is no longer read from ptp_ocp_devlink_info_get().
   DEVLINK_CMD_INFO_GET carries no GENL_ADMIN_PERM, and that read claims
   the i2c adapter and drives the on-card mux for up to two seconds,
   which any user could have repeated to keep the EEPROM, nvmem and at24
   paths off the controller.  The same operation is root-only through
   cpld_status.  The driver now reads the ID once from its own worker,
   as soon as the i2c adapter has registered, and info_get() reports the
   cached value.  Patch 1.
 - As a result info_get() can no longer fail because of the CPLD: it
   skips cpld.id when the value is not available.  Returning an error
   there made devlink discard the whole reply, and -ENODEV was reachable
   on any card where the i2c adapter never bound, which also aborted
   'devlink dev info' for every other instance on the host.  Patch 1.
 - cpld.id is now reported before the EEPROM data rather than after its
   early return, so it no longer depends on the EEPROM having been read.
   Patch 1.
 - adva_x1_bus_claim() re-checks that the adapter it just took a
   reference to is still this card's: i2c_del_adapter() frees the idr
   slot before the bus notifier clears the cached number, so the number
   could already have been recycled.  Patch 1.
 - The probe error paths unregister devlink before ptp_ocp_detach(),
   which destroys cpld_lock and releases the i2c controller.  Patch 1.
 - I2C_M_DMA_SAFE is no longer set.  No adapter that can bind here does
   DMA, and the read half of the scratch buffer is an interior pointer
   that does not satisfy the flag's alignment contract; the core is left
   free to bounce.  Patch 1.
 - The firmware-upload callbacks map errnos onto the documented
   fw_upload_err categories: -ENODEV and a failed transfer are no longer
   reported as a timeout, and a CPLD FAILED status is no longer reported
   as one either.  Patch 2.
 - adva_cpld_prepare() checks for a cancellation on entry, as its own
   comment promised, instead of cycling the CPLD into configuration mode
   for an upload that was already aborted.  Patch 2.
 - Added Documentation/networking/devlink/ptp_ocp.rst describing the
   driver-specific cpld.id version, with the index and MAINTAINERS
   entries.  Patch 1.
 - Comments in patch 1 no longer describe the firmware-upload path that
   only patch 2 adds, and the lines that exceeded 80 columns are wrapped.

Three points from that review are deliberately not addressed here,
because changing them needs a full programming cycle on the card to
validate and I would rather not fold untested changes into a respin:

 - poll_complete() samples DONE before REFRESH only, and does not check
   the sysCONFIG error field the way drivers/fpga/lattice-sysconfig.c
   does.
 - adva_x1_mblaze_release() does not wait for the firmware to route the
   controller back before the adapter lock is dropped.
 - A cancel arriving between cleanup() and fw_upload_prog_complete()
   stays set and aborts the next upload.

Tested on an ADVA TimeCard X1: the driver loads with the i2c adapter
registering after probe, cpld.id and cpld_status read back correctly,
and the wire byte sequences are unchanged from v12, which programmed the
part successfully.

Sagi Maimon (2):
  ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
  ptp: ocp: add TAP CPLD firmware upload for ADVA TimeCard X1

 Documentation/ABI/testing/sysfs-timecard     |  24 +
 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/ptp_ocp.rst |  35 +
 MAINTAINERS                                  |   1 +
 drivers/ptp/Kconfig                          |   2 +
 drivers/ptp/ptp_ocp.c                        | 761 ++++++++++++++++++-
 6 files changed, 818 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/networking/devlink/ptp_ocp.rst


base-commit: c29b37ed7a4d9856ed758a82282456d69cee2ed1
-- 
2.47.0

