Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7A446067
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786696030; cv=none; b=h/ws4LiITMQ1MUocmaT8zMbf9E8yNe1IuCC84CE9xvoIVonkCK/uAN6+5bwqjZ+kErGwd226TIhTXrMn2VHjdKlZsGhV6ZuxyMLDBu8BkBYCNQHW9LNHFOpf/ji8dhNAmGT3AVcNglCBB32gjKXPSVW2MJn9WaywEHmqz26JLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786696030; c=relaxed/simple;
	bh=Ha8L8mFLWFoe3O9OZRr874wr+VyVnNE6XKepMhQSwzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfVw9cS6dtY/NRj0a4+VCw68/P8iIVISkQxmp7+sozmTWXh+mU3lA2qPRu/D3A+GB2NFhheg4noCY/9/CjMudsRjzlohvxzM2sRb+n6h/KKtDonUzlyfmI5TeJQ/wr/xsgkipGdyhotWRyYMWsC5j5YvVOlmRHZlEyzBN/p0ILw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXBclLVE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXBclLVE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786696025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UXtaoxO//JwccS2cWYWcUTiurxyTUG1SgWuJiBB/DGs=;
	b=ZXBclLVEFaX0Xu+SnogXzxQzEvf9JMYct+YyUgRD2+J+E/9lyJPZGsbPuRkwaBeFvBwIkM
	IMUs1VxgaRQF4LBjAwu1PyCdvLWfibxwJM/wUqOa28nfjkeJkWLL2R+hOGJEa9aQoH1mvc
	1uvqfrmSVFisyR26kWYxb642SUlWdYs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-gXV8wgz0N_yN7Xc0pv0lvw-1; Fri,
 14 Aug 2026 04:27:04 -0400
X-MC-Unique: gXV8wgz0N_yN7Xc0pv0lvw-1
X-Mimecast-MFC-AGG-ID: gXV8wgz0N_yN7Xc0pv0lvw_1786696022
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA2B71956080;
	Fri, 14 Aug 2026 08:27:01 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.131])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 246F930001A2;
	Fri, 14 Aug 2026 08:26:57 +0000 (UTC)
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
Subject: [PATCH net-next v8 0/3] dpll: zl3073x: add PTP clock support
Date: Fri, 14 Aug 2026 10:26:53 +0200
Message-ID: <20260814082656.306534-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Link: https://lore.kernel.org/netdev/20260811134700.1211010-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260807094430.120683-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260803140637.102339-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260730132150.371376-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260713103739.1553284-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260708170527.916035-1-ivecera@redhat.com/

Changes:
v8:
  - Drop WARN_ON from tod_ready_wait default case and drop tie_write
    range guard entirely (Vadim)
  - Use timespec64_valid_settod() in tod_adjust (Vadim)
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
 drivers/dpll/zl3073x/chan.c  | 321 ++++++++++++++++++++++++-
 drivers/dpll/zl3073x/chan.h  |  32 +++
 drivers/dpll/zl3073x/core.c  |  17 +-
 drivers/dpll/zl3073x/core.h  |  23 ++
 drivers/dpll/zl3073x/dpll.c  | 439 +++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h  |   5 +
 drivers/dpll/zl3073x/regs.h  |  52 +++++
 8 files changed, 863 insertions(+), 32 deletions(-)


base-commit: 4f93b12cf7b25fbf8e73d222722805b049f0a6d3
-- 
2.54.0

