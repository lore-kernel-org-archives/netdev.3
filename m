Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D6633938B
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541293; cv=none; b=owIvNvTGlG3jQTpOy/PiM/9/HUSPZ00aGax2tgOFdTdjpUgMGKp1EIg+9dcTCAwIv/2scRniqgPaW3HuXJhO+vP6uFC0K90PQiq7m/WoiCUk1F4JcZTLLeR1Fwy0zrqHYZPUcgOclSI9NbZKEf9IvQrBFg/lR7sjz5iWSWrwDv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541293; c=relaxed/simple;
	bh=Jh5wY+u3V7MIGQ3+qn12frIPWOUTacrPWbaM8jJim1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lpp6fha7cik0t0eXmUOXhpMpNE/DetuwpGU9lN/H6mKG1BuZE/8PWZgxWAPpp1y2xtwXANpQqYDghYCQcxonqvZBN2e1CYTohBHYAOSkD+o5JbrMk94d01HcdztSTgdCclckUfHINY4IlFyzjIHVr6lwSMx1HNHlbRj+JoEwQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kc4CrHJU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kc4CrHJU"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49558ce01afso7552375e9.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786541289; x=1787146089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nV9YBKtsEulfVjfXfwXT5cEXH+7jiV0CfcyyBTJ0j6E=;
        b=kc4CrHJU5NNHrrCfQkswJHFmU0CdgqOvdro10qqQQZkqc+lmUvysLVOW+LJVH2Upa7
         MnN4x5Svk77w1qlqB7fANp31Z1Z5zsEqOA3E6LS4MrmSUK+JoAM4lTgVSHcEwUBBcHvy
         CEeynzCARdOc+BoyeIuwfBaXeHAg8JPgTbLVONaKWNvba4wadVogvbnMuj55Aemx8G1p
         CkqwWNWxozD1HbngCoW+UOvNDVyLZ5Q3gxWbIgW7K9ZGS8L2eZ1Tn/huahgT0IjYIWj8
         s/aSN2TzZKb/P9lDiY88yvUC4S8hq3ahAWBqywcbx/UNtH8Y6TdGm5C+bBsRl2HpPARN
         btLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541289; x=1787146089;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nV9YBKtsEulfVjfXfwXT5cEXH+7jiV0CfcyyBTJ0j6E=;
        b=oWhBWwiGVE8xhoIARSPIKmDy8iwtHm9ShIbp0z96qhyrnQ67FFOJ3kY8UCodjbfzBb
         jc4B4hmfcg2NKAeNq0YNgeJLCWdGiE12hriOh3NRuSIdeG4om29UoVlNKHeQflzPxix8
         nJWLAxaLjfMozq1AJXzq7XJbP59QPEL794alsnFIOyo4T3ePVq2wY9XCLsJxlZjTU1x1
         rysGsKHeh9aBJh8gFnJw/WC8EnjgXUUX0dn17fBlYnKNOj/3l2LwCUg3b4P1YyZnut9S
         ZAATvyR/jvxeAu1mJhao6uvDjgTqi1mNnAUPmgenRtuTesgoenrLQWv16D5eDUhF3eq1
         XI4A==
X-Forwarded-Encrypted: i=1; AHgh+RpeWcOGECbBlh8PxolpFAYsMFgk+9nhssI9bJsSGMOYW0ArV7CgkH5dJuAq3VMWrIrC8yiwa/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0QLfEJurRzeUvxteM57r0OfUxKbogaY0yKevCHDeKbQSLA44h
	o1tGWpNc+IxdolDmHBRAHTetBdehULgtSlYqQtbp/7qlwzwBCtUMXHMg
X-Gm-Gg: AR+sD11dl2UoemehFtrOgNi0FIzmwza26CiwUFJqQJGD6P7bLb1aOW3JX55ExTemcY4
	a5LdL42M63dVgi8mC1Re/62Omu1lv/IW9jTQ4rdmANWfemGR43Z0yCmFfBgIX2hb2Mg4Uejt4no
	4GAUIB706hGOeMDnMeO76SZB3EXdB5nXIVLYNM0fPM+dVv6ou8sju/v5WZI4cu/21ZCOfLt/XNq
	jryOFgaP+OBy/ZTXkP5+2xkEiv0E9NwNphoaejUcUqarcNx59EeK/ZYXnGhrzCp+IqOI1udR/sr
	io1WPBlDFNWUwDgifj1lp1tIaNtkSERDXvNaiSlwEjIToxIHxrJuefyI6UecWjd/vZ+HEjnLWw1
	I+D3QjkGcLJ47CrbcWDt0feDrBtrAZci5roxvUimT0oUx5G1zarxvGfS3D+TLduPm6i5WAFKuTE
	5GSUI0MPPQD3AZ58OTe8I0ZwZaERFZgpxH1VLer6CoqBTgTBSykitiydUgNZs/TVzWjz/eM/Dj6
	xB7iFHEwboILMEYa9+p8kbzGNj5+f2kjWbblQqJ
X-Received: by 2002:a05:600d:8494:10b0:499:5282:f8d1 with SMTP id 5b1f17b1804b1-4997c13bf0cmr53031495e9.12.1786541288777;
        Wed, 12 Aug 2026 06:28:08 -0700 (PDT)
Received: from localhost.localdomain.pl ([89.151.31.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997abf917csm87818995e9.13.2026.08.12.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:28:07 -0700 (PDT)
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
Subject: [PATCH V3 1/4 net] net: dsa: b53: deal with Northstar devices using CPU port 5 or 7
Date: Wed, 12 Aug 2026 15:27:52 +0200
Message-ID: <20260812132755.32585-1-zajec5@gmail.com>
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
This fixes a regression so it's a net.git material

V2: Print warning on switch setup instead of on actual EAP mode change
V3: Proper subject prefix & shorter comments (long one comes with 2/2)

 drivers/net/dsa/b53/b53_common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3f5b9592794d..5fd8362d0430 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -332,6 +332,14 @@ static void b53_set_eap_mode(struct b53_device *dev, int port, int mode)
 {
 	u64 eap_conf;
 
+	/*
+	 * On Northstar setting EAP_MODE_SIMPLIFIED with CPU port 5/7 breaks
+	 * standalone ports, see:
+	 * https://lore.kernel.org/netdev/ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com/
+	 */
+	if (is5301x(dev) && !dsa_is_cpu_port(dev->ds, B53_CPU_PORT))
+		return;
+
 	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID)
 		return;
 
@@ -1281,6 +1289,10 @@ static int b53_setup(struct dsa_switch *ds)
 	u16 pvid;
 	int ret;
 
+	/* Discourage users from using port 5 or 7 due to limited features */
+	if (is5301x(dev) && !dsa_is_cpu_port(dev->ds, B53_CPU_PORT))
+		dev_warn(dev->dev, "switch to CPU port 8 to use all switch features\n");
+
 	/* Request bridge PVID untagged when DSA_TAG_PROTO_NONE is set
 	 * which forces the CPU port to be tagged in all VLANs.
 	 */
-- 
2.51.0

