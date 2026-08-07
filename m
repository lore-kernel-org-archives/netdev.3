Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15F63F6C5F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096718; cv=none; b=tSA8rCpfnZX4b66UD2vAx+senYnEa+Z2+pBrApoBZg6k7d7IUkZydng6MURtvQOUL3j9c1lGLJPNDcZMn6LYc4l2K5GWa9kDOnif0qnbT/0jnUu65vc7eNfGpZ5oggYZ1KI6JWijLivts8NtaRKMjvJBrb8sgfCPEtKiJ4zMZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096718; c=relaxed/simple;
	bh=TkFjR4BsAQVCmBq9LtMKCNVzQavpzs+eY/KB6yUHnSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXhRMaLir3PD2DzjcdWiWfpAkFXW4TNVvyntAbh2iN/TvwzgvC5SVwE9BBbJHr1qaiso3QuR/dNlAX4AzAAV50ccZ3ffkP6VmSZ5QW6p2gP8ENs8bUfa9XgKD4GiX19USFWM5U9EBTiZRkf+HAvvPRoNzpRdFnOtjDTG8Wxs1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xyf00PiA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xyf00PiA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786096715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WpPcjcfPLKMPB/S/zYbq+QWgxEqwxZXN4wTls5spDRg=;
	b=Xyf00PiASyb0pWPSR1bftfXdIjUVLYhQVeg0tdIli8L3+q6K0cOJx0kXmqiwLDfWSzCD/4
	DaoNHkuOYzeQmsEWlG6dl3lahqFPdcCaaZ7jwsm7VdO+TTu890qsAj/ZlnHqWpbJXjMgX1
	2SGKBf/0Z0bRvwUtxck2Ee1lAMpr3rI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-URcM9PObN863tLQnF1BREA-1; Fri,
 07 Aug 2026 05:58:32 -0400
X-MC-Unique: URcM9PObN863tLQnF1BREA-1
X-Mimecast-MFC-AGG-ID: URcM9PObN863tLQnF1BREA_1786096711
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E92A19560A5;
	Fri,  7 Aug 2026 09:58:31 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.215])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE3771956094;
	Fri,  7 Aug 2026 09:58:27 +0000 (UTC)
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
Subject: [PATCH net-next v5 0/3] dpll: zl3073x: add PTP clock support
Date: Fri,  7 Aug 2026 11:58:23 +0200
Message-ID: <20260807095826.386756-1-ivecera@redhat.com>
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

Link: https://lore.kernel.org/netdev/20260803140637.102339-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260730132150.371376-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260713103739.1553284-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260708170527.916035-1-ivecera@redhat.com/

Changes:
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
 drivers/dpll/zl3073x/chan.c  | 321 +++++++++++++++++++++++++-
 drivers/dpll/zl3073x/chan.h  |  32 +++
 drivers/dpll/zl3073x/core.c  |  17 +-
 drivers/dpll/zl3073x/core.h  |  23 ++
 drivers/dpll/zl3073x/dpll.c  | 431 +++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h  |   5 +
 drivers/dpll/zl3073x/regs.h  |  52 +++++
 8 files changed, 855 insertions(+), 32 deletions(-)


base-commit: 4fa4977a0d900f936bcae5cd2c510be5554e8dd6
-- 
2.54.0

