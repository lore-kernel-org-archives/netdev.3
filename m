Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506638;
	b=B35CW+noRiGOxNwxYQhTL1WO5Qr0NImugFynsrgtLoMA0S4Qpskua1dWl2rQ8Biyp672
	 96iO93MImAFmud0TlpCPHUFwAygaWEflVnerbh0ydIRfAyD1x0iFeuBIuprJnLRO8bBTn
	 Uxx9ZlP4m1YzABVQWKHs54Fds3ZsGheVfiZbrZdzroYYvRaP8pVQJ70q3OBMOAXacXoyW
	 +U6xBwVYGElHdN0eTIxyU9Nc7eoIMvwXH/74BlYBinsjvCmSPFhEHbCO8+fI1P0NhFS6W
	 ag1e4m5ua/QpQvod6hhwrBsfCh6U6eu9kvk5pjmlWq8LnSqjUg9n+pOndZLnBCTDNkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506638;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=4vlXeE9enSxQAZM/AVNB/6k7VuHl6mXvqO/NCZEaN1w=;
	b=3MewNlcfF6mbzwwZTM/WHR1Sx3wWmPo08QAoOnQ8J4ND5gdnrtLOWkVDZHTmxJs/uyi5
	 2u8pW0ftFSYNql1BsCKuPKo7BO1mhLxkRdNvBSyO3Gnm6GBXciQ9PwlW+8DtYk5oZfZ8P
	 hFtRVveHPIhJURDVJigKmwaqMVahHHFvJY3F+oreg464+e3zSev2AAi8nPcycrbdaDfXd
	 zZQ0vtdzjbFssbWHMmSWKQw0lMxeYMb13Q49Lz+3lYON67l/3Zve/Hb6G7dNCzQn8lKMe
	 mgGlq2prnk8GVCxM09+hEg6gDWn7OWEQRUhghDSXoFQ6Icx1KkEZj26OhY1I8TpNaaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fQFpGwjw;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010460A2634
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 18:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A010460A2634
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=fQFpGwjw
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdd9e925075so61985a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506637; x=1795111437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vlXeE9enSxQAZM/AVNB/6k7VuHl6mXvqO/NCZEaN1w=;
        b=NLLHcMVKhJCD1glyS/hk8/Mx6RcHEpQg+QPAqFTRZ1nZMqRoC89/7vkN+9si57EHjG
         QrxO/S2XeWtFSnLTWM3R5UmPR8aLT/6o3xdyF1IzLJ0VtiToGl0Yx9dDZ1LxnRX/7lUN
         VGGuItlhXgRg8o4118hXZM2TlktZeYk/8PnGj81pDxjXMF1olm/EMWLiytIsfzOboATh
         Ds80JQ7t8hRgIiHBs7MfPOjv5mKEnSpM5Mm4wtfC1VEBBMjYWyM0MVWEDisLkQ6TDX/O
         rpm2Bw/17eF+uS6tai9+M6++aEZGTzv5wKmjo3A+jKYljruoZtMbuvOGT4PWn28w8ASd
         SSZQ==
X-Gm-Message-State: APuU4Z/LeWxcsQM+6/ZDaCExNuh+sKSVEIBqvIMoJg5wgmIfQMl9rbkX
	ultOgbfphf+0O/6+mqRJpzB8U4p/2pyoXtjulNtRw4MksnxnsP208Ko/Cs+wDHpAgqOdQpxYDZZ
	G1QscU8JLRw9I4ZFQmPAwQ+DP+Ecy9JLpnurWBa23jijjlcgXI6mkEFtzRVBy/3Ubat8jrIdXhm
	dNPoF7paly6SV9X3xU5Q+jQp0K9N1YNH0FQpm8s2qGvzYj6xp1gjU+003NcmHt8KEI+7RIKXHwO
	mUYZEj1LAnri/I8
X-Gm-Gg: AYBFou0UxxYsMb1m4JmvUxAr0HCtAyrAiOzw2LFw8XBzBjCvd4UU1pQeCLcO4MJ9WzT
	I+YT/INq8xe+wdJQjP0N5RSk3iQ4ZhoxylH/K5pgFA67Eo8LBW5j1ph5eIbMusmIPJPpnk4+dJg
	y3O2LzSGRKUHVWar6uWvkSqCtSEiQD+v5e7oa3sCQnIUP7GwtozqBnpum7Dju+7lRfFKbkMN83d
	VlvYggiJVdAZ2kwQW0G0UsNxJqSP9enfSo9tw1coZX8/iHu3vdI0DUCxhrjI/Gc2fucICxT6bpb
	BygK3v998lRReUiqT4EZP1qALdV+puKoy0/KYUonDdSTNModjfujm4B+kJEfx02eZiNgrlXMcQ8
	rezkpottKHwPPoLB9f0s3WrNDxOa/jYUA9rZL0Vn/oa0ftgegTk31NvCDpmmLYgcyqENaNKsQu5
	IZ4DhAl1+mqofcCRMk27l0nf5u7sC4xV1+9qQqMK68
X-Received: by 2002:a17:90b:33c6:b0:3b0:9e2c:9b61 with SMTP id 98e67ed59e1d1-3b182ee21e0mr6202439a91.35.1794506636648;
        Thu, 12 Nov 2026 10:03:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197c1a3e7sm3066493a91.2.2026.11.12.10.03.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 10:03:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdb86c39250so58430a12.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794506635; x=1795111435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4vlXeE9enSxQAZM/AVNB/6k7VuHl6mXvqO/NCZEaN1w=;
        b=fQFpGwjwMbR3NB0o6to9uADuPFS7ufipGTgnVsMMohE3zzImvVR0+vV21hmppLVX3f
         lSJ83JELBKocUBbnCRb4QaOwnsbFo0cX03gp8q2CDpuFjtk6+aQGGzur8jvFYsYaqEUR
         yPLJCt9vE5vEUqYPSx2XaUIlJUvoAMBXbmerg=
X-Received: by 2002:a05:6a21:9216:b0:3e1:9071:acdd with SMTP id adf61e73a8af0-3f2ff0dc5cfmr6424033637.35.1794506634906;
        Thu, 12 Nov 2026 10:03:54 -0800 (PST)
X-Received: by 2002:a05:6a21:9216:b0:3e1:9071:acdd with SMTP id adf61e73a8af0-3f2ff0dc5cfmr6423986637.35.1794506634267;
        Thu, 12 Nov 2026 10:03:54 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc18abc06sm95004a12.22.2026.11.12.10.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 10:03:53 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v5 5/8] net: dsa: b53: use the correct override register 2 Gbps bit
Date: Thu, 12 Nov 2026 10:01:59 -0800
Message-ID: <20261112180202.324504-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112180202.324504-1-florian.fainelli@broadcom.com>
References: <20261112180202.324504-1-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The IMP and per-port GMII override registers swap the override-enable and 2
Gbps speed bits. Using the IMP speed bit on a GMII port clears its override
enable and leaves any previous 2 Gbps selection intact. Select the speed
bit alongside the register and enable bit so lower speeds clear the correct
bit and 2 Gbps sets it.

Fixes: b6a8a5477fe9 ("net: dsa: b53: fix resetting speed and pause on forced link")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 715a0969eacb..6b4a94a97d66 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1427,17 +1427,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 				  int speed, int duplex,
 				  bool tx_pause, bool rx_pause)
 {
-	u8 reg, val, off;
+	u8 reg, val, off, speed2000;
 
 	/* Override the port settings */
 	if (port == dev->imp_port) {
 		off = B53_PORT_OVERRIDE_CTRL;
 		val = PORT_OVERRIDE_EN;
+		speed2000 = PORT_OVERRIDE_SPEED_2000M;
 	} else if (is5325(dev)) {
 		return;
 	} else {
 		off = B53_GMII_PORT_OVERRIDE_CTRL(port);
 		val = GMII_PO_EN;
+		speed2000 = GMII_PO_SPEED_2000M;
 	}
 
 	b53_read8(dev, B53_CTRL_PAGE, off, &reg);
@@ -1449,11 +1451,12 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 
 	reg &= ~(0x3 << GMII_PO_SPEED_S);
 	if (is5301x(dev) || is58xx(dev))
-		reg &= ~PORT_OVERRIDE_SPEED_2000M;
+		reg &= ~speed2000;
 
 	switch (speed) {
 	case 2000:
-		reg |= PORT_OVERRIDE_SPEED_2000M;
+		if (is5301x(dev) || is58xx(dev))
+			reg |= speed2000;
 		fallthrough;
 	case SPEED_1000:
 		reg |= PORT_OVERRIDE_SPEED_1000M;
-- 
2.53.0

