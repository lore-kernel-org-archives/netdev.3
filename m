Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615FF241CB7
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939074; cv=none; b=OPUycwBqmcsdXN2LFz+LTTAsRIf0dp+sW0MtPiyffBKKb3q9yEjEwzTe0/gZk+twz8zw5+yYxaRtcskf7gTxf+TRTbFFiTjFgOaCvbwDO5dEg0c7iuIyCFI14G8IfRoyBG/ZMo0QEqC9S2DM+uOj/nmQzAk1RdH1AL19TPPVZnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939074; c=relaxed/simple;
	bh=GBDeQGvJvzFm3l6aVopE+RMkCnNflqPUrxPY/0kZRho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gK82ErJuiVnn/6ijemyLH0rlaF/I3dFEMiw3QcZRKXcD2+mcjG3wVCLjy5dtTCKMNjw63qlkXweedsw1rvWR1hVN4R4bBKR6scdvVu6aCKPmxBqOXDaIe/A+X/cPue0t4pVK6NbWm+0ji9EewDQ2FEovER5q5hZctWuJhDd9dYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ID2hvAX3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ID2hvAX3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783939071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8uNbZSE0AGsoQ8oKNsUmYICr1R9RDojzRbFVBlzR9b8=;
	b=ID2hvAX3123k/3RUzmvMX/PQEQBKWnVsnGYk8jLGd6gu8x41sLVLuJOqnQRVwIv7btEcZ4
	aTsNvSB5mDHdpej8ZT7ZfTagZR20TuVBL1UPo2JU50fUkx53TTb+uuf9nZOTLR6lXUYusb
	mJzvHQ1Ew4RLQnsBsKjdD6xRIPv6+zw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-TFM6ifqfN9uAAdAJ9rar9g-1; Mon,
 13 Jul 2026 06:37:47 -0400
X-MC-Unique: TFM6ifqfN9uAAdAJ9rar9g-1
X-Mimecast-MFC-AGG-ID: TFM6ifqfN9uAAdAJ9rar9g_1783939065
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 013311805A06;
	Mon, 13 Jul 2026 10:37:45 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.34.53])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0A1C1956056;
	Mon, 13 Jul 2026 10:37:40 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] dpll: zl3073x: add PTP clock support
Date: Mon, 13 Jul 2026 12:37:37 +0200
Message-ID: <20260713103739.1553284-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add PTP hardware clock support to the zl3073x DPLL driver.

Patch 1 adds low-level channel operations for ToD read/write/adjust,
output phase step, delta frequency offset write and TIE write as
building blocks for PTP callbacks.

Patch 2 registers a PTP clock device for each DPLL channel with
gettimex64, settime64, adjtime, adjfine, adjphase, getmaxphase
and perout callbacks. Callback availability adapts to the current
channel state - adjfine requires NCO pin connected, adjphase uses
TIE write when tracking a reference, and adjtime selects the
appropriate mechanism automatically.

Link: https://lore.kernel.org/netdev/20260708170527.916035-1-ivecera@redhat.com/

Changes:
v2:
  - Squash low-level ops patches (1+3) into patch 1.
  - Squash PTP callback patches (2+4) into patch 2, register PTP
    clock regardless of initial channel state.

Ivan Vecera (2):
  dpll: zl3073x: add channel ToD, phase step and TIE operations
  dpll: zl3073x: add PTP clock support

 drivers/dpll/zl3073x/Kconfig |   6 +-
 drivers/dpll/zl3073x/chan.c  | 307 +++++++++++++++++++
 drivers/dpll/zl3073x/chan.h  |  48 +++
 drivers/dpll/zl3073x/core.c  |   8 +
 drivers/dpll/zl3073x/core.h  |   8 +
 drivers/dpll/zl3073x/dpll.c  | 575 +++++++++++++++++++++++++++++++++--
 drivers/dpll/zl3073x/dpll.h  |   6 +
 drivers/dpll/zl3073x/regs.h  |  56 ++++
 8 files changed, 978 insertions(+), 36 deletions(-)


base-commit: 4a13f31a92f35161b499bf29638336885259da78
-- 
2.53.0

