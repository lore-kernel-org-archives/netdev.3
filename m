Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793222605;
	b=izSWJnMDhczEWFCNiaY4sgm3va29UVcQgo9mJodVcuUPvIeaa+S1yNaFrgYspZ83IAbI
	 cZkcJa8LA9NukU5fhnpf5mUtgOsG2AMyYsYtIO2y9HHir5iPwL07pp2j6xqwkw6hCezX/
	 7X89SFWrKupdhMP6BGESWpvPwd9E/rzu0VIgFwXuPbXqwlWdWhtwDXx/wZ4VRhj3Mfie1
	 oa38x++G9Xch02KilGhvPJ4woaMUe9YTtUwQYY8k2jDVFpIjiendRgW5Pyo9/1vd1glQ0
	 AguY+a5w4WzjjzRxT356A3KQlcg2EmEZVcfuf7UeDOZGi90petuhPqZgDAd0Xu9uRrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793222605;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=pQ9JV51aLYDpacaXcbipq7EgeCvVh7+04CD76p86tPc=;
	b=01KZrb+RtLgJ6/AW4Dg/EUnQO5suQYk2nGMbkU+a/eDk9qlrqONqvtioGFvRWX7j1AK0
	 ixo9uhGUP66Ul1yF23nowmk63xZn+GC/n3zRLmKTS2cZbDwb7pKmzp2EUShcs6qUkvNJI
	 Gg58fnAm02faqnTxK4rrWgc4Huloqy4a+ewuDgBo+bZ5/lWM1DbWa13IlnJuo1lNQlhuB
	 7n65G70EBVUy73xIfRbXxi2yXKyG5y6ZpWLzfJJzhSyQ7licQ11m3tetWJ/FIlh3cWdUU
	 Vu3LQcKUW1g3ax4EcFxZM7MyZuzLRIQq6dSOK3GbULjrVOEeTKeKk0yuLhaaLd5pP6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="MwGvlQ/C";
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540C606A32E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 21:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2540C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=MwGvlQ/C
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cdaefe02d5dso220989a12.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793222604; x=1793827404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pQ9JV51aLYDpacaXcbipq7EgeCvVh7+04CD76p86tPc=;
        b=GHCuXzUhqs7pM4OnPQrx8b6fo/4SDhU8ZTF0xblj+PIOnWEo5dwDG095cuXxMOsgsR
         aY6npN9a9MJVCHrYNjVSadv54L7pd8pOGO+TYZ0QECqMmQugRfJc0QvWczQiZv7UqpPo
         srg3Jv/GMX4+pAhboQ3t4+9aEejTyicnJ74v0SPkfOPPlKyDzPda6I5btJ0I+fcxRKqC
         2ocxAlgB48Woj5EzkHpKcIPBo90vhveMQ8jeMhjVo2cYhfvbHKVfZSWvbF48YTfChWzM
         JuklYhd5YwqnpcsKeCCnHWyxGdYJ9kLgwqlxMvPw+zDaJywLuRFGsmnTelsXY/1Mr2Kj
         LYlw==
X-Gm-Message-State: AFq9FYIXHRZFC3FIt0T6RPHYo+tiuTirpo/1GKpCMsVJwReRyQPZR1Ic
	GehkFuVLhSFoW7KITE36d4a63GVMRlFojhvCVxQDoW4+IoArkIhmY1ByBCISbYiuk+hozQNwxhj
	tMTF3h8xlP06A9RHouqAD7GjaI2Q51z75cmjKFbYp3aC96Y4oJvj1I/8ikHfJX59t1s+vbC71V9
	DjaSUFT5JPpkAdtLRHEY/+YA/Ew2hvVzDrYlhorsg+qRW3Fd/3NCPjtH/K1Xlytpto3M/HguTkT
	zSnZt9uTWA5xQ3v
X-Gm-Gg: AYBFou3T1n6nyrwxTBHxkJEaqSLLjaHFpVL0HgtVWBeDPxc9A6pdj9Iab1RWrxS+wUK
	3cCjzIuwDiCiVAjv8CCe68V97FiWFevxkIGP/Ou73L0ic9YizCfPCPVp3MXAbW/g47yJNvo9T+l
	ZfcizwrtIn6IrM2LAKwdWInJuVXDmp/yCgiuqTD9zKb56fnq3M4r5bjYY8ewTbt5apEX/unLc1w
	eRw+WHLJ/s2GxJcKoYWVu6vtGRorbncchoIKakqFgvYg3SmGWFPsNg9TlyKDTypsk2r013VQNDV
	3mbSfUakMTsXlp0EDRCkoSXsI/4KsqtYZ6jBVxIUUNWw5cAdETPF+p2nSwlRVaSCd0PmKKiJ0fz
	yxJBZO2ryICPl0PYKhK81pBKHgHVRMLRaoroin0RJFbYyOVblhyxghQ9cUlLy/VV3gxtguKWKDE
	yXtnKL2TsE2GQ0i1yLAoDvsPoCT1UFpx+iMwhn1V/S
X-Received: by 2002:a17:90b:2805:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3ae580a02bcmr2299559a91.33.1793222604553;
        Wed, 28 Oct 2026 14:23:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae55d4f7e0sm867919a91.1.2026.10.28.14.23.23
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2026 14:23:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c70349f65so32383806d6.3
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793222603; x=1793827403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pQ9JV51aLYDpacaXcbipq7EgeCvVh7+04CD76p86tPc=;
        b=MwGvlQ/CvngOXCOn171X3inuHNzmp25wpOYQxDRITZwH/DkfjriWZFaCj7BWk/AwP5
         8kW8WgQT6oBrWR9d3FMAIYBEtEAplzFmYbh5GusQYtCgWDljeSQzQAlkf/6aT54nw3yd
         5QL9/3zJu1XhmFZ8nZq2GRQiofHAWqHRj4YsA=
X-Received: by 2002:a05:620a:6016:b0:943:f301:49b9 with SMTP id af79cd13be357-94408ce490fmr511482885a.53.1793222602836;
        Wed, 28 Oct 2026 14:23:22 -0700 (PDT)
X-Received: by 2002:a05:620a:6016:b0:943:f301:49b9 with SMTP id af79cd13be357-94408ce490fmr511478285a.53.1793222602293;
        Wed, 28 Oct 2026 14:23:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0669112sm1368755185a.10.2026.10.28.14.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:23:21 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 4/5] net: dsa: b53: reject conflicting mirror destinations
Date: Wed, 28 Oct 2026 14:23:09 -0700
Message-ID: <20261028212310.3847553-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
References: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
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

The mirror capture control register selects one destination for all
ingress and egress mirror sources. Adding a rule for a different capture
port currently overwrites that field and silently redirects all existing
mirror rules.

Read the capture control before changing any source masks and reject a
different destination while mirroring is enabled. Return an extack which
describes the hardware limitation, and propagate a failed capture-control
read rather than making the decision from uninitialized data.

Clear the capture-port field when the final source is removed so a later
rule can select a new destination.

Fixes: ed3af5fd08eb ("net: dsa: b53: Add support for port mirroring")
Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c38e8c5838bd..378f47e7250c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2543,7 +2543,19 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 		   struct netlink_ext_ack *extack)
 {
 	struct b53_device *dev = ds->priv;
-	u16 reg, loc;
+	u16 reg, loc, cap_ctl;
+	int ret;
+
+	ret = b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &cap_ctl);
+	if (ret)
+		return ret;
+
+	if ((cap_ctl & MIRROR_EN) &&
+	    (cap_ctl & CAP_PORT_MASK) != mirror->to_local_port) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only one mirroring destination is supported");
+		return -EOPNOTSUPP;
+	}
 
 	if (ingress)
 		loc = B53_IG_MIR_CTL;
@@ -2554,11 +2566,10 @@ int b53_mirror_add(struct dsa_switch *ds, int port,
 	reg |= BIT(port);
 	b53_write16(dev, B53_MGMT_PAGE, loc, reg);
 
-	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
-	reg &= ~CAP_PORT_MASK;
-	reg |= mirror->to_local_port;
-	reg |= MIRROR_EN;
-	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
+	cap_ctl &= ~CAP_PORT_MASK;
+	cap_ctl |= mirror->to_local_port;
+	cap_ctl |= MIRROR_EN;
+	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, cap_ctl);
 
 	return 0;
 }
@@ -2595,10 +2606,8 @@ void b53_mirror_del(struct dsa_switch *ds, int port,
 
 	b53_read16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, &reg);
 	/* Both no longer have ports, let's disable mirroring */
-	if (loc_disable && other_loc_disable) {
-		reg &= ~MIRROR_EN;
-		reg &= ~mirror->to_local_port;
-	}
+	if (loc_disable && other_loc_disable)
+		reg &= ~(MIRROR_EN | CAP_PORT_MASK);
 	b53_write16(dev, B53_MGMT_PAGE, B53_MIR_CAP_CTL, reg);
 }
 EXPORT_SYMBOL(b53_mirror_del);
-- 
2.53.0

