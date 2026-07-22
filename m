Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D22E35C693;
	Wed, 22 Jul 2026 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784712847; cv=none; b=Xq9Q6RoCOaYl6ryDFmuBvcbNrWbcyKaMZsGHji4ZbwonAsyfoToYt7mpDnW/qaxWjj/z8sWTUphI9MxnMZtv/gOPbw+7KTmTxCOU6AYV+rjTTNTBChfn1tO2Pya7juBVmwIu+xcfENos7aL8X7t5eeKFvW4MIybpAZRPsK+TGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784712847; c=relaxed/simple;
	bh=8yex3OmgExi5AP098W163N09gd1BaJRWI08kY1ybLgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UlOQ1V6ntE5H1fg3sqMrFOHnUT3vlUxICfO3FyYCzNLENBYmE8qcMUhNZIqsr62rKeovZb/qf2Q5HXkRhCGsCeWqHhoI395e1yr9hEqmVxnETda9wv0+Hc0kXwR+xWO3MRoQQINVx+Gh+7ATzwyfpSTCnQ/WocZBxIsFEZ4CSD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Sd4g5yIa; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Dyje/JG9; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Sd4g5yIa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dyje/JG9"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h4pwh0MDPzMlGn;
	Wed, 22 Jul 2026 11:33:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784712836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yjF2eeIuoyifdySExQynEYsHj7q+MpksR/EZNdLXUgE=;
	b=Sd4g5yIanJKwMokpu5P09wWpAhkdJNwVAwk+5pd8SsqOWUN4z0rq+7FlcnzX/101Nhk3iK
	2Wz6aXXu/4mmuNWrUuOTqBuYx27GMKgPnosufGk0FBXE8uwWtjo8AzCD7NX6F42E/NlhpF
	BI0AkfrjXhvu34csCyFjG05tA39mR5Fb72tQhtHla3Bvy2VEFVgV+jnPx8PxmtHWo4EbcV
	vgHlqXNA0qcp721h7w+qPLzyCgkB70hxMUY9pEJ9tOkEUDPYRZ3jmgcrj+1LjjvPcTSOtt
	SAjSGpeSpmNYIbklCHFAdFfrzeAtiVuK4FO0fF9rhzTqHJ3xrn/iFX+63wAuZA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="Dyje/JG9";
	spf=pass (outgoing_mbo_mout: domain of manuelebnerli@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=manuelebnerli@mailbox.org
From: Manuel Ebner <manuelebnerli@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1784712834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yjF2eeIuoyifdySExQynEYsHj7q+MpksR/EZNdLXUgE=;
	b=Dyje/JG9IfKOUsswtkGbybx76s8WAUW6YEbWhQnCkEoVZEuFwiT0VKgn4tpoi77eYXIPMx
	0RIcx6T6O0ttAp0oC2MaTFrVAbW2lvzsEaVFEd4JXgOT4sxdD/P2dA81xF+kXmu+4lxA8C
	Ierxddszbb3PC5LOA2RRgA750fWU9FoAoGYgw0m1pT28ZxLUXTDpGO09EIJlRlr3VcUrrP
	DDXV4jl+LrRRFEhmZg2trKbBIvJ0i5HUqH42yUAHgWvMfsZptbsWaQUulFw+ZuiqYjWdXZ
	w5fOJ5BqMtl0ImyJ3qt85J4ZTVb/5DnUwG2LXMZHFmrZZPt38wDMsn65CNVvjQ==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: net: microchip: fix entry
Date: Wed, 22 Jul 2026 11:32:59 +0200
Message-ID: <20260722093259.3109588-2-manuelebnerli@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 80909c3737bc88678ba
X-MBO-RS-META: spg37gmjaooyhrybngz7i7sb1cm7cx47
X-Rspamd-Queue-Id: 4h4pwh0MDPzMlGn

Remove needless '  ID)'

Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
---
[v2]
 Remove ')' -> Remove '  ID)' as suggested by Jakub Kicinski

[v1]
 https://lore.kernel.org/all/20260711134204.472841-7-manuelebner@mailbox.org/

I changed to my new address to manuelebner +LI @mailbox.org to
reduce the mail to my main address.
---
 Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
index b9c394009040..2bf6be9807a7 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
@@ -35,7 +35,7 @@ properties:
           - usb424,9906   # SMSC9505A USB Ethernet Device (HAL)
           - usb424,9907   # SMSC9500 USB Ethernet Device (Alternate ID)
           - usb424,9908   # SMSC9500A USB Ethernet Device (Alternate ID)
-          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device  ID)
+          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device
           - usb424,9e00   # SMSC9500A USB Ethernet Device
           - usb424,9e01   # SMSC9505A USB Ethernet Device
           - usb424,9e08   # SMSC LAN89530 USB Ethernet Device
-- 
2.54.0

