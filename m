Received: from smtp10.goneo.de (smtp10.goneo.de [85.220.189.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBF84D4889;
	Fri, 16 Oct 2026 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162956; cv=none; b=Wd2q6EDCGjyWoiBW0gW1EHBqdY0iXfJVAdRgxhMZSr0IHywV14WZRwFm+Qm6xrP2T49+isfjDZ2P53loJPE9J+ew+19OXpyb7ZYYR4oXdsPlqZXFBKFneD9FTQZCgpf5COCsQv8oF9fi3aOD2I6ohywNjyfl81J6gsD7ZU6HVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162956; c=relaxed/simple;
	bh=CGIRlgxzJFzN1EeWtM+V5XAuvBXk+iu0V2zztJdV1ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpEFz1AT14n9f4NqqPVKR6FQvE6x9plyJdYLn2es2/J+eCge82l07q7c4AW6YoCC0VKLBa5MfqRhMcaRh3GupMU9l1GAm/NIHG3uq/UTOTfKyjyEw3Y/cyI68lRMKoj9WPJ8oHMq6cE/O76GngzMTy+SgHyQzgMEX7UZItFsCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=M3Hw+mWv; arc=none smtp.client-ip=85.220.189.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="M3Hw+mWv"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp10.goneo.de (Postfix) with ESMTPS id AF487240BB5;
	Fri, 16 Oct 2026 17:02:25 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 6E65D240864;
	Fri, 16 Oct 2026 17:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792162943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Oqoarb6lat0O0SBPNdu4CTzuMwLqVCTIg2Uyx1z80Q=;
	b=M3Hw+mWvwjMz3HQzyt6FJ67Tc6TQwWHpw528zeOr31yuD47BiojDIcI44hfsz3RrYUuVwg
	DVDvVfUYCJUAIiiZigw6mNzPdCjc7AAgqNaN7q3oIdIg3dfd9iUywHlrUnUvnhapBV+kaB
	MQ8ZZfL8jail7ZXyXp6C8y8vZjcBOisqPJqWquk7P65y3X1RSmEPCfexFEj2kRdL4/eZoE
	qvdbO+iRS0tzlWrFYfUM37viT4+SglWCx+ptLkuQxHf/jrsCzv3XvczT/FhIvJIDY57wmN
	DmCmbkkT4xBJ3vmIVLyFZVT5uxL0Gf7GZYAqtP4c5HjPK4a8UpM3/ejXuDmpwQ==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 21A3F240529;
	Fri, 16 Oct 2026 17:02:23 +0200 (CEST)
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
Subject: [PATCH net 2/2] dt-bindings: net: qcom,ipq9574-ppe: Apply PPE constraints to all switch ports
Date: Fri, 16 Oct 2026 17:01:40 +0200
Message-ID: <20261016150140.929729-3-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016150140.929729-1-mail@tk154.de>
References: <20261016150140.929729-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 986422

The generic ethernet-switch schema accepts both ports and ethernet-ports
containers and both port and ethernet-port child nodes. The PPE binding
only applies its port constraints to ethernet-port nodes with addresses
matching [1-6]+ inside ethernet-ports.

As a result, ethernet-port@7 with reg = <7> is accepted without the PPE
port ID limit. The alternative container and child naming forms also
bypass the required PPE clocks and resets.

Match the same container and child node patterns as ethernet-switch.yaml
so that every accepted switch port receives the PPE constraints. Keep
the valid port IDs constrained by reg.

Fixes: 1898fc572118 ("dt-bindings: net: Add PPE for Qualcomm IPQ9574 SoC")
Signed-off-by: Til Kaiser <mail@tk154.de>
---
 Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
index 6d0b21a10732..a5e8aab500ed 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
@@ -173,9 +173,10 @@ properties:
       - interrupts
       - interrupt-names
 
-  ethernet-ports:
+patternProperties:
+  "^(ethernet-)?ports$":
     patternProperties:
-      "^ethernet-port@[1-6]+$":
+      "^(ethernet-)?port@[0-9a-f]+$":
         type: object
         unevaluatedProperties: false
         $ref: ethernet-switch-port.yaml#
-- 
2.56.0

