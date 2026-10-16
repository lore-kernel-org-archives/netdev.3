Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274D419F12D;
	Fri, 16 Oct 2026 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164312; cv=none; b=k747L3zvNDXvxo51/Sw3Zz8bB2Eumk3sP+fHoO5BE4X2GvMpa0qgBNl9iw0lM4EKoEw39GY8XZ8SMfgpcvE+ERyQNlkxMeHoHmbmUh2++Wna5rYepCbwCnr+FXSB12Rieba7QWZSxZ77wv8tuaUGYRDjITvUf1cD8VQ241C+bpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164312; c=relaxed/simple;
	bh=4kDsJmMx54n0K0P+x7wOyCUtQ/tF5RprXGmxktZKLBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqiVxjeLX0Cz4INJQuz9XSJ+dMrKUU7xHYEiPgBmVcxSTkmw8yE+SGIYkxqv+pQngkqCgBEoQNbD2vI7xwAdZGZTw94MwGHDNLp/1b8foz8g4c7ITL9VM1YEGa4/aifx7iiEP/xmRWkIuw+QQiSaIGhvn+yatPqmZ4KMtbD6oEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=FHg7cvru; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="FHg7cvru"
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id A2654240280;
	Fri, 16 Oct 2026 17:25:03 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 686CC240529;
	Fri, 16 Oct 2026 17:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792164301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KcHbNBMa6oCYZ3KfZ4OllD4cQ483mxNEm9QvsR9iVVQ=;
	b=FHg7cvrubjSAPX6K7wv+SCSfPIxU39LFws4rpPitEruogEkIe5Gwd6MHdEdZLUQODqkTu9
	WdkVqJqqt3AqkD0+UgHtpXpszzwA+2x9LpF82XNezZH6mPb1JDJAXI7HVqy8WCaAPNs1qq
	kxqMGX0/w/Et0g4cRmUxww38Icx2srkvVnpCK/uoKda5Z84qmiHJS/F+I7rrO5PIUif+Ca
	cC0fnzVJ0IMec3DHcInwe5TxZlr8T3a8NCW8QEDoLXUk339l3+q9yboK1j29VaFtkBKokx
	RMpHUO0ge1hxEbiP1prjZJEEzD4ybQgR7Snwn6v2kewsJzwt//M+2AyAihhddw==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 62AA6240383;
	Fri, 16 Oct 2026 17:24:58 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: jie.luo@oss.qualcomm.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quic_leiwei@quicinc.com,
	quic_suruchia@quicinc.com,
	quic_pavir@quicinc.com,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: ethernet: qualcomm: ppe: Add IPQ5332 support
Date: Fri, 16 Oct 2026 17:24:46 +0200
Message-ID: <20261016152449.934312-1-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 616f03
X-Rspamd-UID: aa5da5

IPQ5332 uses the same PPE architecture as IPQ9574, but has two front
panel ports, a 200 MHz PPE clock, and different interconnect, buffer
and scheduler settings. This series adds support for it.

Patch 1 moves the IPQ9574 settings into per-SoC match data and a hardware
configuration structure, renames the shared regmap configuration, and
makes the reserved scheduler resource lookup independent of the port
count. Patch 2 adds the IPQ5332 binding with per-SoC interconnect, clock,
EDMA reset, interrupt and port-count constraints. Patch 3 adds the driver
configuration and documents the port and UNIPHY counts.

The multicast admission control and port validation fixes for the shared
PPE code are submitted separately to net. This three-patch series is
based directly on net-next and can be applied independently.

The IPQ5332 values come from the PPE initialization in Qualcomm's
QSDK 14.0.1595.1665, qca-ssdk revision
48484d531927b070b996685f1570aff3bccb9c32 (src/init/ssdk_hppe.c,
src/init/ssdk_appe.c and src/adpt/hppe/adpt_hppe_qm.c).

IPQ5332 requires the GCC IM sleep clock in addition to the four PPE
clocks, two EDMA resets instead of one, and 49 EDMA interrupts instead
of 65. These differences are constrained without changing the existing
IPQ9574 layouts.

Tested on the Ubiquiti UniFi 7 Pro XGS access point, using the EDMA
driver from OpenWrt, which is not yet upstream. The device has a
single Ethernet port, connected to PPE port 1. The second front
panel port and its configuration are untested from my side.

Changes since v1:
- Split the two fixes for existing IPQ9574 support into a net series.
- Apply the IPQ5332 port-count limit to both container and port naming
  forms, using reg to constrain the port IDs.
- Drop the clock-provider provenance paragraph and links from the binding
  commit message and add Krzysztof Kozlowski's Reviewed-by.
- Clarify that the shared parent and rate apply to the NSSCC PPE clocks;
  the GCC sleep clock has a separate parent.

Previous posting:
  https://lore.kernel.org/netdev/20261005152915.101780-1-mail@tk154.de/

Thanks,
Til

Til Kaiser (3):
  net: ethernet: qualcomm: ppe: Select hardware configuration by SoC
  dt-bindings: net: qcom,ipq9574-ppe: Add IPQ5332 support
  net: ethernet: qualcomm: ppe: Add IPQ5332 support

 .../bindings/net/qcom,ipq9574-ppe.yaml        |  92 ++++++++-
 .../ethernet/qualcomm/ppe/ppe.rst             |   9 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c       |  87 ++++++--
 .../net/ethernet/qualcomm/ppe/ppe_config.c    | 185 ++++++++++++++++--
 .../net/ethernet/qualcomm/ppe/ppe_config.h    |  35 +++-
 5 files changed, 362 insertions(+), 46 deletions(-)


base-commit: 6b3e73774815910a39d8ca75b9ad7df963f61d50
-- 
2.56.0

