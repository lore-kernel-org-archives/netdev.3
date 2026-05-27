Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0240B6DE
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898382; cv=none; b=QVy/6IJkZjXK+HEloZFMC5mozX0zSakm/c3VXvpFOmMhFjW+yJmp5Wlj8G9e+2qmcqJu7YQfHj+5IRSmNdBlo6YwrTCSLBEO8HRE8XxJJ/x0eewpAX+vb4VxrVsxM86gh7qMdF6Gde6peyhU8S4IfN3x99hbRM9eUNF/qTrLn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898382; c=relaxed/simple;
	bh=Faf+h5HpbUbcJdMcNbzvBPz3TYX9ZyWA1SqMUmXAOgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hB/o59cHXVIAP5vV5tH3iWZ9IJPt8MklAWhNZdl3f4aggo1H4lcXMtNvJe/ltrUTsH9Xvv7+Mwt2eu6q+h8wp8IMONoGZUsz7InaY8Tt7r+FyYNcTEgK5kIgiNL5jxE7Susa5FFWUCYsr/WstK9yn/ahp0aueJnUw0xBghwDe1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ENA25bA/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENA25bA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779898379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6MW06rfg/0nuz0Vv3jjx1UV686K7pO6JCYpQqrQfhHs=;
	b=ENA25bA/gVUO+N2a1yFnBoTn7leBuk2Up7F5Dx8c+BHm7lNtym1PY/pRxFJirZtXkkECzg
	Kzkbqj85u3ArcdwfFJKqE55QuWtKKrk7XtrrmNFwAg5dC3MG14oNOVncogGrDjounrJoje
	+oTof48/Sz0c6qgcFs5NsLHDGsZwVuE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-0ktYnKqENnOmmhqKHfRuDQ-1; Wed,
 27 May 2026 12:12:54 -0400
X-MC-Unique: 0ktYnKqENnOmmhqKHfRuDQ-1
X-Mimecast-MFC-AGG-ID: 0ktYnKqENnOmmhqKHfRuDQ_1779898367
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4664C1800594;
	Wed, 27 May 2026 16:12:47 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.34.40])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFB8B1686;
	Wed, 27 May 2026 16:12:42 +0000 (UTC)
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
Subject: [PATCH net-next v4 0/4] dpll: add NCO pin type and zl3073x support
Date: Wed, 27 May 2026 18:12:37 +0200
Message-ID: <20260527161241.86655-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add a new DPLL_PIN_TYPE_INT_NCO pin type for virtual pins representing
the NCO mode of a DPLL and implement support for it in the zl3073x driver.

Patch 1 adds the new pin type to the DPLL netlink spec and UAPI header.

Patch 2 replaces the single 2s poll timeout with per-operation timeouts
based on Microchip proprietary source code and own measurement.

Patch 3 adds a per-DPLL serialization mutex taken by all DPLL callbacks
and the periodic worker, establishing a single lock that protects all
per-channel state. The chan_state_update() call is moved under this lock.

Patch 4 adds a virtual NCO input pin to the zl3073x driver that allows
userspace to switch a DPLL channel into NCO mode. The pin reports
connected/active state when the channel is in NCO mode and handles
the hardware-specific details of mode transitions including automatic
df_offset capture and 1PPS phase preservation.

Changes:
v4:
  - New patch 2: per-operation poll timeouts
  - New patch 3: per-DPLL serialization lock
  - See individual patches for detailed changelogs.
v3:
  - fixed SoB position
v2:
  - See individual patches for detailed changelogs.

Ivan Vecera (4):
  dpll: add DPLL_PIN_TYPE_INT_NCO pin type
  dpll: zl3073x: use per-operation poll timeouts
  dpll: zl3073x: add per-DPLL serialization lock
  dpll: zl3073x: add NCO virtual input pin

 Documentation/netlink/specs/dpll.yaml |  13 +
 drivers/dpll/dpll_nl.c                |   2 +-
 drivers/dpll/zl3073x/chan.c           | 102 +++++-
 drivers/dpll/zl3073x/chan.h           |  48 +++
 drivers/dpll/zl3073x/core.c           |  47 ++-
 drivers/dpll/zl3073x/core.h           |  10 +-
 drivers/dpll/zl3073x/dpll.c           | 495 ++++++++++++++++++++++----
 drivers/dpll/zl3073x/dpll.h           |   4 +
 drivers/dpll/zl3073x/regs.h           |   9 +
 include/uapi/linux/dpll.h             |   4 +
 10 files changed, 628 insertions(+), 106 deletions(-)


base-commit: aa064a614efcfa4c300609d1f01134e99a12ad10
-- 
2.53.0

