Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793394850;
	b=upLTklBteMWtXqR+/4Zr5nlOhknQrsCIj/cYSdtmOkxnvFVOl0FL3WAwI5TmskEzdNFN
	 T93FJZWBJ942lD/TxJwFjRUpOqV0HalyYlavsPdBlcxUzae9MizzU0R0WdrNAwm3S8z1d
	 VzSkNtdp4LNaZbG0eIJ7cy/ie4DlZ6M7bLemutYATK8u/lXc9y0IvaR6Nna1PJC3/qTxG
	 JVwCfGGbjMgJMANMvDCREGDDAWWP5rEcxGVPvFWyA8P/mceWW8OmKDj3BUqqS2DJlcAkg
	 8gGLzc8uQoiJvuocf8WPwfQN3NG0JdhgsDlyKEPP1fa07bz1bGIGAbnvy6SO2OUB3Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793394850;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=zKHpOqN7el/iBi24fQQZSjZZJgwztQp4IyGIqG/dArc=;
	b=07wzv/GGD6z3hHrbJ73KP32/zTYuO+atSJIDvzUQo6zbBKiHrqB6WvTzfl1vl59rqWnO
	 xsx8+qM6/mPb5/yhrnPsEcz4expS2WWW+oAfnJ0lcQxjzckCQJ2MFIoENcFNbiA4hzTN8
	 KIfLC/JbWhjFNkTDzx5jlNIVhRt+kXd7bjubluGJl4IhrmAoY67EZmnImOrzoVD8kh6hy
	 fRT0Ai5T0KIwTAsnl9L0W6cVhUT6AzS8+ohNbK9lJWlLTc2XaPAmwwH+IMNX4EGP1pTdn
	 ErAS9uaMmNsys/HLpu/LSyYrS2GH66w4HwZlG+/lWT5TjEabxKFDQpPBtdhqTRriuqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DR4mV8qJ;
	arc=none smtp.remote-ip=209.85.219.98
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C277E60A260D
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C277E60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DR4mV8qJ
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-91c7a0c1617so17697046d6.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793394849; x=1793999649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zKHpOqN7el/iBi24fQQZSjZZJgwztQp4IyGIqG/dArc=;
        b=DfTk5/s+JdoP783m4fxaSnCVWCXme9i0emYkNuGscdob3E1+FpGw6MYc0r15CQcZoD
         obbClXGudI8xTlA3fGaJpEfbu7F/W3WdEqOtbYd+zwUmrPcZuw0o1rI+ezJlo/wW3Nqm
         JtF/ujBwT2SgLPV0wBjT5PTM3Mzu1XzUF+8gQcE99s4enaj9xLEDo32reWv9HC+mhynp
         k/jOA7yTEQll2R2VTxuhJROqCF1AaM0KTO9eJAdWOVm9kdj9t9gr+n2hgC7CC2x/dpK8
         JbMEOELjzxVDy21F1KJkhqgyWpoK4LuzAm0hnanfpsljZpqpo15HirWO3fFZpVdaQxTY
         3Z/Q==
X-Forwarded-Encrypted: i=1; AKwUvBzdAvgMPrH+hu7K2nBxY5c4pXOjpMbcrkrGaLEr9ix172LDIsRvAG5+557pV8DlI124Ohbk3bc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZtBmq9Uoj7gSsGb3Us6dXWGlzy3AJDWAH6Px8J63RZJLMnhIu
	OqHCxV3sbEH3ufdIIDZHJHRTVtsfU1fotBtAPP0jV6pXkjcd6MRElxZ3euE7B6DpXbXAOXG2Lwl
	mHaDxJmcyQJVKS355+z8imCA5uYFcypOPrSeoKvH5TFArce+fR5466z0fy+XBU57qNiWtRTdTvN
	C5biHO3T4w7ApzP01+zqmQbwODu6WYS0fN86BasyewGQqcUaqn57BzEvORzCO68nWImGTeUpn/X
	Q31Ey+UCqwT4/Fz78A=
X-Gm-Gg: AYBFou0ofPzajH/4bGr+7mQaozPK9/3CUbNt3P7f9FnKFxGnP9j591jlC9NxhBYWqrJ
	x/GGU20paJFlWZ67alB2N25BYMkcKaN4nSUNUcIunTiX/DhKb2KftiGr+kRVsz7jl56GENEU1aO
	QeMnTpGgqH2D+ug2WCq2/XovwI425gRMZTzBV3CRi47VzxX9wYJ5uVDKuu4xrJ4yi6TNLIIetWa
	AZemvIsCfq95bty9TTIFuKkcMvoQ43n5gaw9ErbKRmD92DAPjZLnI7tuj5RwyjfqI7eL+QunDfG
	gKeYEN2MDVEv4ebEiWr3s8tMjKP8nN7kIbVQHaD+lNraqHf7g99CwCgOHk1R1Y44/my75a+B0y4
	RREUzojzLXx+lfxmlt/sNVr/CADCA3L2MZ6MzUfmCen6TKpTqlH2dwA5LaEjfxP0c7o9GMwm1cv
	FQOrHxbVLYp4JPl+EiFFRllB/WVtk8o59+S21EMlsE
X-Received: by 2002:a05:6214:21ed:b0:91b:5d39:e129 with SMTP id 6a1803df08f44-91ca4b7d476mr60866966d6.50.1793394848526;
        Fri, 30 Oct 2026 14:14:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91ca7f3c492sm398706d6.24.2026.10.30.14.14.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 14:14:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so2632075eec.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793394847; x=1793999647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zKHpOqN7el/iBi24fQQZSjZZJgwztQp4IyGIqG/dArc=;
        b=DR4mV8qJMSeJDZ3qq9Ms4AdH8Q+L1avjwBLElIDMO1gwRjWj63T6jBd9Gzuzph5aTw
         p37//7vumb8T6Q3XyTTBYCkiliQwVdh9Uo0hH9708gy5MpEIKq42ldM7/pzPQDNYh4Pq
         KylEGz5WRerDSmAvgffZp+ZSXN9dF4YOvHNzA=
X-Forwarded-Encrypted: i=1; AKwUvBwu1+X2/+di26uZIzleUcqH37UV4JeRcVHnPuBMhVdstel6nzeKV+yeeg8yG2wnb1QgX24hKtI=@vger.kernel.org
X-Received: by 2002:a05:7300:7f95:b0:35d:eafd:5737 with SMTP id 5a478bee46e88-36a423bec77mr7348007eec.22.1793394846852;
        Fri, 30 Oct 2026 14:14:06 -0700 (PDT)
X-Received: by 2002:a05:7300:7f95:b0:35d:eafd:5737 with SMTP id 5a478bee46e88-36a423bec77mr7347949eec.22.1793394846227;
        Fri, 30 Oct 2026 14:14:06 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42669128sm10574595eec.3.2026.10.30.14.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 14:14:05 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netde@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	netdev@vger.kernel.org (open list:BROADCOM B53/SF2 ETHERNET SWITCH DRIVER),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v3 5/8] net: dsa: b53: use the correct override register 2 Gbps bit
Date: Fri, 30 Oct 2026 14:13:47 -0700
Message-ID: <20261030211350.287566-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030211350.287566-1-florian.fainelli@broadcom.com>
References: <20261030211350.287566-1-florian.fainelli@broadcom.com>
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
 drivers/net/dsa/b53/b53_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 378f47e7250c..75033b28100e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1370,17 +1370,19 @@ static void b53_force_port_config(struct b53_device *dev, int port,
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
@@ -1392,11 +1394,11 @@ static void b53_force_port_config(struct b53_device *dev, int port,
 
 	reg &= ~(0x3 << GMII_PO_SPEED_S);
 	if (is5301x(dev) || is58xx(dev))
-		reg &= ~PORT_OVERRIDE_SPEED_2000M;
+		reg &= ~speed2000;
 
 	switch (speed) {
 	case 2000:
-		reg |= PORT_OVERRIDE_SPEED_2000M;
+		reg |= speed2000;
 		fallthrough;
 	case SPEED_1000:
 		reg |= PORT_OVERRIDE_SPEED_1000M;
-- 
2.53.0

