Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF4530566D
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766007; cv=none; b=YVt32tZyQKUh2xnPflaG6LiQckq7YL9mY4tvHqtCmd1naAutb1Pfv78V/RF0VyFDgSmvJvIu9fubX++QbVI5A5FQcmM+rQtvuWUDfwV+QI5jjRRL9obGUVqKI6RRNL3JTTBJrYaCvgf1czN+W34OQMQVJ26f62hgh/7tSZ8RIMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766007; c=relaxed/simple;
	bh=ZbOJghhQk03x+p6oqd0K1f5jRFcvbUXgo2tvfi7aDxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twDG5tqGMkFpu660YMvSI1H1Nl4bO7jmO5QaC9ojrGbOQ/hlFjqXpYh/bWZ8PrRfxKGOFnn1lUi/fFmcLHyB8GWTHmpPG/OTHbRtEJznHOkBi1F2Et/7AP0OOIqzatbibWv/ACwKscLsjDPJeV3uiH/GJxt74Phve8X32JxZYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ex7BVFCQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex7BVFCQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785766004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XcnYeSRI7yHffVct0RoEaEGJWbiBStfw/UJAe2slSXI=;
	b=ex7BVFCQtJNLfGvbpuZSRAkTwdj6J+rmgoZRicvBSOlreafLfxYGZEe4Q28irGPzHyAY1N
	1+SimWlQkdVTUOHZYKngl+7NvpobYMeMEw3jzEBGPMSECXiRvZee+PdZrya98khA0bk2hm
	lsZdhrx7hPC5tAnG1prj78EjqKunIIE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-BEnOuGhXN4Wc_LFI6Iqn8w-1; Mon,
 03 Aug 2026 10:06:43 -0400
X-MC-Unique: BEnOuGhXN4Wc_LFI6Iqn8w-1
X-Mimecast-MFC-AGG-ID: BEnOuGhXN4Wc_LFI6Iqn8w_1785766002
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 941E919560AD;
	Mon,  3 Aug 2026 14:06:41 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.235])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84664414;
	Mon,  3 Aug 2026 14:06:38 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 0/2] dpll: zl3073x: add PTP clock support
Date: Mon,  3 Aug 2026 16:06:35 +0200
Message-ID: <20260803140637.102339-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add PTP hardware clock support to the zl3073x DPLL driver.

Patch 1 adds low-level channel operations for ToD read/write/adjust,
output phase step, delta frequency offset write and TIE write as
building blocks for PTP callbacks.

Patch 2 registers a PTP clock device for each DPLL channel with
gettimex64, settime64, adjtime, adjfine, adjphase and getmaxphase
callbacks. Callback availability adapts to the current channel
state - adjfine requires NCO pin connected, adjphase uses TIE write
when tracking a reference, and adjtime selects the appropriate
mechanism automatically. Periodic output support will be added in a
follow-up series.

Link: https://lore.kernel.org/netdev/20260730132150.371376-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260713103739.1553284-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260708170527.916035-1-ivecera@redhat.com/

Changes:
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

Ivan Vecera (2):
  dpll: zl3073x: add channel ToD, phase step and TIE operations
  dpll: zl3073x: add PTP clock support

 drivers/dpll/zl3073x/Kconfig |   6 +-
 drivers/dpll/zl3073x/chan.c  | 310 ++++++++++++++++++++++++-
 drivers/dpll/zl3073x/chan.h  |  32 +++
 drivers/dpll/zl3073x/core.c  |  13 ++
 drivers/dpll/zl3073x/core.h  |  23 ++
 drivers/dpll/zl3073x/dpll.c  | 425 ++++++++++++++++++++++++++++++++---
 drivers/dpll/zl3073x/dpll.h  |   5 +
 drivers/dpll/zl3073x/regs.h  |  52 +++++
 8 files changed, 836 insertions(+), 30 deletions(-)


base-commit: a5c6ae8de11ef0c3aedbe5e123354aad87d0d925
-- 
2.54.0

