Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89A3A6B85;
	Wed, 16 Sep 2026 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789533719; cv=none; b=mYxrz8rFj0SnXqfJed54ioj8CMqWuEtnIrn/6MOFIjkQ5hAPE4cPrJLtLqKP7xIVX2lwjKi8k0c155zUwVcds9GA8+Fhcp7xD7ZXGn9J6LXVtW3l53dgF7Ssi3wd0PX5UdJK1vdTC/o0m8sRfzqaNG+w/ITKEtNgegSxn27/WV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789533719; c=relaxed/simple;
	bh=QQ4Rx0RKXeD+Mgg6OnjaTMpWCTRfWxOZGJ9jQAQSPlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esGPJdjeaEdtEwKmZaQIzQpRosU1iH7rMm1oZ2fO1MDs2AZ1p+5zqdJrYaJaXSsQgKMAzbAyiWYeeH6SzEjjQLl/2wblmEjvM3E4qOviEC7TTNq51jspEo9LiSm2no7EI9BN9mxm6RsXDsWXbIf9Hmqade+iaMK2dr3OGUa1Cxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=pc4HvCwe; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="pc4HvCwe"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id A3BE543BC8;
	Wed, 16 Sep 2026 14:41:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789533707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+VOksxVxl1n9pVJKF/iIgS3rOWKCiVngYTFNCP+Fq4=;
	b=pc4HvCweIVrkeCspTViACRKJL/iO6fNRNRnrpQRkg4Vxx5pOP3Ve1IeAnVK0T7s7OHnBmn
	y654KnCD7ZcygtHjQ1/pYyMJ4wydZFBMW5GqOVNXy5gDXVl1V2ATjiJK5FBilrcrLVpJ+1
	jipxHgsr5G09FqzaCwV5rMgsWfOH5ADrUehiSjLPNPs9nLKhZsa4Uw+G7Rcd24XoctrwOB
	Xu79Dqi1fn+nNwhY0eWIjAELI8k/Kzd6JCfw8dLrBcJvkmPhLDDgKJD4VJ614eEPn25h/a
	tol3mAi0lbeHUdL+olwOpKj+ALyjkyM6MJ9kGxzYYGt0spwzIR+IB1LE2gDzLA==
X-GPT-Reason: legitimate; the email is a technical "patch" notification
	regarding Linux kernel devicetree bindings, which aligns with the
	personal/professional context of the recipient and sender
	(alastair@d-silva.org); the From domain matches the sender's identity;
	the content is highly specific technical documentation (YAML schema
	updates) with no marketing, urgency, or phishing indicators; and
	there are no suspicious links or requests for sensitive information.
From: Alastair D'Silva <alastair@d-silva.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH net-next 3/4] dt-bindings: net: allwinner,sun8i-a83t-emac: Add Allwinner H616 EMAC1 and syscon index
Date: Wed, 16 Sep 2026 14:41:18 +1000
Message-ID: <20260916044119.475666-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916044119.475666-1-alastair@d-silva.org>
References: <20260916044119.475666-1-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Allwinner H616 EMAC1 and internal EMAC compatible strings
("allwinner,sun50i-h616-emac1" and "allwinner,sun50i-h616-internal-emac").
Update the syscon property schema to support an optional register index
offset argument, allowing boards to reference the secondary EMAC clock
register on H616/H618 SoCs.

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---

Notes:
    Tested against Allwinner H616/H618 device trees in Armbian, verifying
    schema validation with dt_binding_check.

 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 323a669fa982..cd1075dab581 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -39,6 +39,8 @@ properties:
               - allwinner,sun50i-a100-emac
               - allwinner,sun50i-h6-emac
               - allwinner,sun50i-h616-emac0
+              - allwinner,sun50i-h616-emac1
+              - allwinner,sun50i-h616-internal-emac
               - allwinner,sun55i-a523-gmac0
           - const: allwinner,sun50i-a64-emac
       - items:
@@ -71,10 +73,16 @@ properties:
     maxItems: 1
 
   syscon:
-    $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - minItems: 1
+        maxItems: 2
+        items:
+          - description: Phandle to the device containing the EMAC or GMAC clock register
+          - description: Register index offset (0 for EMAC0, 1 for EMAC1)
     description:
-      Phandle to the device containing the EMAC or GMAC clock
-      register
+      Phandle to the device containing the EMAC or GMAC clock register,
+      with an optional register index (0 for EMAC0, 1 for EMAC1).
 
 required:
   - compatible
-- 
2.53.0

