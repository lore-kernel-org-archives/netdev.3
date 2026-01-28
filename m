Received: from mail.twlab.de (mail.twlab.de [80.151.39.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5F35FF48
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.151.39.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608093; cv=none; b=HqKIq1nmVoOiyEt8CCxSWukak1bwxz3/1pHpK/sGmM4tCvoXKN4uZffiau+GlwQPRq9yF0Tl7uXfy7cYKm0TCjerJmKWS5T4pJ907T/Aw2b96K0FFOqg/E81DTTIpK7biWDOTN65jnLnUZQUQW0Qfji/Z6NtCcw+67ATnYaVCA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608093; c=relaxed/simple;
	bh=BYKR7TsZQ7XIAVJQYUkOStc9M4JZEoi2K5jYRAS8Ldo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eoz80AIgEaoPSlnTEwiZoQm28JQlWl8B2H0LB+z1U5qxWVoGkDR7ipPUj6kibdSsShf9wTtSMTLYUgTYmtGUp+aq7giiCJ8wrNUs6bLlJpmGA/67DK+gVJHAyYFG8LwVTJ0dF1N22U1A1nz2nNglE62/3jakTOtPY/+H2F4emco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de; spf=pass smtp.mailfrom=twx-software.de; dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b=N2v0CNf1; arc=none smtp.client-ip=80.151.39.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=twx-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=twx-software.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=twx-software.de header.i=@twx-software.de header.b="N2v0CNf1"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B96E5EAAFD;
	Wed, 28 Jan 2026 14:39:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=twx-software.de;
	s=dkim; t=1769607544; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Yod0m6lBYZOmcFC9CfW69zI3HGnAZgjD3UH5xU6etE0=;
	b=N2v0CNf14EafGxC5r2enq84WHDlaCrIME6aFwoqlN25HpxBR/qMD+bSoVS5rn4jSDWdCJ4
	jAPV+yqjdY4WI51Qltp2Rra/UvVVdjqImv9H/a3mBDAoyNc8pxQ6WQJUjyUYSs9fr7vUIl
	u9zaiAcN20P2Bgyu1zHcTEQQCGGf01kA1R4CMZAyI/fzRxPpiS9wnOf0TXnMhrV8lldZ5x
	LJwQJMh6b35WBLKxiJGK6mmHciYm9wvDwhV4g+eWzKGXAR/UR8al5ZJkH4M5Pa9tjQFavg
	a3/MdOpo/bWcxQJ2ZTwu2cLo2a//ZIQtHqTQiAK9rXYrCaT0x6x0VN+gF+YHyg==
From: Heinrich Toews <ht@twx-software.de>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v1 1/3] dt-bindings: net: dsa: microchip: add microchip,single-led-mode flag
Date: Wed, 28 Jan 2026 14:38:31 +0100
Message-ID: <20260128133842.1173406-2-ht@twx-software.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128133842.1173406-1-ht@twx-software.de>
References: <20260128133842.1173406-1-ht@twx-software.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Enable single LED mode globally for all non-CPU ports to indicate
link and activity via a single LED per port.

Signed-off-by: Heinrich Toews <ht@twx-software.de>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 8d4a3a9a33fcc..35abe242a7741 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -65,6 +65,12 @@ properties:
     description:
       Indicates if the PME pin polarity is active-high.
 
+  microchip,single-led-mode:
+    type: boolean
+    description:
+      Enable single LED mode for all non-CPU ports. In this mode, a single LED
+      indicates both link and activity.
+
   microchip,io-drive-strength-microamp:
     description:
       IO Pad Drive Strength
-- 
2.52.0

