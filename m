Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6474FECFA;
	Thu,  3 Sep 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459111; cv=none; b=K7ASAlgQOIdW44cg8u1lJlgH5NeQrDmpFRNlIYTV2EpY5SmR/pH9ez7YTdYpOXH4ajMWTsNrf6CtT68w9MklJYYYRX+BnFvwBDab5I2tGGBqjV0i15qZRUVvtRPju8p9gtMXP2QDgGFxGx6hQ5ML5NKSEafRH7DwNbk8ZjEvISM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459111; c=relaxed/simple;
	bh=Wr2OqW69o8MZw2XFVDxk9ByxGMJbThPaMC67F1FtZ4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0NZj+75H5s1vIEu3OOx6IPvVbnewEdixHaO0gQfSDic2z5M8ZiLIH9qq1QPoVyEQOGg4S7bGNz2+2ZeJXQ/Hm/NYLuYlsUg9uvkXUFYl9RXZnc/jOqNPvFTmY4RsLO0z86tnbPkiuy1usYAA0q8SzXXvBbR7Ygrs3YqT7KFiao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a2N/o9Sr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hzPCkzqK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a2N/o9Sr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hzPCkzqK"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788459104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZU1ty+E3jZObtE5Zgsy3Zsxcterr06GphGCs3MuS+n4=;
	b=a2N/o9Sr/k9I9VQb5I9rPp/mdgoGoJmjJdheIyOQaYC68Z3+X+UaFEgrPJKqsAfHNdygqI
	WpcKObQG62tStYHiMiUxAIv34sDMBYAYXasIYn07SURmsXqXHzOdE3GV3by4EAWV/wKVv0
	/dMDpG6GTBVOuFYm9/xRzizok72Ysnfmcwzp0wiLMs0XOvHTx+dleGEKxAF4kdRsyD1PnQ
	JjtoZP5YGyLv5CI64BS/0tpYMItceCFKp7OO9JrXGa6lAYzEHz87eAbwBo2+FETyY8fDbB
	AAqWpE22mENMrW/WKzyyDfWtflr5ROmClbsjP6UiOJkOFyJVxOISIsQEbSvpOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788459104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZU1ty+E3jZObtE5Zgsy3Zsxcterr06GphGCs3MuS+n4=;
	b=hzPCkzqK7RA99gRWoPYcnAtTIHNKfcD0jaeYpZndhHjfFdQTQ8bUo39w4kMim11GZDHIvm
	uYLF1lVIynUC0FAA==
Date: Thu, 03 Sep 2026 20:10:58 +0200
Subject: [PATCH net-next v2 1/4] dt-bindings: vendor-prefixes: Add soce
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-devel-vstrassheim-soce-dsa-ml-v2-1-fb0587cb466b@linutronix.de>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Document binding for System-On-Chip Engineering, S.L.

Link: https://soc-e.com/
Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
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

