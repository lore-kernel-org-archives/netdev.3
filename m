Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B549D4457D3
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610173; cv=none; b=KVHd3a/53pNKU3Oi+MDbSzv88mXMlQ4Uz5vp+jaBxhuN79ujFNF044n6zvs7ANeiHVE2HXmHdt5sP/wJeeDz36+cSq/cDM6SQpqREABy+oqlIE66h04O8GH1CBBUTTRSDvXqvHJRpb24j/+wzHBBtF2Sz5eR+YX66G12Ktr4AEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610173; c=relaxed/simple;
	bh=ToC+qrojIElPVEor8Dd5gyGiOeRrIzNZay5S5+a5o+M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyfknLCRXecfwsSrBMmRJAB1EH85gC66+pteWz89ESnGsWNnKV4Z8CUFsyZ5D4DPkw4PXRYGlDCOZM0BW90a5X1fmHy7Fs9lrmsec2du+U+qRIAoq5t6Aqmg/63GKIv87RFFGhLKL8YYX4ZN8EdwhBWFKnjG7Nmyyj7fuT5btlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0JAxiTN; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0JAxiTN"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso1874345e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786610166; x=1787214966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u3TXL1NZ/aRbhtWQeEIAK86zXlmYDZTCC23cn6TScuc=;
        b=T0JAxiTN/Jag3xnjzYMyTbdVvZbBTNpKfyatM8D3v4L79NOtPRzqN3+P/mzeR7BqyL
         2oDAhFs1pcMxefNE2o/NjvJPU0U9NWgNFdQxV8HWQ9IiAoQwIJEMptkkcGF2TCWC+b9q
         1QqHZZXcAYnacnw2qJkx3SzJJi8QrUaXHmbFwBPpe2LEKYIi9lXHwKQHzbk4XUUneyvI
         uqo/QPSttgmDJKgfskuLeU5rH8/F42FD0OTCbUnIw2xQ352j3VtIQGndaWoHLRwAd6n3
         OxxIyMnG5ZPjhLlYIIl0dk5r4lyej6ztzspYgyYUvnnq3CouYO89YoVR6X55F+9Iba9r
         Um4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786610166; x=1787214966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=u3TXL1NZ/aRbhtWQeEIAK86zXlmYDZTCC23cn6TScuc=;
        b=tTnuULsJLC9d4+2nIgflNkwRTjlMoncZElNaTPzEqfpqJO6IudpkaCkNWhmJVb7fV5
         MPMDhvnnyXtKtygY4GYl3ygvMPxzpOlLUbif7YSo66A3d/3pqkNy5eHoP2UCPWWahIuR
         o9yHEsXYSxgrdbk2ggiFRXsnXd7Ywi71Mz+o9lOPb30Z4PEWaZDH4ElgMKB+Ox8jmWLp
         9sKkMStQGC5FdnXY5N+a9uca8Q/EtFRB4IuQclX4T9dtxhx9OBGxFnAbqXZLmDMP2OrK
         +GaAlxD+ZDWO0qEvwZ46KA4UXuLtxSVX2zzYam40FOZBovmxy43vM/Zh47zRgt9kkvwF
         +rFg==
X-Forwarded-Encrypted: i=1; AHgh+RqDbYBS5Ns8QzxTUtajcY6CPJuDqYDCMGd+C7ANZhjFageNjeIxUCOGzWTCgXBwWdTFMvYCz8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxewMSXy1yaaxjXiYps76F4uWKjvFj1iwDxqK3OnZLOdswde2+1
	Zr4qNOfi+MlEXF+h7nStCj28WkJ9CMpCdNcxg0lBOAXu0jLQ0PwQZUFx
X-Gm-Gg: AR+sD10gdaWjUQU0mZLeWCeC257PwQkVEgSVJdbdO/f5KPcM3rpKl+OoDg4BEB7FqqO
	4oX45lemk5JLOFMXHAgQ8H6BGSkjOMf+Yid55aw+fhvMppVTgVxdXkvyIFfUm8zqidSYjLL9bbA
	FOXrUMn2BDg2Iw+y4yi9Ok7GCsXO3NejzkMIsSFQiMrtVNyJ8ql31NlovDFzgSb3s6ZrozFyFv8
	X/tDNAD4H4bNRVurJuEeGjnkcS4htBT77Nvj8DQZzl7Q61704me0AMLuUwj6vLj7R6bvxBlPOHx
	U4OiwOH23CiOUBSiJjvYK4Fm9iWhl+JZtHHFquHoymbkoDj7AOejRLUJ3Mi7czhLxlcwHq+iWxE
	EHYGOSKHFwGXW2A4Yrh4XqXn9SlFUFy+JxwY19gvsS+RMiMZ8tCV+nzzahrOGDrgudoMtmTKuIm
	M9aArgiAD69CyLKJsbX6G2rbFBwXHZb/oeF9+dfvw9RhftbyBZQN40wOWn8j/e/7tQ5tbfV4VQz
	piI96FavwJ+0KyzW/BGvfFFIIg2/Uh5gwG2kL4cCqqJaSUs
X-Received: by 2002:a05:600c:474a:b0:499:80ce:827b with SMTP id 5b1f17b1804b1-499821bcff7mr43640125e9.4.1786610165898;
        Thu, 13 Aug 2026 01:36:05 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4998216d082sm45804425e9.13.2026.08.13.01.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 01:36:05 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH v14 08/12] MAINTAINERS: add myself as PCS subsystem maintainer
Date: Thu, 13 Aug 2026 10:35:13 +0200
Message-ID: <20260813083536.970196-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813083536.970196-1-ansuelsmth@gmail.com>
References: <20260813083536.970196-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

List all the files of the Ethernet PCS subsystem and add myself as
maintainer.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0e7fae5b92f..04db742696ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9690,6 +9690,15 @@ F:	include/uapi/linux/if_bridge.h
 F:	include/linux/netfilter_bridge/
 F:	net/bridge/
 
+ETHERNET PCS SUBSYSTEM
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/pcs.rst
+F:	drivers/net/pcs/pcs.c
+F:	include/linux/pcs/pcs-provider.h
+F:	include/linux/pcs/pcs.h
+
 ETHERNET PHY LIBRARY
 M:	Andrew Lunn <andrew@lunn.ch>
 M:	Heiner Kallweit <hkallweit1@gmail.com>
-- 
2.53.0

