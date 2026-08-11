Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ABC445AD7
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456056; cv=none; b=ZBE3o4oRrvmHmd0jfxkEaAL6Or9bICkM1EelK5FviG3jw9lkGeav4oW+gMmUsQlyM3tBq9bHpMA94wExEls02zpACTr4KCjIQUzGrMH1p9veQXNFpzna8VuMcCBBPr4izt1VMU1lcOGCQE/3W1z9lziac+loBkZmQg5K0TSLi08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456056; c=relaxed/simple;
	bh=mZF6x2yWwwfP4i3qz58FVK/8EflUyq/PIlrkmuOaJdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WzVDRVK4hrdh6JfavuymSPIYgI+J7m0HRpBla4dgZUOt6Tk1QVTtWom2vwPDHng8tFfIUcXggLxYn825ehdCebm1UFqUR8LRAhvtEHSADJDUM7zCFQb9BuaEPKXrJk4r+kFhlQ0s7JeC/NcCAFfvAAL32NJN9cuZtoPxA3uBb2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYjPo0iY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYjPo0iY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786456042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fqzYBYARumeLeOpOkx/LwSnESVEcjZWwLchk9hGKnb8=;
	b=OYjPo0iYB6fF58e25t/ad/U7qgkCOEi5H7pFHVc5Iwg+5+lMlgNtLo5YbuaOh16OvtBWqO
	sArApIx+t4Cu0dibhtUCsXVQ1DtMarLr5FspggtNRWmsGj++l4ESA9ECZ/UCxBEh8K/s7Y
	ZCkSNfFDKg/cSyVYsIKWK/6FdPwadA0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-iX2s38GqOX2WmGujWydc2g-1; Tue,
 11 Aug 2026 09:47:08 -0400
X-MC-Unique: iX2s38GqOX2WmGujWydc2g-1
X-Mimecast-MFC-AGG-ID: iX2s38GqOX2WmGujWydc2g_1786456025
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 813321956057;
	Tue, 11 Aug 2026 13:47:05 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.196])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E1ED6195DF91;
	Tue, 11 Aug 2026 13:47:01 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v7 0/3] dpll: zl3073x: add PTP clock support
Date: Tue, 11 Aug 2026 15:46:57 +0200
Message-ID: <20260811134700.1211010-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add PTP hardware clock support to the zl3073x DPLL driver.

Patch 1 scales the poll sleep interval in zl3073x_poll_zero_u8()
proportionally to the timeout to avoid excessive bus traffic for
the longer PTP-related timeouts.

Patch 2 adds low-level channel operations for ToD read/write/adjust,
output phase step, delta frequency offset write and TIE write as
building blocks for PTP callbacks.

Patch 3 registers a PTP clock device for each DPLL channel with
gettimex64, settime64, adjtime, adjfine, adjphase and getmaxphase
callbacks. Callback availability adapts to the current channel
state - adjfine requires NCO pin connected, adjphase uses TIE write
when tracking a reference, and adjtime selects the appropriate
mechanism automatically. Periodic output support will be added in a
follow-up series.

Link: https://lore.kernel.org/netdev/20260807094430.120683-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260803140637.102339-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260730132150.371376-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260713103739.1553284-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260708170527.916035-1-ivecera@redhat.com/

Changes:
v7:
  - Check SEM bit before CMD in tod_ready_wait so stale CMD bits
    from a prior boot stage do not block ToD operations
  - Move ptp_info template assignment from alloc to register to
    avoid stale getcycles64 pointers on devlink reload
  - Update kernel-doc for tod_ready_wait, adjtime, adjtime_phase_step
    and tie_write to match actual return semantics
  - Update poll interval changelog to mention effect on all callers
v6:
  - Fix kernel-doc warning: move ZL_TOD_MAX_RETRIES define inside
    the function body to avoid confusing the kernel-doc parser
v5:
  - Add prep patch to scale poll interval with timeout
  - Enumerate all ToD commands in tod_ready_wait switch, return
    -EOPNOTSUPP with WARN_ON in default case (Vadim)
  - Handle CMD=0 (power-on default) in tod_ready_wait
  - Rewrite tod_adjust rollover guard as a retry loop that re-reads
    until the margin is sufficient, replacing manual fixup and fsleep
  - Fix "lowest-ID synth" comments to "first enabled synth"
  - Include dev_name() in PTP clock name for multi-device systems
  - Update kernel-doc for adjfine/adjphase to document zero no-op
v4:
  - Move out_step_time_mask to struct zl3073x_dev (device-global)
  - Fix tod_adjust rollover guard for tick-crossing case
  - Drop trailing tod_ready_wait from tod_adjust
  - Fix TOD_CTRL register item count
  - Move phase step registers into existing page 9 section in regs.h
  - Align ToD command define values
  - Update kernel-doc for chan_state_fetch
  - Drop perout support (will rework as follow-up)
  - Replace abs(delta) with explicit range check to avoid S64_MIN UB
  - Add locking context doc to zl3073x_chan_df_offset_set
  - Export zl3073x_chan_tod_ready_wait and wait for ToD completion in
    adjtime before phase step/TIE write to prevent WR_NEXT_1HZ from
    overwriting the sub-second adjustment
v3:
  - Use PTP_1588_CLOCK instead of PTP_1588_CLOCK_OPTIONAL (Jakub)
  - Factor out output pin frequency helper to a separate commit (Jakub)
  - Remove spurious #include <linux/mutex.h> from dpll.h (Jakub)
v2:
  - Squash low-level ops patches (1+3) into patch 1.
  - Squash PTP callback patches (2+4) into patch 2, register PTP
    clock regardless of initial channel state.

Ivan Vecera (3):
  dpll: zl3073x: scale poll interval proportionally to timeout
  dpll: zl3073x: add channel ToD, phase step and TIE operations
  dpll: zl3073x: add PTP clock support

 drivers/dpll/zl3073x/Kconfig |   6 +-
 drivers/dpll/zl3073x/chan.c  | 325 +++++++++++++++++++++++++-
 drivers/dpll/zl3073x/chan.h  |  32 +++
 drivers/dpll/zl3073x/core.c  |  17 +-
 drivers/dpll/zl3073x/core.h  |  23 ++
 drivers/dpll/zl3073x/dpll.c  | 439 +++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h  |   5 +
 drivers/dpll/zl3073x/regs.h  |  52 +++++
 8 files changed, 867 insertions(+), 32 deletions(-)


base-commit: b54074ffb813aa4b97585d97ae1ead69d96432b5
-- 
2.54.0

