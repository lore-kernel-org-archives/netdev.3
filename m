Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6E3C1984
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786268397; cv=none; b=F6+ihP8hrVtLzDNtlK6sneHtNOO2lx8pNUZ0dTgfeYdYtAvclkQ5VUW5hRZiyM93iwCAVKkwIoRLY36nl3EwBXcOSJTvt93xXyqoZibcC7AYnfO2U/0W3EcYfNYkH2U470lWZ0IUROFLfsTkEEgy87jC7C3yKZiGVUMTV60Pdu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786268397; c=relaxed/simple;
	bh=+hq8Mt+TZMIc/XVnihKgYnPHyFLKJFWGVcytjLzc1T0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H0y2CkMOBvOveZWACPiJXrugdIEfkTgZYTncQjeMzFK8amk2UckOgWn7L3imk2mtbIlxp+EALhoqDYrkN42CS1RosmFNAA9E3PghUhTHy5zxOdrD6KPRdF4bgNExemt4EaHHLUjtKASGpLAxFRvbx3PW0mUA1TvzgHhjIcdFLKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6ICa+nB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6ICa+nB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49557167508so7046925e9.1
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 02:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786268390; x=1786873190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GH95RyuCzeJqJxFk7HniRpRPfrdi+pvLj4WxVBmmWDI=;
        b=Z6ICa+nBMp3ew6rYnei+AaS9JLUaYv61oU5n+KTtl1pMJy0kwvmIjIPtnnBpZyYMs0
         9ek6VBx9COk4UjzClFRkcjin8IjHdlbu0EqD7N0ZdM3fYLu33pxkGYik+ZDq9+UeTdHJ
         3XmQkWWJCXIJFuZ4+lL1yVIpsbBbWrT1icTQhsrq5MrD9MJFv/9tS69mF6sxuw+yCOEK
         P+uFC5ndsuGcMlsHX/hX7WmjyOTJWEFAerZ+mn2j7pB0EEZPGLxy6VoLkc/ZOx7noHRs
         mVriATYPaKhcko5RuBUaSZtXWPJ2dKt/UmWp9Brz4N+RZaz6ig2ON/w093sA4XaW2qAM
         r+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786268390; x=1786873190;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GH95RyuCzeJqJxFk7HniRpRPfrdi+pvLj4WxVBmmWDI=;
        b=U/0vIOMtcHIMu+UMhBGQc7issbUPPe0HzsppiPE5g1P0oN5pDNTpJ3eirUUyfmLrzP
         i0kh4TLHResCm6cL/K5NIgxSdG57j91p0jAMDbhemDcpEJqsiFm6zTgRXVrwH6Zmoqlb
         3OloyLuFBCDhuecVfvhLDKTzKcsT1pjbs84p6dNINwlsdGM2ihunDD0u06KlZGtIv0RJ
         xpP77JMEZ+oPTiNEbI+nOU7xCfWI1dKhx628ToBlJs8ZuJRKMi18GOX9O3U1eq84tx9r
         qBWSWjs21cBCBMjxWrDxd3t2D0bVbPQPYVXD5fQAoI0etce/r6+Gp235GA8BFCrIXTZq
         MB2w==
X-Forwarded-Encrypted: i=1; AHgh+RpE8v3b8ADZj9UFamEpajrpqdySYOww+kxIdGQf5UXJ3IZV3vYvHA10Vv9XSVFVLIM7vntQAAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztdcDrPId874QWKKLKHHoqwpDhSFKfThG9KS4R4mDJGoeIYVLi
	dGI4FV4hQS7RMA8NXQ9BF8fbsuqum1IVakGcFvTE9zCr93jI/xLfq50G
X-Gm-Gg: AR+sD10hEEwxWKZe7/07Y0prqsuv9fBtg0DC1KKJbZgYc30vyjnlP9RBsw5mo0MdCTm
	0SdZyRRVjCmJVoxVr9pTyjUvz8qq/zKjpKGWCirfGKX54yuQiFArRnExc3uXY2n49sWgBq7rRWq
	5VlYczEMQsqhNBnwd/tcn2RMVPZ/SGp399M1MalZ82Ge6qVJ04yfJ+j08JYk8TaehhJ1fuZBV32
	RyhFSmj5XtKr0Nw3CMdNWYgyH99YlHBMlltCZ1b2X2szsUJ9VeMgGtyXpCEBIOHjN/RZ6wr52Vb
	GzMsgMPX5vIpQv3mKesSq1fJIeH/50B7Win99vOpZd81bAEyVi6EuYRfqf02cPfTOziaBn9hVwB
	Vo2wVyRt3izbrJVKdD5wOPlQT6fANNcfFjt06VbeznKCAsBIgh5C+t2pAR9f03MJmAAaipX1tTK
	Rz5htugNilCwxLrVU4xCOh2eFrKCGUjkgsSkVsgg5i32dlJJ01YZD1d8XPRdIuSPWfULZ4PuFLt
	ple7Yxny2wje5gbnrK7536WQSxq/g==
X-Received: by 2002:a05:600c:5791:b0:498:11b5:3ff7 with SMTP id 5b1f17b1804b1-4994e7d8a85mr376741435e9.18.1786268389969;
        Sun, 09 Aug 2026 02:39:49 -0700 (PDT)
Received: from localhost.localdomain.pl ([89.151.31.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f0230sm185578325e9.6.2026.08.09.02.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 02:39:49 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	netdev@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Semih Baskan <strst.gs@gmail.com>
Subject: [PATCH net] net: dsa: b53: skip EAP mode setup on Northstar SoCs when using port 5 or 7
Date: Sun,  9 Aug 2026 11:39:34 +0200
Message-ID: <20260809093934.28098-1-zajec5@gmail.com>
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

Northstar devices have 3 CPU ports. This design was meant for dual IMP
setups when WAN traffic goes to port 5 (IMP1) and LAN traffic goes to
port 8 (IMP0). While all 3 ports support Broadcom header some features
are not available for ports 5 and 7. Trying to set EAP mode when using
those ports breaks standalone ports.

Fixes: 4227ea91e265 ("net: dsa: b53: prevent standalone from trying to forward to other ports")
Cc: Semih Baskan <strst.gs@gmail.com>
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
This fixes a regression. A very similar fix was carried by OpenWrt for
about half a year now.

A recent discussion in
[PATCH net 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
allowed understanding the issue a bit better so I decided to send an
upstream PATCH finally.

 drivers/net/dsa/b53/b53_common.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 3f5b9592794d..4b4a9258ecd4 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -332,6 +332,21 @@ static void b53_set_eap_mode(struct b53_device *dev, int port, int mode)
 {
 	u64 eap_conf;
 
+	/*
+	 * Northstar devices (SoCs with BCM53011 / BCM53012) have 3 Ethernet
+	 * controllers connected to 3 switch ports: 5 (IMP1), 7 and 8 (IMP0).
+	 * Each of those ports can be used as CPU one as all support Broadcom
+	 * header but ports 5 and 7 have some limitations.
+	 *
+	 * Setting EAP_MODE_SIMPLIFIED with port 5/7 used as CPU port breaks
+	 * standalone ports, see:
+	 * https://lore.kernel.org/netdev/ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com/
+	 */
+	if (is5301x(dev) && !dsa_is_cpu_port(dev->ds, B53_CPU_PORT)) {
+		dev_warn_once(dev->dev, "skipping EAP setup because of not using CPU port 8\n");
+		return;
+	}
+
 	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID)
 		return;
 
-- 
2.51.0

