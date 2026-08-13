Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48793A3E98
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615697; cv=none; b=hqIGhrbh7IU+7q9TSrcTHDLMAouzi4oMumqATL/XhpC7njBvYVuITku46ROUkPtQybY2aGGnx7zKG5xMvM7whxUfHMZ7o7TFwI5uU67fLKDmhnBXQTYFCKe4OGQahRhjxB+6yILPrxnGlyIl/jek6UCrQMszS9ywFHhHryfo4g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615697; c=relaxed/simple;
	bh=yojREoWSS25P76867Jlk+icKV4plToD2TgVLkPPDXc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EdXOmNAl190YzS5Lr+CNRffKgvQvG2nmo5kyJHqNmLqSomULfDxlX8kg131zbJlYqfNor4ADTmlPkJuNyOHklxmTRyfBdqeeuphXaQN6P+LdthpcIRQ23EZqu7L1oBbB1Ce2RaCx8bXoKjm+4Inxjd98MQmIRUDZLOzaJ1kYveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRct8DBZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRct8DBZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ce7d2adef4so25016885ad.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 03:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786615695; x=1787220495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DWeu0BF/Yr8FpY4cMXEg/n8k8/uyCaL0DXpaXJPhx6M=;
        b=NRct8DBZCb/+h5Lqglk1ruGmelKlusxlU1rECiMMhn9hOH1dxU/DR+Gfl8J6rIF0BB
         eXo7N92+6rmq+f5yLHDEpl6mW3wvRWor2k42qhjtayy1wor4bqsELEeLo1Ig0+6hYmWL
         yXonXMYggV0sEUvigfQThPV8sqp4XJ65d4HgwTn/gllCW9Y10CAdhSbwsoVG/8T0IcWK
         jG8rYIGIDAuLTyRWaeQJJPVg2KDo/62A053uYMGgusNKX1u/kxiE7fjWh/+L8ror3q74
         I7xJaE00F/ayFXGOTxBk+UJovtHemLMwQ+fXiwU+UFgrZypIqVxnvUVbqQXPBRSqCktk
         RZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786615695; x=1787220495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DWeu0BF/Yr8FpY4cMXEg/n8k8/uyCaL0DXpaXJPhx6M=;
        b=W5wi+N2MIxmqsoJJkOUANT9YwpidPXJDOvh6pDIhDpZJIFGe7+ERClZHp78pW/KrnC
         WeDTQejqZywKX3Thu+aOi7B3FZTw6ITHLkf8bt7mZKm791AXvTwnOBE0gDQka5Eey98q
         1yTxQALoJtD0FBf5Z5K1QUsEUDNJa2a1SeHiwWARjSYizmPirmpB5oKtLRrkEExfqlGN
         udmLwy7QldDexWI4Ru6TQG6ozlmtV8oa/NL2Waip5tFIXJFGizOVqRz9xa4kzAi4e8xy
         jCmzfygLJ8H/Y1mt/RDtb3ODWQiPeyQ7vRXxa+yuKBtB/k+W+yQzzRQ+orrWih6f2ILB
         Glcg==
X-Forwarded-Encrypted: i=1; AHgh+RrX+Pv8PUZudmKj7yH1PujI6pL/UdJrFqnY4KKjmvc+4c0Jb56IMQjTp2B8FUScD8Q8M+tx4Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcANtbcYwWJCcvIa2Dv1Tlm5cbpHJGQszvRXSYpQdTdHjqpnZ
	ZZe4YzTlWXjjIiI53q7LBELSmdOmCAc3GKw58J1AQGqwJx6YQi2lHvm4
X-Gm-Gg: AR+sD11Jq8IBQaTXpxjHYRYTfR/cgj971DpbQihDI6TvGyYXCymjtaW6OHcoTQal2pK
	bTl9mAHENgTpTLfOXQM7GUByWtluKwIPWNwTpvhfMFzUx8zZliUN9bcm8Wcm3aCW2d7Nn9kwldN
	QxyiHx8AiPo+eX5tlQFU8LcHcYrxzWcHLxDw3YgLZpfqf2FoN4j/fqGuo0Q3wDWVUYuEu6biFlb
	ek9hodEkhHFt6ny9Ic6lcjngjox8xW9oEFd30KkV338WgOyf1h2jdM6qVjMqpYsZNG21sXJyWhO
	AjxIbgInQsgzdR5AVahgNQVERREqdE8DI38MgZuCpJHjXcZCiJszW59Oq6Qx7qTEcz0TILfQOLo
	9hNZr+nUq8DfPGlZH62TG713LP1P/BdV7F/MExnt1VzFS9zHqwrImeZqhhqyx2xdOSqOEjY9NJT
	cq+qvaOpUV+3MOa2a3Qz5RDYiOwIDue3WSrDwrXd9Jv+9oG0HnJAqPVDAkgQdcKQ2bPE9+M1Q=
X-Received: by 2002:a17:90b:1f88:b0:38a:c3f:3b87 with SMTP id 98e67ed59e1d1-3931e26fbeamr6273227a91.12.1786615695066;
        Thu, 13 Aug 2026 03:08:15 -0700 (PDT)
Received: from c79ofce.localdomain ([103.165.85.242])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931dadc0f4sm1012244a91.2.2026.08.13.03.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:08:14 -0700 (PDT)
From: Zhixing Chen <running910@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Zhixing Chen <running910@gmail.com>
Subject: [PATCH net-next] r8169: keep LED device name valid after setup
Date: Thu, 13 Aug 2026 18:07:11 +0800
Message-Id: <20260813100711.14724-1-running910@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtl8168_setup_ldev() and rtl8125_setup_led_ldev() build the LED device
name in a stack buffer and assign it to led_cdev->name.

The LED class device registration path reads led_cdev->name after it has
been assigned, and struct led_classdev stores the name as part of the LED
class device state. Do not keep a pointer to a setup function's stack
buffer there.

Store the name in struct r8169_led_classdev instead, so it remains valid
for the lifetime of the LED class device.

Signed-off-by: Zhixing Chen <running910@gmail.com>
---

I noticed this while reviewing the r8169 driver code. The LED name is
stored in led_cdev->name, but the current buffer lifetime does not match
the LED class device lifetime.

I have not seen a crash from this, but led_cdev->name points to a stack
buffer after setup returns. Storing the name in the per-LED private object
keeps the pointer lifetime aligned with the LED class device.

---
 drivers/net/ethernet/realtek/r8169_leds.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_leds.c b/drivers/net/ethernet/realtek/r8169_leds.c
index 1999e81f0bca..5a2067be3095 100644
--- a/drivers/net/ethernet/realtek/r8169_leds.c
+++ b/drivers/net/ethernet/realtek/r8169_leds.c
@@ -31,6 +31,7 @@ struct r8169_led_classdev {
 	struct led_classdev led;
 	struct net_device *ndev;
 	int index;
+	char name[LED_MAX_NAME_SIZE];
 };
 
 #define lcdev_to_r8169_ldev(lcdev) container_of(lcdev, struct r8169_led_classdev, led)
@@ -131,13 +132,12 @@ static void rtl8168_setup_ldev(struct r8169_led_classdev *ldev,
 {
 	struct rtl8169_private *tp = netdev_priv(ndev);
 	struct led_classdev *led_cdev = &ldev->led;
-	char led_name[LED_MAX_NAME_SIZE];
 
 	ldev->ndev = ndev;
 	ldev->index = index;
 
-	r8169_get_led_name(tp, index, led_name, LED_MAX_NAME_SIZE);
-	led_cdev->name = led_name;
+	r8169_get_led_name(tp, index, ldev->name, sizeof(ldev->name));
+	led_cdev->name = ldev->name;
 	led_cdev->hw_control_trigger = "netdev";
 	led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
 	led_cdev->hw_control_is_supported = rtl8168_led_hw_control_is_supported;
@@ -230,13 +230,12 @@ static void rtl8125_setup_led_ldev(struct r8169_led_classdev *ldev,
 {
 	struct rtl8169_private *tp = netdev_priv(ndev);
 	struct led_classdev *led_cdev = &ldev->led;
-	char led_name[LED_MAX_NAME_SIZE];
 
 	ldev->ndev = ndev;
 	ldev->index = index;
 
-	r8169_get_led_name(tp, index, led_name, LED_MAX_NAME_SIZE);
-	led_cdev->name = led_name;
+	r8169_get_led_name(tp, index, ldev->name, sizeof(ldev->name));
+	led_cdev->name = ldev->name;
 	led_cdev->hw_control_trigger = "netdev";
 	led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
 	led_cdev->hw_control_is_supported = rtl8125_led_hw_control_is_supported;

base-commit: f6057f06ef7afa9893ed33603f7917fa39d237b5
-- 
2.34.1

