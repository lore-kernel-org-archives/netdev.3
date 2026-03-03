Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84637CD35;
	Tue,  3 Mar 2026 03:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507813; cv=none; b=F8+PEAAI0NGUmgKcVQh+GRKvxq+dtFqlh0guR2EupDfNCvV127aSjKLO+fexaCQidPXOB8stu9+sD+gClOtLH6xUqJhczI9avym8zBPKmbsUhhs8Wm6nmzibjtX07IxMPb952FydhK2zUhzCoNMeuvIZakpxYsGIP08rPsh/nOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507813; c=relaxed/simple;
	bh=8KxxlcjCdpv74ydnAu0Zu8TLOYgappQwn5JQ2x40vcI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F5KQE63Gm2hvn3+RrMBXqD1RgF6jASrkKGgxSsmsETiSSwo376/ZHkL6XW7K4e0JypwPe92KaxSMKcAHQbefluGxS3faxbVc4QF2b8rY+L46qtuVNT85xCWzhgjpmwWirZgrkRvRvZVDn7OP9CxVjMDhUwVKB7qnXtwnVjeVQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vxGFP-000000001ha-0ytI;
	Tue, 03 Mar 2026 03:16:35 +0000
Date: Tue, 3 Mar 2026 03:16:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] dt-bindings: net: dsa: maxlinear,mxl862xx: remove
 port label
Message-ID: <61579de297eb636ec5f1e6c97d453e26abb0625d.1772507210.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The ports in the example device tree should not have a 'label'
property. Labels for all user ports have been removed from an earlier
submission, but this was overlooked in the case of the CPU port.

Remove 'cpu' port label from the example.

Suggested-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml b/Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
index f1d667f7a055d..2f19c19c60f3b 100644
--- a/Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
@@ -110,7 +110,6 @@ examples:
 
                 port@9 {
                     reg = <9>;
-                    label = "cpu";
                     ethernet = <&gmac0>;
                     phy-mode = "usxgmii";
 
-- 
2.53.0
