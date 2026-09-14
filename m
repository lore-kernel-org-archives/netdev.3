Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745BC39EF33
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789370139; cv=none; b=eTKjYfH+Yk71s2geZ07W5YCqe862O7ssglB4u6zu5v1nf/++g3KbwOThBgQ9xy9FiJt3d40Kq4n9+YKwOuor0iU69Z/3ACgALnuy+N8yCFgE/CYYjJmTPO810XWfqAuXty8w4la/oCqwlisr4+AIIGXT+8HiohvRK2hayiekMy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789370139; c=relaxed/simple;
	bh=jSb2Ftos2O4Cle3dQjevzii599zWf1wPdvUMiVakE/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QV8hcJk70NEtX3la+6Q8Xp9BT8vKapBay5aN8jM/ypmZZArzzxUg0eClVIdqLI88I7ABNS4O/bRC6Rn4L0r5eaEZpN9yTm67VO/uECqVxf1r7bYvQHVSjyzvt6wk/SzAf6ixyLbxMnCD4gDgW+2DIurpep4kj3EsT7cdRKFV0Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkSLEcF9; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkSLEcF9"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso1243840f8f.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789370136; x=1789974936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g961FMFmva6MFSFgsk5zUmE0FV5DENfWVjlPpCRBaQ8=;
        b=hkSLEcF9nYaoDuuhkyHzO5DrpGOvzS2Gy1Irgzv0aHj4mmHNdojX2vP+d9LsxtTDme
         MYS8/lbY6ijSqjrRX1nSBjkfbG4ZeYtwyvjjSuB3caz7XcwVLwzI0yuip6x46kipQj2E
         qkjdtgtyRmBbOB9j9kztVR5e7ClYrdCiCWaoMEeN+q6F/X1jBlGW+XghottGfyZx93Qf
         lr3sqoK9H/xInmKuH3nZo4TensBJi93CbEFiuNrZ2FKGcdYqhBD3wqs7Q4GaY8nKYSel
         J8MChB650d+xGBNxlGoJl8eZJdmKvSV0WTElbSAHWRgqBxQChyJnuohiwGi6hUpiROB4
         k31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789370136; x=1789974936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g961FMFmva6MFSFgsk5zUmE0FV5DENfWVjlPpCRBaQ8=;
        b=KKRXXG5SY+r9f3E44Pi9ORN7YvmCQY3/840+Kp6KVEGK6CDsiVHej/+20DsHgibME5
         hZEipi0EkanGxt531dw//paeq5vs43b1oe0dxLPeurIQjZ1hX9ANqPXuqGH9Hmyi+l4w
         IFJLsPY3+YAeHsT6+tXCsmKUVz0z7U9I1eIqjhVys3PVhcIslZULQnDIlISGjrfjLHBw
         feExAmFp92Hs6LKl3MM6mJE/8LGGE4OYL4Z2xdGrd9PsezgZ1pLgojzJq9Y8l4wP5oTB
         cJktACU8+lGeo34PAgnNo9FJUBsUwl8UpcH9V7QXZYdZes+soy3szgbC3Q9+jgN3g99W
         e5tA==
X-Forwarded-Encrypted: i=1; AKwUvBwegG3RvXQgotLlNk6U4XqFUyGrBCsH9XcmgsSX64bZBGXqSlgTxe6ehgyz+0+q5O1DIj80NCI=@vger.kernel.org
X-Gm-Message-State: AFuF++lq1a1qriQBPjDh+l400G9KAdY90Gd4sedV3SROmjJO1/FqKEIN
	abdQxT77lVR2jkEDU9cTNbqS2FicFI3XYaDP52RdtYbPuzqVTUAyIlZo
X-Gm-Gg: AYBFou2SFH6larnz6bqrAN6SFBCAua1g3A6FAyuqIgl8OZAHHQBb4yV1xyPW4jOVHZ2
	xJYVgU7W87HLyyNC0IgTHjeL47wwPAKX/KrvWVTu+5R0tjmAYm3XHw+/ZRwmqmkpb3wxhEZC4+7
	qwgeAW0yFonFxe/hiOKYwjr1d0/nJzqAtThnV8VIgRQxvfDwIQAtvuIW1Te7KGZ1iP07Dg8128b
	OrnxXzyJXM7aidxgRuja5CwwGL9+zsn1jyU0cXXCeO7w40640fK0qvxUoBSdSeOFJCKmNsYMi6Y
	co2bmEZx5EIy9ZMBHQAR6kJKdogi79gLxAjZMhEMwoYH0az3EaT7LyVFfoouKewIdkxnEJy5nFG
	y/oUG+iQibKG7L2B1ngyt75OLsy+6VtqZZrNZsujtqgCRQd4sV6XHlxupEbOI+Uvr5kAufjpmzC
	70YFcgtP3WtpGrz0x8/acij0GKe536Y44ZIC9eOvpNWs20OviqGDMF4jOPINyQvBnaroXW++LtX
	dOHlpqyOenJcnBFnIAwYjHpllTit13YtNbVxD/fnQ==
X-Received: by 2002:a05:6000:98f:b0:486:fe85:ec9b with SMTP id ffacd0b85a97d-48702ac343emr1115649f8f.24.1789370135494;
        Mon, 14 Sep 2026 00:15:35 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34e4b5sm24472558f8f.22.2026.09.14.00.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:15:34 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net-next v14 0/4] ptp: ocp: add TAP CPLD support for ADVA TimeCard X1
Date: Mon, 14 Sep 2026 10:15:27 +0300
Message-ID: <20260914071531.11640-1-maimon.sagi@gmail.com>
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
through devlink flash.

The card has two I2C controllers.  Linux registers only the one at
0x00150000, normally routed to the config EEPROMs; the one at 0x00120000
belongs to the on-card MicroBlaze and is routed to the TMC or M.2 bus as
its firmware selects.  A request/grant handshake re-routes the host
controller onto the TMC bus, where the PCA9548 and the CPLD behind its
channel 0 live.  Everything here is built on that handshake.

Patches 1 and 2 are pre-existing probe-error-path bugs that were buried
in the feature commit in v13; they are split out with Fixes: tags, as
requested.  Patch 1 is also a prerequisite: patch 3 adds a mutex that
ptp_ocp_detach() destroys, so devlink has to be unregistered first.
Patch 3 adds the bus arbitration and the read-only interfaces, patch 4
the flashing.

v13: https://lore.kernel.org/netdev/20260908122328.52641-1-maimon.sagi@gmail.com/T/#u

Changes since v13:

 - The CPLD is no longer flashed through the firmware-upload subsystem.
   It is a devlink flash component instead:

     devlink dev flash pci/0000:02:00.0 file cpld.bin component fw.cpld

   ->info_get() reports fw.cpld as a running version with
   DEVLINK_INFO_VERSION_TYPE_COMPONENT, carrying the USERCODE of the
   image in the part, which is also what makes the core accept the
   component name.  No component still means the card flash.  This
   removed fw_upload_ops, the adva-cpld.N node, the FW_LOADER/FW_UPLOAD
   selects and the cancellation state machine - and with it a race where
   a cancel arriving after one upload finished could abort the next.
   Patch 4.  (Jakub Kicinski)
 - cpld_status now contains the names of the flags that are set, space
   separated, and an empty line when none is, instead of
   "done=<0|1> busy=<0|1> failed=<0|1>".  Patch 3.  (Jakub Kicinski)
 - The commit was split; the two pre-existing fixes it contained are
   patches 1 and 2 with Fixes: tags.  (Jakub Kicinski)
 - The flash path now validates the state after REFRESH - DONE set, not
   busy, and no sysCONFIG error - and fails the devlink command rather
   than reporting success for an image that did not come back.  Patch 4.
 - adva_x1_mblaze_release() waits for the firmware to drop the grant
   instead of writing RELEASE and returning, and warns if it does not.
   Patch 3.
 - The i2c bus notifier only caches the adapter number for the card's
   own controller, not for an i2c-mux child registered on it.  The
   adapter is also resolved once from probe, because the notifier fires
   from inside platform_device_register() - before bp->i2c_ctrl is
   assigned - whenever the i2c controller driver is already loaded.
   Patch 3.
 - ptp_ocp_devlink_info_get() checks bp->has_cpld explicitly rather than
   relying on cpld_id being zero on boards without one.  Patch 3.
 - ptp_ocp_sync_work() no longer latches the one-shot ID read on -EBUSY,
   so a read that collided with a CPLD operation is retried.  Patch 3.
 - Documentation/networking/devlink/ptp_ocp.rst documents the flash
   components and states the accepted image format: a raw bitstream, a
   whole number of 16-byte pages; .jed and other containers are
   rejected.  Patch 4.

Tested on an ADVA TimeCard X1: a full erase/program/refresh cycle of a
6526-page image through "devlink dev flash ... component fw.cpld", the
CPLD reporting done afterwards and still done across a reboot, and both
rejection paths (a .jed image, and an unknown component name).


Sagi Maimon (4):
  ptp: ocp: unregister devlink before detach on probe error
  ptp: ocp: fix dpll cleanup on probe error
  ptp: ocp: add TAP CPLD access for ADVA TimeCard X1
  ptp: ocp: add TAP CPLD flashing via devlink

 Documentation/ABI/testing/sysfs-timecard     |  28 +
 Documentation/networking/devlink/index.rst   |   1 +
 Documentation/networking/devlink/ptp_ocp.rst |  70 ++
 MAINTAINERS                                  |   1 +
 drivers/ptp/ptp_ocp.c                        | 774 ++++++++++++++++++-
 5 files changed, 868 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/networking/devlink/ptp_ocp.rst


base-commit: 879e280b8486d4612ad1aa050d6fada2dd80cf1c
-- 
2.47.0

