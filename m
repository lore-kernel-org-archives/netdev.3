Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7260648C3FB;
	Wed, 23 Sep 2026 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159992; cv=none; b=Y8B0ey51vV1eLq8e5G9TrHyIA3Gc2a07xFPgykHhx56GK+YsBIMdgJJIuQJ3Cpe5snYeRZA3AB2C55GmIaT7YZ++t8QM3szdbbtVkGkpspK/oR2RWYWNoiV+s8pjZ5g5KfIqFaYy8xIq1VFRf09hmkJPOlSPyP8QNxL5U7eeP18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159992; c=relaxed/simple;
	bh=nGlcMDxAN6UptcP2dDBMG8pXeco2X5tGzNRFpwCzNJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqFTc2SKltXzTHBhy82kLTQlGQix5x1AsOLSgi0Ykh6mvPCkk2L+x0emOWjSYYIZQEDoQANObPuWHqAe0xu1AzjU1ob94CRQS8q2cid5eyHg3306jH20l1uO5vVkJ0EO70H3psO71Im6DwvqMq9N7lPc5A3MRF/rxU8BdXrX+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QwtpWQp9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0g3xo/9T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QwtpWQp9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0g3xo/9T"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aigmjgbtLs8c723qaOIx+1R2oLC30DNEEzQmo9CtujU=;
	b=QwtpWQp97ILOnV8Sctwf/2VVL4kt7Rqjbu0wqMAokcCjXr1BZoXjOhiOus5Dv1caONnX7y
	Pq5W79zc38eBSQFo8as0XER4izK/Ljtrsb8faDN5GkmmQAbt5iDRP8M+dpOZcF1upsjZ0n
	s1kRDAhgj47P+ZyaYEYKOvAiiu0DeMv/8IGNpLQWeO01tqoTtgUB+Z7BvHyioeT6EwiUyY
	B0vX2LWKJX9Ax8q9JEOoemHEjphYhvxvLXX2SxJONqFacO9X84q1kn5PMzslWSMoxeU9LQ
	by1fX7MIQoKPf0GlxAuXjgKmETTnbT4Skm1JioHe3R6ydVwsVkdibs1JyBvHsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aigmjgbtLs8c723qaOIx+1R2oLC30DNEEzQmo9CtujU=;
	b=0g3xo/9T9TvtTA/6UOZAx/4u7QUGspvRyUe0Lhq/7SKOsdxqSVvLSrIW1lixnd+vuOhKXm
	EYQT6T57E4VuHqDw==
Date: Wed, 23 Sep 2026 12:39:28 +0200
Subject: [PATCH net-next v3 1/8] dt-bindings: vendor-prefixes: Add soce
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-devel-vstrassheim-soce-dsa-ml-v3-1-ddebafcb9ba7@linutronix.de>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Document binding for System-On-Chip Engineering, S.L.

Link: https://soc-e.com/
Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..1c641e1f0ca6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1581,6 +1581,8 @@ patternProperties:
     description: Standard Microsystems Corporation
   "^snps,.*":
     description: Synopsys, Inc.
+  "^soce,.*":
+    description: System-On-Chip Engineering, S.L.
   "^sochip,.*":
     description: Shenzhen SoChip Technology Co., Ltd.
   "^socionext,.*":

-- 
2.39.5

