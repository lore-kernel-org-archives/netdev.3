Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDFB15AADA;
	Mon,  5 Oct 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214573; cv=none; b=q3M7IUeM4gEcW9E6wxUWzgNiE2KpSkWjknzGH5e3eYkof9H+WsGpbfRtK8laUEVIwV076UnDKKCyMpOR+G5vATtrNX6Du+83sLa303xCYLDuQAbPpSpYoZUaHmwZDy65O05jRuqKF6H4pXarX3XZxfUfCzNo3MqcUUi/x4RlbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214573; c=relaxed/simple;
	bh=a42x7DdL/6yIGIy5wAtCXmRS3tsHBHPM4WpDbcIE/U4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LibkUkiLkR7BqM9jkz65hd2GSOnIVDrJ38Gkhl1Kzb3eA21lkW6xU7SVJYk/xw44KCpbsFk65gOA2sLRSlkkvTv4DsXdmdJHQDgqSERD60gYjnJPXiGo9LNd6MOdQ1Amb+fx3bf0S1vQ4nJUtpT65aWi8LAbSx9SJP9HPI+GrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=q1XA5rYn; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="q1XA5rYn"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id 65EA6240238;
	Mon, 05 Oct 2026 17:29:32 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 203A224052C;
	Mon, 05 Oct 2026 17:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1791214170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jJuNZTixbETv98/YnWXCykgebAMZ5OC0EKTrS4Kq8eo=;
	b=q1XA5rYn+uza+SbJGSyZ4F9k4u6yHV7ND9gNG5UyQghhMIawWeDeIglMeZNs5n7TrRtMz8
	1s/QrCLm43sIYezLuDlzmaQIKTlTSxd59sUrAh8iIMK539O4UqJ4bjBmWX3M/dSyqSo7Sn
	Fgb3oNfN7k/Y6ltY9la6poZtoj1IY9tfTH36EYyNk8AQpp892q1T+mpksf0K+5Lhh0v/Ot
	RpI+OsvRgXe2jJomAAes/zcvzZcH6XFgKiaPc/KWq3gst6iXW6g4bdewcciIr7PaJt2tql
	0bZhnEPKLfjHWL5TCdy+W7PShYQ1whXqpd7jWH9TeA7KPoFm/tUZxcXyxZO/4Q==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id D7C82240400;
	Mon, 05 Oct 2026 17:29:26 +0200 (CEST)
From: Til Kaiser <mail@tk154.de>
To: netdev@vger.kernel.org
Cc: Luo Jie <jie.luo@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Lei Wei <quic_leiwei@quicinc.com>,
	Suruchi Agarwal <quic_suruchia@quicinc.com>,
	Pavithra R <quic_pavir@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next 0/4] net: ethernet: qualcomm: ppe: Add IPQ5332 support
Date: Mon,  5 Oct 2026 17:29:11 +0200
Message-ID: <20261005152915.101780-1-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 7ecd1c
X-Rspamd-UID: 4022e5

IPQ5332 uses the same PPE architecture as IPQ9574, but has two front
panel ports, a 200 MHz PPE clock, and different interconnect, buffer
and scheduler settings. This series adds support for it.

Patch 1 moves the IPQ9574 settings into per-SoC match data and a
hardware configuration structure, renames the shared regmap configuration,
and makes the reserved scheduler resource lookup independent of the port
count. Patch 2 tightens the port node constraints in the DT schema.
Patch 3 adds IPQ5332 to the schema with per-SoC interconnect, clock, EDMA
reset and interrupt constraints, while retaining the original binding
filename. Patch 4 adds the IPQ5332 configuration to the driver and adds
its port and UNIPHY counts to the documentation.

The IPQ5332 values come from the PPE initialization in Qualcomm's
downstream QSDK 14.0.1595.1665, qca-ssdk revision
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

Thanks,
Til

Til Kaiser (4):
  net: ethernet: qualcomm: ppe: Select hardware configuration by SoC
  dt-bindings: net: qcom,ipq9574-ppe: Tighten ethernet port node
    constraints
  dt-bindings: net: qcom,ipq9574-ppe: Add IPQ5332 support
  net: ethernet: qualcomm: ppe: Add IPQ5332 support

 .../bindings/net/qcom,ipq9574-ppe.yaml        | 103 +++++++++-
 .../ethernet/qualcomm/ppe/ppe.rst             |   9 +-
 drivers/net/ethernet/qualcomm/ppe/ppe.c       |  81 ++++++--
 .../net/ethernet/qualcomm/ppe/ppe_config.c    | 185 ++++++++++++++++--
 .../net/ethernet/qualcomm/ppe/ppe_config.h    |  35 +++-
 5 files changed, 369 insertions(+), 44 deletions(-)


base-commit: 8b4e7209c842d8cb9516f1f5ef0a88aa2d8831a6
-- 
2.55.0

