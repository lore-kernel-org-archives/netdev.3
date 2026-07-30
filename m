Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA542CAF9
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417720; cv=none; b=d5LglN1c4WqaPZ1i6bDp4BFquQJ8bMDwvB2pd/PDl7AH2dtlNHRAdDXnvyt2qto+zUyMIJmrrf86EHS03/dMftKYAL+Q/w+PNBQhMyNvLjWWL6SXNXVppPd3r+e/J53GhanFAZrP0XWf4VuW45vam/L/F3r+CSBOfckVr35F2Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417720; c=relaxed/simple;
	bh=iqjldl6ziM3PQ/chpIC+u25LH1PALre9JDBnIBTPVPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XX3Z0KBfF6kwEsm+650BLzy1D/Dg5KhgUrmEgZj6v2XKj7qBp7hOO9Xe2xSP+Vujqu/80idBClmIZXRNiR/VHbs4fX4JZophzSSr5+IobcloS+LCi2H8G458IyEDsjUCnHETtu5DOnaRrjq7PMdnJgLRmJ3fwhO44nWHqw/awIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXbQhb4e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXbQhb4e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785417718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ve69xuHtOFCsNoesqH3C4cA4WzBZ2DQJvEeMpNiVWr0=;
	b=UXbQhb4e0RYDW1BsOMMSYu3sNDxxH58SOHbBzCV8mYFmQknCfCKbdPVu7AZ4xSc9ujmtEa
	1BdqB2cMudsHYYRmYmWPgaZTn54AEamXXxK728zzw9K6VkqasfGTfV1DdbFWS0rwIL2axW
	OAVk+gQoM2vq9gWsbZHirMR4RzAlLdk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-hxTusc1oOwOVsax2t1Frlw-1; Thu,
 30 Jul 2026 09:21:56 -0400
X-MC-Unique: hxTusc1oOwOVsax2t1Frlw-1
X-Mimecast-MFC-AGG-ID: hxTusc1oOwOVsax2t1Frlw_1785417715
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE3A118002E2;
	Thu, 30 Jul 2026 13:21:54 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.108])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A27CD1956094;
	Thu, 30 Jul 2026 13:21:51 +0000 (UTC)
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
Subject: [PATCH net-next v3 0/3] dpll: zl3073x: add PTP clock support
Date: Thu, 30 Jul 2026 15:21:47 +0200
Message-ID: <20260730132150.371376-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add PTP hardware clock support to the zl3073x DPLL driver.

Patch 1 adds low-level channel operations for ToD read/write/adjust,
output phase step, delta frequency offset write and TIE write as
building blocks for PTP callbacks.

Patch 2 factors out the output pin frequency setting logic into an
unlocked helper callable from internal contexts.

Patch 3 registers a PTP clock device for each DPLL channel with
gettimex64, settime64, adjtime, adjfine, adjphase, getmaxphase
and perout callbacks. Callback availability adapts to the current
channel state - adjfine requires NCO pin connected, adjphase uses
TIE write when tracking a reference, and adjtime selects the
appropriate mechanism automatically.

Link: https://lore.kernel.org/netdev/20260713103739.1553284-1-ivecera@redhat.com/
Link: https://lore.kernel.org/netdev/20260708170527.916035-1-ivecera@redhat.com/

Changes:
v3:
  - Use PTP_1588_CLOCK instead of PTP_1588_CLOCK_OPTIONAL (Jakub)
  - Factor out output pin frequency helper to a separate commit (Jakub)
  - Remove spurious #include <linux/mutex.h> from dpll.h (Jakub)
v2:
  - Squash low-level ops patches (1+3) into patch 1.
  - Squash PTP callback patches (2+4) into patch 2, register PTP
    clock regardless of initial channel state.

Ivan Vecera (3):
  dpll: zl3073x: add channel ToD, phase step and TIE operations
  dpll: zl3073x: refactor output pin frequency set for internal use
  dpll: zl3073x: add PTP clock support

 drivers/dpll/zl3073x/Kconfig |   6 +-
 drivers/dpll/zl3073x/chan.c  | 307 +++++++++++++++++++
 drivers/dpll/zl3073x/chan.h  |  48 +++
 drivers/dpll/zl3073x/core.c  |   8 +
 drivers/dpll/zl3073x/core.h  |   8 +
 drivers/dpll/zl3073x/dpll.c  | 575 +++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h  |   5 +
 drivers/dpll/zl3073x/regs.h  |  56 ++++
 8 files changed, 977 insertions(+), 36 deletions(-)


base-commit: a5c6ae8de11ef0c3aedbe5e123354aad87d0d925
-- 
2.54.0

