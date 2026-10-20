Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508303;
	b=TaphurJqN746NYslirCSL5gbZDngW6OSlEUs387T85fCfccaZ/W4EZGuCoPFAJWHlqhn
	 s+KRPmKK31MKeLWV7CLu89+EJVsPaHFBHNr3roq3r0lOR9pGaXa3ozr+I988wjv7LvvJ3
	 ZO5Zdm26tkHeKbqW0+2YKxFJQ8HlHitkDf0MqjEEAntjrbN56paggKpQ+0yw9n9MPaOrm
	 8+RuCIG6fzqovFPEt5nyMj9ppH8znZeuYUVvjNoWmNqneWGgm6V3/qrRzfH1kHR7DQNYB
	 hGnPW/M+3n2bl019MeZePs2lqYcPonJSW7gOx2BDBpLjfCCxn24sJsU9+rfkoqG/ANw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508303;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=kdeSiPiSYHtLZiKEroKpbvx3t/mSs9j+e1JMptZPqNk=;
	b=ny0r0G7kvd7ced5gWViY0NYmpoOzeyzOH8nftRO93wVnF5YoSfKZpu/hanjY7U1THCgY
	 HJuPxnuVX3Tv21M9ewcNvNgWAjIhQTnVZRN6QENjnlhsty4mHNbLwxLtatEgHWXpow+XP
	 4L48PWsK1vuWFJJM76Ke4D7oE5/dRPYcHDvID5eIC6dI/Etbths5/6UzH6MhL1oDEFPwx
	 IldYT8H68EGWkpUhausas950TVTeutjMDwev2i9orAZfR6PnAC9luq/pIOSNcdS6b6L3o
	 xlkgXQWWhhGDYYvZeH2uTpV29FhFTJM6vp0jsOZKewjX/sWYWjqzYMxGW52jINMOLHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ZdRrrU+H;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B7606A31E;
	Tue, 20 Oct 2026 14:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 482B7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=ZdRrrU+H
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AE718A1624;
	Tue, 20 Oct 2026 16:58:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792508301; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kdeSiPiSYHtLZiKEroKpbvx3t/mSs9j+e1JMptZPqNk=;
	b=ZdRrrU+Hmj4+G5xCCf3YPzOoNy458sP8nEQztvwiHwEeKp7UI3W0KG6Z/6x0/0+sedyF5l
	j2cKh3sUu9vl8Qz1tmXrbC0HL/vZ2hGyIuY+be4eiGlXxNGHwdTR8mAFUW30wfzCvXdprf
	k4i+eKvtQHrNHHdap5YhbpfeO2BSFKaqJET3iM3Z2Wmrc0fKiMs9bN1t4FvqctotE//pnB
	BwFmQxdftnvIc4RP+EHPWxh1ePPYq81j3qMFT6DssY3Bpx/lFNLXm4XsRP1phLaD4RwlnY
	xPKZU4AEAOD8jhM1OZbw92S5pab1KFUZRDcwdKmkXEroobjc789KyQJLTvY/QQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 20 Oct 2026 16:58:09 +0200
Subject: [PATCH 1/3] dt-bindings: clock: bcm2835: add the BCM2711 GISB
 clock
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-devel-bcm2711-gisb-clk-v1-1-a1728724d0f8@tipi-net.de>
References: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
In-Reply-To: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 Stefan Wahren <wahrenst@gmx.net>, Phil Elwell <phil@raspberrypi.com>, 
 netdev@vger.kernel.org, James Clark <jjc@jclark.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

BCM2711 has a clock generator for the GISB bus that the firmware sets
up at 200 MHz. The GENET MDIO controller runs its MDC off it, so add an
id for it.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 include/dt-bindings/clock/bcm2835.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index b60c03430cf15..3186da543f975 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -60,3 +60,4 @@
 #define BCM2835_CLOCK_DSI1P		50
 
 #define BCM2711_CLOCK_EMMC2		51
+#define BCM2711_CLOCK_GISB		52

-- 
2.53.0

