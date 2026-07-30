Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDD3AAF6D;
	Thu, 30 Jul 2026 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432954; cv=none; b=ZVrX3M7GyVPZDGndUN2dHYaNMMuOPIdzzhajeagjFx4RoYi2lXpDL73oEZoyBE5oH/eIfx1lihGue4OOHliq37dqCKmUy1H+nZZFA5eZ1nmhaeGtITShQhD5STxOT0kwiLtLT+274DUhJgWG9K0uR3lWkjakgAs0MZXDDjFspAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432954; c=relaxed/simple;
	bh=acaD9K41+QiD/mT5oibqK0MWmcPuDMQ2txDDD6kYMtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVENA1H/XnuJO8RQoCKEHH96wdN+PQxgsinla3dCqf/TR324l/V5Ms+D1vZdOKW9U9dp/8fZkDoHMQda9FCSvl1y+t+liG7TAYG9H+ZFOE6GnCq7VFvhui9x57qi+WfSPYweaNDXWFXjvX7Ug2jO1x10fA2OyqaknYbvgYnMopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWFNN7jl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWFNN7jl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9520C2BCB9;
	Thu, 30 Jul 2026 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785432953;
	bh=acaD9K41+QiD/mT5oibqK0MWmcPuDMQ2txDDD6kYMtA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iWFNN7jl+tAiw9mqVuETM+di2rLntSVtDYvRSAxiIS/1IneObTvfNnt0EcRp6m4ns
	 eQvDvQHeQPO+GEXX8EPJgvRgJjv6eUztF5rlyi8bbCQNTRmtRH5Nfv+qbDUI1PSQom
	 An8z52hcWejAf4GY0fma6Qm4EdJniG+rvHUU4HowJS93olNstv7cY993OWtM36VhCY
	 aE0hGOqR1m1lZPnCysAjp63j0YAK39xSIUUEavzizCj4DeFtblNginAozlhE1eUBcn
	 ySFD/g9JfILsTZutxkwNt9ijAgq3/LLS6MZhJUcTPTczLTQUdJ6nf3azblHlxQ2b+z
	 Wdasqf3hq6pbA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B085C5516E;
	Thu, 30 Jul 2026 17:35:53 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Thu, 30 Jul 2026 19:35:35 +0200
Subject: [PATCH v2 1/2] dt-bindings: dpll: zl3073x: ZL30643 is compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-for-upstream-zl30643-v2-1-0ea0bbd03755@free.fr>
References: <20260730-for-upstream-zl30643-v2-0-0ea0bbd03755@free.fr>
In-Reply-To: <20260730-for-upstream-zl30643-v2-0-0ea0bbd03755@free.fr>
To: Ivan Vecera <ivecera@redhat.com>, 
 Prathosh Satish <Prathosh.Satish@microchip.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785432952; l=1773;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=hxP/Qko0hV2ofmO+jMLSUDHekBmOPqUro1uZGRZYS10=;
 b=cSXPD8AtHdb07rV/UrvxgRHHUHmhna8lo8Fxj+WoyhYSh0ALue5YJCWRAwAko26/llCjzej6G
 29/SCzGVPxFDP3J/QWjfERr23+gTvb6GlqWK5D5MD9bIKrwPSUQUhUf
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

The Microchip ZL30643 (chip ID 0x0E3B) is a member of the ZL3064x
line card timing family. It is register compatible with the 3-channel
ZL30733 (chip ID 0x0E95) of the ZL3073x family: both datasheets
describe the same register map and use the same chip-ID encoding.

Describe it with a fallback to microchip,zl30733 rather than a new
standalone compatible.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 .../devicetree/bindings/dpll/microchip,zl30731.yaml   | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
index fa5a8f8e390c..17983e6c3597 100644
--- a/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
+++ b/Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
@@ -14,15 +14,22 @@ description:
   provides up to 5 independent DPLL channels, up to 10 differential or
   single-ended inputs and 10 differential or 20 single-ended outputs.
   These devices support both I2C and SPI interfaces.
+  The ZL3064x line card timing ICs  share the ZL3073x register map
+  and are described with a fallback to the register equivalent ZL3073x
+  part.
 
 properties:
   compatible:
-    enum:
-      - microchip,zl30731
-      - microchip,zl30732
-      - microchip,zl30733
-      - microchip,zl30734
-      - microchip,zl30735
+    oneOf:
+      - enum:
+          - microchip,zl30731
+          - microchip,zl30732
+          - microchip,zl30733
+          - microchip,zl30734
+          - microchip,zl30735
+      - items:
+          - const: microchip,zl30643
+          - const: microchip,zl30733
 
   reg:
     maxItems: 1

-- 
2.43.0


