Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E38C1EA7CC;
	Tue, 27 Jan 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519924; cv=none; b=ahsI6VqaeL6jyVjo6kvuB8VRFHOinn3C5lesyJPkQ2Is1+Wm2WzKvC4TJETp9Hw64VzDjMVfbZvbYrI6NjIF83zBLkBIIg6Sj3JRuqc/XOa0IwLT/Qp9ANwfy5sEvT5G38GzzEfNxiVpjq5kojvKV13b10BM/Nm8gpA6zSD1+ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519924; c=relaxed/simple;
	bh=AZEUjWP6z6TjM2vxB5zbvlCTgV70Eb1pQd9sUdUGo6k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XIl/MRpx6qTLDzL9+Y3GVXglK/4LAr+j2ESjjalmz2m7AnD5FGD6kjYG9tn4AvrJBplqYGGDzjnedFlAMU8IFABkYKFk+KrlATvdHRYvwhBHGO9L8jmM7WbbEHx7DZibOoJYBZJkeYM4R5or2jujVBDE0TrPckokxNFakMOC/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkixs-000000000Sb-0l1m;
	Tue, 27 Jan 2026 13:18:40 +0000
Date: Tue, 27 Jan 2026 13:18:37 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] dt-bindings: net: dsa: lantiq,gswip: reference
 common PHY properties
Message-ID: <d9b6212ad5137feeb58b28e9b0784f1084c813df.1769519758.git.daniel@makrotopia.org>
References: <cover.1769519758.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769519758.git.daniel@makrotopia.org>

Reference the common PHY properties so RX and TX SerDes lane polarity
of the SGMII/1000Base-X/2500Base-X PCS can be configured.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index f601e5f9fa6a..bf199b096dc5 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -105,6 +105,7 @@ patternProperties:
     patternProperties:
       "^(ethernet-)?port@[0-6]$":
         $ref: dsa-port.yaml#
+        $ref: /schemas/phy/phy-common-props.yaml#
         unevaluatedProperties: false
 
         properties:
-- 
2.52.0
