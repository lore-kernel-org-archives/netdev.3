Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A849B5B4;
	Mon, 19 Oct 2026 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408067; cv=none; b=HvToMfRrUttlAxjzvgYP6bbA2wXbH5NV5566K0YuBxVxzrURiUSDZDFusscPwTiOuwpMBhZlDPD1ZbB6FRDXOzW3gQSslerZE6NVR6yd9L1v8SfREu76jGM7w6rvRtBpCMJqLkNMjGXUL54+TFxZI6vfqXHYuxxiRXlrUNOJuI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408067; c=relaxed/simple;
	bh=FKVql1RAUwPV6HGkTBRhJdoPXQaq8hy7yBHm62E3qZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olW3trGlJXvvO09yyUsTJEzqObbp/I1H1VPqYk5Mo+Y5yfwYFv4iWbX1omEY9UJlqoGPHbHrrCHM2dUkeOz0jRSCHJVkV4VlJ0h4lRmdRS2i+gX+DVaQzo9wuNSVHbSHPDdmiaXkhWAnrxQyWJGtRSIfnj3f80/v5+c36/jJzr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=KZGbY3Nh; arc=none smtp.client-ip=85.220.129.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="KZGbY3Nh"
Received: from hub2.goneo.de (hub2.goneo.de [IPv6:2001:1640:5::8:53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp6.goneo.de (Postfix) with ESMTPS id 6AA72240ADC;
	Mon, 19 Oct 2026 13:00:20 +0200 (CEST)
Received: from hub2.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPS id 2EE4F24045B;
	Mon, 19 Oct 2026 13:00:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792407618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vPE9psm1Vu8UyFAY1DQ+P/UWO4IHcpKGr5NQXyCSow4=;
	b=KZGbY3Nh7qqtsvBjPN+lghApFT+mQHwUHsR88xJyt5VaD+XZ5JT0pO4+c0YmlcnJoEWEaL
	5bIk+mcO2Efy0FzkNTk+Dzb/IitCzZ/0fGyc9WX6n9PHgdiSv3Sh9G7rfSKclEhtHC6FZA
	8OUk3okFzk5EHBnTUh11DPcAhPXr0g07bqnIAL3GZgADE/t/UFMcyf2peiYFnDHX+DCyKm
	FmBoSrdn+HvOm78+XFox6pFRwWjqy3W2HJMjwH84A9wTMMyFwZQM3iGttNDpgS+wz1sx4s
	MdjUo+yHfAWwPdA8/OxN4Jnyf7ThjpkffetmzfbYxlZOWZZ8LMeZum2G0avdTQ==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub2.goneo.de (Postfix) with ESMTPSA id 3C5E52408ED;
	Mon, 19 Oct 2026 13:00:15 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: jie.luo@oss.qualcomm.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/1] net: ethernet: qualcomm: ppe: Fix multicast queue admission control access
Date: Mon, 19 Oct 2026 12:59:49 +0200
Message-ID: <20261019105950.3977665-1-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 7e1e08
X-Rspamd-UID: 2be89f

Fix multicast admission control accesses to use table-relative queue
indices and the three words belonging to each entry.

Changes since v1:
- Drop the port validation binding patch following review.

Thanks,
Til

Til Kaiser (1):
  net: ethernet: qualcomm: ppe: Fix multicast queue admission control
    access

 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


base-commit: 07bd391eb9572e74f073c49acef327611234f9bb
-- 
2.56.0

