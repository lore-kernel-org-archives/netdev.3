Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CCC18EB0
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945690; cv=none; b=Ypcas7kUhj4oPKixfE1Fm837Od7fn26qVIoiANFfGq09Jze6g066GpHyJkIqQMq3y8LLa63p8TvIH8qghW57FyfuYi0iNMfQzlM99AoBxZaipzwMj3KHueTb0CYUGmA6EBpURqPDNI2gMkSv93/nbrKN7QZVUr7oJ2gxSZYIDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945690; c=relaxed/simple;
	bh=S3RYxZBnPIH9300XbdvtlzSo24q7MLKJWIhHt0aLRdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b0RZoCAmfi7UthKslmv6WbjPJ30OZtZerICgQe+X5+B+ATEfRKOKDCbvRXlSI0EEGBbuwkhHkR6dXYiUAcT1xpdGTODwBtv28T8M4ui7rfxQHsVnn5/p2h+4bymb++kR8rLfFbLr/uUNh0bMI6FmDSZk4kOahtgTikFHFiV1aIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Do61sLyk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Do61sLyk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773945688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F2o3jXF7hXDT9f0KG+mgyZzW3HnVvdN8MzMWPn4Lm0Y=;
	b=Do61sLykWIh9SXQZzxhFNYMzP5ol0uMKJ7pGIQujc2hFpomQsfBZju+5lXD3+Kw4NCqoDn
	TQLQ9dFGXeIiKk19K5XOuxr/+s8iKEou2zSm1NrurKsCSEZu6UyGAJu2sZ8kV38qcuA/nM
	yeoB1gpefQI+39gPjHR9uojHmDsZilA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-8PouI4f3OeCjy_dEtdITFA-1; Thu,
 19 Mar 2026 14:41:25 -0400
X-MC-Unique: 8PouI4f3OeCjy_dEtdITFA-1
X-Mimecast-MFC-AGG-ID: 8PouI4f3OeCjy_dEtdITFA_1773945683
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45C89195609F;
	Thu, 19 Mar 2026 18:41:22 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.224.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA1131953944;
	Thu, 19 Mar 2026 18:41:18 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next v4 0/3] netdevsim: support ETS offload
Date: Thu, 19 Mar 2026 19:40:53 +0100
Message-ID: <cover.1773945414.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

 - patch 1 moves netdevsim tc offloads to a dedicated file
 - patch 2 enables ETS offload on netdevsim
 - patch 3 is a tdc test for ets offload on netdevsim

v2: don't use x-macro (Jakub Kicinski)
v3: move function declaration from the bottom of netdevsim.h (Jakub Kicinski)
v4: explicit path for ethtool in tdc_config.py (Victor Nogueira)

Davide Caratti (3):
  netdevsim: move TC offload code to a dedicated file
  netdevsim: support tc-ets offload
  tc-testing: add a test case for ETS offload

 drivers/net/netdevsim/Makefile                |  2 +-
 drivers/net/netdevsim/netdev.c                | 51 ------------
 drivers/net/netdevsim/netdevsim.h             |  3 +
 drivers/net/netdevsim/tc.c                    | 79 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/ets.json       | 23 ++++++
 tools/testing/selftests/tc-testing/tdc.py     |  3 +
 .../selftests/tc-testing/tdc_config.py        |  1 +
 7 files changed, 110 insertions(+), 52 deletions(-)
 create mode 100644 drivers/net/netdevsim/tc.c

-- 
2.52.0

