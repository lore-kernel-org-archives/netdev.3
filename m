Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF5C4A4EE6;
	Mon,  5 Oct 2026 15:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214574; cv=none; b=P/xM09SaVGpRuHxYylDPqsx4t+1LMGk+76NRSX4qdov444xO0mEK16tndrMlHlPuF4z3O89kJ6aTIhMRAx02XNPs0YTWmKnPInAKXgxmGC2wpFw8PwaI4Pbhd714vkrrpJz1cLvDjva4CZqmn94Jm7/vO6+3EEhsK9zlunY/gyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214574; c=relaxed/simple;
	bh=iLmyUtJy+0o1hB0i3dTEaP2RVB7lyuxJWo+f0BjfThI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecbzlGiERqAgPlKyZAwa20f+a+JCmTYAXKu5qQIl9HkTSUTd6ZNZIhB8mLLI95XXFv8X8kE/escySEoA975vynY3LmcMafwPZr33GRf0acjfm6lSYo1f0jwjdP/TIC8exsbpQuy75oSEY1Yl1D27Ku3efvMVYSeAGGfxgrdqXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=RlKyIJue; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="RlKyIJue"
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id BBFBF2404B5;
	Mon, 05 Oct 2026 17:29:37 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 7FEF52404E7;
	Mon, 05 Oct 2026 17:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1791214175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfUdWIX23FdBmmR8/x6d2ED0x0M75Mu1FYmAPz8R5Gw=;
	b=RlKyIJueN0Umgcq7sl+eI6AWOtQHTTOgEKWmyiAVGvfHTb+LlRqExxiH1th7OW1/tgq6tp
	yYYO87E/0HmBQ2jePBhfXFUrqsaYzVR8uv9PeZrRAjrf/JvhEDq7HqPzYkzpvZD0SNAgS9
	rUzAr1+2xjsEVHKavvG5+8HWSy6I+dhJ2/UsMEh7rqls9omvP4K7n67t0IPnG8og3C0UZJ
	yefzPFr93MYtKNFWJEIeGTJbgH8flvEfxuo7slym7elwmxeslla8TBhBivG1pH3FqwFGrK
	ILZIWFo/AoR8VZbeqnEsOYbxz67/eM8ae5asj/GOqMgxlMUSoK36Zsjl70UQnQ==
Received: from CASE (unknown [195.37.88.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id F1B1A240410;
	Mon, 05 Oct 2026 17:29:32 +0200 (CEST)
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
	linux-doc@vger.kernel.org,
	Til Kaiser <mail@tk154.de>
Subject: [PATCH net-next 2/4] dt-bindings: net: qcom,ipq9574-ppe: Tighten ethernet port node constraints
Date: Mon,  5 Oct 2026 17:29:13 +0200
Message-ID: <20261005152915.101780-3-mail@tk154.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005152915.101780-1-mail@tk154.de>
References: <20261005152915.101780-1-mail@tk154.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-UID: 539376
X-Rspamd-UID: 719efa

The port node pattern "^ethernet-port@[1-6]+$" also matches multi-digit
unit addresses such as ethernet-port@11, which the reg property does not
allow. Drop the stray '+'.

Also restrict the ethernet-ports object to its declared properties.
Without this, nodes outside the port pattern are accepted through the
generic ethernet-switch schema.

Signed-off-by: Til Kaiser <mail@tk154.de>
---
 .../devicetree/bindings/net/qcom,ipq9574-ppe.yaml     | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
index 6d0b21a10732..1a78e2c82b90 100644
--- a/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ipq9574-ppe.yaml
@@ -174,8 +174,17 @@ properties:
       - interrupt-names
 
   ethernet-ports:
+    type: object
+    additionalProperties: false
+
+    properties:
+      '#address-cells':
+        const: 1
+      '#size-cells':
+        const: 0
+
     patternProperties:
-      "^ethernet-port@[1-6]+$":
+      "^ethernet-port@[1-6]$":
         type: object
         unevaluatedProperties: false
         $ref: ethernet-switch-port.yaml#
-- 
2.56.0

