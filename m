Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340B3EFFC0
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842019; cv=none; b=NnbAuBCaHNN2zRWJPE8H4jn8yaAoJNHg+xaTB6M0g3FOco84w+aJjjyqx1vlDVGA4eFChm28o9zTcpVNHvAx7TIOy7SLjAtvv26FrghhmsWH+XkIUFWb69ems5oJz8MTAWoQdcn/xCzx+o+SQlIlCmOjCTDmmUxfkwhQe45QQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842019; c=relaxed/simple;
	bh=NmuE4ik/IuLUddVTM4vXuZG2evkKg8SJtFSkLuFSM14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tum/t1ZPLzy2J9pLTN6Hg0bwtJb9vSpLSm+9yNAFRynflW79F8d6LoOkoYpVCtSp3HxYhpWbF9VIicmTKPhGcoKUx5rJiqWTD56js2/nj+AdhKNCG7wwsq8mnOY/Ve6I7uDFSpPsBaEdHgTOLhrlB3JCqMpLhkD7mU19aMOTsnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcGsvesg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcGsvesg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790842016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TahzOQjxPFJwixkhmbTJQhTTzp6IYeSPiMfDs8g9Hqk=;
	b=JcGsvesgb+5FJHA4w5uL0uZE6FjvDjaOoGUrQ8x/i49Il3fET3apSfJ1fjYpPDb6x2PwDL
	LABWiS4MQvHZksw6+3QORaVlhtCEqKzbYxvFJ6xpsRSb4NcRZBcPg99srtI/LCdqGjyTIc
	X39bGbrrecClXgGFwb6tHJMM6RbNGXQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-8bZznRMsO2WxjJbhfC-HEQ-1; Thu,
 01 Oct 2026 04:06:55 -0400
X-MC-Unique: 8bZznRMsO2WxjJbhfC-HEQ-1
X-Mimecast-MFC-AGG-ID: 8bZznRMsO2WxjJbhfC-HEQ_1790842013
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E95019560B3;
	Thu,  1 Oct 2026 08:06:53 +0000 (UTC)
Received: from p16v.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1559630001A2;
	Thu,  1 Oct 2026 08:06:49 +0000 (UTC)
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
Subject: [PATCH net 0/2] dpll: zl3073x: fix output pin esync and sibling notifications
Date: Thu,  1 Oct 2026 10:06:46 +0200
Message-ID: <20261001080648.1424172-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This series fixes two issues in the zl3073x output pin handling.

Patch 1 makes the embedded sync (eSync) configuration follow the output
carrier frequency. Changing an output pin's frequency did not update its
eSync period/width, so eSync ran at the wrong rate and, for a 1 Hz
carrier, could get stuck on because esync_get() hides it.

Patch 2 notifies the sibling pin of an output pair when a shared HW
setting (divisor, clock type, eSync period/width, phase compensation) is
changed through one pin, so userspace listening on the sibling pin sees
the change. It also serializes access to the per-DPLL pin list, which the
new sibling lookup walks, against pin registration and teardown.

Ivan Vecera (2):
  dpll: zl3073x: make embedded sync follow the output carrier frequency
  dpll: zl3073x: notify sibling pin when shared output config changes

 drivers/dpll/zl3073x/dpll.c | 192 +++++++++++++++++++++++++-----------
 drivers/dpll/zl3073x/out.h  |  36 +++++++
 2 files changed, 173 insertions(+), 55 deletions(-)

-- 
2.55.0

