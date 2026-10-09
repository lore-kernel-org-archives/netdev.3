Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F516459AD5
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573982; cv=none; b=O6vDmkCw62BFIV3bckwju5EWH0Ec0IPC54rIxKfq2Abdq/miFBs095ud5uV3vaiGDhtvcb7BZsFuK+GX57zFaWoXro+EmigPWZ47KbH744rzsXNHzfUxkUq73rOLOBELczKvIxQmx3z/JrxwUNJQba2TJEopaPWljJZIIs22wvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573982; c=relaxed/simple;
	bh=fdt/b8OQvRdoVdjdggZpBSwOT1AmS4X7S1z5GH2GJHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vf44vlI77JhlTwoxq5ABGbP1XWEIodWg0Yu21rlJT1FnvcUCcHQiFb7fhWCzJOaWGaxQftEtCZAPw2SDrvvSBX8K6bk7RMrOA5Mv4cRmkqfapXSdQCMK7lH2ZaKDfimGm/nyzASyaIBNj8B30jolKl2odJi5ebGiTij7Mk0oT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdC4yqAk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdC4yqAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791573974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Iwt0nYxaRyrgSyypUr+4YtTlj4UkzxsZeKXIwuV3Feg=;
	b=EdC4yqAkKAsSt8AlPuLL1Pwblv6LRPmacCCTtXrDZBpJI2G21cOVwmwD+yXuuhLn03Whwd
	d2ufksMIpg9iUSrk1neQDgTcyggpt6CX2FpQKY+ERCyOf0MKIFBGEDUwE6TDMSFWNsIaAj
	Y9VCHQQ2dCVbCQs/2bZPcGGvM+tPzU8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-IgS9HxliNOurHMBlVRxeRA-1; Fri,
 9 Oct 2026 19:26:02 +0000
X-MC-Unique: IgS9HxliNOurHMBlVRxeRA-1
X-Mimecast-MFC-AGG-ID: IgS9HxliNOurHMBlVRxeRA_1791573961
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC3B41953996;
	Fri,  9 Oct 2026 19:26:00 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 17E2918004D2;
	Fri,  9 Oct 2026 19:25:57 +0000 (UTC)
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
Subject: [PATCH net v4 0/5] dpll: zl3073x: fix output pin frequency, esync and sibling notifications
Date: Fri,  9 Oct 2026 21:25:51 +0200
Message-ID: <20261009192556.272263-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series fixes several issues in the zl3073x output pin handling:

1. Do not offer 0 Hz as a supported frequency, it leads to a division
   by zero.
2. Reject output frequencies whose divisor is too small for the HW.
3. Update the eSync period and width when the output frequency changes.
4. Reject N-divided output frequencies that cannot be set exactly.
5. Notify the sibling pin when a shared output setting changes.

Changes since v3:
- New patch 1 to fix a division by zero reported by Sashiko.
- Patch 2: state that the check is necessary but not sufficient for
  N-divided outputs.
- Patch 3: report the eSync frequency and pulse from the registers again
  instead of a fixed 1 Hz / 25%; compute the pulse in 64 bits.
- Patch 4: keep the P-pin quotient in 64 bits and reject values above
  U32_MAX; check esync_n_period < 2 first; fix comments and extack.
- Patch 5: fix the sibling lookup kernel-doc and the commit message.

Changes since v2:
- Added patches 2 and 4.
- Patch 3: simplify zl3073x_out_esync_is_enabled().
- Patch 5: add/remove pins from zldpll->pins around dpll_pin_register()/
  dpll_pin_unregister() so a registered sibling is always found.

Changes since v1:
- Patch 3: pass the actual output carrier to zl3073x_out_esync_enable(),
  drop a redundant "? true : false", fix a comment typo.
- Patch 5: commit message wording.

v3: https://lore.kernel.org/netdev/20261006153116.347497-1-ivecera@redhat.com/
v2: https://lore.kernel.org/netdev/20261002074520.30048-1-ivecera@redhat.com/
v1: https://lore.kernel.org/netdev/20261001080648.1424172-1-ivecera@redhat.com/

Ivan Vecera (5):
  dpll: zl3073x: do not offer 0 Hz as a supported pin frequency
  dpll: zl3073x: reject output frequencies with too small divisor
  dpll: zl3073x: make embedded sync follow the output carrier frequency
  dpll: zl3073x: reject inexact frequencies for N-divided outputs
  dpll: zl3073x: notify sibling pin when shared output config changes

 drivers/dpll/zl3073x/dpll.c | 237 +++++++++++++++++++++++++++---------
 drivers/dpll/zl3073x/out.h  |  36 ++++++
 drivers/dpll/zl3073x/prop.c |  56 +++++++--
 3 files changed, 264 insertions(+), 65 deletions(-)

-- 
2.56.0

