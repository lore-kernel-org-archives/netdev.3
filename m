Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200741B351
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824149; cv=none; b=gDAMZm8UVCfmvIlIRAlnUpXFfTkzaxQDy7DmCq+L04XNXP4EX233BEVuqmPWirnKcq/4EWMxiDIUM1l6w3qzhHJQymA8/njXGYWy31oD3wU/DCjuF5lY+fw6cAhJUmln2VAo6P4IG6J1Cm/6Ezx+IBk66sK3vPyhqgPZq5Ajf/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824149; c=relaxed/simple;
	bh=8faOPPpxjFF2On6KXCEP+FzvS6v/7efQ4ZLp/78JcKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6JGyiNUwlinfPrrbPZ6yvxEP5l0xluk/KbfH9D0gjT1GQe05jTZCJEuv8791N9LJb7DAhKajsU4dhMyLJekwnPxsJvouv+c+Y9Xld9Fi97sayKylsSkZoOWiiduUK4EEhzGnv9bZXQ/NZE7DGSQ7B/FnXO30fpZsVga5c8SV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtIkXd37; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtIkXd37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782824145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yzElmUdjyljEt5e++NVUuqZ6wnCczv4jqGflrMq30u4=;
	b=CtIkXd37nmAy5GRCpmbAi83ch7QMKmN6AdDFVx8Olqu0HDu7RhHifsgBsBNtgZUF9SdWvN
	IpUeDHDuxne0Pjn3VrKJ/e5ICse8P53LtOVRB7qomVxt7UZQqzoH461HRLVBwTaEbvshK6
	k9JN25ghe5W9NkOOO8WGgfF8d87Ko/U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-15wHhNaMN9ezYrlYZfRXmg-1; Tue,
 30 Jun 2026 08:55:44 -0400
X-MC-Unique: 15wHhNaMN9ezYrlYZfRXmg-1
X-Mimecast-MFC-AGG-ID: 15wHhNaMN9ezYrlYZfRXmg_1782824142
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7977C1955F14;
	Tue, 30 Jun 2026 12:55:41 +0000 (UTC)
Received: from p16v.bos2.lab (unknown [10.43.2.199])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 77A9D180057F;
	Tue, 30 Jun 2026 12:55:37 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Michal Schmidt <mschmidt@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pasi Vaananen <pvaanane@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 0/5] dpll: add NCO pin type and zl3073x support
Date: Tue, 30 Jun 2026 14:55:31 +0200
Message-ID: <20260630125536.720717-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add a new DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
the NCO mode of a DPLL and implement support for it in the zl3073x driver.

Patch 1 adds a STATE_CONNECTED_OVERRIDE pin capability for pins that
can override input selection in any DPLL mode, with a WARN_ON check
in dpll_pin_register() that STATE_CAN_CHANGE is also set.

Patch 2 adds the new INT_NCO pin type to the DPLL netlink spec and
UAPI header.

Patch 3 replaces the single 2s poll timeout with per-operation timeouts
based on Microchip proprietary source code and own measurement.

Patch 4 adds a per-DPLL serialization mutex taken by all DPLL callbacks
and the periodic worker, establishing a single lock that protects all
per-channel state. The chan_state_update() call is moved under this lock.

Patch 5 adds a virtual NCO input pin to the zl3073x driver that allows
userspace to switch a DPLL channel into NCO mode. The pin reports
connected/active state when the channel is in NCO mode and handles
the hardware-specific details of mode transitions including automatic
df_offset capture and 1PPS phase preservation.

Link: https://lore.kernel.org/netdev/20260531194423.383366-1-ivecera@redhat.com/

Changes:
v6:
  - New patch 1: STATE_CONNECTED_OVERRIDE pin capability with
    WARN_ON validation in dpll_pin_register() and documentation
    in dpll.rst Pin selection section.
  - Use READ_ONCE/WRITE_ONCE for per-device freq_monitor and
    phase_avg_factor accessed from periodic worker without lock.
    Remove unnecessary zldpll->lock from phase_offset_avg_factor
    get/set callbacks (patch 4).
  - Configure dpll_df_read register (ref_ofst=0, cmd=ACC_I) before
    NCO mode switch with 25ms delays for internal register update
    (reported by Chris du Quesnay, Microchip) (patch 5).
  - Mark df_offset as unknown at probe when firmware left channel
    in NCO mode (patch 5).
  - See individual patches for detailed changelogs.
v5:
  - Rebased on net-next after the freq_monitor per-device fix
    landed via net.
  - Move phase_offset_avg_factor_set notification loop outside lock
    to avoid lockdep false positive on multi-channel devices (patch 4).
  - See individual patches for detailed changelogs.
v4:
  - New patch 3: per-operation poll timeouts
  - New patch 4: per-DPLL serialization lock
  - See individual patches for detailed changelogs.
v3:
  - fixed SoB position
v2:
  - See individual patches for detailed changelogs.

Ivan Vecera (5):
  dpll: add STATE_CONNECTED_OVERRIDE pin capability
  dpll: add DPLL_PIN_TYPE_INT_NCO pin type
  dpll: zl3073x: use per-operation poll timeouts
  dpll: zl3073x: add per-DPLL serialization lock
  dpll: zl3073x: add NCO virtual input pin

 Documentation/driver-api/dpll.rst     |   7 +
 Documentation/netlink/specs/dpll.yaml |  19 +
 drivers/dpll/dpll_core.c              |   6 +-
 drivers/dpll/dpll_nl.c                |   2 +-
 drivers/dpll/zl3073x/chan.c           | 128 ++++++-
 drivers/dpll/zl3073x/chan.h           |  48 +++
 drivers/dpll/zl3073x/core.c           |  48 +--
 drivers/dpll/zl3073x/core.h           |  12 +-
 drivers/dpll/zl3073x/dpll.c           | 489 ++++++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.h           |   4 +
 drivers/dpll/zl3073x/regs.h           |  11 +
 include/uapi/linux/dpll.h             |   8 +
 12 files changed, 677 insertions(+), 105 deletions(-)


base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e
-- 
2.53.0

