Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445E3E1204;
	Fri, 16 Oct 2026 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162952; cv=none; b=oSe828PqMqblsvPulva+M+fU3AxspV7kTf9rWwBBjSgFwhDrb3Xm8bwCMMiQXqXnz0OJ3PFz2OGRlERkS2hOEEtZ/yPbjxzUotIfYpJIqTGThUbW+eotViVCsXtOksPsFITsKG4ZUgGaX4cwIUf/a8PAzBglIo6bHo5ZQxI+ucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162952; c=relaxed/simple;
	bh=TXmEH/lbQZ5d+KFc77OAq91S0zusSMKP/XcdSKqzRPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyasTkYbGGBxXgZptsdcQ9IwsOmfIuIfETDuLY07EM1c7LHCUtV/hmVkbfdOt8GOcCjAzmJzRR/YMy57wTsF+gYaBup7WAYqLflXhJnF8NDxf0BfjBJjSlQ9bAbk/433Xvmo3ubgRr2fkXWwiGtb0JDzjnq5is+DH4bTySH9zWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=s1wKmWZq; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="s1wKmWZq"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id 18563240280;
	Fri, 16 Oct 2026 17:02:25 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id CFE32240555;
	Fri, 16 Oct 2026 17:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792162942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/F8X4FgLFzjbPuRP8RhC1y1JQLf/dWD9TVWr/+buM8Y=;
	b=s1wKmWZqTFdQ60Ip13QisyIbQ0eFXNnGqshbBbz65I8xJ1azFu6QhW6y029SrLwMvdBdMC
	G3bhXThXRE+okga1qSELwc2AyQ3uyZz2bF7dYndvkg9bxf0AWz+Te0esmiFPd3Gn6LpdKz
	F0dQyjBsu8PeaSOpVChkqKjBeg+99OqZneOv2bay2trXrdto3swCov/xOWFJyy/dGVnkZA
	qMQH/FQ1e60ynYQQzZeG2KR1/C/fflx6Fhi64V2PQN0i4FwsC2FuLL1YSqZ+TIZQRjpBV3
	TiK0np2ev5r3GHPio22IwfIGnI4hbhqYnOAe7PJHNnaARJ3LVzZS/MDYz8U72Q==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id DE6D32407E1;
	Fri, 16 Oct 2026 17:02:16 +0200 (CEST)
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
	devicetree@vger.kernel.org
Subject: [PATCH net 0/2] net: ethernet: qualcomm: ppe: Fix queue access and port validation
Date: Fri, 16 Oct 2026 17:01:38 +0200
Message-ID: <20261016150140.929729-1-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 0f7c70

Patch 1 corrects multicast admission control table accesses. The table
uses indices 0 through 43 for global queues 256 through 299, and each
entry contains three words. The driver currently uses the global queue
ID as the index and accesses five words.

Patch 2 applies the PPE port constraints to every container and port
naming form accepted by the common switch schema. This prevents ports
from bypassing the reg limit and required PPE clocks and resets.

These fixes were split out of the IPQ5332 support series. The feature
patches are submitted separately to net-next.

Previous discussion:
  https://lore.kernel.org/netdev/20261005152915.101780-1-mail@tk154.de/

Thanks,
Til

Til Kaiser (2):
  net: ethernet: qualcomm: ppe: Fix multicast queue admission control
    access
  dt-bindings: net: qcom,ipq9574-ppe: Apply PPE constraints to all
    switch ports

 .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml          | 5 +++--
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c             | 7 +++++--
 2 files changed, 8 insertions(+), 4 deletions(-)


base-commit: 191aa41548b2d2b6af534a6d5cf84a552435c74c
-- 
2.56.0

