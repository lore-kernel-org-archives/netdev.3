Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7518440A1D;
	Wed, 16 Sep 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547234; cv=none; b=ApP98IJNekpmETsYCz9URos/SV4HicA5Er3FtlcQ3QAeskRxuA7YDefFJy2XkTV+Ufnd5CxXfi1HYGf52KRcL/b/qdkhRPrKQcexvuKApRV8m2RheiC5D3XPwEDgAwNq1HWynxOCh7xPmTsNusCda99cBHnt3V+uw/PPr2MY7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547234; c=relaxed/simple;
	bh=ZS6PExN9zwWyudpayNewrSthXOr7kECZoA1nMBxnMzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdBZGbKYixKd6G8CsmIXPqH4Kp871Zpa179pV5jtagp+WHR/rzAeYwU0XZaAc85OebiFbDzx8cxlhjOay1Me54fIzmYPux40/g2aAQSQvn5ND1BVQNmHruqQVk65qCeUPTmzeFpAR2ndWHJnaLvghWMHwXGBZfEajm5HHikyVWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq9CNX+H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq9CNX+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3F01F000FF;
	Wed, 16 Sep 2026 08:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789547232;
	bh=JPTY1U6jM33Xmvk3c2hEGE36ySFVJHNZhZh3aISIffg=;
	h=From:To:Cc:Subject:Date;
	b=Hq9CNX+HcbxStVHHmSHjk7s4fzxzbKneov1LsEC0FCRMm6OodtAqLONt6DcbPiDxf
	 Y6Ko/tILshClo73kXmJHQVw+SuoklomSlBaMMaVOKjrUdoxD2L9ze+PW7TqCyuWD/J
	 m7Mz+p/FWn7BKf++FRUKPXdASQ9qrwTym+PIts/sInWK/QsgF/no5cmVVQyRIISRqY
	 iI7rmGovzw1y0UWvsT6ASM9EekfzN0wz3zRA980rfQN3tsJq13bW7ffyVe9BA89Sf7
	 hY0/whoe4dmP8xdMS7cuWMrXokZrahtpLNy2ABoCNjhjuYSoQMITpmOtbJ4EowjE4C
	 D6wjvdYqWKw+w==
From: Arnd Bergmann <arnd@kernel.org>
To: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: dsa: motorcomm: fix unused-function warning
Date: Wed, 16 Sep 2026 10:26:54 +0200
Message-ID: <20260916082707.3973287-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about an unused function here because the __maybe_unused
attribute is in the wrong part of the prototype:

drivers/net/dsa/motorcomm/leds.c:352:1: error: 'yt921x_cled_hw_control_get_device' defined but not used [-Werror=unused-function]
  352 | yt921x_cled_hw_control_get_device(struct led_classdev *led_cdev)
      | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Move the __maybe_unused attribute to refer to the function rather
than the returned object.

Fixes: 9af9a8168213 ("net: dsa: motorcomm: Add LED support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/motorcomm/leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/motorcomm/leds.c b/drivers/net/dsa/motorcomm/leds.c
index 87a6b9cf6068..0e8761f37995 100644
--- a/drivers/net/dsa/motorcomm/leds.c
+++ b/drivers/net/dsa/motorcomm/leds.c
@@ -348,7 +348,7 @@ yt921x_cled_blink_set(struct led_classdev *led_cdev, unsigned long *delay_on,
 	return res;
 }
 
-static struct device * __maybe_unused
+static struct device __maybe_unused *
 yt921x_cled_hw_control_get_device(struct led_classdev *led_cdev)
 {
 	struct yt921x_led *led = to_yt921x_led(led_cdev);
-- 
2.53.0

