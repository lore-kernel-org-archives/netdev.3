Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9B4A2E0E;
	Wed, 29 Jul 2026 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343071; cv=none; b=nm40faluuLxRbeIT91s2hBCI9eIOGNFhlnzwrCz1DhxJEMqADyP7il/Y9PMLunj9maMDNU46+yQ+w3PcHtv2aDSg2KZIyWSvD72/6iJO1fLvWAQj4Jy+3/ZMYoWbVz2E1zpKZsZoJ+Lbi1wrJOp0bOIJY0T0mRJiocGQ2DYVtbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343071; c=relaxed/simple;
	bh=B3zwFph2l5M3r/gGBodPjEoDhGAHgeuEl4GHxmxpfNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NGJRiH6QfoP4I3BAM44qsQJttNblwTBJDUENfOZi+lPKz0P32T/i6omvk/nYDgqyERQ6M4z1wA1H9FZaCMnuQuyO0vINo3idWEvj+FaIJv3V1sEzB9oHPSc1CcTP+WwfkHU9SAmY0Tbo+E506LLN8LBnAj34MctNJ5+2iDe71qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gCiOY+Ob; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MeohaW5L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gCiOY+Ob";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MeohaW5L"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785343065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TBQqDV43QZ7yFwrzrvovYm71bbTIN8k6liXMuFjFSM=;
	b=gCiOY+Obj6AFNbToTOcGIFTPHNuzN0TRMWiZpoYT6p58OljQRBlGjfZ1TiM4tajiCXBchD
	YM8HC3MKKswyUyXhGkhn8tjKhYaEarXTKiLMzUW155ZzSJyvzo+a9iEOpfF9u6WcPJD91G
	RinubsOXubGgbOPsT154SaMoYhwx5xjMB0AjvDbSAZBKEiAinAPz2azx6Ad9i/xa/MLs6t
	noAt7e6ZUEA0y7toXAt/uHZglP6fsjra5MjWAyuGeE6cI29Bd5WfI4gYNIha8S1Tsyy/Fn
	D/i10necrKDV057NoQPbFNLj/seLdWz+2qcC2yj61bghKFOAxn0mr9TDx6bq8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785343065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TBQqDV43QZ7yFwrzrvovYm71bbTIN8k6liXMuFjFSM=;
	b=MeohaW5LGzIewe9YmZXGx5Ozk2NfEwx8FVLfXZXCzT/t9kTbD7KfC+t0Iplk9LhpPPhZP6
	6wrsdIW0/4hEJ0BA==
Date: Wed, 29 Jul 2026 18:36:54 +0200
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: Add soce
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-devel-vstrassheim-soce-dsa-ml-v1-1-be569dae1b20@linutronix.de>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add the soce vendor prefix for System-On-Chip Engineering, S.L.

This prefix is used by the new SoC-e Ethernet switch DT bindings.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7..cf7eefff4230 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1553,6 +1553,8 @@ patternProperties:
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

