Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0B249E13A
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300688; cv=none; b=dyK3cgGIYl7TPkexD4b+yBiUXbFQ4NPpUilMjMZ330No0GNpA4qV2dXBWS2qicBJrk2jtYGJFT8bZK7TTbAkkFMX7HHfQyPUDS83lhS8J0CiTc/FInNtvY3FcbNjBi4fXStEv4FRC+DTPvF/g2p6UH6tWoCzENjd6Q17kMQLrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300688; c=relaxed/simple;
	bh=4YprMsA0rYmg1C5T9O1OIX0LkbAiyDMVZbrjizPZjTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnRQ1J6KdC4SWJxU4m5TRTi/+XVN9eV0ppX+rYFWzNfCk2M/jElGfjDUNPatomsLq+af7QisX2pJaW5ZN74tSCkG8l6XjI1/PyZeo4d2+Ov+/txwrRNjkSmSFSrdQz3eFIt2012m/IdGbLgAuJfPXDs7uEqJqfWacJ22hWhwOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elDxQu6f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elDxQu6f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791300685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4SUKNY2zPOoLsxFBrSx8RHd1xV9n4K16rYqMyf1qrOA=;
	b=elDxQu6fRDtIyQtdh7PNXvhiYs90rG08T81STM7AyicmHfk8x5vYTbXk37cYETChIT9JHG
	EOJ73zN1KD9snKZ+A6OR8ZnznnJv2i8CKcpBWUy6A9X4uVoiXtb6NDr3Qlq4zMIlCbzmj+
	Uwa4VkQxWLumy4YpSByIi8exlOIA1vM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-SCnxEVWGOa-4OCaV_Rih8w-1; Tue,
 06 Oct 2026 11:31:22 -0400
X-MC-Unique: SCnxEVWGOa-4OCaV_Rih8w-1
X-Mimecast-MFC-AGG-ID: SCnxEVWGOa-4OCaV_Rih8w_1791300681
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAE14184A093;
	Tue,  6 Oct 2026 15:31:20 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3053E1800592;
	Tue,  6 Oct 2026 15:31:17 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Min Li <min.li@microchip.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/4] dpll: zl3073x: fix output pin frequency, esync and sibling notifications
Date: Tue,  6 Oct 2026 17:31:12 +0200
Message-ID: <20261006153116.347497-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series fixes several issues in the zl3073x output pin handling.

Patch 1 rejects output frequencies whose divisor is too small for the
hardware (less than 2, or less than 4 for the N-pin of an N-divided
output) as well as a zero frequency; such frequencies were accepted and
offered to userspace before.

Patch 2 makes the embedded sync (eSync) configuration follow the output
carrier frequency. Changing an output pin's frequency did not update its
eSync period/width, so eSync ran at the wrong rate and, for a 1 Hz
carrier, could get stuck on because esync_get() hides it. This was hit
during development and confirmed on an oscilloscope.

Patch 3 rejects N-divided output frequencies that cannot be represented
exactly. Such requests used to be silently rounded, which could also
change the sibling N-pin frequency.

Patch 4 notifies the sibling pin of an output pair when a shared HW
setting (divisor, clock type, eSync period/width, phase compensation) is
changed through one pin, so userspace is told the change happened. It
also ties the zldpll->pins list membership to the DPLL registration
state so the sibling lookup cannot miss a registered pin during probe or
teardown.

Changes since v2:
- Added patch 1 ("reject output frequencies with too small divisor").
- Added patch 3 ("reject inexact frequencies for N-divided outputs"),
  ordered before the notification patch so that a successful P-pin
  frequency change is guaranteed to keep the N-pin frequency unchanged.
- Patch 2: simplify zl3073x_out_esync_is_enabled(); reword the
  esync_get() readback note to only claim what it does - it reports the
  driver's nominal 1 Hz / 25% eSync model and does not faithfully report
  a configuration the driver did not program.
- Patch 4: add/remove pins from zldpll->pins around dpll_pin_register()/
  dpll_pin_unregister() so a registered sibling is always findable by the
  notification lookup (fixes a lost notification during probe/teardown
  pointed out in the v2 review).

Changes since v1:
- Patch 2: pass the actual output carrier (synth_freq / out.div) to
  zl3073x_out_esync_enable() in the frequency change path, matching
  esync_set() (no functional change, output frequencies always divide
  the synth frequency); drop the redundant "? true : false" reported by
  coccinelle (boolconv); note in the commit message that esync_get() now
  reports the fixed 1 Hz / 25% values the driver programs; fix a comment
  typo.
- Patch 4: narrow the commit message wording about zldpll->lock to the
  new sibling lookup helper (no code change).
- Both original commit messages now describe how the issues were found
  and whether they were triggered, as requested on the v1 thread.

v2: https://lore.kernel.org/netdev/20261002074520.30048-1-ivecera@redhat.com/
v1: https://lore.kernel.org/netdev/20261001080648.1424172-1-ivecera@redhat.com/

Ivan Vecera (4):
  dpll: zl3073x: reject output frequencies with too small divisor
  dpll: zl3073x: make embedded sync follow the output carrier frequency
  dpll: zl3073x: reject inexact frequencies for N-divided outputs
  dpll: zl3073x: notify sibling pin when shared output config changes

 drivers/dpll/zl3073x/dpll.c | 244 +++++++++++++++++++++++++++---------
 drivers/dpll/zl3073x/out.h  |  36 ++++++
 drivers/dpll/zl3073x/prop.c |  29 +++--
 3 files changed, 241 insertions(+), 68 deletions(-)

-- 
2.55.0

