Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC82207A38;
	Thu, 19 Feb 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771509027; cv=none; b=Brwsgdfv3h8ROlnOqH7LAdxks2OCimTQ6kL6We7hWvS6sW7YW6Tjwr/vKGqL2AElassiQznZi6AIf+T4cpwUSeiIZfuTB4vEBheUl/0oafTQx9OpmhUYo/heGecSKpvINySxDS3o3fxXPEiQJMAZocxAYEPt+9mLnR0hVFuXp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771509027; c=relaxed/simple;
	bh=9XAB1WkKG/tI/e5hODd4LVsH6dlMu4Pako5uxzY7r4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gW6bWqU1MFjhynYwihmcsAYmz5amc36rszBGq6s6gko4j7k43GLB11EXv8zopN51ckrwWk68Bk49PrDGjktjIyUS69Wx74Hv5crmUgL7pyQ/6OxT7YgXpXK4KNRl7+HpxeRlTI6mBfJSMv8JQXLP83LlwTT8FZQ+m10tA8Rtrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGjBa8Ym; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGjBa8Ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8206CC116C6;
	Thu, 19 Feb 2026 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771509026;
	bh=9XAB1WkKG/tI/e5hODd4LVsH6dlMu4Pako5uxzY7r4U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WGjBa8Ym8qaifVZTCVB4ipQG6VYshVgrPAg6P0SxWFtsQ4FloFd5aNBVkldTkuqT5
	 J27IcBn/iiNjJEXafEQdlnCQfFMmrr5EvOCEbBaHBL9pg81zqIp9R8Qc2I1SHqycaG
	 EP7jXnAhYcbiz8UDnUIlcg60Nx8Z+dmDVUmT0WBjSQNY5mkmkn+96HSi0Yt7X3lfba
	 AwvS79HnRxAbMrtc7TUG8SPWGkaP79pIVXe04mtXK4PiuNSY5Z9GXbtik73qWU2DNW
	 V+4kaKEAqzI3JOkyNt5aJtrNz1M4qesiP+iS1TKYSKPqQUpOryubuT65zMekWaGaNL
	 xPOrv5PwbfsdA==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Thu, 19 Feb 2026 14:49:48 +0100
Subject: [PATCH net-next v4 1/3] dt-bindings: sram: qcom,imem: Allow
 modem-tables subnode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-topic-ipa_imem-v4-1-189d91dbee84@oss.qualcomm.com>
References: <20260219-topic-ipa_imem-v4-0-189d91dbee84@oss.qualcomm.com>
In-Reply-To: <20260219-topic-ipa_imem-v4-0-189d91dbee84@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alex Elder <elder@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771509014; l=1479;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=EkZkFoDGwWgx618F15NSBVvffYCMvU4Fbz6lmWps3uA=;
 b=1Ond31A9jnhBLKGItxrg0VnS5s41WId3NgCJ93uN96R4nX38qubAlziO+HrM3RMkV+oFOlYrU
 zemUJEvi+MwDaRgQj4Imnhw2Qn4/eB74pTIpqbfzPtchJlZoDYsPAf6
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The IP Accelerator hardware/firmware owns a sizeable region within the
IMEM, named 'modem-tables', containing various packet processing
configuration data.

It's not actually accessed by the OS, although we have to IOMMU-map it
with the IPA device, so that presumably the firmware can act upon it.

Allow it as a subnode of IMEM.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/sram/qcom,imem.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
index 6a627c57ae2f..c63026904061 100644
--- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
+++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
@@ -67,6 +67,20 @@ properties:
     $ref: /schemas/power/reset/syscon-reboot-mode.yaml#
 
 patternProperties:
+  "^modem-tables@[0-9a-f]+$":
+    type: object
+    description:
+      Region containing packet processing configuration for the IP Accelerator.
+
+    properties:
+      reg:
+        maxItems: 1
+
+    required:
+      - reg
+
+    additionalProperties: false
+
   "^pil-reloc@[0-9a-f]+$":
     $ref: /schemas/remoteproc/qcom,pil-info.yaml#
     description: Peripheral image loader relocation region

-- 
2.53.0

