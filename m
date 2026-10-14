Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9C4A260F
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 22:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016552; cv=none; b=SjC9Tl9cqYP34Tn2cu8TpGYwQsSWEwjZsfkXvIJIeHCOnvtXNVId7kz0+xOtj0L3tAuxRmEbIqTdwBf+tSUQQfvHNLl0PxXFGroA35XNmZJlqZde9yovlAVzy6yxPO/aBwss1KnJdz4dsXG56Yg883qs17amZ4jtZ2qbmMIj7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016552; c=relaxed/simple;
	bh=xFEmAAT49vOrGlbwyZJCJpFg7gwDK6WlTjnMnrxO8bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjYd0tb3Ps3Bg6JbLUH2AbjL1ASGNLxmpd145LPQ4tNSQ0t63Zl2XvHgt8f6hHy78cXMLw0PXYfwNEH7gYa1XG3eh3ShyYSFEJwpFQbkkuhKItAnA2E47x/zZunhI7dFI8G6tmGnLKLDtpYJ3oXdQAnkIamV6u4fLGXU3FrSwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUjUgw7r; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUjUgw7r"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2156504eec.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 15:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792016550; x=1792621350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2b7f1ifOYnCy9LytpiVooR3kRz3vXe1JYmZB2bLzwcY=;
        b=UUjUgw7rcVdbgL1OES4tTklOrZBQSJKt4SIH6hfwZ2AV9afaf1nG/XNywi6iVdrOLw
         oTuMEaw+YfXcDoVoPAtX/D1iEr7BQ8I2JreFByfSpFj4mYZX4C/U2XzRvedNvZaGt9/j
         OUcUEXo9xhXWM3c3l8cFbJ5YkmugLcJE47UM7ngENVXmB9AXrB7zltVZcz9tttA+awgj
         3zejwZGyY8jIGh46LwQr9PgapKLf24nwqfifL+/43Plwkrg7E4rfi944gMTCc2GqP2f8
         T5mifXZbdyP62krikIUEvoboEYGuyVdswrvqZ+ROL+JoHy1z1PhSSRy6e2/N08j4AfVe
         u+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016550; x=1792621350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2b7f1ifOYnCy9LytpiVooR3kRz3vXe1JYmZB2bLzwcY=;
        b=rjVBqLh7oDi3rUsWx5Jq1/byHWkl5aPvKYTnsdlmxRuThSiZWIXidCiNquIhD5Of3Y
         xldbnyoQkdB0sxukY8BE8A8/4fZ8tHfo6A/qMOviHOokUnZgfMobwWFhc4qORCm8I6xJ
         xQOpi5de6Qcfl2VDtKwT9YHydcYKJUVYsE9qG2iN+ZhpDGOAzfFNewomga+ise/KDjDD
         MxONWxjQpu+jnUX5Fz4fBzA527Yzz8xZ7160HQ7m/e3/4q8Fuws/AJYI2kJPjFs5o8Ug
         Y1Kj4nXj+93HUUJVFuPviE2DyLNBT7kIwy5eX0exDioLH0Pqy0JpiewmdrYqFAemJ20l
         3SAA==
X-Forwarded-Encrypted: i=1; AKwUvByEnttdZbvb+Qc7Nl8Ek2DrjOWMW1V7lA2fOODlpXnaNbgQn/xNrocB/EP2Wcz26LgZCbOdmR4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZQMD54v8/kUSr0EAbDyiriGEmkLgI4G87ZnDc9gy+vo2KWmJy
	2PsBQaSjk8n4fDc2XJUuYjkCNV7RpiYph21iF6slBKKxRrJLXWzY5NoH
X-Gm-Gg: AYBFou1kdnVSSwmsF8xgXEBudq6cKfqHRjio5+zzXUezfo2MR86heOG5vv88zvC4nih
	vLNzdqHGP4Qv2gbl3YYrt0BgZYeECFGYs1sY2K75OzR4jHatHszjSL29yOF5Lq0dmqc33tqT6kU
	bApjPIdNMlLcv23hWo8yCSVcaf6CHj+xDvihzRagsFD3i7bnHyMEuZ/ScTlefFhg1ebl4Ly5aDD
	ARuf1IOZ+q/N0AS6XkiX4/xaYevfkSqqZnKCyqRXqcp20GIsqwFOQgesRTz9NtoRgfqa/oLSaA9
	z6tQd9MTrV3vuo11wndFW8whFRAJLn/htbuNq2zCF/6B5FglmRsgfuLfbCL+gxgoh5aSsmFHhLd
	mGrTLo3bTRZ04HZi3eV/kraeRnNy4YKmGYeNwJjwSYJP5oWu9jSXqoyNcOEhlWpcejTm3X2PpRq
	NtI/7ZsVqvyx439XJmIV+Qx4waUCnvlUEMS3iu6cQux5fu/gFR3hvv93T1+z7iWzHahcNj14cp+
	fM5LowFEH/chBSYXw==
X-Received: by 2002:a05:7301:3a84:b0:351:985:e729 with SMTP id 5a478bee46e88-3537e01e8b6mr25315973eec.12.1792016549619;
        Wed, 14 Oct 2026 15:22:29 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::5:7561])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca6d202sm54635124eec.13.2026.10.14.15.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:22:29 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	linux@roeck-us.net,
	horms@kernel.org,
	hmohsin@meta.com,
	mike.marciniszyn@gmail.com
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	limzhineng2@gmail.com
Subject: [PATCH net-next v4 0/6] eth: fbnic: expand hwmon sensor support
Date: Wed, 14 Oct 2026 15:22:18 -0700
Message-ID: <20261014222225.2803660-1-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware capability response carries per-board sensor thresholds,
and the firmware reports which range a sensor has entered whenever it
crosses one of them. This series surfaces both to userspace:

 - Move the sensor read logic out of fbnic_mac, closer to its only
   caller in the hwmon code, and drop the now-unused get_sensor op.
 - Cache the temperature and voltage readings for the current jiffy so
   a burst of attribute reads issues a single firmware round-trip.
 - Parse and expose the temperature (min/max/crit) and voltage
   (min/max) thresholds. Thresholds the firmware does not report are
   not exposed.
 - Parse the range firmware reports, both in the unsolicited threshold
   event and in the sensor read response, and cache it per sensor.
 - Expose temp1_alarm and in0_alarm from that cached range, and notify
   on each crossing through hwmon_notify_event().
 - Derive the range from the reading carried with the event, on old
   firmware that predates range reporting.

Changes from v3:
 - Moved cache seeding to fbnic_mbx_init() in patch 2, so it also runs
   on resume and AER recovery paths rather than only on probe.
 - Dropped previous patch exposing all hwmon attributes unconditionally as
   read-only. Thresholds the firmware does not report are now not visible
   in sysfs.
 - Collapsed the five per-threshold alarm attributes
   (temp1_{min,max,crit}_alarm, in0_{min,max}_alarm) into one alarm per
   sensor, temp1_alarm and in0_alarm. Firmware reports which range a
   sensor is in rather than per-limit flags, so a single attribute
   matches what the hardware reports.
 - That alarm now comes from the reported range rather than from a
   driver-side comparison of a live reading against the thresholds.
 - Split the alarm work into two: patch 4 parses and caches the range,
   from both the unsolicited event and the sensor read response, and
   patch 5 exposes the attributes and notifies on each crossing. The
   previous "firmware notifies hwmon on sensor threshold events" patch 6
   is now folded into those.
 - Added patch 6 for firmware that predates range reporting, which
   flags only that a limit was exceeded.

Changes from v2:
 - Addressed Jakub's patch 3 feedback on jiffy comparison when
   checking cache validity.

Changes from v1:
 - Addressed Jakub's patch 6 feedback on including a
   if (!IS_REACHABLE(CONFIG_HWMON)) return; guard.

Zinc Lim (6):
  eth: fbnic: move sensor read logic out of fbnic_mac
  eth: fbnic: cache hwmon sensor readings
  eth: fbnic: report temperature and voltage thresholds via hwmon
  eth: fbnic: parse the alarm range reported by firmware
  eth: fbnic: report temperature and voltage alarms via hwmon
  eth: fbnic: derive the alarm range on older firmware

 drivers/net/ethernet/meta/fbnic/fbnic.h       |  11 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 140 +++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  44 +++
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 332 ++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   |  55 ---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |   2 -
 6 files changed, 500 insertions(+), 84 deletions(-)

--
2.53.0-Meta
