Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDAF3911BC
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477029; cv=none; b=VCf44Rx5Eq9+LgNKKclKvxhqKPxKOGtfLU2C0MnD1tmWT9wUbknlP9CV6MEnR9QU2jAgFG/f6d6/I7zDtCmgXXN65Hd6RrOjzuMLBXf3QzF26h3QstUR3XebaAZv0sjwia2zuP4Kz0+hFNDIw9n5yuAka8vB/ukn7xIDg2Q66Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477029; c=relaxed/simple;
	bh=I+AMBIPL88pj6SwRQqKUIsROOLJCx61KzFuc9dOZb8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kxtXqW+IDfxpcmPKjUPI8SVJJ1ZwCIfa69smieRwBgUuebOzn6n4cYzg3wGa35IwVpLjirIl0Uqjp7qt1B9w6aS5Q1pilAoL/ksJKy3ZCt+IkyKRj1PZIH6WOyQVb5hgT1SrnmcBVCdiS6gf6xypvmVBkR6MGVLc+VdudzM7UVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1Kmx3sb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1Kmx3sb"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso1251855e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786477026; x=1787081826; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JsV02jiIk99Htrjv4Tooh1nCMqCT9M9OeWRZPiqd+Y=;
        b=e1Kmx3sb6z/M7WKzX+TGntbI5YIGhInWzifVfNfJVj8YXmklMblikrH2YawOph4rcA
         xTylHlUmxlvwK4RuNhsCXFGY3SRGguGQXmnEmUBCjZY3iTiY5Z1J7v+5BgWZz4/uSNQA
         i+RncX6q7n5p+k27nts5pfd8glZp9PlGEJYPUzLu9ziMdr9K1l7LVwkm38kAb/aoYUwb
         VVqJktfE+aPL09moK0lOXHqXZ9abC8XiIFGW0xHKg7k8MLgtGLw27Ou7vFxCcRKSvVAo
         jZbJxGITg66GdQ3lH8vWAltYLwA/szkVsFld5O0/jw7oEkpVoEiZCfQk3dKWxdTQMxiO
         vemA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786477026; x=1787081826;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0JsV02jiIk99Htrjv4Tooh1nCMqCT9M9OeWRZPiqd+Y=;
        b=EGLDQbZmdg+lJaNKlbXaXa57z5rFVG5hFALGyvw+mTTOqcG2RASYjDe5NutbHnBWUC
         XJlkRExdVta6AM4psaRcRrBNj8MqKpP7inAM1UHNBxy56rgBkYVl7iFubsDTDC7xvYCV
         hrtdkKuNYirde1592Gf4Mn/2dYJi/6hYz4AoCOo188vyzw79xykQuFNzopgAB1GoDh6y
         8FL6mHDr9cELHDOXsGU5PBcaJA0OPRuHXTa+9TD2fYxmyfGHXQ0LWAUb7lmkfb26sSMw
         N5tz0mRmAKsO0Hoc3xuryvtnak3Y2KYoxAQ2XmZ7TkxSw2P6wYuNwfl0wDNZgLrAaVpK
         8Kdw==
X-Forwarded-Encrypted: i=1; AHgh+Rqt7Lua2OWilhzNoVf0g0JGRntFAD3nIuJnpIlHIL1SmKfC9TGIe7FIB1AYBsRWIqGlzxz2V/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKik0BrmDLyAuLcfQ9gXPbupXHroBvKQ4I+N82Rk0ffI6A6ytA
	mzlz7/YxYFiTcCfCc8bVPfhZIp1Qbi7+rHpQ3YUrlN/Ez4BSIQ/k49HO
X-Gm-Gg: AR+sD12pDFjx9NLV830Z4uwssdZynAD4MzgwyP8GVCJkHNp/duolXeMclX8gJzL4N2F
	uQHVgnt3FIJ3paAUz+VDU/fyWGr1ZZONkvVJ2EYWu9RXQKqE+fvPRCDdK6U8wjeF2L76TSBKxP6
	yBqYwvXBJr2i32d/ugoqD2O+1O5vMkBHgkFe2bAMtCSTmZTPZ72Ogjeh7Vtej3Y/vIiLwTl+DAR
	ByK0dejczyPoTVRWMXMSv+PorpQoyMejdnXjH6r7RKOoT+t8St84OH34pKd+dbseOTbnbIJ4gRX
	lTHukox7onPx0Lc6wxKWGk3dCl0bQVlsxizC3KHeMi5e01UdSVNplHQUIi6slw6QrGU8HfIjTmh
	kmLTfq7cff6kj6cCWWQH7NM54+FM0erM4uhR198KHeWAHVwFcDVUww19v7M8sHDMytRVlL1OZQX
	Vwz8sieONg28vAg0EuHZZZBuI85vnWzBnyQf1wd+V6uIGdEpt6KKMZ/VILscfl3Yase/Xjmv9dQ
	OWPvnpq1TaFHDWd+ZM8NjvDqd5VDgUpA/mUvNM7
X-Received: by 2002:a05:600c:3589:b0:499:5e9e:1f50 with SMTP id 5b1f17b1804b1-4997842aa62mr87661505e9.4.1786477025980;
        Tue, 11 Aug 2026 12:37:05 -0700 (PDT)
Received: from localhost.localdomain.pl ([89.151.31.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997b15b807sm10130285e9.7.2026.08.11.12.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:37:05 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org,
	Hauke Mehrtens <hauke@hauke-m.de>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Semih Baskan <strst.gs@gmail.com>
Subject: [PATCH V2 net 1/2] b53: deal with Northstar devices using CPU port 5 or 7
Date: Tue, 11 Aug 2026 21:36:57 +0200
Message-ID: <20260811193658.14304-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Northstar devices have 3 CPU ports. Ports 5 and 7 may be used but have
their limitations. Warn user when CPU port 8 isn't used and add EAP
setup workaround to avoid non-functional standalone ports.

Fixes: 4227ea91e265 ("net: dsa: b53: prevent standalone from trying to forward to other ports")
Cc: Semih Baskan <strst.gs@gmail.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Tested-by: Semih Baskan <strst.gs@gmail.com>
---
V2: Print warning on switch setup instead of on actual EAP mode change

I added PATCH 2/2 as requested but I'm not sure what DT maintainers will
say about it. I'd suggest to take this fix if there are not more
objections on net changes so regression can be fixed. I believe we can
take more time to improve Linux dealing with switch to be more optimal.

 drivers/net/dsa/b53/b53_common.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3f5b9592794d..a9bc90b2ffd2 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -332,6 +332,14 @@ static void b53_set_eap_mode(struct b53_device *dev, int port, int mode)
 {
 	u64 eap_conf;
 
+	/*
+	 * Setting EAP_MODE_SIMPLIFIED with port 5/7 used as CPU port breaks
+	 * standalone ports, see:
+	 * https://lore.kernel.org/netdev/ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com/
+	 */
+	if (is5301x(dev) && !dsa_is_cpu_port(dev->ds, B53_CPU_PORT))
+		return;
+
 	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID)
 		return;
 
@@ -1281,6 +1289,18 @@ static int b53_setup(struct dsa_switch *ds)
 	u16 pvid;
 	int ret;
 
+	/*
+	 * Northstar SoCs devices have 3 Ethernet controllers and 3 CPU ports:
+	 * 5 (IMP1), 7, 8 (IMP0). This design was meant for dual IMP setups when
+	 * WAN traffic goes to port 5 and LAN traffic goes to port 8.
+	 *
+	 * While all 3 ports support Broadcom header, ports 5 and 7 have their
+	 * limitations. Features that relay on trapping to CPU (e.g. EAP, STP)
+	 * won't work when using those as CPU ones.
+	 */
+	if (is5301x(dev) && !dsa_is_cpu_port(dev->ds, B53_CPU_PORT))
+		dev_warn(dev->dev, "switch to CPU port 8 to use all switch features\n");
+
 	/* Request bridge PVID untagged when DSA_TAG_PROTO_NONE is set
 	 * which forces the CPU port to be tagged in all VLANs.
 	 */
-- 
2.51.0

