Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1947B3915B6;
	Thu, 22 Jan 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099941; cv=none; b=eI/hbagUNCbn486e5Gh7Pfv2NPHKA3Br2Rvl4VDnYHrSG9z9RMHA2XZWHLzF/lzTsMj/gEltBcgQh1RrsZ5UU0fscEq3j4O2JQp4t/VUE/DwZFFtGO6NiKedDeuK6MuGUv96XJS34k+yMtavYDzx5ZNfofwvTBHaqzpNIso+DeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099941; c=relaxed/simple;
	bh=izyHUOuQ28kBl2O6xLzOuS/7H5QGRIgSWTu7/BmY7RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SONulLNqSzGqkyHJCO9UOaGCtW/OsysnI0X2e9qUfKmeCY3go33lcMEdJz4p3glQVZu5JTpofO9dPqJXUHprNkucmNwHeK6gVyRSeMPSawHehGTb4kPom6/yc8e9fdyHmGsogLnxMOXlJnaPwldGAFw4GS9f5xN/1mThdlKjd1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vixho-000000001QQ-28pf;
	Thu, 22 Jan 2026 16:38:48 +0000
Date: Thu, 22 Jan 2026 16:38:45 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Chen Minqiang <ptpt52@gmail.com>, Xinfa Deng <xinfa.deng@gl-inet.com>
Subject: [PATCH net-next v6 1/6] dt-bindings: net: dsa: lantiq,gswip: use
 correct node name
Message-ID: <94f439aa17d7b51fb367877df4fb84c8c07c7ce4.1769099517.git.daniel@makrotopia.org>
References: <cover.1769099517.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769099517.git.daniel@makrotopia.org>

Ethernet PHYs should use nodes named 'ethernet-phy@'.
Rename the Ethernet PHY nodes in the example to comply.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v6: rebase on top of current net-next
v5: no changes
v4: no changes
v3: no changes
v2: new patch

 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 37d64b8a76ac7..027a91d276158 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -338,7 +338,7 @@ examples:
                 #address-cells = <1>;
                 #size-cells = <0>;
 
-                switchphy0: switchphy@0 {
+                switchphy0: ethernet-phy@0 {
                     reg = <0>;
 
                     leds {
@@ -353,7 +353,7 @@ examples:
                     };
                 };
 
-                switchphy1: switchphy@1 {
+                switchphy1: ethernet-phy@1 {
                     reg = <1>;
 
                     leds {
-- 
2.52.0
