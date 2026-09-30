Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52EE4D5965
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771001; cv=none; b=oDiKCVDjyUtRJupZtmZ51L6yUkCH0OV7WWA9ai4OGGvnWmHQWXBzvLZHEsx9e/PELv3vCTRTz6LpUifOfg47XSFh3PSIKJ1ZbEiOiCLAFjxXYACzWQ4Jp2JWGOET47C/Oz4CWWogGlAwl7HVGZqKLI7JABN2Jt/hig8JIH17Qjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771001; c=relaxed/simple;
	bh=KzU6pg3SAw7EdiiluA+LfyZ0KB6g8qtQQroQmsrGNVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EARyPAigP2PiJiT/MazgX7Ti8345/dysJ+P3om/ZswjIcwTkn7A3xMJYG86y9jVSxUOThSMnvFWz0PZhmFHl+HnHVCE3wUtEEjP2FsYpMTH63cfczldUY1AOR7wssRrnS+fIy7TqKPLbbXN/jxnRim5IKlAxfE4mqAZwmVMnr8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mKrQm24a; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mKrQm24a"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aaf10bf094so7423588a12.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 05:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790770997; x=1791375797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VaUSX4Um3mqfoQiqXI75sOkcRILE1IPyDF8mtJ1aFuk=;
        b=mKrQm24a0F/nmukkivO2gGaXahLkl1PI2IrxP8r+MkRB6FRSmNqannWWGYARuHRNyX
         /nEMUhqLRw5D/cI864lUCRq9wGiuuA9y4jIsFAF4eNGFgbqGRArzkx8gKIiRMPMCGW9d
         VWBmg0eclYDtjQ2fu4BY/aDJDP80umeRsaBxAGjMXunwgvLQJfJ+2OmvY/JmS4E7K1Y7
         Qo+g/XATrXNTTd6MtqHUo2uY1yspK/TLIbhId0KYAwuQsA6keefRUI2YAXoaFyWskgU9
         wQBN2hjE3o15HCLonNkzIRBWpPO51uE8WJmk4Bup0+t58jGyftHMT1xdpyAD+cEg5AcQ
         nUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770997; x=1791375797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VaUSX4Um3mqfoQiqXI75sOkcRILE1IPyDF8mtJ1aFuk=;
        b=NztrbKXCOTsu08rr7MUHVmdqs8l1XD9PLWa1YOBu3VLCO7aSTOvqGLyfgJX5rAfxUm
         vJDWNkjggcHaDEtqo3nsnEsmnlXKX7o3qEyn383KYEiZCU/NQBQXFfycHIW3IrLKVxLz
         1E8WdT+w3gwcDadA6PpZKRzqlX3eX2IPyG3sz2dKTy/dIiB/0jaZPYwJmsYBtP6nhlgf
         V+TPCCHMcg/XYP2dx8FBzgt/NQgnaLbO0qNV7xTXcHD4obDpvrmo87KNcHEIdmgz9yJT
         uccVvAjpLM0k0pm3X6QWkpAuTvgQwV5rlCxYdSoi841ZJZYt6z+PgNSAzACBJxDUV5nU
         h13A==
X-Forwarded-Encrypted: i=1; AKwUvBy0O6XJGHcxJF0yImo8o6SfZHsXCvz30B5sUNuZizBZYC3aLDuB51yeq73EpaWal5OA2PAVsRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZdv8m1/S9FLNwbTiEA9hQcJlo4uFdL2M2kkrgerJICKzdxbld
	rKOaj7HTqyoqJevAAUkfo0tPImD+YWwiQXKCTXbC/fNLshJrz1nQHbIp9NRoFq8uHXU=
X-Gm-Gg: AYBFou2xTpibzfWN7mLQau4fNq+j/Sbzsilr9yMgFaIa3nB3bCbHZdpd29RIdm2Mbhd
	UU7JmXUX2RG2cmGpXwWWuhHJOJpNJk1FU7W9ehhuoNY2cHN4sGK+WhrzuR43GNXpLsnEakJtjfh
	xH4pBY/mhkf9GhZI4WIK5a2o+Y71trKv+Iia6RYQ2rfM7XieEF8T5yLbOE/f2+kSacCIPVBJffB
	JIySODxj5jjW1PmmJbON4ylFDAxHLFKuzS2q7/2aGQE06TWLuudo6tcE4GFQCLbwdzaEZn5NhAW
	PKTPqVMXG3PYqgq6o+1oRE/oByiNKnOd3tsPUEsAQR2ZaPcSxIESU6SQT6E/zue+GOXHBq0O16j
	RJbjDizTDuUa6wOb4SBn7e4SKZPlJWLkbIARlHtHV0q5/cnQz0ESqtiSxcPjg3aSUPWj+F1iCM5
	19ovMSUgFmiF6yfpQtRcQ5cdSAMPt/ifZFqbcwh89g4KVKDAkAD0d80VbKyMxGeHsjpUjOmlp1a
	iIBDw6I/qItQlpbjb20jC3ehgASTgdwe2E/TNlR/Du1s1FeWJn5oyd8XL212pz8msUDtPjMcJdG
	7krQzBQvYj3jRWPfLP7jAioBHJYU
X-Received: by 2002:a05:6402:24c6:b0:6aa:f630:f846 with SMTP id 4fb4d7f45d1cf-6ae19972f2cmr750838a12.31.1790770996750;
        Wed, 30 Sep 2026 05:23:16 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-187.xnet.hr. [88.207.15.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1568e5a3sm744042a12.20.2026.09.30.05.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:23:16 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hkallweit1@gmail.com,
	lxu@maxlinear.com,
	michael@walle.cc,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 4/5] dt-bindings: net: maxlinear: add MxL86211C lane mapping support
Date: Wed, 30 Sep 2026 14:22:16 +0200
Message-ID: <20260930122305.293686-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930122305.293686-1-robert.marko@sartura.hr>
References: <20260930122305.293686-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the optional lane-to-ASP mapping for the MxL86211C PHY.

The mapping accounts for board-level swaps between its physical TPI
lanes and analog signal processing lanes.

MxL86211C supports per lane mapping.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/net/maxlinear,gpy2xx.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
index 0645e885f1747..b98cb3c3e6d49 100644
--- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
+++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
@@ -22,6 +22,21 @@ allOf:
 
     then:
       properties:
+        maxlinear,lane-asp-map:
+          description: |
+            Mapping of the physical TPI lanes A through D to the PHY's
+            analog signal processing lanes (ASPs). The array index identifies
+            physical lane A, B, C, or D, while its value identifies ASP A, B,
+            C, or D, encoded as 0 through 3. Each ASP must be mapped exactly
+            once. Omit the property to retain the hardware reset mapping.
+          $ref: /schemas/types.yaml#/definitions/uint32-array
+          minItems: 4
+          maxItems: 4
+          uniqueItems: true
+          items:
+            minimum: 0
+            maximum: 3
+
         mdio-regulator:
           type: object
           description: |
@@ -34,6 +49,7 @@ allOf:
 
     else:
       properties:
+        maxlinear,lane-asp-map: false
         mdio-regulator: false
 
 properties:
@@ -78,6 +94,9 @@ examples:
                          "ethernet-phy-ieee802.3-c45";
             reg = <0>;
 
+            /* Swap physical TPI lanes C and D. */
+            maxlinear,lane-asp-map = <0 1 3 2>;
+
             mdio: mdio-regulator {
                 regulator-min-microvolt = <1800000>;
                 regulator-max-microvolt = <1800000>;
-- 
2.55.0

