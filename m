Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069C364935
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 22:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782687466; cv=none; b=WgSRnkzhXbaW6WNP3gVsHeuI+gfhzuBBH9BNJ+h556FLRXFSerTSP4wb4qKYpuq7z+r0tIvcbXCWbp/kh5xImtUlDzcvFGlXUP96auXqHGeqlAKy+PcfeMRqSbrzSyglUuFDCGB5FaOFfIUvnFeipfECjVxQvGEk96MS3bx5EDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782687466; c=relaxed/simple;
	bh=iek3bWNhyo2MkBhWQPDy74O4L++68V4N5au0Q8KBNFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ejDWAr6hMJTTcliZOoNOz6RvTf4fhTfe1htcJrMzGMXMak8PXIoH6h5Eci/AgUykSzEuZ0wOMNw4DUTy86nNGBxiSArtq7IIeKwBkFx52MweSESgx4z+v7mupS7eGnYbCS1ZK16Qcu+cE5l2mm0dNQGQ8p1GUUQGA3IGkbFKKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnTi1a5N; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnTi1a5N"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1390f75d8bbso5860083c88.0
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782687465; x=1783292265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=slQ3kwPWYuEq3RtJi8Axo/grMn5ZVq890EChzw+4Qxg=;
        b=SnTi1a5NaWZYWD5bXLuNYzec8lcHT1KUHcgw0pRkOU6OIfdZPbbkVOoomoPYfvLIyl
         5TpPJdr7OYYs8TDMeMXRclNQ1oATxU61PWRg4UUaD7pXs3DgJJpPjYG6QOrUgneo7X+H
         Wf6pHduVOsGtFjmIFDWZiQX4uA4dBN7ibzKJp5Ky92FCjWr5Z3sXnjnYyQ7wxs+nS0eF
         dDDGjcUJxh+0E/MWAxVo81Zxco6yhqfUAcdpXIQxeMV8+nPE3UGQXbMOL/NWwSVkaalE
         T/q38f5Nfc5x5woH379aeweV5d9Am4F2guni4QU9eMrIGpNvFNhREi3IM8juLQCivhMu
         IOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782687465; x=1783292265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slQ3kwPWYuEq3RtJi8Axo/grMn5ZVq890EChzw+4Qxg=;
        b=dqSFlhtErTIDzx7aNtNPIuk9sVnh9NUj8sEflmIJLnDXRXvebIj0lPEnA5dAZ2g6GQ
         QJ52oilI/ld9dxCS+S6/Gu9vfJTmDRxmSxF/1uU+LVofknsjgZKmFVsTz0/9OHHt0Nou
         qs7OX1OTE5m66JphMmxA/n2Dq9J1wNvX1Y7UxeQS+EQTggKwmLJsIUqhl/wBEuMQkbr3
         ewAv+9HRTcZbT/85CFPQBP1oBrxUgGJ4p7NoLkya9PUVhpsdON8B3QcN/5JRdrRAj/t9
         kXyi9Vz4mF6/WF3LLbUBotLBH+bg0xormwIoJGeAZjYQWsJ9dfZP/YESZQQ1FRHKPRhz
         dQPQ==
X-Gm-Message-State: AOJu0YwRHbSUCar8/TQTKzRWk/L0HltjHXO2ScrVkXb8tnrqgSfhSg6M
	7VDj7XumJ7HHkPQB7a9hFJwNjg4pl5KXI/nHVWRarHqzVioTqzZApQOicvWhXA==
X-Gm-Gg: AfdE7cls/FbcIwFI8ezd8tb2YKvsdgHbszTo5I2mrnwOjlYfLuC8HeEaHL2fgXW0/Wu
	5DJcMgulkxVrbk3sRtTrShh/dCpslRKQv2AF7TRojF1CobwXIc6+T5o1Z7gNYplFQ/V0M5xSgpf
	RvJAuC29PE/O5DFch7MwDFLAkOIaBL1XWNRAUcDFtxvJ1aN8qeltfxnd2vSslYU6WsE2cR012vd
	O4WOr//zt7YYwu3q6cE5Jv3n/Numu4ciRXC8HjCKwVCAG5EypBYCi+sI2TS8V8xJumoSQHqsI2a
	kvYuzKfBQ8D1zjbE3MpYxn1qiLbunGqsD/2rEZYR5jV47eyYDYx+XPn7OldOYrbZQJCIi4LOzAi
	DRc9Ru3iT4KE25IfMal2ogGqlhxRnIo2nogHzzEvQmo9aP/W5Hk4JJ5SzFav9ZkQpyyRbsEFREi
	iR5atJXCKQT8okcJFA4JQt7Ppsm2K8gHGIyiJPPGaOzOFFvhriRJaIgJoq0vjWVVgoTQIQ1PR4y
	QUVPLw64Q==
X-Received: by 2002:a05:7022:104:b0:139:fb1a:7717 with SMTP id a92af1059eb24-139fb1a78d7mr2059817c88.47.1782687464642;
        Sun, 28 Jun 2026 15:57:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d8f77602sm35264463c88.8.2026.06.28.15.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 15:57:43 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: qca8k: fall back to ethernet-ports node name for LEDs
Date: Sun, 28 Jun 2026 15:57:42 -0700
Message-ID: <20260628225742.1191229-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device tree binding allows both "ports" and "ethernet-ports" as
the container node name.  Try "ethernet-ports" when "ports" is absent
so that newer DTBs with the preferred name work.

This matches the handling already present in qca8k-8xxx.c

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/dsa/qca/qca8k-leds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/qca/qca8k-leds.c b/drivers/net/dsa/qca/qca8k-leds.c
index ef496e345a4e..0ada28377f46 100644
--- a/drivers/net/dsa/qca/qca8k-leds.c
+++ b/drivers/net/dsa/qca/qca8k-leds.c
@@ -457,6 +457,9 @@ qca8k_setup_led_ctrl(struct qca8k_priv *priv)
 	int ret;
 
 	ports = device_get_named_child_node(priv->dev, "ports");
+	if (!ports)
+		ports = device_get_named_child_node(priv->dev, "ethernet-ports");
+
 	if (!ports) {
 		dev_info(priv->dev, "No ports node specified in device tree!");
 		return 0;
-- 
2.54.0

